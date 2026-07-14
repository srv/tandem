;; Auto-generated. Do not edit!


(when (boundp 'corrosion_detector::CameraSelector)
  (if (not (find-package "CORROSION_DETECTOR"))
    (make-package "CORROSION_DETECTOR"))
  (shadow 'CameraSelector (find-package "CORROSION_DETECTOR")))
(unless (find-package "CORROSION_DETECTOR::CAMERASELECTOR")
  (make-package "CORROSION_DETECTOR::CAMERASELECTOR"))
(unless (find-package "CORROSION_DETECTOR::CAMERASELECTORREQUEST")
  (make-package "CORROSION_DETECTOR::CAMERASELECTORREQUEST"))
(unless (find-package "CORROSION_DETECTOR::CAMERASELECTORRESPONSE")
  (make-package "CORROSION_DETECTOR::CAMERASELECTORRESPONSE"))

(in-package "ROS")





(defclass corrosion_detector::CameraSelectorRequest
  :super ros::object
  :slots (_message ))

(defmethod corrosion_detector::CameraSelectorRequest
  (:init
   (&key
    ((:message __message) 0)
    )
   (send-super :init)
   (setq _message (round __message))
   self)
  (:message
   (&optional __message)
   (if __message (setq _message __message)) _message)
  (:serialization-length
   ()
   (+
    ;; int8 _message
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int8 _message
       (write-byte _message s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int8 _message
     (setq _message (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _message 127) (setq _message (- _message 256)))
   ;;
   self)
  )

(defclass corrosion_detector::CameraSelectorResponse
  :super ros::object
  :slots (_success _message ))

(defmethod corrosion_detector::CameraSelectorResponse
  (:init
   (&key
    ((:success __success) nil)
    ((:message __message) "")
    )
   (send-super :init)
   (setq _success __success)
   (setq _message (string __message))
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:message
   (&optional __message)
   (if __message (setq _message __message)) _message)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ;; string _message
    4 (length _message)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;; string _message
       (write-long (length _message) s) (princ _message s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _message
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _message (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass corrosion_detector::CameraSelector
  :super ros::object
  :slots ())

(setf (get corrosion_detector::CameraSelector :md5sum-) "1dd2bbcf551a47af8b1e8f3d1a8936e5")
(setf (get corrosion_detector::CameraSelector :datatype-) "corrosion_detector/CameraSelector")
(setf (get corrosion_detector::CameraSelector :request) corrosion_detector::CameraSelectorRequest)
(setf (get corrosion_detector::CameraSelector :response) corrosion_detector::CameraSelectorResponse)

(defmethod corrosion_detector::CameraSelectorRequest
  (:response () (instance corrosion_detector::CameraSelectorResponse :init)))

(setf (get corrosion_detector::CameraSelectorRequest :md5sum-) "1dd2bbcf551a47af8b1e8f3d1a8936e5")
(setf (get corrosion_detector::CameraSelectorRequest :datatype-) "corrosion_detector/CameraSelectorRequest")
(setf (get corrosion_detector::CameraSelectorRequest :definition-)
      "int8 message # camera id selected for processing
---
bool success   # indicate successful run of triggered service
string message # informational, e.g. for error messages
")

(setf (get corrosion_detector::CameraSelectorResponse :md5sum-) "1dd2bbcf551a47af8b1e8f3d1a8936e5")
(setf (get corrosion_detector::CameraSelectorResponse :datatype-) "corrosion_detector/CameraSelectorResponse")
(setf (get corrosion_detector::CameraSelectorResponse :definition-)
      "int8 message # camera id selected for processing
---
bool success   # indicate successful run of triggered service
string message # informational, e.g. for error messages
")



(provide :corrosion_detector/CameraSelector "1dd2bbcf551a47af8b1e8f3d1a8936e5")


