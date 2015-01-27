(cl:in-package #:sicl-hir-to-mir)

(cl:in-package #:sicl-hir-to-mir)

(defmethod cleavir-ir:specialize
    ((instruction cleavir-ir:read-cell-instruction)
     (implementation sicl-target-sicl:sicl)
     (processor cleavir-processor-x86-64:x86-64)
     os)
  (declare (ignore os))
  (let* ((successor (first (cleavir-ir:successors instruction)))
	 (cons (first (cleavir-ir:inputs instruction)))
	 (immediate (make-instance 'cleavir-ir:immediate-input :value -1)))
    (cleavir-ir:make-memref2-instruction cons immediate successor)))

(defmethod cleavir-ir:specialize
    ((instruction cleavir-ir:write-cell-instruction)
     (implementation sicl-target-sicl:sicl)
     (processor cleavir-processor-x86-64:x86-64)
     os)
  (declare (ignore os))
  (let* ((successor (first (cleavir-ir:successors instruction)))
	 (cons (first (cleavir-ir:inputs instruction)))
	 (object (second (cleavir-ir:inputs instruction)))
	 (immediate (make-instance 'cleavir-ir:immediate-input :value -1)))
    (cleavir-ir:make-memset2-instruction cons immediate object successor)))
