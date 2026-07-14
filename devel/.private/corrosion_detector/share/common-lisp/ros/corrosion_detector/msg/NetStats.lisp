; Auto-generated. Do not edit!


(cl:in-package corrosion_detector-msg)


;//! \htmlinclude NetStats.msg.html

(cl:defclass <NetStats> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (scale_m_per_px
    :reader scale_m_per_px
    :initarg :scale_m_per_px
    :type cl:float
    :initform 0.0)
   (median_hole_area_px
    :reader median_hole_area_px
    :initarg :median_hole_area_px
    :type cl:float
    :initform 0.0)
   (median_hole_area_m2
    :reader median_hole_area_m2
    :initarg :median_hole_area_m2
    :type cl:float
    :initform 0.0))
)

(cl:defclass NetStats (<NetStats>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <NetStats>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'NetStats)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name corrosion_detector-msg:<NetStats> is deprecated: use corrosion_detector-msg:NetStats instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <NetStats>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader corrosion_detector-msg:header-val is deprecated.  Use corrosion_detector-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'scale_m_per_px-val :lambda-list '(m))
(cl:defmethod scale_m_per_px-val ((m <NetStats>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader corrosion_detector-msg:scale_m_per_px-val is deprecated.  Use corrosion_detector-msg:scale_m_per_px instead.")
  (scale_m_per_px m))

(cl:ensure-generic-function 'median_hole_area_px-val :lambda-list '(m))
(cl:defmethod median_hole_area_px-val ((m <NetStats>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader corrosion_detector-msg:median_hole_area_px-val is deprecated.  Use corrosion_detector-msg:median_hole_area_px instead.")
  (median_hole_area_px m))

(cl:ensure-generic-function 'median_hole_area_m2-val :lambda-list '(m))
(cl:defmethod median_hole_area_m2-val ((m <NetStats>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader corrosion_detector-msg:median_hole_area_m2-val is deprecated.  Use corrosion_detector-msg:median_hole_area_m2 instead.")
  (median_hole_area_m2 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <NetStats>) ostream)
  "Serializes a message object of type '<NetStats>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'scale_m_per_px))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'median_hole_area_px))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'median_hole_area_m2))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <NetStats>) istream)
  "Deserializes a message object of type '<NetStats>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'scale_m_per_px) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'median_hole_area_px) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'median_hole_area_m2) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<NetStats>)))
  "Returns string type for a message object of type '<NetStats>"
  "corrosion_detector/NetStats")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'NetStats)))
  "Returns string type for a message object of type 'NetStats"
  "corrosion_detector/NetStats")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<NetStats>)))
  "Returns md5sum for a message object of type '<NetStats>"
  "f0b14b7f5d4cea4e0f0d1ef78c891d2e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'NetStats)))
  "Returns md5sum for a message object of type 'NetStats"
  "f0b14b7f5d4cea4e0f0d1ef78c891d2e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<NetStats>)))
  "Returns full string definition for message of type '<NetStats>"
  (cl:format cl:nil "Header header~%~%# Escala calculada (metros/pixel)~%float32 scale_m_per_px~%~%# Área mediana de los hexágonos (en píxeles cuadrados)~%float32 median_hole_area_px~%~%# (Opcional) Área mediana en metros cuadrados (por si la quiere directa)~%float32 median_hole_area_m2~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'NetStats)))
  "Returns full string definition for message of type 'NetStats"
  (cl:format cl:nil "Header header~%~%# Escala calculada (metros/pixel)~%float32 scale_m_per_px~%~%# Área mediana de los hexágonos (en píxeles cuadrados)~%float32 median_hole_area_px~%~%# (Opcional) Área mediana en metros cuadrados (por si la quiere directa)~%float32 median_hole_area_m2~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <NetStats>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <NetStats>))
  "Converts a ROS message object to a list"
  (cl:list 'NetStats
    (cl:cons ':header (header msg))
    (cl:cons ':scale_m_per_px (scale_m_per_px msg))
    (cl:cons ':median_hole_area_px (median_hole_area_px msg))
    (cl:cons ':median_hole_area_m2 (median_hole_area_m2 msg))
))
