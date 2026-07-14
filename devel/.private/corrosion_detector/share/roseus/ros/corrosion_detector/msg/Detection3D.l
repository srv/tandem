;; Auto-generated. Do not edit!


(when (boundp 'corrosion_detector::Detection3D)
  (if (not (find-package "CORROSION_DETECTOR"))
    (make-package "CORROSION_DETECTOR"))
  (shadow 'Detection3D (find-package "CORROSION_DETECTOR")))
(unless (find-package "CORROSION_DETECTOR::DETECTION3D")
  (make-package "CORROSION_DETECTOR::DETECTION3D"))

(in-package "ROS")
;;//! \htmlinclude Detection3D.msg.html


(defclass corrosion_detector::Detection3D
  :super ros::object
  :slots (_class_id _score _x _y _z _width _height _area_px _area_real _is_corrosion ))

(defmethod corrosion_detector::Detection3D
  (:init
   (&key
    ((:class_id __class_id) "")
    ((:score __score) 0.0)
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:z __z) 0.0)
    ((:width __width) 0.0)
    ((:height __height) 0.0)
    ((:area_px __area_px) 0.0)
    ((:area_real __area_real) 0.0)
    ((:is_corrosion __is_corrosion) nil)
    )
   (send-super :init)
   (setq _class_id (string __class_id))
   (setq _score (float __score))
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _z (float __z))
   (setq _width (float __width))
   (setq _height (float __height))
   (setq _area_px (float __area_px))
   (setq _area_real (float __area_real))
   (setq _is_corrosion __is_corrosion)
   self)
  (:class_id
   (&optional __class_id)
   (if __class_id (setq _class_id __class_id)) _class_id)
  (:score
   (&optional __score)
   (if __score (setq _score __score)) _score)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:z
   (&optional __z)
   (if __z (setq _z __z)) _z)
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:height
   (&optional __height)
   (if __height (setq _height __height)) _height)
  (:area_px
   (&optional __area_px)
   (if __area_px (setq _area_px __area_px)) _area_px)
  (:area_real
   (&optional __area_real)
   (if __area_real (setq _area_real __area_real)) _area_real)
  (:is_corrosion
   (&optional (__is_corrosion :null))
   (if (not (eq __is_corrosion :null)) (setq _is_corrosion __is_corrosion)) _is_corrosion)
  (:serialization-length
   ()
   (+
    ;; string _class_id
    4 (length _class_id)
    ;; float64 _score
    8
    ;; float64 _x
    8
    ;; float64 _y
    8
    ;; float64 _z
    8
    ;; float64 _width
    8
    ;; float64 _height
    8
    ;; float64 _area_px
    8
    ;; float64 _area_real
    8
    ;; bool _is_corrosion
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _class_id
       (write-long (length _class_id) s) (princ _class_id s)
     ;; float64 _score
       (sys::poke _score (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _x
       (sys::poke _x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y
       (sys::poke _y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _z
       (sys::poke _z (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _width
       (sys::poke _width (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _height
       (sys::poke _height (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _area_px
       (sys::poke _area_px (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _area_real
       (sys::poke _area_real (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; bool _is_corrosion
       (if _is_corrosion (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _class_id
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _class_id (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float64 _score
     (setq _score (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _x
     (setq _x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y
     (setq _y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _z
     (setq _z (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _width
     (setq _width (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _height
     (setq _height (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _area_px
     (setq _area_px (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _area_real
     (setq _area_real (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; bool _is_corrosion
     (setq _is_corrosion (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get corrosion_detector::Detection3D :md5sum-) "b60e816205b8d91f0f0e4b9f112e2720")
(setf (get corrosion_detector::Detection3D :datatype-) "corrosion_detector/Detection3D")
(setf (get corrosion_detector::Detection3D :definition-)
      "string class_id
float64 score
float64 x  # Metros
float64 y  # Metros
float64 z  # Metros
float64 width
float64 height
float64 area_px
float64 area_real
bool is_corrosion # Valor en bool per a poder distingir entre cas de corrosio i de xarxa
")



(provide :corrosion_detector/Detection3D "b60e816205b8d91f0f0e4b9f112e2720")


