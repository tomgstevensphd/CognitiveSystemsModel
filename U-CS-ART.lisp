;;********************* U-CS-ART.lisp ************************
;;
;;
;;NOTATION:
#|
   ;;1-D1M VAR LIST: (var-name (var-num layer-num field-num module-num) num-last-field value)
   ;;2-DIM VAR LIST:  (var-name (var-from-num var-to-num  from-layer-num to-layer-num  from-field-num to-field-num from-module-num to-module-num) num-last-field value)
|#
(my-config-editor-after-start)
;;

;; THE MAIN/TOP FUNCTIONS FOR CREATING SYMBOL TREES--THE MAIN DATABASE IN ART3 IS IN THE FILE  MyUtilities/U-symbol-trees.lisp 
;; See that file for more info

;;BEGIN ADDED TO U-ART FUNCTIONS =========================



;;END ADDED TO U-ART.LISP FUNCTIONS ======================


;;FIND-SYM-DIMS
;;
;;ddd
(defun find-sym-dims (artsym  &key (separator *art-index-separator)
                              (node-separator *art-node-separator))
  "Creates a list of art dims from a symbol or string, if it contains the dims list. RETURNS (values dims-list rootstr). ASSUMES 1. NO INTEGERS WITHIN SYMBOL and 2. last symbol [rootstr] digit is EITHER A NUMBER OR A SINGLE LETTER. NOTE: Does NOT NEED TO BE AN ART ROOTSTR! SUB FOR OLD find-art-dims."
  (let*
      ((index-sym)
       (index-int)
       (dims-list)
      (length-str)  
      (char)
      (char-str)
      (node-sep-string (format nil "~A" node-separator))
      (node-sep-char0 (string (char node-sep-string 0)))
      (ns-char0-found-p)
      (node-sep-char1 (string (char node-sep-string 1)))
      (rootstr "")
      (length-rootstr)
      (length-dims)
      (string)
      (integer-strs '("0" "1" "2" "3" "4" "5" "6" "7" "8" "9"))
      (dims-found-p)
      (int-str "")
      (next-char)
      (next-str)
      ;;added to fix problem with confusing end of rootstr on symbols
      (last-char-str)
       )
    ;;if artsym not a string, make it one
    (cond
     ((stringp artsym)
      (setf string artsym))
     (t (setf string (format nil "~A" artsym))))

    (setf  length-str (length string))

    (loop
     for n from  0 to (- length-str 1)
     do
     (setf char (char string n)
           char-str (string char))
    ;;(setf *out1 (append *out1 (list (list (format nil "char-str= ~A rootstr= ~A  length-rootstr= ~A ~%" char-str  rootstr length-rootstr)))))
    (cond
     ;;for node-separator char0
     ((and dims-found-p
           (string-equal char-str  node-sep-char0))
      (setf ns-char0-found-p T))
     ;;for node-separators, char1
     ((and (string-equal char-str node-sep-char1) ns-char0-found-p)
      (setf dims-list (append dims-list (list (my-make-symbol node-separator)))
            ns-char0-found-p nil  ))
     ;;for first dim letter at end of rootstr VVV
     ((and (null dims-found-p)(string-equal(string (char string n)) separator)) 
                               ;;was (string (char string (+ n 1))) separator)) caused error
      (setf dims-list (append dims-list (list (my-make-symbol last-char-str))) 
            ;;remove last roostr char, put there in error
            rootstr (subseq rootstr 0 (- (length rootstr) 1))
            dims-found-p T ))
#|was ((and (null dims-found-p)(string-equal(string (char string n)) separator)) 
                               ;;was (string (char string (+ n 1))) separator)) caused error
      (setf dims-list (append dims-list (list (my-make-symbol char-str)))
            dims-found-p T))|#
     ;;for ANY integer
     ((member char-str integer-strs  :test 'string-equal)
      (setf dims-found-p T)
      (when (<  n  (- length-str 1))
        (setf next-char  (char string (+ n 1))
              next-str (string next-char)))       

      (cond
       ;;Is the next char a separator, node-separator, or end of symbol?
       ((or (= n (- length-str 1))
            (string-equal next-str separator)
            (string-equal next-str  node-sep-char0))
        (cond
         ;;if int-str is single digit
         ((string-equal int-str "")
          (setf dims-list (append dims-list (list (parse-integer char-str :junk-allowed t)))))
         ;;if not a single digit
         (t (setf dims-list (append dims-list (list (parse-integer (format nil "~A~A" int-str char-str) :junk-allowed t)))
                  int-str "")))
        ;;end if end of digits
        )
       ;;not end of digits
       (t (setf  int-str  (format nil "~A~A" int-str char-str))))
      ;;end integer found
      )
      ((and dims-found-p (not (string-equal char-str separator)))
       (setf dims-list (append dims-list (list (my-make-symbol char-str)))))
      ((null dims-found-p)
         (setf rootstr (format nil "~A~A" rootstr char-str)))
     (t nil))
    
    ;;added 2016-04
    (setf last-char-str char-str)
    ;;(BREAK)
       ;;end loop
       )
    (values dims-list rootstr)
    ;;end let, find-sym-dims
    ))
;;TEST
;; (find-sym-dims "bvtesti-3-3-3") = (I 3 3 3)  "bvtest"
;; (find-sym-dims "bvtest2-3TOI-L-34")
;; (find-sym-dims "bvtest2332-3TOI-L-3") = (2332 3 TO I L 34)   "bvtest"
;; (find-sym-dims 'bvtest2332-3TOI-L-34) = (2332 3 TO I L 34)  "BVTEST"
;; (find-sym-dims 'CCI-L-F-M)










;;FIND-SYMDIM-INFO
;;
;;ddd
(defun  find-symdim-info (artsym &key (node-separator *art-node-separator)
                              (separator *art-index-separator))
 "In U-ART, RETURNS (values dimslist sublist1 sublist2 n-dims n-sub1-dims n-sub2-dims rootstr). Works on unbound artsyms."
   (let
       ((dimslist)
        (sublist1)
        ( sublist2)
        (  n-dims 0)
        (  n-sub1-dims 0)
        (  n-sub2-dims 0)
        (symvals)
        (node-sep-p)
        (rootstr)
        )

     (cond
      ((and (symbolp artsym)(boundp artsym))
      (setf symvals (eval artsym)
            rootstr (first symvals)
            dimslist (second symvals)))
      (t
       (multiple-value-setq (dimslist rootstr)
           (find-art-dims artsym))))

     ;;(afout 'out (format nil "dimslist= ~A" dimslist))
     (loop
      for item in dimslist
      do
      (cond
       ((my-equal item node-separator)
        (setf  node-sep-p T))
       ((my-equal item separator)
        NIL)
       (node-sep-p
        (incf n-sub2-dims)
        (incf n-dims)
        (setf sublist2 (append sublist2 (list item))))
       (t 
        (incf n-dims)
        (incf n-sub1-dims)
        (setf sublist1 (append sublist1 (list item)))))

      ;;end loop
      ) 

  (values dimslist sublist1 sublist2 n-dims n-sub1-dims n-sub2-dims rootstr)
  ;;end let, find-symdim-info
  ))
;;TEST
;;  (setf  wdni-2-3toi-3-4 '("wdn" (i 2 3 to i 3 4)))
;;  (find-symdim-info 'wdni-2-3toi-3-4) 
;;works= (I 2 3 TO I 3 4)  (I 2 3)  (I 3 4)  6  3  3  "WDN"




;;MAKE-ART-SYMDIMS-LIST
;;
;;ddd
(defun make-art-symdims-list  (artsym) 
  "In U-ART, Converts an artsym into a root and dims list. RETURNS (values root-dims-list rootstr dims-list dims-str)."
  (let
      ((symstr)
       (rootstr)
       (root)
       (dims-str)
       (dims-list)
       (root-dims-list)
       (n-dims)
       )
    (multiple-value-setq (dims-list root)
        (find-art-dims artsym))

    (setf dims-str (format nil "~{~a~^-~}" dims-list )
          root-dims-list (list root dims-list))

     (values root-dims-list root dims-list dims-str)
     ;;end let, make-art-symdims-list
     ))
;;TEST
;;  (make-art-symdims-list "WUPI-3-3TOI-L-6")
;;  works= ("Wup" (I 3 3 TO I L 6))  "Wup"   (I 3 3 TO I L 6)   "I-3-3-TO-I-L-6"




;;FIND-ART-DIMS
;;replaced make-dimlist-from-artsym
;;  OLD VERSION [LATER] DOESN'T WORK WITH NON-ART ROOTSTRS
;;ddd
(defun find-art-dims (artsym  &key (separator *art-index-separator)
                              (node-separator *art-node-separator))
  "Creates a list of art dims from a symbol or string, if it contains the dims list. RETURNS (values dims-list rootstr). ASSUMES 1. NO INTEGERS WITHIN SYMBOL and 2. last symbol [rootstr] digit is EITHER A NUMBER OR A SINGLE LETTER. NOTE: Does NOT NEED TO BE AN ART ROOTSTR! SUB FOR OLD find-art-dims."
  (find-sym-dims artsym :separator separator :node-separator node-separator)
  )
;;TEST
;;  (progn (setf *out1 nil)(find-art-dims  "INPUTI-1-1")) = (I 1 1)   "Input"
;;  (find-art-dims "XI-L-4")  =  (I L 4)  "X" = (I L 4)  "X"
;;  (find-art-dims "RESETI-3-2")  = (I 3 2)   "RESET" 
;; (find-art-dims  "WUPI-L-3TOI-2-3") = (I L 3 TO I 2 3)   "WUP"
;; (find-art-dims 'CCI-L-F-M) = (- L F M) "CCI"




;;  THIS OLD VERSION  DOESN'T WORK WITH NON-ART ROOTSTRS
#|(defun find-art-dims (artsym  &key (art-index-syms *art-index-syms)
                             (separator *art-index-separator) (node-separator *art-node-separator)
                             (root-sym-strs *all-art-symbol-strings))
  "Creates a list of art dims from a symbol or string, if it contains the dims list. RETURNS (values dims-list rootstr). Replaces make-dimlist-from-art-sym in ART2. ROOTSTR not completely reliable. NOTE: FIND-SYM-DIMS OFTEN BETTER."
  (let*
      ((index-sym)
       (index-int)
       (dims-list)
      (length-str)  
      (char)
      (char-str)
      (node-sep-string (format nil "~A" node-separator))
      (node-sep-char0 (string (char node-sep-string 0)))
      (ns-char0-found-p)
      (node-sep-char1 (string (char node-sep-string 1)))
      (rootstr "")
      (length-rootstr)
      (length-dims)
      (string)
       )
    ;;if artsym not a string
    (cond
     ((stringp artsym)
      (setf string artsym))
     (t (setf string (format nil "~A" artsym))))

    ;;find best root-sym-str match
    (multiple-value-setq ( rootstr length-rootstr)
          (find-best-match string root-sym-strs))
   ;;(find-best-match "inputi-1-1" *all-art-symbol-strings) = "input" 5
   ;;(find-best-match "WUPI-3-2TOI-1-3" *all-art-symbol-strings) = "wup" 3
   ;;(find-best-match "UUPI-3-2TOI-1-3" *all-art-symbol-strings) = "udn" 3
   ;;(find-best-match "xi-1-3" *all-art-symbol-strings) = "X" 1 1 ("X")
   ;;(find-best-match "reseti-2-2" *all-art-symbol-strings) = "RESET" 5 9 ("R" "RESET" "R")
    (setf  length-str (length string)
           length-dims (- length-str length-rootstr))
    (loop
     for n from  (- length-rootstr 1) to (-  length-str 1)
     do
     (setf char (char string n)
           char-str (string char))
    ;;(setf *out1 (append *out1 (list (list (format nil "char-str= ~A rootstr= ~A  length-rootstr= ~A ~%" char-str  rootstr length-rootstr)))))
     (cond
      ((member char-str art-index-syms :test 'string-equal)
       (setf dims-list (append dims-list (list (my-make-symbol char-str)))))
      ((setf index-int (parse-integer char-str :junk-allowed t))
       (setf dims-list (append dims-list (list index-int))))
      ((string-equal char-str  node-sep-char0) 
       (setf ns-char0-found-p T)) 
      ((and (string-equal char-str node-sep-char1) ns-char0-found-p)
       (setf dims-list (append dims-list (list (my-make-symbol node-separator)))
           ns-char0-found-p nil  ))
      ;;partially reliable root finder
#|      ((not (string-equal char-str "-"))
       (setf rootstr (format nil "~A~A" rootstr char-str)))|#
      (t nil))
     ;;end loop
     )
    ;;problem with T
   ;;;was  (when (string-equal rootstr "rese")        (setf rootstr "RESET"))

    (values dims-list rootstr)
    ;;end let, find-art-dims
    ))|#
;;TEST
;;  (progn (setf *out1 nil)(find-art-dims  "INPUTI-1-1")) = (I 1 1)   "Input"
;;  (find-art-dims "XI-L-4")  =  (I L 4)  "X" = (I L 4)  "X"
;;  (find-art-dims "RESETI-3-2")  = (I 3 2)   "RESET" 
;; (find-art-dims  "WUPI-L-3TOI-2-3") = (I L 3 TO I 2 3)   "Wup"





 
;;MAKE-ONE-DIM-INDECIES
;;
;;ddd
(defun make-one-dim-indecies (dimspec) ;;no &key index-syms *art-index-syms)
  "U-ART"
  (let*
      ((n-syms (car dimspec))
       (begin-n (second dimspec))
       (incr-n (third dimspec))   
       (index begin-n)
       (index-list (list begin-n))
       
       )
    (loop
     for n from 1 to (- n-syms 1)
     do
     (setf index (+ index incr-n)
           index-list (append index-list (list index)))
     )
    index-list
    ;;end let, make-one-dim-indexes
    ))
;;TEST
;;  (make-one-dim-indecies '(4  1  1)) = (1 2 3 4)
;;  (make-one-dim-indecies '(1  1  1)) =  (1)
;;  (make-one-dim-indecies '(4  2  3)) = (2 5 8 11)


;;=========== FROM U-ART2, TEST THESE BEFORE USING ========


;;
;;SETSYMVAL
;;
;;ddd
(defun setsymval (artsym &optional dims value  &key get-only-p 
                         (betw-dims-strs '("-" "")) (2-node-symbol-list '(wup wdn)) ;; uup udn))
                         (node-separator "To")(node-separator-n 3) (value-n 3)
                         append-value-p subsyms)
  "In U-ART, Adds value to fourth place in the sym-vals list (eg WUP2-3 = (\"Wup\"(2 3) 9 value). RETURNS new sym-vals list (values sym-vals new-sym value old-value). INPUT EITHER1.symbol with dims (eg. sym2-4 nil) or root plus dims (eg. sym (2 4). Use instead of aref. betw-dims-strs is a list of strings to be inserted in order betw dims. NOTE: symbol must be quoted. append-value-p causes it to append the value to the list instead of puttting it in value-n place. dims = list of the i j etc of each dim. If use append-value-p, item should be a list. If no previous value or 3rd item, adds NIL value to old list eg. (a b NIL value). USE subsyms TO APPEND SUBORD SYMS IN A LIST."
  (let
      ((sym-vals) 
       (old-sym-vals)
       (old-value)
       (new-sym-str)
       (new-sym)
       (dims-str "")
       (n-dims (list-length dims))
       (temp1)
       (appended-value)
       (subsyms)
       (old-subsyms)
       (rootdims-list)
       )

    ;;GET/MAKE  THE NEW-SYM TO  GET/SET VALUES
    (cond
     ;;ARTSYM WITH DIMS and DIMS = NIL
     ((null dims)
      ;; (setf rootdims-list (make-dimlist-from-art-sym symbol)))
      (cond
       ((and (symbolp artsym)(boundp artsym))
        (setf new-sym artsym))

       ;;not symbol or bound, BUT SHOULD INCLUDE DIMS
       (t
        (setf new-sym (my-make-symbol (format nil "~A" artsym))))))

     ;;IF DIMS (artsym therefore just a root)      
     (dims
      ;;make the dims-str for finding the symbol later
      (setf dims-str (make-dims-string dims)
            new-sym-str (format nil "~A~A" artsym dims-str)
            new-sym (my-make-symbol new-sym-str)))

     ;;IF ARTSYM IS BOUND, BUT 
     (t
      (when (boundp artsym)
        (setf  new-sym artsym ))))


 ;;GET OR SET THE NEW? VALUE  
 (cond
  ((and (symbolp new-sym)(boundp new-sym))
   (setf old-sym-vals (eval new-sym)
         old-value (nth value-n old-sym-vals)
         old-subsyms (fifth  old-sym-vals))
 ;;append new subsyms to old
 (when (and old-subsyms subsyms)
   (setf subsyms (append old-subsyms subsyms)))

   ;;so if add value it will be in fourth place
   (when (< (length old-sym-vals) 3)
     (setf old-sym-vals (append old-sym-vals (list nil nil nil))))
   (cond
    ((not get-only-p)
     (cond
      ((null append-value-p)
       (cond
        ((> (list-length old-sym-vals) 4)
         (setf  sym-vals (list (first old-sym-vals)(second old-sym-vals)
                               (third old-sym-vals) value subsyms)
                sym-vals (append sym-vals (nthcdr 5 old-sym-vals))))
        (t                           
         (setf  sym-vals (list (first old-sym-vals)(second old-sym-vals)
                               (third old-sym-vals) value subsyms)))))
      (t 
       (cond
        ((listp old-value)
         (setf appended-value (append old-value  value)))
        (t (setf appended-value (list old-value value))))
       (setf  sym-vals (list (first old-sym-vals)(second old-sym-vals)
                               (third old-sym-vals) appended-value))))
     ;;end  not get-only-p clause
     )
    ;;if get-only-p
    (t 
     (setf value old-value
           sym-vals old-sym-vals)))
   ;;end boundp clause
   )
  ;;if new-sym not bound
  (t  (setf  rootdims-list 
             (make-art-symdims-list  new-sym)) 
      (cond
       ((> (list-length rootdims-list) 2)
        (setf sym-vals (list (first rootdims-list)(second rootdims-list) NIL value)
              sym-vals (append sym-vals (nthcdr 2 rootdims-list))))
       (t 
        (setf sym-vals (list (first rootdims-list)(second rootdims-list) NIL value subsyms)))))
  ;;end big cond
  )
      ;;SET THE NEW-SYM TO THE NEW VALUES
      (set new-sym sym-vals)

   (values sym-vals new-sym value old-value subsyms) ;;subsyms added
    ;;end let, setsymval
    ))  
;;TEST
;;ART3
;; (setsymval 'WDN2-1-2TO4-3-1 NIL  0.7) 
;; works= ("Wdn" (2 1 2 TO 4 3 1) NIL 0.7)  WDN2-1-2TO4-3-1  0.7  NIL
;;
;;(setsymval 'wdn '(2 1 4  TO  4 3 1) 0.88)
;;works= ("Wdn" (2 1 4 TO 4 3 1) NIL 0.88)   WDN2-1-4TO4-3-1  0.88  NIL
;;also CL-USER 140 > WDN2-1-4TO4-3-1  = ("Wdn" (2 1 4 TO 4 3 1) NIL 0.88)
;;THEN   (setsymval 'WDN2-1-4TO4-3-1 nil 0.11)
;;works= ("Wdn" (2 1 4 TO 4 3 1) NIL 0.11)  WDN2-1-4TO4-3-1  0.11  0.88
;;also= CL-USER 142 > WDN2-1-4TO4-3-1 =  ("Wdn" (2 1 4 TO 4 3 1) NIL 0.11)  

;;
;; (setsymval 'WDN2-1-2TO4-3-1 nil nil  :get-only-p T)
;; works= (WDN (2 1 2 4 3 1) NIL 0.44 "to" 3)  WDN2-1-2TO4-3-1 0.44 0.44
;; 
;; (setsymval 'reset-ninputs (list 2) 0)
;; WORKS= ("reset-ninputs" (2) 9 0) RESET-NINPUTS2  0  NIL
;; ALSO= CL-USER 88 > RESET-NINPUTS2 
;;works=  ("reset-ninputs" (2) 9 0)

;;
;; (setsymval 'wdn '(2 1 2 4 3 1) 0.88)
;; TO TEST APPEND
;; (setf wup '("Wup" (I L F TO I L F) NIL (WUPI-L-2-TOI-L-F)))
;; (setsymval 'wup nil '(WUPI-L-2-TOI-L-3) :append-value-p T)
;; works= ("Wup" (I L F TO I L F) NIL (WUPI-L-2-TOI-L-F WUPI-L-2-TOI-L-3))
 





;;GETSYMVAL
;;
;;ddd
(defun getsymval (symbol &optional dims  &key (betw-dims-strs '("-" ""))  (value-n 3) (node-separator "To") return-subsyms-p)
  "In U-ART, returns value in fourth place in the sym-vals list (eg WUP2-3 = (\"Wup\"(2 3) 9 value). RETURNS  (values value sym-vals new-sym). INPUT EITHER1.symbol with dims (eg. sym2-4 nil) or root plus dims (eg. sym (2 4). Use instead of aref. betw-dims-strs is a list of strings to be inserted in order betw dims. NOTE: symbol must be quoted. when RETURN-SUBSYMS-P, RETURNS (values subsyms value sym-vals new-sym)"
  (let
      ((sym-vals) 
       (x)
       (new-sym-str)
       (new-sym)
       (dims-str "")
       (n-dims (list-length dims))
       )

    (multiple-value-setq (sym-vals new-sym x value subsyms)
        (setsymval  symbol dims nil :get-only-p T  :betw-dims-strs betw-dims-strs :value-n  value-n :node-separator node-separator))

    (cond
     (return-subsyms-p
      (values subsyms value sym-vals new-sym))
     (t  (values value sym-vals new-sym)))
    ;;end let, getsymval
    ))
;;TEST
;;FOR ART3
;; (getsymval 'WDN2-1-2TO4-3-1)
;; works= 0.7  ("Wdn" (2 1 2 TO 4 3 1) NIL 0.7)  WDN2-1-2TO4-3-1
;;
;; (getsymval 'WDN  '(2 1 2 TO 4 3 1))
;; works= 0.7  ("Wdn" (2 1 2 TO 4 3 1) NIL 0.7)  WDN2-1-2TO4-3-1
;;  (getsymval "WDN2-1-2TO4-3-1")
;; works= 0.7  ("Wdn" (2 1 2 TO 4 3 1) NIL 0.7)  WDN2-1-2TO4-3-1

;;FOR ART2
;;  (getsymval 'WDN2-3) = 0.7  ("Wdn" (2 3) 5 0.7)  WDN2-3
;;  (getsymval "Wdn" '(2 3)) = 0.7  ("Wdn" (2 3) 5 0.7)  WDN2-3
;;  (getsymval "Wdn" '(2 3) :value-n 1) = (2 3)  ("Wdn" (2 3) 5 0.7)  WDN2-3
;;  (getsymval "Wdn" '(2 3) :value-n 1)



;;GET-CLASS-SYMVALS
;;
;;ddd
(defun get-class-symvals (class-sym  &key (value-nth 3) )
  "In U-ART RETURNS (values symvals-list sym-value-lists sym-count). sym-value-lists = (sym value sym-n).   The class-sym may be a root or any topsym. "
  (let
      ((bottom-syms-list (find-bottom-art-instances class-sym))
       (symvals)
       (symvals-list)
       (sym-n 0)
       (sym-val-list)
       (sym-value-lists)
       )
    (loop
     for sym in bottom-syms-list
     do
     (incf sym-n)
     (when (boundp sym)
       (setf symvals (eval sym)
             symvals-list (append symvals-list (list symvals))
             value (nth value-nth symvals)
             sym-val-list (list sym value sym-n)
             sym-value-lists (append sym-value-lists (list sym-val-list))))
     ;;end loop
     )
    (values sym-value-lists  symvals-list  sym-n)
    ;;end let, get-class-symvals
    ))
;;TEST
;;  (get-class-symvals 'WUP)
#|;;sym-value-lists list
((WUP1-3-2TO1-1-3 0.4924 1) (WUP1-3-2TO2-1-3 0.4401 2) (WUP1-3-2TO3-1-3 0.4755 3) (WUP1-3-2TO4-1-3 0.4415 4) (WUP1-3-2TO5-1-3 0.4517 5) (WUP2-3-2TO1-1-3 0.4098 6) (WUP2-3-2TO2-1-3 0.4607 7) (WUP2-3-2TO3-1-3 0.4036 8) (WUP2-3-2TO4-1-3 0.411 9) (WUP2-3-2TO5-1-3 0.4842 10) . . .  . . . . (WUP7-3-2TO5-1-3 0.4558 35) (WUP8-3-2TO1-1-3 0.444 36) (WUP8-3-2TO2-1-3 0.4208 37) (WUP8-3-2TO3-1-3 0.43670002 38) (WUP8-3-2TO4-1-3 0.4 39) (WUP8-3-2TO5-1-3 0.442 40) (WUP9-3-2TO1-1-3 0.4019 41) (WUP9-3-2TO2-1-3 0.4593 42) (WUP9-3-2TO3-1-3 0.4769 43) (WUP9-3-2TO4-1-3 0.4118 44) (WUP9-3-2TO5-1-3 0.412 45))
;;symvals-list= (("Wup" (1 3 2 TO 1 1 3) NIL 0.4924 NIL) ("Wup" (1 3 2 TO 2 1 3) NIL 0.4401 NIL) ("Wup" (1 3 2 TO 3 1 3) NIL 0.4755 NIL) ("Wup" (1 3 2 TO 4 1 3) NIL 0.4415 NIL) ("Wup" (1 3 2 TO 5 1 3) NIL 0.4517 NIL)  . . . . . . ("Wup" (8 3 2 TO 4 1 3) NIL 0.4 NIL) ("Wup" (8 3 2 TO 5 1 3) NIL 0.442 NIL) ("Wup" (9 3 2 TO 1 1 3) NIL 0.4019 NIL) ("Wup" (9 3 2 TO 2 1 3) NIL 0.4593 NIL) ("Wup" (9 3 2 TO 3 1 3) NIL 0.4769 NIL) ("Wup" (9 3 2 TO 4 1 3) NIL 0.4118 NIL) ("Wup" (9 3 2 TO 5 1 3) NIL 0.412 NIL))
n-syms=  45
|#





;;MAKE-GRAPH-POINTS-LISTS
;;
;;ddd
(defun make-graph-points-lists (class-sym-list  &key 
                                                (initial-x-pix 0) (incr-x-pix 40)
                                         (sortdim-n 1) (sortdim-n2-syms *sortdim-n2-syms)
                                         append-symvals-p
                                         (from-index0 1)(to-index0 1)
                                         (use-label-abbrev-p T) (add-label-p T)
                                         (setsym-2dim-nested-lists-p T)
                                         no-1dimlists-in-nested-p)
  "In ART.lisp, NOTE1: artsyms must be PRESORTED because can only assign pixel locations AFTER SORTING. NOTE2:  initial-x-pix and incr-x-pix can be a value OR a list of values--single value used for all, list values must match num cells. Takes N dim arrays RETURNS (values  converted-symvals-lists symbols-list)   eg. (PUT EG HERE SSS  ). 1-dim lists are appended to all-sym-points-lists unless no-1dimlists-in-nested-p"
  (let*
      ((class-points-sym)
       (class-points-syms)
       (flat-points-lists)
       (all-sym-points-lists)
       (points-sym)
       (all-sym-points-list)
       (dimlist)( sublist1)( sublist2)( n-dims)( n-sub1-dims)( n-sub2-dims)( rootstr)
       (n-dims)(n-items)( sublist-Ns)(dimspec-lists)
       ( n-dim1)( n-dim2)( dimspec-lists1)( dimspec-lists2 )
       ( begin-dims)
       (end-dims)
       (cur-sortdim-n)
       )

    (loop
     for class-sym in class-sym-list
     do
      ;; Class syms for graphs (INPUTI-1-1 XI-2-1 YI-3-3 WUPI-3-2TOI-1-3 WDNI-1-3TOI-3-2 UUPI-3-2TOI-1-3 RESETI-2-2)

          (cond
           ((member class-sym sortdim-n2-syms :test 'equal)
            (setf  cur-sortdim-n 5))
           (t (setf cur-sortdim-n sortdim-n)))
    

    (multiple-value-setq (dimlist sublist1 sublist2 n-dims n-sub1-dims n-sub2-dims rootstr)
        (find-symdim-info class-sym))
 ;;MUST ADAPT TO USING find-symdim-info HERE--JUST USE GETSUBSYMS??
    ;;for path syms
    (when dimspec-lists2
      (setf begin-dims dimspec-lists1
            end-dims dimspec-lists2))  


     (multiple-value-setq (class-points-sym  all-sym-points-list)
         (make-graph-points-list class-sym 
                                 :begin-dims begin-dims :end-dims end-dims
                                 :dimlabel :dimsim
                                 :initial-x-pix initial-x-pix
                                 :incr-x-pix incr-x-pix
                                 :sortdim-n cur-sortdim-n
                                 :append-symvals-p append-symvals-p 
                                 :use-label-abbrev-p use-label-abbrev-p 
                                 :add-label-p add-label-p
                                ;; :setsym-2dim-nested-lists-p setsym-2dim-nested-lists-p
                                  ))

     (setf class-points-syms (append class-points-syms (list class-points-sym))
           all-sym-points-lists (append all-sym-points-lists (list all-sym-points-list)))

     ;;end loop
     )
    (values class-points-syms  flat-points-lists  all-sym-points-lists)
    ;;end let, make-graph-points-lists
    ))
;;TEST
;;FOR ART3 ----------------------------------
#|CL-USER 40 > (make-graph-points-lists '(INPUTI-1-1 XI-2-2 YI-3-3 WUPI-3-2TOI-1-3 WDNI-1-3TOI-3-2 UUPI-3-2TOI-1-3 RESETI-2-2))
(*INPUTI-1-1-POINTS *XI-2-2-POINTS *YI-3-3-POINTS *WUPI-3-2TOI-1-3-POINTS *WDNI-1-3TOI-3-2-POINTS *UUPI-3-2TOI-1-3-POINTS *RESETI-2-2-POINTS)
|#
;; (make-graph-points-lists '(INPUTI-1-1 XI-2-2 YI-3-3 WUPI-3-2TOI-1-3 WDNI-1-3TOI-3-2 UUPI-3-2TOI-1-3 RESETI-2-2))
;;NO--MAKE ONLY  GRAPH SIMS THAT WILL USE  EG XI-2-2 NOT XI-L-F; MAKES TOO MANY PTS AND THEY HAVE PIXELS SPECIFIED
;;list syms: (*INPUTI-L-F-POINTS *XI-L-F-POINTS *YI-L-F-POINTS *WUPI-3-2TOI-1-3-POINTS *WDNI-L-FTOI-L-F-POINTS *UUPI-3-2TOI-1-3-POINTS *RESETI-L-F-POINTS)




;;*art-graph-points-syms-list = (INPUTI-1-1 XI-2-2 YI-3-3 WUPI-3-2TOI-1-3 WDNI-1-3TOI-3-2 UUPI-3-2TOI-1-3 RESETI-2-2)
;;class-points-syms: (*INPUTI-1-1-POINTS *XI-2-2-POINTS *WUPI-3-2TOI-1-3-POINTS *WDNI-1-3TOI-3-2-POINTS *YI-3-3-POINTS *RESETI-2-2-POINTS)
;;flat-points-lists:  (((1 (40 -0.07232) "Inp1-1" (1 1 1)) (2 (80 -3.2000244E-4) "Inp1-1" (2 1 1)) (3 (120 0.0304) "Inp1-1" (3 1 1)) (4 (160 1.0312) "Inp1-1" (4 1 1)) (5 (200 1.01856) "Inp1-1" (5 1 1))) ((1 (40 0) "X1-2-2" (1 2 2)) (2 (80 0) "X2-2-2" (2 2 2)) (3 (120 0) "X3-2-2" (3 2 2)) (4 (160 0) "X4-2-2" (4 2 2)) (5 (200 0) "X5-2-2" (5 2 2)) (6 (240 0) "X6-2-2" (6 2 2)) (7 (280 0) "X7-2-2" (7 2 2)) (8 (320 0) "X8-2-2" (8 2 2)) (9 (360 0) "X9-2-2" (9 2 2))) NIL NIL ((1 (40 0) "Y1-3-3" (1 3 3)) (2 (80 0) "Y2-3-3" (2 3 3)) (3 (120 0) "Y3-3-3" (3 3 3)) (4 (160 0) "Y4-3-3" (4 3 3)) (5 (200 0) "Y5-3-3" (5 3 3)) (6 (240 0) "Y6-3-3" (6 3 3)) (7 (280 0) "Y7-3-3" (7 3 3)) (8 (320 0) "Y8-3-3" (8 3 3)) (9 (360 0) "Y9-3-3" (9 3 3))) ((1 (40 0) "res2-2" (1 2 2)) (2 (80 0) "res2-2" (2 2 2)) (3 (120 0) "res2-2" (3 2 2)) (4 (160 0) "res2-2" (4 2 2)) (5 (200 0) "res2-2" (5 2 2)) (6 (240 0) "res2-2" (6 2 2)) (7 (280 0) "res2-2" (7 2 2)) (8 (320 0) "res2-2" (8 2 2)) (9 (360 0) "res2-2" (9 2 2))))
;;nested-points-lists:  (((1 (40 -0.07232) "Inp1-1" (1 1 1)) (2 (80 -3.2000244E-4) "Inp1-1" (2 1 1)) (3 (120 0.0304) "Inp1-1" (3 1 1)) (4 (160 1.0312) "Inp1-1" (4 1 1)) (5 (200 1.01856) "Inp1-1" (5 1 1))) ((1 (40 0) "X1-2-2" (1 2 2)) (2 (80 0) "X2-2-2" (2 2 2)) (3 (120 0) "X3-2-2" (3 2 2)) (4 (160 0) "X4-2-2" (4 2 2)) (5 (200 0) "X5-2-2" (5 2 2)) (6 (240 0) "X6-2-2" (6 2 2)) (7 (280 0) "X7-2-2" (7 2 2)) (8 (320 0) "X8-2-2" (8 2 2)) (9 (360 0) "X9-2-2" (9 2 2))) NIL NIL ((1 (40 0) "Y1-3-3" (1 3 3)) (2 (80 0) "Y2-3-3" (2 3 3)) (3 (120 0) "Y3-3-3" (3 3 3)) (4 (160 0) "Y4-3-3" (4 3 3)) (5 (200 0) "Y5-3-3" (5 3 3)) (6 (240 0) "Y6-3-3" (6 3 3)) (7 (280 0) "Y7-3-3" (7 3 3)) (8 (320 0) "Y8-3-3" (8 3 3)) (9 (360 0) "Y9-3-3" (9 3 3))) ((1 (40 0) "res2-2" (1 2 2)) (2 (80 0) "res2-2" (2 2 2)) (3 (120 0) "res2-2" (3 2 2)) (4 (160 0) "res2-2" (4 2 2)) (5 (200 0) "res2-2" (5 2 2)) (6 (240 0) "res2-2" (6 2 2)) (7 (280 0) "res2-2" (7 2 2)) (8 (320 0) "res2-2" (8 2 2)) (9 (360 0) "res2-2" (9 2 2))))
;;PPRINTED
#|(((1 (40 -0.07232) "Inp1-1" (1 1 1))
  (2 (80 -3.2000244E-4) "Inp1-1" (2 1 1))
  (3 (120 0.0304) "Inp1-1" (3 1 1))
  (4 (160 1.0312) "Inp1-1" (4 1 1))
  (5 (200 1.01856) "Inp1-1" (5 1 1)))
 ((1 (40 0) "X1-2-2" (1 2 2))
  (2 (80 0) "X2-2-2" (2 2 2))
  (3 (120 0) "X3-2-2" (3 2 2))
  (4 (160 0) "X4-2-2" (4 2 2))
  (5 (200 0) "X5-2-2" (5 2 2))
  (6 (240 0) "X6-2-2" (6 2 2))
  (7 (280 0) "X7-2-2" (7 2 2))
  (8 (320 0) "X8-2-2" (8 2 2))
  (9 (360 0) "X9-2-2" (9 2 2)))
 NIL
 NIL
 ((1 (40 0) "Y1-3-3" (1 3 3))
  (2 (80 0) "Y2-3-3" (2 3 3))
  (3 (120 0) "Y3-3-3" (3 3 3))
  (4 (160 0) "Y4-3-3" (4 3 3))
  (5 (200 0) "Y5-3-3" (5 3 3))
  (6 (240 0) "Y6-3-3" (6 3 3))
  (7 (280 0) "Y7-3-3" (7 3 3))
  (8 (320 0) "Y8-3-3" (8 3 3))
  (9 (360 0) "Y9-3-3" (9 3 3)))
 ((1 (40 0) "res2-2" (1 2 2))
  (2 (80 0) "res2-2" (2 2 2))
  (3 (120 0) "res2-2" (3 2 2))
  (4 (160 0) "res2-2" (4 2 2))
  (5 (200 0) "res2-2" (5 2 2))
  (6 (240 0) "res2-2" (6 2 2))
  (7 (280 0) "res2-2" (7 2 2))
  (8 (320 0) "res2-2" (8 2 2))
  (9 (360 0) "res2-2" (9 2 2))))|#
;; (make-graph-points-lists  '(XI-L-F))
;; (make-graph-points-lists  '(Y))


;;FOR ART2 ------------------------------------------------------------------
;; to test (setf *t-input '("input" ((input1 input2 input3))) input1 '("input" (1) 3 .11) input2 '("input" (2) 3 .22)  input3 '("input" (3) 3 .33)  *t-wup '("wup" ((wup1-1 wup1-2)(wup1-2 wup2-2)))  wup1-1 '("wup" (1 1) 2  .11)  wup2-1 '("wup" (1 1) 2  .21) wup1-2 '("wup" (1 2) 2 .12) wup2-2 '("wup" (2 2) 2 .22))
;;  (make-graph-points-lists '(*t-input *t-wup)) ;; activity))
;; works= (*INPUT-POINTS *WUP-POINTS)
;flatlist: (((1 (40 0.11) "input1" (1)) (2 (80 0.22) "input2" (2)) (3 (120 0.33) "input3" (3))) ((1 (40 0.11) "wup1-1" (1 1)) (1 (80 0.12) "wup1-2" (1 2)) (1 (120 0.12) "wup1-2" (1 2)) (2 (160 0.22) "wup2-2" (2 2))))
;;nested-list with 1dim: (((1 (40 0.11) "input1" (1)) (2 (80 0.22) "input2" (2)) (3 (120 0.33) "input3" (3))) ((:DIMSIM 1 ((1 (40 0.11) "wup1-1" (1 1)) (1 (80 0.12) "wup1-2" (1 2)))) (:DIMSIM 1 ((1 (40 0.12) "wup1-2" (1 2)) (2 (80 0.22) "wup2-2" (2 2))))))

;; (make-graph-points-lists '(input))

;;TO TEST FOR ART3
;; to test (setf *t3-input '("input" ((input1-2-11 input2-2-11 input3-2-11))) input1-2-11 '("input" (1 2 11) 3 .11) input2-2-11 '("input" (2 2 11) 3 .22)  input3-2-11 '("input" (3 2 11) 3 .33)  *t3-wup '("wup" ((wup1-1-2-2-11-11 wup1-2-2-2-11-11)(wup1-2-2-2-11-11 wup2-2-2-2-11-11)))  wup1-1-2-2-11-11 '("wup" (1 1 2 2 11 11) 2  .11)  wup2-1-2-2-11-11 '("wup" (1 1 2 2 11 11) 2  .21) wup1-2-2-2-11-11 '("wup" (1 2 2 2 11 11) 2 .12) wup2-2-2-2-11-11 '("wup" (2 2 2 2 11 11) 2 .22) *GRAPH-SYM-ABRV-BEGIN-N 20 *GRAPH-SYM-ABRV-BEGIN-N 0 *GRAPH-SYM-ABRV-END-N 3)
;;
;;  (make-graph-points-lists '(*t3-input *t3-wup)) 




;;MAKE-GRAPH-POINTS-LIST
;;
;;ddd
(defun make-graph-points-list (topsym &key  (dimlabel :dimsim)  nest-syms-p 
                                      begin-dims end-dims
                                         (initial-x-pix 0) (incr-x-pix 40)
                                           append-symvals-p
                                         (use-label-abbrev-p T) (add-label-p T)
                                         (sortdim-n 1)
                                         add-pre-items-to-node-lists-p )
                                         
  "In ART.lisp, NOTE1: topsym can incl dims (eg XI-L-F) or not. If not, it assumes that it is the class-topsym. If a lower level sym, then still works and USES ONLY THOSE INSTANCES IT SPECIFIES. NOTE2: artsyms must be PRESORTED BEFORE ASSIGN PIXES because can only assign pixel locations AFTER SORTING. NOTE3:  initial-x-pix and incr-x-pix can be a value OR a list of values--single value used for all, list values must match num cells. Takes N dim arrays RETURNS (values class-points-sym flat-points-list all-sym-points-list)   eg. (PUT EG HERE SSS  ).   NOTE: if n-dims >= 2, syms are nested by all F1 together first level, F2 groups of F1 ((C11 C21)(C12 C22)), Eg. 1-dim: *INPUT-POINTS = '((:DIMSIM 1 ((1 (40 110) INPUT1 (1)) (2 (80 222 ) INPUT2 (2)) (3 (120 333) INPUT2 (3))))), for 2-dim: *WUP-POINTS = ((:DIMSIM 1 ((1 (40 110) WUP1-1 (1 1)) (2 (80 200) WUP1-2 (2 1)))) (:DIMSIM 2 ((1 (40 50) WUP1-2 (1 2)) (2 (80  20) WUP2-2 (2 2))))).  begin-dims end-dims specify range of the nodes eg begin-dims: '(I  3  2 TO I  1 3) end-dims (I  3  2 TO I  1 3). USE SORTDIM-N (default= 1) to choose dim to sort for first dim (eg. 2 for WDN)."

  ;;SYM egs  INPUTI-1-1 XI-2-2 WUPI-3-2TOI-1-3
  (let*
      ((top-symvals (eval topsym))
       (topdims (second top-symvals))
       (class-rootsym (find-art-class-rootsym topsym))
       (class-root-dimspecs (second (eval class-rootsym)))
       (class-topsym (find-art-class-topsym topsym))
       (class-symvals (eval class-topsym)) 
    ;;eg WUP = ("Wup" (((9 1 1) (1 3 1) (1 2 1)) TO ((5 1 1) (1 1 1) (1 3 1))) WUP-POINTS NIL (WUPI-L-FTOI-L-F))
       ;;not needed (class-dims-list (second class-symvals))
       (class-graph-slot (third class-symvals))
       (flat-sym-list (find-bottom-art-instances class-topsym)) ;;was (flatten-count-nested-lists syms))
       ;;(find-bottom-art-instances 'wupi-l-ftoi-l-f)
       (n-syms (list-length flat-sym-list))
       (firstsym-symvals (eval (car flat-sym-list)))
       (firstsym-dims (second firstsym-symvals))
       (n-dims (dimlist-length firstsym-dims))
       (symroot (first firstsym-symvals))
       ;;(n-field2-groups 1)  
       ;;(firstF1-n)
       (flat-points-list)
       (new-symvals-list)
      ;;(new-values)
       ;;(old-values)
       ;;(sym-count)
      ; ;(value-count)
       (x-pix initial-x-pix)
       (y-pix 0)
       ;;(label "")
      ;;(x-val initial-x-pix)
       (class-points-sym-str)
       (class-points-sym)
       (topsym-points-sym)
       (points-list)
       (points-sublist)
       (all-sym-points-list)
       (sorted-syms)
       (syms-sublist)
       (dims)
       ;;(sym-i)
      ;; (sym-j)  
       ;;added
       (n-dims)(n-items)(sublist-Ns)(dimspec-lists)
       (n-dim1)(n-dim2)(dimspec-lists1)(dimspec-lists2)
       (topsym-points-sym-str)
       )
    ;;(afout 'out (format nil "1 flat-sym-list= ~A~%" flat-sym-list))
  
    ;;GET DIM-SPEC-INFO
    (multiple-value-setq (n-dims n-items sublist-Ns dimspec-lists
                                 n-dim1 n-dim2 dimspec-lists1 dimspec-lists2)
        (find-dim-spec-info class-root-dimspecs))          
;;eg (find-dim-spec-info '(((9 1 1) (1 3 1) (1 2 1)) TO ((5 1 1) (1 1 1) (1 3 1))))
       ;; = 2 3 (1 TO 1)  ((((9 1 1) (1 3 1) (1 2 1))) (((5 1 1) (1 1 1) (1 3 1))))  1 1 (((9 1 1) (1 3 1) (1 2 1)))  (((5 1 1) (1 1 1) (1 3 1)))

     ;;IF TOPSYM NOT CLASS-TOPSYM   FIND begin-dims end-dims
     (when (not (my-equal topsym class-topsym))
       (multiple-value-setq (begin-dims end-dims)  
           (find-artsym-dims-range  topsym)))

    ;;make the graph-points-list points-sym
    (setf  topsym-points-sym-str (format nil "*~A-points" topsym) ;;was class-topsym) 
           topsym-points-sym (my-make-symbol topsym-points-sym-str))
    ;;(afout 'out (format nil "1 topsym-points-sym= ~A~%" topsym-points-sym))

    
     ;;SORT THE FLAT-SYM-LIST  INTO MULTI- DIMLISTS
     ;; Must do BEFORE assign pixels  (for overlapping graphs in same space)
     ;;only sort the PATH LISTS
     (cond
      (dimspec-lists2
        ;;makes a multi-dim list with preitems eg. (((label 1 (x1-1-1 x2-1-1 ...))(label 2 (...))))
       (setf sorted-syms 
             (sort-art-syms-by-dim sortdim-n flat-sym-list
                                   :dimlabel dimlabel :nest-syms-p  nest-syms-p)))

        ;;if single dim list with preitems= label and num eg. ((label 1 (x1-1-1 x2-1-1 ...)))
      ((and add-pre-items-to-node-lists-p dimlabel)
       (setf sorted-syms (list (list dimlabel 1 flat-sym-list))))
      ;;Don't sort the NODE lists
        ;;makes a sorted list, only sym list, eg (x1-1-1 x2-1-1 ...)
      (t (setf sorted-syms flat-sym-list)))
      
     ;;output eg:((:DIMSIM 1 (WUP1-3-2TO2-1-3 ... WUP1-3-2TO5-1-3)) (:DIMSIM 2 (WUP2-3-2TO2-1-3 ...  WUP2-3-2TO5-1-3))  (:DIMSIM 9 (WUP9-3-2TO2-1-3... WUP9-3-2TO5-1-3)))

    ;;MAKE THE GRAPHING VALUES TO ADD 
    ;;from draw-graph-window function, points-list input eg.:  ((:DIMSIM 1 ((1 (40 110) WUP1-1 (1 1)) (2 (80 200) WUP1-2 (2 1)))) (:DIMSIM 2 ((1 (40 50) WUP1-2 (1 2)) (2 (80  20) WUP2-2 (2 2)))))

    ;;MAKE GRAPH-POINTS-SUBLISTS FOR EACH SUBLIST
    (loop
     for sublist in sorted-syms
     do  
     (let
         ((dimlabel1)
          (dim-n1)
          (pre-items)
          (return-after-make-p)
          )
       ;;zzzz
       (cond
        ;;if a PATH sym
        (dimspec-lists2
         (cond
         ;;if a multi-dim PATH list with preitems eg. (((label 1 (x1-1-1 x2-1-1 ...))(label 2 (...))))
          (dimlabel           
           (setf pre-items (butlast sublist)
                 syms-sublist (third sublist)))
        ;;if a multi-dim with no label  ((1 x1-1-1  x2-1-1 ..) etc)
          (t
           (setf pre-items (list (car sublist))
                 syms-sublist (cdr sublist))))
         ;;end PATH syms clause
         )
        ;;if single dim list with label and num eg. ((label 1 (x1-1-1 x2-1-1 ...)))
        (t
         (cond
          ;;if not a sorted list, only sym list, eg (x1-1-1 x2-1-1 ...)
          ((symbolp sublist)
           (setf syms-sublist sorted-syms)
           (setf return-after-make-p T))
          ;;if a labeled NODE list
          (dimlabel
           (setf pre-items (butlast sublist)
                 syms-sublist (third sublist))
           )
          (t NIL))))

     (setf points-sublist 
           (make-graph-points-sublist  syms-sublist 
                                         :x-pix x-pix :topsym-points-sym topsym-points-sym
                                          :use-label-abbrev-p t  :add-label-p t
                                         :begin-dims  begin-dims  :end-dims end-dims
                                         :initial-x-pix initial-x-pix :incr-x-pix incr-x-pix
                                         :append-symvals-p append-symvals-p))

     (when pre-items
       (setf points-sublist (append  pre-items (list points-sublist))))     

     (setf all-sym-points-list (append all-sym-points-list (list points-sublist)))

     ;;if a simple list without sublists--no need for loop
     (when return-after-make-p
       (setf all-sym-points-list points-sublist)
       (return))
     ;;end let, loop
     ))

    ;;FOR 2-dim NESTED LISTS
    ;;nested-list-goal:  ((:DIMSIM 1 (1 (40 110) WUP1-1 (1 1)) (2 (80 200) WUP1-2 (2 1))) (:DIMSIM 2 (1 (40 50) WUP1-2 (1 2)) (2 (80 20) WUP2-2 (2 2))))
;;eg (sort-art-list-into-nested-lists  '((1 (40 110) WUP1-1 (1 1)) (2 (80 200) WUP1-2 (1 2))(1 (40 50) WUP2-1 (2  1)) (2 (80  20) WUP2-2 (2 2)))  :pre-add-dim-n-p T :preitems '(:DIMSIM)  :double-quote-nested-item-p T :sortdim-n 1 )
;;results= ((:DIMSIM 1 ((1 (40 110) WUP1-1 (1 1)) (2 (80 200) WUP1-2 (1 2)))) (:DIMSIM 2 ((1 (40 50) WUP2-1 (2 1)) (2 (80 20) WUP2-2 (2 2)))))

    ;;(afout 'out (format nil "dimspec-lists2= ~A~%  flat-points-list= ~A~%"  dimspec-lists2   flat-points-list))
    
    ;;(afout 'out (format nil "3 topsym-points-sym= ~A~%" topsym-points-sym))

    (set topsym-points-sym all-sym-points-list)

    ;;use instead? (set class-points-sym flat-points-list)

    (values topsym-points-sym  all-sym-points-list)
    ;;end let*, make-graph-points-list
    ))
;;TEST  
;; (progn (setf out nil) (make-graph-points-list  'WUPI-3-2TOI-1-3 :sortdim-n 5))
;; WORKS  SORTS BY SECOND DIM, sortdim-n 5
;;((:DIMSIM 1 ((1 (40 0.5105166) "Wup1-3" (1 3 2 TO 1 1 3)) (2 (80 0.50084305) "Wup1-3" (2 3 2 TO 1 1 3)) (3 (120 0.506335) "Wup1-3" (3 3 2 TO 1 1 3)) (4 (160 0.50858957) "Wup1-3" (4 3 2 TO 1 1 3)) (5 (200 0.505834) "Wup1-3" (5 3 2 TO 1 1 3)) (6 (240 0.49444544) "Wup1-3" (6 3 2 TO 1 1 3)) (7 (280 0.5074334) "Wup1-3" (7 3 2 TO 1 1 3)) (8 (320 0.505121) "Wup1-3" (8 3 2 TO 1 1 3)) (9 (360 0.5001686) "Wup1-3" (9 3 2 TO 1 1 3)))) (:DIMSIM 2 ((1 (40 0.4371) "Wup1-3" (1 3 2 TO 2 1 3)) (2 (80 0.4115) "Wup1-3" (2 3 2 TO 2 1 3)) (3 (120 0.49379998) "Wup1-3" (3 3 2 TO 2 1 3)) (4 (160 0.4324) "Wup1-3" (4 3 2 TO 2 1 3)) (5 (200 0.43400002) "Wup1-3" (5 3 2 TO 2 1 3)) (6 (240 0.4487) "Wup1-3" (6 3 2 TO 2 1 3)) (7 (280 0.4469) "Wup1-3" (7 3 2 TO 2 1 3)) (8 (320 0.4356) "Wup1-3" (8 3 2 TO 2 1 3)) (9 (360 0.4146) "Wup1-3" (9 3 2 TO 2 1 3)))) (:DIMSIM 3 ((1 (40 0.4881) "Wup1-3" (1 3 2 TO 3 1 3)) (2 (80 0.4016) "Wup1-3" (2 3 2 TO 3 1 3)) (3 (120 0.4486) "Wup1-3" (3 3 2 TO 3 1 3)) (4 (160 0.4781) "Wup1-3" (4 3 2 TO 3 1 3)) (5 (200 0.464) "Wup1-3" (5 3 2 TO 3 1 3)) (6 (240 0.40850002) "Wup1-3" (6 3 2 TO 3 1 3)) (7 (280 0.4839) "Wup1-3" (7 3 2 TO 3 1 3)) (8 (320 0.483) "Wup1-3" (8 3 2 TO 3 1 3)) (9 (360 0.4021) "Wup1-3" (9 3 2 TO 3 1 3)))) (:DIMSIM 4 ((1 (40 0.4057) "Wup1-3" (1 3 2 TO 4 1 3)) (2 (80 0.44370002) "Wup1-3" (2 3 2 TO 4 1 3)) (3 (120 0.4176) "Wup1-3" (3 3 2 TO 4 1 3)) (4 (160 0.4251) "Wup1-3" (4 3 2 TO 4 1 3)) (5 (200 0.4363) "Wup1-3" (5 3 2 TO 4 1 3)) (6 (240 0.4969) "Wup1-3" (6 3 2 TO 4 1 3)) (7 (280 0.4744) "Wup1-3" (7 3 2 TO 4 1 3)) (8 (320 0.4364) "Wup1-3" (8 3 2 TO 4 1 3)) (9 (360 0.4736) "Wup1-3" (9 3 2 TO 4 1 3)))) (:DIMSIM 5 ((1 (40 0.47390002) "Wup1-3" (1 3 2 TO 5 1 3)) (2 (80 0.4934) "Wup1-3" (2 3 2 TO 5 1 3)) (3 (120 0.4178) "Wup1-3" (3 3 2 TO 5 1 3)) (4 (160 0.476) "Wup1-3" (4 3 2 TO 5 1 3)) (5 (200 0.4059) "Wup1-3" (5 3 2 TO 5 1 3)) (6 (240 0.4372) "Wup1-3" (6 3 2 TO 5 1 3)) (7 (280 0.4342) "Wup1-3" (7 3 2 TO 5 1 3)) (8 (320 0.4898) "Wup1-3" (8 3 2 TO 5 1 3)) (9 (360 0.4151) "Wup1-3" (9 3 2 TO 5 1 3)))))
;;


;;;; (progn (setf out nil)(make-graph-points-list  'WUPI-3-2TOI-1-3  :dimlabel :dimsim :sortdim-n  1 :nest-syms-p T :setsym-2dim-nested-lists-p T))
;;WORKS= 
;;*WUPI-3-2TOI-1-3-POINTS  NIL
;;((:DIMSIM 1 ((1 (40 0.4695) "Wup1-3" (1 3 2 TO 1 1 3)) (2 (80 0.4776) "Wup1-3" (1 3 2 TO 2 1 3)) (3 (120 0.4589) "Wup1-3" (1 3 2 TO 3 1 3)) (4 (160 0.4542) "Wup1-3" (1 3 2 TO 4 1 3)) (5 (200 0.425) "Wup1-3" (1 3 2 TO 5 1 3)))) (:DIMSIM 2 ((1 (40 0.4005) "Wup1-3" (2 3 2 TO 1 1 3)) (2 (80 0.4138) "Wup1-3" (2 3 2 TO 2 1 3)) (3 (120 0.4622) "Wup1-3" (2 3 2 TO 3 1 3)) (4 (160 0.4287) "Wup1-3" (2 3 2 TO 4 1 3)) (5 (200 0.4099) "Wup1-3" (2 3 2 TO 5 1 3)))) .....      (:DIMSIM 9 ((1 (40 0.4068) "Wup1-3" (9 3 2 TO 1 1 3)) (2 (80 0.459) "Wup1-3" (9 3 2 TO 2 1 3)) (3 (120 0.461) "Wup1-3" (9 3 2 TO 3 1 3)) (4 (160 0.449) "Wup1-3" (9 3 2 TO 4 1 3)) (5 (200 0.40240002) "Wup1-3" (9 3 2 TO 5 1 3)))))
;;by dim-n 5
;; (progn (setf out nil)(make-graph-points-list  'WUPI-3-2TOI-1-3  :dimlabel :dimsim :sortdim-n  5 :nest-syms-p T :setsym-2dim-nested-lists-p T))
;;WORKS= 
;;*WUPI-3-2TOI-1-3-POINTS NIL
;;((:DIMSIM 1 ((1 (40 0.4695) "Wup1-3" (1 3 2 TO 1 1 3)) (2 (80 0.4005) "Wup1-3" (2 3 2 TO 1 1 3)) (3 (120 0.4864) "Wup1-3" (3 3 2 TO 1 1 3)) (4 (160 0.491) "Wup1-3" (4 3 2 TO 1 1 3)) (5 (200 0.4697) "Wup1-3" (5 3 2 TO 1 1 3)) (6 (240 0.48909998) "Wup1-3" (6 3 2 TO 1 1 3)) (7 (280 0.4478) "Wup1-3" (7 3 2 TO 1 1 3)) (8 (320 0.4258) "Wup1-3" (8 3 2 TO 1 1 3)) (9 (360 0.4068) "Wup1-3" (9 3 2 TO 1 1 3)))). . . . . . . . (:DIMSIM 5 ((1 (40 0.425) "Wup1-3" (1 3 2 TO 5 1 3)) (2 (80 0.4099) "Wup1-3" (2 3 2 TO 5 1 3)) (3 (120 0.4617) "Wup1-3" (3 3 2 TO 5 1 3)) (4 (160 0.4256) "Wup1-3" (4 3 2 TO 5 1 3)) (5 (200 0.49019998) "Wup1-3" (5 3 2 TO 5 1 3)) (6 (240 0.4228) "Wup1-3" (6 3 2 TO 5 1 3)) (7 (280 0.419) "Wup1-3" (7 3 2 TO 5 1 3)) (8 (320 0.4063) "Wup1-3" (8 3 2 TO 5 1 3)) (9 (360 0.40240002) "Wup1-3" (9 3 2 TO 5 1 3)))))

;;  (make-graph-points-list  'X  :begin-dims  '(I  2  1) :end-dims '(I  2  1)) 
;;  (make-graph-points-list  'XI-2-2) 
;;  works= *XI-2-2-POINTS
;; ((1 (40 NIL) "X1-2-2" (1 2 2)) (2 (80 NIL) "X2-2-2" (2 2 2)) (3 (120 NIL) "X3-2-2" (3 2 2)) (4 (160 NIL) "X4-2-2" (4 2 2)) (5 (200 NIL) "X5-2-2" (5 2 2)) (6 (240 NIL) "X6-2-2" (6 2 2)) (7 (280 NIL) "X7-2-2" (7 2 2)) (8 (320 NIL) "X8-2-2" (8 2 2)) (9 (360 NIL) "X9-2-2" (9 2 2)))   NIL
;;also *XI-2-2-POINTS = ((1 (40 NIL) "X1-2-2" (1 2 2)) (2 (80 NIL) "X2-2-2" (2 2 2)) (3 (120 NIL) "X3-2-2" (3 2 2)) (4 (160 NIL) "X4-2-2" (4 2 2)) (5 (200 NIL) "X5-2-2" (5 2 2)) (6 (240 NIL) "X6-2-2" (6 2 2)) (7 (280 NIL) "X7-2-2" (7 2 2)) (8 (320 NIL) "X8-2-2" (8 2 2)) (9 (360 NIL) "X9-2-2" (9 2 2)))

;; (progn (setf out nil)(make-graph-points-list  'WUPI-3-2TOI-1-3 :setsym-2dim-nested-lists-p T))

;; (progn (setf out nil)(make-graph-points-list  'WUPI-3-2TOI-1-3 :setsym-2dim-nested-lists-p NIL))
;; works= *WUPI-3-2TOI-1-3-POINTS
;;((1 (40 NIL) "Wup1-3" (1 3 2 TO 1 1 3)) (1 (80 NIL) "Wup1-3" (1 3 2 TO 2 1 3)) (1 (120 NIL) "Wup1-3" (1 3 2 TO 3 1 3)) (1 (160 NIL) "Wup1-3" (1 3 2 TO 4 1 3)) (1 (200 NIL) "Wup1-3" (1 3 2 TO 5 1 3)) (2 (240 NIL) "Wup1-3" (2 3 2 TO 1 1 3)) (2 (280 NIL) "Wup1-3" (2 3 2 TO 2 1 3)) (2 (320 NIL) "Wup1-3" (2 3 2 TO 3 1 3)) (2 (360 NIL) "Wup1-3" (2 3 2 TO 4 1 3)) (2 (400 NIL) "Wup1-3" (2 3 2 TO 5 1 3)) (3 (440 NIL) "Wup1-3" (3 3 2 TO 1 1 3)) (3 (480 NIL) "Wup1-3" (3 3 2 TO 2 1 3)) (3 (520 NIL) "Wup1-3" (3 3 2 TO 3 1 3)) (3 (560 NIL) "Wup1-3" (3 3 2 TO 4 1 3)) (3 (600 NIL) "Wup1-3" (3 3 2 TO 5 1 3)) (4 (640 NIL) "Wup1-3" (4 3 2 TO 1 1 3)) (4 (680 NIL) "Wup1-3" (4 3 2 TO 2 1 3)) (4 (720 NIL) "Wup1-3" (4 3 2 TO 3 1 3)) (4 (760 NIL) "Wup1-3" (4 3 2 TO 4 1 3)) (4 (800 NIL) "Wup1-3" (4 3 2 TO 5 1 3)) (5 (840 NIL) "Wup1-3" (5 3 2 TO 1 1 3)) (5 (880 NIL) "Wup1-3" (5 3 2 TO 2 1 3)) (5 (920 NIL) "Wup1-3" (5 3 2 TO 3 1 3)) (5 (960 NIL) "Wup1-3" (5 3 2 TO 4 1 3)) (5 (1000 NIL) "Wup1-3" (5 3 2 TO 5 1 3)) (6 (1040 NIL) "Wup1-3" (6 3 2 TO 1 1 3)) (6 (1080 NIL) "Wup1-3" (6 3 2 TO 2 1 3)) (6 (1120 NIL) "Wup1-3" (6 3 2 TO 3 1 3)) (6 (1160 NIL) "Wup1-3" (6 3 2 TO 4 1 3)) (6 (1200 NIL) "Wup1-3" (6 3 2 TO 5 1 3)) (7 (1240 NIL) "Wup1-3" (7 3 2 TO 1 1 3)) (7 (1280 NIL) "Wup1-3" (7 3 2 TO 2 1 3)) (7 (1320 NIL) "Wup1-3" (7 3 2 TO 3 1 3)) (7 (1360 NIL) "Wup1-3" (7 3 2 TO 4 1 3)) (7 (1400 NIL) "Wup1-3" (7 3 2 TO 5 1 3)) (8 (1440 NIL) "Wup1-3" (8 3 2 TO 1 1 3)) (8 (1480 NIL) "Wup1-3" (8 3 2 TO 2 1 3)) (8 (1520 NIL) "Wup1-3" (8 3 2 TO 3 1 3)) (8 (1560 NIL) "Wup1-3" (8 3 2 TO 4 1 3)) (8 (1600 NIL) "Wup1-3" (8 3 2 TO 5 1 3)) (9 (1640 NIL) "Wup1-3" (9 3 2 TO 1 1 3)) (9 (1680 NIL) "Wup1-3" (9 3 2 TO 2 1 3)) (9 (1720 NIL) "Wup1-3" (9 3 2 TO 3 1 3)) (9 (1760 NIL) "Wup1-3" (9 3 2 TO 4 1 3)) (9 (1800 NIL) "Wup1-3" (9 3 2 TO 5 1 3)))   NIL
;; PPRINT



;; (make-graph-points-list  'XI-2-2)
;; works= *XI-2-2-POINTS    ((1 (40 0) "X1-2-2" (1 2 2)) (2 (80 0) "X2-2-2" (2 2 2)) (3 (120 0) "X3-2-2" (3 2 2)) (4 (160 0) "X4-2-2" (4 2 2)) (5 (200 0) "X5-2-2" (5 2 2)) (6 (240 0) "X6-2-2" (6 2 2)) (7 (280 0) "X7-2-2" (7 2 2)) (8 (320 0) "X8-2-2" (8 2 2)) (9 (360 0) "X9-2-2" (9 2 2)))   NIL
;; 
;;  (make-graph-points-list  'WUPI-L-FTOI-L-F) 
;;  RESULTS = NIL  (WUPI-L-FTOI-L-F WUPI-L-FTOI-L-1 WUPI-L-FTOI-L-2 WUPI-L-FTOI-L-3 WUPI-L-FTOI-L-4 WUPI-L-FTOI-L-5)  NIL 
;; NOTE: bottom-instances = NIL because WUP set up starting with WUPI-3-2TOI-1-3 and it doesn't connect with top-level


;;FIND-ARTSYM-DIMS-RANGE
;;
;;ddd
(defun find-artsym-dims-range (artsym &key (node-sep *art-node-separator))
  "In U-ART, RETURNS begin-dims end-dims of a range of bottom level syms that will fall within the range specified by the artsym"
  (let
      (
       (dims-list)
       (begin-dims)
       (end-dims)
       )
    (multiple-value-setq (dims-list rootstr)
        (find-art-dims artsym))
    ;;(find-art-dims 'wupI-3-2TOI-1-3) = (I 3 2 TO I 1 3)  or  xi-2-2 = (i 2 2)

    (setf begin-dims dims-list
          end-dims dims-list)
    (values begin-dims end-dims)
    ;;end let, find-artsym-dims-range
    ))
;;TEST
;;  (find-artsym-dims-range 'wupI-3-2TOI-1-3)





;;MEMBER-DIMS-RANGE
;;
;;ddd
(defun member-dims-range (dims begin-dims end-dims 
                              &key  (all-dims-numberp T) (node-sep *art-node-separator))
  "In U-ART, checks members of list dims eg (I L 3) to see if in range of begin-dims to end-dims eg (I L 2) to (I L 6). RETURNS  (values T or NIL plus dim). all-dims-numberp refers ONLY to arg dims."
  (let
      ((result)
       (n-dims (list-length dims))
       (index-sym)
       (dim1)
       )
;; (afout 'out2 (format nil "1 dim= ~A begin-dim= ~A end-dim= ~A result= ~A~%"dim begin-dim end-dim result))
    (loop
     for dim in dims
     for begin-dim in begin-dims
     for end-dim in end-dims
     for n from 0 upto n-dims
     do
     (setf dim1 dim)
    ;;(afout 'out2 (format nil "AT 1: dim= ~A begin-dim= ~A  end-dim= ~A  n= ~A" dim begin-dim  end-dim  n )) 
     ;;(setf index-sym (nth n index-syms))

     (cond
      ((equal dim node-sep) NIL)
      ;;if dims must be all numbers
      ((and all-dims-numberp (not (numberp dim)))
       (setf result nil) (return))
      ;;if number in range, OK
      ((and (numberp dim)(numberp begin-dim)(numberp end-dim)
        (>= dim begin-dim) (<= dim end-dim))
       (setf result T))
      ((and (numberp dim)(numberp begin-dim)(numberp end-dim)
       (or (< dim begin-dim)
            (> dim end-dim)))
       (setf result NIL)(return))
      ;; if any number and either begin or end dim is a letter, OK
      ((and (or (equal dim begin-dim)(equal dim end-dim)))
       (setf result T))
      ((and (numberp dim)
            (or (not (numberp begin-dim))(not (numberp end-dim))))
       (setf result T))
      ;;otherwise, NOT OK
      (t (setf result NIL) 
         (return)))
     ;;if any dims don't meet test, return NIL
     ;;(afout 'out2 (format nil "2 dim= ~A begin-dim= ~A end-dim= ~A result= ~A~%" dim begin-dim end-dim result))

     ;;end loop thru dims
     )
    (values result dim1)
    ;;end let, member-dim-range
    ))
;;TEST
;; (member-dims-range '(2 3 3) '(i 2 2) '(i 2 2)) = NIL 3
;; (member-dims-range '(2 2 2) '(i 2 2) '(i 2 2))  = T  2
;;  (member-dims-range '(I L 4) '(I L 2) '(I L 6) :all-dims-numberp nil) = T 4
;;  (member-dims-range '(I L 4) '(I L 2) '(I L 6)) = NIL  I  (because dims include non integers
;;   (member-dims-range '(I 2 3 TO I 1 3 ) '(I 2 3 TO I 1 3) '(I 2 3 TO I 1 3)) = NIL  I 
;;  (member-dims-range '(I 2 3 TO I 1 3 ) '(I 2 3 TO I 1 3) '(I 2 3 TO I 1 3)   :all-dims-numberp nil)  =  T 3
;;  (member-dims-range '(3 2 3 TO 9 1 3 ) '(I  2 3 TO I 1 3) '(I 2 3 TO I  1 3)) = T  3




;;PRE-ART3
#|(defun make-graph-points-list (class-sym &key  
                                         (initial-x-pix 0) (incr-x-pix 40)
                                           append-symvals-p
                                         (use-label-abbrev-p T) (add-label-p T)
                                         (setsym-2dim-nested-lists-p T)
                                         (sortdim-n 1))
  "In ART.lisp, NOTE: Class-sym should incl dims (eg XI-L-F).  initial-x-pix and incr-x-pix can be a value OR a list of values--single value used for all, list values must match num cells. Takes N dim arrays RETURNS (values class-points-sym flat-points-list nested-points-list)   eg. (PUT EG HERE SSS  ). setsym-2dim-nested-lists-p returns nested list if 2dim, otherwise flat. NOTE: if n-dims >= 2, syms are nested by all F1 together first level, F2 groups of F1 ((C11 C21)(C12 C22)), Eg. 1-dim: *INPUT-POINTS = '((:DIMSIM 1 ((1 (40 110) INPUT1 (1)) (2 (80 222 ) INPUT2 (2)) (3 (120 333) INPUT2 (3))))), for 2-dim: *WUP-POINTS = ((:DIMSIM 1 ((1 (40 110) WUP1-1 (1 1)) (2 (80 200) WUP1-2 (2 1)))) (:DIMSIM 2 ((1 (40 50) WUP1-2 (1 2)) (2 (80  20) WUP2-2 (2 2)))))."

  ;;SYM egs  INPUTI-1-1 XI-2-2 WUPI-3-2TOI-1-3
  (let*
      (;;(class-symvals (eval class-sym)) 
       ;;(syms (second class-symvals))
       (flat-sym-list (find-bottom-art-instances class-sym)) ;;was (flatten-count-nested-lists syms))
       (n-syms (list-length flat-sym-list))
       (firstsym-symvals (eval (car flat-sym-list)))
       (firstsym-dims (second firstsym-symvals))
       (n-dims (dimlist-length firstsym-dims))
       (symroot (first firstsym-symvals))
       (firstsym-lastelem-n (third  firstsym-symvals))
       (n-field2-groups 1)  
       (firstF1-n)
       (flat-points-list)
       (new-symvals-list)
       (new-values)
       (old-values)
       (sym-count)
       (value-count)
       (x-pix initial-x-pix)
       (y-pix 0)
       ;;(label "")
       (x-val initial-x-pix)
       (class-points-sym-str)
       (class-points-sym)
       (points-list)
       (nested-points-list)
       (dims)
       (sym-i)
       (sym-j)  
       )
    ;;(afout 'out (format nil "1 flat-sym-list= ~A~%" flat-sym-list))

    ;;make the graph-points-list points-sym
    (setf  class-points-sym-str (format nil "*~A-points" class-sym) ;;was symroot
           class-points-sym (my-make-symbol class-points-sym-str))
    ;;(afout 'out (format nil "1 class-points-sym= ~A~%" class-points-sym))
 
    ;;MAKE THE GRAPHING VALUES TO ADD 
    ;;from draw-graph-window function, points-list input eg.:  ((:DIMSIM 1 ((1 (40 110) WUP1-1 (1 1)) (2 (80 200) WUP1-2 (2 1)))) (:DIMSIM 2 ((1 (40 50) WUP1-2 (1 2)) (2 (80  20) WUP2-2 (2 2)))))
    (loop
     for sym in flat-sym-list
     for n from 1 to n-syms
     do
     (let*
         ((symvals (eval sym))
          (root (first symvals))
          (lastfield-n (third symvals))
          (value (fourth symvals))
          (point)
          (preitems)
          ;;sss write abbreviate-sym later
          (label-abbrev)    ;;in config-art
          ) 

       (setf dims (second symvals)
             n-dims (dimlist-length dims)
             sym-i (car dims)
             sym-j (second dims))
       ;;(break)

       ;;Include label or abbrev in point?
       (cond
        ((null add-label-p) NIL)
        (use-label-abbrev-p
         (setf label-abbrev (abbreviate-sym-str sym *graph-sym-abrv-begin-n *graph-sym-abrv-end-n)))
        (t (setf  label-abbrev sym)))
      
       ;;SET THE PIXELS FOR GRAPH
       (setf x-pix (+ x-pix incr-x-pix)
             point (list sym-i (list x-pix value) label-abbrev dims))


       ;;MAKE FLAT POINTS LIST
       (setf flat-points-list (append flat-points-list (list point)))

       ;;(afout 'out (format nil "2 class-points-sym= ~A~%" class-points-sym))
       ;;when want to add point to cell/sym symvals
       (when append-symvals-p
         (multiple-value-setq (new-symvals-list new-values old-values 
                                                sym-count value-count )
             (set-class-symval class-sym dims  :append-value-p t)))

       ;;end inner let*,loop
       ))

    ;;FOR 2-dim NESTED LISTS
    ;;nested-list-goal ((:DIMSIM 1 (1 (40 110) WUP1-1 (1 1)) (2 (80 200) WUP1-2 (2 1))) (:DIMSIM 2 (1 (40 50) WUP1-2 (1 2)) (2 (80 20) WUP2-2 (2 2))))
    (when (and (= n-dims 2) setsym-2dim-nested-lists-p)
      (cond
       ((equal class-sym 'wupi-3-2) (setf sort2dim-n *sort-wup-dim))
       ((equal class-sym 'wdni-1-3) (setf sort2dim-n *sort-wdn-dim))
       (t nil))
      (setf nested-points-list (sort-art-list-into-nested-lists  flat-points-list
                                                                 :sortdim-n sort2dim-n 
                                                                 :pre-add-dim-n-p T 
                                                                 :preitems '(:DIMSIM) 
                                                                 :double-quote-nested-item-p T
                                                                 :x-pix0 40 :x-pix-incr *incr-x-pix)))

    ;;first item is (dimlist dimlist etc), 2nd (1 2 3 4...), only 3rd useful
    ;;(setf nested-points-list (third nested-points-list))
    
    ;;(afout 'out (format nil "3 class-points-sym= ~A~%" class-points-sym))
    (cond
     ((and (= n-dims 2) setsym-2dim-nested-lists-p)
      (set class-points-sym nested-points-list))
     (t (set class-points-sym flat-points-list)))

    ;;use instead? (set class-points-sym flat-points-list)

    (values class-points-sym flat-points-list nested-points-list)
    ;;end let*, make-graph-points-list
    ))|#
;;OLD ---------------------------------
;; (make-graph-points-list  'input)
;;works= *INPUT-POINTS    ((1 (40 0.033760004) "Input1" (1)) (2 (80 0.070879996) "Input2" (2)) (3 (120 -0.021760002) "Input3" (3)) (4 (160 0.97904) "Input4" (4)) (5 (200 1.05632) "Input5" (5)) (6 (240 0.92912) "Input6" (6)) (7 (280 0.05392) "Input7" (7)) (8 (320 0.05088) "Input8" (8)) (9 (360 -0.006240003) "Input9" (9)))    NIL
;;also *INPUT-POINTS evals to above list
;;  (make-graph-points-list  'wup)
;;works=  *WDN-POINTS
;;  ((1 (40 0.86669004) "Wdn1-1" (1 1)) (1 (80 0.8019) "Wdn1-2" (1 2)) (1 (120 0.89576) "Wdn1-3" (1 3)) (1 (160 0.8133) "Wdn1-4" (1 4)) (1 (200 0.83268) "Wdn1-5" (1 5)) (1 (240 0.91058004) "Wdn1-6" (1 6)) (1 (280 0.87296004) "Wdn1-7" (1 7)) (1 (320 0.80532) "Wdn1-8" (1 8)) (1 (360 0.81729) "Wdn1-9" (1 9)) (2 (400 0.8526331) "Wdn2-1" (2 1)) (2 (440 0.88569314) "Wdn2-2" (2 2)) (2 (480 1.6516918) "Wdn2-3" (2 3)) (2 (520 63.665223) "Wdn2-4" (2 4))  ...... rest
;;((:DIMSIM 1 ((1 (40 0.081907004) "Wup1-1" (1 1)) (1 (80 0.33341035) "Wup1-2" (1 2)) (1 (120 0.033630997) "Wup1-3" (1 3)) (1 (160 0.025734) "Wup1-4" (1 4)) (1 (200 0.137335) "Wup1-5" (1 5)))) (:DIMSIM 2 ((2 (40 0.086675) "Wup2-1" (2 1)) (2 (80 8.843666) "Wup2-2" (2 2)) (2 (120 0.033184) "Wup2-3" (2 3)) (2 (160 0.061941) "Wup2-4" (2 4)) (2 (200 0.085036) "Wup2-5" (2 5)))) (:DIMSIM 3 ((3 (40 0.13629201) "Wup3-1" (3 1)) (3 (80 28.409277) "Wup3-2" (3 2)) (3 (120 0.013963) "Wup3-3" (3 3)) (3 (160 0.13837801) "Wup3-4" (3 4)) (3 (200 0.10768401) "Wup3-5" (3 5))))  ... plus rest.
;;(make-graph-points-list  'wup  :group-by-F1-p T)


;;ABBREVIATE-SYM-STR
;;
;;ddd
(defun abbreviate-sym-str (sym  n-begin-digits n-end-digits &key (add-dims-p T) (abbrev-sym-root-p T)) ;;not work  (separator #\-)) ;;  "-"))  ;;or "-"
  "In U-ART, sym can be a symbol or string. Works ONLY on an ART sym that is set to a list such as (\"Input1\" (1)) or wup2-3 = (\"Wup\" (2 3) 5 NIL) If change separator betw dims, must manually replace the hyphen in code  below. RETURNS (values new-str symvals)"
  ;; sss START HERE, MUST CONVERT SYMBOL TO A STRING FIRST
  (let
      ((symvals)
       (begin-str "")
       (end-str "")
       (new-str )
       (dims-str "")
       (sym-str)
       (sym-length) ;; (length sym))
       ;;  (begin 0)
       (end 3)
       )
    ;;if sym a string, then work on it and don't try to eval it
    (when (stringp sym)
      (setf abbrev-sym-root-p nil))

    (cond
     ((null abbrev-sym-root-p)
      (setf sym-str sym))
     ((and (boundp sym) (listp (setf symvals (eval sym))))
      (setf sym-str (car symvals)
            dims (second symvals))
      ;;add the dims to string?
      (when add-dims-p
        (setf dims-str (format nil "~{~a~^-~}" dims) ;;not work  separator)
              sym-str (format nil "~A~A" sym-str dims-str)))
      )
     (t nil))

    (when (stringp sym-str)
      (setf sym-length (length sym-str))  
      ;;(afout 'out (format nil "sym-str= ~A~%" sym-str))

      ;;make the begin-str and end-str and abbreviate if not longer than original
      (cond
       ;;not shorter than original 
       ((>= (+ (- n-begin-digits 1) n-end-digits) sym-length)
        (setf new-str  sym-str)) ;;added extra (format nil "~A~A" sym-str dims-str)))
       (t (setf   end (- sym-length  n-end-digits )
                  begin-str (subseq sym-str  0  n-begin-digits)
                  end-str (subseq sym-str end)
                  new-str (format nil "~A~A" begin-str end-str))))
      ;;end when
      )
    (values new-str symvals)
    ;;end mvb,let,abbreviate-sym
    ))
;;TEST
;; (abbreviate-sym-str  'wup3-4  2 3)  = "Wu3-4"  ("Wup" (3 4) 5 NIL) 
 ;; (abbreviate-sym-str  "wup3-4"  2 3)  = "wu3-4"  NIL  ;;from string not symbol
;;  (abbreviate-sym-str  'input2 2 2) =  "int2"  ("input" (2) 3 0.22) = "it2"  ("input" (2) 3 0.22)
;;  (abbreviate-sym-str  'input2 4 4) = "input2"  ("input" (2) 3 0.22)


;;WRITE-CELL-TEXT
;;
;;ddd
(defun write-cell-text (rich-text-pane art-point-lists &key pane-label
                                       font-list graph-color-list )
  "In U-ART, If  (NULL rich-text-pane), then just returns the text. RETURNS (values info-text MAX-VALUE point-label-list point-value-list)  INPUT: art-point-list egs. *INPUT-POINTS = ((1 (40 0.11) \"input1\" (1)) (2 (80 0.22) \"input2\" (2)) (3 (120 0.33) \"input3\" (3))), for 2-dim: *WUP-POINTS = ((:DIMSIM 1 ((1 (40 0.11) \"wup1-1\" (1 1)) (1 (80 0.12) \"wup1-2\" (1 2)))) (:DIMSIM 1 ((1 (40 0.12) \"wup1-2\" (1 2)) (2 (80 0.22) \"wup2-2\" (2 2)))))."
  (let
      ((dimlist-n 1)
       (point-n)
       (point-list)
       (point-info-list)
       (point-label-list)
       (point-value-list)
       (pix-point-label-lists)
       (font) 
       (value)
       (x-pix)
       (label)
       (dim1)
       (last-dim)
       (info-text "")
       (color-text "")
       (n-point-lists (list-length art-point-lists))
       (multi-dim-list-p)
       )
    (if (equal (caar  art-point-lists) :dimsim)  (setf multi-dim-list-p T))

    (loop
     for art-point-list in art-point-lists
     do
     (cond
      ((equal (car art-point-list) :DIMSIM)
       (setf dimlist-n (second art-point-list)
             point-list (third art-point-list)))
             ;;multi-dim-list-p T))
      (t (setf point-list (list art-point-list))))

     ;;make the point-info-list
    (loop
     for point in point-list
     do     
     (multiple-value-setq (value x-pix label dim1 last-dim)
         (find-point-value point))
       (setf point-info-list (append point-info-list (list label value))
             point-label-list (append point-label-list (list label))
             point-value-list (append point-value-list (list value)))
       ;;end loops
       ))

    ;;(afout 'out (format nil ">>>> graph-color-list= ~A  multi-dim-list-p= ~A  n-point-lists= ~A~%" graph-color-list  multi-dim-list-p  n-point-lists 1) )
    ;;LIST DIM-COLOR FOR GRAPH LINES
      (when  (and graph-color-list  multi-dim-list-p  (> n-point-lists 1)) 
        (setf color-text  "[DIM 1:")
        (loop
         for n from 1 to n-point-lists
         for color in graph-color-list
         do
         (setf color-text (format nil "~A ~A=~A" color-text  n color))
         )
        (setf color-text (format nil "~A]" color-text))
        )
      

    ;;GET MAX-MIN INFO
    (multiple-value-bind (max-value max-val-ptnum max-val-ptlabel min-value  min-val-ptnum min-val-ptlabel)
        (find-max-min-points-list art-point-lists)

      (unless pane-label (setf  pane-label "VARS-VALS:"))
      ;;write the info-text
      (setf info-text
            (format nil "~%~A MAX=~A at ~A,~A; MIN=~A at ~A,~A  ~A  >>ALL==>  ~{~S= ~S  ~} " pane-label  max-value max-val-ptnum max-val-ptlabel min-value  min-val-ptnum min-val-ptlabel color-text point-info-list))

      ;;if write to a window
      (when  rich-text-pane        
        ;;sss  creates error (my-find-best-font rich-text-pane font-list )
        ;;set the new font here
        ;; (setf (capi:simple-pane-font rich-text-pane) font)
        ;;write the text
        (setf (capi:rich-text-pane-text  rich-text-pane) info-text))

      (values info-text MAX-VALUE point-label-list point-value-list)
      ;;end mvb, let, write-cell-text
      )))
;;TEST
;; without a pane
;; (write-cell-text nil *wup-points :graph-color-list *graph-color-list)
;; (write-cell-text nil *input-points :graph-color-list *graph-color-list)
;; works= VARIABLES and VALUES:    \"input1\"= 0.11  \"input2\"= 0.22  \"input3\"= 0.33   "    ("input1" "input2" "input3")    (0.11 0.22 0.33)
;;
;; (write-cell-text nil  *wup-points) =   \"Wup1-1\"= 0.081907004  \"Wup1-2\"= 0.33341035  \"Wup1-3\"= 0.033630997  \"Wup1-4\"= 0.025734  \"Wup1-5\"= 0.137335  \"Wup2-1\"= 0.086675  \"Wup2-2\"= 8.843666  \"Wup2-3\"= 0.033184  \"Wup2-4\"= 0.061941  \"Wup2-5\"= 0.085036  \"Wup3-1\"= 0.13629201  \"Wup3-2\"= 28.409277  \"Wup3-3\"= 0.013963  \"Wup3-4\"= 0.13837801  \"Wup3-5\"= 0.10768401  \"Wup4-1\"= 0.048382 ...etc.
;; ("Wup1-1" "Wup1-2" "Wup1-3" "Wup1-4" "Wup1-5" "Wup2-1" "Wup2-2" "Wup2-3" "Wup2-4" "Wup2-5" "Wup3-1" "Wup3-2" "Wup3-3" "Wup3-4" "Wup3-5" "Wup4-1" "Wup4-2" "Wup4-3" "Wup4-4" "Wup4-5" "Wup5-1" "Wup5-2" "Wup5-3" "Wup5-4" "Wup5-5" "Wup6-1" "Wup6-2" "Wup6-3" "Wup6-4" "Wup6-5" "Wup7-1" "Wup7-2" "Wup7-3" "Wup7-4" "Wup7-5" "Wup8-1" "Wup8-2" "Wup8-3" "Wup8-4" "Wup8-5" "Wup9-1" "Wup9-2" "Wup9-3" "Wup9-4" "Wup9-5")
;;(0.081907004 0.33341035 0.033630997 0.025734 0.137335 0.086675 8.843666 0.033184 0.061941 0.085036 0.13629201 28.409277 0.013963 0.13837801 0.10768401 0.048382 358.85248 0.121839 0.145977 0.019178002 0.015453001 14.874984 0.10768401 0.119008005 0.114240006 0.135845 16.450892 0.09174101 0.045104 0.13778201 0.072371006 0.28825817 0.026330002 0.018731002 0.12139201 0.12496801 368.434 0.085036 0.111707 0.064027004 0.056428 340.56998 0.036909 0.006364 0.136143)


;;(capi:contain (write-cell-text nil *input-points))

 #|(capi:contain  
   (make-instance 'capi:rich-text-pane
                  :text (write-cell-text nil *input-points)
                  :font (gp:make-font-description
                         :family "times" 
                         :size 12 
                         :weight :medium                         
                         :slant :roman)))|#
 ;;above works

;;FIND-POINT-VALUES
;;
;;ddd
(defun find-point-value (art-point)
  "In U-ART, Eg (1 (40 0.11) \"wup1-1\" (1 1))"
  (multiple-value-bind (point-n  pix-val-list label dims)
      (values-list art-point)
    (let
        ((x-pix (car pix-val-list))
         (value (second pix-val-list))
         (dim1 (car dims))
         (last-dim (car (last dims))))                        
      (values value x-pix label dim1 last-dim)
      ;;end find-point-values
      )))
 ;;TEST
 ;; (find-point-value  '(1 (40 0.11) \"wup1-1\" (1 1)))
;; works= 0.11  40  \"WUP1-1\"  1  1



       
;;FIND-MAX-MIN-POINTS-LIST
;;
;;ddd
(defun find-max-min-points-list (points-list &key max-floor min-ceiling)
  "In U-ART, INPUT: Either 2-dim or 1-dim points lists; RETURNS (values max-value max-val-ptnum max-val-ptlabel   min-value  min-val-ptnum min-val-ptlabel).  If max-floor, sets min for the max value= floor. Otherwise min of max-value= -999999,If  min-ceiling otherwise max of min= 999999."
  (let
      ((points)
       (all-points)
       (point)
       (value)
       (max-value)
       (max-val-ptnum)
       (max-val-ptlabel)
       (min-value)
       (min-val-ptnum)
       (min-val-ptlabel)
       )
    (loop
     for dimlist in points-list
     do
     (when (listp dimlist)
       (cond
        ;;for multi-dim points
        ((equal (car dimlist) :DIMSIM)
         (setf points (third dimlist)
               all-points (append all-points  points)))
        ;;for single-dim points
        (t (setf all-points (append all-points (list dimlist))))))
     ;;end loop
     )   
    ;;WORK ON ALL-POINTS LIST
    (multiple-value-setq (max-value max-val-ptnum max-val-ptlabel  
                                    min-value  min-val-ptnum min-val-ptlabel)
        (find-max-min-points all-points :max-floor max-floor :min-ceiling min-ceiling))
    (values max-value max-val-ptnum max-val-ptlabel  
             min-value  min-val-ptnum min-val-ptlabel)
    ;;end let, find-mav-points-list
 ))
;;TEST
;;  (find-max-min-points-list *x-activity-points) 
;;works =0.05786446 4 "X-Aty4" -0.0037560517 2 "X-Aty2"
;;  (find-max-min-points-list   *wup-points)
;;works = 368.434 8  "Wup8-2" 0.006364 9 "Wup9-4"
;;  (find-max-min-points-list   *Y-POINTS)
;; (find-max-min-points-list   *reset-points) = 0 1 "reset1" 0 1 "reset1"




;;ART-ROOTSYM-P
;;
;;ddd
(defun art-rootsym-p (artsym &key (artsyms-list *all-art-symbols))
  "In U-ART, checks to see if artsym is a rootsym (second is dimspecs and no indecies, eg X) vs lower sym (second is dims and has indecies-- eg XI-L-F. RETURNS artsym SYMBOL or nil.)"
  (let
      ((art-rootsym-p (member artsym artsyms-list :test 'my-equal))
       )
    (when art-rootsym-p
      (setf art-rootsym-p (my-make-symbol artsym)))
    art-rootsym-p
    ))
;;TEST
;; (art-rootsym-p "INPUT") = INPUT
;; (art-rootsym-p "INPUTI-L-F") = NIL
    

;;FIND-LARGEST-ART-VALUEINDEX
;;
;;ddd
(defun find-largest-ART-ValueIndex (var &key avoid-reset-indexes-p 
                                    (reset-root 'resetnout) (reset-dims '(i 2 2)) 
                                    (default-var-value *def-reset-xy-val)) ;; .00001
  "In U-ART, RETURNS (values  max-index max-val maxSym  dims ). max-index is a dim-list if var has dim-n > 1. Note: var= artsym.NOTE: var can be a LIST of  syms.  If so, only compares values for those syms. Note: n-syms for var and reset dim I should be same. If var value = nil, sets to default-var-value in calculations. If  avoid-reset-indexes-p avoids values = *def-reset-xy-val."
  (let*
      ((symvals (eval var))
       ;;not needed? (subsyms (fifth symvals))
       (bottom-subsyms)
       (n-syms)
       (max-index 1)
       (max-val 0) 
       (maxSym)
       (maxDims)
       (val-i 0)
       (num-vars)
       (dims)
       (n-dims)
       (subvar-list)
       (subsym)
       (rest-resetdims (cdr reset-dims))
       (reset-dims1)
       (resetval)
       )

    ;;is var a list or var to find bottom-syms for?
    (cond
     ((listp var)
      (setf bottom-subsyms var
            n-syms (list-length bottom-subsyms)))
     (t 
      ;;if n-syms set to nil
      (setf bottom-subsyms
            (find-bottom-art-instances var)
            n-syms (list-length bottom-subsyms))))

      ;;Then find the max val, index, sym, and dims for the sym with max value
      (loop
       for  subsym in bottom-subsyms
       for i  from 1 to n-syms
       do
       (setf  subvar-list (eval subsym)
              dims (second subvar-list)
              val-i (fourth subvar-list))

       ;;find reset value
       (setf  reset-dims1 (append (list i) rest-resetdims)
              resetval (getsymval reset-root reset-dims1))

       (when (null val-i) (setf val-i  default-var-value))

       (cond
        ((= val-i  *def-reset-xy-val)
         NIL)
        ((and
              ;;larger than previous largest
              (>   val-i  max-val)
               ;; (null avoid-reset-indexes-p)
               (or
               (null  avoid-reset-indexes-p)
               ;;reset val for that i = 0
               (=  resetval 0))
              )                        ;; (aref *reset i)))
         ;;set the max vals
         (setq max-val val-i
               maxSym subsym
               maxDims dims
               max-index (car dims)))
         (t nil))

       ;;end loop, outer when
       )
      ;;(if (= *print-details 2) (afout 'out (format nil "max-index= ~a ~%" max-index)))
      (values  max-index max-val maxSym maxDims)
      ;;end let, find-largest-ART-ValueIndex
      ))
;;TEST
;;  (setsymval 'RESETNOUT3-2-2 nil 1.0)
;; (find-largest-ART-ValueIndex 'YI-1-3) =3 22.22 Y3-1-3 (3 1 3)
;;(find-largest-ART-ValueIndex 'reset :avoid-reset-indexes-p t) = 11.11 Y5-1-3 (5 1 3)
;; 
;;  (find-largest-ART-ValueIndex 'input) = 4  1.07376 INPUT4-1-1  (4 1 1)  
;; (find-largest-ART-ValueIndex 'wup) = 5 0.4987 WUP5-3-2TO3-1-3 (5 3 2 TO 3 1 3);; (find-largest-ART-ValueIndex 'yi-3-3)
;;     art2was (1 4)  1.001302  WUP1-4

;;OLDER-DELETE LATER??
#|(defun find-largest-ART-ValueIndex (var 
                                    &key avoid-reset-indexes-p (reset-dims  '(i 2 2))) 
  "In U-ART, RETURNS (values  max-index max-val maxSym  dims ). max-index is a dim-list if var has dim-n > 1. Note: var= artsym.NOTE: var can be a LIST of  syms.  If so, only compares values for those syms. "
  (let*
      ((symvals (eval var))
       ;;not needed? (subsyms (fifth symvals))
       (bottom-subsyms (find-bottom-art-instances var))
       (n-syms (list-length bottom-subsyms))
       (max-index 1)
       (max-val 0) 
       (maxSym)
       (maxDims)
       (val-i 0)
       (num-vars)
       (n-dims)
       (dims)
       (subvar-list)
       (subsym)
       (rest-resetdims (cdr reset-dims))
       (reset-dims1)
       (resetval)
       )

    ;;is var a list or var to find bottom-syms for?
    (cond
     ((listp var)
      (setf bottom-subsyms var
            n-syms (list-length bottom-subsyms)))
     (t 
      (setf  bottom-subsyms (find-bottom-art-instances var)
             n-syms (list-length bottom-subsyms))))

    ;;Then find the max val, index, sym, and dims for the sym with max value
      (loop
       for  subsym in bottom-subsyms
       for i  from 1 to n-syms
       do
       (setf  subvar-list (eval subsym)
              dims (second subvar-list)
              val-i (fourth subvar-list))

       ;;find reset value
       (setf  reset-dims1 (append (list i) rest-resetdims)
              resetval (getsymval 'reset reset-dims1))

       (when (null val-i) (setf val-i 0.0))
       (when (and
            ;;larger than previous largest
            (>   val-i max-val)
            (or
             ;; (null avoid-reset-indexes-p)
             (null  avoid-reset-indexes-p)
             ;;reset val for that i = 0
             (=  resetval 0))
             )                        ;; (aref *reset i)))

         ;;set the max vals
         (setq max-val val-i
               maxSym subsym
               maxDims dims
               max-index (car dims))

           ;;end when and ...
           )
       ;;end loop, outer when
       )
      ;;(if (= *print-details 2) (afout 'out (format nil "max-index= ~a ~%" max-index)))
      (values  max-index max-val maxSym maxDims)
      ;;end let, find-largest-ART-ValueIndex
      ))|#


;;EQUAL-DIMS
;;
;;ddd
(defun equal-dims (artsym1 artsym2)
  "In U-ART. Checks to see if dims are equal for 2 artsyms"
  (let
      ((dims1)
       (dims2)
       (equal-dims (equal '(I 1 2) '(i 1 2) ))
       )
       ;;(equal '(I 1 2) '(i 1 2) ) = T
       (when equal-dims
         artsym1)
    ;;end let, equal-dims     
    ))
;;TEST
;;  (equal-dims '(I 1 2) '(i 1 2) ) =  (I 1 2)



;;FIND-RESET-VALUE
;;
;;ddd
(defun find-reset-value (dims-or-sym &key (reset-syms *all-reset-syms))
  "In U-ART, finds the EQUIVALENT reset value for dims-or-sym (can be an artsym or dims). RETURNS (values reset-val reset-p reset-dims)"
  (let
      ((reset-sym)
       (reset-dims)
       (reset-val)
       (reset-p)
       )
    (unless reset-syms
      (setf reset-syms (find-bottom-art-instances 'reset)))

    (multiple-value-setq (reset-val reset-p reset-dims)
        (find-equivalent-value dims-or-sym reset-syms))

    (values reset-val reset-p reset-dims) 
    ;;end let, find-reset-value
    ))
;;TEST
;; (setf RESET2-2-2 '("reset" (2 2 2) NIL 0 NIL))
;;works
;; (find-reset-value '(2 2 2)) = 0  NIL (2 2 2)
;; (find-reset-value  'Y2-2-2) = 0  NIL (2 2 2)
;;
;; (setf RESET3-2-2 '("reset" (3 2 2) NIL .66 NIL))
;;works
;; (find-reset-value '(3 2 2)) = 0.66  T (3 2 2)
;; (find-reset-value  'Y3-2-2) = 0.66  T (3 2 2)

#|CL-USER 110 > reset
("reset" ((9 1 1) (1 2 1) (2 2 1)) RESET-POINTS NIL (RESETI-L-F))
CL-USER 111 > RESETI-L-F
("reset" (I L F) NIL NIL (RESETI-L-2 RESETI-L-3))
CL-USER 112 > RESETI-L-2
("reset" (I L 2) NIL NIL (RESETI-2-2))
CL-USER 113 > RESETI-2-2
;;("reset" (I 2 2) NIL NIL (RESET1-2-2 RESET2-2-2 RESET3-2-2 RESET4-2-2 RESET5-2-2 RESET6-2-2 RESET7-2-2 RESET8-2-2 RESET9-2-2))|#





;;FIND-DIMS-EQUAL-VALUE
;;
;;ddd
(defun find-dims-equal-value (dims-or-sym match-syms)
  "In U-ART, finds the EQUIVALENT (with identical dims) value in match-syms for dims-or-sym (can be an artsym or dims). RETURNS (values reset-val reset-p reset-dims)"
  (let
      ((match-sym)
       (match-dims)
       (match-val)
       (match-p)
       )

    ;;find the dims
    (cond
     ((listp dims-or-sym)
       (setf dims dims-or-sym))
     (t (setf dims (second (eval dims-or-sym)))))

    ;;get match-syms if not initialized
    (unless match-syms
      (setf match-syms (find-bottom-art-instances 'RESET)))

    (loop
     for match-sym in match-syms
     do
     (setf match-dims (find-art-dims match-sym))
     (when
         (equal match-dims dims)
          (setf match-val (getsymval match-sym))
          (when (> match-val 0)
            (setf match-p T))
       (return))
     ;;end loop
     )
    (values match-val match-p match-dims) 
    ;;end let, find-match-value
    ))



;;FIND-MAX-MIN-POINTS
;;
;;ddd
(defun find-max-min-points (points &key max-floor min-ceiling)
  "In U-ART INPUT a simple 1-dim point list, RETURNS (values  max-value max-val-ptnum max-val-ptlabel min-value  min-val-ptnum min-val-ptlabel).  If max-floor, sets min for the max value= floor. Otherwise min of max-value= -999999,If  min-ceiling otherwise max of min= 999999."
  (let
      ((values)
       (ptnum)
       (ptlable)
       (value)
       (max-value -999999)
       (min-val-ptnum)
       (min-val-ptlabel)
       (min-value 999999)
       (max-val-ptnum)
       (max-val-ptlabel)
       )
    ;;
    (if max-floor (setf max-value max-floor))
    (if min-ceiling (setf min-value min-ceiling))

    (loop
     for point in points
     do
     (setf ptnum(car point) 
           ptlable (third point)
           value (second (second point)))   
     ;;for min-val
     (when (< value min-value)
       (setf min-value value
             min-val-ptnum ptnum
             min-val-ptlabel ptlable))
     ;;for max-val
     (when (> value max-value)
       (setf max-value value
             max-val-ptnum ptnum
             max-val-ptlabel ptlable))
     ;;end loop
     )
    (values  max-value max-val-ptnum max-val-ptlabel  
             min-value  min-val-ptnum min-val-ptlabel)
    ;;end let, find-max-min-points
    ))
;;TEST
;;  (find-max-min-points *INPUT-POINTS)
;; works= 1.04512 4 "Input4" -0.067839995 2 "Input2"
 






;;SORT-ART-LIST-INTO-NESTED-LISTS
;;
;;ddd  
(defun sort-art-list-into-nested-lists  (flat-points-list  ;;not needed items-per-list 
                                                           &key (sortdim-n 1) (x-pix0 40)  (x-pix-incr 40)
                                                           preitems   postitems
                                                           (pre-add-dim-n-p t)  double-quote-nested-item-p)
  "In U-lists, Sorts flat-points-list into 2-dim nested lists.  Uses the ART dim sortdim-n (usually 1 or 2) sortdim-n puts that dim in the OUTER-MOST nested list.. Appends preitems to beginning of each dimlist, postitems to end of each dimlist. pre-add-dim-n-p adds dim-n at end of preitems. This designed for ART flat-point-lists, but may be adapted for some other uses. double-quote-nested-item-p only relates to postitems. RETURNS nested-lists of dimlists, [dimlist eg. (:DIMSIM 1 ((1 (40 0.070434004) \"Wup1-1\" (1 1)) (2 (80 0.06954) \"Wup1-2\" (1 2)) ...  ]. "
  (let*
      ((nested-lists)
       (new-dimlist-p)
       (dimlist)
       (dimlist-n 0)
       (new-point-list)
       (n-items (list-length flat-points-list))
       (n-lists 0)
       (value)
       (nth-dimlist-point 0)
       (length-last-dimlist 0)
       (temp-nested-lists)
       (length-sublist)
       (x-pix)
       (Subdims (fourth (car flat-points-list)))
       (n-dims)
       ) 
    ;;prevent errors
    (when (listp Subdims)
      (when (< (list-length Subdims) sortdim-n)
        (setf  sortdim-n 1)))

    ;;get info from flat-points-list
    (loop
     for point-list in flat-points-list
     do
     ;;eg (1 (40 0.8836) "Wdn1-1" (1 1))
     (multiple-value-bind (dim1 sublist label dims  rest)
         (values-list point-list)
       (setf dim (nth (- sortdim-n 1) dims)
             value (second sublist))
       ;;find relevant dimlist in nested-list (if it exists, if not a new dimlist)
       (setf dimlist 
             (get-key-value-in-nested-lists (list (list dim 1)) nested-lists
                                            :return-list-p T))

       ;;(afout 'out (format nil "LOOP point-list=~A~%  dim=~A    ~%dimlist=~A" point-list dim dimlist))

       ;;If new dimlist, find pix values and new-list-p value
       (cond
        ((null dimlist)
         ;;(setf new-dimlist-p T)

         ;;start new x-pix numbering for new graph
            (setf x-pix x-pix0)

         ;;set nth-dimlist-point and new-point-list
         (setf  nth-dimlist-point 1
                sublist (list x-pix (second sublist)))
         (if rest
             (setf  new-point-list (list 1 sublist label dims  rest))
           (setf  new-point-list (list 1 sublist label dims)))

         ;;start new dimlist
         ;;add preitems to new dimlist?
         (when preitems
           (if pre-add-dim-n-p
               (setf dimlist (append  preitems (list dim)(list (list new-point-list))))
             (setf dimlist (append preitems (list new-point-list)))))
    
         ;;append nested list with new dimlist (put partial dimlists in it and find later as find new points to add to the dimlist);  the nested-list should be in order dimlist 1, 2, etc.
         (setf nested-lists (append nested-lists (list dimlist)))
         ;;end dim 1 clause
         )
        ;;previous dimlist of that dim exists (not first item in the relevant dimlist)
        (dimlist
         
         ;;find last-point-list, nth-dimlist-point, x-pix 
         (setf last-point-list  (car (last (car (last dimlist))))
               nth-dimlist-point (+ (car last-point-list) 1)
               x-pix (+ (car (second last-point-list)) x-pix-incr))

         ;;make the new point-list
         ;;eg (1 (40 0.8836) "Wdn1-1" (1 1))
         ;;(multiple-value-bind (dim1 sublist label dims  rest)
         (cond 
          (rest
           (setf new-point-list
                 (list nth-dimlist-point (list x-pix value) label dims rest)))
          (t 
           (setf new-point-list
                 (list nth-dimlist-point (list x-pix value) label dims))))

         ;;yyyy
         ;;append the dimlist with new-point-list
         (setf dimlist (append-nth-nested-list  new-point-list :last  dimlist))

         ;;replace the old dimlist with modified one
         (setf nested-lists (replace-keylist dim nested-lists dimlist :key-n 1))
         ;;(afout 'out (format nil "END dimlist clause~% dimlist=~A dim=~A~%nested-lists=~A "dimlist dim nested-lists))
         ;;end dimlist clause
         )
        ;;should not be a case where either dimlist exists or it is a new one
        (t nil))
       
       ;;AT END ADD postitems to ALL dimlists
       (when postitems
         (loop
          for dimlist in nested-lists
          do
          (if double-quote-nested-item-p
              (setf dimlist (append-double-quoted-sublist (list postitems)))
            (setf dimlist (append dimlist (list postitems))
                  temp-nested-lists (append temp-nested-lists (list dimlist))))
          ;;end loop
          )
         (setf nested-lists temp-nested-lists)
         ;;end when
         )
       ;;reset dimlist
       (setf dimlist nil)

       ;;end mvb,loop
       ))
 
    nested-lists
    ;;end let, sort-list-into-nested-lists
    ))
;;TEST ART3
;; (sort-art-list-into-nested-lists  '((1 (40 NIL) "Wup1-3" (1 3 2 TO 1 1 3)) (1 (80 NIL) "Wup1-3" (1 3 2 TO 2 1 3)) (1 (120 NIL) "Wup1-3" (1 3 2 TO 3 1 3)) (1 (160 NIL) "Wup1-3" (1 3 2 TO 4 1 3)) (1 (200 NIL) "Wup1-3" (1 3 2 TO 5 1 3)) (2 (240 NIL) "Wup1-3" (2 3 2 TO 1 1 3)) (2 (280 NIL) "Wup1-3" (2 3 2 TO 2 1 3)) (2 (320 NIL) "Wup1-3" (2 3 2 TO 3 1 3)) (2 (360 NIL) "Wup1-3" (2 3 2 TO 4 1 3)) (2 (400 NIL) "Wup1-3" (2 3 2 TO 5 1 3)) (3 (440 NIL) "Wup1-3" (3 3 2 TO 1 1 3)) (3 (480 NIL) "Wup1-3" (3 3 2 TO 2 1 3)) (3 (520 NIL) "Wup1-3" (3 3 2 TO 3 1 3)) (3 (560 NIL) "Wup1-3" (3 3 2 TO 4 1 3)) (3 (600 NIL) "Wup1-3" (3 3 2 TO 5 1 3)) (4 (640 NIL) "Wup1-3" (4 3 2 TO 1 1 3)) (4 (680 NIL) "Wup1-3" (4 3 2 TO 2 1 3)) (4 (720 NIL) "Wup1-3" (4 3 2 TO 3 1 3)) (4 (760 NIL) "Wup1-3" (4 3 2 TO 4 1 3)) (4 (800 NIL) "Wup1-3" (4 3 2 TO 5 1 3)) (5 (840 NIL) "Wup1-3" (5 3 2 TO 1 1 3)) (5 (880 NIL) "Wup1-3" (5 3 2 TO 2 1 3)) (5 (920 NIL) "Wup1-3" (5 3 2 TO 3 1 3)) (5 (960 NIL) "Wup1-3" (5 3 2 TO 4 1 3)) (5 (1000 NIL) "Wup1-3" (5 3 2 TO 5 1 3)) (6 (1040 NIL) "Wup1-3" (6 3 2 TO 1 1 3)) (6 (1080 NIL) "Wup1-3" (6 3 2 TO 2 1 3)) (6 (1120 NIL) "Wup1-3" (6 3 2 TO 3 1 3)) (6 (1160 NIL) "Wup1-3" (6 3 2 TO 4 1 3)) (6 (1200 NIL) "Wup1-3" (6 3 2 TO 5 1 3)) (7 (1240 NIL) "Wup1-3" (7 3 2 TO 1 1 3)) (7 (1280 NIL) "Wup1-3" (7 3 2 TO 2 1 3)) (7 (1320 NIL) "Wup1-3" (7 3 2 TO 3 1 3)) (7 (1360 NIL) "Wup1-3" (7 3 2 TO 4 1 3)) (7 (1400 NIL) "Wup1-3" (7 3 2 TO 5 1 3)) (8 (1440 NIL) "Wup1-3" (8 3 2 TO 1 1 3)) (8 (1480 NIL) "Wup1-3" (8 3 2 TO 2 1 3)) (8 (1520 NIL) "Wup1-3" (8 3 2 TO 3 1 3)) (8 (1560 NIL) "Wup1-3" (8 3 2 TO 4 1 3)) (8 (1600 NIL) "Wup1-3" (8 3 2 TO 5 1 3)) (9 (1640 NIL) "Wup1-3" (9 3 2 TO 1 1 3)) (9 (1680 NIL) "Wup1-3" (9 3 2 TO 2 1 3)) (9 (1720 NIL) "Wup1-3" (9 3 2 TO 3 1 3)) (9 (1760 NIL) "Wup1-3" (9 3 2 TO 4 1 3)) (9 (1800 NIL) "Wup1-3" (9 3 2 TO 5 1 3)))    :pre-add-dim-n-p T :preitems '(:DIMSIM)  :double-quote-nested-item-p T :sortdim-n 5 )
;;WORKS=
#|((:DIMSIM    1
  ((1 (40 NIL) "Wup1-3" (1 3 2 TO 1 1 3))
   (2 (80 NIL) "Wup1-3" (2 3 2 TO 1 1 3))
   (3 (120 NIL) "Wup1-3" (3 3 2 TO 1 1 3))
   (4 (160 NIL) "Wup1-3" (4 3 2 TO 1 1 3))
   (5 (200 NIL) "Wup1-3" (5 3 2 TO 1 1 3))
   (6 (240 NIL) "Wup1-3" (6 3 2 TO 1 1 3))
   (7 (280 NIL) "Wup1-3" (7 3 2 TO 1 1 3))
   (8 (320 NIL) "Wup1-3" (8 3 2 TO 1 1 3))
   (9 (360 NIL) "Wup1-3" (9 3 2 TO 1 1 3))))
 (:DIMSIM   2
  ((1 (40 NIL) "Wup1-3" (1 3 2 TO 2 1 3))
   (2 (80 NIL) "Wup1-3" (2 3 2 TO 2 1 3))
   (3 (120 NIL) "Wup1-3" (3 3 2 TO 2 1 3))
   (4 (160 NIL) "Wup1-3" (4 3 2 TO 2 1 3))
   (5 (200 NIL) "Wup1-3" (5 3 2 TO 2 1 3))
   (6 (240 NIL) "Wup1-3" (6 3 2 TO 2 1 3))
   (7 (280 NIL) "Wup1-3" (7 3 2 TO 2 1 3))
   (8 (320 NIL) "Wup1-3" (8 3 2 TO 2 1 3))
   (9 (360 NIL) "Wup1-3" (9 3 2 TO 2 1 3))))
 (:DIMSIM   3
  ((1 (40 NIL) "Wup1-3" (1 3 2 TO 3 1 3))
   (2 (80 NIL) "Wup1-3" (2 3 2 TO 3 1 3))
   (3 (120 NIL) "Wup1-3" (3 3 2 TO 3 1 3))
   (4 (160 NIL) "Wup1-3" (4 3 2 TO 3 1 3))
   (5 (200 NIL) "Wup1-3" (5 3 2 TO 3 1 3))
   (6 (240 NIL) "Wup1-3" (6 3 2 TO 3 1 3))
   (7 (280 NIL) "Wup1-3" (7 3 2 TO 3 1 3))
   (8 (320 NIL) "Wup1-3" (8 3 2 TO 3 1 3))
   (9 (360 NIL) "Wup1-3" (9 3 2 TO 3 1 3))))
 (:DIMSIM   4
  ((1 (40 NIL) "Wup1-3" (1 3 2 TO 4 1 3))
   (2 (80 NIL) "Wup1-3" (2 3 2 TO 4 1 3))
   (3 (120 NIL) "Wup1-3" (3 3 2 TO 4 1 3))
   (4 (160 NIL) "Wup1-3" (4 3 2 TO 4 1 3))
   (5 (200 NIL) "Wup1-3" (5 3 2 TO 4 1 3))
   (6 (240 NIL) "Wup1-3" (6 3 2 TO 4 1 3))
   (7 (280 NIL) "Wup1-3" (7 3 2 TO 4 1 3))
   (8 (320 NIL) "Wup1-3" (8 3 2 TO 4 1 3))
   (9 (360 NIL) "Wup1-3" (9 3 2 TO 4 1 3))))
 (:DIMSIM   5
  ((1 (40 NIL) "Wup1-3" (1 3 2 TO 5 1 3))
   (2 (80 NIL) "Wup1-3" (2 3 2 TO 5 1 3))
   (3 (120 NIL) "Wup1-3" (3 3 2 TO 5 1 3))
   (4 (160 NIL) "Wup1-3" (4 3 2 TO 5 1 3))
   (5 (200 NIL) "Wup1-3" (5 3 2 TO 5 1 3))
   (6 (240 NIL) "Wup1-3" (6 3 2 TO 5 1 3))
   (7 (280 NIL) "Wup1-3" (7 3 2 TO 5 1 3))
   (8 (320 NIL) "Wup1-3" (8 3 2 TO 5 1 3))
   (9 (360 NIL) "Wup1-3" (9 3 2 TO 5 1 3)))))|#

;;FOR ART2: SORT BY DIM 1
;; ;;   (sort-art-list-into-nested-lists  '((1 (40 110) WUP1-1 (1 1)) (2 (80 200) WUP1-2 (1 2))(1 (40 50) WUP2-1 (2  1)) (2 (80  20) WUP2-2 (2 2)))  :pre-add-dim-n-p T :preitems '(:DIMSIM)  :double-quote-nested-item-p T :sortdim-n 1 )
;;works= ((:DIMSIM 1 ((1 (40 110) WUP1-1 (1 1)) (2 (80 200) WUP1-2 (1 2)))) (:DIMSIM 2 ((1 (40 50) WUP2-1 (2 1)) (2 (80 20) WUP2-2 (2 2)))))
;;   (sort-art-list-into-nested-lists  '((1 (40 0.070434004) "Wup1-1" (1 1)) (1 (80 0.06954) "Wup1-2" (1 2)) (1 (120 0.026330002) "Wup1-3" (1 3)) (1 (160 0.038548) "Wup1-4" (1 4)) (1 (200 0.112005) "Wup1-5" (1 5)) (2 (240 0.08712201) "Wup2-1" (2 1)) (2 (280 0.0074070008) "Wup2-2" (2 2)) (2 (320 0.082205005) "Wup2-3" (2 3)) (2 (360 0.017092) "Wup2-4" (2 4)) (2 (400 0.063878) "Wup2-5" (2 5)) (3 (440 0.100085005) "Wup3-1" (3 1)) (3 (480 0.009195) "Wup3-2" (3 2)) (3 (520 0.13808) "Wup3-3" (3 3)) (3 (560 0.096807) "Wup3-4" (3 4)) (3 (600 0.08280101) "Wup3-5" (3 5)) (4 (640 0.032587998) "Wup4-1" (4 1)) (4 (680 0.076096006) "Wup4-2" (4 2)) (4 (720 0.022009) "Wup4-3" (4 3)) (4 (760 0.097701006) "Wup4-4" (4 4)) (4 (800 0.05166) "Wup4-5" (4 5)) (5 (840 0.107535005) "Wup5-1" (5 1)) (5 (880 0.009791001) "Wup5-2" (5 2)) (5 (920 0.057769) "Wup5-3" (5 3)) (5 (960 0.046295997) "Wup5-4" (5 4)) (5 (1000 0.056875) "Wup5-5" (5 5)) (6 (1040 0.046445) "Wup6-1" (6 1)) (6 (1080 0.07848) "Wup6-2" (6 2)) (6 (1120 0.024542002) "Wup6-3" (6 3)) (6 (1160 0.048978) "Wup6-4" (6 4)) (6 (1200 0.104704) "Wup6-5" (6 5)) (7 (1240 0.023946) "Wup7-1" (7 1)) (7 (1280 0.11111101) "Wup7-2" (7 2)) (7 (1320 0.07505301) "Wup7-3" (7 3)) (7 (1360 0.011728) "Wup7-4" (7 4)) (7 (1400 0.022009) "Wup7-5" (7 5)) (8 (1440 0.0033840002) "Wup8-1" (8 1)) (8 (1480 0.019178002) "Wup8-2" (8 2)) (8 (1520 0.12347801) "Wup8-3" (8 3)) (8 (1560 0.012324) "Wup8-4" (8 4)) (8 (1600 0.047934998) "Wup8-5" (8 5)) (9 (1640 0.026181002) "Wup9-1" (9 1)) (9 (1680 0.046147) "Wup9-2" (9 2)) (9 (1720 0.126458) "Wup9-3" (9 3)) (9 (1760 0.080417) "Wup9-4" (9 4)) (9 (1800 0.13361001) "Wup9-5" (9 5)))   :pre-add-dim-n-p T :preitems '(:DIMSIM)  :double-quote-nested-item-p T :sortdim-n 1 )
;;WORKS= ((:DIMSIM 1 ((1 (40 0.070434004) "Wup1-1" (1 1)) (2 (80 0.06954) "Wup1-2" (1 2)) (3 (120 0.026330002) "Wup1-3" (1 3)) (4 (160 0.038548) "Wup1-4" (1 4)) (5 (200 0.112005) "Wup1-5" (1 5)))) (:DIMSIM 2 ((1 (40 0.08712201) "Wup2-1" (2 1)) (2 (80 0.0074070008) "Wup2-2" (2 2)) (3 (120 0.082205005) "Wup2-3" (2 3)) (4 (160 0.017092) "Wup2-4" (2 4)) (5 (200 0.063878) "Wup2-5" (2 5)))) (:DIMSIM 3 ((1 (40 0.100085005) "Wup3-1" (3 1)) (2 (80 0.009195) "Wup3-2" (3 2)) (3 (120 0.13808) "Wup3-3" (3 3)) (4 (160 0.096807) "Wup3-4" (3 4)) (5 (200 0.08280101) "Wup3-5" (3 5)))) (:DIMSIM 4 ((1 (40 0.032587998) "Wup4-1" (4 1)) (2 (80 0.076096006) "Wup4-2" (4 2)) (3 (120 0.022009) "Wup4-3" (4 3)) (4 (160 0.097701006) "Wup4-4" (4 4)) (5 (200 0.05166) "Wup4-5" (4 5)))) (:DIMSIM 5 ((1 (40 0.107535005) "Wup5-1" (5 1)) (2 (80 0.009791001) "Wup5-2" (5 2)) (3 (120 0.057769) "Wup5-3" (5 3)) (4 (160 0.046295997) "Wup5-4" (5 4)) (5 (200 0.056875) "Wup5-5" (5 5)))) (:DIMSIM 6 ((1 (40 0.046445) "Wup6-1" (6 1)) (2 (80 0.07848) "Wup6-2" (6 2)) (3 (120 0.024542002) "Wup6-3" (6 3)) (4 (160 0.048978) "Wup6-4" (6 4)) (5 (200 0.104704) "Wup6-5" (6 5)))) (:DIMSIM 7 ((1 (40 0.023946) "Wup7-1" (7 1)) (2 (80 0.11111101) "Wup7-2" (7 2)) (3 (120 0.07505301) "Wup7-3" (7 3)) (4 (160 0.011728) "Wup7-4" (7 4)) (5 (200 0.022009) "Wup7-5" (7 5)))) (:DIMSIM 8 ((1 (40 0.0033840002) "Wup8-1" (8 1)) (2 (80 0.019178002) "Wup8-2" (8 2)) (3 (120 0.12347801) "Wup8-3" (8 3)) (4 (160 0.012324) "Wup8-4" (8 4)) (5 (200 0.047934998) "Wup8-5" (8 5)))) (:DIMSIM 9 ((1 (40 0.026181002) "Wup9-1" (9 1)) (2 (80 0.046147) "Wup9-2" (9 2)) (3 (120 0.126458) "Wup9-3" (9 3)) (4 (160 0.080417) "Wup9-4" (9 4)) (5 (200 0.13361001) "Wup9-5" (9 5)))))

;;
;;SORT BY DIM 2
;; (sort-art-list-into-nested-lists  '((1 (40 110) WUP1-1 (1 1)) (2 (80 200) WUP1-2 (2 1))(1 (40 50) WUP1-2 (1 2)) (2 (80  20) WUP2-2 (2 2)))  :pre-add-dim-n-p T :preitems '(:DIMSIM)  :double-quote-nested-item-p T :x-pix0 40 :sortdim-n 2 )
;;works=  ((:DIMSIM 1 ((1 (40 110) WUP1-1 (1 1)) (2 (80 50) WUP1-2 (1 2)))) (:DIMSIM 2 ((1 (40 200) WUP1-2 (2 1)) (2 (80 20) WUP2-2 (2 2)))))

;;(sort-art-list-into-nested-lists  '((1 (40 0.070434004) "Wup1-1" (1 1)) (1 (80 0.06954) "Wup1-2" (1 2)) (1 (120 0.026330002) "Wup1-3" (1 3)) (1 (160 0.038548) "Wup1-4" (1 4)) (1 (200 0.112005) "Wup1-5" (1 5)) (2 (240 0.08712201) "Wup2-1" (2 1)) (2 (280 0.0074070008) "Wup2-2" (2 2)) (2 (320 0.082205005) "Wup2-3" (2 3)) (2 (360 0.017092) "Wup2-4" (2 4)) (2 (400 0.063878) "Wup2-5" (2 5)) (3 (440 0.100085005) "Wup3-1" (3 1)) (3 (480 0.009195) "Wup3-2" (3 2)) (3 (520 0.13808) "Wup3-3" (3 3)) (3 (560 0.096807) "Wup3-4" (3 4)) (3 (600 0.08280101) "Wup3-5" (3 5)) (4 (640 0.032587998) "Wup4-1" (4 1)) (4 (680 0.076096006) "Wup4-2" (4 2)) (4 (720 0.022009) "Wup4-3" (4 3)) (4 (760 0.097701006) "Wup4-4" (4 4)) (4 (800 0.05166) "Wup4-5" (4 5)) (5 (840 0.107535005) "Wup5-1" (5 1)) (5 (880 0.009791001) "Wup5-2" (5 2)) (5 (920 0.057769) "Wup5-3" (5 3)) (5 (960 0.046295997) "Wup5-4" (5 4)) (5 (1000 0.056875) "Wup5-5" (5 5)) (6 (1040 0.046445) "Wup6-1" (6 1)) (6 (1080 0.07848) "Wup6-2" (6 2)) (6 (1120 0.024542002) "Wup6-3" (6 3)) (6 (1160 0.048978) "Wup6-4" (6 4)) (6 (1200 0.104704) "Wup6-5" (6 5)) (7 (1240 0.023946) "Wup7-1" (7 1)) (7 (1280 0.11111101) "Wup7-2" (7 2)) (7 (1320 0.07505301) "Wup7-3" (7 3)) (7 (1360 0.011728) "Wup7-4" (7 4)) (7 (1400 0.022009) "Wup7-5" (7 5)) (8 (1440 0.0033840002) "Wup8-1" (8 1)) (8 (1480 0.019178002) "Wup8-2" (8 2)) (8 (1520 0.12347801) "Wup8-3" (8 3)) (8 (1560 0.012324) "Wup8-4" (8 4)) (8 (1600 0.047934998) "Wup8-5" (8 5)) (9 (1640 0.026181002) "Wup9-1" (9 1)) (9 (1680 0.046147) "Wup9-2" (9 2)) (9 (1720 0.126458) "Wup9-3" (9 3)) (9 (1760 0.080417) "Wup9-4" (9 4)) (9 (1800 0.13361001) "Wup9-5" (9 5)))   :pre-add-dim-n-p T :preitems '(:DIMSIM) :sortdim-n 2 :double-quote-nested-item-p T  :sortdim-n 2)
;;WORKS=  ((:DIMSIM 1 ((1 (40 0.070434004) "Wup1-1" (1 1)) (2 (80 0.08712201) "Wup2-1" (2 1)) (3 (120 0.100085005) "Wup3-1" (3 1)) (4 (160 0.032587998) "Wup4-1" (4 1)) (5 (200 0.107535005) "Wup5-1" (5 1)) (6 (240 0.046445) "Wup6-1" (6 1)) (7 (280 0.023946) "Wup7-1" (7 1)) (8 (320 0.0033840002) "Wup8-1" (8 1)) (9 (360 0.026181002) "Wup9-1" (9 1)))) (:DIMSIM 2 ((1 (40 0.06954) "Wup1-2" (1 2)) (2 (80 0.0074070008) "Wup2-2" (2 2)) (3 (120 0.009195) "Wup3-2" (3 2)) (4 (160 0.076096006) "Wup4-2" (4 2)) (5 (200 0.009791001) "Wup5-2" (5 2)) (6 (240 0.07848) "Wup6-2" (6 2)) (7 (280 0.11111101) "Wup7-2" (7 2)) (8 (320 0.019178002) "Wup8-2" (8 2)) (9 (360 0.046147) "Wup9-2" (9 2)))) (:DIMSIM 3 ((1 (40 0.026330002) "Wup1-3" (1 3)) (2 (80 0.082205005) "Wup2-3" (2 3)) (3 (120 0.13808) "Wup3-3" (3 3)) (4 (160 0.022009) "Wup4-3" (4 3)) (5 (200 0.057769) "Wup5-3" (5 3)) (6 (240 0.024542002) "Wup6-3" (6 3)) (7 (280 0.07505301) "Wup7-3" (7 3)) (8 (320 0.12347801) "Wup8-3" (8 3)) (9 (360 0.126458) "Wup9-3" (9 3)))) (:DIMSIM 4 ((1 (40 0.038548) "Wup1-4" (1 4)) (2 (80 0.017092) "Wup2-4" (2 4)) (3 (120 0.096807) "Wup3-4" (3 4)) (4 (160 0.097701006) "Wup4-4" (4 4)) (5 (200 0.046295997) "Wup5-4" (5 4)) (6 (240 0.048978) "Wup6-4" (6 4)) (7 (280 0.011728) "Wup7-4" (7 4)) (8 (320 0.012324) "Wup8-4" (8 4)) (9 (360 0.080417) "Wup9-4" (9 4)))) (:DIMSIM 5 ((1 (40 0.112005) "Wup1-5" (1 5)) (2 (80 0.063878) "Wup2-5" (2 5)) (3 (120 0.08280101) "Wup3-5" (3 5)) (4 (160 0.05166) "Wup4-5" (4 5)) (5 (200 0.056875) "Wup5-5" (5 5)) (6 (240 0.104704) "Wup6-5" (6 5)) (7 (280 0.022009) "Wup7-5" (7 5)) (8 (320 0.047934998) "Wup8-5" (8 5)) (9 (360 0.13361001) "Wup9-5" (9 5)))))

;;FOR SORTING 3+ dimension lists, where the field and module dimensions are the SAME.
;;
;;  (sort-art-list-into-nested-lists  '((1 (40 110) WUP1-1-8-11-1-2  (1 1 8 11 1 2)) (2 (80 200) WUP1-2-8-11-1-2  (1 2 8 11 1 2))(1 (40 50) WUP2-1-8-11-1-2  (2  1 8 11 1 2)) (2 (80  20) WUP2-2-8-11-1-2  (2 2 8 11 1 2)))  :pre-add-dim-n-p T :preitems '(:DIMSIM)  :double-quote-nested-item-p T :sortdim-n 1 )
;; RESULTS= ((:DIMSIM 1 ((1 (40 110) WUP1-1-8-11-1-2 (1 1 8 11 1 2)) (2 (80 200) WUP1-2-8-11-1-2 (1 2 8 11 1 2)))) (:DIMSIM 2 ((1 (40 50) WUP2-1-8-11-1-2 (2 1 8 11 1 2)) (2 (80 20) WUP2-2-8-11-1-2 (2 2 8 11 1 2)))))




#|
CL-USER 65 > (truncate (/ 9  4 )) = 2   1/4
CL-USER 66 > (truncate (/ 9 (* 4 1.0))) = 2  0.25
CL-USER 68 > (ceiling (/ 9  4)) = 3  -3/4
|#



;;MAKE-ART-CYCLE-DATA-TEXT
;;
;;ddd
(defun make-art-cycle-data-text (vars-list &key (cycle-n  *overall-cycle-n) formula-list)
  "In U-ART, makes text listing variables and values in vars-list. vars-list eg (INPUT X P U R RESET WUP WDN Y) "
  (let
      ((var-n 0)
       (main-var-dimspecs)
       (all-bottom-syms)
       (subvar-text "")
       (var-text "")
       (cycle-text 
        (format nil ">>> FOR *OVERALL-CYCLE-N= ~A, VARIABLES= ~A" cycle-n vars-list))
       (formula "")
       (subvar-list)
       (outer-dim-n 0)
       (inner-dim-n 0)
       (max-val)
       (max-index)
       (line 
"------------------------------------------------------------------------------------------------------------------------------------------------------------")    
       
   
    (cycle-line " >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> END OF CYCLE <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
    )
    ;;default-formula-list
    (unless formula-list
      (setf formula-list
            '((input "INPUT")
              (p "pi = (+ ui  SUMj (* (g yI) wdnji))  ;  ui = net v-activity;; g(yI) = d  ;if Tj = maxi Tj  & the jth F2 node not reset ;;; g(yI) = 0  ;otherwise")
              ;;(q "qi = (/ pi (+ e   L2norm p));;L2norm = SUMi (* var var)")
              ;;(u "ui = (/ vi (+ e  L2norm v)) ;;L2norm = SUMi (* var var)")
              (r  "ri = (-  (/  ui   max1u)  (/ pi  max2p))")

              ;;FIELD 3
              (XI-3-3  "XI-3-3 =  f(YI-2-3)      ;;If Si-2-3 = f(Yi-2-3)")
              (YI-3-3 "YI-3-3 =  (/ XI-3-3 (+ e  L2norm XI-3-3))")
              (XI-2-3 "XI-2-3 =  (+ f(YI-1-3)   (* b  f(YI-3-3)))  = (+ YI-1-3 (* b YI-3-3))" )
              ;;was "vi = (+ f(xi)  (* b f(qi)))  = (+ x (* b x))  
              ;;   OR  0; b=  0.2; WHERE f(x) = 0  if (<= x theta); f(x) = x  if (>= x theta)  ;theta = 0.3;")
              (YI-2-2 "YI-2-1 =(/ XI-2-2 (+ e  L2norm XI-2-2)) ;;L2norm = SUMi (* var var)")
              (XI-1-3 "XI-1-3 =  (+ [?? YI-3-1 zz adaptive??]   (* a  YI-2-3)) ;a= 0.5")
              ;;was (w  "wi = (+ Ii (* a ui)) ;a=0.5 ")
              (YI-1-3 "YI-1-3 =(/ XI-1-3 (+ e  L2norm XI-1-3)) ;;L2norm = SUMi (* var var)")
              ;;eg?? "ui = (/ vi (+ e  L2norm v)) ;;L2norm = SUMi (* var var)")
              ;;FIELD 2
              (XI-3-2  "XI-3-2 = (+  f(YI-2-2) ??? adaptive Z S INPUT??)        ;;If Si-2-1 = f(Yi-1-1)")
              (YI-3-2  "YI-3-2 =  (/ XI-3-2 (+ e  L2norm XI-3-2))")
              (XI-2-2 "XI-2-2 =  (+ f(YI-1-2)   (* b  f(YI-3-2)))  = (+ YI-1-2 (* b YI-3-2))" )
              ;;was "vi = (+ f(xi)  (* b f(qi)))  = (+ x (* b x))  
              ;;   OR  0; b=  0.2; WHERE f(x) = 0  if (<= x theta); f(x) = x  if (>= x theta)  ;theta = 0.3;")
              (YI-2-2 "YI-2-1 =(/ XI-2-2 (+ e  L2norm XI-2-2)) ;;L2norm = SUMi (* var var)")
              (XI-1-2 "XI-1-2 =  (+ YI-3-1  (* a  YI-2-2)) ;a= 0.5")
              ;;was (w  "wi = (+ Ii (* a ui)) ;a=0.5 ")
              (YI-1-2 "YI-1-2 =(/ XI-1-2 (+ e  L2norm XI-1-2)) ;;L2norm = SUMi (* var var)")
              ;;eg?? "ui = (/ vi (+ e  L2norm v)) ;;L2norm = SUMi (* var var)")
              ;;FIELD 1
              (XI-3-1 "XI-3-1 =  f(YI-1-1) ;;If Si-2-1 = f(Yi-1-1)" )
              (YI-3-1 "YI-3-1 =  (/ XI-3-1 (+ e  L2norm XI-3-1))")
              (XI-2-1 "XI-2-1 =  (+ f(YI-1-1)   (* b  f(YI-3-1)))  = (+ YI-1-1 (* b YI-3-1))" )
              ;;was "vi = (+ f(xi)  (* b f(qi)))  = (+ x (* b x))  
              ;;   OR  0; b=  0.2; WHERE f(x) = 0  if (<= x theta); f(x) = x  if (>= x theta)  ;theta = 0.3;")
              (YI-2-1 "YI-2-1 =(/ XI-2-1 (+ e  L2norm XI-2-1)) ;;L2norm = SUMi (* var var)")
              (XI-1-1 "XI-1-1 =  (+ INPUTI-1-1  (* a  YI-2-1)) ;a= 0.5")
              ;;was (w  "wi = (+ Ii (* a ui)) ;a=0.5 ")
              (YI-1-1 "YI-1-1 =(/ XI-1-1 (+ e  L2norm XI-1-1)) ;;L2norm = SUMi (* var var)")
              ;;eg?? "ui = (/ vi (+ e  L2norm v)) ;;L2norm = SUMi (* var var)")
              ;;WEIGHTS
              (wup "wupij =  SUMi  (* learning-rate  d  (my-floor (- pi  wupij) -0.2) " )
              (wdn "wdnji =  SUMi  (* learning-rate  d  (my-floor (- pi  wdnji) -0.2) ")
             ;; (UUPI-3-2TOI-1-3  "UUPI-3-2TOI-1-3 =  ???")
             ;;(UDNI-1-3TOI-3-2 "UDNI-1-3TOI-3-2 = ???")

              ;;OTHER
              (T "Tj = SUMi (* pi zij)  ;;(j = M + 1...N), M= max i number; Tj = max{Tj:  j= M+1...N}  F2 MAKES A CHOICE")
              (y  "yi = SUMj (* pi wupij) .  In CompetitiveF2, if y-max-output > 0.25, resets all other y-outputs to 0.0")
              )))

    ;;eg for (input v-activity ...)
    (loop
     for main-var in vars-list
     do
     (incf var-n)
     ;;find the right formula
     (setf formula (get-key-value-in-single-nested-list main-var formula-list))
     
     ;;get the specific dim vars
     (setf main-var-dimspecs (second (eval main-var))
           all-bottom-syms (find-bottom-art-instances main-var))

     (multiple-value-bind (max-index max-val maxSym  dims)
         (find-largest-ART-ValueIndex main-var)
     (setf var-text (format nil "~A~%>> FOR VAR= ~A, MAX-VAL=~A, Max-index= ~A;  maxSym=~A,  *overall-cycle-N=~A~%  FORMULA==>  ~A"  line  main-var max-val max-index maxsym  *overall-cycle-n   formula))    

     ;;eg for ((wup1-1..)(wup2-1...) ...)
    (loop
     for sublist in all-bottom-syms     
     do
     (when (listp sublist)
       (incf outer-dim-n)
       (setf subvar-text (format nil "~A [ "subvar-text))

       ;;eg for (wup1-1 wup 1-2...)
       (loop
        for subvar in sublist
        do  
        (incf inner-dim-n)
        (setf subvar-list (eval subvar))

        (multiple-value-bind (varname dims n value)
            (values-list subvar-list)
          (setf subvar-text (format nil "~A~A~A=~A; "subvar-text varname dims value))
          ;;end mvb, innermost loop
          ))
       (setf subvar-text (format nil "~A]" subvar-text))
       (setf var-text (format nil "~A~%~A"var-text subvar-text)
             subvar-text "")
       ;;end when,middle loop
       ))
    (setf cycle-text (format nil "~A~%~A" cycle-text var-text ) 
          var-text "")
    ;;end mvb, outer loop
    ))
    (setf cycle-text (format nil "~A~% ~A~%   =====> END *OVERALL-CYCLE-N=  ~A" cycle-text  cycle-line  *overall-cycle-n))
    cycle-text
    ;;end let, make-art-cycle-data-text
    ))
;;TEST
;;  (make-art-cycle-data-text '(input x wup))
;; works= ">>> FOR CYCLE-N= 30, VARIABLES= (INPUT V-ACTIVITY WUP)
#|------------------------------------------------------------------------------------------------------------------------------------------------------------
>> FOR VAR= INPUT, MAX-VAL=0.95456, Max-index= 4;  VarN=1,  Cycle-N=30
 ==>  INPUT
 [ Input(1)=0.046879992; Input(2)=-0.016479999; Input(3)=0.031359993; Input(4)=0.95456; Input(5)=0.93792; Input(6)=0.95264; Input(7)=-0.05792; Input(8)=-0.051199995; Input(9)=6.400049E-4; ] .... ETC
------------------------------------------------------------------------------------------------------------------------------------------------------------
>> FOR VAR= WUP, MAX-VAL=0.23860002, Max-index= (7 3);  VarN=3,  Cycle-N=30
 ==>  wupij =  SUMi SUMj (* learning-rate  d  pi  wupij) 
 [ Wup(1 1)=0.20155; Wup(1 2)=0.12715; Wup(1 3)=0.16225; Wup(1 4)=0.1612; Wup(1 5)=0.23065001; ]
.. ETC
 [ Wup(8 1)=0.12010001; Wup(8 2)=0.101950005; Wup(8 3)=0.119950004; Wup(8 4)=0.1684; Wup(8 5)=0.2245; ]
 [ Wup(9 1)=0.10345; Wup(9 2)=0.22855002; Wup(9 3)=0.22225002; Wup(9 4)=0.2362; Wup(9 5)=0.13645001; ]
  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> END OF CYCLE <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   =====> END CYCLE= 30"
|#




;;FIND-ART-ABOVE-MIN
;;
;;ddd 
(defun find-art-above-min  (art-sym  &key (min-val 0))
  "In U-ART, RETURNS (values min-indexes-list min-vals-list min-syms-list all-values-list). min-indexes-list includes only reset-val indeces, min-values-list includes all vals. Process ONE FIELD AT A TIME (eg RESETI-2-2 or RESETI-2-3) Returns NIL if none were reset. "
  (let*
      ((bottom-syms (find-bottom-art-instances art-sym))
       (min-indexes-list)
       (min-vals-list)
       (all-values-list)
       (min-index-list)
       (min-syms-list)
       (min-list)  
       (min-index 0)
       (val)
       (val)
       )
    (loop
     for sym  in  bottom-syms
     for min-index from 1 to (list-length bottom-syms)
     do
     (setf val (fourth (eval sym))) 
     (when (> val min-val)
       (setf min-indexes-list (append min-indexes-list (list min-index))
             min-syms-list (append min-syms-list (list sym))
             min-vals-list (append min-vals-list (list val)))
       ;;end when
       )
     ;;append all vals
     (setf all-values-list (append all-values-list (list val)))
     ;;end loop
     )   
    (values min-indexes-list min-vals-list min-syms-list all-values-list)
    ;;end let, find-art-above-min
    ))
;;TEST
;;  (find-art-above-min 'resetI-2-2)
;;  result= NIL NIL NIL (0 0 0 0 0)
;;  (setsymval 'reset3-2-2 nil  5.55) = ("reset" (3 2 2) NIL 0.555)  RESET3-2-2 0.555 0
;;  (find-art-above-min 'resetI-2-2)
;;  works= (3)  (0.555) (RESET3-2-2) (0 0 0.555 0 0)




;;MAKE-DIM-SYMBOL
;;
;;ddd
(defun make-dim-symbol (root &optional dimlist &key (separator-str "-") tail-string return-only-str-p (set-to-symvals-if-unbound-p T) value subsyms)
  "In U-ART, Makes a new art dim-symbol.  If set-to-symvals-if-unbound-p sets new sym to (root dimlist nil value subsyms).  If  RETURNS (values new-dimsym symdims-str symvals) eg WUPI-3-2TOI-1-3   \"WupI-3-2TOI-1-3\"). WILL NOT change values or subsyms if bound.  If bound, returns old value and old subsyms. Will work if ROOT is a proper artsym--creates symvals and sets the artsym to the symvals."
  (let
      ((symdims-str)
       (new-dimsym)
       (dimlist-str (make-dims-string dimlist :separator-str separator-str))
       (symvals)
       )

    (cond
     ((stringp root)    
      (cond
       (tail-string
        (setf symdims-str
              (format nil "~A~A~A" root dimlist-str tail-string)))
       (t
        (setf symdims-str
              (format nil "~A~A" root dimlist-str))))
      (unless return-only-str-p
      (setf new-dimsym (my-make-symbol symdims-str)))
      )
     ((symbolp root)
      (setf new-dimsym root
            symdims-str (format nil "~A" new-dimsym))
       (multiple-value-setq (dimlist root)
           (find-art-dims new-dimsym)))
     (t nil))

    ;;SET NEW-DIMSYM TO SYMVALS?
    (cond
     ((boundp new-dimsym)
      (setf symvals (eval new-dimsym)))
     (set-to-symvals-if-unbound-p
      (setf symvals (list root dimlist nil value subsyms))
      (set new-dimsym symvals))
     (t nil))

    (values new-dimsym symdims-str symvals)
    ;;end let, make-symdims-string
    ))
;;TEST
;; (make-dim-symbol "Wup"   '(i 8 3 to i 9 22) :value 0.55 :subsyms '(this that))
;; ;;works= WUPI-8-3TOI-9-22  "WupI-8-3TOI-9-22"  ("Wup" (I 8 3 TO I 9 22) NIL 0.55 (THIS THAT))
;;also: WUPI-8-3TOI-9-22 = ("Wup" (I 8 3 TO I 9 22) NIL 0.55 (THIS THAT))
;;  (make-dim-symbol "Wup"   '(i 8 3 to i 9 22) :value 0.99 :subsyms '(other))
;; works= WUPI-8-3TOI-9-22 "WupI-8-3TOI-9-22" ("Wup" (I 8 3 TO I 9 22) NIL 0.55 (THIS THAT)) [Didn't change value or subsyms because already set above.]
;;
;;  (make-dim-symbol "Wup"   '(i 8 3 to i 9 22))
;; works= WUPI-8-3TOI-9-22   "WupI-8-3TOI-9-22"
;;  (make-dim-symbol "Wup"   '(i 8 3 to i 9 22) :tail-string "tailstring")
;; works= WUPI-8-3TOI-9-22TAILSTRING    "WupI-8-3TOI-9-22tailstring"
;;
;;  (make-dim-symbol 'testxi-233-255 nil) = 
;; works=  (make-dim-symbol 'testxi-233-255)  TESTXI-233-255  "TESTXI-233-255"  ("TESTX" (I 233 255) NIL NIL NIL)


;;MAKE-DIMS-STRING
;;
;;ddd
(defun make-dims-string (dimlist &key (separator-str *art-index-separator )(key-list '(TO)))
  "In U-ART, RETURNS a dims-string (eg. \"1-2-3TO4-5-6\") from a dims-list eg. (1 2 3 :to 4 5 6) Otherwise inserts just separator-str."
  (let
      ((dims-string "")
       (no-separator-p)
       )
    (multiple-value-bind (n-dims n-items keys)
        (dimlist-length dimlist)
      (loop
       for item in dimlist
       for n from 1 to n-items
       do
       (cond
        ;;for key items
       ((member item key-list :test 'my-equal)
         (setf dims-string (format nil "~A~A" dims-string item)
               no-separator-p T))
        ;;for first item
        ((= n 1)
         (setf dims-string (format nil "~A" item)))
        ;;if following a key
        (no-separator-p
         (setf dims-string (format nil "~A~A" dims-string  item)
               no-separator-p nil))
        (t 
         (setf dims-string (format nil "~A~A~A" dims-string separator-str item)
               no-separator-p nil)))

       ;;end loop
       )
      dims-string
      ;;end let, mvb, make-art-dims-string
      )))
;;TEST
;; (make-dims-string '(11)) = "11"
;; (make-dims-string '(12 7 33)) = "12-7-33"
;;  (make-dims-string '(5 78 3 to 4 9 22)) =  "5-78-3TO4-9-22"
;; (make-dims-string '(i 8 3 to i 9 22)) = "I-8-3TOI-9-22"
;; (make-dims-string '(i l f))




;;FIND-DIM-SPEC-INFO
;;
;;dddsu
(defun find-dim-spec-info (dim-spec-list 
                           &key (node-separators '("to" to)))  ;; (separator  "-"))
  "In U-ART, RETURNS (values n-dims n-items sublist-Ns dimspec-lists n-dim1 n-dim2 dimspec-lists1 dimspec-lists2 )."
  (let
      ((n-dims 0)
       (separator)
       (node-separator)
       (node-sep-found-p)
       (n-items (list-length dim-spec-list))
       (n-subitems 0)
       (dimspec-lists)
       (dimspec-lists1)
       (dimspec-lists2)
       (sublists)
       (sublist-Ns)
       (n-dim1) 
       (n-dim2)
       )
    (loop
     for item in dim-spec-list
     for n from 1 to n-items
     do
     (cond
      ((listp item)
       (incf n-dims)
       (incf n-subitems)
       (cond
        (node-sep-found-p
         (setf dimspec-lists2 (append dimspec-lists2 (list item))))
        (t (setf dimspec-lists1 (append dimspec-lists1 (list item)))))
       )
      ((member item node-separators :test 'equal)
       (setf node-sep-found-p T)
       (setf sublist-Ns (append sublist-Ns (list n-subitems item))
             n-subitems 0))
      (t nil))
     ;;end loop
     )
    (setf sublist-Ns (append sublist-Ns (list n-subitems)))
    (cond
     (dimspec-lists2 
      (setf dimspec-lists (list dimspec-lists1 dimspec-lists2)))
     (t (setf dimspec-lists (list dimspec-lists1))))

    ;;added
    (when node-sep-found-p
      (setf n-dim1 (car sublist-Ns)
             n-dim2 (third sublist-Ns))
      ;;end when
      )

    (values n-dims n-items sublist-Ns dimspec-lists n-dim1 n-dim2 dimspec-lists1 dimspec-lists2 )
    ;;end let, find-dim-spec-info
    ))
;;TEST
;;  (find-dim-spec-info '((5 1 1 )  (3 1 1)  (3 1 1)))  ;;FOR X
;;  WORKS= 3  3 (3) (((5 1 1) (3 1 1) (3 1 1)))  NIL  NIL ((5 1 1) (3 1 1) (3 1 1)) NIL
;;  (find-dim-spec-info '((5 1 1)  (1 3 1)  (1 2 1) to (3 1 1 )  (1 1 1) (1 3 1))) ;;FOR WUP
;; WORKS= 6  7  (3 TO 3)  (((5 1 1) (1 3 1) (1 2 1)) ((3 1 1) (1 1 1) (1 3 1))) 3 3 ((5 1 1) (1 3 1) (1 2 1)) ((3 1 1) (1 1 1) (1 3 1))
;;  (find-dim-spec-info   '((5 1 1)(1 3 1)(1 2 1)TO (3 1 1)(1 1 1)(1 3 1)))    
;; works= 6  7  (3 TO 3)  (((5 1 1) (1 3 1) (1 2 1)) ((3 1 1) (1 1 1) (1 3 1)))  3  3 ((5 1 1) (1 3 1) (1 2 1)) ((3 1 1) (1 1 1) (1 3 1))



;;FIND-DIMS-INFO
;;
;;ddd
(defun find-dims-info (dims &key (node-separator 'TO))
  "In U-ART, RETURNS (values n-dims n-ints path-var-p  n-dims1 n-dims2 n-ints1 n-ints2  n-items)"
  (let
      ((n-items 0)
       (n-dims 0)
       (n-dims1 0)
       (n-dims2 0)
       (n-ints 0)
       (n-ints1 0)
       (n-ints2 0)
       (path-var-p)
       )
    (loop
     for item in dims
     do
     (incf n-items)
     (cond
      ((my-equal item node-separator)
       (setf path-var-p T))
      (path-var-p
       (incf n-dims2)
       (incf n-dims)
       (when (integerp item)
         (incf n-ints)
         (incf n-ints2)))
      (t
       (incf n-dims)
       (incf n-dims1)
       (when (integerp item)
         (incf  n-ints)
         (incf n-ints1))))
     ;;end loop
     )
    (values n-dims n-ints path-var-p  n-dims1 n-dims2 n-ints1 n-ints2  n-items)
    ;;end let, find-dims-info
    ))
;;TEST
;;  (find-dims-info  '(2 2 2)) = 3 3 NIL 3 0 3 0 3
;;  (find-dims-info  '(I 2 2)) = 3 2 NIL 3 0 2 0 3
;;  (find-dims-info  '(I L 2 TO I 3 4 )) = 6 3 T 3 3 1 2 7













;;-------------------------- DO I EVEN NEED THESE?? ----------------------

;;SET-CLASS-SYMVAL 
;;
;;ddd
(defun set-class-symval (sym value &optional key &key sym-end )
  "In U-ART, if sym is bound, puts value as second item in list, unless KEY.  If key, then sets value wherever key specifies, replacing value there unless append-key-p (SYMVALS = (name value (key1 value)(key2 value), etc) RETURNS (values  new-symvals new-keylist  return-value  final-spec-list old-keylist). If sym is a string creates symbol. If sym-end a string, adds to end of sym. (symvals = (name value (key1 value)(key2 value), etc).  NORMALLY value is a list of subclass symbols. "
  (let*
      ((sym-str)
       (symvals)
       (symvals)
       (new-symvals)
       (new-keylist)
       ;;replaced with new-symvals  (return-nested-lists)
       (return-value)
       (spec-list)
       (old-keylist)
       (old-item)
       )

    ;;make sure sym is a symbol and sym-str is a string
    (if sym-end 
        (setf sym-str  (format nil "~A~A" sym sym-end)
              sym sym-str))
    (if (symbolp sym) 
        (setf sym-str  (format nil "~A" sym ))
      (setf sym-str sym))                   
    (when (stringp sym)
      (setf sym (my-make-symbol sym)))

    (when (and (boundp sym)(listp (eval sym)))
      (setf symvals (eval sym)))

    (cond
     ;;symvals=T, key=NIL
     ((and symvals (null key))
      (multiple-value-setq (new-symvals old-item return-value)
          (replace-nth symvals 1 value)))
     ;;symbals=T
     ((null symvals)
      ;;symvals=NIL, key=NIL
      (if (null key)
          (setf  new-symvals (list sym-str value))
        ;;key=T
        (setf new-symvals (list sym-str nil (list key value)))))
     ;;symvals=T, key=T
     (t
       (multiple-value-setq (new-keylist new-symvals  return-value  spec-list old-keylist)
          (set-key-value-in-nested-lists value (list (list key 0))  symvals))
       ;;set-key- didn't work??

       (when (and (null new-keylist)  key)
         (setf new-keylist (list :NTH value)
               new-symvals (append symvals new-keylist)))
      ;;end t, outer cond
      ))
      ;; (t (setf new-symvals (list sym-str value))))

      ;;set the sym to the new-symvals (done in lower function)
       (set sym new-symvals)
      ;;end let, set-class-symval
      (values  new-symvals  new-keylist  return-value  spec-list old-keylist)
      ))
;;TEST
;; from initialized x-activity
;;  (set-class-symval 'x-activity 99 :key1)
;; works= ("X-Activity" ((X-ACTIVITY1 X-ACTIVITY2 X-ACTIVITY3 X-ACTIVITY4 X-ACTIVITY5)) (:KEY1 99))  (:KEY1 99)  NIL  NIL NIL
;;  (get-class-symval 'x-activity :key1)
;; works= 99    ("X-Activity" ((X-ACTIVITY1 X-ACTIVITY2 X-ACTIVITY3 X-ACTIVITY4 X-ACTIVITY5)) (:KEY1 99))
;; (get-class-symval 'x-activity)
;; works = ((X-ACTIVITY1 X-ACTIVITY2 X-ACTIVITY3 X-ACTIVITY4 X-ACTIVITY5))   ("X-Activity" ((X-ACTIVITY1 X-ACTIVITY2 X-ACTIVITY3 X-ACTIVITY4 X-ACTIVITY5)) (:KEY1 99)

;; (setf input  '("input" (input1 input2 input3) (:key1 this)(:key2 that)))
;; then (set-class-symval 'input 99 :key2)  =  ("input" (INPUT1 INPUT2 INPUT3) (:KEY1 THIS) (:KEY2 99))   (:KEY2 99)  99  (:KEY2 0)  (:KEY2 THAT)
;; then CL-USER 179 > input =  ("input" (INPUT1 INPUT2 INPUT3) (:KEY1 THIS) (:KEY2 99))
;; 
;;  (set-class-symval "classX1" 99) = ("classX" 99) NIL NIL NIL NIL
;;  (set-class-symval "classX1" 67  nil :sym-end  "end") = ("classXend" 99)  NIL  NIL NIL NIL
;; CL-USER 11 > classX1end = ("classXend" 99)
;; (set-class-symval "classX1end" 77) = ("classXend" 77) NIL 77 NIL NIL
;;  (set-class-symval "classX1end" .22 :key1) = ("classX1end" 77 (:KEY1 0.22))  NIL  NIL  NIL  NIL
;;  (set-class-symval "classX1" .44 :key1) = ("classX1" NIL (:KEY1 0.44)) NIL NIL NIL NIL
 ;;  (set-class-symval "classX1" .11 :key1) = ("classX1" 79 (:KEY1 0.11))  :KEY1 0.11)  NIL  NIL NIL
;;  (makunbound-vars '(classX1 classX1end classXX1))


     

;;GET-CLASS-SYMVAL
;;
;;ddd
(defun get-class-symval (class-sym  &optional key ) ;;later?? &key sym-end)
  "In U-ART, if sym is bound, gets value as second item in list, unless KEY.  RETURNS (values  new-symvals new-keylist  return-value  final-spec-list old-keylist). If sym is a string creates symbol. If sym-end a string, adds to end of sym. (symvals = (name value (key1 value)(key2 value), etc). NORMALLY value is a list of subclass symbols if NO KEY."

  (let*
      (;;(sym-str)
       (symvals (eval class-sym))
       ;;replaced with new-symvals  (return-nested-lists)
       (class-name-str (car symvals))
       ;;value is normally a list of class instance symbols
       (value (second symvals))
      )

    (when key
      (setf keylist
        (get-key-value-in-nested-lists (list (list key 0)) symvals  :return-list-p t)
        value (second keylist)))

    (values value symvals)
    ;;end let, get-class-symval
    ))
;;TEST
;;  (get-class-symval 'input)
;;  (set-class-symval 'x-activity 99 :key1)
;; works= ("X-Activity" ((X-ACTIVITY1 X-ACTIVITY2 X-ACTIVITY3 X-ACTIVITY4 X-ACTIVITY5)) (:KEY1 99))  (:KEY1 99)  NIL  NIL NIL
;;  (get-class-symval 'x-activity :key1)
;; works= 99    ("X-Activity" ((X-ACTIVITY1 X-ACTIVITY2 X-ACTIVITY3 X-ACTIVITY4 X-ACTIVITY5)) (:KEY1 99))
;; (get-class-symval 'x-activity)
;; works = ((X-ACTIVITY1 X-ACTIVITY2 X-ACTIVITY3 X-ACTIVITY4 X-ACTIVITY5))   ("X-Activity" ((X-ACTIVITY1 X-ACTIVITY2 X-ACTIVITY3 X-ACTIVITY4 X-ACTIVITY5)) (:KEY1 99)




;;SETSUBSYMS
;;
;;ddd
(defun setsubsyms (artsym subsyms &key (omit-duplicates-p T) graph-slot)
  "In U-ART, appends the subsyms list in symvals of artsym with subsyms. Note:  RETURNS (values new-subsyms new-symvals  value artsym joint-items). Use make-artsyms-from-dims to make artsym first if unbound. If omit-duplicates-p, only adds non-duplicates and also returns joint-items."
  (let
      ((symvals)
       (old-subsyms)
       (new-subsyms)
       (new-symvals)
       (joint-items)
       (rootstr)
       (dims)
       (value)
       (rest)
       )
    (when (boundp artsym)
      (setf symvals (eval artsym)
      rootstr (car symvals)
      dims (second symvals)
      graph-slot (third symvals)
      value (fourth symvals)
      old-subsyms (fifth symvals)
      rest (nthcdr 5 symvals))

      (when omit-duplicates-p
        (multiple-value-setq (joint-items subsyms)
            (my-member-list subsyms old-subsyms)))  

      (unless (listp subsyms)
        (setf subsyms (list subsyms)))

      (setf new-subsyms (append old-subsyms subsyms)
            new-symvals (list rootstr dims graph-slot value new-subsyms))
      (set artsym new-symvals)
      ;;end when
      )
      (values new-subsyms new-symvals  value artsym joint-items)
    ;;end let, setsubsyms
    ))
;;TEST
;; first WUPI-L-2TOI-L-3 = ("Wup" (I L 2 TO I L 3) NIL NIL ((WUPI-3-2TOI-1-3)))
;;  (setsubsyms 'WUPI-L-2TOI-L-3 '(WUPI-1-2TOI-1-3 WUPI-L-2TOI-2-3))
;; (setsubsyms 'WUPI-L-2TOI-L-3 '(WUPI-1-2TOI-1-3 WUPI-L-2TOI-2-3))
;; works= (WUPI-3-2TOI-1-3 WUPI-1-2TOI-1-3 WUPI-L-2TOI-2-3)
;;  ("Wup" (I L 2 TO I L 3) NIL NIL (WUPI-3-2TOI-1-3 WUPI-1-2TOI-1-3 WUPI-L-2TOI-2-3))  NIL WUPI-L-2TOI-L-3 NIL
;; WUPI-L-2TOI-L-3  =  ("Wup" (I L 2 TO I L 3) NIL NIL (WUPI-3-2TOI-1-3 WUPI-1-2TOI-1-3 WUPI-L-2TOI-2-3))

;;older used nested lists
;; works = ((WUPI-3-2TOI-1-3) (WUPI-1-2TOI-1-3 WUPI-L-2TOI-2-3))     ("Wup" (I L 2 TO I L 3)  NIL NIL   ((WUPI-3-2TOI-1-3) (WUPI-1-2TOI-1-3 WUPI-L-2TOI-2-3)))  NIL  WUPI-L-2TOI-L-3  NIL




;;GETSUBSYMS
;;
;;ddd
(defun getsubsyms (sym)
  "In U-ART"
  (let
      ((symvals)
       (subsyms)
       )
    (when (and (symbolp sym)(boundp sym))
      (setf symvals (eval sym)
            subsyms (fifth symvals)))
    subsyms
    ;;end let, getsubsyms
    ))
;;TEST
;; (getsubsyms 'WUPI-3-2TOI-1-3)
;; WORKS= (WUP1-3-2TO1-1-3 WUP1-3-2TO2-1-3 WUP1-3-2TO3-1-3 WUP1-3-2TO4-1-3 WUP1-3-2TO5-1-3 WUP2-3-2TO1-1-3 WUP2-3-2TO2-1-3 WUP2-3-2TO3-1-3 WUP2-3-2TO4-1-3 WUP2-3-2TO5-1-3 WUP3-3-2TO1-1-3 WUP3-3-2TO2-1-3 WUP3-3-2TO3-1-3 WUP3-3-2TO4-1-3 WUP3-3-2TO5-1-3 WUP4-3-2TO1-1-3 WUP4-3-2TO2-1-3 WUP4-3-2TO3-1-3 WUP4-3-2TO4-1-3 WUP4-3-2TO5-1-3 WUP5-3-2TO1-1-3 WUP5-3-2TO2-1-3 WUP5-3-2TO3-1-3 WUP5-3-2TO4-1-3 WUP5-3-2TO5-1-3 WUP6-3-2TO1-1-3 WUP6-3-2TO2-1-3 WUP6-3-2TO3-1-3 WUP6-3-2TO4-1-3 WUP6-3-2TO5-1-3 WUP7-3-2TO1-1-3 WUP7-3-2TO2-1-3 WUP7-3-2TO3-1-3 WUP7-3-2TO4-1-3 WUP7-3-2TO5-1-3 WUP8-3-2TO1-1-3 WUP8-3-2TO2-1-3 WUP8-3-2TO3-1-3 WUP8-3-2TO4-1-3 WUP8-3-2TO5-1-3 WUP9-3-2TO1-1-3 WUP9-3-2TO2-1-3 WUP9-3-2TO3-1-3 WUP9-3-2TO4-1-3 WUP9-3-2TO5-1-3)




;;SETSUBSYMS-IN-SYMLIST
;;
;;ddd
(defun setsubsyms-in-symlist (symlist subsyms)
  "In U-ART. Appends the same subsyms list to each artsym in symlist. RETURNS syms-reset-list. "
  (let
      ((new-subsymval)
       (syms-reset-list)
       )
    (loop
     for sym in symlist
     do
     (setf new-subsymval
     (setsubsyms sym subsyms))
     (when new-subsymval
       (setf syms-reset-list (append syms-reset-list (list sym))))
     ;;end loop
     )
    syms-reset-list
    ;;end let, setsubsyms-in-symlist
    ))
;;TEST
;; (setsubsyms-in-symlist '(WUPI-L-2TOI-L-1 ) ''(WUPI-1-2TOI-L-1 WUPI-L-2TOI-2-1))
;; works= 




;;DIMLIST-IS-INTS-P
;;
;;ddd
(defun dimlist-is-ints-p (dimlist &key (node-separator *art-node-separator))
  "In U-ART, tests to see if an ART dimlist has all integers (or node-separators)"
  (let
      ((n-integers 0)
       (n-items (length dimlist))
       (no-result T)
       )
    (cond
     ((and dimlist (listp dimlist))
      (dolist (item dimlist)
        (cond
         ((integerp item)
          (incf n-integers))
         ((my-equal item node-separator)
          NIL)
         (t (setf n-integers nil) (return)))
        ;;end dolist, and
        ))
     (t (setf n-integers nil)))
    (values n-integers n-items)
    ;;end let, dimlist-is-ints-p
    ))
;;TEST
;;  (dimlist-is-ints-p '(1 2 a TO 3 4 5)) = NIL 7
;; (dimlist-is-ints-p '(1 2 3 TO 3 4 5)) =  6  7
;; (dimlist-is-ints-p  '(I L F TO I L 3))
;; (dimlist-is-ints-p nil)



;;SET-ART-BOTTOMSYM-VALUES
;;
;;ddd
(defun set-art-bottomsym-values (artsym value)
  "In U-ART, from any higher artsym, finds all bottom syms and sets them to same value. RETURNS symlist"
  (let
      ((bottomsyms (find-bottom-art-instances artsym))
       )
    (loop
      for sym in bottomsyms
      do
      ;;set all initial values for bottom level syms
      (setsymval  sym  nil  value)
      ;;end loop, when
      )
    bottomsyms
    ;;end let, set-art-bottomsym-values
    ))
;;TEST
;; (set-art-bottomsym-values 'xi-l-f  0.1)
;; works X8-2-2 = ("X" (8 2 2) NIL 0.1 NIL) & rest also work




;;GET-ART-BOTTOMSYM-VALUES
;;
;;ddd
(defun get-art-bottomsym-values (artsym)
  "In U-ART, from any higher artsym, finds all bottom syms and GETS VALUES them to same value. RETURNS (values sym-value-lists value-list)"
  (let
      ((bottomsyms (find-bottom-art-instances artsym))
       (sym-value-lists)
       (sym-val-list)
       (val)
       (value-list)
       )
    (loop
      for sym in bottomsyms
      do
      ;;set all initial values for bottom level syms
      (setf val (fourth (eval sym))
            value-list (append value-list (list val))
            sym-val-list (list sym val)
            sym-value-lists (append sym-value-lists (list sym-val-list)))
      ;;end loop, when
      )
    (values sym-value-lists value-list)
    ;;end let, get-art-bottomsym-values
    ))
;;TEST
;; (get-art-bottomsym-values 'WUPI-L-FTOI-L-F)
;; works= ((WUP1-3-2TO1-1-3 0.4939) (WUP1-3-2TO2-1-3 0.499) (WUP1-3-2TO3-1-3 0.4283) (WUP1-3-2TO4-1-3 0.4286) (WUP1-3-2TO5-1-3 0.469) (WUP2-3-2TO1-1-3 0.4242) (WUP2-3-2TO2-1-3 0.433) .....(WUP9-3-2TO3-1-3 0.44120002) (WUP9-3-2TO4-1-3 0.4781) (WUP9-3-2TO5-1-3 0.44730002))
;; (get-art-bottomsym-values 'xi-2-2)
;;((X1-2-2 4.5461745) (X2-2-2 4.149624) (X3-2-2 3.584882) (X4-2-2 0.0010999999) (X5-2-2 3.812347) (X6-2-2 0.0010999999) (X7-2-2 3.860172) (X8-2-2 4.0231) (X9-2-2 3.6214159))
;;(4.5461745 4.149624 3.584882 0.0010999999 3.812347 0.0010999999 3.860172 4.0231 3.6214159)


;;SET-ART-VALUES-FROM-ROOT
;;
;;ddd
(defun set-art-values-from-root (root-sym &key default-value 
                                               random-lo-val random-hi-val ) 
  "In U-ART, sets initial values from  a root-sym and either default-value or random-lo-val random-hi-val. RETURNS (values bottom-syms-list subsyms-list error-syms-list)" 
  (let*
      ((symval-list) 
       (sym-list)  ;;was second
       (bottom-syms-list)
       (subsyms-list)
       (error-syms-list)
       (dims)(rootstr)
       )
    ;;not needed when syms exist
    (unless (and (symbolp  root-sym)(boundp root-sym))
      (multiple-value-setq (dims rootstr)
          (find-art-dims root-sym))
      (setf root-sym (my-make-symbol root-sym))
      (set root-sym (list root-sym (list rootstr dims nil nil nil))))

    ;;normally starts here
    (setf symval-list (eval root-sym)
          ;;sym-list (fourth symval-list)
          subsyms-list (fifth symval-list))

    (when subsyms-list
      (multiple-value-setq (bottom-syms-list subsyms-list error-syms-list)
          (find-bottom-art-instances root-sym))

      (setf values-list
            (set-art-values-from-symlist bottom-syms-list
                                              :default-value default-value 
                                              :random-lo-val    random-lo-val  
                                              :random-hi-val   random-hi-val))
     ;;  (setf  return-vals-list (append return-vals-list (list return-vals)))
       ;;end when
       )
    (values bottom-syms-list subsyms-list values-list error-syms-list)
    ;;end let, set-init-art-values-from-root
    ))
;;TEST
;; (set-art-values-from-root 'wupI-L-FTOI-L-F  :random-lo-val *wUpInitLo  :random-hi-val *wUpInitHi  )
;; RESULTS=
#|(WUP1-3-2TO1-1-3 WUP1-3-2TO2-1-3 WUP1-3-2TO3-1-3 WUP1-3-2TO4-1-3 WUP1-3-2TO5-1-3 WUP2-3-2TO1-1-3 WUP2-3-2TO2-1-3 WUP2-3-2TO3-1-3 WUP2-3-2TO4-1-3 WUP2-3-2TO5-1-3 WUP3-3-2TO1-1-3 WUP3-3-2TO2-1-3 WUP3-3-2TO3-1-3 WUP3-3-2TO4-1-3 WUP3-3-2TO5-1-3 WUP4-3-2TO1-1-3 WUP4-3-2TO2-1-3 WUP4-3-2TO3-1-3 WUP4-3-2TO4-1-3 WUP4-3-2TO5-1-3 WUP5-3-2TO1-1-3 WUP5-3-2TO2-1-3 WUP5-3-2TO3-1-3 WUP5-3-2TO4-1-3 WUP5-3-2TO5-1-3 WUP6-3-2TO1-1-3 WUP6-3-2TO2-1-3 WUP6-3-2TO3-1-3 WUP6-3-2TO4-1-3 WUP6-3-2TO5-1-3 WUP7-3-2TO1-1-3 WUP7-3-2TO2-1-3 WUP7-3-2TO3-1-3 WUP7-3-2TO4-1-3 WUP7-3-2TO5-1-3 WUP8-3-2TO1-1-3 WUP8-3-2TO2-1-3 WUP8-3-2TO3-1-3 WUP8-3-2TO4-1-3 WUP8-3-2TO5-1-3 WUP9-3-2TO1-1-3 WUP9-3-2TO2-1-3 WUP9-3-2TO3-1-3 WUP9-3-2TO4-1-3 WUP9-3-2TO5-1-3)
(WUPI-L-FTOI-L-F WUPI-L-2TOI-L-3 WUPI-3-2TOI-1-3)
(0.42000002 0.4383 0.4926 0.42450002 0.43490002 0.4763 0.4506 0.4576 0.41730002 0.4068 0.4528 0.4345 0.45340002 0.4378 0.4695 0.4754 0.4558 0.4247 0.4163 0.419 0.4871 0.4542 0.4294 0.4903 0.4459 0.4228 0.456 0.439 0.4135 0.48360002 0.4508 0.4551 0.4018 0.4929 0.422 0.49830002 0.4724 0.4002 0.4052 0.4515 0.4074 0.4041 0.4242 0.4499 0.4285)
NIL|#
;; (find-bottom-art-instances 'wupI-L-FTOI-L-F)
;;




;;SET-ART-VALUES-FROM-SYMLIST
;; 
;;ddd
(defun set-art-values-from-symlist (sym-list &key default-value random-lo-val random-hi-val)
  "In U-ART, sets initial values from either 1-default-value OR random-lo random-hi-val. Eg.  '(x1-1-1 x2-1-1 x-3-1-1 x1-2-1 ....), random-lo-val,random-hi-val. RETURNS list of values." 
  (let
      ((new-value)
       (new-values-list)
       )
    (loop
     for sym in sym-list
     do
     (cond
      (default-value
       (setsymval sym NIL default-value)
       (setf new-values-list (append new-values-list (list default-value))))
      ((and  random-lo-val random-hi-val)
       (setf new-value (frandom random-lo-val random-hi-val))
       (setsymval sym NIL new-value)
       (setf new-values-list (append new-values-list (list new-value))))
      (t nil))
     ;;end loop
     )

 ;; (setf  *art-cycle-data-text (list (format nil "~A~%In zeroActivations: RESETTING ~A~%~A" *art-cycle-data-text 1-dim-nInputs-sym-list  1-dim-nOutputs-sym-list)))
    new-values-list
    ;;end let, set-init-art-values-from-root
    ))




;;TO COPY WHOLE SETS OF NETWORK VALUES ------------------------------
;;

;;COPY-ART-VALUES-FROM-ROOT
;;
;;ddd
(defun copy-art-values-from-root (from-root-sym to-root-sym)
  "In U-ART, copies values from NON-NESTED  from-root-sym list to to-root-sym list of syms."  
  (let
      ((from-symlist (find-bottom-art-instances from-root-sym))
       (to-symlist (find-bottom-art-instances  to-root-sym))
       (from-sym)
       (to-sym)
       (return-vals)
       )
    (setf return-vals
           (copy-art-values-from-syms-lists from-symlist to-symlist))
    ;;end let, copy-art-values-from-root
    ))
;;TEST
;; (set-art-values-from-root  'WUPI-L-FTOI-L-F :random-lo-val *wUpInitLo   :random-hi-val *wUpInitHi)
;;  (copy-art-values-from-root 'WUPI-L-FTOI-L-F  'UUPI-L-FTOI-L-F)
;;  seems to work  UUP4-3-2TO2-1-3 = ("Uup" (4 3 2 TO 2 1 3) NIL 0.4312)




;;COPY-ART-VALUES-FROM-SYMS-LISTS
;;
;;ddd
(defun copy-art-values-from-syms-lists (from-syms to-syms) 
  "In U-ART, copies values from syms in non-nested from-syms to syms in non-nested to-syms CHECKS DIMLISTS of each match items. RETURNS values-list" 
  (let
      ((value)
       (from-symvals)
       (to-symvals)
       (from-dimlist)
       (to-dimlist)
       (values-list)
       )
    
    (loop
     for from-sym in from-syms
     for to-sym in  to-syms
     do
     ;;find initial value and symvals, eg ("Wup"  (2 3 1 4 1 2 "To") 9  0.77)
     ;; (multiple-value-setq (value from-symvals)

     ;;CHECK DIMLIST MATCH
     (setf from-symvals (eval from-sym)
           to-symvals (eval to-sym)
          from-dimlist (second from-symvals)
          to-dimlist (second to-symvals))
     (when (my-equal-lists from-dimlist to-dimlist :exclusion-items '(TO))
       (setf value (fourth from-symvals)
             values-list (append values-list (list value)))

       ;;set the values for corresponding copy-to-sym
       (setsymval to-sym nil value)
       ;;end when dimlists match
       )      
     ;;end loop
     )

    ;;(setf  *art-cycle-data-text (list (format nil "~A~%In zeroActivations: RESETTING ~A~%~A" *art-cycle-data-text 1-dim-nInputs-sym-list  1-dim-nOutputs-sym-list)))
    values-list
    ;;end let, copy-art-values-from-syms-lists
    ))


;;GET-DEFAULT-SYM-GRAPH-SLOT
;;
;;ddd
(defun get-default-sym-graph-slot (root)
  "In U-ART, uses root sym eg input, x, wup, etc to retrieve the slotname for temp storing graph point values in graphing instances. Root can be string or symbol."
  (let
      ((rootsym)
       (slotname)
       (best-match)
       )
  (cond
   ((stringp root)
    (setf rootsym (my-make-symbol root)))
   (t (setf rootsym root)))
  
  (setf slotname (getsymval rootsym nil :value-n 2))

  (when (and (null slotname)
             (setf best-match (nth-value 4 (find-best-match root *art-graph-var-slots))))
    (setf slotname best-match))
;;(nth-value 4 (find-best-match 'xi-2-2 '(reset-points xi-2-2-points y-points))) = XI-2-2-POINTS
  ;;SSS FINISH
#|  (when (null slotname)
    (find other way to get slotname -- new function for get slots from class or just make a list of all slots with corresponding topsyms))|#

  (values slotname rootsym)
  ;;end let, get-default-sym-graph-slot
    ))
;;TEST
;; (get-default-sym-graph-slot 'input)
;; (get-default-sym-graph-slot 'xi-2-2) = NIL XI-2-2
;; (slot-exists-p  'art-multipane-interface 'xi-2-2) = NIL EVEN THO EXISTS IN CLASS













;;****************** FUNCTIONS THAT MAY WORK BUT NOT CURRENTLY USED? ********

;;SORT-ART-SYMS-BY-DIM2
;;
;;ddd
(defun sort-art-syms-by-dim2 (root dim-n &key return-nth-list)
  "In U-ART. Sorts syms list of (eval root) by one dim (eg dim 2 of  3 or 6 dims in dimlist).
 RETURNS (values sorted-lists return-syms). dim-n starts with 1"
  (let
      ((symval-list (eval root))
       (root-str (car symval-list))
       (symlist (second symval-list))
       (rest-list (cddr symval-list))
       (sym-dim-list)
       (sym-dim-lists)
       (sorted-symlist)
       (sorted-symval-list)
       (sorted-sym-dims-lists)
       (nth-list)
       (num-lists)
       (return-list)
       )
    ;;SSS
    ;;make a big sym-dims-list so can sort by it?
    (loop
     for sym in symlist
     do
     (let*
         ((symlist1 (eval sym))
          (dimlist (second symlist))
          (dim (nth (- dim-n 1) simlist))
          )
       (setf sym-dim-list (list dim sym)
             sym-dims-list (append sym-dims-list (list sym-dim-list)))
       ))

    (setf sorted-sym-dims-lists (NEW?? GROUP-BY-NTH sym-dims-list 0))
    
    (setf sorted-symval-list (append (list root-str sorted-sym-dims-lists) rest-list))

   (when return-nth-list
      (setf return-list (elt sorted-symlist return-nth-list)))

    (values sorted-symval-list n return-list)
    ;;end let, sort-art-syms-by-dim2
    ))





;;SORT-ART-SYMS-BY-DIM
;;
;;ddd
(defun sort-art-syms-by-dim (dim-n syms-list 
                                   &key  dimlabel   nest-syms-p
                                   sort-each-group) ;;was (sort-each-group #'test-lessp))
  "In U-ART. Sorts a flat list of art syms.  RETURNS (values groups-list sorted-groups-list )  Note: dim-n from 1, USE dim-n= 5 for WUP.  TO counts as a dim. sort-each-group key needs work. If dimlabel, puts dimlabel before  the dim in each sublist. If also nest-syms-p, then creates a list such as (dimlabel 1 (WUP1-2-2TO3-1-3 ...)"
  (let
      ((n-syms (list-length syms-list))
       (symvals)
       (dims)
       (dim-index)
       (syms)
       (group-list)
       (new-group-list)
       (groups-list)  
       (sorted-groups-list)
       (revised-groups-list)
       (list)
       )
    (loop
     for sym in syms-list
     for n from 1 to n-syms
     ;;for nth from 0 upto n-syms
     do
     (when (and (symbolp sym)(boundp sym))
       (setf symvals (eval sym)
             dims (second symvals)
             dim-index (nth (- dim-n 1) dims))
       
       (when groups-list
         (setf group-list (get-key-list dim-index groups-list)))
;;(get-key-list 2   '((1 TEST1-2-2TO1-1-3) (2 TEST2-2-2TO2-1-3) (3 TEST3-2-2TO1-1-3)))
       (cond
        ;;if group already exists
        (group-list
         (setf new-group-list (append group-list (list sym))
               groups-list (replace-list-item new-group-list  group-list groups-list)
               ;;(replace-list-item '(new)  '(2 TEST2-2-2TO2-1-3) '((1 TEST1-2-2TO1-1-3) (2 TEST2-2-2TO2-1-3) (3 TEST3-2-2TO1-1-3)))
               group-list nil))
        (t (setf new-group-list (list dim-index sym)
                 groups-list (append groups-list (list new-group-list)))))
       ;;end when, loop
       ))
    ;;(setf gl1 '(dimlabel 1 (a b c)))
    ;;(append (butlast gl1)(list (append (car (last gl1)) (list 99)))) = (DIMLABEL 1 (A B C 99))
   
     ;;if sort-each-group, 
     (cond
      (sort-each-group
       ;;first sort by the dim-index
       (setf groups-list (my-sort groups-list sort-each-group))
       ;;then sort within each group (after remove initial dim-index)
       (loop
        for list in groups-list
        do
        ;;remove dim-index
        (setf  list (cdr list))
        (setf  list (my-sort list sort-each-group)
               sorted-groups-list (append sorted-groups-list (list list)))
        ;;end loop, sort-each-group
        ))
      (t  nil))

     ;;If nest-syms-p, put syms into an inner list; if dimlabel add it
     (when (or dimlabel nest-syms-p)
       (loop
        for group in groups-list
        do
        (cond
         (dimlabel
          (setf group  (append (list dimlabel (first group))(list (cdr group)))))
         (t (setf group  (append (list (first group)) (list (cdr group))))))

        (setf revised-groups-list (append revised-groups-list (list group)))
        ;;end loop
        )
       (setf groups-list revised-groups-list)
       ;;end when
       )       
       (values groups-list sorted-groups-list )
    ;;end let, sort-art-syms-by-dim
    ))
;;TEST
;;Format for art graphing:
;; (sort-art-syms-by-dim 1 '(WUP1-3-2TO1-1-3 WUP1-3-2TO2-1-3 WUP1-3-2TO3-1-3 WUP1-3-2TO4-1-3 WUP1-3-2TO5-1-3 WUP2-3-2TO1-1-3 WUP2-3-2TO2-1-3 WUP2-3-2TO3-1-3 WUP2-3-2TO4-1-3 WUP2-3-2TO5-1-3 WUP3-3-2TO1-1-3 WUP3-3-2TO2-1-3 WUP3-3-2TO3-1-3 WUP3-3-2TO4-1-3 WUP3-3-2TO5-1-3 WUP4-3-2TO1-1-3 WUP4-3-2TO2-1-3 WUP4-3-2TO3-1-3 WUP4-3-2TO4-1-3 WUP4-3-2TO5-1-3 WUP5-3-2TO1-1-3 WUP5-3-2TO2-1-3 WUP5-3-2TO3-1-3 WUP5-3-2TO4-1-3 WUP5-3-2TO5-1-3 WUP6-3-2TO1-1-3 WUP6-3-2TO2-1-3 WUP6-3-2TO3-1-3 WUP6-3-2TO4-1-3 WUP6-3-2TO5-1-3 WUP7-3-2TO1-1-3 WUP7-3-2TO2-1-3 WUP7-3-2TO3-1-3 WUP7-3-2TO4-1-3 WUP7-3-2TO5-1-3 WUP8-3-2TO1-1-3 WUP8-3-2TO2-1-3 WUP8-3-2TO3-1-3 WUP8-3-2TO4-1-3 WUP8-3-2TO5-1-3 WUP9-3-2TO1-1-3 WUP9-3-2TO2-1-3 WUP9-3-2TO3-1-3 WUP9-3-2TO4-1-3 WUP9-3-2TO5-1-3)   :dimlabel :DIMSIM :nest-syms-p  T)
;;WORKS=  ((:DIMSIM 1 (WUP1-3-2TO1-1-3 WUP1-3-2TO2-1-3 WUP1-3-2TO3-1-3 WUP1-3-2TO4-1-3 WUP1-3-2TO5-1-3)) (:DIMSIM 2 (WUP2-3-2TO1-1-3 WUP2-3-2TO2-1-3 WUP2-3-2TO3-1-3 WUP2-3-2TO4-1-3 WUP2-3-2TO5-1-3)) (:DIMSIM 3 (WUP3-3-2TO1-1-3 WUP3-3-2TO2-1-3 WUP3-3-2TO3-1-3 WUP3-3-2TO4-1-3 WUP3-3-2TO5-1-3)) (:DIMSIM 4 (WUP4-3-2TO1-1-3 WUP4-3-2TO2-1-3 WUP4-3-2TO3-1-3 WUP4-3-2TO4-1-3 WUP4-3-2TO5-1-3)) (:DIMSIM 5 (WUP5-3-2TO1-1-3 WUP5-3-2TO2-1-3 WUP5-3-2TO3-1-3 WUP5-3-2TO4-1-3 WUP5-3-2TO5-1-3)) (:DIMSIM 6 (WUP6-3-2TO1-1-3 WUP6-3-2TO2-1-3 WUP6-3-2TO3-1-3 WUP6-3-2TO4-1-3 WUP6-3-2TO5-1-3)) (:DIMSIM 7 (WUP7-3-2TO1-1-3 WUP7-3-2TO2-1-3 WUP7-3-2TO3-1-3 WUP7-3-2TO4-1-3 WUP7-3-2TO5-1-3)) (:DIMSIM 8 (WUP8-3-2TO1-1-3 WUP8-3-2TO2-1-3 WUP8-3-2TO3-1-3 WUP8-3-2TO4-1-3 WUP8-3-2TO5-1-3)) (:DIMSIM 9 (WUP9-3-2TO1-1-3 WUP9-3-2TO2-1-3 WUP9-3-2TO3-1-3 WUP9-3-2TO4-1-3 WUP9-3-2TO5-1-3)))

;;RESULTS FOR DIM = 5 (TO counts as a dim), PPRINTED:
;;works= ((:DIMSIM 1 (WUP1-3-2TO1-1-3 WUP2-3-2TO1-1-3 WUP3-3-2TO1-1-3 WUP4-3-2TO1-1-3 WUP5-3-2TO1-1-3 WUP6-3-2TO1-1-3 WUP7-3-2TO1-1-3 WUP8-3-2TO1-1-3 WUP9-3-2TO1-1-3)) (:DIMSIM 2 (WUP1-3-2TO2-1-3 WUP2-3-2TO2-1-3 WUP3-3-2TO2-1-3 WUP4-3-2TO2-1-3 WUP5-3-2TO2-1-3 WUP6-3-2TO2-1-3 WUP7-3-2TO2-1-3 WUP8-3-2TO2-1-3 WUP9-3-2TO2-1-3)) (:DIMSIM 3 (WUP1-3-2TO3-1-3 WUP2-3-2TO3-1-3 WUP3-3-2TO3-1-3 WUP4-3-2TO3-1-3 WUP5-3-2TO3-1-3 WUP6-3-2TO3-1-3 WUP7-3-2TO3-1-3 WUP8-3-2TO3-1-3 WUP9-3-2TO3-1-3)) (:DIMSIM 4 (WUP1-3-2TO4-1-3 WUP2-3-2TO4-1-3 WUP3-3-2TO4-1-3 WUP4-3-2TO4-1-3 WUP5-3-2TO4-1-3 WUP6-3-2TO4-1-3 WUP7-3-2TO4-1-3 WUP8-3-2TO4-1-3 WUP9-3-2TO4-1-3)) (:DIMSIM 5 (WUP1-3-2TO5-1-3 WUP2-3-2TO5-1-3 WUP3-3-2TO5-1-3 WUP4-3-2TO5-1-3 WUP5-3-2TO5-1-3 WUP6-3-2TO5-1-3 WUP7-3-2TO5-1-3 WUP8-3-2TO5-1-3 WUP9-3-2TO5-1-3)))




;;MAKE-GRAPH-POINTS-SUBLIST
;;
;;ddd
(defun make-graph-points-sublist (flat-sym-list 
                                  &key  (x-pix 0) (topsym-points-sym "Graph")
                                  begin-dims  end-dims
                                  (initial-x-pix 0) (incr-x-pix 40)
                                  append-symvals-p
                                  (use-label-abbrev-p T) (add-label-p T))
  "In U-ART, RETURNS flat-points-list. INPUT a flat-sym-list with NO keys etc."
  (let
      ((flat-points-list)
       (n-syms (list-length flat-sym-list))
       (sym-i 0)
       )
    (loop
     for sym in flat-sym-list
     for n from 1 to n-syms
     do
     (let*
         ((symvals (eval sym))
          (root (first symvals))
          (lastfield-n (third symvals))
          (value (fourth symvals))
          (point)
          (preitems)
          ;;sss write abbreviate-sym later
          (label-abbrev)    ;;in config-art
          (dims)
          (n-dims)
          (sym-j)
          ) 

       (setf dims (second symvals)
             n-dims (dimlist-length dims)
             ;;was sym-i  (car dims)
             sym-j (second dims))
       ;;(incf sym-i)

       ;;ADDED when in dims range
       (when (or (null begin-dims)
                 (member-dims-range dims begin-dims end-dims))
         (incf sym-i) ;;moved here
         ;;(member-dims-range '(2 3 3) '(i 2 2) '(i 2 2)) = nil
         ;;(member-dims-range '(2 3 3 to 1 1 3) '(I 3 3 to I 1 3) '(I 3 3 to I 1 3)) =T
    
         ;;INCLUDE LABEL OR ABBREV IN POINT?
         (cond
          ((null add-label-p) NIL)
          (use-label-abbrev-p
           (setf label-abbrev 
                 (abbreviate-sym-str sym *graph-sym-abrv-begin-n *graph-sym-abrv-end-n)))
          (t (setf  label-abbrev sym)))
      
         ;;SET THE PIXELS FOR GRAPH
         (setf x-pix (+ x-pix incr-x-pix)
               point (list sym-i (list x-pix value) label-abbrev dims))

         ;;MAKE FLAT POINTS LIST
         (setf flat-points-list (append flat-points-list (list point)))

         ;;(afout 'out (format nil "2 topsym-points-sym= ~A~%" topsym-points-sym))
         ;;when want to add point to cell/sym symvals
         #|old (when append-symvals-p
         (multiple-value-setq (new-symvals-list new-values old-values 
                                                sym-count value-count )
             (set-class-symval class-sym dims  :append-value-p t)))|#

         ;;end when in range
         )
       ;;end inner let*,loop
       ))
    flat-points-list
    ;;end let, make-graph-points-sublist
    ))
;;TEST
;;(make-graph-points-sublist  '(WUP1-3-2TO5-1-3 WUP2-3-2TO5-1-3 WUP3-3-2TO5-1-3 WUP4-3-2TO5-1-3 WUP5-3-2TO5-1-3 WUP6-3-2TO5-1-3 WUP7-3-2TO5-1-3 WUP8-3-2TO5-1-3 WUP9-3-2TO5-1-3))
;;works= ((1 (40 0.425) "Wup1-3" (1 3 2 TO 5 1 3)) (2 (80 0.4099) "Wup1-3" (2 3 2 TO 5 1 3)) (3 (120 0.4617) "Wup1-3" (3 3 2 TO 5 1 3)) (4 (160 0.4256) "Wup1-3" (4 3 2 TO 5 1 3)) (5 (200 0.49019998) "Wup1-3" (5 3 2 TO 5 1 3)) (6 (240 0.4228) "Wup1-3" (6 3 2 TO 5 1 3)) (7 (280 0.419) "Wup1-3" (7 3 2 TO 5 1 3)) (8 (320 0.4063) "Wup1-3" (8 3 2 TO 5 1 3)) (9 (360 0.40240002) "Wup1-3" (9 3 2 TO 5 1 3)))




;;SORT-ART-SYMS-BY-N
;;
;;ddd
(defun sort-art-syms-by-n (root &key n-lists n-items-per-list return-nth-list)
  "In U-ART.  RETURNS (values resorted-symvals-list n-nested-lists nth-list). Any degree of nesting ok. Sorts EITHER BY n-lists OR n-items-per-list. If both specified, sorts by n-lists with n-items-per-list and puts rest items in rest-list. If left over items in any sorting, puts items in rest-list. If return-nth-list, returns it at values end."
  (let*
      ((symval-list (eval root))
       (root-str (car symval-list))
       (symlist (second symval-list))
       (rest-list (cddr symval-list))
       (sorted-symlist)
       (sorted-symval-list)
       (nth-list)
       (num-lists)
       (return-list)
       )
    (multiple-value-setq (sorted-symlist num-lists)
        (resort-nested-lists-by-n symlist :n-lists  n-lists :n-items-per-list n-items-per-list))

    (setf sorted-symval-list (append (list root-str sorted-symlist) rest-list))

   (when return-nth-list
      (setf return-list (elt sorted-symlist return-nth-list)))

    (values sorted-symval-list num-lists return-list)
    ;;end let, sort-art-syms-by-n
    ))
;;TEST;; (sort-art-syms-by-n 'x :n-lists 3 :return-nth-list 2)
;; WORKS= ("X" ((X1-1-1 X1-1-2 X1-1-3 X1-2-1 X1-2-2 X1-2-3 X1-3-1 X1-3-2 X1-3-3 X2-1-1 X2-1-2 X2-1-3 X2-2-1 X2-2-2 X2-2-3 X2-3-1 X2-3-2 X2-3-3 X3-1-1 X3-1-2 X3-1-3 X3-2-1 X3-2-2 X3-2-3 X3-3-1 X3-3-2 X3-3-3) (X4-1-1 X4-1-2 X4-1-3 X4-2-1 X4-2-2 X4-2-3 X4-3-1 X4-3-2 X4-3-3 X5-1-1 X5-1-2 X5-1-3 X5-2-1 X5-2-2 X5-2-3 X5-3-1 X5-3-2 X5-3-3 X6-1-1 X6-1-2 X6-1-3 X6-2-1 X6-2-2 X6-2-3 X6-3-1 X6-3-2 X6-3-3) (X7-1-1 X7-1-2 X7-1-3 X7-2-1 X7-2-2 X7-2-3 X7-3-1 X7-3-2 X7-3-3 X8-1-1 X8-1-2 X8-1-3 X8-2-1 X8-2-2 X8-2-3 X8-3-1 X8-3-2 X8-3-3 X9-1-1 X9-1-2 X9-1-3 X9-2-1 X9-2-2 X9-2-3 X9-3-1 X9-3-2 X9-3-3)))  4  NIL

 

;;FIND-LAST-ART-DIMS
;;
;;ddd    
(defun find-last-art-dims (sym i &optional j)
  "In U-ART, for a sym (eg xi-1-3 or wupi-3-1toi-1-3) RETURNS (values new-dims restdims1 restdims2 n-dims root new-dims1 new-dims2)all but first (or first after to) REPLACES indexes with  i and j substituted for first indexes"
  (let
      ((dims)
       (root)
       (n-dims)( n-ints) (path-var-p)( n-dims1)( n-dims2)
       (new-dims)
       (new-dims1)
       (new-dims2)
       (restdims1)
       (restdims2)
       )
    
        (multiple-value-setq (dims root)
            (find-art-dims sym))
        (multiple-value-setq (n-dims n-ints path-var-p  n-dims1 n-dims2) ;; n-ints1 n-ints2)
            (find-dims-info dims))

        ;;FOR NODES
       (cond
        ((null path-var-p)
          (setf restdims1 (cdr dims)
                new-dims (append (list i) restdims1))
          ;;end nodes
          )
        ;;FOR PATHS
        (t
         (cond
          ((= n-dims1 3)
           (setf restdims1 (list (second dims)(third dims))
                 restdims2 (nthcdr 5 dims)))
          ((= n-dims1 4)
           (setf restdims1 (list (second dims)(third dims)(fourth dims))
                 restdims2 (nthcdr 6 dims))))

         (setf new-dims1 (append (list i) restdims1)
               new-dims2 (append (list j) restdims2)
               new-dims (append new-dims1 (list 'to)  new-dims2))
          ;;end paths
          ))

       (values new-dims restdims1 restdims2 n-dims root new-dims1 new-dims2)
        ;;end let, find-last-art-dims
        ))
;;TEST
;; (find-last-art-dims 'xi-2-3 'x  'y) = (X 2 3)  (2 3)  NIL 3 "X"
;; (find-last-art-dims 'wupi-3-1toi-1-3 'x 'y) = (X 3 1 TO Y 1 3)  (3 1)  (1 3)  6  "Wup"  (X 3 1)  (Y 1 3)
;; (find-last-art-dims 'WUPI-3-2-5TOI-1-3-5  'i  'j) 
;; works= (I 3 2 5 TO J 1 3 5)  (3 2 5) (1 3 5) 7 "Wup" (I 3 2 5) (J 1 3 5)
;; (find-last-art-dims 'WUPI-3-2TOI-1-3  'i  'j)
;; works= (I 3 2 TO J 1 3)  (3 2)  (1 3)  5  "Wup" (I 3 2) (J 1 3)




;;TEST-XY-NODE-RESET
;;
;;ddd
(defun test-xy-node-reset (sym &optional dims
                               &key (reset-val *def-reset-xy-val)
                               t-return-get-val-p
                                (t-return-val *def-reset-xy-val) (nil-return-val 0))
  "Tests the value of a node. If it equals reset-val, then it returns t-return-val if the test is T and nil-return-val if it is NIL."
  (let
      ((val)
       (return-val)
       )
    (setf val (getsymval sym dims))
    (cond
     ((or (null val)
          (and (numberp val)
               (not (= val reset-val))))
      (cond
         (t-return-get-val-p
          (setf return-val val))
         (t (setf return-val nil-return-val))))      
     (t (setf return-val t-return-val)))
    ;;test-xy-node-reset
    ))
;;TEST
;;  (test-xy-node-reset 'X1-2-2) = 0
;;  (setsymval 'x1-2-2 nil 999)
;;  (test-xy-node-reset 'X1-2-2) = 999
;;  (test-xy-node-reset 'X4-2-2 nil :t-return-get-val-p T)



;;INITIALIZE-XY-RESETS
;;
;;ddd
(defun initialize-xy-resets (&key (init-x *art-initial-x)(init-y *art-initial-y)
                                  (def-reset-val *def-reset-xy-val)
                                  (x-syms '(xi-1-3  xi-2-3 xi-3-3))(y-syms '(yi-1-3 yi-2-3 yi-3-3)))
  "Initializes x and y values that were reset to their original initial values. RETURNS list of reset-syms"
  (let
      ((init-val)
       (bot-symvals)
       (lnum 0)
       (reset-syms)
       (xy-syms (list x-syms y-syms))
       )
    (loop
     for syms  in xy-syms
     do
     (incf lnum)
     (loop
      for sym in syms
      do
     (setf bot-symvals (get-art-bottomsym-values sym))

     (loop
      for symval in bot-symvals
      do      
      (multiple-value-bind (sym val)
          (values-list symval)
        (cond
         ((and (numberp val)(= val def-reset-val))
          (setf reset-syms (append reset-syms (list sym)))
          (cond
           ((= lnum 1)
            (setsymval sym nil init-x))
           (t (setsymval sym nil init-y))))
         (t nil))                    

        ;;end mvb,loop, loop, loop
        ))))
    reset-syms
       ;;end let, initialize-xy-resets
       ))
;;TEST
;;  (initialize-xy-resets)
;;  (setsymval 'x4-1-3 nil 999)
;;  (initialize-xy-resets) = (X4-1-3)
;;  (get-art-bottomsym-values 'xi-1-3) = ((X1-1-3 0.01) (X2-1-3 0.01) (X3-1-3 1.7915592) (X4-1-3 0.01) (X5-1-3 0.01))(0.01 0.01 1.7915592 0.01 0.01)      
                                  