(cl:in-package #:cleavir-meter)

(defgeneric reset (meter)
  (:method-combination progn))

(defgeneric report (meter &optional stream)
  (:method-combination progn :most-specific-last))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Class METER.
;;;
;;; This is the base class of all meters.

(defclass meter () ())

(defmethod reset progn ((meter meter))
  nil)

(defmethod report progn ((meter meter) &optional stream)
  (declare (ignore stream)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Class BASIC-METER.
;;;
;;; A meter class that counts the number of invocations and measures
;;; the total CPU time for the invocations.

(defclass basic-meter (meter)
  ((%cpu-time :initform 0 :accessor cpu-time)
   (%invocation-count :initform 0 :accessor invocation-count)))

(defmethod reset progn ((meter basic-meter))
  (setf (cpu-time meter) 0)
  (setf (invocation-count meter) 0))