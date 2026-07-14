;; Auto-generated. Do not edit!


(when (boundp 'corrosion_detector::Trigger)
  (if (not (find-package "CORROSION_DETECTOR"))
    (make-package "CORROSION_DETECTOR"))
  (shadow 'Trigger (find-package "CORROSION_DETECTOR")))
(unless (find-package "CORROSION_DETECTOR::TRIGGER")
  (make-package "CORROSION_DETECTOR::TRIGGER"))
(unless (find-package "CORROSION_DETECTOR::TRIGGERREQUEST")
  (make-package "CORROSION_DETECTOR::TRIGGERREQUEST"))
(unless (find-package "CORROSION_DETECTOR::TRIGGERRESPONSE")
  (make-package "CORROSION_DETECTOR::TRIGGERRESPONSE"))

(in-package "ROS")





(defclass corrosion_detector::TriggerRequest
  :super ros::object
  :slots ())

(defmethod corrosion_detector::TriggerRequest
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass corrosion_detector::TriggerResponse
  :super ros::object
  :slots (_success _message ))

(defmethod corrosion_detector::TriggerResponse
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

(defclass corrosion_detector::Trigger
  :super ros::object
  :slots ())

(setf (get corrosion_detector::Trigger :md5sum-) "937c9679a518e3a18d831e57125ea522")
(setf (get corrosion_detector::Trigger :datatype-) "corrosion_detector/Trigger")
(setf (get corrosion_detector::Trigger :request) corrosion_detector::TriggerRequest)
(setf (get corrosion_detector::Trigger :response) corrosion_detector::TriggerResponse)

(defmethod corrosion_detector::TriggerRequest
  (:response () (instance corrosion_detector::TriggerResponse :init)))

(setf (get corrosion_detector::TriggerRequest :md5sum-) "937c9679a518e3a18d831e57125ea522")
(setf (get corrosion_detector::TriggerRequest :datatype-) "corrosion_detector/TriggerRequest")
(setf (get corrosion_detector::TriggerRequest :definition-)
      "---
bool success   # indicate successful run of triggered service
string message # informational, e.g. for error messages
")

(setf (get corrosion_detector::TriggerResponse :md5sum-) "937c9679a518e3a18d831e57125ea522")
(setf (get corrosion_detector::TriggerResponse :datatype-) "corrosion_detector/TriggerResponse")
(setf (get corrosion_detector::TriggerResponse :definition-)
      "---
bool success   # indicate successful run of triggered service
string message # informational, e.g. for error messages
")



(provide :corrosion_detector/Trigger "937c9679a518e3a18d831e57125ea522")


