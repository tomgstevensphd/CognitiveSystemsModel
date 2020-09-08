;;************************ U-CS.lisp ***************************
;;
;;MODIFIED TO WORK WITH BOTH SHAQ AND CSQ
;;
;; WILL NEED TO MODIFY THESE IF ADD NEW QUEST NAMES OR MAKE
;;    OTHER CHANGES IN *SHAQ-question-variable-lists
;;INCLUDES ALL FUNCTIONS FROM FORMER U-CS-data-functions.lisp 
;;
;;  UTILITIES ADDED TO ART UTILITIES 
;;  FOR DEFINING CS-NODES AND PATHS
;;  ETC
  

;;STACK SIZE & NUM STACKS
;;Must extend stack size to make large numbers of elmsyms & combos
;;(setf *default-stack-group-list-length* 15 ) ;;default is 10, num of stacks
;; (extend-current-stack 100 ) ;; ;;100% extension to stack size, ; HAVE TO EXTEND FOR EACH STACK??
;;*sg-default-size*

(setf *stack-overflow-behaviour* :error) ;;default is :error
#| Var i ab l e *STACK-OVERFLOW-BEHAVIOUR*
Summary Controls behavior when stack overflow is detected.
Initial value :ERROR
Description The variable *stack-overflow-behaviour* controls behavior
when stack overflow is detected. When *stack-overflow-behaviour* is set to :error, LispWorks signals an error. 
When it is set to :WARN, LispWorks increases the stack size automatically to accommodate the overflow, but prints a warning message to signal that this has happened. MAY CAUSE LW TO CRASH--ME??
When it is set to NIL, LispWorks increases stack size silently. Notes Stack overflow is only detected when code was compiled with optimize qualities safety >= 1 or interruptible > 0|# 

(defparameter *cur-stack-size (current-stack-length))   ;;default = 31744


;;
;;MODIFIED TO WORK WITH BOTH SHAQ AND CSQ
;;
;; WILL NEED TO MODIFY THESE IF ADD NEW QUEST NAMES OR MAKE
;;    OTHER CHANGES IN *SHAQ-question-variable-lists


;;MY-MAKE-CS-SYMBOL
;;2019
;;ddd
(defun my-make-cs-symbol (object &key prestr poststr 
                                 make-base-sym-p
                                 (delete-chars (quote (#\: #\\ #\/ #\; #\" #\, #\Tab #\Newline #\, 
                                                       #\; #\: #\\ #\? #\[ #\] #\#  #\> #\| #\( #\})))
                                 (string-not-equal (quote ("" "."))) 
                                 (special-begins '("$" "<"))
                                 (alt-new-symbol (quote *sym-not-found)) 
                                 (replace-space-char #\-) (separator "."))
  "U-CS, RETURNS: (values csym string basic-str)  INPUT: STRING OR LIST uses MY-MAKE-CS-SYMBOL except OMITS deleting periods, which are used for separators in csartsyms.  BASIC-STR is string w/o pre or post.
  NOTE: Allows $ and < for CS symbols. SPECIAL-BEGINS: Will NOT modify syms w/ special-begins. Cks to see if prestr or poststr are ALREADY on sym."
  (let*
      ((string (cond ((stringp object) object)
                     ((symbolp object) (format nil "~A" object))
                     ((listp object) (convert-list-items-to-string object  :separator separator))))
       (str-n0 (subseq string 0 1))
       (len-pre (length prestr))
       (len-post (length poststr))
       (len-str (when poststr (length string)))
       (str-begin (subseq string 0 len-pre))
       (str-end (when poststr (subseq string (- len-str len-post))))
       (csym)
       (basic-str)
       (csym-base)
       )
    ;;Get right begining
    (cond
     ((member str-n0 special-begins :test 'my-equal)
      (setf basic-str (subseq string 1))
      )
     (T
      (when (equal str-n0 ".")
        (setf string (subseq string 1)))
      (unless (or (null prestr) (my-equal str-begin prestr))
        (setf string (format nil "~A~A" prestr string)))
      (setf basic-str (subseq string len-pre))))
    ;;Get right end
    (when poststr
      (unless (my-equal str-end poststr)
      (setf string (format nil "~A~A" string poststr)))
      (setf basic-str (subseq basic-str 0 (- (length string) len-pre len-post))))

    (setf csym (my-make-symbol string  :delete-chars delete-chars :string-not-equal string-not-equal  :alt-new-symbol alt-new-symbol :replace-space-char replace-space-char))
    (when make-base-sym-p
      (setf csym-base (my-make-symbol basic-str)))
    (values csym string basic-str csym-base)
    ;;end my-make-cs-symbol
    ))
;;TEST
;; (my-make-cs-symbol 'testsym :prestr "<" :poststr ">" :DELETE-CHARS NIL :make-base-sym-p T)
;; works = <TESTSYM>  "<TESTSYM>" "TESTSYM" TESTSYM
;; (my-make-cs-symbol 'testsym :prestr nil  :poststr ">" :DELETE-CHARS NIL)
;; works= TESTSYM>  "TESTSYM>"  "TESTSYM" NIL
;; (my-make-cs-symbol 'testsym :prestr "<" :poststr nil :DELETE-CHARS NIL)
;; works= <TESTSYM  "<TESTSYM"  "TESTSYM" NIL
;; ;; (my-make-cs-symbol '<testsym :prestr "<" :poststr ">" :DELETE-CHARS NIL :make-base-sym-p T)

;; (my-make-cs-symbol "INPUT.I.L.1")
;; works= INPUT.I.L.1  "INPUT.I.L.1"  "INPUT.I.L.1"

;; (my-make-cs-symbol "THIS.A.B.22.C.X") = THIS.A.B.22.C.X "THIS.A.B.22.C.X" "THIS.A.B.22.C.X"
;; (my-make-cs-symbol  '(aa bb cc)) = AA.BB.CC
;; FIX $sym and <scale problems
;; (my-make-cs-symbol  '$sym :prestr "<")
;; works= $SYM   "$SYM"
;; (my-make-cs-symbol  '<scale :prestr "<")
;; works= <SCALE   "<SCALE"
;; (my-make-cs-symbol  'scale :prestr "<")
;; works = <SCALE   "<SCALE"
;;;; (my-make-cs-symbol ".INPUT.I.L.1")  =  INPUT.I.L.1  "INPUT.I.L.1"




;;GET-CATEGORY-QVARS
;;
;;ddd
(defun get-category-qvars (category &key (all-category-lists  (eval *ALL-CSQ-QVARS)))
  ;;was *shaq-question-variable-lists
  "In U-CS (inSHAQ U-data-functions), RETURNS (values category-qvarlist = a list of all the qvarlists for qvar category AND category)."
  (let 
      ((category-list)
       (category-qvarlist)
       )
    (multiple-value-setq (category-list return-qvar)
        (get-key-value-in-nested-lists (list (list category 0))
                                       all-category-lists :return-list-p t
                                       :no-return-extra-p t))
    (setf category-qvarlist (cdr category-list))   
    (values category-qvarlist category)
    ;;end let, get-category-qvars
    ))
;;TEST
;;  (get-category-qvars 'bio4job) = works
;;   (get-category-qvars 'stu-data) = works
#|(("stpared" "b-Highest parents educ level" "spss-match" ("stuParentsEduc" 1 STUPARENTSEDUCQ "int" STUPARENTSEDUC "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "StudentBasicData.java")) ("stuclass" "st-Class level" "spss-match" ("stuClassLevel" "3" STUCLASSLEVELQ "int" STUCLASSLEVEL "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "StudentBasicData.java")) ("studegre" "st-Educ objective level"... ETC. SOME DELETED|#
;;FOR CSQ
;; (get-category-qvars 'pce-people)
;; works= ((PCE-PEOPLE ("mother" "mother" "single-text" ("mother" "1" "motherQ" "pc-element" "Pc-Element")) ("father" "father" "single-text" ("father" "2" "fatherQ" "pc-element" "Pc-Element")) ("best-m-friend" "best-m-friend" "single-text" ("best-m-friend" "3" "best-m-friendQ" "pc-element" "pc-Element" GETNAME-P)) ("best-f-friend" "best-f-friend" "single-text" ("best-f-friend" "4" "best-f-friendQ" "pc-element" "pc-Element" GETNAME-P)) ("m-dislike" "m-dislike" "single-text" ("m-dislike" "5" "m-dislikeQ" "pc-element" "pc-Element" GETNAME-P))  etc.



;;GET-CATEGORY-QVAR-NAMES
;;
;;ddd
(defun get-category-qvar-names (category &key (all-category-lists  
                                               *cur-qvarlists) (return-syms-p T))
  ;;was *shaq-question-variable-lists
  "In U-CS (in SHAQ U-data-functions),  RETURNS (values category-qvar-names category-syms category) where  category-qvar-names = a list of all the qvar names for qvar category."
  (let 
      ((category-qvarlists)
       (category-qvar-names)
       (sym)
       (category-syms)
       )
    (multiple-value-setq (category-qvarlists)  
        (get-category-qvars category))
    (setf  category-qvar-names (get-nth-in-all-lists 0 category-qvarlists))

    (when return-syms-p
      (loop
       for name in category-qvar-names
       do
       (setf  sym (my-make-cs-symbol name  :delete-chars nil)
              category-syms (append category-syms (list sym)))))
 
    (values category-qvar-names category-syms category)
    ;;end let, get-category-qvar-names
    ))
;;TEST
;;  (get-category-qvar-names 'pce-people)  
;;  works= ("mother" "father" "best-m-friend" "best-f-friend" "m-dislike" "f-dislike" "m-admire" "f-admire" "per-mostfun" "per-romance" "role-model" "child-friend" "child-dislike" "work-friend" "work-per-dislike" "fav-boss" "worst-boss" "fav-m-star" "fav-politico" "fav-teacher" "fav-spiritual" "dis-teacher")   (MOTHER FATHER BEST-M-FRIEND BEST-F-FRIEND M-DISLIKE F-DISLIKE M-ADMIRE F-ADMIRE PER-MOSTFUN PER-ROMANCE ROLE-MODEL CHILD-FRIEND CHILD-DISLIKE WORK-FRIEND WORK-PER-DISLIKE FAV-BOSS WORST-BOSS FAV-M-STAR FAV-POLITICO FAV-TEACHER FAV-SPIRITUAL DIS-TEACHER)   PCE-PEOPLE




;;GET-ALL-SHAQ-QVAR-CATEGORIES
;;
;;ddd
(defun get-all-shaq-qvar-categories (&key (all-category-lists *ALL-CSQ-QVARS))
      "In U-CS (inSHAQ U-data-functions), RETURNS all-categories-list."
      (let
          ((all-categories-list)
           )
        (loop
         for cat-list in all-category-lists
         with cat-sym
         do
         (setf cat-sym (car cat-list)
               all-categories-list (append all-categories-list (list cat-sym)))
         ;;end loop
         )
        all-categories-list
        ;;end get-all-shaq-qvar-categories
        ))
;;TEST
;;  (get-all-shaq-qvar-categories) = 
;;works, returns (ID UTYPE UGOALS BIO3EDUC BIO4JOB BI07LANG BIO1ETHN BIORELAF STUCOLLE STUMAJOR STUSPECI STURESID STU-DATA STGPATRE STUAPT STUFEEL STURESOURCE STUACMOTIV STU-LRN SM COPE THEMES TBV IE WORLDVIEW SELF-CONF ASSERTCR INTIMACY INDEP-INT ROM LIBROLE HAP RHEALTH RPEOPLE RDEP RANX RANG REMOT TB2 CARGEN CARBUS CARENGR CARFINE CARHELP CARLANG CARMED CARLAW CARNATSCI CARBESCI CARETHNIC CARWRITE)



;;GET-CSYM-QVAR
;;2020
;;ddd
(defun get-csym-qvar (csym  &key )
  "U-CS   RETURNS (values qvar-sym  qvar-str csym-str )
   INPUT: string or symbol."
  (let*
      ((csym-str (cond ((stringp csym) csym)
                       (T (format nil "~A" csym))))
       (qvar-str (subseq csym-str 1))
       (qvar-sym (my-make-cs-symbol qvar-str))
       )
    (values qvar-sym  qvar-str csym-str )
    ;;end let, get-csym-qvar
    ))
;;TEST
;; (get-csym-qvar "<testcsym") = TESTCSYM  "testcsym"  "<testcsym"
;; (get-csym-qvar '<testcsymX)  = TESTCSYMX "TESTCSYMX" "<TESTCSYMX"




;;GET-QVARLIST
;;
;;ddd
(defun get-qvarlist (qvar &key  (category T) not-nested-p
                           (all-qvarlists  *ALL-CSQ-QVARS))
  "In U-CS (inSHAQ U-data-functions). RETURNS  (values qvarlist return-qvar). Used to create *shaq-all-question-categories-list, a global shaq variable."
  (let
      ((qvarlist)
       (return-qvar)
       (qvar-str)
       )
    (cond
     ((stringp qvar)
      (setf qvar-str qvar))
     (t (setf qvar-str (format nil "~A" qvar))))
     
    (cond
     ((null not-nested-p)
      (multiple-value-setq (qvarlist return-qvar)
          (get-key-value-in-nested-lists (list (list category 0)(list qvar-str 0)) all-qvarlists :return-list-p t  :no-return-extra-p t)))
     (t (multiple-value-setq (qvarlist return-qvar)
            (get-key-value-in-nested-lists  `((,qvar-str 0)) all-qvarlists :return-list-p t  :no-return-extra-p t))))
    ;;end get-qvarlist
    (values qvarlist return-qvar)
    ))
;;TEST
;;for links
;; (get-qvarlist 'emot)
;;for pcsyms
;; (get-qvarlist 'q :not-nested-p t :all-qvarlists *all-pcqvars) = ("Q" "q vs nq" NIL "Q" ("Q" "1" "quest-name" "int" "Priority12" NIL NIL NIL NIL))    "Q"
;;  (get-qvarlist 'mother) = ("mother" "mother" "single-text" ("mother" "1" "motherQ" "pc-element" "Pc-Element"))
;; (get-qvarlist 'green)
;;  (get-qvarlist "lrntxout" *ALL-CSQ-QVARS)
;;   (get-qvarlist "lrntxout" *SHAQ-question-variable-lists 'STU-LRN)
;; both work, return ("lrntxout" "la-Outline textbooks" "spss-match" "lrnTEXToutline" ("lrnTEXToutline" "2" "lrnTEXToutlineQ" "int" "FrAnswerPanel.LikeMe7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "bsLearningAreas.java"))
;;FOR MULTI-SELECTION ITEMS
;;  (get-qvarlist "BIO4JOB") = ("bio4job" "b-Primary occupation" "spss-match" ("bio4job") ("INSTRUCTIONS: Select ALL of the following best describe your primary OCCUPATION." "If you have multiple occupations, choose all of them.") NIL :MULTI-ITEM)
;; (get-key-value-in-nested-lists '(( "BIO4JOB" 0))  *SHAQ-question-variable-lists :return-list-p T) works, returns entire list of lists under BIO4JOB CATEGORY
;; (get-qvarlist 'k :not-nested-p T)
;;2019
;; (get-qvarlist 'emot :not-nested-p nil)
;; (get-key-value-in-nested-lists (list (list 'emot 0 T)) *ALL-CSQ-QVARS :return-list-p t  :no-return-extra-p t)
;;
;; (get-qvarlist 'isa :all-qvarlists *ALL-CS-EXPLORE-QVARS)



;;GET-QVAR-QUEST-INFO
;; DO NOT USE/FINISH THIS FUNCTION? USE GET-QUESTION-INFO INSTEAD?
;;2020
;;ddd
#|(defun get-qvar-quest-info (qvar  &key (all-qvar-quest-lists *ALL-CSQ-QUESTIONS)
                                  (all-qvars-lists  *ALL-CSQ-QVARS)
                                  (default-multi-ans-instr-text "Select ALL that apply to you")
                                  (return-text-version-p T))
  "U-CS USE GET-QUESTION-INFO INSTEAD??
  RETURNS (values  qvar  selection-type multi-item-p q-num 
       q-frame-inst linktype1 linktype2 test-result qvarlist compare-3
       deflist-selection-type num-answers answer-array scored-reverse-p
       frame-name-text instrs ans-instruction-text title-text-formated
       instruction-text   instr-text-formated  q-text-sym question-text-list
       question-text-formated answer-array-list ans-data-list 
                 INFO-TEXT-VERSION) Uses make-question-frame to get the info."
  (let*
      ((info-text-version "")
       ;;main vars & lists
       (origqvar qvar)
       (qvar-str (cond ((stringp qvar)
                        (setf qvar (my-make-symbol qvar)) origqvar)
                       (t (setf qvar-str (format nil "~A" qvar)))))
       (qvarlist (get-keyvalue-in-nested-list (list (list qvar-str T)) all-qvars-lists
                                               :return-value&keylist-p T))
       ;;works with strings or syms
       ;;(get-keyvalue-in-nested-list (list (list 'lrntense T)) *ALL-CSQ-QVARS :return-value&keylist-p t)
       (multi-item-p)
       (selection-type) 
       (cat-qvarlist (when multi-item-p qvarlist))
       ;;(get-keyvalue-in-nested-list (list (list 'emot T)) *ALL-CSQ-QVARS)
       (cat-info-list (when multi-item-p (second cat-qvarlist)))
       (frame-name-text) 
       ;;(spss-match ) (java-var) 
       (q-phra)
       (q-num)  ;;not needed (old-q-name ) (data-type) 
       ;;not needed (array) (frame-title) ( fr-width) (fr-height) (java-file)
       (q-text-sym)
       ;;(qvar-name-list)
       (fr-answer-panel-sym)
       (fr-answer-panel-deflist)
       (instrs)
       (deflist-selection-type) 
       (num-answers) 
       (answer-array) ;;(values)
       (linktype1)
       (linktype2)
       ;;now an arg above (selection-type) 
       (data-type)  
       ;;reversed item or scoring?
       (reversed-item-p) 
       (item-norm-or-rev)
       (scored-reverse-p) 
       (nor-or-rev-scored)
       (pre-selected-num)
       (ans-instruction-text)
       (answer-array-list)
       ;;  (ans-instr-text)
       (q-frame-inst)
       ;;answer-button-layout -SPECIFIES SLOT NAME later in this function
       (scale-instr-text)
       (title-text) ;;for top-center title area
       (title-text-formated)
       (instruction-text) 
       (instr-text-formated)
       (question-text-list)
       (question-text-formated)
       (single-sel-test-list     (list 'single :single-selection "single""SINGLE" :single-input-frame "single-input-frame"))
       (multi-sel-test-list
        (list 'multiple 'multi "multiple" "MULTIPLE" :multiple-selection :multi-special-frame))
       (single-input-test-list  (list  "single-input"  'single-input :single-input ))
       (multi-input-test-list (list  "multi-text"  :multi-text  'multi-text))
       ;;added bec warning       
       (ans-text-list)
       (ans-data-list)     
       ;;for single-text selection type
       (text-input-box-instrs)
       (text-input-box1-instrs "Type answer below:")
       (text-input-box2-instrs "")
       ;;added for mbs--not all needed?
       (spss-match)(  java-var)(  q-num)
       (q-text-sym (my-make-symbol (format nil "~A"qvar-str)))
       (  data-type)
       ;;not needed    (ans-xdata-list)
       (all-args)
       (multi-item-p)
       (X)
       )
    ;;FIND SELECTION-TYPE RELATED INFO
    (multiple-value-setq (selection-type test-result X multi-item-p)
        (find-qvar-selection-type qvar  :qvarlist qvarlist
                            :data-list all-qvars-lists :return-qvarlist-p NIL
                             :non-nested-datalist-p    non-nested-datalist-p
                             :inkey linktype-key))

    ;;FIND QUESTION TEXT ;;match below syms w/ above
    (multiple-value-setq (q-text-sym q-text-out q-title q-instr-out text-input-box-text)
        (get-question-text  qvar))
   ;;(get-question-text  'isaq)

    ;;FIND INFO BY MULTI-ITEM-P OR NOT SSSS START HERE-FOR EACH VAR VALUE
       (cond
        ((equal selection-type :SINGLE-SELECTION)
         (setf q-phrase (second qvarlist)
               q-sublist (fifth qvarlist)
               q-num (second q-sublist)
               fr-answer-panel-sym (my-make-symbol (fifth q-sublist)))
         (cond
          ((boundp fr-answer-panel-sym)
           (setf  fr-answer-panel-deflist (eval fr-answer-panel-sym))
           ;;SSS FIND EXISTING FUNCTIONS TO GET SUB VALUES???
           (cond 
            ((boundp (car fr-answer-panel-deflist))


#|       (instrs (eval (car fr-answer-panel-deflist))
       (deflist-selection-type) 
       (num-answers) 
       (answer-array) ;;(values)|#
               )
            (T  ))
           ;;end boundp fr-ans
           )
          (T ))

         ;;end single-selection
         )
        ((equal selection-type :SINGLE-TEXT)


         )
        ((equal selection-type :MULTIPLE-SELECTION)

         )
        ((equal selection-type :MULTI-TEXT)

         )
        ((equal selection-type  :MULTI-SPECIAL-FRAME)


         )
        (T NIL))
                          
#|(qvar qvar-string selection-type multi-item-p frame-name-text 
              q-num  instrs   ans-instruction-text
              title-text-formated
              instruction-text 
              instr-text-formated
              q-text-sym question-text-list 
              question-text-formated
              answer-array-list ans-values-list q-frame-inst 
              linktype1 linktype2
              deflist-selection-type num-answers answer-array values
              data-type  reversed-item-p 
              test-result qvarlist compare-3
              item-norm-or-rev scored-reverse-p pre-selected-num )|#

;;(q-text-name (format nil "~AQ" qvar))
       ;;(q-text-sym (my-make-cs-symbol q-text-name))

        (when return-text-version-p
          (setf info-text-version
                (format nil "~%=> QVAR QUESTION INFO for QVAR= ~S 
 qvar-string= ~S
 selection-type= ~S multi-item-p= ~S q-num= ~S
 q-frame-inst= ~S  linktype1= ~S   linktype2= ~S
 test-result= ~S  
 qvarlist= ~S
 compare-3= ~S deflist-selection-type= ~S  num-answers= ~S
 answer-array= ~S  scored-reverse-p= ~S
 TEXT ----------------------------
 frame-name-text= ~S 
 instrs= ~S
 ans-instruction-text= ~S 
 title-text-formated= ~S
 instruction-text= ~S
 instr-text-formated= ~S
 q-text-sym= ~S
 question-text-list= ~S
 question-text-formated= ~S
 answer-array-list= ~S~%  ans-data-list= ~S 
          " qvar qvar-string selection-type multi-item-p q-num 
       q-frame-inst linktype1 linktype2 test-result qvarlist compare-3
       deflist-selection-type num-answers answer-array scored-reverse-p
       frame-name-text instrs ans-instruction-text title-text-formated
       instruction-text   instr-text-formated  q-text-sym question-text-list
       question-text-formated answer-array-list ans-data-list  )))

        (values  qvar qvar-string selection-type multi-item-p q-num 
       q-frame-inst linktype1 linktype2 test-result qvarlist compare-3
       deflist-selection-type num-answers answer-array scored-reverse-p
       frame-name-text instrs ans-instruction-text title-text-formated
       instruction-text   instr-text-formated  q-text-sym question-text-list
       question-text-formated answer-array-list ans-data-list 
                 info-text-version)
  ;;end let,get-qvar-quest-info
    ))|#
#|OLD
(defun get-qvar-quest-info (qvar  &key (all-qvarlists *ALL-CSQ-QUESTIONS)
                                  (default-multi-ans-instr-text "Select ALL that apply to you")
                                  (return-text-version-p T))
  "U-CS   RETURNS (values  qvar  selection-type multi-item-p q-num 
       q-frame-inst linktype test-result qvarlist compare-3
       deflist-selection-type num-answers answer-array scored-reverse-p
       frame-name-text instrs ans-instruction-text title-text-formated
       instruction-text   instr-text-formated  q-text-sym question-text-list
       question-text-formated answer-array-list ans-values-list 
                 INFO-TEXT-VERSION) Uses make-question-frame to get the info."
  (let*
      ((info-text-version "")
       )
    (multiple-value-bind (qvar qvar-string selection-type multi-item-p frame-name-text 
              q-num  instrs   ans-instruction-text
              title-text-formated
              instruction-text 
              instr-text-formated
              q-text-sym question-text-list 
              question-text-formated
              answer-array-list ans-values-list q-frame-inst 
              linktype
              deflist-selection-type num-answers answer-array values
              data-type  reversed-item-p 
              test-result qvarlist compare-3
              item-norm-or-rev scored-reverse-p pre-selected-num )

        (make-question-frame qvar nil  :all-qvarlists  all-qvarlists
                             :return-only-quest-info-p T :quest-num 1
                             :csq-frame-pane1-title " Answer: "
                             :csq-frame-pane2-title " Answer: ")

;;(q-text-name (format nil "~AQ" qvar))
       ;;(q-text-sym (my-make-cs-symbol q-text-name))

        (when return-text-version-p
          (setf info-text-version
                (format nil "~%=> QVAR QUESTION INFO for QVAR= ~S 
 qvar-string= ~S
 selection-type= ~S multi-item-p= ~S q-num= ~S
 q-frame-inst= ~S  linktype= ~S
 test-result= ~S  
 qvarlist= ~S
 compare-3= ~S deflist-selection-type= ~S  num-answers= ~S
 answer-array= ~S  scored-reverse-p= ~S
 TEXT ----------------------------
 frame-name-text= ~S 
 instrs= ~S
 ans-instruction-text= ~S 
 title-text-formated= ~S
 instruction-text= ~S
 instr-text-formated= ~S
 q-text-sym= ~S
 question-text-list= ~S
 question-text-formated= ~S
 answer-array-list= ~S~%  ans-values-list= ~S 
          " qvar qvar-string selection-type multi-item-p q-num 
       q-frame-inst linktype test-result qvarlist compare-3
       deflist-selection-type num-answers answer-array scored-reverse-p
       frame-name-text instrs ans-instruction-text title-text-formated
       instruction-text   instr-text-formated  q-text-sym question-text-list
       question-text-formated answer-array-list ans-values-list  )))

        (values  qvar qvar-string selection-type multi-item-p q-num 
       q-frame-inst linktype test-result qvarlist compare-3
       deflist-selection-type num-answers answer-array scored-reverse-p
       frame-name-text instrs ans-instruction-text title-text-formated
       instruction-text   instr-text-formated  q-text-sym question-text-list
       question-text-formated answer-array-list ans-values-list 
                 info-text-version)
  ;;end mvb,let,get-qvar-quest-info
    )))|#
;;TEST
;;SSS FINISH TESTING get-qvar-quest-info
;; (get-qvar-quest-info 'emot)
;; (get-qvar-quest-info 'ex)





;;GET-ALL-CSQ-QVARNAMES
;;
;;2016  was named get-all-shaq-qvarnames
;;ddd
(defun get-all-CSQ-qvarnames ( &key return-var&qtext-p
                                    return-var&label-p (add-quote "")
                                    (all-qvarlists *ALL-CSQ-QVARS))
                                    ;;was (eval *cur-qvarlists)))
  "In U-CS (inSHAQ U-data-functions). RETURNS (values all-qvars-list all-categories-list  problems-list). If return-var&label-p, then returns a list of qvar label strings for each. If add-quote, puts whatever add-quote is set to on both ends of the label (for spss add single quote). [was get-all-shaq-qvarnames.] If RETURN-VAR&QTEXT-P, returns lists of qvar qtext strings for all qvars."
  (let
      ((all-qvars-list)
       (all-categories-list)
       (problems-list)
       (qtext)
       (qvar)
       )
    (loop
     for catlist in all-qvarlists
     with catname = nil
     do
     (cond
      ((listp catlist)
       (setf catname (car catlist))
       (loop 
        for qvarlist in (cdr catlist)
        do
        (setf qvar nil)
        (cond
         ((null return-var&label-p)
          (cond
           ((listp qvarlist)
            (setf qvar (car qvarlist))
            (cond
             (return-var&qtext-p
              (setf qtext (nth-value 1 (get-question-text qvar)))
              (when (listp qtext)
                (setf qtext (car qtext)))
              (setf all-qvars-list (append all-qvars-list (list (list qvar qtext))))
              )
             (t (setf qvar (car qvarlist)                
                      all-qvars-list (append all-qvars-list (list qvar)))))
            ;;end listp
            )
           (t (setf problems-list (append problems-list (list qvarlist)))))
          )
         ;;if return-var&label-p
         (t
          (cond
           ((listp qvarlist)
            (setf qvar (car qvarlist)     
                  label (second qvarlist)
                  all-qvars-list (append all-qvars-list (list (list qvar label)))))
           ;;was(format nil "~A  ~A~A~A" qvar add-quote label add-quote))))))
           (t (setf problems-list (append problems-list (list qvarlist)))))))       
        ;;end inner loop, clause
        ))
      (t (setf problems-list (append problems-list (list qvarlist)))))
     ;;end outer loop
     )
    (values all-qvars-list all-categories-list  problems-list)
    ;;end let, get-all-CSQ-qvars
    ))
;;TEST
;; (get-all-CSQ-qvarnames)
;; (setf *all-CSQ-qvarnames-list (get-all-CSQ-qvarnames))
;; ;; (setf *num-qvars (list-length *all-CSQ-qvarnames-list)) = 58
;;  get-all-CSQ-qvars
;;  (setf *all-shaq-qvar&labels (get-all-CSQ-qvarnames :return-var&label-p T :add-quote "\'"))
;;  (get-all-CSQ-qvarnames :return-var&qtext-p T)


;;MY-GET-DATE-TIME --NEWER VERSION IN U-DATA-FUNCTIONS
;;
;;ddd
#|(defun my-get-date-time (&key (date-separator "."))
  "In U-CS (inSHAQ U-data-functions), RETURNS (values date-string  date time year month day hour min sec )"
  (let
      ((date-string)
       (time)
       (date)
       )
    (multiple-value-bind (sec min hour day month year)
        (decode-universal-time (get-universal-time))
    (setf time (format nil "~a:~a" hour min)
          date (format nil "~a~a~a~a~a" month date-separator day date-separator year))
    (setf date-string (format nil "Date: ~A  Time: ~A" date time))
    (values date-string  date time year month day hour min sec )
    ;;end mvb, let, my-get-date-time
    )))|#
;;TEST
;; (my-get-date-time)
;; works= "Date: 10.29.2014  Time: 11:15"  "10.29.2014"  "11:15"  2014  10  29  11  15  7
;; (format nil "~S" "




;;GET-CS-POLE-NAME
;;2019
;;ddd
(defun get-cs-pole-name (csym  &key (pole-n 1) return-other-pole-p (prestr "<"))
  "U-CS  RETURNS (pole-name pole-n) OR if return-other-pole-p, adds other-polename). Input sym or string. If pole-n = 1 or not a number, returns  pole-name = csym namestr. Use get-cs-bestpole-name for bestpole."
  (let*
      ((csym-sym (cond ((symbolp csym) csym) (t (my-make-cs-symbol csym :prestr prestr))))
       (symlist (eval csym-sym))
       (pole-name (cond 
                  ((numberp pole-n)
                   (cond
                    ((not (= pole-n 2))
                     (setf pole-name (get-key-value :pole1 symlist)))
                    (t (setf pole-name (get-key-value :pole2 symlist)))))
                  ;;pole not a number, use csym name
                    (t (setf pole-name (second symlist)))))
       (other-polename (when return-other-pole-p 
                         (cond
                          ((= pole-n 1)
                              (setf other-polename (get-key-value :pole2 symlist)))
                          (t (setf other-polename (get-key-value :pole1 symlist))))))
       )
    (cond
     ((null return-other-pole-p)
     (values pole-name pole-n ) )
     (t (values pole-name pole-n other-polename)))
    ;;end let, get-cs-pole-name
    ))
;;TEST
;; (get-cs-pole-name  'intimate)  = "INTIMATE"  1 
;; (get-cs-pole-name  'intimate :pole-n 2) = "NOT INTIMATE"  2
;; (get-cs-pole-name  'intimate :return-other-pole-p T)
;; works= "INTIMATE"  1  "NOT INTIMATE"
;; (get-cs-pole-name  'intimate :pole-n 2 :return-other-pole-p T)
;; works= "NOT INTIMATE"  2  "INTIMATE"




;;GET-CS-BESTPOLE-NAME
;;2019
;;ddd
(defun get-cs-bestpole-name (csym &key (prestr "<") )
  "U-CS  RETURNS (bestpole-name bestpole-n). Input sym or string. If bestpole-n not a number, returns  bestpole-name = csym namestr."
  (let*
      ((csym-sym (cond ((symbolp csym) csym) (t (my-make-cs-symbol csym :prestr prestr))))
       (symlist (eval csym-sym))
       (bestpole-n (get-key-value :bestpole symlist))
       (bestpole-name (cond 
                  ((numberp bestpole-n)
                   (cond
                    ((not (= bestpole-n 2))
                     (setf bestpole-name (get-key-value :pole1 symlist)))
                    (t (setf bestpole-name (get-key-value :pole2 symlist)))))
                  ;;bestpole not a number, use csym name
                    (t (setf bestpole-name (second symlist)))))
       )
    (values bestpole-name bestpole-n   )
    ;;end let, get-cs-bestpole-name
    ))
;;TEST
;;  (setf **test-pcs1 '(("CAREFOROTHERS" "CARE FOR OTHERS vs SELFISH" CS2-1-1-99 NIL NIL :PC ("CARE FOR OTHERS" "SELFISH" 1 NIL) :POLE1 "CARE FOR OTHERS" :POLE2 "SELFISH" :BESTPOLE 1 (:BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL))) :va "0.917" :RNK 3)      ("INTIMATE" "INTIMATE vs NOT INTIMATE" CS2-1-1-99 NIL NIL :PC ("INTIMATE" "NOT INTIMATE" 1 NIL) :POLE1 "INTIMATE" :POLE2 "NOT INTIMATE" :BESTPOLE 1 (:BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL BEST-M-FRIEND NIL))) :va "0.750" :RNK 7.5)   ("FLEXIBLE" "FLEXIBLE vs RIGID" CS2-1-1-99 NIL NIL :PC ("FLEXIBLE" "RIGID" 1 NIL) :POLE1 "FLEXIBLE" :POLE2 "RIGID" :BESTPOLE 1 (:BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL F-DISLIKE NIL))) :va "0.750" :RNK 7)      ("EGOTISTICAL" "EGOTISTICAL vs HUMBLE" CS2-1-1-99 NIL NIL :PC ("EGOTISTICAL" "HUMBLE" 2 NIL) :POLE1 "EGOTISTICAL" :POLE2 "HUMBLE" :BESTPOLE 2 (:BIPATH ((POLE1 NIL F-DISLIKE NIL) (POLE1 NIL CHILD-DISLIKE NIL) (POLE2 NIL MOTHER NIL))) :va "0.667" :RNK 3)))
;; (setf testsym-xx '("testsym" "test sym name"  ))
;; (get-cs-bestpole-name "INTIMATE")
;; works= "INTIMATE"  1
;; (get-cs-bestpole-name "CAREFOROTHERS") = "CARE FOR OTHERS"  1
;; (get-cs-bestpole-name  "EGOTISTICAL")
;; works= "HUMBLE"  2
;; (get-cs-bestpole-name 'testsym-xx)
;; works = "test sym name"   NIL


 
;;GET-QUEST-VAR-VALUES  --USE GET-QUESTION-INFO INSTEAD??
;;
;;ddd
#|(defun get-quest-var-values (qvar &key qvarlist  return-values-p  (category T) label spss-match java-var qnum q-name data-type answer-panel array frame-title fr-width fr-height java-file help-info help-links (all-qvarlists '*ALL-CSQ-QVARS) ;;was  *cur-qvarlists ) 
                                  qvarlist-not-nested-p)
  "In U-CS (inSHAQ U-data-functions)  qvar is the NEW-spss variable sym or string. IF return-values-p,  RETURNS (values   label  spss-match  java-var  qnum  q-name  data-type  answer-panel  array  frame-title   fr-width  fr-height  java-file help-info  help-links) =  a list of key-value pairs with keys=  label spss-match java-var qnum q-name data-type answer-panel array frame-title fr-width fr-height java-file qvar).  For a key = T, returns the first T value (values return-var-value return-var  return-keylist qvar help-info help-links). Category is the category of the qvar.  If qvarlist supplied, then uses it INSTEAD of search long list for qvar--saves time.  [If NULL return-values-p, RETURNS EG.  returns= \"acmFinancialQ\"  Q-NAME  (:LABEL \"am-Confidence school finances\" :SPSS-MATCH \"spss-match\" :JAVA-VAR \"acmFinancial\" :QNUM \"19\" :Q-NAME \"acmFinancialQ\" :DATA-TYPE \"int\" :ANSWER-PANEL \"FrAnswerPanel.Confidence7\" :ARRAY \"questionInstancesArray\" :FRAME-TITLE \"frameTitle\" :FR-WIDTH \"frameDimWidth\" :FR-HEIGHT \"frameDimHeight\" :JAVA-FILE \"iAcademicMotivation.java\")   ACMFINAN"
  (let
      ((return-var-value)  
       (sublist)
       (arg-keylist-vals (list  label spss-match java-var qnum q-name data-type answer-panel array frame-title fr-width fr-height java-file))
       (return-var)
       (key)
       (val)
       (return-qvar)
       (return-keylist)
       (help-info-links-list)
       (help-info)
       (help-links)
       (var1)
       (n2)
       )
    ;;test to see if all-qvarlists are nested
    (when (not (listp (second (car all-qvarlists))))
      (setf qvarlist-not-nested-p T))

    ;;(afout 'out (format nil "arg-keylist-vals= ~A~%" arg-keylist-vals))

    ;;see if use return-var (set to T?) before change their values below
    (loop
     for n from 0 to 11  
     do
     (setf key (nth n '(label spss-match java-var qnum q-name  data-type answer-panel array frame-title fr-width fr-height java-file))
           val (nth n arg-keylist-vals))
     (cond
      (val
       (setf  return-var key)
       (return))
      (t nil))
     ;;end loop
     )
    ;;get the list of values
    (cond
     ;;if the qvarlist is supplied, saves a search
     (qvarlist nil)
     (t (multiple-value-setq (qvarlist return-qvar)
            (get-qvarlist qvar :category category :all-qvarlists all-qvarlists
                           :not-nested-p qvarlist-not-nested-p))))
    ;;(get-qvarlist 'mild  :category T :all-qvarlists *all-pcqvars) = ("MILD" "4" "int" "Priority12" NIL NIL NIL NIL) "MILD"
    ;; For pcqvars (get-qvarlist 'q :not-nested-p t :all-qvarlists *all-pcqvars) = ("Q" "q vs nq" NIL "Q" ("Q" "1" "quest-name" "int" "Priority12" NIL NIL NIL NIL))   "Q"

    ;;set the values
    (setf  label (second qvarlist)
           spss-match (third qvarlist)
           java-var (fourth qvarlist)
           help-info-links-list (sixth qvarlist))
    (if (listp (setf sublist (fifth qvarlist)))
        (setf qnum (second sublist) 
              q-name (third sublist) 
              data-type (fourth sublist) 
              answer-panel (fifth sublist)
              array (sixth sublist)
              frame-title  (seventh sublist)
              fr-width (eighth sublist)
              fr-height  (ninth sublist)
              java-file  (tenth sublist )))

    ;;for help-info-link-list
    (when (listp help-info-links-list)
      (setf  help-info (second help-info-links-list)
             help-links (third help-info-links-list)))

    ;;make the return-keylist
    (setf return-keylist (list  :label label :spss-match spss-match :java-var java-var :qnum qnum :q-name q-name :data-type data-type :answer-panel answer-panel :array array :frame-title frame-title :fr-width  fr-width :fr-height fr-height :java-file java-file :help-info help-info :help-links help-links))
    ;;(BREAK "inside get-quest-var-values")
    ;;(afout 'out (format nil "q-name= ~A  return-var= ~A~% " q-name return-var))  
    #|  DOESN'T WORK BUT SHOULD -- (eval return-var) = unbound var
   ;;get the return-var-value  set above
    (if return-var
        (setf return-var-value (eval return-var)))|#
    ;;SSS TEMP SOLUTION
    (loop
     for n from 0 to 12  
     do
     (setf n2 (+ (* n 2) 1)
           var1 (nth n '(label spss-match java-var qnum q-name  data-type answer-panel array frame-title fr-width fr-height java-file help-info-link-list)))
     (cond
      ((equal key var1)
       (setf return-var-value (nth n2 return-keylist)
             return-var key)
       (return))
      (t nil))                 
     ;;end loop
     )

    ;;what to return?
    (cond
     (return-values-p 
      (values   label  spss-match  java-var  qnum  q-name  data-type  answer-panel  array  frame-title   fr-width  fr-height  java-file help-info  help-links))
     ( return-var 
       (values return-var-value   return-var  return-keylist qvar))
     (t (values return-keylist qvar)))
    ;;(BREAK "In get-quest-var-values")

    ;;end let, get-quest-var-values
    ))|#
;;TEST 
;; (get-quest-var-values 'EX :qvarlist qvarlist :return-values-p t :all-qvarlists all-qvarlists ))
;; (get-quest-var-values 'MILD :return-values-p T  :all-qvarlists *all-pcqvars )
;;  :not-nested-p T)
;; (get-quest-var-values 'hot)  
;; (get-quest-var-values 'acmfinan) 
;;modified version incl help
#|"iAcademicMotivation.java"
JAVA-FILE
(:LABEL "am-Confidence school finances" :SPSS-MATCH "spss-match" :JAVA-VAR "acmFinancial" :QNUM "19" :Q-NAME "acmFinancialQ" :DATA-TYPE "int" :ANSWER-PANEL "Confidence7" :ARRAY "questionInstancesArray" :FRAME-TITLE "frameTitle" :FR-WIDTH "frameDimWidth" :FR-HEIGHT "frameDimHeight" :JAVA-FILE "iAcademicMotivation.java" :HELP-INFO NA :HELP-LINKS NA)
ACMFINAN|#

   ;; label spss-match java-var qnum q-name data-type answer-panel array frame-title fr-width fr-height java-file)
;;works, returns= (:LABEL "am-Confidence school finances" :SPSS-MATCH "spss-match" :JAVA-VAR "acmFinancial" :QNUM "19" :Q-NAME "acmFinancialQ" :DATA-TYPE "int" :ANSWER-PANEL "FrAnswerPanel.Confidence7" :ARRAY "questionInstancesArray" :FRAME-TITLE "frameTitle" :FR-WIDTH "frameDimWidth" :FR-HEIGHT "frameDimHeight" :JAVA-FILE "iAcademicMotivation.java")       ACMFINAN
;;   (get-quest-var-values 'acmfinan :q-name t) 
;; works, returns= "acmFinancialQ"  Q-NAME  (:LABEL "am-Confidence school finances" :SPSS-MATCH "spss-match" :JAVA-VAR "acmFinancial" :QNUM "19" :Q-NAME "acmFinancialQ" :DATA-TYPE "int" :ANSWER-PANEL "FrAnswerPanel.Confidence7" :ARRAY "questionInstancesArray" :FRAME-TITLE "frameTitle" :FR-WIDTH "frameDimWidth" :FR-HEIGHT "frameDimHeight" :JAVA-FILE "iAcademicMotivation.java")   ACMFINAN
;;(setf  xx 1 yy 2 zz 3)
;; (sort (list zz xx yy) '<) = (1 2 3)
 ;;



;;GET-MULTI-SELECT-QVAR-VALUES
;; WAS get-multi-select-quest-var-values OR get-multi-select-question-var-values
;;ddd
(defun get-multi-select-qvar-values (qvar &key qvarlist supsys
                                                        return-all-answer-qvars-p selection-type
                                                        (def-selection-type :MULTI-ITEM)
                                                        (all-qvarlists *ALL-CSQ-QVARS)
                                                        (default-title-text *default-multi-choice-title)
                                                        (default-instr-text *default-multi-choice-instr))
  "In U-CS (inSHAQ U-data-functions) NOT user answers. RETURNS:  (values   primary-qvar primary-qvar-str  primary-qvar-label 
              q-title  ans-instr-text q-num quest-text-list selection-type
              q-spss-name 
              ans-name-list   ans-text-list   num-answers ANSWER-QVARLISTS
              q-datatype    ans-data-list   ans-xdata-lists 
              linktype1 linktype2 sub-linktype1-list sub-linktype2-list
              supsys sublist   primary-help-info primary-help-links).  
     NOTE: If QVARLIST is supplied, saves the search for the qvar category list.
      also: :MULTI-ITEM-SINGLE-SELECT used for single-selection multi-item."
  ;;qvar  is the overall sym not used  (eg BIO4JOB)
  (let*
      ((primary-qvar (cond  ((stringp qvar)   (my-make-symbol qvar)) (t qvar)))
       (multi-items-list 
        (cond (qvarlist  qvarlist)  
              (t (nth-value 1 (get-keyvalue-in-nested-list (list (list qvar T)) all-qvarlists)))))
       ;;(get-keyvalue-in-nested-list (list (list 'utype T)) *ALL-CSQ-QVARS)
       ;; (find-qvar-selection-type 'ugoals)
       (length-multi-list (list-length multi-items-list))
       (primary-qvarlist) ;;later (car multi-items-list))
       (primary-qvar-str (cond ((stringp qvar) qvar)
                               (t (format nil "~A" qvar)))) ;; later(car primary-qvarlist))
       (primary-qvar-label)
       (primary-spss-match)
       ;;(primary-java-var)
       (primary-qvar-sublist)
       (selection-type)
         ;indiv item spss names
       (q-spss-name) ;;for whole category (eg. occupation)
       (ans-name-list)  ;;spss var name for each item (eg. sales, teacher, etc)
       (ans-text-list) ;;actual text of answer items
       (num-answers (- length-multi-list 2)) ;;don't count category name + primary list
       ;;question text title, instrs, overall question

       ;;THESE MAY BE MODIFIED BELOW
       (q-title default-title-text)
       (ans-instr-text default-instr-text)
       (primary-help-info "")
       (primary-help-links)
       (quest-text-list) ;;PUT IN AS INSTR TEXT
       (q-num 0)
       ;;data info -- generally each item scored 0 or 1(checked)
       (q-datatype)       ;;usually integer
       (ans-data-list)   ;;list of  1's (1 1 1 ... 1)        
       ;;following rarely used with multi-selection
       (array)
       (frame-title)
       (java-var-list)
       (spss-match-list)
       (fr-width)
       (fr-height)
       (java-file)
       (ans-xdata-lists)
       (qvar)
       (label)
       (spss-match)
       (java-var)
       (sublist)
       (special-title)
       (special-instr)
       (ans-xdata-list)
       ;;added
       (ans-text-sublist)
       (return-multi-selection-keylist)
       (q-instr-sym)
       (answer)
       (linktype1)
       (linktype2)
       (sub-linktype1-list)
       (sub-linktype2-list)
       ;;for helplinks
       (primary-help-list)
       (special-quest-list)
       (answer-qvarlists)
       ;;yyyy
       )
    ;;FOR EACH LIST IN MULTI-SELECT LIST GROUP
    (loop
     for qvarlist in multi-items-list
     for i from 0 to (-  length-multi-list 1)
     #|    with qvar
    with label
    with spss-match
    with java-var
    with sublist
    with special-title
    with special-instr
    with ans-xdata-list|#
     do
     ;;set the values
 
     ;;from the qvar get more data for the title, instrs, question
     ;; most ARE NOT SCORED EXCEPT 1 (checked) or 0 (not)  
     (cond
      ((= i 1) 
       (setf   primary-qvar-label (second qvarlist)
              ;; primary-spss-match (third qvarlist)
              primary-java-var (fourth qvarlist) ;;actually usually a list
              primary-qvar-sublist (fifth qvarlist)
              primary-help-list (sixth qvarlist)
              linktype1 (get-key-value :LNTP qvarlist)
              linktype2 (get-key-value :LN2  qvarlist)
              selection-type (cond ((member :MULTI-ITEM-SINGLE-SELECT qvarlist
                                            :test 'equal) :MULTI-ITEM-SINGLE-SELECT)
                                   (T def-selection-type)))
       ;;for helplinks
       (if (equal (car primary-help-list) :help)
           (setf primary-help-info (second primary-help-list)
                 primary-help-links (third primary-help-list)))
       ;;check for special title and instructions for each category/multi question
       (cond
        ((listp primary-qvar-sublist)
         (setf special-title (getf primary-qvar-sublist :title)
               special-quest-list (getf primary-qvar-sublist :quest))
         (if special-title (setf q-title  (car special-title))
           ;;may cause weird error if nil instead of  a string? After checking, probably not.
           (setf q-title " "))
         ;;NO USED AS QUEST  (if special-instr (setf ans-instr-text  special-instr))
         (unless (listp ans-instr-text)
           (setf ans-instr-text (list ans-instr-text)))
         (setf  QUEST-TEXT-LIST special-quest-list) ;; primary-qvar-sublist)
         ;;(afout 'out (format nil "2 QUEST-TEXT-LIST ~A~%"QUEST-TEXT-LIST))       
         )
        (t nil))      
       ;;OLD FORM THAT MAY STILL BE USED??
       ;;(afout 'out (format nil "primary-qvar-sublist= ~A~%"primary-qvar-sublist))
       (cond
        #|       ((and (listp primary-qvar-sublist)
             (<  (list-length primary-qvar-sublist) 5))
        (setf  QUEST-TEXT-LIST ans-instr-text) ;; primary-qvar-sublist)
        ;;(afout 'out (format nil "2 QUEST-TEXT-LIST ~A~%"QUEST-TEXT-LIST))
        )   |#     
        ((and (listp primary-qvar-sublist)
              (> (list-length primary-qvar-sublist) 4))
         (if (numberp (second sublist))
             (setf q-num (second sublist)))
         (setf q-name (third sublist) 
               q-datatype (fourth sublist) 
               answer-panel (fifth sublist)
               array (sixth sublist)
               frame-title  (seventh sublist)
               fr-width (eighth sublist)
               fr-height  (ninth sublist)
               java-file  (tenth sublist ))
         )
        (t   nil     ))
       ;;end (= i 1) clause
       )
      ;;FOR REST OF QVAR ITEMS IN THE MULT-LIST
      ((> i 1) 
       ;;get answer text and other info here
       (cond
        ((listp qvarlist)
         (setf answer-qvarlists (append answer-qvarlists (list qvarlist)))
         (let*
             ((qvar-str (first qvarlist))
              (qvar (my-make-symbol qvar-str))
              (label (second qvarlist))
              (spss-match (third qvarlist))
              ;;later comment off these below??
              ;;spss-match-list (append spss-match-list (list spss-match))
              (java-var (fourth qvarlist))
              (java-var-list (append java-var-list (list java-var)))
              (ans-text-sublist (fifth qvarlist))
              (ans-xdata-list (car (last qvarlist)))
              (sub-linktype1 (get-key-value :LNTP qvarlist))
              (sub-linktype2 (get-key-value :LN2  qvarlist))
              )
           ;;ANS-NAME-LIST
              (setf ans-name-list (append ans-name-list (list qvar)))
           ;;SUB-LINKTYPE1-LIST and SUB-LINKTYPE2-LIST
           (setf sub-linktype1-list (append sub-linktype1-list (list sub-linktype1))
                 sub-linktype2-list (append sub-linktype2-list (list sub-linktype2)))
           ;;ANS-XDATA-LIST
           (unless  (and (listp ans-xdata-list)(equal (car ans-xdata-list) :xdata))
             (setf ans-xdata-list nil))
           (setf ans-xdata-lists (append ans-xdata-lists (list ans-xdata-list)))
             
           (if (stringp (car ans-text-sublist))
               (setf ans-text-list (append ans-text-list  ans-text-sublist))
             ;;else
             (setf  ans-text-list (append ans-text-list (list label))))             
             
           ;;(afout 'out (format nil "label= ~A ans-text-list= ~A~%"   label ans-text-list))
           ;;end let, listp 
           ))
        (t nil))
       ;;end (> i 1),cond
       )
      (t nil))
     ;;end loop
     )
    ;;MAKE Q-NUM AND ANS-DATA-LIST
    ;;SSS  DEFPARAMETER THIS VARIABLE
    (unless (and (numberp q-num) (> q-num 0))
      (setf q-num (incf *current-multi-selection-qnum)))
    ;;changed 2019, bec error=MAKE-LIST expected a non-negative integer, got -2
    (unless ans-data-list
      (cond 
       ((> length-multi-list 2)
        (setf q-datatype 'integer
              ans-data-list (make-sequence 'list (-  length-multi-list 2) :initial-element 1))) ;;don't count cat-sym and primary-var
       (t (setf q-datatype 'integer
                ans-data-list (make-sequence 'list 2 :initial-element 1)))))

   (unless return-all-answer-qvars-p 
     (setf  answer-qvarlists "Answer-qvarlists not returned"))

    (values   primary-qvar primary-qvar-str  primary-qvar-label
              q-title  ans-instr-text q-num quest-text-list selection-type
              q-spss-name 
              ANS-NAME-LIST   ANS-TEXT-LIST   num-answers answer-qvarlists
              q-datatype    ans-data-list   ans-xdata-lists 
              linktype1 linktype2 sub-linktype1-list sub-linktype2-list
              supsys sublist   primary-help-info primary-help-links)
    ;;end let,  get-multi-select-qvar-values
    ))
;;TEST
;; NULLreturn-all-answer-qvars-p
;; (get-multi-select-qvar-values 'UTYPE)
 #|primary-qvar= UTYPE  primary-qvar-str "UTYPE" 
;; primary-qvar-label "UserType" 
;;q-title=  "SHAQ CARES: 
               Selection of Your Questionnaires-Part 1"
;;ans-instr-text= "Select ALL that apply to you"  num-answers 52
("  ==> FIND YOUR HAPPINESS QUOTIENT (HQ). 
         Research shows that 75% of people's overall happiness score is accounted for by the SHAQ HQ score (Stevens, 2009). Your HQ values, beliefs, and life skills may be powerful influences on your past, current, and future happiness. 
         HQ factors are CONTROLLABLE factors: you can choose to be happy by improving them. 
         ==> Why are you taking SHAQ?") 
selection-type= :MULTI-ITEM   q-spss-name= NIL
;;ans-name-list= (TWANTTHO TKNOWMOR TWANTHEL TWANTSPE TEXPERIE TPREVSHAQ WANTSPQ TU100STU TCSULBST TCOLSTU TOTHERST TRESSUB TCOLFACA U-NONE)
("Want a thorough assessment and/or my Happiness Quotient (HQ) Score." "Want to understand myself better." "Want help with a general problem(s)." "Want help for specific problem(s)." "Experienced self help user. " "Previous SHAQ user." "I want to choose specific questionnaire(s)." "I'm a CSULB student completing UNIV 100 assignment" "Other CSULB student." "Other college student. " "Other type of student." "Subject  in a SHAQ research project." "College faculty member or administrator." "Other or None of above.")
14   "Answer-qvarlists not returned"  INTEGER  (1 1 1 1 1 1 1 1 1 1 1 1 1 1)
((:XDATA :SCALES (HQ)) (:XDATA :SCALES (HQ)) (:XDATA :SCALES (HQ)) (:XDATA :SCALES NIL) (:XDATA :SCALES NIL) (:XDATA :SCALES (PREVIOUS-USER)) (:XDATA :SCALES (SPECIFIC-QUESTS)) (:XDATA :SCALES (HQ ACAD-LEARNING)) (:XDATA :SCALES (ACAD-LEARNING)) (:XDATA :SCALES (ACAD-LEARNING)) (:XDATA :SCALES (ACAD-LEARNING)) (:XDATA :SCALES NIL) (:XDATA :SCALES NIL) (:XDATA :SCALES NIL)) NIL NIL NIL NIL NIL NIL NIL NIL
|#
;;For LINK QUESTIONS
;; (get-multi-select-qvar-values 'emot)
 ;; works= EMOT  "EMOT"  "EMOT"  
#|"   TYPE OF EMOTION"
"Select ALL that apply to you"  62
("    Select the EMOTION(S) that is/are MOST strongly associated with this item")
:MULTI-ITEM   NIL
(HAP CARE ANX ANG DEP NONE)
("  HAPPY" "  CARING" "  ANXIETY" "  ANGER" "  SAD" " UNSURE or NONE")
6   "Answer-qvarlists not returned"  INTEGER  (1 1 1 1 1 1)
(NIL NIL NIL NIL NIL NIL) NIL NIL NIL NIL NIL NIL NIL NIL
|#


;;OLDER DEPRECIATED--RETURNED LIST OF KEYLISTS INSTEAD OF VALUES
(defun get-multi-selection-quest-var-values (qvar-category &key qvarlist) ;;
   ;;should work, but gets error &key (qvar-master-list *SHAQ-question-variable-lists))
  "In U-CS, DEPRECIATED--RETURNED LIST OF KEYLISTS,
 USE GET-MULTI-SELECT-QVAR-VALUES INSTEAD (inSHAQ U-data-functions)  RETURNS PLIST ( :qvar-category :primary-qvar-sym  :primary-qvar-label :primary-title-text :primary-instr-text :quest-text-list :q-spss-name :ans-name-list (SPSS VAR NAME each item) :ans-text-list :num-answers  :primary-title-text :primary-instr-text :quest-text-list  :qnum  :data-type :ans-data-list  :primary-java-var :primary-spss-match :spss-match-list :java-var-list :ans-xdata-lists).  If qvarlist is supplied, saves the search for the qvar category list."
  ;;qvar-category  is the overall sym not used  (eg BIO4JOB)
  (let*
      ((multi-items-list 
        (if qvarlist  qvarlist ;;if provided in key
          ;;otherwise, find the qvarlist
          (eval `(get-key-value-in-nested-lists (quote (( ,qvar-category 0)))
                                                (eval *cur-qvarlists)  :return-list-p t))))
 ;;test (get-key-value-in-nested-lists (quote (( ugoals 0))) *cur-qvarlists :return-list-p t)
;; (find-qvar-selection-type 'ugoals)

       (length-multi-list (list-length multi-items-list))
       (primary-qvarlist) ;;later (car multi-items-list))
       (primary-qvar-sym)  ;; later(car primary-qvarlist))
       (primary-qvar-label)
       (primary-spss-match)
       (primary-java-var)
       (primary-qvar-sublist)
         ;indiv item spss names
       (q-spss-name) ;;for whole category (eg. occupation)
       (ans-name-list)  ;;spss var name for each item (eg. sales, teacher, etc)
       (ans-text-list) ;;actual text of answer items
       (num-answers (- length-multi-list 2)) ;;don't count category name + primary list
       ;;question text title, instrs, overall question

       ;;THESE MAY BE MODIFIED BELOW
       (primary-title-text *default-multi-choice-title)
       (primary-instr-text *default-multi-choice-instr)
       (primary-help-info "")
       (primary-help-links)
       (quest-text-list) ;;PUT IN AS INSTR TEXT
       (qnum 0)
       ;;data info -- generally each item scored 0 or 1(checked)
       (data-type)       ;;usually integer
       (ans-data-list)   ;;list of  1's (1 1 1 ... 1)        
       ;;following rarely used with multi-selection
       (array)
       (frame-title)
       (java-var-list)
       (spss-match-list)
       (fr-width)
       (fr-height)
       (java-file)
       (ans-xdata-lists)
       (qvar)
        (label)
        (spss-match)
        (java-var)
        (sublist)
        (special-title)
        (special-instr)
        (ans-xdata-list)
        ;;added
        (ans-text-sublist)
        (return-multi-selection-keylist)
        (q-instr-sym)
        (answer)
        (linktype1)
        (linktype2)
        (sub-linktype1-list)
        (sub-linktype2-list)
      ;;for helplinks
      (primary-help-list)
      (special-quest-list)
      (answer-qvarlists)
;;yyyy
        )
  
   ;;FOR EACH LIST IN MULTI-SELECT LIST GROUP
   (loop
    for qvarlist in multi-items-list
    for i from 0 to (-  length-multi-list 1)
#|    with qvar
    with label
    with spss-match
    with java-var
    with sublist
    with special-title
    with special-instr
    with ans-xdata-list|#
    do
    ;;set the values
 
    ;;from the primary-qvar get more data for the title, instrs, question
    ;; most ARE NOT SCORED EXCEPT 1 (checked) or 0 (not)  
    (cond
     ((= i 1) 
      (setf  primary-qvar-sym (first qvarlist)
             ;; qvar-syms-list (append qvar-syms-list (list qvar))
             primary-qvar-label (second qvarlist)
             primary-spss-match (third qvarlist)
             primary-java-var (fourth qvarlist) ;;actually usually a list
             primary-qvar-sublist (fifth qvarlist)
             primary-help-list (sixth qvarlist)
             linktype1 (get-key-value :LNTP qvarlist)
             linktype2 (get-key-value :LN2  qvarlist)
              )
      ;;for helplinks
      (if (equal (car primary-help-list) :help)
          (setf primary-help-info (second primary-help-list)
                primary-help-links (third primary-help-list)))
      ;;check for special title and instructions for each category/multi question
      (cond
       ((listp primary-qvar-sublist)
        (setf special-title (getf primary-qvar-sublist :title)
              special-quest-list (getf primary-qvar-sublist :quest))
        (if special-title (setf primary-title-text  (car special-title))
          ;;may cause weird error if nil instead of  a string? After checking, probably not.
          (setf primary-title-text " "))
      ;;NO USED AS QUEST  (if special-instr (setf primary-instr-text  special-instr))
        (setf  QUEST-TEXT-LIST special-quest-list) ;; primary-qvar-sublist)
        ;;(afout 'out (format nil "2 QUEST-TEXT-LIST ~A~%"QUEST-TEXT-LIST))       
        )
       (t nil))      
  ;;OLD FORM THAT MAY STILL BE USED??
     ;;(afout 'out (format nil "primary-qvar-sublist= ~A~%"primary-qvar-sublist))
      (cond
#|       ((and (listp primary-qvar-sublist)
             (<  (list-length primary-qvar-sublist) 5))
        (setf  QUEST-TEXT-LIST primary-instr-text) ;; primary-qvar-sublist)
        ;;(afout 'out (format nil "2 QUEST-TEXT-LIST ~A~%"QUEST-TEXT-LIST))
        )   |#     
       ((and (listp primary-qvar-sublist)
             (> (list-length primary-qvar-sublist) 4))
        (if (numberp (second sublist))
            (setf qnum (second sublist)))
        (setf q-name (third sublist) 
              data-type (fourth sublist) 
              answer-panel (fifth sublist)
              array (sixth sublist)
              frame-title  (seventh sublist)
              fr-width (eighth sublist)
              fr-height  (ninth sublist)
              java-file  (tenth sublist ))
        )
       (t   nil     ))
     ;;end (= i 1) clause
      )
     ;;FOR REST OF QVAR ITEMS IN THE MULT-LIST
     ((> i 1) 
      ;;get answer text and other info here
      (cond
       ((listp qvarlist)
        (setf answer-qvarlists (append answer-qvarlists (list qvarlist)))
        (setf qvar (first qvarlist)
               ans-name-list (append ans-name-list (list qvar))
               label (second qvarlist)
               spss-match (third qvarlist)
               ;;later comment off these below??
               spss-match-list (append spss-match-list (list spss-match))
               java-var (fourth qvarlist)
               java-var-list (append java-var-list (list java-var))
               ans-text-sublist (fifth qvarlist)
               ans-xdata-list (car (last qvarlist))
               sub-linktype1 (get-key-value :LNTP qvarlist)
               sub-linktype2 (get-key-value :LN2  qvarlist)  
               )
        ;;SUB-LINKTYPE1-LIST and SUB-LINKTYPE2-LIST
        (setf sub-linktype1-list (append sub-linktype1-list (list sub-linktype1))
              sub-linktype2-list (append sub-linktype2-list (list sub-linktype2)))
        ;;ANS-XDATA-LIST
        (unless  (and (listp ans-xdata-list)(equal (car ans-xdata-list) :xdata))
          (setf ans-xdata-list nil))
        (setf ans-xdata-lists (append ans-xdata-lists (list ans-xdata-list)))
             
        (if (stringp (car ans-text-sublist))
            (setf ans-text-list (append ans-text-list  ans-text-sublist))
          ;;else
          (setf  ans-text-list (append ans-text-list (list label))))             
             
        ;;(afout 'out (format nil "label= ~A ans-text-list= ~A~%"   label ans-text-list))
        )
       (t nil))
      ;;end (> i 1),cond
      )
     (t nil))
     ;;end loop
     )
   ;;MAKE QNUM AND ANS-DATA-LIST
     ;;SSS  DEFPARAMETER THIS VARIABLE
     (unless (and (numberp qnum) (> qnum 0))
       (setf qnum (incf *current-multi-selection-qnum)))
     ;;changed 2019, bec error=MAKE-LIST expected a non-negative integer, got -2
     (unless ans-data-list
       (cond 
        ((> length-multi-list 2)
       (setf data-type 'integer
             ans-data-list (make-sequence 'list (-  length-multi-list 2) :initial-element 1))) ;;don't count cat-sym and primary-var
        (t (setf data-type 'integer
             ans-data-list (make-sequence 'list 2 :initial-element 1)))))

         ;;MAKE THE RETURN-KEYLIST
         (setf return-multi-selection-keylist
               (list :qvar-category qvar-category
                 :primary-qvar-sym  primary-qvar-sym  ;; later(car primary-qvarlist))
                 :primary-qvar-label  primary-qvar-label
                 ;;question text title, instrs, overall question
                 :primary-title-text primary-title-text
                 :primary-instr-text primary-instr-text
                 :qnum  qnum
                 :quest-text-list quest-text-list
                ;;;indiv item spss names
                 :q-spss-name  q-spss-name ;;for whole category (eg. occupation)
                 :ans-name-list  ans-name-list  ;;SPSS VAR NAME each item 
                 :ans-text-list ans-text-list  ;;actual text of answer items
                 :num-answers  num-answers
                 ;;question text title, instrs, overall question
                 ;;data info -- generally each item scored 0 or 1(checked)
                 :data-type   data-type      ;;usually integer
                 :ans-data-list   ans-data-list  ;;list of  1's (1 1 1 ... 1)       
                 :primary-java-var  primary-java-var 
                 :primary-spss-match  primary-spss-match
                 :spss-match-list spss-match-list
                 :java-var-list java-var-list
                 :ans-xdata-lists ans-xdata-lists
                  :linktype1 linktype1
                  :linktype2 linktype2
                 :sub-linktype1-list sub-linktype1-list
                 :sub-linktype2-list sub-linktype2-list
                 :help-info primary-help-info
                 :help-links primary-help-links
                 ))
     ;;end let, defun get-multi-selection-quest-var-values
     ))
;;(defparameter @SSS-TEST nil)
;;TEST
;; (get-multi-selection-quest-var-values 'emot)
;;  (get-multi-selection-quest-var-values 'bio4job)
;; works, result= (:QVAR-CATEGORY BIO4JOB :PRIMARY-QVAR-SYM "bio4job" :PRIMARY-QVAR-LABEL "b-Primary occupation" :PRIMARY-TITLE-TEXT "MULTIPLE-SELECTION QUESTION" :PRIMARY-INSTR-TEXT "Select ALL that apply to you" :QNUM 10 :QUEST-TEXT-LIST ("INSTRUCTIONS: Select ALL of the following best describe your primary OCCUPATION." "If you have multiple occupations, choose all of them.") :Q-SPSS-NAME NIL :ANS-NAME-LIST ("student" "manager" "propeop" "protech" "consulta" "educator" "sales" "technici" "clerical" "service" "ownbus10" "othrsfem") :ANS-TEXT-LIST ("1-Student" "2-Manager" "3-People professional" "4-Technical professional" "5-Consultant" "6-Educator" "7-Sales" "8-Other technical" "9-Clerical" "10-Service" "11-Own business" "12-othrsfem") :NUM-ANSWERS 13 :DATA-TYPE INTEGER :ANS-DATA-LIST (1 1 1 1 1 1 1 1 1 1 1 1) :PRIMARY-JAVA-VAR ("bio4job") :PRIMARY-SPSS-MATCH "spss-match" :SPSS-MATCH-LIST ("spss-match" "spss-match" "spss-match" "spss-match" NIL "spss-match" "spss-match" "spss-match" "spss-match" "spss-match" "spss-match" "spss-match") :JAVA-VAR-LIST (("Student") ("Manager/executive") NIL ("Technician") ("Consultant") ("Educator") ("Sales") ("Technician") ("Clerical") ("Service") ("Own business +10 employees") (("Other self-employed"))))
;; 
;; (get-key-value-in-nested-lists '(( "BIO4JOB" 0))  *SHAQ-question-variable-lists :return-list-p T) works, returns entire list of lists under BIO4JOB CATEGORY
;; (defun testx (a &key (b 7))   b) ;; (testx 9) = 7
;;
;;  (get-multi-selection-quest-var-values 'scalessel)




;;GET-QUESTION-INFO
;;
;;ddd
(defun get-question-info (qvar &optional (category T) 
                               &key q-num
                               (all-questions-list *ALL-CSQ-QUESTIONS)
                               (all-qvarlists *ALL-CSQ-QVARS)
                               (csq-data-list '*SHAQ-ALL-DATA-LIST)
                               get-multiselect-scores-p
                               qvarlist  quest-varlist is-answer-qvar-p
                               (format-out-text-p T) add-instrs-p
                               text-input-box1-instrs text-input-box2-instrs
                                selection-type ;;needed to sometimes over-ride given
                               (eval-text-input-box-sym-p T))
  "In U-CS REPLACES get-question-text, quest-name = qvar  given quest-symbol.
  RETURNS: (values qvar qvar-string label q-title selection-type  q-instr-out q-text-out  text-input-box1-instrs text-input-box2-instrs
            q-instr-list  q-text-list     
            ans-name-list ans-text-list   ans-nonuser-data-list  ans-xdata-lists  num-answers
            linktype1  linktype2 supsys subsys
            sub-linktype1-list sub-linktype2-list ANSWER-QVARLISTS 
            reversed-item-p item-norm-or-rev qvarlist multi-item-p 
            MULTI-ANS-VAL-PAIRS multi-ans-chkd-pairs)
   LIST of question text from nested list--arg string or symbol, will also search for question sym w/o Q if gets nil. 
  NOTE: Q-INSTR-LIST: First item= q-title [unless only 1 item in list, then= q-instr]  Second= q-instr  Q-INSTR can be a list (incl (FORMAT nil ... within) a string or a list with one or more symbols that should be evaluated to a STRING. 
   ADD-INSTRS-P: if stringp, inserts pre instrs, if T, inserts INSTRUCTIONS.
  UPDATED for CSQ. multi-item-p found automatically.
  QVARLIST prevents search in case of multi-item quests."
  ;;2019 preprocess to get one list of questions
  (when (symbolp all-questions-list)
    (setf all-questions-list (eval all-questions-list)))

  (when (stringp qvar)
    (setf qvar (my-make-symbol qvar)))

  (let*
      ((qvar-string (format nil "~A" qvar))
       (q-text-name (format nil "~AQ" qvar))
       (q-text-sym (my-make-cs-symbol q-text-name))
       ;;quest-varlist is main qvarQ list of question text info
       ;;works= (ISAQ ((FORMAT NIL "What kind(s) or type(s) is ~A?" *CS-EXPLORE-PHRASE)) CS-LINKTYPE-INSTR *MULTI-INPUT-BOX-INSTRS)  ETC
       ;; (get-set-append-delete-keyvalue-in-nested-list :get (list (list T 0) (list 'motherq  0 :R)
       (multi-item-p) 
       (selection-type1)
       (q-title)
       (q-instr)
       (q-instr-list)
       ;;primary-qvar-label  q-title  primary-instr-text q-num quest-text-list
       (n-instrs)
       (q-instr-sym)  ;;  q-instr-text  q-num1  q-text-list 
       (q-text-list)
       (q-ans-info)
       (text-input-box-instrs-sym)
       (proc-q-instr-list)
       (proc-q-text-list)
       (q-instr-out)
       (q-text-list)
       (q-text-out)   
       (q-spss-name)
       (reversed-item-p)
       (item-norm-or-rev)
       ;;from ans-array-info, 
       (q-datatype)
       (ans-info-list)  
       (ans-instrs)    
       (ans-text-list )
       (ans-nonuser-data-list) 
       (num-answers )    
       ;;for multiple-selection 
       (question-text)
       (instruction-text)
       ;;for get-main-qvar-vars-p
       (label)
       (linktype1)
       (linktype1)
       (sub-linktype1)
       (sub-linktype2)
       (supsys )
       (qvar-category)
       (q-num1)
       (primary-qvar-sym)
       (primary-qvar-label) ;;(primary-title-text)
       ;;(primary-instr-text)  ;;(quest-text-list)
       (ans-name-list)                            
       (ANSWER-QVARLISTS)
       (ans-xdata-list)
       (ans-xdata-lists)
       (sub-linktype1-list)(sub-linktype2-list)
       (supsys)(subsys)(help-info)(help-links)
       (primary-qvar)( primary-qvar-str) ;;USED ONLY FOR MVSETQ
       ;;SSSSS FINISH THIS LATER--FOR USE IN MAKE-QUESTION-FRAME
       (test-result) ;;FIND AND EVAL? FUNCTION IN QVAR INFO
       ;;for multi-selection answers
       (multi-ans-val-pairs)
       (multi-ans-chkd-pairs) 
       (ans-nonuser-data-list )
       )
    (unless (or quest-varlist (and selection-type (member selection-type ;;added mult
                                      '(:check-box-type :multiple :multiple-selection :multi-item)
                                      :test 'equal)))
        (setf quest-varlist   (get-set-append-delete-keyvalue-in-nested-list :get  
                                                                       (list  (list q-text-sym  0 1))
                                                                       all-questions-list
                                                                       :return-nested-list-p NIL)))
    
    (unless selection-type ;;Do not over-ride selection-type arg.
     (cond
      ((intersection '(:text :text-input) quest-varlist :test 'equal)
       (setf selection-type :text))
      ((or (null quest-varlist) (null (second quest-varlist))
               (member  'NO-QUEST-STRING-FOUND quest-varlist :test 'equal))
      (setf multi-item-p T
            selection-type :multiple-selection))))
    ;;(break "quest-varlist")

    ;;STEP 1: GET TEXT INFO FROM THE QUEST-VARLIST (qvarQ list)
    ;;
    ;;eg (SMTBUSYQ    ("I rarely get upset about being too rushed, having too many things to do, or not having any time to relax.")   SM-INSTR  SMTBUSYQ)
    ;;also, (SM-INSTR     ("Self-Management Questions:" "Honest answers give you the most accurate results."))
    (cond
     ;;IF MULTI-ITEM-P OR :CHECK-BOX-TYPE, don't get any text here.
     ((or multi-item-p (member selection-type '(:multiple :multiple-selection
                                                :multi-item :check-box-type) :test 'equal))
      (setf multi-item-p T))
     ;;FOR NON MULTI-ITEM QVARS, use the *CSQ-QUESTIONS FILE
     ;;  >> FOR ANSWER-PANEL TEXT, GO TO QVAR INFO SECTION
     
     ;;SPECIAL QUESTIONS RETURNING TEXT ANSWERS
     ;;(eg ID info). Only need Question text from QVAR
     ;;--not from Questions. Later get text answer.
     ((equal selection-type :text) 
      (when quest-varlist
       (setf q-text-list (second quest-varlist ))))

     ;;SINGLE-RESPONSE FROM A NUMERICAL-SCORED ANSWER SET
     ((and quest-varlist (listp quest-varlist))
      (setf q-text-list (second quest-varlist)
            q-instr-sym (third quest-varlist)
            n-text-list (list-length q-text-list))

      ;;GET MAIN INSTRUCTIONS LIST
      (setf q-instr-list (get-keyvalue-in-nested-list
                          (list  (list q-instr-sym 0 1) ) 
                          all-questions-list :return-value&keylist-p T)) 
      ;;  *CS-EXPLORE-PHRASE = "GROUP KNOWLEDGE WORKER"
      ;;eg(CS-LINKTYPE-INSTR ("LINKS TO OTHER NODES" (format nil  "Associations with the word, class, concept, or instance \"~A.\" " *cs-explore-phrase)) )
      ;;FOR q-instr-list
      (setf proc-q-instr-list (process-text-list q-instr-list))
      ;;SET TO INSTR SYM
      (cond
       ((not (listp proc-q-instr-list))
        (setf q-instr-out proc-q-instr-list))
       ((> (list-length proc-q-instr-list) 1)
        (setf q-title (first proc-q-instr-list)
              q-instr-out (second proc-q-instr-list)))
       (t (setf  q-instr-out (car proc-q-instr-list))))
        ;(break)
      ;;FOR q-text-list
      (setf proc-q-text-list (process-text-list q-text-list))
      ;;SET TO TEXT-SYM
      (cond
       ((not (listp proc-q-text-list))
        (setf q-text-out proc-q-text-list))
       ((> (list-length proc-q-text-list) 1)
        (setf q-text-out (string-append* proc-q-text-list)))
       (t (setf  q-text-out (car proc-q-text-list))))
      ;;(break "new")

      ;;ADDED FOR CSQ (from SHAQ) 
      ;;following may no longer be needed bec of new process-text-list function
      (when (symbolp q-title)
        (setf q-title (eval q-title)))
      (when (and (symbolp q-instr) (null q-instr-out))
        (setf q-instr-out (eval q-instr)))
      #| REPLACED W/ get-quest-input-box-instrs
            (when (and eval-text-input-box-sym-p 
                 (symbolp text-input-box1-instrs)(boundp text-input-box1-instrs))
        (setf text-input-box1-instrs (eval text-input-box1-instrs)))
      (when (and eval-text-input-box-sym-p 
                 (symbolp text-input-box2-instrs)(boundp text-input-box2-instrs))
        (setf text-input-box2-instrs (eval text-input-box2-instrs)))|#
      ;;end listp quest-varlist
      )
     (t (setf q-text-list '("NO QUESTION TEXT FOUND"))))
    ;;END GETTING QUESTION TEXT INFO from *ALL-CSQ-QUESTIONS

    ;;STEP 2: PROCESS THE QVARLIST for other variables--incl some TEXT.
    (cond
     ;;in case a qvar (eg  PC) which evals to a qvarlist
     ((and (symbolp qvar)(boundp qvar))
      (setf qvarlist (eval qvar)))
     ;;non-boundp qvar list
     ((and (null qvarlist) (not (equal selection-type :check-box-type)))
      (multiple-value-setq (instr-list qvarlist )
          (get-keyvalue-in-nested-list qvar all-qvarlists  
                                       :return-value&keylist-p T)))
     ;;(get-keyvalue-in-nested-list (list (list 'smtbusy T)) *ALL-CSQ-QVARS :return-value&keylist-p T)
     ;;otherwise use supplied qvarlist arg
     (t NIL))
     ;;(break "qvarlist")

    ;;FOR SINGLE-SELECTION QUESTS and :CHECK-BOX-TYPE ANSWER
    ;;   >> ALSO GET ANSWER TEXT FROM QVAR  ANSWER-PANELS
    (cond
     ((equal selection-type :check-box-type)
      (multiple-value-setq (cslabel qvarlist)
          (get-keyvalue-in-nested-list qvar  all-qvarlists :return-value&keylist-p T))
      (setf q-text-out (car (fifth qvarlist))
            help-info (get-keyvalue-in-nested-list :help qvarlist))
      ;;("catholic" "Catholic" "spss-match" NIL ("Catholic") (:HELP NIL NIL))
      ;;("coprivca" "CA Private U" "spss-match" ("A public university in another state"))
      ;;(break "check box")
      ;;end :check-box-type
      )
     ((member selection-type '( :TEXT :TEXT-INPUT) :test 'equal)
      NIL)
     ((not multi-item-p)
      ;;(value qvar-str phrase (LABEL) selection-type q-num quest-sym q-ans-info q-ans-array q-datatype reversed-item-p linktype1 linktype2 supsys sublist q-help  reversed-item-p item-norm-or-rev )
      (multiple-value-setq (qvar-str label selection-type1 q-num quest-sym q-ans-info q-ans-array q-datatype  linktype1 linktype2 supsys sublist q-help  reversed-item-p item-norm-or-rev )
          (get-qvar-single-select-values qvar :qvarlist qvarlist))
      ;;selection-type arg has priority
      (unless selection-type
        (setf selection-type selection-type1))
      ;;get q-ans-info text
      (setf q-ans-info (convert-list-items-to-string q-ans-info))

#|(defparameter *input-box-instrs  '("Type answer in BOX below:") "For instructions inside the text-input-pane")
 (defparameter *multi-input-box-instrs  '|#
      ;;GET THE ANSWER TEXT INFO
      (multiple-value-setq (ans-info-list  ans-instrs  num-answers ans-text-list
                                           ans-nonuser-data-list)  
          (get-answer-panel-info q-ans-info)) 

      ;;GET-QUEST-INPUT-BOX-INSTRS
      (multiple-value-setq (text-input-box1-instrs text-input-box2-instrs)
          (get-quest-input-box-instrs qvar :selection-type selection-type
                                      :quest-varlist  quest-varlist))
      ;;end single-selection = not multi-item
      )
     ;;FOR MULTI-ITEM QUESTS
     ((or multi-item-p (and (null q-text-out)(null q-instr-out))
          (member selection-type '(:multiple :multiple-selection) :test 'equal))
      ;;(break "before multi-item")
      (cond
       ;;IS-ANSWER-QVAR-P? Answer qvar is an answer from multi-item qvar made to csym.
       ((and (not (listp (second qvarlist))) (member  :multi-item qvarlist :test 'equal))
        (setf is-answer-qvar-p T)
        ;;eg ( "twanttho"   "t-Want thorough assessment"  "spss-match"  NIL  ("Want a thorough assessment and/or my Happiness Quotient (HQ) Score.")  (:help nil nil)  :MULTI-ITEM  (:XDATA :scales (HQ))   )
        ;;qvar qvar-string label q-title selection-type  q-instr-out q-text-out  
        (setf label (second qvarlist))
        (cond ((listp (fifth qvarlist))
               (setf q-text-out (format-string-list (fifth qvarlist))))
              (T (setf q-text-out (fifth qvarlist))))
        ;;for xdata
        (setf  ans-xdata-list (get-keyvalue-in-nested-list '((:xdata T)) qvarlist :return-list-p T)
               supsys (get-key-value :scales ans-xdata-list)
               ans-xdata-lists (list ans-nonuser-data-list))
        )
       ;;FOR REQULAR MULTI-ITEM QUESTIONS with multple answers
       (T      
        (setf *qvar-category  qvar-string)  

        ;;GET MULTI-ITEM VARS & TEXT-INPUT
        ;;orig output (values qvar-str phrase q-num quest-sym q-ans-info q-ans-array q-datatype reversed-item-p linktype1 linktype2 supsys sublist q-help  reversed-item-p item-norm-or-rev ) 
        (multiple-value-setq (primary-qvar qvar-string  label  
                                           q-title  q-instr-list q-num q-text-list selection-type1
                                           q-spss-name  ANS-NAME-LIST  ANS-TEXT-LIST 
                                           num-answers 
                                           answer-qvarlists q-datatype    ans-nonuser-data-list 
                                           ans-xdata-lists 
                                           linktype1 linktype2 sub-linktype1-list sub-linktype2-list
                                           supsys sublist   help-info help-links )  
            (get-multi-select-qvar-values qvar-string :qvarlist qvarlist ))

        ;;for BIO4JOB & UTYPE  = "Answer-qvarlists not returned"
        ;;selection-type arg gets priority
        (unless selection-type
          (setf selection-type selection-type1))

        ;;GET MULTI-SELECTION SCORES/ANSWERS
        (when (and get-multiselect-scores-p csq-data-list)
            (multiple-value-setq (MULTI-ANS-VAL-PAIRS MULTI-ANS-CHKD-PAIRS 
                                                      ans-nonuser-data-list )
                (GET-MULTI-SELECT-ANSWERS qvar :csq-data-list csq-data-list)))

        ;;SSSS START HERE DEBUG (GET-MULTI-SELECT-ANSWERS 
        ;; NOTE: ANS-NAME-LIST  ANS-TEXT-LIST ABOVE HAVE ANS TEXT
        ;; CHECK: MULTI-ANS-VAL-PAIRS MULTI-ANS-CHKD-PAIRS 

        ;;(break "In Get-question-info: Multi-item questions")
        #|  ;;added 2020   SSSSSS FINISH MAKING NEW LINK CSYM
      ;;NO?? HAP, CAR, etc are STANDARD ANSWERS--NOT USER DEFINED
         (when (and make-link-answer-sym-p 
                      (not (boundp (my-make-symbol (car answer-array-list)))))
             (dolist (ans answer-array-list)
               (let* ((str (make-condensed-str ans))
                      (list (list str ans :lntp linktype))
                      (sym (my-make-symbol str))
                      )                 
                 (make-csym sym ans (list sym) nil nil :supsys supsys :lntp linktype)
             ;;end let,dolist, when make-link-answer-sym-p
             )))|#
        ;;(break "multiple-selection vars ans-text-list quest-text-list instruction-text")
        (when (null instruction-text) (setf instruction-text ""))
        (when  (null q-text-list) (setf q-text-list '("")))
  
        ;;QUESTION NUMBER
        (cond
         (q-num (setf pre-selected-num q-num))
         (T (setf pre-selected-num q-num1)))

        ;;FOR COMPATIBILITY with vertical-buttons, single-selection, etc.REPLACE ABOVE?
        (setf ans-instruction-text "Select ALL that apply to you")

        ;;(afout 'out (format nil "*multi-selection-qvarlist ~A~% ans-text-list=~A~%" *multi-selection-qvarlist ans-text-list))

        ;;END MULTIPLE-SELECTION TYPE
        )))
       (t NIL))
    ;;(break "After multi-item")
    #|(defparameter  LikeMe7Reverse   
    '(LikeMe7Instructions  7 LikeMe7AnswerArray  Values1to7Array  "single"  "int"  T  NIL))|#
    ;;(break "end")

    ;;FORMAT TEXT-OUT?
    (cond
     (format-out-text-p
      (setf q-text-out (format-string-list q-text-list  :add-newlines 1)) ;;WAS  ;;was print-list  :no-newline-p t))
      ;;(break "formated-qtext")
      ;;add the question instructions?
      (when add-instrs-p 
       (cond
         ((stringp add-instrs-p)
          (setf q-text-out
              (format nil  "~A~%   ~A ~A" format-out-text-p add-instrs-p q-instr )))
         (T
        (setf q-text-out
              (format nil  "~A~%   INSTRUCTIONS: ~A" format-out-text-p q-instr )))))

      ;;q-instr-list to q-instr-out 
      (unless (and q-instr-list (listp q-instr-list))
                     (setf q-instr-list (list q-instr-list)))
      (cond
       (q-instr-out NIL)
       ((and (null q-instr-out) q-instr-list)
        (setf q-instr-out (format-string-list q-instr-list :add-newlines 0)))
                                ;;was (print-list :no-newline-p t)))
       (T (setf q-instr-out q-instr-list)))
      ;;(break "q-instr-out")
      ;;end format-out-text-p
      )
     (T
      (when  question-text 
        (setf q-text-out question-text))
      (when (and q-text-list (null q-text-out))
        (setf q-text-out q-text-list))
      (when (not (listp q-text-out))
        (setf q-text-out (list q-text-out)))
     (cond
      ((and q-instr-list (listp q-instr-list))
       (setf q-instr-out q-instr-list))
      (t (setf q-instr-out q-instr-list)))))

    (when (null item-norm-or-rev)
      (setf item-norm-or-rev 'NORMAL-ITEM))

    (values qvar qvar-string label q-title selection-type  q-instr-out q-text-out  
            text-input-box1-instrs text-input-box2-instrs
            q-instr-list  q-text-list     
            ANS-NAME-LIST ANS-TEXT-LIST ans-nonuser-data-list  
            ans-xdata-lists  num-answers
            linktype1  linktype2 supsys subsys
            sub-linktype1-list sub-linktype2-list answer-qvarlists 
            reversed-item-p item-norm-or-rev qvarlist multi-item-p 
            MULTI-ANS-VAL-PAIRS MULTI-ANS-CHKD-PAIRS)
    ;;end get-question-info
    ))
;;TEST
;; FOR :TEXT QVARS
;; (get-question-info  "age" NIL :get-multiselect-scores-p T)
;; FOR ANSWER ONLY "QVARS":
;; (get-question-info  'BIO4JOB NIL  :get-multiselect-scores-p T)
#|BIO4JOB
"BIO4JOB"
"b-Primary occupation"
"YOUR OCCUPATION"
:MULTIPLE-SELECTION
"Select ALL that apply to you"
"Select ALL of the following that best describe your primary OCCUPATION. 

   => If you have multiple occupations, choose all of them.
"
NIL
NIL
("Select ALL that apply to you")
("Select ALL of the following that best describe your primary OCCUPATION. 
   => If you have multiple occupations, choose all of them.")
(STUDENT MANAGER PROPEOP PROTECH CONSULTA EDUCATOR SALES TECHNICI CLERICAL SERVICE OWNBUS10 OTHRSFEM OTHER)
("Student" "Manager/executive" "People-related professional" "Technical Professional" "Professional Consultant" "Educator" "Sales" "Technician" "Clerical" "Service employee" "Own business +10 employees" "Other self-employed" "Other")
(0 0 1 0 0 1 0 0 0 0 0 0 0)
(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)
14   NIL NIL NIL NIL  (NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)
(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)
"Answer-qvarlists not returned"   NIL      NORMAL-ITEM
(BIO4JOB ("bio4job" "b-Primary occupation" "spss-match" ("bio4job") (:QUEST ("Select ALL of the following that best describe your primary OCCUPATION. 
   => If you have multiple occupations, choose all of them.") :TITLE ("YOUR OCCUPATION")) (:HELP NIL NIL) NIL :MULTI-ITEM) ("student" "1-Student" "spss-match" NIL ("Student") NIL (:HELP NIL NIL) :MULTI-ITEM) ("manager" "2-Manager" "spss-match" NIL ("Manager/executive") NIL (:HELP NIL NIL) :MULTI-ITEM) ("propeop" "3-People professional" "spss-match" NIL ("People-related professional") (:HELP NIL NIL) :MULTI-ITEM)     ETC ETC  ("protech" "4-Technical professional" "spss-match" NIL ("Technical Professional") NIL (:HELP NIL NIL) :MULTI-ITEM)  ("othrsfem" "12-other occupation" "spss-match" NIL ("Other self-employed") NIL (:HELP NIL NIL) :MULTI-ITEM) ("other" "13-Other" "spss-match" NIL ("Other") NIL (:HELP NIL NIL) :MULTI-ITEM) :MULTI-ITEM)     T
;;USER ANSWERS: (("student" NIL) ("manager" NIL) ("propeop" T) ("protech" NIL) ("consulta" NIL) ("educator" T) ("sales" NIL) ("technici" NIL) ("clerical" NIL) ("service" NIL) ("ownbus10" NIL) ("othrsfem" NIL) ("other" NIL))
(("propeop" T) ("educator" T)) 
 |#
;; (get-question-info  "twanttho" NIL :get-multiselect-scores-p T)
;;  works= TWANTTHO  "TWANTTHO" NIL NIL :MULTIPLE-SELECTION "NIL                                                                                                 " "" NIL NIL NIL)NIL NIL NIL NIL :SCALES NILNILNILNILNILNILNILNILNIL NORMAL-ITEM ("twanttho" "t-Want thorough assessment" "spss-match" NIL ("Want a thorough assessment and/or my Happiness Quotient (HQ) Score.") (:HELP NIL NIL) :MULTI-ITEM (:XDATA :SCALES (HQ))) T
;; <BIO4JOB = ("<BIO4JOB" ("bio4job" "b-Primary occupation" "spss-match" ("bio4job") (:QUEST ("Select ALL of the following that best describe your primary OCCUPATION.      => If you have multiple occupations, choose all of them.") :TITLE ("YOUR OCCUPATION")) (:HELP NIL NIL) NIL :MULTI-ITEM) $MIS.<BIO4JOB NIL NIL :QT :QVAR :CSS $MIS :ADAT (("student" NIL) ("manager" NIL) ("propeop" T) ("protech" NIL) ("consulta" NIL) ("educator" T) ("sales" NIL) ("technici" NIL) ("clerical" NIL) ("service" NIL) ("ownbus10" NIL) ("othrsfem" NIL) ("other" NIL)))    BIO4JOB   NIL    $MIS.<BIO4JOB   NIL
;;
;; 
;;FOR CSQ LINKS (eg "isa")
;; (get-question-info 'isa)
;;works= ISAQ   ("What kind(s) or type(s) is NIL?")  NIL  NIL  "Type only ONE answer in BOX below.  
;;     * Type any additional answers in other popup windows.  
;;     * If NO ANSWER or UNCERTAIN, leave blank. 
;;     * When finished with all answers, click on LAST button."
;; works=  ISA  "ISA" NIL
;; q-instr-out= "LINKS TO OTHER NODES"
#|;; q-text-out= "
        Type answer in box at bottom:     "
;;q-text-out= ("What kind(s) or type(s) is NOT SEEK EXT APPROVAL?")
;; text-input-box-instrs= "Type only ONE answer in BOX below. 
     * Type any additional answers in other popup windows.  
     * If NO ANSWER or UNCERTAIN, leave blank. 
     * When finished with all answers, click on LAST button."
;;q-instr-list= ("LINKS TO OTHER NODES" (FORMAT NIL "~%        Type answer in box at bottom:     "))
;;q-text-list= ((FORMAT NIL "What kind(s) or type(s) is ~A?" *CS-EXPLORE-PHRASE))   NIL NIL NIL NIL NIL NIL
|#
;;  LINK MULTI-ITEM 
;; (get-question-info 'emot)
;;WORKS= qvar=EMOT qvar-string="EMOT" label= NIL
;;q-title="LINKS TO OTHER NODES"
;;q-text-out=    ("What emotion(s) (HAPPY, CARING, ANXIETY, ANGER, SAD, NONE-OF-ABOVE) do you MOST associate with NOT SEEK EXT APPROVAL?")
#|q-instr-out= "
        Type answer in box at bottom:     "
;;q-text-out= ("What emotion(s) (HAPPY, CARING, ANXIETY, ANGER, SAD, NONE-OF-ABOVE) do you MOST associate with NOT SEEK EXT APPROVAL?")
;;text-input-box-instrs= "Type only ONE answer in BOX below. 
     * Type any additional answers in other popup windows.  
     * If NO ANSWER or UNCERTAIN, leave blank. 
     * When finished with all answers, click on LAST button."
;;q-instr-list= ("LINKS TO OTHER NODES" (FORMAT NIL "~%        Type answer in box at bottom:     "))
;;q-text-list= ((FORMAT NIL "What emotion(s) (HAPPY, CARING, ANXIETY, ANGER, SAD, NONE-OF-ABOVE) do you MOST associate with ~A?" *CS-EXPLORE-PHRASE))   NIL NIL NIL NIL NIL
|#
;;HERE66
;;FOR SHAQ SINGLE-SELECTION
;; (get-question-info 'smtbusy)
;;works= 
;;qvar= SMTBUSY qvar-string "SMTBUSY"
;;label=  "sm-Rarely upset about too rushed"  
;;q-title= "Self-Management Questions:"   
;;selection-type :SINGLE-SELECTION
;;q-instr-out= "Self-Management Questions:  Honest answers give you the most accurate results."
;;q-text-out= "I rarely get upset about being too rushed, having too many things to do, or not having any time to relax."
;; text-input-box1-instrs = NIL
;; text-input-box2-instrs= NIL
;;q-text-list=  ("Self-Management Questions:" "Honest answers give you the most accurate results.") 
;;q-instr-list= ("I rarely get upset about being too rushed, having too many things to do, or not having any time to relax.")
;;ANS-NAME-LIST=  ("twanttho" "tknowmor" "twanthel" "twantspe" "texperie" "tprevshaq" "wantspq" "tu100stu" "tcsulbst" "tcolstu" "totherst" "tressub" "tcolfaca" "u-none") 
;;ans-text-list=  ("EXTREMELY accurate / like me" "MODERATELY accurate / like me" "MILDLY accurate / like me" "UNCERTAIN, neutral, or midpoint" "MILDLY inaccurate / unlike me" "MODERATELY inaccurate / unlike me" "EXTREMELY inaccurate / unlike me")  (7 6 5 4 3 2 1)  NIL 7 NIL NIL NIL  NIL NIL NIL NIL NIL NORMAL-ITEM

;;FOR SHAQ MULTI-SELECTION
;; (get-question-info 'UTYPE) ;;note: q-text-out is formated
#| works=
qvar= UTYPE qvar-string="UTYPE"  label="UserType" 
  q-title= "SHAQ CARES:
 Selection of Your Questionnaires-Part 1"
selection-type :MULTI-ITEM
q-instr-out= "Select ALL that apply to you"
q-text-out= "  ==> FIND YOUR HAPPINESS QUOTIENT (HQ). 
         Research shows that 75% of people's overall happiness score is accounted for by the SHAQ HQ score (Stevens, 2009). Your HQ values, beliefs, and life skills may be powerful influences on your past, current, and future happiness. 
         HQ factors are CONTROLLABLE factors: you can choose to be happy by improving them. 
         ==> Why are you taking SHAQ?"
text-input-box1-instrs= NIL  text-input-box2-instrs= NIL
q-instr-list= "Select ALL that apply to you"
q-text-list= ("  ==> FIND YOUR HAPPINESS QUOTIENT (HQ). 
         Research shows that 75% of people's overall happiness score is accounted for by the SHAQ HQ score (Stevens, 2009). Your HQ values, beliefs, and life skills may be powerful influences on your past, current, and future happiness. 
         HQ factors are CONTROLLABLE factors: you can choose to be happy by improving them. 
         ==> Why are you taking SHAQ?")
ans-name-list= (TWANTTHO TKNOWMOR TWANTHEL TWANTSPE TEXPERIE TPREVSHAQ WANTSPQ TU100STU TCSULBST TCOLSTU TOTHERST TRESSUB TCOLFACA U-NONE)
ans-text-list= ("Want a thorough assessment and/or my Happiness Quotient (HQ) Score." "Want to understand myself better." "Want help with a general problem(s)." "Want help for specific problem(s)." "Experienced self help user. " "Previous SHAQ user." "I want to choose specific questionnaire(s)." "I'm a CSULB student completing UNIV 100 assignment" "Other CSULB student." "Other college student. " "Other type of student." "Subject  in a SHAQ research project." "College faculty member or administrator." "Other or None of above.")   
ans-nonuser-data-list= (1 1 1 1 1 1 1 1 1 1 1 1 1 1)
ans-xdata-lists= ((:XDATA :SCALES (HQ)) (:XDATA :SCALES (HQ)) (:XDATA :SCALES (HQ)) (:XDATA :SCALES NIL) (:XDATA :SCALES NIL) (:XDATA :SCALES (PREVIOUS-USER)) (:XDATA :SCALES (SPECIFIC-QUESTS)) (:XDATA :SCALES (HQ ACAD-LEARNING)) (:XDATA :SCALES (ACAD-LEARNING)) (:XDATA :SCALES (ACAD-LEARNING)) (:XDATA :SCALES (ACAD-LEARNING)) (:XDATA :SCALES NIL) (:XDATA :SCALES NIL) (:XDATA :SCALES NIL))
num-answers= 14
  linktype1 NIL linktype2 NIL supsys NIL subsys  NIL sub-linktype1NIL sub-linktype2 NIL ANSWER-QVARLISTS = "Answer-qvarlists not returned" reversed-item-p NIL item-norm-or-rev= NORMAL-ITEM
|#


;;OLDER--VALUES OUTPUT IS DIFFERENT
;; (get-question-text    "thm1achq")
;;works, = (" Being the best at whatever I do (example: making top grades). Achieving more than most other people.")  "INSTRUCTIONS FOR Life Themes, Dreams, and Values:"  "Answer each question according to how important that theme is to you."   
;; (get-question-text "DEFINITION")
;; (get-question-text  'SLFCOPE)
;; result= SLFCOPEQ  ("Emotional coping skills--ability to prevent and overcome negative emotions effectively")  "Self-Confidence Questions"  "CONFIDENCE in your abililities, skills, knowledge, and motivation in this area."  SLFCOPEQ
;; (get-question-text  'UTYPE)
;;  (list (list 3 0) (list (my-make-cs-symbol "this") 0))
;; (my-make-cs-symbol "thisone")
;; (get-question-text  'COPEMOTA T :all-questions-list *ALL-CSQ-QUESTIONS :eval-text-input-box-sym-p nil)
;; works= COPEMOTAQ    ("Outwardly express anger by losing your temper, crying, damaging something, or getting even.")    NIL    NIL   COPEMOTAGGRESSQ  
;; (get-question-text "stuextmo")

;; (get-set-append-delete-keyvalue-in-nested-list :get  (list (list 'pce-people 0 )  (list 'mother  0 :R))      (eval  *cur-all-questions)) 
;;  (get-keyvalue-in-nested-list (list (list T 0 )(list 'PCE-PEOPLE-INSTR 0 :R) ) (eval *cur-all-questions))  ("People Important To You" *INSTR-NAME-ELEMENT)  (PCE-PEOPLE-INSTR ("People Important To You" *INSTR-NAME-ELEMENT))   (PCE-PEOPLE-INSTR ("People Important To You" *INSTR-NAME-ELEMENT))   ("return-orig-nested-list-p=NIL") T






;;MAKE-QVARSYMS-LIST
;;
;;2016
;;ddd
(defun make-qvarsyms-list (&key (cur-all-qvars-list *cur-qvarlists))
  "In U-CS-data-functions, makes a list of ALREADY EXISTING (ONLY) qvarsyms from current-qvarlist. Note: if not default list must use QUOTE."
  (let 
      ((qvarsyms)
       (qvar-names (get-all-csq-qvarnames
                    :all-qvarlists (eval cur-all-qvars-list)))
       (list-length)
       (qvar)
       )
    (loop
     for qname in qvar-names
     do
     (setf qvar (my-make-cs-symbol qname))

     (multiple-value-bind (result list)
         (symbol-listp qvar  :min-length 3)
       ;;(symbol-listp 'fav-spiritual  :min-length 3)
       (when result
         (setf qvarsyms (append qvarsyms (list qvar))))

     ;;end mvb,loop
     ))
    qvarsyms
    ;;end let, make-qvarsyms-list
    ))
;;TEST
;;  (make-qvarsyms-list)
;; works = (MOTHER FATHER BEST-M-FRIEND BEST-F-FRIEND M-DISLIKE F-DISLIKE M-ADMIRE F-ADMIRE PER-MOSTFUN PER-ROMANCE ROLE-MODEL CHILD-FRIEND TEACHER POLICEMAN SALESPERSON DOCTOR LAWYER BUSINESS-OWNER MANAGER SCIENTIST FARMER DRUG-DEALER POLITICIAN DANCER ARTIST COMEDIAN ENGINEER HOUSE-CLEANER MOVIE-STAR ROCK-STAR CHURCH-MINISTER CATHOLICS PROTESTANTS JEWS MUSLIMS BUDDHISTS ATHEISTS YOUR-PERSONALITY YOUR-POSSESSIONS)
;; (make-qvarsyms-list :cur-all-qvars-list '*all-PC-element-qvars)



;;GET-MULTI-SELECT-ANSWERS       
;;2020
;;ddd
(defun get-multi-select-answers (qvar  &key  (csq-data-list '*SHAQ-ALL-DATA-LIST))
  "U-CS Used by get-question-info to look up user answers.  RETURNS (values MULTI-ANS-VAL-PAIRS item-chkd-pairs all-ans-data)"
  (let*
      ((MULTI-ANS-VAL-PAIRS)
       (item-chkd-pairs)
       (all-ans-data)
       (qvar-str (format nil "~A" qvar))
       (datalist (cond ((symbolp csq-data-list)(eval-sym csq-data-list))
                            (T csq-data-list)))
       (qvar-datalist (nth-value 6 
                                 (get-set-append-delete-keyvalue-in-nested-list
                                  :GET (list :shaq-data-list qvar-str ) datalist :use-simple-key-p T)))
;; (nth-value 6 (get-set-append-delete-keyvalue-in-nested-list :GET (list :SHAQ-DATA-LIST "UTYPE" ) (append *CSQ-DATA-LIST  *SHAQ-ALL-DATA-LIST ) :use-simple-key-p T)) ;;this works
       (answerlist (when (listp qvar-datalist) (nthcdr 5 qvar-datalist)))
       (item-pairs)
       )
        ;;(break "1")
      (dolist (item answerlist)
        (let*
            ((ans (fourth item))
             (item-pair (list (car item) ans))
             (item-chkd-p ans)
             )
          (setf  MULTI-ANS-VAL-PAIRS (append1 MULTI-ANS-VAL-PAIRS item-pair))
          (cond
           (ans (setf all-ans-data (append1 all-ans-data 1)))
           (T (setf all-ans-data (append1 all-ans-data 0))))
          (when item-chkd-p
            (setf item-chkd-pairs (append1 item-chkd-pairs item-pair)))
          ))
      (values MULTI-ANS-VAL-PAIRS item-chkd-pairs all-ans-data)
      ;;end let, get-multi-select-answers
      ))
;;TEST
;;  (get-multi-select-answers 'UTYPE)     
;;works= (("twanttho" T) ("tknowmor" NIL) ("twanthel" NIL) ("twantspe" NIL) ("texperie" NIL) ("tprevshaq" NIL) ("wantspq" NIL) ("tu100stu" NIL) ("tcsulbst" NIL) ("tcolstu" NIL) ("totherst" NIL) ("tressub" NIL) ("tcolfaca" NIL) ("u-none" NIL))
;;  (("twanttho" T))  (1 0 0 0 0 0 0 0 0 0 0 0 0)
;;
;;  (get-multi-select-answers 'BIO7LANG)     
;; works= (("lenglish" T) ("lspanish" NIL) ("lvietnam" NIL) ("lcambodn" NIL) ("lchinese" NIL) ("lkorean" NIL) ("lportugu" NIL) ("lgerman" NIL) ("lfrench" NIL) ("lmideast" NIL) ("lothrasn" NIL) ("lothreur" NIL) ("lother" NIL))
;; (("lenglish" T))      (1 0 0 0 0 0 0 0 0 0 0 0 0)
;;
;; ;;  (get-multi-select-answers 'UTYPE :csq-data-list (append *csq-data-list *SHAQ-ALL-DATA-LIST))
;; works= (("twanttho" T) ("tknowmor" NIL) ("twanthel" NIL) ("twantspe" NIL) ("texperie" NIL) ("tprevshaq" NIL) ("wantspq" NIL) ("tu100stu" NIL) ("tcsulbst" NIL) ("tcolstu" NIL) ("totherst" NIL) ("tressub" NIL) ("tcolfaca" NIL) ("u-none" NIL))   (("twanttho" T))   (1 0 0 0 0 0 0 0 0 0 0 0 0 0)




;;GET-CSQ-TEXT-INPUT
;;2020
;;ddd
(defun get-csq-text-input (qvar &key (datakey *txtinputkey) return-base-str-p
                                (shaq-data-list *SHAQ-ALL-DATA-LIST)O)
  "U-CS For SHAQ DATA RESULTS.  RETURNS  (values txtinput qvar-score-list)  INPUT: qvar can be QVAR or CSYM sym or string. When return-base-str-p, uses qvar str as car."
  (let*
      ((qvarstr (cond ((stringp qvar) qvar)
                      ((symbolp qvar) (format nil "~A" qvar))))
       (searchstr (cond ((string-equal (subseq qvarstr 0 1) "<") 
              (subseq qvarstr 1))
            (T qvarstr)))
       (vals (get-set-append-delete-keyvalue-in-nested-list
              :GET (list :SHAQ-DATA-LIST searchstr)
              *SHAQ-ALL-DATA-LIST :use-simple-key-p T))
       (txtinput (second vals))
       (qvar-score-list (list qvar txtinput))
        )
    (when return-base-str-p
      (setf qvar-score-list (list searchstr txtinput)))
    (values txtinput qvar-score-list)
    ;;end let, get-csq-text-input
    ))
;;TEST
;;  (get-csq-text-input "sex") 
;; works= "Male"   ("sex" "Male")
;;  ;;  (get-csq-text-input '<SEX) 
;; works= "Male"  (<SEX "Male")
;;  (get-csq-text-input '<SEX :return-base-str-p T)
;; works= "Male"   ("SEX" "Male")











;;XXX -------------------------------- OLDER -- LATER DELETE?? ----------------
;;
#|  OLDER NOT-WORKING WITH CURRENT SCHEME 
(defun get-multi-question-vars-text (quest-sym)
  "In U-CS (inSHAQ U-data-functions), "
  (let*
      ((q-text-name (format nil "~AQ" quest-name))
       (q-text-sym (my-make-cs-symbol q-text-name))
       (q-multi-var-list 
        (get-key-value-in-nested-lists  (list (list quest-name 0)) 
                                        *ALL-CSQ-QUESTIONS :return-list-p T))
       (length-q-multi-list (list-length q-multi-var-list))
       (q-instr-list)
       (q-title)
       (q-instr)
       (q-instr-list)
       (q-item-text-list)
       (n -1)
       )
    #|    (if
        (null qvarlist)
        (setf new-q-name (my-make-cs-symbol (format nil "~AQ" quest-sym))
              qvarlist  (get-key-value-in-nested-lists 
                           (list (list category 0) (list new-q-name 0))
                           *ALL-CSQ-QUESTIONS :return-list-p T)))|#
    (loop
     for q-item-var-list in q-multi-var-list
     do
     (incf n)
     
     (cond
      ((= n 1)
       (setf quest-name (car q-item-var-list)
             quest-label (second q-item-var-list)
             quest-instr-list (fifth q-item-var-list)
             quest-title (first quest-instr-list)
             quest-instr (second  quest-instr-list)
             quest-type (sixth quest-instr-list))
       (cond
        ((listp q-instr-list)
         (setf q-title (first (second  q-instr-list))
               q-instr (second  (second  q-instr-list))
            quest-text (third q-instr-list)))
        ;;unless the q-instr text is specified, use default
        (t (setf quest-title "INSTRUCTIONS: Select ALL that apply to you."
           quest-instr ("Finish this SSS"))))
       ;;end n = 1
       )
      ((listp q-item-var-list)
       (setf q-item-str (first q-item-var-list)
             q-item-sym (my-make-cs-symbol q-item-str)
             q-item-label (second q-item-var-list)
             q-text-list (fourth qvarlist))

       ;;appending the list to pass to the check-button-panel for items text
       (setf q-item-text-list (append q-item-text-list (list (car q-text-list))))
       )
       (t (setf q-text-list '("NO MULTI-QUESTION INFORMATION FOUND"))))

     #|      (setf q-instr-list (get-key-value-in-nested-lists 
                          (list (list category 0) (list q-instr-sym 0))
                          *ALL-CSQ-QUESTIONS :return-list-p T))|#

     ;;end loop      
     )
       (values q-text-sym q-text-list q-title q-instr)  
      ;;end get-question-text
      ))|#





;;xxx      ------------------   TEST DATA -------------------------
;;example date:
#|(setf  *test-quests1 
  '((STRING-VARS
     "RealPeopleSex.java"
     (RPESATISFIEDRELQ "Overall, I am extremely satisfied with my relationship with my partner.")
     (RPEFU "My partner and I have have fun together:")
     (RPEARGUEQ "My partner and I have arguments for at least several minutes:")
     )
    (STRING-VARS
     "RealPeople.java"
     (RPECOMMITQ "Degree of commitment to an intimate(romantic) relationship (lasting at least 3 months)")
     (RPEHAPFRIENDSQ "Almost all of my good friends are very successful and happy in almost every area of their lives including school and interpersonal relationships.")
     (RPEHMARRQ "I have (or have had) a very happy marital -- or marital-like relationship with someone for an extended period of time.")
     (RPENETWQ "I have developed an extensive, close network of friends and career-related persons with whom I share support and information.")
     (RPECLFR "In my life I have had a number of extremely close friends with whom I could discuss my innermost secrets, weaknesses, and problems.")
     (RPECLFAMQ "I feel extremely close with the members of the family I grew up in.")
     (RPENUMFRIENDSQ "Approximate number of friends in general with whom you interact socially -- outside of work or school settings--at least once a month.")
     (RPENUMCLOSEFRIENDSQ "Approximate number of EXTREMELY CLOSE friendships with which you are VERY SATISFIED."))))
|#


;;xxx ---------------------- CONVERSION FUNCTION (No longer needed?) ----------

#|  WORKS,  QUOTED OFF BECAUSE DON'T NEED IT ANYMORE??
;;CONVERT-JAVA-TO-SPSS-QUEST-NAMES
;;
;;ddd
(defun convert-java-to-spss-quest-names (&key (all-qvarlists *shaq-question-variable-lists))
  "In U-CS (inSHAQ U-data-functions), A TEMP FUNCTION USED TO CHANGE THE NAMES IN THE LIST OF QUESTION  FROM THE OLD JAVA NAMES TO THE NEW SPSS NAMES"
  (let
      ((old-q-sym)
       (new-q-sym)
       (q-string)
       (new-qlist)
       (cat-sym)
       (new-cat-list)
       (new-shaq-quest-list)
       )
    (loop
     for cat-list in all-qvarlists
     with cat-sym
     do
     (setf cat-sym (first cat-list)
           cat-list (cdr cat-list)
           new-cat-list (list cat-sym))
     (loop
      for sl-list in cat-list
      with qvar
      with sublist
      with q-name
      with q-list
      with q-strings
      with new-q-sym
      do
      (cond
       ((listp sl-list)
        (setf qvar (first sl-list)
              sublist (fifth sl-list))
        (cond
         ((listp sublist)
          (setf q-name (third sublist))
       ;;  (afout 'out (format nil "q-name= ~A~% (list '(T 0)(list q-name 0))= ~A~%" q-name (list '(T 0)(list q-name 0))))
      ;; (afout 'out (format nil "q-name= ~A~%sl-list= ~A~%" q-name sl-list))
         (multiple-value-setq (q-list q-name)
               (get-key-value-in-nested-lists 
                (list '(T 0)(list q-name 0)) *ALL-CSQ-QUESTIONS :return-list-p t))     
         (setf new-q-sym (my-make-cs-symbol (format nil "~AQ" qvar)))
       ;;  (afout 'out (format nil "q-strings= ~A~%" q-strings))
         )
        (t nil)))
       (t nil))     
      (cond
       (q-list
        (setf  q-strings (cdr q-list)
               new-qlist (list  new-q-sym q-strings q-name)
               new-cat-list (append new-cat-list (list new-qlist))))
       (t (setf new-q-sym (my-make-cs-symbol (format nil "~AQ" qvar))
                new-qlist (list  new-q-sym 'NO-QUEST-STRING-FOUND)
                new-cat-list (append new-cat-list (list new-qlist)))))
        ;;end inner loop
        )
       (setf new-shaq-quest-list (append new-shaq-quest-list (list new-cat-list)))
       ;;end outer loop
       )
      ;;end
      new-shaq-quest-list
      ))
|#
;;test
;; SSS START TESTING HERE--TO RENAME QUESTS
#|  (defun print-new-shaq-questions ()
    (let
       ((new-shaq-qlist)
        )
      (setf new-shaq-qlist (convert-java-to-spss-quest-names))
      (print-nested-list new-shaq-qlist :stream t :incl-quotes-p t)
      ))|#
;; (print-new-shaq-questions)


;;  
;; (get-key-value-in-nested-lists (list '(T 0)(list 'smtExercizeQ 1)) *ALL-CSQ-QUESTIONS)


;;CALC-IS-QUEST-REVERSE-SCORED
;;
;;ddd
(defun calc-is-quest-reversed  (qvar &key answer-array)
  "In U-data-functions. Checks the scoring array Eg. LikeMe7Reverse vs LikeMe7 to see if question is reverse or normall scored.  Returns (values reversed-item-p item-norm-or-rev) REVERSED-ITEM  if finds word reverse in the name. item-norm-or-rev = NORMAL-ITEM if not reversed/  NOTE: answer-array can be a symbol. "
  (let*
      ((reversed-item-p )
       (item-norm-or-rev 'NORMAL-ITEM)
       )
    ;;modified 2019 to fix list error
    (unless answer-array
      (let  ((ansrs (fifth (fifth (get-qvarlist qvar)))))
        (when (listp ansrs)
          (setf answer-array ansrs))))

    (when (stringp answer-array)
      (setf answer-array (my-make-symbol answer-array)))

    (when (symbolp answer-array)
      (setf answer-array (format nil "~A" answer-array)))

    ;;see if answer-array contains word "reverse"
    (when (search "reverse" answer-array :test 'char-equal)
      (setf reversed-item-p 'REVERSED-ITEM
            item-norm-or-rev 'REVERSED-ITEM))

            item-norm-or-rev 
    ;;return result NIL or REVERSED-ITEM
    (values reversed-item-p item-norm-or-rev)
    ))
;;TEST
;;  (calc-is-quest-reversed 'TBVWEAK)  works = REVERSED-ITEM
;;  (calc-is-quest-reversed 'THM10OTH)  works = nil
;;  (calc-is-quest-reversed 'COPBLAME)  works = REVERSED-ITEM
;;  (calc-is-quest-reversed 'COPBLAME :answer-array "PerCent6CopeReverse") = REVERSED-ITEM
;;  (calc-is-quest-reversed nil :answer-array 'FREQ7REVERSE) = REVERSED-ITEM
;; (calc-is-quest-reversed nil :answer-array 'FREQ7) = NIL
    




;;GET-ELMSYMVAL-LISTS
;;
;;ddd
(defun get-elmsymval-lists (&key (elmsyms *all-elmsyms))
  "In U-CS, RETURNS (values elmsymval-lists elmsyms n-elmsyms).  Gets all elmsyms from *csq-elmsym-lists unless elmsyms. Note: *all-elmsyms includes all elmsyms, while  *all-elmsym-lists contains only those with names."
  (let
      ((elmsym-lists)
       (elmsym-names)
       (elmsymval-list)
       (elmsymval-lists)
       (n-elmsyms)
       )
    
      ;;(break "2")
      (loop
       for elmsym in elmsyms
       do
       (unless (symbolp elmsym)
         (setf elmsym (my-make-cs-symbol elmsym)))

       (when (and (symbolp elmsym)(boundp elmsym))
         (setf elmsymval-list (eval elmsym)
               elmsymval-lists (append elmsymval-lists (list elmsymval-list)))
                                       ;;was (list (list elmsym  elmsymval-list))))
         ;;(break "3")
         (setf n-elmsyms (list-length elmsyms))
         ;;end when
         )
       ;;end loop
       )

    (values elmsymval-lists elmsyms n-elmsyms)
    ;;end let, get-elmsymvals
    ))
;;TEST
;;  (get-elmsymval-lists)
;; works=     REDO    (MOTHER FATHER BEST-M-FRIEND BEST-F-FRIEND)    4



;;MAKE-EVALED-SYM-LISTS
;;2020
;;ddd
(defun make-evaled-sym-lists (symbols &key )
 "In U-CS, RETURNS: A "
 (let
     ((all-syms)
      (all-symval-lists)      
      )
   (loop
    for item in symbols
    do
    (let*
        ((sym  (my-make-cs-symbol item))
         (symvals)
         )
    (when (and (symbolp sym)(boundp sym))
          (setf symvals (eval sym)
                all-syms (append all-syms (list sym))
                all-symval-lists (append all-symval-lists (list (list sym symvals)))))
    ;;end let, loop
    ))
   (values all-symval-lists all-syms)
   ;;end let, make-evaled-sym-lists
     ))
;;TEST
;; (make-evaled-sym-lists *all-stored-sys-csyms) 
;; (make-evaled-sym-lists  '(<SSREHAPSUCFRS <BIO <ACAD-ACH <BIO3EDUC <BIOHSGPA <BIOCOLLE  <BIORELAF <STU-DATA <STUAPT <STUFEEL <STUACMOTIV <STU-LRN <USERID <SEX <AGE <NATION <ZIPCODE <HRSWORK))
;;works= ((<SSREHAPSUCFRS ("<SSREHAPSUCFRS" UNBOUND-SLOT $PEOP.<SRPEOPLE.<SSREHAPSUCFRS NIL "Life Outcomes: Emotional, Relationship, Career, Academic" :QT :SCALE :S (<RPEHMARR <RPECOMMI) :CSS (ASSESSMENT PER-SYSTEM) :VA 1.0 :SD 2.5)) (<BIO ("<BIO" UNBOUND-SLOT (:S (<ACAD-ACH <NO-SCALE)) NIL "Biographical informaton" :QT :SCALE :CSS (ASSESSMENT PER-SYSTEM) :VA UNBOUND-SLOT)) (<ACAD-ACH ("<ACAD-ACH" UNBOUND-SLOT $LRN NIL "Biographical informaton" :QT :SCALE :S (<BIO3EDUC <BIOHSGPA <BIOCOLLE) :CSS (ASSESSMENT PER-SYSTEM) :VA 0.9523334 :SD 2.4944382)) (<BIO3EDUC ("<BIO3EDUC" NIL $BIO.BIO3EDUC.<BIO3EDUC (1 1) "" :QT :QVAR :CSS $BIO.BIO3EDUC :VA 1.0)) (<BIOHSGPA ("<BIOHSGPA" NIL $LRN.BIOHSGPA.<BIOHSGPA (1 1) "" :QT :QVAR :CSS $LRN.BIOHSGPA :VA 1.0)) (<BIOCOLLE ("<BIOCOLLE" NIL $LRN.BIOCOLLE.<BIOCOLLE (1 1) "" :QT :QVAR :CSS $LRN.BIOCOLLE :VA 0.85700006)) (<BIORELAF ("<BIORELAF" NIL $BIO.BIORELAF.<BIORELAF (1 1) "" :QT :QVAR :CSS $BIO.BIORELAF)) (<STU-DATA ("<STU-DATA" NIL $ACAD.STU-DATA.<STU-DATA (1 1) "" :QT :QVAR :CSS $ACAD.STU-DATA)) (<STUAPT ("<STUAPT" NIL $ACAD.STUAPT.<STUAPT (1 1) "" :QT :QVAR :CSS $ACAD.STUAPT)) (<STUFEEL ("<STUFEEL" NIL $ACAD.STUFEEL.<STUFEEL (1 1) "" :QT :QVAR :CSS $ACAD.STUFEEL)) (<STUACMOTIV ("<STUACMOTIV" NIL $ACAD.STUACMOTIV.<STUACMOTIV (1 1) "" :QT :QVAR :CSS $ACAD.STUACMOTIV)) (<STU-LRN ("<STU-LRN" NIL $ACAD.STU-LRN.<STU-LRN (1 1) "" :QT :QVAR :CSS $ACAD.STU-LRN)) (<USERID ("<UserID" "User ID" $CS.<USERID :VAL "555555" :CSS $CS)) (<SEX ("<Sex" "Sec" $CS.<SEX :VAL "Male" :CSS $CS)) (<AGE ("<Age" "Age" $CS.<AGE :VAL 78 :CSS $CS)) (<NATION ("<Nation" "Nation" $CS.<NATION :VAL "USA" :CSS $CS)) (<ZIPCODE ("<ZipCode" "ZipCode" $CS.<ZIPCODE :VAL 92260 :CSS $CS)) (<HRSWORK ("<HrsWork" "HrsWork" $CS.<HRSWORK :VAL 78 :CSS $CS)))
;; (<SSREHAPSUCFRS <BIO <ACAD-ACH <BIO3EDUC <BIOHSGPA <BIOCOLLE <BIORELAF <STU-DATA <STUAPT <STUFEEL <STUACMOTIV <STU-LRN <USERID <SEX <AGE <NATION <ZIPCODE <HRSWORK)



;;MAKE-PCSYMVAL-LISTS
;;
;;ddd
(defun make-pcsymval-lists (&key (all-datalists *csq-data-list))
 "In U-CS, makes a list of all (pcsym (pcsymvals) -- USED FOR SAVING TO A FILE. RETURNS (values all-pcsymval-lists all-pcsyms)."
 (let
     ((pcsym)
      (all-pcsyms)
      (pcsymvals)
      (all-pcsymval-lists)
      (pcsym-datalists (get-keyvalue-in-nested-list '((:PCSYM-ELM-LISTS T)) all-datalists))
      )
   (loop
    for pcsymdata in pcsym-datalists
    do
    (setf pcsym (car pcsymdata))
    (when (and (symbolp pcsym)(boundp pcsym))
          (setf pcsymvals (eval pcsym)
                all-pcsyms (append all-pcsyms (list pcsym))
                all-pcsymval-lists (append all-pcsymval-lists (list (list pcsym pcsymvals)))))
    ;;end loop
    )
   (values all-pcsymval-lists all-pcsyms)
   ;;end let, get-pcsymval-lists
     ))
;;TEST
;;  (make-pcsymval-lists)





;;GETSYMVALS
;;2019
;;ddd
(defun getsymvals (object &key if-not-exist-set-p set-to-val)
  "U-CS CHECKS IF EXIST, THEN RETURNS (EVAL SYM): (values symvals boundp sym symstr).   IF-NOT-EXIST-SET-P sets to set-to-val; otherwise leaves unbound."
  (let*
      ((sym)
       (symstr)
       (symvals)
       (boundp)
       )
    (cond 
     ((symbolp object) 
      (setf sym object
            symstr (format nil "~A" object)))
     ((stringp object) 
      (setf sym (my-make-symbol object)
            symstr object))
     (t nil))
    (cond
     ((boundp sym)
      (setf boundp T
            symvals (eval sym)))
     (if-not-exist-set-p
      (setf symvals set-to-val
            boundp T)
      (set sym symvals))            
     ;;otherwise, leave unbound
     (t nil))
    (values symvals boundp sym symstr)            
  ;;end let, getsymvals
  ))
;;TEST
;; (getsymvals 'testsym1) = NIL  NIL  TESTSYM1  "TESTSYM1"
;; (getsymvals 'testsym1 :if-not-exist-set-p T :set-to-val '(new value list))
;; works = (NEW VALUE LIST)  T TESTSYM1  "TESTSYM1"
;; after set above, repeat
;; ;; (getsymvals 'testsym1 :if-not-exist-set-p T :set-to-val '(new value list 2))
;; works (gets old value)  (NEW VALUE LIST)  T  TESTSYM1  "TESTSYM1"






;;GETCSYMVALS
;;for return CSYMVALS using only an ARTSYM
;;ddd
(defun getcsymvals (csartsym &optional dims &key (dataval-nth 0))
  "In U-CS, RETURNS CSYMVALS From an CSARTSYM (network node sym) RETURNS (values CSYMvals CSdata CSYM nth-dataval) of the associated CSYM (located as the CSartsym value). If dataval-nth, returns nth-dataval. "
  (let
      ((CSYM)
       (CSYMvals)
       (CSdata)
       (CSYMstr)
       (nth-dataval)
       )
    (setf CSYM (getsymval CSartsym))

    ;;GET CSYMVALS
    (cond
     ((boundp CSYM)
        (setf CSYMvals (eval CSYM)      
              CSdata (fourth CSYMvals)))
     (t (setf CSYM nil)))

    (when (and dataval-nth (listp CSdata))
      (setf nth-dataval (nth dataval-nth CSdata)))

    (values CSYMvals CSdata CSYM nth-dataval)
    ;;end let, getCSYMvals
    ))
;;TEST
;; (getCSYMvals 'CS2-11-1-1)
;; = ("CSTSTSYM" "CS test sym" CS2-11-1-1 (4 "data") "test definition" :INFO "more info")   (4 "data")  CSTSTSYM 4
    




;;SETCSYMVAL
;;
;;ddd
(defun  setcsymval (sym value ;;not used &optional dims 
                        &key (data-only-p T) 
                              all-symvals-p (nth-value 3) csdata-nth 
                              set-csdata-key-value set-cs-key-value 
                              append-setkey-as-list-p)
  "U-CS, takes a csartsym and sets whatever  csym as its value. then sets the CS data-value to either value (if data-only-p) OR if all-symvals-p, sets the ENTIRE CSYMVALS to value.  BOTH ARTSYM and CSYM assume that 'VALUE is the 4th ITEM in its symvalist.
  :NTH-VALUE, sets the nth CSYM symvalist item to value [Default is for ARTSYMs, value  = 4th for its CSYM, so will work with ART].
  :CSDATA-NTH, changes 4th item in CSYM VALUE list.  If :CSDATA-
  :SET-CSDATA-KEY-VALUE is a key eg. :PC.  and changes csdata list containing key to key value (or appends it if not).  (Does NOT affect any other values). NOTE: CSDATA IS 4th item in the csymvals (which is 4th in csartsym). 
   :SET-CS-KEY-VALUE sets or appends value to key in main cssymvals list (eg. :info).  RETURNS (values new-csymvals csym old-value old-keyval new-csdata). 
   SYM can be an artsym or csym, but must be bound."
  (let*
      ((symlist (eval sym))
       (dims? (second symlist))
       (dims (when (and (listp dims?)(numberp (car dims?))) dims?))
       (artsym)
       (csym)
       (csymvals)
       (csdata)
       (orig-csdata)
       (otherval)
       (new-csdata)
       (new-csymvals)
       (old-value)
       (setkey)
       (keyvalue)
       (key&data)
       (keyfound)
       (old-keyval)
       ) 

    ;;GET CS SYM, SYMVALS, AND DATA
    ;;2019 Is sym an artsym or csym?
    ;;Get csym--artsym not needed
    (cond
     (dims 
      (setf csym (getsymval sym)))
     ;;artsym not needed
     (t (setf csym sym)))
    ;;get csymvals
    (when (boundp csym)
          (setf csymvals (eval csym)
                csdata (fourth csymvals)))
    (cond
    ;;SET-CSDATA-KEY-VALUE (new) sets a key value in CSDATA list
     ((and set-csdata-key-value (symbolp set-csdata-key-value))
      (setf setkey set-csdata-key-value
            keyvalue value
            orig-csdata csdata)
      (multiple-value-setq (new-csdata keyfound old-keyval)
             (set-key-value setkey keyvalue csdata))
      (multiple-value-setq (new-csymvals old-value)
          (replace-nth csymvals 3 new-csdata)))
     ;;SET-CS-KEY-VALUE  for CSYMVALS
     ((and set-cs-key-value (symbolp set-cs-key-value))
      (setf setkey set-cs-key-value
            keyvalue value)
      (multiple-value-setq (new-csymvals keyfound old-keyval)
         (set-key-value setkey keyvalue csymvals
                        :append-as-keylist-p append-setkey-as-list-p
                        :append-as-flatlist-p (not append-setkey-as-list-p) )))
      ;;SET CSDATA-NTH
     (csdata-nth
      (setf new-csdata (replace-nth csdata csdata-nth value))
      (multiple-value-setq (new-csymvals old-value)
          (replace-nth csymvals 3 new-csdata)))
     ;;SET NTH-VALUE
     (nth-value
      (multiple-value-setq (new-csymvals old-value)
          (replace-nth csymvals nth-value  value)))
     ;;SET ENTIRE CSYMVALS
     (all-symvals-p
      (setf new-csymvals value
            old-value csymvals))
     ;;SET CSYM DATA ONLY 
     (data-only-p
      (setf new-csdata value)
      (multiple-value-setq (new-csymvals old-value)
          (replace-nth csymvals 3 value)))
     (t nil))

    ;;SET the CSYM to new-csymvals
    (when csym
      (set csym new-csymvals))
    (values new-csymvals csym old-value old-keyval new-csdata)
    ;;end let, setcsymval
    ))
;;TEST
;;NOTE: These egs use an ARTSYM, but now a CSYM could be used instead.
;; first (make-csym 'csmysym "cs test sym" 'cs3-11-1-1  '(4 "data"  :key1 (a b c)) "test definition" :system '$TOPBV :info "more info")
;;works=  ("CSMYSYM" "cs test sym" CS3-11-1-1 (4 "data" :KEY1 (A B C)) "test definition" :SYSTEM $TOPBV :INFO "more info")   CSMYSYM
;;ALSO CSMYSYM  =>  ("CSMYSYM" "cs test sym" CS3-11-1-1 (4 "data" :KEY1 (A B C)) "test definition" :SYSTEM $TOPBV :INFO "more info")
;;  CS3-11-1-1  => ("CS" (3 11 1 1) NIL CSMYSYM NIL)
;; CHANGE CSYM VALUE [4th csym item]; here (a list of data with a new list of data)
;;  (setcsymval 'cs3-11-1-1 '(6 "more newdata" :key1 (c d e)))
;; works= ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :SYSTEM $TOPBV :INFO "more info")    CSMYSYM   (4 "data" :KEY1 (A B C))     NIL    (6 "more newdata" :KEY1 (C D E))
;;ALSO:  CSMYSYM =>  ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :SYSTEM $TOPBV :INFO "more info")
;;ALSO [unchanged]:  CS3-11-1-1 => ("CS" (3 11 1 1) NIL CSMYSYM NIL)

;; CHANGE CSYM VALUE DATALIST NTH with :CSDATA-NTH = 4 (appends because is no nth= 2)
;;  (setcsymval 'cs3-11-1-1  "newdata nth=4"   :CSDATA-NTH 4 )
;;  works= ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E) "newdata nth=4") "test definition" :INFO "more info")   CSMYSYM  (6 "more newdata" :KEY1 (C D E))   NIL    (6 "more newdata" :KEY1 (C D E) "newdata nth=4")
;; CSMYSYM [datalist last item added]=>  ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E) "newdata nth=4") "test definition" :SYSTEM $TOPBV :INFO "more info")
;; CS3-11-1-1 [unchanged] = > ("CS" (3 11 1 1) NIL CSMYSYM NIL)
;;
;;  :CSDATA-NTH = 1
;; (setCSYMval 'CS3-11-1-1  "newdata nth=1"   :CSDATA-NTH 1 )
;; works [changes csym datalist item at n = 1]= ("CSMYSYM" "CS test sym" CS3-11-1-1 (6 "newdata nth=1" "newdata nth=2") "test definition" :INFO "more info")   CSMYSYM   (6 "newdata" "newdata nth=2")
;;also  CSMYSYM  =  ("CSMYSYM" "CS test sym" CS3-11-1-1 (6 "newdata nth=1" "newdata nth=2") "test definition" :INFO "more info")
;;
;; CHANGE NTH-VALUE = 1 in the CSYM symvalslist [not in its value datalist]
;; (setcsymval 'CS3-11-1-1 "NEW N-1 VALUE"      :nth-value 1)
;; ("CSMYSYM" "NEW N-1 VALUE" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E) "newdata nth=4") "test definition" :SYSTEM $TOPBV :INFO "more info")   CSMYSYM   "CSMYSUM"  NIL  NIL
;; CSMYSYM => ("CSMYSYM" "NEW N-1 VALUE" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E) "newdata nth=4") "test definition" :SYSTEM $TOPBV :INFO "more info")
;;
;; :SET-CSDATA-KEY-VALUE
;; *ADD* KEY VALUE TO CSYM VALUE DATALIST [not to larger symvalist]
;; (setcsymval 'CS3-11-1-1 '(new-key-value)  :SET-CSDATA-KEY-VALUE :key1)
;; works [adds inside value datalist] = ("CSMYSYM" "NEW N-1 VALUE" CS3-11-1-1 (6 "more newdata" :KEY1 (NEW-KEY-VALUE) "newdata nth=4") "test definition" :SYSTEM $TOPBV :INFO "more info")    CSMYSYM    (6 "more newdata" :KEY1 (C D E) "newdata nth=4")   (C D E)    (6 "more newdata" :KEY1 (NEW-KEY-VALUE) "newdata nth=4")

;; *CHANGE* KEY VALUE IN CSYM VALUE DATALIST
;; (setcsymval 'CS3-11-1-1 '(new-key-value2)  :SET-CSDATA-KEY-VALUE :key1)
;; works [changes csym value datalist :key1 value] = ("CSMYSYM" "NEW N-1 VALUE" CS3-11-1-1 (6 "more newdata" :KEY1 (NEW-KEY-VALUE2) "newdata nth=4") "test definition" :SYSTEM $TOPBV :INFO "more info")    CSMYSYM   (6 "more newdata" :KEY1 (NEW-KEY-VALUE) "newdata nth=4")   (NEW-KEY-VALUE)   (6 "more newdata" :KEY1 (NEW-KEY-VALUE2) "newdata nth=4")
;; CSMYSYM =>  ("CSMYSYM" "NEW N-1 VALUE" CS3-11-1-1 (6 "more newdata" :KEY1 (NEW-KEY-VALUE2) "newdata nth=4") "test definition" :SYSTEM $TOPBV :INFO "more info")
;;
;;SET-CS-KEY-VALUE  Changes key value in larger CSYM symvalist
;; (setcsymval 'CS3-11-1-1 "NEW INFO SET"  :SET-CS-KEY-VALUE :INFO)
;; works = ("CSMYSYM" "NEW N-1 VALUE" CS3-11-1-1 (6 "more newdata" :KEY1 (NEW-KEY-VALUE2) "newdata nth=4") "test definition" :SYSTEM $TOPBV :INFO "NEW INFO SET")   CSMYSYM    NIL  "more info"  NIL
;;
;;APPEND NEW CS-KEY-VALUE in larger CSYM symvalist
;; (setcsymval 'CS3-11-1-1 "APPENDED KEY VALUE"  :set-cs-key-value  :newkey)
;; works= ("CSMYSYM" "NEW N-1 VALUE" CS3-11-1-1 (6 "more newdata" :KEY1 (NEW-KEY-VALUE2) "newdata nth=4") "test definition" :SYSTEM $TOPBV :INFO "NEW INFO SET" :NEWKEY "APPENDED KEY VALUE")   CSMYSYM   NIL  NIL  NIL
;;ALSO:  CSMYSYM => ("CSMYSYM" "NEW N-1 VALUE" CS3-11-1-1 (6 "more newdata" :KEY1 (NEW-KEY-VALUE2) "newdata nth=4") "test definition" :SYSTEM $TOPBV :INFO "NEW INFO SET" :NEWKEY "APPENDED KEY VALUE")
;;USE OF CSYM for SYM
;;  (setcsymval 'CSMYSYM  '(APPENDED KEY VALUE 2)  :set-cs-key-value  :newkey2)
;;works= ("CSMYSYM" "NEW N-1 VALUE" CS3-11-1-1 (6 "more newdata" :KEY1 (NEW-KEY-VALUE2) "newdata nth=4") "test definition" :SYSTEM $TOPBV :INFO "NEW INFO SET" :NEWKEY "APPENDED KEY VALUE" :NEWKEY2 (APPENDED KEY VALUE 2))  CSMYSYM  NIL NIL NIL





;;GET-SYMKEYVAL
;;2019
;;ddd
(defun get-symkeyval (sym key  &key  spec-lists (val-nth 1))
  "In U-CS,  RETURNS (values newsymval-list  new-keylist old-value old-keylist )   INPUT:  "
  (let
      ((oldsymlist (eval sym))
       )
    (unless spec-lists
      (setf spec-lists (list (list key T val-nth))))

    (multiple-value-bind (return-keylist newsymval-list   new-keylist return-value    
              keylist)
          (get-set-append-delete-keyvalue-in-nested-list :GET spec-lists oldsymlist)
     
    (values return-value (list key return-value)  oldsymlist)
    ;;end mvb,let, get-symkeyval
    )))
;;TEST
;; (get-symkeyval 'PRACTICAL :XYLOC)
;; works= (0 2)     (:XYLOC (0 2))     ("PRACTICAL" "PRACTICAL vs NOT PRACTICAL" CS2-1-1-99 NIL NIL :PC ("PRACTICAL" "NOT PRACTICAL" 1 NIL) :POLE1 "PRACTICAL" :POLE2 "NOT PRACTICAL" :BESTPOLE 1 (:BIPATH ((POLE1 NIL FARMER NIL) (POLE1 NIL ANGLOS NIL) (POLE2 NIL SALESPERSON NIL))) :va "0.833" :RNK 7.5 :XY-N (2 2) :XYLOC (0 2))




;;SET-SYMKEYVAL
;;2018
;;ddd
(defun set-symkeyval (sym key value  &key  spec-lists (val-nth 1)
                          append-value-p  add-value-p  splice-newvalue-at-nth-p )
  "In U-CS,  RETURNS (values newsymval-list  new-keylist old-value old-keylist )   INPUT:  "
  (let
      ((oldsymlist (eval sym))
       )
    (unless spec-lists
      (setf spec-lists (list (list key T val-nth))))

    (multiple-value-bind (return-keylist newsymval-list   new-keylist return-value    
              old-keylist last-key-found-p old-value) 
          (get-set-append-delete-keyvalue-in-nested-list value spec-lists oldsymlist
                  :append-value-p append-value-p      :add-value-p add-value-p
                  :splice-newvalue-at-nth-p  splice-newvalue-at-nth-p)
      
    ;;reset the sym
    (set sym newsymval-list)

    (values newsymval-list  new-keylist old-value old-keylist )
    ;;end mvb,let, SET-SYMKEYVAL
    )))
;;TEST
;; 1. FIRST MAKE A CSYM
;;  (make-csym 'csmysym "cs test sym" 'cs3-11-1-1  '(4 "data"  :key1 (a b c)) "test definition" :info "more info")
;;= ("CSMYSYM" "cs test sym" CS3-11-1-1 (4 "data" :KEY1 (A B C)) "test definition" :INFO "more info")
;; cs3-11-1-1 = ("CS" (3 11 1 1) NIL CSMYSYM NIL)
;; CSMYSYM  = ("CSMYSYM" "cs test sym" CS3-11-1-1 (4 "data" :KEY1 (A B C)) "test definition" :INFO "more info")
;; 2. ADD NEW KEY AND VALUE
;; (set-symkeyval 'CSMYSYM :NEWKEY 'NEWVAL)
;; works= ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :INFO "more info" :NEWKEY NEWVAL)   (:NEWKEY NEWVAL)   NIL  NIL
;; 3. REPLACE THE VALUE
;; (set-symkeyval 'CSMYSYM :NEWKEY 'NEWVAL2)
;; works= ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :INFO "more info" :NEWKEY NEWVAL2)    ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :INFO "more info" :NEWKEY NEWVAL2)   NEWVAL   ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :INFO "more info" :NEWKEY NEWVAL)
;; 4. APPEND THE VALUE
;; (set-symkeyval 'CSMYSYM :NEWKEY 'NEWVAL3 :APPEND-VALUE-P T)
;; works= ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :INFO "more info" :NEWKEY (NEWVAL2 NEWVAL3))     ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :INFO "more info" :NEWKEY (NEWVAL2 NEWVAL3))NEWVAL2   ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :INFO "more info" :NEWKEY NEWVAL2)   
;; 5. ADD-VALUE-P 
;; (set-symkeyval 'CSMYSYM :NEWKEY 'NEWVAL4 :ADD-VALUE-P T)
;; works = ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :INFO "more info" :NEWKEY (NEWVAL2 NEWVAL3) NEWVAL4)   ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :INFO "more info" :NEWKEY (NEWVAL2 NEWVAL3) NEWVAL4)   (NEWVAL2 NEWVAL3)   ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :INFO "more info" :NEWKEY (NEWVAL2 NEWVAL3))





;;MAKE-CSYM
;;modified 2018-08,2019-10;2020-08
;;ddd
(defun make-csym (csym csphrase  csdata  csdef  
                       &key  (if-csym-exists :modify-csartloc)
                       prestr poststr csname ;;csname here to avoid scope problem
                       ;;options :set-only-csartloc&supsys :replace :replace-non-csartloc
                       ;;     :modify-only-csartloc
                       ;;csartloc-related args
                       (csartloc-origin :supsys-csartloc) 
                       topdim  dims  supsys (def-supsys '$MIS) parents
                       (last-dim :csym) supsys-csartloc
                       new-csartloc (make-new-csartloc-p T) new-csartloc-vals
                       (update-supsys-sublist-p T)  
                       csartloc-n3-item  csartloc-rest-vals                          
                       (supsys-key *supsyskey)  sublist (sublist-key *sublistkey) ;;CSS  S
                       linktype (linktype-key *linktypekey) ;;LNTP
                       value1 value2  sd ;;stand-deviation
                       (valuekey1 *csvalkey)  (valuekey2 *csval2key) ;;VA VA2
                       revscoredp (revscorekey *revscorekey) 
                       valrank (valrankey *csval-rank-key) ;;RNK 
                       (sdkey *sdkey) ;;SD
                       ans-data-list (ans-data-key *multivalkey) ;;ADAT
                       (txtinputkey *txtinputkey) text-input  ;;TXT
                       (qtype-key *qtypekey) qtype change-csloc-p  ;;QT                       
                       cs-categories  info   system (systemkey *csyskey)
                       BIPATH pole1 pole2 bestpole rev-poles-p (revpoleskey *revpoleskey) ;;
                       to from wto wfrom clev  (clevkey *clevkey)  ;;CLEV
                       pclist  restkeys (no-nil-restkeys-p T)                       
                       ;;not used (default-csart-rootstr *default-csart-rootstr)
                       ;;IN 3RD ARG csartloc ;;For a csartloc sym or csartdims
                       (dim-separator *art-index-separator)
                       (node-separator *art-node-separator)
                       store-all-csyms-to-file-p ;;using-dated-files by default
                       (all-stored-csyms-file *all-stored-csyms-file)
                       (all-stored-csartlocs-file *all-stored-csartlocs-file)
                       ;;used only when store-all-csyms-to-file-p
                       (all-stored-csyms-listsym '*ALL-STORED-CSYMS) 
                       ;;MAIN ACCUM LIST--ONLY APPENDED HERE!!
                       (all-csyms-sym '*ALL-MAKE-CSYMS)
                       ;;csartloc accumulate syms
                       (all-csartloc-syms-sym '*ALL-MAKE-CSARTLOC-SYMS)
                       append-all-syms&vals-p ;;big list--eval all csyms later
                       ;;only used when append-all-syms&vals-p
                       (all-csartloc-syms&vals-sym '*ALL-CSARTLOC-SYMS&VALS)
                       ;;was *ALL-STORED-SYS-CSYMS
                       ;;special (temp?) for adding tlink csyms
                       (tlink-artlocsym '*new-tlink-artloc)
                       )
  "U-CS, csym (sym or string).  makes NEW CSYM [a cs name sym] set to a CSYMVALS = (CSNAME  CSPHRASE CSARTLOC CSDATA  CSDEF KEYWORDS ). KEYWORDS are :info, :system, :pc,  and :path set to lists. also sets the value (4th of symvals) of csartloc sym (created if not exist) to csym. ALSO makes new CSARTSYM [made from cs-art-loc] set to a list Eg (\"CS\" (3 11 1 1) CSTESTSYM  'ART-DATALIST)
   Note: *ALL-CSYMS is ONLY appended in make-csym!
  NEW for CSARTLOC: Multi-level-csartloc = topdim + dims + supsys + csym (If last-dim=:csym ) Any nils are omitted.  If last-dim = a sym, it is used.  
   If ONLY DIMS (last-dim = nil), makes new csartsym = dims.
  RETURNS (values csymvals csym csartloc-sym csartloc-vals supsys supsys-vals ).  Note1: Can set or get CSdata with setsymval or getsymval functions. pclist = (pole1 pole2 value) causes csphrase to be sritten as pole1 vs pole2 and a list with both poles written after keyword :pc. :CLEV is cstree supord level.  CHANGED? pre+dims eg (CS 3 L 2 M HS)
  NAMED KEYS include :INFO, :BIPATH, etc  Both named-keys and restkeys' valulues are APPENDED TO ANY EXISTING values (unless :do-nothing or :replace). SUPSYS (key :css) is the main cs subsystem where it is placed as an element.
  SOURCE/TYPE (key :ty): One of *CSYM-SOURCE-TYPES = '(:SYS :SCALE :SSCALE :QV :ELM :PC :LNK).
  RESTKEYS allows a list of keylists eg. ((key1 value1)(key2 value2) etc). Should be a standard key such as :to :from :wto :wfrom NOTE:  :SUBITEM standard key is useful to put INSIDE a value-list for any other key (eg. :BIPATH '(\"MOTHER\" NIL    :SUBITEM \"Jane Doe\")).  When store-all-csyms-to-file-p,  appends new csyms to *ALL-STORED-CSYMS, but takes much time & makes huge files. Functions calling make-csym should store batch lists of csyms by type in files.
   IF-CSYM-EXISTS either  :do-nothing :replace :modify (with KEY VALUES ONLY) :replace-non-csartloc  :modify-csartloc
   CSARTLOCs:  :CSARTLOC-ORIGIN can be :new-csartloc (becomes new)  :supsys-csym, :topdim-dims (incls non-nils for topdim, dims,supsys,csym), :supsys-csartloc (adds csym to supsys csartloc), :scale-class,  :supsys-only,  :parents (unfinished).
  GLOBAL-VARS SET: *ALL-CSARTLOC-SYMS
 "
  ;;NOTE: Don't get confused about CSYM vs CSARTSYM.  
  ;;   CSYM = (list csname  csphrase CSARTLOC=CSARTSYM csdata  csdef  & KEYS :S, :CSS, etc.)
  ;;   CSARTSYM is the csym-loc symbol that evals to eg. ("CS.$BSK.22.1" "BehSk cell" (CS $BSK 22 1) ( art data list)) 
  ;;(break "csartloc")

  ;;SET FINAL CSYM & CSNAME
  (cond 
   ((or (stringp csym) prestr poststr)
    (multiple-value-setq (csym csname)
        (my-make-cs-symbol  csym :prestr prestr :poststr poststr)))
   (T (setf csname (format nil "~A" csym)))) 
  ;;LET
  (let*
      ((old-csymvals (when (boundp csym) (eval csym)))
       (csymvals-exist-p (when old-csymvals T))
       (csymvals)
       ;;added
       ;;use only keys want to APPEND not replace/modify
       (append-named-keys&values (list 
                           (list  :BIPATH BIPATH)(list  :pole1  pole1 )(list  :pole2 pole2)
                           (list :bestpole bestpole)(list revpoleskey rev-poles-p) 
                           (list :to  to)(list  :from from)(list :wto wto)
                           (list :wfrom wfrom)(list  :info info )
                           ))
       ;;only keys want to REPLACE
       (set-named-keys&values (list
                               (list valuekey1 value1)(list  valuekey2 value2)
                               (list valrankey valrank) (list sdkey sd)(list revscorekey revscoredp)
                               (list  ans-data-key ans-data-list )(list txtinputkey  text-input )
                               (list systemkey system )
                               (list qtype-key qtype)(list clevkey clev)
                               ))
       (csdbsym-str)
       (old-keylist)
       (new-keylist)
       (new-value)
       ;;added supsys sym modification 
       (supsys-vals (when (eval-sym supsys)))
       ;;not used (main-dimsym (cond (supsys supsys)(t default-csart-rootstr)))
       (csartsym-exists-p)
       (csartloc-sym (cond
                      ((and csymvals-exist-p
                            (member if-csym-exists '(:do-nothing :replace-non-csartloc))
                            (third csymvals )))
                      (T (setf csartloc-sym (make-sym-str-dims-from-any 
                                             (list def-supsys csym))))))
       (csartloc-vals)
       (csartloc-syms&vals)
       (all-csartloc-syms (eval-sym all-csartloc-syms-sym))
       (all-csartloc-syms&vals (when append-all-syms&vals-p
                                 (eval-sym all-csartloc-syms&vals-sym)))
       )   
    ;;USE OLD CSYMVALS -- OR -- MAKE NEW, REPLACE, MODIFY
    (cond
     ((and (equal if-csym-exists :DO-NOTHING) csymvals-exist-p )
      (setf csymvals old-csymvals)
      )
     ;;OTHERWISE MAKE NEW CSARTLOC-SYM
     ;;MAKE NEW CSARTLOC symbol and new new-csartloc-vals?
     ;;must make AFTER initial creation of csym [chicken & egg problem].
     (T
      (multiple-value-bind (new-csartloc1 new-csartloc-vals csartdims
                                          old-csartloc csymvals1)
          (set-csym-csartloc csym :csartloc-origin csartloc-origin
                             :new-csartloc new-csartloc 
                             :topdim topdim :dims dims  :last-dim last-dim 
                             :supsys supsys  :def-supsys def-supsys 
                             :supsys-csartloc supsys-csartloc :parents parents
                             :new-csartloc-vals new-csartloc-vals  :artsym-n 2
                             :if-exists-replace-p make-new-csartloc-p 
                             :make-new-csartloc-p make-new-csartloc-p   
                             :n3-item csartloc-n3-item :rest-vals csartloc-rest-vals
                             :separator-str dim-separator :return-csartdims-p T
                             :append-all-csartloc-syms&vals-p T
                             :all-csartloc-syms-sym all-csartloc-syms-sym
                             :all-csartloc-syms&vals-sym all-csartloc-syms&vals-sym          
                             :supsys-key supsys-key)
        ;;note: csartloc set to csartloc-vals in func above
        (setf csartloc-sym new-csartloc1
              csartloc-vals new-csartloc-vals              
              all-csartloc-syms (append1 all-csartloc-syms  csartloc-sym)
              all-csartloc-syms&vals (append all-csartloc-syms&vals 
                                             (list csartloc-sym new-csartloc-vals)))         
        ;;(break "in set-csartloc")  

        (cond
         ((and (equal if-csym-exists :SET-ONLY-CSARTLOC&SUPSYS) 
               csymvals-exist-p )
          (setf csymvals (set-nth-in-list csartloc-sym 2 old-csymvals)
                csymvals (set-key-value supsys-key supsys csymvals ))
          (set csym csymvals)
          ) 
         ((and (equal if-csym-exists :MODIFY-ONLY-CSARTLOC) 
               csymvals-exist-p ) NIL)
         ;;must be done after new csartloc created below
         ;;(break "in :MODIFY-ONLY-CSARTLOC")                 
         ;;OTHERWISE MODIFY OR REPLACE CSYM
         (T
          ;;SET/CREATE THE CSARTLOC VALUE TO CSYM?
          ;;NOTE: Multi-level-csartloc = topdim + dims + supsys + csym (If last-dim=:csym )
          ;; Any nils are omitted.  If last-dim = a sym, it is used. 
          ;; If ONLY dims (last-dim = nil), makes new csartsym = dims.
          ;; If supsys = :GET finds from :css if available
      
          ;;SET MAIN VALUES IF CSYM NOT EXIST or if MODIFY, REPLACE
          (when (or (null csymvals-exist-p) 
                    (member if-csym-exists '(:MODIFY :REPLACE
                                             :REPLACE-NON-CSARTLOC) :test 'equal))
            ;;Note: if :replace-non-csartloc, the csartloc was set to OLD csartloc above.
            ;;
            ;;(list clev  value1 value2 sd  BIPATH pole1 pole2 bestpole system sublist
            ;;                                                                  to from wto wfrom info )
            ;;1. MAKE THE NEW CSYMVALS 
            (setf csymvals  (list csname  csphrase  csartloc-sym csdata  csdef))
            ;;2.ADD QUESTION/SCALE,ETC TYPE IF FROM CSQ
            (when qtype
              (setf csymvals (append csymvals (list qtype-key qtype))))
            ;;(set csym csymvals)
            ;;(break "csym=csymvals")
            ;;3. When PCLIST, APPEND old
            (when pclist
              (setf csymvals (append-key-value-in-list :pc pclist csymvals)))
            ;;4. When SUPSYS, replace old
            (when supsys
              (setf csymvals (set-key-value supsys-key supsys csymvals
                                            :append-as-flatlist-p T)))
            ;;modify cs-categories,APPEND old
            (when cs-categories
              (setf csymvals (append-key-value-in-list :cat cs-categories csymvals)))
            ;;5. MODIFY CSYMVALS KEYLISTS 
            ;;Keys&values to REPLACE/ADD
            (setf csymvals 
                  (set-keys-values-in-list set-named-keys&values csymvals
                                           :append-values-p NIL :replace-old-value-p T
                                           :omit-if-null-value-p T :append-as-flatlist-p T
                                           :no-dupl-p NIL))
            ;;Keys&values to APPEND            
            (setf csymvals 
                  (set-keys-values-in-list append-named-keys&values csymvals
                                           :append-values-p T :replace-old-value-p NIL
                                           :omit-if-null-value-p T :append-as-flatlist-p T :no-dupl-p T))
            ;;added 2020
            ;;6. LINKTYPE?
            (when (and linktype (null member linktype-key csymvals :test 'equal))
              (setf csymvals (append csymvals (list linktype-key linktype))))       
            ;;7. When SUBLIST, replace old
            (when sublist
              (setf csymvals (set-key-value sublist-key sublist csymvals
                                            :append-values-p T :replace-old-value-p NIL
                                            :append-as-flatlist-p T :no-dupl-p T))
              ;;(afout 'out (format nil "In make-csym, when sublist csym= ~A~% csymvals= ~A" csym csymvals))
              ;;end when
              )
            ;;7. FOR RESTKEYS -- CAN ADD ANY KEYS
            (when restkeys
              (loop
               for item in restkeys
               for n from 1 to 100
               do
               (let
                   ((xkey)
                    (xval)
                    )
                 (cond
                  ((listp item)
                   (setf xkey (car item)
                         xval (second item)))           
                  ((and (symbolp item) (oddp n))
                   (setf xkey item))
                  ((and (symbolp item) (evenp n))
                   (setf xval item))  
                  (t nil))
                 ;;(break "1")
                 ;;when key and val NOT NIL append
                 (when (OR (and xkey xval) (null no-nil-restkeys-p))
                   (setf csymvals
                         (SET-KEY-VALUE XKEY XVAL CSYMVALS 
                                        :append-values-p NIL :replace-old-value-p T
                                        :append-as-keylist-p NIL :append-as-flatlist-p T
                                        :no-dupl-p T)))
                 ;;(break "end loop")
                 ;;end let,loop,when restkeys
                 )))
            ;;(break "after restkeys")
            ;;SET THE CSYM to new CSYMVALS
            (set csym csymvals)
            ;;end when MODIFY/REPLACE CSYMVALS, T, cond
            )
          ;;(break "2")
          ;;9. REV-POLES-P  (2019 added for rev-poles-p)
          (when rev-poles-p
            (setf csymvals (append csymvals (list :REVPOL))))

          ;;end T [make new csartloc] , cond
          ))
     
        ;;(break "after set-csartloc")
        ;;5. SET THE CSYM = NEW CSYMVALS (with new csartloc-sym ?)
        (cond
         ((and (equal if-csym-exists :MODIFY-ONLY-CSARTLOC) 
               csymvals-exist-p )
          (setf csymvals (set-nth-in-list csartloc-sym 2 old-csymvals))
          (set csym csymvals))
         ((equal if-csym-exists :do-nothing) NIL)
         ;;reset csym csartloc after new one made
         (csartloc-sym
          (setf csymvals (eval-sym csym)
                csymvals (set-nth-in-list csartloc-sym 2 csymvals))
          (set csym  csymvals))
         (T (set csym csymvals)))   
        ;;end mvb,T = MAKE NEW CSYM, cond
        )))
    ;;(break "end after set new csartloc-sym in csym")
    ;;PROBLEM NOT SETTING CSYM TO NEW CSARTLOC
    ;;MAY BE FIXED NOW--CHECK IT

    ;;6. UPDATE SUPSYS VALS,  SET GLOBAL ALL-CSYMS, etc.     
    (unless (and csymvals-exist-p 
                 (equal if-csym-exists :do-nothing))
      ;;REDUNDANT-done in set-csym-csartloc, but cks if done, so ok?
      ;;6.1 UPDATE SUPSYS? [check if csym is in its supsys sublist. If not, update sublist.]
      #|        (when (and update-supsys-sublist-p supsys)
          (update-supsys-sublist csym :supsys supsys :supsys-key supsys-key
                                 :sublist-key sublist-key))|#
      ;;(break "after update")
      ;;(afout 'out (format nil "IN MAKE-CSYM BEFORE STORE-CSYM:~% csym= ~A~% csymvals= ~A" csym csymvals))       

      ;;6.2 UPDATE GLOBAL *ALL-CSYMS LIST
      (set all-csyms-sym (append1 (eval all-csyms-sym) csym))
      ;;UPDATE GLOBAL  *ALL-CSARTLOC-SYMS LIST
      (set all-csartloc-syms-sym all-csartloc-syms)

      ;;6.3 STORE EACH NEW CSYM TO A CSYM FILE?
      ;;Note: creates huge file & greatly slows program--store global cum var
      ;;  at end of function making csyms
      (when store-all-csyms-to-file-p ;;also stores csymvals
        (multiple-value-setq (csym csymvals supsys supsys-vals )
            (store-csym csym :supsys supsys :all-stored-csyms-sym
                        all-stored-csyms-listsym
                        :csym-cum-store-file all-stored-csyms-file)))
      ;;(afout 'out (format nil "   AFTER STORE-CSYM:~% csym= ~A~% (eval csym)= ~A ~% csymvals= ~A" csym (eval csym) csymvals))

      ;;when store all csyms to a file, STORE ALL CSARTLOCS TOO.
      (when store-all-csyms-to-file-p ;;also stores csymvals
        (multiple-value-setq (csym csymvals supsys supsys-vals )
            (store-csym csartloc  all-stored-csartlocs-file  :all-stored-csyms-sym
                        all-csartloc-syms&vals-sym
                        :csym-cum-store-file all-stored-csartlocs-file)))
      ;;end unless update
      )
    ;;(break "END make-csym") 
    ;;(afout 'out (format nil "END MAKE-CSYM: CSYM= ~A" csym))
    #|(afout 'out (format nil "END MAKE-CSYM: CSYM= ~A:~% CSARTLOC-SYM = ~A ~% SUPSYS-CSARTLOC= ~A " csym csartloc-sym supsys-csartloc ))|#
    ;;(afout'out (format nil " END MAKE-CSYM:~% csym= ~A~% (eval csym)= ~A ~% csymvals= ~A" csym (eval csym) csymvals))
    (values csymvals csym csartloc-sym csartloc-vals supsys)
    ;;end let, make-CSYM
    ))
;;TEST
;;2020
;;for new normal using many keys (incl restkeys)     
;; (make-csym  'mycsym3 "mycsym phr"  "DATA" "DEF"  :supsys-csartloc  '$CS.BELIEFS  :value1 .888 :value2 33.0  :sd 1.22 :valrank 9 :text-input "Text Input" :qtype :QVAR :info '("This is info" "This is more") :system 'CS1-system :clev 6 :restkeys '((:k1 data1)(:k2 data2)) :if-csym-exists :MODIFY)
;;works= ("MYCSYM3" "mycsym phr" $CS.BELIEFS.MYCSYM3 "DATA" "DEF" :QT :QVAR :VA 0.888 :VA2 33.0 :RNK 9 :SD 1.22 :TXT "Text Input" :CSYS CS1-SYSTEM :CLEV 6 :INFO ("This is info" "This is more") :K1 DATA1 :K2 DATA2)    MYCSYM3  $CS.BELIEFS.MYCSYM3    ("$CS.BELIEFS.MYCSYM3" ($CS BELIEFS MYCSYM3) NIL MYCSYM3)    NIL
;; for multi-selection ans data
;; (make-csym 'multi-ans-csym  "multi-ans-csym phr" "DATA" "DEF"  :supsys 'mysupsys1 :ans-data-list '(("ans1" NIL)("ans2" T)("ans3")))
;; ("MULTI-ANS-CSYM" "multi-ans-csym phr" MYSUPSYS1.MULTI-ANS-CSYM "DATA" "DEF" :CSS MYSUPSYS1 :ADAT (("ans1" NIL) ("ans2" T) ("ans3")))    MULTI-ANS-CSYM    MYSUPSYS1.MULTI-ANS-CSYM   ("MYSUPSYS1.MULTI-ANS-CSYM" (MYSUPSYS1 MULTI-ANS-CSYM) NIL MULTI-ANS-CSYM)   MYSUPSYS1 
;; 
;; (setf mysupsys1 '("mysupsys1" "mysupsys1 phr" top.mysupsys1 nil nil  :css top :s (sym1 sym2 sym3) :data "this data" :clev 3 :qt :qvar))
;; (makunbound-vars '(mysupsys1top.mysupsys1 mycsym2 MYSUPSYS1.MYCSYM2))
;; (make-csym 'mycsym2  "mycsym phr" "DATA" "DEF"  :supsys 'mysupsys1 :clev 3 :qtype :scale :sublist '(sub1 sub2 sub3) :info "this info")
;;works= ("MYCSYM2" "mycsym phr" TOP.MYSUPSYS1.MYCSYM2 "DATA" "DEF" :QT :SCALE :CSS MYSUPSYS1 :CLEV 3 :INFO "this info" :S (SUB1 SUB2 SUB3))   MYCSYM2  TOP.MYSUPSYS1.MYCSYM2  ("TOP.MYSUPSYS1.MYCSYM2" (TOP MYSUPSYS1 MYCSYM2) NIL MYCSYM2)  MYSUPSYS1
;; ALSO: MYCSM2 added to supsym sublist:
;; MYSUPSYS1 = ("mysupsys1" "mysupsys1 phr" TOP.MYSUPSYS1 NIL NIL :CSS TOP :S (SYM1 SYM2 SYM3 MYCSYM2) :DATA "this data" :CLEV 3 :QT :QVAR)
;;test if-csym-exists :MODIFY-ONLY-CSARTSYM
;; also csartloc works: TOP.MYSUPSYS1.MYCSYM2  =  ("TOP.MYSUPSYS1.MYCSYM2" (TOP MYSUPSYS1 MYCSYM2) NIL MYCSYM2)
;; (make-csym 'mycsym2  "mycsym phr" NIL "DATA" "DEF"  :supsys-csartloc  '$CS.BELIEFS  :if-csym-exists :MODIFY-ONLY-CSARTSYM)
;; works: MYCSYM2 = ("MYCSYM2" "mycsym phr" $SC.DIM1.DIM2.MYSUPSYS1.MYCSYM2 "DATA" "DEF" :CSS MYSUPSYS1)
;; also new csartloc: $SC.DIM1.DIM2.MYSUPSYS1.MYCSYM2 = ("$SC.DIM1.DIM2.MYSUPSYS1.MYCSYM2" ($SC DIM1 DIM2 MYSUPSYS1 MYCSYM2) NIL MYCSYM2)
;; also, old csartloc unbound MYSUPSYS1.MYCSYM2 = unbound error

;;;; when if-csym-exists =  :SET-ONLY-CSARTLOC&SUPSYS
;; (setf  mycsym3 '("MYCSYM3" "mycsym 3 phr" $MIS.OLDSUP.MYCSYM3 "DATA" "DEF" :CSS OLDSUP))
;; (make-csym 'mycsym3 nil nil nil :if-csym-exists :SET-ONLY-CSARTLOC&SUPSYS :csartloc-origin :supsys-csartloc :supsys-csartloc 'TOP.MYSUPSYS1  :supsys 'mysupsys1)
;; works= ("MYCSYM3" "mycsym 3 phr" TOP.MYSUPSYS1.MYCSYM3 "DATA" "DEF" :CSS MYSUPSYS1)    MYCSYM3     TOP.MYSUPSYS1.MYCSYM3      ("TOP.MYSUPSYS1.MYCSYM3" (TOP MYSUPSYS1 MYCSYM3) NIL MYCSYM3)   MYSUPSYS1  
;;also :S updated: MYSUPSYS1  = ("mysupsys1" "mysupsys1 phr" TOP.MYSUPSYS1 NIL NIL :CSS TOP :S (SYM1 SYM2 SYM3 MYCSYM3) :DATA "this data")



;;
;;test  if-csym-exists :REPLACE-NON-CSARTLOC 
;; (make-csym 'mycsym2  "mycsym phr" NIL "NEW DATA" NIL  :supsys 'mysupsys1 :DIMS NIL :qtype 'NEWQT :sublist '(sym1 sym2) :clev 6 :if-csym-exists :REPLACE-NON-CSARTLOC)
;; works= ("MYCSYM2" "mycsym phr" $SC.MYSUPSYS1.MYCSYM2 "NEW DATA" NIL :QT NEWQT :CSS MYSUPSYS1 :CLEV 6 :S (SYM1 SYM2))   MYCSYM2  $SC.MYSUPSYS1.MYCSYM2   NIL  MYSUPSYS1



;;  (make-csym 'new-csym1 "new-csym1 phrase" nil "data" "csdef")
;;works=  ("NEW-CSYM1" "new-csym1 phrase" $MIS.NEW-CSYM1 "data" "csdef" :CSS $MIS)    NEW-CSYM1   $MIS.NEW-CSYM1   NIL  $MIS
;;2019
;;  (make-csym '$CS "Cog Syst" 'root.$CS "data" "def")
;; ("$CS" "Cog Syst" ROOT.$CS "data" "def" :CSS $MIS)  $CS   ROOT.$CS  (ROOT $CS)  $MIS  (:S $CS)  
;;Also:  $CS  = ("$CS" "Cog Syst" ROOT.$CS "data" "def" :CSS $MIS)
;;Also:  ROOT.$CS =  ("ROOT.$CS" (ROOT $CS) $CS NIL)

;; [set above: (setf $BSK '($BSK "Behavioral Skill" :S ($PEOP $MECH $MAIN) :CLEV 1  ))] also? (setf *ALL-STORED-CSYMS nil)
;;MAKE A NEW CSYM  [ (setf newcsym0 nil) ]  MAKE-CSYM, uses STORE-CSYM
;;with both both locs given
;; (make-csym 'newcsym0 "new0" 'CS.loc1 "data" "def" :SUBLIST '(SYM1 SYM2) :cs-categories '(cat1 cat2) :supsys '$BSK :new-csartdims '(CS loc1) :clev 2)
;; works= ("NEWCSYM0" "new0" CS.LOC1 "data" "def" :S (SYM1 SYM2) :CSS $BSK :CAT (CAT1 CAT2) :CLEV 2)    NEWCSYM0   CS.LOC1   NIL  $BSK  ("$BSK" "Behavioral Skill" $CS.$EXC.$BSK NIL NIL :S ($PEOP $MECH $MAIN NEWCSYM0) :CSS $EXC :INFO 2)
;;ALSO:  CS.LOC1 = ("CS.LOC1" (CS LOC1) NEWCSYM0 NIL)
;;
;;with only cs-artloc sym given:
;; (make-csym 'newcsym0 "new0" 'CS.loc1 "data" "def" :cs-categories '(cat1 cat2) :supsys '$BSK)
;; works= ("NEWCSYM0" "new0" CS.LOC1 "data" "def" :CSS $BSK :CAT (CAT1 CAT2))   NEWCSYM0   CS.LOC1  (CS LOC1)  $BSK  (NEWCSYM0 (:S $BSK))   
;;also  CS.LOC1 = ("CS.LOC1" (CS LOC1) NEWCSYM0 NIL)
;; and  $BSK = ($BSK "Behavioral Skill" :S ($PEOP $MECH $MAIN) :CLEV 1 :S  (NEWCSYM0))
;;  (make-csym 'newsym1 "newsym1 sym" '(CS 1) "data" "def" :supsys 'CS :sublist '(csub1 csub2)  :info "info here")
;; works = ("NEWSYM1" "newsym1 sym" CS "data" "def" :S (CSUB1 CSUB2) :WFROM "info here" :CSS CS)   NEWSYM1   CS   NIL  CS  (NEWSYM1 (:S CS))
;;also: NEWSYM1 = ("NEWSYM1" "newsym1 sym" CS "data" "def" :S (CSUB1 CSUB2) :WFROM "info here" :CSS CS)


;;OLDER
;; (make-csym 'cststsym "cs test sym" 'cs2-1-1-1  '(5 "data") "test definition" :pole1 "pole1" :pole2 "pole2" :bestpole 1 :system '$TOPBV  :info "more info")
;;works=  ("CSTSTSYM" "cs test sym" CS2-1-1-1 (5 "data") "test definition" :POLE1 "pole1" :POLE2 "pole2" :BESTPOLE 1 :SYSTEM $TOPBV :INFO "more info")     CSTSTSYM    
;;CL-USER 45 > CSTSTSYM  =>   ("CSTSTSYM" "cs test sym" CS2-1-1-1 (5 "data") "test definition" :POLE1 "pole1" :POLE2 "pole2" :BESTPOLE 1 :SYSTEM $TOPBV :INFO "more info")
;;ALSO FOR CSARTSYM,   CS2-1-1-1 => ("CS" (2 1 1 1) NIL CSTSTSYM NIL)

;;OLDER
;; (make-csym 'cststsym "cs test sym" 'cs2-1-1-1  '(5 "data") "test definition" :pole1 "pole1" :pole2 "pole2" :bestpole 1  :info "more info")
;; (make-csym 'verysilly  "cs test sym" 'cs3-1-1-1  '(5 "data") "test definition" :info "more info")
;;works=  CSTSTSYM  ("CSTSTSYM" "cs test sym" CS2-1-1-1 (5 "data") "test definition" :INFO "more info")
;;also CL-USER 148 > CS2-1-1-1  =   (CS2-1-1-1 NIL NIL CSTSTSYM NIL)

;;  (make-csym 'new-csym "newsymname" nil  nil  nil  :info "more info")
;;  VVV

;;MODIFIED FOR PC AFTER THESE TESTS
;;  (make-csym 'cststsym "cs test sym" 'cs2-1-1-1  '(5 "data") "test definition" :info "more info")
;; works= ("cststsym" "cs test sym"  cs2-1-1-1 (5 "data") "test definition" :info "more info")    cststsym
;; then: CL-USER 29 > CS2-1-1-1 =  ("CS" (2 1 1 1) NIL CSTSTSYM NIL)
;;
;;(make-csym 'cststsym "cs test sym" 'cs2-11-1-1  '(4 "data") "test definition" :info "more info")
;;works= ("cststsym" "cs test sym" cs2-11-1-1 (4 "data") "test definition" :info "more info")   cststsym
;;also CL-USER 33 > CS2-11-1-1  = ("CS" (2 11 1 1) NIL CSTSTSYM NIL)
;;  
;;depends on
;; (get-csartsym-dims 'CStst1-1-1-1)   = ("CSTST" (1 1 1 1))  "CSTST"  (1 1 1 1) "1-1-1-1"




;;MAKE-CSARTLOC
;;2019
;;ddd
#|(defun make-csartloc (csartloc csym  &key supsys (append-csym-p T)
                            n3-item rest-vals  if-exists-replace-p (csartloc-n 2)
                            csartloc-syms&vals set-as-csartdims-p (if-exists-replace-p t)
                            (make-new-csartloc-p t)  
                            (all-csartloc-syms-sym  '*all-csartloc-syms) 
                            (all-csartloc-syms&vals-sym '*all-csartloc-syms&vals))
  "U-CS WORKS--DEPRECIATED: Use SET-CSYM-CSARTLOC instead. RETURNS: (values csartloc-sym csartloc-vals csartdims csartloc-str csymvals)   INPUT: csartloc can be sym or list. CSARTLOC-VALS= (csartloc-str csartdims n3-item csym [rest-vals appended]). UNBINDS old csartloc. If SUPSYS, cons to front. Puts CSYM as last dim."
  (let*
      ((csartloc-str)
       )
    ;;for campatibility with set-csym-csartloc--the default is use supsys if find it.
    (when (null supsys)
      (setf supsys :get))
    (multiple-value-bind (csartloc-sym csartloc-vals 
                                   csartdims old-csartloc csymvals)
        (set-csym-csartloc csym :csartloc-origin csartloc-origin
                             :new-csartloc csartloc
                             :topdim topdim :dims dims  :last-dim last-dim 
                             :supsys supsys  :def-supsys def-supsys 
                             :csartloc-syms&vals csartloc-syms&vals  :artsym-n 2
                             ;;:set-as-csartdims-p set-as-csartdims-p 
                             :if-exists-replace-p make-new-csartloc-p 
                             :make-new-csartloc-p make-new-csartloc-p   
                             :n3-item csartloc-n3-item :rest-vals csartloc-rest-vals
                             :separator-str dim-separator
                             :append-all-csartloc-syms&vals-p T
                             :all-csartloc-syms-sym all-csartloc-syms-sym
                             :all-csartloc-syms&vals-sym all-csartloc-syms&vals-sym            
                             :supsys-key supsys-key)
  ;;SSSS DEBUG   MAKE-CSARTLOC & set-csym-csartloc                 

      #| OLDER-REPLACED BY SET-CSYM-CSARTLOC
;;FIND NEW-CSARTLOC, NEW-CSARTLOC-STR, CSARTDIMS
    (cond
     ((symbolp csartloc)
      (setf new-csartloc csartloc
            csartdims (find-artsym-dims new-csartloc)))
     ((and (listp csartloc) (not (null-list-p csartloc)))
      (setf csartdims csartloc
            csartloc (make-list-symbol csartloc)))    
     ((stringp csartloc)
      (setf new-csartloc-str csartloc
            csartloc (my-make-cs-symbol csartloc)
            csartdims (find-artsym-dims new-csartloc)))
     (t nil))

    ;;CONS SUPSYS
    (when supsys
      (cond
       ((not (null-list-p csartdims))
        (setf csartdims (cons supsys csartdims)))
       (T (setf csartdims (list supsys)))))

    (when append-csym-p
      (cond
       ((not (null-list-p  csartdims))
        (setf csartdims (append csartdims (list csym))))
       (t (setf csartdims (list csym)))))

    ;;MAKE NEW CSARTLOC & STR
    (setf new-csartloc (my-make-cs-symbol csartdims))
    ;;in case begins with "."
    (setf new-csartloc-str (delete-begin-string '(".") new-csartloc-str))
  
    ;;DOES DIMSYM ALREADY EXIST?
    (cond
     ((and (listp dimsymvals)(> (list-length dimsymvals) 2))
      (cond
       (if-exists-replace-p
        (setf make-new-symvals-p T))
       (t (setf make-new-symvals-p NIL))))
     (t (setf make-new-symvals-p T)))

    ;;MAKE new-csartloc-str
    (unless new-csartloc-str
      (setf new-csartloc-str (format nil "~A" new-csartloc)))

    ;;MAKE NEW CSARTLOC-VALS AND SET TO CSARTLOC-SYM?
    (cond
     (make-new-symvals-p
      (setf new-csartloc-vals
           (append (list new-csartloc-str csartdims n3-item csym) rest-vals))
      (set new-csartloc new-csartloc-vals))
     ((boundp csartloc)
      (setf new-csartloc-vals (set-nth-in-list new-csartloc-str 0 dimsymvals))
            new-csartloc-vals (set-nth-in-list csartdims 1 new-csartloc-vals)            
      (set new-csartloc new-csartloc-vals)
      (makunbound csartloc))
     (t nil))|#
     ;;(csartloc-sym csartloc-vals csymvals csartdims)
      (setf csartloc-str (format nil "~A" csartloc-sym))
      (values csartloc-sym csartloc-vals csartdims csartloc-str csymvals)
      ;;end MVB,let, make-csartloc
      )))|#
;;TEST
;; (make-csartloc NIL 'CAREFOROTHERS :if-exists-replace-p T)
;; works= $TBV.CAREFOROTHERS   ("$TBV.CAREFOROTHERS" ($TBV CAREFOROTHERS) "3rd" CAREFOROTHERS "rest of stuff")       ($TBV CAREFOROTHERS)     "$TBV.CAREFOROTHERS"     ("CAREFOROTHERS" "CARE FOR OTHERS vs SELFISH" $TBV.CAREFOROTHERS NIL NIL :PC ("CARE FOR OTHERS" "SELFISH" 1 NIL) :POLE1 "CARE FOR OTHERS" :POLE2 "SELFISH" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)) :CSVAL "0.917" :CSRANK 3)

;; (setf new-csym2 '("new-csym2" "new-csym2 phr" nil "data" "def" :css next-level-sys))
;; (make-csartloc nil 'new-csym2 :n3-item 'N3 :rest-vals '(:k1 this :k2 'that))
;; works= NEXT-LEVEL-SYS.NEW-CSYM2        ("NEXT-LEVEL-SYS.NEW-CSYM2" (NEXT-LEVEL-SYS NEW-CSYM2) N3 NEW-CSYM2 :K1 THIS :K2 (QUOTE THAT))     (NEXT-LEVEL-SYS NEW-CSYM2)    "NEXT-LEVEL-SYS.NEW-CSYM2"    ("new-csym2" "new-csym2 phr" NEXT-LEVEL-SYS.NEW-CSYM2 "data" "def" :CSS NEXT-LEVEL-SYS)

;;OLD -----------------------------------------
;; CSARTLOC A SYMBOL
;; (make-csartloc 'AA.BB.CC 'csym22 :n3-item 'N3 :rest-vals '(:k1 this :k2 'that))
;; works= AA.BB.CC.CSYM22    ("AA.BB.CC.CSYM22" (AA BB CC CSYM22) N3 CSYM22 :K1 THIS :K2 (QUOTE THAT))    (AA BB CC CSYM22)   "AA.BB.CC.CSYM22"
;;ALSO: AA.BB.CC.CSYM22  =   ("AA.BB.CC.CSYM22" (AA BB CC CSYM22) N3 CSYM22 :K1 THIS :K2 (QUOTE THAT))
;;
;;with SUPSYS
;; (make-csartloc 'AA.BB.CC 'csym22 :supsys '$CS  :n3-item 'N3 :rest-vals '(:k1 this :k2 'that))
;;works= $CS.AA.BB.CC.CSYM22    ("$CS.AA.BB.CC.CSYM22" ($CS AA BB CC CSYM22) N3 CSYM22 :K1 THIS :K2 (QUOTE THAT))   ($CS AA BB CC CSYM22)    "$CS.AA.BB.CC.CSYM22"
;;also: 
;; $CS.AA.BB.CC.CSYM22   =  ("$CS.AA.BB.CC.CSYM22" ($CS AA BB CC CSYM22) N3 CSYM22 :K1 THIS :K2 (QUOTE THAT))
;;
;;For TOP-CSARTLOC
;; 



;;GET-CSYM-PATHS
;;2020
;;ddd
(defun get-csym-paths (csym pathtype) ;;  &key  )
  "U-CS RETURNS    INPUT:  "
  (when (stringp csym)
    (setf csym (my-make-cs-symbol csym)))
  (let*
      ((csympaths (get-key-value pathtype csym))
       (path-csym-pairs)       
       )
    (when (my-listp csympaths)
      (loop
       for path in csympaths
       do
       (let*
           ((csym1)
            (csym2)
            )
         (when (listp csym2)
           (setf csym2 (second csym2)))
         (cond
          (
           )
          (
           )
          (t nil))
         ;;end let,loop
         ))

      ;;end when
      )

    (values    )
    ;;end let, get-csympaths
    ))
;;TEST
;; COMPILE-BUFFER CNTR-F7



;;GET-PATH-2CSYMS
;;2020
;;ddd
(defun get-path-2csyms (csym1 csympath)
  "U-CS Gets the csym in eg. (pole1 nil csym1 (pole1 csym2))   RETURNS (values csym-pair csym-pair-info)  INPUT: csympath can be of forms: 1.(poleX data1 csym2 data2), 2.(polex data1 (poleX2 data2 csym2)), 3. (csym1 data1 csym2 data2) , 4.(csym1 data1 (csym2 (POLE2) data2)), 5. ((csym2 data2) :lntp :isa linkdata), 6. (poleX1 data1 (polex2 csym2 data) :lntp link linkdata). Depreciated: extra parens around 3 & 4"
;; ((CSYM2 :KEY21 (QUOTE DATA21)) :LNTP :ISA :KEY1 (QUOTE DATA1))
;; (make-csym-path-info 'intimate 'careforothers :linktype :ISA   :csym1pole 'pole1 :csym2pole  'pole1 :csym1data '(:key1 data1) :csym2data '(:Key22 data22))
;; works= (POLE1 NIL (POLE1 CAREFOROTHERS :KEY22 DATA22) :LNTP :ISA :KEY1 DATA1)
;; ((csym2 data2) :lntp link linkdata) egs. ((RESEARCH-EV) :LNTP :HOW), 
;; (poleX1 data1 (polex2 csym2 data) :lntp link linkdata)
;;    eg.  (POLE1 NIL (POLE1 CAREFOROTHERS :KEY22 DATA22) :LNTP :ISA :KEY1 DATA1)
  (let*
      ((csym2)
       (c1-info)
       (c2-info)
       (list1)
       (list2)
       )
    ;;filter out depreciated paths w/ extra parens around them (in elmsyms + ??)
    (when (and (listp (car csympath)) (> (list-length (car csympath)) 2)
               (< (length csympath) 2))
      (setf cympath (car csympath)))
    ;;FIND PATH CSYMS & INFO
    (cond
     ((my-listp (car csympath))
      (setf list1 (car csympath))
      (cond
       ;;PC path with poles listed
       ;;csym2 is in a list
       ((member (car list1) '(pole1 pole2) :test 'equal)
        (setf c1-info (list csym1 :pole (car list1) :data (second list1)))
        (cond
         ((my-listp (third csympath))
          (setf list2 (third csympath))
          (cond
           ((member (car list2) '(pole1 pole2) :test 'equal)
            (setf csym2 (second list2)
                  c2-info (list csym2 :pole (car list2) :data (append (cddr list2)))))
           ((symbolp (car list2))
            (setf csym2 (car list2)
                  c2-info (list  csym2 :data (append (cdr list2)))))
           (T nil))
         ;;end my-listp 3rd
         )
         ;;csym2 not in a list
         ((symbolp (third csympath))
          (setf csym2 (third csympath)
                c2-info (list csym2 :data (append (nthcdr 3 csympath)))))
         (t nil)))
       ;;CSYM1 HAS NO POLES
       ((symbolp (car list1))
        (setf csym2 (car list1)
              data2 (second list1)
              c1-info (list csym1 :data (append (nthcdr 3 csympath))))
        (cond
         ((my-listp (third list1))
          (setf list2 (third list1))
          (cond
           ((member (car list2) '(pole1 pole2) :test 'equal)
            (setf csym2 (second list2)
                  data2 (nthcdr 3 list2)
                  c2-info (list csym2 :pole (car list2) :data (append data2))))
           (T (setf csym2 (car list2)
                    data2 (cdr list2)
                    c2-info (list csym2 :data (append data2))))))
         ;;third not a list
         (T
          (setf c2-info (list csym2 :data data2))))
        ;;(setf c2-info (list csym2 :data data2))
        ;;end symbolp 
        )
         ;;make other options here??
         (T NIL))
      ;;end listp first item
      )
     ;;FIRST CSYMPATH ITEM IS A SYMBOL
     ;;1. It is a pole  eg (POLE1 NIL PER-ROMANCE NIL)
     ((member (car csympath) '(pole1 pole2) :test 'equal)
      (setf c1-info (list csym1 :pole (car csympath) :data (second csympath)))
      (cond
       ((my-listp (third csympath))
        (setf list2 (third cysmpath))
        (cond
         ((member (car list2) '(pole1 pole2) :test 'equal)
          (setf csym2 (second list2)
                c2-info (list csym2 :pole (car list2) :data (append (nthcdr 3 list2)))))
         (T (setf csym2 (car list2)
                  c2-info (list csym2  :data (append (cdr list2))))))
        )
      (T
       (setf csym2 (third csympath)
             c2-info (list csym2  :data (append (nthcdr 3 csympath))))))
      )      
       ;;otherwise form of (CSYM1  DATA (CSYM2 DATA)) or (CSYM1  DATA CSYM2 DATA))
       ;;2. First item is CSYM2
       (T 
        (setf csym2 (car csympath)
              c2-info (list csym2 :data (second csympath)))
        (cond
         ((my-listp (third csympath))
          (setf list2 (third csympath)
                csym2 (car list2)
                c2-info (list csym2 :data (append (cdr list2)))))
         ((my-symbolp (third csympath))
          (setf csym2 (third csympath)
                c2-info (list csym2 :data (append (nthcdr 3 csympath)))))
         (T NIL))))

    (setf csym-pair (list csym1 csym2)
          csym-pair-info (list c1-info c2-info))

    (values csym-pair csym-pair-info)
    ;;end let, get-path-2csyms
    ))
;;TEST
;; SSSSS START TESTING get-path-2csyms
;;test from testdata (modified version of AUTONOMOUS)
;; (get-path-2csyms '>AUTONOMOUS  '(POLE1 NIL F-ADMIRE NIL))
;; works= (>AUTONOMOUS F-ADMIRE)      ((>AUTONOMOUS :POLE POLE1 :DATA NIL) (F-ADMIRE :DATA (NIL)))
;; (get-path-2csyms '>AUTONOMOUS '((EXTERNALCONT) :LNTP :OPP))
;;works= (>AUTONOMOUS EXTERNALCONT)           ((>AUTONOMOUS :DATA NIL) (EXTERNALCONT :DATA NIL))
;; (get-path-2csyms '>AUTONOMOUS '(POLE2 NIL CHILD-DISLIKE NIL))
;; works= (>AUTONOMOUS CHILD-DISLIKE)         ((>AUTONOMOUS :POLE POLE2 :DATA NIL) (CHILD-DISLIKE :DATA (NIL)))

;; USE FOR >AUTONOMOUS :BIPATH ((POLE1 NIL F-ADMIRE NIL) (POLE1 NIL PER-ROMANCE NIL) (POLE2 NIL CHILD-DISLIKE NIL) ((FREEDOM) :LNTP :WHY) ((RESEARCHEVID) :LNTP :EVID) ((RESEARCH-EV) :LNTP :HOW) ((DIDITMYWAY8) :LNTP :EX) ((RESEARCH-EV8) :LNTP :FETR) ((DID-IT-MY-W3) :LNTP :FETR) ((INDEPENDENCE) :LNTP :NAME) ((FOLLOWOWNBEL) :LNTP :DEF) ((OWNWAYAGAINS) :LNTP :DESC) ((EXTERNALCONT) :LNTP :OPP) ((RESEARCH-EV2) :LNTP :SYN) ((DID-IT-MY-W5) :LNTP :SYN) ((INDEPENDENC) :LNTP :SYN) ((FOLLOW-OWN-) :LNTP :SYN))


;;FIND-CSARTLOC-HIER--REPLACED  BY SET-CSYM-CSARTLOC modified
;;2020
;;ddd
#|(defun find-csartloc-hier (csym &key (csartloc-origin :supsys-csym)
                                supsys-csartloc   supsys csartloc  topdim dims
                                (last-dim :csym)  parents
                                ;;FIND SCALE-CLASS CSYM?? csartloc1 below
                                return-csartdims-p)
  "U-CS   RETURNS (values csartloc csartdims)    INPUT:  CSARTLOC-ORIGIN can be  :supsys-csym, :topdim-dims, :supsys-csartloc, :csartloc :scale-class,  :supsys-only,  :parents  "
  (let*
      ((csartdims)
       )
    ;;GET supsys?
    (when (or (equal supsys :GET)
              (member csartloc-origin '(:supsys-csym  :supsys-csartloc
                                        :scale-class  :supsys-only) :test 'equal))
      ;;[NOT incl: :topdim-dims :csartloc :parents]
      (setf supsys (get-key-value supsys-key csymvals))
      ;;assumes supsys is next to end dim
      (unless supsys
        (when (listp old-csartloc-dims)
          (cond
           ;;if csym at end of csartdims
           ((equal csym (last1 old-csartloc-dims))
            (setf supsys (car (last old-csartloc-dims 2))))
           ;;if no csym at end
           (T (setf supsys (car (last old-csartloc-dims))))))
        ;;if double csyms in csartdims
        (when (equal supsys csym)
          (setf supsys (car (last old-csartloc-dims 3))))
        ;;end unless,when :GET supsys
        ))
    ;;WHICH CSARTLOC-ORIGIN?
    (cond
     ((equal csartloc-origin :SUPSYS-CSYM)
      (when supsys
        (setf csartdims (list supsys)))
      (setf csartdims (append csartdims (list csym))))
     ((equal csartloc-origin  :CSARTLOC) 
      (setf csartloc csartloc))
     ((equal csartloc-origin  :TOPDIM-DIMS)
      (when (or topdim supsys last-dim)
        ;;1. convert dims to a list
        (cond
         ((listp dims)
          (setf csartdims dims))
         ((or (symbolp dims) (stringp dims))
          (setf csartdims (find-art-dims dims)))
         (t nil))
        ;;2. Add topdim?
        (when  topdim 
          (setf csartdims (cons topdim csartdims)))
        ;;3. Add supsys?
        (when supsys
          (setf csartdims (append csartdims (list supsys ))))
        ;;4. Add last-dim-csym?
        (when last-dim 
          (cond
           ((equal last-dim :csym)
            (setf csartdims (append csartdims (list csym))))
           (T (setf csartdims (append csartdims (list last-dim))))))
        ))
     ;;(break "after add csym")
     ((equal csartloc-origin :SUPSYS-CSARTLOC)
      (cond
       (supsys-csartloc
        (setf csartdims 
              (nth-value 2 (make-sym-str-dims-from-any supsys-csartloc))
              csartdims (append csartdims (list csym))))
       (supsys
        (cond
         ((listp supsys)
          (setf csartdims (append csartdims supsys (list csym))))
         (T (setf csartdims (append csartdims (list supsys csym))))))
       (T (setf csartdims (append csartdims (list csym))))))
     ((equal csartloc-origin :SCALE-CLASS)
      ;;SSSSS FIND SCALE CLASS??
      (setf csartloc csartloc1))
     ((equal csartloc-origin :SUPSYS-ONLY)
      (cond
       (supsys
        (setf csartloc supsys))
       (T (setf csartloc def-supsys))))
      ((equal csartloc-origin :PARENTS)
      (parents
       (cond
        ((listp parents)
         (setf csartdims (append  parents (list csym))))
        (T (setf csartdims (list parents csym)))))
      (T (setf csartdims (append csartdims (list csym)))))
     (T (setf csartloc csym)))

    ;;MAKE NEW CSARTLOC-SYM
    (when csartdims
      (setf csartloc-sym (make-list-symbol csartdims :separator-str separator-str)
            csartloc-str (format nil "~A" csartloc-sym)))
    (when (and return-csartdims-p (null csartdims))
      (setf csartdims (nth-value 2 (make-sym-str-dims-from-any csartloc))))
    (values csartloc csartdims)
    ;;end let, find-csartloc-hier
    ))|#
;;TEST
;; for :supsys-csym
;; (find-csartloc-hier 'test-scaleX  :supsys 'supsys :return-csartdims-p T)
;; works = SUPSYS.TEST-SCALEX   (SUPSYS TEST-SCALEX)
;; for :supsys-csartloc
;; (find-csartloc-hier 'test-scaleX :csartloc-origin :supsys-csartloc :supsys-csartloc  '$CS.BELIEF  :return-csartdims-p T)
;; works= $CS.BELIEF.TEST-SCALEX   ($CS BELIEF TEST-SCALEX)
;; for :csartloc
;; (find-csartloc-hier 'test-scaleX :csartloc-origin :csartloc :csartloc  '$CS.BELIEF.X11  :return-csartdims-p T)
;; works = $CS.BELIEF.X11   ($CS BELIEF X11)
;; for :topdim-dims
;; ;; (find-csartloc-hier 'test-scaleX :csartloc-origin :topdim-dims :topdim '$CS :dims '(dim1 dim2)  :return-csartdims-p T)
;; works= $CS.DIM1.DIM2.TEST-SCALEX   ($CS DIM1 DIM2 TEST-SCALEX)







#|
  (when (and csym (boundp csym))  
    (let*
        ((csymvals (eval csym))
         (name (second csymvals))
         (csartloc (third csymvals))
         (val (get-key-value :VA csymvals))
         (sublist (get-key-value :S csymvals))
         (child-sublist (list name))
         (qt (get-key-value :QT csymvals))
         (clev (get-key-value :clev csymvals))
         (rank (get-key-value :RNK csymvals))
         )
      (when name 
        (setf child-sublist (append child-sublist (list name))))
      (when val 
        (setf child-sublist (append child-sublist (list :VA val))))
      (when rank
        (setf child-sublist (append child-sublist (list :RNK rank))))
      (when clev 
        (setf child-sublist (append child-sublist (list :CLEV clev))))
      (when (and *incl-csartloc-in-treeviewer-nodes-p csartloc)
        (setf child-sublist (append child-sublist (list csartloc))))
      (when qt 
        (setf child-sublist (append child-sublist (list :qt qt))))
      (when (and *incl-sublist-in-treeviewer-nodes-p)
        (setf child-sublist (append child-sublist (list :S sublist))))
         ;;(break "childlist")
       ;;end let,when,csym-treeview-children-function
       )))|#

;;GET-CSYM-INFO
;;2019
;;ddd
(defun get-csym-info (csym  &key rest-keys omit-def-p omit-desc-p omit-data-p
                            (return-node-text-first-p T) (make-text-info-p T) 
                            incl-all-keys-p (omit-some-nil-p T)
                            incl-csymvals-p  return-csymvals-copy-p
                            (phrasekey *csphrkey) ;; :PHR)  
                            (cslockey *cslockey) ;; :CSLOC)
                            (datakey *datakey)  ;; :DATA
                            (defkey *defkey) ;; :DEF
                            (desckey *desckey) ;; :DESC)
                            (max-desc-n 200)(max-def-n 200)
                            (clevkey :CLEV)(qtypekey :QT)
                            (sublistkey *sublistkey) ;; :S)
                            (csvalkey *csvalkey) ;;  :VA) HERENOW
                            (multivalkey *multivalkey)
                            (txtinputkey *txtinputkey)
                            (pcvalkey :CSVAL)
                            (pcrankey :CSRANK)
                            (pcbestpole-key :BESTPOLE)
                            (csrankey *csval-rank-key) (if-val-nil 'omit)  ;; :RNK
                            (incl-sublist-p *incl-sublist-in-treeviewer-nodes-p)
                            (incl-csloc-p *incl-csartloc-in-treeviewer-nodes-p)
                            (make-key-val-pairs-p T)
                            )
  "U-CS   RETURNS: When RETURN-NODE-TEXT-FIRST-P = (values return-info-text  all-info-keylist key-val-pairs keys values)); when (null make-text-info-p) = (values all-info-keylist key-val-pairs keys values)), T =  (values all-info-keylist key-val-pairs keys values).
         Used in making NODES for make-csym-treeviewer INPUT:  IF-VAL-NIL can be 'OMIT, NIL, or any value as default. 
  Note: For scales, :description used for csdef."
  (let*
      ((csymvals (eval-sym csym))
       (csymstr (car csymvals))
       (phrase (second csymvals))
       (csloc (third csymvals))
       (data  (fourth  csymvals))
       (def (fifth  csymvals)) ;;in practice used scale :description for def
       (desc (get-key-value desckey csymvals)) 
       (sublist (get-key-value sublistkey csymvals))
       (csval (get-key-value csvalkey csymvals))
       (csrank (get-key-value csrankey csymvals))
       (PCval (get-key-value pcvalkey csymvals))
       (PCrank (get-key-value pcrankey csymvals))
       (ans-data-list (get-key-value multivalkey csymvals))
       (txtinput (get-key-value txtinputkey csymvals))
       (PCbestpole (get-key-value pcbestpole-key csymvals))
       (clev (get-key-value clevkey csymvals))
       (qtype (get-key-value qtypekey csymvals))
       (all-info-keylist)
       (all-info-string "")
       (rest-key-list)
       (key-val-pairs)
       (restkey-pairs)(n-found-keys)(rest-keys)(flat-rest-pairs)
       (return-info-text)
       )
    ;;(BREAK "1")
    ;;OMIT potentially longer parts?
    (when omit-def-p
      (setf def nil))
    (when omit-desc-p
      (setf desc nil))
    (when omit-data-p
      (setf data nil))

    ;;(break)
    ;;max length of def & desc?
     (when (and max-def-n (sequencep def))
       (setf def (max-seq-n max-def-n def)))
     (when (and max-desc-n (sequencep desc))
       (setf desc (max-seq-n max-desc-n desc)))
     ;;rest-keys?
     (when rest-keys
       (multiple-value-setq (restkey-pairs  n-found-keys rest-keys flat-rest-pairs)
                                      (get-multi-keyvalues-in-nested-lists rest-keys csymvals
                                 :add-flat-keylist-p T :if-val-nil if-val-nil)))

     ;;MAKE THE KEY-VAL-PAIRS?
     (when make-key-val-pairs-p
       (setf key-val-pairs
             (list (list :name csymstr)(list phrasekey phrase)
                   (list cslockey csloc)))
       (when data
         (setf key-val-pairs (append key-val-pairs (list  (list :data data)))))
       (when def
         (setf key-val-pairs (append key-val-pairs (list  (list :def def)))))
       (when  csval
         (setf key-val-pairs (append key-val-pairs (list  (list csvalkey csval)))))
       (when csrank
         (setf key-val-pairs (append key-val-pairs (list (list csrankey csrank)))))     
       (when PCval
         (setf key-val-pairs (append key-val-pairs (list (list pcvalkey PCval)))))     
       (when PCrank
         (setf key-val-pairs (append key-val-pairs (list (list pcrankey PCrank)))))     
       (when ans-data-list
         (setf key-val-pairs (append key-val-pairs (list (list multivalkey ans-data-list)))))    
       (when txtinput
         (setf key-val-pairs (append key-val-pairs (list (list txtinputkey txtinput)))))
       (when PCbestpole
         (setf key-val-pairs (append key-val-pairs (list (list pcbestpole-key PCbestpole))))) 
       (when (and incl-sublist-p sublist)
         (setf key-val-pairs (append key-val-pairs (list (list sublistkey sublist)))))
       (when desc
         (setf key-val-pairs (append key-val-pairs (list (list desckey desc)))))
       (when clev
         (setf key-val-pairs (append key-val-pairs (list (list clevkey clev)))))
       (when qtype
         (setf key-val-pairs (append key-val-pairs (list (list qtypekey qtype)))))

       ;;MODIFY TO FLAT KEY LISTS
       (setf all-info-keylist (flatten-1-level key-val-pairs ))
       ;;end when
       )
     ;;GET KEYS and VALUES lists to return (for various purposes)
     (multiple-value-bind (keys values  )
         (set-syms-to-second key-val-pairs :set-sym-to-val-p NIL)
     ;;WHEN REST-KEYS FIND VALUES
     (when flat-rest-pairs
       (setf all-info-keylist (append all-info-keylist flat-rest-pairs)
             key-val-pairs (append key-val-pairs (list restkey-pairs))))  
     ;;MAKE-TEXT-INFO?
     (when (or make-text-info-p return-node-text-first-p)
       (cond
        (omit-some-nil-p
         (setf node-info-string (format nil "~A  ~S" csymstr phrase)) 
         (when csval 
           (setf node-info-string (format nil "~A :~A ~S"
                                          node-info-string csvalkey csval)))      
         ;;(BREAK)
         (when csrank
           (setf  node-info-string (format nil "~A :~A ~A"
                                           node-info-string csrankey csrank)))   
         (when PCval 
           (setf node-info-string (format nil "~A :~A ~S"
                                          node-info-string pcvalkey PCval)))    
         (when PCrank 
           (setf node-info-string (format nil "~A :~A ~S"
                                          node-info-string pcrankey PCrank)))  
         (when ans-data-list 
           (setf node-info-string (format nil "~A :~A ~S"
                                          node-info-string multivalkey ans-data-list)))
         (when txtinput 
           (setf node-info-string (format nil "~A :~A ~S"
                                          node-info-string txtinputkey txtinput)))
         (when PCbestpole 
           (setf node-info-string (format nil "~A :~A ~S"
                                          node-info-string pcbestpole-key PCbestpole)))  
         (when (and csloc incl-csloc-p)
           (setf node-info-string (format nil "~A ~A"
                                          node-info-string csloc)))
         (when def
           (setf node-info-string (format nil "~A ~S"
                                          node-info-string def)))
         (when desc 
           (setf node-info-string (format nil "~A ~S"
                                          node-info-string desc)))                                
         (when clev
           (setf node-info-string (format nil "~A :~A ~S"
                                       node-info-string clevkey clev)))
         (when qtype
           (setf node-info-string (format nil "~A :~A ~S"
                                       node-info-string qtypekey qtype)))
         )
        (t
         ;;modified for pcs
         (when PCval (setf csval pcval))
         (when PCrank (setf csrank PCrank))
         (setf all-info-string (format nil "~A ~S ~S :~A ~S ~S :A ~A :~A :~A :~A ~A :~A ~S"
                                       csymstr phrase csloc csvalkey csval def clevkey clev 
                                       qtypekey qtype csrankey csrank sublistkey  ))
         (setf node-info-string (format nil "~A ~S :~A ~S ~S :A ~A :~A :~A :~A ~A ~S"
                                        csymstr  csloc csvalkey  csval desc clevkey clev 
                                       qtypekey qtype csrankey csrank desc ))))
       ;;APPEND SUBLIST?
       (when (and sublist incl-sublist-p)
         (setf node-info-string (format nil "~A :~A ~S"
                                        node-info-string sublistkey sublist)
               all-info-string (format nil "~A :~A ~S"
                                        all-info-string sublistkey sublist)))

       ;;ALL KEYS or NODE INFO TEXT RETURNED?
       (cond        
        (return-node-text-first-p
         (setf return-info-text node-info-string))
       ;;incl other keys/info
       (incl-all-keys-p 
           (setf return-info-text (format nil "~S" all-info-keylist)))
       (return-csymvals-copy-p
         (setf return-info-text (format nil "~S" csymvals)))
       (T (setf return-info-text node-info-string)))
       ;;(BREAK)
       ;;incl-csymvals-p incls basic plus (nthcdr 4 csymvals)
       (when incl-csymvals-p 
         (setf return-info-text (format nil "~A; ~A"return-info-text (nthcdr 4 csymvals))))   
       ;;END when make-text-info-p
       )
     ;;RETURN
     (cond
      (return-node-text-first-p
       (values return-info-text  all-info-keylist key-val-pairs keys values))
      ((null make-text-info-p)
       (values all-info-keylist key-val-pairs keys values))
      (t  (values all-info-keylist key-val-pairs keys values return-info-text csym csval))) 
    ;;end mvb,let, get-csym-info
    )))
;;TEST
;; (get-csym-info '<sex)
;; works= "<SEX  \"Sex\" :TXT \"Male\" $BIO.<SEX \"Sex\" :QT :TEXT"    (:NAME "<SEX" :PHR "Sex" :CSLOC $BIO.<SEX :DEF "Sex" :TXT "Male" :QT :TEXT)    ((:NAME "<SEX") (:PHR "Sex") (:CSLOC $BIO.<SEX) (:DEF "Sex") (:TXT "Male") (:QT :TEXT))   (:NAME :PHR :CSLOC :DEF :TXT :QT)    ("<SEX" "Sex" $BIO.<SEX "Sex" "Male" :TEXT)
;; (get-csym-info '<WOVGOODF :make-text-info-p T)
;;  (get-csym-info '<sworldview :make-text-info-p T)
;; works= 
#|"<SWORLDVIEW  \"Positive World View\" :VA 0.926 $SC.$BV.$WV.<SWORLDVIEW \"Optimism about the future of the world and own life, lack of entitlement thinking, plus daily positive versus negative thoughts. How constructively and positively you view the world and the future can\" :QT :SCALE"
(:NAME "<SWORLDVIEW" :PHR "Positive World View" :CSLOC $SC.$BV.$WV.<SWORLDVIEW :DEF "Optimism about the future of the world and own life, lack of entitlement thinking, plus daily positive versus negative thoughts. How constructively and positively you view the world and the future can" :VA 0.926 :QT :SCALE)
((:NAME "<SWORLDVIEW") (:PHR "Positive World View") (:CSLOC $SC.$BV.$WV.<SWORLDVIEW) (:DEF "Optimism about the future of the world and own life, lack of entitlement thinking, plus daily positive versus negative thoughts. How constructively and positively you view the world and the future can") (:VA 0.926) (:QT :SCALE))
(:NAME :PHR :CSLOC :DEF :VA :QT)
("<SWORLDVIEW" "Positive World View" $SC.$BV.$WV.<SWORLDVIEW "Optimism about the future of the world and own life, lack of entitlement thinking, plus daily positive versus negative thoughts. How constructively and positively you view the world and the future can" 0.926 :SCALE)|#
;; (get-csym-info 'autonomous :make-text-info-p T)
;; (:NAME "AUTONOMOUS" :PHR "AUTONOMOUS vs NOT AUTONOMOUS" :CSLOC CS2-1-1-99 :va "0.917" :RNK 10 :DESC "AUTONOMOUS vs NOT AUTONOMOUS")
;; ((:NAME "AUTONOMOUS") (:PHR "AUTONOMOUS vs NOT AUTONOMOUS") (:CSLOC CS2-1-1-99) (:va "0.917") (:RNK 10) (:DESC "AUTONOMOUS vs NOT AUTONOMOUS"))
;; RETURN NILs
;; (setf testsym99 '("testsym99" "testsym99 phr" "$CS.testsym99" '(data) nil :desc "This is descrip"  :va .99  :S :rnk 11 :qt :scale :clev 4 (sub1 sub2)))
;; (get-csym-info 'testsym99 :if-val-nil nil)
;; WORKS W QUOTES (:NAME "name" :PHR "phr" :CSLOC "csloc" :DATA (QUOTE (DATA)) :va 0.99)
;; ((:NAME "name") (:PHR "phr") (:CSLOC "csloc") (:DATA (QUOTE (DATA))) (:va 0.99))
;; (setf testsym99 '("name" "phr" "csloc" (data) nil :desc nil  :va .99  :S nil))
;; works w/o quotes too:   (:NAME "name" :PHR "phr" :CSLOC "csloc" :DATA (DATA) :va 0.99)
;; ((:NAME "name") (:PHR "phr") (:CSLOC "csloc") (:DATA (DATA)) (:va 0.99))






;;MAKE-PC
;;2019 Changed to make bestpole the csym name pole.
;;
;;ddd
(defun make-pc (pole1 pole2 bestpole value  &key pcsym pcname 
                      pcphrase pcdata rev-poles-p
                      pcart-loc pcdef  info system  BIPATH  (min-sym-length 5)
                      (supsys '$PC) topdim dims (last-dim :csym)
                      (csartloc-origin :supsys-csym) supsys-csartloc
  ;;SSSSSS MAKES LONG CHAINS :supsys-csartloc) (supsys-csartloc '$PC)
 ;;EG CSARTLOC= $MIS-MISC-$P.$CS.$MIS-NIL-NIL-QT-SYS-CLEV-1-S-MOTHER-FATHER-BEST-M-FRIEND-BEST-F-FRIEND-M-DISLIKE-F-DISLIKE-M-ADMIRE-F-ADMIRE-PER-MOSTFUN-PER-ROMANCE-ROLE-MODEL-CHILD-FRIEND-CHILD-DISLIKE-WORK-FRIEND-WORK-PER-DISLIKE-FAV-BOSS-WORST-BOSS-FAV-M-STAR-FAV-POLITICO-FAV-TEACHER-FAV-SPIRITUAL-DIS-TEACHER-TEACHER-POLICEMAN-SALESPERSON-DOCTOR-LAWYER-BUSINESS-OWNER-MANAGER-SCIENTIST-FARMER-DRUG-DEALER-POLITICIAN-DANCER-ARTIST-COMEDIAN-ENGINEER-HOUSE-CLEANER-MOVIE-STAR-ROCK-STAR-CHURCH-MINISTER-CATHOLICS-PROTESTANTS-JEWS-MUSLIMS-BUDDHISTS-ATHEISTS-ANGLOS-HISPANICS-BLACKS-ASIANS-MOST-IMPORTANT-VALUE-MOST-IMPORTANT-ABILITY-MOST-IMPORTANT-BELIEF-YOUR-PERSONALITY-YOUR-BEST-CHARACTERISTIC-YOUR-POSSESSIONS-YOUR-WORST-CHARACTERISTIC
                      (max-sym-length 18) 
                      restkeys (if-exists-do-nothing-p T) (update-dims-dimsym :C) )
  "U-CS, makes a new PC node (inside of an ART type network with csartloc symbol Uses make-csym function.  RESTKEYS allows a list of keylists eg. ((key1 value1)(key2 value2) etc). Should be a standard key such as :to :from :wto :wfrom. RETURNS (values pcsymvals pcsym). 2019 Makes bestpole pole1"     
  (let*
      ((pclist (list pole1  pole2 bestpole value)) ;;not used?
       ;;2019 make pole1 the bestpole
       (rev (when (= bestpole 2) T))
       (newpole1   (when bestpole   (cond ((equal bestpole 1) pole1)(t pole2))))
       (newpole2 (cond ((equal newpole1 pole1) pole2) (t pole1)))
       (newbestpole 1)
       (len-newpole1 (length newpole1))
       (pcsymvals) 
       (similar-sym)       
       )
    (unless pcphrase
      (setf pcphrase (format nil "~A vs ~A" newpole1 newpole2)))

    (unless pcsym
      (multiple-value-setq (pcsym pcname similar-sym pcymvals)
          (make-condensed-sym newpole1 :max-length max-sym-length
                                          :min-length min-sym-length))
#|      (setf pcname (make-condensed-string newpole1 :max-length max-sym-length
                                          :min-length min-sym-length))
      (multiple-value-setq (pcsym pcname similar-sym pcymvals)
          (make-condensed-sym pcname :max-length max-sym-length
                                          :min-length min-sym-length))   |#
      ;;end unless
      )
    (cond
     ((and if-exists-do-nothing-p pcsym (boundp pcsym)(listp (eval pcsym))
           (>  (list-length (eval pcsym)) 2))
      ;;(break "after and")
      ;;do nothing
      (setf pcsymvals (eval pcsym))
      )
     ;;IF SYM DOESN'T EXIST (or (null if-exists-do-nothing-p))
     (t
      ;;The real work function
      (multiple-value-setq (pcsymvals pcsym)
          (make-csym pcsym pcphrase  pcdata pcdef :pclist pclist
                     :new-csartloc pcart-loc :supsys supsys
                     :csartloc-origin csartloc-origin 
                     :supsys-csartloc supsys-csartloc 
                     :topdim topdim :dims dims :last-dim last-dim
                     :pole1 newpole1 :pole2 newpole2 :bestpole newbestpole
                     :rev-poles-p rev-poles-p
                     :info info :system system
                     :BIPATH BIPATH
                     ;;not used :default-csart-rootstr *default-csart-rootstr
                      :dim-separator *art-index-separator
                     :node-separator *art-node-separator :restkeys restkeys
                     :if-csym-exists :modify
                     ))
      ;;(break "after make-csym")
      ;;end t, cond
      ))
    (values pcsymvals pcsym)
    ;;end let, make-pc
    ))
;;TEST
;; (make-pc "very hot" "cold" 2 .9 :pcphrase "very hot phrase" :BIPATH '((path1 xx)(path2 xx)) )
;; works=  ("VERYHOT2" "very hot phrase" CS2-1-1-99 NIL NIL :PC ("very hot" "cold" 1 0.9) :POLE1 "very hot" :POLE2 "cold" :BESTPOLE 1 :BIPATH ((PATH1 XX) (PATH2 XX)))     VERYHOT2
;;ALSO  VERYHOT2 =>  ("VERYHOT2" "very hot phrase" CS2-1-1-99 NIL NIL :PC ("very hot" "cold" 1 0.9) :POLE1 "very hot" :POLE2 "cold" :BESTPOLE 1 :BIPATH ((PATH1 XX) (PATH2 XX)))
;; AND   CS2-1-1-99  =>  ("CS" (2 1 1 99) NIL VERYHOT2 NIL)
;;
;;  (make-pc  "very cold" "not" "Way 2 alike better" nil)
;;   (make-pc  "very funny" "not" "Way 2 alike better" nil)
;;  ;;  (make-pc  "independent" "dependent" "Way 2 alike better" nil)
;;  (make-pc  "more independent" "less independent" "Way 2 alike better" nil)
;;  (make-pc "lucky" "unlucky""Way 2 alike better" nil     :pcdata '(pcdata)  :pcdef "pc definition" :info "info":BIPATH '("BIPATH"))
;; results=  ("LUCKY" "lucky vs unlucky" CS1-1-1-1 (PCDATA) "pc definition" :PC ("lucky" "unlucky" NIL) :INFO "info" :BIPATH ("BIPATH"))    LUCKY
;;also 
;;CL-USER 146 > LUCKY  =  ("LUCKY" "lucky vs unlucky" CS1-1-1-1 (PCDATA) "pc definition" :PC ("lucky" "unlucky" NIL) :INFO "info" :BIPATH ("BIPATH"))
;;CL-USER 147 > CS1-1-1-1  =  ("CS" (1 1 1 1) NIL LUCKY NIL)

#| PRE-SYSTEM VERSION
(defun make-pc (pole1 pole2 bestpole value  &key pcsym pcname  pcphrase pcdata
                      pcart-loc pcdef  info  BIPATH  (min-sym-length 5)(max-sym-length 18) 
                      restkeys (if-exists-do-nothing-p T) (update-dims-dimsym :C) )
  "U-CS, makes a new PC node (inside of an ART type network with csartloc symbol Uses make-csym function.  RESTKEYS allows a list of keylists eg. ((key1 value1)(key2 value2) etc). Should be a standard key such as :to :from :wto :wfrom. RETURNS (values pcsymvals pcsym)."
  (let*
      ((pclist (list pole1  pole2 bestpole value)) ;;not used?
       (len-pole1 (length pole1))
       (pcsymvals) 
       (similar-sym)
       
       )
    (unless pcphrase
      (setf pcphrase (format nil "~A vs ~A" pole1 pole2)))

    (unless pcsym
      (multiple-value-setq (pcsym pcname similar-sym pcymvals)
          (make-condensed-sym pole1 :max-length max-sym-length
                                          :min-length min-sym-length))
#|      (setf pcname (make-condensed-string pole1 :max-length max-sym-length
                                          :min-length min-sym-length))
      (multiple-value-setq (pcsym pcname similar-sym pcymvals)
          (make-condensed-sym pcname :max-length max-sym-length
                                          :min-length min-sym-length))   |#
      ;;end unless
      )

    (cond
     ((and if-exists-do-nothing-p pcsym (boundp pcsym)(listp (eval pcsym))
           (>  (list-length (eval pcsym)) 2))
      ;;(break "after and")
      ;;do nothing
      (setf pcsymvals (eval pcsym))
      )
     ;;IF SYM DOESN'T EXIST (or (null if-exists-do-nothing-p))
     (t
      ;;update the *cur-csartdims
      (setf *cur-csartdims (incf-artdims *cur-csartdims update-dims-dimsym))
      ;;The real work function
      (multiple-value-setq (pcsymvals pcsym)
          (make-csym pcsym pcphrase pcart-loc pcdata pcdef :pclist pclist
                     :pole1 pole1 :pole2 pole2 :bestpole bestpole
                     :info info :BIPATH BIPATH :default-csart-rootstr *default-csart-rootstr
                     :cur-csartdims *cur-csartdims :separator *art-index-separator
                     :node-separator *art-node-separator :restkeys restkeys
                     :if-exists-do-nothing-p if-exists-do-nothing-p
                     ))
      ;;(break "after make-csym")
      ;;end t, cond
      ))
    (values pcsymvals pcsym)
    ;;end let, make-pc
    ))|#




;;MAKE-ELMSYMS-- NOT USED--
;;REPLACED BY MAKE-ELMSYMS-FROM QVARS?
;;
;;ddd
#|(defun make-elmsyms (elminfo-list &key if-exists-reset-p (if-exists-do-nothing-p T)
                                  keylists)
  "In U-CS. If elminfo-list is a list of BIPATH, makes elms with BIPATH. If list of strings, makes elms w/o BIPATH. Does not use longstring, uses exact element name in elminfo to make syms. RETURNS (values elmsyms elmsymvals)"
  (let
      ((elmsym)
       (elmsyms)
       (elsymvals)
       (elmsymvals)
       (BIPATH)
       )
    (loop
     for elminfo in elminfo-list
     do
     (cond
      ;;must be BIPATH (w elm-str included extra)
      ((listp elminfo)
       (setf elm-str (car elminfo)
             BIPATH (cddr elminfo)))
       (t (setf elm-str elminfo)))

     (multiple-value-setq (elsymvals elmsym)
         (make-elmsym nil  nil :elm-name elm-str :BIPATH BIPATH
                      :if-exists-reset-p if-exists-reset-p
                      :if-exists-do-nothing-p if-exists-do-nothing-p ))
     (setf elm-syms (append elmsyms (list elmsym))
           elmsymvals (append elmsymvals (list elsymvals)))
     ;;end loop
     )
    (values elmsyms elmsymvals)
    ;;end let, make-elm-syms
    ))|#
;;TEST
;; (make-elmsyms '("mother" "father" "best-m-friend"))
;;works= (MOTHER4 FATHER4 BEST-M-FRIEND)   (("MOTHER4" "mother" CS1-1-1-1 NIL NIL) ("FATHER4" "father" CS1-1-1-1 NIL NIL) ("BEST-M-FRIEND" "best-m-friend" CS1-1-1-1 NIL NIL))    
;;for BIPATH
;;  (make-elmsyms '(("mother" NIL (TEST-PCSYM (POLE1) NIL)) ("best-m-friend" NIL (TEST-PCSYM (POLE1) NIL)) ("father" NIL (TEST-PCSYM (POLE2) NIL))))




;;MAKE-ELMSYM
;;
;;ddd
(defun make-elmsym (sym-long-str value  &key elmsym elm-name 
                                 elm-phrase elm-data  elm-def 
                                 (supsys '$ELM) topdim dims (last-dim :csym)                                   
                                 csartloc (csartloc-origin :supsys-csartloc)
                                 (supsys-csartloc '$ELM)
                                 info BIPATH  (min-sym-length 5)(max-sym-length 30) 
                                 restkeys    (if-exists-reset-p T) if-exists-do-nothing-p
                                 (detail-data-list '*CSQ-elmsym-lists))
  "U-CS, makes a new ELEMENT node (inside of an ART type network with csartloc symbol. Uses make-csym function. sym-long-str can simple-name or longer phrase  that is condensed.  RESTKEYS allows a list of keylists eg. ((key1 value1)(key2 value2) etc). Should be a standard key such as :to :from :wto :wfrom.   RETURNS (values elmsym elmsymvals similar-sym csartloc csartloc-vals).  If detail-data-list, the appends redundant-detail info needed to begin CSQ at point where discontinued. IF-EXISTS-RESET-P resets only elmsym not art node to value (and takes precedence over if-exists-do-nothing-p."
  (let*
      ((elmsymvals)     
       (similar-sym)
       (elmsym-exists-p)
       (if-csym-exists)
       (csartloc1)
       (csartloc-vals)
       )
    (cond
     ;;if null sym-long-str, use elm-name or elmsym for sym name
     ((and (null sym-long-str) elmsym) 
      (setf sym-long-str (format nil "~A" elmsym)))
     ((and (null sym-long-str) elm-name) 
      ;;does not check for existence of symbol (should I?)
      (setf elmsym (my-make-cs-symbol elm-name)
            sym-long-str (format nil "~A" elmsym)))
     ((and sym-long-str (symbolp sym-long-str)
           (boundp sym-long-str))
      (setf elmsym sym-long-str
            sym-long-str (format nil "~A" sym-long-str)))
     (t nil))

    (when (boundp elmsym)
      (setf elmsymvals (eval elmsym)))

    ;;TEST TO SEE IF ELMSYM EXISTS AND SET TO A LIST > 2
    (when (and (listp elmsymvals)
             (> (list-length elmsymvals) 2))
        ;;set the sym to sym-long-str and eval it
        (setf elmsym-exists-p T))

      ;;ELM-PHRASE
      (unless elm-phrase
        (cond 
         (sym-long-str
          (setf elm-phrase sym-long-str))
         (elm-name
          (setf elm-phrase elm-name))
         (t (setf elm-phrase (format nil "~A" elmsym))))
        ;;end unless
        )

      ;;MAKE NEW ELMSYM IF DOESN'T EXIST
      (unless elmsym
        ;;make name string
        (setf elm-name (make-condensed-string sym-long-str
                                              :max-length max-sym-length :min-length min-sym-length))

        ;;make elmsym, but do not set to value (or make-csym won't work right)
        (multiple-value-setq (elmsym elm-name similar-sym) ;;not needed? csymvals)
            (make-condensed-sym elm-name :set-to-value-p NIL
                                :min-length min-sym-length :max-length max-sym-length))   
        ;;end unless
        )
      (unless elm-name
        (setf elm-name (format nil "~A" elmsym)))        

      ;;(BREAK "B2")

      ;;IF RESET OR SETTING NEW SYM AND SYMVALS
      ;;The real work function adding elmsymvals
      ;;must translate if-exists-do-nothing-p for make-csym
      (cond (if-exists-do-nothing-p (setf if-csym-exists :do-nothing))
            (t (setf if-csym-exists :replace)))

      ;;MAKE THE NEW ELM CSYM
      (multiple-value-setq (elmsymvals elmsym) 
          (make-csym elmsym elm-phrase  elm-data elm-def 
                     :new-csartloc csartloc 
                      :supsys supsys :topdim topdim :dims dims :last-dim last-dim
                     :csartloc-origin csartloc-origin :supsys-csartloc supsys-csartloc
                      :supsys supsys
                     :info info :BIPATH BIPATH
                     ;;not used :default-csart-rootstr *default-csart-rootstr
                     :dim-separator *art-index-separator
                     :node-separator *art-node-separator :restkeys restkeys
                     ;;see above translation  :do-nothing :replace :modify
                     :if-csym-exists  if-csym-exists
                     ))

      ;;store elmsym info in serial form to store to file?
      (when (and detail-data-list elmsymvals)
        (set detail-data-list (append (eval detail-data-list) (list (list elmsym elmsymvals)))))
      ;;(BREAK "B3")               
      (values elmsym elmsymvals similar-sym)
      ;;end let, make-elmsym
      ))
;;TEST
;;  (make-elmsym  "mother" nil)
;; works= ("MOTHER7" "mother" CS1-1-1-1 NIL NIL)    MOTHER7
;; (make-elmsym "newnameXX" nil :elm-phrase "qphrase")
;; (make-elmsym "glowABcdefgh" nil :elm-phrase "qphrase")
;; works= GLOWABCDEFGH   ("GLOWABCDEFGH" "qphrase" CS1-1-1-1 NIL NIL)   NIL
;;also GLOWABCDEFGH = ("GLOWABCDEFGH" "qphrase" CS1-1-1-1 NIL NIL)
;;
;;reset
;;  (make-elmsym  "mother" nil :if-exists-do-nothing-p nil ::if-exists-reset-p t)
;; works= MOTHER   ("MOTHER" "mother" CS1-1-1-1 NIL NIL)   NIL
;;also
;; CL-USER 62 > mother =  ("MOTHER" "mother" CS1-1-1-1 NIL NIL)


;;RESET-ALL-ELMS
;;
;;ddd
(defun reset-all-elms (&key (all-elms *all-pc-element-qvars))
  "In U-CS, resets all elms to initialization values. RETURNS (values elmsyms type-list)"
  (make-elmsyms-from-qvars all-elms ::if-exists-reset-p T  :if-exists-do-nothing-p NIL)
  )
;; (reset-all-elms)


;;MAKE-ELMSYMS-FROM-QVARS
;;
;;ddd
(defun make-elmsyms-from-qvars (all-qvars-list &key
                                            (if-exists-reset-p T) if-exists-do-nothing-p
                                         csartloc (csartloc-origin :supsys-csartloc)
                                         (supsys-csartloc '$ELM))
                                           ;;( init-art-dims *init-CSart-elment-dims)
  "In U-CS. INPUT= a list of qvarlists as nested lists of qvar-types. Makes new elmsyms. If make-art-elm-network-p, Makes an ART network framework. RETURNS (values elmsyms type-list). if-exists-do-nothing-p has priority over resetting. ALSO SETS *type-name-elms list to each type elmsyms list.  :IF-EXISTS-RESET-P resets only elmsym not art node to value (and takes precedence over if-exists-do-nothing-p"
  (let
      ((type)
       (type-list)
       (qvarlist)
       (qvar)
       (elmsyms)
       ;;(dims) ;; init-art-dims)
       (num-qvars 0)
       (artsym)
       (artsyms)
       )

    (loop
     for qvartype-list  in all-qvars-list
     do
     (setf type (car qvartype-list)
           type-list (append type-list (list type))
           qvarlists (cdr qvartype-list))

     (loop
      for qvarlist in qvarlists
      do
      (when (listp qvarlist)
        (multiple-value-bind (qname qphrase qtype qdata)
            (values-list qvarlist)

          (setf qvar (my-make-cs-symbol qname))

          ;;UNBIND PREVIOUS QVAR?
          (when (and :if-exists-reset-p (symbol-listp qvar))
            (makunbound qvar))
          
          ;;find already made artsym in network and use to set to values
#|   depreciated       (setf dims (incf-artdims dims :I)
                artsym (car (make-artsyms-from-dims *cs-elm-rootsr (list dims))))|#

          ;;(break "in loop after working on qvar")
          (setf elmsym (make-elmsym qname nil :elm-phrase qphrase
                                     :csartloc csartloc :csartloc-origin csartloc-origin
                                     :supsys-csartloc supsys-csartloc
                                      :if-exists-reset-p if-exists-reset-p
                                     :if-exists-do-nothing-p if-exists-do-nothing-p )
                elmsyms (append elmsyms (list elmsym)))
          ;;vvv
          ;;end when,mvb, inner loop
          )))

         ;;SET GLOBAL VAR TO TYPE
          (setf type-name (format nil "*~A-elmsyms" type)
                type-sym (my-make-cs-symbol type-name))

          (set type-sym elmsyms)
     ;;end outer loop
     )
    (values elmsyms type-list)
    ;;end let, make-elmsyms-from-qvars
    ))
;;TEST
;; (make-elmsyms-from-qvars *all-PC-element-qvars)  







;;FIND-POLE-ELM-LINKS
;;
;;ddd
(defun find-pcpole-elm-links (pcsym 3elements alike-button-selections
                                        dif-button-selection)
  "In U-CS, used within callback to link text-input1 with the 2 elements selected as alike, and text-input2 with the element selected as different. RETURNS (values pole1-alike-elms  pole2-dif-elms pc-BIPATH-list elm-BIPATH-lists)."
  (let*
      ((pole1-alike-elms)
       (pole2-dif-elms)
       (pole1-paths)
       (pole2-paths)
       (pc-BIPATH-list)
       (elm-BIPATH-list)
       )
    
      (when (member "item 1" alike-button-selections :test 'string-equal)
       (setf  pole1-alike-elms (list (first 3elements))))
      (when (member "item 2" alike-button-selections :test 'string-equal)
       (setf  pole1-alike-elms (append pole1-alike-elms (list (second 3elements)))))
      (when (member "item 3" alike-button-selections :test 'string-equal)
       (setf  pole1-alike-elms (append pole1-alike-elms (list (third 3elements)))))
      (when (member "item 1" dif-button-selection :test 'string-equal)
       (setf  pole2-dif-elms (list  (first 3elements))))
      (when (member "item 2" dif-button-selection :test 'string-equal)
       (setf  pole2-dif-elms  (list  (second 3elements))))
      (when (member "item 3" dif-button-selection :test 'string-equal)
       (setf  pole2-dif-elms  (list  (third 3elements))))


        (setf  pc-BIPATH-list  (list (list 'pole1 nil (car pole1-alike-elms) nil)(list 'pole1 nil  (second pole1-alike-elms) NIL)(list 'pole2 nil (car pole2-dif-elms) nil)))

        (setf elm-BIPATH-lists
              (list (list (car pole1-alike-elms) nil (list pcsym '(pole1)NIL))
               (list (second pole1-alike-elms) nil (list pcsym '(pole1)NIL))
               (list (car pole2-dif-elms) nil (list pcsym '(pole2) NIL))))

        (values pole1-alike-elms  pole2-dif-elms pc-BIPATH-list elm-BIPATH-lists)

      ;;end let, find-pcpole-elm-links
      ))
;;TEST
;;  (find-pcpole-elm-links 'TEST-PCSYM '("mother" "father" "best-m-friend") '("item 1" "item 3") '("item 2")   )) 
;;works=("mother" "best-m-friend")   ("father")   ((POLE1 NIL "mother" NIL) (POLE1 NIL "best-m-friend" NIL) (POLE2 NIL "father" NIL))        (("mother" NIL (TEST-PCSYM (POLE1) NIL)) ("best-m-friend" NIL (TEST-PCSYM (POLE1) NIL)) ("father" NIL (TEST-PCSYM (POLE2) NIL)))





;;ADD-ELM-BIPATH
;;
;;ddd
(defun add-pcs-to-elm-BIPATH (elm-BIPATH)
  "In U-CS"
  (let
      ((elmsyms)
       (elmsym)
       (elmsymvals)
       )
    (loop
     for pathlist in elm-BIPATH
     do
     (setf elmsym  (my-make-cs-symbol (car pathlist))
           elmsymvals (eval elmsym))
     (when elmsym
          (setf elmsyms (append elmsyms (list elmsym))
      elmsymvals (append-key-value-in-list :BIPATH (list pathlist) elmsymvals                                 :append-as-flatlist-p NIL 
                                 :append-first-as-flatlist-p T  :list-first-value-p T)))
     ;;(break "after append")
     (when elmsym
       (set elmsym elmsymvals))
     ;;end loop
     )
    (values elmsyms elmsymvals)
    ;;end let, add-elm-BIPATH
    ))
;;TEST
;;  (add-pcs-to-elm-BIPATH '(("mother" NIL (TEST-PCSYM (POLE1) NIL)) ("best-m-friend" NIL (TEST-PCSYM (POLE1) NIL)) ("father" NIL (TEST-PCSYM (POLE2) NIL))))
;;works=  (MOTHER BEST-M-FRIEND FATHER)
;;("FATHER" "father" ELM3-1-1-99 NIL NIL :BIPATH ("father" NIL (TEST-PCSYM (POLE2) NIL)))
;; CL-USER 76 > mother = ("MOTHER" "mother" ELM2-1-1-99 NIL NIL :BIPATH ("mother" NIL (TEST-PCSYM (POLE1) NIL)))
;; CL-USER 77 > best-m-friend  =  ("BEST-M-FRIEND" "best-m-friend" ELM4-1-1-99 NIL NIL :BIPATH ("best-m-friend" NIL (TEST-PCSYM (POLE1) NIL)))
;;
;;then append more paths
;;  (add-pcs-to-elm-BIPATH '(("mother" NIL (NEW-PCSYM (POLE1) NIL)) ("best-m-friend" NIL (NEW-PCSYM (POLE1) NIL)) ("father" NIL (NEW-PCSYM (POLE2) NIL))))         





;;SET-CSYM-KEYVALUE
;;
;;ddd
;;
;;THIS FUNCTION NOT NEEDED, ENTIRELY PRECLUDED BY 
;;   SET-KEY-VALUE  and APPEND-KEY-VALUE FUNCTIONS

;;TEST FOR SET-KEY-VALUE
;; (setf mother '("MOTHER" "mother" CS1-1-1-1 (datalist this :key1 "that") NIL :info "this is info" :key3 (a b c)))
;;  for datalist key item
;;  (set-key-value :key1 "NEW-VALUE" mother)
;; works= ("MOTHER" "mother" CS1-1-1-1 (DATALIST THIS :KEY1 "NEW-VALUE") NIL :INFO "this is info" :KEY3 (A B C))   :KEY1  "that"  (:KEY1 "NEW-VALUE")
;;for flatlist key item
;;  (set-key-value :info "NEW-FLAT-VALUE" mother)
;; works= ("MOTHER" "mother" CS1-1-1-1 (DATALIST THIS :KEY1 "that") NIL :INFO "NEW-FLAT-VALUE" :KEY3 (A B C))   :INFO    "this is info"    (:INFO "NEW-FLAT-VALUE")



;; (replace-list mother 3 '(datalist REPLACEMENT)) = ("MOTHER" "mother" CS1-1-1-1 (DATALIST REPLACEMENT) NIL :INFO "this is info" :KEY3 (A B C))




;;GET-ELMSYM-QUEST-TEXT
;;
;;ddd
(defun get-elmsym-quest-text (elmsym)
  "In U-CS. RETURNS (values  qtext q-text-sym q-text-list q-title q-instr).Uses specific name if value of elmsym set to a name, or default text in Q text null value. "
  (let
      ;;if elmsym value set to a SPECIFIC (eg person) NAME
      ((qtext (fifth (eval elmsym)))
       ) 
    (multiple-value-bind ( q-text-sym q-text-list q-title q-instr)
        (get-question-text elmsym)
     
      ;;If not a name, then use default text
      (when (null qtext)
        (setf qtext (car q-text-list)))

    (values  qtext q-text-sym q-text-list q-title q-instr)    
    ;;end let, get-elmsym-quest-text
    )))
;;TEST
;;  (get-elmsym-quest-text 'MOTHER)
;; "Your Mother [or person most like a mother to you]"   MOTHERQ  ("Your Mother [or person most like a mother to you]")  "People Important To You"   "Write the (first + last name initial) NAME of a person that fits the description well. DO NOT use the same person twice!"





;;MAKE-ELMSYM-COMPARE-LISTS
;;
;;ddd
(defun make-elmsym-compare-lists (&key (all-elmsyms *all-elmsyms)
                                       (global-combos-sym  '*all-elmsym-compare-combos)
                                       compare-within-categories
                                       use-make-combos-from-lists-p
                                       return-every-nth
                                       random-sample-percent
                                       randomize-p
                                       (randomize-min-combo-n 20)
                                       return-all-combos-p
                                       (prefix "") (postfix ""))
  "In U-CS.  Takes large all-elmsyms list and makes combos of items 1, 2, 3; 4,5,6; etc until all-elmsyms used.  If compare-within-categories (must be list of  qvar categories), creates these combos WITHIN each category list. If  return-every-nth, return-combos is every nth. If  random-sample-percent, return-combos is a that percent chosen randomly.  If randomize-p, randomizes the result. If extra elmsyms,  adds item 1, etc from top of list. Note: Using make-combos creates huge number of comparisons. RETURNS (values global-combos-sym n-combos all-return-combos all-combos )"
  (let*
      ((elmsym-lists)
       (combo-lists) 
       (remainders)
       (nth 0)
       (combo)
       (n-combos)       
       (return-combos)
       (all-return-combos)
       (cat-combos)
       (all-combos)
       (elmsyms)
       (catsyms-lists)
       (combos-sym)
       )
    (cond
     ;;RANDOMIZE AND/OR SAMPLE PERCENT
     ((or randomize-p random-sample-percent return-every-nth)

      ;;COMPARE-WITHIN-CATEGORIES OR COMPARE ACROSS ALL-ELMSYMS
      (cond
       (compare-within-categories
        (loop
         for cat in compare-within-categories
         do
         (setf elmsyms (nth-value 1 (get-category-qvar-names cat))
               elmsym-lists (append elmsym-lists (list elmsyms)))
         ;;end loop, compare-within-categories
         )
        (setf elmsyms nil)  ;;RESET
        )
       (t (setf elmsym-lists (list all-elmsyms))))       
      
      ;;(BREAK "1")
      ;;MAKE THE COMBOS for each cat (only 1 cat unless compare-within-categories
      (loop
       for elmsyms in elmsym-lists
       do
       (multiple-value-setq (return-combos n-combos combos-sym cat-combos)
           (make-combos elmsyms 3 :global-combos-sym NIL
                        :return-all-combos-p return-all-combos-p
                        :return-every-nth return-every-nth
                        :random-sample-percent random-sample-percent
                        :randomize-p randomize-p
                        :randomize-min-combo-n randomize-min-combo-n
                        :return-all-combos-p return-all-combos-p 
                        :prefix prefix :postfix postfix  ))
       ;;make one combined flat list
       (setf all-return-combos (append all-return-combos return-combos))
       (unless (equal all-combos 'ALL-COMBOS-NOT-RETURNED)
             (setf all-combos (append all-combos cat-combos)))
       ;;end loop
       )
      ;;(BREAK "2")
      (when global-combos-sym
        (set global-combos-sym all-return-combos))

      (setf n-combos (list-length all-return-combos))
     ;; (break "make-combos")

     ;;END (or randomize-p random-sample-percent return-every-nth)
      )

     ;;USE-MAKE-COMBOS-FROM-LISTS-P
     (use-make-combos-from-lists-p  

      ;;DIVIDE INTO 3 LISTS TO PICK ELEMENTS FROM EACH LIST
      (setf elmsym-lists (divide-list-in-order all-elmsyms 3))

      ;;MAKE THE COMBOS
      (multiple-value-setq (combo-lists remainders)
          (make-combos-from-lists elmsym-lists))

      ;; SSSS START HERE TESTING--USE       (group-by-nth ON REMAINDERS
     (when remainders
        ;;(setf remainders (delete-duplicates remainders :test 'equal))
        (loop
         for rem in remainders
         do
         (cond
          ((null rem) NIL)
#|          ((and rem (not (listp rem)))
           (setf combo (list rem  (nth nth all-elmsyms) (nth (+ nth 1) all-elmsyms))
                 nth (+ nth 2)
                 combo-lists (append combo-lists (list combo))))|#
          ((and rem (listp rem))
           (cond
            ((= (list-length rem) 2)
             (setf combo (append rem (nth nth all-elmsyms))
                   combo-lists (append combo-lists (list combo)))
             (incf nth))
            (t (setf combo (append rem (list (nth nth all-elmsyms) (nth (+ nth 1) all-elmsyms)))
                     nth (+ nth 2)
                     combo-lists (append combo-lists (list combo))))))
          (t nil))
       
         ;; (break "2")
         ;;end loop, when remainders
         ))
      (setf n-combos (+ *n-people-combos *n-group-combos *n-self-combos)
            all-return-combos combo-lists)
      ;;end use-make-combos-from-lists-p
      )    
     (t nil))

    (values global-combos-sym n-combos all-return-combos all-combos )
    ;;end let,make-elmsym-compare-lists
    ))
;;TEST
;;  (make-elmsym-compare-lists  :all-elmsyms  '(A B C D E F G H I J K L M N O P) :return-every-nth 20)
;; works=  *ALL-ELMSYM-COMPARE-COMBOS     28       ((A B C) (A C J) (A E G) (A G H) (A I M) (A M O) (B D G) (B E P) (B H I) (B J P) (C D I) (C F H) (C H K) (C K M) (D E L) (D G M) (D J L) (E F G) (E H J) (E K L) (F G M) (F J L) (G H I) (G J P) (H I N) (H M P) (I M O) (K L M))      ALL-COMBOS-NOT-RETURNED
;;TEST--USING REAL DATA

;; SSS START HERE TESTING
;;  (make-elmsym-compare-lists  :global-combos-sym  '*all-elmsym-compare-combos :compare-within-categories '(PCE-PEOPLE PCE-GROUPS PCE-SELF) :return-every-nth 20  :random-sample-percent NIL  :randomize-p NIL :return-all-combos-p NIL) 
;; FOR A TEST SAMPLE
;; (setf *all-elmsymsX '(MOTHER FATHER BEST-M-FRIEND BEST-F-FRIEND M-DISLIKE F-DISLIKE M-ADMIRE F-ADMIRE PER-MOSTFUN PER-ROMANCE ROLE-MODEL))
;;(make-elmsym-compare-lists :all-elmsyms *all-elmsymsX :return-every-nth 12)
;;works= *ALL-ELMSYM-COMPARE-COMBOS   14     ((MOTHER FATHER BEST-M-FRIEND) (MOTHER BEST-M-FRIEND M-ADMIRE) (MOTHER M-DISLIKE F-DISLIKE) (MOTHER M-ADMIRE PER-MOSTFUN) (FATHER BEST-M-FRIEND M-ADMIRE) (FATHER M-DISLIKE F-DISLIKE) (FATHER M-ADMIRE PER-MOSTFUN) (BEST-M-FRIEND BEST-F-FRIEND F-ADMIRE) (BEST-M-FRIEND F-DISLIKE PER-MOSTFUN) (BEST-M-FRIEND PER-ROMANCE ROLE-MODEL) (BEST-F-FRIEND M-ADMIRE F-ADMIRE) (M-DISLIKE F-DISLIKE PER-MOSTFUN) (M-DISLIKE PER-ROMANCE ROLE-MODEL) (M-ADMIRE F-ADMIRE PER-ROMANCE))      ALL-COMBOS-NOT-RETURNED

;; EVERY 100th FOR ALL QVARS ==========================
;;  (make-elmsym-compare-lists  :return-every-nth 100)
;; works= *ALL-ELMSYM-COMPARE-COMBOS    309    ((MOTHER FATHER BEST-M-FRIEND) (MOTHER BEST-M-FRIEND ANGLOS) (MOTHER M-DISLIKE CHURCH-MINISTER) (MOTHER M-ADMIRE HOUSE-CLEANER) (MOTHER PER-MOSTFUN MOVIE-STAR) (MOTHER ROLE-MODEL JEWS) (MOTHER CHILD-DISLIKE MOST-IMPORTANT-ABILITY) (MOTHER FAV-BOSS POLICEMAN) (MOTHER FAV-M-STAR PROTESTANTS) (MOTHER FAV-SPIRITUAL MANAGER) (MOTHER TEACHER YOUR-WORST-CHARACTERISTIC) (MOTHER LAWYER BUSINESS-OWNER) (MOTHER SCIENTIST CHURCH-MINISTER) (MOTHER DANCER MOVIE-STAR) (MOTHER HOUSE-CLEANER MOST-IMPORTANT-ABILITY) (MOTHER JEWS MOST-IMPORTANT-BELIEF)  ...   etc  --- (HOUSE-CLEANER MOST-IMPORTANT-VALUE YOUR-WORST-CHARACTERISTIC) (MOVIE-STAR MUSLIMS BLACKS) (ROCK-STAR CHURCH-MINISTER YOUR-PERSONALITY) (ROCK-STAR HISPANICS YOUR-PERSONALITY) (CHURCH-MINISTER BUDDHISTS HISPANICS) (CATHOLICS JEWS MOST-IMPORTANT-BELIEF) (PROTESTANTS JEWS HISPANICS) (PROTESTANTS YOUR-POSSESSIONS YOUR-WORST-CHARACTERISTIC) (MUSLIMS BUDDHISTS YOUR-PERSONALITY) (BUDDHISTS BLACKS ASIANS) (ANGLOS BLACKS ASIANS) (ASIANS MOST-IMPORTANT-VALUE MOST-IMPORTANT-ABILITY))     ALL-COMBOS-NOT-RETURNED







;;TEST ONLY
;; (Multiple-value-setq (*global-combos-sym *n-pc-combos *pc-combos *all-combos) (make-elmsym-compare-lists :return-every-nth 100))  ;;if *all-elmsyms nil, run (csq-initialize)
;;   (make-elmsym-compare-lists  :all-elmsyms  '(A B C D E F G H I J K L M N O P) :return-every-nth 5) 
;;  (make-elmsym-compare-lists  :all-elmsyms  '(A B C D E F G H I J K L M N O P) ) 
;; works= CSQ-ELMSYM-COMBOS    112    ((G L M) (F I O) (C L M) (D J L) (C D E) (B C K) (A C J) (A H J) (B K N) (C I L) (A D J) (D E G) (C E P) (H N P) (I K P) (B F J) (H K M) (C E F) (B D L) (A K L) (D H M) (C D L) (L N P) (B H M) (E H N) (A D I) (B F O) (H I K) (B D P) (I K L) (A G I) (H L P) (A C E) (C G P) (C J N) (A O P) (C J O) (A F I) (A C L) (A D L) (F G P) (A E K) (A B K) (C N P) (E M N) (D G J) (G H O) (A B M) (J K P) (D E J) (G I P) (B O P) (B K M) (A D N) (G M N) (E F K) (D K N) (F H P) (D G L) (I O P) (B F I) (D I J) (B E O) (F I P) (H J K) (A J M) (B E K) (E G J) (C D F) (B J K) (E F N) (H J M) (G M O) (G I L) (F H I) (B F N) (K M P) (B H P) (A J P) (C H K) (F G L) (A G J) (B D K) (B H K) (A F G) (H K O) (H I J) (A C O) (G H N) (D G O) (J L M) (B E N) (C E H) (E J M) (B I L) (A C M) (E H P) (C I J) (A B D) (F G I) (B C H) (K L P) (I J K) (K L M) (F J M) (C G I) (A C D) (E L M) (C E K) (F K L) (D G I) (B F P))            ((A B C) (A B D) (A B E) (A B F) (A B G) (A B H) (A B I) (A B J) (A B K) (A B L) (A B M) (A B N) (A B O) (A B P) (A C D) (A C E) (A C F) (A C G) (A C H) (A C I) (A C J) (A C K) (A C L) (A C M) (A C N) (A C O) (A C P)  etc.


;;  (make-elmsym-compare-lists) 
;;works for 4 elmsyms (doesn't find sample, too few)
;; CSQ-ELMSYM-COMBOS  4   ((MOTHER FATHER BEST-M-FRIEND) (MOTHER FATHER BEST-F-FRIEND) (MOTHER BEST-M-FRIEND BEST-F-FRIEND) (FATHER BEST-M-FRIEND BEST-F-FRIEND))    ((MOTHER FATHER BEST-M-FRIEND) (MOTHER FATHER BEST-F-FRIEND) (MOTHER BEST-M-FRIEND BEST-F-FRIEND) (FATHER BEST-M-FRIEND BEST-F-FRIEND))
;; also CL-USER 8 > CSQ-ELMSYM-COMBOS = ((MOTHER FATHER BEST-M-FRIEND) (MOTHER FATHER BEST-F-FRIEND) (MOTHER BEST-M-FRIEND BEST-F-FRIEND) (FATHER BEST-M-FRIEND BEST-F-FRIEND))

;; works= ((MOTHER FATHER BEST-M-FRIEND) (BEST-F-FRIEND M-DISLIKE F-DISLIKE) (M-ADMIRE F-ADMIRE PER-MOSTFUN) .....  (YOUR-PERSONALITY YOUR-BEST-CHARACRISTIC YOUR-POSSESSIONS) (YOUR-WORST-CHARACTERISTIC MOTHER FATHER))   21


;; *all-elmsyms
;; (make-combos '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20) 3);; (setf *all-combos (m;

;;  IF USE MAKE-COMBOS FOR ALL ELMSYMS, => COMBOS-N = 35990
;; (make-combos *all-elmsyms))
;; (setf *all-flat-combos (flatten-1-level *all-combos))
;; (list-length *flat-all-combos) = 35990

;; FOR MAKE-COMBOS ONLY WITHIN CATEGORIES
;; *PCE-PEOPLE  *PCE-GROUPS *PCE-SELF
;; (setf *pce-people-combos (flatten-1-level (make-combos *PCE-PEOPLE 3)))
;; (list-length *pce-people-combos) = 1771
;; (setf *pce-groups-combos (flatten-1-level (make-combos *PCE-GROUPS 3)));; (list-length *;;; (list-length *pce-groups-combos)  = 4495
;; (setf *pce-self-combos (flatten-1-level (make-combos *PCE-SELF 3)))
;; (list-length *pce-self-combos) = 35
;;
;;USING RANDOM-SELECTION
;; (setf *random-pce-people-combos (my-random-selection *pce-people-combos 10))
;; (list-length *random-pce-people-combos) = 178
;; (setf *random-pce-groups-combos (my-random-selection *pce-groups-combos 3))
;; (list-length *random-pce-groups-combos) = 135
;; (setf *random-pce-self-combos (my-random-selection *pce-self-combos 50))
;; (list-length *random-pce-self-combos) = 18

;; (multiple-value-setq (*TEST-return-combos *TEST-n-combos *TEST-global-combos-sym *TEST-all-combos)       (make-combos *all-elmsyms  3 :global-combos-sym 'global-combos-sym     :return-all-combos-p T            :random-sample-percent  100    :randomize-p   T      :return-all-combos-p T   :prefix "" :postfix ""  ))


;;SSS START HERE MAKE FUNCTION TO MAKE 3s of each category??
;;EVERY  20th FOR EACH OF 3 QVAR GROUPS/SETS
;;  (make-elmsym-compare-lists :all-elemsyms   :return-every-nth 20)
;; (get-category-qvars 'pce-people)






;;LOAD-USER-CSQ-DATA
;; ALSO SEE READ-SAVED-CSQ-DATA
;;2019
;;ddd
;; (defun load-user-csq-data NOT LOADING ELMS -MOTHER SET TO "mother"
(defun load-user-csq-data (pathname  &key set-file-vars-to-nil-p
                                     eval-file-vars-w/o-load-p (not-set-when-no-sym1 T)
                                     eval-master-db-p (sublistkey :S)
                                     (cs-sys-master-db  *MASTER-CSART-CAT-DB)
                                     (new-global-vars
                                                  '( *csq-data-list 
                                                      *all-pc-element-qvars *all-pcqvar-lists  
                                                      *all-csq-value-ranking-lists
                                                      *ALL-ELMSYMS 
                                                      *ALL-ELMSYMS&VALS
                                                      *ALL-PCSYMS  *ALL-PCSYMS&VALS
  
                                                      *ALL-MAKE-CSYMS 
                                                      *ALL-MAKE-CSYMS-SYMS&VALS
                                                      *ALL-MAKE-CSARTLOC-SYMS 
                                                      *ALL-MAKE-CSARTLOC-SYMS&VALS
                                                      ;;convert from older (for older csq files)
                                                      *ALL-ELMSYMS *ALL-ELMSYMS&VALS
                                                      *ALL-PCSYMS  *ALL-PCSYMS-SYMS&VALS
                                                      *csq-data-list 
                                                      *all-pc-element-qvars *all-pcqvar-lists  
                                                      *all-csq-value-ranking-lists))
                                     (file-global-vars
                                                    '( *file-*csq-data-list
                                                       *file-*all-pc-element-qvars    *file-*all-pcqvar-lists
                                                       *file-*all-csq-value-ranking-lists
                                                       *file-*ALL-ELMSYMS 
                                                       *file-*ALL-ELMSYMS&VALS
                                                       *file-*ALL-PCSYMS 
                                                       *file-*ALL-PCSYMS&VALS
                                                       *file-*ALL-MAKE-CSYMS 
                                                       *file-*ALL-MAKE-CSYMS-SYMS&VALS
                                                       *file-*ALL-MAKE-CSARTLOC-SYMS  
                                                       *file-*ALL-MAKE-CSARTLOC-SYMS&VALS
                                                       ;;older csq data files
                                                       *file-elmsyms *file-elmsymvals  
                                                       *file-pcsyms *file-pcsymval-lists   
                                                       *file-csq-data-list
                                                       *file-all-pc-element-qvars    *file-all-pcqvar-lists
                                                       *file-all-csq-value-ranking-lists))
                                     )
  "U-CS,  Can make all csyms necessary for make-csym-treeviewer.   
    NOTE: ONLY WORKS FOR THESE CS STORED VARS!
      If EVAL-MASTER-DB-P, evals all sys csyms. 
      If EVAL-FILE-VARS-W/O-LOAD-P, can make new-global-vars from file-global-vars w/o by just evaling (not loading) file.   
      RETURNS (values  new-elmsyms new-pcsyms new-all-csyms new-csartloc-syms)
      INPUT: pathname for saved CSQ data."
  (let
      ((new-elmsyms)
       (new-pcsyms)
       (new-all-csyms)
       (new-csartloc-syms)
       )
    ;;EVAL
    (when eval-master-db-p
      (set-syms-to-second cs-sys-master-db))

    ;;reset global file vars to nil (so no unbound var errors)
    (unless eval-file-vars-w/o-load-p
      (set-vars-to-value NIL file-global-vars)
      ;;restores all the main list vars
      (load pathname)
      ;;end unless
      )
    ;;*FILE VARS evaled when load pathname
    (when new-global-vars
      (SET-SYMS-TO-EVALED-SYMS new-global-vars file-global-vars
                               :not-set-when-no-sym1 not-set-when-no-sym1))

    ;;resets all *file-VARIABLES to nil
    (when set-file-vars-to-nil-p 
     (set-vars-to-value NIL file-global-vars))

    ;;restores the elmsyms (*file-elmsymvals set above)
    (setf new-elmsyms
          (make-syms-from-symvalists *all-elmsyms&vals))

    ;;restores the pcsyms (*file-pcsymval-lists set above)
    (setf new-pcsyms
          (make-syms-from-symvalists *all-pcsyms&vals))

    ;;restores *all-make-csyms 
    (setf new-all-csyms
          (make-syms-from-symvalists *all-make-csyms-syms&vals ))

    ;;restores *all-make-csartloc-sym 
    (setf new-csartloc-syms
          (make-syms-from-symvalists *all-make-csartloc-syms&vals ))

    ;;SSSSS LATER: ALSO RESTORE NETWORK SYMS WUP2-3 ETC NODES/PATHS FROM DATA??
     ;;(break "end of load-user-csq-data")
    (values  new-elmsyms new-pcsyms new-all-csyms new-csartloc-syms)
    ;;end let, load-user-csq-data
    ))
;;TEST
;; (load-user-csq-data    "C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\0-TOM-ALL-CSDATA-NoErrors-2020-08-26.lisp") = error not exist
;; (load-user-csq-data  nil    :eval-file-vars-w/o-load-p T)
;; (load-user-csq-data  "C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\1 2020-05 TOM CSQ RESULTS.lisp")
;; (load-user-csq-data  "C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\2-TOM-TOM-new-CSYMS-VALS2020-7-28-13h49.lisp")
;; (load-user-csq-data  *selected-TOM-user-data)
;;   (load-user-csq-data  "C:/3-TS/LISP PROJECTS TS/CogSysOutputs/Tom-AllData2019-10.lisp")
#|;; works= (MOTHER FATHER BEST-M-FRIEND BEST-F-FRIEND M-DISLIKE F-DISLIKE M-ADMIRE F-ADMIRE PER-MOSTFUN PER-ROMANCE ROLE-MODEL CHILD-FRIEND CHILD-DISLIKE WORK-FRIEND WORK-PER-DISLIKE FAV-BOSS WORST-BOSS FAV-M-STAR FAV-POLITICO FAV-TEACHER FAV-SPIRITUAL DIS-TEACHER TEACHER POLICEMAN SALESPERSON DOCTOR LAWYER BUSINESS-OWNER MANAGER SCIENTIST FARMER DRUG-DEALER POLITICIAN DANCER ARTIST COMEDIAN ENGINEER HOUSE-CLEANER MOVIE-STAR ROCK-STAR CHURCH-MINISTER CATHOLICS PROTESTANTS JEWS MUSLIMS BUDDHISTS ATHEISTS ANGLOS HISPANICS BLACKS ASIANS MOST-IMPORTANT-VALUE MOST-IMPORTANT-ABILITY MOST-IMPORTANT-BELIEF YOUR-PERSONALITY YOUR-BEST-CHARACTERISTIC YOUR-POSSESSIONS YOUR-WORST-CHARACTERISTIC)
(CAREFOROTHERS INTIMATE FLEXIBLE CASUAL EGOTISTICAL EXUBERANT NOTTHEORIST LOVEX LOVEDANCE HELPINGCAREER HIGHIMPACT PSYCHOLOGISTS UNDERSTANDING IMPULSIVE ENTERTAINER AGGRESSIVE PATERNAL CAREABOUTOTHERSFEE INSPIREOTHERS BESTFRIEND DIRECT-HONEST UNBRIDLEDHUMOR FANTASYWORLD ATHLETIC ESPOSECHRISTIAN CRITICAL SEXDEVIANCE GLOBALPERSPECTIVE FUNCOMPANION SELF-DISCLOSE MISSIONSPREADPSYCH CRUEL COURTEOUS DEEPUNDERSTANDPEOP DEMOCRATICLEADER PSYCHOLOGIST METICULOUS COGNITIVEPSYCHS EMOTIONAL CHARMING VALUEGROUPHAPPINES LOCALLEADER HIGHLYEDUCATED ENLIGHTENWORLD PETTY ENCOURAGING HUMOROUS GREATLEADER CONFIDENT-SELF-EST INTERPERSONALSKILL INTIMATELYASSERTIV GREATSPEAKER AUTONOMOUS HIGHINTELLIGENCE GOODNEGOTIATOR PROGRESSIVE CLOSE PLAYFUL COUNSELORS INDUSTRIOUS SEXY UNDERSTANDING4 SOFTSPOKEN TEAMMATE BEHAVIORALPSYCH OPTIMISTIC CHILDHOODFRIEND DEBONAIRE HIGHSTANDARDS TEACHER1 LIBERALCHRISTIAN EMPATHETICLISTENER OVERCOMEDIFFICULTI FIGHTILLNESS PUBLICSERVANT SECULAR SEEKATTENTION HELPER SPREADKNOWLEDGE LAWFUL MANAGER0 PRAGMATIC GROUPKNOWLEDGEWORK VERBALSKILLS LESSCIVILIZED REPRESENTGROUP PERFORMER SHOWBUSINESS SOLVEPROBLEMS STARPERFORMER LESSWEALTH DEPENDGOV IMMIGRANTS PROFIT-ORIENTED OCCUPATION PHYSICALWELLBEING LEGALEXPERT SELF-DISCIPLINE ENFORCERULES CREATENEWRULES SOCIALCONSTRAINTS RESPECTED SEEKEXTERNALAPPROV CREATIVE RITUALISTIC LESSMORALISTIC PROFESSIONAL DRAMATIC EUROCENTRICVALUES INDIVIDUALISTIC CATHOLIC PEOPLE-JOB GREEDY OWNER PERFORMANCE-ORIENT HIGHSTATUS RATIONAL PRACTICAL PERSUASIVE INFLUENCIAL MANUALWORK NOTHISTORY-ORIENTE NOTANALYTIC NOTLOYAL SPIRITUALINTEGRATI SEEKULTIMATETRUTH MATERIALISTIC SKILLEDMOVEMENTS)
|#




;;MAKE-SYMS-FROM-SYMVALISTS
;;2019
;;ddd
(defun make-syms-from-symvalists  (symvalists &key (set-sym-to-vals-p T)
                                              (set-to-item-n 1) (set-to-car-if-no-sym-p T))
  "In U-CS. RETURNS (values found-syms found-names). For restoring elmsyms, pcsyms from a file symvalists *file-elmsymvals or *file-pcsymval-lists. When set-elmsym-to-vals-p, sets the new syms to the symvalists.
   If SET-TO-ITEM-N = nil, does NOT set first item to anything.
   If SET-TO-CAR-IF-NO-SYM-P: if second item NOT a list, sets entire list to first item [makes a sym]."
  (let
      ((found-names)
       (found-syms)
       )
    (loop
     for symlist in symvalists
     do
     (let
         ((sym)
          (symname)
          (len-symlist)
          )
       (when (listp symlist)
         (setf symname (format nil "~A" (car symlist))
               sym (my-make-cs-symbol symname)
               len-symlist (list-length symlist))
         (when set-sym-to-vals-p
           (cond
            ;;when list is form (sym (symvals))
            ((= len-symlist 2)
             (set sym (second symlist)))
            (set-to-car-if-no-sym-p
            (set sym symlist))
            (set-to-item-n
             (set sym (nth set-to-item-n symlist)))
            (T NIL)))
           ;;append lists
           (setf found-names (append1 found-names symname)
                 found-syms (append1 found-syms sym))
           ;;end when
           )
       ;;(break "end make-syms-from-symvalists loop")
     ;;end let, loop
     ))
    (values found-syms found-names)
    ;;end let, make-syms-from-symvalists
    ))
;;TEST
;; FOR *ALL-MAKE-CSYMS-SYMS&VALS
;; (make-syms-from-symvalists *ALL-MAKE-CSYMS-SYMS&VALS)
;; works: eg. <SWORLDVIEW = ("<SWORLDVIEW" "Positive World View" $P.$CS.$EXC.$BV.$WV.<SWORLDVIEW NIL "Optimism about the future of the world and own life, lack of entitlement thinking, plus daily positive versus negative thoughts. How constructively and positively you view the world and the future can" :QT :SCALE :CSS $WV :VA 0.926 :SD 1.863082 :S (<SSWVGRATPT <SSWVOPTIMS <SSWVENTIT))
;;FOR ELMSYMS  (evals to whole list)
;; (make-syms-from-symvalists '(("MOTHER" "mother" ELM2-1-1-99 NIL NIL :BIPATH (((MOTHER NIL (CAREFOROTHERS (POLE1) NIL))) ((MOTHER NIL (INTIMATE (POLE1) NIL))) ((MOTHER NIL (FLEXIBLE (POLE1) NIL))) ((MOTHER NIL (CASUAL (POLE1) NIL))) ((MOTHER NIL (EGOTISTICAL (POLE2) NIL))) ((MOTHER NIL (EXUBERANT (POLE2) NIL))) ((MOTHER NIL (NOTTHEORIST (POLE1) NIL))) ((MOTHER NIL (LOVEX (POLE1) NIL))) ((MOTHER NIL (LOVEDANCE (POLE1) NIL))) ((MOTHER NIL (HELPINGCAREER (POLE2) NIL))) ((MOTHER NIL (HIGHIMPACT (POLE2) NIL)))))))
;;works= (MOTHER)   ("MOTHER")
;; also CL-USER 4 > mother => list above
;;
;;FOR PCSYMS (evals second in list?)
;; (make-syms-from-symvalists '((CAREFOROTHERS ("CAREFOROTHERS" "CARE FOR OTHERS vs SELFISH" CS2-1-1-99 NIL NIL :PC ("CARE FOR OTHERS" "SELFISH" 1 NIL) :POLE1 "CARE FOR OTHERS" :POLE2 "SELFISH" :BESTPOLE 1 (:BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)))))) :set-to-item-n 1)
;; works= (CAREFOROTHERS)   ("CAREFOROTHERS")
;;also CL-USER 8 > CAREFOROTHERS =>
;;  evals to ONLY SECOND TERM ("CAREFOROTHERS" "CARE FOR OTHERS vs SELFISH" CS2-1-1-99 NIL NIL ...ETC ETC...






;;MAKE-ELMSYMS-FROM-DATALIST
;;
;;ddd
(defun make-elmsyms-from-datalist (datalist 
                                    &key (set-elmsym-to-vals-p T) (elmsym-key :elmsym-lists))
  "In U-CS. For restoring elmsyms from a partially-completed CSQ from *CSQ-elmsym-lists. DOES NOT RESTORE CSYM at this time."
  (let
      ((elmsym-lists (get-key-values elmsym-key datalist))
       (elmsymvals)
       )
    (loop
     for elmlist in elmsym-lists
     do
     (when elmlist
       (setf elmsym (car elmlist)
             elmsymvals (second elmlist)
             elmsyms (append elmsyms (list elmsym)))
       ;;end when
       )
     (when set-elmsym-to-vals-p
       (set elmsym elmsymvals))

     ;;end loop
     ) 
    elmsyms
    ;;end let, make-elmsyms-from-datalist
    ))





;;MAKE-MIXED-COMBOS-FOR-PCE-CATS -- WORKS, BUT NOT USED
;;   USE *all-elmsyms INSTEAD OF CATS
;;
;;ddd 
#|(defun make-mixed-combos-for-pce-cats (pce-cat-global-syms 
                                &key (random-sample-percent 10)
                                                   (randomize-p T) return-all-combos-p
                                                   (prefix "") (postfix "-combos")
                                                   cat-combo-global-sym
                                                   (randomize-min-combo-n 20)
                                                   )
  "In U-CS, creates combo-lists of 3 elements and can return a randomized sample of random-sample-percent of the total. RETURNS  If return-all-combos-p, (values cat-global-sym randomized-combos cat-combos) otherwise, (values cat-global-sym randomized-combos). When LISTP pce-cat-global-syms, combine symlists into one large list--so resultant combos are a mix of all cats."
  (let
      ((randomized-combos)
       (n-combos)
       (syms)
       (qsyms)
       (all-qsyms)
      (qnames)
       (all-combos)
       (new-cat-combo-global-sym)
       )

    ;;FIND THE pce-cat-global-syms
    (cond
     ((listp pce-cat-global-syms) 
      (loop 
       for cat in pce-cat-global-syms
       do
       (cond
        ((boundp cat)
         (setf qsyms (eval cat)))
        (t
         (setf qnames (get-category-qvar-names cat)    
               qsyms (find-symbols-for-names qnames))))
           (break "0")
       (setf all-qsyms (append all-qsyms qsyms))
       ;;end loop
       )
      ;;(setf pce-cat-global-syms syms)
      )
     (t (setf all-qsyms (eval pce-cat-global-sym))))
    (break "2 all-qsyms")

    ;;MAKE THE COMBOS
    (setf all-combos (flatten-1-level (make-combos  all-qsyms 3))
          n-combos (list-length all-combos))   
    (break "3")
   
      
      ;;RANDOM SELECT COMBOS FROM EACH CATEGORY?
      (cond
       ((and  randomize-p (> n-combos randomize-min-combo-n))
        (setf return-combos 
              (my-random-selection all-combos random-sample-percent))
        )
       (t (setf return-combos all-combos)))

      ;;SET A cat-combo-global-sym TO THE RETURN-COMBOS?
      (when cat-combo-global-sym
        (setf new-cat-combo-global-sym (my-make-cs-symbol 
                                        (format nil "~A~A~A" prefix  cat-combo-global-sym postfix)))
        (set new-cat-combo-global-sym return-combos))

       (values  return-combos  n-combos new-cat-combo-global-sym)
      ;;end let, make-mixed-combos-for-pce-cats
      ))|#
;;TEST
;; (make-mixed-combos-for-pce-cats '(PCE-PEOPLE PCE-GROUPS PCE-SELF))
;; works= ((MOTHER FATHER BEST-M-FRIEND) (MOTHER FATHER BEST-F-FRIEND) (MOTHER BEST-M-FRIEND BEST-F-FRIEND) (FATHER BEST-M-FRIEND BEST-F-FRIEND))   4   NIL
;; set a new-cat-combo-global-sym
;; (make-mixed-combos-for-pce-cats '(PCE-PEOPLE PCE-GROUPS PCE-SELF) :cat-combo-global-sym 'test-gsym)
;; works= ((MOTHER FATHER BEST-M-FRIEND) (MOTHER FATHER BEST-F-FRIEND) (MOTHER BEST-M-FRIEND BEST-F-FRIEND) (FATHER BEST-M-FRIEND BEST-F-FRIEND))   4   TEST-GSYM-COMBOS
;;CL-USER 7 > TEST-GSYM-COMBOS =  ((MOTHER FATHER BEST-M-FRIEND) (MOTHER FATHER BEST-F-FRIEND) (MOTHER BEST-M-FRIEND BEST-F-FRIEND) (FATHER BEST-M-FRIEND BEST-F-FRIEND))





#|  ;;MAKE-COMBOS-FOR-PCE-CATS  -- NOT CURRENTLY BEING USED
;;
;;ddd 
(defun make-combos-for-pce-cats (pce-cat-global-syms  
                                 &key (random-sample-percent 10)
                                 (randomize-p T) return-all-combos-p
                                 (prefix "") (postfix "-combos"))
  "In U-CS, creates combo-lists of 3 elements and can return a randomized sample of random-sample-percent of the total. RETURNS  If return-all-combos-p, (values cat-global-syms randomized-combos cat-combos n-combos) otherwise, (values cat-global-syms randomized-combos n-combos). Sets each sublist to a global variation of the gloval var subcat set to."
  (let
      ((cat-combos)
       (cat-global-sym)
       ;;IF USE GLOBAL SYMS?(pce-cat-global-syms (eval pce-cat-global-sym))
       (randomized-combos)
       (n-combos)
       (return-combos)
       )
    (loop
     for catsym in pce-cat-global-syms
     do
     (multiple-value-setq (cat-global-sym randomized-combos cat-combos) 
         ;;USE GLOBAL VARS ABOVE HERE?
         (make-combos-for-pce-cat catsym
                                  :random-sample-percent random-sample-percent
                                  :randomize-p randomize-p
                                  :return-all-combos-p return-all-combos-p
                                  :prefix prefix :postfix postfix))

     ;;end loop
     )

#|    (setf  (+ *n-people-combos *n-group-combos *n-self-combos)
          *all-elmsyms-comparisons (append *random-people-elmsym-combos
           *random-groups-elmsym-combos  *random-self-elmsym-combos))|#

    (setf *n-elmsym-combos (list-length randomized-combos))

    ;;end let, make-combos-for-pce-cats
    ))
|#



;;GET-EXISTING-ELMSYM-COMBOS
;;
;;ddd
(defun get-existing-elmsym-combos (global-combos-sym
                                  ;;normally  '*all-elmsym-compare-combos
                                   &key
                                   (combos *all-elmsym-compare-combos)
                                   (all-elmsyms *all-elmsyms)
                                   (find-in-file-p T)
                                   (pathname  "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\csq-permdata.lisp"))
  "In U-CS, gets an elmsym-combo-list and processes it for use by CSQ-Manager, etc. RETURNS (values global-combos-sym n-combos return-combos ) Also SETS global-combos-sym to the return-combos list."
  (let
      ((return-combos)
       (n-combos 0)
       )
    (cond
     (find-in-file-p
      (setf return-combos 
            (find-global-variable-in-file global-combos-sym pathname)))

     (t (setf return-combos combos)
      (set global-combos-sym combos)))

    (setf n-combos (list-length return-combos))

    (values global-combos-sym  return-combos n-combos) 
    ;;end let, get-existing-elmsym-combos
    ))
;;TEST
;; (makunbound '*test-elmsym-4combos)
;;  (get-existing-elmsym-combos  '*test-elmsym-4combos)
;;works= *TEST-ELMSYM-4COMBOS    ((MOTHER FATHER BEST-M-FRIEND) (MOTHER FATHER BEST-F-FRIEND) (MOTHER BEST-M-FRIEND BEST-F-FRIEND) (FATHER BEST-M-FRIEND BEST-F-FRIEND))    4



;;SAVE-CSQ-DATA-TO-FILE -- USED FOR STORING PCSYMS etc
;;
;;ddd
(defun save-csq-data-to-file (all-csyms-file &key csym-types-file
                                   (use-dated-filename- T)                                   
                                   (dirpath *csq-save-all-dirpath) (if-file-exists :overwrite)
                                   ;;"C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\")
                                   ;;inputs
                                   (csq-elmsym-lists *CSQ-ELMSYM-LISTS)
                                   (csq-data-list *CSQ-DATA-LIST)
                                   (all-PCqvars *ALL-PCQVARS)
                                   (csq-value-ranking-lists 
                                    ;;*FILE-ALL-CSQ-VALUE-RANKING-LISTS
                                    *ALL-ORDERED-VALUES-RATINGS-LISTS)
                                   (all-csart-cat-sym-db-sym '*MASTER-CSART-CAT-DB)
                                   ;;outputs
                                   (ALL-CSYMS-SYM '*ALL-CSYMS)
                                   (all-scale-csyms-sym '*ALL-SCALE-CSYMS)
                                   (all-qvar-csyms-sym '*ALL-QVAR-CSYMS)
                                   (all-special-csyms-sym '*ALL-SPECIAL-CSYMS)
                                   (all-csartloc-syms-sym '*ALL-CSARTLOC-SYMS)
                                   (all-stored-sys-csyms-sym '*ALL-STORED-SYS-CSYMS)
                                   (all-stored-csyms-sym '*ALL-STORED-CSYMS)
                                   (newlink-made-csyms-sym '*NEWLINK-MADE-CSYMS)
                                   ;;modify to use syms later??
                                   ;;(all-stored-csyms *ALL-STORED-CSYMS)
                                   (newlink-made-csyms *NEWLINK-MADE-CSYMS)             
                                   ;;not used set-csq-symbols-to-data-p
                                   (save-cs-explore-data-p T)
                                   (remake-all-PCqvar-lists-p T)
                                   )                                   
  "In U-CS, Saves all CSQ data to a file. "
  (when (null dirpath) 
    (setf dirpath ""))
  (let
      ((all-csyms-pathname (cond (use-dated-filename-p
                        (make-dated-pathname all-csyms-file :root dirpath :file-ext nil))
                       (T (format nil "~A~A" dirpath all-csyms-file))))
       (csym-types-pathname (cond (use-dated-filename-p
                        (make-dated-pathname csym-types-file :root dirpath :file-ext nil))
                       (T (format nil "~A~A" dirpath csym-types-file))))
       (pcsym-elm-lists (get-keyvalue-in-nested-list '((:PCSYM-ELM-LISTS T))  csq-data-list))
       (date (my-get-date-time))
       )
    ;;added 2019 -- might defeat remaking list for changes below SSSS
    (when (and (null all-PCqvars) *all-pcsyms)
      (setf  all-PCqvars *all-pcsyms
             *all-PCqvars *all-pcsyms))
    (when (and (null *all-PCqvar-lists)  *ALL-PCSYMS&VALS)
      (setf *all-PCqvar-lists  *ALL-PCSYMS&VALS))

    (multiple-value-bind (pcsymval-lists pcsyms)
                (make-pcsymval-lists :all-datalists csq-data-list)

    (multiple-value-bind (elmsymval-lists elmsyms n-elmsyms)
        (get-elmsymval-lists :elmsyms *all-elmsyms)   

   ;;UPDATE THE *all-PCqvar-lists (probably modified after initially created)
   (when remake-all-PCqvar-lists-p
     (setf *all-PCqvar-lists NIL)
     (loop
      for pcqvar-str in all-PCqvars
      do
      (setf *all-PCqvar-lists (append *all-PCqvar-lists
                                      (list (eval (my-make-cs-symbol pcqvar-str)))))
      ;;end loop,when
      ))

   ;;GET CSYM FORMATED DATA-2020
   (multiple-value-bind       
        (formated-csyms-db formated-all-scale-csyms formated-all-qvar-csyms 
       formated-all-special-csyms formated-all-csyms formated-all-csyms/vals
       formated-all-stored-sys-csyms formated-all-stored-sys-csyms-sym/vals
       formated-all-csartloc-syms formated-all-csartloc-syms/vals
       ;;formated-all-stored-csyms  formated-all-stored-csyms/vals-lists
       formated-newlink-csyms)
       (get-all-csq-data :return-formated-data-p T 
                         :all-csart-cat-sym-db-sym   all-csart-cat-sym-db-sym
                         :all-scale-csyms-sym all-scale-csyms-sym
                         :all-qvar-csyms-sym   all-scale-csyms-sym
                         :all-special-csyms-sym   all-special-csyms-sym
                         :all-stored-csyms-sym all-stored-csyms-sym
                         :all-csartloc-syms-sym   all-csartloc-syms-sym
                         :all-csyms-sym   all-csyms-sym
                       ;;  :all-stored-csyms-sym   all-stored-csyms-sym
                         :newlink-made-csyms-sym   newlink-made-csyms-sym)
      ;;(all-csart-cat-sym-db-sym  (all-scale-csyms-sym ) (all-qvar-csyms-sym (quote *all-qvar-csyms)) (all-special-csyms-sym (quote *all-special-csyms)) (all-csartloc-syms-sym (quote *all-csartloc-syms)) (all-csyms-sym (quote *all-csyms)) (all-stored-csyms-sym (quote *all-stored-csyms)) (newlink-made-csyms-sym (quote *newlink-made-csyms)) (return-formated-data-p t) (return-data-p t))

     ;;OPEN FILE STREAM for all-csyms-pathname (for *ALL-CSYMS & their vals)
      (when all-csyms-pathname
       (with-open-file (out all-csyms-pathname :direction :output :if-exists if-file-exists
                            :if-does-not-exist :create)
         (format out ";;FOR DATE: ~S ;; ELMSYMS=~%(defparameter *file-elmsyms  '~S)~%;;ELMSYMVALS= ~%(defparameter *file-elmsymvals  '~S) ~%;;PCSYMS= ~% (defparameter *file-pcsyms  '~S)~%;;PCSYMVAL-LISTS= ~%(defparameter *file-pcsymval-lists '~S)~%;;*CSQ-DATA-LIST= ~%(defparameter *file-csq-data-list '~S) ~% ~%;;FOR CREATING:~%;;*ALL-PC-ELEMENT-QVARS=~%(defparameter *file-all-pc-element-qvars  '~S)~%;;*ALL-PCQVAR-LISTS=~%(defparameter *file-all-pcqvar-lists '~S)~%;;*ALL-ORDERED-VALUES-RATINGS-LISTS= ~%(defparameter *file-ALL-ORDERED-VALUES-RATINGS-LISTS '~S) ~% "
                 date elmsyms elmsymval-lists  pcsyms  pcsymval-lists *csq-data-list *all-pc-element-qvars  *all-pcqvar-lists csq-value-ranking-lists )

         ;;end with, when pathname
        ))

     ;;OPEN FILE STREAM for csym-types-pathname
     (when csym-types-pathname
       (with-open-file (out csym-types-pathname :direction :output :if-exists if-file-exists
                            :if-does-not-exist :create)
         (format out ";;FOR DATE: ~S ;; ELMSYMS=~%(defparameter *file-elmsyms  '~S)~%;;ELMSYMVALS= ~%(defparameter *file-elmsymvals  '~S) ~%;;PCSYMS= ~% (defparameter *file-pcsyms  '~S)~%;;PCSYMVAL-LISTS= ~%(defparameter *file-pcsymval-lists '~S)~%;;*CSQ-DATA-LIST= ~%(defparameter *file-csq-data-list '~S) ~% ~%;;FOR CREATING:~%;;*ALL-PC-ELEMENT-QVARS=~%(defparameter *file-all-pc-element-qvars  '~S)~%;;*ALL-PCQVAR-LISTS=~%(defparameter *file-all-pcqvar-lists '~S)~%;;*ALL-ORDERED-VALUES-RATINGS-LISTS= ~%(defparameter *file-ALL-ORDERED-VALUES-RATINGS-LISTS '~S) ~% "
                 date elmsyms elmsymval-lists  pcsyms  pcsymval-lists *csq-data-list *all-pc-element-qvars  *all-pcqvar-lists csq-value-ranking-lists )

         (format out ";;CSYM-LISTS:~% ~A~% ~A~% ~A~% ~A~% ~A~% ~A~% ~A~% ~%"
                 formated-csyms-db formated-all-scale-csyms formated-all-qvar-csyms formated-all-special-csyms formated-all-csyms formated-all-csyms/vals  formated-all-csartloc-syms formated-all-csartloc-syms/vals) ;;formated-all-stored-csyms formated-all-stored-csyms/vals-lists ;;9 items
 
         ;;end ,with-open, when csym-types-pathname
         ))
     ;;end mvb
     )
#|      (format out ";;FOR DATE: ~S~%;; ELMSYMS=~% (setf *file-elmsyms  '~S)~%;;ELMSYMVALS= ~%  (setf *file-elmsymvals  '~S)~%;;PCSYMS= ~% (setf *file-pcsyms  '~S)~%;;PCSYMVAL-LISTS= ~% (setf *file-pcsymval-lists '~S)~%;;*CSQ-DATA-LIST=~% (setf *file-csq-data-list '~S)~% ~%;;FOR CREATING:~%;;*ALL-PC-ELEMENT-QVARS=~%  (setf *file-all-pc-element-qvars  '~S)~%;;*ALL-PCQVAR-LISTS=~% (setf *file-all-pcqvar-lists '~S)~%;;*ALL-CSQ-VALUE-RANKING-LISTS=~% (setf *file-all-csq-value-ranking-lists '~S)~% " date elmsyms elmsymval-lists  pcsyms  pcsymval-lists *csq-data-list *all-pc-element-qvars  *all-pcqvar-lists csq-value-ranking-lists )
            ;;end with
      )

    ;;SAVE CS-EXPLORE DATA?
    ;;get,format, and save cs-explore data
    (when (and save-cs-explore-data-p *NEWLINK-MADE-CSYMS)
      (save-cs-explore-data-to-file  :path  pathname
                                     :all-csart-cat-sym-db-sym '*MASTER-CSART-CAT-DB
                                :all-stored-csyms-sym '*ALL-STORED-CSYMS
                                :newlink-made-csyms-sym '*NEWLINK-MADE-CSYMS
                                :return-stored-strings-p T))
|#
    ;;(values elmsyms pcsyms *all-csq-data-list-syms )
    (format T "==> ALL CSQ FORMATED DATA SAVED TO PATH:~% ~A~%" pathname )              
    ;;end let, mvb,mvb, save-csq-data-to-file
    ))))
;;TEST
;;  (save-csq-data-to-file "1 TOM-All-CSQ-DATA-2020-03-19.lisp")
;;  (save-csq-data-to-file "csq-data-output-test2.lisp")




;;GET-ALL-CSQ-DATA
;;2020
;;ddd
(defun get-all-csq-data (&key 
                                (all-csart-cat-sym-db-sym '*MASTER-CSART-CAT-DB)
                                ;;not done
                                (all-scale-csyms-sym '*ALL-SCALE-CSYMS)
                                (all-qvar-csyms-sym '*ALL-QVAR-CSYMS)
                                (all-special-csyms-sym '*ALL-SPECIAL-CSYMS)
                                (all-csartloc-syms-sym '*ALL-CSARTLOC-SYMS)
                                (all-csyms-sym '*ALL-CSYMS)
                                ;;done
                                ;;(all-stored-sys-csyms-sym '*ALL-STORED-SYS-CSYMS)
                                (all-stored-csyms-sym '*ALL-STORED-CSYMS)
                                (newlink-made-csyms-sym '*NEWLINK-MADE-CSYMS)
                                (return-formated-data-p T) (return-data-p T))
  "CS-explore.   RETURNS (values      formated-newlink-csyms formated-csyms-db  all-csart-cat-sym-db all-stored-csyms all-stored-csyms/vals newlink-made-csyms)   FOR USE IN SAVE. "
  (let*
      ((all-csart-cat-sym-db (eval all-csart-cat-sym-db-sym))
       ;;didn't make the sym/vals lists for all-csart-cat-sym-db, bec is in cs-config
       (all-scale-csyms (eval  all-scale-csyms-sym))
       (all-qvar-csyms (eval  all-qvar-csyms-sym))
       (all-special-csyms (eval  all-special-csyms-sym))
       (all-csyms (eval all-csyms-sym))
       (all-csyms/vals-sym 'all-csyms/vals)
       (all-csyms/vals (make-evaled-sym-lists all-csyms)) 
       (all-csartloc-syms (eval  all-csartloc-syms-sym))
       (all-csartloc-syms/vals-sym 'all-csartloc-syms/vals)
       (all-csartloc-syms/vals (make-evaled-sym-lists all-csartloc-syms))
       ;;(all-stored-sys-csyms (eval all-stored-sys-csyms-sym))
       ;;(all-stored-sys-csyms-sym/vals-sym 'all-stored-sys-csyms-sym/vals)
       ;;(all-stored-sys-csyms-sym/vals (eval all-stored-sys-csyms-sym))
       (all-stored-csyms (eval all-stored-csyms-sym))
       (all-stored-csyms/vals-sym '*all-stored-csyms/vals)
       (all-stored-csyms/vals (make-pcsymval-lists :all-datalists all-stored-csyms))
       (newlink-made-csyms (eval newlink-made-csyms-sym))
       ;;not needed bec included in all-stored-csyms/vals
       ;;(newlink-made-csyms/vals-lists (make-pcsymval-lists newlink-made-csyms))
       (formated-csyms-db)
       (formated-all-scale-csyms)(formated-all-qvar-csyms)
       (formated-all-special-csyms)(formated-all-csyms)(formated-all-csyms/vals)
       (formated-all-csartloc-syms)(formated-all-csartloc-syms/vals)
       (formated-all-stored-csyms)(formated-all-stored-csyms/vals)
       (formated-newlink-csyms)
       )
    ;;SSSSSS FINISH FORMATED LISTS FOR STORING (TEMPORARILY doubles memory requirements) START HERE
;;NOTE:  Just storing ALL CSYMS AND CSYMVALS for each user should be all that is necessary to recover all user data for any part of CSQ/SHAQ. Right??
;; from MAKE-CSQ-CSYMS: all-new-csyms  all-new-scale-csyms all-qvar-csyms all-csartloc-syms new-elmsyms new-pcsyms all-csyms) ,
;;also *MASTER-CSART-CAT-DB, *ALL-STORED-SYS-CSYMS, *CSQ-MAIN-SCALE-CLASSES, *CSQ-BIO-ACAD-ETC-SYS/QVARS, *CSQ-USER-DATA-PATH, 
;;from CSQ-MANAGER, *all-new-csyms  *all-new-scale-csyms   *all-new-qvar-csyms   *all-new-csartloc-syms   *new-elmsyms  *new-pcsyms )
       (setf  formated-csyms-db (format nil "~%;;~A ~%(defparameter  *file-MASTER-CSART-CAT-DB  '~A)" all-csart-cat-sym-db-sym all-csart-cat-sym-db)
              ;;new
              formated-csart-db-csyms (format nil "~%;;~A ~%(defparameter  *file-MASTER-CSART-DB-CSYMS  '~A)" all-csart-cat-sym-db-sym all-csart-cat-sym-db)
              
              formated-all-scale-csyms  (format nil "~%;;~A ~%  (defparameter  *FILE-ALL-SCALE-CSYMS '~A)" all-scale-csyms-sym all-scale-csyms  )
              formated-all-qvar-csyms  (format nil "~%;;~A ~%  (defparameter  *FILE-ALL-QVAR-CSYMS '~A)" all-qvar-csyms-sym  all-qvar-csyms)
              formated-all-special-csyms  (format nil "~%;;~A ~%(defparameter  *FILE-ALL-SPECIAL-CSYMS '~A)" all-special-csyms-sym  all-special-csyms)
             ;; formated-all-csyms  (format nil "~%;;~A ~%  (defparameter  *file-ALL-CSYMS  '~A)"   all-csyms)
             ;; formated-all-csyms/vals  (format nil "~%;;~A ~%  (set-sym&subsyms *file-ALL-CSYMS/VALS  '~A)"   all-csyms/vals)
              ;;formated-all-stored-sys-csyms  (format nil "~%;;~A ~%(defparameter  *file-ALL-STORED-SYS-CSYMS  '~A)" all-stored-sys-csyms-sym  all-stored-sys-csyms)
             ;; formated-all-stored-sys-csyms-sym/vals  (format nil "~%;;~A ~%  (set-sym&subsyms *file-ALL-STORED-SYS-/VALS-CSYM  '~A)" all-stored-sys-csyms-sym/vals-sym  all-stored-sys-csyms-sym/vals)
              formated-all-stored-csyms  (format nil "~%;;~A ~%(defparameter  *file-ALL-STORED-CSYMS  '~A)" all-stored-csyms-sym  all-stored-csyms)
              formated-all-stored-csyms/vals (format nil "~%;;*ALL-STORED-CSYMVALS-LISTS ~%(set-sym&subsyms '*file-ALL-STORED-CSYMVALS-LISTS  '~A)"   all-stored-csyms/vals)
              formated-all-csartloc-syms (format nil "~%;;~A ~%(defparameter  *FILE-ALL-CSARTLOC-SYMS  '~A)" all-csartloc-syms-sym  all-csartloc-syms)
              formated-all-csartloc-syms/vals  (format nil "~%;;~A ~%(set-sym&subsyms '' '*file-ALL-CSARTLOC-SYMS/VALS '~A)"  all-csartloc-syms/vals-sym all-csartloc-syms/vals)
              formated-newlink-csyms  (format nil "~%;;~A ~%(defparameter  *file-NEWLINK-MADE-CSYMS-SYM ~A)"newlink-made-csyms-sym  newlink-made-csyms)
              ;;not needed, bec symvals made in all-stored-csyms/vals
              #|       (formated-newlink-csyms/vals-lists (format nil "~%;;~A ~%  (defparameter  *file-NEWLINK-CSYMVALS-LISTS=  '~A)"   newlink-made-csyms/vals-lists))|#
              ;; end setf formated-  data
              )
       ;;(break "END")
    (cond
     ((and return-formated-data-p return-data-p)
      (values  
       ;;formated
        formated-csyms-db formated-all-scale-csyms formated-all-qvar-csyms 
       formated-all-special-csyms ;;formated-all-csyms formated-all-csyms/vals
       ;;formated-all-stored-sys-csyms formated-all-stored-sys-csyms-sym/vals
       formated-all-csartloc-syms formated-all-csartloc-syms/vals
       formated-all-stored-csyms formated-all-stored-csyms/vals
       formated-newlink-csyms
       ;;unformated
       all-csart-cat-sym-db all-scale-csyms all-qvar-csyms 
       all-qvar-csyms-sym all-special-csyms ;;all-csyms all-csyms/vals
       all-csartloc-syms all-csartloc-syms/vals 
       all-stored-csyms  all-stored-csyms/vals 
       newlink-made-csyms))
     (return-formated-data-p
      (values        
        formated-csyms-db formated-all-scale-csyms formated-all-qvar-csyms 
       formated-all-special-csyms ;;formated-all-csyms formated-all-csyms/vals
       ;;formated-all-stored-sys-csyms formated-all-stored-sys-csyms-sym/vals
       formated-all-csartloc-syms formated-all-csartloc-syms/vals
       formated-all-stored-csyms formated-all-stored-csyms/vals
       formated-newlink-csyms))
     (return-data-p
      (values 
       all-csart-cat-sym-db all-scale-csyms all-qvar-csyms 
       all-qvar-csyms-sym all-special-csyms ;;all-csyms all-csyms/vals
       all-csartloc-syms all-csartloc-syms/vals 
       all-stored-csyms  all-stored-csyms/vals 
       newlink-made-csyms)))
    ;;end let, get-all-csq-data
    ))
;;TEST
;; (get-all-csq-data)



;;SAVE-REVISED-USER-FILE-DATA
;;2019
;;ddd
(defun save-revised-user-file-data (file &key 
                                         (dirpath *csq-save-all-dirpath)
                                         ;;"C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\")
                                         (csq-elmsym-lists *all-elmsyms)
                                         (csq-data-list *csq-data-list)
                                         (all-PCqvars *all-pcsyms) ;;all-PCqvars                                        
                                         (csq-value-ranking-lists *all-csq-value-ranking-lists)
                                         set-csq-symbols-to-data-p
                                         save-cs-explore-data-p
                                         )
  "U-CS Uses save-csq-data-to-file to save different global var lists to a user data file  NOTE: If use     ,*MASTER-CSART-CAT-DB must be set to a list."
  (cond
   ((and save-cs-explore-data-p (boundp '*MASTER-CSART-CAT-DB) 
             (listp *MASTER-CSART-CAT-DB))
    (setf save-cs-explore-data-p T))
   (t (setf save-cs-explore-data-p nil)))

  (save-csq-data-to-file file :dirpath *csq-save-all-dirpath
                         ;;"C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\")
                         :csq-elmsym-lists csq-elmsym-lists
                         :csq-data-list csq-data-list  :all-PCqvars all-PCqvars
                         :csq-value-ranking-lists csq-value-ranking-lists
                         :set-csq-symbols-to-data-p set-csq-symbols-to-data-p
                         :save-cs-explore-data-p save-cs-explore-data-p)
  ;;end save-revised-user-file-data
  )
;;TEST
;; (save-revised-user-file-data "Tom-AllData2019-03.lisp")





;;READ-SAVED-CSQ-DATA
;;   (OLDER--LESS EFFICIENT?)   SEE: LOAD-USER-CSQ-DATA
;;
;;ddd
(defun read-saved-csq-data (file &key (set-csq-symbols-to-data-p T)
                                 (eval-objects-p  T)                              
                                 (all-data-list-syms *all-csq-data-list-syms)
                                 (file-data-syms '(*file-elmsyms *file-elmsymvals *file-pcsyms 
                                                                 *file-pcsymval-lists *file-csq-data-list
                                                                 *file-all-pc-element-qvars 
                                                                 *file-all-pcqvar-lists))
                                 ;;not needed (determine-starting-point-p T)
                                 (dirpath "C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\"))
  "In U-CS, Reads in CSQ data and sets to (format out *file-elmsyms *file-elmsymvals *file-pcsyms  *file-pcsymval-lists *csq-data-list. If EVAL-OBJECTS-P, sets car of lists to list[Each begins with *file-].  SET-CSQ-SYMBOLS-TO-DATA-P set regular csq symbols to the data in the file also. Otherwise the word '*file-' precedes the symbol. [Can also later set csq data to '*file- symbol.]  Reads ONLY FIRST 5 OBJECTS IN FILE. When DETERMINE-STARTING-POINT-P , uses data to set where to start rest of CSQ.
  NOTE: Attempts to auto-correct if file is full path."
  (let
      ((pathname (cond ((or (> (length file) 25)
                            (and (stringp file)(equal (elt file 1) #\:))) file)
                                      (t    (format nil "~A~A" dirpath file))))
       (object)
       (object-list)
       (elmsym)
       )
    ;;(break "in read")
    ;;RESET GLOBAL VARS
       ;;(*ELMSYMS *ELMSYMVALS *PCSYMS *PCSYMVAL-LISTS *CSQ-DATA-LIST *ALL-PC-ELEMENT-QVARS *ALL-PCQVAR-LISTS)
       (when all-data-list-syms
         (loop
          for sym in all-data-list-syms
          do
          (set sym nil))
         ;;end when
         )
       (when file-data-syms
         (loop
          for sym in file-data-syms
          do
          (set sym nil))
         ;;end when
         )
          
  (with-open-file ( in pathname :direction :input)
    (loop
     ;;for object-n from 1 to (list-length all-data-list-syms)
     for sym in  all-data-list-syms
     do
     (setf object (read in)
           object-list (append object-list (list object)))
     ;;(break "object 1")
     (when (and eval-objects-p (listp object)
                                              (or (equal (car object) 'setf)
                                                  (equal (car object) 'set-sym&subsyms)))
      (eval object))
       ;;(break "object 2")
     (when set-csq-symbols-to-data-p
       (set sym (eval (second object))))
       ;;end loop
     )
    ;;end with-
    )

  ;;EVAL THE  INNER CONTENTS OF SOME LISTS--IF EXIST
;;*ALL-CSQ-DATAFILE-VARS = (*file-all-pc-element-qvars *file-all-pcqvar-lists *file-csq-data-list          *file-elmsyms *file-elmsymvals *FILE-PCSYMS *file-pcsymval-lists)
  (when *FILE-ELMSYMS
    (setf  *all-elmsyms *file-elmsyms))
  (when *FILE-ELMSYMVALS
    (loop
     for list in *file-elmsymvals    
     do
     (setf elmsym (my-make-cs-symbol (car list)))
     (set elmsym list)
     )
    ;;end when
    )
  ;;NOTE: *file-elmsymvals set above 

 ;;NOTE: *FILE-PCSYMS not needed--the pcsyms are set to the pcsymval-lists below
  (when *FILE-PCSYMVAL-LISTS
    (loop
     for list in *file-pcsymval-lists
     do
     (set (car list) (second list))
     )
    ;;end when
    )
  (when *FILE-CSQ-DATA-LIST
    (setf *csq-data-list *file-csq-data-list))
  (when *FILE-ALL-PC-ELEMENT-QVARS
      (setf *ALL-PC-ELEMENT-QVARS *file-all-pc-element-qvars))
  (when *FILE-ALL-PCQVAR-LISTS
    (setf *ALL-PCQVAR-LISTS *file-all-pcqvar-lists))
  
  ;;WHERE TO START CSQ? DONE IN CSQ-CHOICE-FRAME
  ;;SSS REFINE LATER, SO AUTO STARTS WHERE USER LEFT OFF?

#|  (when determine-starting-point-p
    (cond
     ;;ADD ALT FOR AFTER HAVE ADDED VALUES
     (*file-all-pcqvar-lists
      (setf  *csq-begin-step 'find-pc-values 
             *run-begin-with-find-pcs-p NIL *run-complete-csq-p NIL))
     (*file-elmsymvals
      (setf  *run-begin-with-find-pcs-p T *run-complete-csq-p NIL ))
     (t (setf *run-complete-csq-p T)))
    ;;(break "begin")
    ;;end when
    )|#
  object-list
  ;;end let, read-saved-csq-data
  ))
;;TEST
;;  (read-saved-csq-data "CSQ-TomShortTest.lisp")
;;  (read-saved-csq-data "csq-output-temp-old.lisp")
;;  (read-saved-csq-data "TOM-CSQ-PT1.LISP")
;; works
;;  (read-saved-csq-data "Tom-AllData2017-01-copy.lisp"  :set-csq-symbols-to-data-p T )
;;
;;  (read-saved-csq-data "csq-output-test1.lisp" :set-csq-symbols-to-data-p T )
;; works= seems to.. all above symbols eval to what appears ok
;;  also CL-USER 90 > MOTHER =  ("MOTHER" "mother" ELM2-1-1-99 NIL NIL :BIPATH (((MOTHER NIL (CAREFOROTHERS (POLE1) NIL))) ((MOTHER NIL (INTIMATE (POLE1) NIL))) ((MOTHER NIL (FLEXIBLE (POLE1) NIL))) ((MOTHER NIL (CASUAL (POLE1) NIL))) ((MOTHER NIL (EGOTISTICAL (POLE2) NIL))) ((MOTHER NIL (EXUBERANT (POLE2) NIL))) ((MOTHER NIL (NOTTHEORIST (POLE1) NIL))) ((MOTHER NIL (LOVEX (POLE1) NIL))) ((MOTHER NIL (LOVEDANCE (POLE1) NIL))) ((MOTHER NIL (HELPINGCAREER (POLE2) NIL))) ((MOTHER NIL (HIGHIMPACT (POLE2) NIL)))))
;; AND CL-USER 91 > MATERIALISTIC = ("MATERIALISTIC" "MATERIALISTIC vs NOT MATERIALISTIC" CS2-1-1-99 NIL NIL :PC ("MATERIALISTIC" "NOT MATERIALISTIC" 2 NIL) :POLE1 "MATERIALISTIC" :POLE2 "NOT MATERIALISTIC" :BESTPOLE 2 (:BIPATH ((POLE1 NIL SALESPERSON NIL) (POLE1 NIL ANGLOS NIL) (POLE2 NIL BUDDHISTS NIL))))


;;  CL-USER 47 > *FILE-PCSYMS = (A4 B7 C0 D4)              
;; CL-USER 48 > *FILE-ELMSYMS = (MOTHER FATHER BEST-M-FRIEND BEST-F-FRIEND)
;; ALSO:
;; ;;CL-USER 1 > mother  = ("MOTHER" "mother" ELM2-1-1-99 NIL NIL :BIPATH (((MOTHER NIL (A4 (POLE2) NIL))) ((MOTHER NIL (B7 (POLE2) NIL))) ((MOTHER NIL (C0 (POLE2) NIL)))))









;;RANK-BY-PC-VALUES
;;
;;ddd
(defun rank-by-pc-values (&key (csqdatalist *csq-data-list)
                               (sort-list-p T) (return-only-sorted-p T) (reduce-duplicates-p T))
  "U-CS.lisp, Input *csq-data-list; RETURNS (values sorted-pc-value-lists pc-value-list) where each list is (pc value) . return-only-sorted-p only works if sorted."
  (let
      ((pc-value-list)
       (pc-value-lists)
       (pc-val-only-list)
       (pc-val-only-lists)
       (sorted-pc-value-lists)
       (sorted-pc-val-only-lists)
       (pc)
       (pcbest)
       (value)
       (bestpole)
       (pole1)
       (pole2)
       )
    (loop
     for pclist in (second csqdatalist)
     do
     (setf pc (car pclist)
           value (fifth (fourth (second pclist)))
           bestpole (get-keyvalue-in-nested-list '((:bestpole T 1))  (eval pc))
           pole1 (get-keyvalue-in-nested-list '((:pole1 T 1)) (eval pc))
           pole2 (get-keyvalue-in-nested-list '((:pole2 T 1)) (eval pc))
           pc-val-only-list (list pc value)
           pc-val-only-lists (append pc-val-only-lists (list pc-val-only-list)))

     (cond
      ((= bestpole 1)
       (setf  pc-value-list (list pole1 pole2 value pc)))
      ((= bestpole 2)
       (setf  pc-value-list (list pole2 pole1 value pc))
       ))

     (setf pc-value-lists (append pc-value-lists (list  pc-value-list)))

     ;;end loop
     )
    (cond
     (sort-list-p
      (setf sorted-pc-value-lists (my-sort-lists 2 pc-value-lists :descending-p T 
                                                 :reduce-duplicates-p reduce-duplicates-p)
            sorted-pc-val-only-lists (my-sort-lists 2 pc-val-only-lists :descending-p T 
                                                    :reduce-duplicates-p reduce-duplicates-p))
      (cond
       (return-only-sorted-p
        (values sorted-pc-value-lists  sorted-pc-val-only-lists))
       (t
        (values sorted-pc-value-lists pc-value-lists pc-val-only-lists))))
     (t (values pc-value-lists pc-val-only-lists)))

    ;;end let, rank-by-pc-values
    ))
;;TEST
;; (setf *ranked-pcs-by-values  (rank-by-pc-values :reduce-duplicates-p T))
;; (rank-by-pc-values :sort-list-p nil )
;;   (setf *test-csq-data-list '(:PCSYM-ELM-LISTS ((CAREFOROTHERS (MOTHER FATHER BEST-M-FRIEND (CAREFOROTHERS CAREFOROTHERS :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12) (CAREFOROTHERS CAREFOROTHERS :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12) (CAREFOROTHERS CAREFOROTHERS :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12))) (INTIMATE (MOTHER BEST-M-FRIEND BEST-F-FRIEND (INTIMATE INTIMATE :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) ))) ..etc


;;MAKE-CSQ-RESULTS-TREE-FRAMES
;;2017
;;ddd
(defun make-csq-results-tree-frames (pathname &key  expand-all
                                              (csq-treeview-datalists *csq-treeview-data-lists) 
                                              (make-sorted-pc-values-frame-p T)
                                              (incf-init-y 70)
                                              (init-y 20) (min-treeview-pane-height 820))
  "In   Makes   treeview list frames INPUT:  If pathname=NIL, evals the data variables without reading file.  If expand-all 'ALL, expands all nodes, if 'NONE, expands none, if NIL, up to individual arg list."
;;*file-elmsymvals *file-pcsymval-lists *file-csq-data-list *file-all-pc-element-qvars *file-all-pcqvar-lists *file-pcsyms *file-elmsyms
;; *csq-treeview-data-lists = ((:DATASYM *FILE-CSQ-DATA-LIST :FRAME-ARGS (:EXPANDP 99 :TITLE "CSQ-DATA-LIST-ARGS" :WIDTH 500)) (:DATASYM *FILE-ELMSYMVALS :FRAME-ARGS (:EXPANDP 99 :TITLE "CSQ ELMSYMVALS" :WIDTH 500)) (:DATASYM *FILE-PCSYMVAL-LISTS :FRAME-ARGS (:EXPANDP 99 :TITLE "CSQ PCSYMVAL-LISTS" :WIDTH 450)) (:DATASYM *FILE-ELMSYMS :FRAME-ARGS (:EXPANDP 1 :TITLE "CSQ ELMSYMS" :WIDTH 300)))
  (let
      ((eval-file-syms-p)
       (init-y 10)       
       )
    (when pathname (setf eval-file-syms-p T)
      (read-saved-csq-data pathname :set-csq-symbols-to-data-p eval-file-syms-p
                           :eval-objects-p eval-file-syms-p))
    (loop
     for datalist in  csq-treeview-datalists
     do
     (when (and datalist  (listp datalist))
       (let*
           ((datasym (get-key-value :datasym datalist) )
            (frame-args (get-key-value :frame-args datalist))
            (expandp (get-key-value :expandp frame-args))
            (title (get-key-value :title frame-args))
            (min-width (get-key-value :width frame-args))
            (sym-datalist (eval datasym))
            (group-by-val-p (get-key-value :group-by-val-p frame-args))
            (order-by-rank-p  (get-key-value :order-by-rank-p frame-args) )
            )
         (unless min-width
           (setf min-width 500))

         (cond
          ((equal expand-all 'ALL)
           (setf expandp T))
          ((equal expand-all 'NONE)
           (setf expandp NIL)))

         ;;MAKE THE TREE
         (make-treeview-frame sym-datalist :frame-title title :expand-tree-p expandp
                              :initial-y init-y :min-treeview-pane-height min-treeview-pane-height 
                              :min-treeview-pane-width min-width
                              :group-by-val-p group-by-val-p :order-by-rank-p order-by-rank-p)     
     
         (setf init-y (+ incf-init-y init-y))
         ;;end let,when,loop
         )))
    (when make-sorted-pc-values-frame-p
      (sort-pcs-by-value  :return-list-p NIL))
    ;;end let, make-csq-results-tree-frames
    ))
;;TEST
;;  (make-csq-results-tree-frames  NIL)
;;SSSS make-csq-results-tree-frames here
;; (make-csq-results-tree-frames  "Tom-AllData2017-01-copy.lisp")
;; (make-csq-results-tree-frames "Tom-AllData2019-03.lisp"
;; WORKS: Produces 7 or 8 expanded treeview frames







;;SORT-PCS-BY-VALUE&RANK
;;2018-02
;;ddd
(defun sort-pcs-by-value&rank (pcsyms &key (groupkey :va)
                                      (sortkey :RNK)
                                    (datalist *csq-data-list)
                                  return-all-lists-p
                                  (make-treeview-p T) return-unsorted-list-p
                                  (rank-within-values-p T) splice-matched-lists-p 
                                  only-group-numbers-p (only-sort-numbers-p t) 
                                ascending-p  (descending-p T) (return-list-p T))
  "In  U-CS, PREFERRED function to sort pcs by values (and ranks within same value) and to make a treeview list of them.  Only uses datalist if no pcsyms list. RETURNS    INPUT:  "
  (let
      ((unsorted-lists)
       (group-matched-lists)
       (sorted-lists)
       (pcsym-elm-list)
       (use-syms-p)
       )
  (cond
   ((and pcsyms (listp pcsyms) (boundp (car pcsyms)) )
    (setf use-syms-p T))
   ;;find pcsyms from datalist & see if the pcsyms are bound
   ((and (setf pcsyms (nth-value 1 (make-pcsymval-lists :all-datalists datalist)))
         (boundp (car pcsyms))) 
        (setf use-syms-p T))
   ;;otherwise just use the older function
   (t      
    (multiple-value-setq (sorted-lists unsorted-lists)
        (sort-pcs-by-value-from-csq-data-list :csq-data-list datalist
                                              :return-list-p return-list-p
                                              :return-unsorted-list-p return-unsorted-list-p
                                               :descending-p descending-p))))
  (when use-syms-p
    (loop
     for pcsym in pcsyms
     do
     (let*
         ((pcsymvals (eval pcsym))
          (pc-rating (get-key-value groupkey pcsymvals))
          (pc-rank (get-key-value sortkey pcsymvals))
          (sortlist)
          )
       (cond
        (pc-rank
         (setf sortlist (list pcsym pc-rating pc-rank)))
        (t  (setf sortlist (list pcsym pc-rating))))

       ;;append
       (setf unsorted-lists (append unsorted-lists (list sortlist)))
       ;;end llet,loop
       ))

    ;;(break "unsorted-lists")
    ;;GROUP/SORT THE LISTS
    (setf group-matched-lists 
          (group-lists-by-nths 1 unsorted-lists :group-matched-lists-p 
                               (null splice-matched-lists-p)))

    #|(group-keylists-by-keyvalues groupkey unsorted-lists  :sortkey sortkey
                                         :splice-matched-lists-p splice-matched-lists-p 
                                         :only-group-numbers-p only-group-numbers-p
                                         :only-sort-numbers-p only-sort-numbers-p
                                         :ascending-p ascending-p :descending-p descending-p)|#
    ;;(break "sorted-lists")
    ;;end when  use-syms-p
    )
   ;;(break "group-matched-lists")
   (setf  sorted-lists (sort-inner-lists 2 group-matched-lists :test 'my-lessp))
;;test
;; (setf *x-sorted-lists (sort-1nested-lists 2 **pcs-by-value&rank :test 'my-lessp))

    (when make-treeview-p
      (make-treeview-frame sorted-lists :frame-title "PCSYMS SORTED BY VALUES"
                           :min-treeview-pane-width 300))
    (cond
     (return-all-lists-p 
      (values  sorted-lists group-matched-lists unsorted-lists))
     ((null return-list-p)
      NIL)
     (t sorted-lists))
    ;;end let, sort-pcs-by-value&rank
    ))
;;TEST
;; (sort-pcs-by-value&rank *pcsyms)
;; (setf **pcs-by-value&rank (sort-pcs-by-value&rank  *file-pcsyms))
;; WORKS FOR MY REAL PCS = (((VALUEGROUPHAPPINES "0.917" 1) (CAREABOUTOTHERSFEE "0.917" 2) (CAREFOROTHERS "0.917" 3) (ENLIGHTENWORLD "0.917" 4) (SPREADKNOWLEDGE "0.917" 4.5) (SPIRITUALINTEGRATI "0.917" 5) (SEEKULTIMATETRUTH "0.917" 6) (HIGHIMPACT "0.917" 7) (DIRECT-HONEST "0.917" 8) (HIGHINTELLIGENCE "0.917" 9) (AUTONOMOUS "0.917" 10) (OPTIMISTIC "0.917" 11) (SELF-DISCIPLINE "0.917" 12) (ESPOSECHRISTIAN "0.917" 13) (PROGRESSIVE "0.917" 14) (SOLVEPROBLEMS "0.917" 15) (CRUEL "0.917" 16) (ATHLETIC "0.917" 17) (HELPINGCAREER "0.917" 18)) ((GREATLEADER "0.750" 1) (INSPIREOTHERS "0.750" 2) (LOVEX "0.750" 4) (INDUSTRIOUS "0.750" 5) (PERFORMANCE-ORIENT "0.750" 6) (FLEXIBLE "0.750" 7) (INTIMATE "0.750" 7.5) (LIBERALCHRISTIAN "0.750" 8) (EXUBERANT "0.750" 8) (EMPATHETICLISTENER "0.750" 9) (PLAYFUL "0.750" 10) (INFLUENCIAL "0.750" 11) (COGNITIVEPSYCHS "0.750" 12) (MATERIALISTIC "0.750" 13) (NOTANALYTIC "0.750" 14) (INDIVIDUALISTIC "0.750" 15) (SKILLEDMOVEMENTS "0.750" 16) (VERBALSKILLS "0.750" 16) (LAWFUL "0.750" 17) (CLOSE "0.750" 18) (NOTHISTORY-ORIENTE "0.750" 19) (RESPECTED "0.750" 20) (SOCIALCONSTRAINTS "0.750" 21) (COURTEOUS "0.750" 22) (PATERNAL "0.750" 23)) ((STARPERFORMER 0.5 1) (PUBLICSERVANT 0.5 2) (PEOPLE-JOB 0.5 3) (PERFORMER 0.5 4) (CASUAL 0.5 5) (FANTASYWORLD 0.5 6) (SEEKATTENTION 0.5 7) (UNBRIDLEDHUMOR 0.5 7) (CATHOLIC 0.5 8) (CRITICAL 0.5 9)) ((EUROCENTRICVALUES "0.667" 1) (PHYSICALWELLBEING "0.667" 2) (EGOTISTICAL "0.667" 3) (LESSWEALTH "0.667" 3.5) (CREATENEWRULES "0.667" 4) (BEHAVIORALPSYCH "0.667" 5) (GREATSPEAKER "0.667" 6) (MANAGER0 "0.667" 7) (HIGHSTATUS "0.667" 8) (HUMOROUS "0.667" 10) (NOTLOYAL "0.667" 10.5) (SEXY "0.667" 11) (LOVEDANCE "0.667" 12) (ENFORCERULES "0.667" 13) (EMOTIONAL "0.667" 13) (DEPENDGOV "0.667" 14) (SECULAR "0.667" 15) (MANUALWORK "0.667" 16) (SELF-DISCLOSE "0.667" 17)) ((DEEPUNDERSTANDPEOP "0.833" 1) (FIGHTILLNESS "0.833" 2) (HIGHSTANDARDS "0.833" 2) (MISSIONSPREADPSYCH "0.833" 2) (DEMOCRATICLEADER "0.833" 3) (HIGHLYEDUCATED "0.833" 4) (CONFIDENT-SELF-EST "0.833" 5) (HELPER "0.833" 5.5) (RATIONAL "0.833" 6) (INTIMATELYASSERTIV "0.833" 6) (PRAGMATIC "0.833" 7) (PRACTICAL "0.833" 7.5) (LESSCIVILIZED "0.833" 8) (CREATIVE "0.833" 8.5) (BESTFRIEND "0.833" 9) (GLOBALPERSPECTIVE "0.833" 10) (UNDERSTANDING4 "0.833" 11) (UNDERSTANDING "0.833" 11) (IMPULSIVE "0.833" 12) (INTERPERSONALSKILL "0.833" 12.5) (FUNCOMPANION "0.833" 13) (NOTTHEORIST "0.833" 14) (OVERCOMEDIFFICULTI "0.833" 14.5) (ENCOURAGING "0.833" 15) (GOODNEGOTIATOR "0.833" 16) (GREEDY "0.833" 17) (AGGRESSIVE "0.833" 17) (SEEKEXTERNALAPPROV "0.833" 18) (PETTY "0.833" 18) (PERSUASIVE "0.833" 19)) ((GROUPKNOWLEDGEWORK "0.583" 1) (TEACHER1 "0.583" 2) (PROFESSIONAL "0.583" 3) (PSYCHOLOGISTS "0.583" 3) (PSYCHOLOGIST "0.583" 3.5) (COUNSELORS "0.583" 4) (LEGALEXPERT "0.583" 5) (OWNER "0.583" 6) (REPRESENTGROUP "0.583" 7) (LOCALLEADER "0.583" 8) (ENTERTAINER "0.583" 9) (METICULOUS "0.583" 10) (CHARMING "0.583" 11) (SOFTSPOKEN "0.583" 12) (TEAMMATE "0.583" 13) (CHILDHOODFRIEND "0.583" 14) (SHOWBUSINESS "0.583" 15) (PROFIT-ORIENTED "0.583" 16) (DEBONAIRE "0.583" 17) (LESSMORALISTIC "0.583" 18) (DRAMATIC "0.583" 19) (RITUALISTIC "0.583" 20) (OCCUPATION "0.583" 21) (IMMIGRANTS "0.583" 22) (SEXDEVIANCE "0.583" 23)))



;;SORT-PCS-BY-VALUE-FROM-CSQ-DATA-LIST
;;2017
;;ddd
(defun sort-pcs-by-value-from-csq-data-list (  &key  (csq-data-list *file-csq-data-list )
                                  return-unsorted-list-p (make-treeview-p T)
                                  (descending-p T) (return-list-p T))
  "In U-CS NON-PREFERRED way to sort pcvals and make a treeview frame, but can be made from only csq-data-list.  RETURNS (values  sorted-lists unsorted-lists) if  return-unsorted-list-p"
  (let
      ((unsorted-lists)
       (sorted-lists)
       (pcsym-elm-list (get-keyvalue-in-nested-list '((:PCSYM-ELM-LISTS 0)) csq-data-list))
       )
    (loop
     for pclist in pcsym-elm-list
     do
     (let*
         ((pcsym (car pclist))
          (pc-rating (nth 4 (fourth (second pclist))))
          (sortlist (list pcsym  pc-rating))
          )
       (setf unsorted-lists (append unsorted-lists (list sortlist)))
       ;;end llet,loop
       ))
    (setf sorted-lists (my-sort-lists 1 unsorted-lists  :descending-p descending-p))

    (when make-treeview-p
      (make-treeview-frame sorted-lists :frame-title "PCSYMS SORTED BY VALUES"
                           :min-treeview-pane-width 300))

    (cond
     (return-unsorted-list-p 
      (values  sorted-lists unsorted-lists))
     ((null return-list-p)
      NIL)
     (t sorted-lists))
    ;;end let, sort-pcs-by-value-from-csq-data-list
    ))
;;TEST
;; (sort-pcs-by-value-from-csq-data-list  :return-list-p NIL)





;;GET-SET-DELETE-APPEND-CSQ-DATA-LIST
;;2018-01-20
;;ddd
(defun get-set-delete-append-csq-data-list (listkey key value &key (datalist *csq-data-list) 
                                                     (keyloc-n 99)(val-nth 1) update-csq-data-list-p
                                   append-value-p list-first-item-in-append-p add-value-p 
                                   splice-newvalue-at-nth-p key-in-prev-keylist-p 
                                   (test (quote my-equal)) return-list-p key=list-p 
                                   put-key-after-items put-value-after-items 
                                   new-begin-items new-end-items splice-key-value-in-list-p 
                                   splice-old-new-values-p parens-after-begin-items-p (return-nested-list-p t) 
                                   (max-list-length 1000) if-not-found-append-key-value-p
                                   return-all-values-p)  
  "In U-CS.lisp, In keylist for listkey, finds or adds key, get, set, delete, appends it. If (null return-all-values-p) RETURNS (values  return-keylist new-return-nested-lists) OTHERWISE RETURNS (values return-keylist new-return-nested-lists new-keylist return-value  old-keylist last-key-found-p ) Uses get-set-append-delete-keyvalue-in-nested-list"
  ;;modify data-list
  (multiple-value-bind (return-keylist new-return-nested-lists new-keylist return-value  
                                       old-keylist last-key-found-p )
      (get-set-append-delete-keyvalue-in-nested-list value 
                                                     (list (list listkey T)(list key keyloc-n val-nth))
                                                     datalist
                                                     :add-value-p T :append-value-p nil
                                                     :key-in-prev-keylist-p T
                                                     :if-not-found-append-key-value-p NIL
                                                     :list-first-item-in-append-p  list-first-item-in-append-p
                                                     :splice-newvalue-at-nth-p  splice-newvalue-at-nth-p
                                                     :test test         :return-list-p return-list-p  
                                                     :put-key-after-items put-key-after-items
                                                     :put-value-after-items put-value-after-items
                                                     :new-begin-items new-begin-items :new-end-items new-end-items
                                                     :splice-key-value-in-list-p splice-key-value-in-list-p
                                                     :splice-old-new-values-p splice-old-new-values-p
                                                     :parens-after-begin-items-p parens-after-begin-items-p  
                                                     :return-nested-list-p return-nested-list-p
                                                     :max-list-length max-list-length
                                                     :if-not-found-append-key-value-p if-not-found-append-key-value-p)

    ;;("NICE" "nice vs nnice" CS2-1-1-99 NIL NIL :PC ("nice" "nnice" 1 NIL) :POLE1 "nice" :POLE2 "nnice" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)))
    ;; *quest-- (HON HON :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12)

    ;;SET MODIFIED *CSQ-DATA-LIST
    (when update-csq-data-list-p
      (setf *csq-data-list new-return-nested-lists))

  (cond
   (return-all-values-p
    (values return-keylist new-return-nested-lists new-keylist return-value  
            old-keylist last-key-found-p ))
   (t (values  return-keylist new-return-nested-lists)))
  ;;end mvb, get-set-delete-append-csq-data-list
  ))
;;TEST
;; (setf *test-csq-data-list '(:PCSYM-ELM-LISTS ((KIND1 (MOTHER FATHER BEST-M-FRIEND)) (FEM4 (MOTHER BEST-M-FRIEND BEST-F-FRIEND)) (UNDERST (MOTHER BEST-F-FRIEND FATHER))))                           kind1 '("KIND1" "kind vs ukind" CS2-1-1-99 NIL NIL :PC ("kind" "ukind" 1 NIL) :POLE1 "kind" :POLE2 "ukind" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)) :va "0.917")                FEM4 '("FEM4" "fem vs male" CS2-1-1-99 NIL NIL :PC ("fem" "male" 0 NIL) :POLE1 "fem" :POLE2 "male" :BESTPOLE 0 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL BEST-M-FRIEND NIL)) :va "0.833")               UNDERST   '("UNDERST" "underst vs nunders" CS2-1-1-99 NIL NIL :PC ("underst" "nunders" 1 NIL) :POLE1 "underst" :POLE2 "nunders" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL FATHER NIL)) :va "0.917"))
;; (get-set-delete-append-csq-data-list 'underst :newkey 'newvalue :datalist *test-csq-data-list)
;; works = (UNDERST (MOTHER BEST-F-FRIEND FATHER) :NEWKEY NEWVALUE)                 (:PCSYM-ELM-LISTS ((KIND1 (MOTHER FATHER BEST-M-FRIEND)) (FEM4 (MOTHER BEST-M-FRIEND BEST-F-FRIEND)) (UNDERST (MOTHER BEST-F-FRIEND FATHER) :NEWKEY NEWVALUE)))




;;GET-SCALE-SLOT-VALUES
;;2019
;;ddd
(defun get-scale-slot-values (scale &key (return-values-p T) 
                                    (most-scale-info-p T) label-p name-string-p description-p
                                    mean-score-p num-questions-p scale-questions-p)
  "In U-cs, USE NEWER GET-SLOT-VALUES INSTEAD?? Finds designated CSQ SCALES standard slot-values. RETURNS (values name-string label  description num-questions  scale-questions mean-score scale-inst-sym scale-inst).  
       IF (null return-values-p) RETURNS (values scale-info-list scale-inst-sym), a key list with key for each value returned (selected by keys in arg). TIP: use :return-list-p to get only 1 or 2 values.NOTE: scale can be a symbol, string, or scale-instance"
  (let*
      ((scale-inst-sym) 
       (scale-inst) 
       (scale-info-list) 
       (label)
       (name-string)
       (scale-name)
       (description)
       (mean-score)
       (num-questions)
       (scale-questions)
       )
    ;;(break "HERE")
    (cond
     ;;IF SCALE IS A SYMBOL OR STRING
     ((or (symbolp scale) (stringp scale))
      (setf scale-inst-sym (my-make-cs-symbol (format nil "*~A-inst" scale)))
      ;;(break "2")
      (setf  scale-info-list (list scale-inst-sym)
             scale-inst (eval scale-inst-sym)))
     ;;IF SCALE IS A SCALE INSTANCE
     (t (setf scale-inst scale
              name-string (slot-value scale-inst 'name-string)
              scale-name (slot-value scale-inst 'scale-name)
              scale-inst-sym (my-make-cs-symbol (format nil "*~A-inst" scale-name)
                                                scale-info-list (list scale-inst-sym)))))
    ;;WHICH PARTS TO RETURN?
    (when (or name-string-p most-scale-info-p)
      (setf name-string (slot-value scale-inst  'name-string)  ;;(eval scale-inst)
            scale-info-list (append scale-info-list (list :name-string name-string))))
    (when (or name-string-p most-scale-info-p)
      (setf scale-name (slot-value scale-inst  'scale-name)  ;;(eval scale-inst)
            scale-info-list (append scale-info-list (list :scale-name scale-name))))
        ;;(break "scale-inst")
    (when (or label-p most-scale-info-p)
      (setf label (slot-value scale-inst 'label)
            scale-info-list (append scale-info-list (list :label label))))
    (when (or description-p most-scale-info-p)
      (setf description (slot-value scale-inst 'description)
            scale-info-list (append scale-info-list (list :description description))))
    (when (and (or mean-score-p most-scale-info-p)
               (slot-exists-p  scale-inst 'mean-score))
      (setf mean-score (slot-value scale-inst 'mean-score)
            scale-info-list (append scale-info-list (list :mean-score mean-score))))
    (when (or num-questions-p most-scale-info-p)
      (setf num-questions (slot-value scale-inst 'num-questions)
            scale-info-list (append scale-info-list
                                    (list :num-questions num-questions))))
    (when (or scale-questions-p most-scale-info-p)
      (setf scale-questions (slot-value scale-inst 'scale-questions)
            scale-info-list (append scale-info-list (list :scale-questions scale-questions))))
    (cond
     (return-values-p
      (values name-string label scale-name description num-questions  scale-questions
              mean-score scale-inst-sym scale-inst))
     (t 
      (values scale-info-list scale-inst-sym scale-inst)))
    ;;end let, get-scale-slot-values
    ))
;;TEST
;;;; (get-scale-slot-values  'sT1HigherSelf)
;;works = "sT1HigherSelf"   "sT1-HigherSelf-Integrity  happy balance devel discpn phil"   "Values self happiness, integrity, development, learning, discipline, self-sufficiency, independence, balance, and strong philosophy of life. This scale correlated .380 with overall happiness, .166 with low depression, .137 with low anxiety,.327 with low anger/aggression, .327 with the health scale, and .351 with overall relationship success, (10 items)"        10     (THM6LEAR THM9SHAP THM14IND THM22BOD THM23BAL THMCOMPC THMINTEG THMPHIL THMSESUF THMSEDIS)       (THM6LEAR THM9SHAP THM14IND THM22BOD THM23BAL THMCOMPC THMINTEG THMPHIL THMSESUF THMSEDIS)     ".749"  *ST1HIGHERSELF-INST     #<ST1HIGHERSELF 2CAE6557>

;; WHEN RETURN A LIST (:return-values-p = NIL)
;; (get-scale-slot-values  'sT1HigherSelf  :return-values-p NIL)
;; works =(*ST1HIGHERSELF-INST :NAME-STRING "sT1HigherSelf" :LABEL "sT1-HigherSelf-Integrity  happy balance devel discpn phil" :DESCRIPTION "Values self happiness, integrity, development, learning, discipline, self-sufficiency, independence, balance, and strong philosophy of life. This scale correlated .380 with overall happiness, .166 with low depression, .137 with low anxiety,.327 with low anger/aggression, .327 with the health scale, and .351 with overall relationship success, (10 items)" :MEAN-SCORE ".749" :NUM-QUESTIONS 10 :SCALE-QUESTIONS (THM6LEAR THM9SHAP THM14IND THM22BOD THM23BAL THMCOMPC THMINTEG THMPHIL THMSESUF THMSEDIS))     *ST1HIGHERSELF-INST    #<ST1HIGHERSELF 2CAE6557>
;; (get-scale-slot-values  'sT1HigherSelf :most-scale-info-p NIL :name-string-p T  :return-values-p NIL)
;; works =(*ST1HIGHERSELF-INST :NAME-STRING "sT1HigherSelf")    *ST1HIGHERSELF-INST   #<ST1HIGHERSELF 2CAE6557>


;;SET-PCVALS-CSYM1DATALIST 
;;2019
;;ddd
(defun set-pcvals-csym1datalist (  &key (datalist *CSQ-DATA-LIST)(val-n 4) )
  "U-CS,  RETURNS    INPUT:  "
  (let
      ((pcsym-elm-lists (get-key-value :pcsym-elm-lists  datalist))
       (pcsyms-set)
       )
 ;;SSSSS FINISH THIS FUNCTION
    (loop 
     for pcsymlist in pcsym-elm-lists
     do
     (let*
         ((pcsym (car pcsymlist))
          (pcdata (second pcsymlist))
          (pcdata1 (fourth pcdata))
          (pcval (nth val-n pcdata1))
           ;;set the pcval with :val
           (pcsym-set (set-symkeyval pcsym :val pcval))
           )
       (when pcsym-set 
         (setf pcsyms-set (append pcsyms-set (list pcsym))))
     ;;end let,loop
     ))
      pcsyms-set ;; (values    )
    ;;end let, set-pcvals-csym1datalist
    ))
;;TEST
;; (set-pcvals-csym1datalist )
;; works, eg:=
;;CL-USER 29 > CREATIVE =>   ("CREATIVE" "CREATIVE vs NOT CREATIVE" CS2-1-1-99 NIL NIL :PC ("CREATIVE" "NOT CREATIVE" 1 NIL) :POLE1 "CREATIVE" :POLE2 "NOT CREATIVE" :BESTPOLE 1 (:BIPATH ((POLE1 NIL DANCER NIL) (POLE1 NIL MOVIE-STAR NIL) (POLE2 NIL POLICEMAN NIL))) :VAL "0.833")





;;SET-VAL-RANKS-FROM-RANKLISTS
;;2019, Modified 2019-08 to MAKE RELATIVE RANKS (0.01-1.0).
;;ddd
(defun set-val-ranks-from-ranklists (&key (all-ranklists *all-csq-value-ranking-lists)
                                          (use-rel-rank-p T)
                                          (val-n 1)(csvalkey :va) 
                                          (rankkey :RNK) set-value-p)
  "U-CS,  RETURNS pcsyms-set. RANK is RELATIVE NOW (/ n-vals) Sets the rankkey :RNK = rank in pcsymvals for each pcsym in the ranklists (eg (0.917 ((\"HELPING\" 18) etc)).     NOTE: Does NOT set or change :va value unless SET-VALUE-P; When use-rel-rank-p  (eg. 0.01-1.0) instead of absolute rank from all ranklists."
  (let
      ((pcsyms-set)
       )
    (loop 
     for val-ranklist in all-ranklists
     do
    (let*
        ((value (car val-ranklist))
         (ranklists (second val-ranklist))
         (n-ranks (list-length val-ranklist)) ;;new
         )
     (loop
      for ranklist in ranklists
      do            
      (let*
          ((pcname (car ranklist))
           (pcsym (my-make-cs-symbol pcname))
           (abs-rank (nth val-n ranklist))  ;;new
           (rel-rank (/ abs-rank n-ranks))  ;;new
           (rank (cond (use-rel-rank-p rel-rank)(t  abs-rank)))  ;;new
           ;;set the pcval with :val
           (pcsym-set (set-symkeyval pcsym rankkey rank)) 
           )
        (when rank 
          (setf pcsyms-set (append pcsyms-set (list pcsym))))
        ;;if set-value-p
        (when (and set-value-p value)
          (set-symkeyval pcsym csvalkey value))
        ;;end lets,loops
        ))))
    pcsyms-set
    ;;end let, set-val-ranks-from-ranklists
    ))
;;TEST
;; (set-val-ranks-from-ranklists)
;; works= (HELPINGCAREER ATHLETIC CRUEL SOLVEPROBLEMS PROGRESSIVE ESPOSECHRISTIAN SELF-DISCIPLINE OPTIMISTIC AUTONOMOUS HIGHINTELLIGENCE DIRECT-HONEST HIGHIMPACT SEEKULTIMATETRUTH SPIRITUALINTEGRATI SPREADKNOWLEDGE ENLIGHTENWORLD CAREFOROTHERS CAREABOUTOTHERSFEE VALUEGROUPHAPPINES PERSUASIVE PETTY SEEKEXTERNALAPPROV AGGRESSIVE GREEDY GOODNEGOTIATOR ENCOURAGING NOTTHEORIST FUNCOMPANION INTERPERSONALSKILL IMPULSIVE UNDERSTANDING UNDERSTANDING4 GLOBALPERSPECTIVE BESTFRIEND     .... ETC ....      TEAMMATE SOFTSPOKEN CHARMING METICULOUS ENTERTAINER LOCALLEADER REPRESENTGROUP OWNER LEGALEXPERT COUNSELORS PSYCHOLOGIST PSYCHOLOGISTS PROFESSIONAL TEACHER1 GROUPKNOWLEDGEWORK CRITICAL CATHOLIC UNBRIDLEDHUMOR SEEKATTENTION FANTASYWORLD CASUAL PERFORMER PEOPLE-JOB PUBLICSERVANT STARPERFORMER)
;;ALSO
;; CL-USER 6 > NOTTHEORIST   =>   ("NOTTHEORIST" "NOT THEORIST vs ACCOMPLISHED THEORIST" CS2-1-1-99 NIL NIL :PC ("NOT THEORIST" "ACCOMPLISHED THEORIST" 2 NIL) :POLE1 "NOT THEORIST" :POLE2 "ACCOMPLISHED THEORIST" :BESTPOLE 2 (:BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL PER-MOSTFUN NIL) (POLE2 NIL ROLE-MODEL NIL))) :va "0.833" :RNK 14)

;;TEST SET-VALUE-P
#|(setf **test-rank-list-x '((0.5
  (("CRITICAL" 9)
   ("CATHOLIC" 8)
   ("UNBRIDLEDHUMOR" 7)
   ("SEEKATTENTION" 7)
   ("FANTASYWORLD" 6)
   ("CASUAL" 5)
   ("PERFORMER" 4)
   ("PEOPLE-JOB" 3)
   ("PUBLICSERVANT" 2)
   ("STARPERFORMER" 1)))))
|#
;;  (set-val-ranks-from-ranklists  :all-ranklists **test-rank-list-x :set-value-p T)
;; works= (CRITICAL CATHOLIC UNBRIDLEDHUMOR SEEKATTENTION FANTASYWORLD CASUAL PERFORMER PEOPLE-JOB PUBLICSERVANT STARPERFORMER)
;;
;; FOR ITEM WITH :VAL AND :RANK ALREADY SET TO THESE VALUES,
;; worked--didn't change values or duplicate them.
;; CL-USER 13 > CRITICAL  =>   ("CRITICAL" "CRITICAL vs NOT CRITICAL" CS2-1-1-99 NIL NIL :PC ("CRITICAL" "NOT CRITICAL" 2 NIL) :POLE1 "CRITICAL" :POLE2 "NOT CRITICAL" :BESTPOLE 2 (:BIPATH ((POLE1 NIL WORST-BOSS NIL) (POLE1 NIL DIS-TEACHER NIL) (POLE2 NIL BEST-M-FRIEND NIL))) :VAL 0.5 :RANK 9)
;; for PERFORMER, :VAL 0.5 :RANK 4 was correct also
;; 1. Now reset PERFORMER TO NO :VAL OR :RANK
;; (setf PERFORMER '("PERFORMER" "PERFORMER vs NOT PERFORMER" CS2-1-1-99 NIL NIL :PC ("PERFORMER" "NOT PERFORMER" 0 NIL) :POLE1 "PERFORMER" :POLE2 "NOT PERFORMER" :BESTPOLE 0 (:BIPATH ((POLE1 NIL TEACHER NIL) (POLE1 NIL DANCER NIL) (POLE2 NIL BLACKS NIL)))))
;; 2. Reset all vars   (set-val-ranks-from-ranklists  :all-ranklists **test-rank-list-x :set-value-p T)
;; 3. Test PERFORMER => ("PERFORMER" "PERFORMER vs NOT PERFORMER" CS2-1-1-99 NIL NIL :PC ("PERFORMER" "NOT PERFORMER" 0 NIL) :POLE1 "PERFORMER" :POLE2 "NOT PERFORMER" :BESTPOLE 0 (:BIPATH ((POLE1 NIL TEACHER NIL) (POLE1 NIL DANCER NIL) (POLE2 NIL BLACKS NIL))) :RANK 4 :VAL 0.5)   



;; SSSS ============== MOVE TO U-LISTS AFTER FIX? ===================




;;SORT-LISTS-BY-FUNCALL
;;2018-02
;;ddd
(defun sort-lists-by-funcall (function funcargs append-n uncked-lists 
                                       &key (test 'my-greaterp))           
  "In  U-lists. INPUTS a list of 1nested-lists, RETURNS  new list ordered by order of nth-list, nth item nested-list in each list."
  (let
      ((selected)
       (sorted-lists)
       (sorted-lists1)
       (other-items)
       (ret-n)
       (restlists)
       (uncked-lists2)
       (nthlist)
       )
    (cond
     ((listp uncked-lists)
      (multiple-value-setq (selected ret-n restlists uncked-lists2 nthlist)
          (get-greatest/least-list-by-funcalled-items function funcargs append-n 
                                                      uncked-lists :test test))  
        (setf sorted-lists (append sorted-lists (list selected)))
        )
     (t (setf other-items (append other-items (list uncked-lists)))))
  ;;(break "1")
    (when restlists
      (multiple-value-setq (sorted-lists1 other-items restlists)
          (sort-lists-by-funcall function funcargs append-n restlists :test test))
      (setf sorted-lists (append sorted-lists sorted-lists1)))

    (values sorted-lists other-items restlists)
    ;;end let, sort-lists-by-funcall
    ))
;;TEST
;; (sort-lists-by-funcall '#'NTH '(1) 1 '((C 3)(E 5)(A 1)(B 2)))
;; works= ((E 5) (C 3) (B 2) (A 1))   NIL   NIL





;;ORDER-1NESTED-SUBLISTS-BY-FUNCALL
;;2018-02
;;ddd
(defun order-1nested-sublists-by-funcall (function funcargs append-n
                                                    ;;function2 funcargs2 append-n2 
                                                    list-of-1nested-lists
       ;;was (nthlist nth list-of-1nested-lists
                                                      &key (test1 'my-greaterp)
                                                      (test2 'my-greaterp) (begin-n 0))
                                                      ;;ordered-list unordered-list other-items)
  "In  U-lists. INPUTS a list of 1nested-lists, RETURNS  new list ordered by order of nth-list, nth item nested-list in each list. test1 is for inner list test2 is for outer list."
  (let
      ((inner-list-selected-items)
       (sorted-selected-items-lists)
       (other-items)
       (list-n (list-length list-of-1nested-lists))
       (sorted-lists)
       (nth)
       )
    ;;1-MAKE inner-list-selected-items OF (N selected) for each list
    (loop
     for list in list-of-1nested-lists
     for n from begin-n to (+ list-n begin-n)
     do
     ;;(afout 'out (format nil "BEGIN LOOP1 list= ~A n= ~A" list n))
     (cond
      ((listp list)
       (multiple-value-bind (selected ret-n restlists uncked-lists nthlist)
           (get-greatest/least-list-by-funcalled-items function funcargs append-n
                                                       list :test test1)
         (setf inner-list-selected-items (append inner-list-selected-items
                                                 (list (list n selected))))
         ))
      (t (setf other-items (append other-items (list list)))))
     ;;end loop
     )
    ;;(break)
    ;;2-SORT inner-list-selected-items
    (setf sorted-selected-items-lists 
          (sort-lists-by-funcall  #'NTH '(1) 1  inner-list-selected-items :test test2))
    ;;(break)
    ;;3-Use sorted-selected-items-lists to sort uncked-lists
    (loop
     for list in sorted-selected-items-lists
     do
     (setf nth (car list)
           sorted-lists (append sorted-lists (list (nth nth list-of-1nested-lists))))
    ;;end 2nd loop
    )  
    (values  INNER-LIST-SELECTED-ITEMS  other-items)
    ;;end let, defun
    ))  
;;TEST
;;SSSSS START HERE order-1nested-sublists-by-funcall
;; (progn (setf out nil) (order-1nested-sublists-by-funcall #'NTH '(0) 1 '(((E 0.3))    ((D 0.7) (M 0.7) (P 0.7) (S 0.7))      ((C 0.1) (R 0.1))      ((B 0.2) (O 0.2)) ((A 0.4) (L 0.4) (Q 0.4)))))


;; (progn (setf out nil) (order-1nested-sublists-by-funcall #'NTH '(1) 1 '(((E 0.3))    ((D 0.7) (M 0.7) (P 0.7) (S 0.7))      ((C 0.1) (R 0.1))      ((B 0.2) (O 0.2)) ((A 0.4) (L 0.4) (Q 0.4)))))
;;result
#|
((0 (E 0.3)) (1 (S 0.7)) (2 (R 0.1)) (3 (O 0.2)) (4 (Q 0.4)))
NIL|#




;;MAKE-CSLINK ;; NOT NEEDED? USE MAKE-CSYM INSTEAD?? modify for tlinks? ssss
;;2019
;;ddd
(defun make-cslink (csym new-cs-info tlink &key (path-type :BIPATH)
                                                        (node 'N1) ;;if PC 'POLE1
                                                        (system '$MIS) new-csname
                                                        (create-newcs-p T) (art-loc *new-tlink-artloc)
                                                        csdata csdef
                                                        (min-sym-length 4) (max-sym-length 18))
  "U-CS For new-cs 1. CREATES a new csym for new-cs none exists AND if create-newcs-p. 2. In the csym, stores within the path-type a new (:TLINK tlink) NEW-CS list. Error if csym has no csymlist.
     RETURNS (values      ). "
;;SSSSS START HERE WRITING NEW STORE-CSLINK FUNCTION
  (let
      ((new-csym)
       (csymlist (eval csym))
       )
    ;;GET/MAKE NEW-CSYM, NEW-CSNAME
    (cond
     ((null new-csname)
      ;;make new-csname and new-csym
      (multiple-value-setq (new-csym new-csname) ;;not needed? similar-sym new-csymvals)
          (make-condensed-sym new-cs-info :max-length max-sym-length
                                          :min-length min-sym-length)))
     ;;new-csname
     (T (setf new-csym (my-make-cs-symbol new-csname))))

    ;;MAKE NEW-CSYM SYMVALIST etc
;;SSSS USE incf-new-tlink-artloc FUNCTION HERE
    (make-csym new-csym new-cs-info  csdata csdef :system system
               :new-csartloc csartloc
               :BIPATH (list csym nil new-csym))

    ;;STEP 1: STORE LINK INFO IN ORIGINAL CSYM :BIPATH
    
    (values    )
    ;;end let, make-cslink
    ))
;;TEST
;; (make-cslink 





;;STORE-CSYM
;;2019
;; first version depreciated: replaced by (make-dims-treeviewer related functions, so ALL cells and csyms are stored in csartlocs tree(s)
;;ddd
(defun store-csym (csym  &key new-supsys 
                         (use-dated-file-p T) incl-time-p
                         (store-to-file-p T)  return-syms&vals-p
                         (csym-cum-store-file *ALL-STORED-CSYMS-FILE)
                         (all-csyms-sym '*ALL-CSYMS) (supersys-key :CSS)
                         (subsys-key :S))
  "U-CS, Not used by default in make-csym currently.  1. APPENDS CSYM SUPSYS SUBLIST [:S] and 2. GLOBAL CSYMS LIST. 3. When STORE-TO-FILE-P,  saves syms & sym&vals lists to file.  If RETURN-SYMS&VALS-P, returns that list too. 4. When NEW-SUPSYS, modifies :CSS in csym as well.   RETURNS  (values csym csymvals new-css new-css-vals ), 
    used in MAKE-CSYM, Dated file by DAY limits file size to one day's work.
    ALSO If NEW-SUPSYS, appends sublist :S  in supsys sym. "
  (when (listp csym)
    (setf csym (car csym)))
  (when (listp new-supsys)
    (setf new-supsys (car new-supsys)))
  (when (stringp new-supsys)
        (setf new-supsys (my-make-cs-symbol new-supsys)))
  
  (when use-dated-file-p
    (setf csym-cum-store-file 
          (make-dated-pathname (file-namestring csym-cum-store-file) 
                       :root (directory-namestring csym-cum-store-file) :file-ext nil
                       :incl-time-p incl-time-p)))
  (let*
      ;;get symvals for CSYM (should have been set by make-csym)
      ((csymvals  (eval-sym csym)) 
       ;;get SUPERSYS sym, supsys symvals, subsys vals, 
       (cur-supsys (get-key-value supersys-key csymvals))
       (supsysvals) ;;no (progn (when (listp cur-supsys)  (setf cur-supsys (car cur-supsys))   (eval-sym cur-supsys))))
       (all-syms-list (eval-sym all-csyms-sym)) ;;only works with global variable?
       )
    ;;Put NEW-SUPSYS SYM in CSYM :css  value [also adds csym to its sublist below]
    (cond
     (new-supsys 
      (setf csymvals 
            (set-key-value supersys-key NEW-SUPSYS csymvals :append-as-flatlist-p T))
      (set csym csymvals))
     (T (setf new-supsys cur-supsys)))
    
    ;;get supsysvals
    (setf supsysvals (eval-sym new-supsys))

    ;;APPEND CSYM TO  SUPSYS SUBSYS LIST (:S)  if not already listed
    (setf supsysvals
          (append-key-value-in-list subsys-key csym supsysvals :not-duplicate-p T))

    ;;APPEND ALL-CSYMS-LIST
    (unless (or (null all-syms-list) (member csym all-syms-list :test 'equal))
      (set all-csyms-sym (append1 all-syms-list csym)))

    ;;STORE TO FILE?
    (when store-to-file-p
      (with-open-file (outs csym-cum-store-file :direction :output :if-exists :append
                            :if-does-not-exist :create)
        (write (list csym csymvals) :stream outs)
        ;; (format outs " (~A  ~A)" csym csymvals )
        ))
    ;;end let, store-csym
    (values csym csymvals new-supsys new-supsysvals )
    ))
;;TEST
;;test the store to file function
;; (make-csym 'newcsym0 "new0"  "data" "def"  :cs-categories '(cat1 cat2) :supsys-csartloc '$BSK :store-to-file-p "c:\temp\csyms-test.lisp")
;; works= ("NEWCSYM0" "new0" CS.LOC1 "data" "def" :CSS $BSK :CAT (CAT1 CAT2))   NEWCSYM0  CS.LOC1  NIL $BSK  (:S NEWCSYM0)
;; also: NEWCSYM0 =  ("NEWCSYM0" "new0" CS.LOC1 "data" "def" :CSS $BSK :CAT (CAT1 CAT2))
;; [set above: (setf $BSK '($BSK "Behavioral Skill" NIL NIL NIL :S ($PEOP $MECH $MAIN) :CLEV 1  ) CS.LOC1 NIL) also? (setf *ALL-STORED-CSYMS nil)
;; 1. MAKE A NEW CSYM  [ (setf newcsym0 nil) ]  ***USES STORE-CSYM
;; (make-csym 'newcsym0 "new0" 'CS.loc1 "data" "def" :cs-categories '(cat1 cat2) :supsys '$BSK)
;; works=  ("NEWCSYM0" "new0" CSLOC1 "data" "def" :CSS $BSK :CAT (CAT1 CAT2))    NEWCSYM0  CSLOC1   NIL
;;also:  NEWCSYM0 = ("NEWCSYM0" "new0" CSLOC1 "data" "def" :CSS $BSK :CAT (CAT1 CAT2))
;; and  $BSK = ($BSK "Behavioral Skill" :S ($PEOP $MECH $MAIN) :CLEV 1 :S  ((NIL)))
;; TO CHANGE RE-STORE A CSYM (PREVENTS DUPLICATES)
;; 2. STORE-CSYM 
;; (store-csym 'NEWCSYM0)
;; works= NEWCSYM0      ("NEWCSYM0" "new0" CSLOC1 "data" "def" :CAT (CAT1 CAT2) :CSS $BSK)       $BSK       ($BSK "Behavioral Skill" :S ($PEOP $MECH $MAIN) :CLEV 1 :ELMS (NEWCSYM0))
;; also: *ALL-STORED-CSYMS = (NEWCSYM0)

;; ETC
;; (setf  $MISC '($MISC "No-Class" NIL NIL NIL :S NIL  :CLEV 1))
;; (store-csym 'testsym1 nil) 
;; works= ($MISC "No-Class" NIL NIL NIL :S (TESTSYM1) :CLEV 1)
;; also: $MISC=  ($MISC "No-Class" NIL NIL NIL :S   (TESTSYM1) :CLEV 1)
;; and: *ALL-STORED-CSYMS = (TESTSYM1)
;; (store-csym 'testsym2) = ($MISC "No-Class" :S (TESTSYM1 TESTSYM2) :CLEV 1)
;; and: *ALL-STORED-CSYMS= (TESTSYM1 TESTSYM2)



;;STORE-VAR-LISTS-TO-FILE
;;2019
;;ddd
(defun store-var-lists-to-file (&key (var-lists (list *all-stored-vars
                                                       *all-non-sys-vars  *all-stored-sys-vars))
                                            (output-names '(*ALL-STORED-VARS
                                             *ALL-NON-SYS-VARS  *ALL-STORED-SYS-VARS))
                                           return-varvals-p
                                           (path *var-storage-file ))
  "U-CS Stores BOTH vars and var value lists. The VAR-LISTS are lists of nested (or not) var syms which each eval to a value list  RETURNS (values all-stored-list-vars all-stored-varval-lists)  if return-varvals-p, otherwise NIL as 2nd.   INPUT:  Any VARIABLE list set to values will work.
  Note: store? *ALL-STORED-VARS, *ALL-NON-SYS-VARS, *ALL-STORED-SYS-VARS"
  (let
      ((all-stored-list-vars)
       (all-stored-varval-lists)
       )
    (loop
     for varlist in var-lists
     for n from 0 to 99
     do
     (let*
         ((output-name (nth n output-names))
          )
       (when varlist 
         (unless (listp varlist)
           (setf varlist (list varlist)))
         (multiple-value-bind (vars varvalists)
             (store-vars-to-file varlist  :output-name output-name :path path )
           ;;accumulate stored
           (setf all-stored-list-vars (append all-stored-list-vars
                                              (list (list output-name vars))))
           (when return-varvals-p
             (setf all-stored-varval-lists (append all-stored-varval-lists
                                                   (list (list output-name varlist)))))    
           ;;(break "end loop")
           ;;end mvb,when, let, loop
           )) ))
    (values all-stored-list-vars all-stored-varval-lists)
    ;;end let, store-vars-to-file
    ))
;;TEST
;; (store-var-lists-to-file :return-varvals-p T)



;;STORE-VARS-TO-FILE
;;2019
;;ddd
(defun store-vars-to-file (vars  &key (output-name "VARS")
                                   ;;(added-vars '(*all-non-sys-vars))
                                   (path *var-storage-file ))
  "U-CS  Stores BOTH vars and var value lists.  RETURNS (values  all-vars var-symval-lists output-str)   
  INPUT:  Any VARIABLE list set to values will work. If (null path) just returns lists.
  Note: store? *ALL-STORED-VARS, *ALL-NON-SYS-VARS, *ALL-STORED-SYS-VARS"
  (let
      ((output-str (format nil "~%;;Date: ~A LIST-NAME: ~A:" (date-string) output-name))
       (var-symval-lists)
       (all-vars)
       )
    (loop
     for var in vars
     do
     (let*
         ((varvals)
          (varlist)
          )
       (when (stringp var)
         (setf var (my-make-cs-symbol var)))
       (cond
        ((boundp var)
         (setf varvals (eval var)
               varlist (list var varvals)))
        (t  (setf varvals NIL
                  varlist (list var varvals))))
       (setf var-symval-lists (append var-symval-lists (list varlist))
             all-vars (append all-vars (list var)))
       ;;end let,loop
       ))
    (when path
      (with-open-file (outs path :direction :output :if-exists :append :if-does-not-exist :create)
        (format outs "~A~%;;ALL VARS:~%~A~%;;BINDINGS:~%~A~%" output-str all-vars var-symval-lists)      
        ;;end with-
        ))
    (values  all-vars var-symval-lists output-str)
    ;;end let, store-vars-to-file
    ))
;;TEST
;; (store-vars-to-file *all-stored-vars) = it works.
;; 






;;xxx ========================== OLDER DELETE? ======================
#|FIRST VERSION (defun store-csym (csym  &key artdims (default-prefix 'CS)
                               (csyms-db-sym '*CSYMS-DB )
                               (store-artdims-p T)(store-artsyms-p T)(store-orgdims-p T)
                               return-db-p
                               ck-for-duplicates-p)
  "U-CS,    RETURNS    INPUT:  CSYM must NOT be an artsym. ARTDIMS includes system as last--not prefix."
  ;;USES *CSYMS-DB = '(:CSYMS NIL   :ARTDIMS NIL  :ARTSYMS NIL :ORGDIMS NIL)
  ;; IN :ORGDIMS, STORES ARTDIMS IN NESTED LISTS BY EACH LEVEL FROM LAST TO FIRST [normally PREFIX IS TOP, THEN system is last dim= top list] 
  ;; EG. :ORGDIMS (CS (1 (1 (1 2 3))(2 1 1) etc) (HS (1 (1 (1 2 3)(2 (1(2 1 1))))(2 etc)))    (PS (1 (1 2))(2 (1 2 3)) etc) etc)
  (let*
      ((csymlist (eval csym))
       (artsym (third csymlist))
       (artsymlist (eval artsym))
       (prefix (my-make-cs-symbol (first artsymlist)))
       (artdims (second artsymlist))
       (artdims+pre (append (list prefix) artdims))
       (search-spec-list (append (list prefix) (butlast (reverse artdims))))
       (store-dims (last search-spec-list))
       (csyms-db (eval csyms-db-sym))
       (new-csyms-db) 
       (db-csyms (get-key-value :CSYMS csyms-db))
       (new-db-csyms)
       (new-db-artsyms)
       (new-db-artdims)
       (new-db-orgdims)
#|       (orgdims-prefix-list)
       (orgdims-sys-list)
       (orddims-list)|#
       )
    (break)
    (unless (and ck-for-duplicates-p
                 (member csym db-csyms :test 'equal))
      (setf new-db-csyms (append new-db-csyms  (list csym)))
      (when store-artsyms-p
        (setf new-db-artsyms 
              (append (get-key-value :ARTSYMS csyms-db) (list artsym))))
      (when store-artdims-p
        (setf artdims  (second (eval artsym))
              new-db-artdims (append (get-key-value :ARTDIMS csyms-db) (list artdims))))
      ;;SSS TEST SETTING new-db-orgdims HERE
;;SSS NO--USE A VARIATION OF make-tree-nodes-list FUNCTION
      (when store-orgdims-p
        (setf db-orgdims (get-key-value :ORGDIMS csyms-db)
              new-db-orgdims 
              (nth-value 1 (get-set-append-delete-keyvalue-in-nested-list store-dims ;;artdims+pre
                                 search-spec-list  db-orgdims))))
#|(get-set-append-delete-keyvalue-in-nested-list '(NEW 1 2 3) '((CS T)(HS T)(2 T)(4 T) (5 T)) *testorgcsartdims)=> (:ORGDIMS (CS (1 (1 (1 2 3)) (2 1 1) ETC (HS (1 (1 (1 2 3) (2 (1 (2 1 1)))) (2 (3) (4 (1)     (5 (NEW 1 2 3))   )))) (PS (1 (1 2)) (2 (1 2 3)) ETC) ETC)) (NONCS ETC))|#
      ;;MAKE THE NEW CSYMS-DB
      (set csyms-db-sym (list :CSYMS new-db-csyms :ARTDIMS new-db-artdims 
                              :ARTSYMS new-db-artsyms :ORGDIMS new-db-orgdims))
      ;;end unless
      )
 ;;return the db?
  (when return-db-p
    (eval csyms-db-sym))
    ;;end let, store-csym
    ))|#
;;TEST
;; (setf *test-store-db2 '(:CSYMS NIL :ARTDIMS NIL :ARTSYMS NIL :ORGDIMS NIL))
;; (store-csym 'AUTONOMOUS :return-db-p T :csyms-db *test-store-db2)
;; works= (:CSYMS (AUTONOMOUS) :ARTDIMS ((2 1 1 99)) :ARTSYMS (CS2-1-1-99))
#|    I. DB-ITEM TYPES (Make a separate DB-ITEM LIST for each separate item.
      Each has PARTS (separate keys for each part in II. with links to those brain ares) and each may have LINKS (specifiec in paths (eg :BIPATH) to other DB-ITEMS of the same or different type as it. 
  Note: Classes may overlap and a db-item may be a member of more than one type [to list in both or just one--probably just one. Later search both cats to find it.]
       *DB-VALUE (VALUE)
       *DB-BELIEF (SELF STEREOTYPE REGNANT)
       *DB-PC (OPPOSITE)
       *DB-KNOWB (ISA PART WHY CAUSE EVIDENCE HOW EXAMPLE FEATURE PROTOTYPE)
       *DB-COGSK (SM DEC PLAN LEARN COPE CRITTHK)
       *DB-BEHSK (PEOP MECH MAINT )
       *DB-SCRIPT (SCRIPT)
       *DB-EVENT (EVENT)
       *DB-ELM (ELM)   Any abstract or concrete object or entity (eg person,group, object, city, ocean, factory, university, congress, )
  II. INTEGRAL PARTS OF THE DB-ITEM (put within defining/describing list)
       *DB-VERBAL  (NAME DEFINE DESCRIPTION OPPOSITE SYNONYM)
       *DB-IMAGE (IMAGE)
       *DB-SOUND (SOUND)
       *DB-SMELL (SMELL)
       *DB-TASTE (TASTE)
       *DB-TACTILE (TACTILE)
       *DB-EMOTION (EMOTION HAPPY CARE ANXIETY ANGER SAD  )
       *DB-MOTOR (MOTOR)|#

;;OLDER (defparameter *CS-CATEGORIES  '((CS (BV (TOPV (HS () ))(TOPB (WV ()  )))  (ROLES ( ))  (LBS (SM ()) (COPE ()) (LRN ()) (INTR ()) (HLTH ()) (CAR ()) (MANU ()) (ATHL ())))(EMOT (HAP)(CARE)(ANX)(DEP)(ANG))  (SENS (VIS)(AUD)(PROP))(MOT))     "WV= worldview, LBS=LifeBeliefsSkills, SM COPE LRN INTR=Interpers, HLTH CAR MANU ATHL")



;;MAKE-SYM-STR-DIMS-FROM-ANY
;;2019
;;ddd
(defun make-sym-str-dims-from-any (item &key (separators '("." "-")))
  "U-CS-ART. INPUT: Any symbol, string, or dimlist with letters, integers, symbols with dims separated by one of separators. RETURNS: (values sym str dims str-dims). str-dims eg (\"HS\"  \"2\". str-dims not returned when item= list."
  (let*
      ((sym)
       (str)
       (dims)
       (str-dims)
       )
    (cond 
     ((listp item )
      (setf dims item
            str (make-dims-string item)
            sym (my-make-cs-symbol str :delete-chars nil)
            str-dims (make-list-of-strings dims)))
     ((stringp item) 
      (setf str item
            sym (my-make-cs-symbol str  :delete-chars nil))
      (multiple-value-setq (dims str-dims)
             (find-artsym-dims sym)))
     ((symbolp item)
      (setf sym item
            str (format nil "~A" item))
      (multiple-value-setq (dims str-dims)
          (find-artsym-dims sym)))
      )
    (values sym str dims str-dims)
    ;;end let, make-sym-str-dims-from-any
    ))
;;TEST
;;from symbol
;; (make-sym-str-dims-from-any 'CS-HS-22-3)
;; works= CS-HS-22-3  "CS-HS-22-3" (CS HS 22 3) ("CS" "HS" "22" "3")
;;from string
;; (make-sym-str-dims-from-any "CS-HS-22-3")
;; works= CS-HS-22-3  "CS-HS-22-3" (CS HS 22 3)("CS" "HS" "22" "3")
;;from csartdims
;; (make-sym-str-dims-from-any '(CS HS 22 3))
;; works=CS.HS.22.3  "CS.HS.22.3"  (CS HS 22 3)  ("CS" "HS" "22" "3")




;;SET-CSYMS-CSARTLOCS
;;2020
;;ddd
(defun set-csyms-csartlocs (csyms &key set-new-supsys
                                  (csartloc-origin :supsys-csartloc) 
                                  supsys-csartloc
                                  topdim dims (supsys :get) (last-dim :csym)
                                  new-csartloc (def-supsys '$MIS)
                                  csartloc-syms&vals  (if-exists-replace-p T)
                                  (make-new-csartloc-p T) (artsym-n 2)
                                  csartloc-n3-item csartloc-rest-vals (dim-separator ".")
                                  (append-all-csartloc-syms&vals-p T)
                                  (update-supsys-sublist-p T)
                                  (all-csartloc-syms-sym '*ALL-CSARTLOC-SYMS)
                                  (all-csartloc-syms&vals-sym
                                   '*ALL-CSARTLOC-SYMS&VALS)
                                  (supsys-key :CSS))
  "U-CS REVISE Sets the csartloc value as either a csartloc-sym or csartdims.   RETURNS (values all-csartloc-syms  all-csartloc-syms&vals all-csyms&vals). 
   INPUT:  :CSARTLOC-ORIGIN can be :new-csartloc (becomes new)  :supsys-csym, :topdim-dims (incls non-nils for topdim, dims,supsys,csym), :SUPSYS-CSARTLOC (adds csym to supsys csartloc),  :scale-class,  :supsys-only,  :parents (unfinished). [Can't be :csym-only bec the csartloc-sym = csym].
   If TOPDIM, uses as topdim. If SUPSYS, puts ahead of csym--otherwise gets from :CSS. If last-dim-csym-p, sets csym as last dim. If DIMS, puts them BETWEEN topdim & supsys (if not nil). ROOT applies only to clev=0.
   When SET-SUPSYS, sets all supsys vals to set-supsys."
  (let*
      ((all-csartloc-syms)
       (all-csartloc-syms&vals)
       (all-csyms&vals)
       ;;(all-csartdimss)
       )
    (loop
     for csym in csyms
     do
     (let*
         ((csartloc-sym&vals)
          )
       (multiple-value-bind (csartloc-sym csartloc-vals csartdims old-csartloc
                                          csymvals)
           (set-csym-csartloc csym :set-new-supsys set-new-supsys
                              :csartloc-origin csartloc-origin :supsys-csartloc supsys-csartloc
                              :new-csartloc new-csartloc
                              :topdim topdim :dims dims  :last-dim last-dim 
                              :supsys supsys  :def-supsys def-supsys 
                              :new-csartloc-vals nil
                              ;; :csartloc-syms&vals csartloc-syms&vals  
                              :artsym-n 2
                              ;;:set-as-csartdims-p set-as-csartdims-p 
                              :if-exists-replace-p make-new-csartloc-p 
                              :make-new-csartloc-p make-new-csartloc-p   
                              :n3-item csartloc-n3-item :rest-vals csartloc-rest-vals
                              :separator-str dim-separator
                              :append-all-csartloc-syms&vals-p T
                              :update-supsys-sublist-p update-supsys-sublist-p
                              :all-csartloc-syms-sym all-csartloc-syms-sym
                              :all-csartloc-syms&vals-sym all-csartloc-syms&vals-sym           
                              :supsys-key supsys-key)
         (setf csartloc-sym&vals (list csartloc-sym csartloc-vals))

         ;;ACCUMULATE
         (setf all-csartloc-syms (append all-csartloc-syms (list csartloc-sym))
               all-csartloc-syms&vals 
               (append all-csartloc-syms&vals (list csartloc-sym&vals))
               all-csyms&vals (append all-csyms&vals (list (list csym csymvals))))
         ;;end mvb,let,loop
         )))
    (values all-csartloc-syms  all-csartloc-syms&vals all-csyms&vals)     
    ;;end let,set-csyms-csartlocs
    ))
;;TEST
;; (set-csyms-csartlocs '(ENFORCERULES)  :supsys nil :csartloc-origin :supsys-csartloc :supsys-csartloc '$CS.$PC)
;; works= ($CS.$PC.ENFORCERULES)     (($CS.$PC.ENFORCERULES ("$CS.$PC.ENFORCERULES" ($CS $PC ENFORCERULES) NIL ENFORCERULES)))      ((ENFORCERULES ("ENFORCERULES" "ENFORCE RULES vs NOT ENFORCE RULES" $CS.$PC.ENFORCERULES NIL NIL :PC ("ENFORCE RULES" "NOT ENFORCE RULES" 0 NIL) :POLE1 "ENFORCE RULES" :POLE2 "NOT ENFORCE RULES" :BESTPOLE 0 :BIPATH ((POLE1 NIL MANAGER NIL) (POLE1 NIL DANCER NIL) (POLE2 NIL POLICEMAN NIL)) :CSVAL "0.667" :CSRANK 13)))    
;; (set-csyms-csartlocs '(CAREFOROTHERS) :topdim '$PC :supsys nil :csartloc-origin :supsys-csartloc)
;; works? = ($P.$CS.$MIS.CAREFOROTHERS)     (($P.$CS.$MIS.CAREFOROTHERS ("$P.$CS.$MIS.CAREFOROTHERS" ($P $CS $MIS CAREFOROTHERS) NIL CAREFOROTHERS)))
;;csymvals ((CAREFOROTHERS ("CAREFOROTHERS" "CARE FOR OTHERS vs SELFISH" $P.$CS.$MIS.CAREFOROTHERS NIL NIL :PC ("CARE FOR OTHERS" "SELFISH" 1 NIL) :POLE1 "CARE FOR OTHERS" :POLE2 "SELFISH" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)) :CSVAL "0.917" :CSRANK 3)))                                            





;;SET-CSYM-CSARTLOC
;;2020
;;ddd 
(defun set-csym-csartloc (csym &key  (csartloc-origin :supsys-csartloc)
                               topdim supsys  (def-supsys '$MIS)
                               supsys-csartloc 
                               (last-dim :csym) dims 
                               new-csartloc  new-csartloc-vals parents  
                               set-new-supsys append-supsys-sublist-p
                               set-as-csartdims-p (artsym-n 2) clev (clevkey :clev)
                               (root '$P)
                               (update-supsys-sublist-p T)(sublist-key :S)
                               (if-exists-replace-p T)(make-new-csartloc-p T) 
                               n3-item rest-vals (separator-str ".")
                               (return-csartdims-p T)
                               (append-all-csartloc-syms&vals-p T)
                               (all-csartloc-syms-sym '*ALL-CSARTLOC-SYMS)
                               (all-csartloc-syms&vals-sym
                                '*ALL-CSARTLOC-SYMS&VALS)
                               (supsys-key :CSS))
  "U-CS Used to CHANGE the csartloc value, make NEW CSARLOC SYM, and append the global vars collecting all the csartloc syms & their symvals. Sets the csartloc value as either a csartloc-sym or csartdims.   RETURNS (values csartloc-sym new-csartloc-vals csartdims old-csartloc-sym csymvals).
   INPUT:  :CSARTLOC-ORIGIN can be :new-csartloc (becomes new)  :supsys-csym, :topdim-dims (incls non-nils for topdim, dims,supsys,csym), :supsys-csartloc (adds csym to supsys csartloc),  :scale-class,  :supsys-only,  :parents (unfinished). [Can't be :csym-only bec the csartloc-sym = csym].
   If TOPDIM, uses as topdim. If SUPSYS, puts ahead of csym--otherwise gets from :CSS. If last-dim-csym-p, sets csym as last dim. If DIMS, puts them BETWEEN topdim & supsys (if not nil). ROOT applies only to clev=0."
  (let*
      ((csartloc)
       (csartloc-sym)
       (csartloc-str)
       (csymvals (eval-sym csym))
       (old-csartloc-sym (nth artsym-n csymvals))
       (old-csartloc-vals (eval-sym old-csartloc-sym))
       (old-csartloc-dims (second old-csartloc-vals))
       (child)
       (csartdims)
       (supsys-vals)
       (all-csartloc-syms (eval-sym all-csartloc-syms-sym))
       (all-csartloc-syms&vals (eval-sym all-csartloc-syms&vals-sym))
       )
    (when (and (null clev) csymvals)
      (setf clev (get-key-value clevkey csymvals)))
   ;;MODIFY CSARTLOC
   ;;   with :CSARTLOC-ORIGIN = :new-csartloc :supsys-csym, :topdim-dims, 
   ;;        :supsys-csartloc, :scale-class,  :supsys-only,  :parents 
   (cond
    ((or if-exists-replace-p (null old-csartloc))
     (cond
      ;;0. CLEV = 0 [top of tree]
      ((equal clev 0) 
       (setf csartdims (list root csym)
             csartloc-sym (make-list-symbol csartdims)))     
      ;;1. USE-NEW-CSARTLOC?
      ((and (equal csartloc-origin :NEW-CSARTLOC)
            new-csartloc)
       (setf csartloc-sym new-csartloc)
       (cond
        ((boundp csartloc-sym)
         (setf csartloc-vals (eval csartloc-sym)))
        (new-csartloc-vals
         (set new-csartloc new-csartloc-vals))
        (T  (setf csartloc-vals (list (format nil "~A" csartloc-sym)
                                      (find-sym-dims new-csartloc) NIL csym )))))
      ;;2. GET SUPSYS & CSARTDIMS
      ((member csartloc-origin '(:supsys-csym  :supsys-csartloc
                                 :scale-class  :supsys-only) :test 'equal)
       ;;[NOT incl: :topdim-dims  :parents]
       ;;WHEN PREVIOUS CSYM EXISTS, get :CSS supsys to get its csartloc
         (cond
          ((and csymvals set-new-supsys)
           (setf supsys set-new-supsys
                 csymvals (set-key-value supsys-key supsys csymvals
                          :no-dupl-p T :append-values-p T :append-as-flatlist-p T)))
          (csymvals
           (setf supsys (get-key-value supsys-key csymvals)))
         ;;assumes supsys is next to end dim
         ((null supsys)  ;;(not found in symvals or in arg)
           (when (and old-csartloc-dims (LISTP old-csartloc-dims))
             (cond
              ;;if csym at end of csartdims
              ((equal csym (last1 old-csartloc-dims))
               (setf supsys (car (last old-csartloc-dims 2))))
              ;;if no csym at end
              (T (setf supsys (car (last old-csartloc-dims)))))
             ;;if double csyms in csartdims
             (when (equal supsys csym)
               (setf supsys (car (last old-csartloc-dims 3)))))
           ;;if still no supsys found, use def-supsys
           (unless supsys
             (cond
              (def-supsys
               (setf supsys def-supsys))
              (T (setf supsys 'SUPSYS-NOT-FOUND))))    
           ;;end null supsys, cond,member
           )))
         (T NIL))
    
    ;;3. WHICH CSARTLOC-ORIGIN?
    (cond
     ((equal csartloc-origin :SUPSYS-CSYM)
      (when supsys
        (setf csartdims (list supsys)))
      (setf csartdims (append csartdims (list csym))))
     ((equal csartloc-origin  :TOPDIM-DIMS)
      (when (or topdim supsys last-dim)
        ;;1. convert dims to a list
        (cond
         ((listp dims)
          (setf csartdims dims))
         ((or (symbolp dims) (stringp dims))
          (setf csartdims (find-art-dims dims)))
         (t nil))
        ;;2. Add topdim?
        (when  topdim 
          (setf csartdims (cons topdim csartdims)))
        ;;3. Add supsys?
        (when supsys
          (setf csartdims (append csartdims (list supsys ))))
        ;;4. Add last-dim-csym?
        (when last-dim 
          (cond
           ((equal last-dim :csym)
            (setf csartdims (append csartdims (list csym))))
           (T (setf csartdims (append csartdims (list last-dim))))))
        ))
     ((equal csartloc-origin :SUPSYS-CSARTLOC)
      (cond
       (supsys-csartloc
        (setf csartdims (get-sym-dims supsys-csartloc)
              ;;old (nth-value 2 (get-csartsym-dims supsys-csartloc))
              csartdims (append csartdims (list csym))))
       (supsys
        (when (listp supsys)
          (setf supsys (car supsys)))
        (cond
         ;;find supsys-csartloc
         ((and (symbolp supsys) (boundp supsys))
          (setf supsys-csartloc (third (eval supsys)))
          (setf csartdims (get-sym-dims supsys-csartloc)
                ;;old(nth-value 2 (get-csartsym-dims supsys-csartloc))
                csartdims (append csartdims (list csym))))
         ((listp supsys)
          (setf csartdims (append csartdims supsys (list csym))))
         (supsys  ;;if supsys initially nil, was set to def-supsys above
                  (setf csartdims (append csartdims (list supsys csym))))
         ((or topdim dims)
          (when topdim
            (setf csartdims (list topdim)))
          (when dims
            (setf csartdims (append csartdims dims)))
          (setf csartdims (append1 csym)))            
         (T (setf csartdims (append csartdims (list supsys csym)))))
        ;;end supsys clause
        )          
       (T (cond
           (csartdims 
            (setf csartdims (append csartdims (list csym))))))
       (T (setf csartdims (list csym))))
      ;;end :supsys-csartloc
      )
     ((equal csartloc-origin :SUPSYS-ONLY)
      (cond
       (supsys
        (setf csartloc supsys))
       (T (setf csartloc def-supsys))))
     ((member csartloc-origin '(:SCALE-CLASS :PARENTS))
      (cond
       (parents
        (cond
         ((listp parents)
          (setf csartdims (list (car parents) csym)))
         (T (setf csartdims (list parents csym)))))
       (T (setf child (string-trim '("<") (format nil "~A" csym))
                csartdims (list (car (find-direct-superclass-names child)) csym)))))
     ;;end member csartloc-origin cond
     (T NIL))

    ;;USE OLD OR MAKE NEW CSARTLOC-SYM
      (cond
       ;;USE OLD-CSARTLOC ?
       ((and old-csartloc-sym (null if-exists-replace-p))
       (setf csartloc-sym old-csartloc-sym
               new-csartloc-vals (eval-sym old-csartloc-sym)
               csymvals (eval-sym csym)))

       ;;MAKE NEW CSARTLOC-SYM
       (T
       (when csartdims
         (setf csartloc-sym 
               (make-list-symbol csartdims :separator-str separator-str)
               csartloc-str (format nil "~A" csartloc-sym)))
       (when (and return-csartdims-p (null csartdims) csartloc)
         (setf csartdims (nth-value 2 (make-sym-str-dims-from-any csartloc))))

       ;;MAKE NEW-CSARTLOC-VALS and set csartloc-sym to them
       (unless n3-item
         (setf n3-item (nth 2 old-csartloc-vals)))
       (unless rest-vals
         (setf rest-vals (nthcdr 4 old-csartloc-vals)))
       (setf new-csartloc-vals
             (cond (rest-vals 
                    (append (list csartloc-str csartdims n3-item csym) rest-vals))
                   (t (list csartloc-str csartdims n3-item csym))))
       (set csartloc-sym new-csartloc-vals)
       ;;(break "csartloc-sym")
       ;;unbind old-csartloc-sym if not same as new
       (when (and csartloc-sym old-csartloc-sym
                  (not (equal csartloc-sym old-csartloc-sym) ))
         (makunbound old-csartloc-sym))

       ;;APPEND GLOBAL CSARTLOC VAR
       (when append-all-csartloc-syms&vals-p
         (set all-csartloc-syms-sym
              (append all-csartloc-syms (list csartloc-sym)))
         (set all-csartloc-syms&vals-sym 
              (append all-csartloc-syms&vals (list (list csartloc-sym new-csartloc-vals)))))
       ;;SET THE CSYM CSARTLOC VAL
       (setf  csymvals (set-nth-in-list csartloc-sym artsym-n csymvals))
       (set csym csymvals)    
       ;;(break "csymvals before update-supsys")

       ;;UPDATE-SUPSYS-SUBLIST-P
       (when (and update-supsys-sublist-p supsys)
         (multiple-value-bind  (new-supsys-vals1 new-keylist1 new-value1)
          (update-supsys-sublist csym :supsys NIL :supsys-key supsys-key
                                 :supsys-csartloc supsys-csartloc
                                 :sublist-key sublist-key)     
         ;;supsys updated in func above      
         ;;(break "update supsys sublist")
         ;;end mvb,when
         ))      
    ;; end T= (NOT (or if-exists-replace-p (null old-csartloc)))
    ))
      ;;end of if exists-replace-p or (null old-csartloc)
      )
    (T NIL))
    (values csartloc-sym new-csartloc-vals csartdims old-csartloc-sym csymvals)
    ;;end let, set-csym-csartloc
    ))
;;TEST
;; when csym not exist
;;  (set-csym-csartloc 'newcsymx :supsys-csartloc 'top.supsys )
;; TOP.SUPSYS.NEWCSYMX    
;; ("TOP.SUPSYS.NEWCSYMX" (TOP SUPSYS NEWCSYMX) NIL NEWCSYMX)    (TOP SUPSYS NEWCSYMX)   NIL  NIL
;;For SET-NEW-SUPSYS
;; (set-csym-csartloc 'CAREFOROTHERS :csartloc-origin :supsys-csartloc  :SET-NEW-SUPSYS '$PC :append-supsys )
;;works (what want for $PCs?) = ;; $P.$CS.$PC.CAREFOROTHERS                ("$P.$CS.$PC.CAREFOROTHERS" ($P $CS $PC CAREFOROTHERS) NIL CAREFOROTHERS)     ($P $CS $PC CAREFOROTHERS)   $P.$CS.$MIS.CAREFOROTHERS        ("CAREFOROTHERS" "CARE FOR OTHERS vs SELFISH" $P.$CS.$PC.CAREFOROTHERS NIL NIL :PC ("CARE FOR OTHERS" "SELFISH" 1 NIL) :POLE1 "CARE FOR OTHERS" :POLE2 "SELFISH" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)) :CSVAL "0.917" :CSRANK 3 :CSS $PC)
;;
;; (setf <test-supsys-csym '("test-supsys-csym" "test-supsys-csym phrase" $CS.<BELIEFS.<test-supsys-csym "DATA" :CSS <BELIEFS :CLEV 2 :S (new-test-scale)))
;; :supsys-csym;  use def-supsys 
;;   (set-csym-csartloc '<new-test-scale :csartloc-origin :supsys-csym)
;; works=  $MIS.<NEW-TEST-SCALE   ("$MIS.<NEW-TEST-SCALE" ($MIS <NEW-TEST-SCALE) NIL <NEW-TEST-SCALE)   ($MIS <NEW-TEST-SCALE)  NIL  NIL
;;also $MIS.<NEW-TEST-SCALE = ("$MIS.<NEW-TEST-SCALE" ($MIS <NEW-TEST-SCALE) NIL <NEW-TEST-SCALE)
;;
;; :supsys-csym; use :supsys arg
;; (set-csym-csartloc '<new-test-scale :csartloc-origin :supsys-csym :supsys '<test-supsys-csym)
;; works =  <TEST-SUPSYS-CSYM.<NEW-TEST-SCALE   ("<TEST-SUPSYS-CSYM.<NEW-TEST-SCALE" (<TEST-SUPSYS-CSYM <NEW-TEST-SCALE) NIL <NEW-TEST-SCALE)   (<TEST-SUPSYS-CSYM <NEW-TEST-SCALE)   NIL  NIL
;;also: <TEST-SUPSYS-CSYM.<NEW-TEST-SCALE =  ("<TEST-SUPSYS-CSYM.<NEW-TEST-SCALE" (<TEST-SUPSYS-CSYM <NEW-TEST-SCALE) NIL <NEW-TEST-SCALE)
;;
;; for :supsys-csartloc w/ null :supsys-csartloc
;; (set-csym-csartloc '<new-test-scale :csartloc-origin :supsys-csartloc  :supsys '<test-supsys-csym)
;; works= $CS.<BELIEFS.<TEST.SUPSYS.CSYM.<NEW-TEST-SCALE  ("$CS.<BELIEFS.<TEST.SUPSYS.CSYM.<NEW-TEST-SCALE" ($CS <BELIEFS <TEST SUPSYS CSYM <NEW-TEST-SCALE) NIL <NEW-TEST-SCALE)   ($CS <BELIEFS <TEST SUPSYS CSYM <NEW-TEST-SCALE)  NIL  NIL
;; for :supsys-csartloc w/ :supsys-csartloc = $CS.<BELIEFS
;; (set-csym-csartloc '<new-test-scale :csartloc-origin :supsys-csartloc :supsys-csartloc '$CS.<BELIEFS)
;;works= $CS.<BELIEFS.<NEW-TEST-SCALE   ("$CS.<BELIEFS.<NEW-TEST-SCALE" ($CS <BELIEFS <NEW-TEST-SCALE) NIL <NEW-TEST-SCALE)   ($CS <BELIEFS <NEW-TEST-SCALE)   NIL  NIL
;;For CLEV = 0
;; (set-csym-csartloc '$CS)
;;works= $P.$CS
;; ("$P.$CS" ($P $CS) $CS $CS NIL NIL :S ($EXC $PC $ELM $EP $PCPT $LNG $BHB $BOD $OUTC $MIS) :CLEV 0)    ($P $CS)   $CS   ("$CS" "All Main Systems" $P.$CS NIL NIL NIL :S ($EXC $PC $ELM $EP $PCPT $LNG $BHB $BOD $OUTC $MIS) :CLEV 0)
;;also  $P.$CS =  ("$P.$CS" ($P $CS) $CS $CS NIL NIL :S ($EXC $PC $ELM $EP $PCPT $LNG $BHB $BOD $OUTC $MIS) :CLEV 0)

;;OLDER
;;;; (set-csym-csartloc 'careforothers)
;;works= ("CAREFOROTHERS" "CARE FOR OTHERS vs SELFISH" $TBV.CAREFOROTHERS NIL NIL :PC ("CARE FOR OTHERS" "SELFISH" 1 NIL) :POLE1 "CARE FOR OTHERS" :POLE2 "SELFISH" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)) :CSVAL "0.917" :CSRANK 3)      $TBV.CAREFOROTHERS     ("$TBV.CAREFOROTHERS" ($TBV CAREFOROTHERS) "3rd" CAREFOROTHERS "rest of stuff")    ($TBV CAREFOROTHERS)    $TBV.CAREFOROTHERS.CAREFOROTHERS
;;ALSO 
;;$TBV.CAREFOROTHERS   =  ("$TBV.CAREFOROTHERS" ($TBV CAREFOROTHERS) "3rd" CAREFOROTHERS "rest of stuff")
;;note: Above also is correct if just repeat (set-csym-csartloc 'careforothers)
;;ORIGINAL WAS (setf CAREFOROTHERS '("CAREFOROTHERS" "CARE FOR OTHERS vs SELFISH" $TBV.CAREFOROTHERS.CAREFOROTHERS NIL NIL :PC ("CARE FOR OTHERS" "SELFISH" 1 NIL) :POLE1 "CARE FOR OTHERS" :POLE2 "SELFISH" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)) :CSVAL "0.917" :CSRANK 3)   $TBV.CAREFOROTHERS.CAREFOROTHERS '("$TBV.CAREFOROTHERS.CAREFOROTHERS" ($TBV CAREFOROTHERS CAREFOROTHERS) "3rd" careforothers "rest of stuff"))
;;TO ADD A TOPDIM
;; (set-csym-csartloc 'careforothers :topdim 'TOPSYM)
;;works= ("CAREFOROTHERS" "CARE FOR OTHERS vs SELFISH" TOPSYM.$TBV.CAREFOROTHERS NIL NIL :PC ("CARE FOR OTHERS" "SELFISH" 1 NIL) :POLE1 "CARE FOR OTHERS" :POLE2 "SELFISH" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)) :CSVAL "0.917" :CSRANK 3)    TOPSYM.$TBV.CAREFOROTHERS     ("TOPSYM.$TBV.CAREFOROTHERS" (TOPSYM $TBV CAREFOROTHERS) "3rd" CAREFOROTHERS "rest of stuff")     (TOPSYM $TBV CAREFOROTHERS)    $TBV.CAREFOROTHERS.CAREFOROTHERS




;;FIND-SUPSYS-CSARTDIMS
;;2020
;;ddd
(defun find-supsys-csartdims (sys-csym &key omit-this-csym-p return-dimlist-p
                                     (omit-root "R.") omit-end-str )
  "U-CS Allows use any lower :SYS csym [not non-sys] to begin a csartloc, and can find entire csartloc from top sys sym. Eg $ELM for most ELMSYMS & $TBV or $PER for most PCSYMS.
         RETURNS: (values sup-csartloc-sym sup-csartcsartdims)
         INPUT: Any SYSTEM CSYM as bottom to find direct superord sys csyms.
         OMIT-ROOT can be ANY string, and it will be deleted if found.
         OMIT-END-STR can be used INSTEAD of omit-this-csym-p."
  (let*
      ((sup-csartloc-sym (third (eval-sym sys-csym)))
       (sup-csartloc-sym-str (format nil "~A" sup-csartloc-sym))
       (sym)
       (sup-dims)
       (sup-str-dims)
       )
   (when omit-this-csym-p
     (setf omit-end-str (format nil ".~A" sys-csym)))   
   (when omit-end-str
     (setf sup-csartloc-sym-str
           (delete-final-string (list (format nil "~A" omit-end-str)) sup-csartloc-sym-str)))
   (when omit-root
     (setf sup-csartloc-sym-str
           (delete-begin-string (list (format nil "~A" omit-root)) sup-csartloc-sym-str)))
   (when (or omit-root omit-end-str)           
     (setf  sup-csartloc-sym (my-make-cs-symbol sup-csartloc-sym-str)))
   (when  return-dimlist-p
     (multiple-value-setq (sym sup-csartloc-sym-str sup-dims sup-str-dims)
          (make-sym-str-dims-from-any sup-csartloc-sym)))
    (values sup-csartloc-sym sup-csartloc-sym-str sup-dims sup-str-dims)
    ;;end let, find-supsys-csartdims
    ))
;;TEST
;; (find-supsys-csartdims '$PER)
;; works= $CS.$ELM.$PER  "$CS.$ELM.$PER"  NIL  NIL
;; (find-supsys-csartdims '$PER :return-dimlist-p T :omit-root NIL)
;; works= R.$CS.$ELM.$PER  "R.$CS.$ELM.$PER"  (R $CS $ELM $PER) ("R" "$CS" "$ELM" "$PER")
;; (find-supsys-csartdims '$PER :omit-this-csym-p T  :return-dimlist-p T)
;; works= $CS.$ELM "$CS.$ELM" ($CS $ELM) ("$CS" "$ELM")







;;UPDATE-SUPSYS-SUBLIST
;;2020
;;ddd
(defun update-supsys-sublist (csym &key supsys supsys-csartloc
                                   (supsys-key :CSS)  
                                   (sublist-key :S) (reset-supsys-p T) (if-list-supsys-n 0) 
                                   (def-supsys '$MIS) (scale-csym-prefix "<"))
  "U-CS   RETURNS (values new-supsys-vals new-keylist new-value)   INPUT: Can find supsys from arg, from :CSS or from csartloc."  
    ;;(break "In update-  ARG supsys")
  (when (and supsys (listp supsys))
    (setf supsys (nth if-list-supsys-n supsys)))
  (let* 
      ((new-supsys-vals)
       (csym-sym (my-make-cs-symbol csym))
       (csymvals)
       (supsys-vals (eval-sym supsys))
       (return-keylist)( new-supsys-vals)( new-keylist)( new-value)
       (update-csym-sup-p)
       )
    ;;If supsys not given
    (unless supsys
      ;;try 
      (cond
       (supsys-csartloc
        (setf supsys (last1 (get-sym-dims supsys-csartloc))))
       ;; (get-sym-dims '$P.$CS.$EXC.$BV.$TBV.<ST5-ORDERPERFECTIONGOODNESS)
       ((setf csymvals (eval-sym csym-sym))
        (cond
         ((setf  supsys-csartloc (third csymvals))
          (setf supsys (last1 (get-sym-dims supsys-csartloc))))
         ;;Try getting supsys from :CSS
         ((setf supsys (get-key-value supsys-key csymvals)) NIL)
         (T nil)))
       (T nil))
      ;;end unless supsys
      )
    ;;(break "In update-  after unless, supsys")
    (when (equal supsys csym-sym)
      (setf supsys def-supsys))
    ;;make sure it has a scale-csym-prefix, but NOT double prefix
    (when (and (stringp supsys) scale-csym-prefix)
      (unless (string-equal (subseq supsys 0 1) scale-csym-prefix)
        (setf supsys (format nil "~A~A" scale-csym-prefix supsys)))
      (setf supsys (my-make-cs-symbol supsys)))              
      ;;update csym :css too
      (when csymvals
        (setf csymvals 
              (set-key-value supsys-key supsys csymvals :append-as-flatlist-p T))
        (when csym-sym
          (set csym-sym csymvals)))
    ;;when reset-supsys-p, update the supsys sublist (add the csym to sublist)
    (when reset-supsys-p
      (when (stringp supsys)
        (setf supsys (my-make-symbol supsys)))
      (setf supsys-vals (eval-sym supsys)
            new-supsys-vals (set-key-value  sublist-key csym supsys-vals
                            :append-values-p T  :replace-old-value-p NIL
                            :set-listsym-to-newlist-p T
                            :no-dupl-p T :append-as-flatlist-p T))
      ;;(break "In update-supsys-sublist, at end before set Also new-supsys-vals :CSS")
      (when supsys
        (set supsys new-supsys-vals))
      ;;end when reset-supsys-p
      )
    (values new-supsys-vals new-keylist new-value) 
    ;;end let, update-supsys-sublist
    ))
;;TEST
;; (setf $CS '("$CS"  "All Main Systems"  $P.$CS NIL NIL :QT :SYS :CSS $P :CLEV 0 :SYSTEM :CLEV :S ($EXC $PC $ELM $EP $PCPT $LNG $BHB $BOD $EMOT $MIS))    $LNG '("$LNG" "Language" $P.$CS.$LNG NIL NIL :CSS $CS :QT :SYS :CLEV 1 :SYSTEM :CLEV :S ($VER $MTH $LOG)))
;; (update-supsys-sublist '$LNG)
;; works= ("$CS" "All Main Systems" $P.$CS NIL NIL :QT :SYS :CSS $P :CLEV 0 :SYSTEM :CLEV :S ($EXC $PC $ELM $EP $PCPT $LNG $BHB $BOD $EMOT $MIS $CS))  NIL  NIL
;; (setf  mycsym '("mycsym" "mycsym phr" mysupsys1.mycsym nil nil :css mysupsys1)  mysupsys1 '("mysupsys1" "mysupsys1 phr" top.mysupsys1 nil nil  :css top :s (sym1 sym2 sym3) :data "this data"))
;; (update-supsys-sublist 'mycsym)
;; works= ("mysupsys1" "mysupsys1 phr" TOP.MYSUPSYS1 NIL NIL :CSS TOP :S (SYM1 SYM2 SYM3 MYCSYM) :DATA "this data")   ("mysupsys1" "mysupsys1 phr" TOP.MYSUPSYS1 NIL NIL :CSS TOP :S (SYM1 SYM2 SYM3 MYCSYM) :DATA "this data")   (SYM1 SYM2 SYM3 MYCSYM)
;; ALSO: mysupsys1  =  ("mysupsys1" "mysupsys1 phr" TOP.MYSUPSYS1 NIL NIL :CSS TOP :S (SYM1 SYM2 SYM3 MYCSYM) :DATA "this data")
;;test not-duplicate-p 
;; works [no extra mysupsys1 added] = (QUOTE ("mysupsys1" "mysupsys1 phr" TOP.MYSUPSYS1 NIL NIL :CSS TOP :S (SYM1 SYM2 SYM3 MYCSYM) :DATA "this data"))
;; If supsys
;; (update-supsys-sublist 'mycsym :supsys 'mysupsys1)
;; works= (QUOTE ("mysupsys1" "mysupsys1 phr" TOP.MYSUPSYS1 NIL NIL :CSS TOP :S (SYM1 SYM2 SYM3 MYCSYM) :DATA "this data"))    ("mysupsys1" "mysupsys1 phr" TOP.MYSUPSYS1 NIL NIL :CSS TOP :S (SYM1 SYM2 SYM3 MYCSYM) :DATA "this data")    (SYM1 SYM2 SYM3 MYCSYM)
;;try get supsys from csartloc
;; ;; (setf  mycsym '("mycsym" "mycsym phr" mysupsys1.mycsym nil nil ) mysupsys1 ''("mysupsys1" "mysupsys1 phr" top.mysupsys1 nil nil  :css top :s (sym1 sym2 sym3) :data "this data"))
;; (update-supsys-sublist 'mycsym)
;; works= (QUOTE ("mysupsys1" "mysupsys1 phr" TOP.MYSUPSYS1 NIL NIL :CSS TOP :S (SYM1 SYM2 SYM3 MYCSYM) :DATA "this data"))   ("mysupsys1" "mysupsys1 phr" TOP.MYSUPSYS1 NIL NIL :CSS TOP :S (SYM1 SYM2 SYM3 MYCSYM) :DATA "this data")   (SYM1 SYM2 SYM3 MYCSYM)
;;ALSO [adds :CSS MYSUPSYS1] mycsym =  ("mycsym" "mycsym phr" MYSUPSYS1.MYCSYM NIL NIL :CSS MYSUPSYS1)



;;MAKE-TLINK-CSYM
;;2019
;;ddd
#|(defun make-tlink-csym (  &key  )
  "   RETURNS    INPUT:  "
  (let
      ((artdims (incf-new-tlink-artloc))
       )
  ;;SSSS  START HERE FINISH make-tlink-csym
  ;; CALL MAKE-CSYM TO DO IT
    (cond
     (
      )
     (
      )
     (t nil))

    (loop
     for 
     do
     (let*
         ((x)
          )
     
     ;;end let,loop
     ))

    (values    )
    ;;end let, make-tlink-csym
    ))|#
;;TEST
;; (make-tlink-csym





;;GET-LAST-TREE-LIST
;;2019
;;ddd
(defun get-last-tree-list (number-tree  &key (nthitem 0) (test 'my-greaterp-num)
                                         largest-num   largest-dims)
  "U-CS Searches a tree of numbers [non-numbers omitted], each level from top, finds LARGEST [or test] first-in-sublist value, returns that list, then recurse until no more sublevels.   RETURNS list of first-values for each selected sublist at each level.   INPUT: Tree of numbers (and can incl symbols--though omitted). "
  (let*
      ((largest-item-sublist (cond ((and number-tree (listp number-tree))
                                   (find-greatest/least-1nested-list nthitem (cdr number-tree)
                                                               :test test))
                                   (t  number-tree)))
       (new-largest-num (cond ((and largest-item-sublist (listp largest-item-sublist))
                           (find-greatest largest-item-sublist))
                           (number-tree  (find-greatest  number-tree))))
       )
    ;;(afout 'out (format nil "LET; number-tree= ~A~% largest-item-sublist= ~A new-largest-num= ~A" number-tree largest-item-sublist new-largest-num))
    (cond
     ((and largest-item-sublist (listp largest-item-sublist))
      (multiple-value-bind ( largest-dims1)  ;;largest-num1
          (get-last-tree-list largest-item-sublist
                              :largest-num new-largest-num :largest-dims largest-dims
                              :nthitem nthitem :test test)
        (setf largest-dims (append largest-dims1 largest-dims (list new-largest-num)))
        ;;(afout 'out (format nil "largest-dims= ~A" largest-dims ))
      )) 
     (t (setf new-largest-num largest-num))) ;;(setf largest-dims (append largest-dims (list largest-num)))))
    ;;(afout 'out (format nil "LAST largest-dims= ~A largest-num= ~A" largest-dims largest-num))
     largest-dims
    ;;end let, get-last-tree-list
    ))
;;TEST
;;  (get-last-tree-list '((1 (1 1 (1 1)))    (2 )  (3 (1)(2)(3 (1)(2)(3)(4)))))
;; works= (4 3 3)
;;  (get-last-tree-list '((A (1 1))  (3 (1 (2)(3))(B (1 1))(4 (5 (1)(2 (1 1))(6 (m (1 2))(7 (8 (1)(9))))))))) 
;; works =   (9 8 7 6 5 4 3)




;;MAKE-CSYM-LINK
;;2019
;;ddd
(defun make-csym-link (csym1 csym2 linktype1 linktype2 
                             &key (csym1dir :bipath) (csym2dir :bipath)
                                   csloc1 csloc2 csym1pole csym2pole 
                                 csphrase2 csloc2 csdata2 csdef2   (supsys2 '$MIS)
                                 (global-newlink-csyms-sym '*NEWLINK-MADE-CSYMS)
                                  csym2vals (linktype-key :lntp) (set-csyms-to-vals-p T))
  "U-CS,   RETURNS (values new-csym1-val new-csym2-val new-csym1-symvals new-csym2-symvals)   INPUT:  ASSUMES CSYM1 EXISTS--usually csym2 not exist makes new csym2--use to,from csymvals to define [if they exist, REPLACE old csymvals.  LINKTYPE: from *ALL-CS-EXPLORE-LINK-TYPES   Process CSCATs as csym2 or create an instance. Only use poles for PCs. Csym1 usually has the :TO, and csym2 the :FROM.  Uses set-csym-link to set the link. Note: linktype1 is default if (null linktype2)."
  ;;CSYM1
  (let*
      ((csym1vals (getsymvals csym1))
       )
    (when (null linktype2)
      (setf linktype2 linktype1))

  ;;CSYM2
  (setf csym2vals (getsymvals csym2))
  ;;IF CSYM2 NOT EXIST, MAKE IT
  (unless csym2vals
    (setf csphrase2 (cond (csphrase2 csphrase2)                     
                          (t (string csym2))))
    (setf csloc2 (cond (csloc2 csloc2)
                       (supsys2 (make-csartloc (list supsys2 csym2) csym2))
                       (t csym2)))
  ;;GET/MAKE CSLOC2 when null csym2vals and csloc2
  (when  (null csloc2)
    (cond
     (supsys2
      (setf csloc2 (make-csartloc supsys2 csym2)))
     (t (setf csloc2 csym2))))
       
  ;;MAKE NEW CSYM2
  (setf csym2-vals
    (make-csym csym2 csphrase2  csdata2 csdef2 :supsys supsys2 :new-csartloc csloc2 ))
#|(supsys-key :css) sublist (sublist-key :s) change-csloc-p (make-new-csartloc-p t) cs-categories info system BIPATH pole1 pole2 bestpole rev-poles-p to from wto wfrom clev (clevkey :clev) pclist restkeys (if-csym-exists :modify) (topdim "R") cur-csartdims csartloc (separator *art-index-separator) (node-separator *art-node-separator) store-all-csyms-to-file-p  (all-csyms-listsym (quote *all-stored-sys-csyms)) (tlink-artlocsym (quote *new-tlink-artloc)))|#
  ;;append global var
  (set global-newlink-csyms-sym (append (eval global-newlink-csyms-sym) (list csym2)))
  ;;end unless csym2 exists
    )
  
    ;;WHEN CSYMVALS,  MAKE NEW CSYMS FROM CSYMVALS--incl csloc syms?
  (when csym2vals
    (set csym2 csym2vals)
    (set-csym-csartloc csym2 :csartloc-origin :new-csartloc
                            :new-csartloc csloc2)
#|                           ;;  :topdim topdim :dims dims  :last-dim last-dim 
                             :supsys supsys  :def-supsys def-supsys 
                             :supsys-csartloc sup-csartloc
                             :csartloc-syms&vals csartloc-syms&vals  :artsym-n 2
                             ;;:set-as-csartdims-p set-as-csartdims-p 
                             :if-exists-replace-p make-new-csartloc-p 
                             :make-new-csartloc-p make-new-csartloc-p   
                             :n3-item csartloc-n3-item :rest-vals csartloc-rest-vals
                             :separator-str dim-separator
                             :append-all-csartloc-syms&vals-p T
                             :all-csartloc-syms-sym all-csartloc-syms-sym
                             :all-csartloc-syms&vals-sym all-csartloc-syms&vals-sym            
                             :supsys-key supsys-key)|#
    ;;was (make-csartloc (list csloc2 csym2) csym2)
    (store-csym csym2 :supsys supsys2))

   ;;ADD THE CSYM-LINKS TO CSYMS
   (multiple-value-bind ( new-csym1-vals new-csym2-vals from-link to-link)
       (set-csym-link   csym1 csym2 linktype1 linktype2  csym1dir csym2dir 
                     :csym2data csdata2 :csym1pole csym1pole
                      :csym2pole csym2pole :linktype-key linktype-key  
                      :set-csyms-to-vals-p set-csyms-to-vals-p)

    (values new-csym1-vals new-csym2-vals from-link to-link)
    ;;end mvb, let, make-csym-link
    )))
;;TEST
;; (setf newcsym3 '("newcsym3" "newcsym3" $MIS.NEWCSYM3 :V 22 :CSS $MIS))
;; (makunbound 'NEWCSYM4)
;; (make-csym-link 'newcsym3 'NEWCSYM4 :ISA :EX)
;; works= ("newcsym3" "newcsym3" $MIS.NEWCSYM3 :V 22 :CSS $MIS :BIPATH ((NEWCSYM4) :LNTP :ISA))    ("NEWCSYM4" "NEWCSYM4" $MIS.NEWCSYM4 NIL NIL :CSS $MIS :BIPATH ((NEWCSYM3) :LNTP :EX))   ((NEWCSYM4) :LNTP :ISA)  ((NEWCSYM3) :LNTP :EX)
;; also: *NEWLINK-MADE-CSYMS = (NEWCSYM4)
;; also: *ALL-STORED-CSYMS = (NEWCSYM4) 


;; OLDER--PRECHANGE
;;  (make-csym-link 'newcsym3 'newcsym4 :isa :csym1dir :TO :csym2dir :FROM  :csdata2 'data2  :csym2vals NIL :set-csyms-to-vals-p NIL)
;; works=
;; ("newcsym3" "newcsym3" $MIS.NEWCSYM3 :V 22 :CSS NIL (:TO ((NEWCSYM4) :LNTP :ISA :DATA DATA2)))
;; ("newcsym4" "newcsym4" $MIS.NEWCSYM4 :V 33 :CSS NIL (:FROM ((NEWCSYM3) :LNTP :ISA :DATA DATA1)))
;; (:TO ((NEWCSYM4) :LNTP :ISA :DATA DATA2))
;; (:FROM ((NEWCSYM3) :LNTP :ISA :DATA DATA1))
;; (setf newcsym3 nil newcsym4 nil)
;; ALSO $MIS.NEWCSYM3  = ("$MIS.NEWCSYM3" ($MIS NEWCSYM3) NEWCSYM3)

;;  (make-csym-link 'newcsym11 'newcsym12 :isa :TO :FROM :csym1data 'data1 :csym2data NIL :csym1vals NIL :csym2vals NIL :set-csyms-to-vals-p T)




;;SET-CSYM-LINK INFO
;;NOTE:  *ALL-CS-EXPLORE-LINK-TYPES =  (ISA PART WHY CAUSE EVID HOW EX FEAT NAME DEF DESC OPP SYN EVNT VALNK SELF OBJ SUPGL SUBGL SRCPT SIT ALT-R ACT REINF PUNISH IMG SND SENS EMOT HAP CARE ANX ANG DEP NONE)
;; eg of :BIPATH:  (CAREFOROTHERS ("CAREFOROTHERS" "CARE FOR OTHERS vs SELFISH" CS2-1-1-99 NIL NIL :PC ("CARE FOR OTHERS" "SELFISH" 1 NIL) :POLE1 "CARE FOR OTHERS" :POLE2 "SELFISH" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL))) :va "0.917" :RNK 3)

;;2019-12 FORMULA FOR CSYM PATHS/LINKS
;; (PATHTYPE (POLE-&OR-LINKSYM  LINKKEY LINKTYPE) see below:
;;  (PATHTYPE [:TO, :FROM, OR :BIPATH] 
;;   2. (POLE-&OR-LINKSYM [If pole1 or pole2, (POLE1 NIL NODE2 [If node2 pole is specified use list (POLE2 NODE2) instead of symbol NODE2.
;;  3. LINKTYPE (optional), use key :LNTP with linktype-key eg. :ISA in list0
;;EXAMPLES
;; (:BIPATH 
;; from pole1:  ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL) . . . cont below
;;assumed pole1:  (HELPER :LNTP :ISA)  (TEACHER :LNTP :EX) (TEACHNAME :LNTP :NAME) (DONTRUMP :LNTP :OPP)  (BOOKZ :LNTP :OBJLNK)  (IGNORANTPEOP  :LNTP :SD) (JESUS  :LNTP :IMG) . . . eg (POLE1 NIL (POLE2 SMART) :LNTP :ISA))

;;SET-CSYM-LINK -see formula above
;;2019
;;ddd
(defun set-csym-link (csym1 csym2 linktype1 linktype2 csym1dir csym2dir  
                                &key csym1data csym2data  csym1pole csym2pole 
                                (linktype-key :lntp) (set-csyms-to-vals-p  T))
  "U-CS,   RETURNS (values new-csym1-symvals new-csym2-symvals new-csym1-val new-csym2-val )   INPUT: LINKTYPE: from *ALL-CS-EXPLORE-LINK-TYPES   Process CSCATs as csym2 or create an instance. Only use poles for PCs. Csym1 usually has the :TO, and csym2 the :FROM."
  
  (when (and (boundp csym1)(boundp csym2))
  (let*
      ((csym1-vals (eval csym1))
       (csym2-vals (eval csym2))
       (csym1-pathlist)
       (csym2-pathlist)
       )
    ;;MAKE THE NEW PATH-LISTS
    ;;for csym1    
    (setf csym1-pathlist 
          (make-csym-path-info csym1 csym2  :linktype linktype1
                               :csym1data csym1data :csym2data csym2data  
                               :csym1pole csym1pole :csym2pole csym2pole 
                               :linktype-key linktype-key )
          csym2-pathlist 
          (make-csym-path-info csym2 csym1  :linktype linktype2
                               :csym1data csym2data :csym2data csym1data  
                               :csym1pole csym2pole :csym2pole csym1pole 
                               :linktype-key linktype-key ))
 
    ;;SET/MODIFY CSYM-VALS
    (multiple-value-bind (new-csym1-val new-csym1-symvals)
          (get-set-append-delete-keyvalue-in-nested-list csym1-pathlist 
                                                         (list (list csym1dir T)) csym1-vals
                                                         :append-value-p t 
                                                         ;; :splice-newvalue-at-nth-p t
                                                         :if-not-found-splice-keyvalue-list-p T
                                                          :splice-old-new-values-p nil
                                                        ;; :if-not-found-append-keyvalue-list-p NIL
                                                       ;;  :if-not-found-add-item-in-last-nested-list-p T
                                                         :if-not-found-append-key-value-p NIL)
    (multiple-value-bind (new-csym2-val new-csym2-symvals)
        (get-set-append-delete-keyvalue-in-nested-list csym2-pathlist 
                                                         (list (list csym2dir T)) csym2-vals
                                                         :append-value-p t :splice-newvalue-at-nth-p NIL
                                                      ;;   :splice-old-new-values-p NIL
                                                        :if-not-found-splice-keyvalue-list-p T
                                                         :if-not-found-append-keyvalue-list-p nil
                                                         :if-not-found-append-key-value-p NIL)
      ;;(break "end")
   
    ;;SET THE CSYM TO NEW VALS
    (when set-csyms-to-vals-p
      (set csym1 new-csym1-symvals)
      (set csym2 new-csym2-symvals))   
    (values new-csym1-symvals new-csym2-symvals csym1-pathlist csym2-pathlist )
    ;;end mvb, mvb,when,let, set-csym-link
    )))))
;;TEST
;; for appending exsting :bipath
;; (set-csym-link 'intimate 'careforothers  :ISA :ISA  :BIPATH :BIPATH :csym1pole 'pole1 :csym2pole  'pole1 :csym1data '(:key1 data1) :csym2data '(:Key22 data22) :set-csyms-to-vals-p nil)
;;csym1=  ("INTIMATE" "INTIMATE vs NOT INTIMATE" CS2-1-1-99 NIL NIL :PC ("INTIMATE" "NOT INTIMATE" 1 NIL) :POLE1 "INTIMATE" :POLE2 "NOT INTIMATE" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL BEST-M-FRIEND NIL)) :TO ((POLE1 CAREFOROTHERS :KEY22 DATA22) :LNTP :ISA :KEY1 DATA1))
;;csym2= ("CAREFOROTHERS" "CARE FOR OTHERS vs SELFISH" CS2-1-1-99 NIL NIL :PC ("CARE FOR OTHERS" "SELFISH" 1 NIL) :POLE1 "CARE FOR OTHERS" :POLE2 "SELFISH" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)) :FROM (POLE1 NIL (INTIMATE :KEY1 DATA1) :LNTP :ISA :KEY22 DATA22))
;; csym1path= (POLE1 NIL (POLE1 CAREFOROTHERS :KEY22 DATA22) :LNTP :ISA :KEY1 DATA1)
;; csym2path=   (POLE1 NIL (INTIMATE :KEY1 DATA1) :LNTP :ISA :KEY22 DATA22)
;; for new values :to :from
;; (set-csym-link 'intimate 'careforothers  :ISA :ISA  :TO :FROM :csym1pole NIL :csym2pole  'pole1 :csym1data '(:key1 data1) :csym2data '(:Key22 data22) :set-csyms-to-vals-p nil)




;;RESET INTIMATE AND CAREFOROTHERS
;; (setf intimate '("INTIMATE" "INTIMATE vs NOT INTIMATE" CS2-1-1-99 NIL NIL :PC ("INTIMATE" "NOT INTIMATE" 1 NIL) :POLE1 "INTIMATE" :POLE2 "NOT INTIMATE" :BESTPOLE 1 (:BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL BEST-M-FRIEND NIL))) :va "0.750" :RNK 7.5)           CAREFOROTHERS '("CAREFOROTHERS" "CARE FOR OTHERS vs SELFISH" CS2-1-1-99 NIL NIL :PC ("CARE FOR OTHERS" "SELFISH" 1 NIL) :POLE1 "CARE FOR OTHERS" :POLE2 "SELFISH" :BESTPOLE 1 (:BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL))) :va "0.917" :RNK 3))

;;FOR A NON-PC (NON-POLE) CSYM
;; (set-csym-link 'intimate 'careforothers  :ISA   :TO :FROM  :csym1data 'data1 :csym2data 'data2 :set-csyms-to-vals-p NIL)
;; works
;; ("INTIMATE" "INTIMATE vs NOT INTIMATE" CS2-1-1-99 NIL NIL :PC ("INTIMATE" "NOT INTIMATE" 1 NIL) :POLE1 "INTIMATE" :POLE2 "NOT INTIMATE" :BESTPOLE 1 (:BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL BEST-M-FRIEND NIL))) :va "0.750" :RNK 7.5 (:TO ((CAREFOROTHERS) :LNTP :ISA :DATA DATA2)))
;;  ("CAREFOROTHERS" "CARE FOR OTHERS vs SELFISH" CS2-1-1-99 NIL NIL :PC ("CARE FOR OTHERS" "SELFISH" 1 NIL) :POLE1 "CARE FOR OTHERS" :POLE2 "SELFISH" :BESTPOLE 1 (:BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL))) :va "0.917" :RNK 3 (:FROM ((INTIMATE) :LNTP :ISA :DATA DATA1)))
;;  (:TO ((CAREFOROTHERS) :LNTP :ISA :DATA DATA2))
;;  (:FROM ((INTIMATE) :LNTP :ISA :DATA DATA1))




;;MAKE-CSYM-PATH-INFO
;;2019
;;ddd
(defun make-csym-path-info (csym1 csym2 &key linktype   
                                  csym1data csym2data  csym1pole csym2pole 
                                  csym1-vals csym2-vals
                                  (linktype-key :lntp) )
  "U-CS, Makes a path-list--NOT including Direction (bipath to or from).  RETURNS newpathlist. Used INSIDE a CSYM list subordinate to :BIPATH, :TO, or :FROM.  csym1data csym2data should be lists of KEYS and VALUES.    csym1-vals csym2-vals are COMPLETE symvals; csym1data csym2data  are appended to created symvals."
  (let*
      ((csym1pole-info)
       (to-sublist)
       (csym2pole-info)
       (new-c1-c2-link-vals)
       (new-csym1-vals csym1-vals)
       (new-csym2-vals csym2-vals)
       )
    ;;CSYM1POLE VALS
    (cond
     (csym2pole
      (setf csym2pole-info (list csym2pole csym2)))
     (t (setf csym2pole-info (list csym2))))

    (when csym2data
      (setf csym2pole-info (append csym2pole-info csym2data)))

    (cond
     (csym1pole 
      (setf new-c1-c2-link-vals (list csym1pole nil  csym2pole-info)))
     (t (setf new-c1-c2-link-vals   (list csym2pole-info))))

    ;;APPEND LINKTYPE?
    (when linktype
      (setf new-c1-c2-link-vals (append new-c1-c2-link-vals (list linktype-key linktype))))
    (when csym1data
      (setf new-c1-c2-link-vals (append new-c1-c2-link-vals (append csym1data))))

    new-c1-c2-link-vals
    ;;end 
    ))
;;TEST
;; (make-csym-path-info 'csym1 'csym2 :linktype :isa  :csym1data nil  ::csym2data nil  :csym1pole nil  :csym2pole nil  )
;; simpliest case w/ linktype
;; works=  ((CSYM2) :LNTP :ISA) ;;NOTE: CSYM1 IS ASSUMED, NO POLE 
;;
;;  (make-csym-path-info 'csym1 'csym2 :linktype :isa  :csym1data '(:key1 'data1)  ::csym2data '(:key21 'data21)  :csym1pole 'pole1  :csym2pole 'pole2  )
;; works= (POLE1 NIL (POLE2 CSYM2 :KEY21 (QUOTE DATA21)) :LNTP :ISA :KEY1 (QUOTE DATA1))
;; (make-csym-path-info 'csym1 'csym2 :linktype :isa  :csym1data '(:key1 'data1)  ::csym2data '(:key21 'data21)  :csym1pole nil  :csym2pole nil  )
;; works= ((CSYM2 :KEY21 (QUOTE DATA21)) :LNTP :ISA :KEY1 (QUOTE DATA1))

;; (make-csym-path-info 'intimate 'careforothers :linktype :ISA   :csym1pole 'pole1 :csym2pole  'pole1 :csym1data '(:key1 data1) :csym2data '(:Key22 data22))
;; works= (POLE1 NIL (POLE1 CAREFOROTHERS :KEY22 DATA22) :LNTP :ISA :KEY1 DATA1)




;;GET-CSYM-LINKS
;;2019
;;ddd
(defun get-csym-links (csym &key (csymdirs '(:bipath :to :from))
                            linktypes (return-values-p T) (linktype-key :lntp))
  "U-CS,   RETURNS (values-list all-csym-linklists) if return-values-p, otherwise all-csym-linklists. Each linklist eg. (:BIPATH (( ....)))."  
  (when  (boundp csym)
  (let*
      ((csym-vals (eval csym))
       (all-csym-linklists)
       )
    (loop
     for csymdir in csymdirs
     do
     (let
         ((linktype)
          )
       (multiple-value-bind (linklist key keylist)
           (get-key-value csymdir csym-vals)
         (when linktypes
           (setf linktype (get-key-value  ))
           )
       ;;accumulate
            (setf all-csym-linklists (append all-csym-linklists (list (list csymdir linklist))))
            ;;end mvb, let,loop
            )))
       (cond
        (return-values-p
         (values-list all-csym-linklists))
        (t all-csym-linklists))
       ;;end let, get-csym-links
       )))
;;TEST
;; (setf intimate '("INTIMATE" "INTIMATE vs NOT INTIMATE" CS2-1-1-99 NIL NIL :PC ("INTIMATE" "NOT INTIMATE" 1 NIL) :POLE1 "INTIMATE" :POLE2 "NOT INTIMATE" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL BEST-M-FRIEND NIL))))
;; (get-csym-links 'intimate)
;; works= (:BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL BEST-M-FRIEND NIL)))    (:TO NIL)    (:FROM NIL)



;;GET-CSYM-LINKTYPE-LISTS 
;;2019
;;ddd
(defun get-csym-linktype-lists (csym linkdir linktype &key (linktype-key :lntp)
                                     return-all-linkdir-lists-p)
  "U-CS   RETURNS link-lists RETURN-ALL-LINKDIR-LISTS-P (values link-lists dir-links).  INPUT: linkdir eg. :BIPATH, kinktype eg. :ISA "
  (let*
      ((csymvals (eval csym))
       (link-lists)
       (dir-links (get-key-value linkdir csymvals))
       )
    (setf link-lists (get-lists-w-keyvalue linktype-key linktype dir-links))
    ;;above works better
    ;;(multiple-value-bind (keyvalue-lists  n-found-keys rest-keys flat-keylist found-lists)
        ;;(get-multi-keyvalues-in-nested-lists linktypes dir-links :add-flat-keylist-p T)
        (cond
         (return-all-linkdir-lists-p
          (values link-lists dir-links))
         (t link-lists))
      ;;end mvb,let, get-csym-linktype-lists
      ))
;;TEST
;; (setf intimate '("INTIMATE" "INTIMATE vs NOT INTIMATE" CS2-1-1-99 NIL NIL :PC ("INTIMATE" "NOT INTIMATE" 1 NIL) :POLE1 "INTIMATE" :POLE2 "NOT INTIMATE" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL BEST-M-FRIEND NIL)) :TO ((POLE1 CAREFOROTHERS :KEY22 DATA22) :LNTP :ISA :KEY1 DATA1)))
;; (get-csym-linktype-lists 'intimate :to :isa)
;; works = (((POLE1 CAREFOROTHERS :KEY22 DATA22) :LNTP :ISA :KEY1 DATA1))  

;; (setf intimate '("INTIMATE" "INTIMATE vs NOT INTIMATE" CS2-1-1-99 NIL NIL :PC ("INTIMATE" "NOT INTIMATE" 1 NIL) :POLE1 "INTIMATE" :POLE2 "NOT INTIMATE" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL BEST-M-FRIEND NIL) ((POLE1 CAREFOROTHERS :KEY22 DATA22) :LNTP :ISA :KEY1 DATA1))))
;;return-all-linkdir-lists-p
;; (get-csym-linktype-lists 'intimate :bipath :isa :return-all-linkdir-lists-p T)
;;works= (((POLE1 CAREFOROTHERS :KEY22 DATA22) :LNTP :ISA :KEY1 DATA1))            ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL BEST-M-FRIEND NIL) ((POLE1 CAREFOROTHERS :KEY22 DATA22) :LNTP :ISA :KEY1 DATA1))






;;ORDER-1NESTED-SUBLISTS-BY-NTHLIST-NTH
;;2017
;;ddd
#|(defun order-1nested-sublists-by-nthlist-nth (nthlist nth list-of-1nested-lists
                                                      &key ordered-list unordered-list other-items)
  "In  U-lists. INPUTS a list of 1nested-lists, RETURNS  new list ordered by order of nth-list, nth item nested-list in each list."
  (let*
      ((testgroup (car list-of-1nested-lists))
       (testlist (nth nthlist testgroup))
       (testitem)
       (matchitem (nth nth (nth nthlist (car (last ordered-list)))))
       )
    ;;(break "1")
    ;;(afout 'out (format nil "testgroup= ~A~%testlist= ~A~%matchitem= ~A" testgroup testlist matchitem))

    (when list-of-1nested-lists
     (cond
      ((listp testlist)
         (setf testitem (nth nth testlist))
         (cond
          ((null ordered-list)
           (setf ordered-list (list testgroup)))
          ((>=  testitem matchitem)
           (setf ordered-list (append ordered-list (list testgroup))))
          ;;if < last item in test group put at head of ordered list
          ((= (list-length list-of-1nested-lists) 1) ;;was testgroup) 1)
           (setf ordered-list (append  (list testgroup) ordered-list))
           ;;(break "list-length 1, ordered-list, testgroup")
           )
          (t 
           ;;IF NOT GREATER THAN LAST ITEM RECURSE ON ORDERED-LIST
           (multiple-value-bind (ret-ordered-list ret-unordered-list ret-other-items )
               (order-1nested-sublists-by-nthlist-nth nthlist nth 
                                                      (list testgroup) :ordered-list (butlast ordered-list ))
                                                   ;;was   (butlast ordered-list) :ordered-list ordered-list )
      ;;(afout 'out (format nil "ordered-list= ~A~% .unordered-list= ~A~% .other-items= ~A~% ret-ordered-list= ~A~% ret-unordered-list= ~A~% ret-other-items= ~A~% " ordered-list unordered-list other-items ret-ordered-list ret-unordered-list ret-other-items))
      ;;setf 
           (setf ordered-list (append ret-ordered-list (last ordered-list))
                unordered-list   (append unordered-list (list ret-unordered-list) 
                    other-items (append other-items (list ret-other-items))))
             ))))
      (t (setf other-items (append other-items testlist))))
     ;;(BREAK "ordered-list")
         ;;(afout 'out (format nil "2 ordered-list= ~A" ordered-list))

     ;;IF NOT COMPLETE, RECURSE
     (unless (< (list-length list-of-1nested-lists) 1)
       (multiple-value-bind (ret-ordered-list ret-unordered-list ret-other-items )
               (order-1nested-sublists-by-nthlist-nth nthlist nth 
                                        (cdr list-of-1nested-lists)  :ordered-list ordered-list
                                        :unordered-list unordered-list 
                                        :other-items other-items)
       ;;(break "AFTER UNLESS RETURN")
       (setf ordered-list (append ordered-list ret-ordered-list)
             unordered-list  (append unordered-list ret-unordered-list)
             other-items (append other-items ret-other-items))
       ;;end mvb, unless
       ))
     ;;end when list-of-1nested-lists
     )
             ;;(afout 'out (format nil "END ordered-list=~A~% unordered-list=~A~%  other-items=~A" ordered-list unordered-list other-items))
    (values  ordered-list unordered-list other-items)
    ;;end let, order-1nested-sublists-by-nthlist-nth
    ))|#
;;TEST
;;SSSS START HERE order-1nested-sublists-by-nthlist-nth
;; (progn (setf out nil) (order-1nested-sublists-by-nthlist-nth 0 1 '(((E 0.3)) ((D 0.7) (M 0.7) (P 0.7) (S 0.7)) ((C 0.1) (R 0.1))  ((B 0.2) (O 0.2)) ((A 0.4) (L 0.4) (Q 0.4)))) (fout out))



;;OLD VERSION--DELETE LATER
#|(defun set-csym-link (csym1 csym2 linktype csym1dir csym2dir  
                                &key csym1data csym2data  csym1pole csym2pole 
                                (linktype-key :lntp) (set-csyms-to-vals-p  T))
  "U-CS,   RETURNS (values new-csym1-symvals new-csym2-symvals new-csym1-val new-csym2-val )   INPUT: LINKTYPE: from *ALL-CS-EXPLORE-LINK-TYPES   Process CSCATs as csym2 or create an instance. Only use poles for PCs. Csym1 usually has the :TO, and csym2 the :FROM."
  (when (and (boundp csym1)(boundp csym2))
  (let*
      ((from-vals (eval csym1))
       (to-vals (eval csym2))
       (from-sublist)
       (csym1pole-sublist)
       (to-sublist)
       (csym2pole-sublist)
       (new-csym1-vals from-vals)
       (new-csym2-vals to-vals)
       )
    ;;CSYM1POLE VALS
    (cond
     (csym1pole 
      (setf csym1pole-sublist (append csym1pole-sublist (list  csym2 csym2pole)))
      (when linktype
        (setf csym1pole-sublist (append csym1pole-sublist (list linktype-key linktype))))
      (when csym1data
        (setf csym1pole-sublist (append csym1pole-sublist (list :data csym1data))))
       (setf from-sublist (append from-sublist (list csym1pole-sublist))))
     (t 
      (setf from-sublist (append from-sublist (list (list csym2))))
      (when linktype
        (setf from-sublist (append from-sublist (list linktype-key linktype))))
      (when csym1data
        (setf from-sublist (append from-sublist (list :data csym2data))))))
    ;;CSYM2POLE VALS
    (cond
     (csym2pole 
      (setf csym2pole-sublist (append csym2pole-sublist  (list csym1 csym1pole)))
      (when linktype
        (setf csym2pole-sublist (append csym2pole-sublist (list linktype-key linktype))))
      (when csym2data
        (setf csym2pole-sublist (append csym2pole-sublist (list :data csym1data))))
       (setf to-sublist (append to-sublist (list csym2pole-sublist)))
      )
     (t 
      (setf to-sublist (append to-sublist (list (list csym1))))
      (when linktype
        (setf to-sublist (append to-sublist (list linktype-key linktype))))
      (when csym2data
        (setf to-sublist (append to-sublist (list :data csym1data))))))
    
    ;;SET/MODIFY CSYM-VALS
    (multiple-value-bind (new-csym1-val new-csym1-symvals)
          (get-set-append-delete-keyvalue-in-nested-list from-sublist 
                                                         (list (list csym1dir T)) new-csym1-vals
                                                         :append-value-p t :splice-newvalue-at-nth-p t 
                                                          :splice-old-new-values-p t
                                                         :if-not-found-append-keyvalue-list-p T
                                                         :if-not-found-append-key-value-p NIL)
    (multiple-value-bind (new-csym2-val new-csym2-symvals)
        (get-set-append-delete-keyvalue-in-nested-list to-sublist 
                                                         (list (list csym2dir T)) new-csym2-vals
                                                         :append-value-p t :splice-newvalue-at-nth-p t 
                                                         :splice-old-new-values-p t
                                                         :if-not-found-append-keyvalue-list-p T
                                                         :if-not-found-append-key-value-p NIL)
   
    ;;SET THE CSYM TO NEW VALS
    (when set-csyms-to-vals-p
      (set csym1 new-csym1-symvals)
      (set csym2 new-csym2-symvals))   
    (values new-csym1-symvals new-csym2-symvals new-csym1-val new-csym2-val )
    ;;end mvb, mvb,when,let, set-csym-link
    )))))|#
;;TEST
;; (set-csym-link 'intimate 'careforothers  :ISA   :TO :FROM :csym1pole 'pole1 :csym2pole  'pole1 :csym1data 'data1 :csym2data 'data2 :set-csyms-to-vals-p T)
;;works= 
;;  ("INTIMATE" "INTIMATE vs NOT INTIMATE" CS2-1-1-99 NIL NIL :PC ("INTIMATE" "NOT INTIMATE" 1 NIL) :POLE1 "INTIMATE" :POLE2 "NOT INTIMATE" :BESTPOLE 1 (:BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL BEST-M-FRIEND NIL))) :va "0.750" :RNK 7.5 (:TO ((CAREFOROTHERS POLE1 :LNTP :ISA :DATA DATA1))))
;;  ("CAREFOROTHERS" "CARE FOR OTHERS vs SELFISH" CS2-1-1-99 NIL NIL :PC ("CARE FOR OTHERS" "SELFISH" 1 NIL) :POLE1 "CARE FOR OTHERS" :POLE2 "SELFISH" :BESTPOLE 1 (:BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL))) :va "0.917" :RNK 3 (:FROM ((INTIMATE POLE1 :LNTP :ISA :DATA DATA1))))
;;  (:TO ((CAREFOROTHERS POLE1 :LNTP :ISA :DATA DATA1)))
;;  (:FROM ((INTIMATE POLE1 :LNTP :ISA :DATA DATA1)))
;;
;; ADD ANOTHER LINK
;; (set-csym-link 'intimate 'careforothers  :WHY :TO :FROM :csym1pole  'pole1 :csym2pole  'pole1 :csym1data 'data11 :csym2data 'data22 :set-csyms-to-vals-p NIL)
;;works= 
;; ("INTIMATE" "INTIMATE vs NOT INTIMATE" CS2-1-1-99 NIL NIL :PC ("INTIMATE" "NOT INTIMATE" 1 NIL) :POLE1 "INTIMATE" :POLE2 "NOT INTIMATE" :BESTPOLE 1 (:BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL BEST-M-FRIEND NIL))) :va "0.750" :RNK 7.5 (:TO ((CAREFOROTHERS POLE1 :LNTP :ISA :DATA DATA1) (CAREFOROTHERS POLE1 :LNTP :WHY :DATA DATA11))))
;; ("CAREFOROTHERS" "CARE FOR OTHERS vs SELFISH" CS2-1-1-99 NIL NIL :PC ("CARE FOR OTHERS" "SELFISH" 1 NIL) :POLE1 "CARE FOR OTHERS" :POLE2 "SELFISH" :BESTPOLE 1 (:BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL))) :va "0.917" :RNK 3 (:FROM ((INTIMATE POLE1 :LNTP :ISA :DATA DATA1) (INTIMATE POLE1 :LNTP :WHY :DATA DATA11))))
;;  (:TO ((CAREFOROTHERS POLE1 :LNTP :ISA :DATA DATA1) (CAREFOROTHERS POLE1 :LNTP :WHY :DATA DATA11)))
;;  (:FROM ((INTIMATE POLE1 :LNTP :ISA :DATA DATA1) (INTIMATE POLE1 :LNTP :WHY :DATA DATA11)))

;;RESET INTIMATE AND CAREFOROTHERS
;; (setf intimate '("INTIMATE" "INTIMATE vs NOT INTIMATE" CS2-1-1-99 NIL NIL :PC ("INTIMATE" "NOT INTIMATE" 1 NIL) :POLE1 "INTIMATE" :POLE2 "NOT INTIMATE" :BESTPOLE 1 (:BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL BEST-M-FRIEND NIL))) :va "0.750" :RNK 7.5)           CAREFOROTHERS '("CAREFOROTHERS" "CARE FOR OTHERS vs SELFISH" CS2-1-1-99 NIL NIL :PC ("CARE FOR OTHERS" "SELFISH" 1 NIL) :POLE1 "CARE FOR OTHERS" :POLE2 "SELFISH" :BESTPOLE 1 (:BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL))) :va "0.917" :RNK 3))

;;FOR A NON-PC (NON-POLE) CSYM
;; (set-csym-link 'intimate 'careforothers  :ISA   :TO :FROM  :csym1data 'data1 :csym2data 'data2 :set-csyms-to-vals-p NIL)
;; works
;; ("INTIMATE" "INTIMATE vs NOT INTIMATE" CS2-1-1-99 NIL NIL :PC ("INTIMATE" "NOT INTIMATE" 1 NIL) :POLE1 "INTIMATE" :POLE2 "NOT INTIMATE" :BESTPOLE 1 (:BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL BEST-M-FRIEND NIL))) :va "0.750" :RNK 7.5 (:TO ((CAREFOROTHERS) :LNTP :ISA :DATA DATA2)))
;;  ("CAREFOROTHERS" "CARE FOR OTHERS vs SELFISH" CS2-1-1-99 NIL NIL :PC ("CARE FOR OTHERS" "SELFISH" 1 NIL) :POLE1 "CARE FOR OTHERS" :POLE2 "SELFISH" :BESTPOLE 1 (:BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL))) :va "0.917" :RNK 3 (:FROM ((INTIMATE) :LNTP :ISA :DATA DATA1)))
;;  (:TO ((CAREFOROTHERS) :LNTP :ISA :DATA DATA2))
;;  (:FROM ((INTIMATE) :LNTP :ISA :DATA DATA1))


;;xxx -------------- USED ONLY FOR OLDER SHAQ, ETC FUNCTIONS ----------

   
;;GET-QUESTION-TEXT
;;
;;ddd
(defun get-question-text (qvar &optional (category T) 
                               &key quest-varlist (all-questions-list *ALL-CSQ-QUESTIONS)
                               text-input-box1-instrs text-input-box2-instrs
                               (eval-text-input-box-sym-p T))
  "In U-CS DEPRECIATED-use GET-QUESTION-INFO (inSHAQ U-data-functions),quest-name = qvar  given quest-symbol RETURNS (values q-text-sym q-text-list q-title q-instr) LIST of question text from nested list--arg string or symbol, will also search for question sym w/o Q if gets nil. WORKS ONLY FOR SINGLE-SELECTION Qs.
  NOTE: q-instr can be a list (incl (FORMAT nil ... within) a string or a list with one or more symbols that should be evaluated to a STRING. "
  ;;2019 preprocess to get one list of questions
    (when (symbolp all-questions-list)
      (setf all-questions-list (eval all-questions-list)))
  (let*
      ((q-text-name (format nil "~AQ" qvar))
       (q-text-sym (my-make-cs-symbol q-text-name))
       ;;works= (ISAQ ((FORMAT NIL "What kind(s) or type(s) is ~A?" *CS-EXPLORE-PHRASE)) CS-LINKTYPE-INSTR *MULTI-INPUT-BOX-INSTRS)  ETC
       ;; (get-set-append-delete-keyvalue-in-nested-list :get (list (list T 0) (list 'motherq  0 :R)
       (q-instr-list)
       (q-title)
       (q-instr)
       (q-instr-list)
       (n-instrs)
       (q-instr-sym)
       (q-text-list) 
       (text-input-box-instrs)
       (text-input-box1-instrs)
       (text-input-box2-instrs)
       (proc-q-instr-list)
       (proc-q-text-list)
       (q-instr-out)
       (q-text-out)
       )
    (unless quest-varlist
        (setf quest-varlist (get-set-append-delete-keyvalue-in-nested-list :get  
                                                                     (list  (list q-text-sym  0 1))
                                                                    all-questions-list :return-nested-list-p NIL)))
    ;;(break "quest-varlist")
    (cond
     ((and quest-varlist (listp quest-varlist))
      (setf q-text-list (second quest-varlist)
            q-instr-sym (third quest-varlist)
            n-text-list (list-length q-text-list))
      ;;was             text-input-box-instrs (eval (fourth quest-varlist))) 
      ;;works with actual list or symbol for a list of  instructions
      (cond
       ((listp (setf text-input-box-instrs (fourth quest-varlist)))
        (setf  text-input-box-instrs (car text-input-box-instrs )))
       ((boundp text-input-box-instrs)
        (setf  text-input-box-instrs  (car (eval text-input-box-instrs))))
       (t nil))
      ;;GET MAIN INSTRUCTIONS LIST
      (setf q-instr-list (get-keyvalue-in-nested-list
                          (list  (list q-instr-sym 0 1) ) 
                          all-questions-list)) ;;was *cur-all-questions)) ;;was :return-list-p T))

;;  *CS-EXPLORE-PHRASE = "GROUP KNOWLEDGE WORKER"

      ;;eg(CS-LINKTYPE-INSTR ("LINKS TO OTHER NODES" (format nil  "Associations with the word, class, concept, or instance \"~A.\" " *cs-explore-phrase)) )
      ;;FOR q-instr-list
      (setf proc-q-instr-list (process-text-list q-instr-list))
      ;;SET TO INSTR SYM
      (cond
       ((not (listp proc-q-instr-list))
        (setf q-instr-out proc-q-instr-list))
       ((> (list-length proc-q-instr-list) 1)
        (setf q-title (first proc-q-instr-list)
              q-instr-out (second proc-q-instr-list)))
       (t (setf  q-instr-out (car proc-q-instr-list))))
        ;(break)
      ;;FOR q-text-list
      (setf proc-q-text-list (process-text-list q-text-list))
      ;;SET TO TEXT-SYM
      (cond
       ((not (listp proc-q-text-list))
        (setf q-text-out proc-q-text-list))
       ((> (list-length proc-q-text-list) 1)
        (setf q-text-out (string-append* proc-q-text-list)))
       (t (setf  q-text-out (car proc-q-text-list))))
      ;;(break "new")

      ;;ADDED FOR CSQ (from SHAQ) 
      ;;following may no longer be needed bec of new process-text-list function
      (when (symbolp q-title)
        (setf q-title (eval q-title)))
      (when (and (symbolp q-instr) (null q-instr-out))
        (setf q-instr-out (eval q-instr)))

      ;;TEXT INPUT BOX INSTRS (for 1 or 2 boxes)
      (cond
       ((and eval-text-input-box-sym-p 
                 (symbolp text-input-box-instrs)(boundp text-input-box-instrs))
        (setf text-input-box-instrs (eval text-input-box-instrs)))
       ((and (symbolp text-input-box-instrs)
             (not (boundp text-input-box-instrs)))
        (setf text-input-box-instrs nil)))
      ;;end listp quest-varlist
      )
     (t (setf q-text-list '("NO QUESTION TEXT FOUND"))))
    (cond
         ((null (listp text-input-box-instrs))   ;;was text-input-box-instrs
          (setf text-input-box1-instrs text-input-box-instrs))
         (t
          (setf text-input-box1-instrs (car text-input-box-instrs))
          (when (> (list-length text-input-box-instrs) 1)
            (setf text-input-box2-instrs (second text-input-box-instrs)))))

    ;;FOR TEXT-INPUT-BOXES 
    ;;(break "end")
     (when (not (listp q-text-out))
       (setf q-text-out (list q-text-out)))
    (values q-text-sym q-text-out q-title q-instr-out text-input-box1-instrs
            text-input-box2-instrs)  
    ;;end get-question-text
    ))
;;TEST
;;FOR CSQ LINKS (eg "isa")
;; (get-question-text 'isa)
;;works= ISAQ   ("What kind(s) or type(s) is NIL?")  NIL  NIL  "Type only ONE answer in BOX below.  
;;     * Type any additional answers in other popup windows.  
;;     * If NO ANSWER or UNCERTAIN, leave blank. 
;;     * When finished with all answers, click on LAST button."
;; (get-question-text 'emot) = works

;;For elmsyms
;;  (get-question-text  "mother")
;;works= MOTHERQ     ("Your Mother [or person most like a mother to you]")       "People Important To You"        "Write the (first + last name initial) NAME of a person that fits the description well. DO NOT use the same person twice!"    "Type answer in BOX below:" NIL
;; (get-question-text    " ")
;;works, = (" Being the best at whatever I do (example: making top grades). Achieving more than most other people.")  "INSTRUCTIONS FOR Life Themes, Dreams, and Values:"  "Answer each question according to how important that theme is to you."   NIL NIL
;; (get-question-text "DEFINITION")
;; (get-question-text  'SLFCOPE)
;; works= SLFCOPEQ   ("Emotional coping skills--ability to prevent and overcome negative emotions effectively")   "Self-Confidence Questions"  "CONFIDENCE in your abililities, skills, knowledge, and motivation in this area."  NIL  NIL

;;  (list (list 3 0) (list (my-make-cs-symbol "this") 0))
;; (my-make-cs-symbol "thisone")
;; (get-question-text  'COPEMOTA T :all-questions-list *ALL-CSQ-QUESTIONS :eval-text-input-box-sym-p nil)
;; works= COPEMOTAQ    ("Outwardly express anger by losing your temper, crying, damaging something, or getting even.")    NIL    NIL   COPEMOTAGGRESSQ  
;; (get-question-text "stuextmo")

;; (get-set-append-delete-keyvalue-in-nested-list :get  (list (list 'pce-people 0 )  (list 'mother  0 :R))      (eval  *cur-all-questions)) 
;;  (get-keyvalue-in-nested-list (list (list T 0 )(list 'PCE-PEOPLE-INSTR 0 :R) ) (eval *cur-all-questions))  ("People Important To You" *INSTR-NAME-ELEMENT)  (PCE-PEOPLE-INSTR ("People Important To You" *INSTR-NAME-ELEMENT))   (PCE-PEOPLE-INSTR ("People Important To You" *INSTR-NAME-ELEMENT))   ("return-orig-nested-list-p=NIL") T




;;GET-QUESTION-TEXT-FORMATED
;; modified 2019
;;ddd
(defun get-question-text-formated (qvar &key add-instrs-p 
                                        (all-questions-list *ALL-CSQ-QUESTIONS))
                                        ;; *cur-all-questions))
  "In U-data-functions DEPRECIATED-use GET-QUESTION-INFO  RETURNS (values formated-qtext q-text-sym q-title q-instr) formated text from question-text list in the definition of the question in Q-questions.lisp"
  (when (symbolp *cur-all-questions)
    (setf all-questions-list (eval *cur-all-questions)))   
  (let
      ((formated-qtext)
       )
    (multiple-value-bind (q-text-sym q-text-list q-title q-instr)
        (get-question-text qvar  T :all-questions-list all-questions-list) 
      (setf formated-qtext (print-list q-text-list :no-newline-p t))

      ;;add the question instructions?
      (when add-instrs-p 
        (setf formated-qtext (format nil  "~A~%   INSTRUCTIONS: ~A" formated-qtext q-instr )))
      (values formated-qtext q-text-sym q-title q-instr)
      )))
;;TEST
;; (get-question-text-formated 'SLFCOPE)
;; (get-question-text-formated 'SLFCOPE :add-instrs-p T )
;; (get-question-text-formated 'mother)
;; (get-question-text-formated
        




;;GET-QUEST-INPUT-BOX-INSTRS
;;2020
;;ddd
(defun get-quest-input-box-instrs (qvar &key selection-type quest-varlist
                                           (eval-text-input-box-sym-p T)
                                           (for-selection-types '(:single-text :multi-text))
                                           (all-questions-list *ALL-CSQ-QUESTIONS))
  "U-CS RETURNS:  (values text-input-box1-instrs text-input-box2-instrs)
      INPUT: Use selection-type quest-varlist args to avoid new searches.
      For INPUT-TEXT selection types only."

  (let*
      ((q-text-name (format nil "~AQ" qvar))
       (q-text-sym (my-make-cs-symbol q-text-name))       
       (text-input-box-instrs)
       (text-input-box1-instrs)
       (text-input-box2-instrs)
       )       
    (unless quest-varlist
        (setf quest-varlist (get-set-append-delete-keyvalue-in-nested-list :get  
                                                                     (list  (list q-text-sym  0 1))
                                                                    all-questions-list :return-nested-list-p NIL)))
    (unless selection-type
      (setf selection-type (find-qvar-selection-type qvar)))

    (when (member selection-type for-selection-types :test 'equal)
        (setf text-input-box-instrs (fourth quest-varlist))

      ;;works with actual list or symbol for a list of  instructions
      (cond
       ((listp text-input-box-instrs )
        (setf  text-input-box-instrs (car text-input-box-instrs )))
       ((boundp text-input-box-instrs)
        (setf  text-input-box-instrs  (car (eval text-input-box-instrs))))
       (t nil))
      ;;TEXT INPUT BOX INSTRS (for 1 or 2 boxes)
      (cond
       ((and eval-text-input-box-sym-p 
                 (symbolp text-input-box-instrs)(boundp text-input-box-instrs))
        (setf text-input-box-instrs (eval text-input-box-instrs)))
       ((and (symbolp text-input-box-instrs)
             (not (boundp text-input-box-instrs)))
        (setf text-input-box-instrs nil)))
    (cond
         ((null (listp text-input-box-instrs))   ;;was text-input-box-instrs
          (setf text-input-box1-instrs text-input-box-instrs))
         (t
          (setf text-input-box1-instrs (car text-input-box-instrs))
          (when (> (list-length text-input-box-instrs) 1)
            (setf text-input-box2-instrs (second text-input-box-instrs)))))
    (values text-input-box1-instrs text-input-box2-instrs selection-type)
    ;;end let, when, get-quest-input-box-instrs
    )))
;;TEST
;; (get-quest-input-box-instrs 'isa)
;; works= "Type only ONE answer in BOX below. 
;;     * Type any additional answers in other popup windows.  
;;     * If NO ANSWER or UNCERTAIN, leave blank. 
;;     * When finished with all answers, click on LAST button."  NIL  :MULTI-TEXT
;; (get-quest-input-box-instrs 'smtbusy :selection-type :single-selection)
;; works= NIL NIL


;;WRITE MAKE-CSYM-FROM-CSQ-SCALE FUNCTION
;; USE make-csyms-from-subscales&qvars??

;; MAKE THIS THE STARTING POINT for MAKING ALL CSYMS
;; GET 1- csyms and sub csyms from sub-scales from scale hierarchy
;;          2- question csyms from scale class inst,
;;          3-  sub-csyms from multi-item quests.
;;  IN THAT ORDER 1 to 3 above.
;; Should SCALES  also be systems?? with $ in name??
;; HERE??

;;xxx USEFUL FUNCTIONS from U-CS-data-results-functions
;;NOTE; MOST OR ALL FUNCTIONS USE CSQ-DATA-LIST FOR INFO SOURCE INSTEAD OF THE SCALE INSTANCES.

;; FOR SCALES-SUBSCALES
;; >>>> (get-scale-datalist "INTSS7COLLAB")
;;  works = (:SCALEDATA INTSS7COLLAB :N 7 :REL 0.143 :MN 1.0 :TOT 7 :MAX 49 :SD 0.0 :VAR 0.0)     :SCALEDATA

;;    (values scale-rel-score  scale-rel-score-str scale-datalist scale-qvars scale-qvar-datalists  scale-subscales scale-type) 
;;>>>> (GET-CSQ-SCALE-SCORE&DATA 'SSL1BCONFIDNOTAVOIDSTUDY)
;; works=   0.143  "0.143"
;;scale-datalist= (:SCALEDATA SSL1BCONFIDNOTAVOIDSTUDY :N 5 :REL 0.143 :MN 1.0 :TOT 5 :MAX 35 :SD 0.0 :VAR 0.0 :QV (LRNUNASN LRNCOLMT LRNTIRED LRNAREAD LRNPROOF))
;;scale-qvars= (LRNUNASN LRNCOLMT LRNTIRED LRNAREAD LRNPROOF)
;;scale-qvar-datalists= ((LRNUNASN "ld-Understand & begin assignments" :SINGLE "EXTREMELY accurate / like me" "0.143" 1 1 7 1 SCORED-REVERSE LIKEME7REVERSE) (LRNCOLMT "ld-Not made to feel not college material" :SINGLE "EXTREMELY accurate / like me" "0.143" 1 2 7 1 SCORED-REVERSE LIKEME7REVERSE) (LRNTIRED "ld-Not reading 1 hour make tired" :SINGLE "EXTREMELY accurate / like me" "0.143" 1 3 7 1 SCORED-REVERSE LIKEME7REVERSE) (LRNAREAD "ld-Not problem avoiding reading" :SINGLE "EXTREMELY accurate / like me" "0.143" 1 4 7 1 SCORED-REVERSE LIKEME7REVERSE) (LRNPROOF "ld-Not unsure of un-proofed-by-other paper" :SINGLE "EXTREMELY accurate / like me" "0.143" 1 5 7 1 SCORED-REVERSE LIKEME7REVERSE))     scale-subscales= NIL     :SCALEDATA

;; >>>>  (GET-SCALEDATA-SUBSCALES      '(:SCALEDATA  SWORLDVIEW   :N  11  :REL  0.68445457  :MN  5.3636365  :TOT  59  :MAX  86  :SD  3.4712515  :VAR  12.049587  :SS  ("SSWVGRATPT" "SSWVOPTIMS" "SSWVENTIT")))
;;works = ("SSWVGRATPT" "SSWVOPTIMS" "SSWVENTIT")

;;>>>  (MAKE-SUBSCALE-DATALIST subscale-name subscale-qvarlist scale-data-list)


;;FOR QVARS
;;>>>>>> (GET-CSQ-QVAR-SCORE&DATA 'SMTBUSY)
;;works= 1.0   "1.000"  SCORED-NORMAL  (SMTBUSY "sm-Rarely upset about too rushed" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 1 7 7 SCORED-NORMAL LIKEME7)

;;>>>>>  (GET-TEXTDATA-ANSWER "sex" "sID"   :datalist '(("sID" :TEXT-DATA ("Name" " " :SINGLE " ")("UserID" "222222" :SINGLE "222222") ("Sex" "Male" :SINGLE "Male" 1) ("Age" 22 :SINGLE 22 22) ("Email" "" :SINGLE "") ("USA?" "USA" :SINGLE "USA" 1) ("Nation" "USA" :SINGLE "USA") ("ZipCode" 44444 :SINGLE 44444) ("HrsWork" 22 :SINGLE 22 22)))) 
;; NEW works= "Male"  "Sex"

;;MULTI-ITEM QVARS
;;  (GET-MULTI-SEL-DATA-ALL-VALUES&TEXT '(BIO1ETHN   :MULTI    "bio1ethn"   "Primary Ethnic Group"   3   ("enortham" "1" 1 T 1 3 NIL)   ("eafrica" "2" 1 T 1 3 NIL)   ("enoreur" "3" 1 NIL 0 3 NIL)   ("esoueur" "4" 1 NIL 0 3 NIL)  ("ecambodn" "5" 1 NIL 0 3 NIL)   ("echina" "6" 1 NIL 0 3 NIL)   ("ekorea" "7" 1 NIL 0 3 NIL)  ("ejapan" "8" 1 NIL 0 3 NIL)   ("evietnam" "9" 1 NIL 0 3 NIL)  ("eothrasn" "10" 1 NIL 0 3 NIL)  ("emexico" "11" 1 NIL 0 3 NIL)  ("ecentram" "12" 1 NIL 0 3 NIL)  ("esoutham" "13" 1 NIL 0 3 NIL)  ("epacific" "14" 1 NIL 0 3 NIL)  ("eother" "15" 1 NIL 0 3 NIL)))
;;works, returns (("enortham" "North America" 1 T) ("eafrica" "Africa" 1 T) ("enoreur" "Northern Europe" 0 NIL) ("esoueur" "Southern Europe" 0 NIL) ETC
;;"  North America [1]; Africa [1]; Northern Europe [0]; Southern Europe [0]; ETC
;;  (get-multi-sel-data-all-values&text NIL :multi-qvar 'BIO1ETHN) = SAME AS ABOVE

;;XXX  USEFUL FUNCTIONS FROM U-CLOS ----------------------------------
;; THESE FUNCTIONS USE THE SCALE INSTANCES FOR DATA SOURCES

;; CLASS INSTANCES
;; >>>(get-class-inst 'outcome)
;;works= *OUTCOME-INST   #<OUTCOME 2A701B87>  "*OUTCOME-inst"  "OUTCOME"
;;
;;SUPERCLASSES/ SUPER SCALES
;;(find-direct-superclass-names "ACAD-LEARNING")
;;works, returns= ("ASSESSMENT" "PER-SYSTEM")   (#<STANDARD-CLASS ASSESSMENT 21E90D3F> #<STANDARD-CLASS PER-SYSTEM 21E900A3>)   ACAD-LEARNING   #<STANDARD-CLASS ACAD-LEARNING 21A8E74F>
;;test:  (class-direct-superclasses (find-class  'ACAD-LEARNING))
;;results = (#<STANDARD-CLASS ASSESSMENT 21E90D3F> #<STANDARD-CLASS PER-SYSTEM 21E900A3>)

;; SCALE SUBSCALES
;;>>>>  (GET-SUBSCALE-NAMES 'sworldview)
;; works = ("SSWVGRATPT" "SSWVOPTIMS" "SSWVENTIT")
;;
;; >>>>> (find-all-direct-subclass-names '(HQ)) 
;; RESULT = ("INTSS7COLLAB" "INTSS6POSSUP" "INTSS5INDEP" "INTSS4LOVERES" "INTSS3LIBROLE" "INTSS2ROMANTC" "INTSS1BOPENHON" "INTSS1AASSERTCR" "SEMOTCOP" "SSELFMAN" "SSLFCONF" "SGRFEARS" "SETHBEL" "SIECONTR" "SWVGRATENT" "STBSLFWO" "SWORLDVIEW" "ST11DUTYPUNCTUAL" "ST10OVERCMPROBACCEPTSELF" "ST9VALUESELFALLUNCOND" "ST8ATTENTIONFUNEASY" "ST7IMPACTCHALLENGEEXPLOR" "ST6GODSPIRITRELIG" "ST5-ORDERPERFECTIONGOODNESS" "ST4SUCCESSSTATUSMATER" "ST3FAMCARE" "ST2SOCINTIMNOFAM" "ST1HIGHERSELF")

;;GET PARENTS
;;>>> (GET-PARENT-SYMS *SSL14MATHAPT-INST)
;; works= (ACAD-LEARNING SCALE)   NIL

;;MULTI-ITEM INFO
;;  (values multi-slot-value-list instance-sym1)
;;>>>>  (GET-MULTI-SLOT-VALUES 'ssl11NotNonAcadMot '(name-string label scale-name description scale-group-name scale-questions mean-score help-links) :convert-classvar-p T)
;; works= ((NAME-STRING "ssl11NotNonAcadMot") (LABEL "ssl11NotNonAcadMot") (SCALE-NAME "College Internal Motivation") (DESCRIPTION "Internal Motivation--to be in college. Internal motives versus pleasing parents, making money, or being confused why in school. Financially self-supporting. Internal motivation for accomplishing any task--including a college degree--is associated with greater success and happiness. (4 items)") (SCALE-GROUP-NAME "acad-learning") (SCALE-QUESTIONS (STUEXTMO STUMONEYNEW STUCONFU STUFINDE STUCAREE)) (MEAN-SCORE 0.593) (HELP-LINKS ("c15-carp.htm" "time_management.htm" "life_goals_and_meaning.htm")))      *SSL11NOTNONACADMOT-INST


;;SLOT-VALUES for all
;;
;;  (GET-SLOT-VALUE 'sselfman 'description  :convert-classvar-p T)
;; works= "A key HQ scale. Skills related to self-care, decision-making, goal-setting, and time-management including leading a balanced life and attending to all main need/value areas. Many items are based upon  OPATSM time-management system.  Research shows that these vital skills are related to a more successful and happier life in almost all life areas. This scale correlated .606 with overall life happiness, .297 with low depression, .365 with relationship success, and over .30 with job status. (15 items)"            *SSELFMAN-INST   #<SSELFMAN 2A5D2B13>




;;MAKE-CSYMS-FROM-SUBSCALES&QVARS
;;2020
;;ddd
(defun make-csyms-from-subscales&qvars (scale-qvar &key quest-varlist 
                                                    scalelist-not-exist-p
                                                    (if-csym-exists :replace)  ;;:replace-non-csartloc
                                                    ;;or :replace :modify
                                                    ;; (return-csym&csymvals-p T)
                                                    (return-all-csyms-p T)
                                                    csphrase csartloc csdata  csdef  
                                                    ;;csartloc-related args
                                                    (csartloc-origin :supsys-csartloc)
                                                    supsys (def-supsys '$MIS) (supsys-key :CSS)
                                                    supsys-csartloc  new-csartloc 
                                                    ;;FIX CSART ABOVE NEW-CSARTLOC
                                                    (update-supsys-sublist-p T)
                                                    change-csloc-p (make-new-csartloc-p T) 
                                                     topdim  dims (last-dim :csym) parents       
                                                    (remove-parents '(SCALE ASSESSMENT SUBSCALE))
                                                    ;; or :supsys-csym etc.
                                                    ;;use-scale-class-csartloc-p
                                                    (max-length-csdef 200)
                                                    (scale-csym-prefix "<") (incl-helplinks-p T)
                                                    (qvar-csym-prefix "<")
                                                    sublist-csyms (sublist-key :S) 
                                                    subscales  clev
                                                    subscale-csyms  qvar-csyms
                                                    (scale-prestr "<")
                                                    scale-qvars (qtype-key :QT)(qtype :scale) 
                                                    linktype (linktype-key :LNTP)
                                                    cs-categories info system BIPATH 
                                                    ;;scales not PCs- no poles? 
                                                    ;;pole1 pole2 bestpole rev-poles-p pclist
                                                    csartloc-n3-item csartloc-rest-vals
                                                    ;; :qvarlist-not-exist-p qvarlist-not-exist-p
                                                    ;;(return-csym&csymvals-p T)  
                                                    selection-type
                                                    to from wto wfrom clev  (clevkey :clev)
                                                    restkeys                                                      
                                                    (separator *art-index-separator)
                                                    (node-separator *art-node-separator)
                                                    store-all-csyms-to-file-p 
                                                    omit-qvar-csyms-p
                                                    omit-subscale-csyms-p
                                                    no-shaq-score-search-p
                                                    no-csq-score-search-p
                                                    ;;(all-scalelists *ALL-CSQ-SCALES)
                                                    (all-qvarlists *ALL-CSQ-QVARS)
                                                    (all-questions-list *ALL-CSQ-QUESTIONS)
                                                    (csq-data-list (append *CSQ-DATA-LIST
                                                                           *SHAQ-ALL-DATA-LIST))
                                                    (shaq-all-data-list *SHAQ-ALL-DATA-LIST)
                                                    (all-csyms-sym '*ALL-MAKE-CSYMS)
                                                    ;;;WAS '*ALL-STORED-SYS-CSYMS)  
                                                    (all-csartloc-syms-sym '*ALL-CSARTLOC-SYMS)
                                                    (all-csartloc-syms&vals-sym
                                                     '*ALL-CSARTLOC-SYMS&VALS)  
                                                    (incl-scale-slots 
                                                     '(name-string label  scale-name description 
                                                                   parents children is-scale-p  assessment-type 
                                                                   scale-group-name
                                                                   scale-questions num-questions
                                                                   quest-selection-type reverse-scored-p  
                                                                   scoring-formula relative-score mean-score 
                                                                   variance standard-deviation sample-n
                                                                   subscales ;;csartloc
                                                                   composite-scale-p help-links))
                                                    ;;special (temp?) for adding tlink csyms
                                                    (tlink-artlocsym '*new-tlink-artloc)
                                                    )
  "U-CS Makes a new csym from scale-qvar instance (incls scores, etc).
         NOTE: 1. SUBLIST-CSYMS can be MIXED qvar-csyms or subscale-csyms. 
                       2. qvars part of subscales are NOT incl in scale sublist-csyms.
    3. To let DB csyms form independently, make-csym for scales if-csym-exists :replace-non-csartloc.
  RETURNS: (values scale-csym sublist-csyms all-new-csyms  all-new-scale-csyms all-qvar-csyms all-csartloc-syms all-csyms)
  IF A CSYM EXISTS, it may be due to being created by the CS DB csyms--which have only csartloc vals, so replace with scale inst vals--EXCEPT CSARTLOCS.
  CSARTLOC OPTIONS:   CSARTLOC-ORIGIN can be  :supsys-csym, :topdim-dims, :SUPSYS-CSARTLOC, :scale-class,  :supsys-only, :parents."
  (let*
      ((scale-csym)
       (scale-csym-str)
       (scale-qvar-str)
       (scale-class-str)
       (scale-class)
       (sublist-csyms)
       (all-new-csyms)
       (all-new-scale-csyms)
       (all-qvar-csyms)
       (all-csartloc-syms)
       (all-csyms)
       )
     ;;set the scale-csym & scale-csym-str
     ;;also, remove pre from scale-qvar (but incl in csym)
      (multiple-value-setq (scale-csym scale-csym-str scale-class-str scale-class)
          (my-make-cs-symbol scale-qvar :prestr scale-prestr :make-base-sym-p T))
      ;;needed to look up SHAQ, etc data
      ;;(setf scale-class (my-make-symbol scale-class-str))
        ;;(setf scale-csym scale-csym1         scale-csym-str scale-csym-str1))

    ;;STEP 1: GET THE SCALE CLASS DATA/VALUES
    ;;
    ;;1. GET SCALE CLASS INSTANCE -- SSS IS THIS NEEDED??
    (multiple-value-bind (scale-inst-sym scale-inst-object scale-inst-string)
        (get-class-inst scale-class)

      ;;(break "after scale-inst-sym")
      (cond
       ;;IF A SCALE 
       ((boundp scale-inst-sym)
        ;;2. GET RELEVANT SCALE CLASS VALUES (from incl-scale-slots)
        (multiple-value-bind
        ;;was name-string label  scale-name ;;title description ;;object-docs class-instance
            ;;csphrase =  scale-name slot; data-label = label
            (NAME-STRING  DATA-LABEL CSPHRASE1 CSDEF1 
                          PARENTS children 
                          is-scale-p  assessment-type scale-group-name 
                          scale-questions num-questions quest-selection-type 
                          reverse-scored-p  scoring-formula 
                          relative-score mean-score variance standard-deviation sample-n
                          SUBSCALES1 composite-scale-p help-links)
            (get-slot-values scale-class incl-scale-slots :return-only-values-p T)
          ;;since subscales is an arg above
          (setf subscales subscales1
                subscales1 nil)

          ;;(when (equal data-label 'unbound-slot)(null data-label)     
          ;;(break "help-links")
          ;;set csphrase and csdef
          (unless csphrase
            (cond
             ((and csphrase1 (not (equal csphrase1 'unbound-slot)))
              (setf csphrase csphrase1))
             (name-string
              (setf csphrase name-string))))
          (unless csdef
            (cond
             (max-length-csdef
              (setf csdef (max-seq-n max-length-csdef csdef1 )))
             (T (setf csdef csdef1))))
          ;;help-links?
          (when (and incl-helplinks-p help-links)
            (setf restkeys (append restkeys (list :helplk help-links))))
      
          ;;next didn't work bec each subscale INHERITS the subscales slot values, however modified CSQ-SHAQ-new-scales to inclu explicit :subscale NIL in subscales.
          ;;(unless subscales         (setf subscales subscales1))
          ;;(break "scale-values")
          ;; (afout 'out (format nil "~S ~S ~S ~S ~S~%~S ~S ~S ~S ~S~%~S ~S ~S ~S ~S~%~S ~S ~S ~S ~S~%~S ~S % "  NAME-STRING DATA-LABEL CSPHRASE CSDEF  parents children      is-scale-p  assessment-type scale-group-name  scale-questions num-questions  quest-selection-type reverse-scored-p  scoring-formula   relative-score mean-score variance standard-deviation sample-n subscales composite-scale-p help-links))
          (let*
              ((linktype1)(linktype2)
               (item-norm-or-rev)
               (csartdims)
               ;;accumulated
               (scale-csym-lists)
               (scale-csym-tree)
               ;;(all-subscales)  
               (cur-scale-qvars)  
               (new-qvar-csyms)
               (all-qvars)  
               (all-csartloc-syms) 
               (csartloc-sym)
               (cur-csartloclist)
               (all-scale-csyms) ;; (eval all-csyms-sym))
               (csartloc-syms)
               (scale-rel-score relative-score)
               ;;(values scale-csym  all-scale-csyms all-qvar-csyms  
               ;;  csartloc-sym csartloclist all-csartloc-syms)
               )
            ;;SSSSSS PROBLEM SETS :CSS TO A LIST
            ;;EG ("<ST4SUCCESSSTATUSMATER" "VALUES-THEMES" $CS.PER-SYSTEM NIL NIL :QT :SCALE :CSS (PER-SYSTEM) :VA 0.65555555 :SD 0.9558139 :S (<THM3EDUC <THM4MONE <THM25POS <THM26SUC <THM30CEO <THM33GOA <THMRESPE <THM1ACH <THMRECOG))
            ;;(BREAK "MID making scale csym")
            ;;3. GET SUPSYS & CSARTDIMS
            ;;3.1 SUPSYS and parents
            (when (and parents (not (equal parents 'unbound-slot)))
              ;;remove the remove-parents parents
              (setf parents (delete-items-from-list remove-parents parents)))
        
            ;;3.2 CSARTLOC-ORIGIN 
            ;;csartloc-origin :supsys-csym :csym-hier :scale-class  :supsys-only        
            ;;FIND SUPSYS
            (cond
             (supsys nil)
             (supsys-csartloc
              (setf supsys (last1 (nth-value 2 
                                             (make-sym-str-dims-from-any supsys-csartloc)))))
             (def-supsys
              (setf supsys def-supsys))
             (parents
              (cond
               ((listp parents)                      
                (setf supsys (car parents)))
               (T (setf supsys def-supsys)))))   
            ;;(break "parents-supsys")
 
            ;;4. SUBSCALES (not subscale-csyms)
            ;; If subscales not found above, find them here using children
            (unless (and subscales (not (equal subscales 'unbound-slot)))
              (cond
               ((and subscales (not (equal subscales 'unbound-slot))) NIL)
               ((or (null is-scale-p)(equal is-scale-p 'unbound-slot))
                ;;use instead get-all-subclasses-p above??
                (setf subscales  (get-direct-subclass-names scale-class)))
               (T (setf subscales (get-direct-subclass-names scale-class)))) 
              ;;was (get-subscale-names scale-class) -- returns NIL then subscales
              ;;(BREAK "unless subscales")
              ;;end unless
              )

            ;;5. MAKE SUBSCALE-CSYMS? (don't include question csyms if subscales now)
            (cond
             ;;from arg subscale-csyms
             (subscale-csyms
              (setf sublist-csyms (append sublist-csyms subscale-csyms)))
             ((and subscales (not (equal subscales 'unbound-slot)))
              (setf subscale-csyms (my-make-symbols  subscales
                                                     :pre "<"  :CSFORMATP T)
                    sublist-csyms (append sublist-csyms subscale-csyms)))
             (scale-questions
              (setf scale-qvars scale-questions
                    qvar-csyms (my-make-symbols scale-questions 
                                                :pre "<" :csformatp T)
                    ;;Do NOT append to sublist-csyms (subscale csyms)
                    sublist-csyms qvar-csyms))
             ((and scale-qvars (not (equal scale-qvars 'unbound-slot)))
              (setf sublist-csyms (append sublist-csyms qvar-csyms)))
             (T nil))

          #|  (when (equal scale-qvar '<sworldview)
              (break "after get scale class info"))|#
            ;;6. GET THE SCALE SCORE DATA?
            (unless (or no-shaq-score-search-p  (null is-scale-p))
              ;;SHAQ question relative score
              (multiple-value-bind (scale-rel-score1  scale-rel-score-str1 scale-datalist1 
                                                      scale-qvars1 scale-qvar-datalists  scale-subscales 
                                                      scale-type scale-SD1 scale-SD-str1)
                  (get-csq-scale-score-etc scale-class :not-return-qvar-datalists-p T     
                                           :quests-scales-datalist shaq-all-data-list)

                (unless (and scale-rel-score (null scale-rel-score1))
                  (setf  scale-rel-score  scale-rel-score1   
                         scale-rel-score-str scale-rel-score-str1))
                (setf  scale-SD scale-SD1 scale-SD-str scale-SD-str1
                       scale-datalist scale-datalist1)
                ;;(BREAK "after get-csq-scale-score-etc") 
                ;;end mvb,unless
                ))
#|            (when (equal scale-qvar '<sworldview)
              (break "scale-rel-score & scale-SD")) |#
            ;;(afout 'out (format nil "In scales&qvars MAKE THE SCALE-CSYM= ~A" scale-csym))

            ;;STEP 2: MAKE THE SCALE-CLASS CSYM 
            ;;(csartloc csartdims)
            (multiple-value-bind (scale-csymvals scale-csym1 csartloc-sym1 csartloclist1
                                                 supsys1 supsys-vals1 )          
                (make-csym scale-csym csphrase   csdata  csdef  
                           :value1 scale-rel-score  ;; :value2 rank-score :value2key :RNK
                           :sd scale-SD :if-csym-exists :replace-non-csartloc 
                           :csartloc-origin csartloc-origin  :supsys-csartloc supsys-csartloc    
                           :new-csartloc new-csartloc   
                           :supsys supsys :supsys-key supsys-key :sublist sublist-csyms
                           :topdim topdim :dims dims :last-dim last-dim
                           :qtype-key qtype-key :qtype qtype
                           :sublist-key sublist-key 
                           :linktype linktype :linktype-key linktype-key
                           :change-csloc-p change-csloc-p
                           :make-new-csartloc-p make-new-csartloc-p
                           :cs-categories cs-categories :info info :system system 
                           :BIPATH BIPATH ;; :pole1 pole1 :pole2 pole2 :bestpole bestpole 
                           ;; :rev-poles-p rev-poles-p
                           :to  to :from from :wto wto :wfrom wfrom
                           :clev  clev  :clevkey clevkey 
                           :restkeys  restkeys  ;;  :pclist  pclist 
                           ;;only for scales
                           ;;or :replace-non-csartloc :replace :modify
                           ;;  :cur-csartdims cur-csartdims;;For LAST DIMS, auto-incf last digit                     
                           ;;if present :incl dimsym USE AS IS
                           :dim-separator separator  :node-separator node-separator
                           :store-all-csyms-to-file-p store-all-csyms-to-file-p ;;autodone (ck-for-dupl-csyms-p T
                           :all-csyms-sym all-csyms-sym 
                           ;;special (temp? for adding tlink csyms
                           :tlink-artlocsym tlink-artlocsym )

              ;;ACCUMULATE THE SCALE CSYM --COPIED ABOVE
              (when scale-csym1
                (setf cur-scale-csym scale-csym1                  
                      all-new-scale-csyms (append all-new-scale-csyms (list scale-csym1))
                      all-new-csyms (append all-new-csyms (list cur-scale-csym))
                      csartloc-sym csartloc-sym1  
                      all-csartloc-syms (append all-csartloc-syms (list csartloc-sym))
                      cur-csartloclist csartloclist1
                      cur-supsys supsys1)
                     ;;end when
                )
              ;;(break "before step3 qvars")
              ;;(afout   'out (format nil "AFTER SCALE-CSYM= ~A:~% all-new-scale-csyms= ~A~% all-qvar-csyms= ~A~%  all-csartloc-syms= ~A" scale-csym all-new-scale-csyms all-qvar-csyms all-csartloc-syms))

              ;;STEP 3: PROCESS CUR-SCALE-QVARS--UNLESS SUBSCALES??
              #|        (when (or (equal scale-csym 'sT2SocIntimNoFam)
                  (equal scale-csym '<sT2SocIntimNoFam)
                  (equal scale-csym '<sT3FamCare)
                  (equal scale-csym 'sT3FamCare))
          (break  "before make-csym"))|#

              (cond
               ((and scale-qvars (null omit-qvar-csyms-p)
                         (NULL SUBSCALES))
                ;;(break "Is qvar not subscale") 
                ;;(afout 'out (format nil "RECURSE make-csyms-from-qvars~% scale-qvars= ~A" scale-qvars))
                (multiple-value-bind (new-qvar-csyms1 qvar-csartloc-syms)
                    ;;not needed? all-sublist-csyms)
                    (make-csyms-from-qvars  scale-qvars
                                            :no-csq-score-search-p no-csq-score-search-p
                                            :csartloc-origin csartloc-origin
                                            :supsys-csartloc CSARTLOC-SYM ;;from last level csym
                                            :topdim topdim :dims dims :last-dim last-dim 
                                            :parents parents 
                                            :supsys scale-csym  :def-supsys def-supsys
                                            :new-csartloc new-csartloc :clev clev
                                            :make-new-csartloc-p make-new-csartloc-p
                                            :update-supsys-sublist-p update-supsys-sublist-p
                                            :csartloc-n3-item csartloc-n3-item 
                                            :csartloc-rest-vals csartloc-rest-vals
                                            ;; :qvarlist-not-exist-p qvarlist-not-exist-p
                                            ;; :return-csym&csymvals-p T 
                                            :selection-type selection-type
                                            :qvar-csym-prefix qvar-csym-prefix 
                                            :if-csym-exists if-csym-exists
                                            :qvar-csym-prefix qvar-csym-prefix
                                            :supsys-key supsys-key
                                            :qtype-key qtype-key :qtype qtype                                    
                                            :sublist-key sublist-key :linktype linktype
                                            :linktype-key linktype-key 
                                            :change-csloc-p change-csloc-p
                                            :cs-categories  cs-categories :info info :system system
                                            :bipath  bipath
                                            :to   to :from from :wto wto :wfrom wfrom
                                            :clev clev :clevkey clevkey 
                                            :restkeys restkeys :if-csym-exists if-csym-exists
                                            ;; :topdim topdim  :cur-csartdims  cur-csartdims 
                                            :separator separator  :node-separator node-separator
                                            :store-all-csyms-to-file-p store-all-csyms-to-file-p
                                            :store-all-csyms-to-file-p store-all-csyms-to-file-p
                                            :all-qvarlists all-qvarlists
                                            :all-questions-list all-questions-list
                                            :csq-data-list csq-data-list
                                             :all-csyms-sym all-csyms-sym 
                                            ;;'*ALL-STORED-SYS-CSYMS
                                            :all-csartloc-syms-sym all-csartloc-syms-sym
                                            :all-csartloc-syms&vals-sym all-csartloc-syms&vals-sym
                                            )             
                  ;;note: not all args used above.

                  (setf new-qvar-csyms new-qvar-csyms1)

                  ;;ACCUMULATE QVARS RESULTS
                  (setf all-qvar-csyms (append all-qvar-csyms 
                                               (list (list scale-class new-qvar-csyms)))
                        all-new-csyms (append all-new-csyms new-qvar-csyms)
                        all-csartloc-syms (append all-csartloc-syms qvar-csartloc-syms))
                  ;;end mvb, is qvar not subscale ;;was when
                  ))
              ;;(afout   'out (format nil "AFTER QVAR-CSYMS: SCALE-QVARS= ~A~% all-new-scale-csyms= ~A~% all-qvar-csyms= ~A~%  all-csartloc-syms= ~A" scale-qvars all-new-scale-csyms all-qvar-csyms all-csartloc-syms))

              ;;STEP 4: RECURSE for SUBSCALE CLASSES
              ;;SSSS PROCESS EITHER SUBSCALES OR QVARS--NOT BOTH??
              ((and subscales (null omit-subscale-csyms-p)
                         (not (equal subscales 'unbound-slot))
                         ;;SSSSS added to prevent stack overflow  recurse when member of subscales
                         (not (member scale-class subscales :test 'equal)))
                ;;(break "subscales before loop")  
                ;;(afout 'out (format nil "STEP 4: RECURSE for SUBSCALES= ~A" subscales))
                (loop
                 for scale in subscales
                 for n from 1 to 100
                 do 
                 (multiple-value-bind (scale-csym sublist-csyms1 all-new-csyms1
                                                  all-new-scale-csyms1 all-qvar-csyms1  
                                                  all-csartloc-syms1 csartloc-sym1 csartloclist1)
                     ;;old     (scale-csym all-scale-csyms1 csartloc-sym csartloclist supsys1 supsys-vals1 )
                     ;;DO NOT pass most scale values to next level subscale
                     #|     (topdim "$CS") dims (max-length-csdef 200) (scale-csym-prefix "<") (incl-helplinks-p t) sublist-csyms (sublist-key :s) subscales subscale-csyms qvar-csyms scale-qvars|#
                   (make-csyms-from-subscales&qvars scale  :quest-varlist NIL ;;quest-varlist 
                                                    :scalelist-not-exist-p scalelist-not-exist-p
                                                    :if-csym-exists if-csym-exists
                                                    :return-all-csyms-p return-all-csyms-p
                                                    :csphrase  NIL :csdata NIL :csdef  NIL
                                                    :csartloc-origin csartloc-origin
                                                    :supsys-csartloc CSARTLOC-SYM ;;from csym
                                                    :new-csartloc new-csartloc
                                                    :make-new-csartloc-p make-new-csartloc-p
                                                    :supsys  SCALE-CSYM  :def-supsys def-supsys                   
                                                    :change-csloc-p change-csloc-p
                                                    :topdim topdim :dims dims :last-dim last-dim
                                                    :parents parents
                                                    :remove-parents remove-parents
                                                    :scale-csym-prefix scale-csym-prefix
                                                    :incl-helplinks-p incl-helplinks-p                                               
                                                    :supsys-key supsys-key
                                                    :sublist-csyms NIL ;;sublist-csyms 
                                                    :sublist-key sublist-key
                                                    :subscales NIL ;;otherwise infinite loop
                                                    ;;use sublist-csyms :subscale-csyms  subscale-csyms
                                                    :qvar-csyms qvar-csyms :scale-qvars scale-qvars
                                                    :qtype-key qtype-key  :qtype qtype
                                                    :linktype linktype :linktype-key linktype-key
                                                    :change-csloc-p change-csloc-p
                                                    ::make-new-csartloc-p make-new-csartloc-p
                                                    :cs-categories cs-categories :info NIL :system system 
                                                    :BIPATH  BIPATH 
                                                    ;;scales not PCs- no poles?  pole1 pole2 bestpole rev-poles-p pclist
                                                    :to  NIL :from  NIL :wto NIL :wfrom NIL 
                                                    :clev NIL  :clevkey clevkey ;;to left added 2018
                                                    :restkeys restkeys  
                                                    :if-csym-exists if-csym-exists ;;or :replace :modify
                                                    ;;SSSS include topdim?
                                                    ;;For LAST USED DIMS, incf last digit automatically?
                                                    ;; :cur-csartdims cur-csartdims
                                                    :separator separator :node-separator node-separator
                                                    :store-all-csyms-to-file-p store-all-csyms-to-file-p
                                                    ;;autodone (ck-for-dupl-csyms-p T)
                                                    :no-shaq-score-search-p no-shaq-score-search-p
                                                    :no-csq-score-search-p no-csq-score-search-p
                                                    ;;(all-scalelists *ALL-CSQ-SCALES)
                                                    ;;(all-questions-list *ALL-CSQ-QUESTIONS)
                                                    :csq-data-list csq-data-list 
                                                     :all-csyms-sym all-csyms-sym 
                                                    :incl-scale-slots incl-scale-slots
                                                    :tlink-artlocsym tlink-artlocsym
                                                    )
                   ;;OLD--passed values from supord scale to lower ones.
 
                   ;;ACCUMULATE SUBSCALES RESULTS
                   (setf sublist-csyms sublist-csyms1
                         all-new-scale-csyms (append all-new-scale-csyms sublist-csyms)
                         ;;was all-new-scale-csyms1)
                         all-qvar-csyms (append all-qvar-csyms  all-qvar-csyms1)
                         all-new-csyms (append all-new-csyms all-new-csyms1)
                         all-csartloc-syms (append all-csartloc-syms all-csartloc-syms1))
                   ;;(break "after subscales")

                   ;;STEP 5: APPEND SCALE SUBSCALES & QVARS TO SUBLIST-CSYMS
                   (when all-new-scale-csyms
                     (setf sublist-csyms (append sublist-csyms all-new-scale-csyms1)))
                   (when (and (null all-new-scale-csyms) new-qvar-csyms)
                     (setf sublist-csyms (append sublist-csyms new-qvar-csyms)))
                   ;;FIX LATER, but this works?
                   ;;(setf sublist-csyms (delete-list-items (list cur-scale-csym) sublist-csyms))

                   ;;(break "after sublist-csyms")
                   ;;(afout   'out (format nil "AFTER SUBSCALE= ~A: all-new-scale-csyms= ~A~% all-qvar-csyms= ~A~%  all-csartloc-syms= ~A" scale all-new-scale-csyms all-qvar-csyms all-csartloc-syms))
                   ;;no done above? cur-csartloclist cur-csartloclist1)

                   ;;end mvb, loop, is subscales
                   )))
              (T NIL))
           
            ;;ADD TO NEW SCALE-CSYM
            #|         (when sublist-csyms
            (set cur-scale-csym (append (eval cur-scale-csym) 
                                        (list sublist-key sublist-csyms)))
            (break "after append sublist-csyms")
            )|#
            #|(set-key-value sublist-key  sublist-csyms cur-scale-csym
                         :append-as-keylist-p nil :append-as-flatlist-p T
                         :set-listsym-to-newlist-p T)|#

            ;;(setf rel-score (get-csq-qvar-score&data scalename-sym))
            ;;Rank not used yet for SHAQ qvars (score value within group of score-range).
            ;; (setf rank (get-????    ))
                         
            ;;FIND other CSQ SCORES (value ranks, pc value scores)
            #|  ranks not used for questions? (unless  no-csq-score-search-p
    (setf rank-score  3) ;;MODIFY THIS|#    
            ;;end mvb,let,mvb,mvb

            (when (and return-all-csyms-p all-csyms-sym (boundp all-csyms-sym)
                       (setf all-csyms (eval all-csyms-sym))))
            ;;END let, mvb, SCALE-CLASS IS A SCALE
            ))))
       ;;IS SCALE-CLASS ACTUALLY A QVAR? 
       ((get-qvarlist scale-class)
        ;;(afout 'out (format nil "In scales&qvars, IS SCALE-CLASS a QVAR? scale-class= ~A" scale-class))
           (multiple-value-bind (qvar-csym1 csymvals1 qvar1 all-sublist-csyms1
                                          csartloc-sym1)
               ;;if all returned (new-csym csymvals1 csartloc-sym1 csartloclist1 supsys1 supsys-vals1 qvar)))
               (make-csym-from-qvar SCALE-CLASS
                                    :csphrase csphrase :csdata csdata
                                    :csdef csdef 
                                    :csartloc-origin csartloc-origin
                                    :topdim topdim :dims dims :last-dim last-dim 
                                    :parents parents :supsys-csartloc supsys-csartloc
                                    :supsys NIL  :def-supsys def-supsys ;;was supsys--errors?
                                    :new-csartloc new-csartloc
                                    :make-new-csartloc-p make-new-csartloc-p
                                    :update-supsys-sublist-p update-supsys-sublist-p
                                    :csartloc-n3-item csartloc-n3-item 
                                    :csartloc-rest-vals csartloc-rest-vals
                                    ;; :qvarlist-not-exist-p qvarlist-not-exist-p
                                    :return-csym&csymvals-p T :clev clev
                                    :selection-type selection-type
                                    :qvar-csym-prefix qvar-csym-prefix 
                                    :if-csym-exists if-csym-exists
                                    :qvar-csym-prefix qvar-csym-prefix
                                    :supsys-key supsys-key
                                    :qtype-key qtype-key :qtype qtype                                    
                                    :sublist-key sublist-key :linktype linktype
                                    :linktype-key linktype-key 
                                    :change-csloc-p change-csloc-p
                                    :cs-categories  cs-categories :info info :system system
                                    :bipath  bipath
                                    :to   to :from from :wto wto :wfrom wfrom
                                    :clev clev :clevkey clevkey 
                                    :restkeys restkeys :if-csym-exists if-csym-exists
                                    ;; :topdim topdim  :cur-csartdims  cur-csartdims 
                                    :separator separator  :node-separator node-separator
                                    :store-all-csyms-to-file-p store-all-csyms-to-file-p
                                    :no-csq-score-search-p no-csq-score-search-p
                                    :all-qvarlists  all-qvarlists  :all-questions-list  all-questions-list 
                                    :csq-data-list csq-data-list  :all-csyms-sym all-csyms-sym 
                                    :all-csartloc-syms-sym all-csartloc-syms-sym
                                    :all-csartloc-syms&vals-sym all-csartloc-syms&vals-sym
                                    )
           ;;ACCUMULATE
           (setf all-csyms (append all-csyms (list qvar-csym1))
                 all-csartloc-syms (append all-csartloc-syms (list csartloc-sym1)))
           ;;FINISH WRITING AND TESTING make-csyms-from-qvars
           ;;  HOW TO GET LIST OF CSYMS FOR INPUT??
           ;;end mvb,qvar clause
           ))
       (T NIL))
       ;;end mvb
       )
       (values scale-csym sublist-csyms 
               all-new-csyms  all-new-scale-csyms all-qvar-csyms  
               all-csartloc-syms all-csyms )
       ;;end let,mvb,mvb, make-csyms-from-subscales&qvars
       ))
;;TEST
;; (make-csyms-from-subscales&qvars '<SINBUS :supsys-csartloc '$SC.$EXC.$DOM.$CARR.$CARI)
;; <SINBUS = ("<SINBUS" "Business-Related Interests" $SC.$EXC.$DOM.$CARR.$CARI.<SINBUS NIL "Areas of interest within the overall category." :QT :SCALE :CSS $CARI :VA 0.46942857 :SD 2.2497166 :S (<CARIBMAR <CARIBMAN <CARIBINF <CARIBFIN <CARIBHRD <CARIBACC <CARISPBU))

;;also qvar: <CARIBINF = ("<CARIBINF" "cb-Inform Systems" $SC.$EXC.$DOM.$CARR.$CARI.<SINBUS.<CARIBINF NIL "I enjoy working with computers, and think I would like a career related to business applications of computers. I am considering BUSINESS INFORMATION SYSTEMS as a major or minor department." :QT :SCALE :CSS <SINBUS :VA 1.0)

;; (make-csyms-from-subscales&qvars '$BIO :supsys-csartloc '$SC.$SLF)
;; ;; (make-csyms-from-subscales&qvars '<UTYPE :supsys-csartloc '$SC.$SLF.$BIO)
;; (make-csyms-from-subscales&qvars '<UGOALS :supsys-csartloc '$SC.$SLF.$BIO) 

;; (make-csyms-from-subscales&qvars '<SWORLDVIEW :supsys-csartloc '$P.$SC.$BV.$WV)
;; produces= ("<SWORLDVIEW" "Positive World View" $SC.$BV.$WV.<SWORLDVIEW NIL "Optimism about the future of the world and own life, lack of entitlement thinking, plus daily positive versus negative thoughts. How constructively and positively you view the world and the future can" :QT :SCALE :CSS $WV :VA 0.926 :SD 1.863082 :S (<SSWVGRATPT <SSWVOPTIMS <SSWVENTIT <TBVGRATI <WOVABUND <WOVGRATE <WOVPROGR <WOVGOODF <WOVMYLIF <WOVPOSTH <TBVENTIT <WOVNFAIR <WOVINJUR <WOVENTIT))  ETC.

;; test use qvar as scale-class  <sehappy    :supsys-csartloc 
;; (make-csyms-from-subscales&qvars 'SEHAPPY :supsys-csartloc '$SC.$EMOT.$HAP)
;; (make-csyms-from-subscales&qvars '<SSELFMAN :supsys-csartloc '$SC.$EXC.$SKL )    
;; (make-csyms-from-subscales&qvars 'WOVENTIT :supsys-csartloc '$SC.$BV.$WV.<worldview)
;; works= <WOVENTIT  NIL NIL NIL NIL ($SC.$BV.$WV.<WORLDVIEW.<WOVENTIT)  (<WOVENTIT)
;; (make-csyms-from-subscales&qvars 'SSLFCONF :supsys-csartloc '$SC.$BV.$SLF)
;; works = <SSLFCONF
;; SSSS FIX?? SUBSCALES missing in this list, but incl in new csyms below (<SLFCREAT <SLFPERFA <SLFFINEA <SSSCARTCRE)
;; actual subscales: (SSSCLEARN SSSCCOPOPT SSSCSMSMSD SSSCINTERP SSSCALLHELP SSSCSCIENCE SSSCARTCRE)
;; (<SSLFCONF <SSSCLEARN <SLFLEARN <SLFCRITT <SLFRESEA <SLFANALY <SLFSYNTH <SLFCOMPU <SLFIQ <SSSCCOPOPT <SLFSELF4 <SLFCOPE <SLFSELF5 <SLFCONFL <SLFOPTIM <SLFFRIEN <SSSCSMSMSD <SLFDECMA <SLFTIMEM <SLFSELFM <SLFACHAN <SLFMANA6 <SLFHEAL3 <SLFINDEP <SSSCINTERP <SLFADAPT <SLFMEETP <SLFPERSU <SLFMANA7 <SLFBUSAN <SLFSPEAK <SLFJOBSE <SSSCALLHELP <SLFSOCSC <SLFPHILR <SLFLIBAR <SLFEDUCH <SLFLISTE <SLFHELPS <SSSCSCIENCE <SLFBIOSC <SLFNATSC <SLFHEAL2 <SLFENGIN <SSSCARTCRE <SLFCREAT <SLFPERFA <SLFFINEA)
;;(<SSLFCONF <SLFLEARN <SLFCRITT <SLFRESEA <SLFANALY <SLFSYNTH <SLFCOMPU <SLFIQ <SLFSELF4 <SLFCOPE <SLFSELF5 <SLFCONFL <SLFOPTIM <SLFFRIEN <SLFDECMA <SLFTIMEM <SLFSELFM <SLFACHAN <SLFMANA6 <SLFHEAL3 <SLFINDEP <SLFADAPT <SLFMEETP <SLFPERSU <SLFMANA7 <SLFBUSAN <SLFSPEAK <SLFJOBSE <SLFSOCSC <SLFPHILR <SLFLIBAR <SLFEDUCH <SLFLISTE <SLFHELPS <SLFBIOSC <SLFNATSC <SLFHEAL2 <SLFENGIN <SLFCREAT <SLFPERFA <SLFFINEA)
;; (("SSSCLEARN" (<SLFLEARN <SLFCRITT <SLFRESEA <SLFANALY <SLFSYNTH <SLFCOMPU <SLFIQ)) ("SSSCCOPOPT" (<SLFSELF4 <SLFCOPE <SLFSELF5 <SLFCONFL <SLFOPTIM <SLFFRIEN)) ("SSSCSMSMSD" (<SLFDECMA <SLFTIMEM <SLFSELFM <SLFACHAN <SLFMANA6 <SLFHEAL3 <SLFINDEP)) ("SSSCINTERP" (<SLFADAPT <SLFMEETP <SLFPERSU <SLFMANA7 <SLFBUSAN <SLFSPEAK <SLFJOBSE)) ("SSSCALLHELP" (<SLFSOCSC <SLFPHILR <SLFLIBAR <SLFEDUCH <SLFLISTE <SLFHELPS)) ("SSSCSCIENCE" (<SLFBIOSC <SLFNATSC <SLFHEAL2 <SLFENGIN)) ("SSSCARTCRE" (<SLFCREAT <SLFPERFA <SLFFINEA)))
;; NIL    all-csyms also printed out
;;ALSO: <SSLFCONF =   ("<SSLFCONF" "Self-Confidence and Life Skill Areas" $SC.$BV.$SLF.<SSLFCONF NIL "A list of knowledge and skills areas was developed, and subjects were asked to rate their own confidence/skills for each area. The Self-Confidence scale measures the contingent, efficacy aspect of sel" :QT :SCALE :CSS $SLF :VA 0.9930244 :SD 0.21540882 :S (<SSSCLEARN <SSSCCOPOPT <SSSCSMSMSD <SSSCINTERP <SSSCALLHELP <SSSCSCIENCE <SSSCARTCRE <SLFLEARN <SLFCRITT <SLFRESEA <SLFANALY <SLFSYNTH <SLFCOMPU <SLFIQ <SLFSELF4 <SLFCOPE <SLFSELF5 <SLFCONFL <SLFOPTIM <SLFFRIEN <SLFDECMA <SLFTIMEM <SLFSELFM <SLFACHAN <SLFMANA6 <SLFHEAL3 <SLFINDEP <SLFADAPT <SLFMEETP <SLFPERSU <SLFMANA7 <SLFBUSAN <SLFSPEAK <SLFJOBSE <SLFSOCSC <SLFPHILR <SLFLIBAR <SLFEDUCH <SLFLISTE <SLFHELPS <SLFBIOSC <SLFNATSC <SLFHEAL2 <SLFENGIN <SLFCREAT <SLFPERFA <SLFFINEA))
;; also:  $SC.$BV.$SLF.<SSLFCONF  =  ("$SC.$BV.$SLF.<SSLFCONF" ($SC $BV $SLF <SSLFCONF) NIL <SSLFCONF)
;; subscale: <SSSCCOPOPT   =  ("<SSSCCOPOPT" "Achievement Confidence" $SC.$BV.$SLF.<SSLFCONF.<SSSCCOPOPT NIL "Confidence/skills of optimistic-assertive engagement for both people and nonpeople tasks. Achievement motivation, work habits, emotional control, optimism, self-disclosure, and caring conflict resolut" :QT :SCALE :CSS <SSLFCONF :VA 1.0 :SD 0.0 :S (<SLFSELF4 <SLFCOPE <SLFSELF5 <SLFCONFL <SLFOPTIM <SLFFRIEN))
;; qvar: <SLFSELF4   =  ("<SLFSELF4" "sc-Ach motivation-work habits, focus" $SC.$BV.$SLF.<SSLFCONF.<SSSCCOPOPT.<SLFSELF4 NIL "Self-motivation--ability to motivate yourself to do unpleasant tasks even under adverse conditions" :QT :SCALE :CSS <SSLFCONF :VA 1.0)



;; make-csyms-from-subscales&qvars
;;main-scales=  (VALUES-THEMES BELIEFS SKILLS-CONFIDENCE INTERPERSONAL ACAD-LEARNING CAREER-INTEREST OUTCOME BIO)
;; (make-csyms-from-subscales&qvars 'BELIEFS)
;; (make-csyms-from-subscales&qvars 'sworldview)
;; FOR STARTING FROM MAKE-CSYM-TREE
;; (make-csyms-from-subscales&qvars 'SWORLDVIEW  :if-csym-exists :REPLACE :csartloc-origin :supsys-csartloc  :SUPSYS-CSARTLOC '$CS.$BV.$WV :SUPSYS '$WV)
#|<SWORLDVIEW
(<TBVENTIT <WOVNFAIR <WOVINJUR <WOVENTIT <SSWVENTIT)
(<SWORLDVIEW <SSWVGRATPT <TBVGRATI <WOVABUND <WOVGRATE <SSWVOPTIMS <WOVPROGR <WOVGOODF <WOVMYLIF <WOVPOSTH <SSWVENTIT <TBVENTIT <WOVNFAIR <WOVINJUR <WOVENTIT)
(<SWORLDVIEW <TBVGRATI <WOVABUND <WOVGRATE <WOVPROGR <WOVGOODF <WOVMYLIF <WOVPOSTH <TBVENTIT <WOVNFAIR <WOVINJUR <WOVENTIT)
(("SSWVGRATPT" (<TBVGRATI <WOVABUND <WOVGRATE)) ("SSWVOPTIMS" (<WOVPROGR <WOVGOODF <WOVMYLIF <WOVPOSTH)) ("SSWVENTIT" (<TBVENTIT <WOVNFAIR <WOVINJUR <WOVENTIT)))
($CS.$BV.$WV.<SWORLDVIEW $CS.$BV.$WV.<SWORLDVIEW.<SSWVGRATPT $CS.$BV.$WV.<SWORLDVIEW.<SSWVGRATPT.<TBVGRATI $CS.$BV.$WV.<SWORLDVIEW.<SSWVGRATPT.<WOVABUND $CS.$BV.$WV.<SWORLDVIEW.<SSWVGRATPT.<WOVGRATE $CS.$BV.$WV.<SWORLDVIEW.<SSWVOPTIMS $CS.$BV.$WV.<SWORLDVIEW.<SSWVOPTIMS.<WOVPROGR $CS.$BV.$WV.<SWORLDVIEW.<SSWVOPTIMS.<WOVGOODF $CS.$BV.$WV.<SWORLDVIEW.<SSWVOPTIMS.<WOVMYLIF $CS.$BV.$WV.<SWORLDVIEW.<SSWVOPTIMS.<WOVPOSTH $CS.$BV.$WV.<SWORLDVIEW.<SSWVENTIT $CS.$BV.$WV.<SWORLDVIEW.<SSWVENTIT.<TBVENTIT $CS.$BV.$WV.<SWORLDVIEW.<SSWVENTIT.<WOVNFAIR $CS.$BV.$WV.<SWORLDVIEW.<SSWVENTIT.<WOVINJUR $CS.$BV.$WV.<SWORLDVIEW.<SSWVENTIT.<WOVENTIT)|#
;;ALSO: scale: <SWORLDVIEW   =   ("<SWORLDVIEW" "Positive World View" $CS.$BV.$WV.<SWORLDVIEW NIL "Optimism about the future of the world and own life, lack of entitlement thinking, plus daily positive versus negative thoughts. How constructively and positively you view the world and the future can" :QT :SCALE :CSS $WV :VA 0.926 :SD 1.863082 :S (<SSWVGRATPT <SSWVOPTIMS <SSWVENTIT <TBVGRATI <WOVABUND <WOVGRATE <WOVPROGR <WOVGOODF <WOVMYLIF <WOVPOSTH <TBVENTIT <WOVNFAIR <WOVINJUR <WOVENTIT))
;; subscale: <SSWVGRATPT  =  ("<SSWVGRATPT" "Grateful Abundance Beliefs" $CS.$BV.$WV.<SWORLDVIEW.<SSWVGRATPT NIL "High gratitude for life and whatever one has; high proportion of positive thoughts. (5 items). Had best correlation with overall happiness of any scale (0.722). Also correlated 0.574 with low depressi" :QT :SCALE :CSS <SWORLDVIEW :VA 1.0 :SD 1.4142135 :S (<TBVGRATI <WOVABUND <WOVGRATE))
;;qvar: <WOVGRATE   =  ("<WOVGRATE" "wv-Extremely grateful" $CS.$BV.$WV.<SWORLDVIEW.<SSWVGRATPT.<WOVGRATE NIL "I am extremely grateful for having so much." :QT :SCALE :CSS <SWORLDVIEW :VA 1.0)
;; qvar csartloc:  $CS.$BV.$WV.<SWORLDVIEW.<SSWVGRATPT.<WOVGRATE =   ("$CS.$BV.$WV.<SWORLDVIEW.<SSWVGRATPT.<WOVGRATE" ($CS $BV $WV <SWORLDVIEW <SSWVGRATPT <WOVGRATE) NIL <WOVGRATE)
;; (makunbound '<sworldview)
;; (make-csyms-from-subscales&qvars 'stbslfwo)
;; (makunbound '<stbslfwo)

;;
#|
;;PER-SYSTEM SCALES
;; 
(my-defclass BIO (assessment per-system)
  (my-defclass VALUES-THEMES (assessment per-system)
  (my-defclass BELIEFS  (assessment per-system)
  (my-defclass SKILLS-CONFIDENCE  (assessment per-system)
  (my-defclass INTERPERSONAL (assessment per-system)
  (my-defclass ACAD-LEARNING (assessment per-system)
  (my-defclass CAREER-INTEREST (assessment per-system)
  (my-defclass OUTCOME (assessment per-system)
;;OTHER, VARIOUS (BIO-TEXT INTRO-MAQ text-answer-question multi-answer-scale composite-scale)
  (my-defclass BIO-TEXT (text-answer-question scale) ;;was BIO
  (my-defclass INTRO-MAQ ( multi-answer-scale)
  (my-defclass BIO-MAQ (multi-answer-scale)
  (my-defclass HQ  (composite-scale)
  (my-defclass HigherSelfScale (composite-scale)
  (my-defclass sID  (BIO-TEXT)
        (my-defclass acad-ach  (BIO scale)
      (my-defclass no-scale (BIO scale)
  (my-defclass sutype  (INTRO-MAQ)
  (my-defclass sugoals  (INTRO-MAQ)
|#+
;;TEST
;; ;; (make-csyms-from-subscales&qvars 'sworldview)
;; (make-csyms-from-subscales&qvars 'BIO-TEXT)


;;SSSSSS START HERE TEST FOR BIO, ETC
;; (make-csyms-from-subscales&qvars 'BIO)
#| results= <BIO
(<BIO <ACAD-ACH <BIO3EDUC <BIOHSGPA <BIOCOLLE <NO-SCALE <BIO5INCO)
(<BIO <ACAD-ACH <NO-SCALE)
(("ACAD-ACH" (<BIO3EDUC <BIOHSGPA <BIOCOLLE)) ("NO-SCALE" (<BIO5INCO)))
($CS.ASSESSMENT.PER-SYSTEM.<BIO $CS.ASSESSMENT.PER-SYSTEM.<ACAD-ACH $CS.ASSESSMENT.PER-SYSTEM.<ACAD-ACH.<BIO3EDUC $CS.ASSESSMENT.PER-SYSTEM.<ACAD-ACH.<BIOHSGPA $CS.ASSESSMENT.PER-SYSTEM.<ACAD-ACH.<BIOCOLLE $CS.ASSESSMENT.PER-SYSTEM.<NO-SCALE $CS.ASSESSMENT.PER-SYSTEM.<NO-SCALE.<BIO5INCO)
$CS.ASSESSMENT.PER-SYSTEM.<BIO
($CS ASSESSMENT PER SYSTEM <BIO)
;;ALSO:
<BIO = ("<BIO" UNBOUND-SLOT $CS.ASSESSMENT.PER-SYSTEM.<BIO NIL "Biographical informaton" :QT :SCALE :CSS (ASSESSMENT PER-SYSTEM) :VA UNBOUND-SLOT)
<BIOHSGPA = ("<BIOHSGPA" "b-High school GPA" $CS.ASSESSMENT.PER-SYSTEM.<ACAD-ACH.<BIOHSGPA NIL "Your high school grade average?" :QT :QVAR :CSS $CS.ASSESSMENT.PER-SYSTEM.<ACAD-ACH)
 <NO-SCALE  = ("<NO-SCALE" UNBOUND-SLOT $CS.ASSESSMENT.PER-SYSTEM.<NO-SCALE NIL "Biographical informaton" :QT :SCALE :CSS (ASSESSMENT PER-SYSTEM))
|#
;;FOR MAIN SINGLE-SELECTON SHAQ SCALES
;; (make-csyms-from-subscales&qvars 'SWORLDVIEW)
;;scale-csym= <SWORLDVIEW
;;all-new-csyms= (<SWORLDVIEW <SSWVGRATPT <WOVPROGR <WOVGOODF <WOVMYLIF <WOVNFAIR <TBVENTIT <WOVINJUR <WOVABUND <TBVGRATI <WOVENTIT <WOVGRATE <WOVPOSTH <SSWVOPTIMS <WOVPROGR <WOVGOODF <WOVMYLIF <WOVNFAIR <TBVENTIT <WOVINJUR <WOVABUND <TBVGRATI <WOVENTIT <WOVGRATE <WOVPOSTH <SSWVENTIT <WOVPROGR <WOVGOODF <WOVMYLIF <WOVNFAIR <TBVENTIT <WOVINJUR <WOVABUND <TBVGRATI <WOVENTIT <WOVGRATE <WOVPOSTH)
;;all-new-scale-csyms= (<SWORLDVIEW <SSWVGRATPT <SSWVOPTIMS <SSWVENTIT)
;; all-qvar-csyms= (("SSWVGRATPT" (<WOVPROGR <WOVGOODF <WOVMYLIF <WOVNFAIR <TBVENTIT <WOVINJUR <WOVABUND <TBVGRATI <WOVENTIT <WOVGRATE <WOVPOSTH)) ("SSWVOPTIMS" (<WOVPROGR <WOVGOODF <WOVMYLIF <WOVNFAIR <TBVENTIT <WOVINJUR <WOVABUND <TBVGRATI <WOVENTIT <WOVGRATE <WOVPOSTH)) ("SSWVENTIT" (<WOVPROGR <WOVGOODF <WOVMYLIF <WOVNFAIR <TBVENTIT <WOVINJUR <WOVABUND <TBVGRATI <WOVENTIT <WOVGRATE <WOVPOSTH)))
;;all-csartloc-syms= ($CS.BELIEFS.HQ.<SWORLDVIEW $CS.BELIEFS.HQ.<SSWVGRATPT $CS.BELIEFS.HQ.<SSWVOPTIMS $CS.BELIEFS.HQ.<SSWVENTIT)
;;all-csartloc-syms= ($CS.BELIEFS.HQ.<SWORLDVIEW $CS.BELIEFS.HQ.<SSWVGRATPT $CS.BELIEFS.HQ.<SSWVGRATPT.<WOVPROGR $CS.BELIEFS.HQ.<SSWVGRATPT.<WOVGOODF $CS.BELIEFS.HQ.<SSWVGRATPT.<WOVMYLIF $CS.BELIEFS.HQ.<SSWVGRATPT.<WOVNFAIR $CS.BELIEFS.HQ.<SSWVGRATPT.<TBVENTIT $CS.BELIEFS.HQ.<SSWVGRATPT.<WOVINJUR $CS.BELIEFS.HQ.<SSWVGRATPT.<WOVABUND $CS.BELIEFS.HQ.<SSWVGRATPT.<TBVGRATI $CS.BELIEFS.HQ.<SSWVGRATPT.<WOVENTIT $CS.BELIEFS.HQ.<SSWVGRATPT.<WOVGRATE $CS.BELIEFS.HQ.<SSWVGRATPT.<WOVPOSTH $CS.BELIEFS.HQ.<SSWVOPTIMS $CS.BELIEFS.HQ.<SSWVOPTIMS.<WOVPROGR $CS.BELIEFS.HQ.<SSWVOPTIMS.<WOVGOODF $CS.BELIEFS.HQ.<SSWVOPTIMS.<WOVMYLIF $CS.BELIEFS.HQ.<SSWVOPTIMS.<WOVNFAIR $CS.BELIEFS.HQ.<SSWVOPTIMS.<TBVENTIT $CS.BELIEFS.HQ.<SSWVOPTIMS.<WOVINJUR $CS.BELIEFS.HQ.<SSWVOPTIMS.<WOVABUND $CS.BELIEFS.HQ.<SSWVOPTIMS.<TBVGRATI $CS.BELIEFS.HQ.<SSWVOPTIMS.<WOVENTIT $CS.BELIEFS.HQ.<SSWVOPTIMS.<WOVGRATE $CS.BELIEFS.HQ.<SSWVOPTIMS.<WOVPOSTH $CS.BELIEFS.HQ.<SSWVENTIT $CS.BELIEFS.HQ.<SSWVENTIT.<WOVPROGR $CS.BELIEFS.HQ.<SSWVENTIT.<WOVGOODF $CS.BELIEFS.HQ.<SSWVENTIT.<WOVMYLIF $CS.BELIEFS.HQ.<SSWVENTIT.<WOVNFAIR $CS.BELIEFS.HQ.<SSWVENTIT.<TBVENTIT $CS.BELIEFS.HQ.<SSWVENTIT.<WOVINJUR $CS.BELIEFS.HQ.<SSWVENTIT.<WOVABUND $CS.BELIEFS.HQ.<SSWVENTIT.<TBVGRATI $CS.BELIEFS.HQ.<SSWVENTIT.<WOVENTIT $CS.BELIEFS.HQ.<SSWVENTIT.<WOVGRATE $CS.BELIEFS.HQ.<SSWVENTIT.<WOVPOSTH)
;;csartloc-sym= $CS.BELIEFS.HQ.<SWORLDVIEW
;;csartloclist== ($CS BELIEFS HQ <SWORLDVIEW)
;; 
;;  (make-csyms-from-subscales&qvars 'BELIEFS)
;;works?= 
;; <BELIEFS
;;all-new-csyms= (<BELIEFS <SWORLDVIEW <SSWVGRATPT <WOVPROGR <WOVGOODF <WOVMYLIF <WOVNFAIR <TBVENTIT <WOVINJUR <WOVABUND <TBVGRATI <WOVENTIT <WOVGRATE <WOVPOSTH <SSWVOPTIMS <WOVPROGR <WOVGOODF <WOVMYLIF <WOVNFAIR <TBVENTIT <WOVINJUR <WOVABUND <TBVGRATI <WOVENTIT <WOVGRATE <WOVPOSTH <SSWVENTIT <WOVPROGR <WOVGOODF <WOVMYLIF <WOVNFAIR <TBVENTIT <WOVINJUR <WOVABUND <TBVGRATI <WOVENTIT <WOVGRATE <WOVPOSTH <STBSLFWO <SSSWNONCONT <TBVOTHFI <TBVLIKED <TBVWEAK <TBVBEST <TBVRULES <TBVWINNE <TBVBALAN <TBVHAPCA <THVSELFA <THVUNCON <THVSELFW <SSSWHAPALLGRAT <TBVOTHFI <TBVLIKED <TBVWEAK <TBVBEST <TBVRULES <TBVWINNE <TBVBALAN <TBVHAPCA <THVSELFA <THVUNCON <THVSELFW <SSSWACALLSELF <TBVOTHFI <TBVLIKED <TBVWEAK <TBVBEST <TBVRULES <TBVWINNE <TBVBALAN <TBVHAPCA <THVSELFA <THVUNCON <THVSELFW <SIECONTR <SSIEAUTONY <IECSELFS <IECICONT <IECGENET <IECPEOPL <IECDEPEN <IECCOFEE <IECCOPRB <SSIENCODEP <IECSELFS <IECICONT <IECGENET <IECPEOPL <IECDEPEN <IECCOFEE <IECCOPRB <SSIENOTHER <IECSELFS <IECICONT <IECGENET <IECPEOPL <IECDEPEN <IECCOFEE <IECCOPRB <SETHBEL <SSB2ETHIC <TB2RELAT <TB2PUNIS <TBV2NOTR <TB2GROUM <TB2SELFM <TB2GDWRK <TB2GDATT <TB2ALLGD <TB2REASO <TBV2ASTR <TB2IDHUM <TB2LIFAD <TB2MOVEM <TBV2CORE <SSB2FORGIV <TB2RELAT <TB2PUNIS <TBV2NOTR <TB2GROUM <TB2SELFM <TB2GDWRK <TB2GDATT <TB2ALLGD <TB2REASO <TBV2ASTR <TB2IDHUM <TB2LIFAD <TB2MOVEM <TBV2CORE <SSB2IDGRND <TB2RELAT <TB2PUNIS <TBV2NOTR <TB2GROUM <TB2SELFM <TB2GDWRK <TB2GDATT <TB2ALLGD <TB2REASO <TBV2ASTR <TB2IDHUM <TB2LIFAD <TB2MOVEM <TBV2CORE <SSB2GRNDMNG <TB2RELAT <TB2PUNIS <TBV2NOTR <TB2GROUM <TB2SELFM <TB2GDWRK <TB2GDATT <TB2ALLGD <TB2REASO <TBV2ASTR <TB2IDHUM <TB2LIFAD <TB2MOVEM <TBV2CORE <SSB2INRGOOD <TB2RELAT <TB2PUNIS <TBV2NOTR <TB2GROUM <TB2SELFM <TB2GDWRK <TB2GDATT <TB2ALLGD <TB2REASO <TBV2ASTR <TB2IDHUM <TB2LIFAD <TB2MOVEM <TBV2CORE <SSB2NOASTR <TB2RELAT <TB2PUNIS <TBV2NOTR <TB2GROUM <TB2SELFM <TB2GDWRK <TB2GDATT <TB2ALLGD <TB2REASO <TBV2ASTR <TB2IDHUM <TB2LIFAD <TB2MOVEM <TBV2CORE <SSB2LIFAD <TB2RELAT <TB2PUNIS <TBV2NOTR <TB2GROUM <TB2SELFM <TB2GDWRK <TB2GDATT <TB2ALLGD <TB2REASO <TBV2ASTR <TB2IDHUM <TB2LIFAD <TB2MOVEM <TBV2CORE <SGRFEARS <SSWFSOCIAL <WOVHAPPY <WOVPOOR <WOVILL <WOVDEATH <WOVALONE <WOVNOLOV <WOVLIKED <WOVPERSO <WOVPROBL <WOVDISCO <WOVSUCCE <WOVOVERC <SSWFSELF <WOVHAPPY <WOVPOOR <WOVILL <WOVDEATH <WOVALONE <WOVNOLOV <WOVLIKED <WOVPERSO <WOVPROBL <WOVDISCO <WOVSUCCE <WOVOVERC <SSWFPOVFAI <WOVHAPPY <WOVPOOR <WOVILL <WOVDEATH <WOVALONE <WOVNOLOV <WOVLIKED <WOVPERSO <WOVPROBL <WOVDISCO <WOVSUCCE <WOVOVERC <SSWFILLDEA <WOVHAPPY <WOVPOOR <WOVILL <WOVDEATH <WOVALONE <WOVNOLOV <WOVLIKED <WOVPERSO <WOVPROBL <WOVDISCO <WOVSUCCE <WOVOVERC)   ME: [LENGTH = 259]
;;all-new-scale-csyms= (<BELIEFS <SWORLDVIEW <SSWVGRATPT <SSWVOPTIMS <SSWVENTIT <STBSLFWO <SSSWNONCONT <SSSWHAPALLGRAT <SSSWACALLSELF <SIECONTR <SSIEAUTONY <SSIENCODEP <SSIENOTHER <SETHBEL <SSB2ETHIC <SSB2FORGIV <SSB2IDGRND <SSB2GRNDMNG <SSB2INRGOOD <SSB2NOASTR <SSB2LIFAD <SGRFEARS <SSWFSOCIAL <SSWFSELF <SSWFPOVFAI <SSWFILLDEA)
;;all-qvar-csyms= (("SSWVGRATPT" (<WOVPROGR <WOVGOODF <WOVMYLIF <WOVNFAIR <TBVENTIT <WOVINJUR <WOVABUND <TBVGRATI <WOVENTIT <WOVGRATE <WOVPOSTH)) ("SSWVOPTIMS" (<WOVPROGR <WOVGOODF <WOVMYLIF <WOVNFAIR <TBVENTIT <WOVINJUR <WOVABUND <TBVGRATI <WOVENTIT <WOVGRATE <WOVPOSTH)) ("SSWVENTIT" (<WOVPROGR <WOVGOODF <WOVMYLIF <WOVNFAIR <TBVENTIT <WOVINJUR <WOVABUND <TBVGRATI <WOVENTIT <WOVGRATE <WOVPOSTH)) ("SSSWNONCONT" (<TBVOTHFI <TBVLIKED <TBVWEAK <TBVBEST <TBVRULES <TBVWINNE <TBVBALAN <TBVHAPCA <THVSELFA <THVUNCON <THVSELFW)) ("SSSWHAPALLGRAT" (<TBVOTHFI <TBVLIKED <TBVWEAK <TBVBEST <TBVRULES <TBVWINNE <TBVBALAN <TBVHAPCA <THVSELFA <THVUNCON <THVSELFW)) ("SSSWACALLSELF" (<TBVOTHFI <TBVLIKED <TBVWEAK <TBVBEST <TBVRULES <TBVWINNE <TBVBALAN <TBVHAPCA <THVSELFA <THVUNCON <THVSELFW)) ("SSIEAUTONY" (<IECSELFS <IECICONT <IECGENET <IECPEOPL <IECDEPEN <IECCOFEE <IECCOPRB)) ("SSIENCODEP" (<IECSELFS <IECICONT <IECGENET <IECPEOPL <IECDEPEN <IECCOFEE <IECCOPRB)) ("SSIENOTHER" (<IECSELFS <IECICONT <IECGENET <IECPEOPL <IECDEPEN <IECCOFEE <IECCOPRB)) ("SSB2ETHIC" (<TB2RELAT <TB2PUNIS <TBV2NOTR <TB2GROUM <TB2SELFM <TB2GDWRK <TB2GDATT <TB2ALLGD <TB2REASO <TBV2ASTR <TB2IDHUM <TB2LIFAD <TB2MOVEM <TBV2CORE)) ("SSB2FORGIV" (<TB2RELAT <TB2PUNIS <TBV2NOTR <TB2GROUM <TB2SELFM <TB2GDWRK <TB2GDATT <TB2ALLGD <TB2REASO <TBV2ASTR <TB2IDHUM <TB2LIFAD <TB2MOVEM <TBV2CORE)) ("SSB2IDGRND" (<TB2RELAT <TB2PUNIS <TBV2NOTR <TB2GROUM <TB2SELFM <TB2GDWRK <TB2GDATT <TB2ALLGD <TB2REASO <TBV2ASTR <TB2IDHUM <TB2LIFAD <TB2MOVEM <TBV2CORE)) ("SSB2GRNDMNG" (<TB2RELAT <TB2PUNIS <TBV2NOTR <TB2GROUM <TB2SELFM <TB2GDWRK <TB2GDATT <TB2ALLGD <TB2REASO <TBV2ASTR <TB2IDHUM <TB2LIFAD <TB2MOVEM <TBV2CORE)) ("SSB2INRGOOD" (<TB2RELAT <TB2PUNIS <TBV2NOTR <TB2GROUM <TB2SELFM <TB2GDWRK <TB2GDATT <TB2ALLGD <TB2REASO <TBV2ASTR <TB2IDHUM <TB2LIFAD <TB2MOVEM <TBV2CORE)) ("SSB2NOASTR" (<TB2RELAT <TB2PUNIS <TBV2NOTR <TB2GROUM <TB2SELFM <TB2GDWRK <TB2GDATT <TB2ALLGD <TB2REASO <TBV2ASTR <TB2IDHUM <TB2LIFAD <TB2MOVEM <TBV2CORE)) ("SSB2LIFAD" (<TB2RELAT <TB2PUNIS <TBV2NOTR <TB2GROUM <TB2SELFM <TB2GDWRK <TB2GDATT <TB2ALLGD <TB2REASO <TBV2ASTR <TB2IDHUM <TB2LIFAD <TB2MOVEM <TBV2CORE)) ("SSWFSOCIAL" (<WOVHAPPY <WOVPOOR <WOVILL <WOVDEATH <WOVALONE <WOVNOLOV <WOVLIKED <WOVPERSO <WOVPROBL <WOVDISCO <WOVSUCCE <WOVOVERC)) ("SSWFSELF" (<WOVHAPPY <WOVPOOR <WOVILL <WOVDEATH <WOVALONE <WOVNOLOV <WOVLIKED <WOVPERSO <WOVPROBL <WOVDISCO <WOVSUCCE <WOVOVERC)) ("SSWFPOVFAI" (<WOVHAPPY <WOVPOOR <WOVILL <WOVDEATH <WOVALONE <WOVNOLOV <WOVLIKED <WOVPERSO <WOVPROBL <WOVDISCO <WOVSUCCE <WOVOVERC)) ("SSWFILLDEA" (<WOVHAPPY <WOVPOOR <WOVILL <WOVDEATH <WOVALONE <WOVNOLOV <WOVLIKED <WOVPERSO <WOVPROBL <WOVDISCO <WOVSUCCE <WOVOVERC)))
;;all-csartloc-syms= ($CS.ASSESSMENT.PER-SYSTEM.<BELIEFS $CS.ASSESSMENT.PER-SYSTEM.<SWORLDVIEW $CS.ASSESSMENT.PER-SYSTEM.<SSWVGRATPT $CS.ASSESSMENT.PER-SYSTEM.<SSWVGRATPT.<WOVPROGR $CS.ASSESSMENT.PER-SYSTEM.<SSWVGRATPT.<WOVGOODF $CS.ASSESSMENT.PER-SYSTEM.<SSWVGRATPT.<WOVMYLIF $CS.ASSESSMENT.PER-SYSTEM.<SSWVGRATPT.<WOVNFAIR $CS.ASSESSMENT.PER-SYSTEM.<SSWVGRATPT.<TBVENTIT $CS.ASSESSMENT.PER-SYSTEM.<SSWVGRATPT.<WOVINJUR $CS.ASSESSMENT.PER-SYSTEM.<SSWVGRATPT.<WOVABUND $CS.ASSESSMENT.PER-SYSTEM.<SSWVGRATPT.<TBVGRATI $CS.ASSESSMENT.PER-SYSTEM.<SSWVGRATPT.<WOVENTIT $CS.ASSESSMENT.PER-SYSTEM.<SSWVGRATPT.<WOVGRATE $CS.ASSESSMENT.PER-SYSTEM.<SSWVGRATPT.<WOVPOSTH $CS.ASSESSMENT.PER-SYSTEM.<SSWVOPTIMS $CS.ASSESSMENT.PER-SYSTEM.<SSWVOPTIMS.<WOVPROGR $CS.ASSESSMENT.PER-SYSTEM.<SSWVOPTIMS.<WOVGOODF $CS.ASSESSMENT.PER-SYSTEM.<SSWVOPTIMS.<WOVMYLIF $CS.ASSESSMENT.PER-SYSTEM.<SSWVOPTIMS.<WOVNFAIR $CS.ASSESSMENT.PER-SYSTEM.<SSWVOPTIMS.<TBVENTIT $CS.ASSESSMENT.PER-SYSTEM.<SSWVOPTIMS.<WOVINJUR $CS.ASSESSMENT.PER-SYSTEM.<SSWVOPTIMS.<WOVABUND $CS.ASSESSMENT.PER-SYSTEM.<SSWVOPTIMS.<TBVGRATI $CS.ASSESSMENT.PER-SYSTEM.<SSWVOPTIMS.<WOVENTIT $CS.ASSESSMENT.PER-SYSTEM.<SSWVOPTIMS.<WOVGRATE $CS.ASSESSMENT.PER-SYSTEM.<SSWVOPTIMS.<WOVPOSTH $CS.ASSESSMENT.PER-SYSTEM.<SSWVENTIT $CS.ASSESSMENT.PER-SYSTEM.<SSWVENTIT.<WOVPROGR $CS.ASSESSMENT.PER-SYSTEM.<SSWVENTIT.<WOVGOODF $CS.ASSESSMENT.PER-SYSTEM.<SSWVENTIT.<WOVMYLIF $CS.ASSESSMENT.PER-SYSTEM.<SSWVENTIT.<WOVNFAIR $CS.ASSESSMENT.PER-SYSTEM.<SSWVENTIT.<TBVENTIT $CS.ASSESSMENT.PER-SYSTEM.<SSWVENTIT.<WOVINJUR $CS.ASSESSMENT.PER-SYSTEM.<SSWVENTIT.<WOVABUND $CS.ASSESSMENT.PER-SYSTEM.<SSWVENTIT.<TBVGRATI $CS.ASSESSMENT.PER-SYSTEM.<SSWVENTIT.<WOVENTIT $CS.ASSESSMENT.PER-SYSTEM.<SSWVENTIT.<WOVGRATE $CS.ASSESSMENT.PER-SYSTEM.<SSWVENTIT.<WOVPOSTH $CS.ASSESSMENT.PER-SYSTEM.<STBSLFWO $CS.ASSESSMENT.PER-SYSTEM.<SSSWNONCONT $CS.ASSESSMENT.PER-SYSTEM.<SSSWNONCONT.<TBVOTHFI $CS.ASSESSMENT.PER-SYSTEM.<SSSWNONCONT.<TBVLIKED $CS.ASSESSMENT.PER-SYSTEM.<SSSWNONCONT.<TBVWEAK $CS.ASSESSMENT.PER-SYSTEM.<SSSWNONCONT.<TBVBEST $CS.ASSESSMENT.PER-SYSTEM.<SSSWNONCONT.<TBVRULES $CS.ASSESSMENT.PER-SYSTEM.<SSSWNONCONT.<TBVWINNE $CS.ASSESSMENT.PER-SYSTEM.<SSSWNONCONT.<TBVBALAN $CS.ASSESSMENT.PER-SYSTEM.<SSSWNONCONT.<TBVHAPCA $CS.ASSESSMENT.PER-SYSTEM.<SSSWNONCONT.<THVSELFA $CS.ASSESSMENT.PER-SYSTEM.<SSSWNONCONT.<THVUNCON $CS.ASSESSMENT.PER-SYSTEM.<SSSWNONCONT.<THVSELFW $CS.ASSESSMENT.PER-SYSTEM.<SSSWHAPALLGRAT $CS.ASSESSMENT.PER-SYSTEM.<SSSWHAPALLGRAT.<TBVOTHFI $CS.ASSESSMENT.PER-SYSTEM.<SSSWHAPALLGRAT.<TBVLIKED $CS.ASSESSMENT.PER-SYSTEM.<SSSWHAPALLGRAT.<TBVWEAK $CS.ASSESSMENT.PER-SYSTEM.<SSSWHAPALLGRAT.<TBVBEST $CS.ASSESSMENT.PER-SYSTEM.<SSSWHAPALLGRAT.<TBVRULES $CS.ASSESSMENT.PER-SYSTEM.<SSSWHAPALLGRAT.<TBVWINNE $CS.ASSESSMENT.PER-SYSTEM.<SSSWHAPALLGRAT.<TBVBALAN $CS.ASSESSMENT.PER-SYSTEM.<SSSWHAPALLGRAT.<TBVHAPCA $CS.ASSESSMENT.PER-SYSTEM.<SSSWHAPALLGRAT.<THVSELFA $CS.ASSESSMENT.PER-SYSTEM.<SSSWHAPALLGRAT.<THVUNCON $CS.ASSESSMENT.PER-SYSTEM.<SSSWHAPALLGRAT.<THVSELFW $CS.ASSESSMENT.PER-SYSTEM.<SSSWACALLSELF $CS.ASSESSMENT.PER-SYSTEM.<SSSWACALLSELF.<TBVOTHFI $CS.ASSESSMENT.PER-SYSTEM.<SSSWACALLSELF.<TBVLIKED $CS.ASSESSMENT.PER-SYSTEM.<SSSWACALLSELF.<TBVWEAK $CS.ASSESSMENT.PER-SYSTEM.<SSSWACALLSELF.<TBVBEST $CS.ASSESSMENT.PER-SYSTEM.<SSSWACALLSELF.<TBVRULES $CS.ASSESSMENT.PER-SYSTEM.<SSSWACALLSELF.<TBVWINNE $CS.ASSESSMENT.PER-SYSTEM.<SSSWACALLSELF.<TBVBALAN $CS.ASSESSMENT.PER-SYSTEM.<SSSWACALLSELF.<TBVHAPCA $CS.ASSESSMENT.PER-SYSTEM.<SSSWACALLSELF.<THVSELFA $CS.ASSESSMENT.PER-SYSTEM.<SSSWACALLSELF.<THVUNCON $CS.ASSESSMENT.PER-SYSTEM.<SSSWACALLSELF.<THVSELFW $CS.ASSESSMENT.PER-SYSTEM.<SIECONTR $CS.ASSESSMENT.PER-SYSTEM.<SSIEAUTONY $CS.ASSESSMENT.PER-SYSTEM.<SSIEAUTONY.<IECSELFS $CS.ASSESSMENT.PER-SYSTEM.<SSIEAUTONY.<IECICONT $CS.ASSESSMENT.PER-SYSTEM.<SSIEAUTONY.<IECGENET $CS.ASSESSMENT.PER-SYSTEM.<SSIEAUTONY.<IECPEOPL $CS.ASSESSMENT.PER-SYSTEM.<SSIEAUTONY.<IECDEPEN $CS.ASSESSMENT.PER-SYSTEM.<SSIEAUTONY.<IECCOFEE $CS.ASSESSMENT.PER-SYSTEM.<SSIEAUTONY.<IECCOPRB $CS.ASSESSMENT.PER-SYSTEM.<SSIENCODEP $CS.ASSESSMENT.PER-SYSTEM.<SSIENCODEP.<IECSELFS $CS.ASSESSMENT.PER-SYSTEM.<SSIENCODEP.<IECICONT $CS.ASSESSMENT.PER-SYSTEM.<SSIENCODEP.<IECGENET $CS.ASSESSMENT.PER-SYSTEM.<SSIENCODEP.<IECPEOPL $CS.ASSESSMENT.PER-SYSTEM.<SSIENCODEP.<IECDEPEN $CS.ASSESSMENT.PER-SYSTEM.<SSIENCODEP.<IECCOFEE $CS.ASSESSMENT.PER-SYSTEM.<SSIENCODEP.<IECCOPRB $CS.ASSESSMENT.PER-SYSTEM.<SSIENOTHER $CS.ASSESSMENT.PER-SYSTEM.<SSIENOTHER.<IECSELFS $CS.ASSESSMENT.PER-SYSTEM.<SSIENOTHER.<IECICONT $CS.ASSESSMENT.PER-SYSTEM.<SSIENOTHER.<IECGENET $CS.ASSESSMENT.PER-SYSTEM.<SSIENOTHER.<IECPEOPL $CS.ASSESSMENT.PER-SYSTEM.<SSIENOTHER.<IECDEPEN $CS.ASSESSMENT.PER-SYSTEM.<SSIENOTHER.<IECCOFEE $CS.ASSESSMENT.PER-SYSTEM.<SSIENOTHER.<IECCOPRB $CS.ASSESSMENT.PER-SYSTEM.<SETHBEL $CS.ASSESSMENT.PER-SYSTEM.<SSB2ETHIC $CS.ASSESSMENT.PER-SYSTEM.<SSB2ETHIC.<TB2RELAT $CS.ASSESSMENT.PER-SYSTEM.<SSB2ETHIC.<TB2PUNIS $CS.ASSESSMENT.PER-SYSTEM.<SSB2ETHIC.<TBV2NOTR $CS.ASSESSMENT.PER-SYSTEM.<SSB2ETHIC.<TB2GROUM $CS.ASSESSMENT.PER-SYSTEM.<SSB2ETHIC.<TB2SELFM $CS.ASSESSMENT.PER-SYSTEM.<SSB2ETHIC.<TB2GDWRK $CS.ASSESSMENT.PER-SYSTEM.<SSB2ETHIC.<TB2GDATT $CS.ASSESSMENT.PER-SYSTEM.<SSB2ETHIC.<TB2ALLGD $CS.ASSESSMENT.PER-SYSTEM.<SSB2ETHIC.<TB2REASO $CS.ASSESSMENT.PER-SYSTEM.<SSB2ETHIC.<TBV2ASTR $CS.ASSESSMENT.PER-SYSTEM.<SSB2ETHIC.<TB2IDHUM $CS.ASSESSMENT.PER-SYSTEM.<SSB2ETHIC.<TB2LIFAD $CS.ASSESSMENT.PER-SYSTEM.<SSB2ETHIC.<TB2MOVEM $CS.ASSESSMENT.PER-SYSTEM.<SSB2ETHIC.<TBV2CORE $CS.ASSESSMENT.PER-SYSTEM.<SSB2FORGIV $CS.ASSESSMENT.PER-SYSTEM.<SSB2FORGIV.<TB2RELAT $CS.ASSESSMENT.PER-SYSTEM.<SSB2FORGIV.<TB2PUNIS $CS.ASSESSMENT.PER-SYSTEM.<SSB2FORGIV.<TBV2NOTR $CS.ASSESSMENT.PER-SYSTEM.<SSB2FORGIV.<TB2GROUM $CS.ASSESSMENT.PER-SYSTEM.<SSB2FORGIV.<TB2SELFM $CS.ASSESSMENT.PER-SYSTEM.<SSB2FORGIV.<TB2GDWRK $CS.ASSESSMENT.PER-SYSTEM.<SSB2FORGIV.<TB2GDATT $CS.ASSESSMENT.PER-SYSTEM.<SSB2FORGIV.<TB2ALLGD $CS.ASSESSMENT.PER-SYSTEM.<SSB2FORGIV.<TB2REASO $CS.ASSESSMENT.PER-SYSTEM.<SSB2FORGIV.<TBV2ASTR $CS.ASSESSMENT.PER-SYSTEM.<SSB2FORGIV.<TB2IDHUM $CS.ASSESSMENT.PER-SYSTEM.<SSB2FORGIV.<TB2LIFAD $CS.ASSESSMENT.PER-SYSTEM.<SSB2FORGIV.<TB2MOVEM $CS.ASSESSMENT.PER-SYSTEM.<SSB2FORGIV.<TBV2CORE $CS.ASSESSMENT.PER-SYSTEM.<SSB2IDGRND $CS.ASSESSMENT.PER-SYSTEM.<SSB2IDGRND.<TB2RELAT $CS.ASSESSMENT.PER-SYSTEM.<SSB2IDGRND.<TB2PUNIS $CS.ASSESSMENT.PER-SYSTEM.<SSB2IDGRND.<TBV2NOTR $CS.ASSESSMENT.PER-SYSTEM.<SSB2IDGRND.<TB2GROUM $CS.ASSESSMENT.PER-SYSTEM.<SSB2IDGRND.<TB2SELFM $CS.ASSESSMENT.PER-SYSTEM.<SSB2IDGRND.<TB2GDWRK $CS.ASSESSMENT.PER-SYSTEM.<SSB2IDGRND.<TB2GDATT $CS.ASSESSMENT.PER-SYSTEM.<SSB2IDGRND.<TB2ALLGD $CS.ASSESSMENT.PER-SYSTEM.<SSB2IDGRND.<TB2REASO $CS.ASSESSMENT.PER-SYSTEM.<SSB2IDGRND.<TBV2ASTR $CS.ASSESSMENT.PER-SYSTEM.<SSB2IDGRND.<TB2IDHUM $CS.ASSESSMENT.PER-SYSTEM.<SSB2IDGRND.<TB2LIFAD $CS.ASSESSMENT.PER-SYSTEM.<SSB2IDGRND.<TB2MOVEM $CS.ASSESSMENT.PER-SYSTEM.<SSB2IDGRND.<TBV2CORE $CS.ASSESSMENT.PER-SYSTEM.<SSB2GRNDMNG $CS.ASSESSMENT.PER-SYSTEM.<SSB2GRNDMNG.<TB2RELAT $CS.ASSESSMENT.PER-SYSTEM.<SSB2GRNDMNG.<TB2PUNIS $CS.ASSESSMENT.PER-SYSTEM.<SSB2GRNDMNG.<TBV2NOTR $CS.ASSESSMENT.PER-SYSTEM.<SSB2GRNDMNG.<TB2GROUM $CS.ASSESSMENT.PER-SYSTEM.<SSB2GRNDMNG.<TB2SELFM $CS.ASSESSMENT.PER-SYSTEM.<SSB2GRNDMNG.<TB2GDWRK $CS.ASSESSMENT.PER-SYSTEM.<SSB2GRNDMNG.<TB2GDATT $CS.ASSESSMENT.PER-SYSTEM.<SSB2GRNDMNG.<TB2ALLGD $CS.ASSESSMENT.PER-SYSTEM.<SSB2GRNDMNG.<TB2REASO $CS.ASSESSMENT.PER-SYSTEM.<SSB2GRNDMNG.<TBV2ASTR $CS.ASSESSMENT.PER-SYSTEM.<SSB2GRNDMNG.<TB2IDHUM $CS.ASSESSMENT.PER-SYSTEM.<SSB2GRNDMNG.<TB2LIFAD $CS.ASSESSMENT.PER-SYSTEM.<SSB2GRNDMNG.<TB2MOVEM $CS.ASSESSMENT.PER-SYSTEM.<SSB2GRNDMNG.<TBV2CORE $CS.ASSESSMENT.PER-SYSTEM.<SSB2INRGOOD $CS.ASSESSMENT.PER-SYSTEM.<SSB2INRGOOD.<TB2RELAT $CS.ASSESSMENT.PER-SYSTEM.<SSB2INRGOOD.<TB2PUNIS $CS.ASSESSMENT.PER-SYSTEM.<SSB2INRGOOD.<TBV2NOTR $CS.ASSESSMENT.PER-SYSTEM.<SSB2INRGOOD.<TB2GROUM $CS.ASSESSMENT.PER-SYSTEM.<SSB2INRGOOD.<TB2SELFM $CS.ASSESSMENT.PER-SYSTEM.<SSB2INRGOOD.<TB2GDWRK $CS.ASSESSMENT.PER-SYSTEM.<SSB2INRGOOD.<TB2GDATT $CS.ASSESSMENT.PER-SYSTEM.<SSB2INRGOOD.<TB2ALLGD $CS.ASSESSMENT.PER-SYSTEM.<SSB2INRGOOD.<TB2REASO $CS.ASSESSMENT.PER-SYSTEM.<SSB2INRGOOD.<TBV2ASTR $CS.ASSESSMENT.PER-SYSTEM.<SSB2INRGOOD.<TB2IDHUM $CS.ASSESSMENT.PER-SYSTEM.<SSB2INRGOOD.<TB2LIFAD $CS.ASSESSMENT.PER-SYSTEM.<SSB2INRGOOD.<TB2MOVEM $CS.ASSESSMENT.PER-SYSTEM.<SSB2INRGOOD.<TBV2CORE $CS.ASSESSMENT.PER-SYSTEM.<SSB2NOASTR $CS.ASSESSMENT.PER-SYSTEM.<SSB2NOASTR.<TB2RELAT $CS.ASSESSMENT.PER-SYSTEM.<SSB2NOASTR.<TB2PUNIS $CS.ASSESSMENT.PER-SYSTEM.<SSB2NOASTR.<TBV2NOTR $CS.ASSESSMENT.PER-SYSTEM.<SSB2NOASTR.<TB2GROUM $CS.ASSESSMENT.PER-SYSTEM.<SSB2NOASTR.<TB2SELFM $CS.ASSESSMENT.PER-SYSTEM.<SSB2NOASTR.<TB2GDWRK $CS.ASSESSMENT.PER-SYSTEM.<SSB2NOASTR.<TB2GDATT $CS.ASSESSMENT.PER-SYSTEM.<SSB2NOASTR.<TB2ALLGD $CS.ASSESSMENT.PER-SYSTEM.<SSB2NOASTR.<TB2REASO $CS.ASSESSMENT.PER-SYSTEM.<SSB2NOASTR.<TBV2ASTR $CS.ASSESSMENT.PER-SYSTEM.<SSB2NOASTR.<TB2IDHUM $CS.ASSESSMENT.PER-SYSTEM.<SSB2NOASTR.<TB2LIFAD $CS.ASSESSMENT.PER-SYSTEM.<SSB2NOASTR.<TB2MOVEM $CS.ASSESSMENT.PER-SYSTEM.<SSB2NOASTR.<TBV2CORE $CS.ASSESSMENT.PER-SYSTEM.<SSB2LIFAD $CS.ASSESSMENT.PER-SYSTEM.<SSB2LIFAD.<TB2RELAT $CS.ASSESSMENT.PER-SYSTEM.<SSB2LIFAD.<TB2PUNIS $CS.ASSESSMENT.PER-SYSTEM.<SSB2LIFAD.<TBV2NOTR $CS.ASSESSMENT.PER-SYSTEM.<SSB2LIFAD.<TB2GROUM $CS.ASSESSMENT.PER-SYSTEM.<SSB2LIFAD.<TB2SELFM $CS.ASSESSMENT.PER-SYSTEM.<SSB2LIFAD.<TB2GDWRK $CS.ASSESSMENT.PER-SYSTEM.<SSB2LIFAD.<TB2GDATT $CS.ASSESSMENT.PER-SYSTEM.<SSB2LIFAD.<TB2ALLGD $CS.ASSESSMENT.PER-SYSTEM.<SSB2LIFAD.<TB2REASO $CS.ASSESSMENT.PER-SYSTEM.<SSB2LIFAD.<TBV2ASTR $CS.ASSESSMENT.PER-SYSTEM.<SSB2LIFAD.<TB2IDHUM $CS.ASSESSMENT.PER-SYSTEM.<SSB2LIFAD.<TB2LIFAD $CS.ASSESSMENT.PER-SYSTEM.<SSB2LIFAD.<TB2MOVEM $CS.ASSESSMENT.PER-SYSTEM.<SSB2LIFAD.<TBV2CORE $CS.ASSESSMENT.PER-SYSTEM.<SGRFEARS $CS.ASSESSMENT.PER-SYSTEM.<SSWFSOCIAL $CS.ASSESSMENT.PER-SYSTEM.<SSWFSOCIAL.<WOVHAPPY $CS.ASSESSMENT.PER-SYSTEM.<SSWFSOCIAL.<WOVPOOR $CS.ASSESSMENT.PER-SYSTEM.<SSWFSOCIAL.<WOVILL $CS.ASSESSMENT.PER-SYSTEM.<SSWFSOCIAL.<WOVDEATH $CS.ASSESSMENT.PER-SYSTEM.<SSWFSOCIAL.<WOVALONE $CS.ASSESSMENT.PER-SYSTEM.<SSWFSOCIAL.<WOVNOLOV $CS.ASSESSMENT.PER-SYSTEM.<SSWFSOCIAL.<WOVLIKED $CS.ASSESSMENT.PER-SYSTEM.<SSWFSOCIAL.<WOVPERSO $CS.ASSESSMENT.PER-SYSTEM.<SSWFSOCIAL.<WOVPROBL $CS.ASSESSMENT.PER-SYSTEM.<SSWFSOCIAL.<WOVDISCO $CS.ASSESSMENT.PER-SYSTEM.<SSWFSOCIAL.<WOVSUCCE $CS.ASSESSMENT.PER-SYSTEM.<SSWFSOCIAL.<WOVOVERC $CS.ASSESSMENT.PER-SYSTEM.<SSWFSELF $CS.ASSESSMENT.PER-SYSTEM.<SSWFSELF.<WOVHAPPY $CS.ASSESSMENT.PER-SYSTEM.<SSWFSELF.<WOVPOOR $CS.ASSESSMENT.PER-SYSTEM.<SSWFSELF.<WOVILL $CS.ASSESSMENT.PER-SYSTEM.<SSWFSELF.<WOVDEATH $CS.ASSESSMENT.PER-SYSTEM.<SSWFSELF.<WOVALONE $CS.ASSESSMENT.PER-SYSTEM.<SSWFSELF.<WOVNOLOV $CS.ASSESSMENT.PER-SYSTEM.<SSWFSELF.<WOVLIKED $CS.ASSESSMENT.PER-SYSTEM.<SSWFSELF.<WOVPERSO $CS.ASSESSMENT.PER-SYSTEM.<SSWFSELF.<WOVPROBL $CS.ASSESSMENT.PER-SYSTEM.<SSWFSELF.<WOVDISCO $CS.ASSESSMENT.PER-SYSTEM.<SSWFSELF.<WOVSUCCE $CS.ASSESSMENT.PER-SYSTEM.<SSWFSELF.<WOVOVERC $CS.ASSESSMENT.PER-SYSTEM.<SSWFPOVFAI $CS.ASSESSMENT.PER-SYSTEM.<SSWFPOVFAI.<WOVHAPPY $CS.ASSESSMENT.PER-SYSTEM.<SSWFPOVFAI.<WOVPOOR $CS.ASSESSMENT.PER-SYSTEM.<SSWFPOVFAI.<WOVILL $CS.ASSESSMENT.PER-SYSTEM.<SSWFPOVFAI.<WOVDEATH $CS.ASSESSMENT.PER-SYSTEM.<SSWFPOVFAI.<WOVALONE $CS.ASSESSMENT.PER-SYSTEM.<SSWFPOVFAI.<WOVNOLOV $CS.ASSESSMENT.PER-SYSTEM.<SSWFPOVFAI.<WOVLIKED $CS.ASSESSMENT.PER-SYSTEM.<SSWFPOVFAI.<WOVPERSO $CS.ASSESSMENT.PER-SYSTEM.<SSWFPOVFAI.<WOVPROBL $CS.ASSESSMENT.PER-SYSTEM.<SSWFPOVFAI.<WOVDISCO $CS.ASSESSMENT.PER-SYSTEM.<SSWFPOVFAI.<WOVSUCCE $CS.ASSESSMENT.PER-SYSTEM.<SSWFPOVFAI.<WOVOVERC $CS.ASSESSMENT.PER-SYSTEM.<SSWFILLDEA $CS.ASSESSMENT.PER-SYSTEM.<SSWFILLDEA.<WOVHAPPY $CS.ASSESSMENT.PER-SYSTEM.<SSWFILLDEA.<WOVPOOR $CS.ASSESSMENT.PER-SYSTEM.<SSWFILLDEA.<WOVILL $CS.ASSESSMENT.PER-SYSTEM.<SSWFILLDEA.<WOVDEATH $CS.ASSESSMENT.PER-SYSTEM.<SSWFILLDEA.<WOVALONE $CS.ASSESSMENT.PER-SYSTEM.<SSWFILLDEA.<WOVNOLOV $CS.ASSESSMENT.PER-SYSTEM.<SSWFILLDEA.<WOVLIKED $CS.ASSESSMENT.PER-SYSTEM.<SSWFILLDEA.<WOVPERSO $CS.ASSESSMENT.PER-SYSTEM.<SSWFILLDEA.<WOVPROBL $CS.ASSESSMENT.PER-SYSTEM.<SSWFILLDEA.<WOVDISCO $CS.ASSESSMENT.PER-SYSTEM.<SSWFILLDEA.<WOVSUCCE $CS.ASSESSMENT.PER-SYSTEM.<SSWFILLDEA.<WOVOVERC)
;;csartloc-sym= $CS.ASSESSMENT.PER-SYSTEM.<BELIEFS
;;csartloclist= ($CS ASSESSMENT PER SYSTEM <BELIEFS)
;;all-csyms= works, long list of 200
;;MAKUNBOUND-VARS
;; (makunbound-vars '(<SWORLDVIEW <STBSLFWO <SIECONTR <SETHBEL <SGRFEARS <BELIEFS <WOVPROGR <WOVGOODF <WOVMYLIF <WOVNFAIR <TBVENTIT <WOVINJUR <WOVABUND <TBVGRATI <WOVENTIT <WOVGRATE <WOVPOSTH <TBVOTHFI <TBVLIKED <TBVWEAK <TBVBEST <TBVRULES <TBVWINNE <TBVBALAN <TBVHAPCA <THVSELFA <THVUNCON <THVSELFW <IECSELFS <IECICONT <IECGENET <IECPEOPL <IECDEPEN <IECCOFEE <IECCOPRB <TB2RELAT <TB2PUNIS <TBV2NOTR <TB2GROUM <TB2SELFM <TB2GDWRK <TB2GDATT <TB2ALLGD <TB2REASO <TBV2ASTR <TB2IDHUM <TB2LIFAD <TB2MOVEM <TBV2CORE <WOVHAPPY <WOVPOOR <WOVILL <WOVDEATH <WOVALONE <WOVNOLOV <WOVLIKED <WOVPERSO <WOVPROBL <WOVDISCO <WOVSUCCE <WOVOVERC <ISA <SMTBUSY))




;;MAKE-CSYM-FROM-QVAR 
;; 
;;2020
;;ddd
(defun make-csym-from-qvar (qvar  &key qvarlist 
                                  quest-varlist  qvarlist-not-exist-p 
                                  (if-csym-exists :replace)
                                  (return-csym&csymvals-p T) 
                                  (GET-SCORE-DATA-P T)
                                  qvar&ans ans-data-list text-input
                                  csphrase  csdata  csdef (qvar-csym-prefix "<")
                                  (csartloc-origin :supsys-csartloc)
                                  topdim  dims  supsys (def-supsys '$MIS) parents
                                  (last-dim :csym) supsys-csartloc   
                                  new-csartloc (make-new-csartloc-p T) new-csartloc-vals
                                  (update-supsys-sublist-p T)  
                                  csartloc-n3-item  csartloc-rest-vals        
                                  (supsys-key :CSS)
                                  (qtype-key :QT)(qtype :qvar)
                                  sublist (sublist-key :S)  (clev 6)
                                  linktype (linktype-key :LNTP)
                                  change-csloc-p (make-new-csartloc-p T) 
                                  cs-categories info system BIPATH 
                                  ;;qvars not PCs- no poles?  pole1 pole2 
                                  ;;   bestpole rev-poles-p pclist
                                  to from wto wfrom clev  (clevkey :clev) 
                                  restkeys  
                                  (if-csym-exists :modify) ;;or :replace :modify
                                  (topdim "R")
                                  (separator *art-index-separator)
                                  (node-separator *art-node-separator)
                                  store-all-csyms-to-file-p 
                                  no-shaq-score-search-p
                                  no-csq-score-search-p
                                  (all-qvarlists *ALL-CSQ-QVARS)
                                  (all-questions-list *ALL-CSQ-QUESTIONS)
                                  (csq-data-list 
                                   (append *CSQ-DATA-LIST *SHAQ-ALL-DATA-LIST ))
                                  (shaq-all-data-list *SHAQ-ALL-DATA-LIST)
                                  (all-csyms-sym '*ALL-CSYMS) 
                                  (all-csartloc-syms-sym '*ALL-CSARTLOC-SYMS)
                                  (all-csartloc-syms&vals-sym '*ALL-CSARTLOC-SYMS&VALS)                                  ;;special (temp?) for adding tlink csyms
                                  (tlink-artlocsym '*new-tlink-artloc)
                                  selection-type ;;needed to sometimes over-ride given
                                  )
  "U-CS Makes a new csym [INCLUDES CSQ SCORES if available] from INPUT: original SHAQ-CSQ question  qvars (only stored in defining nested lists). Since these are used as part of CS Network for a user, includes score (:va) and rank (:RNK) if available.  RETURNS: If return-csym&csymvals-p, (values  csym1 csymvals1 qvar all-sublist-csyms csartloc-sym1 sublist-csartloc-syms)), (T (values  csym1 csymvals1 csartloc-sym1 csartloclist1 supsys1 supsys-vals1 qvar sublist-csartloc-syms)))
    csq-data-list is to find original shaq scores. Note: does NOT include PCs, Explore csyms, etc which were csyms created by other functions.
  NOTE: QVAR sym used as CSYM DEF--USE TO FIND QUESTION TEXT as def."
  (let*
      ((csym-str (format nil "~A~A" qvar-csym-prefix qvar))
       (csym (my-make-cs-symbol csym-str :prestr qvar-csym-prefix))
       (first-item)
       (multi-item-p)
       (qvar-str)(label)
       (q-num)(quest-sym)(q-ans-info)(q-ans-array)(q-datatype)
       (q-help)(reversed-item-p)(item-norm-or-rev)
       (sublist-csyms)
       (sublist-csartloc-syms)
       (all-sublist-csyms)
       ;;added for get-question-info
       (qvar-string)( q-title)(q-instr-out)(q-text-out)
       ( text-input-box1-instrs)(text-input-box2-instrs)
       (q-instr-list)(q-text-list)
       (ans-name-list)(ans-text-list)(ans-xdata-lists)(num-answers)
       (linktype1)(linktype2) (subsys)(sub-linktype1-list)(sub-linktype2-list)
       (ANSWER-QVARLISTS)
       (q-rel-score)(q-rel-score-str)
       (rank-score)
       ;;for multi-selection answers
       (multi-ans-val-pairs)
       (multi-ans-chkd-pairs) 
       ;;for text input answers
       (selection-type1)  ;;needed below
       (sub-supsys-csartloc (when supsys-csartloc
                              (my-make-cs-symbol (format nil "~A.~A" supsys-csartloc csym-str))))
       )
    (unless qvarlist-not-exist-p
      (cond
       (qvarlist 
        (setf first-item (second qvarlist)))
       (T
        (multiple-value-setq (first-item qvarlist)
            (get-keyvalue-in-nested-list  qvar all-qvarlists :return-value&keylist-p T))))
      ;;Is multi-item-p  or text?
      (cond
       ((and (listp first-item)
                 (member :multi-item first-item :test 'equal))
        (setf multi-item-p T
              selection-type :multiple))
       ((and (not (listp first-item))
                 (intersection '(:TEXT-INPUT :TEXT) qvarlist :test 'equal))
        (setf selection-type :TEXT-INPUT 
              qtype :TEXT))
       (T nil))
      ;;(break "first-item, qvarlist") 

      ;;STEP 1: GET QVAR VALUES
        (multiple-value-setq (qvar qvar-string csphrase q-title selection-type1 q-instr-out q-text-out   text-input-box1-instrs text-input-box2-instrs   q-instr-list  q-text-list    ans-name-list ans-text-list  ans-data-list ans-xdata-lists  num-answers    linktype1  linktype2 supsys1 subsys   sub-linktype1-list sub-linktype2-list ANSWER-QVARLISTS  reversed-item-p item-norm-or-rev qvarlist multi-item-p MULTI-ANS-VAL-PAIRS multi-ans-chkd-pairs)
            (GET-QUESTION-INFO qvar T :q-num q-num 
                               :GET-MULTISELECT-SCORES-P T
                               :all-questions-list all-questions-list :selection-type selection-type
                               :all-qvarlists all-qvarlists :qvarlist qvarlist
                               :quest-varlist quest-varlist :format-out-text-p NIL ))
        ;;(break "after get-question-info")

      ;;selection-type   HERENOW
      (unless selection-type
        (setf selection-type selection-type1))
      ;;(break "selection-type after get-question-info")

      ;;find csdef
      (cond
       ((and q-text-out (listp q-text-out))
        (setf csdef (car q-text-out)))
       (q-text-out 
        (setf csdef (car q-text-out))))
      ;;find csdata
      (cond
       (ans-data-list
        (setf csdata ans-data-list))
       (ans-xdata-lists
        (setf csdata ans-xdata-lists))
       (t nil))
      ;;end unless qvar-not-exist-p
      )
    ;;SUPSYS
    (when (and supsys (listp supsys))
      (setf supsys (make-list-symbol supsys)))
    (when (member selection-type '(:text :text-input) :test 'equal)
      (setf supsys (get-key-value *supsyskey qvarlist)))
    (cond
     (supsys nil)
     (supsys-csartloc (setf supsys (last1 (get-sym-dims supsys-csartloc))))
     (supsys1 (setf supsys supsys1))
     (T (setf supsys def-supsys)))
    ;;(break "before get ANS/SCORES & make-csym supsys")

    ;;special for check-box answers (puts qvar (eg UTPE) at end of supsys.
    #| SSSS CHECK ON THESE--NOT NEEDED?
     (when (equal selection-type :multiple-selection)
      (setf supsys (my-make-cs-symbol (format nil "~A.~A" supsys qvar))))|#

    ;;FIND SHAQ QVAR [not scale] SCORES?
    (unless (or (null csq-data-list) (null get-score-data-p) no-shaq-score-search-p)
      ;;PUT SCORES IN MAKE-CSYM-FROM SHAQ QUEST SCORES     
      ;;Do BEFORE recurse, so can use multi-select answers on each answer csym.
      (cond
       ;;SINGLE-SELECTION
       ((member selection-type '(:single :single-selection) :test 'equal)
      ;;SHAQ question relative score
      (multiple-value-setq (q-rel-score q-rel-score-str item-norm-or-rev)
          (get-csq-qvar-score&data qvar  :quests-scales-datalist shaq-all-data-list))
      ;;  (get-csq-qvar-score&data  'THM9SHAP)
      ;;Rank not used yet for SHAQ qvars (score value within group of score-range).
      ;; (setf rank (get-????    ))
      )
       ;;MULTIPLE-SELECTION
       ((member selection-type '(:multi :multiple-selection :multiple :QMA) :test 'equal)
            ;;not needed (member qtype '(:QMA)))
            (unless multi-ans-val-pairs
              (multiple-value-setq (multi-ans-val-pairs multi-ans-chkd-pairs 
                                                        ans-data-list)
                  (GET-MULTI-SELECT-ANSWERS qvar :csq-data-list csq-data-list)))
        (when multi-ans-val-pairs
          (setf ANS-DATA-LIST multi-ans-val-pairs))
        ;;(break "get ans-data-list?")
        )
       ;;TEXT INPUT ANSWERS
       ((member selection-type '(:TEXT-INPUT :TEXT))
                  ;;not in qvar list  (member qtype '(:TXT) :test 'equal)))
        (setf TEXT-INPUT   ;;not needed qvar-score-list)
            (get-csq-text-input csym))
        ;; eg (get-csq-text-input '<SEX)  =  "Male"  (<SEX "Male")
        ;;(break "get-csq-text-input")
        )
       (T NIL))
      ;;end unless
      )   
    ;;(break "before recurse")
    ;;RECURSE for subsys csyms IF ANS-NAME-LIST
    (when (and ans-name-list (listp ans-name-list))  ;;ans-text-list
      ;;(CATHOLIC JEWISH LATTERD BUDDHIST ISLAM BAPTIST METHODST EPISCOP LUTHERAN PRESBYTE PROLIBER PROFUNDA NOAFFIL AGNOSTIC OTHRNOAN)
      ;;MUST RESET SELECTION-TYPE to :CHECK-BOX-TYPE for ANS-NAME-LIST & ADD  MULTI-QUEST SYM AS A SUPSYS SYM
      ;;(break "before recurse on sublist")  ;;HERENOW PROBLEM
      (multiple-value-setq (sublist-csyms sublist-csartloc-syms) ;;all-sublist-csyms
          (make-csyms-from-qvars ans-name-list :supsys supsys ;;HERENOW
                                 :csartloc-origin :supsys-csartloc
                                 :supsys-csartloc sub-supsys-csartloc
                                 :selection-type :check-box-type
                                 :ans-data-list  ANS-DATA-LIST
                                 :text-input TEXT-INPUT
                                 :all-csartloc-syms-sym all-csartloc-syms-sym
                                 :all-csartloc-syms&vals-sym all-csartloc-syms&vals-sym))   
      (setf all-sublist-csyms (append all-sublist-csyms (list sublist-csyms)))
      ;;end when ans-name-list
      )
    ;;APPEND :S IN SUPSYS--or is this redundant??
    ;;not needed and supsys needs to be bound to work [may not be yet]
    #|(when (and supsys (boundp supsys))
      (set supsys (set-key-value :S all-sublist-csyms (eval supsys)
                                  :replace-old-value-p NIL
                                  :append-values-p T :set-listsym-to-newlist-p T
                                  :append-as-flatlist-p T :no-dupl-p T)))|#

    ;;SET OTHER CSYM ARGS
    ;;For csartloc
#| OLD   (when (null csartloc)
      (setf csartloc (make-list-symbol (list supsys csym))))|#
    ;;For csdef 
    ;;for answer-text csyms, csphrase is a condensed q-text
    ;;note: could use qvar sym used as csym def so can look up Q-TEXT as csde   
    (when (null csdef)
      (setf csdef (make-condensed-string q-text-out :max-length 100
                                         :word-separator " ")))
    ;;For csphrase
    (when (and (null csphrase) csdef)
      (setf csphrase (make-condensed-string csdef :cond-words-p T
                                            :max-length 25  :word-separator " ")))
    ;;For sublist
    (cond
     ((and sublist (null sublist-csyms)) NIL)
     ((and sublist sublist-csyms)
      (setf sublist (append sublist sublist-csyms)))
     (sublist-csyms
      (setf sublist sublist-csyms))
     (T nil))
    ;;(break)

    ;;For special cases
    (when (and (equal csartloc-origin :supsys-csartloc) (null supsys-csartloc)
               supsys)
      (setf supsys-csartloc supsys))
    ;;(break "supsys")
    ;;For individual answer qvars, use only that answer = QVAR&ANS
    ;;       otherwise use ANS-DATA-LIST
    (when qvar&ans
      (setf ans-data-list qvar&ans))
                                  
    ;;MAKE THE CSYM
    ;;(make-csym 'newcsym0 "new0" 'CS.loc1 "data" "def" :cs-categories '(cat1 cat2) :supsys '$BSK)
    ;;(break  "IN MAKE-QVAR-CSYM before make-csym") ;;NO :S QVARS
    (multiple-value-bind (csymvals1 csym1 csartloc-sym1 csartloclist1 
                                    supsys1 supsys-vals1 )
        (make-csym csym csphrase  csdata  csdef  
                   :if-csym-exists if-csym-exists :clev clev
                   :csartloc-origin csartloc-origin
                   :topdim topdim :dims dims :last-dim last-dim
                   :supsys supsys :def-supsys def-supsys :parents  parents  
                   :supsys-csartloc supsys-csartloc :new-csartloc new-csartloc 
                   :make-new-csartloc-p make-new-csartloc-p 
                   ;; :change-csloc-p change-csloc-p
                   :new-csartloc-vals new-csartloc-vals 
                   :update-supsys-sublist-p update-supsys-sublist-p
                   :csartloc-n3-item csartloc-n3-item
                   :csartloc-rest-vals csartloc-rest-vals
                   :sublist sublist-csyms
                   :supsys-key supsys-key   :sublist-key sublist-key
                   :value1 q-rel-score  ;; :value2 rank-score :value2key :RNK
                   :ans-data-list ans-data-list :text-input text-input
                   :qtype-key qtype-key :qtype qtype
                   :linktype linktype :linktype-key linktype-key
                   :cs-categories cs-categories :info info :system system 
                   :BIPATH BIPATH ;; :pole1 pole1 :pole2 pole2 :bestpole bestpole 
                   ;; :rev-poles-p rev-poles-p
                   :to  to :from from :wto wto :wfrom wfrom
                   :clev  clev  :clevkey clevkey 
                   :restkeys  restkeys  ;;  :pclist  pclist 
                   :dim-separator separator  :node-separator node-separator
                   :store-all-csyms-to-file-p store-all-csyms-to-file-p
                   :all-csyms-sym all-csyms-sym 
                   :all-csartloc-syms-sym all-csartloc-syms-sym
                   :all-csartloc-syms&vals-sym all-csartloc-syms&vals-sym 
                   ;;special (temp? for adding tlink csyms
                   :tlink-artlocsym tlink-artlocsym )
          ;;(break  "IN MAKE-QVAR-CSYM AFTER make-csym");;NO :S QVARS HERE
      (cond
       (return-csym&csymvals-p
        (values  csym1 csymvals1 qvar all-sublist-csyms csartloc-sym1 sublist-csartloc-syms))
       (T (values  csym1 csymvals1 qvar all-sublist-csyms csartloc-sym1 csartloclist1 supsys1 supsys-vals1 qvar  sublist-csartloc-syms)))
      ;;end mvb, let, make-csym-from-qvar
      )))
;;TEST
;;text qvar
;;   (make-csym-from-qvar 'age)
;;works= <AGE   ("<AGE" "Age" $BIO.<AGE NIL "Age" :QT :TEXT :CSS $BIO :TXT 78)   AGE  NIL  $BIO.<AGE  NIL
;;   (make-csym-from-qvar 'BIO4JOB)
;;works= <BIO4JOB
#|("<BIO4JOB" "b-Primary occupation" $MIS.<BIO4JOB (0 0 1 0 0 1 0 0 0 0 0 0 0) "Select ALL of the following that best describe your primary OCCUPATION. 
   => If you have multiple occupations, choose all of them." :QT :QVAR :CSS $MIS :ADAT (("student" NIL) ("manager" NIL) ("propeop" T) ("protech" NIL) ("consulta" NIL) ("educator" T) ("sales" NIL) ("technici" NIL) ("clerical" NIL) ("service" NIL) ("ownbus10" NIL) ("othrsfem" NIL) ("other" NIL)) :S (<STUDENT <MANAGER <PROPEOP <PROTECH <CONSULTA <EDUCATOR <SALES <TECHNICI <CLERICAL <SERVICE <OWNBUS10 <OTHRSFEM <OTHER))|#          
;;   BIO4JOB           
;; ((<STUDENT <MANAGER <PROPEOP <PROTECH <CONSULTA <EDUCATOR <SALES <TECHNICI <CLERICAL <SERVICE <OWNBUS10 <OTHRSFEM <OTHER))                     $MIS.<BIO4JOB
;; ($MIS.<STUDENT $MIS.<MANAGER $MIS.<PROPEOP $MIS.<PROTECH $MIS.<CONSULTA $MIS.<EDUCATOR $MIS.<SALES $MIS.<TECHNICI $MIS.<CLERICAL $MIS.<SERVICE $MIS.<OWNBUS10 $MIS.<OTHRSFEM $MIS.<OTHER)
;;Also answer csym:  <MANAGER = ("<MANAGER" "Manager/executive" $MIS.<MANAGER NIL "Manager/executive" :QT :QVAR :CSS $MIS :ADAT ("manager" NIL))
;;text qvar to csym
;; (make-csym-from-qvar 'AGE)
;; works= <AGE    ("<AGE" "Age" $BIO.<AGE NIL "Age" :QT :TEXT-INPUT :CSS $BIO :TXT 78)    AGE   NIL   $BIO.<AGE  NIL
;; a multi-choice answer qvar csym
;; (make-csym-from-qvar 'UTYPE)  
;; text csym
;; ;; (make-csym-from-qvar 'SEX)  
;; works= <SEX  = ("<SEX" "Sex 1=M 2=F" $BIO.<SEX NIL NIL :QT :TEXT-INPUT :CSS $BIO :TXT "Male")    SEX   NIL  $BIO.<SEX  NIL
;; (make-csym-from-qvar  'THM9SHAP :supsys-csartloc '$P.$CS.$EXC.$BV.$HISF.<ST1HIGHERSELF)
;; works= <THM9SHAP    ("<THM9SHAP" "ti-Self-happiness" $P.$CS.$EXC.$BV.$HISF.<ST1HIGHERSELF.<THM9SHAP NIL "SELF-HAPPINESS: Living the happiest life I can." :QT :QVAR :CSS <ST1HIGHERSELF :VA 1.0)    THM9SHAP  NIL  $P.$CS.$EXC.$BV.$HISF.<ST1HIGHERSELF.<THM9SHAP   NIL
;; (make-csym-from-qvar 'mlibart :supsys-csartloc nil)
;; works= <MLIBART    ("<MLIBART" "Lib Art major" $MIS.<MLIBART (NIL) "Liberal arts (a language, history, etc.)" :QT :QVAR :CSS $MIS)    MLIBART   NIL   $MIS.<MLIBART   NIL
;; (make-csym-from-qvar 'woventit :supsys-csartloc 'TOP.<SWORLDVIEW)
;; works= <WOVENTIT    ("<WOVENTIT" "wv-Not entitled to basic necessities" TOP.<SWORLDVIEW.<WOVENTIT NIL "I am entitled to the basic necessities of life such as good health care, good income, people caring for me, etc." :QT :QVAR :CSS $MIS :VA 0.42900002)    WOVENTIT   NIL   TOP.<WORLDVIEW.<WOVENTIT  NIL
;;also: TOP.<WORLDVIEW.<WOVENTIT = ("TOP.<WORLDVIEW.<WOVENTIT" (TOP <WORLDVIEW <WOVENTIT) NIL <WOVENTIT)

;;2020 for a MULTIPLE-SELECT SHAQ VAR
;; (make-csym-from-qvar 'UTYPE :supsys-csartloc '$CS.<BIO) = 
;;works=  [note: :ADAT is answers & scores list]
#|<UTYPE
("<UTYPE" "UserType" $CS.<BIO.<UTYPE (1 1 1 1 1 1 1 1 1 1 1 1 1 1) "  ==> FIND YOUR HAPPINESS QUOTIENT (HQ). 
         Research shows that 75% of people's overall happiness score is accounted for by the SHAQ HQ score (Stevens, 2009). Your HQ values, beliefs, and life skills may be powerful influences on your past, current, and future happiness. 
         HQ factors are CONTROLLABLE factors: you can choose to be happy by improving them. 
         ==> Why are you taking SHAQ?" :QT :QVAR :CSS <BIO :ADAT (("twanttho" T) ("tknowmor" NIL) ("twanthel" NIL) ("twantspe" NIL) ("texperie" NIL) ("tprevshaq" NIL) ("wantspq" NIL) ("tu100stu" NIL) ("tcsulbst" NIL) ("tcolstu" NIL) ("totherst" NIL) ("tressub" NIL) ("tcolfaca" NIL) ("u-none" NIL)) :S (<TWANTTHO <TKNOWMOR <TWANTHEL <TWANTSPE <TEXPERIE <TPREVSHAQ <WANTSPQ <TU100STU <TCSULBST <TCOLSTU <TOTHERST <TRESSUB <TCOLFACA <U-NONE))
UTYPE
((<TWANTTHO <TKNOWMOR <TWANTHEL <TWANTSPE <TEXPERIE <TPREVSHAQ <WANTSPQ <TU100STU <TCSULBST <TCOLSTU <TOTHERST <TRESSUB <TCOLFACA <U-NONE))
$CS.<BIO.<UTYPE
($CS.<BIO.<UTYPE.<TWANTTHO $CS.<BIO.<UTYPE.<TKNOWMOR $CS.<BIO.<UTYPE.<TWANTHEL $CS.<BIO.<UTYPE.<TWANTSPE $CS.<BIO.<UTYPE.<TEXPERIE $CS.<BIO.<UTYPE.<TPREVSHAQ $CS.<BIO.<UTYPE.<WANTSPQ $CS.<BIO.<UTYPE.<TU100STU $CS.<BIO.<UTYPE.<TCSULBST $CS.<BIO.<UTYPE.<TCOLSTU $CS.<BIO.<UTYPE.<TOTHERST $CS.<BIO.<UTYPE.<TRESSUB $CS.<BIO.<UTYPE.<TCOLFACA $CS.<BIO.<UTYPE.<U-NONE)
;;ALSO for sub csyms:
;; <TKNOWMOR =  ("<TKNOWMOR" "Want to under mysel bette" $CS.<BIO.<UTYPE.<TKNOWMOR NIL "Want to understand myself better." :QT :QVAR :CSS <BIO :ADAT ("tknowmor" NIL))  [note: :ADAT plus ans & score]
;; main <UTYPE csartloc
;; $CS.<BIO.<UTYPE  = ("$CS.<BIO.<UTYPE" ($CS <BIO <UTYPE) NIL <UTYPE)
;;sub csartlocs
;;  $CS.<BIO.<UTYPE.<TWANTSPE =  ("$CS.<BIO.<UTYPE.<TWANTSPE" ($CS <BIO <UTYPE <TWANTSPE) NIL <TWANTSPE)

|#
;;    (multiple-value-bind (new-csyms csartloc-syms all-sublist-csyms)
;;       (make-csyms-from-qvars '(UTYPE UGOALS BIO3EDUC BIO4JOB BI07LANG BIO1ETHN BIORELAF))
;; (make-csym-from-qvar 'BIORELAF)
;; (make-csym-from-qvar 'UTYPE)
;; works  
#|<UTYPE =  ("<UTYPE" "UserType" $MIS.<UTYPE (1 1 1 1 1 1 1 1 1 1 1 1 1 1) "  ==> FIND YOUR HAPPINESS QUOTIENT (HQ). 
         Research shows that 75% of people's overall happiness score is accounted for by the SHAQ HQ score (Stevens, 2009). Your HQ values, beliefs, and life skills may be powerful influences on your past, current, and future happiness. 
         HQ factors are CONTROLLABLE factors: you can choose to be happy by improving them. 
         ==> Why are you taking SHAQ?" :QT :QVAR :S (<TWANTTHO <TKNOWMOR <TWANTHEL <TWANTSPE <TEXPERIE <TPREVSHAQ <WANTSPQ <TU100STU <TCSULBST <TCOLSTU <TOTHERST <TRESSUB <TCOLFACA <U-NONE) :CSS $MIS)|#
;;also:  <TWANTHEL  =  ("<TWANTHEL" "t-Want help with problem" HQ.<TWANTHEL (NIL) "Want help with a general problem(s).    " :QT :QVAR :CSS HQ)
;; (make-csym-from-qvar 'UGOALS)

;;  (make-csym-from-qvar 'TB2RELAT)
;;works= <TB2RELAT   ("<TB2RELAT" "b2-RevNo absolute right--situational ethics" $MIS.<TB2RELAT NIL "There is no 'absolute' right and wrong or good or bad--it depends upon factors like your point of view, the situation, or one's cultural background." :QT :QVAR :CSS $MIS)   TB2RELAT   NIL
;;
;;for multi-item ANSWER made into a csym
;;  (make-csym-from-qvar "twanttho")
;;works= <TWANTTHO   ("<TWANTTHO" "t-Want thorough assessment" HQ.<TWANTTHO (NIL) "Want a thorough assessment and/or my Happiness Quotient (HQ) Score.                                 " :CSS HQ)  TWANTTHO  NIL
;;ALSO: <TWANTTHO = ("<TWANTTHO" "t-Want thorough assessment" HQ.<TWANTTHO (NIL) "Want a thorough assessment and/or my Happiness Quotient (HQ) Score.                                 " :CSS HQ)
;; And: HQ.<TWANTTHO  = ("HQ.<TWANTTHO" (HQ <TWANTTHO) NIL <TWANTTHO)
;; For single-selection SHAQ qvar
;; (make-csym-from-qvar 'smtbusy)
;; works = <SMTBUSY
#|("<SMTBUSY" "sm-Rarely upset about too rushed" $MIS.<SMTBUSY NIL "(I rarely get upset about being too rushed, having too many things to do, or not having any time to " :CSS $MIS)   SMTBUSY|#
;;ALSO:  <SMTBUSY = ("<SMTBUSY" "sm-Rarely upset about too rushed" $MIS.<SMTBUSY NIL "(I rarely get upset about being too rushed, having too many things to do, or not having any time to " :CSS $MIS)
;;ALSO: $MIS   = ERROR, SHOULD INCL $MIS, ETC  (:S (MOTHER FATHER BEST-M-FRIEND BEST-F-FRIEND M-DISLIKE F-DISLIKE M-ADMIRE F-ADMIRE PER-MOSTFUN PER-ROMANCE ROLE-MODEL CHILD-FRIEND CHILD-DISLIKE WORK-FRIEND WORK-PER-DISLIKE FAV-BOSS WORST-BOSS FAV-M-STAR FAV-POLITICO FAV-TEACHER FAV-SPIRITUAL DIS-TEACHER TEACHER POLICEMAN SALESPERSON DOCTOR LAWYER BUSINESS-OWNER MANAGER SCIENTIST FARMER DRUG-DEALER POLITICIAN DANCER ARTIST COMEDIAN ENGINEER HOUSE-CLEANER MOVIE-STAR ROCK-STAR CHURCH-MINISTER CATHOLICS PROTESTANTS JEWSX MUSLIMS BUDDHISTS ATHEISTS ANGLOS HISPANICS BLACKS ASIANS MOST-IMPORTANT-VALUE MOST-IMPORTANT-ABILITY MOST-IMPORTANT-BELIEF YOUR-PERSONALITY YOUR-BEST-CHARACTERISTIC YOUR-POSSESSIONS YOUR-WORST-CHARACTERISTIC JEWSX1 JEWSX6 JEWSX8 JEWSX7 JEWSX0 JEWSX2 JEWSX3 JEWSX5 JEWSX4 ISA WHY <SMTBUSY))
;;For multi-item SHAQ qvar
;; (make-csym-from-qvar 'utype)  ;;SSSSSS START HERE TESTING
;;works=  
;;csym= <UTYPE 
#|csymvals= ("<UTYPE" "UserType" $MIS.<UTYPE NIL "(  ==> FIND YOUR HAPPINESS QUOTIENT (HQ). 
         Research shows that 75% of people's overall happ" :S (<TWANTTHO <TKNOWMOR <TWANTHEL <TWANTSPE <TEXPERIE <TPREVSHAQ <WANTSPQ <TU100STU <TCSULBST <TCOLSTU <TOTHERST <TRESSUB <TCOLFACA <U-NONE) :CSS $MIS)      UTYPE|#
;;ALSO:
;;artsym=  $MIS.<UTYPE =  ("$MIS.<UTYPE" ($MIS <UTYPE) NIL <UTYPE)
;;subsym= <TRESSUB=  ("<TRESSUB" "Subje in a SHAQ resea pro" $MIS.<TRESSUB NIL "Subject  in a SHAQ research project." :CSS $MIS)






;;MAKE-CSYMS-FROM-QVARS
;;2020
;;ddd
(defun make-csyms-from-qvars (qvars &key csdata  csdef info  cs-categories  
                                    system bipath to from wto wfrom clev
                                    ans-data-list text-input (qvar-csym-prefix "<")
                                    (csartloc-origin :supsys-csartloc)
                                    (topdim '$SC) dims  supsys (def-supsys '$MIS) parents
                                    (last-dim :csym) supsys-csartloc   
                                    new-csartloc (make-new-csartloc-p T) new-csartloc-vals
                                    (update-supsys-sublist-p T)  
                                    csartloc-n3-item  csartloc-rest-vals   
                                    (supsys-key :css)  (sublist-key :s) 
                                    linktype (linktype-key :lntp) change-csloc-p 
                                    (make-new-csartloc-p t) (clevkey :clev) 
                                    restkeys (if-csym-exists :modify) (topdim "R")
                                    selection-type ;;used to override given values
                                    (qtype-key :QT) (qtype :QVAR)
                                    (separator *art-index-separator) 
                                    (node-separator *art-node-separator) 
                                    store-all-csyms-to-file-p no-csq-score-search-p
                                    (all-csyms-csym '*ALL-CSYMS)
                                    (pc-elm-key :PCSYM-ELM-LISTS)
                                    (shaq-qvar-key :SHAQ-DATA-LIST)
                                    (all-qvarlists *ALL-CSQ-QVARS) 
                                    (all-questions-list *ALL-CSQ-QUESTIONS) 
                                    (csq-data-list 
                                     (append *CSQ-DATA-LIST *SHAQ-ALL-DATA-LIST))
                                    (all-csyms-sym (quote *ALL-CSYMS))
                                    (all-csartloc-syms-sym '*ALL-CSARTLOC-SYMS)
                                    (all-csartloc-syms&vals-sym '*ALL-CSARTLOC-SYMS&VALS))
  "U-CS   RETURNS (values new-csyms csartloc-syms all-sublist-csyms)   INPUT: qvars from SHAQ or other lists of question qvars. "
  (let*
      ((new-csyms)
       (csartloc-syms)
       (all-sublist-csyms)
       )
    (unless (not (listp qvars))
      (loop
       for qvar in qvars
       for n from 0 to 1000
       do
       (let*
           ((csphrase)
            (csdef)
            (new-csym)
            (all-sublist-csyms)
            (csartloc-sym)
            (ans&data (nth n ans-data-list))
            (qvar&ans ans&data)
            )
         #|       (when answer-text-list
         (setf csdef (nth n answer-text-list)
               qvarlist-not-exist-p T))|#
       ;;(afout 'out (format nil "In make-csyms-from-qvars before make-c..qvar: ~% QVAR= ~A ans&data= ~A" qvar ans&data))
         (unless (or (null qvar)(equal qvar 'unbound-slot))
           (multiple-value-setq (new-csym csymvals1 qvar all-sublist-csyms
                                          csartloc-sym)
               ;;if all returned (new-csym csymvals1 csartloc-sym1 csartloclist1 supsys1 supsys-vals1 qvar)))
               (make-csym-from-qvar qvar :csphrase csphrase :csdata csdata
                                    :qvar&ans qvar&ans
                                    :ans-data-list ans-data-list :text-input text-input
                                    :csdef csdef 
                                    :csartloc-origin csartloc-origin
                                    :topdim topdim :dims dims :last-dim last-dim 
                                    :parents parents :supsys-csartloc supsys-csartloc
                                    :supsys NIL  :def-supsys def-supsys  ;;supsys caused errors?
                                    :new-csartloc new-csartloc
                                    :make-new-csartloc-p make-new-csartloc-p
                                    :update-supsys-sublist-p update-supsys-sublist-p
                                    :csartloc-n3-item csartloc-n3-item 
                                    :csartloc-rest-vals csartloc-rest-vals
                                    ;; :qvarlist-not-exist-p qvarlist-not-exist-p
                                    :return-csym&csymvals-p T :clev clev
                                    :selection-type selection-type
                                    :qvar-csym-prefix qvar-csym-prefix 
                                    :if-csym-exists if-csym-exists
                                    :qvar-csym-prefix qvar-csym-prefix
                                    :supsys-key supsys-key
                                    :qtype-key qtype-key :qtype qtype                                    
                                    :sublist-key sublist-key :linktype linktype
                                    :linktype-key linktype-key 
                                    :change-csloc-p change-csloc-p
                                    :cs-categories  cs-categories :info info :system system
                                    :bipath  bipath
                                    :to   to :from from :wto wto :wfrom wfrom
                                    :clev clev :clevkey clevkey 
                                    :restkeys restkeys :if-csym-exists if-csym-exists
                                    ;; :topdim topdim  :cur-csartdims  cur-csartdims 
                                    :separator separator  :node-separator node-separator
                                    :store-all-csyms-to-file-p store-all-csyms-to-file-p
                                    :no-csq-score-search-p no-csq-score-search-p
                                    :all-qvarlists  all-qvarlists  :all-questions-list  all-questions-list 
                                    :csq-data-list csq-data-list :all-csyms-sym all-csyms-sym
                                    :all-csartloc-syms-sym all-csartloc-syms-sym
                                    :all-csartloc-syms&vals-sym all-csartloc-syms&vals-sym
                                    )) 
           ;;ACCUMULATE
           (setf new-csyms (append new-csyms (list new-csym))                 
                 csartloc-syms (append csartloc-syms (list csartloc-sym)))
           ;;append global not nec, bec done in make-csym
           ;;FINISH WRITING AND TESTING make-csyms-from-qvars
           ;;  HOW TO GET LIST OF CSYMS FOR INPUT??
           ;;end unless,unless, let,loop
           ))))
    (values new-csyms csartloc-syms all-sublist-csyms)
    ;;end let, make-csyms-from-qvars
    ))
;;TEST
;; (make-csyms-from-qvars '(isa smtbusy utype))
;; (make-csyms-from-qvars '(TB2RELAT TB2PUNIS))

;;   (make-csyms-from-qvars '(UTYPE UGOALS BIO3EDUC BIO4JOB BI07LANG BIO1ETHN BIORELAF))
;;works=
;;new-csyms=  (<UTYPE <UGOALS <BIO3EDUC <BIO4JOB <BI07LANG <BIO1ETHN <BIORELAF)
;;csartloc-syms=  ($MIS.UTYPE.<UTYPE $MIS.UGOALS.<UGOALS $MIS.<BIO3EDUC $MIS.BIO4JOB.<BIO4JOB $MIS.BI07LANG.<BI07LANG $MIS.BIO1ETHN.<BIO1ETHN $MIS.BIORELAF.<BIORELAF)   NIL
;;also:  <BIO4JOB  = ("<BIO4JOB" "b-Primary occupation" $MIS.BIO4JOB.<BIO4JOB (1 1 1 1 1 1 1 1 1 1 1 1 1 1) "Select ALL of the following that best describe your primary OCCUPATION. 
;;also: $MIS.BIO4JOB.<BIO4JOB = ("$MIS.BIO4JOB.<BIO4JOB" ($MIS BIO4JOB <BIO4JOB) NIL <BIO4JOB)




;;MAKE-CUSTOM-CSYMS
;;2020
;;ddd
(defun make-custom-csyms (make-csyms-arglists &key (use-new-csartlocs-p T)
                                         supsys  (def-supsys '$CS) (if-csym-exists :replace)
                                         (csartloc-origin :supsys-csartloc)
                                         supsys-csartloc (get-text-input-p T)
                                         auto-art-dims  init-dims (csym-prestring "<")
                                         (get-user-value-p T)
                                         (user-all-data-list *SHAQ-ALL-DATA-LIST))
  "U-CS.  One csym-arglist item = '(csym bvphrase bvart-loc bvdata  bvdef   :info info :paths paths :default-bvart-rootstr default-bvart-rootstr :va value :valnth valnth
    :cur-bvart-dims cur-bvart-dims :separator separator :node-separator node-separator) Eg. (\"Sex\" \"Sec\" $BIO.<SEX :valnth 3). If a key in above is missing, then make-csym uses it's default value.  Unless bvart-loc, then it uses supsys, init-bvdims to assign the csym to a bvartsym. :VALNTH is the location of the USER ANSWER value.
  INPUT: MAKE-CSYMS-ARGLISTS can be mixed list of  lists and symbols/strings that eval to arglists.  
  Note: IF-CSYM-EXISTS OVERIDES make-csym default.
 SSSS INCLUDE OTHER CSYM ARGS LATER"
;;(MAKE-CSYM arglists: (csym csphrase csdata csdef &key (if-csym-exists :do-nothing) (csartloc-origin :supsys-csartloc) (topdim (quote $sc)) dims supsys (def-supsys (quote $mis)) parents (last-dim :csym) supsys-csartloc new-csartloc (make-new-csartloc-p t) new-csartloc-vals (update-supsys-sublist-p t) csartloc-n3-item csartloc-rest-vals (supsys-key :css) sublist (sublist-key :s) linktype (linktype-key :lntp) value1 value2 sd ETC.
;; eg: ("UserID" "User ID" NIL NIL  :supsys $BIO :csartloc-origin :supsys-csartloc :supsys-csartloc '$CS.$BIO  :value1 3)
  (let
      ((csyms)
       (csymvals)
       (old-csymvals)
       (csym)
       (dim1)
       (rest-dims (when auto-art-dims (cdr auto-art-dims))) ;;*cur-bvart-dims))
       (csartlocs)
       (csyms&vals-list)
       )   
    (loop
     for csym-arglist in make-csyms-arglists
     do
            ;;If stringp, make symbol
       (when (stringp csym-arglist)
         (setf csym-arglist (my-make-symbol csym-arglist))) 
       (let*
           ((csartloc-dims)
            (csartloc)
            (csym-str) 
            (csym)
            (valnth (get-key-value :valnth csym-arglist))
            (value)
            (txtinput)
            (new-csym-arglist csym-arglist)
            )
         (multiple-value-setq (csym-str csym )
             (make-string&symbol (car csym-arglist))) ;;no :prefix csym-prestring))
         ;;make initial make-csym-arglist
         (setf new-csym-arglist (append new-csym-arglist 
                                        (list :if-csym-exists if-csym-exists)))
         (when csym-prestring
           (setf new-csym-arglist (append new-csym-arglist 
                                             (list :prestr csym-prestring))))
         (when csartloc-origin
           (setf new-csym-arglist (append new-csym-arglist 
                                             (list :csartloc-origin csartloc-origin))))
         (when supsys-csartloc
           (setf new-csym-arglist (append new-csym-arglist 
                                             (list :supsys-csartloc  supsys-csartloc))))    
         (when supsys
           (setf new-csym-arglist (append new-csym-arglist 
                                          (list :supsys  supsys))))                                         
         ;;delete :valnth & number from csym-arglist [replace w/ :val and user-answer]

       (when valnth
          (setf new-csym-arglist
                 (get-set-append-delete-keyvalue :valnth :delete-key&value
                                                 :old-keylist csym-arglist)
 ;;  (get-set-append-delete-keyvalue :valnth :delete-key&value   :old-keylist  '("Nation" "Nation" NIL NIL :SUPSYS $BIO :VALNTH 3 :IF-CSYM-EXISTS :REPLACE :PRESTR "<" :CSARTLOC-ORIGIN :SUPSYS-CSARTLOC :VALUE1 "USA" :TXTINPUT "USA"))
           ;;GET USER VALUE FROM ALL-DATA-LIST?
           value   (get-keyvalue-in-nested-list (list (list csym-str T valnth)) user-all-data-list)
            new-csym-arglist (append new-csym-arglist (list :VALUE1 value)))
           ;;end when valnth
           )
         (when get-text-input-p
           (setf txtinput (get-csq-text-input csym-str)
                 new-csym-arglist (append new-csym-arglist (list :TXTINPUT txtinput))))
         ;;(break "new-csym-arglist")
         ;;MAKE NEW CSYM
         (multiple-value-setq (csymvals csym  csartloc)
             (apply #'make-csym  new-csym-arglist))
         ;;ACCUMULATE
         (setf csyms (append csyms (list csym))
               csartlocs (append csartlocs (list csartloc))
               csyms&vals-list (append1 csyms&vals-list  (list csym csymvals)))
         ;;end let, loop
         ))
    (values csyms csartlocs )
    ;;end mvb,let, make-custom-csyms
    ))
;;TEST
;; (csym bvphrase bvart-loc bvdata  bvdef   :info info :paths paths :default-bvart-rootstr default-bvart-rootstr :cur-bvart-dims cur-bvart-dims :separator separator :node-separator node-separator)
 ;; (make-custom-csyms '(("UserID" "User ID" NIL NIL  :supsys $BIO :csartloc-origin :supsys-csartloc :supsys-csartloc $CS.$BIO  :value1 3)))
;;works= (<USERID)   ($CS.$BIO.<USERID)
;;also: <USERID = ("<UserID" "User ID" $CS.$BIO.<USERID NIL NIL :CSS $BIO :VA 3 :TXT "555555")
;;also: $CS.$BIO.<USERID  = ("$CS.$BIO.<USERID" ($CS $BIO <USERID) NIL <USERID)
#|
 ;; (make-custom-csyms '(("Nation" "Nation" NIL NIL  :supsys $BIO  :valnth 3)))
;; works (including set user-answer): (<NATION) ($CS.<NATION)
;; ALSO: <NATION  = ("<Nation" "Nation" $CS.<NATION :VAL "USA" :CSS $CS)
;; and $CS.<NATION = ("$CS.<NATION" ($CS <NATION) NIL <NATION)
;;
 ;; (make-custom-csyms  '(("UserID" "User ID" $BIO.USERID :valnth 3)))
;; works= (<USERID)  ($CS.<USERID)
;;also: <USERID = ("<UserID" "User ID" $CS.<USERID :VAL "555555" :CSS $CS)
;;also:  $CS.<USERID = ("$CS.<USERID" ($CS <USERID) NIL <USERID)
;; misc egs.
  (make-custom-csyms 
   '((happy "happiness for all" nil (99) "Max happiness for self and others")
     (truth  "truth" nil  (90) "Max truth unless too harmful")
     (knowledge "knowledge" nil (90) "Max knowledge--especially important for top values")
     (self-development "self-development" nil (90) "Max self-development--esp meet top values")
     (integrity "integrity" nil (90) "Max integrity")
     (internal-control "internal control" nil (80) "Internal control by top values---close to integrity")
     (health "health" nil (90) "Physical health for all")
     ))
 ;;works= (<HAPPY <TRUTH <KNOWLEDGE <SELF-DEVELOPMENT <INTEGRITY <INTERNAL-CONTROL <HEALTH)
($CS.<HAPPY $CS.<TRUTH $CS.<KNOWLEDGE $CS.<SELF-DEVELOPMENT $CS.<INTEGRITY $CS.<INTERNAL-CONTROL $CS.<HEALTH)
;; also:   <TRUTH = ("<TRUTH" "truth" $CS.<TRUTH (90) "Max truth unless too harmful" :CSS $CS)
;; also:  > $CS.<TRUTH  =  ("$CS.<TRUTH" ($CS <TRUTH) NIL <TRUTH)
     |#










;;GET-QVAR-SINGLE-SELECT-VALUES
;;2020
;;ddd
(defun get-qvar-single-select-values (qvar  &key qvarlist selection-type
                                            (def-select-type :single-selection))
  "U-CS   RETURNS (values qvar-str phrase selection-type q-num quest-sym q-ans-info q-ans-array q-datatype  linktype1 linktype2 supsys sublist q-help  reversed-item-p item-norm-or-rev )   INPUT: qvarlist saves search. "
  (unless (symbolp qvar)
    (setf qvar (my-make-symbol qvar)))
  (unless qvarlist
    (cond
     ((boundp qvar)
      (setf qvarlist (eval qvar)))
     (T (setf qvarlist (get-qvarlist qvar)))))
  (let*
      ((qvar-str (car qvarlist))
       (phrase (second qvarlist))
       (q-sublist (fifth qvarlist))
       (q-num (second q-sublist))
       (quest-sym (third q-sublist))
       (q-datatype (fourth q-sublist))
       (q-ans-info (fifth q-sublist))
       (q-ans-array (sixth q-sublist))
       (q-ans-sym)
       (q-ans-symvals)
       (linktype1 (get-key-value :LNTP qvarlist))
       (linktype2 (get-key-value :LN2 qvarlist))
       (supsys (get-key-value :CSS qvarlist))
       (sublist (get-key-value :S qvarlist))       
       (q-help (get-key-list :help qvarlist))
       (reversed-item-p)
       (item-norm-or-rev)
       )
    ;;FIND SELECTION TYPE (needed for odd selection types)
    (setf selection-type (find-qvar-selection-type qvar :qvarlist qvarlist
                                                   :return-qvarlist NIL 
                                                   :return-qvarlist-p NIL `:non-nested-datalist-p NIL ))
    ;;SHAQ single-selection qvars do not specify selection-type
    (when (null selection-type)
      (setf selection-type def-select-type))
      
    ;;FIND ANSWER TEXT
    (cond
     ((stringp q-ans-info)
      (setf q-ans-sym (my-make-symbol q-ans-info))      
      (multiple-value-setq (instr-sym num-answers answers values)
          (get-answer-panel-info q-ans-sym))           
      )
     (T  NIL)) ;;what to use as default??

    ;;FIND REVERSED-ITEM-P 
    (when (and (stringp q-ans-info) (match-substring "reverse" q-ans-info))
      (setf reversed-item-p T))
    (multiple-value-setq (reversed-item-p item-norm-or-rev)
            (calc-is-quest-reversed qvar :answer-array q-ans-array)) ;;answer-array)    
    (values qvar-str phrase selection-type q-num quest-sym q-ans-info q-ans-array q-datatype  linktype1 linktype2 supsys sublist q-help  reversed-item-p item-norm-or-rev )
    ;;end let, get-qvar-single-select-values
    ))
;;EXAMPLE ( "smtbusy"  "sm-Rarely upset about too rushed"  "spss-match"  "smtBUSY"   ("smtBUSY" "13" "smtBUSYQ" "int" "LikeMe7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "bsSelfManagement.java")  (:help nil nil)   )
;;TEST
;; (get-qvar-single-select-values 'smtbusy)
;; works= "smtbusy"  "sm-Rarely upset about too rushed" :SINGLE-SELECTION  "13"  "smtBUSYQ"   "LikeMe7"   "questionInstancesArray"  "int"  NIL NIL NIL NIL NIL (:HELP NIL NORMAL-ITEM)




;;GET-ANSWER-PANEL-INFO
;;2020
;;ddd
(defun get-answer-panel-info (ans-info-sym)
  "U-CS   RETURNS (values  ans-info-list  ans-instrs  n-answers ans-text-list
       ans-data-list selection-type datatype scored-reverse-p  X  )  . "
  (when (stringp ans-info-sym)
    (setf ans-info-sym (my-make-symbol ans-info-sym)))
  (let*
      ((ans-info-list (when (boundp ans-info-sym) (eval ans-info-sym)))
       (ans-instrs)
       (n-answers)
       (ans-text-list)
       (ans-data-list)
       (selection-type)
       (datatype)
       (scored-reverse-p)
       (X)
       )
    ;;FIND FIRST LEVEL OF DATA
    (when (and ans-info-list (listp ans-info-list))
      (setf ans-instrs (car ans-info-list)
            n-answers (second ans-info-list)
            ans-text-list (third ans-info-list)
            ans-data-list (fourth ans-info-list)
            selection-type (fifth ans-info-list)
            datatype (sixth ans-info-list)
            scored-reverse-p (seventh  ans-info-list)
            X (eighth ans-info-list)))

    ;;EVAL THE SYMBOLS
    (when (symbolp ans-instrs)
      (setf ans-instrs (eval ans-instrs)))
    (when (symbolp ans-text-list)
      (setf ans-text-list (eval ans-text-list)))
    (when (symbolp ans-data-list)
      (setf ans-data-list (eval ans-data-list)))
     (values  ans-info-list  ans-instrs  n-answers ans-text-list
       ans-data-list selection-type  datatype scored-reverse-p  X 
       )
    ;;end let, get-answer-panel-info
    ))
;;TEST
;; (get-answer-panel-info "likeMe7")
;; works= 
;;ans-info-list= (LIKEME7INSTRUCTIONS 7 LIKEME7ANSWERARRAY VALUES7TO1ARRAY "single" "int")  
;;ans-instrs= "Accuracy/degree like you:"  n-answers= 7
;;ans-text-list= ("EXTREMELY accurate / like me" "MODERATELY accurate / like me" "MILDLY accurate / like me" "UNCERTAIN, neutral, or midpoint" "MILDLY inaccurate / unlike me" "MODERATELY inaccurate / unlike me" "EXTREMELY inaccurate / unlike me")
;;ans-data-list=  (7 6 5 4 3 2 1) 
;;selection-type-  "single"  datatype= "int"  scored-reverse-p= NIL  X=  NIL





;;GET-SCALE-INFO
;;2020
;;ddd
(defun get-scale-info (scale &optional (category T) 
                               &key scale-id
                               ;;FIX? these lists don't exist!!
                               (all-scales-list '*ALL-CSQ-SCALES)
                               (all-scalelists *ALL-CSQ-SCALES)
                               scalelist  quest-varlist is-answer-scale-p
                               (format-out-text-p T) add-instrs-p
                               text-input-box1-instrs text-input-box2-instrs
                               (eval-text-input-box-sym-p T))
  "In U-CS NOT-WORKING, FIX??   RETURNS: (values scale scale-string label q-title selection-type  q-instr-out q-text-out   text-input-box1-instrs text-input-box2-instrs   q-instr-list  q-text-list    ans-name-list ans-text-list  ans-data-list ans-xdata-lists  num-answers    linktype1  linktype2 supsys subsys   sub-linktype1-list sub-linktype2-list ANSWER-SCALELISTS  reversed-item-p item-norm-or-rev  scalelist multi-item-p)
   LIST of scale text from nested list--arg string or symbol, will also search for scale sym w/o Q if gets nil. 
  NOTE: Q-INSTR-LIST: First item= q-title [unless only 1 item in list, then= q-instr]  Second= q-instr  Q-INSTR can be a list (incl (FORMAT nil ... within) a string or a list with one or more symbols that should be evaluated to a STRING. 
   ADD-INSTRS-P: if stringp, inserts pre instrs, if T, inserts INSTRUCTIONS.
  UPDATED for CSQ. multi-item-p found automatically.
  SCALELIST prevents search in case of multi-item quests.
    NOT USED YET: sub-linktype1-list sub-linktype2-list"
  ;;2019 preprocess to get one list of scales
  (when (symbolp all-scales-list)
    (setf all-scales-list (eval all-scales-list)))

  (when (stringp scale)
    (setf scale (my-make-symbol scale)))

;;SSSSSS FINISH get-scale-info
  (let*
      ((scale-string (format nil "~A" scale))
       (s-text-name (format nil "~AQ" scale))
       (s-text-sym (my-make-cs-symbol s-text-name))
       (s-class-inst-name (format nil "*~A-inst" scale-string))
       (s-class-inst-sym (my-make-symbol s-class-inst-name))
       (s-class-inst (when (boundp s-class-inst-sym)
                            (eval s-class-inst-sym)))
       ;;quest-varlist is main scaleQ list of scale text info
       ;;works= (ISAQ ((FORMAT NIL "What kind(s) or type(s) is ~A?" *CS-EXPLORE-PHRASE)) CS-LINKTYPE-INSTR *MULTI-INPUT-BOX-INSTRS)  ETC
       ;; (get-set-append-delete-keyvalue-in-nested-list :get (list (list T 0) (list 'motherq  0 :R)
       ;;(multi-item-p) 
       ;;here66
       (selection-type)
       (s-label (get-slot-value s-class-inst 'label))
       (s-title (get-slot-value s-class-inst 'scale-name ))
       (s-data-name (get-slot-value s-class-inst 'data-name-string ))
       (s-instr)
       (s-instr-list)
;;primary-scale-label  s-title  primary-instr-text scale-id quest-text-list
       (n-instrs)
       (s-instr-sym)  ;;  s-instr-text  scale-id1  s-text-list 
       (s-text-list)
       (text-input-box-instrs-sym)
       (proc-s-instr-list)
       (proc-s-text-list)
       (s-instr-out)
       (s-text-list)
       (s-text-out)   
       (s-spss-name)
       (reversed-item-p)
       (item-norm-or-rev)
       ;;from ans-array-info, 
       (s-datatype)
#|       (ans-info-list)  
       (ans-instrs)    
       (ans-text-list )
       (ans-data-list) |#
       (num-answers )    
       ;;for multiple-selection 
#|       (scale-text)
       (instruction-text)|#
          ;;for get-main-scale-vars-p
       (linktype1)
       (linktype1)
       (sub-linktype1)
       (sub-linktype2)
       (supsys )
       (scale-category)
       (scale-id1)
       (primary-scale-sym)
       (primary-scale-label) ;;(primary-title-text)
       ;;(primary-instr-text)  ;;(quest-text-list)
       (ans-name-list)                            
       (ANSWER-SCALELISTS)
       (ans-xdata-list)
       (ans-xdata-lists)
       (sub-linktype1-list)(sub-linktype2-list)
       (supsys)(subsys)(help-info)(help-links)
       (primary-scale)( primary-scale-str) ;;USED ONLY FOR MVSETQ
       (test-result) ;;FIND AND EVAL? FUNCTION IN SCALE INFO
       )
    (unless quest-varlist
        (setf quest-varlist   (get-set-append-delete-keyvalue-in-nested-list :get  
                                                                       (list  (list s-text-sym  0 1))
                                                                       all-scales-list :return-nested-list-p NIL)))
#|     (when (or (null quest-varlist) (null (second quest-varlist))
               (member  'NO-QUEST-STRING-FOUND quest-varlist :test 'equal))
      (setf multi-item-p T
            selection-type :multiple-selection))|#
    ;;(break "quest-varlist")

    ;;STEP 1: GET TEXT INFO FROM THE QUEST-VARLIST (scaleQ list)
    ;;
    ;;eg (SMTBUSYQ    ("I rarely get upset about being too rushed, having too many things to do, or not having any time to relax.")   SM-INSTR  SMTBUSYQ)
    ;;also, (SM-INSTR     ("Self-Management Questions:" "Honest answers give you the most accurate results."))
    (cond
     ;;SSS FIND SCALE TEXT HERE
     (

      )
     ;;(multi-item-p NIL)
     ;;FOR NON MULTI-ITEM SCALES, use the *CSQ-SCALES FILE
     ;;  >> FOR ANSWER-PANEL TEXT, GO TO SCALE INFO SECTION
     #|((and quest-varlist (listp quest-varlist))
      (setf s-text-list (second quest-varlist)
            s-instr-sym (third quest-varlist)
            n-text-list (list-length s-text-list))

      ;;GET MAIN INSTRUCTIONS LIST
      (setf s-instr-list (get-keyvalue-in-nested-list
                          (list  (list s-instr-sym 0 1) ) 
                          all-scales-list :return-value&keylist-p T)) 

      ;;  *CS-EXPLORE-PHRASE = "GROUP KNOWLEDGE WORKER"

      ;;eg(CS-LINKTYPE-INSTR ("LINKS TO OTHER NODES" (format nil  "Associations with the word, class, concept, or instance \"~A.\" " *cs-explore-phrase)) )
      ;;FOR s-instr-list
      (setf proc-s-instr-list (process-text-list s-instr-list))
      ;;SET TO INSTR SYM
      (cond
       ((not (listp proc-s-instr-list))
        (setf s-instr-out proc-s-instr-list))
       ((> (list-length proc-s-instr-list) 1)
        (setf s-title (first proc-s-instr-list)
              s-instr-out (second proc-s-instr-list)))
       (t (setf  s-instr-out (car proc-s-instr-list))))
        ;(break)
      ;;FOR s-text-list
      (setf proc-s-text-list (process-text-list s-text-list))
      ;;SET TO TEXT-SYM
      (cond
       ((not (listp proc-s-text-list))
        (setf s-text-out proc-s-text-list))
       ((> (list-length proc-s-text-list) 1)
        (setf s-text-out (string-append* proc-s-text-list)))
       (t (setf  s-text-out (car proc-s-text-list))))
      ;;(break "new")

      ;;ADDED FOR CSQ (from SHAQ) 
      ;;following may no longer be needed bec of new process-text-list function
      (when (symbolp s-title)
        (setf s-title (eval s-title)))
      (when (and (symbolp s-instr) (null s-instr-out))
        (setf s-instr-out (eval s-instr)))
      #| REPLACED W/ get-quest-input-box-instrs
            (when (and eval-text-input-box-sym-p 
                 (symbolp text-input-box1-instrs)(boundp text-input-box1-instrs))
        (setf text-input-box1-instrs (eval text-input-box1-instrs)))
      (when (and eval-text-input-box-sym-p 
                 (symbolp text-input-box2-instrs)(boundp text-input-box2-instrs))
        (setf text-input-box2-instrs (eval text-input-box2-instrs)))|#
      ;;end listp quest-varlist
      )|#
     (t (setf s-text-list '("NO SCALE TEXT FOUND"))))
    ;;END GETTING SCALE TEXT INFO from *ALL-CSQ-SCALES

    ;;STEP 2: PROCESS THE SCALELIST for other variables--incl some TEXT.
    (cond
     ;;in case a scale (eg  PC) which evals to a scalelist
     ((and (symbolp scale)(boundp scale))
      (setf scalelist (eval scale)))
     ;;non-boundp scale list
     ((and (null scalelist) all-scalelists)
      (multiple-value-setq (instr-list scalelist )
          (get-keyvalue-in-nested-list scale all-scalelists  
                                       :return-value&keylist-p T)))
     ;;(get-keyvalue-in-nested-list (list (list 'smtbusy T)) *ALL-CSQ-SCALES :return-value&keylist-p T)
     ;;IF SCALE CLASS INST EXISTS, GET INFO FROM IT
     (s-class-inst

      )
     ;;otherwise use supplied scalelist arg
     (t NIL))
     ;;(break "scalelist")

    ;;FOR SINGLE-SELECTION QUESTS
    ;;   >> ALSO GET ANSWER TEXT FROM SCALE  ANSWER-PANELS
    #|(cond
     ((not multi-item-p)
      ;;(value scale-str phrase (LABEL) selection-type scale-id quest-sym s-ans-info s-ans-array s-datatype reversed-item-p linktype1 linktype2 supsys sublist s-help  reversed-item-p item-norm-or-rev )
      (multiple-value-setq (scale-str label selection-type scale-id quest-sym s-ans-info s-ans-array s-datatype  linktype1 linktype2 supsys sublist s-help  reversed-item-p item-norm-or-rev )
          (get-scale-single-select-values scale :scalelist scalelist))

#|(defparameter *input-box-instrs  '("Type answer in BOX below:") "For instructions inside the text-input-pane")
 (defparameter *multi-input-box-instrs  '|#
      ;;GET THE ANSWER TEXT INFO
      (multiple-value-setq (ans-info-list  ans-instrs  num-answers ans-text-list
                                           ans-data-list)  
          (get-answer-panel-info s-ans-info)) 

      ;;GET-QUEST-INPUT-BOX-INSTRS
      (multiple-value-setq (text-input-box1-instrs text-input-box2-instrs)
          (get-quest-input-box-instrs scale :selection-type selection-type :quest-varlist
                                      quest-varlist))
      ;;end single-selection = not multi-item
      )
     ;;FOR MULTI-ITEM QUESTS
     ((or multi-item-p (and (null s-text-out)(null s-instr-out)))
      ;;here66
      ;;(break "before multi-item")

      (cond
       ;;IS-ANSWER-SCALE-P? Answer scale is an answer from multi-item scale made to csym.
       ((and (not (listp (second scalelist))) (member  :multi-item scalelist :test 'equal))
        (setf is-answer-scale-p T)
        ;;eg ( "twanttho"   "t-Want thorough assessment"  "spss-match"  NIL  ("Want a thorough assessment and/or my Happiness Quotient (HQ) Score.")  (:help nil nil)  :MULTI-ITEM  (:XDATA :scales (HQ))   )
        (setf label (second scalelist))
        (cond ((listp (fifth scalelist))
               (setf s-text-out (format-string-list (fifth scalelist))))
              (T (setf s-text-out (fifth scalelist))))
        ;;for xdata
        (setf  ans-xdata-list (get-keyvalue-in-nested-list '((:xdata T)) scalelist :return-list-p T)
               supsys (get-key-value :scales ans-xdata-list)
               ans-xdata-lists (list ans-data-list))
        )
       ;;FOR REQULAR MULTI-ITEM SCALES with multple answers
       (T      
        (setf *scale-category  scale-string)  

        ;;GET MULTI-ITEM VARS & TEXT
        ;;orig output (values scale-str phrase scale-id quest-sym s-ans-info s-ans-array s-datatype reversed-item-p linktype1 linktype2 supsys sublist s-help  reversed-item-p item-norm-or-rev )  here88
        #|(multiple-value-setq (primary-scale scale-string  label  
                                           s-title  s-instr-list scale-id s-text-list selection-type
                                           s-spss-name  ans-name-list  ans-text-list   num-answers 
                                           ANSWER-SCALELISTS s-datatype    ans-data-list   ans-xdata-lists 
                                           linktype1 linktype2 sub-linktype1 sub-linktype2
                                           supsys sublist   help-info help-links )  
            (get-multi-select-scale-values scale-string :scalelist scalelist ))|#
        ;;(break)
        #|  ;;added 2020 ;;here88  SSSSSS FINISH MAKING NEW LINK CSYM
      ;;NO?? HAP, CAR, etc are STANDARD ANSWERS--NOT USER DEFINED
         (when (and make-link-answer-sym-p 
                      (not (boundp (my-make-symbol (car answer-array-list)))))
             (dolist (ans answer-array-list)
               (let* ((str (make-condensed-str ans))
                      (list (list str ans :lntp linktype))
                      (sym (my-make-symbol str))
                      )                 
                 (make-csym sym ans (list sym) nil nil :supsys supsys :lntp linktype)
             ;;end let,dolist, when make-link-answer-sym-p
             )))|#
        ;;(break "multiple-selection vars ans-text-list quest-text-list instruction-text")
        (when (null instruction-text) (setf instruction-text ""))
        (when  (null s-text-list) (setf s-text-list '("")))
  
        ;;SCALE NUMBER
        (cond
         (scale-id (setf pre-selected-num scale-id))
         (T (setf pre-selected-num scale-id1)))

        ;;FOR COMPATIBILITY with vertical-buttons, single-selection, etc.REPLACE ABOVE?
        (setf ans-instruction-text "Select ALL that apply to you")

        ;;(afout 'out (format nil "*multi-selection-scalelist ~A~% ans-text-list=~A~%" *multi-selection-scalelist ans-text-list))

        ;;END MULTIPLE-SELECTION TYPE
        )))
       (t NIL))|#
    ;;(break "After multi-item")
    #|(defparameter  LikeMe7Reverse   
    '(LikeMe7Instructions  7 LikeMe7AnswerArray  Values1to7Array  "single"  "int"  T  NIL))|#
    ;;(break "end")

    ;;FORMAT TEXT-OUT?
    (cond
     (format-out-text-p
      (setf s-text-out (format-string-list s-text-list  :add-newlines 1)) ;;WAS  ;;was print-list  :no-newline-p t))
      ;;(break "formated-qtext")
      ;;add the scale instructions?
      (when add-instrs-p 
       (cond
         ((stringp add-instrs-p)
          (setf s-text-out
              (format nil  "~A~%   ~A ~A" format-out-text-p add-instrs-p s-instr )))
         (T
        (setf s-text-out
              (format nil  "~A~%   INSTRUCTIONS: ~A" format-out-text-p s-instr )))))

      ;;s-instr-list to s-instr-out 
      (unless (and s-instr-list (listp s-instr-list))
                     (setf s-instr-list (list s-instr-list)))
      (cond
       (s-instr-out NIL)
       ((and (null s-instr-out) s-instr-list)
        (setf s-instr-out (format-string-list s-instr-list :add-newlines 0)))
                                ;;was (print-list :no-newline-p t)))
       (T (setf s-instr-out s-instr-list)))
      ;;(break "s-instr-out")
      ;;end format-out-text-p
      )
     (T
      (when  scale-text 
        (setf s-text-out scale-text))
      (when (and s-text-list (null s-text-out))
        (setf s-text-out s-text-list))
      (when (not (listp s-text-out))
        (setf s-text-out (list s-text-out)))
     (cond
      ((and s-instr-list (listp s-instr-list))
       (setf s-instr-out s-instr-list))
      (t (setf s-instr-out s-instr-list)))))

    (when (null item-norm-or-rev)
      (setf item-norm-or-rev 'NORMAL-ITEM))

   ;;
    (values scale scale-string s-label s-title selection-type  s-instr-out s-text-out  
            text-input-box1-instrs text-input-box2-instrs
            s-instr-list  s-text-list     
            ans-name-list ans-text-list   ans-data-list  ans-xdata-lists  num-answers
            linktype1  linktype2 supsys subsys
            sub-linktype1 sub-linktype2 ANSWER-SCALELISTS 
            reversed-item-p item-norm-or-rev scalelist multi-item-p )
    ;;end get-scale-info
    ))
;; (get-scale-info 'sworldvieiw)


;;TO FIND SCALE QUESTION QVARS ------------------------------

;;FIND-QVARS-FOR-SCALE 
;;
;;ddd
(defun find-qvars-for-scale (all-qvarlist scale-sym)
  "In U-CS RETURNS: (values qvars quests num-qvar-Qs num-qs)
   Eg. (find-qvars-for-scale *all-pc-elements 'pce-people)"
  (let
      ((target-scale-list)
       (qvar)
       (quest)
       (qnum)
       (qvars)
       (quests)
       (quest-str)
       (quest-strs)
       (num-qs 0)
       (num-qvar-Qs)
       )
    ;;FIND TARGET-SCALE-LIST
    (loop
     for scale-list in all-qvarlist
     do
     (when (equal (car scale-list) scale-sym)
       (setf target-scale-list scale-list)
       (return))
     )
    
    (loop
     for item in target-scale-list
     do
     (when (listp item)
       (incf num-qs)
       (setf qvar-str (car item)
             qvar (my-make-symbol qvar-str)
             in-list (fifth item))
       (when (listp in-list)
         (setf qnum (my-make-symbol (second in-list))
               quest-str (third in-list)
               quest (my-make-symbol quest-str)))
       (setf qvars (append qvars (list qvar))
             quests (append quests (list quest))
             quest-strs (append quest-strs (list quest-str))
             num-qvar-Qs (append num-qvar-Qs (list (list qvar qnum qvar-str quest))))
       ;;end outer when
       )
     ;;end loop
     )
    (values qvars quests num-qvar-Qs num-qs)
    ;;let, find-qvars-for-scale
    ))
;;TEST
;; USE DATA IN SCALES BELOW
#|CL-USER 32 > (find-qvars-for-scale *all-pc-elements 'pce-people)
(MOTHER FATHER BEST-M-FRIEND BEST-F-FRIEND M-DISLIKE F-DISLIKE M-ADMIRE F-ADMIRE PER-MOSTFUN PER-ROMANCE ROLE-MODEL CHILD-FRIEND CHILD-DISLIKE WORK-FRIEND WORK-PER-DISLIKE FAV-BOSS WORST-BOSS FAV-M-STAR FAV-POLITICO FAV-TEACHER WORST-BOSS FAV-SPIRITUAL DIS-TEACHER)
(MOTHERQ FATHERQ BEST-M-FRIENDQ BEST-F-FRIENDQ M-DISLIKEQ F-DISLIKEQ M-ADMIREQ F-ADMIREQ PER-MOSTFUNQ PER-ROMANCEQ ROLE-MODELQ CHILD-FRIENDQ CHILD-DISLIKEQ WORK-FRIENDQ WORK-PER-DISLIKEQ FAV-BOSSQ WORST-BOSSQ FAV-M-STARQ FAV-POLITICOQ FAV-TEACHERQ WORST-BOSSQ FAV-SPIRITUALQ DIS-TEACHERQ)
((MOTHER 1 "mother" MOTHERQ) (FATHER 2 "father" FATHERQ) (BEST-M-FRIEND 3 "best-m-friend" BEST-M-FRIENDQ) (BEST-F-FRIEND 4 "best-f-friend" BEST-F-FRIENDQ) (M-DISLIKE 5 "m-dislike" M-DISLIKEQ) (F-DISLIKE 6 "f-dislike" F-DISLIKEQ) (M-ADMIRE 7 "m-admire" M-ADMIREQ) (F-ADMIRE 8 "f-admire" F-ADMIREQ) (PER-MOSTFUN 9 "per-mostfun" PER-MOSTFUNQ) (PER-ROMANCE 10 "per-romance" PER-ROMANCEQ) (ROLE-MODEL 11 "role-model" ROLE-MODELQ) (CHILD-FRIEND 12 "child-friend" CHILD-FRIENDQ) (CHILD-DISLIKE 13 "child-dislike" CHILD-DISLIKEQ) (WORK-FRIEND 14 "work-friend" WORK-FRIENDQ) (WORK-PER-DISLIKE 15 "work-per-dislike" WORK-PER-DISLIKEQ) (FAV-BOSS 16 "fav-boss" FAV-BOSSQ) (WORST-BOSS 17 "worst-boss" WORST-BOSSQ) (FAV-M-STAR 18 "fav-m-star" FAV-M-STARQ) (FAV-POLITICO 19 "fav-politico" FAV-POLITICOQ) (FAV-TEACHER 20 "fav-teacher" FAV-TEACHERQ) (WORST-BOSS 21 "worst-boss" WORST-BOSSQ) (FAV-SPIRITUAL 22 "fav-spiritual" FAV-SPIRITUALQ) (DIS-TEACHER 23 "dis-teacher" DIS-TEACHERQ))
23|#






;;MAKE-QVARS-FROM-SYMLIST
;;moved from csq-qvars
;;
;;ddd
(defun make-qvars-from-symlist (symlist-in-cats &key (sym-is-car-p T) (text-type "single-text") (qtype "$KNW"))
  "U-CS.lisp  From a list of sym names makes a new list of qvars by category"
  (let
      ((all-new-qvars)
       (pp-output)
       )
    (loop
     for cat in symlist-in-cats
     do
     (let*
         ((catsym (car cat))
          (symlistS (cdr cat))
          (n-syms (list-length symlistS))
          (new-qvars)
          )
    (loop
     for item in symlists
     for n from 1 to n-syms
     do
     (let
         ((sym)
          (qlist)
          )
     (cond
      (sym-is-car-p
       (setf sym (car item)))
      (t (setf sym item)))
  
     ;;make the new qvar and add to new-qvars
     (setf symstr (format nil "~A" sym)
           symq (format NIL "~AQ" symstr)
         qlist (list symstr symstr text-type (list symstr (format nil "~A" n)
                       symq qtype qtype))
         new-qvars (append new-qvars (list qlist)))
    ;; (break "item")
     ;;end inner let,loop
     ))
     (setf all-new-qvars (append all-new-qvars (append (list (list  catsym) new-qvars))))
     ;;end outer let,loop
     ))
    (loop
     for list in all-new-qvars
     do
     (loop
      for item in list
      do
      (print item)
      ))
    all-new-qvars
    ;;end let, make-qvars-from-symlist
    ))
;;TEST
;;SSSSS START TEST HERE make-qvars-from-symlist
;; (make-qvars-from-symlist *MAKE-QVARS)
;;works, prints lists of new qvars (must add parens at both ends)
;;returns all-new-qvars



;;STORE-CS-SYMS&SYMVALS
;;store-syms&evaled-syms-moved to u-files [REVISE IT WITH BELOW CHANGES]
;;2020
;;ddd
(defun store-cs-syms&symvals (filename  &key PPRINT-P 
                                        ;;file-path args
                                         (dir "C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\") 
                                         (use-dated-path-p T) (incl-time-p T)
                                         (append-filename-begin "2-TOM-") append-filename-end      
                                         ;;what to print
                                         (file-head-message 
                                          ";;TOM ALL STORED CSYMS & CSYM-VALS - NEW DATA")
                                         (pre-listsyms-sym-str "*file-")
                                         ;;eval the syms & nth sym? [or done in listsyms?]
                                         (eval-syms-p T) ;;not needed if incl already syms&vals listsyms
                                         eval-nth-in-symlist ;; 2) not needed if incl csartlocs & vals
                                         ;;accumulate?
                                         accumulate-all-syms&vals-p
                                         accumulate-all-lists-p ;;not if incl *ALL-CSYMS 
                                         ;;input listsyms
                                         (listsyms-sym '*ALL-CSYMS-LIST-SYMS)
                                         (listsyms  '(
                                                     *ALL-ELMSYMS  ;;*ALL-ELMSYMS&VALS
                                                     *ALL-PCSYMS ;;*ALL-PCSYMS&VALS
                                                     *ALL-MAKE-CSYMS  ;;*ALL-CSYMS&VALS
                                                     *ALL-MAKE-CSARTLOC-SYMS 
                                                     ;;*ALL-CSARTLOC-SYMS&VALS
                                                     ))
                                         (if-file-exists :overwrite)
                                         )
  "U-CS Prints objects, evaled syms, and evaled nth syms to filename. 
   REMOVES DUPLICATE CSYMs & evals them to make SYM&VALS lists to store.
   RETURNS: (values listsyms all-syms all-syms&vals all-listsym-nth-syms all-listsym-nth-syms&vals pathname). Set dir to NIL if FULL pathname.
   [Eval args: EVAL-SYMS-P EVAL-NTH-IN-SYMLIST = 2? or done in listsym syms&vals lists?] NOTE: "
  ;;prevent pre-listsyms-sym-str = nil
  (unless pre-listsyms-sym-str 
    (setf pre-listsyms-sym-str ""))

  (let*
      ((pathname (make-dated-pathname filename :root dir 
                                      :append-begin append-filename-begin
                                      :append-end append-filename-end :file-ext ".lisp"
                                      :incl-time-p incl-time-p
                                      :no-date-p (not use-dated-path-p)))
       (date (date-string))
       (all-syms)
       (all-syms&vals)
       (all-listsym-nth-syms)
       (all-listsym-nth-syms&vals)
       )
    (when (null dir)
      (setf dir ""))
    
    (with-open-file (instr pathname :direction :output :if-does-not-exist :create 
                           :if-exists if-file-exists)
      ;;PRINT FILE INTRO
      (format nil "~A~%  ;;DATE: ~A~%" file-head-message date)

      ;;LOOP THRU LISTSYMS-SYMS-for each BIGLIST
      (loop
       for listsym in listsyms ;;eg. *ALL-CSYMS
       do
       ;;in case listsym is a list with sym as first item
       (when (listp listsym)
         (setf listsym (car listsym)))
       (when (boundp listsym)
         (let*
             ((listsym-syms (remove-duplicates (eval-sym listsym))) ;;REMOVES DUPLS
              (listsym-syms&vals)
              (listsym-nth-syms)
              (listsym-nth-syms&vals)
              )
           ;;FOR EACH SYM, LIST SYM & EVALED SYM = symvals
           (loop
            for sym in listsym-syms ;;eg. MOTHER
            do
            (let*
                ((symvals (eval-sym sym))
                 (sym&symvals (when eval-syms-p (list sym symvals)))
                 (nth-sym)
                 (nth-evaled-symvals)
                 )
              (when eval-nth-in-symlist
                (setf NTH-SYM (nth eval-nth-in-symlist symvals))
                (cond
                 ((and (symbolp nth-sym)(boundp nth-sym))
                  (setf NTH-EVALED-SYMVALS  (list nth-sym (eval nth-sym))))
                 (T (setf nth-evaled-symvals  (list nth-sym)))))
                ;;(break "when eval-nth-in-symlist")    

              ;;ACCUMULATE LISTSYM LISTS eg. listsym-sym = *all-elmsyms
              (setf listsym-syms&vals (append listsym-syms&vals (list sym&symvals)))
              ;;FOR EVAL-NTH-IN-SYMLIST
              (when NTH-SYM
                      listsym-nth-syms (append listsym-nth-syms (list nth-sym))
                      listsym-nth-syms&vals (append listsym-nth-syms&vals 
                                                          (list (list nth-sym nth-evaled-symvals))))        
              ;;end let,loop
              ))          
           ;;ACCUMULATE ALL LISTSYM SYMS & SYMVALS
           (setf all-syms (append all-syms listsym-syms)
                 all-listsym-nth-syms (append all-listsym-nth-syms
                                              (list (list listsym listsym-nth-syms))))     
           (when accumulate-all-syms&vals-p
             (setf  all-syms&vals (append all-syms&vals 
                                              (list (list listsym listsym-syms&vals)))
                    all-listsym-nth-syms&vals (append all-listsym-nth-syms&vals
                                                            (list (list listsym listsym-nth-syms&vals)))))
              ;;WRITE TO THE FILE for each LISTSYM (syms and syms&vals-lists)
              #|            (cond
             (pprint-p
              (format instr "~A~%  ;;DATE: ~A   PPRINTED LISTS:" 
                      file-head-message date)
              (format instr ";;ALL SYMS:~%  (setf ~A " symlist-sym)
              (princ " '" instr) (pprint all-biglists instr)
              (format instr "~%;;ALL SYM-SYMLISTS:~%  (setf ~A" evaled-sym-sym)
              (princ " '" instr) (pprint all-sym&val-lists instr)
              (format instr "~%;;ALL SYMS:~%  (setf ~A" evaled-nth-sym)
              (princ " '" instr)  (pprint all-nth-evaled-lists instr))
             (T      |#
           (cond
            (eval-syms-p
             ;; created in this function all-syms&vals all-listsym-nth-syms&vals 
             (cond
              (nth-sym
             (format instr 
                     ";;xxx ====================== ~A =====================
    ;;ALL ~A SYMS:
    (setf ~A~A '~A) ~%
   ;;ALL ~A SYM&VALS: 
    (setf ~A~A-SYMS&VALS '~S) ~%
    ;;FOR LISTSYM: ~A, EVALED-NTH-SYM= ~A SYM&VALS LISTS
    (setf ~A-~A-LISTSYM-NTH-SYMS&VALS  '~S) 
    " listsym   
                     listsym
                     pre-listsyms-sym-str listsym    listsym-syms    
                     listsym
                     pre-listsyms-sym-str listsym    listsym-syms&vals 
                     listsym eval-nth-in-symlist
                     pre-listsyms-sym-str eval-nth-in-symlist listsym-nth-syms&vals )
             )
              ;;not nth-sym
              (T
               (format instr 
                     ";;xxx ====================== ~A =====================
    ;;ALL ~A SYMS:
    (setf ~A~A '~A) ~%
   ;;ALL ~A SYM&VALS: 
    (setf ~A~A-SYMS&VALS '~S) ~%

    ;;FOR LISTSYM: ~A, EVALED-NTH-SYM= ~A SYM&VALS LISTS
    (setf ~A-~A-LISTSYM-NTH-SYMS&VALS  '~S) 
    " listsym   
                     listsym
                     pre-listsyms-sym-str listsym    listsym-syms    
                     listsym
                     pre-listsyms-sym-str listsym    listsym-syms&vals)
               ;;end no nth-sym, cond
               ))
             ;;end eval-syms-p
             )
            ;;not eval syms
            (T
             (format instr 
                     ";;xxx ====================== ~A =====================
;;ALL ~A SYMS:
    (setf ~A~A '~A) ~%
    " listsym listsym  pre-listsyms-sym-str  listsym listsym-syms)
       ;;end T,cond
            ))
           ;;end when boundp, let,loop
           )))

       (when accumulate-all-lists-p
         (format instr "~% ;;>> ACCUMULATIVE LISTS: 
         ;;>> ALL-LISTSYMS:
         (setf ~A~A  '~A)~%
         ;;>> ALL-SYMS:
         (setf ~AALL-FILE-SYMS '~A)
         ;;>> ALL NTH-SYMS
         (setf ~AALL-NTH=~A-SYMS '~A)

         " pre-listsyms-sym-str listsyms-sym LISTSYMS 
                 pre-listsyms-sym-str   ALL-SYMS
                 pre-listsyms-sym-str  eval-nth-in-symlist   ALL-LISTSYM-NTH-SYMS)

         (format instr "
        ;;>> ACCUMULATIVE SYM&SYMVAL LISTS~%
         ;;>> ALL-SYM&VAL-LISTS
         (setf ~AALL-SYM&VAL-LISTS  '~A)~%
         ;;>>ALL-LISTSYM-NTH-EVALED-SYM&VALS [Nth= ~A]:
         (setf ~AALL-LISTSYM-NTH-SYMS&VALS '~A)~%
         "   pre-listsyms-sym-str  eval-nth-in-symlist    ALL-SYMS&VALS
                 eval-nth-in-symlist
                 pre-listsyms-sym-str    ALL-LISTSYM-NTH-SYMS&VALS))
      ;;end with-open
      )
    (values listsyms all-syms all-syms&vals 
            all-listsym-nth-syms all-listsym-nth-syms&vals
            pathname)
    ;;end let, store-syms&evaled-syms
    ))
;;TEST
;; (store-cs-syms&symvals "1-test-store-syms-test-1.lisp")
;; (store-cs-syms&symvals "TOM-new-CSYMS-VALS.LISP" )
;;FOR EVALING when not accumulated in make-csq-csyms:  eval-syms-p eval-nth-in-symlist ;
;; (store-cs-syms&symvals "1-TOM-evaled-CSYMS-VALS.LISP"  :eval-syms-p T :eval-nth-in-symlist 2 :listsyms  '(*ALL-ELMSYMS *ALL-PCSYMS *ALL-CSARTLOC-SYMS  *ALL-CSYMS))      
;;PROBLEMS:   $TBV.PROGRESSIVE.PROGRESSIVE, $TBV.PLAYFUL.PLAYFUL
;; note: $ELM.FAV-TEACHER ok
;;However they are listed in all-csartloc-syms (eg $ELM.MOTHER)

;;CSARTLOCS in ELMs & PCS (eg $ELM.MOTHER.MOTHER  $TBV.HIGHSTATUS.HIGHSTATUS, $TBV.GREEDY.GREEDY, but double last sym.

   ;;ALL *ALL-CSARTLOC-SYMS SYM&VALS: 
;;==> *file-*ALL-CSARTLOC-SYMS-SYMS&VALS included *all-elmsyms
    ;;(setf *file-*ALL-CSARTLOC-SYMS-SYMS&VALS '((*ALL-ELMSYMS ((MOTHER ("MOTHER" "mother" $ELM.MOTHER.MOTHER NIL NIL :BIPATH (((MOTHER NIL (CAREFOROTHERS (POLE1) NIL))) ((MOTHER NIL (INTIMATE (POLE1) NIL))) ((MOTHER NIL (FLEXIBLE (POLE1) NIL))) ((MOTHER NIL (CASUAL (POLE1) NIL))) ((MOTHER NIL (EGOTISTICAL (POLE2) NIL))) ((MOTHER NIL (EXUBERANT (POLE2) NIL))) ((MOTHER NIL (NOTTHEORIST (POLE1) NIL))) ((MOTHER NIL (LOVEX (POLE1) NIL))) ((MOTHER NIL (LOVEDANCE (POLE1) NIL))) ((MOTHER NIL (HELPINGCAREER (POLE2) NIL))) ((MOTHER NIL (HIGHIMPACT (POLE2) NIL)))))) etc










;;SET-CSYM-VALUES  -- DELETE: INTEGRATED INTO MAKE-CSYM
;;2020
;;ddd
#|(defun set-csym-values (csym  &key csymvals (set-csym-to-vals-p T)
                              (if-csym-exists :replace-non-csartloc)
                              (delete-if-null-value-p T)
                              ;;or :replace-csartloc :do-nothing
                              reset-only-nil-vals-p
                              csphrase csartloc csdata  csdef  
                              ;;keys
                              sublist value1value1 value2 csrank linktype qtype
                              sd   BIPATH pole1 pole2 bestpole rev-poles-p
                              to from wto wfrom clev   
                              pclist  restkeys  
                              ;;key syms
                              (supsys-key :CSS)  (sublist-key :S) (linktype-key :LNTP)
                              (valuekey1 :VA)  (valuekey2 :V2) 
                              (csrank-key *csval-rank-key)
                              (clevkey :clev) (qtype-key :QT)  change-csloc-p 
                              )
  "U-CS.  RETURNS (values new-csymvals)   INPUT:  "
  (let*
      ((new-csymvals)
       (old-csymvals (when (eval-sym cysm)))
       (csym-exists-p (when old-csymvals T))    
       (csym-str) 
       (csartloc) 
       (csartloclist)
       (supsys)
       (supsys-vals )
       (key-value-pairs)
       )
       (cond
        ((null csym-exists-p)
         (multiple-value-setq (new-csymvals csym csartloc csartloclist 
                                         supsys supsys-vals )
             (make-csym csym csphrase csartloc csdata  csdef  
                        :dims dims :topdim topdim
                        :value1 q-rel-score  ;; :value2 rank-score :value2key :RNK
                        :supsys supsys :supsys-key supsys-key :sublist sublist-csyms
                        :qtype-key qtype-key :qtype qtype
                        :sublist-key sublist-key 
                        :linktype linktype :linktype-key linktype-key
                        :change-csloc-p change-csloc-p
                        :make-new-csartloc-p make-new-csartloc-p
                        :cs-categories cs-categories :info info :system system 
                        :BIPATH BIPATH 
                        :pole1 pole1 :pole2 pole2 :bestpole bestpole 
                        :rev-poles-p rev-poles-p
                        :to  to :from from :wto wto :wfrom wfrom
                        :clev  clev  :clevkey clevkey 
                        :restkeys  restkeys   :pclist  pclist 
                        :if-csym-exists if-csym-exists ;;or :replace :modify
                        :topdim topdim
                        :csartloc csartloc ;;if present :incl dimsym USE AS IS
                        ;;USE DEFAULTS
                        ;;:separator separator  :node-separator node-separator
                        :store-all-csyms-to-file-p store-all-csyms-to-file-p
                        :all-csyms-listsym all-csyms-listsym 
                        :all-csartloc-syms-sym all-csartloc-syms-sym
                        :all-csartloc-syms&vals-sym all-csartloc-syms&vals-sym 
                        ;;special (temp? for adding tlink csyms
                        :tlink-artlocsym tlink-artlocsym ))
           ;;end if csym not exist
           )

        
                        
#|         (setf csym-str (format nil "~A" csym-str)
          new-csymvals 
               (list csym-str csphrase csartloc csdata  csdef  
                              ;;keys
                              valuekey1 value1 valuekey2 value2 csrank-key csrank
                              clevkey clev qtype-key qtype
                              linktype-key linktype 
                              :SD sd  :BIPATH  bipath 
                              :pole1 pole1 :pole2 pole2 :bestpole bestpole 
                              :rev-poles-p rev-poles-p :to to :from from
                              :wto wto :wfrom wfrom sublist-key sublist
                               :pclist pclist  :restkeys restkeys)))
           ;;delete the keys & vals = nil?     
           (when delete-if-null-value-p
             (setf new-csymvals (delete-keys&vals-from-list
                                 new-csymvals :vals '(nil))))|#
           ;;end if csym NOT exist          
         
        (csym-exists-p
         (cond
          ((equal if-csym-exists :do-nothing)
           (setf new-csymvals old-csymvals))        

          (T
           (setf key-value-pairs (list 
                                  (list valuekey1 value1 ) (list valuekey2 value2) 
                                  (list  csrank-key csrank  ) (list clevkey clev) 
                                  (list qtype-key qtype) (list linktype-key linktype) 
                                  (list  :SD sd  ) (list :BIPATH  bipath ) (list   )
                                  (list  ) (list  ) (list   )
                                  (list  ) (list  ) (list   )
                                  (list  ) (list  ) (list   )
                                  ))
   ;;;SSSSSS FINISH THIS FUNCTION--put rest of key-vals in list 
;; INSTEAD MOVE USEFUL PARTS INTO MAKE-CSYM & USE IT INSTEAD?                           
#|                              :pole1 pole1 :pole2 pole2 :bestpole bestpole 
                              :rev-poles-p rev-poles-p :to to :from from
                              :wto wto :wfrom wfrom sublist-key sublist
                               :pclist pclist  :restkeys restkeys)|#

           (setf new-csymvals (set-keys-values-in-list key-value-pairs old-csymvals
                                                    :omit-if-null-value-p T))


          ;;OTHERWISE SET APPROPRIATE VALUES
          #|(loop
           for item 
           do
           (let*
               ((x)
                )
             (cond
              (
               )
              ((equal if-csym-exists :replace-non-csartloc)


               )
              ((equal if-csym-exists :replace-csartloc)
               ;;make new csartloc csym
               (make-csartloc csartloc csym :supsys supsys :n3-item n3-item 
                              :rest-vals rest-vals)
               )
              (
               )
              (t nil))
             ;;end let,loop
             ))|#
    (when set-csym-to-vals-p
      (set csym new-csymvals))
    ;;END EXISTS?
    ))))

    (values new-csymvals csym old-csymvals)
    ;;end let, defun
    ))|#
;;TEST
;;







;;STORE-CS-SYMS&SYMVALS-BY-VARS
;;2020
;;ddd
#|(defun store-cs-syms&symvals-by-vars (filename  &key PPRINT-P 
                                         (dir "C:\\3-TS\\LISP PROJECTS TS\\CogsysOutputs\\") 
                                         (items-per-file 200)
                                         (use-dated-path-p T) (incl-time-p T)
                                         append-filename-begin append-filename-end  
                                         (pre-listsyms-sym-str "*file-")
                                         accumulate-all-lists-p 
                                         (all-syms-list-sym '*ALL-CSYM-LISTSYMS-SYMS)
                                         (listsyms-sym-lists  '((*ALL-CSYMS)(*ALL-CSYMS&VALS)
                                                     (*ALL-ELMSYMS  *ALL-ELMSYMS&VALS
                                                     *ALL-PCSYMS *ALL-PCSYMS&VALS)
                                                     (*ALL-CSARTLOC-SYMS)
                                                     (*ALL-CSARTLOC-SYMS&VALS) ))
                                         (if-file-exists :overwrite)
                                         (eval-nth-in-symlist 2)
                                         (file-head-message 
                                          ";;TOM ALL STORED CSYMS & CSYM-VALS")
                                         )
  "U-CS Prints objects, evaled syms, and evaled nth syms to filename. 
   RETURNS: (values all-listsyms all-biglists all-syms&vals-lists all-nth-evaled-lists)
   LISTSYMS-SYMS can be symbols that EVAL to val-lists OR (csym val-lists).
    set dir to NIL if FULL pathname."
  (let*
      ((all-pathnames) 
       (all-listsyms)
       (all-biglists)
       (all-syms&vals-lists)
       (date (date-string))
       (all-nth-evaled-lists)
       )  
    (when (null dir)
      (setf dir ""))

    ;;LOOP THRU LISTSYMS-SYMS-for each BIGLIST
    (cond
     ((null items-per-file)
      (loop
       for listsyms-syms in listsyms-sym-lists
       for sublist-n from 1 to 1000
       do 
       (multiple-value-bind (all-listsyms1 all-biglists all-syms&vals-lists
                                           all-nth-evaled-lists pathname1)
           (store-cs-syms&symvals filename  :pprint-p pprint-p
                                  :dir dir
                                  :use-dated-path-p use-dated-path-p
                                  :incl-time-p incl-time-p
                                  :pre-listsyms-sym-str pre-listsyms-sym-str
                                  :accumulate-all-lists-p accumulate-all-lists-p
                                  :all-syms-list-sym all-syms-list-sym
                                  :listsyms-syms listsyms-syms 
                                  :if-file-exists if-file-exists
                                  :eval-nth-in-symlist eval-nth-in-symlist
                                  :file-head-message 
                                  (format nil ";;TOM ALL STORED CSYMS & CSYM-VALS
      ;;DATE ~A ~%   ;; STORING VARIABLE(S):~%  '~A " date listsyms-syms))
         ;;ACCUMULATE
         (setf all-listsyms (append all-listsyms all-listsyms1)
               all-pathnames (append all-pathnames (list pathname1)))

         ;;end mvb, sublist loop, (null items-per-file)
         )))
      ;;WHEN ITEMS-PER-FILE
      (T 
       (loop
        for listsyms-syms in listsyms-sym-lists
        for sublist-n from 1 to 1000
        do 
        (multiple-value-bind (all-listsyms1 all-biglists all-syms&vals-lists
                                            all-nth-evaled-lists pathname1)
            (store-cs-syms&symvals-by-parts filename  :pprint-p pprint-p
                                            :dir dir
                                            :use-dated-path-p use-dated-path-p
                                            :incl-time-p incl-time-p
                                            :pre-listsyms-sym-str pre-listsyms-sym-str
                                            :accumulate-all-lists-p accumulate-all-lists-p
                                            :all-syms-list-sym all-syms-list-sym
                                            :listsyms-syms listsyms-syms 
                                            :if-file-exists if-file-exists
                                            :eval-nth-in-symlist eval-nth-in-symlist
                                            :file-head-message 
                                            (format nil ";;TOM ALL STORED CSYMS & CSYM-VALS
      ;;DATE ~A ~%   ;; STORING VARIABLE(S):~%  '~A " date listsyms-syms))
          ;;ACCUMULATE
          (setf all-listsyms (append all-listsyms all-listsyms1)
                all-pathnames (append all-pathnames (list pathname1)))

          ;;end mvb, sublist loop, T=  items-per-file)
          ))))

      ;;PUT A REALLY BIG LIST AT END=> CAN CAUSE MEMORY ERROR!
      (when accumulate-all-lists-p
        (format instr ";;ACCUMULATIVE LISTS: 
         ;;ALL-LISTSYMS:
         (setf ~A-~A 'S) " pre-listsyms-sym-str all-syms-list-sym all-listsyms )

        (format instr ";;ALL SYMVAL LISTS TOGETHER
            ;;ALL BIG LISTS:~%  ~A
            ;;ALL ALL-SYMS&VALS-LISTS: ~%  ~A "            
                all-biglists all-syms&vals-lists ))
    
      (values all-listsyms all-pathnames)
      ;;all-biglists all-syms&vals-lists all-nth-evaled-lists)
      ;;end let, store-cs-syms&symvals-by-vars
      ))|#
;;TEST
;; (store-cs-syms&symvals-by-vars "3-TOM-CSQ-CSYMS")





;;STORE-CS-SYMS&SYMVALS-BY-PARTS
;;2020
;;ddd
#|(defun store-cs-syms&symvals-by-parts (filename  &key PPRINT-P 
                                         (dir "C:\\3-TS\\LISP PROJECTS TS\\CogsysOutputs\\") 
                                         (use-dated-path-p T)(incl-time-p T) (file-ext "lisp")
                                         append-filename-begin append-filename-end  
                                         (items-per-file 200)
                                         (pre-listsyms-sym-str "*file-")
                                         accumulate-all-lists-p 
                                         (all-syms-list-sym '*ALL-CSYM-LISTSYMS-SYMS)
                                         (listsyms-syms  '(*ALL-CSYMS *ALL-CSYMS&VALS
                                                     *ALL-ELMSYMS  *ALL-ELMSYMS&VALS
                                                     *ALL-PCSYMS *ALL-PCSYMS&VALS
                                                     *ALL-CSARTLOC-SYMS 
                                                     *ALL-CSARTLOC-SYMS&VALS ))
                                         (if-file-exists :overwrite)
                                         (eval-nth-in-symlist 2)
                                         (file-head-message 
                                          ";;TOM ALL STORED CSYMS & CSYM-VALS")
                                         )
  "U-CS Prints objects, evaled syms, and evaled nth syms to filename. 
   Makes files for  items-per-file items WITHIN EACH BIGLIST.
   RETURNS: (values all-listsyms all-biglists all-syms&vals-lists all-nth-evaled-lists)
   LISTSYMS-SYMS can be symbols that EVAL to val-lists OR (csym val-lists).
    set dir to NIL if FULL pathname."
  (let*
      ((all-pathnames) 
       (all-listsyms)
       (all-biglists)
       (all-syms&vals-lists)
       (date (date-string))
       (all-nth-evaled-lists)
       )  
    (when (null dir)
      (setf dir ""))

      ;;LOOP THRU LISTSYMS-SYMS-for each BIGLIST
      (loop
       for listsym in listsyms-syms
       do
       (let*
           ((biglist (when (symbolp listsym)(eval listsym)))
                         ;;  ((listp list-elm) list-elm)))
            (item-lists)
            (syms&vals-lists)
            (nth-evaled-lists)
            )
         ;;in case listsym is a list with sym as first item
         (when (listp listsym)
           (setf listsym (car listsym)))

         ;;FOR EACH ITEM-SYM, LIST SYM & EVALED SYM
         (loop
          for item in biglist
          for n from 1 to 5000
          do
          (let*
              ((itemsym)
               (result)
               (item&result)
               (nth-sym)
               (nth-evaled-result)
               )
            (when (and (symbolp item)(boundp item))
              (setf itemsym item
                    result (eval item))
              (when eval-nth-in-symlist
                (setf nth-sym (nth eval-nth-in-symlist result))
                (cond
                 ((and (symbolp nth-sym)(boundp nth-sym))
                  (setf nth-evaled-result  (list nth-sym (eval nth-sym))))
                 (T (setf nth-evaled-result  (list nth-sym)))))
              ;;end when and
              )
            (setf item&result (list item result)
                  itemsym-lists (append item-lists (list itemsym))
                  syms&vals-lists (append syms&vals-lists (list item&result)))
            (when eval-nth-in-symlist
              (setf evaled-nth-sym 
                    (my-make-symbol (format nil "~A-~Ath-item"
                                            listsym eval-nth-in-symlist))
                    all-nth-evaled-lists (append all-nth-evaled-lists (list nth-evaled-result))))
            ;;(break "itemsym, item&result")

            ;;ACCUMULATE ALL LISTS?
            (setf all-listsyms (append all-listsyms (list listsym)))
            (when accumulate-all-lists-p
              (setf all-biglists (append all-biglists (list item-lists))
                    all-syms&vals-lists (append all-syms&vals-lists 
                                                  (list syms&vals-lists))))
            
            ;;PART AT A TIME
            ;;WRITE TO THE FILE for each BIGLIST
            (when (or (equal item (car (last biglist)))
                      (integerp (/ n items-per-file)))
              ;;make pathname
              (setf pathname (make-dated-pathname filename :root dir 
                                      :append-begin NIL
                                      :append-end N  :file-ext file-ext
                                      :incl-time-p incl-time-p
                                      :no-date-p (not use-dated-path-p)))
              (setf all-pathnames (append all-pathnames (list pathname)))

              (with-open-file (instr pathname :direction :output :if-does-not-exist :create 
                                     :if-exists if-file-exists)
                ;;PRINT FILE INTRO
                (format nil "~A~%  ;;DATE: ~A~%" file-head-message date)
                ;;(cond
                 #|(pprint-p
                  (format instr "~A~%  ;;DATE: ~A   PPRINTED LISTS:" 
                          file-head-message date)
                  (format instr ";;ALL SYMS:~%  (setf ~A " symlist-sym)
                  (princ " '" instr) (pprint all-biglists instr)
                  (format instr "~%;;ALL SYM-SYMLISTS:~%  (setf ~A" evaled-sym-sym)
                  (princ " '" instr) (pprint all-syms&vals-lists instr)
                  (format instr "~%;;ALL SYMS:~%  (setf ~A" evaled-nth-sym)
                  (princ " '" instr)  (pprint all-nth-evaled-lists instr))|#
                 ;;(T      
                 
                 (format instr 
                         " ;;FILE-PART ~A for N= ~A  ~A SYMS ending in N= ~A:
    (setf ~A~A-~A '~A) ~%
   ;;ALL ~A  
    (setf ~A~A-~A-SYM-SYMVALS  '~S) ~%
    ;;SYM= ~A SYMLIST
    (setf ~A-~A '~S) 
    " N  (list-length biglist) listsym N 
                         pre-listsyms-sym-str N listsym   biglist    
                         listsym
                         pre-listsyms-sym-str N listsym all-syms&vals-lists 
                         evaled-nth-sym
                         pre-listsyms-sym-str evaled-nth-sym eval-nth-in-symlist )
                ;;RESET THE LISTS
               (set-vars-to-value NIL '(all-biglists  all-syms&vals-lists   ))
                ;;end open,when
                ))
            ;;(BREAK "END LIST LOOP")
            ;;end let,loop
            ))
         ;;end let,outer loop
         ))

      ;;PUT A REALLY BIG LIST AT END?
      (when accumulate-all-lists-p
        (format instr ";;ACCUMULATIVE LISTS: 
         ;;ALL-LISTSYMS:
         (setf ~A-~A 'S) " pre-listsyms-sym-str all-syms-list-sym all-listsyms )

        (format instr ";;ALL SYMVAL LISTS TOGETHER
            ;;ALL BIG LISTS:~%  ~A
            ;;ALL ALL-SYMS&VALS-LISTS: ~%  ~A "            
                all-biglists all-syms&vals-lists ))
    
   (values all-listsyms all-biglists all-syms&vals-lists all-nth-evaled-lists
           all-pathnames)
    ;;end let, store-cs-syms&symvals-by-parts
    ))|#
;;TEST
;; ;; (store-cs-syms&symvals-by-parts "1-TOM-new-CSYMS-VALS.LISP" )
;; store-data-listsyms-syms

;; (store-syms&evaled-syms"2020-TOM-CSQ-CSYM-OUTPUT-FILE.lisp" :pprint-p T  :dir  "C:\\3-TS\\LISP PROJECTS TS\\CogsysOutputs\\"   :listsyms-syms '( *ALL-STORED-SYS-CSYMS  )  :eval-nth-in-symlist NIL   :file-head-message  ";;TOM ALL STORED CSYMS & CSYM-VALS")

;; (store-syms&evaled-syms"2020-05 TOM-CSQ-CSYM-OUTPUT-FILE.lisp" :pprint-p T  :dir  "C:\\3-TS\\LISP PROJECTS TS\\CogsysOutputs\\"   :listsyms-syms '(*ALL-STORED-SYS-CSYMS *ALL-CSYMS )  :eval-nth-in-symlist NIL   :file-head-message  ";;TOM ALL STORED CSYMS & CSYM-VALS")

;;FOR ALL CSYMS & CSARTLOC-SYMS
;; (store-cs-syms&symvals "C:\\3-TS\\LISP PROJECTS TS\\CogsysOutputs\\TOM-ALL-CSYMS.lisp"     :pprint-p  NIL  :dir nil   :use-dated-path-p T  :accumulate-all-lists-p NIL)      




;;OLDER VERION--INCOMPLETE NOT STORE NEWER LISTS
#|(defun save-csq-data-to-file (file &key 
                                   (dirpath *csq-save-all-dirpath)
                                   ;;"C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\")
                                   (csq-elmsym-lists *csq-elmsym-lists)
                                   (csq-data-list *csq-data-list)
                                   (all-PCqvars *all-PCqvars)
                                   (csq-value-ranking-lists *all-ordered-values-ratings-lists)
                                   (all-stored-csyms *ALL-STORED-CSYMS)
                                   (newlink-made-csyms *NEWLINK-MADE-CSYMS)             
                                   ;;not used set-csq-symbols-to-data-p
                                   (save-cs-explore-data-p T)
                                   (remake-all-PCqvar-lists-p T)
                                   )                                   
  "In U-CS, Saves all CSQ data to a file. "
  (let
      ((pathname (format nil "~A~A" dirpath file))
       (pcsym-elm-lists (get-keyvalue-in-nested-list '((:PCSYM-ELM-LISTS T))  csq-data-list))
       (date (my-get-date-time))
       )
    ;;added 2019 -- might defeat remaking list for changes below SSSS
    (when (and (null all-PCqvars) *all-pcsyms)
      (setf  all-PCqvars *all-pcsyms
             *all-PCqvars *all-pcsyms))
    (when (and (null *all-PCqvar-lists)  *ALL-PCSYMS&VALS)
      (setf *all-PCqvar-lists  *ALL-PCSYMS&VALS))

    (multiple-value-bind (pcsymval-lists pcsyms)
                (make-pcsymval-lists :all-datalists csq-data-list)

    (multiple-value-bind (elmsymval-lists elmsyms n-elmsyms)
        (get-elmsymval-lists :elmsyms *all-elmsyms)    

   ;;UPDATE THE *all-PCqvar-lists (probably modified after initially created)
   (when remake-all-PCqvar-lists-p
     (setf *all-PCqvar-lists NIL)
     (loop
      for pcqvar-str in all-PCqvars
      do
      (setf *all-PCqvar-lists (append *all-PCqvar-lists
                                      (list (eval (my-make-cs-symbol pcqvar-str)))))
      ;;end loop,when
      ))
   ;;OPEN FILE STREAM
      (with-open-file (out pathname :direction :output :if-exists :append
                           :if-does-not-exist :create)
      (format out ";;FOR DATE: ~S~%;; ELMSYMS=~% (setf *file-elmsyms  '~S)~%;;ELMSYMVALS= ~%  (setf *file-elmsymvals  '~S)~%;;PCSYMS= ~% (setf *file-pcsyms  '~S)~%;;PCSYMVAL-LISTS= ~% (setf *file-pcsymval-lists '~S)~%;;*CSQ-DATA-LIST=~% (setf *file-csq-data-list '~S)~% ~%;;FOR CREATING:~%;;*ALL-PC-ELEMENT-QVARS=~%  (setf *file-all-pc-element-qvars  '~S)~%;;*ALL-PCQVAR-LISTS=~% (setf *file-all-pcqvar-lists '~S)~%;;*ALL-CSQ-VALUE-RANKING-LISTS=~% (setf *file-all-csq-value-ranking-lists '~S)~% " date elmsyms elmsymval-lists  pcsyms  pcsymval-lists *csq-data-list *all-pc-element-qvars  *all-pcqvar-lists csq-value-ranking-lists )
            ;;end with
      )

    ;;SAVE CS-EXPLORE DATA?
    ;;get,format, and save cs-explore data
    (when (and save-cs-explore-data-p *NEWLINK-MADE-CSYMS)
      (save-cs-explore-data-to-file  :path  pathname
                                     :all-csart-cat-sym-db-sym '*MASTER-CSART-CAT-DB
                                :all-stored-csyms-sym '*ALL-STORED-CSYMS
                                :newlink-made-csyms-sym '*NEWLINK-MADE-CSYMS
                                :return-stored-strings-p T))
    (values elmsyms pcsyms *all-csq-data-list-syms)
    ;;end let, mvb,mvb, save-csq-data-to-file
    ))))|#



#| DELETE--OLDER NOT INCL LATEST --but works
(defun set-csym-csartloc (csym &key topdim (supsys :GET)
                               (last-dim :csym) dims 
                               new-csartloc (use-new-csartloc-p T)
                               make-supsys-csym-csartloc-p
                               csartloc-syms&vals set-as-csartdims-p (artsym-n 2)
                               (if-exists-replace-p T)(make-new-csartloc-p T) 
                               n3-item rest-vals (separator-str ".")
                               (append-all-csartloc-syms&vals-p T)
                               (all-csartloc-syms-sym '*ALL-CSARTLOC-SYMS)
                               (all-csartloc-syms&vals-sym
                                '*ALL-CSARTLOC-SYMS&VALS)
                               (supsys-key :CSS))
  "U-CS Used to CHANGE the csartloc value, make NEW CSARLOC SYM, and append the global vars collecting all the csartloc syms & their symvals. Sets the csartloc value as either a csartloc-sym or csartdims.   RETURNS (values csymvals csartloc-sym new-csartloc-vals csartdims old-csartloc). If TOPDIM, uses as topdim. If SUPSYS, puts ahead of csym--otherwise gets from :CSS. If last-dim-csym-p, sets csym as last dim. If DIMS, puts them BETWEEN topdim & supsys (if not nil). "
  (let*
      ((csartloc)
       (csartloc-sym)
       (csartloc-str)
       (new-csartloc-vals)
       (csartloc-syms&vals)
       (csymvals (eval-sym csym))
       (old-csartloc-sym (nth artsym-n csymvals))
       (old-csartloc-vals (eval-sym old-csartloc-sym))
       (old-csartloc-dims (second old-csartloc-vals))
       (csartdims)
       (all-csartloc-syms (eval-sym all-csartloc-syms-sym))
       (all-csartloc-syms&vals (eval-sym all-csartloc-syms&vals-sym))
       )
    ;;find supsys?
    (when (equal supsys :GET)
      (setf supsys (get-key-value supsys-key csymvals))
      ;;assumes supsys is next to end dim
      (unless supsys
        (when (listp old-csartloc-dims)
          (cond
           ;;if csym at end of csartdims
           ((equal csym (car (last old-csartloc-dims)))
            (setf supsys (car (last old-csartloc-dims 2))))
           ;;if no csym at end
           (T (setf supsys (car (last old-csartloc-dims))))))
        ;;if double csyms in csartdims
        (when (equal supsys csym)
          (setf supsys (car (last old-csartloc-dims 3))))
        ;;end unless,when
        ))
    ;;(break "supsys")
    (cond
     (use-new-csartloc-p
      (setf csartloc-sym new-csartloc)
      (cond
       ((boundp csartloc-sym)
        (setf csartloc-vals (eval csartloc-sym)))
       (T  NIL)))
     ;;modify csartloc?
     ((or if-exists-replace-p (null old-csartloc))
      (when (or topdim supsys last-dim)
        ;;1. convert dims to a list
        (cond
         ((listp dims)
          (setf csartdims dims))
         ((or (symbolp dims) (stringp dims))
          (setf csartdims (find-art-dims dims)))
         (t nil))
        ;;2. Add topdim?
        (when  topdim 
          (setf csartdims (cons topdim csartdims)))
        ;;3. Add supsys?
        (when supsys
          (setf csartdims (append csartdims (list supsys ))))
        ;;4. Add last-dim-csym?
        (when last-dim 
          (cond
           ((equal last-dim :csym)
            (setf csartdims (append csartdims (list csym))))
           (T (setf csartdims (append csartdims (list last-dim))))))
        ;;(break "after add csym")
        ;;MAKE NEW CSARTLOC-SYM
        (setf csartloc-sym (make-list-symbol csartdims :separator-str separator-str)
              csartloc-str (format nil "~A" csartloc-sym))
        ;;end when
        )
      ;;MAKE NEW-CSARTLOC-VALS and set csartloc-sym to them
      (unless n3-item
        (setf n3-item (nth 2 old-csartloc-vals)))
      (unless rest-vals
        (setf rest-vals (nthcdr 4 old-csartloc-vals)))
      (setf new-csartloc-vals
            (cond (rest-vals 
                   (append (list csartloc-str csartdims n3-item csym) rest-vals))
                  (t (list csartloc-str csartdims n3-item csym))))
      (set csartloc-sym new-csartloc-vals)
      ;;(break "csartloc-sym")
      ;;unbind old-csartloc-sym
      (when (and csartloc-sym old-csartloc-sym)
        (makunbound old-csartloc-sym))

      ;;APPEND GLOBAL ARTLOC VAR
      (when append-all-csartloc-syms&vals-p
        (set all-csartloc-syms-sym
             (append all-csartloc-syms (list csartloc-sym)))
        (set all-csartloc-syms&vals-sym 
             (append all-csartloc-syms&vals (list (list csartloc-sym new-csartloc-vals)))))
      ;;SET THE CSYM CSARTLOC VAL
      (setf  csymvals (set-nth-in-list csartloc-sym artsym-n csymvals))
      (set csym csymvals)    
      ;;(break "csymvals")
      ;;end modify csartloc
      )     
     ;;If old-csartloc exists and (null if-exists-replace-p) use old csartloc & csym vals
     (T (setf csartloc-sym old-csartloc-sym
              new-csartloc-vals (eval-sym old-csartloc-sym)
              csymvals (eval-sym csym))))
    (values csymvals csartloc-sym new-csartloc-vals csartdims old-csartloc-sym)
    ;;end let, set-csym-csartloc
    ))|#