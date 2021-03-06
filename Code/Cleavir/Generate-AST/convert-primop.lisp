(cl:in-package #:cleavir-generate-ast)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:EQ.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:eq)) form env system)
  (db origin (op arg1 arg2) form
    (declare (ignore op))
    (cleavir-ast:make-eq-ast
     (convert arg1 env system)
     (convert arg2 env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:TYPEQ.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:typeq)) form env system)
  (db origin (op arg1 arg2) form
    (declare (ignore op))
    (cleavir-ast:make-typeq-ast
     (convert arg1 env system)
     arg2)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:CAR.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:car)) form env system)
  (db origin (op arg) form
    (declare (ignore op))
    (cleavir-ast:make-car-ast (convert arg env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:CDR.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:cdr)) form env system)
  (db origin (op arg) form
    (declare (ignore op))
    (cleavir-ast:make-cdr-ast (convert arg env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:RPLACA.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:rplaca)) form env system)
  (db origin (op arg1 arg2) form
    (declare (ignore op))
    (cleavir-ast:make-rplaca-ast (convert arg1 env system)
				 (convert arg2 env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:RPLACD.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:rplacd)) form env system)
  (db origin (op arg1 arg2) form
    (declare (ignore op))
    (cleavir-ast:make-rplacd-ast (convert arg1 env system)
				 (convert arg2 env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FIXNUM-ARITHMETIC.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:fixnum-arithmetic)) form env system)
  (cleavir-code-utilities:check-form-proper-list form)
  (cleavir-code-utilities:check-argcount form 4 4)
  (destructuring-bind (variable operation normal overflow) (cdr form)
    (assert (symbolp variable))
    (let ((new-env (cleavir-env:add-lexical-variable env variable)))
      (cleavir-ast:make-if-ast (convert operation new-env system)
			       (convert normal new-env system)
			       (convert overflow new-env system)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FIXNUM-+.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:fixnum-+)) form env system)
  (db origin (op arg1 arg2 variable) form
    (declare (ignore op))
    (cleavir-ast:make-fixnum-add-ast (convert arg1 env system)
				     (convert arg2 env system)
				     (convert variable env system))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FIXNUM--.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:fixnum--)) form env system)
  (db origin (op arg1 arg2 variable) form
    (declare (ignore op))
    (cleavir-ast:make-fixnum-sub-ast (convert arg1 env system)
				     (convert arg2 env system)
				     (convert variable env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FIXNUM-<.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:fixnum-<)) form env system)
  (destructuring-bind (arg1 arg2) (cdr form)
    (make-instance 'cleavir-ast:fixnum-less-ast
      :arg1-ast (convert arg1 env system)
      :arg2-ast (convert arg2 env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FIXNUM-<=.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:fixnum-<=)) form env system)
  (destructuring-bind (arg1 arg2) (cdr form)
    (make-instance 'cleavir-ast:fixnum-not-greater-ast
      :arg1-ast (convert arg1 env system)
      :arg2-ast (convert arg2 env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FIXNUM->.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:fixnum->)) form env system)
  (destructuring-bind (arg1 arg2) (cdr form)
    (make-instance 'cleavir-ast:fixnum-greater-ast
      :arg1-ast (convert arg1 env system)
      :arg2-ast (convert arg2 env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FIXNUM->=.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:fixnum->=)) form env system)
  (destructuring-bind (arg1 arg2) (cdr form)
    (make-instance 'cleavir-ast:fixnum-not-less-ast
      :arg1-ast (convert arg1 env system)
      :arg2-ast (convert arg2 env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FIXNUM-=.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:fixnum-=)) form env system)
  (destructuring-bind (arg1 arg2) (cdr form)
    (make-instance 'cleavir-ast:fixnum-equal-ast
      :arg1-ast (convert arg1 env system)
      :arg2-ast (convert arg2 env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FIXNUM-ADD.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:fixnum-add)) form env system)
  (db origin (op arg1 arg2 variable) form
    (declare (ignore op))
    (cleavir-ast:make-fixnum-add-ast (convert arg1 env system)
				     (convert arg2 env system)
				     (convert variable env system))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FIXNUM-SUB.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:fixnum-sub)) form env system)
  (db origin (op arg1 arg2 variable) form
    (declare (ignore op))
    (cleavir-ast:make-fixnum-sub-ast (convert arg1 env system)
				     (convert arg2 env system)
				     (convert variable env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FIXNUM-LESS.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:fixnum-less)) form env system)
  (destructuring-bind (arg1 arg2) (cdr form)
    (make-instance 'cleavir-ast:fixnum-less-ast
      :arg1-ast (convert arg1 env system)
      :arg2-ast (convert arg2 env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FIXNUM-NOT-GREATER.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:fixnum-<=)) form env system)
  (destructuring-bind (arg1 arg2) (cdr form)
    (make-instance 'cleavir-ast:fixnum-not-greater-ast
      :arg1-ast (convert arg1 env system)
      :arg2-ast (convert arg2 env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FIXNUM-GREATER.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:fixnum-GREATER)) form env system)
  (destructuring-bind (arg1 arg2) (cdr form)
    (make-instance 'cleavir-ast:fixnum-greater-ast
      :arg1-ast (convert arg1 env system)
      :arg2-ast (convert arg2 env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FIXNUM-NOT-LESS.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:fixnum-not-less)) form env system)
  (destructuring-bind (arg1 arg2) (cdr form)
    (make-instance 'cleavir-ast:fixnum-not-less-ast
      :arg1-ast (convert arg1 env system)
      :arg2-ast (convert arg2 env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FIXNUM-EQUAL.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:fixnum-equal)) form env system)
  (destructuring-bind (arg1 arg2) (cdr form)
    (make-instance 'cleavir-ast:fixnum-equal-ast
      :arg1-ast (convert arg1 env system)
      :arg2-ast (convert arg2 env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:LET-UNINITIALIZED.
;;;
;;; A form using the operator LET-UNINITIALIZED has the following
;;; syntax:
;;;
;;; (CLEAVIR-PRIMOP:LET-UNINITIALIZED (var*) form*)
;;;
;;; It sole purpose is to create a lexical environment for the
;;; variables in which the forms are evaluated.  An absolute
;;; requirement is that the variables must be assigned to before they
;;; are used in the forms, or else things will fail spectacularly.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:let-uninitialized)) form env system)
  (destructuring-bind (variables &rest body) (rest form)
    (let ((new-env env))
      (loop for variable in variables
	    for variable-ast = (cleavir-ast:make-lexical-ast variable)
	    do (setf new-env
		     (cleavir-env:add-lexical-variable
		      new-env variable variable-ast)))
      (process-progn (convert-sequence body new-env system)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:SHORT-FLOAT-ADD.
;;;
;;; This primitive operation is used in the implementation of the
;;; Common Lisp function +.  It takes two arguments, both forms that
;;; must evaluate to short floats.
;;;
;;; The value of a form with this operator is a short float
;;; representing the sum of the two arguments.
;;;
;;; If the result of the operation is greater than the value of the
;;; constant variable MOST-POSITIVE-SHORT-FLOAT, then an error of type
;;; FLOATING-POINT-OVERFLOW is signaled.
;;;
;;; If the result of the operation is less than the value of the
;;; constant variable MOST-NEGATIVE-SHORT-FLOAT, then an error of
;;; type FLOATING-POINT-UNDERFLOW is signaled.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:short-float-add)) form env system)
  (db origin (op arg1 arg2) form
    (declare (ignore op))
    (make-instance 'cleavir-ast:short-float-add-ast
      :arg1-ast (convert arg1 env system)
      :arg2-ast (convert arg2 env system)
      :origin origin)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:SHORT-FLOAT-SUB.
;;;
;;; This primitive operation is used in the implementation of the
;;; Common Lisp function -.  It takes two arguments, both forms that
;;; must evaluate to short floats.
;;;
;;; The value of a form with this operator is a short float
;;; representing the difference between the two arguments.
;;;
;;; If the result of the operation is greater than the value of the
;;; constant variable MOST-POSITIVE-SHORT-FLOAT, then an error of type
;;; FLOATING-POINT-OVERFLOW is signaled.
;;;
;;; If the result of the operation is less than the value of the
;;; constant variable MOST-NEGATIVE-SHORT-FLOAT, then an error of
;;; type FLOATING-POINT-UNDERFLOW is signaled.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:short-float-sub)) form env system)
  (db origin (op arg1 arg2) form
    (declare (ignore op))
    (make-instance 'cleavir-ast:short-float-sub-ast
      :arg1-ast (convert arg1 env system)
      :arg2-ast (convert arg2 env system)
      :origin origin)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:SHORT-FLOAT-MUL.
;;;
;;; This primitive operation is used in the implementation of the
;;; Common Lisp function *.  It takes two arguments, both forms that
;;; must evaluate to short floats.
;;;
;;; The value of a form with this operator is a short float
;;; representing the product of the two arguments.
;;;
;;; If the result of the operation is greater than the value of the
;;; constant variable MOST-POSITIVE-SHORT-FLOAT, then an error of type
;;; FLOATING-POINT-OVERFLOW is signaled.
;;;
;;; If the result of the operation is less than the value of the
;;; constant variable MOST-NEGATIVE-SHORT-FLOAT, then an error of
;;; type FLOATING-POINT-UNDERFLOW is signaled.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:short-float-mul)) form env system)
  (db origin (op arg1 arg2) form
    (declare (ignore op))
    (make-instance 'cleavir-ast:short-float-mul-ast
      :arg1-ast (convert arg1 env system)
      :arg2-ast (convert arg2 env system)
      :origin origin)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:SHORT-FLOAT-DIV.
;;;
;;; This primitive operation is used in the implementation of the
;;; Common Lisp function /.  It takes two arguments, both forms that
;;; must evaluate to short floats.
;;;
;;; The value of a form with this operator is a short float
;;; representing the quotient of the two arguments.
;;;
;;; If the result of the operation is greater than the value of the
;;; constant variable MOST-POSITIVE-SHORT-FLOAT, then an error of type
;;; FLOATING-POINT-OVERFLOW is signaled.
;;;
;;; If the result of the operation is less than the value of the
;;; constant variable MOST-NEGATIVE-SHORT-FLOAT, then an error of
;;; type FLOATING-POINT-UNDERFLOW is signaled.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:short-float-div)) form env system)
  (db origin (op arg1 arg2) form
    (declare (ignore op))
    (make-instance 'cleavir-ast:short-float-div-ast
      :arg1-ast (convert arg1 env system)
      :arg2-ast (convert arg2 env system)
      :origin origin)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:SHORT-FLOAT-LESS.
;;;
;;; This primitive operation is used in the implementation of the
;;; Common Lisp function <.  It takes two arguments, both forms that
;;; must evaluate to short floats.  It can only appear as the
;;; TEST-FORM in the special form IF.
;;;
;;; The value of a form with this operator is a short float
;;; representing the quotient of the two arguments.
;;;
;;; If the first argument is strictly less than the second argument,
;;; then the THEN branch of the IF form is evaluated.  Otherwise, the
;;; ELSE branch of the IF form is evaluated.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:short-float-less)) form env system)
  (db origin (op arg1 arg2) form
    (declare (ignore op))
    (make-instance 'cleavir-ast:short-float-less-ast
      :arg1-ast (convert arg1 env system)
      :arg2-ast (convert arg2 env system)
      :origin origin)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FUNCALL.
;;;
;;; This primop is similar to the function CL:FUNCALL.  The difference
;;; is that the primop does not allow function NAMES as its first
;;; argument.  It has to be a form that evaluates to a function.
;;;
;;; In order to inline CL:FUNCALL, a possible strategy would be to
;;; define a compiler macro on that function that expands to a form
;;; that turns the first argument into a function if it is not already
;;; a function and then calls this primop.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:funcall)) form env system)
  (destructuring-bind (function-form . argument-forms) (rest form)
    (cleavir-ast:make-call-ast
     (convert function-form env system)
     (loop for argument-form in argument-forms
	   collect (convert argument-form env system)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:SLOT-READ.
;;;
;;; This primop takes two arguments.  The first argument is a form
;;; that must evaluate to a standard instance.  The second argument is
;;; a form that must evaluate to a fixnum and that indicates the slot
;;; number to be read.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:slot-read)) form env system)
  (destructuring-bind (instance-form slot-number-form) (rest form)
    (cleavir-ast:make-slot-read-ast
     (convert instance-form env system)
     (convert slot-number-form env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:SLOT-WRITE.
;;;
;;; This primop takes three arguments.  The first argument is a form
;;; that must evaluate to a standard instance.  The second argument is
;;; a form that must evaluate to a fixnum and that indicates the slot
;;; number to be written.  The third argument is a form that evaluates
;;; to the object that will be written to the slot.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:slot-write)) form env system)
  (destructuring-bind (instance-form slot-number-form value-form) (rest form)
    (cleavir-ast:make-slot-write-ast
     (convert instance-form env system)
     (convert slot-number-form env system)
     (convert value-form env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:AREF.
;;;
;;; This primop takes five arguments. The first and second are an
;;; array and an index into it, as forms. The remainder of the
;;; arguments are not evaluated. The third is the actual element
;;; type of the array. The fourth is whether the array is actually
;;; simple. The fifth is whether the value in the array is already
;;; boxed.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:aref)) form env system)
  (db origin (array-form index-form type simple-p boxed-p)
      (rest form)
    (make-instance 'cleavir-ast:aref-ast
      :array-ast (convert array-form env system)
      :index-ast (convert index-form env system)
      :element-type type
      :simple-p simple-p
      :boxed-p boxed-p
      :origin origin)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:ASET.
;;;
;;; This primop takes six arguments. The first two are an array and
;;; an index into it. The third is the object to be written in. The
;;; fourth and fifth are as above. The sixth is whether the objects
;;; in the array are boxed.
;;;
;;; Forms using this primitive operation must occur in a context
;;; that does not require a value, such as in a PROGN other than as
;;; the last form.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:aset)) form env system)
  (db origin (array-form index-form object-form
			 type simple-p boxed-p)
      (rest form)
    (make-instance 'cleavir-ast:aset-ast
      :array-ast (convert array-form env system)
      :index-ast (convert index-form env system)
      :element-ast (convert object-form env system)
      :element-type type
      :simple-p simple-p
      :boxed-p boxed-p
      :origin origin)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:VALUES.
;;;
;;; This primitive operation can be used to inline CL:VALUES.
;;; That is, (cl:values ...) and (cleavir-primop:values ...) are
;;;  equivalent. The difference is that CL:VALUES is a function.
;;; This will compile down into a FIXED-TO-MULTIPLE-INSTRUCTION.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:values)) form env system)
  (db origin (op . arguments) form
    (declare (ignore op))
    (make-instance 'cleavir-ast:values-ast
     :argument-asts (mapcar
		     (lambda (form) (convert form env system))
		     arguments)
     :origin origin)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:UNREACHABLE.
;;;
;;; Indicates that execution of the form should be impossible.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:unreachable)) form env system)
  (declare (ignore form env system))
  ;; should have :origin, i guess?
  (make-instance 'cleavir-ast:unreachable-ast))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:AST.
;;;
;;; This allows ASTs produced by other means to be inserted into
;;; code which is then converted again.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:ast)) form env system)
  (declare (ignore env system))
  (db origin (ast) (rest form) ast))
