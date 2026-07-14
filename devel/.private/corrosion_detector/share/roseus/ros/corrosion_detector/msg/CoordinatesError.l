;; Auto-generated. Do not edit!


(when (boundp 'corrosion_detector::CoordinatesError)
  (if (not (find-package "CORROSION_DETECTOR"))
    (make-package "CORROSION_DETECTOR"))
  (shadow 'CoordinatesError (find-package "CORROSION_DETECTOR")))
(unless (find-package "CORROSION_DETECTOR::COORDINATESERROR")
  (make-package "CORROSION_DETECTOR::COORDINATESERROR"))

(in-package "ROS")
;;//! \htmlinclude CoordinatesError.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass corrosion_detector::CoordinatesError
  :super ros::object
  :slots (_header _x_err _y_err _z_err _total_error ))

(defmethod corrosion_detector::CoordinatesError
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:x_err __x_err) 0.0)
    ((:y_err __y_err) 0.0)
    ((:z_err __z_err) 0.0)
    ((:total_error __total_error) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _x_err (float __x_err))
   (setq _y_err (float __y_err))
   (setq _z_err (float __z_err))
   (setq _total_error (float __total_error))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:x_err
   (&optional __x_err)
   (if __x_err (setq _x_err __x_err)) _x_err)
  (:y_err
   (&optional __y_err)
   (if __y_err (setq _y_err __y_err)) _y_err)
  (:z_err
   (&optional __z_err)
   (if __z_err (setq _z_err __z_err)) _z_err)
  (:total_error
   (&optional __total_error)
   (if __total_error (setq _total_error __total_error)) _total_error)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float64 _x_err
    8
    ;; float64 _y_err
    8
    ;; float64 _z_err
    8
    ;; float64 _total_error
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float64 _x_err
       (sys::poke _x_err (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y_err
       (sys::poke _y_err (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _z_err
       (sys::poke _z_err (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _total_error
       (sys::poke _total_error (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float64 _x_err
     (setq _x_err (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y_err
     (setq _y_err (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _z_err
     (setq _z_err (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _total_error
     (setq _total_error (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get corrosion_detector::CoordinatesError :md5sum-) "f51f162e146a2cd618e4c2bc2935431c")
(setf (get corrosion_detector::CoordinatesError :datatype-) "corrosion_detector/CoordinatesError")
(setf (get corrosion_detector::CoordinatesError :definition-)
      "std_msgs/Header header

# Coordenadas del error (posicion ground_truth - posicion calculada)
float64 x_err 
float64 y_err
float64 z_err

# Distancia euclídea entre los 2 puntos en 3 dimensiones
float64 total_error
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



(provide :corrosion_detector/CoordinatesError "f51f162e146a2cd618e4c2bc2935431c")


