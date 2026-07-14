
(cl:in-package :asdf)

(defsystem "corrosion_detector-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "CameraSelector" :depends-on ("_package_CameraSelector"))
    (:file "_package_CameraSelector" :depends-on ("_package"))
    (:file "Trigger" :depends-on ("_package_Trigger"))
    (:file "_package_Trigger" :depends-on ("_package"))
  ))