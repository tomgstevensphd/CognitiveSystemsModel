
;;THIS HANGS UP LISP SYSTEM
;; (setf *return-combos (my-random-selection *all-elmsym-3combos 10))

;;;SSSS START HERE, PROBLEM WITH MAKE-COMBOS--MAKES ALL POSSIBLE 3 PERMUTATIONS OF THE BASIC LIST.  EG.  (1 2 3) and (2 1 3) and (3 2 1) when I only need (1 2 3)

;; (list-length *all-elmsym-3combos) = 30856
(defparameter *all-elmsym-3combos