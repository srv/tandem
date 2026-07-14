
(cl:in-package :asdf)

(defsystem "corrosion_detector-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "AxisPoints" :depends-on ("_package_AxisPoints"))
    (:file "_package_AxisPoints" :depends-on ("_package"))
    (:file "BoundingBox" :depends-on ("_package_BoundingBox"))
    (:file "_package_BoundingBox" :depends-on ("_package"))
    (:file "BoundingBoxArray" :depends-on ("_package_BoundingBoxArray"))
    (:file "_package_BoundingBoxArray" :depends-on ("_package"))
    (:file "CoordinatesError" :depends-on ("_package_CoordinatesError"))
    (:file "_package_CoordinatesError" :depends-on ("_package"))
    (:file "Detection3D" :depends-on ("_package_Detection3D"))
    (:file "_package_Detection3D" :depends-on ("_package"))
    (:file "Detection3DArray" :depends-on ("_package_Detection3DArray"))
    (:file "_package_Detection3DArray" :depends-on ("_package"))
    (:file "NetStats" :depends-on ("_package_NetStats"))
    (:file "_package_NetStats" :depends-on ("_package"))
  ))