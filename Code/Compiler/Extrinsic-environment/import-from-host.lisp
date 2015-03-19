(cl:in-package #:sicl-extrinsic-environment)

(defun import-from-host (environment)
  ;; Import available packages in the host to ENVIRONMENT.
  (setf (sicl-env:packages environment)
	(list-all-packages))
  (do-all-symbols (symbol)
    ;; Import available functions in the host to ENVIRONMENT.
    (when (and (fboundp symbol)
	       (not (special-operator-p symbol))
	       (null (macro-function symbol)))
      (setf (sicl-global-environment:fdefinition symbol environment)
	    (fdefinition symbol)))
    (when (fboundp `(setf ,symbol))
      (setf (sicl-global-environment:fdefinition `(setf ,symbol) environment)
	    (fdefinition `(setf ,symbol))))
    ;; Import all constant variables in the host to ENVIRONMENT.
    (when (constantp symbol)
      (setf (sicl-global-environment:constant-variable symbol environment)
	    (cl:symbol-value symbol)))))