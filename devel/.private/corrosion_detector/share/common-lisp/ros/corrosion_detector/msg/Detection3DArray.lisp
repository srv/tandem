; Auto-generated. Do not edit!


(cl:in-package corrosion_detector-msg)


;//! \htmlinclude Detection3DArray.msg.html

(cl:defclass <Detection3DArray> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (detections
    :reader detections
    :initarg :detections
    :type (cl:vector corrosion_detector-msg:Detection3D)
   :initform (cl:make-array 0 :element-type 'corrosion_detector-msg:Detection3D :initial-element (cl:make-instance 'corrosion_detector-msg:Detection3D))))
)

(cl:defclass Detection3DArray (<Detection3DArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Detection3DArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Detection3DArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name corrosion_detector-msg:<Detection3DArray> is deprecated: use corrosion_detector-msg:Detection3DArray instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Detection3DArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader corrosion_detector-msg:header-val is deprecated.  Use corrosion_detector-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'detections-val :lambda-list '(m))
(cl:defmethod detections-val ((m <Detection3DArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader corrosion_detector-msg:detections-val is deprecated.  Use corrosion_detector-msg:detections instead.")
  (detections m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Detection3DArray>) ostream)
  "Serializes a message object of type '<Detection3DArray>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'detections))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'detections))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Detection3DArray>) istream)
  "Deserializes a message object of type '<Detection3DArray>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'detections) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'detections)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'corrosion_detector-msg:Detection3D))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Detection3DArray>)))
  "Returns string type for a message object of type '<Detection3DArray>"
  "corrosion_detector/Detection3DArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Detection3DArray)))
  "Returns string type for a message object of type 'Detection3DArray"
  "corrosion_detector/Detection3DArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Detection3DArray>)))
  "Returns md5sum for a message object of type '<Detection3DArray>"
  "f6614de60092c15ffd08b1a8bb5742ea")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Detection3DArray)))
  "Returns md5sum for a message object of type 'Detection3DArray"
  "f6614de60092c15ffd08b1a8bb5742ea")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Detection3DArray>)))
  "Returns full string definition for message of type '<Detection3DArray>"
  (cl:format cl:nil "Header header~%Detection3D[] detections~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: corrosion_detector/Detection3D~%string class_id~%float64 score~%float64 x  # Metros~%float64 y  # Metros~%float64 z  # Metros~%float64 width~%float64 height~%float64 area_px~%float64 area_real~%bool is_corrosion # Valor en bool per a poder distingir entre cas de corrosio i de xarxa~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Detection3DArray)))
  "Returns full string definition for message of type 'Detection3DArray"
  (cl:format cl:nil "Header header~%Detection3D[] detections~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: corrosion_detector/Detection3D~%string class_id~%float64 score~%float64 x  # Metros~%float64 y  # Metros~%float64 z  # Metros~%float64 width~%float64 height~%float64 area_px~%float64 area_real~%bool is_corrosion # Valor en bool per a poder distingir entre cas de corrosio i de xarxa~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Detection3DArray>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'detections) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Detection3DArray>))
  "Converts a ROS message object to a list"
  (cl:list 'Detection3DArray
    (cl:cons ':header (header msg))
    (cl:cons ':detections (detections msg))
))
