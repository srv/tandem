; Auto-generated. Do not edit!


(cl:in-package corrosion_detector-msg)


;//! \htmlinclude CoordinatesError.msg.html

(cl:defclass <CoordinatesError> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (x_err
    :reader x_err
    :initarg :x_err
    :type cl:float
    :initform 0.0)
   (y_err
    :reader y_err
    :initarg :y_err
    :type cl:float
    :initform 0.0)
   (z_err
    :reader z_err
    :initarg :z_err
    :type cl:float
    :initform 0.0)
   (total_error
    :reader total_error
    :initarg :total_error
    :type cl:float
    :initform 0.0))
)

(cl:defclass CoordinatesError (<CoordinatesError>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CoordinatesError>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CoordinatesError)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name corrosion_detector-msg:<CoordinatesError> is deprecated: use corrosion_detector-msg:CoordinatesError instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <CoordinatesError>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader corrosion_detector-msg:header-val is deprecated.  Use corrosion_detector-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'x_err-val :lambda-list '(m))
(cl:defmethod x_err-val ((m <CoordinatesError>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader corrosion_detector-msg:x_err-val is deprecated.  Use corrosion_detector-msg:x_err instead.")
  (x_err m))

(cl:ensure-generic-function 'y_err-val :lambda-list '(m))
(cl:defmethod y_err-val ((m <CoordinatesError>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader corrosion_detector-msg:y_err-val is deprecated.  Use corrosion_detector-msg:y_err instead.")
  (y_err m))

(cl:ensure-generic-function 'z_err-val :lambda-list '(m))
(cl:defmethod z_err-val ((m <CoordinatesError>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader corrosion_detector-msg:z_err-val is deprecated.  Use corrosion_detector-msg:z_err instead.")
  (z_err m))

(cl:ensure-generic-function 'total_error-val :lambda-list '(m))
(cl:defmethod total_error-val ((m <CoordinatesError>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader corrosion_detector-msg:total_error-val is deprecated.  Use corrosion_detector-msg:total_error instead.")
  (total_error m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CoordinatesError>) ostream)
  "Serializes a message object of type '<CoordinatesError>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'x_err))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'y_err))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'z_err))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'total_error))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CoordinatesError>) istream)
  "Deserializes a message object of type '<CoordinatesError>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x_err) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y_err) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'z_err) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'total_error) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CoordinatesError>)))
  "Returns string type for a message object of type '<CoordinatesError>"
  "corrosion_detector/CoordinatesError")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CoordinatesError)))
  "Returns string type for a message object of type 'CoordinatesError"
  "corrosion_detector/CoordinatesError")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CoordinatesError>)))
  "Returns md5sum for a message object of type '<CoordinatesError>"
  "f51f162e146a2cd618e4c2bc2935431c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CoordinatesError)))
  "Returns md5sum for a message object of type 'CoordinatesError"
  "f51f162e146a2cd618e4c2bc2935431c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CoordinatesError>)))
  "Returns full string definition for message of type '<CoordinatesError>"
  (cl:format cl:nil "std_msgs/Header header~%~%# Coordenadas del error (posicion ground_truth - posicion calculada)~%float64 x_err ~%float64 y_err~%float64 z_err~%~%# Distancia euclídea entre los 2 puntos en 3 dimensiones~%float64 total_error~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CoordinatesError)))
  "Returns full string definition for message of type 'CoordinatesError"
  (cl:format cl:nil "std_msgs/Header header~%~%# Coordenadas del error (posicion ground_truth - posicion calculada)~%float64 x_err ~%float64 y_err~%float64 z_err~%~%# Distancia euclídea entre los 2 puntos en 3 dimensiones~%float64 total_error~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CoordinatesError>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     8
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CoordinatesError>))
  "Converts a ROS message object to a list"
  (cl:list 'CoordinatesError
    (cl:cons ':header (header msg))
    (cl:cons ':x_err (x_err msg))
    (cl:cons ':y_err (y_err msg))
    (cl:cons ':z_err (z_err msg))
    (cl:cons ':total_error (total_error msg))
))
