; Auto-generated. Do not edit!


(cl:in-package corrosion_detector-srv)


;//! \htmlinclude CameraSelector-request.msg.html

(cl:defclass <CameraSelector-request> (roslisp-msg-protocol:ros-message)
  ((message
    :reader message
    :initarg :message
    :type cl:fixnum
    :initform 0))
)

(cl:defclass CameraSelector-request (<CameraSelector-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CameraSelector-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CameraSelector-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name corrosion_detector-srv:<CameraSelector-request> is deprecated: use corrosion_detector-srv:CameraSelector-request instead.")))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <CameraSelector-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader corrosion_detector-srv:message-val is deprecated.  Use corrosion_detector-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CameraSelector-request>) ostream)
  "Serializes a message object of type '<CameraSelector-request>"
  (cl:let* ((signed (cl:slot-value msg 'message)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CameraSelector-request>) istream)
  "Deserializes a message object of type '<CameraSelector-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'message) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CameraSelector-request>)))
  "Returns string type for a service object of type '<CameraSelector-request>"
  "corrosion_detector/CameraSelectorRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CameraSelector-request)))
  "Returns string type for a service object of type 'CameraSelector-request"
  "corrosion_detector/CameraSelectorRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CameraSelector-request>)))
  "Returns md5sum for a message object of type '<CameraSelector-request>"
  "1dd2bbcf551a47af8b1e8f3d1a8936e5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CameraSelector-request)))
  "Returns md5sum for a message object of type 'CameraSelector-request"
  "1dd2bbcf551a47af8b1e8f3d1a8936e5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CameraSelector-request>)))
  "Returns full string definition for message of type '<CameraSelector-request>"
  (cl:format cl:nil "int8 message # camera id selected for processing~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CameraSelector-request)))
  "Returns full string definition for message of type 'CameraSelector-request"
  (cl:format cl:nil "int8 message # camera id selected for processing~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CameraSelector-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CameraSelector-request>))
  "Converts a ROS message object to a list"
  (cl:list 'CameraSelector-request
    (cl:cons ':message (message msg))
))
;//! \htmlinclude CameraSelector-response.msg.html

(cl:defclass <CameraSelector-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil)
   (message
    :reader message
    :initarg :message
    :type cl:string
    :initform ""))
)

(cl:defclass CameraSelector-response (<CameraSelector-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CameraSelector-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CameraSelector-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name corrosion_detector-srv:<CameraSelector-response> is deprecated: use corrosion_detector-srv:CameraSelector-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <CameraSelector-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader corrosion_detector-srv:success-val is deprecated.  Use corrosion_detector-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <CameraSelector-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader corrosion_detector-srv:message-val is deprecated.  Use corrosion_detector-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CameraSelector-response>) ostream)
  "Serializes a message object of type '<CameraSelector-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CameraSelector-response>) istream)
  "Deserializes a message object of type '<CameraSelector-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'message) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'message) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CameraSelector-response>)))
  "Returns string type for a service object of type '<CameraSelector-response>"
  "corrosion_detector/CameraSelectorResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CameraSelector-response)))
  "Returns string type for a service object of type 'CameraSelector-response"
  "corrosion_detector/CameraSelectorResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CameraSelector-response>)))
  "Returns md5sum for a message object of type '<CameraSelector-response>"
  "1dd2bbcf551a47af8b1e8f3d1a8936e5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CameraSelector-response)))
  "Returns md5sum for a message object of type 'CameraSelector-response"
  "1dd2bbcf551a47af8b1e8f3d1a8936e5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CameraSelector-response>)))
  "Returns full string definition for message of type '<CameraSelector-response>"
  (cl:format cl:nil "bool success   # indicate successful run of triggered service~%string message # informational, e.g. for error messages~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CameraSelector-response)))
  "Returns full string definition for message of type 'CameraSelector-response"
  (cl:format cl:nil "bool success   # indicate successful run of triggered service~%string message # informational, e.g. for error messages~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CameraSelector-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CameraSelector-response>))
  "Converts a ROS message object to a list"
  (cl:list 'CameraSelector-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'CameraSelector)))
  'CameraSelector-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'CameraSelector)))
  'CameraSelector-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CameraSelector)))
  "Returns string type for a service object of type '<CameraSelector>"
  "corrosion_detector/CameraSelector")