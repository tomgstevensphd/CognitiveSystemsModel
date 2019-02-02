;;******************************** U-CSQ.lisp *************************
;;
;; UTILITY FILE FOR COGNITIVE SYSTEMS QUESTIONNAIRE (CSQ) MANAGEMENT FUNCTIONS
;;
(in-package "CL-USER")

;;put in all key files
#|(when (boundp '*deliver-version-p)
  (cond
   ((null *deliver-version-p)
      (my-config-editor-after-start)
      (initialize-shaq)
      )
   (*deliver-version-p
      (dbg:log-bug-form "DEBUG in U-SHAQ-management" :log-file "SHAQ-Deliver LOG.lisp" :message-stream T)
      (defun initialize-shaq () nil)
      )
  ))|#


;;GET-QVAR-FROM-CATNUM
;;
;;ddd
(defun get-qvar-from-catnum (qvarcat qvarnum &key (all-qvars *all-PC-element-qvars))
  "In U-CSQ, finds qvar assoc with qvarcat num. RETURNS (values qvar qvarlist ans-type)."
  (let
      ((qvar)
       (qvarcat2)
       (testnum)
       (ans-type)
       (qvarnum-str (format nil "~A" qvarnum))
       (qvarlist)
       )
    ;;CATEGORY LOOP
    (loop
     for catlist in all-qvars
     do
     (setf qvarcat2 (car catlist))
     (when (and (listp catlist) (equal qvarcat qvarcat2))
       (setf qvarlists (butlast (cdr catlist))
             ans-type (car (last catlist)))
       (loop
        for qvarlist1 in  qvarlists
        do
        (setf testnum (second (fourth qvarlist1)))
        (when (string-equal qvarnum-str testnum)
          (setf qvar (car qvarlist1)
                qvarlist qvarlist1)
          (return))
        ;;end inner loop
        )
     (return)
     ;;end when, loop
     ))
    (values qvar qvarlist ans-type)
    ;;end let, get-qvar-from-catnum
    ))
;;TEST
;; (get-qvar-from-catnum 'PCE-PEOPLE 3)
;; works= "best-m-friend"    ("best-m-friend" "best-m-friend" "single-text" ("best-m-friend" "3" "best-m-friendQ" "pc-element" "pc-element"))     :SINGLE-TEXT
;;                

