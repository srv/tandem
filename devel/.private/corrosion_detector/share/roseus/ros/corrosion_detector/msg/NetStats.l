;; Auto-generated. Do not edit!


(when (boundp 'corrosion_detector::NetStats)
  (if (not (find-package "CORROSION_DETECTOR"))
    (make-package "CORROSION_DETECTOR"))
  (shadow 'NetStats (find-package "CORROSION_DETECTOR")))
(unless (find-package "CORROSION_DETECTOR::NETSTATS")
  (make-package "CORROSION_DETECTOR::NETSTATS"))

(in-package "ROS")
;;//! \htmlinclude NetStats.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass corrosion_detector::NetStats
  :super ros::object
  :slots (_header _scale_m_per_px _median_hole_area_px _median_hole_area_m2 ))

(defmethod corrosion_detector::NetStats
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:scale_m_per_px __scale_m_per_px) 0.0)
    ((:median_hole_area_px __median_hole_area_px) 0.0)
    ((:median_hole_area_m2 __median_hole_area_m2) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _scale_m_per_px (float __scale_m_per_px))
   (setq _median_hole_area_px (float __median_hole_area_px))
   (setq _median_hole_area_m2 (float __median_hole_area_m2))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:scale_m_per_px
   (&optional __scale_m_per_px)
   (if __scale_m_per_px (setq _scale_m_per_px __scale_m_per_px)) _scale_m_per_px)
  (:median_hole_area_px
   (&optional __median_hole_area_px)
   (if __median_hole_area_px (setq _median_hole_area_px __median_hole_area_px)) _median_hole_area_px)
  (:median_hole_area_m2
   (&optional __median_hole_area_m2)
   (if __median_hole_area_m2 (setq _median_hole_area_m2 __median_hole_area_m2)) _median_hole_area_m2)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _scale_m_per_px
    4
    ;; float32 _median_hole_area_px
    4
    ;; float32 _median_hole_area_m2
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _scale_m_per_px
       (sys::poke _scale_m_per_px (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _median_hole_area_px
       (sys::poke _median_hole_area_px (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _median_hole_area_m2
       (sys::poke _median_hole_area_m2 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _scale_m_per_px
     (setq _scale_m_per_px (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _median_hole_area_px
     (setq _median_hole_area_px (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _median_hole_area_m2
     (setq _median_hole_area_m2 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get corrosion_detector::NetStats :md5sum-) "f0b14b7f5d4cea4e0f0d1ef78c891d2e")
(setf (get corrosion_detector::NetStats :datatype-) "corrosion_detector/NetStats")
(setf (get corrosion_detector::NetStats :definition-)
      "Header header

# Escala calculada (metros/pixel)
float32 scale_m_per_px

# Área mediana de los hexágonos (en píxeles cuadrados)
float32 median_hole_area_px

# (Opcional) Área mediana en metros cuadrados (por si la quiere directa)
float32 median_hole_area_m2
================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

")



(provide :corrosion_detector/NetStats "f0b14b7f5d4cea4e0f0d1ef78c891d2e")


