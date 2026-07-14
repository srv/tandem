#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy
import math
from geometry_msgs.msg import Twist, Point, PointStamped, PoseStamped
from std_msgs.msg import Float64
from tf.transformations import euler_from_quaternion
from visualization_msgs.msg import Marker
from dynamic_reconfigure.server import Server
from visual_inspector.cfg import VerticalInspectorConfig
from std_srvs.srv import Trigger, TriggerResponse

from cola2_msgs.msg import BodyVelocityReq, GoalDescriptor, Bool6Axis, NavSts
# NOTA: Ya no se necesita Range

class VerticalInspector(object):
    """
    Generates a vertical inspection pattern (lawnmower in Y-Z).
    The depth reference (Z) is obtained directly from NavSts.
    """
    def __init__(self):
        
        # ==================================================================
        # ### --- MANUAL FILTER CONFIGURATION --- ###
        self.use_smoothing_flag = False 
        # ==================================================================

        # ---- MISSION Parameters (Static) ----
        self.inspection_width = rospy.get_param("~inspection_width", 10.0)
        self.inspection_depth = rospy.get_param("~inspection_depth", 15.0)
        self.step_down_z = rospy.get_param("~step_down_z", 2.0)
        self.start_z = rospy.get_param("~start_z", 0.5)

        # Orientation to look at the net (-1.57 rad = -90 degree)
        self.target_yaw = rospy.get_param("~target_yaw", -1.57)

        # Safety Limit
        self.max_safe_depth = 100 

        # Yaw Control (PID for alignment)
        self.kp_yaw = 0.8
        self.wz_max = 0.3
        self.tol_yaw = 0.05

        # Y Control (PID)
        self.kp_y = 0.20
        self.ki_y = 0.0  
        self.vy_max = 0.1
        self.int_y_limit = 0.2
        self.tol_y = 0.15

        # Z Control (PID)
        self.kp_z = 0.12
        self.ki_z = 0.01
        self.vz_max = 0.1
        self.int_z_limit = 0.2
        self.tol_z = 0.15
        
        # ---- APPROACH / CENTERING PARAMETERS ----

        # Moviment lateral per centrar la corrosió
        self.kp_center_y = rospy.get_param("~kp_center_y", 0.25)
        self.vy_center_max = rospy.get_param("~vy_center_max", 0.10)

        # Control de yaw durant centrat i aproximació
        self.kp_yaw_approach = rospy.get_param("~kp_yaw_approach", 0.30)
        self.wz_approach_max = rospy.get_param("~wz_approach_max", 0.10)

        # Moviment frontal
        self.kp_approach_x = rospy.get_param("~kp_approach_x", 0.20)
        self.vx_approach_max = rospy.get_param("~vx_approach_max", 0.15)

        # Toleràncies
        self.tol_center_y = rospy.get_param("~tol_center_y", 0.08)
        self.tol_center_z = rospy.get_param("~tol_center_z", 0.05)
        self.tol_yaw_approach = rospy.get_param("~tol_yaw_approach", 0.05)

        # Histèresi: evita canvis continus CENTER_HOLE <-> APPROACH_HOLE
        self.tol_center_y_exit = rospy.get_param("~tol_center_y_exit", 0.15)
        self.tol_center_z_exit = rospy.get_param("~tol_center_z_exit", 0.10)
        self.tol_yaw_exit = rospy.get_param("~tol_yaw_exit", 0.10)

        # Distància final respecte de la paret
        self.safe_distance = rospy.get_param("~safe_distance", 0.8)
        self.safe_distance_tolerance = rospy.get_param("~safe_distance_tolerance", 0.15)

        # Offset vertical càmera - base_link
        self.camera_offset_z = rospy.get_param("~camera_offset_z", 0.11)

        # Associació espacial durant el tracking
        self.approach_tracking_gate = rospy.get_param("~approach_tracking_gate", 0.5)

        # Suavitzat de la pose objectiu
        self.approach_target_alpha = rospy.get_param("~approach_target_alpha", 0.30)

        # Filter parameters 
        self.alpha = 0.3
        self.max_dv = 0.10

        # ---- Internal filter variables ----
        self.vy_f = 0.0
        self.vz_f = 0.0

        # ---- Topics/frames ----
        self.navigation_topic = rospy.get_param("~navigation_topic", "/girona500/navigator/navigation")
        self.frame_id = rospy.get_param("~frame_id", "girona500/base_link")
        self.rate_hz = rospy.get_param("~rate_hz", 20.0)
        
        # ---- Pub/Sub ----
        self.pub = rospy.Publisher("/girona500/controller/body_velocity_req",
                                   BodyVelocityReq, queue_size=10)
        self.pub_markers = rospy.Publisher("inspection_pattern_marker", Marker, queue_size=1)
        
        # --- RQT PLOT PUBLISHERS ---
        self.pub_vz_out = rospy.Publisher("debug/vz_command", Float64, queue_size=1)
        self.pub_target_z = rospy.Publisher("debug/target_depth", Float64, queue_size=1)
        self.pub_real_z = rospy.Publisher("debug/real_depth", Float64, queue_size=1)
        self.pub_error_z = rospy.Publisher("debug/error_depth", Float64, queue_size=1)
        
        # Subscription to Navigation
        self.sub_nav = rospy.Subscriber(self.navigation_topic, NavSts, self.nav_cb, queue_size=10)
        self.pub_current_point = rospy.Publisher("current_target_point", PointStamped, queue_size=1)

        # ==========================================
        # --- HOLE DETECTOR TRACKING (FILTRO) ---
        # ==========================================
        self.hole_pose = None
        self.candidate_hole_pose = None
        self.hole_detect_count = 0
        self.last_hole_time = rospy.Time(0)
        # Distància frontal entre el robot i la detecció abans de l'aproximació
        self.pre_approach_forward = None
        self.is_pre_approach_position_saved = False

        # Control del retorn a la distància d'inspecció
        self.kp_return_x = rospy.get_param("~kp_return_x", 0.20)
        self.vx_return_max = rospy.get_param("~vx_return_max", 0.12)

        # Tolerància per considerar recuperada la distància original
        self.return_distance_tolerance = rospy.get_param("~return_distance_tolerance", 0.10)

        # Yaw durant el retorn
        self.kp_yaw_return = rospy.get_param("~kp_yaw_return", 0.30)
        self.wz_return_max = rospy.get_param("~wz_return_max", 0.10)
        self.return_yaw_tolerance = rospy.get_param("~return_yaw_tolerance", 0.08)

        # ------------------------------------------------------------------
        # Reset i exclusió temporal de l'última detecció
        # ------------------------------------------------------------------
        self.ignored_hole_pose = None

        # Distància mínima respecte de l'objectiu anterior perquè una detecció
        # pugui considerar-se una corrosió diferent
        self.ignore_hole_radius = rospy.get_param("~ignore_hole_radius", 1.0)

        # Temps durant el qual s'ignorarà l'objectiu anterior
        self.ignore_hole_timeout = rospy.get_param("~ignore_hole_timeout", 10.0)

        self.ignore_hole_start_time = rospy.Time(0)

        # ------------------------------------------------------------
        # CLEAR PREVIOUS TARGET PARAMETERS
        # ------------------------------------------------------------

        # Velocitat lateral utilitzada per abandonar la detecció anterior
        self.clear_target_vy = rospy.get_param("~clear_target_vy", 0.08)

        # Distància lateral mínima que cal recórrer abans d'acceptar
        # que s'ha abandonat la corrosió anterior
        self.clear_target_min_distance = rospy.get_param("~clear_target_min_distance", 0.50)

        # Temps continu durant el qual no s'ha de tornar a veure
        # la detecció anterior
        self.clear_target_not_seen_timeout = rospy.get_param("~clear_target_not_seen_timeout", 2.0)

        # Radi espacial per decidir si una detecció correspon
        # a la corrosió anterior
        self.clear_target_gate = rospy.get_param("~clear_target_gate", 0.75)

        # Temps màxim de seguretat dins de CLEAR_PREVIOUS_TARGET
        self.clear_target_max_duration = rospy.get_param("~clear_target_max_duration", 15.0)

        # Variables internes
        self.last_previous_target_seen = rospy.Time(0)
        self.clear_target_start_time = rospy.Time(0)
        self.clear_target_start_pose = None
        self.clear_target_direction = 1.0

        # Mentre siga False, MOVING no pot iniciar un tracking nou
        self.allow_new_detections = True

        # Parámetros del Filtro Espacio-Temporal
        self.req_detections = 3      # Frames seguidos necesarios para confirmación
        self.max_hole_dist = 1.0     # Distancia máxima entre detecciones (metros)
        self.max_hole_timeout = 3.0  # Tiempo máximo permitido entre detecciones (segundos)

        self.detection_topic = rospy.get_param("~detection_topic", "/corrosion_detector/hole")
        self.inspection_depth = rospy.get_param("~inspection_depth", 15.0)


        self.sub_hole = rospy.Subscriber(self.detection_topic, PoseStamped, self.hole_cb, queue_size=1)

        self.reset_tracking_srv = rospy.Service("~reset_tracking", Trigger, self.reset_tracking_cb)

        # ---- States ----
        self.state = "INITIALIZING" 
        self.waypoints = []
        self.current_wp_index = 0
        
        self.has_init = False
        self.x0 = self.y0 = self.z0 = 0.0 
        self.yaw0 = 0.0
        self.last_pose = None
        self.start_time = rospy.Time.now()
        
        # Internal Integral accumulators
        self.int_z = 0.0 
        self.int_y = 0.0 
        self.vx_est = 0.0 
        self.vy_est = 0.0
        self.vz_est = 0.0

        # ---- DYNAMIC RECONFIGURE SERVER ----
        self.srv = Server(VerticalInspectorConfig, self.reconfigure_cb)

        rospy.loginfo("VerticalInspector ready | nav_topic=%s", self.navigation_topic)
        rospy.loginfo("FILTERING ENABLED: %s", self.use_smoothing_flag)
        rospy.loginfo("SAFETY LIMIT Z: %.2f m", self.max_safe_depth)

    def reconfigure_cb(self, config, level):
        """ Dynamic reconfigure callback. """
        # Y Control
        self.kp_y = config.kp_y
        if hasattr(config, 'ki_y'): 
            self.ki_y = config.ki_y
        if hasattr(config, 'int_y_limit'):
            self.int_y_limit = config.int_y_limit
        if hasattr(config, 'kd_y'): 
            self.kd_y = config.kd_y
            
        self.vy_max = config.vy_max
        self.tol_y = config.tol_y
        
        # Z Control
        self.kp_z = config.kp_z
        self.ki_z = config.ki_z
        if hasattr(config, 'kd_z'): 
            self.kd_z = config.kd_z
        self.vz_max = config.vz_max
        self.int_z_limit = config.int_z_limit
        self.tol_z = config.tol_z
        
        # Filter values
        self.alpha = config.alpha_filter
        self.max_dv = config.max_dv
        
        return config

    def _generate_waypoints(self):
        """ Generates the list of relative waypoints (dy, dz) and publishes them to RViz. """
        self.waypoints = []
        half_width = self.inspection_width / 2.0
        current_z = self.start_z
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

        rospy.loginfo("Generated %d waypoints.", len(self.waypoints))
        
        if self.has_init:
            self.publish_path_line_marker()

    def publish_path_line_marker(self):
        """ Publishes the generated waypoints as a LINE_STRIP Marker. """
        marker = Marker()
        marker.header.frame_id = "world_ned"
        marker.header.stamp = rospy.Time.now()
        marker.ns = "inspection_pattern"
        marker.id = 0
        marker.type = Marker.LINE_STRIP
        marker.action = Marker.ADD
        marker.pose.orientation.w = 1.0
        marker.scale.x = 0.1
        marker.color.r = 0.0
        marker.color.g = 1.0
        marker.color.b = 0.0
        marker.color.a = 0.8
        
        cy = math.cos(self.yaw0)
        sy = math.sin(self.yaw0)

        for (dy, dz) in self.waypoints:
            p = Point()
            p.x = self.x0 - sy * dy
            p.y = self.y0 + cy * dy
            p.z = self.z0 + dz 
            
            marker.points.append(p)

        self.pub_markers.publish(marker)
        rospy.loginfo("Published inspection pattern marker to RViz.")
        
    def publish_current_target_point(self, current_wp_index):
        """ Publica el waypoint objetivo actual como un mensaje PointStamped. """
        dy, dz = self.waypoints[current_wp_index]
        
        point_stamped = PointStamped()
        point_stamped.header.frame_id = "world_ned"
        point_stamped.header.stamp = rospy.Time.now()
        
        cy = math.cos(self.yaw0)
        sy = math.sin(self.yaw0)
        
        point_stamped.point.x = self.x0 - sy * dy
        point_stamped.point.y = self.y0 + cy * dy
        point_stamped.point.z = self.z0 + dz 
        
        self.pub_current_point.publish(point_stamped) 

    def nav_cb(self, msg):
        """
        Callback de Navegación (NavSts). Ejecuta el bucle de control.
        """
        # Extraer Posición (NED)
        px = msg.position.north
        py = msg.position.east
        pz = msg.position.depth 
        yaw = msg.orientation.yaw 

        self.vx_est = msg.body_velocity.x
        self.vy_est = msg.body_velocity.y
        self.vz_est = msg.body_velocity.z


        if not self.has_init:
            self.x0, self.y0, self.z0, self.yaw0 = px, py, pz, yaw
            # Force net Y-Z to be calculated based on the final orientation
            self.yaw0 = self.target_yaw
            self.has_init = True
            rospy.loginfo("Initial position set.")
            self._generate_waypoints()

        self.last_pose = (px, py, pz, yaw)
        self.main_control_loop()

    def hole_cb(self, msg):
        """
        Receives 3D world NED coordiante of the hole.
        Implements a spacial-temporal filter to avoid alucinations and false positives.
        """
        hx = msg.pose.position.x
        hy = msg.pose.position.y
        hz = msg.pose.position.z
        now = rospy.Time.now()

        # --------------------------------------------------------------
        # Durant RETURN_TO_INSPECTION i CLEAR_PREVIOUS_TARGET
        # no s'accepten deteccions noves.
        # --------------------------------------------------------------
        if self.state in ["RETURN_TO_INSPECTION", "CLEAR_PREVIOUS_TARGET"]:
            if self.ignored_hole_pose is not None:
                old_x, old_y, old_z = self.ignored_hole_pose
                distance_to_previous = math.sqrt((hx - old_x) ** 2
                    + (hy - old_y) ** 2
                    + (hz - old_z) ** 2)

                # La corrosió anterior encara és visible
                if distance_to_previous <= self.clear_target_gate:
                    self.last_previous_target_seen = now
                    rospy.loginfo_throttle(1.0, ("La corrosió anterior encara és visible | distància a la referència: %.2f m"), distance_to_previous)

            # Important: durant aquests estats no processem
            # cap detecció, ni l'antiga ni una de nova.
            return

        # --------------------------------------------------------------
        # Ignorar temporalment la detecció anterior després d'un reset
        # --------------------------------------------------------------
        if self.ignored_hole_pose is not None:

            ignored_x, ignored_y, ignored_z = self.ignored_hole_pose

            distance_to_ignored = math.sqrt(
                (hx - ignored_x) ** 2
                + (hy - ignored_y) ** 2
                + (hz - ignored_z) ** 2)

            ignored_elapsed = (now - self.ignore_hole_start_time).to_sec()

            # Si encara som dins del període d'exclusió i la detecció
            # està prop de l'objectiu anterior, la descartem
            if (ignored_elapsed < self.ignore_hole_timeout and distance_to_ignored < self.ignore_hole_radius):
                rospy.loginfo_throttle(1.0,
                    "Ignorant detecció anterior | dist=%.2f m | temps=%.1f/%.1f s",
                    distance_to_ignored,
                    ignored_elapsed,
                    self.ignore_hole_timeout)
                return

            # Si ha acabat el timeout, eliminem el bloqueig
            if ignored_elapsed >= self.ignore_hole_timeout:
                rospy.loginfo( "Finalitzat el període d'exclusió de l'objectiu anterior.")
                self.ignored_hole_pose = None

            # Si la nova detecció està prou lluny, també eliminem el bloqueig:
            # ja pot tractar-se d'una corrosió diferent
            elif distance_to_ignored >= self.ignore_hole_radius:
                rospy.loginfo("Nova detecció separada %.2f m de l'objectiu anterior. Iniciant un tracking nou.",
                    distance_to_ignored)
                self.ignored_hole_pose = None
        
        # Si ya hemos confirmado el agujero y estamos acercándonos, 
        # simplemente actualizamos la posición para no perderlo si el AUV se mueve.
        if self.state in ["CENTER_HOLE", "APPROACH_HOLE", "WAITING_INTERVENTION"]:

            # Si no hi ha objectiu, acceptem la detecció actual
            if self.hole_pose is None:
                self.hole_pose = (hx, hy, hz)
                return

            old_x, old_y, old_z = self.hole_pose
            tracking_distance = math.sqrt((hx - old_x) ** 2 + (hy - old_y) ** 2 + (hz - old_z) ** 2)

            # Només actualitzem l'objectiu si la detecció és compatible
            if tracking_distance <= self.approach_tracking_gate:
                a = self.approach_target_alpha
                self.hole_pose = (a * hx + (1.0 - a) * old_x, a * hy + (1.0 - a) * old_y, a * hz + (1.0 - a) * old_z)
            else:
                rospy.logwarn_throttle(1.0, "Detecció ignorada durant tracking: distància al target actual = %.2f m", tracking_distance)
            return

        if not self.allow_new_detections:
            rospy.loginfo_throttle(1.0, "Deteccions noves temporalment desactivades.")
            return

        # Si estamos en plena misión de búsqueda (MOVING o ALIGNING)
        if self.state == "MOVING":
            
            # 1. Si no hay ningún candidato previo, empezamos a contar
            if self.candidate_hole_pose is None:
                self.candidate_hole_pose = (hx, hy, hz)
                self.hole_detect_count = 1
                self.last_hole_time = now
                rospy.loginfo("Posible agujero detectado. Iniciando tracking... (1/%d)", self.req_detections)
                return

            # Extraemos las coordenadas del candidato que estábamos siguiendo
            cx, cy, cz = self.candidate_hole_pose
            time_diff = (now - self.last_hole_time).to_sec()
            dist_3d = math.sqrt((hx - cx)**2 + (hy - cy)**2 + (hz - cz)**2)

            # 2. Regla Temporal: ¿Ha pasado demasiado tiempo a ciegas?
            if time_diff > self.max_hole_timeout:
                rospy.logwarn("Tracking perdido por tiempo (%.1fs). Reseteando candidato...", time_diff)
                self.candidate_hole_pose = (hx, hy, hz)
                self.hole_detect_count = 1
                self.last_hole_time = now
                return

            # 3. Regla Espacial: ¿El agujero ha saltado de sitio de repente?
            if dist_3d > self.max_hole_dist:
                rospy.logwarn("El agujero se ha movido demasiado (%.2fm). Posible falso positivo. Reseteando...", dist_3d)
                self.candidate_hole_pose = (hx, hy, hz)
                self.hole_detect_count = 1
                self.last_hole_time = now
                return

            # 4. PASA LOS FILTROS: ¡Racha válida! Sumamos un punto.
            self.hole_detect_count += 1
            self.last_hole_time = now
            
            # Suavizamos el candidato haciendo una media con la nueva coordenada
            self.candidate_hole_pose = (
                (cx + hx) / 2.0,
                (cy + hy) / 2.0,
                (cz + hz) / 2.0
            )

            rospy.loginfo("Agujero consistente. Racha: %d/%d", self.hole_detect_count, self.req_detections)

            # 5. ¿Alcanzamos los 3 frames de seguridad? ¡A POR ÉL!
            if self.hole_detect_count >= self.req_detections:
                rospy.loginfo("!!! AGUJERO 100% VERIFICADO !!! Abortando patrón de búsqueda.")
                self.hole_pose = self.candidate_hole_pose
                px, py, pz, yaw = self.last_pose
                self.pre_approach_pose = (px, py, pz, yaw)
                self.state = "CENTER_HOLE"
                rospy.loginfo("Detecció confirmada. Passant a CENTER_HOLE.")


    def reset_tracking_cb(self, request):

        previous_state = self.state

        # Desactivar deteccions noves fins haver abandonat
        # completament la corrosió anterior
        self.allow_new_detections = False

        # Considerem que l'objectiu anterior acaba de ser vist
        self.last_previous_target_seen = rospy.Time.now()

        if self.hole_pose is not None:
            self.ignored_hole_pose = self.hole_pose
        elif self.candidate_hole_pose is not None:
            self.ignored_hole_pose = self.candidate_hole_pose
        else:
            self.ignored_hole_pose = None

        self.ignore_hole_start_time = rospy.Time.now()

        self.hole_pose = None
        self.candidate_hole_pose = None
        self.hole_detect_count = 0
        self.last_hole_time = rospy.Time(0)

        self.int_y = 0.0
        self.int_z = 0.0
        self.vy_f = 0.0
        self.vz_f = 0.0

        self.publish_cmd(0.0, 0.0, 0.0, 0.0, "inspector_reset_tracking")
        if (previous_state == "WAITING_INTERVENTION" and self.pre_approach_forward is not None and self.ignored_hole_pose is not None):
            self.state = "RETURN_TO_INSPECTION"
            message = ("Intervenció finalitzada. Recuperant la posició d'inspecció.")

        elif previous_state in ["CENTER_HOLE", "APPROACH_HOLE"] and self.pre_approach_forward is not None and self.ignored_hole_pose is not None:
            self.state = "RETURN_TO_INSPECTION"
            message = ("Tracking cancel·lat durant l'aproximació. Recuperant la posició d'inspecció.")

        elif previous_state in ["WAITING_INTERVENTION", "CENTER_HOLE", "APPROACH_HOLE"]:
            self.state = "MOVING"
            message = ("No hi ha una referència frontal vàlida. Reprenent directament la inspecció.")

        elif previous_state == "FINISHED":
            self.state = "FINISHED"
            message = ("La missió ja estava finalitzada. No es reprèn la inspecció.")

        else:
            self.state = "MOVING"
            message = "Tracking reiniciat. Reprenent la inspecció."

        rospy.loginfo(message)

        return TriggerResponse(success=True, message=message)

    def main_control_loop(self):
        """ Contiene la lógica principal del controlador y la máquina de estados. """
        
        # --- State 1: INITIALIZING ---
        if self.state == "INITIALIZING":
            is_ready = self.has_init and self.last_pose is not None
                
            if not is_ready:
                if not self.has_init:
                    rospy.logwarn_throttle(2.0, "Waiting for odometry...")
                self.publish_cmd(0.0, 0.0, 0.0, 0.0, "inspector_initializing")
                return
            else:
                rospy.loginfo("Initialization complete. Aligning robot.")
                self.state = "ALIGNING"
                self.current_wp_index = 0

        # --- State 2: ALIGNING ---
        elif self.state == "ALIGNING":
            px, py, pz, yaw = self.last_pose

            e_yaw = self.normalize_angle(self.target_yaw - yaw)
            wz_cmd = self.kp_yaw * e_yaw
            wz = self.clip(wz_cmd, -self.wz_max, self.wz_max)

            if abs(e_yaw) < self.tol_yaw:
                rospy.loginfo("Alignment complete! Starting inspection pattern.")
                self.publish_cmd(0.0, 0.0, 0.0, 0.0, "inspector_aligned")
                self.state = "MOVING"
                self.current_wp_index = 0
            else:
                self.publish_cmd(0.0, 0.0, 0.0, wz, "inspector_aligning")
                rospy.loginfo_throttle(1.0, "Aligning | ErrYaw: %.2f rad | Cmd(wz: %.2f)", e_yaw, wz)

        # --- State 3: MOVING ---
        elif self.state == "MOVING":
            if self.current_wp_index >= len(self.waypoints):
                rospy.loginfo("Mission completed.")
                self.state = "FINISHED"
                self.publish_cmd(0.0, 0.0, 0.0, 0.0, "inspector_finished")
                return

            target_dy, target_dz = self.waypoints[self.current_wp_index]
            px, py, pz, yaw = self.last_pose
            
            # --- CALCULATE TARGET DEPTH ---
            # La profundidad objetivo es la Profundidad Inicial (z0) + Desplazamiento (target_dz)
            target_depth = self.z0 + target_dz
            current_depth = pz # Z real es la Z de la navegación

            # ---------------- ERROR IN Y AXIS ----------------
            dx_w = px - self.x0
            dy_w = py - self.y0
            cy = math.cos(self.yaw0); sy = math.sin(self.yaw0)
            dy_b = -sy*dx_w + cy*dy_w 
            e_y = target_dy - dy_b
            
            # PI D Control for Y
            vy_cmd = (self.kp_y * e_y - self.kd_y * self.vy_est + self.int_y)

            # Anti-windup for Y
            if abs(vy_cmd) < self.vy_max - 1e-3:
                 self.int_y += self.ki_y * e_y / self.rate_hz
                 self.int_y = self.clip(self.int_y, -self.int_y_limit, self.int_y_limit)

            vy = self.clip(vy_cmd, -self.vy_max, self.vy_max)
            reached_y = abs(e_y) < self.tol_y
            
            # ---------------- ERROR IN Z AXIS (PID) ----------------
            
            # Safety check
            if current_depth > self.max_safe_depth:
                rospy.logwarn_throttle(1.0, "!!! SAFETY LIMIT REACHED (%.2fm) !!! Forcing ASCENT.", 
                                       current_depth)
                vz = -0.9 
                reached_z = False
                self.int_z = 0.0 
                e_z_or_depth = 0.0
            else:
                # Lógica normal de control
                e_depth = target_depth - current_depth
                e_z_or_depth = e_depth
                
                # PI D Control for Z
                vz_cmd = (self.kp_z * e_z_or_depth - self.kd_z * self.vz_est + self.int_z)
                
                if abs(vz_cmd) < self.vz_max - 1e-3:
                    self.int_z += self.ki_z * e_z_or_depth / self.rate_hz
                    self.int_z = self.clip(self.int_z, -self.int_z_limit, self.int_z_limit)
                
                vz = self.clip(vz_cmd, -self.vz_max, self.vz_max)
                reached_z = abs(e_z_or_depth) < self.tol_z
            
            # --- Waypoint Transition ---
            if reached_y and reached_z:
                rospy.loginfo("WP %d reached.", self.current_wp_index)
                self.current_wp_index += 1
                self.int_z = 0.0
                self.int_y = 0.0 
                vy, vz = 0.0, 0.0 
            
            # --- APPLY SMOOTHING (OR NOT) ---
            vy_out, vz_out = self.smooth(vy, vz)

            # --- NUEVO: MANTENER EL RUMBO ACTIVO (HEADING HOLD) ---
            # Calculamos el error de yaw continuamente mientras nos movemos
            e_yaw_moving = self.normalize_angle(self.target_yaw - yaw)
            wz_cmd = self.kp_yaw * e_yaw_moving
            wz_out = self.clip(wz_cmd, -self.wz_max, self.wz_max)
            
            requester = "inspector_wp_{}".format(self.current_wp_index)
            self.publish_cmd(0.0, vy_out, vz_out, wz_out, requester)
            
            # --- PUBLISHING FOR RQT_PLOT AND CURRENT TARGET ---
            # 1. Real Z
            self.pub_real_z.publish(Float64(current_depth))
            # 2. Target Z
            self.pub_target_z.publish(Float64(target_depth))
            # 3. Output Vz Command
            self.pub_vz_out.publish(Float64(vz_out*10))
            # 3b. Error in Z
            self.pub_error_z.publish(Float64(e_z_or_depth))

            # 4. CURRENT TARGET POINT
            # BUGFIX: Solo publica si no hemos llegado al final
            if self.current_wp_index < len(self.waypoints):
                self.publish_current_target_point(self.current_wp_index)
            
            rospy.loginfo_throttle(1.0, 
                "WP %d | ErrY:%.2f (IntY:%.2f) | ErrZ:%.2f | Cmd(vy:%.2f, vz:%.2f)",
                self.current_wp_index, e_y, self.int_y, e_z_or_depth, vy_out, vz_out)

        # ------------------------------------------------------------
        # STATE 4: CENTER_HOLE
        # ------------------------------------------------------------
        elif self.state == "CENTER_HOLE":

            if self.hole_pose is None:
                self.publish_cmd(0.0, 0.0, 0.0, 0.0, "inspector_waiting_hole_center")
                return

            hx, hy, hz = self.hole_pose
            px, py, pz, yaw = self.last_pose

            # ========================================================
            # 1. ERROR OBJECTIU EN COORDENADES BODY
            # ========================================================
            dx_world = hx - px
            dy_world = hy - py

            cy = math.cos(yaw)
            sy = math.sin(yaw)

            # Eix X del robot: component frontal
            e_forward = cy * dx_world + sy * dy_world
            if not self.is_pre_approach_position_saved:
                self.is_pre_approach_position_saved = True
                self.pre_approach_forward = e_forward

            # Eix Y del robot: component lateral
            e_lateral = -sy * dx_world + cy * dy_world

            # ========================================================
            # 2. MANTENIR YAW PERPENDICULAR A LA PARET
            # ========================================================
            e_yaw_wall = self.normalize_angle(self.target_yaw - yaw)
            wz_cmd = self.kp_yaw_approach * e_yaw_wall
            wz = self.clip(wz_cmd, -self.wz_approach_max, self.wz_approach_max)

            # ========================================================
            # 3. MOVIMENT LATERAL PER CENTRAR LA DETECCIÓ
            # ========================================================
            vy_cmd = self.kp_center_y * e_lateral
            vy = self.clip(vy_cmd, -self.vy_center_max, self.vy_center_max)

            # ========================================================
            # 4. CENTRAT VERTICAL
            # ========================================================
            e_z = (hz - self.camera_offset_z - pz)
            vz_cmd = self.kp_z * e_z
            vz = self.clip(vz_cmd, -self.vz_max, self.vz_max)

            # ========================================================
            # 5. CONDICIONS DE CENTRAT
            # ========================================================

            centered_y = abs(e_lateral) < self.tol_center_y
            centered_z = abs(e_z) < self.tol_center_z
            aligned_yaw = abs(e_yaw_wall) < self.tol_yaw_approach

            if centered_y:
                vy = 0.0
            if centered_z:
                vz = 0.0
            if aligned_yaw:
                wz = 0.0

            # No permetem avançar en aquest estat
            vx = 0.0
            self.publish_cmd(vx, vy, vz, wz, "inspector_centering_hole")
            if centered_y and centered_z and aligned_yaw:
                rospy.loginfo("Corrosió centrada. Passant a APPROACH_HOLE.")
                self.publish_cmd(0.0, 0.0, 0.0, 0.0, "inspector_hole_centered")
                self.state = "APPROACH_HOLE"
                return

            rospy.loginfo_throttle(1.0, ("CENTER_HOLE | Forward: %.2f | LatErr: %.2f | ZErr: %.2f | YawErr: %.1f deg | Cmd(vy: %.2f vz: %.2f wz: %.2f)"),
                e_forward, e_lateral, e_z, math.degrees(e_yaw_wall), vy, vz, wz)

        # ------------------------------------------------------------
        # STATE 5: APPROACH_HOLE
        # ------------------------------------------------------------
        elif self.state == "APPROACH_HOLE":

            if self.hole_pose is None:
                self.publish_cmd(0.0, 0.0, 0.0, 0.0, "inspector_waiting_hole_approach")
                return

            hx, hy, hz = self.hole_pose
            px, py, pz, yaw = self.last_pose

            # ========================================================
            # 1. ERROR OBJECTIU EN FRAME BODY
            # ========================================================
            dx_world = hx - px
            dy_world = hy - py

            cy = math.cos(yaw)
            sy = math.sin(yaw)

            e_forward = cy * dx_world + sy * dy_world
            e_lateral = -sy * dx_world + cy * dy_world

            # ========================================================
            # 2. YAW FIX RESPECTE DE LA PARET
            # ========================================================
            e_yaw_wall = self.normalize_angle(self.target_yaw - yaw)
            wz_cmd = self.kp_yaw_approach * e_yaw_wall
            wz = self.clip(wz_cmd, -self.wz_approach_max, self.wz_approach_max)

            # ========================================================
            # 3. CORRECCIÓ LATERAL SUAU
            # ========================================================
            vy_cmd = self.kp_center_y * e_lateral
            vy = self.clip(vy_cmd, -self.vy_center_max, self.vy_center_max)

            # ========================================================
            # 4. CONTROL VERTICAL
            # ========================================================
            e_z = (hz - self.camera_offset_z - pz)
            vz_cmd = self.kp_z * e_z
            vz = self.clip(vz_cmd, -self.vz_max, self.vz_max)

            # ========================================================
            # 5. HISTÈRESI: SI PERDEM EL CENTRAT, TORNEM A CENTER_HOLE TODO: Per ara desactivat. Si creiem que fa falta, ja l'activarem
            # ========================================================
            # lost_centering = (
            #     abs(e_lateral) > self.tol_center_y_exit
            #     or abs(e_z) > self.tol_center_z_exit
            #     or abs(e_yaw_wall) > self.tol_yaw_exit)

            # if lost_centering:
            #     rospy.logwarn("Centrat perdut durant approach. Tornant a CENTER_HOLE.")
            #     self.publish_cmd(0.0, vy, vz, wz, "inspector_recenter_hole")
            #     self.state = "CENTER_HOLE"
            #     return

            # ========================================================
            # 6. APROXIMACIÓ FRONTAL
            # ========================================================
            e_distance = e_forward - self.safe_distance
            vx = 0.0
            if e_distance > self.safe_distance_tolerance:
                vx_cmd = self.kp_approach_x * e_distance
                vx = self.clip(vx_cmd, 0.0, self.vx_approach_max)

            else:
                rospy.loginfo("Distància segura assolida. Tracking finalitzat.")
                self.publish_cmd(0.0, 0.0, 0.0, 0.0, "inspector_ready")
                self.state = "WAITING_INTERVENTION"
                return

            self.publish_cmd(vx, vy, vz, wz, "inspector_approaching")
            rospy.loginfo_throttle( 1.0, (
                    "APPROACH_HOLE | "
                    "Forward: %.2f | "
                    "DistErr: %.2f | "
                    "LatErr: %.2f | "
                    "ZErr: %.2f | "
                    "YawErr: %.1f deg | "
                    "Cmd(vx: %.2f vy: %.2f vz: %.2f wz: %.2f)"),
                e_forward, e_distance, e_lateral, e_z, math.degrees(e_yaw_wall),
                vx, vy, vz, wz)

        elif self.state == "WAITING_INTERVENTION":
            self.publish_cmd(0.0, 0.0, 0.0, 0.0, "inspector_waiting_intervention")
            rospy.loginfo_throttle(2.0, "Robot posicionat davant de la corrosió. "
                "Esperant intervenció o crida a ~reset_tracking.")

        # ------------------------------------------------------------
        # STATE 7: RETURN_TO_INSPECTION
        # ------------------------------------------------------------
        elif self.state == "RETURN_TO_INSPECTION":

            # Necessitem la distància original i la posició de la corrosió
            # utilitzada com a referència.
            if (self.pre_approach_forward is None or self.ignored_hole_pose is None):
                rospy.logwarn("RETURN_TO_INSPECTION sense referència vàlida. Passant directament a MOVING.")
                self.publish_cmd(0.0, 0.0, 0.0, 0.0, "inspector_return_missing_reference")
                self.pre_approach_forward = None
                self.is_pre_approach_position_saved = False
                self.state = "MOVING"
                return

            if self.last_pose is None:
                self.publish_cmd(0.0, 0.0, 0.0, 0.0, "inspector_return_waiting_navigation")
                return

            # ========================================================
            # 1. POSICIÓ ACTUAL I POSICIÓ DE LA DETECCIÓ TRACTADA
            # ========================================================
            px, py, pz, yaw = self.last_pose
            hx, hy, hz = self.ignored_hole_pose

            dx_world = hx - px
            dy_world = hy - py

            cy = math.cos(yaw)
            sy = math.sin(yaw)

            # Distància frontal actual respecte de la corrosió
            current_forward = (cy * dx_world + sy * dy_world)

            # ========================================================
            # 2. ERROR RESPECTE DE LA DISTÀNCIA PRE-APPROACH
            # ========================================================
            # Positiu:
            # el robot està massa prop de la paret i ha de retrocedir.
            # Negatiu:
            # el robot està més lluny del que estava abans.
            distance_error = (self.pre_approach_forward - current_forward)

            # En el cas normal:
            # pre_approach_forward = 2.0 m
            # current_forward      = 0.8 m
            # distance_error = 1.2 m
            # Per recuperar els 2.0 m, el robot ha de moure's cap arrere:
            # vx negativa.
            vx_cmd = -self.kp_return_x * distance_error
            vx = self.clip(vx_cmd, -self.vx_return_max, self.vx_return_max)

            # ========================================================
            # 3. MANTENIR YAW PERPENDICULAR A LA PARET
            # ========================================================
            e_yaw_wall = self.normalize_angle(self.target_yaw - yaw)
            wz_cmd = self.kp_yaw_return * e_yaw_wall
            wz = self.clip(wz_cmd, -self.wz_return_max, self.wz_return_max)

            # ========================================================
            # 4. CONDICIONS DE RETORN
            # ========================================================
            reached_distance = (abs(distance_error) < self.return_distance_tolerance)
            reached_yaw = (abs(e_yaw_wall) < self.return_yaw_tolerance)

            if reached_distance:
                vx = 0.0

            if reached_yaw:
                wz = 0.0

            # Durant aquest estat només recuperem distància frontal
            # i mantenim l'orientació.
            vy = 0.0
            vz = 0.0

            self.publish_cmd(vx, vy, vz, wz, "inspector_returning_to_inspection")

            # ========================================================
            # 5. TRANSICIÓ A MOVING
            # ========================================================
            if reached_distance and reached_yaw:
                rospy.loginfo( "Distància d'inspecció recuperada: actual=%.2f m, objectiu=%.2f m. "
                    "Reprenent MOVING.", current_forward,self.pre_approach_forward)
                self.publish_cmd(0.0, 0.0, 0.0, 0.0, "inspector_inspection_distance_recovered")

                # Reiniciar variables del retorn
                # La distància frontal ja s'ha recuperat
                self.pre_approach_forward = None
                self.is_pre_approach_position_saved = False

                self.int_y = 0.0
                self.int_z = 0.0
                self.vy_f = 0.0
                self.vz_f = 0.0

                # Preparar el desplaçament per abandonar el target anterior
                self.clear_target_start_time = rospy.Time.now()
                self.last_previous_target_seen = rospy.Time.now()

                px, py, pz, yaw = self.last_pose
                self.clear_target_start_pose = (px, py, pz)

                # Elegir la direcció lateral que continua el patró d'inspecció
                if self.current_wp_index < len(self.waypoints):
                    target_dy, _ = self.waypoints[self.current_wp_index]
                    dx_w = px - self.x0
                    dy_w = py - self.y0
                    cy0 = math.cos(self.yaw0)
                    sy0 = math.sin(self.yaw0)
                    current_dy = -sy0 * dx_w + cy0 * dy_w
                    lateral_error = target_dy - current_dy
                    self.clear_target_direction = (1.0 if lateral_error >= 0.0 else -1.0)
                else:
                    # Fallback
                    self.clear_target_direction = 1.0

                self.state = "CLEAR_PREVIOUS_TARGET"
                rospy.loginfo("Distància d'inspecció recuperada. Passant a CLEAR_PREVIOUS_TARGET.")
                return

            rospy.loginfo_throttle(1.0, (
                    "RETURN_TO_INSPECTION | "
                    "CurrentForward: %.2f m | "
                    "TargetForward: %.2f m | "
                    "Error: %.2f m | "
                    "YawErr: %.1f deg | "
                    "Cmd(vx: %.2f wz: %.2f)"),
                current_forward, self.pre_approach_forward, distance_error, math.degrees(e_yaw_wall), vx, wz)

        # ------------------------------------------------------------
        # STATE 8: CLEAR_PREVIOUS_TARGET
        # ------------------------------------------------------------
        elif self.state == "CLEAR_PREVIOUS_TARGET":

            if self.last_pose is None:
                self.publish_cmd(0.0, 0.0, 0.0, 0.0, "inspector_clear_waiting_navigation")
                return

            if self.clear_target_start_pose is None:
                rospy.logwarn("CLEAR_PREVIOUS_TARGET sense pose inicial. Reprenent MOVING.")
                self.allow_new_detections = True
                self.state = "MOVING"
                return

            px, py, pz, yaw = self.last_pose
            start_x, start_y, start_z = self.clear_target_start_pose
            now = rospy.Time.now()

            # ========================================================
            # 1. DESPLAÇAMENT LATERAL RECORREGUT
            # ========================================================
            dx_world = px - start_x
            dy_world = py - start_y

            # Projectar el desplaçament sobre l'eix lateral
            # de la trajectòria d'inspecció
            cy0 = math.cos(self.yaw0)
            sy0 = math.sin(self.yaw0)
            lateral_displacement = (-sy0 * dx_world + cy0 * dy_world)
            lateral_displacement_signed = (self.clear_target_direction * lateral_displacement)
            enough_displacement = (lateral_displacement_signed >= self.clear_target_min_distance)

            # ========================================================
            # 2. TEMPS DES DE L'ÚLTIMA VEGADA QUE ES VA VEURE
            #    LA CORROSIÓ ANTERIOR
            # ========================================================
            time_not_seen = (now - self.last_previous_target_seen).to_sec()
            previous_target_not_seen = (time_not_seen >= self.clear_target_not_seen_timeout)

            # ========================================================
            # 3. CONTROL DE YAW
            # ========================================================
            e_yaw_wall = self.normalize_angle(self.target_yaw - yaw)
            wz_cmd = self.kp_yaw_return * e_yaw_wall
            wz = self.clip(wz_cmd, -self.wz_return_max, self.wz_return_max)

            if abs(e_yaw_wall) < self.return_yaw_tolerance:
                wz = 0.0

            # ========================================================
            # 4. MOVIMENT LATERAL
            # ========================================================
            vy = (self.clear_target_direction * self.clear_target_vy)
            vx = 0.0
            vz = 0.0
            self.publish_cmd(vx, vy, vz, wz, "inspector_clearing_previous_target")

            # ========================================================
            # 5. CONDICIÓ ESTRICTA PER TORNAR A MOVING
            # ========================================================
            if enough_displacement and previous_target_not_seen:
                rospy.loginfo((
                        "Objectiu anterior abandonat | "
                        "desplaçament lateral: %.2f m | "
                        "temps sense veure'l: %.2f s. "
                        "Reactivant deteccions."),
                    lateral_displacement_signed, time_not_seen)

                self.publish_cmd(0.0, 0.0, 0.0, 0.0, "inspector_previous_target_cleared")

                # Ja podem oblidar definitivament la detecció tractada
                self.ignored_hole_pose = None
                self.clear_target_start_pose = None
                self.clear_target_start_time = rospy.Time(0)
                self.last_previous_target_seen = rospy.Time(0)

                # Reiniciar qualsevol candidat residual
                self.hole_pose = None
                self.candidate_hole_pose = None
                self.hole_detect_count = 0
                self.last_hole_time = rospy.Time(0)

                # Tornar a habilitar el detector
                self.allow_new_detections = True

                self.int_y = 0.0
                self.int_z = 0.0
                self.vy_f = 0.0
                self.vz_f = 0.0

                self.state = "MOVING"
                return

            # ========================================================
            # 6. TIMEOUT DE SEGURETAT
            # ========================================================

            clear_elapsed = (now - self.clear_target_start_time).to_sec()
            if clear_elapsed >= self.clear_target_max_duration:
                rospy.logwarn((
                        "Timeout en CLEAR_PREVIOUS_TARGET després de %.1f s. "
                        "Reactivant deteccions per seguretat."), clear_elapsed)
                self.publish_cmd(0.0, 0.0, 0.0, 0.0, "inspector_clear_target_timeout")
                self.ignored_hole_pose = None
                self.clear_target_start_pose = None
                self.hole_pose = None
                self.candidate_hole_pose = None
                self.hole_detect_count = 0
                self.last_hole_time = rospy.Time(0)
                self.allow_new_detections = True
                self.state = "MOVING"
                return

            rospy.loginfo_throttle(1.0, ("CLEAR_PREVIOUS_TARGET | "
                    "Lateral: %.2f/%.2f m | "
                    "NotSeen: %.2f/%.2f s | "
                    "EnoughDisp: %s | "
                    "TargetGone: %s | "
                    "Cmd(vy: %.2f wz: %.2f)"),
                lateral_displacement_signed,
                self.clear_target_min_distance,
                time_not_seen,
                self.clear_target_not_seen_timeout,
                enough_displacement, previous_target_not_seen, vy, wz)

        # --- State 5: FINISHED ---
        elif self.state == "FINISHED":
            vy, vz = self.smooth(0.0, 0.0)
            self.publish_cmd(0.0, 0.0, 0.0, 0.0, "inspector_finished")
            rospy.loginfo_throttle(5.0, "Missió d'inspecció completada.")
        else:
            vy, vz = self.smooth(0.0, 0.0)
            self.publish_cmd(0.0, vy, vz, 0.0, "inspector_idle")


    def smooth(self, vy, vz):
        if not self.use_smoothing_flag:
            self.vy_f = vy
            self.vz_f = vz
            return vy, vz

        vy_f = self.alpha * vy + (1.0 - self.alpha) * self.vy_f
        vz_f = self.alpha * vz + (1.0 - self.alpha) * self.vz_f
        
        vy_f = self.clip(vy_f, self.vy_f - self.max_dv, self.vy_f + self.max_dv)
        vz_f = self.clip(vz_f, self.vz_f - self.max_dv, self.vz_f + self.max_dv)
        
        self.vy_f, self.vz_f = vy_f, vz_f
        return vy_f, vz_f

    def publish_cmd(self, vx, vy, vz, wz, requester):
        """ Modificado para aceptar wz (Yaw Rate) """
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
        tw.angular.z = wz
        cmd.twist = tw
        ba = Bool6Axis()
        ba.x = False
        ba.y = False
        ba.z = False
        ba.roll = True
        ba.pitch = True
        ba.yaw = False
        cmd.disable_axis = ba
        self.pub.publish(cmd)

    @staticmethod
    def normalize_angle(angle):
        """ Asegura que el ángulo siempre esté entre -PI y +PI """
        while angle > math.pi:
            angle -= 2.0 * math.pi
        while angle < -math.pi:
            angle += 2.0 * math.pi
        return angle
        
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