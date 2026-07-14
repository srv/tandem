;; Auto-generated. Do not edit!


(when (boundp 'corrosion_detector::BoundingBox)
  (if (not (find-package "CORROSION_DETECTOR"))
    (make-package "CORROSION_DETECTOR"))
  (shadow 'BoundingBox (find-package "CORROSION_DETECTOR")))
(unless (find-package "CORROSION_DETECTOR::BOUNDINGBOX")
  (make-package "CORROSION_DETECTOR::BOUNDINGBOX"))

(in-package "ROS")
;;//! \htmlinclude BoundingBox.msg.html


(defclass corrosion_detector::BoundingBox
  :super ros::object
  :slots (_class_id _score _x _y _w _h _corr_x _corr_y _std_x _std_y _area _width _height ))

(defmethod corrosion_detector::BoundingBox
  (:init
   (&key
    ((:class_id __class_id) "")
    ((:score __score) 0.0)
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:w __w) 0.0)
    ((:h __h) 0.0)
    ((:corr_x __corr_x) 0.0)
    ((:corr_y __corr_y) 0.0)
    ((:std_x __std_x) 0.0)
    ((:std_y __std_y) 0.0)
    ((:area __area) 0.0)
    ((:width __width) 0)
    ((:height __height) 0)
    )
   (send-super :init)
   (setq _class_id (string __class_id))
   (setq _score (float __score))
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _w (float __w))
   (setq _h (float __h))
   (setq _corr_x (float __corr_x))
   (setq _corr_y (float __corr_y))
   (setq _std_x (float __std_x))
   (setq _std_y (float __std_y))
   (setq _area (float __area))
   (setq _width (round __width))
   (setq _height (round __height))
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
  (:w
   (&optional __w)
   (if __w (setq _w __w)) _w)
  (:h
   (&optional __h)
   (if __h (setq _h __h)) _h)
  (:corr_x
   (&optional __corr_x)
   (if __corr_x (setq _corr_x __corr_x)) _corr_x)
  (:corr_y
   (&optional __corr_y)
   (if __corr_y (setq _corr_y __corr_y)) _corr_y)
  (:std_x
   (&optional __std_x)
   (if __std_x (setq _std_x __std_x)) _std_x)
  (:std_y
   (&optional __std_y)
   (if __std_y (setq _std_y __std_y)) _std_y)
  (:area
   (&optional __area)
   (if __area (setq _area __area)) _area)
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:height
   (&optional __height)
   (if __height (setq _height __height)) _height)
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
    ;; float64 _w
    8
    ;; float64 _h
    8
    ;; float64 _corr_x
    8
    ;; float64 _corr_y
    8
    ;; float64 _std_x
    8
    ;; float64 _std_y
    8
    ;; float64 _area
    8
    ;; int16 _width
    2
    ;; int16 _height
    2
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
     ;; float64 _w
       (sys::poke _w (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _h
       (sys::poke _h (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _corr_x
       (sys::poke _corr_x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _corr_y
       (sys::poke _corr_y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _std_x
       (sys::poke _std_x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _std_y
       (sys::poke _std_y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _area
       (sys::poke _area (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; int16 _width
       (write-word _width s)
     ;; int16 _height
       (write-word _height s)
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
   ;; float64 _w
     (setq _w (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _h
     (setq _h (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _corr_x
     (setq _corr_x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _corr_y
     (setq _corr_y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _std_x
     (setq _std_x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _std_y
     (setq _std_y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _area
     (setq _area (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; int16 _width
     (setq _width (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _height
     (setq _height (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;;
   self)
  )

(setf (get corrosion_detector::BoundingBox :md5sum-) "ce1d7034235b18cb9d0c6436906febbb")
(setf (get corrosion_detector::BoundingBox :datatype-) "corrosion_detector/BoundingBox")
(setf (get corrosion_detector::BoundingBox :definition-)
      "string class_id      # \"0\", \"person\", etc.
float64 score        # Probabilidad (0.0 a 1.0)

# Coordenadas NORMALIZADAS (0.0 a 1.0)
# Es lo estándar en YOLO y facilita la vida al siguiente nodo
float64 x            # Centro X
float64 y            # Centro Y
float64 w            # Ancho
float64 h            # Alto

# Coordenades normalitzades del Punt de corrosió
float64 corr_x
float64 corr_y
float64 std_x
float64 std_y
float64 area
int16 width
int16 height

")



(provide :corrosion_detector/BoundingBox "ce1d7034235b18cb9d0c6436906febbb")


