#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy
import math
from nav_msgs.msg import Odometry
from geometry_msgs.msg import Twist
from std_msgs.msg import Float64
from sensor_msgs.msg import Range
from tf.transformations import euler_from_quaternion

# --- DYNAMIC RECONFIGURE IMPORTS ---
from dynamic_reconfigure.server import Server
# Asegúrate de que 'tandem' es el nombre correcto de tu paquete donde está el .cfg
from tandem.cfg import VerticalInspectorConfig

from cola2_msgs.msg import BodyVelocityReq, GoalDescriptor, Bool6Axis


class VerticalInspector(object):
    """
    Genera un patrón de inspección vertical (cortacésped en Y-Z)
    calculando la profundidad actual a partir de la altitud y la
    profundidad del fondo marino.
    Parámetros de control ajustables dinámicamente.
    """
    def __init__(self):
        # ---- Parámetros de la MISIÓN (Estáticos) ----
        # Estos no se cambian dinámicamente porque requerirían regenerar waypoints
        self.inspection_width = rospy.get_param("~inspection_width", 6.0)
        self.inspection_depth = rospy.get_param("~inspection_depth", 10.0)
        self.step_down_z = rospy.get_param("~step_down_z", 2.0)

        # ---- Inicialización de variables de CONTROL (Valores por defecto temporales) ----
        # Estos valores serán sobrescritos inmediatamente por el servidor de reconfigure
        self.kp_y = 0.20
        self.vy_max = 0.6
        self.tol_y = 0.2
        self.kp_z = 0.12
        self.ki_z = 0.01
        self.vz_max = 0.8
        self.int_z_limit = 0.2
        self.tol_z = 0.2
        self.alpha = 0.3
        self.max_dv = 0.10

        # ---- Suavizado de consignas ----
        self.vy_f = 0.0
        self.vz_f = 0.0

        # ---- Tópicos/frames ----
        self.odom_topic = rospy.get_param("~odom_topic", "/girona500/navigator/odometry")
        self.frame_id = rospy.get_param("~frame_id", "girona500/base_link")
        self.rate_hz = rospy.get_param("~rate_hz", 20.0)
        
        # --- Tópicos para calcular la profundidad ---
        self.altitude_topic = rospy.get_param("~altitude_topic", "/girona500/navigator/altitude")
        self.sea_bottom_depth = rospy.get_param("~sea_bottom_depth", 50)

        # ---- Pub/Sub ----
        self.pub = rospy.Publisher("/girona500/controller/body_velocity_req",
                                   BodyVelocityReq, queue_size=10)
        self.sub_odom = rospy.Subscriber(self.odom_topic, Odometry, self.odom_cb, queue_size=10)

        self.altitude = None
        self.current_depth_calculated = None 
        self.depth0 = None 
        
        self.sub_alt = rospy.Subscriber(self.altitude_topic, Range, self.altitude_cb, queue_size=10)

        # ---- Estados de la Misión ----
        self.state = "INITIALIZING" 
        self.waypoints = []
        self.current_wp_index = 0
        self._generate_waypoints()

        # ---- Estados del Controlador/Odometría ----
        self.has_init = False
        self.x0 = self.y0 = self.z0 = 0.0
        self.yaw0 = 0.0
        self.last_pose = None
        self.start_time = rospy.Time.now()
        self.int_z = 0.0 

        # ---- DYNAMIC RECONFIGURE SERVER ----
        # Inicializamos el servidor pasando la configuración y el callback.
        # Esto llamará a self.reconfigure_cb inmediatamente una vez.
        self.srv = Server(VerticalInspectorConfig, self.reconfigure_cb)

        rospy.Timer(rospy.Duration(1.0/self.rate_hz), self.on_timer)

        rospy.loginfo("VerticalInspector listo | odom=%s", self.odom_topic)
        rospy.loginfo("Inspección: %.1fm (Y) x %.1fm (Z), bajando %.1fm por pasada.",
                      self.inspection_width, self.inspection_depth, self.step_down_z)

    def reconfigure_cb(self, config, level):
        """ 
        Callback que se ejecuta cuando cambian parámetros en rqt_reconfigure 
        o al iniciar el nodo.
        """
        rospy.loginfo("Reconfigurando parámetros de control...")
        
        # Control Lateral (Y)
        self.kp_y = config.kp_y
        self.vy_max = config.vy_max
        self.tol_y = config.tol_y
        
        # Control Profundidad (Z)
        self.kp_z = config.kp_z
        self.ki_z = config.ki_z
        self.vz_max = config.vz_max
        self.int_z_limit = config.int_z_limit
        self.tol_z = config.tol_z
        
        # Filtros (Nota: en tu .cfg pusiste "alpha_filter", mapealo a self.alpha)
        self.alpha = config.alpha_filter
        self.max_dv = config.max_dv
        
        return config

    def _generate_waypoints(self):
        """ Genera la lista de waypoints relativos (dy, dz) para el patrón. """
        self.waypoints = []
        half_width = self.inspection_width / 2.0
        current_z = 2.0
        direction = 1  
        start_y = -half_width
        self.waypoints.append((start_y, current_z))

        while current_z < self.inspection_depth:
            target_y = direction * half_width
            self.waypoints.append((target_y, current_z))
            current_z += self.step_down_z
            if current_z > self.inspection_depth:
                current_z = self.inspection_depth
            self.waypoints.append((target_y, current_z))
            direction *= -1
            if current_z == self.inspection_depth:
                target_y = direction * half_width
                self.waypoints.append((target_y, current_z))
                break 

        rospy.loginfo("Generados %d waypoints para la inspección.", len(self.waypoints))

    # -------------------- Callbacks --------------------

    def altitude_cb(self, msg):
        self.altitude = msg.range
        self.calculate_current_depth()
        
    def calculate_current_depth(self):
        if self.altitude is not None and self.sea_bottom_depth is not None:
            self.current_depth_calculated = self.sea_bottom_depth - self.altitude
            
            if self.depth0 is None and self.has_init:
                self.depth0 = self.current_depth_calculated
                rospy.loginfo("**********************************************")
                rospy.loginfo("Profundidad INICIAL calculada fijada: %.2f m", self.depth0)
                rospy.loginfo("**********************************************")

    def odom_cb(self, msg):
        px = msg.pose.pose.position.x
        py = msg.pose.pose.position.y
        pz = msg.pose.pose.position.z
        q = msg.pose.pose.orientation
        yaw = euler_from_quaternion([q.x, q.y, q.z, q.w])[2]

        if not self.has_init:
            self.x0, self.y0, self.z0, self.yaw0 = px, py, pz, yaw
            self.has_init = True
            rospy.loginfo("Posición inicial fijada: x0=%.2f y0=%.2f z0=%.2f yaw0=%.1f°",
                          self.x0, self.y0, self.z0, math.degrees(self.yaw0))
            self.calculate_current_depth() 

        self.last_pose = (px, py, pz, yaw)

    # -------------------- Control Loop  --------------------

    def on_timer(self, _evt):
        
        # --- Estado 1: INITIALIZING ---
        if self.state == "INITIALIZING":
            is_ready = self.has_init and self.last_pose is not None and (self.depth0 is not None)
                
            if not is_ready:
                if not self.has_init:
                    rospy.logwarn_throttle(2.0, "Esperando odometría...")
                elif self.depth0 is None:
                    rospy.logwarn_throttle(2.0, "Esperando altitud y fondo para calcular profundidad inicial...")
                self.publish_cmd(0.0, 0.0, 0.0, "inspector_initializing")
                return
            else:
                rospy.loginfo("Inicialización completa. Empezando misión.")
                self.state = "MOVING"
                self.current_wp_index = 0

        # --- Estado 2: MOVING ---
        elif self.state == "MOVING":
            if self.current_wp_index >= len(self.waypoints):
                rospy.loginfo("Misión de inspección completada.")
                self.state = "FINISHED"
                self.publish_cmd(0.0, 0.0, 0.0, "inspector_finished")
                return

            target_dy, target_dz = self.waypoints[self.current_wp_index]
            px, py, pz, yaw = self.last_pose
            
            # Error en Eje Y
            dx_w = px - self.x0
            dy_w = py - self.y0
            cy = math.cos(self.yaw0); sy = math.sin(self.yaw0)
            dy_b = -sy*dx_w + cy*dy_w
            e_y = target_dy - dy_b
            
            # Control P para Y (usando self.kp_y dinámico)
            vy = self.clip(self.kp_y * e_y, -self.vy_max, self.vy_max)
            reached_y = abs(e_y) < self.tol_y
            
            e_z_or_depth = 0.0
            
            if self.current_depth_calculated is None:
                rospy.logwarn_throttle(1.0, "Perdidos datos de altitud/fondo. Pausando control Z.")
                vz_cmd = 0.0
                vz = 0.0
                e_z_or_depth = 0.0 
                reached_z = False  
                self.int_z = 0.0   
            
            else:
                target_depth = self.depth0 + target_dz
                e_depth = target_depth - self.current_depth_calculated 
                e_z_or_depth = e_depth
                
                # Control PI para Z (usando self.kp_z y self.ki_z dinámicos)
                vz_cmd = (self.kp_z * e_z_or_depth + self.int_z)
                
                if abs(vz_cmd) < self.vz_max - 1e-3:
                    self.int_z += self.ki_z * e_z_or_depth / self.rate_hz
                    self.int_z = self.clip(self.int_z, -self.int_z_limit, self.int_z_limit)
                
                vz = self.clip(vz_cmd, -self.vz_max, self.vz_max)
                reached_z = abs(e_z_or_depth) < self.tol_z
            
            # --- Transición de Waypoint ---
            if reached_y and reached_z:
                rospy.loginfo("Waypoint %d alcanzado: (y=%.2f, z=f(%.2f))", 
                              self.current_wp_index, target_dy, target_dz)
                self.current_wp_index += 1
                self.int_z = 0.0  
                vy, vz = 0.0, 0.0 
            
            # Suavizar y publicar
            vy_s, vz_s = self.smooth(vy, vz)
            requester = "inspector_wp_{}".format(self.current_wp_index)
            self.publish_cmd(0.0, vy_s, vz_s, requester)
            
            rospy.loginfo_throttle(1.0, 
                "WP %d | ErrY:%.2f (Kp:%.2f) | ErrZ:%.2f (Kp:%.2f, Ki:%.3f) | Cmd (vy:%.2f, vz:%.2f)",
                self.current_wp_index, e_y, self.kp_y, e_z_or_depth, self.kp_z, self.ki_z, vy_s, vz_s)

        # --- Estado 3: FINISHED ---
        elif self.state == "FINISHED":
            vy, vz = self.smooth(0.0, 0.0)
            self.publish_cmd(0.0, vy, vz, "inspector_finished")
        else:
            vy, vz = self.smooth(0.0, 0.0)
            self.publish_cmd(0.0, vy, vz, "inspector_idle")

    # -------------------- Utilidades --------------------

    def smooth(self, vy, vz):
        vy_f = self.alpha * vy + (1.0 - self.alpha) * self.vy_f
        vz_f = self.alpha * vz + (1.0 - self.alpha) * self.vz_f
        vy_f = self.clip(vy_f, self.vy_f - self.max_dv, self.vy_f + self.max_dv)
        vz_f = self.clip(vz_f, self.vz_f - self.max_dv, self.vz_f + self.max_dv)
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
        cmd.twist = tw
        ba = Bool6Axis()
        ba.x = False
        ba.y = False
        ba.z = False
        ba.roll = True
        ba.pitch = True
        ba.yaw = True
        cmd.disable_axis = ba
        self.pub.publish(cmd)

    @staticmethod
    def clip(v, vmin, vmax):
        return max(vmin, min(v, vmax))

    @staticmethod
    def sign(v):
        return 1.0 if v >= 0.0 else -1.0


if __name__ == "__main__":
    rospy.init_node("vertical_inspector")
    try:
        VerticalInspector()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass