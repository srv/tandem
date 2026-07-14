;; Auto-generated. Do not edit!


(when (boundp 'corrosion_detector::BoundingBoxArray)
  (if (not (find-package "CORROSION_DETECTOR"))
    (make-package "CORROSION_DETECTOR"))
  (shadow 'BoundingBoxArray (find-package "CORROSION_DETECTOR")))
(unless (find-package "CORROSION_DETECTOR::BOUNDINGBOXARRAY")
  (make-package "CORROSION_DETECTOR::BOUNDINGBOXARRAY"))

(in-package "ROS")
;;//! \htmlinclude BoundingBoxArray.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass corrosion_detector::BoundingBoxArray
  :super ros::object
  :slots (_header _boxes ))

(defmethod corrosion_detector::BoundingBoxArray
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:boxes __boxes) ())
    )
   (send-super :init)
   (setq _header __header)
   (setq _boxes __boxes)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:boxes
   (&rest __boxes)
   (if (keywordp (car __boxes))
       (send* _boxes __boxes)
     (progn
       (if __boxes (setq _boxes (car __boxes)))
       _boxes)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; corrosion_detector/BoundingBox[] _boxes
    (apply #'+ (send-all _boxes :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; corrosion_detector/BoundingBox[] _boxes
     (write-long (length _boxes) s)
     (dolist (elem _boxes)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; corrosion_detector/BoundingBox[] _boxes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _boxes (let (r) (dotimes (i n) (push (instance corrosion_detector::BoundingBox :init) r)) r))
     (dolist (elem- _boxes)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get corrosion_detector::BoundingBoxArray :md5sum-) "f4acd9e8a28a9feaebd1bd8961261358")
(setf (get corrosion_detector::BoundingBoxArray :datatype-) "corrosion_detector/BoundingBoxArray")
(setf (get corrosion_detector::BoundingBoxArray :definition-)
      "Header header        # Importante para el timestamp
BoundingBox[] boxes  # La lista de cajas (puede haber 0, 1 o 20)
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

================================================================================
MSG: corrosion_detector/BoundingBox
string class_id      # \"0\", \"person\", etc.
float64 score        # Probabilidad (0.0 a 1.0)

# Coordenadas NORMALIZADAS (0.0 a 1.0)
# Es lo estándar en YOLO y facilita la vida al siguiente nodo
float64 x            # Centro X
float64 y            # Centro Y
float64 w            # Ancho
float64 h            # Alto

# Coordenades normalitzades del Punt de corrosió
float64 corr_x
float64 corr_y
float64 std_x
float64 std_y
float64 area
int16 width
int16 height

")



(provide :corrosion_detector/BoundingBoxArray "f4acd9e8a28a9feaebd1bd8961261358")


