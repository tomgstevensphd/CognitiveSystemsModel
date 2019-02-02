;;********************* csq-permdata.lisp ****************************
;;
;; DATA WHICH IS NOT INCL IN CONFIG
;; 1.IS AT LEAST SEMI-PERMENANT
;; 2.GENERALLY TO BE USED DURING CSQ PROCESSING
;;
;;CAN USE find-global-variable-in-file function to find variable symbols used in top-level defparameter, setf, etc 

;;============ THE DATA ========================
;;
(defparameter *test-elmsym-4combos '((MOTHER FATHER BEST-M-FRIEND) (MOTHER FATHER BEST-F-FRIEND) (MOTHER BEST-M-FRIEND BEST-F-FRIEND) (FATHER BEST-M-FRIEND BEST-F-FRIEND)))

(defparameter *test-data '(this is test data) "This is test docs")