;; Auto-generated. Do not edit!


(when (boundp 'corrosion_detector::AxisPoints)
  (if (not (find-package "CORROSION_DETECTOR"))
    (make-package "CORROSION_DETECTOR"))
  (shadow 'AxisPoints (find-package "CORROSION_DETECTOR")))
(unless (find-package "CORROSION_DETECTOR::AXISPOINTS")
  (make-package "CORROSION_DETECTOR::AXISPOINTS"))

(in-package "ROS")
;;//! \htmlinclude AxisPoints.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass corrosion_detector::AxisPoints
  :super ros::object
  :slots (_header _major_axis_p1 _major_axis_p2 _minor_axis_p1 _minor_axis_p2 _orientation _major_axis_len _minor_axis_len ))

(defmethod corrosion_detector::AxisPoints
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:major_axis_p1 __major_axis_p1) (instance geometry_msgs::Point :init))
    ((:major_axis_p2 __major_axis_p2) (instance geometry_msgs::Point :init))
    ((:minor_axis_p1 __minor_axis_p1) (instance geometry_msgs::Point :init))
    ((:minor_axis_p2 __minor_axis_p2) (instance geometry_msgs::Point :init))
    ((:orientation __orientation) 0.0)
    ((:major_axis_len __major_axis_len) 0.0)
    ((:minor_axis_len __minor_axis_len) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _major_axis_p1 __major_axis_p1)
   (setq _major_axis_p2 __major_axis_p2)
   (setq _minor_axis_p1 __minor_axis_p1)
   (setq _minor_axis_p2 __minor_axis_p2)
   (setq _orientation (float __orientation))
   (setq _major_axis_len (float __major_axis_len))
   (setq _minor_axis_len (float __minor_axis_len))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:major_axis_p1
   (&rest __major_axis_p1)
   (if (keywordp (car __major_axis_p1))
       (send* _major_axis_p1 __major_axis_p1)
     (progn
       (if __major_axis_p1 (setq _major_axis_p1 (car __major_axis_p1)))
       _major_axis_p1)))
  (:major_axis_p2
   (&rest __major_axis_p2)
   (if (keywordp (car __major_axis_p2))
       (send* _major_axis_p2 __major_axis_p2)
     (progn
       (if __major_axis_p2 (setq _major_axis_p2 (car __major_axis_p2)))
       _major_axis_p2)))
  (:minor_axis_p1
   (&rest __minor_axis_p1)
   (if (keywordp (car __minor_axis_p1))
       (send* _minor_axis_p1 __minor_axis_p1)
     (progn
       (if __minor_axis_p1 (setq _minor_axis_p1 (car __minor_axis_p1)))
       _minor_axis_p1)))
  (:minor_axis_p2
   (&rest __minor_axis_p2)
   (if (keywordp (car __minor_axis_p2))
       (send* _minor_axis_p2 __minor_axis_p2)
     (progn
       (if __minor_axis_p2 (setq _minor_axis_p2 (car __minor_axis_p2)))
       _minor_axis_p2)))
  (:orientation
   (&optional __orientation)
   (if __orientation (setq _orientation __orientation)) _orientation)
  (:major_axis_len
   (&optional __major_axis_len)
   (if __major_axis_len (setq _major_axis_len __major_axis_len)) _major_axis_len)
  (:minor_axis_len
   (&optional __minor_axis_len)
   (if __minor_axis_len (setq _minor_axis_len __minor_axis_len)) _minor_axis_len)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; geometry_msgs/Point _major_axis_p1
    (send _major_axis_p1 :serialization-length)
    ;; geometry_msgs/Point _major_axis_p2
    (send _major_axis_p2 :serialization-length)
    ;; geometry_msgs/Point _minor_axis_p1
    (send _minor_axis_p1 :serialization-length)
    ;; geometry_msgs/Point _minor_axis_p2
    (send _minor_axis_p2 :serialization-length)
    ;; float64 _orientation
    8
    ;; float64 _major_axis_len
    8
    ;; float64 _minor_axis_len
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; geometry_msgs/Point _major_axis_p1
       (send _major_axis_p1 :serialize s)
     ;; geometry_msgs/Point _major_axis_p2
       (send _major_axis_p2 :serialize s)
     ;; geometry_msgs/Point _minor_axis_p1
       (send _minor_axis_p1 :serialize s)
     ;; geometry_msgs/Point _minor_axis_p2
       (send _minor_axis_p2 :serialize s)
     ;; float64 _orientation
       (sys::poke _orientation (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _major_axis_len
       (sys::poke _major_axis_len (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _minor_axis_len
       (sys::poke _minor_axis_len (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; geometry_msgs/Point _major_axis_p1
     (send _major_axis_p1 :deserialize buf ptr-) (incf ptr- (send _major_axis_p1 :serialization-length))
   ;; geometry_msgs/Point _major_axis_p2
     (send _major_axis_p2 :deserialize buf ptr-) (incf ptr- (send _major_axis_p2 :serialization-length))
   ;; geometry_msgs/Point _minor_axis_p1
     (send _minor_axis_p1 :deserialize buf ptr-) (incf ptr- (send _minor_axis_p1 :serialization-length))
   ;; geometry_msgs/Point _minor_axis_p2
     (send _minor_axis_p2 :deserialize buf ptr-) (incf ptr- (send _minor_axis_p2 :serialization-length))
   ;; float64 _orientation
     (setq _orientation (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _major_axis_len
     (setq _major_axis_len (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _minor_axis_len
     (setq _minor_axis_len (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get corrosion_detector::AxisPoints :md5sum-) "c40b075900f16fe11733d8a1bb7afb1b")
(setf (get corrosion_detector::AxisPoints :datatype-) "corrosion_detector/AxisPoints")
(setf (get corrosion_detector::AxisPoints :definition-)
      "std_msgs/Header header

# List of 2D points
geometry_msgs/Point major_axis_p1
geometry_msgs/Point major_axis_p2
geometry_msgs/Point minor_axis_p1
geometry_msgs/Point minor_axis_p2

# Orientation of the axis (yaw in radians)
float64 orientation

# Axis lenghts
float64 major_axis_len
float64 minor_axis_len

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
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :corrosion_detector/AxisPoints "c40b075900f16fe11733d8a1bb7afb1b")


