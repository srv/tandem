; Auto-generated. Do not edit!


(cl:in-package corrosion_detector-msg)


;//! \htmlinclude AxisPoints.msg.html

(cl:defclass <AxisPoints> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (major_axis_p1
    :reader major_axis_p1
    :initarg :major_axis_p1
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point))
   (major_axis_p2
    :reader major_axis_p2
    :initarg :major_axis_p2
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point))
   (minor_axis_p1
    :reader minor_axis_p1
    :initarg :minor_axis_p1
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point))
   (minor_axis_p2
    :reader minor_axis_p2
    :initarg :minor_axis_p2
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point))
   (orientation
    :reader orientation
    :initarg :orientation
    :type cl:float
    :initform 0.0)
   (major_axis_len
    :reader major_axis_len
    :initarg :major_axis_len
    :type cl:float
    :initform 0.0)
   (minor_axis_len
    :reader minor_axis_len
    :initarg :minor_axis_len
    :type cl:float
    :initform 0.0))
)

(cl:defclass AxisPoints (<AxisPoints>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AxisPoints>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AxisPoints)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name corrosion_detector-msg:<AxisPoints> is deprecated: use corrosion_detector-msg:AxisPoints instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <AxisPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader corrosion_detector-msg:header-val is deprecated.  Use corrosion_detector-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'major_axis_p1-val :lambda-list '(m))
(cl:defmethod major_axis_p1-val ((m <AxisPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader corrosion_detector-msg:major_axis_p1-val is deprecated.  Use corrosion_detector-msg:major_axis_p1 instead.")
  (major_axis_p1 m))

(cl:ensure-generic-function 'major_axis_p2-val :lambda-list '(m))
(cl:defmethod major_axis_p2-val ((m <AxisPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader corrosion_detector-msg:major_axis_p2-val is deprecated.  Use corrosion_detector-msg:major_axis_p2 instead.")
  (major_axis_p2 m))

(cl:ensure-generic-function 'minor_axis_p1-val :lambda-list '(m))
(cl:defmethod minor_axis_p1-val ((m <AxisPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader corrosion_detector-msg:minor_axis_p1-val is deprecated.  Use corrosion_detector-msg:minor_axis_p1 instead.")
  (minor_axis_p1 m))

(cl:ensure-generic-function 'minor_axis_p2-val :lambda-list '(m))
(cl:defmethod minor_axis_p2-val ((m <AxisPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader corrosion_detector-msg:minor_axis_p2-val is deprecated.  Use corrosion_detector-msg:minor_axis_p2 instead.")
  (minor_axis_p2 m))

(cl:ensure-generic-function 'orientation-val :lambda-list '(m))
(cl:defmethod orientation-val ((m <AxisPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader corrosion_detector-msg:orientation-val is deprecated.  Use corrosion_detector-msg:orientation instead.")
  (orientation m))

(cl:ensure-generic-function 'major_axis_len-val :lambda-list '(m))
(cl:defmethod major_axis_len-val ((m <AxisPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader corrosion_detector-msg:major_axis_len-val is deprecated.  Use corrosion_detector-msg:major_axis_len instead.")
  (major_axis_len m))

(cl:ensure-generic-function 'minor_axis_len-val :lambda-list '(m))
(cl:defmethod minor_axis_len-val ((m <AxisPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader corrosion_detector-msg:minor_axis_len-val is deprecated.  Use corrosion_detector-msg:minor_axis_len instead.")
  (minor_axis_len m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AxisPoints>) ostream)
  "Serializes a message object of type '<AxisPoints>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'major_axis_p1) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'major_axis_p2) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'minor_axis_p1) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'minor_axis_p2) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'orientation))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'major_axis_len))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'minor_axis_len))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AxisPoints>) istream)
  "Deserializes a message object of type '<AxisPoints>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'major_axis_p1) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'major_axis_p2) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'minor_axis_p1) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'minor_axis_p2) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'orientation) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'major_axis_len) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'minor_axis_len) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AxisPoints>)))
  "Returns string type for a message object of type '<AxisPoints>"
  "corrosion_detector/AxisPoints")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AxisPoints)))
  "Returns string type for a message object of type 'AxisPoints"
  "corrosion_detector/AxisPoints")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AxisPoints>)))
  "Returns md5sum for a message object of type '<AxisPoints>"
  "c40b075900f16fe11733d8a1bb7afb1b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AxisPoints)))
  "Returns md5sum for a message object of type 'AxisPoints"
  "c40b075900f16fe11733d8a1bb7afb1b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AxisPoints>)))
  "Returns full string definition for message of type '<AxisPoints>"
  (cl:format cl:nil "std_msgs/Header header~%~%# List of 2D points~%geometry_msgs/Point major_axis_p1~%geometry_msgs/Point major_axis_p2~%geometry_msgs/Point minor_axis_p1~%geometry_msgs/Point minor_axis_p2~%~%# Orientation of the axis (yaw in radians)~%float64 orientation~%~%# Axis lenghts~%float64 major_axis_len~%float64 minor_axis_len~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AxisPoints)))
  "Returns full string definition for message of type 'AxisPoints"
  (cl:format cl:nil "std_msgs/Header header~%~%# List of 2D points~%geometry_msgs/Point major_axis_p1~%geometry_msgs/Point major_axis_p2~%geometry_msgs/Point minor_axis_p1~%geometry_msgs/Point minor_axis_p2~%~%# Orientation of the axis (yaw in radians)~%float64 orientation~%~%# Axis lenghts~%float64 major_axis_len~%float64 minor_axis_len~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AxisPoints>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'major_axis_p1))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'major_axis_p2))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'minor_axis_p1))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'minor_axis_p2))
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AxisPoints>))
  "Converts a ROS message object to a list"
  (cl:list 'AxisPoints
    (cl:cons ':header (header msg))
    (cl:cons ':major_axis_p1 (major_axis_p1 msg))
    (cl:cons ':major_axis_p2 (major_axis_p2 msg))
    (cl:cons ':minor_axis_p1 (minor_axis_p1 msg))
    (cl:cons ':minor_axis_p2 (minor_axis_p2 msg))
    (cl:cons ':orientation (orientation msg))
    (cl:cons ':major_axis_len (major_axis_len msg))
    (cl:cons ':minor_axis_len (minor_axis_len msg))
))
