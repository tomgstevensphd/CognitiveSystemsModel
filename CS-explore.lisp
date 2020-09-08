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
;;new: use SET-CSYM-LINK function
    4.1 ADD DATA AND TYPE TO PCSYMLIST OF PC BEING EXPLORED (mostly under (:BIPATH (:ISA (THISPC THATPC ..) 
    4.2 ADD DATA TO NEW/OLD PC ON OTHER END.
5. LATER? Fill in missing parts (eg opposite pole, best pole, value rating, etc.)
6. STORE IN MAIN PCSYMS DATABASE
|#
;;ALSO, TRY PC REPTEST ON 3 VALUES AT A TIME TO GET HIGHER ORDER
;; NOTE: My value of happiness NEVER was elicited by my taking the CS-REPTEST the first time.

;;LINKTYPES   2019-11-4
;; *ALL-CS-EXPLORE-LINK-TYPES  = (ISA PART WHY CAUSE EVID HOW EX FEAT NAME DEF DESC OPP SYN EVNT VALNK SELF OBJ SUPGL SUBGL SRCPT SIT ALT-R ACT REINF PUNISH IMG SND SENS EMOT HAP CARE ANX ANG DEP NONE)

;;$CS CATEGORIES  2019-11-4
;;*CS-CATEGORIES  '($CS $MIS $EXC $KNW $CSK $BSK $EP $ELM $PCPT $LNG $EMT $MOT $BV $TBV $WV $HISF $SLF $OBJ $PER $GRP $REFG $FAM $SCR $EVT $VER $MTH $LOG $IMG $SOND $SML $TST $TCT $HAP $CAR $ANX $ANG $DEP
;;
;; TREE 2019-11-4
#|(Defparameter   *CS-CAT-DB-TREE
  '(("$CS"   "All Main Systems"  R.$CS  :S
  (("$EXC"    "Executive"    R.$CS.$EXC    :S
    (("$TBV"       "Top Belief-Value"      R.$CS.$EXC.$TBV
      NIL       NIL      :CSS      $EXC      :CLEV      2)
     ("$WV"      "Worldview"      R.$CS.$EXC.$WV      :S
      (("$SLF" "Self" R.$CS.$EXC.$WV.$SLF NIL NIL :CSS $WV :CLEV 3)
       ("$REFG"        "Reference Group"        R.$CS.$EXC.$WV.$REFG   :S
        (("$FAM"   "Family"   R.$CS.$EXC.$WV.$REFG.$FAM
          NIL      NIL     :CSS  $REFG :CLEV  3))
        :CLEV  3))
      :CLEV  2)
     ("$CSK"  "Cognitive Skill"   R.$CS.$EXC.$CSK  :S
      (("$PS" "ProbSolv" R.$CS.$EXC.$CSK.$PS NIL NIL :CSS $CSK :CLEV 3)
       ("$DM" "DecMaking" R.$CS.$EXC.$CSK.$DM NIL NIL :CSS $CSK :CLEV 3)
       ("$PLN"        "Planning"   R.$CS.$EXC.$CSK.$PLN
        NIL    NIL   :CSS  $CSK  :CLEV  3)
       ("$COP"     "EmotCope"   R.$CS.$EXC.$CSK.$COP
        NIL  NIL :CSS             $CSK  :CLEV   3)
       ("$RESN"  "ResearchLearn"   R.$CS.$EXC.$CSK.$RESN
        NIL   NIL  :CSS  $CSK :CLEV   3))
      :CLEV  2)
     ("$BSK"   "Behavioral Skill"  R.$CS.$EXC.$BSK    :S
      (("$PEOP"    "People Skill"   R.$CS.$EXC.$BSK.$PEOP
        NIL     NIL    :CSS   $BSK   :CLEV  3)
       ("$MECH" "Mech" R.$CS.$EXC.$BSK.$MECH NIL NIL :CSS $BSK :CLEV 3)
       ("$MAIN"   "Mainenance"  R.$CS.$EXC.$BSK.$MAIN
        NIL    NIL   :CSS  $BSK :CLEV  3))
      :CLEV  2))
    :CLEV  1)
   ("$KNW" "Knowledge"  R.$CS.$KNW   :S
    (("$NSC" "NatSci" R.$CS.$KNW.$NSC NIL NIL :CSS $KNW :CLEV 3)
     ("$SSC" "SocSci" R.$CS.$KNW.$SSC NIL NIL :CSS $KNW :CLEV 3)
     ("$BSC" "BehSci" R.$CS.$KNW.$BSC NIL NIL :CSS $KNW :CLEV 3)
     ("$ART" "Art" R.$CS.$KNW.$ART NIL NIL :CSS $KNW :CLEV 3)
     ("$BUS" "Bus" R.$CS.$KNW.$BUS NIL NIL :CSS $KNW :CLEV 3)
     ("$SPT" NIL R.$CS.$KNW.$SPT NIL NIL :CSS $KNW :CLEV 3)
     ("$REC" "Recreat" R.$CS.$KNW.$REC NIL NIL :CSS $KNW :CLEV 3))
    :CLEV 1)
   ("$LNG"  "Language"   R.$CS.$LNG    :S
    (("$VER" "Verbal" R.$CS.$LNG.$VER NIL NIL :CSS $LNG :CLEV 3)
     ("$MTH" "Math" R.$CS.$LNG.$MTH NIL NIL :CSS $LNG :CLEV 3))
    :CLEV  1)
   ("$EP"  "Episode"  R.$CS.$EP   :S
    (("$SCR" "Script" R.$CS.$EP.$SCR NIL NIL :CSS $EP :CLEV 3)
     ("$EVT" "Event" R.$CS.$EP.$EVT NIL NIL :CSS $EP :CLEV 3))
    :CLEV  1)
   ("$ELM" "Element" R.$CS.$ELM    :S
    (("$PER" "Person" R.$CS.$ELM.$PER NIL NIL :CSS $ELM :CLEV 3)
     ("$OBJ" "Object" R.$CS.$ELM.$OBJ NIL NIL :CSS $ELM :CLEV 3))
    :CLEV  1)
   ("$EMT" "Emotion" R.$CS.$EMT  :S
    (("$HAP" "Happy" R.$CS.$EMT.$HAP NIL NIL :CSS $EMT :CLEV 3)
     ("$CAR" "Caring" R.$CS.$EMT.$CAR NIL NIL :CSS $EMT :CLEV 3)
     ("$ANX" "Anxiety" R.$CS.$EMT.$ANX NIL NIL :CSS $EMT :CLEV 3)
     ("$ANG" "Anger" R.$CS.$EMT.$ANG NIL NIL :CSS $EMT :CLEV 3)
     ("$DEP" "Depression" R.$CS.$EMT.$DEP NIL NIL :CSS $EMT :CLEV 3))
    :CLEV  1)
   ("$PCPT" "Percept"  R.$CS.$PCPT  :S
    (("$VER" "Verbal" R.$CS.$PCPT.$VER NIL NIL :CSS $PCPT :CLEV 3)
     ("$IMG" "Image" R.$CS.$PCPT.$IMG NIL NIL :CSS $PCPT :CLEV 3)
     ("$SOND" "Sound" R.$CS.$PCPT.$SOND NIL NIL :CSS $PCPT :CLEV 3)
     ("$SML" "Smell" R.$CS.$PCPT.$SML NIL NIL :CSS $PCPT :CLEV 3)
     ("$TST" "Taste" R.$CS.$PCPT.$TST NIL NIL :CSS $PCPT :CLEV 3)
     ("$TCT" "Tactile" R.$CS.$PCPT.$TCT NIL NIL :CSS $PCPT :CLEV 3)
     ("$BND" "Bio Need" R.$CS.$PCPT.$BND :CSS $PCPT :CLEV 3))
    :CLEV  1)
   ("$MOT" "Motor" R.$CS.$MOT NIL NIL :CSS $CS :CLEV 1)
   ("$MIS" "Misc" R.$CS.$MIS NIL NIL :CSS $CS :CLEV 1))
  :CLEV  0))
  "  *CS-CAT-DB-TREE created by MAKE-CSYM-TREE using  *MASTER-CSART-CAT-DB ")|#


;;LOAD NEEDED FILES
(LOAD  "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CS-explore-questions.lisp")



;;INITIALIZE-CS-EXPLORE
;;2018
;;ddd
(defun initialize-cs-explore (&optional (reload-user-data-p T)
                                        &key 
                                        (userdata-pathname
                                         *DEFAULT-CSQ-USERDATA-PATH)           
                                        (unbind-csyms *all-cs-explore-outputs)
                                        (unbind-nested-level 99) )
  "CS-Explore Initializes all db subsyms.  RETURNS (values unbound-vars not-unbound-vars  n-unbound-syms).  Does NOT affect link or other qvars."
  (let
      ((set-symbols-list)
       (n-all-subsyms)
       (n-unbound-syms)
       (unbound-vars)
       (not-unbound-vars)
       (current-process (mp:get-current-process))
       )
    (when unbind-csyms   
      (multiple-value-bind (unbound-vars1 not-unbound-vars1)
          (makunbound-nested-vars  unbind-csyms :unbind-level  unbind-nested-level)
        (setf unbound-vars (append unbound-vars unbound-vars1)
              not-unbound-vars (append not-unbound-vars not-unbound-vars1))))

    ;;ADD OTHER VARS, etc TO RE-INITIALIZE BELOW

    ;;RESET *DEFAULT-CSQ-USERDATA-PATH if set to NIL above
    (setf *DEFAULT-CSQ-USERDATA-PATH userdata-pathname)                                      

    (setf n-unbound-syms (list-length not-unbound-vars))
    ;;RELOAD USER DATA?
    (cond
     (reload-user-data-p  ;;here88       
                          ;;(break "reload-user-data-p")
                          (csq-initialize :use-test-qvars-p NIL
                                          :read-userdata-file-p  T
                                          :userdata-pathname userdata-pathname
                                          :if-elmsym-exists-reset-p t :unbind-csq-vars-p t
                                          :if-elmsym-exists-do-nothing-p NIL :save-all-userdata-p t)
                          ;;(break "In csq-initialize cur-proc, cur-proc")
                          )
     ;;done in csq-initialize 
     (t (run-csq-choice-interface current-process)      
        (mp:current-process-pause 1000)))

    (values unbound-vars not-unbound-vars  n-unbound-syms)
    ;;end let, initialize-cs-explore
    ))
;;TEST
;; 1. SET THE GLOBAL VARIABLES
;;   If needed:  (LOAD "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-config.lisp")
;;       (initialize-cs-explore)
;; works: unbinds and then rebinds setting to nil all *MASTER-CSART-CAT-DB
;; 2. TEST SAVING THEM TO A FILE
;; (save-csq-data-to-file "test-csdb-out.lisp"  )
;; works: prints all normal saved csq info to file along with *MASTER-CSART-CAT-DB info, what each DB SYMBOL IS SET TO.




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


;;MAKUNBOUND-EXPLORE-VARS --DEPRECIATED--UNNEEDED
;; USE MAKUNBOUND-VARS INSTEAD
;;2018
;;ddd
#|(defun makunbound-CS-explore-vars 
                                   (&key (unbind-vars *ALL-STORED-CSYMS))
                                          ;;was (append *CSYMS-DB  *ALL-CSDB-SUBSYMS
                                                  ;;*ALL-STORED-CSYMS)))                                         
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
    ))|#
;;TEST
;; (makunbound-explore-vars)

;;ANSWERS= (("HELPER") ("SMART") ("SPREAD KNOWL") ("DESIRE TO INFORM") ("EXISTS") ("FINISH SCHOOL") ("TEACHER") ("CARES ABOUT OTHERS") ("TEACHER") ("SOMEONE WHO TEACHES OTHERS") ("TEACHES GROUPS") ("PROPOGANDIST") ("TEACHER") ("COUNSELOR") ("") ("I AM ONE") ("DIPLOMA") ("WORLD MORE EDUCATED") ("DO RESEARCH") ("") ("EDUC PARENTS") ("OTHER JOBS") ("") ("FEEL GOOD RE SELF") ("LESS MONEY") ("JESUS") ("MUSIC") ("NONE"))
;; RESULTS= (("HELPER") ("SMART") ("SPREAD KNOWL") ("DESIRE TO INFORM") ("EXISTS") ("FINISH SCHOOL") ("TEACHER") ("CARES ABOUT OTHERS") ("TEACHER") ("SOMEONE WHO TEACHES OTHERS") ("TEACHES GROUPS") ("PROPOGANDIST") ("TEACHER") ("COUNSELOR") ("") ("I AM ONE") ("DIPLOMA") ("WORLD MORE EDUCATED") ("DO RESEARCH") ("") ("EDUC PARENTS") ("OTHER JOBS") ("") ("FEEL GOOD RE SELF") ("LESS MONEY") ("JESUS") ("MUSIC") ("NONE"))
;;STORED-NEWLINK-CSYMS = (SPREADKNOWL EXISTSXXX FINISHSCHOOL TEACHERXXX TEACHERXXX SOMEONEWHOTE TEACHESGROUPS PROPOGANDISTXXX JESUSXXX MUSICXXX NONEXXX)




;;CS-EXPLORE-CSYMS
;;2019
;;ddd
(defun cs-explore-csyms (csyms &key  (initialize-explore-p T)
                               (init-userdata-too-p T)
                               (cs-pole 'bestpole)                      
                        (qvars-list-name '*ALL-CSQ-QVARS)
                        (linkfrom :csym)  default-linktype2
                        (csym1dir :BIPATH) (csym2dir :BIPATH)
                        csymdata  (supsys2 '$MIS) csloc2 csdata2    
                        (set-global-vars-p T) (linkkey :lntp)
                        (all-stored-csyms-sym '*ALL-STORED-CSYMS)
                        (stored-newlink-csyms-sym '*NEWLINK-MADE-CSYMS)
                        (quests-list-name '*ALL-CSQ-QUESTIONS)
                        (make-new-csym-links-p T) (if-csym-exists :do-nothing)
                        (incl-na-none-text-button-p T)
                        confirm-input-p  
                        (min-length 3) (max-length 12) (extra-chars "xxxxxxxxxxxx") 
                        (if-exists-change-p t) (if-null-string-abort-p t) (word-separator "") 
                        cond-words-p (min-word-len 3) (phrase-min 3) (phr-word-max 5)
                        )
  "CS-explore-csyms. Uses explore qvars to generate questions and form new network links such as ISA, SUPGOAL, EMOTION, etc.   RETURNS (values all-answers all-results  all-stored-csyms  n-stored-csyms).    INPUT: CSYMS list (usually *pcsyms) CS-POLE can be (:bestpole, 'bestpole, nil);  'pole1; 'pole2; or 'bothpoles. NOTE: :MULTI-ITEM means a popup with multiplel answers to choose from; 'MULTI-TEXT' means multiple popups each requiring a separate text answer. 
    :LINKFROM [sets csym1]  :QVAR sets csym1 from qvars-list-name OR  :CSYM sets csym1 = csym in arglist."
  ;;INITIALIZE THE SYSTEM?
  (when initialize-explore-p
    (initialize-cs-explore init-userdata-too-p))

  (let
      ((all-answers)
       (all-results)
       (all-stored-csyms)
       (n-stored-csyms)
       )
    (when (and (symbolp csyms)(boundp csyms))
      (setf csyms (eval csyms)))
    (when (listp csyms)
    (loop
     for csym in csyms
     do
       (multiple-value-bind (answers1 results1  all-stored-csyms1)
           (cs-explore csym  NIL  :cs-pole cs-pole :qvars-list-name qvars-list-name 
                       :linkfrom linkfrom :default-linktype2  default-linktype2
                       :csym1dir csym1dir :csym2dir csym2dir
                       :csymdata csymdata  :supsys2 supsys2 :csloc2 csloc2 :csdata2  csdata2    
                       :set-global-vars-p set-global-vars-p :linkkey linkkey
                       :all-stored-csyms-sym all-stored-csyms-sym
                       :stored-newlink-csyms-sym stored-newlink-csyms-sym
                       :quests-list-name quests-list-name
                       :make-new-csym-links-p make-new-csym-links-p
                       :if-csym-exists if-csym-exists
                       :incl-na-none-text-button-p incl-na-none-text-button-p
                       :min-length min-length :max-length max-length
                       :extra-chars extra-chars :if-exists-change-p if-exists-change-p
                       :if-null-string-abort-p if-null-string-abort-p
                       :word-separator word-separator :cond-words-p cond-words-p
                       :min-word-len min-word-len :phrase-min phrase-min
                       :phr-word-max phr-word-max
                       )
         ;;accumulate
         (setf all-answers (append all-answers (list answers1))
               all-results (append all-results (list results1))
               all-stored-csyms (append all-stored-csyms (list all-stored-csyms1)))
         ;;end mvb,loop
         ))
    (setf n-stored-csyms (list-length all-stored-csyms))
    (values all-answers all-results  all-stored-csyms  n-stored-csyms)
    ;;end when, let, cs-explore-csyms
    )))
;;TEST
;; (cs-explore-csyms '(RESPECTED SEEKEXTERNALAPPROV));;  *pcsyms)




;;FOR TESTING ONLY? SET *DEFAULT-CSQ-USERDATA-PATH
 (when (null *DEFAULT-CSQ-USERDATA-PATH)
   (setf *DEFAULT-CSQ-USERDATA-PATH 
         "C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\Tom-AllData2019-10.lisp"))

;;CS-EXPLORE  
;;2018-08
;;ddd
(defun cs-explore (csym &optional initialize-explore-p &key (init-userdata-too-p T) 
                        (cs-pole 'bestpole)      
                        (cur-qvar-syms '(ISA WHY EX EMOT)) ;; *CUR-CS-EXPLORE-QVAR-SYMS)
                        (qvars-list-name '*ALL-CS-EXPLORE-QVARS) ;;all qvarlists
                        (all-questions-list *all-csq-questions)
                        (linkfrom :csym)  default-linktype2
                        (csym1dir :BIPATH) (csym2dir :BIPATH)
                        csymdata  (supsys2 '$MIS) csloc2 csdata2    
                        (set-global-vars-p T) (linkkey :lntp)
                       (all-stored-csyms-sym '*ALL-STORED-CSYMS)
                        (stored-newlink-csyms-sym '*NEWLINK-MADE-CSYMS)                        (quests-list-name '*ALL-CSQ-QUESTIONS)
                        ;;was '*All-CS-exploreQs)  ;;was (store-key :BIPATH)
                        (make-new-csym-links-p T) (if-csym-exists :do-nothing)
                        (incl-na-none-text-button-p T)
                        confirm-input-p  
                        (min-length 3) (max-length 12) (extra-chars "xxxxxxxxxxxx") 
                        (if-exists-change-p t) (if-null-string-abort-p t) (word-separator "") 
                        (multi-item-selection-types '(:multi-item 'multi-item))
                        cond-words-p (min-word-len 3) (phrase-min 3) (phr-word-max 5)
                        record-blank-answers-p
                        )         ;;was (csdb-pre "*DB"))
                         ;;not needed, done in store- (track-all-stored-csyms-p T))
   "CS-explore. Uses explore qvars to generate questions and form new network links such as ISA, SUPGOAL, EMOTION, etc.   RETURNS (values  answers results  all-stored-csyms).    INPUT:  CS-POLE can be (:bestpole, 'bestpole, nil);  'pole1; 'pole2; or 'bothpoles. NOTE: :MULTI-ITEM means a popup with multiplel answers to choose from; 'MULTI-TEXT' means multiple popups each requiring a separate text answer. 
    :LINKFROM [sets csym1]  :QVAR sets csym1 from qvars-list-name OR  :CSYM sets csym1 = csym in arglist.
   NOTE: ALL new csyms are stored in *ALL-STORED-CSYMS-FILE (DATED)
   note: If INITIALIZE-EXPLORE-P ,also INIT-USERDATA-TOO-P or some csyms will be undefined.  
  PATHw/links FORMAT: 1. ((csym2 data2) :lntp link linkdata) egs. ((RESEARCH-EV) :LNTP :HOW),  2. (poleX1 data1 (polex2 csym2 data) :lntp link linkdata), 3. combo if 1 & 2."   
  ;;INITIALIZE THE SYSTEM?
  ;; 1. for testing only??
  (when (null *DEFAULT-CSQ-USERDATA-PATH)
   (setf *DEFAULT-CSQ-USERDATA-PATH 
         "C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\Tom-AllData2019-10.lisp"))
  ;;2. INITIALIZE
  (when initialize-explore-p
    (initialize-cs-explore init-userdata-too-p))
  (let*
      ((outputs)
       (cs-phrase (cond
                   ((member cs-pole '( :bestpole bestpole NIL) :test 'my-equal)
                    (get-cs-bestpole-name csym))
                   ((equal cs-pole 'bothpoles)
                    (second (eval csym)))
                   ((equal cs-pole 'pole1)
                    (get-cs-pole-name csym))
                   ((equal cs-pole 'pole2)
                    (get-cs-pole-name csym :pole-n 2))))                   
       (all-qvarlists (eval qvars-list-name))
       (all-quests (eval quests-list-name))       
       (answers)
       (results)
       ;;note: following 2 start as equal lists
       (all-stored-csyms (eval stored-newlink-csyms-sym))
       (stored-newlink-csyms (eval stored-newlink-csyms-sym))                         
       )
    ;;SET THE DEFAULT *cur-all-questions and *cur-qvarlists
    (setf *cur-qvarlists qvars-list-name
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
     for qvar in cur-qvar-syms
     do
     (let*
         ((n-qvars (list-length cur-qvar-syms))
          (ans-type)
          ;;(qvar-str)  ;; (car (second catlist)))
          (mult-ans)
          (current-qvar)
          (csyms)  ;;was
          ;;(stored-csdbsyms)
          (new-csym1-val)
          (new-csym2-val)
          (new-csym1-symvals)
          (new-csym2-symvals)
          (stored-csyms)
          (qvars-list  (eval qvars-list-name))
          )
       ;;GET QVAR INFO 
#| OLD- PRE GET-QUESTION-INFO      (multiple-value-bind (qvar qvar-string selection-type multi-item-p q-num 
       q-frame-inst linktype1X linktype2X test-result qvarlist compare-3
       deflist-selection-typeX num-answersX answer-array-OK scored-reverse-pX
       frame-name-textX instrsX ans-instruction-textX title-text-formatedX
       instruction-textX   instr-text-formatedX  q-text-sym question-text-listX
       question-text-formatedX answer-array-listX ans-values-listX
                 INFO-TEXT-VERSION)
           (get-qvar-quest-info qvar :all-qvarlists qvars-list
                               :return-text-version-p NIL)
  (qvar qvar-string label q-title selection-type  q-instr-out q-text-out   text-input-box1-instrs text-input-box2-instrs   q-instr-list  q-text-list    ans-name-list ans-text-list  ans-data-list ans-xdata-lists  num-answers    linktype1  linktype2 supsys subsys   sub-linktype1 sub-linktype2 ANSWER-QVARLISTS  reversed-item-p item-norm-or-rev)

|#
  ;;not? multi-item-p q-num, q-frame-inst, test-result. qvarlist, compare-3 INFO-TEXT-VERSION
  (multiple-value-bind (qvar qvar-string label  title-text-formated selection-type  instr-text-formated question-text-formated    text-input-box1-instrs text-input-box2-instrs   q-instr-list  q-text-list    ans-name-list ans-text-list  ans-data-list ans-xdata-lists  num-answers    linktype1  linktype2 supsys subsys   sub-linktype1 sub-linktype2 ANSWER-QVARLISTS  reversed-item-p item-norm-or-rev  qvarlist multi-item-p)
       (get-question-info qvar T :all-qvarlists all-qvarlists :all-questions-list all-questions-list)
      (break "In CS-Explore, qvar before selection-type cond")
       (cond
        ;;IS Q MULTI-ITEM QUESTION
        ;;STEP 1: MAKE THE QUESTIONS, ETC FROM QVARS
        ;;FOR :MULTI-ITEM QUESTS
        ( multi-item-p 
         (setf current-qvar  qvar
               *current-qvarlist qvarlist
               ;;added
               cur-linktype linktype)
         (unless default-linktype2
           (setf linktype2 cur-linktype))
         ;;was (my-make-keyword  current-qvar))
         ;;(break "BEFORE make-question-frame FIRST")
         (make-question-frame current-qvar NIL ;;arg not used in def
                              :incl-na-none-text-button-p incl-na-none-text-button-p
                              :csq-frame-pane1-title CS-PHRASE ;;added to list variable
                              :all-qvarlists  all-qvarlists ;;was *current-qvarlist
                              :compare-3elms-p NIL) ;;CS-PHRASE

         ;;PAUSE 
         (mp:current-process-pause 100)
         ;;(break "AFTER pause for make-question-frame")

         ;;COLLECT THE ANSWERS
         (loop
          for ans in (cddr *quest-frame-results-list-brief)
          do
          ;;Was the quest item selected ("answer 1" T 1) or not ("answer2" NIL 0)?
          (when (second ans)
            (setf mult-ans (append mult-ans (list (car ans))))

            ;;MAKE-CSLINK; (STORE THE ANS) ;;csdbsym to csym
            (let*
                ((csym2str  (format nil "~A"  (car ans))) ;; was csdbstr, csdb-pre ans
                 (csym2 (my-make-cs-symbol csym2str)) ;;csdbsym,  str
                 (csym2-exists-p (and (boundp csym)(listp csym)
                                      (> (list-length csym) 2)))
                 )
              (when make-new-csym-links-p
                (unless (and (boundp csym2)
                             (equal if-csym-exists :do-nothing))
                  ;;note: mvs values not used??
                  (multiple-value-setq (new-csym1-val new-csym2-val 
                                                      new-csym1-symvals new-csym2-symvals)
                      (make-csym-link csym csym2 CUR-LINKTYPE linktype2
                                      :csym1dir  CSYM1DIR :csym2dir CSYM2DIR 
                                      :csdata2 csdata2
                                      :supsys2 SUPSYS2 :csloc2 CSLOC2))
                  ;;append all-stored-csyms return list
                  (setf all-stored-csyms (append all-stored-csyms (list csym2)))
                  ;;(break "new-csym2-symvals")
                  ;;end unless,when, let,when,loop
                  )))))
         (setf answers (append answers (list mult-ans))
               results (append results (list (list qvar-string
                                                   *quest-frame-results-list-brief))))
         ;; all-stored-csdb-syms (append all-stored-csdb-syms (list csdbsyms))
         ;;(break "END of store mult-ans answers")
         ;;end multi-item cat
         )
        ;;FOR TEXT-INPUT ANSWERS (single-text and multi-text)
        (T       
          (let*
              (;;given (qvar (car qvarlist))
               (csym1str (cond ((equal linkfrom :csym) csym)
                               (t qvar)))                               
               ;;(type (third qvarlist));;now selection-type
               (csym1 (my-make-cs-symbol csym1str))
               ;;above (linktype  (get-key-value linkkey qvarlist))
               (linktype2)
               (csym2)
               ;;was (my-make-keyword  CSYMSTR))
               ;;eg "ISA" is both csym and linktype             
               (answer)
               (result)
               (csym2-exists-p (and (boundp csym1)
                                    (> (list-length (eval csym1)) 2)))
               )
            ;;Set global vars for text-go-button-callback
            (setf  *current-qvar  csym1str
                   *current-qvarlist qvarlist)
            ;;linktype2
            (unless linktype2
              (setf linktype2 linktype1))
            ;;(break "before frame in all other type items")

            (cond
             ;;1. MAKE SINGLE-TEXT FRAME
             ((member selection-type '(:single-text "single-text") :test 'my-equal)
              ;;(break "Before single-input make-question-frame")
              ;;HEREBB
              (make-question-frame (string linktype1)
                                   'scale-sym :quest-frame 'frame-csq
                                   :incl-na-none-text-button-p incl-na-none-text-button-p
                                   :all-qvarlists all-qvarlists
                                   :compare-3elms-p NIL)       
              ;;(make-question-frame "isa"   'scale-sym :quest-frame 'frame-csq                                                           :incl-na-none-text-button-p T    :all-qvarlists all-qvarlists     :compare-3elms-p NIL)
              ;;(break "single input text before pause")
              ;;PAUSE 
              (mp:current-process-pause 100)

              ;;COLLECT THE ANSWERS
              (setf answer *text-input-frame-text-answers
                    answers (append answers (list answer))
                    results (append results 
                                    (list (list csym1str answer))))     
              ;;(break "answers results")
              ;;2019
              ;;MAKE NEW CSYM2? AND CSYM-CSYM2 LINK
              ;; note: answers eg= (("HELPER" "") ("SPREAD KNOWLEDGE"))
              (unless (and (null record-blank-answers-p)
                           (or (null answer)  
                               (member answer '("" ("") (nil)) :test 'my-equal)))
                (setf csym2   ;was (caar (last answers))
                      (make-condensed-sym (car answer)  :set-to-value-p NIL
                                          :if-exists-change-p if-exists-change-p
                                          :if-null-string-abort-p if-null-string-abort-p      
                                          :word-separator word-separator
                                          :cond-words-p cond-words-p
                                          :min-word-len min-word-len 
                                          :phrase-min phrase-min
                                          :phr-word-max phr-word-max))
                ;;note: mvs values not used?
                (multiple-value-setq (new-csym1-val new-csym2-val
                                                    new-csym1-symvals new-csym2-symvals)
                    (make-csym-link csym csym2 linktype1 linktype2
                                    :csym1dir csym1dir :csym2dir csym2dir 
                                    :csdata2 csdata2 :supsys2 supsys2 :csloc2 csloc2))
                ;;(break "after make-csym-link")
                                     
                ;;APPEND STORED SYMS LISTS
                (setf  all-stored-csyms 
                       (append all-stored-csyms (list csym1 csym2)))

                (when (null csym2-exists-p)
                  (setf  stored-newlink-csyms 
                         (append stored-newlink-csyms (list csym2))))
                ;;end unless no answer, :single-text
                ))
             ;;2. MAKE-MULTI-INPUT-FRAMES 
             ;;FOR MULTI-TEXT INPUT QVARS  
             ((member selection-type '("multi-text" :multi-text) :test 'my-equal)
              (setf result nil) ;;here77 
                ;;set callback global vars
                (setf  *current-qvar  qvar ;; csym1str
                       *current-qvarlist qvarlist)
                ;;SSSSSS START HERE DEBUG NO INST-TEXT-FORMATED ETC?
                ;;MAYBE NOT NEEDED FOR THESE FRAMES--SEEM TO WORK??
                ;; NOT FINDING IT BEC NO :MULTI-TEXT IN MAKE-QUESTION-FRAME?
                ;;(break "before make multi") 
                (make-multi-input-frames 
                 (list (list question-text-formated) title-text-formated 'input-or-buttons
                       instr-text-formated) 
                 :incl-na-none-button-p incl-na-none-text-button-p
                 :win-title *CSQ-frame-title 
                 :win-background #(:RGB 0.5019608 1.0 0.0 1.0)
                 :win-args '(:x 20 :y 20 :visible-max-height 250)
                 :quest-pane-ht 20 :quest-border 20
                 :quest-font-size 14 :quest-font-color :red
                 :special-process (mp:get-current-process)
                 :poke-special-process-p T
                 :confirm-input-p NIL )
                ;;PAUSE- NOT NEEDED; pause in  make-multi-input-frames that 
                ;;    keeps control from passing to here?

                ;;COLLECT THE ANSWERS
                (setf answer  *temp-all-multi-input-outputs
                      result (list  linktype1 *temp-all-multi-input-outputs))
                (when (or record-blank-answers-p
                          (not (or (null answer)  
                                 (member answer '("" ("") (nil)) :test 'my-equal))))
                  (setf  answers (append answers  (list answer))
                         results (append results (list result) )))
             
                ;;MAKE/FIND NEW CSYMS FOR EACH ANSWER
                ;;MAKE NEW CSYM2? AND CSYM-CSYM2 LINK
                ;; note: answers eg= (("HELPER" "") ("SPREAD KNOWLEDGE"))
                ;;(break "Before multi-text loop, make-new-csym-links-p")
                (when make-new-csym-links-p 
                  (loop
                   for ans in answers  ;;wasans in answers
                   do
                   (let*
                       (;;(res2 (car (second result)))
                        (cur-csym2 
                         (make-condensed-sym ans :set-to-value-p NIL
                                             :if-exists-change-p if-exists-change-p
                                             :if-null-string-abort-p if-null-string-abort-p      
                                             :word-separator word-separator
                                             :cond-words-p  cond-words-p
                                             :min-word-len min-word-len 
                                             :phrase-min phrase-min
                                             :phr-word-max phr-word-max))
                        )
                     ;;note: mvb return values NOT USED
                     ;;(break "BEFORE MAKE-CSYM-LINK")
                     (unless (and (boundp cur-csym2) 
                                  (equal if-csym-exists :do-nothing))
                       (multiple-value-bind (new-csym1-val new-csym2-val 
                                                           new-csym1-symvals new-csym2-symvals)
                           (MAKE-CSYM-LINK csym cur-csym2 linktype1 linktype2
                                           :csym1dir csym1dir :csym2dir csym2dir 
                                           :csdata2 csdata2
                                           :supsys2 supsys2 :csloc2 csloc2)

                         ;;APPEND ALL-STORED-CSYMS RETURN LIST
                         (setf all-stored-csyms (append all-stored-csyms (list cur-csym2)))
                         ;;(break "End of multi-text")
                         ;;(break "end make-csym-link")
                         ;;end mvb,let,loop
                         )))                                         
                   ;;end  loop, when,  "mult-text"
                   )))
             (t nil))
            ;;end let, t ,cond
            )))
       ;;end mvb,let, loop
       )))
    ;;SS START HERE - LATER PUT IN GRAPHIC NETWORK?

    ;;global var set in case need for callbacks etc
    (setf *all-CS-explore-outputs (list answers results)) ;;all-stored-csdb-syms))
    ;;KEEP TRACK of new  nodes, etc USING GLOBAL VARS
    ;;not needed  (setf    all-stored-csyms)
    (when set-global-vars-p
      (set stored-newlink-csyms-sym stored-newlink-csyms)
      (set all-stored-csyms-sym all-stored-csyms))
    
    (values  answers results  all-stored-csyms)
    ;;end let, cs-explore
    ))
;;TEST
;;test for making link answer symbols
;; (cs-explore '(emot) 
;; OUTPUT=  all-stored-csyms-sym= '*ALL-STORED-CSYMS)
;;                        stored-newlink-csyms-sym=  '*NEWLINK-MADE-CSYMS
;; DO FULL TEST ON AUTONOMOUS--JUST ADD T AS BELOW
;; FIRST RESET THE VARIABLES (initialize-cs-explore
;;==> (cs-explore 'AUTONOMOUS)
;; TO RESET ALL VARS FIRST=> (cs-explore 'AUTONOMOUS T)
;; RESULTS of complete test: [left out early questions for some reason-- bec of break??
;;answers= (("FREEDOM") ("RESEARCH EVID") ("DID IT MY WAY") ("INDEPENDENCE") ("FOLLOW OWN BELIEFS,VALUES, GOALS") ("OWN WAY AGAINST PRESSURE") ("EXTERNAL CONTROL") ("EATING XPC") ("LAUGH") ("NONE") ("HAP" "CARE"))
;;results= ((AUTONOMOUS ("FREEDOM")) (AUTONOMOUS ("RESEARCH EVID")) (AUTONOMOUS ("DID IT MY WAY")) (AUTONOMOUS ("INDEPENDENCE")) (AUTONOMOUS ("FOLLOW OWN BELIEFS,VALUES, GOALS")) (AUTONOMOUS ("OWN WAY AGAINST PRESSURE")) (AUTONOMOUS ("EXTERNAL CONTROL")) (AUTONOMOUS ("EATING XPC")) (AUTONOMOUS ("LAUGH")) (AUTONOMOUS ("NONE")) ("EMOT" ("EMOT" 1 ("HAP" T 1) ("CARE" T 1) ("ANX" NIL 0) ("ANG" NIL 0) ("DEP" NIL 0) ("NONE" NIL 0))))
;; all-stored-csyms= (NIL FREEDOM NIL RESEARCHEVID RESEARCH-EV NIL DIDITMYWAY8 RESEARCH-EV8 DID-IT-MY-W3 NIL INDEPENDENCE NIL FOLLOWOWNBEL NIL OWNWAYAGAINS NIL EXTERNALCONT RESEARCH-EV2 DID-IT-MY-W5 INDEPENDENC FOLLOW-OWN- OWN-WAY-AGA EXTERNAL-CO RESEARCH-EV4 INDEPENDENC6 FOLLOW-OWN-1 OWN-WAY-AGA5 EXTERNAL-CO5 RESEARCH-EV1 DID-IT-MY-W2 INDEPENDENC8 FOLLOW-OWN-3 OWN-WAY-AGA0 EXTERNAL-CO6 INDEPENDENC4 OWN-WAY-AGA4 EXTERNAL-CO4 DID-IT-MY-W7 INDEPENDENC1 FOLLOW-OWN-6 DID-IT-MY-W1 FOLLOW-OWN-7 OWN-WAY-AGA3 EXTERNAL-CO8 RESEARCH-EV0 DID-IT-MY-W8 FOLLOW-OWN-8 OWN-WAY-AGA8 RESEARCH-EV5 DID-IT-MY-W4 FOLLOW-OWN-0 OWN-WAY-AGA1 EXTERNAL-CO2 DID-IT-MY-W0 INDEPENDENC5 FOLLOW-OWN-4 EXTERNAL-CO0 OWN-WAY-AGA2 RESEARCH-EV6 NIL EATINGXPC NIL LAUGH NIL NONE HAP CARE)
;;ALSO,  AUTONOMOUS=
;;paths w/ linktypes:  ("AUTONOMOUS" "AUTONOMOUS vs NOT AUTONOMOUS" CS2-1-1-99 NIL NIL :PC ("AUTONOMOUS" "NOT AUTONOMOUS" 1 NIL) :POLE1 "AUTONOMOUS" :POLE2 "NOT AUTONOMOUS" :BESTPOLE 1 :BIPATH ((POLE1 NIL F-ADMIRE NIL) (POLE1 NIL PER-ROMANCE NIL) (POLE2 NIL CHILD-DISLIKE NIL) ((FREEDOM) :LNTP :WHY) ((RESEARCHEVID) :LNTP :EVID) ((RESEARCH-EV) :LNTP :HOW) ((DIDITMYWAY8) :LNTP :EX) ((RESEARCH-EV8) :LNTP :FETR) ((DID-IT-MY-W3) :LNTP :FETR) ((INDEPENDENCE) :LNTP :NAME) ((FOLLOWOWNBEL) :LNTP :DEF) ((OWNWAYAGAINS) :LNTP :DESC) ((EXTERNALCONT) :LNTP :OPP) ((RESEARCH-EV2) :LNTP :SYN) ((DID-IT-MY-W5) :LNTP :SYN) ((INDEPENDENC) :LNTP :SYN) ((FOLLOW-OWN-) :LNTP :SYN) ((OWN-WAY-AGA) :LNTP :SYN) ((EXTERNAL-CO) :LNTP :SYN) ((RESEARCH-EV4) :LNTP :EVT) ((INDEPENDENC6) :LNTP :EVT) ((FOLLOW-OWN-1) :LNTP :EVT) ((OWN-WAY-AGA5) :LNTP :EVT) ((EXTERNAL-CO5) :LNTP :EVT) ((RESEARCH-EV1) :LNTP :VALNK) ((DID-IT-MY-W2) :LNTP :VALNK) ((INDEPENDENC8) :LNTP :VALNK) ((FOLLOW-OWN-3) :LNTP :VALNK) ((OWN-WAY-AGA0) :LNTP :VALNK) ((EXTERNAL-CO6) :LNTP :VALNK) ((INDEPENDENC4) :LNTP :SELFLNK) ((OWN-WAY-AGA4) :LNTP :SELFLNK) ((EXTERNAL-CO4) :LNTP :SELFLNK) ((DID-IT-MY-W7) :LNTP :OBJLNK) ((INDEPENDENC1) :LNTP :OBJLNK) ((FOLLOW-OWN-6) :LNTP :OBJLNK) ((DID-IT-MY-W1) :LNTP :SUPG) ((FOLLOW-OWN-7) :LNTP :SUPG) ((OWN-WAY-AGA3) :LNTP :SUPG) ((EXTERNAL-CO8) :LNTP :SUPG) ((RESEARCH-EV0) :LNTP :SUBG) ((DID-IT-MY-W8) :LNTP :SUBG) ((FOLLOW-OWN-8) :LNTP :SUBG) ((OWN-WAY-AGA8) :LNTP :SUBG) ((RESEARCH-EV5) :LNTP :SCPT) ((DID-IT-MY-W4) :LNTP :SCPT) ((FOLLOW-OWN-0) :LNTP :SIT) ((OWN-WAY-AGA1) :LNTP :SIT) ((EXTERNAL-CO2) :LNTP :SIT) ((DID-IT-MY-W0) :LNTP :ALTR) ((INDEPENDENC5) :LNTP :ALTR) ((FOLLOW-OWN-4) :LNTP :ALTR) ((EXTERNAL-CO0) :LNTP :ALTR) ((OWN-WAY-AGA2) :LNTP :ACT) ((RESEARCH-EV6) :LNTP :PUNISH) ((EATINGXPC) :LNTP :IMG) ((LAUGH) :LNTP :SND) ((NONE) :LNTP :SENS) ((HAP)) ((CARE))))

;;SSSSSS FINISH TESTING THE CS-EXPLORE FUNCTION AND FINISH IT
;; SSSSSS IN FOLLOWING, ISA WAS ANSWERED BUT NOT RECORDED!!
;; (cs-explore 'GROUPKNOWLEDGEWORK T) FOR '(ISA EX EMOT)
;; works= (("WHY") ("EXAMPLE") ("HAP" "ANX"))    
;;((GROUPKNOWLEDGEWORK ("WHY")) (GROUPKNOWLEDGEWORK ("EXAMPLE")) (EMOT ("EMOT" 1 ("HAP" T 1) ("CARE" NIL 0) ("ANX" T 1) ("ANG" NIL 0) ("DEP" NIL 0) ("NONE" NIL 0))))
;;;(NIL WHY NIL EXAMPLE HAP ANX)
;; GLOBAL VARS SET:
;; *ALL-STORED-CSYMS = (NIL WHY NIL EXAMPLE HAP ANX)
;; *NEWLINK-MADE-CSYMS = (WHY EXAMPLE)
;;ALSO CSYMS
;; GROUPKNOWLEDGEWORK = ("GROUPKNOWLEDGEWORK" "GROUP KNOWLEDGE WORKER vs NOT GROUP KNOWL WORK" CS2-1-1-99 NIL NIL :PC ("GROUP KNOWLEDGE WORKER" "NOT GROUP KNOWL WORK" 1 NIL) :POLE1 "GROUP KNOWLEDGE WORKER" :POLE2 "NOT GROUP KNOWL WORK" :BESTPOLE 1 :BIPATH ((POLE1 NIL TEACHER NIL) (POLE1 NIL SCIENTIST NIL) (POLE2 NIL JEWS NIL) ((WHY) :LNTP :WHY) ((EXAMPLE) :LNTP :EX) ((HAP)) ((ANX))))
;;WHY = ("WHY" "WHY" $MIS.WHY NIL NIL :CSS $MIS :BIPATH ((GROUPKNOWLEDGEWORK) :LNTP :WHY))


;;ALSO
;; GROUPKNOWLEDGEWORK=  
#|("GROUPKNOWLEDGEWORK"
 "GROUP KNOWLEDGE WORKER vs NOT GROUP KNOWL WORK"
 CS2-1-1-99
 NIL
 NIL
 :PC
 ("GROUP KNOWLEDGE WORKER" "NOT GROUP KNOWL WORK" 1 NIL)
 :POLE1
 "GROUP KNOWLEDGE WORKER"
 :POLE2
 "NOT GROUP KNOWL WORK"
 :BESTPOLE
 1
 :BIPATH
 ((POLE1 NIL TEACHER NIL)
  (POLE1 NIL SCIENTIST NIL)
  (POLE2 NIL JEWS NIL)

  ((SPREADKNOWL) :LNTP :WHY)
  ((SPREAD-KNOW) :LNTP :CAUS)
  ((THEYEXIST) :LNTP :EVID)
  ((SPREAD-KNOW7) :LNTP :HOW)
  ((THEY-EXIST) :LNTP :HOW)
  ((TEACHER8) :LNTP :EX)
  ((SPREAD-KNOW5) :LNTP :FETR)
  ((TEACHER6) :LNTP :NAME)
  ((TEACHOTHERS) :LNTP :DEF)
  ((SPREADSKNOWL) :LNTP :DESC)
  ((TRUMP) :LNTP :OPP)
  ((SPREAD-KNOW0) :LNTP :SYN)
  ((TEACH-OTHER) :LNTP :SYN)
  ((SPREADS-KNO) :LNTP :SYN)
  ((TEACH-OTHER5) :LNTP :EVT)
  ((SPREADS-KNO6) :LNTP :EVT)
;;note: SPREADS-KNO6  = ("SPREADS-KNO6" "SPREADS-KNO6" $MIS.SPREADS-KNO6 NIL NIL :CSS $MIS :BIPATH ((GROUPKNOWLEDGEWORK) :LNTP :EVT))
  ((TEACH-OTHER2) :LNTP :VALNK)
  ((SPREADS-KNO4) :LNTP :VALNK)
  ((SPREAD-KNOW6) :LNTP :SELFLNK)
  ((TEACH-OTHER7) :LNTP :SELFLNK)
  ((SPREADS-KNO7) :LNTP :SELFLNK)
  ((TEACH-OTHER8) :LNTP :OBJLNK)
  ((SPREADS-KNO8) :LNTP :OBJLNK)
  ((TEACH-OTHER4) :LNTP :SUPG)
  ((TEACH-OTHER0) :LNTP :SUBG)
  ((SPREADS-KNO0) :LNTP :SUBG)
  ((SPREAD-KNOW3) :LNTP :SCPT)
  ((SPREAD-KNOW2) :LNTP :SIT)
  ((TEACH-OTHER1) :LNTP :ACT)
  ((SPREAD-KNOW8) :LNTP :REINF)
  ((TEACH-OTHER6) :LNTP :REINF)
  ((SPREADS-KNO1) :LNTP :REINF)
  ((TEACH-OTHER3) :LNTP :PUNISH)
  ((COMPUTER) :LNTP :IMG)
  ((NONE2) :LNTP :SND)
  ((NONE7) :LNTP :SENS)))|#
;;SSSSSS START HERE PROBLEM, EG. COUNSELING GIVEN AS ANS DOESN'T SHOW UP ABOVE--INSTEAD MULTIPLE EG TEACH-OTHER8 & SPREAD-KNOW

;;TO RESET GROUPKNOWLEDGEWORK
;; (setf groupknowledgework   '("GROUPKNOWLEDGEWORK" "GROUP KNOWLEDGE WORKER vs NOT GROUP KNOWL WORK" CS2-1-1-99 NIL NIL :PC ("GROUP KNOWLEDGE WORKER" "NOT GROUP KNOWL WORK" 1 NIL) :POLE1 "GROUP KNOWLEDGE WORKER" :POLE2 "NOT GROUP KNOWL WORK" :BESTPOLE 1  :va "0.583" :RNK 1))
;; (cs-explore 'groupknowledgework)
;; RESULTS
;;answers=  (("SPREAD KNOWL") ("THEY EXIST") ("TEACHER") ("TEACHER") ("TEACH OTHERS") ("SPREADS KNOWL") ("TRUMP") ("COMPUTER") ("NONE") ("NONE") ("HAP" "CARE"))
;;results= ((GROUPKNOWLEDGEWORK ("SPREAD KNOWL")) (GROUPKNOWLEDGEWORK ("THEY EXIST")) (GROUPKNOWLEDGEWORK ("TEACHER")) (GROUPKNOWLEDGEWORK ("TEACHER")) (GROUPKNOWLEDGEWORK ("TEACH OTHERS")) (GROUPKNOWLEDGEWORK ("SPREADS KNOWL")) (GROUPKNOWLEDGEWORK ("TRUMP")) (GROUPKNOWLEDGEWORK ("COMPUTER")) (GROUPKNOWLEDGEWORK ("NONE")) (GROUPKNOWLEDGEWORK ("NONE")) ("EMOT" ("EMOT" 1 ("HAP" T 1) ("CARE" T 1) ("ANX" NIL 0) ("ANG" NIL 0) ("DEP" NIL 0) ("NONE" NIL 0))))
;; all-stored-csyms= (NIL SPREADKNOWL SPREAD-KNOW NIL THEYEXIST SPREAD-KNOW7 THEY-EXIST NIL TEACHER8 SPREAD-KNOW5 NIL TEACHER6 NIL TEACHOTHERS NIL SPREADSKNOWL NIL TRUMP SPREAD-KNOW0 TEACH-OTHER SPREADS-KNO TEACH-OTHER5 SPREADS-KNO6 TEACH-OTHER2 SPREADS-KNO4 SPREAD-KNOW6 TEACH-OTHER7 SPREADS-KNO7 TEACH-OTHER8 SPREADS-KNO8 TEACH-OTHER4 TEACH-OTHER0 SPREADS-KNO0 SPREAD-KNOW3 SPREAD-KNOW2 TEACH-OTHER1 SPREAD-KNOW8 TEACH-OTHER6 SPREADS-KNO1 TEACH-OTHER3 NIL COMPUTER NIL NONE2 NIL NONE7)

;;  USE   *TEST-CS-EXPLORE-BRIEF to test only 1 or 2 qvars
;; (cs-explore 'GROUPKNOWLEDGEWORK  :qvars-list-name '*TEST-CS-EXPLORE-BRIEF )
;; results = ((:EVT ("this is another test")))   (TEACHER2XXX TEACHER2XXX TRUMPXXX JESUSXXX THISISANOTHE)
;  THISISANOTHE =  ("THISISANOTHE" "THISISANOTHE" $MIS NIL NIL :CSS $MIS (:BIPATH ((GROUPKNOWLEDGEWORK) :LNTP :EVT)))
;;  (SETF  *TEST-CS-EXPLORE-BRIEF   '((CS-DECLARATIVE ("EX" "EXAMPLE" "single-text" ("EG" "7" "EXQ" "$KNW" "$KNW") NIL NIL :LNTP :EX))(EMOTION ("EMOTION" "EMOTION" NIL NIL (:TITLE ("   TYPE OF EMOTION") :QUEST ("    Select the EMOTION(S) that is/are MOST strongly associated with this item")) (:HELP NIL NIL) NIL :MULTI-ITEM) ("HAP" "HAPPY" "spss-match" NIL ("  HAPPY") (:HELP NIL NIL) :CSS "$HAP" :MULTI-ITEM) ("CARE" "CARING" "spss-match" NIL ("  CARING") (:HELP NIL NIL) :CSS "$CAR" :MULTI-ITEM) ("ANX" "ANXIETY" "spss-match" NIL ("  ANXIETY") (:HELP NIL NIL) :CSS "$ANX" :MULTI-ITEM) ("ANG" "ANGER" "spss-match" NIL ("  ANGER") (:HELP NIL NIL) :CSS "$ANG" :MULTI-ITEM) ("DEP" "DEP" "spss-match" NIL ("  SAD") (:HELP NIL NIL) :CSS "$DEP" :MULTI-ITEM) ("NONE" "UNSURE or NONE" "spss-match" NIL (" UNSURE or NONE") (:HELP NIL NIL) :MULTI-ITEM))))
;;FOR MULTI-SELECTION QVAR
;;  (SETF  *TEST-CS-EXPLORE-BRIEF  '((EMOT ("EMOT" "EMOT" NIL NIL (:TITLE ("   TYPE OF EMOTION") :QUEST ("    Select the EMOTION(S) that is/are MOST strongly associated with this item") NIL NIL :LNTP :EMOT) (:HELP NIL NIL) NIL :MULTI-ITEM) ("HAP" "HAPPY" "spss-match" NIL ("  HAPPY") (:HELP NIL NIL) :CSS "$HAP" :LNTP :HAP :MULTI-ITEM) ("CARE" "CARING" "spss-match" NIL ("  CARING") (:HELP NIL NIL) :CSS "$CAR" :LNTP :CAR :MULTI-ITEM) ("ANX" "ANXIETY" "spss-match" NIL ("  ANXIETY") (:HELP NIL NIL) :CSS "$ANX" :LNTP :ANX :MULTI-ITEM) ("ANG" "ANGER" "spss-match" NIL ("  ANGER") (:HELP NIL NIL) :CSS "$ANG" :LNTP :ANG :MULTI-ITEM) ("DEP" "DEP" "spss-match" NIL ("  SAD") (:HELP NIL NIL) :CSS "$DEP" :LNTP :DEP :MULTI-ITEM) ("NONE" "UNSURE or NONE" "spss-match" NIL (" UNSURE or NONE") (:HELP NIL NIL) :MULTI-ITEM))))
;;test
;; (cs-explore 'AUTONOMOUS  :qvars-list-name '*TEST-CS-EXPLORE-BRIEF )



;; (cs-explore 'GROUPKNOWLEDGEWORK  :qvars-list-name '*TEST-CS-EXPLORE-BRIEF )
;; for EX and EMOTION LINKS
;; works= (("teacher") ("ANX" "DEP"))
;;((GROUPKNOWLEDGEWORK ("teacher")) ("EMOTION" ("EMOTION" 1 ("HAP" NIL 0) ("CARE" NIL 0) ("ANX" T 1) ("ANG" NIL 0) ("DEP" T 1) ("NONE" NIL 0))))   (NIL TEACHER8 ANX DEP)

;; (cs-explore 'GROUPKNOWLEDGEWORK  :qvars-list-name '*TEST-CS-EXPLORE-QVARS )
;;RESULTS
;; ("HELPERZ" ("TEACHERD") ("TEACHNAME") ("DONTRUMP") "GO TO CLASSES" "BOOKZ" "MORE CIVIL SOCIETY" "DO RESEARCH" "IGNORANT PEOPLE" ("JESUSZ") NIL)
;; ((:ISA ("HELPERZ")) (GROUPKNOWLEDGEWORK ("TEACHERD")) (GROUPKNOWLEDGEWORK ("TEACHNAME")) (GROUPKNOWLEDGEWORK ("DONTRUMP")) (:EVT ("GO TO CLASSES")) (:OBJLNK ("BOOKZ")) (:SUPG ("MORE CIVIL SOCIETY")) (:SUBG ("DO RESEARCH")) (:SD ("IGNORANT PEOPLE")) (GROUPKNOWLEDGEWORK ("JESUSZ")) ("EMOT" NIL))
;;  (TEACHER2XXX TEACHER2XXX TRUMPXXX JESUSXXX HELPERZ NIL TEACHERD NIL TEACHNAME7 NIL DONTRUMP HELPERZ0 HELPERZ2 GOTOCLASSES7 BOOKZ HELPERZ5 BOOKZ0 MORECIVILSOC BOOKZ7 MORECIVILSOC6 DORESEARCH HELPERZ4 GOTOCLASSES3 BOOKZ2 MORECIVILSOC7 DORESEARCH5 IGNORANTPEOP NIL JESUSZ)
;;ALSO
;; CSYM EG
;; GROUPKNOWLEDGEWORK  =  ("GROUPKNOWLEDGEWORK" "GROUP KNOWLEDGE WORKER vs NOT GROUP KNOWL WORK" CS2-1-1-99 NIL NIL :PC ("GROUP KNOWLEDGE WORKER" "NOT GROUP KNOWL WORK" 1 NIL) :POLE1 "GROUP KNOWLEDGE WORKER" :POLE2 "NOT GROUP KNOWL WORK" :BESTPOLE 1 :va "0.583" :RNK 1 (:BIPATH ((HELPERB3) :LNTP :ISA (HELPERZ) :LNTP :ISA (TEACHERD) :LNTP :EX (TEACHNAME7) :LNTP :NAME (DONTRUMP) :LNTP :OPP (HELPERZ0) :LNTP :EVT (HELPERZ2) :LNTP :OBJLNK (GOTOCLASSES7) :LNTP :OBJLNK (BOOKZ) :LNTP :OBJLNK (HELPERZ5) :LNTP :SUPG (BOOKZ0) :LNTP :SUPG (MORECIVILSOC) :LNTP :SUPG (BOOKZ7) :LNTP :SUBG (MORECIVILSOC6) :LNTP :SUBG (DORESEARCH) :LNTP :SUBG (HELPERZ4) :LNTP :SD (GOTOCLASSES3) :LNTP :SD (BOOKZ2) :LNTP :SD (MORECIVILSOC7) :LNTP :SD (DORESEARCH5) :LNTP :SD (IGNORANTPEOP) :LNTP :SD (JESUSZ) :LNTP :IMG)))
;; CSYM2 EGS:
;; BOOKZ = ("BOOKZ" "BOOKZ" $MIS.BOOKZ NIL NIL :CSS $MIS (:BIPATH ((GROUPKNOWLEDGEWORK) :LNTP :OBJLNK)))
;; also eval artsym:  $MIS.BOOKZ = ("$MIS.BOOKZ" ($MIS BOOKZ) BOOKZ)
;; MORECIVILSOC6  =  ("MORECIVILSOC6" "MORECIVILSOC6" $MIS.MORECIVILSOC6 NIL NIL :CSS $MIS (:BIPATH ((GROUPKNOWLEDGEWORK) :LNTP :SUBG)))
;; ;; also eval artsym: $MIS.MORECIVILSOC6k  = ("$MIS.MORECIVILSOC6" ($MIS MORECIVILSOC6) MORECIVILSOC6)




;;ALSO MAIN CSYM1: GROUPKNOWLEDGEWORK =  ("GROUPKNOWLEDGEWORK" "GROUP KNOWLEDGE WORKER vs NOT GROUP KNOWL WORK" CS2-1-1-99 NIL NIL :PC ("GROUP KNOWLEDGE WORKER" "NOT GROUP KNOWL WORK" 1 NIL) :POLE1 "GROUP KNOWLEDGE WORKER" :POLE2 "NOT GROUP KNOWL WORK" :BESTPOLE 1 (:BIPATH ((POLE1 NIL TEACHER NIL) (POLE1 NIL SCIENTIST NIL) (POLE2 NIL JEWS NIL) (THISISANOTHE) :LNTP :EVT (HELPERZXXX) :LNTP :ISA (HELPERZXXX7) :LNTP :ISA (TEACHERZXXX) :LNTP :EX (TEACHNAMEXXX) :LNTP :NAME (DTRUMPXXX) :LNTP :OPP (HELPERZXXX3) :LNTP :EVT (TEACHERZ) :LNTP :EVT (TEACHNAME) :LNTP :EVT (DTRUMP) :LNTP :EVT (GOTOCLASSES) :LNTP :EVT (HELPERZXXX0) :LNTP :OBJLNK (GOTOCLASSES0) :LNTP :OBJLNK (BOOKXXX) :LNTP :OBJLNK (GOTOCLASSES5) :LNTP :SUPG (BOOKXXX1) :LNTP :SUPG (MAKINGCIVILSOCIETY) :LNTP :SUPG (HELPERZXXX5) :LNTP :SUBG (GOTOCLASSES4) :LNTP :SUBG (BOOKXXX8) :LNTP :SUBG (MAKINGCIVILSOCIETY4) :LNTP :SUBG (DORESEARCHX) :LNTP :SUBG (HELPERZXXX8) :LNTP :SD (GOTOCLASSES1) :LNTP :SD (BOOKXXX7) :LNTP :SD (MAKINGCIVILSOCIETY3) :LNTP :SD (DORESEARCHX4) :LNTP :SD (IGNORANTPEOPLE) :LNTP :SD (JESUSXXX) :LNTP :IMG)) :va "0.583" :RNK 1)
;;
;;CSYM2 EG:  HELPERZXXX3 = ("HELPERZXXX3" "HELPERZXXX3" $MIS NIL NIL :CSS $MIS (:BIPATH ((GROUPKNOWLEDGEWORK) :LNTP :EVT)))
;;CSYM2 EG: GOTOCLASSES4  = ("GOTOCLASSES4" "GOTOCLASSES4" $MIS NIL NIL :CSS $MIS (:BIPATH ((GROUPKNOWLEDGEWORK) :LNTP :SUBG)))












;;OLDER RESULTS FOR ABOVE
;; (("HELPER2") ("TEACHER2") ("TEACHER2") ("TRUMP") ("GO TO SCHOOL") ("BOOK") ("CIVILIZATION") ("GO TO SCHOOL") ("IGNORANCE2") ("JESUS") NIL)
;; ((("ISA" ("HELPER2"))) ("EX" ("TEACHER2")) ("NAME" ("TEACHER2")) ("OPP" ("TRUMP")) (("EVNT" ("GO TO SCHOOL"))) (("OBJ" ("BOOK"))) (("SUPGL" ("CIVILIZATION"))) (("SUBGL" ("GO TO SCHOOL"))) (("SIT" ("IGNORANCE2"))) ("IMG" ("JESUS")) ("EMOT" NIL))
;; (EX TEACHER2XXX NAME TEACHER2XXX OPP TRUMPXXX IMG JESUSXXX)


;; (cs-explore 'GROUPKNOWLEDGEWORK  :qvars-list-name '*ALL-CS-EXPLORE-QVARS )
;;1. RESULTS RETURNED BY (values  answers results  all-stored-csyms)



;;SAVE-CS-EXPLORE-DATA-TO-FILE
;;2019
;;ddd
(defun save-cs-explore-data-to-file (&key (path *csq-save-all-dirpath)
                                     (all-csart-cat-sym-db-sym '*MASTER-CSART-CAT-DB)
                                (all-stored-csyms-sym '*ALL-STORED-CSYMS)
                                (newlink-made-csyms-sym '*NEWLINK-MADE-CSYMS)
                                (return-stored-strings-p T) return-data-p)
  "CS-explore   RETURNS (values  formated-all-stored-csyms  formated-all-stored-csyms/vals-lists  formated-newlink-csyms formated-csyms-db  all-csart-cat-sym-db all-stored-csyms all-stored-csyms/vals-lists  newlink-made-csyms)   INPUT:  "
  (let*
      ((store-string (format nil ";;==> CS-EXPLORE DATA SAVED IN: ~A" path))
       )
    (multiple-value-bind (formated-all-stored-csyms  formated-all-stored-csyms/vals-lists  formated-newlink-csyms formated-csyms-db )
        (get-all-cs-explore-data :all-csart-cat-sym-db-sym all-csart-cat-sym-db-sym 
                                 :all-stored-csyms-sym all-stored-csyms-sym
                                 :newlink-made-csyms-sym newlink-made-csyms-sym
                                 :return-formated-data-p T)
      ;;WRITE DATA TO FILE
      (with-open-file (out path :direction :output :if-exists :append :if-does-not-exist :create)
        ;;write each list-string to file
        (loop
         for formated-string in (list formated-all-stored-csyms  formated-all-stored-csyms/vals-lists  formated-newlink-csyms formated-csyms-db )
         do
           (when (stringp formated-string)
             (format out "~A" formated-string))      
           ;;end,loop,open
           ))
        (cond
         (return-stored-strings-p
          (values store-string formated-all-stored-csyms  formated-all-stored-csyms/vals-lists  formated-newlink-csyms formated-csyms-db ) )
         (t store-string))
    ;;end let, mvb,save-cs-explore-data-to-file
    )))
;;TEST
;; (save-cs-explore-data-to-file :path  ???)
;; (save-csq-data-to-file


;;GET-ALL-CS-EXPLORE-DATA
;;2018
;;ddd
(defun get-all-cs-explore-data (&key 
                                (all-csart-cat-sym-db-sym '*MASTER-CSART-CAT-DB)
                                (all-stored-csyms-sym '*ALL-STORED-CSYMS)
                                (newlink-made-csyms-sym '*NEWLINK-MADE-CSYMS)
                                (return-formated-data-p T) (return-data-p T))
  "CS-explore.   RETURNS (values  formated-all-stored-csyms  formated-all-stored-csyms/vals-lists  formated-newlink-csyms formated-csyms-db  all-csart-cat-sym-db all-stored-csyms all-stored-csyms/vals-lists  newlink-made-csyms)   FOR USE IN SAVE. "
  (let*
      ( ;;ordinary lists for use in formating
       (all-csart-cat-sym-db (eval all-csart-cat-sym-db-sym))
       ;;didn't make the sym/vals lists for all-csart-cat-sym-db, bec is in cs-config
       (all-stored-csyms (eval all-stored-csyms-sym))
       (all-stored-csyms/vals-lists (make-pcsymval-lists :all-datalists all-stored-csyms))
       (newlink-made-csyms (eval newlink-made-csyms-sym))
       ;;not needed bec included in all-stored-csyms/vals-lists
       ;;(newlink-made-csyms/vals-lists (make-pcsymval-lists newlink-made-csyms))
       ;;formated lists for storing
       (formated-csyms-db (format nil "~%;;~A ~%  (setf *file-MASTER-CSART-CAT-DB=  '~A~% " all-csart-cat-sym-db-sym all-csart-cat-sym-db))
       (formated-all-stored-csyms  (format nil "~%;;~A ~%  (setf *file-ALL-STORED-CSYMS  '~A~% " all-stored-csyms-sym  all-stored-csyms))
       (formated-all-stored-csyms/vals-lists (format nil "~%;;*ALL-STORED-CSYMVALS-LISTS ~%  (setf *file-ALL-STORED-CSYMVALS-LISTS  '~A~% "   all-stored-csyms/vals-lists))
       (formated-newlink-csyms  (format nil "~%;;~A ~%  (setf *file-NEWLINK-MADE-CSYMS-SYM ~A~% " newlink-made-csyms-sym newlink-made-csyms))
       ;;not needed, bec symvals made in all-stored-csyms/vals-lists
       #|       (formated-newlink-csyms/vals-lists (format nil "~%;;~A ~%  (setf *file-NEWLINK-CSYMVALS-LISTS=  '~A~% "   newlink-made-csyms/vals-lists))|#
       ;; (formated-explore-csyms-data)
       )
    (cond
     ((and return-formated-data-p return-data-p)
      (values  formated-all-stored-csyms  formated-all-stored-csyms/vals-lists
               formated-newlink-csyms formated-csyms-db
               all-csart-cat-sym-db all-stored-csyms all-stored-csyms/vals-lists
               newlink-made-csyms))
     (return-formated-data-p
      (values formated-all-stored-csyms  formated-all-stored-csyms/vals-lists
               formated-newlink-csyms formated-csyms-db))
     (return-data-p
      (values all-csart-cat-sym-db all-stored-csyms all-stored-csyms/vals-lists
               newlink-made-csyms)))
    ;;end let, get-all-cs-explore-data
    ))
;;TEST
;; (get-all-cs-explore-data)




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
          (csname  csphrase  csdata csartloc csdef  keywords )
   CSNAME (string) the symbol string for the meaning csphrase.
   CSPHRASE (string) The meaning phrase of the belief/value. For PCs writes a string of pole1 vs pole2
   CSDATA (list) a list.  (VALUE  etc--to be added?) Eg dif types of values etc)
   CSARTLOC: ART symbol whose symvals it is embedded in.
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
;; INTIMATE= ("INTIMATE" "INTIMATE vs NOT INTIMATE" CS2-1-1-99 NIL NIL :PC ("INTIMATE" "NOT INTIMATE" 1 NIL) :POLE1 "INTIMATE" :POLE2 "NOT INTIMATE" :BESTPOLE 1 (:BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL BEST-M-FRIEND NIL))))


#| FROM NOTES:
:BIPATH a list of pathlists to/from other nodes (eg. pole to/from element)
  BIPATHLIST = FOR NON-PCs only 1 node: (node-sym (data))
    [Note: PC :BIPATH go to every elm, Each elm links to ONE pc pole]
        FOR PCs [either or both poles can have links] 
         eg. :BIPATH ((pole1 nil (mother NIL))(pole1 nil (best-friend nil))(pole2 nil (father nil)))
        FOR ELMS TO PCS:  :BIPATH (("mother" NIL (TEST-PCSYM (POLE1) NIL))
:TO a list of pathlists to other nodes eg.  (to-element ...)
  TOPATHLIST = ()
:FROM  a list of pathlists from other nodes (eg pole from element)
  FROMPATH  eg (from-element ...)
:WTO a list of weighted pathlists to other nodes
  WPATHLIST = (   )
:WFROM  a list of weighted pathlists from other nodes 
  WFROMPATH = (  )
|#




;;XXX ============== OLDER: DEPRECIATED ================

;;XXX 2019 CSARTSYM TREE DB PARAMETERS MOVED TO CS-CONFIG


;;-------- OLDER APPROACH-- REPLACED BY :TSYS AND :TLINK SYSTEM -----
;;EXPLORE PARAMETERS
;; 1. STORE UNDER DB-ITEM TYPE/FEATURE SYMBOL LIST
;; DB-ITEM TYPES: Used for STORING CSYMS BY SUB-TYPE.  IF ONLY FALLS IN GENERAL CATEGORY THEN STORE UNDER (eg VALUE for *DB-VALUE.
#|(Defparameter *DB-TOPBV '((:SUBTP *DBTOPBV *DBSUPGOAL *DBSUBGOAL *DBSUPPLAN *DBSUBPLAN)) )
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
(Defparameter *ALL-CS-DB-ITEM-TYPES '(*DB-TOPBV *DB-WRLDVW *DB-SELF *DB-REFGRP *DB-VALUE  *DB-BELIEF *DB-PC *DB-KNOWB *DB-COGSK *DB-BEHSK  *DB-SCRIPT *DB-EVENT *DB-ELM) "Separate DB-ITEM TYPES. Each item a separate entity, Can have LINKS (eg BIPATHS where a linked db-item is listed in the BIPATH, etc.")
(Defparameter *ALL-CS-DB-ITEM-FEATURES
      '(*DB-VERBAL        *DB-IMAGE       *DB-SOUND       *DB-SMELL       *DB-TASTE       *DB-TACTILE       *DB-EMOTION       *DB-MOTOR) "Integral pars of the DB-ITEM. Sublists of these items--no link necessary.")
;;ALL SUBSYMS FROM ABOVE
(Defparameter *ALL-CSDB-SUBSYMS NIL "Complete list of all db subsyms calculated in initialize-cs-explore")|#
;; END OLDER DB SYSTEM -- REPLACED BY :TSYS AND :TLINK SYSTEM -----






;;OLDER- PRE FALL 2019 ================================
#|(defun cs-explore (csym &key (cs-pole 'bestpole)
                        (qvars-list-name '*all-cs-explore-qvars) 
                        (quests-list-name '*All-CS-exploreQs) (store-key :BIPATH)
                        confirm-input-p  (csdb-pre "*DB"))
                         ;;not needed, done in store- (track-all-stored-csyms-p T))
                         "CS-explore. Uses explore qvars to generate questions and form new network links such as ISA, SUPGOAL, EMOTION, etc.   RETURNS (values  answers results  all-stored-csyms).    INPUT:  CS-POLE can be (:bestpole, 'bestpole, nil);  'pole1; 'pole2; or 'bothpoles. NOTE: :MULTI-ITEM means a popup with multiplel answers to choose from; 'MULTI-TEXT' means multiple popups each requiring a separate text answer."   
  (let*
      ((outputs)
       (cs-phrase (cond
                   ((member cs-pole '( :bestpole bestpole NIL) :test 'equal)
                    (get-cs-bestpole-name csym))
                   ((equal cs-pole 'bothpoles)
                     (second (eval csym)))
                   ((equal cs-pole 'pole1)
                    (get-cs-pole-name csym))
                   ((equal cs-pole 'pole2)
                    (get-cs-pole-name csym :pole-n 2))))                   
       (all-qvarlists (eval qvars-list-name))
       (all-quests (eval quests-list-name))
       (answers)
       (results)
       ;;(all-stored-csdb-syms)
       (all-stored-csyms)
       )
    ;;SET THE DEFAULT *cur-all-questions and *cur-qvarlists
    (setf *cur-qvarlists qvars-list-name
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
     (let*
         ((n-qvars (list-length catlist))
          (ans-type)
          (catvar-str (car (second catlist)))
          (mult-ans)
          (current-qvar)
          (csdbsyms)
          (stored-csdbsyms)
          (stored-csyms)
          )   
       (cond
        ;;IS Q MULTI-ITEM QUESTION
       ;;STEP 1: MAKE THE QUESTIONS, ETC FROM QVARS
       ;;FOR :MULTI-ITEM QUESTS
        ((equal (car (last (second catlist))) :multi-item)
         (setf current-qvar  catvar-str
               *current-qvarlist catlist)
         ;;(break "BEFORE make-question-frame FIRST")
         (make-question-frame catvar-str NIL ;;arg not used in def
                              :csq-frame-pane1-title CS-PHRASE ;;added to list variable
                              :all-qvarlists  all-qvarlists ;;was *current-qvarlist
                                :compare-3elms-p NIL) ;;CS-PHRASE

       ;;or(cdr *current-qvarlist))
         ;;PAUSE +
         (mp:current-process-pause 100)
         ;;(break "AFTER pause for make-question-frame")

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
                 (csdbsym (my-make-cs-symbol csdbstr))
                 )
              ;;store csym in BIPATH for each node
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
             ;; all-stored-csdb-syms (append all-stored-csdb-syms (list csdbsyms))
              all-stored-csyms (append all-stored-csyms (list stored-csyms)))
        ;;(break "END of store mult-ans answers")
        ;;end multi-item cat
        )
       ;;FOR TEXT-INPUT ANSWERS (single-text and multi-text)
       (T       
        (loop
         for qvarlist in (cdr catlist)
         for n from 1 to n-qvars
         do
         (let*
             ((qvarstr (car qvarlist))
              (type (third qvarlist))
              (csdbstr  (format nil "~A~A" csdb-pre qvarstr))
              (csdbsym (my-make-cs-symbol csdbstr))
              (answer)
              (result)
              )
           ;;Set global vars for text-go-button-callback
           (setf  *current-qvar  qvarstr
                  *current-qvarlist qvarlist)
           ;;(break "before frame in all other type items")
           (cond
            ((equal type "single-text")
             ;;MAKE SINGLE-INPUT FRAME
             ;;(BREAK "BEFORE make-question-frame")
             (make-question-frame  qvarstr 'scale-sym :quest-frame 'frame-csq
                                   :all-qvarlists all-qvarlists
                                   :compare-3elms-p NIL)
             #|   (make-question-frame  "DEFINE" 'scale-sym :quest-frame 'frame-csq :all-qvarlists *all-cs-explore-qvars :compare-3elms-p NIL)|#

             ;;(break "single input text before pause")
             ;;PAUSE 
             (mp:current-process-pause 100)

             ;;COLLECT THE ANSWERS
             (setf answer *text-input-frame-text-answers
              answers (append answers (list answer))
                   results (append results 
                                   (list (list qvarstr answer))))            
             ;;MAKES NEW CSYM if not exist
             ;; store the answers in csdb items
             (store-in-csdbsym csdbsym store-key (list csym  nil nil))
             ;;NOT USEFUL? (setf all-stored-csdb-syms (append all-stored-csdb-syms (list csdbsym)))
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
                      *current-qvarlist qvarlist)
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

               ;;MAKE NEW CSYMS FOR EACH ANSWER
               ;;oldo-store the answers in csdb items
               (loop
                for ans1 in answers
                do 
                (when ans1
                  (multiple-value-bind (new-keylist1 csdbsym1 old-keylist1 csdbsym-str1)
                      (store-in-csdbsym qvarstr  store-key csym  :subitem ans1)
                    ;;2nd node
                    (store-in-csdbsym csym store-key qvarstr  :subitem ans1)
                    ;;NOT USEFUL? collect csdb-sym
#|                    (setf all-stored-csdb-syms (append all-stored-csdb-syms (list csdbsym1)
                                           all-stored-csyms (append all-stored-csyms (list csym))))|#
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
    (setf *all-CS-explore-outputs (list answers results)) ;;all-stored-csdb-syms))
    
    ;;KEEP TRACK of new  nodes, etc USING GLOBAL VARS
    ;;  *ALL-STORED-CSYMS  *ALL-STORED-CSDB-SYMS 
#|  not needed  (when track-all-stored-csyms-p
      (setf  *ALL-STORED-CSYMS  all-stored-csyms  
             *ALL-STORED-CSDB-SYMS all-stored-csdb-syms))|#
    (values  answers results  all-stored-csyms)
    ;;end let, cs-explore
    ))|#
;;TEST
;;SSSS FINISH TESTING THE CS-EXPLORE FUNCTION AND FINISH IT
;; (cs-explore 'GROUPKNOWLEDGEWORK  :qvars-list-name '*test-cs-explore-qvars )
;;1. RESULTS RETURNED BY (values  answers results  all-stored-csyms)
;;     BEFORE CS-EXPLORE: GROUPKNOWLEDGEWORK=>>  ("GROUPKNOWLEDGEWORK" "GROUP KNOWLEDGE WORKER vs NOT GROUP KNOWL WORK" CS2-1-1-99 NIL NIL :PC ("GROUP KNOWLEDGE WORKER" "NOT GROUP KNOWL WORK" 1 NIL) :POLE1 "GROUP KNOWLEDGE WORKER" :POLE2 "NOT GROUP KNOWL WORK" :BESTPOLE 1 (:BIPATH ((POLE1 NIL TEACHER NIL) (POLE1 NIL SCIENTIST NIL) (POLE2 NIL JEWS NIL))) :va "0.583" :RNK 1)

;;BEFORE CS-EXPLORE
;;AUTONOMOUS=> ("AUTONOMOUS" "AUTONOMOUS vs NOT AUTONOMOUS" CS2-1-1-99 NIL NIL :PC ("AUTONOMOUS" "NOT AUTONOMOUS" 1 NIL) :POLE1 "AUTONOMOUS" :POLE2 "NOT AUTONOMOUS" :BESTPOLE 1 (:BIPATH ((POLE1 NIL F-ADMIRE NIL) (POLE1 NIL PER-ROMANCE NIL) (POLE2 NIL CHILD-DISLIKE NIL))) :va "0.917" :RNK 10)

;; (cs-explore 'AUTONOMOUS) SSSSSS START HERE TEST ANOTHER QVAR
;;("AUTONOMOUS" "AUTONOMOUS vs NOT AUTONOMOUS" CS2-1-1-99 NIL NIL :PC ("AUTONOMOUS" "NOT AUTONOMOUS" 1 NIL) :POLE1 "AUTONOMOUS" :POLE2 "NOT AUTONOMOUS" :BESTPOLE 1 (:BIPATH ((POLE1 NIL F-ADMIRE NIL) (POLE1 NIL PER-ROMANCE NIL) (POLE2 NIL CHILD-DISLIKE NIL))) :va "0.917" :RNK 10)

;; OTHER ERRORS PRINTING WRONG NAMES FOR QVARS--EG "PUNISH"

;; RESULT; CL-USER 8 >  AUTONOMOUS=>
;;PPRINT VERSON;; AUTONOMOUS= 
#|
("AUTONOMOUS"
 "AUTONOMOUS vs NOT AUTONOMOUS"
 CS2-1-1-99
 NIL
 NIL
 :PC
 ("AUTONOMOUS" "NOT AUTONOMOUS" 1 NIL)
 :POLE1
 "AUTONOMOUS"
 :BIPATH
 (("ISA" :SUBITEM ("PERSO-CHAR" "SHAQ-SCALE")) ok
     ("PART" :SUBITEM ("PERSO-CHAR" "SHAQ-SCALE")) no
     ("PART" :SUBITEM ("PART1" "PART2")) no
  (*DBWHY NIL :SUBITEM ("IMPORTANT-WHY EXISTS")) ok
     ("CAUSE" :SUBITEM ("PERSO-CHAR" "SHAQ-SCALE")) no
     ("CAUSE" :SUBITEM ("PART1" "PART2")) no
     ("CAUSE" :SUBITEM ("IMPORTANT-WHY EXISTS")) no
  ("CAUSE" :SUBITEM ("CAUSE1" "CAUSE2")) ok
  (*DBEVIDENCE NIL :SUBITEM ("EVIDENCE FOR AUTO")) ok
  (*DBHOW NIL :SUBITEM ("STEP1, STEP2")) ok
  (*DBEXAMPLE NIL :SUBITEM ("BEST EG OF AUTON")) ok
     ("FEATURE" :SUBITEM ("PERSO-CHAR" "SHAQ-SCALE")) no
     ("FEATURE" :SUBITEM ("PART1" "PART2")) no
     ("FEATURE" :SUBITEM ("IMPORTANT-WHY EXISTS"))
     ("FEATURE" :SUBITEM ("CAUSE1" "CAUSE2"))
     ("FEATURE" :SUBITEM ("EVIDENCE FOR AUTO"))
     ("FEATURE" :SUBITEM ("STEP1, STEP2"))
     ("FEATURE" :SUBITEM ("BEST EG OF AUTON"))
  ("FEATURE" :SUBITEM ("FEATURE1" "FEATURE2")) ok
  (*DBREGNANT NIL :SUBITEM ("EXCL ASSOC WITH NOTHING"))ok
  (*DBNAME NIL :SUBITEM ("NO BETTER NAME"))ok
  (*DBDEFINE NIL :SUBITEM ("DEF OF AUTON"))ok
  (*DBDESCRIBE NIL :SUBITEM ("DESCRIP OF AUTOON"))ok
  (*DBOPPOSITE NIL :SUBITEM ("OPPOSITE OF A"))ok
     ("SYNONYM" :SUBITEM ("PERSO-CHAR" "SHAQ-SCALE"))
     ("SYNONYM" :SUBITEM ("PART1" "PART2"))
  ("SYNONYM" :SUBITEM ("IMPORTANT-WHY EXISTS"))
  ("SYNONYM" :SUBITEM ("CAUSE1" "CAUSE2"))
  ("SYNONYM" :SUBITEM ("EVIDENCE FOR AUTO"))
  ("SYNONYM" :SUBITEM ("STEP1, STEP2"))
  ("SYNONYM" :SUBITEM ("BEST EG OF AUTON"))
  ("SYNONYM" :SUBITEM ("FEATURE1" "FEATURE2"))
  ("SYNONYM" :SUBITEM ("EXCL ASSOC WITH NOTHING"))
  ("SYNONYM" :SUBITEM ("NO BETTER NAME"))
  ("SYNONYM" :SUBITEM ("DEF OF AUTON"))
  ("SYNONYM" :SUBITEM ("DESCRIP OF AUTOON"))
     ("SYNONYM" :SUBITEM ("OPPOSITE OF A"))
  ("SYNONYM" :SUBITEM ("SYNON1" "SYNON2"))ok
     ("EVENT" :SUBITEM ("PERSO-CHAR" "SHAQ-SCALE"))
  ("EVENT" :SUBITEM ("PART1" "PART2"))
  ("EVENT" :SUBITEM ("IMPORTANT-WHY EXISTS"))
  ("EVENT" :SUBITEM ("CAUSE1" "CAUSE2"))
  ("EVENT" :SUBITEM ("EVIDENCE FOR AUTO"))
  ("EVENT" :SUBITEM ("STEP1, STEP2"))
  ("EVENT" :SUBITEM ("BEST EG OF AUTON"))
  ("EVENT" :SUBITEM ("FEATURE1" "FEATURE2"))
  ("EVENT" :SUBITEM ("EXCL ASSOC WITH NOTHING"))
  ("EVENT" :SUBITEM ("NO BETTER NAME"))
  ("EVENT" :SUBITEM ("DEF OF AUTON"))
  ("EVENT" :SUBITEM ("DESCRIP OF AUTOON"))
  ("EVENT" :SUBITEM ("OPPOSITE OF A"))
     ("EVENT" :SUBITEM ("SYNON1" "SYNON2"))
  ("EVENT" :SUBITEM ("PRE-EVENT1" "PRE-EVENT2"))ok
     ("VALUE" :SUBITEM ("PERSO-CHAR" "SHAQ-SCALE"))
  ("VALUE" :SUBITEM ("PART1" "PART2"))
  ("VALUE" :SUBITEM ("IMPORTANT-WHY EXISTS"))
  ("VALUE" :SUBITEM ("CAUSE1" "CAUSE2"))
  ("VALUE" :SUBITEM ("EVIDENCE FOR AUTO"))
  ("VALUE" :SUBITEM ("STEP1, STEP2"))
  ("VALUE" :SUBITEM ("BEST EG OF AUTON"))
  ("VALUE" :SUBITEM ("FEATURE1" "FEATURE2"))
  ("VALUE" :SUBITEM ("EXCL ASSOC WITH NOTHING"))
  ("VALUE" :SUBITEM ("NO BETTER NAME"))
  ("VALUE" :SUBITEM ("DEF OF AUTON"))
  ("VALUE" :SUBITEM ("DESCRIP OF AUTOON"))
  ("VALUE" :SUBITEM ("OPPOSITE OF A"))
  ("VALUE" :SUBITEM ("SYNON1" "SYNON2"))
     ("VALUE" :SUBITEM ("PRE-EVENT1" "PRE-EVENT2"))
  ("VALUE" :SUBITEM ("VAL1 ASSOC W AUTO" "VAL2 ASSOC AUT"))ok
     ("SELF" :SUBITEM ("PERSO-CHAR" "SHAQ-SCALE"))
  ("SELF" :SUBITEM ("PART1" "PART2"))
  ("SELF" :SUBITEM ("IMPORTANT-WHY EXISTS"))
  ("SELF" :SUBITEM ("CAUSE1" "CAUSE2"))
  ("SELF" :SUBITEM ("EVIDENCE FOR AUTO"))
  ("SELF" :SUBITEM ("STEP1, STEP2"))
  ("SELF" :SUBITEM ("BEST EG OF AUTON"))
  ("SELF" :SUBITEM ("FEATURE1" "FEATURE2"))
  ("SELF" :SUBITEM ("EXCL ASSOC WITH NOTHING"))
  ("SELF" :SUBITEM ("NO BETTER NAME"))
  ("SELF" :SUBITEM ("DEF OF AUTON"))
  ("SELF" :SUBITEM ("DESCRIP OF AUTOON"))
  ("SELF" :SUBITEM ("OPPOSITE OF A"))
  ("SELF" :SUBITEM ("SYNON1" "SYNON2"))
  ("SELF" :SUBITEM ("PRE-EVENT1" "PRE-EVENT2"))
     ("SELF" :SUBITEM ("VAL1 ASSOC W AUTO" "VAL2 ASSOC AUT"))
  ("SELF" :SUBITEM ("AUT AFFECTS ME PERS1" "AUT AFFECTS ME PERS2"))ok
      ("POSEXPECT" :SUBITEM ("PERSO-CHAR" "SHAQ-SCALE"))
  ("POSEXPECT" :SUBITEM ("PART1" "PART2"))
  ("POSEXPECT" :SUBITEM ("IMPORTANT-WHY EXISTS"))
  ("POSEXPECT" :SUBITEM ("CAUSE1" "CAUSE2"))
  ("POSEXPECT" :SUBITEM ("EVIDENCE FOR AUTO"))
  ("POSEXPECT" :SUBITEM ("STEP1, STEP2"))
  ("POSEXPECT" :SUBITEM ("BEST EG OF AUTON"))
  ("POSEXPECT" :SUBITEM ("FEATURE1" "FEATURE2"))
  ("POSEXPECT" :SUBITEM ("EXCL ASSOC WITH NOTHING"))
  ("POSEXPECT" :SUBITEM ("NO BETTER NAME"))
  ("POSEXPECT" :SUBITEM ("DEF OF AUTON"))
  ("POSEXPECT" :SUBITEM ("DESCRIP OF AUTOON"))
  ("POSEXPECT" :SUBITEM ("OPPOSITE OF A"))
  ("POSEXPECT" :SUBITEM ("SYNON1" "SYNON2"))
  ("POSEXPECT" :SUBITEM ("PRE-EVENT1" "PRE-EVENT2"))
      ("POSEXPECT" :SUBITEM ("VAL1 ASSOC W AUTO" "VAL2 ASSOC AUT"))
      ("POSEXPECT" :SUBITEM ("AUT AFFECTS ME PERS1" "AUT AFFECTS ME PERS2"))
  ("POSEXPECT" :SUBITEM ("POS OUTC1" "POS OUT2"))ok
      ("NEGEXPECT" :SUBITEM ("PERSO-CHAR" "SHAQ-SCALE"))
  ("NEGEXPECT" :SUBITEM ("PART1" "PART2"))
  ("NEGEXPECT" :SUBITEM ("IMPORTANT-WHY EXISTS"))
  ("NEGEXPECT" :SUBITEM ("CAUSE1" "CAUSE2"))
  ("NEGEXPECT" :SUBITEM ("EVIDENCE FOR AUTO"))
  ("NEGEXPECT" :SUBITEM ("STEP1, STEP2"))
  ("NEGEXPECT" :SUBITEM ("BEST EG OF AUTON"))
  ("NEGEXPECT" :SUBITEM ("FEATURE1" "FEATURE2"))
  ("NEGEXPECT" :SUBITEM ("EXCL ASSOC WITH NOTHING"))
  ("NEGEXPECT" :SUBITEM ("NO BETTER NAME"))
  ("NEGEXPECT" :SUBITEM ("DEF OF AUTON"))
  ("NEGEXPECT" :SUBITEM ("DESCRIP OF AUTOON"))
  ("NEGEXPECT" :SUBITEM ("OPPOSITE OF A"))
  ("NEGEXPECT" :SUBITEM ("SYNON1" "SYNON2"))
  ("NEGEXPECT" :SUBITEM ("PRE-EVENT1" "PRE-EVENT2"))
  ("NEGEXPECT" :SUBITEM ("VAL1 ASSOC W AUTO" "VAL2 ASSOC AUT"))
  ("NEGEXPECT" :SUBITEM ("AUT AFFECTS ME PERS1" "AUT AFFECTS ME PERS2"))
      ("NEGEXPECT" :SUBITEM ("POS OUTC1" "POS OUT2"))
  ("NEGEXPECT" :SUBITEM ("NEG OUT1" "NEG OUT2"))ok
      ("SUPGOAL" :SUBITEM ("PERSO-CHAR" "SHAQ-SCALE"))
  ("SUPGOAL" :SUBITEM ("PART1" "PART2"))
  ("SUPGOAL" :SUBITEM ("IMPORTANT-WHY EXISTS"))
  ("SUPGOAL" :SUBITEM ("CAUSE1" "CAUSE2"))
  ("SUPGOAL" :SUBITEM ("EVIDENCE FOR AUTO"))
  ("SUPGOAL" :SUBITEM ("STEP1, STEP2"))
  ("SUPGOAL" :SUBITEM ("BEST EG OF AUTON"))
  ("SUPGOAL" :SUBITEM ("FEATURE1" "FEATURE2"))
  ("SUPGOAL" :SUBITEM ("EXCL ASSOC WITH NOTHING"))
  ("SUPGOAL" :SUBITEM ("NO BETTER NAME"))
  ("SUPGOAL" :SUBITEM ("DEF OF AUTON"))
  ("SUPGOAL" :SUBITEM ("DESCRIP OF AUTOON"))
  ("SUPGOAL" :SUBITEM ("OPPOSITE OF A"))
  ("SUPGOAL" :SUBITEM ("SYNON1" "SYNON2"))
  ("SUPGOAL" :SUBITEM ("PRE-EVENT1" "PRE-EVENT2"))
  ("SUPGOAL" :SUBITEM ("VAL1 ASSOC W AUTO" "VAL2 ASSOC AUT"))
  ("SUPGOAL" :SUBITEM ("AUT AFFECTS ME PERS1" "AUT AFFECTS ME PERS2"))
  ("SUPGOAL" :SUBITEM ("POS OUTC1" "POS OUT2"))
       ("SUPGOAL" :SUBITEM ("NEG OUT1" "NEG OUT2"))
  ("SUPGOAL" :SUBITEM ("HIGHER GOAL1" "HIGHER GOAL2"))ok
       ("SUBGOAL" :SUBITEM ("PERSO-CHAR" "SHAQ-SCALE"))
  ("SUBGOAL" :SUBITEM ("PART1" "PART2"))
  ("SUBGOAL" :SUBITEM ("IMPORTANT-WHY EXISTS"))
  ("SUBGOAL" :SUBITEM ("CAUSE1" "CAUSE2"))
  ("SUBGOAL" :SUBITEM ("EVIDENCE FOR AUTO"))
  ("SUBGOAL" :SUBITEM ("STEP1, STEP2"))
  ("SUBGOAL" :SUBITEM ("BEST EG OF AUTON"))
  ("SUBGOAL" :SUBITEM ("FEATURE1" "FEATURE2"))
  ("SUBGOAL" :SUBITEM ("EXCL ASSOC WITH NOTHING"))
  ("SUBGOAL" :SUBITEM ("NO BETTER NAME"))
  ("SUBGOAL" :SUBITEM ("DEF OF AUTON"))
  ("SUBGOAL" :SUBITEM ("DESCRIP OF AUTOON"))
  ("SUBGOAL" :SUBITEM ("OPPOSITE OF A"))
  ("SUBGOAL" :SUBITEM ("SYNON1" "SYNON2"))
  ("SUBGOAL" :SUBITEM ("PRE-EVENT1" "PRE-EVENT2"))
  ("SUBGOAL" :SUBITEM ("VAL1 ASSOC W AUTO" "VAL2 ASSOC AUT"))
  ("SUBGOAL" :SUBITEM ("AUT AFFECTS ME PERS1" "AUT AFFECTS ME PERS2"))
  ("SUBGOAL" :SUBITEM ("POS OUTC1" "POS OUT2"))
  ("SUBGOAL" :SUBITEM ("NEG OUT1" "NEG OUT2"))
  ("SUBGOAL" :SUBITEM ("HIGHER GOAL1" "HIGHER GOAL2"))
  ("SUBGOAL" :SUBITEM ("SUBGOAL1" "SUBGOAL2"))
  ("SCRIPT" :SUBITEM ("PERSO-CHAR" "SHAQ-SCALE"))
  ("SCRIPT" :SUBITEM ("PART1" "PART2"))
  ("SCRIPT" :SUBITEM ("IMPORTANT-WHY EXISTS"))
  ("SCRIPT" :SUBITEM ("CAUSE1" "CAUSE2"))
  ("SCRIPT" :SUBITEM ("EVIDENCE FOR AUTO"))
  ("SCRIPT" :SUBITEM ("STEP1, STEP2"))
  ("SCRIPT" :SUBITEM ("BEST EG OF AUTON"))
  ("SCRIPT" :SUBITEM ("FEATURE1" "FEATURE2"))
  ("SCRIPT" :SUBITEM ("EXCL ASSOC WITH NOTHING"))
  ("SCRIPT" :SUBITEM ("NO BETTER NAME"))
  ("SCRIPT" :SUBITEM ("DEF OF AUTON"))
  ("SCRIPT" :SUBITEM ("DESCRIP OF AUTOON"))
  ("SCRIPT" :SUBITEM ("OPPOSITE OF A"))
  ("SCRIPT" :SUBITEM ("SYNON1" "SYNON2"))
  ("SCRIPT" :SUBITEM ("PRE-EVENT1" "PRE-EVENT2"))
  ("SCRIPT" :SUBITEM ("VAL1 ASSOC W AUTO" "VAL2 ASSOC AUT"))
  ("SCRIPT" :SUBITEM ("AUT AFFECTS ME PERS1" "AUT AFFECTS ME PERS2"))
  ("SCRIPT" :SUBITEM ("POS OUTC1" "POS OUT2"))
  ("SCRIPT" :SUBITEM ("NEG OUT1" "NEG OUT2"))
  ("SCRIPT" :SUBITEM ("HIGHER GOAL1" "HIGHER GOAL2"))
  ("SCRIPT" :SUBITEM ("SUBGOAL1" "SUBGOAL2"))
  ("SCRIPT" :SUBITEM ("SCRIPT1" "SCRIPT2"))
  ("SITUATION-SD" :SUBITEM ("PERSO-CHAR" "SHAQ-SCALE"))
  ("SITUATION-SD" :SUBITEM ("PART1" "PART2"))
  ("SITUATION-SD" :SUBITEM ("IMPORTANT-WHY EXISTS"))
  ("SITUATION-SD" :SUBITEM ("CAUSE1" "CAUSE2"))
  ("SITUATION-SD" :SUBITEM ("EVIDENCE FOR AUTO"))
  ("SITUATION-SD" :SUBITEM ("STEP1, STEP2"))
  ("SITUATION-SD" :SUBITEM ("BEST EG OF AUTON"))
  ("SITUATION-SD" :SUBITEM ("FEATURE1" "FEATURE2"))
  ("SITUATION-SD" :SUBITEM ("EXCL ASSOC WITH NOTHING"))
  ("SITUATION-SD" :SUBITEM ("NO BETTER NAME"))
  ("SITUATION-SD" :SUBITEM ("DEF OF AUTON"))
  ("SITUATION-SD" :SUBITEM ("DESCRIP OF AUTOON"))
  ("SITUATION-SD" :SUBITEM ("OPPOSITE OF A"))
  ("SITUATION-SD" :SUBITEM ("SYNON1" "SYNON2"))
  ("SITUATION-SD" :SUBITEM ("PRE-EVENT1" "PRE-EVENT2"))
  ("SITUATION-SD" :SUBITEM ("VAL1 ASSOC W AUTO" "VAL2 ASSOC AUT"))
  ("SITUATION-SD" :SUBITEM ("AUT AFFECTS ME PERS1" "AUT AFFECTS ME PERS2"))
  ("SITUATION-SD" :SUBITEM ("POS OUTC1" "POS OUT2"))
  ("SITUATION-SD" :SUBITEM ("NEG OUT1" "NEG OUT2"))
  ("SITUATION-SD" :SUBITEM ("HIGHER GOAL1" "HIGHER GOAL2"))
  ("SITUATION-SD" :SUBITEM ("SUBGOAL1" "SUBGOAL2"))
  ("SITUATION-SD" :SUBITEM ("SCRIPT1" "SCRIPT2"))
  ("SITUATION-SD" :SUBITEM ("SIT PRE AUTO1" "SIT PRE AUT2"))
  ("ALT-R" :SUBITEM ("PERSO-CHAR" "SHAQ-SCALE"))
  ("ALT-R" :SUBITEM ("PART1" "PART2"))
  ("ALT-R" :SUBITEM ("IMPORTANT-WHY EXISTS"))
  ("ALT-R" :SUBITEM ("CAUSE1" "CAUSE2"))
  ("ALT-R" :SUBITEM ("EVIDENCE FOR AUTO"))
  ("ALT-R" :SUBITEM ("STEP1, STEP2"))
  ("ALT-R" :SUBITEM ("BEST EG OF AUTON"))
  ("ALT-R" :SUBITEM ("FEATURE1" "FEATURE2"))
  ("ALT-R" :SUBITEM ("EXCL ASSOC WITH NOTHING"))
  ("ALT-R" :SUBITEM ("NO BETTER NAME"))
  ("ALT-R" :SUBITEM ("DEF OF AUTON"))
  ("ALT-R" :SUBITEM ("DESCRIP OF AUTOON"))
  ("ALT-R" :SUBITEM ("OPPOSITE OF A"))
  ("ALT-R" :SUBITEM ("SYNON1" "SYNON2"))
  ("ALT-R" :SUBITEM ("PRE-EVENT1" "PRE-EVENT2"))
  ("ALT-R" :SUBITEM ("VAL1 ASSOC W AUTO" "VAL2 ASSOC AUT"))
  ("ALT-R" :SUBITEM ("AUT AFFECTS ME PERS1" "AUT AFFECTS ME PERS2"))
  ("ALT-R" :SUBITEM ("POS OUTC1" "POS OUT2"))
  ("ALT-R" :SUBITEM ("NEG OUT1" "NEG OUT2"))
  ("ALT-R" :SUBITEM ("HIGHER GOAL1" "HIGHER GOAL2"))
  ("ALT-R" :SUBITEM ("SUBGOAL1" "SUBGOAL2"))
  ("ALT-R" :SUBITEM ("SCRIPT1" "SCRIPT2"))
  ("ALT-R" :SUBITEM ("SIT PRE AUTO1" "SIT PRE AUT2"))
  ("ALT-R" :SUBITEM ("ALTERN TO AUTON1" "HIGHER GOAL2"))
  ("MOTOR" :SUBITEM ("PERSO-CHAR" "SHAQ-SCALE"))
  ("MOTOR" :SUBITEM ("PART1" "PART2"))
  ("MOTOR" :SUBITEM ("IMPORTANT-WHY EXISTS"))
  ("MOTOR" :SUBITEM ("CAUSE1" "CAUSE2"))
  ("MOTOR" :SUBITEM ("EVIDENCE FOR AUTO"))
  ("MOTOR" :SUBITEM ("STEP1, STEP2"))
  ("MOTOR" :SUBITEM ("BEST EG OF AUTON"))
  ("MOTOR" :SUBITEM ("FEATURE1" "FEATURE2"))
  ("MOTOR" :SUBITEM ("EXCL ASSOC WITH NOTHING"))
  ("MOTOR" :SUBITEM ("NO BETTER NAME"))
  ("MOTOR" :SUBITEM ("DEF OF AUTON"))
  ("MOTOR" :SUBITEM ("DESCRIP OF AUTOON"))
  ("MOTOR" :SUBITEM ("OPPOSITE OF A"))
  ("MOTOR" :SUBITEM ("SYNON1" "SYNON2"))
  ("MOTOR" :SUBITEM ("PRE-EVENT1" "PRE-EVENT2"))
  ("MOTOR" :SUBITEM ("VAL1 ASSOC W AUTO" "VAL2 ASSOC AUT"))
  ("MOTOR" :SUBITEM ("AUT AFFECTS ME PERS1" "AUT AFFECTS ME PERS2"))
  ("MOTOR" :SUBITEM ("POS OUTC1" "POS OUT2"))
  ("MOTOR" :SUBITEM ("NEG OUT1" "NEG OUT2"))
  ("MOTOR" :SUBITEM ("HIGHER GOAL1" "HIGHER GOAL2"))
  ("MOTOR" :SUBITEM ("SUBGOAL1" "SUBGOAL2"))
  ("MOTOR" :SUBITEM ("SCRIPT1" "SCRIPT2"))
  ("MOTOR" :SUBITEM ("SIT PRE AUTO1" "SIT PRE AUT2"))
  ("MOTOR" :SUBITEM ("ALTERN TO AUTON1" "HIGHER GOAL2"))
  ("MOTOR" :SUBITEM ("BLANK WINDOW1"))
  ("REINF" :SUBITEM ("PERSO-CHAR" "SHAQ-SCALE"))
  ("REINF" :SUBITEM ("PART1" "PART2"))
  ("REINF" :SUBITEM ("IMPORTANT-WHY EXISTS"))
  ("REINF" :SUBITEM ("CAUSE1" "CAUSE2"))
  ("REINF" :SUBITEM ("EVIDENCE FOR AUTO"))
  ("REINF" :SUBITEM ("STEP1, STEP2"))
  ("REINF" :SUBITEM ("BEST EG OF AUTON"))
  ("REINF" :SUBITEM ("FEATURE1" "FEATURE2"))
  ("REINF" :SUBITEM ("EXCL ASSOC WITH NOTHING"))
  ("REINF" :SUBITEM ("NO BETTER NAME"))
  ("REINF" :SUBITEM ("DEF OF AUTON"))
  ("REINF" :SUBITEM ("DESCRIP OF AUTOON"))
  ("REINF" :SUBITEM ("OPPOSITE OF A"))
  ("REINF" :SUBITEM ("SYNON1" "SYNON2"))
  ("REINF" :SUBITEM ("PRE-EVENT1" "PRE-EVENT2"))
  ("REINF" :SUBITEM ("VAL1 ASSOC W AUTO" "VAL2 ASSOC AUT"))
  ("REINF" :SUBITEM ("AUT AFFECTS ME PERS1" "AUT AFFECTS ME PERS2"))
  ("REINF" :SUBITEM ("POS OUTC1" "POS OUT2"))
  ("REINF" :SUBITEM ("NEG OUT1" "NEG OUT2"))
  ("REINF" :SUBITEM ("HIGHER GOAL1" "HIGHER GOAL2"))
  ("REINF" :SUBITEM ("SUBGOAL1" "SUBGOAL2"))
  ("REINF" :SUBITEM ("SCRIPT1" "SCRIPT2"))
  ("REINF" :SUBITEM ("SIT PRE AUTO1" "SIT PRE AUT2"))
  ("REINF" :SUBITEM ("ALTERN TO AUTON1" "HIGHER GOAL2"))
  ("REINF" :SUBITEM ("BLANK WINDOW1"))
  ("REINF" :SUBITEM ("REWS OR POS OUTS"))
  ("PUNISH" :SUBITEM ("PERSO-CHAR" "SHAQ-SCALE"))
  ("PUNISH" :SUBITEM ("PART1" "PART2"))
  ("PUNISH" :SUBITEM ("IMPORTANT-WHY EXISTS"))
  ("PUNISH" :SUBITEM ("CAUSE1" "CAUSE2"))
  ("PUNISH" :SUBITEM ("EVIDENCE FOR AUTO"))
  ("PUNISH" :SUBITEM ("STEP1, STEP2"))
  ("PUNISH" :SUBITEM ("BEST EG OF AUTON"))
  ("PUNISH" :SUBITEM ("FEATURE1" "FEATURE2"))
  ("PUNISH" :SUBITEM ("EXCL ASSOC WITH NOTHING"))
  ("PUNISH" :SUBITEM ("NO BETTER NAME"))
  ("PUNISH" :SUBITEM ("DEF OF AUTON"))
  ("PUNISH" :SUBITEM ("DESCRIP OF AUTOON"))
  ("PUNISH" :SUBITEM ("OPPOSITE OF A"))
  ("PUNISH" :SUBITEM ("SYNON1" "SYNON2"))
  ("PUNISH" :SUBITEM ("PRE-EVENT1" "PRE-EVENT2"))
  ("PUNISH" :SUBITEM ("VAL1 ASSOC W AUTO" "VAL2 ASSOC AUT"))
  ("PUNISH" :SUBITEM ("AUT AFFECTS ME PERS1" "AUT AFFECTS ME PERS2"))
  ("PUNISH" :SUBITEM ("POS OUTC1" "POS OUT2"))
  ("PUNISH" :SUBITEM ("NEG OUT1" "NEG OUT2"))
  ("PUNISH" :SUBITEM ("HIGHER GOAL1" "HIGHER GOAL2"))
  ("PUNISH" :SUBITEM ("SUBGOAL1" "SUBGOAL2"))
  ("PUNISH" :SUBITEM ("SCRIPT1" "SCRIPT2"))
  ("PUNISH" :SUBITEM ("SIT PRE AUTO1" "SIT PRE AUT2"))
  ("PUNISH" :SUBITEM ("ALTERN TO AUTON1" "HIGHER GOAL2"))
  ("PUNISH" :SUBITEM ("BLANK WINDOW1"))
  ("PUNISH" :SUBITEM ("REWS OR POS OUTS"))
  ("PUNISH" :SUBITEM ("NEG OUTS"))
  (*DBIMAGE NIL :SUBITEM ("VIS IMAGE"))
  (*DBSOUND NIL :SUBITEM ("SOUND"))
  (*DBSMELL NIL :SUBITEM ("SMELL"))
  (*DBTASTE NIL :SUBITEM ("TASTE"))
  (*DBTACTILE NIL :SUBITEM ("TACTILE"))
  (*DBHAPPY NIL)
  (*DBANGER NIL)
  (*DBUNSURE-OR-NONE NIL))
 :POLE2
 "NOT AUTONOMOUS"
 :BESTPOLE
 1
 (:BIPATH
  ((POLE1 NIL F-ADMIRE NIL)
   (POLE1 NIL PER-ROMANCE NIL)
   (POLE2 NIL CHILD-DISLIKE NIL)))
 :va
 "0.917"
 :RNK
 10)
|#

;; USING 2018 VERSION of *ALL-CS-EXPLORE-QVARS
;; (cs-explore 'HIGHIMPACT ) 
#| FOR HIGHIMPACT (only)
;;   TOM RESULTS--EXCEPT EMOTIONS SECTION AT END 
0 (("ISA" (NIL "Improve happiness." "Improve health." "Improve wealth.")))
1 (("PART" ("healtth" "happiness" "economy" "growth" "invention" "discovery")))
2 ("WHY" ("Improves the  happiness, health, environment of people and other parts of the world."))
3 ("CAUSE" ("Caring for self-others, intelligence, creativity, skill, persistence, resources."))
4 ("EVIDENCE" ("Measures of the change of outcomes variables."))
5 ("HOW" ("Imagination, exploring alternatives, setting goalsl, planning, action, feedback, revision."))
6 ("EXAMPLE" ("Writing and publishing my book."))
7 (("FEATURE" ("Strong positive effects on the happiness, health, wealth,environment of many people.")))
8 ("STEREOTYPE" ("Affects the rest of the world--physical environment, animals, etc."))
9 ("REGNANT" ("Skillful thought and behavior directed toward top goals persistently over time."))
10 ("PROTOTYPE" ("Jesus preaching to his followers."))
11 ("NAME" ("High Impact"))
12 ("DEFINE" NIL)
13 ("DESCRIBE" NIL)
14 ("OPPOSITE" ("Low Impact."))
15 (("SYNONYM" ("Effective" "great outcomes" NIL "world-beater")))
16 (("EVENT" (NIL "directed actions.")))
17 (("VALUE" ("happiness" "health" "material well-being" " wealth" "power" "intelligence" "education" "self-development" "persistence")))
18 (("SELF" ("A top goal")))
19 (("POSEXPECT" ("happiness" "health" "wealth" "friends" "confidence" "respect" "achievement, goal-satisfaction" "status")))
20 (("NEGEXPECT" ("jealousy" "negative side-effects" "unknown")))
21 (("SUPGOAL" (NIL "Contribute to world health." "Improve world happiness." "Improve world knowledge." "Add beauty to world." "Add romance and love to world.")))
22 (("SUBGOAL" (NIL NIL NIL "Take one step at a time." "good organization." NIL "good planning" "time managwment" NIL "management skills" "marketing skills" "engineering skills")))
23 (("SCRIPT" (NIL "relevant experiental theory knowledge")))
24 (("SITUATION-SD" (NIL "")))
25 (("ALT-R" (NIL NIL "non-assetiveness" NIL "fear of being rejected or criticized" NIL "poor information gathering" "disorganization" "giving up easily" "few resources" "low IQ")))
26 (("MOTOR" ("")))
27 (("REINF" ("goal satisfaction" "natural rewards of the impact effects" "self-satisfaction" "respect" "self-development" "knowledge" "practical experience" "expertise" "ability to teach/mentor" "oft...
28 (("PUNISH" (NIL "personal costs of the project" "financial and other costs." NIL "Huge time costs." "Often fail or down periods.")))
29 ("IMAGE" ("A sea of people with improved lives."))
30 ("SOUND" ("Beautiful music."))
31 ("SMELL" ("Sweet smell of success."))
32 ("TASTE" ("A wonderful dinner with my sweetheart."))
|#
;;end results -- except EMOTIONS SECTION --------------

;;OTHER STUFF ------------------------------
#|("BEST-M-FRIEND" "best-m-friend" ELM4-1-1-99 NIL "DAVE"
 :BIPATH (((BEST-M-FRIEND NIL (CAREFOROTHERS (POLE1) NIL))) 
 ((BEST-M-FRIEND NIL (INTIMATE (POLE2) NIL))) 
 ((BEST-M-FRIEND NIL (PSYCHOLOGISTS (POLE1) NIL))) ((BEST-M-FRIEND NIL (CAREABOUTOTHERSFEE (POLE1) NIL))) 

((BEST-M-FRIEND NIL (INSPIREOTHERS (POLE1) NIL))) ((BEST-M-FRIEND NIL (BESTFRIEND (POLE2) NIL))) ((BEST-M-FRIEND NIL (DIRECT-HONEST (POLE1) NIL))) ((BEST-M-FRIEND NIL (UNBRIDLEDHUMOR (POLE2) NIL))) ((BEST-M-FRIEND NIL (FANTASYWORLD (POLE2) NIL))) ((BEST-M-FRIEND NIL (ATHLETIC (POLE1) NIL))) ((BEST-M-FRIEND NIL (ESPOSECHRISTIAN (POLE2) NIL))) ((BEST-M-FRIEND NIL (CRITICAL (POLE2) NIL)))))
|#



;;STORE-IN-CSDBSYM
;;NO LONGER NEEDED--REPLACED BY STORE-CSLINK
;;2018
;;ddd
#|(defun store-in-csdbsym (csdbsym  &key dbkeylist BIPATH topath  from wto 
                                   wfrom info SUBITEM  (append-value-p T) 
                                   (dbprefix "")  default-val 
                                   (track-all-stored-csyms *ALL-STORED-CSYMS))
  "CS-explore. Also see MAKE-CSYM which makes a NETWORK NODE--this ONLY makes database symbol objects--(eg *DB-VALUE).   RETURNS (values new-keylist csdbsym  old-keylist csdbsym-str)   INPUT: csdbsym (sym, string, or unbound). VALUE of KEY is item/value to be stored in csdbsym,  dbkeylist is entire  csdbsym list. Rest of keys are keys followed by value lists.  If key does not exist, creates it. Set DBPREFIX to *DB or *DB-  if WANT TO CREATE NEW CSDB-SYM. SUBITEM key is a subitem of a csdb category (eg. *DBGOAL :BIPATH (TENNIS NIL  :SUBITEM \"win tourney\"). [Note: subitem will appear in EVERY key that is non-nil, so only do ONE key store when use subitem.]"
 (let
     ((rest-keys '(:BIPATH :topath  :from :wto :wfrom :info))
      (rest-keyvalues (list BIPATH topath from wto wfrom info))
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
     ;;(setf old-keylist `("BEST-M-FRIEND" "best-m-friend" ELM4-1-1-99 NIL "DAVE"  :BIPATH (((BEST-M-FRIEND NIL (CAREFOROTHERS (POLE1) NIL))) 
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
   ))|#
;;TEST
;; explore-csym2 previously UNBOUND
;; (store-in-csdbsym  "explore-csym2" :BIPATH '("to-csdb" NIL) )
;; works= (:BIPATH (("to-csdb" NIL)))  EXPLORE-CSYM2  NIL  "testgetsetsym"
;; FOR PREVIOUS sym explore-csym3
;; (setf explore-csym3 '("explore-csym" "explore-csym" NIL ELM4-1-1-99 NIL "DAVE"))
;; (store-in-csdbsym  "explore-csym3" :BIPATH '("my-goal" NIL) )
;; works= ("explore-csym" "explore-csym" NIL ELM4-1-1-99 NIL "DAVE" :BIPATH (("my-goal" NIL)))    EXPLORE-CSYM3    ("explore-csym" "explore-csym" NIL ELM4-1-1-99 NIL "DAVE")   "explore-csym3"
;; APPEND ANOTHER BIPATH
;; (store-in-csdbsym  "explore-csym3" :BIPATH '("plan b" NIL) )
;; works= ("explore-csym" "explore-csym" NIL ELM4-1-1-99 NIL "DAVE" :BIPATH (("my-goal" NIL) ("plan b" NIL)))    EXPLORE-CSYM3  
;; old-keylist= ("explore-csym" "explore-csym" NIL ELM4-1-1-99 NIL "DAVE" :BIPATH (("my-goal" NIL)))  "testgetsetsym"
;; SUBITEM WITH 2 NODES (TENNIS *DGOAL)
;; (store-in-csdbsym  "*DGOAL" :BIPATH '("TENNIS" NIL) :subitem "Win Tourney")
;;works=(:BIPATH (("TENNIS" NIL :SUBITEM "Win Tourney")))  *DGOAL  NIL   "testgetsetsym"  
;;also works=  *DGOAL=> (:BIPATH (("TENNIS" NIL :SUBITEM "Win Tourney"))) 
;; meaning of above: CSDB is *DGOAL it is linked to a NODE="TENNIS". TENNIS IS linked to GOAL with subitem (subgoal)= "Win Touurney" TENNIS also has a :BIPATH ((*DGOAL NIL :subitem "Win Tourney") etc)
;; SECOND NODE OF LINK
;; (store-in-csdbsym  "TENNIS" :BIPATH '("*DGOAL" NIL) :subitem "Win Tourney")
;;works= (:BIPATH (("*DGOAL" NIL :SUBITEM "Win Tourney")))    TENNIS   NIL  "testgetsetsym"  NIL



;; (store-in-csdbsym '*DBCRITTHK8 :dbkeylist '(:wto (testsym)))
;; works = (:WTO (TESTSYM))  *DBCRITTHK8 NIL NIL
;; here
;; (store-in-csdbsym '*DBCRITTHK8 :BIPATH 'new-bipath-item)
;; works= (:WTO (TESTSYM) :BIPATH (NEW-BIPATH-ITEM NEW-BIPATH-ITEM))   *DBCRITTHK8  (:WTO (TESTSYM) :BIPATH (NEW-BIPATH-ITEM))  NIL
;; (store-in-csdbsym '*DBCRITTHK8 :BIPATH 'new-bipath-item2)
;; works= (:WTO (TESTSYM) :BIPATH (NEW-BIPATH-ITEM NEW-BIPATH-ITEM NEW-BIPATH-ITEM2))     *DBCRITTHK8    (:WTO (TESTSYM) :BIPATH (NEW-BIPATH-ITEM NEW-BIPATH-ITEM))    NIL



