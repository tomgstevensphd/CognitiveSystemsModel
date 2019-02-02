;;*********************** CS-explore.lisp ******************************
;;
;;NOTES:
;; SEE CS-NOTES.lisp also
#|CS-EXPLORE STEPS:
1. PRESENT CS-EXPLORE-QUESTIONS from CS-explore-questions.lisp
  output to: *CS-EXPLORE-DATALIST
2. ASK TO NAME EACH INPUT ANSWER (VERBAL LABEL)
3. IDENTIFY LINKING PC: Check to see if NAME/PC ALREADY EXISTS
        3.1 IF PC EXISTS, LINK IT TO THIS PCSYM
        3.2 IF PC NOT EXIST,  Make NAME a pcsym and set to a pcsymlist with first INPUT as :description, etc.
4. ADD DATA TO EACH PC in LINK
    4.1 ADD DATA AND TYPE TO PCSYMLIST OF PC BEING EXPLORED (mostly under (:BIPATHS (:ISA (THISPC THATPC ..) 
    4.2 ADD DATA TO NEW/OLD PC ON OTHER END.
5. LATER? Fill in missing parts (eg opposite pole, best pole, value rating, etc.)
6. STORE IN MAIN PCSYMS DATABASE
|#
;;ALSO, TRY PC REPTEST ON 3 VALUES AT A TIME TO GET HIGHER ORDER
;; NOTE: My value of happiness NEVER was elicited by my taking the CS-REPTEST the first time.


;;EXPLORE PARAMETERS
;; 1. STORE UNDER DB-ITEM TYPE/FEATURE SYMBOL LIST
;; DB-ITEM TYPES: Used for STORING CSYMS BY SUB-TYPE.  IF ONLY FALLS IN GENERAL CATEGORY THEN STORE UNDER (eg VALUE for *DB-VALUE.
(Defparameter *DB-TOPBV '((:SUBTP *DBTOPBV *DBSUPGOAL *DBSUBGOAL *DBSUPPLAN *DBSUBPLAN)) )
(Defparameter *DB-WRLDVW '((:SUBTP *DBWRLDVW)) )
(Defparameter *DB-SELF '((:SUBTP *DBSELF)) )
(Defparameter *DB-REFGRP '((:SUBTP *DBREFGRP)) )
(Defparameter  *DB-VALUE '((:SUBTP *DBVALUE)) ) 
(Defparameter *DB-BELIEF '((:SUBTP *DBSELF *DBSTEREOTYPE  *DBREGNANT)) )
(Defparameter *DB-PC '((:SUBTP *DBPC *DBOPPOSITE)) )
(Defparameter *DB-KNOWB '((:SUBTP *DBKNOWB *DBISA *DBPART *DBWHY *DBCAUSE *DBEVIDENCE *DBHOW *DBEXAMPLE *DBFEATURE *DBPROTOTYPE)) )
(Defparameter *DB-COGSK  '((:SUBTP *DBCOGSK *DBPROBS *DBDEC *DBPLAN *DBLEARN *DBCOPE *DBCRITTHK)) )
(Defparameter *DB-BEHSK  '((:SUBTP *DBBEHSK *DBPEOP *DBMECH *DBMAINT )) )
(Defparameter *DB-SCRIPT '((:SUBTP *DBSCRIPT)) )
(Defparameter *DB-EVENT '((:SUBTP *DBEVENT)) )
(Defparameter *DB-ELM '((:SUBTP *DBELM)) )
;;INTEGRAL PARTS OF DB-ITEMS ABOVE
(Defparameter *DB-VERBAL '((:SUBTP *DBVERBAL *DBNAME *DBDEFINE *DBDESCRIPTION *DBOPPOSITE *DBSYNONYM)) )
(Defparameter *DB-IMAGE '((:SUBTP *DBIMAGE)) )
(Defparameter *DB-SOUND '((:SUBTP *DBSOUND)) )
(Defparameter *DB-SMELL  '((:SUBTP *DBSMELL)) )
(Defparameter *DB-TASTE  '((:SUBTP *DBTASTE)) )
(Defparameter *DB-TACTILE '((:SUBTP *DBTACTILE)) )
(Defparameter *DB-EMOTION '((:SUBTP *DBEMOTION *DBHAPPY *DBCARING *DBANXIETY *DBANGER *DBSAD  )) )
(Defparameter *DB-MOTOR '((:SUBTP *DBMOTOR)) )
;; ALL DB-TYPES
(Defparameter *ALL-CS-DB-ITEM-TYPES '(*DB-TOPBV *DB-WRLDVW *DB-SELF *DB-REFGRP *DB-VALUE  *DB-BELIEF *DB-PC *DB-KNOWB *DB-COGSK *DB-BEHSK  *DB-SCRIPT *DB-EVENT *DB-ELM) "Separate DB-ITEM TYPES. Each item a separate entity, Can have LINKS (eg BIPATHSS where a linked db-item is listed in the BIPATHS, etc.")
(Defparameter *ALL-CS-DB-ITEM-FEATURES
      '(*DB-VERBAL        *DB-IMAGE       *DB-SOUND       *DB-SMELL       *DB-TASTE       *DB-TACTILE       *DB-EMOTION       *DB-MOTOR) "Integral pars of the DB-ITEM. Sublists of these items--no link necessary.")
;;ALL SUBSYMS FROM ABOVE
(Defparameter *ALL-CSDB-SUBSYMS NIL "Complete list of all db subsyms calculated in initialize-cs-explore")


;;INITIALIZE-CS-EXPLORE
;;2018
;;ddd
(defun initialize-cs-explore (&key (unbind-previous-subsyms T)
                                     (nested-symbol-list 
                                      (append *ALL-CS-DB-ITEM-TYPES 
                                              *ALL-CS-DB-ITEM-FEATURES))
                                     (key :SUBTP ) default-value  values-list)
  "CS-Explore Initializes all db subsyms. If  unbind-previous-subsyms, unbinds and then rebinds setting to nil *ALL-CSDB-SUBSYMS [LATER? SSS WHATEVER ADDITIONAL INITIS PUT HERE   RETURNS (values set-symbols-list n-all-subsyms n-syms). Does NOT UNBIND any CSYMs only *DB-spyms. "
  (let
      ((set-symbols-list)
       (n-all-subsyms)
       (n-syms)
       )
    ;;UNBIND PREVIOUS CS-EXPLORE subsyms and  add more???
    (when (and unbind-previous-subsyms *ALL-CSDB-SUBSYMS)
      (makunbound-cs-explore-vars))

    (multiple-value-setq (set-symbols-list n-all-subsyms n-syms )
        (set-nested-symbols :nested-symbol-list nested-symbol-list
                            :key key :default-value  default-value 
                            :values-list values-list))
    ;;set the global variable
    (setf *ALL-CSDB-SUBSYMS set-symbols-list)
 
    (values set-symbols-list n-all-subsyms n-syms)
    ;;end let, initialize-cs-explore
    ))
;;TEST
;; (initialize-cs-explore)
;; works: unbinds and then rebinds setting to nil all *ALL-CSDB-SUBSYMS

;; (save-csq-data-to-file

;;SET-NESTED-SYMBOLS
;;2018
;;ddd
(defun set-nested-symbols (&key (nested-symbol-list 
                                 (append *ALL-CS-DB-ITEM-TYPES 
                                         *ALL-CS-DB-ITEM-FEATURES))
                                (key :SUBTP ) default-value  values-list)
  "CS-explore, Sets lists of nested (database) symbols to either default-value or items in  values-list  RETURNS (values  set-symbols-list n-all-subsyms n-syms )   INPUT:  "
  (let
      ((set-symbols-list)
       (n-syms (list-length nested-symbol-list))
       (n-all-subsyms 0)
       )
    (loop
     for topsym in nested-symbol-list
     do
  (let*
      ((topsymlist (eval topsym))
       (syms-list (cdr (get-key-list key topsymlist)))
       (n-subsyms (list-length syms-list))
       )
    (setf n-all-subsyms (+ n-all-subsyms n-subsyms))
    ;;(break)
    (loop
     for sym in syms-list  
     for n from 0 to (- n-syms 1)
     do
     (let*
         ((value (cond (values-list (nth n values-list))
                      (t default-value)))
          )
       (set sym default-value)
       (setf set-symbols-list (append set-symbols-list (list sym)))
     ;;end let, inner loop
     ))
    ;;end let, outer loop
    ))
    (values  set-symbols-list n-all-subsyms n-syms )
    ;;end let, set-nested-symbols
    ))
;;TEST
;; (set-nested-symbols)


;;MAKUNBOUND-EXPLORE-VARS
;;2018
;;ddd
(defun makunbound-CS-explore-vars 
                                   (&key (unbind-vars 
                                          (append *ALL-CSDB-SUBSYMS
                                                  *ALL-STORED-CSYMS)))                                         
#|   not needed bec values not added
                                      (append *ALL-CS-DB-ITEM-FEATURES
                                               *ALL-CS-DB-ITEM-TYPES )))|#
  "CS-explore. Unbinds global CS-explore vars.    RETURNS (vars-unbound  unbind-vars N) . U-symbol-info converts a list of  symbols or strings to a list of UNBOUND VARS--even if they were previously bound. RETURNS (values new-varlist varlist)"
  (let
      ((unbound-vars)
       (n-unbind (list-length unbind-vars))
       (n-unbound 0)
       )
    (setf vars-unbound (makunbound-vars unbind-vars)
          n-unbound (list-length vars-unbound))
    (values vars-unbound n-unbound n-unbind)
    ;;end let, makunbound-explore-vars
    ))
;;TEST
;; (makunbound-explore-vars)


;;OLD --LATER DELETE?? ----------------------
#| Not needed if top syms eval to lists of subsyms
(Defparameter *CS-DB-ITEM-TREE
  '((*DB-TOPBV (TOPBV))
    (*DB-WRLDVW (WRLDVW))
    (*DB-SELF (SELF))
    (*DB-REFGRP (REFGRP))
    (*DB-VALUE (VALUE)) 
    (*DB-BELIEF (BELIEF SELF STEREOTYPE REGNANT)) 
    (*DB-PC (OPPOSITE))
    (*DB-KNOWB (KNOWB ISA PART WHY CAUSE EVIDENCE HOW EXAMPLE FEATURE PROTOTYPE)) 
    (*DB-COGSK (COGSK SM DEC PLAN LEARN COPE CRITTHK)) 
    (*DB-BEHSK (BEHSK PEOP MECH MAINT )) 
    (*DB-SCRIPT (SCRIPT)) 
    (*DB-EVENT (EVENT)) 
    (*DB-ELM (ELM))
    ) "TREE PROVIDES INFO ONLY! DB-ITEM types with subtypes listed to help classify new DB-item syms. Sym in csymlist key= :CSDB (COPE) ")
|#
;;ALL DB-FEATURES 
#| Not needed if top syms eval to lists of subsyms
(Defparameter *CS-DB-ITEM-FEATURE-TREE
      '((*DB-VERBAL (VERBAL NAME DEFINE DESCRIPTION OPPOSITE SYNONYM))
        (*DB-IMAGE (IMAGE))
       (*DB-SOUND (SOUND))
       (*DB-SMELL (SMELL))
       (*DB-TASTE (TASTE))
       (*DB-TACTILE (TACTILE))
       (*DB-EMOTION (EMOTION HAPPY CARING ANXIETY ANGER SAD  ))
       (*DB-MOTOR (MOTOR))
       ) "TREE PROVIDES INFO ONLY!  DB-ITEM features with subtypes listed to help classify new DB-item syms.  Sym in csymlist key= :CSDB (HAPPY)")
|#


;;CS-EXPLORE
;;2018-08
;;ddd
(defun cs-explore (csym &key (qvars-list-name '*all-cs-explore-qvars) 
                          (quests-list-name '*All-CS-exploreQs) (store-key :bipath)
                          confirm-input-p  (csdb-pre "*DB"))
                         ;;not needed, done in store- (track-all-stored-csyms-p T))
  "CS-explore   RETURNS    INPUT:  "   
  (let*
      ((outputs)
       (cs-phrase (second (eval csym)))
       (all-qvarlists (eval qvars-list-name))
       (all-quests (eval quests-list-name))
       (answers)
       (results)
       (all-stored-csdb-syms)
       (all-stored-csyms)
       )
    ;;SET THE DEFAULT *cur-all-questions and *cur-qvar-lists
    (setf *cur-qvar-lists qvars-list-name
          *cur-all-questions quests-list-name
          *cs-explore-phrase cs-phrase 
          *run-csq-p T ;;so callback will poke this
          *temp-all-multi-input-outputs NIL
          *all-CS-explore-outputs NIL
          )
    ;;SET THE *csq-main-process
    (setf *csq-main-process (mp:get-current-process))

    ;;(break)
    ;;STEP 1: FOR EACH CATEGORY
    (loop
     for catlist in all-qvarlists
     do
     (let
         ((n-qvars (list-length catlist))
          (multi-item-p)
          (catvar-str (car (second catlist)))
          (mult-ans)
          (current-qvar)
          (csdbsyms)
          (stored-csdbsyms)
          (stored-csyms)
          )   
       (when (equal (car (last (second catlist))) :multi-item)
         (setf multi-item-p T))
       ;;STEP 1: MAKE THE QUESTIONS, ETC FROM QVARS
       ;;FOR :MULTI-ITEM QUESTS
       (cond
        (multi-item-p
         (setf current-qvar  catvar-str
               *current-qvar-list catlist)
         (make-question-frame catvar-str NIL ;;arg not used in def
                              :all-qvar-lists  all-qvarlists ;;was *current-qvar-list
                              :compare-3elms-p NIL )
         ;;or(cdr *current-qvar-list))
         ;;PAUSE 
         (mp:current-process-pause 100)

         ;;COLLECT THE ANSWERS
         (loop
          for ans in (cddr *quest-frame-results-list-brief)
          do
          ;;Was the quest item selected ("answer 1" T 1) or not ("answer2" NIL 0)?
          (when (second ans)
            (setf mult-ans (append mult-ans (list (car ans))))

            ;;STORE THE ANS
            (let*
                ((csdbstr  (format nil "~A~A" csdb-pre (car ans)))
                 (csdbsym (my-make-symbol csdbstr))
                 )
              ;;store csym in BIPATHS for each node
              (store-in-csdbsym csdbsym store-key  (list csym NIL))
              (setf  stored-csdbsyms (append csdbsyms (list csdbsym)))
              ;;store in 2nd node
              (store-in-csdbsym csym store-key  (list csdbsym  NIL))
              (setf stored-csyms (append stored-csyms (list csym)))
              ;;end let,when,loop
              )))
        (setf answers (append answers (list mult-ans))
              results (append results (list (list catvar-str
                                                  *quest-frame-results-list-brief)))
              all-stored-csdb-syms (append all-stored-csdb-syms (list csdbsyms))
              all-stored-csyms (append all-stored-csyms (list stored-csyms)))
        ;;end multi-item cat
        )
       ;;FOR ALL OTHER TYPE ITEMS
       (t       
        (loop
         for qvarlist in (cdr catlist)
         for n from 1 to n-qvars
         do
         (let*
             ((qvarstr (car qvarlist))
              (type (third qvarlist))
              (csdbstr  (format nil "~A~A" csdb-pre qvarstr))
              (csdbsym (my-make-symbol csdbstr))
              (answer)
              (result)
              )
           ;;Set global vars for text-go-button-callback
           (setf  *current-qvar  qvarstr
                  *current-qvar-list qvarlist)
           ;;(break "before frame")

           (cond
            ((equal type "single-text")
             ;;MAKE SINGLE-INPUT FRAME
             (make-question-frame  qvarstr 'scale-sym :quest-frame 'frame-csq
                                   :all-qvar-lists all-qvarlists
                                   :compare-3elms-p NIL)
             #|   (make-question-frame  "DEFINE" 'scale-sym :quest-frame 'frame-csq :all-qvar-lists *all-cs-explore-qvars :compare-3elms-p NIL)|#
             ;;(break "single")
             ;;PAUSE 
             (mp:current-process-pause 100)

             ;;COLLECT THE ANSWERS
             (setf answer *text-input-frame-text-answers
              answers (append answers (list answer))
                   results (append results 
                                   (list (list qvarstr answer))))            
             ;;STORE THE ANSWERS IN CSDB ITEMS
             (store-in-csdbsym csdbsym store-key (list csym  nil nil))
             (setf all-stored-csdb-syms (append all-stored-csdb-syms (list csdbsym)))
            ;;store in 2nd node
            (store-in-csdbsym csym store-key  
                              (list csdbsym  NIL) :subitem answer)                         
            (setf  all-stored-csyms (append all-stored-csyms (list csym)))
             ;;end :single-text
             )
            ;;FOR MULTI-TEXT INPUT QVARS
            ((equal type "multi-text")
             (setf result nil)
             (multiple-value-bind (q-text q-text-sym title q-instr )
                 (get-question-text-formated qvarstr)
               ;;set callback global vars
               (setf  *current-qvar  qvarstr
                      *current-qvar-list qvarlist)
               ;;(break "before make multi")
               (make-multi-input-frames (list (list q-text) title 'input-or-buttons q-instr) 
                                        :win-title *CSQ-frame-title 
                                        :win-background #(:RGB 0.5019608 1.0 0.0 1.0)
                                        :win-args '(:x 20 :y 20 :visible-max-height 250)
                                        :quest-pane-ht 20 :quest-border 20
                                        :quest-font-size 14 :quest-font-color :red
                                        :special-process (mp:get-current-process)
                                        :poke-special-process-p T
                                        :confirm-input-p NIL )
               ;;PAUSE- not needed because of a pause in  make-multi-input-frames that 
               ;;    keeps control from passing to here?

               ;;COLLECT THE ANSWERS
               (setf result (list (list qvarstr *temp-all-multi-input-outputs))
                     answers (append answers (list  *temp-all-multi-input-outputs))
                     results (append results (list result) ))

               ;;STORE THE ANSWERS IN CSDB ITEMS
               (loop
                for ans1 in answers
                do 
                (when ans1
                  (multiple-value-bind (new-keylist1 csdbsym1 old-keylist1 csdbsym-str1)
                      (store-in-csdbsym qvarstr  store-key csym  :subitem ans1)
                    ;;2nd node
                    (store-in-csdbsym csym store-key qvarstr  :subitem ans1)
                    ;;collect csdb-sym
                    (setf all-stored-csdb-syms (append all-stored-csdb-syms (list csdbsym1)
                                           all-stored-csyms (append all-stored-csyms (list csym))))
                    ;;end inner mvb, when,loop
                    )))
               ;;end mvb, mult-input
               ))
            (t nil))
           ;;end let,inner loop t cond
           ))))
       ;;end let,outer cat loop
       ))
    ;;SSSS START HERE - LATER PUT IN GRAPHIC NETWORK?

    ;;global var set in case need for callbacks etc
    (setf *all-CS-explore-outputs (list answers results all-stored-csdb-syms))
    
    ;;KEEP TRACK of new  nodes, etc USING GLOBAL VARS
    ;;  *ALL-STORED-CSYMS  *ALL-STORED-CSDB-SYMS 
#|  not needed  (when track-all-stored-csyms-p
      (setf  *ALL-STORED-CSYMS  all-stored-csyms  
             *ALL-STORED-CSDB-SYMS all-stored-csdb-syms))|#
    
    (values  answers results all-stored-csdb-syms all-stored-csyms)
    ;;end let, cs-explore
    ))
;;TEST
;; SSSSS START HERE TESTING THE STORING OF CSDB INFO W store-in-csdbsym
;;(PRAGMATIC ("PRAGMATIC" "PRAGMATIC vs NOT PRAGMATIC" CS2-1-1-99 NIL NIL :PC ("PRAGMATIC" "NOT PRAGMATIC" 1 NIL) :POLE1 "PRAGMATIC" :POLE2 "NOT PRAGMATIC" :BESTPOLE 1 (:BIPATHS ((POLE1 NIL TEACHER NIL) (POLE1 NIL MANAGER NIL) (POLE2 NIL MUSLIMS NIL)))))
;; (cs-explore 'PRAGMATIC  :qvars-list-name '*test-cs-explore-qvars )
;;works=
;;answers= (("HAPPY" "CARING") ("think pragmatic" "act pragmatic") ("dogmatic") ("doing nec to meet goals") ("consider consequences" "considr all values"))
;;results= (("EMOTION" ("EMOTION" 1 ("HAPPY" T 1) ("CARING" T 1) )) (("ISA" ("think pragmatic" "act pragmatic"))) ("OPPOSITE" ("dogmatic")) ("DEFINE" ("doing nec to meet goals")) (("GOAL" ("consider consequences" "considr all values"))))
;;dbsyms= ((*DBHAPPY *DBCARING *DBANXIETY *DBANGER *DBSAD) ISA ISA *DBOPPOSITE *DBDEFINE GOAL GOAL GOAL GOAL GOAL)

;;PRAGMATIC=> ("PRAGMATIC" "PRAGMATIC vs NOT PRAGMATIC" CS2-1-1-99 NIL NIL :PC ("PRAGMATIC" "NOT PRAGMATIC" 1 NIL) :POLE1 "PRAGMATIC" :BIPATHS ((*DBHAPPY NIL) (*DBCARING NIL) (*DBANXIETY NIL) (*DBANGER NIL) (*DBSAD NIL) ("ISA" :SUBITEM ("HAPPY" "CARING")) ("ISA" :SUBITEM ("think pragmatic" "act pragmatic")) (*DBOPPOSITE NIL :SUBITEM ("dogmatic")) (*DBDEFINE NIL :SUBITEM ("doing nec to meet goals")) ("GOAL" :SUBITEM ("HAPPY" "CARING")) ("GOAL" :SUBITEM ("think pragmatic" "act pragmatic")) ("GOAL" :SUBITEM ("dogmatic")) ("GOAL" :SUBITEM ("doing nec to meet goals")) ("GOAL" :SUBITEM ("consider consequences" "considr all values"))) :POLE2 "NOT PRAGMATIC" :BESTPOLE 1 (:BIPATHS ((POLE1 NIL TEACHER NIL) (POLE1 NIL MANAGER NIL) (POLE2 NIL MUSLIMS NIL))))
;; GOAL=>  (:BIPATHS ((PRAGMATIC :SUBITEM ("HAPPY" "CARING")) (PRAGMATIC :SUBITEM ("think pragmatic" "act pragmatic")) (PRAGMATIC :SUBITEM ("dogmatic")) (PRAGMATIC :SUBITEM ("doing nec to meet goals")) (PRAGMATIC :SUBITEM ("consider consequences" "considr all values")) (PRAGMATIC :SUBITEM ("HAPPY" "CARING")) (PRAGMATIC :SUBITEM ("typ1" "think" "doing pragmatic")) (PRAGMATIC :SUBITEM ("dogmatic")) (PRAGMATIC :SUBITEM ("considers all values and consequences realitically and acts accordingly.")) (PRAGMATIC :SUBITEM ("g1")))) 



;; (cs-explore 'CAREFOROTHERS  :qvars-list-name '*test-cs-explore-qvars )
;; works= 
;;answers= (("HAPPY" "ANGER") ("type 1" "last type") ("opp care") ("def care") ("goal 1" "last goal"))
;; results= (("EMOTION" ("EMOTION" 1 ("HAPPY" T 1) ("CARING" NIL 0) ("ANXIETY" NIL 0) ("ANGER" T 1) ("SAD" NIL 0))) (("ISA" ("type 1" "last type"))) ("OPPOSITE" ("opp care")) ("DEFINE" ("def care")) (("GOAL" ("goal 1" "last goal"))))
;;all-stored-csdb-syms= ((*DBHAPPY *DBCARING *DBANXIETY *DBANGER *DBSAD) HAPPY-ANGER TYPE-1-LAST-TYPE *DBOPPOSITE *DBDEFINE HAPPY-ANGER TYPE-1-LAST-TYPE OPP-CARE DEF-CARE GOAL-1-LAST-GOAL)
;;ALSO
;; GOAL-1-LAST-GOAL = (:BIPATHS (CAREFOROTHERS))
;; *DBCARING= (:BIPATHS ((CAREFOROTHERS NIL) (CAREFOROTHERS NIL) (CAREFOROTHERS NIL)))



#|("BEST-M-FRIEND" "best-m-friend" ELM4-1-1-99 NIL "DAVE"
 :BIPATHS (((BEST-M-FRIEND NIL (CAREFOROTHERS (POLE1) NIL))) 
 ((BEST-M-FRIEND NIL (INTIMATE (POLE2) NIL))) 
 ((BEST-M-FRIEND NIL (PSYCHOLOGISTS (POLE1) NIL))) ((BEST-M-FRIEND NIL (CAREABOUTOTHERSFEE (POLE1) NIL))) 

((BEST-M-FRIEND NIL (INSPIREOTHERS (POLE1) NIL))) ((BEST-M-FRIEND NIL (BESTFRIEND (POLE2) NIL))) ((BEST-M-FRIEND NIL (DIRECT-HONEST (POLE1) NIL))) ((BEST-M-FRIEND NIL (UNBRIDLEDHUMOR (POLE2) NIL))) ((BEST-M-FRIEND NIL (FANTASYWORLD (POLE2) NIL))) ((BEST-M-FRIEND NIL (ATHLETIC (POLE1) NIL))) ((BEST-M-FRIEND NIL (ESPOSECHRISTIAN (POLE2) NIL))) ((BEST-M-FRIEND NIL (CRITICAL (POLE2) NIL)))))
|#
;;STORE-IN-CSDBSYM
;;2018
;;ddd
(defun store-in-csdbsym (csdbsym  &key dbkeylist bipaths topath  from wto 
                                   wfrom info SUBITEM  (append-value-p T) 
                                   (dbprefix "")  default-val 
                                   (track-all-stored-csyms *ALL-STORED-CSYMS))
  "CS-explore. Also see MAKE-CSYM which makes a NETWORK NODE--this only makes database symbol objects--(eg *DB-VALUE).   RETURNS (values new-keylist csdbsym  old-keylist csdbsym-str)   INPUT: csdbsym (sym, string, or unbound). VALUE of KEY is item/value to be stored in csdbsym,  dbkeylist is entire  csdbsym list. Rest of keys are keys followed by value lists.  If key does not exist, creates it. Set DBPREFIX to *DB or *DB-  if WANT TO CREATE NEW CSDB-SYM. SUBITEM key is a subitem of a csdb category (eg. *DBGOAL :BIPATHS (TENNIS NIL  :SUBITEM \"win tourney\"). [Note: subitem will appear in EVERY key that is non-nil, so only do ONE key store when use subitem.]"
 (let
     ((rest-keys '(:BIPATHS :topath  :from :wto :wfrom :info))
      (rest-keyvalues (list BIPATHS topath from wto wfrom info))
      (csdbsym-str)
      (old-keylist)
      (new-keylist)
      (new-value)
      )
   ;;FIND OLD-KEYLIST AND/OR CREATE/SET csdbsym
   (cond
    ((and (symbolp csdbsym)(boundp csdbsym))
     (setf old-keylist (eval csdbsym)))
    ;;If not bound, create a new csdbsym
    (t 
     ;;(setf old-keylist `("BEST-M-FRIEND" "best-m-friend" ELM4-1-1-99 NIL "DAVE"  :BIPATHS (((BEST-M-FRIEND NIL (CAREFOROTHERS (POLE1) NIL))) 
     (multiple-value-setq (csdbsym new-keylist csdbsym-str old-keylist)
         (get-set-symbol-value csdbsym :new-value default-val :sym-prefix dbprefix))
    ;;In case there is no basic csdb info in beginning
    ;;end t,cond
    ))
   ;;MODIFY THE NEW-KEYLIST?
   (cond
    (dbkeylist
     (set csdbsym dbkeylist)
     (setf new-keylist (eval csdbsym)))
    (t
     (loop
      for key in rest-keys
      for value in rest-keyvalues
      do
      (let*
          ((keylist)
           )
        (cond
         (value
          (cond
           (subitem
            (cond
             ((listp value)
              (setf new-value (append value (list :subitem subitem))))
             (t (setf new-value (list value :subitem subitem))))
            ;;end subitem
            )
           (t (setf new-value value)))            
          (setf new-keylist 
                (get-set-append-delete-keyvalue key new-value :old-keylist  old-keylist
                                                :append-value-p T :keyloc-n 9 :val-nth 1))
          (set csdbsym new-keylist)
          ;;add to global csym tracking list?
            (when track-all-stored-csyms 
              (setf *ALL-STORED-CSYMS 
                    (append *ALL-STORED-CSYMS (list csdbsym))))
          ;;end cond
          ))
        ;;end let,loop, t cond
        ))))
   (values new-keylist csdbsym  old-keylist csdbsym-str )
   ;;end let, store-in-csdbsym
   ))
;;TEST
;; explore-csym2 previously UNBOUND
;; (store-in-csdbsym  "explore-csym2" :BIPATHS '("to-csdb" NIL) )
;; works= (:BIPATHS (("to-csdb" NIL)))  EXPLORE-CSYM2  NIL  "testgetsetsym"
;; FOR PREVIOUS sym explore-csym3
;; (setf explore-csym3 '("explore-csym" "explore-csym" NIL ELM4-1-1-99 NIL "DAVE"))
;; (store-in-csdbsym  "explore-csym3" :BIPATHS '("my-goal" NIL) )
;; works= ("explore-csym" "explore-csym" NIL ELM4-1-1-99 NIL "DAVE" :BIPATHS (("my-goal" NIL)))    EXPLORE-CSYM3   ("explore-csym" "explore-csym" NIL ELM4-1-1-99 NIL "DAVE")   "testgetsetsym"
;; Append another bipath
;; (store-in-csdbsym  "explore-csym3" :BIPATHS '("plan b" NIL) )
;; works= ("explore-csym" "explore-csym" NIL ELM4-1-1-99 NIL "DAVE" :BIPATHS (("my-goal" NIL) ("plan b" NIL)))    EXPLORE-CSYM3  
;; old-keylist= ("explore-csym" "explore-csym" NIL ELM4-1-1-99 NIL "DAVE" :BIPATHS (("my-goal" NIL)))  "testgetsetsym"
;; SUBITEM WITH 2 NODES (TENNIS *DGOAL)
;; (store-in-csdbsym  "*DGOAL" :BIPATHS '("TENNIS" NIL) :subitem "Win Tourney")
;;works=(:BIPATHS (("TENNIS" NIL :SUBITEM "Win Tourney")))  *DGOAL  NIL   "testgetsetsym"  
;;also works=  *DGOAL=> (:BIPATHS (("TENNIS" NIL :SUBITEM "Win Tourney"))) 
;; meaning of above: CSDB is *DGOAL it is linked to a NODE="TENNIS". TENNIS IS linked to GOAL with subitem (subgoal)= "Win Touurney" TENNIS also has a :BIPATHS ((*DGOAL NIL :subitem "Win Tourney") etc)
;; SECOND NODE OF LINK
;; (store-in-csdbsym  "TENNIS" :BIPATHS '("*DGOAL" NIL) :subitem "Win Tourney")
;;works= (:BIPATHS (("*DGOAL" NIL :SUBITEM "Win Tourney")))    TENNIS   NIL  "testgetsetsym"  NIL



;; (store-in-csdbsym '*DBCRITTHK8 :dbkeylist '(:wto (testsym)))
;; works = (:WTO (TESTSYM))  *DBCRITTHK8 NIL NIL
;; here
;; (store-in-csdbsym '*DBCRITTHK8 :BIPATHS 'new-bipath-item)
;; works= (:WTO (TESTSYM) :BIPATHS (NEW-BIPATH-ITEM NEW-BIPATH-ITEM))   *DBCRITTHK8  (:WTO (TESTSYM) :BIPATHS (NEW-BIPATH-ITEM))  NIL
;; (store-in-csdbsym '*DBCRITTHK8 :BIPATHS 'new-bipath-item2)
;; works= (:WTO (TESTSYM) :BIPATHS (NEW-BIPATH-ITEM NEW-BIPATH-ITEM NEW-BIPATH-ITEM2))     *DBCRITTHK8    (:WTO (TESTSYM) :BIPATHS (NEW-BIPATH-ITEM NEW-BIPATH-ITEM))    NIL






;;GET-ALL-CS-EXPLORE-DATA
;;2018
;;ddd
(defun get-all-cs-explore-data (&key (csdb-subsyms *ALL-CSDB-SUBSYMS)
                                     (cs-explore-stored-csyms *ALL-STORED-CSYMS)
                                     (return-formated-data-p T) (return-data-p T))
  "CS-explore.   RETURNS (values  formated-db-subsyms-data   formated-explore-csyms-data db-subsyms-data explore-csyms-data)   FOR USE IN SAVE. "
  (let
       ((formated-db-subsyms (format nil "~%;;*ALL-CSDB-SUBSYMS= 
       (setf *file-ALL-CSDB-SUBSYMS  '~A~% " csdb-subsyms))
       (formated-explore-csyms  (format nil "~%;;*ALL-STORED-CSYMS= 
       (setf *file-ALL-STORED-CSYMS=  '~A~% " cs-explore-stored-csyms))
       (db-subsyms-data)
       (explore-csyms-data)
       (formated-db-subsyms-data)
       (formated-explore-csyms-data)
       )
    ;;FOR DBSYMS and CSYMS
    (multiple-value-setq (formated-db-subsyms-data db-subsyms-data)
        (make-formated-save-to-file-data csdb-subsyms :title ";;*ALL-CSDB-SUBSYMS DATA" :return-formated-data-p return-formated-data-p :return-data-p return-data-p))
    (multiple-value-setq (formated-explore-csyms-data explore-csyms-data)
        (make-formated-save-to-file-data cs-explore-stored-csyms :title ";;*ALL-STORED-CSYMS DATA" :return-formated-data-p return-formated-data-p :return-data-p return-data-p))
     ;;SSSSS START HERE - FINISH GET-ALL-CS-EXPLORE-DATA 
     ;;  FOR USE IN SAVE

    (values  formated-db-subsyms-data   formated-explore-csyms-data db-subsyms-data explore-csyms-data)
    ;;end let, get-all-cs-explore-data
    ))
;;TEST
;; (setf *ALL-CSDB-SUBSYMS '(db1 db2) db1 '(db1 data) db2 '(db2 data) *ALL-STORED-CSYMS '(goal run) goal '(goal data) run '(run data))
;; (get-all-cs-explore-data)
;; works =
;;formated= ;;DATE: 2018/08/29 18:04:04  ;;*ALL-STORED-CSYMS DATA     (setf GOAL '(GOAL DATA))     (setf RUN '(RUN DATA))    
;;data= ((DB1 (DB1 DATA)) (DB2 (DB2 DATA)))    ((GOAL (GOAL DATA)) (RUN (RUN DATA)))

;; (save-csq-data-to-file

;;SAVE-CS-EXPLORE-DATA-TO-FILE
;;2018
;;ddd
(defun save-cs-explore-data-to-file (&key (filename "C:/3-TS/LISP PROJECTS TS/CogSysOutputs/cs-explore-data.lisp")  (return-formated-data-p T))
  "In CS-explore. Saves in a format of (setq sym '(data ...)). Note: cs-explore data auto saved in file in save-csq-data-to-file"
  (with-open-file (out filename :direction :output :if-exists :append
                       :if-does-not-exist :create)
    (when  (or *ALL-CSDB-SUBSYMS *ALL-STORED-CSYMS) 
      (multiple-value-bind (formated-db-subsyms-data  
                            formated-explore-csyms-data) 
          ;;not needed? db-subsyms-data explore-csyms-data)
          (get-all-cs-explore-data :csdb-subsyms *ALL-CSDB-SUBSYMS
                                   :cs-explore-stored-csyms *ALL-STORED-CSYMS
                                   :return-data-p NIL)
        ;;write to file
        (format out "~%~A~%~A~%" formated-db-subsyms-data
                formated-explore-csyms-data)
        (when return-formated-data-p
          formated-db-subsyms-data)
        ;;end mvb,when,with-open, save-cs-explore-data-to-file
        ))))
;;TEST
;;SSSSS START HERE TEST save-cs-explore-data-to-file
;; (setf *ALL-CSDB-SUBSYMS '(db1 db2) db1 '(db1 data) db2 '(db2 data) *ALL-STORED-CSYMS '(goal run) goal '(goal data) run '(run data))
;; (save-cs-explore-data-to-file) 
;;works= ;;DATE: 2018/08/29 18:08:28
;;*ALL-CSDB-SUBSYMS DATA    (setf DB1 '(DB1 DATA))     (setf DB2 '(DB2 DATA)) "
;; and appends file above




;;DELETE LATER? ===========================

#| OLD--not needed because store info in keylist in EACH CSDB SUBSYM eg *DBELM
;;STORE-CS-DB-ITEM
;;2018
;;ddd
(defun store-cs-db-item (cssym  &key (db-item-type-tree  *cs-db-item-type-tree)
                                (db-item-feature-tree  *cs-db-item-feature-tree) (dbkey :CSDB)
                                (store-in-csdbsym-p T))
  "CS-explore Stores dbsym in correct db-item-type list.  RETURNS  csym is quaoted.   INPUT: the dbsym should eval to a proper db-item-list.  Finds KEYWORD = :CSDB (HAPPY)
   CSYM evals to CSYMVALS = 
          (csname  csphrase  csdata csart-loc csdef  keywords )
   CSNAME (string) the symbol string for the meaning csphrase.
   CSPHRASE (string) The meaning phrase of the belief/value. For PCs writes a string of pole1 vs pole2
   CSDATA (list) a list.  (VALUE  etc--to be added?) Eg dif types of values etc)
   CSART-LOC: ART symbol whose symvals it is embedded in.
   CSDEF (string). EG.  "
  (let*
      ((found-db-list)
       (found-dbs)
       (dblist)
       (csymlist (eval cssym))
       (csdb-list (get-key-value dbkey csymlist))
       )
    ;;MAKE THE SEARCH DB LIST
    (when db-item-type-tree
      (setf dblist (append dblist db-item-type-tree)))
    (when db-item-feature-tree
      (setf dblist (append dblist db-item-feature-tree)))
    
    ;;FOR EACH CSDB IN csdb-list
    (loop
     for dbsym in csdb-list
     do    
    (loop
     for db in dblist
     do
     (let*
         ((searchsym (car db))
          (searchlist (second db))
          )
    (when (member dbsym searchlist :test :equal)
      (setf found-db-list (append found-db-list (list dbsym searchsym))
            found-dbs (append found-dbs (list searchsym))))

    ;;STORE THE CSYM IN THE CSDB?
    (when store-in-csdbsym-p
       (store-in-csdbsym csym dbsym))

     ;;end let,loop
     ))

    (values found-dbs  found-db-list )
    ;;end let, store-cs-db-item
    ))
;;TEST
;; (setf  expl-prob '("expl-prob" "Explore problem" :csdata nil NIL "Definition of explore problem" :CSDB (cope dm
;; (store-cs-db-item 

;; --------------------- END DELETE LATER --------------------------------
|#



;;XXX ======================= ADDITIONAL ========================

;;(make-input-questions '( "First Quest" "Second Quest") :confirm-input-p T)

;;FORMAT FOR CS-EXPLORE QVARS AND QUESTIONS FROM SHAQ/CSQ
#| 
 ;;GETNAME-P MEANT FUNCTION SHOULD ASK USER FOR THE SPECIFIC NAME eg. "John" not "Mother"
(defparameter *all-PC-element-qvars
  '((PCE-PEOPLE
     ("mother""mother"  "single-text" ("mother" "1" "motherQ" "pc-element" "Pc-Element"))
     )
  ((PCE-SELF
     ("Most-Important-Value""Most-Important-Value"  "single-text" ("Most-Important-Value" "1" "Most-Important-ValueQ" "pc-element" "pc-Element" getname-p))
     ("Your-Worst-Characteristic""Your-Worst-Characteristic"  "single-text" ("Your-Worst-Characteristic" "7" "Your-Worst-CharacteristicQ" "pc-element" "pc-Element" getname-p)) 
     :SINGLE-TEXT
     )
  "All PCE-elements for use in generating Personal Constructs. If getname-p, CSQ queries for specific name."
  ))
|#

;; PCSYMVALS LIST W/O EXPLORE ADDITIONS
;; INTIMATE= ("INTIMATE" "INTIMATE vs NOT INTIMATE" CS2-1-1-99 NIL NIL :PC ("INTIMATE" "NOT INTIMATE" 1 NIL) :POLE1 "INTIMATE" :POLE2 "NOT INTIMATE" :BESTPOLE 1 (:BIPATHS ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL BEST-M-FRIEND NIL))))


#| FROM NOTES:
:BIPATHS a list of pathlists to/from other nodes (eg. pole to/from element)
  BIPATHLIST = FOR NON-PCs only 1 node: (node-sym (data))
    [Note: PC :bipaths go to every elm, Each elm links to ONE pc pole]
        FOR PCs [either or both poles can have links] 
         eg. :bipaths ((pole1 nil (mother NIL))(pole1 nil (best-friend nil))(pole2 nil (father nil)))
        FOR ELMS TO PCS:  :bipaths (("mother" NIL (TEST-PCSYM (POLE1) NIL))
:TO a list of pathlists to other nodes eg.  (to-element ...)
  TOPATHLIST = ()
:FROM  a list of pathlists from other nodes (eg pole from element)
  FROMPATH  eg (from-element ...)
:WTO a list of weighted pathlists to other nodes
  WPATHLIST = (   )
:WFROM  a list of weighted pathlists from other nodes 
  WFROMPATH = (  )
|#
