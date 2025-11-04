#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy
import math
from nav_msgs.msg import Odometry
from geometry_msgs.msg import Twist
from std_msgs.msg import Float64
from tf.transformations import euler_from_quaternion

# Ajusta estos imports al paquete de tus mensajes si no usas COLA2:
from cola2_msgs.msg import BodyVelocityReq, GoalDescriptor, Bool6Axis


class BodyYZMover(object):
    def __init__(self):
        # ---- Objetivo en marco del cuerpo inicial ----
        self.target_dy = rospy.get_param("~target_dy", 5.0)   # +Y = izquierda
        self.target_dz = rospy.get_param("~target_dz", 2.0)   # Z+ = ABAJO (sumergirse). Ej: bajar 2 m => +2.0

        # ---- Control lateral (Y) ----
        self.kp_y   = rospy.get_param("~kp_y", 0.20)
        self.vy_max = rospy.get_param("~vy_max", 0.35)
        self.tol_y  = rospy.get_param("~tol_y", 0.15)

        # ---- Control de profundidad (Z) ----
        self.use_pressure_depth = rospy.get_param("~use_pressure_depth", True)
        self.depth_topic = rospy.get_param("~depth_topic", "/girona500/navigation/depth")
        self.kp_z   = rospy.get_param("~kp_z", 0.45)
        self.ki_z   = rospy.get_param("~ki_z", 0.08)      # Integral para vencer flotabilidad
        self.vz_max = rospy.get_param("~vz_max", 0.6)
        self.int_z_limit = rospy.get_param("~int_z_limit", 0.3)  # límite del término integral (m/s)
        self.tol_z  = rospy.get_param("~tol_z", 0.15)

        # ---- Suavizado de consignas ----
        self.alpha = rospy.get_param("~alpha_filter", 0.3)  # 0..1 (menor = más suave)
        self.max_dv = rospy.get_param("~max_dv", 0.10)      # m/s por ciclo
        self.vy_f = 0.0
        self.vz_f = 0.0

        # ---- Coordinación Y/Z (prioriza profundidad si no está alcanzada) ----
        self.depth_priority_weight = rospy.get_param("~depth_priority_weight", 0.5)  # 0..1

        # ---- Open-loop si aún no hay odometría ----
        self.enable_open_loop = rospy.get_param("~enable_open_loop", True)
        self.open_loop_vy = rospy.get_param("~open_loop_vy", 0.2)
        self.open_loop_vz = rospy.get_param("~open_loop_vz", 0.2)
        self.open_loop_timeout = rospy.get_param("~open_loop_timeout", 10.0)

        # ---- Tópicos/frames ----
        self.odom_topic = rospy.get_param("~odom_topic", "/girona500/navigator/odometry")
        self.frame_id   = rospy.get_param("~frame_id", "girona500/base_link")
        self.rate_hz    = rospy.get_param("~rate_hz", 10.0)

        # ---- Pub/Sub ----
        self.pub = rospy.Publisher("/girona500/controller/body_velocity_req",
                                   BodyVelocityReq, queue_size=10)
        self.sub_odom = rospy.Subscriber(self.odom_topic, Odometry, self.odom_cb, queue_size=10)

        self.depth = None
        self.depth0 = None
        if self.use_pressure_depth:
            self.sub_depth = rospy.Subscriber(self.depth_topic, Float64, self.depth_cb, queue_size=10)

        # ---- Estados ----
        self.has_init = False
        self.x0 = self.y0 = self.z0 = 0.0
        self.yaw0 = 0.0
        self.last_pose = None
        self.start_time = rospy.Time.now()
        self.int_z = 0.0

        rospy.Timer(rospy.Duration(1.0/self.rate_hz), self.on_timer)

        rospy.loginfo("BodyYZMover listo | odom=%s depth=%s use_depth=%s (Z+ abajo)",
                      self.odom_topic, self.depth_topic, self.use_pressure_depth)

    # -------------------- Callbacks --------------------

    def depth_cb(self, msg):
        self.depth = float(msg.data)
        if self.depth0 is None and self.has_init:
            self.depth0 = self.depth

    def odom_cb(self, msg):
        px = msg.pose.pose.position.x
        py = msg.pose.pose.position.y
        pz = msg.pose.pose.position.z
        q  = msg.pose.pose.orientation
        yaw = euler_from_quaternion([q.x, q.y, q.z, q.w])[2]

        if not self.has_init:
            self.x0, self.y0, self.z0, self.yaw0 = px, py, pz, yaw
            self.has_init = True
            if self.use_pressure_depth and (self.depth is not None):
                self.depth0 = self.depth
            rospy.loginfo("A fijado: x0=%.2f y0=%.2f z0=%.2f yaw0=%.1f°, depth0=%s",
                          self.x0, self.y0, self.z0, math.degrees(self.yaw0),
                          ("%.2f" % self.depth0) if self.depth0 is not None else "None")

        self.last_pose = (px, py, pz, yaw)

    # -------------------- Control Loop --------------------

    def on_timer(self, _evt):
        now = rospy.Time.now()

        # Open-loop si no hay odometría (durante unos segundos)
        do_open_loop = (not self.has_init) and self.enable_open_loop and \
                       ((now - self.start_time).to_sec() <= self.open_loop_timeout)
        if do_open_loop:
            vy = self.sign(self.target_dy) * self.open_loop_vy if abs(self.target_dy) > 1e-3 else 0.0
            vz = self.sign(self.target_dz) * self.open_loop_vz if abs(self.target_dz) > 1e-3 else 0.0
            vy, vz = self.smooth(vy, vz)
            self.publish_cmd(0.0, vy, vz, "body_yz_openloop")
            rospy.logwarn_throttle(2.0, "Open-loop: sin odom aún. vy=%.2f vz=%.2f", vy, vz)
            return

        # Sin referencias → quieto
        if not self.has_init or self.last_pose is None:
            vy, vz = self.smooth(0.0, 0.0)
            self.publish_cmd(0.0, vy, vz, "body_yz_idle")
            return

        # --- Eje Y: error en marco del cuerpo inicial ---
        px, py, pz, yaw = self.last_pose
        dx_w = px - self.x0
        dy_w = py - self.y0
        cy = math.cos(self.yaw0); sy = math.sin(self.yaw0)
        dy_b = -sy*dx_w + cy*dy_w
        e_y = self.target_dy - dy_b
        vy = self.clip(self.kp_y * e_y, -self.vy_max, self.vy_max)
        reached_y = abs(e_y) < self.tol_y

        # --- Eje Z: profundidad (Z+ abajo) ---
        if self.use_pressure_depth and (self.depth is not None) and (self.depth0 is not None):
            target_depth = self.depth0 + self.target_dz              # bajar 2 m => +2
            e_depth = target_depth - self.depth                      # >0 => falta bajar
            vz_cmd = (self.kp_z * e_depth + self.int_z)              # Z+ abajo → e_depth>0 => vz>0
            # Anti-windup
            if abs(vz_cmd) < self.vz_max - 1e-3:
                self.int_z += self.ki_z * e_depth / self.rate_hz
                self.int_z = self.clip(self.int_z, -self.int_z_limit, self.int_z_limit)
            vz = self.clip(vz_cmd, -self.vz_max, self.vz_max)
            reached_z = abs(e_depth) < self.tol_z
        else:
            # Fallback con odom Z (asegúrate de convención Z+ abajo si lo usas)
            dz_w = pz - self.z0
            # Suponiendo que odom Z también es +abajo (ajusta si no):
            e_z = self.target_dz - dz_w
            vz_cmd = self.kp_z * e_z + self.int_z
            if abs(vz_cmd) < self.vz_max - 1e-3:
                self.int_z += self.ki_z * e_z / self.rate_hz
                self.int_z = self.clip(self.int_z, -self.int_z_limit, self.int_z_limit)
            vz = self.clip(vz_cmd, -self.vz_max, self.vz_max)
            reached_z = abs(e_z) < self.tol_z

        # Prioriza profundidad si aún no está en tolerancia
        if not reached_z:
            vy *= self.depth_priority_weight

        # Si ya llegó a alguno de los ejes, anula su velocidad
        if reached_y: vy = 0.0
        if reached_z: vz = 0.0

        # Suaviza y limita variación
        vy, vz = self.smooth(vy, vz)

        requester = "body_yz_move_reached" if (reached_y and reached_z) else "body_yz_move"
        self.publish_cmd(0.0, vy, vz, requester)

    # -------------------- Utilidades --------------------

    def smooth(self, vy, vz):
        # Filtro pasa-bajo
        vy_f = self.alpha * vy + (1.0 - self.alpha) * self.vy_f
        vz_f = self.alpha * vz + (1.0 - self.alpha) * self.vz_f
        # Rate limit
        vy_f = self.clip(vy_f, self.vy_f - self.max_dv, self.vy_f + self.max_dv)
        vz_f = self.clip(vz_f, self.vz_f - self.max_dv, self.vz_f + self.max_dv)
        # Actualiza estado
        self.vy_f, self.vz_f = vy_f, vz_f
        return vy_f, vz_f

    def publish_cmd(self, vx, vy, vz, requester):
        cmd = BodyVelocityReq()
        cmd.header.stamp = rospy.Time.now()
        cmd.header.frame_id = self.frame_id

        gd = GoalDescriptor()
        gd.requester = requester
        gd.priority = 0
        cmd.goal = gd

        tw = Twist()
        tw.linear.x = vx
        tw.linear.y = vy
        tw.linear.z = vz
        tw.angular.x = 0.0
        tw.angular.y = 0.0
        tw.angular.z = 0.0
        cmd.twist = tw

        # Control ACTIVO en x,y,z (False); ángulos deshabilitados (True)
        ba = Bool6Axis()
        ba.x = False
        ba.y = False
        ba.z = False
        ba.roll  = True
        ba.pitch = True
        ba.yaw   = True
        cmd.disable_axis = ba

        self.pub.publish(cmd)
        rospy.loginfo_throttle(1.0, "%s -> vx=%.2f vy=%.2f vz=%.2f", requester, vx, vy, vz)

    @staticmethod
    def clip(v, vmin, vmax): 
        return max(vmin, min(v, vmax))

    @staticmethod
    def sign(v): 
        return 1.0 if v >= 0.0 else -1.0


if __name__ == "__main__":
    rospy.init_node("body_yz_mover")
    BodyYZMover()
    rospy.spin()
