;;******************** CSQ-Manage.lisp ***********************
;;
;;SHOULD STILL RUN SHAQ AS WELL AS NEW CSQ FUNCTIONS
;;
;;RUN PC FUNCTIONS AS AN OPTION OF OVERALL CSQ
;;
;; (Main MP functions copied from Screensaver -- then modified)
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


;;GOSHAQ-CSQ
;;2020
;;ddd
#|(defun goshaq-csq (&key  )
  "CSQ-manage. MAIN SHAQ/CSQ controlling function. 
  1. Can load previous SHAQ and/or CSQ data.
  2. Can run SHAQ and/or CSQ (incl explore cs links).
 [Uses GOSHAQ and GOCSQ to run either]."
  (let*
      ((current-process (mp:get-current-process))
       )
    ;;1. BRIEF INTRO INFO TO BOTH SHAQ/CSQ



    ;;2. SELECT SHAQ AND/OR CSQ [not specific parts of CSQ, later]

    ;;CAN RUN SHAQ FROM WITHIN GOCSQ, 
    ;; USE THIS FUNC TO SET RIGHT SETTINGS FOR GOCSQ!!
    ;;EGS *run-csq-p  *run-shaq-intros-p


    ;; CHOICE OF GET SHAQ DATA FOR CSQ ON CSQ INTROS

    ;;SSSSSS START HERE IN GOSHAQ-CSQ




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
    ;;end let, defun
    ))|#
;;TEST
;;









;; UNQUOTE IF RUN SHAQ
#| (when *run-SHAQ-p 
  (dbg:log-bug-form "DEBUG in U-SHAQ-management" :log-file "SHAQ-Deliver LOG.lisp" :message-stream T)|

 (defparameter *shaq-initialized NIL "Set to T when function run to initialize")
  (defparameter *shaq-files-loaded NIL "Value changed after load-shaq-files run")
 )|#
;;
;;***************(GOSHAQ) ==> starts SHAQ in Lisp Interpreter******************
(defparameter *run-shaq-intros-p T)
(defparameter *test-scale-list '()) ;; '(ssl3WritingSkills)) ;;'(ACAD-LEARNING));; '(scollege)) ;; )
;;OK-LIST '(BIO NO-SCALE BELIEFS OUTCOME VALUES-THEMES SKILLS-CONFIDENCE INTERPERSONAL ACAD-LEARNING CAREER-INTEREST)) 
(defparameter *run-qvarlist NIL)
       ;; '(stmajgpa)) '(STURESID) ) ;;'(STURESOURCE)) ;; NIL ) ;;


;; USE TO CHECK *CSQ-DATA-LIST 
;;  (pretty-print-csq-data-list *CSQ-DATA-LIST)

;;; GOSHAQ -- (FOR LISP INTERPRETED VERSION)
;; 
;;ddd GGG
(defun goshaq (&key (run-qvarlist *run-qvarlist) (test-scale-list *test-scale-list )                     (run-shaq-intros-p *run-shaq-intros-p))
  "In U-SHAQ-management, RUN-QVARLIST is a list of qvars/questions to run that EXCLUDES running all other questions. TEST-SCALE-LIST is a list of test scales."
  (setf out nil)
  ;;MUST SET *make-defs-file TO NIL or writes scale defclasses and instances to files to be used in the application builder instead of evaluating them.
  (setf *make-defs-file-p NIL)

  ;;IF SHAQ CONFIG VARS NOT INITIALIZED, DO IT NOW 
  (unless  (boundp '*config-shaq-loaded )
    (load  "C:\\3-TS\\LISP PROJECTS TS\\SHAQ\\config-shaq.lisp"))
  (unless *CSQ-DATA-LIST
    (load  "C:\\3-TS\\LISP PROJECTS TS\\SHAQ\\config-vars.lisp"))
  (unless *shaq-initialized
    (shaq-initialize))
  (setf *CSQ-DATA-LIST '(:csq-data-list)
        *shaq-scaledata-list '(:shaq-scaledata-list)
        *run-shaq-intros-p run-shaq-intros-p)
  (SHAQ-process-manager    ;;  *shaq-post-sym-list *shaq-scale-sym-list  
                           :run-qvarlist run-qvarlist :test-scale-list test-scale-list
                           :run-shaq-intros-p run-shaq-intros-p)
  ;;end goshaq
  )


;;RUN-SHAQ
;;
;;ddd
(defun run-shaq (&key (run-qvarlist *run-qvarlist) (test-scale-list *test-scale-list )                     (run-shaq-intros-p *run-shaq-intros-p))
  "In U-SHAQ-management, RUN-QVARLIST is a list of qvars/questions to run that EXCLUDES running all other questions. TEST-SCALE-LIST is a list of test scales.
THIS VERSION FOR USE IN APPLICATION BUILDER TO MAKE RUNTIME DELIVERY VERSION."
 (setf out nil)
;;IMPORTANT FOR DELIVER, CREATE THE CLASS COMPILE AND INST FILES
;;no, DO OUTSIDE OF DELIVERY  (setf *make-defs-file-p T)

  ;;for debugging
  (setq *debugger-hook* 'my-debugger-hook) ;;function my-debugger-hook defined below

;;SET KEY GLOBAL VARIABLES
  ;;NO (shaq-initialize) FOR RUN-TIME VERSION
;; (unless *shaq-initialized   (shaq-initialize))
  (setf *CSQ-DATA-LIST '(:csq-data-list)
        *shaq-scaledata-list '(:shaq-scaledata-list)
        *run-shaq-intros-p run-shaq-intros-p)

;;MAKE THE CLASS INSTANCES
  (make-persim-class-instances)
  ;;(make-shaq-scale-instances) instances made by defparameters when the inst file loaded

;;END *RUN-SHAQ-P
 )

(defparameter *1-MP-PROCESS-m NIL)


;;TO RUN CSQ
;; 1-USE (GOCSQ) FOR INTERPRETED VERSION (Uses config-CSQ to load)
;; 2-When using APPLICATION BUILDER, use (RUN-CSQ) (uses CSQ-APP)

;;defined with goCSQ (defparameter  *run-CSQ-intros-p T)

;;TO TEST CSQ w/o having to take all the questions manually
;; 1. run GOCSQ (then exit) [or if loads all, U-CSQ-management (loads everything)]
;; 2. compile buffer  CSQ-data-list-eg1.lisp  (or other that sets *csq-data-list  and *CSQ-scaledata-list to test data.
;; 3. run (calc-scale&subscale-scores)
;; 4. run (make-all-questions-text)  makes quest text and sets to symbols  end in T
;; 5. run (make-CSQ-results-text)
;; OLD5. run (setf *testresults (process-scales-results)) makes all the text for all scales, questions

#| (defparameter *CSQ-multi-answer-questions
   '(ID USER-TYPE GOALS BIO JOB LANG ETHNIC RELIGION STU-STATUS
        STU-MAJOR STU-SPECIAL STU-LIVING STU-MISC  STU-GRE-TREND
        STU-APT  STU-FEEL STU-TIME) "This is new for lisp version, must edit")|#
        ;;NOTE: MUST DO SPECIAL FOR ID AND STU-FEEL

;;
;;***************(GOCSQ) ==> starts CSQ in Lisp Interpreter******************
;;MAKES SURE MUST MANUALLY RESET CSYM GLOBAL VARS IN FRAME
(defparameter *INITIALIZE-CSYM-GLOBAL-VARS-P NIL "Can't reset various global accumulative csym global vars unless = T. Eg. *all-stored-csyms, *all-csyms, *all-csartloc-syms, etc.")
(defparameter *test-scale-list '()) ;; '(ssl3WritingSkills)) ;;'(ACAD-LEARNING));; '(scollege)) ;; )
;;OK-LIST '(BIO NO-SCALE BELIEFS OUTCOME VALUES-THEMES SKILLS-CONFIDENCE INTERPERSONAL ACAD-LEARNING CAREER-INTEREST)) 
(defparameter *run-qvarlist NIL) ;; '(stmajgpa)) '(STURESID) ) ;;'(STURESOURCE)) ;; NIL ) ;;

(defparameter  *load-MY-UTILITY-files-p NIL "For loading files in CS-config")
(defparameter *load-CS-UTILITY-files-p NIL "For loading files in CS-config")
(defparameter *load-CS-MODEL-files-p NIL "For loading files in CS-config")

(defparameter *no-elmsym-combo-reset-p nil "Keeps from running make-elmsym-compare-lists--which takes a lot of time")
  ;;RUN CSQ INTROS?
  (when (not (boundp '*RUN-CSQ-INTROS-P))
    (setf  *RUN-CSQ-INTROS-P nil))
  (when (not (boundp '*CS-ART-init-RAN-P))
    (setf   *CS-ART-init-RAN-P nil))

;;DOES IT MAKE NEW COMBOS FOR EACH PERSON OR USE A STANDARD SET 
(defparameter  *use-existing-elmsym-combos T "Does CSQ make new combos for each person or use a standard set")

;; USE TO CHECK *csq-data-list  
;;  (pretty-print-CSQ-data-list *CSQ-data-list)

;;; GOCSQ -- (FOR LISP INTERPRETED VERSION)  ;;(csq-manager



;;GOCSQ
;;
;;ddd the main start function
(defun GOCSQ (&optional load-cs-config-p  INIT-USER-DATA-P 
                        load-CS-MODEL-files-p
                        RUN-CSQ-INITIALIZE-P  ;;put back?? RESET-GLOBAL-CSYM-VARS-P
                        &key csq-reinit-p no-elmsym-reset-p  use-test-qvars-p
                        (default-userdata-path 
                         "C:/3-TS/LISP PROJECTS TS/CogSysOutputs/Tom-USE-AllData2019-10.lisp")
                        (run-select-csq-parts-p T) (run-qvarlist *run-qvarlist)
                        (use-existing-elmsym-combos *use-existing-elmsym-combos)
                        (test-scale-list *test-scale-list ) 
                        (run-CSQ-intros-p *run-CSQ-intros-p) 
                        (run-SHAQ-intros-p *run-SHAQ-intros-p)
                        init-ART-NETWORK-p)
  "In CSQ-manage, RUN-QVARLIST is a list of qvars/questions to run that EXCLUDES running all other questions. TEST-SCALE-LIST is a list of test scales.
 RUN-CSQ-INITIALIZE-P resets EVERYTHING. "
  (setf out nil)
  ;;MUST SET *make-defs-file TO NIL or writes scale defclasses and instances to files to be used in the application builder instead of evaluating them.
  (setf *make-defs-file-p NIL)

  (defvar  *INITIALIZE-USER-DATA-VARS-P NIL "Causes all main user data global vars to initialize in CS-config")

  ;;WHAT TO LOAD/INITIALIZE
  (cond
   ;;load and initialize ALL
   ((and load-cs-config-p ;;was  (or  load-cs-config-p (not (boundp 'CS-ART-init)))
         init-user-data-p)
    (setf *INITIALIZE-USER-DATA-VARS-P T    
          *INITIALIZE-CSYM-GLOBAL-VARS-P T
          *load-CS-MODEL-files-p T   
          *load-MY-UTILITY-files-p T
          *load-CS-UTILITY-files-p T
          *load-CS-MODEL-files-p T
          run-csq-initialize-p T)
    (load  "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CS-config.lisp")
    )
   ;;load cs-config all load files; but DON'T INITIALIZE USER DATA FILES
   (load-cs-config-p
    (setf *INITIALIZE-USER-DATA-VARS-P NIL 
          *INITIALIZE-CSYM-GLOBAL-VARS-P NIL)
    (cond
     (load-CS-MODEL-files-p
         (setf  *load-CS-MODEL-files-p T))
     (T (setf *load-CS-MODEL-files-p NIL)))
    ;;load CS-config
    (load  "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CS-config.lisp")
    )
   ;;don't load any files or initialize any user data
   (T (setf *INITIALIZE-USER-DATA-VARS-P NIL    
          *INITIALIZE-CSYM-GLOBAL-VARS-P NIL
          *load-CS-MODEL-files-p NIL   
          *load-MY-UTILITY-files-p NIL
          *load-CS-UTILITY-files-p NIL
          *load-CS-MODEL-files-p NIL
          run-csq-initialize-p NIL)))

  ;;reset *initialize-user-data-vars-p so don't accidently erase user data
  (setf *INITIALIZE-USER-DATA-VARS-P NIL
        *INITIALIZE-CSYM-GLOBAL-VARS-P NIL)

  ;;from old gocsq
  ;;ELMSYM-COMBOS
  (cond
   (no-elmsym-reset-p
    (setf *no-elmsym-combo-reset-p T))
   (t (setf *no-elmsym-combo-reset-p NIL)))
  ;;SELECT CSQ PARTS?
  (when run-select-csq-parts-p
    (setf *run-select-csq-parts-p T))
  ;;DEFAULT-USERDATA-PATH
  (when default-userdata-path
    (setf *default-CSQ-userdata-path default-userdata-path))
  ;;end from old gocsq

  ;;CSQ-INITIALIZE run IF init-user-data-p run-csq-initialize-p
  (cond
   ((or init-user-data-p run-csq-initialize-p)
    (CSQ-INITIALIZE :use-test-qvars-p use-test-qvars-p 
                    :if-elmsym-exists-reset-p t :unbind-csq-vars-p t
                    :if-elmsym-exists-do-nothing-p NIL :save-all-userdata-p t)
    (sleep 2))
   ;;CSQ-REINIT-P ? Used programatically? Check/revise??
   (csq-reinit-p
    (csq-reinit :use-test-qvars-p use-test-qvars-p)))

  (when run-csq-initialize-p ;;put back in OR reset-global-csym-vars-p)
    (setf *INITIALIZE-CSYM-GLOBAL-VARS-P T)
    (set-vars-to-value NIL '( *ALL-MAKE-CSYMS *ALL-MAKE-CSARTLOC-SYMS
                              *ALL-CSYMS *ALL-CSARTLOC-SYMS *ALL-TREE-CSYMS)))

  ;;FOR INIT-ART-NETWORK-P
  (when (and init-ART-NETWORK-p (null  *CS-ART-init-ran-p))
    (CS-ART-init))

  ;;INIT DATA LISTS ETC --done in csq-initialize
  (setf *run-CSQ-intros-p  run-CSQ-intros-p
        *run-SHAQ-intros-p  run-SHAQ-intros-p)

  ;;(break "In GOCSQ Before CSQ-process-manager")

  ;;RUN MAIN FUNCTION
  (CSQ-process-manager    ;;  *shaq-post-sym-list *shaq-scale-sym-list  
                          :run-qvarlist run-qvarlist :test-scale-list test-scale-list
                          :run-shaq-intros-p run-shaq-intros-p 
                          :run-CSQ-intros-p run-CSQ-intros-p)
  :use-existing-elmsym-combos use-existing-elmsym-combos
  ;;end GOCSQ
  )


;;RUN-CSQ
;;
;;ddd
(defun run-CSQ (&key (run-qvarlist *run-qvarlist) (test-scale-list *test-scale-list )                     (run-CSQ-intros-p *run-CSQ-intros-p) 
                     (use-existing-elmsym-combos *use-existing-elmsym-combos)
                     run-shaq-intros-p)
  "In CSQ-manage, RUN-QVARLIST is a list of qvars/questions to run that EXCLUDES running all other questions. TEST-SCALE-LIST is a list of test scales. THIS VERSION FOR USE IN APPLICATION BUILDER TO MAKE RUNTIME DELIVERY VERSION."
 (setf out nil)
;;IMPORTANT FOR DELIVER, CREATE THE CLASS COMPILE AND INST FILES
;;no, DO OUTSIDE OF DELIVERY  (setf *make-defs-file-p T)

  (when *run-shaq-p
  ;;for debugging
  (setq *debugger-hook* 'my-debugger-hook) ;;function my-debugger-hook defined below

;;SET KEY GLOBAL VARIABLES
  ;;NO (shaq-initialize) FOR RUN-TIME VERSION
;; (unless *shaq-initialized   (shaq-initialize))
  (setf *CSQ-DATA-LIST '(:csq-data-list)
        *shaq-scaledata-list '(:shaq-scaledata-list)
        *run-shaq-intros-p run-shaq-intros-p)
  ;;end *run-shaq-p
  )
  (when *run-CSQ-p
    ;;for debugging
    (setq *debugger-hook* 'my-debugger-hook) ;;function my-debugger-hook defined below

    ;;SET KEY GLOBAL VARIABLES
    ;;NO (CSQ-initialize) FOR RUN-TIME VERSION??? old notes
    ;; (unless *CSQ-initialized   (CSQ-initialize))
    (init-main-csq-variables)
    (setf  *run-CSQ-intros-p run-CSQ-intros-p)
    ;;end *run-CSQ-p
    )

;;MAKE THE CLASS INSTANCES (good for both SHAQ and CSQ)
  (make-persim-class-instances)
  ;;(make-shaq-scale-instances) instances made by defparameters when the inst file loaded

  ;;
  (CSQ-process-manager    ;;  *shaq-post-sym-list *shaq-scale-sym-list  
                :run-qvarlist run-qvarlist :test-scale-list test-scale-list
                :run-shaq-intros-p run-shaq-intros-p
                :use-existing-elmsym-combos use-existing-elmsym-combos
                :run-CSQ-intros-p run-CSQ-intros-p)
  ;;end run-CSQ
  )

;;xxx -------------------------------- MP PROCESS FUNCTIONS -------------------
#|
 If the process process is waiting, process-poke causes it TO RUN ITS WAIT-FUNCTION AS SOON AS POSSIBLE, and IF THE WAIT FUNCTION RETURNS TRUE,  the process returns from process-wait. This has an effect only in SMP LispWorks, where the running
of the wait-function can happen asynchronously. process-poke can be used to avoid delays that happen because the next execution of the wait-function does not happen immediately. 
without the call to process-poke, the process may wake up after some delay.
process-poke RETURNS T IF IT ACTUALLY POKED THE PROCESS or nil otherwise (when the process is not waiting or is stopped).
|#

;;CSQ-PROCESS-MANAGER          
;;  
;;ddd
(defun CSQ-process-manager (&key ;;(question-sym-list-sym '*All-PCE-elementQs)  
                                   run-qvarlist test-scale-list 
                                   (run-CSQ-intros-p *run-CSQ-intros-p)
                                   (run-shaq-intros-p *run-shaq-intros-p)
                                   (use-existing-elmsym-combos *use-existing-elmsym-combos)
                                   append-to-scale-cat-list )
                                                   ;;no args for Deliver?  text height)
  "In U-SHAQ-management.lisp, manages all processes makes the basic specific-instance elements.  RUN-QVARLIST is a list of qvars/questions to run that EXCLUDES running all other questions.  =  question-sym-list "
  (let (  ;;not used?? (manager-mailbox (mp:ensure-process-mailbox))
        ;;(question-sym-list (eval question-sym-list-sym))
        (text) 
        (height 100)
        ) 
    (when *run-shaq-p
      (setf append-to-scale-cat-list  '(HQ)
            text "Cognitive Systems Questionnaire (CSQ)"))

    ;;INITIALIZE SHAQ IF NOT DONE
  ;;MOVED  (unless (and (boundp '*deliver-version-p) (null *deliver-version-p)) (initialize-shaq))
  ;;GLOBAL VARS USED BY INTERFACE INSTANCES AND CALLBACKS
  ;;  TO COMMUNICATE WITH FUNCTIONS ETC
   (defparameter *intro-frame-results-list nil) 
   (defparameter *question-frame-results-list nil) 
   (defparameter *quest-frame-results-list-brief nil)
   (defparameter *scale-frame-results-list nil) 
   (defparameter *help-frame-results-list nil) 
   (defparameter *results-frame-results-list nil) 

    ;;TO-DO?
    ;;READ IN FILE PARAMETER DEFAULTS TO OVERRIDE DEFPARAMETERS
    ;; IF *settings-filename is a real file that exists
   ;; (load-eval-db *settings-filename) 

   ;;TO RUN CSQ -------------------
   (when *run-csq-p
     (setf text "Cognitive Systems Questionaire (CSQ)")
     ;;(BREAK "BEFORE mp:process-run-function 'CSQ-MANAGER")

     (setf *CSQ-main-process
           (mp:process-run-function "CSQ MAIN PROCESS"
                                    '(:mailbox "CSQ-main-process-mailbox")
                                    'CSQ-manager ;;question-sym-list 
                                    run-qvarlist test-scale-list run-CSQ-intros-p 
                                    run-shaq-intros-p
                                    append-to-scale-cat-list 
                                    :use-existing-elmsym-combos use-existing-elmsym-combos))
     ;; (csq-manager  run-qvarlist test-scale-list run-csq-intros-p run-shaq-intros-p append-to-scale-cat-list  
     ;;end when *run-csq-p
     )

   ;;TO RUN SHAQ -------------------
   (when *run-SHAQ-p
          (setf text "Success and Happiness Attributes Question (SHAQ)")
     (setf *SHAQ-main-process
           (mp:process-run-function "SHAQ MAIN PROCESS"
                                    '(:mailbox "SHAQ-main-process-mailbox")
                                    'SHAQ-manager ;;question-sym-list 
                                    run-qvarlist test-scale-list  
                                    run-shaq-intros-p
                                    append-to-scale-cat-list))
                                    ;;question-sym-list-sym))
     ;;end when *run-SHAQ-p
     )
         
   ;;end let, CSQ-process-manager
   ))





;;xxx
;;------------------------------- FOR CSQ ONLY -----------------------------------------


;;CSQ-MANAGER
;;
;;ddd
(defun CSQ-manager (run-qvarlist test-scale-list
                                 run-CSQ-intros-p  run-SHAQ-intros-p
                                 append-to-scale-cat-list 
                                 &key (not-send-csqdat-p T) (top-csyms '($CS))
                                 ;;csym args
                                 (if-csym-exists :REPLACE)
                                 (csym-pre "<")
                                 ;;choose one of 2 below to make csyms
                                 (make-all-csyms-from-cs-csym-db-p T) ;;for making tree
                                 make-scale&qvar-csyms-from-scale-cats-p
                                 (all-cs-db-cats-list *MASTER-CSART-CAT-DB)
                                 (popup-store-file-objects-p T)
                                 (make-csym-treeviewer-p T)
                                 (use-existing-elmsym-combos T)
                                 (reset-*all-elmsym-compare-combos-p T)
                                 (all-elmsyms *ALL-ELMSYMS) (all-explore-syms *PCSYMS)
                                 (all-elmsym-qvars '*ALL-PC-ELEMENT-QVARS)
                                 (question-sym-list  *ALL-PCE-ELEMENTQS)
                                 ;;CS-EXPLORE ARGS
                                 (cs-pole 'bestpole)
                                 ;;input lists
                                 (qvars-list-name (append-when-boundp-or-listp
                                                   '(*All-PC-element-qvars 
                                                     *ALL-CS-EXPLORE-QVARS 
                                                     *SHAQ-question-variable-lists )))
                                  ;;problems '*ALL-CSQ-QVARS)
                                 (quests-list-name '*ALL-CSQ-QUESTIONS)
                                 ;;keys
                                 (clevkey :CLEV)
                                 (sublist-key :S) (supsys-key :CSS ) 
                                 (qtype-key :QT)  (sublist-key :S)
                                 (catkey :CAT) (valkey :V) 
                                 (csvalkey :VA) (csrankey :RNK)
                                 (infokey  :INFO) (pckey  :PC)
                                 (bipathkey :BIPATH) (bestpolekey :BESTPOLE)
                                 (tokey :TO) ;;was :topath
                                 (fromkey :FROM) 
                                 (wtokey :WTO) (wfromkey :WFROM)
                                 (pclistkey :PCLIST) (systemkey  :CSYS) ;;not used?
                                 linktype (linktype-key :LNTP)  
                                 restkeys
                                 (save-cs-cats-db-tree-file "cs-cats-db-tree-file.lisp")
                                 (cs-db-csyms&vals-file "cs-db-csyms&vals-file.lisp")
                                 (linkfrom :csym)  default-linktype2
                                 (csym1dir :BIPATH) (csym2dir :BIPATH)
                                 csymdata  (supsys2 '$MIS) csloc2 csdata2    
                                 (set-global-vars-p T) (linkkey :LNTP)
                                 ;;OUTPUT GLOBAL VARS during sub processing
                                 (all-stored-csyms-sym '*ALL-STORED-CSYMS) 
                                 ;;NEWLINK ARGS
                                 (stored-newlink-csyms-sym '*NEWLINK-MADE-CSYMS)
                                 (make-new-csym-links-p T) 
                                 (incl-na-none-text-button-p T)
                                 confirm-input-p  
                                 (min-length 3) (max-length 12) (extra-chars "xxxxxxxxxxxx")
                                 (if-exists-change-p t) (if-null-string-abort-p t)
                                 (word-separator "") cond-words-p (min-word-len 3) 
                                 (phrase-min 3) (phr-word-max 5)
                                 ;;CSARTLOC ARGS
                                 (csartloc-origin :supsys-csartloc) (supsys-csartloc '$P)
                                 (make-new-csartloc-p T)
                                 (update-supsys-sublist-p T)
                                 topdim dims  (last-dim :csym) supsys
                                 topdimslist  def-topdimsym   def-supsys
                                 new-csartloc new-csartloc-vals
                                 parents  
                                 ;;old (make-new-csartloc-p t)
                                 ;;old (roots-at-clevs '(0))    
                                 (artsym-n 2) (if-exists-replace-p t)  csartloc-n3-item 
                                 csartloc-rest-vals   set-as-csartdims-p
                                 (separator-str ".") (return-csartdims-p t) 
                                 (append-all-csartloc-syms&vals-p t)   
                                 ;;MORE ARGS FOR MAKING CSYMS
                                 (set-final-global-vars-p t) 
                                 (set-global-vars-p t) (set-all-global-vars-p t) 
                                 omit-scales-p omit-qvars-p omit-special-vars-p 
                                 omit-custom-vars-p 
                                 ;;input lists
                                 (main-scale-classes *CSQ-MAIN-SCALE-CLASSES)
                                 ;;not needed 
                                 ;;(misc-bio/lrn/qvar-lists *CSQ-BIO-ACAD-ETC-SYS/QVARS)
                                 ;;(special-classes-arglists *CSQ-SPECIAL-SCALE-CSYM-ARGLISTS) 
                                 custom-csym-arglists  ;;not needed *custom-arglists-for-csyms)
                                 ;;ARGS FOR STORING DATA
                                 (set-new-csym-global-vars-p T)
                                 ;;DATA PATHS
                                 ;;For original CSQ data output
                                 (raw-CSQ-data-path *RAW-CSQ-DATA-PATH)   
                                 ;;"C:/3-TS/LISP PROJECTS TS/CogSysOutputs/RAW-CSQ-DATA.lisp"
                                 ;;for all csyms output (as they are made)
                                 (csq-csyms-data-path *CSQ-CSYMS-DATA-PATH) 
                                 ;;"C:/3-TS/LISP PROJECTS TS/CogSysOutputs/CSQ-CSYMS-DATA.lisp"
                                 (raw-SHAQ-data-path *RAW-SHAQ-DATA-PATH)
                                 ;;"C:/3-TS/LISP PROJECTS TS/CogSysOutputs/RAW-SHAQ-DATA.lisp"
                                 (raw-SHAQ-results-path *RAW-SHAQ-RESULTS-PATH)
                                 ;;FOR STORING CSYM DATA
                                 (user-data-dir *CSQ-DATA-DIR)
                                 (user-csym-storage-file *CSQ-USER-CSYM-DATA-FILE)
                                 (append-filename-begin "2-TOM-")
                                 append-filename-end     
                                 (listsyms-sym '*ALL-CSYMS-LIST-SYMS)
                                 ;;if eval-syms-p, evals syms & get up-to-date vals,
                                 ;; makes new syms&vals lists
                                 (store-data-listsyms '( 
                                                   *ALL-ELMSYMS ;;N=58
                                                   *ALL-PCSYMS ;;N=128 
                                                   *ALL-MAKE-CSYMS ;;N=795             
                                                   *ALL-MAKE-CSARTLOC-SYMS ;;N=855
                                                   ;;*ALL-CSARTLOC-SYMS&VALS
                                                   ;;*ALL-CSYMS&VALS
                                                   ))
                                 (sys-csyms-varname '*ALL-STORED-SYS-CSYMS)
                                 (all-csyms-sym '*ALL-CSYMS)
                                 (EVAL-SYMS-P T)
                                 accumulate-all-syms&vals-p 
                                 (store-all-syms&symvals :IN-MAKE-TREE) ;;or :HERE
                                 (use-dated-filename-p T)
                                 (use-time-wdate-p T)
                                 pprint-user-output-p
                                 dir                                        
                                 ;;"C:\\3-TS\\LISP PROJECTS TS\\CogsysOutputs\\") 
                                 (pre-listname-str "*file-")
                                 (if-output-file-exists :overwrite)
                                 accumulate-all-lists-p 
                                 (all-syms-list-sym '*ALL-CSYM-LISTNAMES)
                                 eval-nth-in-symlist 
                                 (file-head-message 
                                  ";;TOM ALL STORED CSYMS & CSYM-VALS")
                                 ;;ARGS FOR TREEVIEWER
                                 (top-csym-list '($CS))
                                 (frame-title *csym-treeviewer-frame-title)
                                 (check-boxes-p *incl-cs-viewer-check-boxes) 
                                 (make-treeviewer-options-interface 
                                  *make-treeviewer-options-interface) 
                                 group-by-val-p order-by-rank-p last-list=value-p
                                 (valkey :v) (sublistkey :s)
                                 (min-treeview-pane-height *csym-treeviewer-frame-ht) 
                                 (min-treeview-pane-width *csym-treeviewer-frame-width)
                                 (x *csym-treeviewer-frame-x) (y *csym-treeviewer-frame-y) 
                                 frame-init-args (expand-tree-p 99) (initial-y 20)
                                 ;;ARGS FOR STORING NON-PC-related CSYMS
                                 (all-csyms-output-file
                                  "2020-TOM-CSQ-CSYM-OUTPUT-FILE.lisp")
                                 (csym-out-dir 
                                  "C:\\3-TS\\LISP PROJECTS TS\\CogsysOutputs\\") 
                                 (eval-nth-in-symlist NIL)
                                 (csym-out-file-heading 
                                  ";;TOM ALL STORED CSYMS & CSYM-VALS")
                                 )
  "In CSQ-manager,  Called by CSQ main process.  Code for management of entire CSQ process. APPEND-TO-SCALE-CAT-LIST adds superclass scale categories get scale-lists from. STORAGE: Stores STORE-DATA-LISTSYMS (eg (*ALL-STORED-SYS-CSYMS *ALL-CSYMS ) in all-csyms-output-file. If  SET-NEW-CSYM-GLOBAL-VARS-P, sets GLOBAL VARS *all-new-csyms *all-new-scale-csyms *all-new-qvar-csyms *all-new-csartloc-syms *new-elmsyms *new-pcsyms. in ADDITION to other global vars in "  
  (let*
      ((dated-csq-csyms-data-path
            (make-dated-pathname csq-csyms-data-path :root nil :file-ext nil 
                                 :incl-time-p use-time-wdate-p ))
       )
    ;;SET NEW GLOBAL PATH VAR--for later use?
    (setf *DATED-CSQ-CSYMS-DATA-PATH dated-csq-csyms-data-path)   

  ;;STEP 1: CSQ INTRO FRAMES & PRE-PROCESSING
  ;;1.1 RESET GLOBAL SELECTION VARS (done in go-csq-choices-callback)
  ;; *run-complete-csq-p  ;;1  *run-complete-csq-NO-SHAQ-p  ;;2
  ;; *run-begin-with-find-pcs-p  ;;3 *run-begin-with-find-csvalues-p   ;;4
  ;; *run-begin-with-find-csvalranks-p  ;;5 *run-begin-with-cs-explore-p  ;;6
  ;; *run-shaq-only-p  ;;7 *run-begin-with-load&view-data  ;;8
  ;; *run-begin-with-view-data  ;;9

  ;;1.2 RUN MAKE-CSQ-INTRO-FRAMES (setf above selection vars)
  
  ;;1.2.0 RUN-CSQ-CHOICE-INTERFACE
  ;; To choose what user data to load (if any) & where to start csq-manager.
  ;; Callback actually loads user data
  (run-csq-choice-interface (mp:get-current-process))
  (mp:current-process-pause 300)
      ;;use results of csq-intro callback [file loaded in callback when appropriate]
      (when *load&view-csym-data-p 
        (setf make-csym-treeviewer-p T
              *begin-csq-manager-view-data-p T
              *run-begin-with-view-data T
             store-all-syms&symvals NIL
            *save-all-userdata-p NIL)
           ;;(break "After csq-choice In when *load&view-csym-data-p <THM12PLE")
            (sleep 20))
 ;; (load-user-csq-data    "C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\0-TOM-ALL-CSDATA-NoErrors-2020-08-26.lisp")
 ;; (load-user-csq-data    "C:/3-TS/LISP PROJECTS TS/CogSysOutputs/0-TOM-ALL-CSDATA-NoErrors-2020-08-26.lisp")

  ;;SKIP TO SAVE &/or VIEW DATA?
  (unless *begin-csq-manager-view-data-p ;; *run-begin-with-view-data  ;; 
    (unless *begin-csq-manager-store-data-p

      ;;1.2.1 RUN CSQ-INTRO INFO FRAMES?
      (when *run-CSQ-intros-p
        (make-CSQ-intro-frames)
        ;;hold until poked--not needed?
        ;;(mp:current-process-pause 3600  'check-for-frame-visible)
        ;; (BREAK "CSQ 1- POST make-CSQ-intro-frames")
        )


      ;;1.3: SELECT COMBOS FOR FINDING  PCs
      ;;Following is over-ridden by the step choice frame below
      (cond
       (use-existing-elmsym-combos (setf *use-existing-elmsym-combos T))
       (t (setf *use-existing-elmsym-combos NIL)))
      ;;(break (format nil "*use-existing-elmsym-combos= ~A" *use-existing-elmsym-combos))
      (format T "*use-existing-elmsym-combos= ~A" *use-existing-elmsym-combos)

      ;;1.4: RESET OTHER GLOBAL VARS
      (setf *pc-items-ratings-lists nil)
      ;;SSSSS MAKE/CHECK DEFPARAMETERS FOR THESE
      ;;2020--NO, done in csq-initialize
      #|  (setf *all-new-csyms NIL      *all-new-scale-csyms NIL
        *all-new-qvar-csyms NIL   *all-new-csartloc-syms NIL)|#
      (setf  *new-elmsyms NIL  *new-pcsyms NIL)

      ;;1.5: SET LOCAL VARS
      (let*
          ((userid)
           (user-csqdata-list)
           (scale-cat-list (find-all-direct-subclass-names '(per-system))) ;;= ("OUTCOME" "CAREER-INTEREST" "ACAD-LEARNING" "INTERPERSONAL" "SKILLS-CONFIDENCE" "BELIEFS" "VALUES-THEMES" "BIO") 
           (selected-category-list)
           (selected-question-list)
           (selected-q-list-length)
           (q-frame-instance)
           (previous-q-name)
           ;;SSS CAN MANUALLY SET THESE FOR TESTING
           (run-TEST-quests-p)
           (utype-selected-scalescats)
           (utype-selected-qvars-in-datalist)
           (ugoals-selected-scalescats)
           (ugoals-selected-qvars-in-datalist)
           (user-selected-scalecats)
           (user-selected-qvars-in-datalist)
           (intro-selected-scalecats)
           (all-selected-scales)
           (selected-cats)
           (selected-scalecats)
           (begin-selection)
           (n-combos)
           (all-scalecats)
           (all-selected-questions)
           (selected-scales)
           (all-scale-inst-strings)
           (all-scale-inst-objects)
           ;;SHAQ
           (scales-subscales-results-text)
           (scales-ss-quests-results-text)
           ;;actual selections by user
           (CSQ-select-scales-instance)
           (all-scale-data-list)
           (all-elm-combos)
           (elmsyms-compare-list)
           ;;text
           (all-text-questsyms-list)
           (global-combos-sym)
           (return-combos)
           (all-combos)
           (current-process (mp:get-current-process))
           ;;end let list
           )
        ;;STEP 2: RUN SELECTED CSQ AND/OR SHAQ FRAMES 

        ;;CSQ 2.0: RUN CSQ =====================================
        ;;
        (when (or *RUN-CSQ-P *run-complete-csq-p *run-complete-csq-NO-SHAQ-p)
          ;;CSQ NOTES:
          ;;CSQ 1.0: MAKE KEY CSQ CHOICES, 
          ;;                1. where to begin and  2. make new pc combos?
          ;;MAKE-CSQ-CHOICE-INTERFACE
          ;;    1.chooses entry point = *run-complete-csq-p; 
          ;;              *run-begin-with-find-pcs-p; and/or  *csq-begin-step
          ;;    2. file to load data from (if any) = *csq-previous-data-file
          ;;SSSS CHECK NEW ALTERN FOR EXPLORE A PC
          ;; LATER??  WRITE FUNCTION TO SEE WHAT DATA ARE IN DATA FILE, TO SEE WHICH STEP TO START AT INSTEAD OF CHOICE BELOW??

          ;;CSQ 2.1: IDENTIFY NAMES OF REAL PEOPLE FROM PEOPLE  ELMS   
          ;;Names are added to FIFTH position in ELMSYM values list
          (when (or *run-complete-csq-p *run-only-write-elms-p)
            (make-elmsym-name-frames )
            ;;done in make-elmsym-name-frames
            ;;(mp:current-process-pause 3600  'check-for-frame-visible)
            )      
          ;;(BREAK "CSQ 2-POST make-elmsym-name-frames")
      
          ;;CSQ 2.2: MAKE FRAMES FOR IDENTIFYING PC ELEMENTS
          ;;
          ;;CSQ 2.2.1: FIND OR MAKE ELMSYM COMPARISON COMBOS
          (when (or *run-complete-csq-p *run-complete-csq-NO-SHAQ-p
                    *run-begin-with-find-pcs-p *run-only-find-pcs-p)
            ;;GET COMBOS OF 3 ELEMENTS
            ;;EITHER (1) USE STANDARDIZED SET or
            ;;  (2) CALC NEW SET BELOW
            (cond
             ;;USE-EXISTING-ELMSYM-COMBOS? set in config file default T
             (*USE-EXISTING-ELMSYM-COMBOS 
              (cond
               ;;TEST SITUATION
               ((equal *all-PC-element-qvars *test-pc-element-qvars)
                (setf global-combos-sym '*test-elmsym-combos
                      return-combos *test-elmsym-combos 
                      all-combos nil))
               ;;NORMAL SITUATION USING PRE COMBOS
               (*all-elmsym-compare-combos
                (setf global-combos-sym '*all-elmsym-compare-combos 
                      return-combos *all-elmsym-compare-combos 
                      all-combos nil))
               ;;NORMAL USING COMBOS FROM FILE (usually evaluated in config)
               (t
                (multiple-value-setq (global-combos-sym n-combos return-combos all-combos )
                    (get-existing-elmsym-combos  use-existing-elmsym-combos)))))   
             ;;USING NEW COMBOS                 
             (T
              ;;Make combinations of 3 elements 
              (unless *no-elmsym-combo-reset-p  ;;why is this here??
                (multiple-value-setq (global-combos-sym n-combos return-combos all-combos )
                    (make-elmsym-compare-lists))  ;;defaults to *all-elmsyms and *all-elmsym-compare-combos))
                (when (and (boundp reset-*all-elmsym-compare-combos-p)
                           reset-*all-elmsym-compare-combos-p)
                  (setf  *all-elmsym-compare-combos return-combos))
                )))
            ;;SS START HERE  PUT CODE ABOVE SO CAN EITHER  START WITH 
            ;;   1. MAKING PERM COMBOS AND/OR 
            ;;   2. COMPARE, FIND PCs, 3. RATE PCS?
            ;;NOTE: I COMPLETED CSQ THRU FINDING ALL ELMSYMS (see test1 file)
            ;;(BREAK "AFTER COMBOS SELECTED")
        
            ;;SAVE ALL USERDATA FROM UP TO NOW?
            (when *save-all-userdata-after-find-elms
              (save-csq-data-to-file csq-raw-data-path)) ;;*CSQ-RAW-DATA-PATH

            ;; COMBO OUTPUTS
            ;;ALL COMBOS
            ;;*people-elmsym-combos
            ;;*groups-elmsym-combos
            ;;*self-elmsym-combos
            ;;RANDOM SAMPLE OF COMBOS
            ;;*random-people-elmsym-combos
            ;;*random-groups-elmsym-combos
            ;;*random-self-elmsym-combos
            ;;*all-elmsyms-comparisons
            ;;N SAMPLE COMBOS
            ;;*n-people-combos
            ;;*n-group-combos
            ;;*n-self-combos
            ;;*n-elmsym-combos

            ;;CSQ 2.2.2 MAKE THE FRAMES TO FIND THE NEW PCS
            (MAKE-PC-POLES-FRAMES  return-combos)  ;;was using old functions *all-elmsyms-comparisons)
            (BREAK "CSQ 3-POST make-pc-poles-frames")

            ;;pc-groups pc-self)) ;;*all-pc-element-qvar-cats)
            ;;  (make-pc-poles-frames '(:CSQ-DATA-LIST :PCSYM-ELM-LISTS ((A (MOTHER FATHER TEACHER)) (B (MOTHER BEST-M-FRIEND TEACHER)) (C (MOTHER FATHER BEST-M-FRIEND)) (D (FATHER BEST-M-FRIEND TEACHER)))))

            ;;hold until poked, NO? done inside make-pc-poles-frames??

            ;;RATE THE VALUE OF EACH PC
            ;;adds values to *csq-data-list
            ;; First, add key to *csq-data-list
            ;;seems to cause error--processed before above function?? put inside it.
            ;; (setf *csq-data-list  (append *csq-data-list  (list :pc-values)))
            ;;(BREAK "aftter (append *csq-data-list  (list :pc-values))")

            ;;END WHEN (or *run-complete-csq-p *run-begin-with-find-pcs-p *run-only-find-pcs-p)
            )   

          ;;if make-pc-poles-frames not called must pause here?
          ;;(mp:current-process-pause 1000) ;;  'check-for-frame-visible)      

          ;;CSQ 2.3: RATE PC VALUES & RANK THEM
          (when (or *run-complete-csq-p *run-complete-csq-NO-SHAQ-p
                    *run-begin-with-find-csvalues-p *run-only-find-csvalues-p
                    *run-begin-with-find-csvalranks-p)
            ;; MAKE-PC-RATE-VALUE-FRAMES TO RATE PC VALUES
            (make-pc-rate-value-frames *csq-data-list)   
            (mp:current-process-pause 3600)
            (BREAK "CSQ 2.3-POST make-pc-rate-value-frames")
            ;;end rate pc values
            )
          ;;hold until poked --NO, done inside make-pc-rate-value-frames??
          ;;If start here, need pause here?
          ;;  'check-for-frame-visible)

          ;;CSQ 2.4: RANK TOP VALUES WITHIN EACH RATING CATEGORY
          ;; (setf *pc-items-ratings-lists  '(((KIND5 "0.917") (K1 "0.917") (NICE "0.917"))((TALL "0.833") (FEMAL "0.667") (PAR "0.833"))))
          ;;works= (((("NICE" 1) ("K1" 2) ("KIND5" 3)) (("TALL" 1) ("PAR" 2)) (("FEMAL" 1))))
          ;;unders= ("UNDERS" "UNDERS vs NUND" CS2-1-1-99 NIL NIL :PC ("UNDERS" "NUND" 1 NIL) :POLE1 "UNDERS" :POLE2 "NUND" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL FATHER NIL)))
          ;;SSSS CHECK *pc-items-ratings-lists IN SAVED DATA FILE
          ;;NOT if make new ones here??     
          (when  (or *run-complete-csq-p *run-complete-csq-NO-SHAQ-p
                     *run-begin-with-find-pcs-p *run-begin-with-find-csvalues-p
                     *run-begin-with-find-csvalranks-p *run-only-find-csvalues-p)

            ;;if needed, set *csq-data-list *file-csq-data-list
            (when  (and *file-csq-data-list (< (list-length *csq-data-list) 10))
              (setf *csq-data-list *file-csq-data-list))
       
            ;;make-pc-items-ratings-lists *pc-items-ratings-lists
            (multiple-value-setq (*pc-items-ratings-lists N)
                (make-pc-items-ratings-lists *csq-data-list))
            ;;RANK THE VALUES
            (manage-value-rank-frames `((:items-ratings-lists
                                         ,(LIST *pc-items-ratings-lists):group-by-rating-across-groups)))
            ;;eg KIND = "KIND" "kind vs ukind" CS2-1-1-99 NIL NIL :PC ("kind" "ukind" 1 NIL) :POLE1 "kind" :POLE2 "ukind" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)) :CSVAL "0.917" :RNK "2")
            (mp:current-process-pause 3600)
            (break "after rank top values")
            ;;end when ;;csq 2.4: rank top values
            )
          ;;CSQ 3: EXPLORE A COGNITVE SYSTEM IN DEPTH?
          (when  (or *run-complete-csq-p  *run-complete-csq-NO-SHAQ-p
                     *run-begin-with-find-pcs-p *run-begin-with-find-csvalues-p
                     *run-begin-with-find-csvalranks-p
                     *run-begin-with-cs-explore-p *cs-explore-indepth-p)
            (break "BEFORE explore in depth?")

            ;;CSQ 3.1: INITIALIZE THE CS-EXPLORE GLOBAL VARS, ETC.
            (initialize-cs-explore)

            ;;CSQ 3.2: RUN CS-EXPLORE-CSYMS
            ;;     ==> SETS *ALL-STORED-CSYMS & *NEWLINK-MADE-CSYMS
            (cs-explore-csyms  all-explore-syms ;;= *pcsyms
                               :cs-pole cs-pole :qvars-list-name qvars-list-name 
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
            ;;end EXPLORE IN DEPTH
            )
          ;;(break "Before SAVE ALL THE USER DATA")

          ;;CSQ 4: SAVE ALL THE USER DATA--not if *run-begin-with-load&view-data
          (when (and *save-all-userdata-p (not *run-begin-with-load&view-data))
            (save-csq-data-to-file raw-csq-data-path
                                   :dirpath NIL
                                   :use-dated-filename-p use-dated-filename-p  ))
          ;; (save-csq-data-to-file  "Tom-AllData2017-01.lisp")

          (when (or *run-complete-csq-p *run-begin-with-find-csvalranks-p
                    *run-only-find-csvalues-p *run-begin-with-cs-explore-p)
            ;;*run-begin-with-find-last-p)
            (BREAK "END OF PRE MAKE-CSYMS CSQ"))
          ;;older END OF CSQ SO FAR---------------

          ;;END RUN-CSQ ---------------------------------------------------
          )
      
        ;;FOR RUN SHAQ (debug later) -----------------------------------------------------------
        ;; WHEN RUN SHAQ & SHAQ INTROS
        (when (or *run-complete-csq-p *run-shaq-only-p) 
          (when *run-shaq-intros
            ;;run user-type and goals
            (make-question-frame "UTYPE" 'scale-sym 
                                 :quest-frame 'frame-TALL-quest-multi-R-interface)
            ;;hold until poked
            (mp:current-process-pause 3600  'check-for-frame-visible)
            (make-question-frame "UGOALS" 'scale-sym 
                                 :quest-frame 'frame-TALL-quest-multi-R-interface)
            ;;hold until poked
            (mp:current-process-pause 3600  'check-for-frame-visible)
            ;;get utype and ugoals results
            ;;for utype
            (multiple-value-setq (utype-selected-scalescats utype-selected-qvars-in-datalist)
                (get-multi-sel-xdata-key-values 'UTYPE  :scales))
            ;;for ugoals
            (multiple-value-setq (ugoals-selected-scalescats ugoals-selected-qvars-in-datalist)
                (get-multi-sel-xdata-key-values 'UGOALS  :scales))
            ;;combine utype and ugoals selections in intro-selected-scalecats, remove duplicates
            ;;note--still has (:scales as key)
            (setf intro-selected-scalecats (remove-duplicates
                                            (append utype-selected-scalescats ugoals-selected-scalescats)
                                            :test 'my-equal :from-end t))
            ;;(afout 'out (format nil "1.intro-selected-scalecats= ~A~%" intro-selected-scalecats))
            ;;intro-selected-scalecats is input arg= (:scales ... cats and scale qvars listed)

            ;;2.1: QUESTIONNAIRE & SCALE SELECTION
            (cond
             ;;IF USER WANTS TO CHOOSE SPECIFIC QUESTIONNAIRES/SCALES  
             ((member 'specific-quests  intro-selected-scalecats :test 'my-equal)
              ;;then make  the select-scales frame
              (make-question-frame 'SCALESSEL NIL  :quest-num 1
                                   :quest-frame 'frame-xtall-multi-answer-button-interface )
              ;;hold until poked
              (mp:current-process-pause 3600  'check-for-frame-visible)
              ;;get the xdata for SCALESSEL
              (multiple-value-setq (user-selected-scalecats user-selected-qvars-in-datalist)
                  (get-multi-sel-xdata-key-values 'SCALESSEL  :scales))
              ;;make selected-scalecats from UTYPE, UGOALS, and SCALESEL frames
              (setf selected-scalecats
                    (remove-duplicates (append intro-selected-scalecats 
                                               user-selected-scalecats) :test 'my-equal :from-end t))
              ;;end member clause
              )
             ;;OTHERWISE USE INTRO-SELECTED-SCALECATS [all?]
             (t (setf selected-scalecats  intro-selected-scalecats)))
            ;;(afout 'out (format nil "2.selected-scalecats= ~a~%" selected-scalecats))
            ;;end if *run-shaq-intros-p
            )
          ;;SHAQ 2.1. FIND USERID, UNLESS USERID = "NO-BIO",
          ;;    LATER, ADD OUTCOME SCALES UNLESS "NO-BIO"
          (multiple-value-setq (in userid)
              ;;  (get-selected-values
              (get-qvarlist-in-CSQdatalist  "userid"))

          ;;SHAQ 2.2 NORMALLY, RUN THE BIO  QUESTIONS NEXT (put OUTCOME at end)
          ;;Don't run BIO, add to list to run later -- may confuse 
          (cond
           ((or (string-equal userid "NO-BIO") test-scale-list  run-qvarlist)
            (setf all-scalecats  selected-scalecats))
           ;;KKK NO BIO3EDUC BIO4JOB BI07LANG BIO1ETHN BIORELAF FRAME-FAMILY-INFO (run-frame-family-info)
           (T (setf all-scalecats (append '("BIO-MAQ" "ACAD-ACH") selected-scalecats '( "no-scale"  OUTCOME "sUserFeedback")))))
     
          ;;no add to list (make-scales-frames '(BIO) :scale-cat-list scale-cat-list)

          ;;if using a test-scale-list
          ;;(afout 'out (format nil "In SHAQ-MANAGER, test-scale-list= ~A~%" test-scale-list))
          (if test-scale-list  (setf  all-scalecats  test-scale-list)) 
          ;;remove :scales from all-scalecats
          (setf all-scalecats (remove :scales all-scalecats :test 'equal))
          ;;(afout 'out (format nil "In CSQ-Manager, all-scalecats ~A~%scale-cat-list= ~A~%" all-scalecats scale-cat-list))

          ;;SHAQ 2.3  USE FUNCTION THAT DOES ALL THE WORK FOR REST OF SELECTIONS
          #| ?? WHAT IS THIS??   (multiple-value-setq (all-selected-scales  all-selected-questions selected-cats all-scalecats selected-scales all-scale-inst-strings all-scale-inst-objects)|#

          #|   Put in all-scalecats-list order above  ;;2.4 RUN OUTCOME LAST 
     (unless (or (string-equal userid "NO-BIO") test-scale-list run-qvarlist)
      (make-scales-frames '(OUTCOME) :scale-cat-list scale-cat-list))|#

          ;;SHAQ 2.5 RUN USER-FEEDBACK FRAME
          ;;DO THIS LAST to replace all other questions in selected-question-list
          ;;if run-qvarlist, then RUN ONLY THE QUESTS ON run-qvarlist
          ;;BBB MMM  In CSQ-manager, call to make-scale-frames
          ;;(afout 'out (format nil "BB: IF run-qvarlist= ~A~%" run-qvarlist))
          (if run-qvarlist 
              (make-scale-frames  nil :run-qvarlist run-qvarlist)) ;; :scale-cat-list scale-cat-list
          ;;SHAQ 3:. MAKE AND RUN SHAQ? QUESTION FRAMES 
          ;;                  
          ;;(afout 'out (format nil "test-scale-list= ~A~%scale-cat-list= ~A~%" test-scale-list scale-cat-list))
          (unless test-scale-list
            ;;NO included in regular bio-maq (run-frame-family-info) 
     ; ;;hold running next frames until poked by callback in family frame
            ;; (mp:current-process-pause 3600  'check-for-frame-visible)
            ;;kkk
            (make-scales-frames  all-scalecats  :scale-cat-list scale-cat-list))
          (sleep 3)

          ;;SHAQ 4:  CALC SCALE & SUBSCALE SCORES and ADD TO *CSQ-DATA-LIST
          (setf all-scale-data-list    (calc-scale&subscale-scores) 
                *CSQ-scaledata-list (append *CSQ-scaledata-list all-scale-data-list))
          ;; (setf   *CSQ-scaledata-list (append *CSQ-scaledata-list (calc-scale&subscale-scores)))
          ;; (setf *testcss (calc-scale&subscale-scores))
          (sleep 3)
 
          ;;SHAQ 5: MAKE THE QUESTION TEXT and SCALE TEXT

          ;;5.1 SET THE QVAR CONVERTED SYMS (add a T to end) 
          ;;      TO EACH QUEST TEXT and 
          ;;   make a list of them all (later eval the syms to get the quest-text)
          ;;(when *run-shaq-p
          (setf all-text-questsyms-list  (make-all-questions-text))

          ;;5.2 MAKE SCALE + QUEST TEXT
          ;;   Make the text for the two windows 1-SCALES ONLY and 
          ;;    2-ALL RESULTS=SCALES, SUBSCALES/QUESTS
          ;; (when *run-shaq-p
          (multiple-value-setq (scales-subscales-results-text scales-ss-quests-results-text)
              (process-scales-results))

          ;;SHAQ 6: CREATE THE WHOLE TEXT AND 3  RESULTS WINDOWS
          ;; 1-SCALES ONLY, 2-ALL RESULTS, 3-HELPLINKS 
          ;; (Do this before send-CSQ-dat to prevent connection error from preventing printout
          ;; (when *run-shaq-p
          (make-CSQ-results-text)
          ;; USE RAW-SHAQ-DATA-PATH  & RAW-SHAQ-RESULTS-TEXT-PATH

          ;;END *RUN-SHAQ-P
          )
        
        ;;STEP 3: MAKE CSYMS (from EITHER scale-cats or csym-sys-db) =====
        ;;STEP 3.1 : MAKE-SCALE&QVAR-CSYMS-FROM-SCALE-CATS-P
        ;;CONFLICTS WITH make-all-csyms-from-cs-csym-db-p below
        ;; CSQ/SHAQ CSYMS (omits PCSYMs done above) =====
        ;; DEPRECIATED--USE MAKE-CSYMS-TREE INSTEAD
        #|(when make-scale&qvar-csyms-from-scale-cats-p 
          (multiple-value-bind (all-new-csyms  all-new-scale-csyms
                                               all-qvar-csyms all-csartloc-syms new-elmsyms new-pcsyms)
              (make-csq-csyms :load-user-data-p NIL ;;loaded elsewhere 
                              :set-final-global-vars-p set-final-global-vars-p 
                              :set-global-vars-p set-global-vars-p
                              :set-all-global-vars-p set-all-global-vars-p
                              :omit-scales-p omit-scales-p :omit-qvars-p omit-qvars-p
                              :omit-special-vars-p omit-custom-vars-p
                              :main-scale-classes main-scale-classes
                              :misc-bio/lrn/qvar-lists misc-bio/lrn/qvar-lists
                              :special-classes-arglists special-classes-arglists
                              :custom-csym-arglists custom-csym-arglists 
                              :csq-csyms-data-path NIL
                              ;;FOR CSARTLOCS
                              :csartloc-origin :supsys-csartloc :make-new-csartloc-p T
                              :update-supsys-sublist-p T
                              :topdim NIL :dims NIL  :last-dim :csym :supsys nil
                              :topdimslist NIL  :def-topdimsym def-topdimsym
                              :def-supsys def-supsys
                              :supsys-csartloc NIL :new-csartloc NIL :new-csartloc-vals NIL
                              :parents NIL
                              ;;old (make-new-csartloc-p t)
                              ;;old (roots-at-clevs '(0))    
                              :artsym-n 2 :if-exists-replace-p t :csartloc-n3-item NIL
                              :csartloc-rest-vals NIL  :set-as-csartdims-p T
                              :return-csartdims-p T
                              :append-all-csartloc-syms&vals-p T)
            ;;done by store below  dated-user-data-path) 
            ;;SET SUBTYPE GLOBAL VARS
            (when set-new-csym-global-vars-p
              (setf *all-new-csyms all-new-csyms
                    *all-new-scale-csyms all-new-scale-csyms
                    *all-new-qvar-csyms all-qvar-csyms
                    *all-new-csartloc-syms all-csartloc-syms
                    *new-elmsyms new-elmsyms
                    *new-pcsyms new-pcsyms))
            (sleep 2)
            ;;(break "USER DATA LOADED & CSYMS MADE?")
            ;;end mvb, when
            ))|#
            ;;END MAKE-SCALE&QVAR-CSYMS-FROM-SCALE-CATS-P

        ;;STEP 3: MAKE-ALL-CSYMS-FROM-CS-CSYM-DB-P
        (when make-all-csyms-from-cs-csym-db-p
           (multiple-value-bind (tree-list1 all-csyms1 all-csartloc-syms1)
              (MAKE-CSYM-TREE 
               :ALL-CATS-LIST  all-cs-db-cats-list 
               :save-csyms&vals-to-file (when 
                                            (equal store-all-syms&symvals :IN-MAKE-TREE)
                                          user-csym-storage-file)
               :if-csym-exists if-csym-exists  :tree-leveln 1
               :csartloc-origin csartloc-origin :supsys-csartloc supsys-csartloc
               :topdim topdim :dims dims :last-dim last-dim
               :supsys supsys :topdimslist topdimslist
               :def-supsys def-supsys
               :new-csartloc nil
               :new-csartloc-vals new-csartloc-vals
               :if-exists-replace-p if-exists-replace-p
               :artsym-n artsym-n :csartloc-n3-item csartloc-n3-item
               :csartloc-rest-vals csartloc-rest-vals
               :set-as-csartdims-p  set-as-csartdims-p 
               :sublist-key sublist-key :supsys-key supsys-key
               :clevkey clevkey
               :qtype-key qtype-key 
               :catkey catkey :valkey valkey
               :csvalkey csvalkey :csrankey csrankey
               :infokey infokey :pckey pckey
               :bipathkey bipathkey :bestpolekey bestpolekey :tokey tokey
               :fromkey fromkey :wtokey wtokey :wfromkey wfromkey
               :pclistkey pclistkey :systemkey systemkey 
               :restkeys restkeys 
               :sys-csyms-varname sys-csyms-varname
               )
            ;;ACCUMULATE (tree-list1 all-csyms1 all-csartloc-syms1)
            (setf  *ALL-CSYMS (append *ALL-CSYMS all-csyms1)
                   *ALL-CSARTLOC-SYMS 
                   (append *ALL-CSARTLOC-SYMS all-csartloc-syms1))

            ;;SSSSSS FIX THESE ACCUM VARS??
            ;;SET SUBTYPE GLOBAL VARS
            #|(when set-new-csym-global-vars-p
              (setf *all-new-csyms all-new-csyms
                    *all-new-scale-csyms all-new-scale-csyms
                    *all-new-qvar-csyms all-qvar-csyms
                    *all-new-csartloc-syms all-csartloc-syms
                    *new-elmsyms new-elmsyms
                    *new-pcsyms new-pcsyms))|#
            (sleep 5)
            ;;end mvb, when
            ))
         ;;END  MAKE-ALL-CSYMS-FROM-CS-CSYM-DB-P
        ;;end local let,  unless *begin-csq-manager-store-data-p
        ))

    ;;STEP 5:  STORE ALL USER DATA (CSYMS) FROM ALL SOURCES 
    ;;      in DATED-USER-DATA-PATH
    ;; EG: "C:/3-TS/LISP PROJECTS TS/CogSysOutputs/ALL-CSQ-USER-DATA 2020-05-26.lisp"
    ;;
    ;;MOVE STORE CSQ & SHAQ RESULTS TO HERE??
    ;;NOTE: CSYMS ARE ALSO STORED BY MAKE-CSYM
    ;;*ALL-CSYMS = '($CS $EXC $TBV $WV $SLF $REFG 
    ;; *ALL-NON-SYS-CSYMS = ($CS $EXC $TBV $WV $SLF 
    ;; *ALL-SPECIAL-CSYMS = (<USERID <SEX <AGE <NATION <ZIPCODE <HRSWORK)
    ;; missing many *ALL-QVAR-CSYMS = (("ACAD-ACH" (<BIO3EDUC <BIOHSGPA <BIOCOLLE)) ("NO-SCALE" (<BIO5INCO)) <BIO <ACAD-ACH <BIO3EDUC

    (when store-all-syms&symvals ;; if :in-make-tree stores above
      (multiple-value-bind  (listsyms all-syms all-syms&vals all-listsym-nth-syms
                                      all-listsym-nth-syms&vals pathname)
          (store-cs-syms&symvals user-csym-storage-file       
                                          :pprint-p  pprint-user-output-p
                                          :dir  user-data-dir 
                                          :use-dated-path-p use-dated-filename-p
                                          :incl-time-p use-time-wdate-p
                                          :pre-listsyms-sym-str pre-listname-str
                                          :append-filename-begin append-filename-begin 
                                          :append-filename-end append-filename-end   
                                          :eval-syms-p eval-syms-p
                                          :accumulate-all-syms&vals-p
                                          accumulate-all-syms&vals-p
                                          :accumulate-all-lists-p NIL ;;mem crash accumulate-all-lists-p 
                                          :listsyms-sym listsyms-sym
                                          :listsyms store-data-listsyms  ;;HERENOW
                                          :if-file-exists if-output-file-exists
                                          :eval-nth-in-symlist eval-nth-in-symlist 
                                          :file-head-message file-head-message)

        ;;SET *ALL-CSYMS&VALS (not done elsewhere)
        (when all-syms&vals
          (setf *ALL-CSYMS&VALS all-syms&vals))
        ;;end mvb,when store-all-syms&symvals-p
        ))

    (break "END (unless *begin-csq-manager-view-data-p)")
    ;;END (unless *begin-csq-manager-view-data-p
    )

  ;;  3. SSSSSS TREE VIEWER STARTS WITH $CS = (  <A SYM) , MUST HAVE BEEN RESET OR TREE-VIEWER FIRES BEFOTE IT SHOULD??

  ;;  3. SSSSSS TREE VIEWER STARTS WITH $CS = (  <A SYM) , MUST HAVE BEEN RESET OR TREE-VIEWER FIRES BEFOTE IT SHOULD??
  ;; 
  ;;JUST RUN (GOCSQ T T) and debug at this point. 
  ;; Check: is all data loading and saving right? Are SHAQ & CSQ values incl?
  ;; Can select dif parts of CSQ/SHAQ and dif data sources?
  ;; MAKE/USE CSQ-TREEVIEWER TO VIEW ALL CSYMS

  ;;STEP  5: DISPLAY RESULTS IN VIEWERS--CHOICE OF VIEWERS??
  ;;In case datafile loads slowly
  (when (not (boundp '$CS)) (sleep 10))
   ;;(BREAK "before make-csym-treeviewer-p")
  (cond
   ((and make-csym-treeviewer-p (boundp '$CS))
    (make-csym-treeviewer top-csym-list :frame-title *csym-treeviewer-frame-title
                          :check-boxes-p check-boxes-p 
                          :make-treeviewer-options-interface make-treeviewer-options-interface
                          :group-by-val-p group-by-val-p :order-by-rank-p order-by-rank-p
                          :last-list=value-p last-list=value-p
                          :valkey valkey :sublistkey sublistkey
                          :min-treeview-pane-height min-treeview-pane-height
                          :min-treeview-pane-width min-treeview-pane-width
                          :x x  :y y   :frame-init-args frame-init-args
                          :expand-tree-p expand-tree-p  :initial-y initial-y)
    ;; make-csym-treeviewer
    )
   (T (break "$SC IS UNBOUND: DON'T START TREEVIEWER--STOP PROCESSING")))

  ;;STEP 6: STORE DATA/SEND DATA TO SERVER
  ;;  DISPLAY and/or  PRINT THE RESULTS
  (cond
   ((or (null not-send-CSQdat-p) (not (boundp '$CS)))
        (break "$CS IS UNBOUND: DON'T STORE DATA--STOP PROCESSING"))
   (T NIL)) ;;DO LATER??  (send-CSQ-dat)))

  ;;*ALL-STORED-CSYMS made from make-csym/store-csym
#|  (when (and (null *ALL-CSYMS) *ALL-STORED-CSYMS)
    (setf  *ALL-CSYMS *ALL-STORED-CSYMS))|#
  ;;*ALL-CSYMS&VALS SET ABOVE TOO

  #| SSSSS FIX LATER -- NEED CURRENT PATH
  (when popup-store-file-objects-p
    (list-file-objects DATED-CSQ-CSYMS-DATA-PATH :all :pathroot nil))|#
  ;; (list-file-objects "C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\1-TOM-evaled-CSYMS-VALS2020-6-12-16h17.lisp" :all :pathroot nil)

  (values *ALL-CSYMS  "==> CSQ/SHAQ COMPLETED: CSYMS ABOVE" )
  ;;all-new-scale-csyms all-qvar-csyms new-elmsyms new-pcsyms all-csartloc-syms)
  ;;end let, CSQ--manager
  ))
;;TEST
;; SSSSSS PROBLEMS: Elms & PCs under $MIS
;; 


;; (store-vars-to-file '( ) :path 


;; DELETE, NOT NEEDED -----------------------------------------------------------
;; USE ;; (manage-value-rank-frames `((:items-ratings-lists ,(list *pc-items-ratings-lists))))
#|;;CSQ-RANK-WITHIN-CSVAL-RATINGS
;;2018
;;ddd
(defun csq-rank-within-csval-ratings (all-items-ratings-lists) ;; *pc-items-ratings-lists
  (let*
          ((ordered-items-ratings-lists (sort-1nested-lists 1 all-items-ratings-lists))
           (grouped-items-ratings-lists (group-lists-by-nths  1 ordered-items-ratings-lists))
           (all-csval-ranks)
           ) 
    ;;test (progn (setf xx1  (sort-lists-by-funcall #'NTH '(1) 1 '(("love" 0.8)("money" 0.6)("friends" 0.5)("exercise" 0.7)("cleanliness" 0.3)("health" 0.8)("success" 0.8)("happiness" 0.8)("good job" 0.7))))  
;;works= (("love" 0.8) ("health" 0.8) ("success" 0.8) ("happiness" 0.8) ("exercise" 0.7) ("good job" 0.7) ("money" 0.6) ("friends" 0.5) ("cleanliness" 0.3)) NIL
;; (group-lists-by-nths  1 xx1)) = ((("happiness" 0.8) ("success" 0.8) ("health" 0.8) ("love" 0.8)) (("good job" 0.7) ("exercise" 0.7)) (("money" 0.6)) (("friends" 0.5)) (("cleanliness" 0.3)))  ;;;sort-1nested-lists
        ;;SSSSS START HERE 
        ;;(break "grouped-items-ratings-lists")
        (loop
         for items-rating-list in grouped-items-ratings-lists
         do    
         (manage-value-rank-frames items-rating-list)
         (let
             ((csval-ranks *temp-ordered-values-ratings-strs)
              ;;eg (("kind" "2")("male" "4")..
              )
           (setf all-csval-ranks (append all-csval-ranks csval-ranks))
           ;;end let
           )
         ;;MODIFY DATA-LIST
         (loop
          for pclist in all-csval-ranks
          do
          (let
              ((pc-name (my-make-symbol (car pclist)))
               (rank (second pclist))
               (newkeylist)
               (new-datalist)
               )
            (break "before get-set")
            (multiple-value-setq (newkeylist new-datalist)
                (get-set-append-delete-keyvalue-in-nested-list rank 
                                                               (list (list pc-name T)(list *csrank-key 99))
                                                               *csq-data-list
                                                               :add-value-p T :append-value-p nil
                                                               :key-in-prev-keylist-p T))
            (setf *csq-data-list new-datalist)
            ;;end let, inner loop
            ))
         (setf *all-grouped-csval-ranks all-csval-ranks)
         ;;end outer loop, let
         ))
  ;;end csq-rank-within-csval-ratings 
  )
;;TEST
;; (csq-rank-within-csval-ratings *pc-items-ratings-lists)

;;  ((("love" 0.8)("money" 0.6)("friends" 0.5)("exercise" 0.7)("cleanliness" 0.3))(("health" 0.8)("success" 0.8)("happiness" 0.8)("good job" 0.7))) :group-by-rating-across-groups)))|#

;; (make- '( :items-ratings-lists *pc-items-ratings-lists)
;; -------------------------------- END DELETE -----------------------------------------------


 
;;------------------------------END FOR CSQ ONLY -----------------------------------------

;;xxx
;;------------------------------- FOR SHAQ ONLY --------------------------------------
;;
;;SHAQ--MANAGER 
;;  Main process to manage SHAQ 
;;
;;ddd
(defun SHAQ-manager (question-sym-list run-qvarlist test-scale-list run-shaq-intros-p 
                                  append-to-scale-cat-list 
                                  &key not-send-shaqdat-p)
  "In U-SHAQ-management, Called by shaq main process.  Code for management of entire SHAQ process. append-to-scale-cat-list adds superclass scale categories get scale-lists from."
  (let 
      ((userid)
       (user-shaqdata-list)
       (scale-cat-list (find-all-direct-subclass-names '(per-system))) ;;= ("OUTCOME" "CAREER-INTEREST" "ACAD-LEARNING" "INTERPERSONAL" "SKILLS-CONFIDENCE" "BELIEFS" "VALUES-THEMES" "BIO") 
       (selected-category-list)
       (selected-question-list)
       (selected-q-list-length)
       (q-frame-instance)
       (previous-q-name)
       ;;SSS CAN MANUALLY SET THESE FOR TESTING
       (run-TEST-quests-p)
       (utype-selected-scalescats)
       (utype-selected-qvars-in-datalist)
       (ugoals-selected-scalescats)
       (ugoals-selected-qvars-in-datalist)
       (intro-selected-scalecats)
       (all-selected-scales)
       (selected-cats)
       (selected-scalecats)
       (all-scalecats)
       (all-selected-questions)
       (selected-scales)
       (all-scale-inst-strings)
       (all-scale-inst-objects)
       ;;actual selections by user
       (user-selected-scalecats)
       (user-selected-qvars-in-datalist)
       (shaq-select-scales-instance)
       (all-scale-data-list)
       ;;shaq
       (scales-subscales-results-text)
       (scales-ss-quests-results-text)
       ;;text
       (all-text-questsyms-list)
       ;;end let list
       )
    ;;must add HQ to scale-cat-list, or won't process it right 
    ;;     (this is redundant to setting in Shaq-process-manager)
    (IF (null append-to-scale-cat-list) (setf append-to-scale-cat-list '(HQ)))
    (setf scale-cat-list (append  append-to-scale-cat-list scale-cat-list))
    ;;(setf tt1 (append '(a b c) '(x y))) works

      ; STEP 1: RUN THE INTRO FRAMES and SELECT SCALES/QUESTIONS
    ;;MUST RUN before assemble rest of data to select questions
    ;; normally used by ALL incl picking specific scales
    ;; don't use for testing only purposes
    (cond
     ((and *run-shaq-intros-p (null test-scale-list)(null run-qvarlist))
      (create-shaq-intro-frames)
      ;;RUN USER-TYPE AND GOALS
      (make-question-frame "UTYPE" 'scale-sym 
                           :quest-frame 'frame-TALL-quest-multi-R-interface)
      ;;hold until poked
      (mp:current-process-pause 3600  'check-for-frame-visible)

      (make-question-frame "UGOALS" 'scale-sym 
                           :quest-frame 'frame-TALL-quest-multi-R-interface)
      ;;hold until poked
      (mp:current-process-pause 3600  'check-for-frame-visible)

      ;;GET UTYPE AND UGOALS RESULTS
      ;;FOR UTYPE
      (multiple-value-setq (utype-selected-scalescats utype-selected-qvars-in-datalist)
          (get-multi-sel-xdata-key-values 'UTYPE  :scales))

      ;;FOR UGOALS
      (multiple-value-setq (ugoals-selected-scalescats ugoals-selected-qvars-in-datalist)
          (get-multi-sel-xdata-key-values 'UGOALS  :scales))

      ;;combine utype and ugoals selections in intro-selected-scalecats, remove duplicates
      ;;note--still has (:scales as key)
      (setf intro-selected-scalecats (remove-duplicates
                                      (append utype-selected-scalescats ugoals-selected-scalescats)
                                      :test 'my-equal :from-end t))

      ;;(afout 'out (format nil "1.intro-selected-scalecats= ~A~%" intro-selected-scalecats))
      )
     (t nil))
    ;;intro-selected-scalecats is input arg= (:scales ... cats and scale qvars listed)
    (cond
     ;;IF USER WANTS TO CHOOSE SPECIFIC QUESTIONNAIRES/SCALES, 
     ((member 'specific-quests  intro-selected-scalecats :test 'my-equal)
      ;;then make  the select-scales frame
      (make-question-frame 'SCALESSEL NIL  :quest-num 1
                           :quest-frame 'frame-xtall-multi-answer-button-interface )
      ;;hold until poked
      (mp:current-process-pause 3600  'check-for-frame-visible)
      ;;get the xdata for SCALESSEL
      (multiple-value-setq (user-selected-scalecats user-selected-qvars-in-datalist)
          (get-multi-sel-xdata-key-values 'SCALESSEL  :scales))
      ;;make selected-scalecats from UTYPE, UGOALS, and SCALESEL frames
      (setf selected-scalecats
            (remove-duplicates (append intro-selected-scalecats 
                                       user-selected-scalecats) :test 'my-equal :from-end t))
      ;;end member clause
      )
     (t (setf selected-scalecats  intro-selected-scalecats)))
   ;;(afout 'out (format nil "2.selected-scalecats= ~A~%" selected-scalecats))

    ;; SSS DO I WANT TO BE ABLE TO BYPASS INTRO AND/OR CHOOSE EVEN MORE SPECIFIC SCALES OR SUBSCALES--NO DO IN MENUS UNDER SETTINGS??
    
    ;;STEP 2: RUN SCALES,QUESTIONS and and GATHER DATA into *CSQ-DATA-LIST
    ;;
    ;;2.1. FIND USERID, UNLESS USERID = "NO-BIO",
    ;;    LATER, ADD OUTCOME SCALES UNLESS "NO-BIO"
    (multiple-value-setq (user-shaqdata-list userid)
        ;;  (get-selected-values
        (get-qvarlist-in-shaqdatalist  "userid"))

    ;;2.2 NORMALLY, RUN THE BIO  QUESTIONS NEXT (put OUTCOME at end)
    ;;Don't run BIO, add to list to run later -- may confuse 
    (cond
     ((or (string-equal userid "NO-BIO") test-scale-list  run-qvarlist)
      (setf all-scalecats  selected-scalecats))
 ;;KKK NO BIO3EDUC BIO4JOB BI07LANG BIO1ETHN BIORELAF FRAME-FAMILY-INFO (run-frame-family-info)
     (T (setf all-scalecats (append '("BIO-MAQ" "ACAD-ACH") selected-scalecats '( "no-scale"  OUTCOME "sUserFeedback")))))
     
    ;;no add to list (make-scales-frames '(BIO) :scale-cat-list scale-cat-list)

    ;;if using a test-scale-list
    ;;(afout 'out (format nil "In SHAQ-MANAGER, test-scale-list= ~A~%" test-scale-list))
    (if test-scale-list  (setf  all-scalecats  test-scale-list)) 
    ;;remove :scales from all-scalecats
    (setf all-scalecats (remove :scales all-scalecats :test 'equal))
    ;;(afout 'out (format nil "In SHAQ-Manager, all-scalecats ~A~%scale-cat-list= ~A~%" all-scalecats scale-cat-list))


    ;;2.3  USE FUNCTION THAT DOES ALL THE WORK FOR REST OF SELECTIONS
    #| ?? WHAT IS THIS??   (multiple-value-setq (all-selected-scales  all-selected-questions selected-cats all-scalecats selected-scales all-scale-inst-strings all-scale-inst-objects)|#

    ;;MMM MAKE ALL THE SCALES QUESTION FRAMES HERE
   ;;no, done later  (make-scales-frames  all-scalecats  :scale-cat-list scale-cat-list)

    #|   Put in all-scalecats-list order above  ;;2.4 RUN OUTCOME LAST 
     (unless (or (string-equal userid "NO-BIO") test-scale-list run-qvarlist)
      (make-scales-frames '(OUTCOME) :scale-cat-list scale-cat-list))|#

    ;;2.5 RUN USER-FEEDBACK FRAME

    ;;DO THIS LAST to replace all other questions in selected-question-list
    ;;if run-qvarlist, then RUN ONLY THE QUESTS ON run-qvarlist
    ;;BBB MMM  In SHAQ-manager, call to make-scale-frames
   ;;(afout 'out (format nil "BB: IF run-qvarlist= ~A~%" run-qvarlist))
    (if run-qvarlist 
        (make-scale-frames  nil :run-qvarlist run-qvarlist)) ;; :scale-cat-list scale-cat-list

    ;;STEP 2b:. MAKE AND RUN QUESTION FRAMES 
    ;;                  
    ;;(afout 'out (format nil "test-scale-list= ~A~%scale-cat-list= ~A~%" test-scale-list scale-cat-list))
    (unless test-scale-list
     ;;NO included in regular bio-maq (run-frame-family-info) 
     ; ;;hold running next frames until poked by callback in family frame
     ;; (mp:current-process-pause 3600  'check-for-frame-visible)
      ;;kkk
      (make-scales-frames  all-scalecats  :scale-cat-list scale-cat-list))

    (sleep 5)

    ;;STEP 3:  CALC SCALE & SUBSCALE SCORES and ADD TO *CSQ-DATA-LIST
  (setf all-scale-data-list    (calc-scale&subscale-scores) 
        *shaq-scaledata-list (append *shaq-scaledata-list all-scale-data-list))
 ;; (setf   *shaq-scaledata-list (append *shaq-scaledata-list (calc-scale&subscale-scores)))
 ;; (setf *testcss (calc-scale&subscale-scores))

 (sleep 5)
 
 ;;STEP 4: MAKE THE QUESTION TEXT and SCALE TEXT

    ;;4.1 SET THE QVAR CONVERTED SYMS (add a T to end) 
    ;;      TO EACH QUEST TEXT and 
    ;;   make a list of them all (later eval the syms to get the quest-text)
    (setf all-text-questsyms-list  (make-all-questions-text)) 

    ;;4.2 MAKE SCALE + QUEST TEXT
    ;;   Make the text for the two windows 1-SCALES ONLY and 
    ;;    2-ALL RESULTS=SCALES, SUBSCALES/QUESTS
    (multiple-value-setq (scales-subscales-results-text scales-ss-quests-results-text)
        (process-scales-results))


    ;;STEP 5: CREATE THE WHOLE TEXT AND 3  RESULTS WINOWS
    ;; 1-SCALES ONLY, 2-ALL RESULTS, 3-HELPLINKS 
    ;; (Do this before send-shaq-dat to prevent connection error from preventing printout
    (make-shaq-results-text)

    ;;STEP 6: SEND DATA TO SERVER and  PRINT THE RESULTS
    (unless not-send-shaqdat-p
      (send-shaq-dat))
 
    ;;end let, SHAQ--manager
    ))


(defun check-for-frame-visible ()
  "In U-SHAQ-management.lisp, used by mp:current-process-pause to keep it open for input from a poke. Just an EMPTY function for now."
  ;;FINISH LATER, NOW JUST RETURN T OR NIL?
  NIL)


;;; The debugger hook, which is set into *DEBUGGER-HOOK* in the
;;; main function above.  See the comment at the top of the file.

(defun my-debugger-hook (condition old-debugger-hook)
  "In U-shaq-management, (copied basic from LW-examples\deliver\..."
  (declare (ignore old-debugger-hook))
  (let ((path 
         (dbg:log-bug-form (format nil "Error log of ~a " condition)
                           :message-stream *open-dos-debug-window)))  ;was nil
    (capi:display-message 
     "
    Log of  Shaqer that occured  ~a ~%    written to: ~a   

     PLEASE WAIT:  SHAQ IS BUSY COMPUTING!

     ==> DO NOT CLOSE ANY SHAQ WINDOWS!!

   (If you wait more than 1-4 minutes, something may be wrong!)

"   path condition)
    )
  (abort))







;;MAKE-QUESTION-SELECTION-LIST 
;;OUTDATED??
;;ddd
#|(defun make-question-selection-list (matching-scales-lists &key (csq-data-list *CSQ-DATA-LIST))
  "In Frames-shaq-intros.  1. Takes the (SCALESSEL :MULTI \"scalessel\" \"scales-selected\" ...) list created by select-shaq-scales and user-chosen in frame to create a single list of  selected scales to be run by function (process-selected-question-list (selected-question-list). matching-scales-lists should be a list of lists with first item matching the multi-sel answer in SCALESSEL, and the second item either a scale-name or a scale category name eg. OUTCOME.  RETURNS list of scale-names and category names. to pass to a function to process category names and/or scale-names and run the questions. (Put in separate function to allow intermediate operations)."
 (let
     ;;should SCALESSEL be a string--NO.
     ((select-shaq-scales-results (get-qvarlist-in-shaqdatalist 'SCALESSEL))
      )
    (multiple-value-setq (selected-scale-ans-lists  matched-scale-names)
        (process-multi-selection-results 'SCALESSEL  matching-scale-lists))

 ;;end let, make-question-selection-list
 ))|#
;;TEST
;;  (select-SHAQ-scales)
;; (defun goq4 ()  (progn (setf out nil) (setf *qfr4-inst (select-shaq-scales))))
;;  (goq4)
;; 2014-07
#|(
(nthcdr 5  '(SCALESSEL :MULTI "scalessel" "scales-selected" NIL ("HQ1.HAPPINESS QUOTIENT Scales (Required for HQ)" "1" HQ-SCALES NIL 0 NIL) ("HQ2.HQ Scales + ACADEMIC SUCCESS Scales" "2" HQ-ACAD NIL 0 NIL) ("HQ3.HQ + Academic Success + ACADEMIC MAJOR CHOICE" "3" HQ-ACAD-CAR NIL 0 NIL) ("1.Life Themes and Values Scales" "4" THEMES NIL 0 NIL) ("2.World View Beliefs Scale" "5" WORLDVIEW NIL 0 NIL) ("3.Self and Life Beliefs Scales" "6" TBV-TB2 NIL 0 NIL) ("4.Internal vs. External Control of Your Life (IE) Scale" "7" IE NIL 0 NIL) ("5.Self-Confidence and Skills Scale" "8" SELF-CONF NIL 0 NIL) ("6.Self-Management Skills/Habits Scale" "9" SM T 1 NIL) ("7.Emotional Coping Skills/Habits Scale" "10" COPE NIL 0 NIL) ("R1.INTERPERSONAL: Intimacy/Assertion/Problem-Solving" "11" ASSERTCR NIL 0 NIL) ("L1.LEARNING and ACADEMIC SUCCESS" "12" INTIMACY NIL 0 NIL) ("C1.CAREER or ACADEMIC MAJOR INTEREST" "13" INDEP-INT T 1 NIL) ("O1.Overall Happiness Scale" "14" LIBROLE NIL 0 NIL) ("O2.Depression Scale" "15" STU-LRN NIL 0 NIL) ("O3.Anxiety Scale" "16" STUACMOTIV NIL 0 NIL) ("O4.Anger and Aggression Scale" "17" CARGEN NIL 0 NIL)))|#



;;PROCESS-MULTI-SELECTION-RESULTS
;;
;;ddd
(defun process-multi-selection-results (qvar &optional matching-items-list)
  "In U-SHAQ-management--move??  1. Finds the results list for qvar in *CSQ-DATA-LIST, 2. RETURNS (values selected-lists-with-cdr-match-list matched-items-list) (selected from matched items in matching-items-list--if supplied-otherwise, matched-items-list = nil.= matching-items-list eg= '((\"answer 1\" \"scale-name1\")...)."
  (let*
      ((qvarlist (get-qvarlist-in-shaqdatalist qvar))
       (answer-lists (nthcdr 5 qvarlist))
       (selected-lists-with-cdr-match-list)
       (matched-items-list)
       )
    ;;(afout 'out (format nil "answer-lists= ~A~%" answer-lists))
;;eg ("6.Self-Management Skills/Habits Scale" "9" SM T 1 NIL)
     ;;EEE
    (loop
     for ans-list in answer-lists
     do 
     (let
         (( ans-str)
          ( data-sym)
          ( selected-p)
          ( data-value)
          ( match-list)
          ( new-ans-list)
          )
     (setf ans-str (first ans-list)
      data-sym (third ans-list)
      selected-p (fourth ans-list)
      data-value (fifth ans-list))
     ;;(afout 'out (format nil "~A ans-str=~A  selected-p= ~A~%"out1 ans-str  selected-p))
     (cond
      (selected-p
       (cond
        (matching-items-list
         (setf match-list (get-key-value-in-nested-lists `((,ans-str)) matching-items-list
                                                         :return-list-p T)
               matched-items-list (append matched-items-list (list match-list))
               new-ans-list (append ans-list (cdr  match-list))
               selected-lists-with-cdr-match-list (append selected-lists-with-cdr-match-list
                                                      (list new-ans-list)))
              ;;(afout 'out (format nil " match-list= ~A" match-list))
         
         ;;end matching-items-list clause
         )
        (t (setf match-list (get-key-value-in-nested-lists `((,ans-str)) matching-items-list
                                                         :return-list-p T)
                 selected-lists-with-cdr-match-list (append selected-lists-with-cdr-match-list
                                                      (list ans-list)))))
       ;;end selected-p
       )
       (t nil))
     ;;end let,loop
     ))
     ;;return
    (values selected-lists-with-cdr-match-list matched-items-list)
    ;;end let, process-multi-selection-results
    ))
;;TEST (must run (select-shaq-scales) first to generate *CSQ-DATA-LIST
;; (process-multi-selection-results 'SCALESSEL *select-shaq-scales-keylist)
;;WORKS, SAMPLE RESULTS: (values selected-lists-with-cdr-match-list matched-items-list)
#|(("HQ3.HQ + Academic Success + ACADEMIC MAJOR CHOICE" "3" HQ-ACAD-CAR T 1 NIL (HQ CAREER-INTEREST)) ("6.Self-Management Skills/Habits Scale" "9" SM T 1 NIL ("sselfman")) ("O3.Anxiety Scale" "16" STUACMOTIV T 1 NIL ("sranxiet")))
(("HQ3.HQ + Academic Success + ACADEMIC MAJOR CHOICE" (HQ CAREER-INTEREST)) ("6.Self-Management Skills/Habits Scale" ("sselfman")) ("O3.Anxiety Scale" ("sranxiet")))|#

;;NO LONGER USED??
;; TEST TO REPLACE  LOOPs IN MAIN FUNCTIONS ABOVE
;;
;;PROCESS-SELECTED-CATEGORY-LIST
;;
;;ddd
#|(defun process-selected-category-list (selected-category-list)
   "In U-SHAQ-management.lisp,"
   (let
       ((x)
        )
(loop
     for category in selected-category-list
     with qvarlist
     do
     (setf qvarlist (get-category-qvars category)
           selected-question-list qvarlist)
     ;;end loop
     )
  (process-selected-question-list selected-question-list)

  ;;end let, process-selected-category-list
  ))|#
;;TEST
;;  (process-selected-category-list '(UGOALS))


;;MAKE-SCALES-FRAMES
;;
;;ddd
(defun make-scales-frames  (scalecat-list &key scale-cat-list reverse-subclass-order-p
                                    (non-scalecat-syms
                                     '(:scales scales :scale scale   NIL PREVIOUS-USER SPECIFIC-QUESTS))) ;; add :no-scale no-scale??
  "In CSQ-manage, INPUT=list of scales to make question-frames for every question in every scale in the list.  Both Single and Multi-selection questions can be included in the qvar lists in the :scale-questions slot of each scale. reverse-subclass-order-p causes order of cat-scales to be opposite those in class definitions."
;;MMM BBB IN MAKE-SCALES-FRAMES 
     ;;(afout 'out (format nil "In make-scales-frames,   scalecat-list= ~A~%" scalecat-list))
     (let
         ((processed-scales)
          (processed-cats)
          )
     ;;PROCESS THE  ALL-SCALECATS
     (loop
      for scale  in scalecat-list
      do
    ;;not needed?  with scale-name-str
    (let
        (( scale-category)
         ( scale-cat-class)
         ( cat-scale-list)
         ( process-scale-list)
         )
      do      
      ;;  (afout 'out (format nil "In make-scales-frames, scale= ~A~%" scale ))
      ;;not needed  (setf scale-name-str (format nil "~A" scale))
      ;;SSS UNDO AFOUTS
      ;;(afout 'out (format nil "OMIT LIST)= ~a"   (append  non-scalecat-syms  processed-scales processed-cats)))
      (cond
       ;;in case :scales or other non-scale-items included in list or WAS PROCESSED
       ((member scale (append  non-scalecat-syms  processed-scales processed-cats)
                :test 'my-equal)
        ;;(afout 'out (format nil "SCALE= ~a is a member of OMIT LIST)" scale  ))
        NIL)
       ;;IS SCALE A SCALE SUPERCLASS? If so, find subclass regular scales.
       ((member scale scale-cat-list :test 'my-equal) ;;these are strings
        ;;not needed?   (setf scale-cat-class scale cat-scale-list (find-direct-subclass-names scale-cat-class))
        (multiple-value-bind (cat-scale-list cat-scale-classes)
            (find-direct-subclass-names scale :reverse-subclass-order-p 
                                        reverse-subclass-order-p)
          ;;(afout 'out (format nil "In make-scales-frames, subclasses= ~A~%" cat-scale-list))
          (unless (null reverse-subclass-order-p)
            (setf cat-scale-list (reverse cat-scale-list)))
          (loop
           for cat-scale in cat-scale-list
           ;;with sub-cat-scale-list
           do
           (setf outx1 (format nil "In CAT inner loop, cat-scale= ~A~%" cat-scale)) 
           (unless (member cat-scale processed-scales :test 'my-equal)
             (make-scale-frames cat-scale)
             ;;added 01-2015
             (setf processed-scales (append processed-scales (list cat-scale)))
             ;;end unless, inner loop
             ))
          ;;added 01-2015
          (setf processed-cats (append processed-cats (list scale)))
          ;;end mvb, member clause
          ))
       (t
        ;;if an ordinary scale, make-scale-frames  
        (unless (member scale processed-scales :test 'my-equal)
          (make-scale-frames scale)
          (setf processed-scales (append processed-scales (list scale)))
          )))
      ;;end outer let, loop
      ))
   ;;end let,  make-scales-frames     
    ))
;; (make-scales-frames '(SBIOG) :scale-cat-list   '("OUTCOME" "CAREER-INTEREST" "ACAD-LEARNING" "INTERPERSONAL" "SKILLS-CONFIDENCE" "BELIEFS" "VALUES-THEMES" "BIO"))
;;  ;; (find-all-direct-subclass-names '(HQ)) WORKS






;;MAKE-SCALE-FRAMES
;;
;;ddd
(defun make-scale-frames (scale &key (begin-quest-num 1)
                                (data-list-name *cur-data-list) run-qvarlist)
  "In CSQ-manage, INPUT= scale-name (sym or string, which is the name of a scale class. MAKES QUESTION-FRAMES for each scale question (may be a multi-ans quest) using scale info as well. Can take scale info for question frames if desire later. Now only use the ::scale-questions for numbering. Adds key = name of scale to data-list"
;;MMM IN MAKE-SCALE-FRAMES
  (let*
      ((data-list (eval data-list-name))
       (q-frame-inst)
       (previous-qvar)
       (scalename-sym) 
       (scale-class-inst-sym)
       (scale-class-inst) 
       (scale-long-name) 
       (question-list)  
       (scale-class-inst-object)
       )
    ;;(afout 'out (format nil "In make-scale-frames, scale= ~A~%" scale))
    (setf scalename-sym (my-make-symbol scale))
    (multiple-value-setq (scale-class-inst scale-class-inst-object)
             (get-class-inst scalename-sym))
     ;;(afout 'out1 (format nil "(scale-class-inst= ~A scale-class-inst-object= ~A"scale-class-inst scale-class-inst-object))
    (cond
     ;;if only use run-qvarlist, must not use scale
     ((or (null scale) (null scale-class-inst-object))
      (set data-list-name (append data-list (list :non-scale-items))))
     (T
      (setf  scale-long-name (slot-value  scale-class-inst-object  'scale-name)
             question-list (slot-value  scale-class-inst-object  'scale-questions))
      ;;pre 01-2015
      #|      (setf scalename-sym (my-make-symbol scale)
            scale-class-inst (get-class-inst scalename-sym)
            scale-long-name (slot-value (eval scale-class-inst) 'scale-name)
            question-list (slot-value (eval scale-class-inst) 'scale-questions)) |#   

      ;;add :scale scalename-sym to data-list unless this is a recursive call SSS :scale added
      ;;JJJ
      (unless (member scalename-sym data-list :test 'equal)
        (set data-list-name (append data-list (list :scale scalename-sym))))
      ;;(afout 'out (format nil "1-selected-question-list= ~A~%"selected-question-list))
      ;;end T, cond
      ))
    ;;Append question-list if run-qvarlist
    (if run-qvarlist (setf question-list (append question-list run-qvarlist)))
    ;;(afout 'out (format nil "BBB question-list= ~A~% run-qvarlist= ~A%" question-list run-qvarlist))
    (loop
     ;;no for qvar  in question-list  ;;qvar = category for multi quests
     for quest-num from begin-quest-num to (list-length question-list)
     do
     (let
         (( cat-name)
          ( qvar)
          ( q-frame-inst)
          )
       ;;1-FIND QVAR
       (setf qvar (nth (- quest-num 1) question-list))

       ;;2-MAKE Q-FRAME-INST -- It's selection-callback appends *CSQ-DATA-LIST
       (setf  q-frame-inst (make-question-frame qvar  'scale-sym  
                                                :quest-num quest-num)) ;; :selection-type selection-type))
        
       ;;3-HOLD THIS FUNCTION'S PROCESSING UNTIL IT GETS POKED by callback
       ;;    let question hang for 1 hour without attention 
       (mp:current-process-pause 3600  'check-for-frame-visible)

       (cond
        ((member 'go-previous-frame *question-frame-results-list :test 'equal)
         ;;note, *CSQ-DATA-LIST reset in the previous-frame-callback
         (setf  *question-frame-results-list (delete-list-items '(go-previous-frame) 
                                                                *question-frame-results-list))
         (if (> quest-num 1)(setf quest-num (- quest-num 1))
           (setf quest-num 1))
         ;;recurse at previous qvar
         (make-scale-frames scale :begin-quest-num quest-num
                            :data-list-name  data-list-name :run-qvarlist  run-qvarlist)

         ;;NOTE: the recursive make-scale-frames MUST finish the rest of the qvars from previous frame, or will get redundant questions, so add RETURN here.
         (return)
         )
        (t nil))

       ;;end let, loop
       ))
    ;;end let*, make-scale-frames
    ))
;;TEST FOR BOTH FUNCTIONS ABOVE
;;  (make-scale-frames 'IntSS2Romantc)
;;  (make-scale-frames 'sT1HigherSelf)
;;make-scale-frames TESTED with (goshaq) and works well, ROBUST using previous frames button.



;;MAKE-CSQ-CSYMS--DEPRECIATED--use make-csym-tree instead!
;;2020
;;ddd
(defun make-csq-csyms (&key  load-user-data-p ;;needs work here
                             (set-final-global-vars-p T)(set-global-vars-p T)
                             (set-all-global-vars-p T)
                             omit-scales-p omit-qvars-p omit-special-vars-p omit-custom-vars-p
                             use-old-csymvals-p
                             (main-scale-classes *CSQ-MAIN-SCALE-CLASSES)
                             (misc-bio/lrn/qvar-lists *CSQ-BIO-ACAD-ETC-SYS/QVARS)
                             ;;MAKE SPECIAL-CLASSES FUNCTION 
                             (special-classes-arglists *CSQ-SPECIAL-SCALE-CSYM-ARGLISTS)
                             (custom-csym-arglists *CUSTOM-ARGLISTS-FOR-CSYMS)
                             ;;DATA PATHS ;;for input only?? not all used? SS CHECK LATER
                             (raw-csq-data-path *RAW-CSQ-DATA-PATH)
                             (raw-shaq-data-path *RAW-SHAQ-DATA-PATH)
                             (csq-csyms-data-path *DATED-CSQ-CSYMS-DATA-PATH)    
                             ;;FOR MAKE-CSYM-TREE
                             (make-sys-db-csyms-p T)
                             (top-csyms '($CS)) (qtype-key :QT)
                             (all-cs-db-cats-list *MASTER-CSART-CAT-DB) ;;use
                             (IF-SYS-CSYMS-EXIST :replace)  ;; :do-nothing)
                             use-old-sys-csymvals-p 
                             ;;FOR CSARTLOCS
                             (csartloc-origin :supsys-csartloc)(make-new-csartloc-p T)
                             ;;SSSS ONLY NEEDED FOR PCS AND ELMS??
                             (update-supsys-sublist-p T)
                             topdim dims  (last-dim :csym) supsys
                             topdimslist  def-topdimsym  (def-supsys '$SC)
                             supsys-csartloc new-csartloc new-csartloc-vals
                             parents  
                             ;;old (make-new-csartloc-p t)
                             ;;old (roots-at-clevs '(0))    
                             (artsym-n 2) (if-exists-replace-p t)  csartloc-n3-item 
                             csartloc-rest-vals   set-as-csartdims-p
                             (separator-str ".") (return-csartdims-p t) 
                             (append-all-csartloc-syms&vals-p t)                       
                             ;;FOR ELMSYMS and PCSYMS
                             (get-existing-elmsyms&pcsyms-p T)
                             (set-elm-supsys-csartloc '$ELM)
                             (set-pc-supsys-csartloc '$PC)
                             (all-elmsyms-sym '*ALL-ELMSYMS)
                             (all-pcsyms-sym '*ALL-PCSYMS)
                             (all-elmsymvals-sym '*ALL-ELMSYMS&VALS)
                             (all-pcsymvals-sym '*ALL-PCSYMS&VALS)
                             (elms-supsys-csym '$ELM)
                             (pcs-supsys-csym '$PC)
                             ;;OUTPUTS [Only for the CS-CAT-DB-TREE]
                             (save-cs-cats-db-tree-file *CS-CAT-DB-TREE-FILE) ;;use
                             (cs-db-csyms&vals-file *CS-CAT-DB-CSYMS&VALS-FILE) ;;use
                             allsupdims curdimslist (dimslist-type (quote allsup))   
                             ;;GLOBAL ACCUM VARS--data to be saved in CSQ-manager.
                             (all-csyms-sym '*ALL-CSYMS) 
                             (all-csyms&vals-sym '*ALL-CSYMS&VALS)
                             (cs-sys-csym-tree-sym '*CSQ-SYM-DB-TREE)
                             (cs-sys-csyms-sym '*ALL-SYS-DB-CSYMS)
                             (all-scale-csyms-sym '*ALL-SCALE-CSYMS)
                             (all-qvar-csyms-sym '*ALL-QVAR-CSYMS)
                             (all-special-csyms-sym '*ALL-SPECIAL-CSYMS)
                             (all-csartloc-syms-sym '*ALL-CSARTLOC-SYMS)
                             (all-csartloc-syms&vals-sym '*ALL-CSARTLOC-SYMS&VALS)
                             (clevkey :clev)
                             (sublist-key :s) (supsys-key :css) (catkey :cat) (valkey :v) 
                             (csvalkey :va) (csrankey :rnk) (infokey :info) (pckey :pc)
                             (bipathkey :bipath) (bestpolekey :bestpole) (tokey :to) 
                             (fromkey :from) (wtokey :wto) (wfromkey :wfrom) 
                             (pclistkey :pclist) (systemkey :csys) restkeys 
                             (sys-csyms-varname (quote *ALL-STORED-SYS-CSYMS)) ;;use
                             ;;is above same as csyms in *CS-CAT-DB-TREE-FILE??
                             start-with-make-elms/pcs-p
                             unbind-all-sys-csyms-p
                             )
  "CSQ-manage DEPRECIATED: USE MAKE-CSYM-TREE INSTEAD!   RETURNS (values  all-new-csyms  all-new-scale-csyms
              all-qvar-csyms all-csartloc-syms new-elmsyms new-pcsyms)   NOTE: Does not return special item scale and qvar csyms in scale and qvar lists, but DOES in all new-cssyms lists. 
    NOTE: Does NOT MAKE PCSYMS, ELMSYMS, LINK CSYMS, etc made in the CSQ PC and EXPLORE questionnaire functions. However, it does set their :supsys ELMS-SUPSYS-CSYM & PCS-SUPSYS-CSYM, and includes all ELMs & PCs in their supsys sublists."
  (let*
      ((all-new-csyms)
       (cs-sys-csym-tree)
       (cs-sys-csyms)
       (main-scale-csyms)
       (all-new-scale-csyms)
       (all-new-qvar-csyms)
       (all-new-csartloc-syms)
       (all-scale-csyms (eval-sym all-scale-csyms-sym))
       (all-sublist-csyms)
       (all-qvar-csyms (eval-sym all-qvar-csyms-sym))
       (all-special-csyms (eval-sym all-special-csyms-sym))
       (all-csartloc-syms (eval-sym all-csartloc-syms-sym))
       (all-csartloc-syms&vals (eval-sym all-csartloc-syms&vals-sym))
       (all-csyms (eval-sym all-csyms-sym))    
       (all-csyms&vals (eval-sym all-csyms&vals-sym))
       (csartloc-syms)
       (new-elmsyms)
       (new-pcsyms)
       (all-elm-csartloc-syms)
       (all-elm-artsym-vals)
       (ALL-ELM-CSYMS&VALS)
       (all-pc-csymvals)
       )
    ;;LOAD PCSYM DATA FILE?
    (when load-user-data-p
      (multiple-value-setq (new-elmsyms new-pcsyms)
          (load-user-csq-data raw-csq-data-path)))

    (unless start-with-make-elms/pcs-p
      ;;MAKE-CSYMS STEP 1: SYSTEM DB CSYMS & TREE
      (when  make-sys-db-csyms-p 
        (multiple-value-setq (cs-sys-csym-tree cs-sys-csyms csartloc-syms)
            (MAKE-CSYM-TREE :top-csyms top-csyms
                            :all-cats-list all-cs-db-cats-list :make-csym-treeviewer-p NIL
                            :if-csym-exists if-sys-csyms-exist  :tree-leveln 1
                            :use-old-csymvals-p  use-old-csymvals-p  
                            :csartloc-origin csartloc-origin 
                            :topdim topdim :dims dims :last-dim last-dim
                            :supsys supsys :topdimslist topdimslist
                            :supsys-csartloc new-csartloc
                            :def-supsys def-supsys
                            :new-csartloc nil
                            :new-csartloc-vals new-csartloc-vals
                            :if-exists-replace-p if-exists-replace-p
                            :artsym-n artsym-n :csartloc-n3-item csartloc-n3-item
                            :csartloc-rest-vals csartloc-rest-vals
                            :set-as-csartdims-p  set-as-csartdims-p 
                            :def-topdimsym def-topdimsym
                            :sublist-key sublist-key :supsys-key supsys-key
                            :clevkey clevkey 
                            :qtype-key qtype-key
                            :save-csym-tree-to-file save-cs-cats-db-tree-file
                            :save-csyms&vals-to-file cs-db-csyms&vals-file
                            :catkey catkey :valkey valkey
                            :csvalkey csvalkey :csrankey csrankey
                            :infokey infokey :pckey pckey
                            :bipathkey bipathkey :bestpolekey bestpolekey :tokey tokey
                            :fromkey fromkey :wtokey wtokey :wfromkey wfromkey
                            :pclistkey pclistkey :systemkey systemkey 
                            :restkeys restkeys 
                            :sys-csyms-varname sys-csyms-varname
                            )
          ;;end mvs, when
          ))
      ;;ACCUMULATE CSYMS
      (setf all-csyms (append all-csyms cs-sys-csyms)
            all-csartloc-syms (append all-csartloc-syms csartloc-syms))
      ;;SET GLOBAL SYS-DB SYMS TO LISTS
      (when set-global-vars-p
        (set cs-sys-csym-tree-sym cs-sys-csym-tree)
        (set cs-sys-csyms-sym cs-sys-csyms))
      ;;(break "==>  FINISHED 1. MAKE-CSYM-TREE")
      (format T "==>  FINISHED 1. MAKE-CSYM-TREE")       

      ;;MAKE-CSYMS STEP 2: Process CSQ MAIN SCALE CLASSES
      (unless omit-scales-p                   
        (loop
         for scale-class in main-scale-classes
         do
         (multiple-value-bind (main-scale-csym1 sublist-csyms1 all-new-csyms1  all-new-scale-csyms1 all-qvar-csyms1 all-csartloc-syms1 all-csyms1)
             (MAKE-CSYMS-FROM-SUBSCALES&QVARS scale-class)
           ;;ACCUMULATE
           (setf  main-scale-csyms (append main-scale-csyms (list main-scale-csym1))
                  all-sublist-csyms (append all-sublist-csyms sublist-csyms1)
                  all-new-csyms (append all-new-csyms all-new-csyms1)  ;;omit? sublist-csyms1
                  all-new-scale-csyms (append all-new-scale-csyms all-new-scale-csyms1)
                  all-new-qvar-csyms (append all-new-qvar-csyms all-qvar-csyms1)
                  all-new-csartloc-syms (append all-new-csartloc-syms all-csartloc-syms1)
                  all-csyms (append all-csyms all-csyms1))  
           ;;end mvb,loop, unless
           )))
      ;;ALL-SCALE-
      ;;ACCUMULATE other scales together?
      ;;IS THIS REDUNDANT?
      ;;(setf all-csyms (append all-csyms main-scale-csyms all-new-scale-csyms all-new-qvar-csyms))

      ;;SET SCALE GLOBAL SCALE AND QVAR VARS (not csartloc and all-csyms)?
      (when set-all-global-vars-p
        (set all-scale-csyms-sym all-scale-csyms)
        (set all-qvar-csyms-sym all-qvar-csyms))
      ;;(break "AFTER 2: make-csyms-from-subscales&qvars")
      (format T "==> FINISHED 2. MAKE-CSYMS-FROM-SUBSCALES&QVARS")

      ;;MAKE-CSYMS STEP 3: Process MISC SCALES/QVARS TO CSYMS
      ;; eg. '($BIO (UTYPE UGOALS BIO3EDUC BIO4JOB BI07LANG BIO1ETHN BIORELAF))
      (unless  omit-qvars-p 
        (loop
         for misc-scale-qvar-list in misc-bio/lrn/qvar-lists
         do
         (let*
             ((q-supsys (car misc-scale-qvar-list))
              (qvars (second misc-scale-qvar-list))
              )   
           (multiple-value-bind (new-csyms csartloc-syms all-sublist-csyms)
               (make-csyms-from-qvars qvars :supsys q-supsys
                                      :qtype-key qtype-key :qtype :QVAR
                                      :all-csartloc-syms-sym all-csartloc-syms-sym
                                      :all-csartloc-syms&vals-sym all-csartloc-syms&vals-sym)  
             ;;ACCUMULATE
             ;;qvar csyms from questions and multi-answers made to csyms?
             (setf  all-new-csyms (append all-new-csyms new-csyms
                                          all-sublist-csyms)
                    all-qvar-csyms (append all-qvar-csyms all-new-csyms)
                    all-csartloc-syms (append all-csartloc-syms csartloc-syms)
                    all-csyms (append all-csyms all-new-csyms))
             ;;end mvb,let,loop, unless
             ))))
      ;;SET QVAR GLOBAL VARS--SSSS MOVE/REDUNDANT??
      (set  all-qvar-csyms-sym all-qvar-csyms)
      ;;(break "AFTER make-csyms-from-qvars")
      (format T "==> FINISHED: 3. Process MISC SCALES/QVARS TO CSYMS")

      ;;MAKE-CSYMS STEP 4: Process SPECIAL SCALES & ITEMS
      ;;(csym bvphrase bvart-loc bvdata  bvdef   :info info :paths paths
      ;;eg '(("UserID" "User ID" $BIO.USERID NIL NIL))
     (unless omit-special-vars-p 
        (multiple-value-bind (all-new-csyms1 all-csartloc-syms1)
            ;;not used csartloc-sym1)
            ;;not used csartloclist all-csyms)
            (make-custom-csyms custom-csym-arglists)
          ;; (csyms-arglists &key (use-new-csartlocs-p T)    supsys  (def-supsys '$CS)                                   auto-art-dims  init-dims (csym-prestring "<")) 
          ;;ACCUMULATE
          (setf  all-special-csyms all-new-csyms1
                 all-new-csyms (append all-new-csyms all-special-csyms)
                 all-csartloc-syms (append all-csartloc-syms all-csartloc-syms1)
                 all-csyms (append all-csyms all-new-csyms1))
          ;;(break "END after make-custom-csyms")
          ;;end mvb,unless
          )
      (when set-all-global-vars-p 
        (set  all-special-csyms-sym all-special-csyms))
      ;;end unless omit-special-vars-p
      )
      ;;end unless start-with-make-elms/pcs-p
      )
    
    ;;MAKE-CSYMS STEP 5: GET-CSYMS FOR ALL-ELMSYMS and ALL-PCSYMS
    (when get-existing-elmsyms&pcsyms-p
      (setf all-elmsyms (eval-sym all-elmsyms-sym)
            all-pcsyms (eval-sym all-pcsyms-sym))

      ;;RESET ELM, PC CSARTLOC-SYMS?
      (when  set-elm-supsys-csartloc
        (multiple-value-setq (ALL-ELM-CSARTLOC-SYMS  
                              ALL-ELM-ARTSYM-VALS  ALL-ELM-CSYMS&VALS)
            (set-csyms-csartlocs all-elmsyms :topdim set-elm-supsys-csartloc)))          
      (when  set-pc-supsys-csartloc
        (multiple-value-setq (ALL-PC-CSARTLOC-SYMS  
                              ALL-PC-ARTSYM-VALS ALL-PC-CSYMVALS)
            (set-csyms-csartlocs all-pcsyms  :topdim set-pc-supsys-csartloc)))

      ;;PUT ELMs & PCs IN SUPSYM SUBLISTS (:S)
      ;;HERENOW
      ;;ELMs
      (set-key-value :S (eval all-elmsyms-sym) elms-supsys-csym
                     :append-values-p T  :set-listsym-to-newlist-p T
                     :append-as-flatlist-p T :no-dupl-p T)
      ;;PCs
      (set-key-value :S (eval all-pcsyms-sym)  pcs-supsys-csym
                     :append-values-p T :set-listsym-to-newlist-p T
                     :append-as-flatlist-p T :no-dupl-p T)
      ;;(break "after set $ELMS & $PCs")
      
      ;;ACCUMULATE REST
      (setf ALL-CSYMS (append all-csyms all-elmsyms all-pcsyms)       
            ALL-CSARTLOC-SYMS (append all-csartloc-syms
                                      all-elm-csartloc-syms all-pc-csartloc-syms))

      ;;SETTING ELM & PC GLOBAL VARS
      ;; all-elmsyms-sym and all-pcsyms-sym already set above
      (when set-global-vars-p
        (set all-elmsymvals-sym ALL-ELM-CSYMS&VALS)        
        (set all-pcsymvals-sym ALL-PC-CSYMVALS))
      ;;end when get-existing-elmsyms&pcsyms-p
      )
    ;;(break "FINISHED: 3. Process MISC SCALES/QVARS TO CSYMS")
    (format T "==> FINISHED: 3. Process MISC SCALES/QVARS TO CSYMS")

    ;;SET MAIN GLOBAL VARS?
    (when (or set-global-vars-p set-all-global-vars-p)
      (set all-scale-csyms-sym all-scale-csyms)            
      (set all-qvar-csyms-sym all-qvar-csyms)
      (set all-csartloc-syms-sym all-csartloc-syms)
      (set all-csartloc-syms&vals-sym all-csartloc-syms&vals)
      (set all-csyms-sym all-csyms)
      (set all-csyms&vals-sym all-csyms&vals))

    ;;IS THIS A GOOD IDEA?
    #|      (when (> (list-length *ALL-STORED-SYS-CSYMS)
               (list-length *ALL-CSYMS))
        (setf *ALL-CSYMS *ALL-STORED-SYS-CSYMS))|#
    (format T "==> FINISHED:  4. Process SPECIAL SCALES & ITEMS")

    ;;NOTE: *ALL-STORED-SYS-CSYMS set by make-csym 
    ;; *FILE-ELMSYMS, *file-elmsymvals, *file-pcsyms, *file-pcsymval-lists,
    ;;     *file-csq-data-list, *file-all-pc-element-qvars, *file-all-pcqvar-lists, 
    ;;     *file-all-csq-value-ranking-lists
    (format T "==> FINISHED CREATING ALL NEW CSYMS")
    (values  all-csyms  all-scale-csyms
             all-qvar-csyms all-csartloc-syms new-elmsyms new-pcsyms)
    ;;end let, make-csq-csyms
    ))
;;TEST
;; (make-csq-csyms  :load-user-data-p NIL)
;;CSQ-SYMS (make-csq-csyms )  ;[I UNBOUND ALL CSYMS]
;;
;;  (make-csq-csyms  :load-user-data-p NIL :IF-SYS-CSYMS-EXIST :replace)
;; ABOVE DONE--WHAT NEXT?  ;SSSSSS START HERE 
;;
;;FOR PROCESS ELMS/PCS AFTER REST DONE
;; (make-csq-csyms :start-with-make-elms/pcs-p T :load-user-data-p NIL)




;;MAKE-PC-ELEMENTS-FRAMES --REDUNDANT?
;;
;;ddd
#|(defun make-pc-elements-frames (&key (scalecat-list *cur-pc-scale-cats)
                                 (scale-cat-list *All-PC-element-scale-cats)  
                                reverse-subclass-order-p
                               (non-scalecat-syms  '(:scales scales :scale scale   NIL 
                                                     PREVIOUS-USER SPECIFIC-QUESTS)))
  "In CSQ, Makes  frames to find PC elements. INPUT=list of scales to make question-frames for every question in every scale in the list.  Both Single and Multi-selection questions can be included in the qvar lists in the :scale-questions slot of each scale. reverse-subclass-order-p causes order of cat-scales to be opposite those in class definitions."

     ;;(afout 'out (format nil "In make-scales-frames,   scalecat-list= ~A~%" scalecat-list))
     (let
         ((processed-scales)
          (processed-cats)
          )
     ;;PROCESS THE all-scalecats
     (loop
      for scale  in scalecat-list
    ;;not needed?  with scale-name-str
      with scale-category
      with scale-cat-class
      with cat-scale-list
      with process-scale-list
      do      
    ;;  (afout 'out (format nil "In make-scales-frames, scale= ~A~%" scale ))
    ;;not needed  (setf scale-name-str (format nil "~A" scale))
     ;;SSS UNDO AFOUTS
      ;;(afout 'out (format nil "OMIT LIST)= ~a"   (append  non-scalecat-syms  processed-scales processed-cats)))
     (cond
      ;;in case :scales or other non-scale-items included in list or WAS PROCESSED
      ((member scale (append  non-scalecat-syms  processed-scales processed-cats)
               :test 'my-equal)
       ;;(afout 'out (format nil "SCALE= ~a is a member of OMIT LIST)" scale  ))
       NIL)
      ;;IS SCALE A SCALE SUPERCLASS? If so, find subclass regular scales.
       ((member scale scale-cat-list :test 'my-equal) ;;these are strings
        ;;not needed?   (setf scale-cat-class scale cat-scale-list (find-direct-subclass-names scale-cat-class))
        (multiple-value-bind (cat-scale-list cat-scale-classes)
            (find-direct-subclass-names scale :reverse-subclass-order-p 
                                        reverse-subclass-order-p)
            ;;(afout 'out (format nil "In make-scales-frames, subclasses= ~A~%" cat-scale-list))
            (unless (null reverse-subclass-order-p)
              (setf cat-scale-list (reverse cat-scale-list)))
            ;;(BREAK)
          (loop
           for cat-scale in cat-scale-list
           ;;with sub-cat-scale-list
           do
          (setf outx1 (format nil "In CAT inner loop, cat-scale= ~A~%" cat-scale)) 
          (unless (member cat-scale processed-scales :test 'my-equal)
           (make-scale-frames cat-scale)
        ;;added 01-2015
           (setf processed-scales (append processed-scales (list cat-scale)))
           ;;end unless, inner loop
           ))
        ;;added 01-2015
        (setf processed-cats (append processed-cats (list scale)))
        ;;end mvb, member clause
        ))
       (t
        ;;if an ordinary scale, make-scale-frames  
        (unless (member scale processed-scales :test 'my-equal)
          (make-scale-frames scale)
          (setf processed-scales (append processed-scales (list scale)))
          )))
        ;;end outer loop
        )

    ;;end let, make-pc-elements-frames
    ))|#

;; (make-pc-elements-frames)

















;;-----------------xxx -------------------------- OLD BUT KEEP?? ------------------
;;ORIGINAL VERSION -- PRE CALC SCALES AND SUBSCALES
#|(defun make-scale-frames (scale &key (begin-quest-num 1)
                                (data-list-name '*CSQ-DATA-LIST) run-qvarlist)
  "In U-SHAQ-management, INPUT= scale-name (sym or string, which is the name of a scale class. MAKES QUESTION-FRAMES for each scale question (may be a multi-ans quest) using scale info as well. Can take scale info for question frames if desire later. Now only use the ::scale-questions for numbering. Adds key = name of scale to data-list"
;;MMM IN MAKE-SCALE-FRAMES
  (let*
      ((data-list (eval data-list-name))
       (q-frame-inst)
       (previous-qvar)
       (scalename-sym) 
       (scale-class-inst) 
       (scale-long-name) 
       (question-list)  
       )
    ;;(afout 'out (format nil "In make-scale-frames, scale= ~A~%" scale))
    (cond
     ;;if only use run-qvarlist, must not use scale
     ((null scale) 
      (set data-list-name (append data-list (list :non-scale-items))))
     (T
      (setf scalename-sym (my-make-symbol scale)
            scale-class-inst (get-class-inst scalename-sym)
            scale-long-name (slot-value (eval scale-class-inst) 'scale-name)
            question-list (slot-value (eval scale-class-inst) 'scale-questions))    

    ;;add :scale scalename-sym to data-list unless this is a recursive call
    (unless (member scalename-sym data-list :test 'equal)
      (set data-list-name (append data-list (list :scale scalename-sym))))
    ;;(afout 'out (format nil "1-selected-question-list= ~A~%"selected-question-list))
    ;;end T, cond
    ))
    ;;Append question-list if run-qvarlist
    (if run-qvarlist (setf question-list (append question-list run-qvarlist)))
    ;;(afout 'out (format nil "BBB question-list= ~A~% run-qvarlist= ~A%" question-list run-qvarlist))
    (loop
     ;;no for qvar  in question-list  ;;qvar = category for multi quests
     for quest-num from begin-quest-num to (list-length question-list)
     with cat-name 
     with qvar
     with q-frame-inst
     do
     ;;1-FIND QVAR
     (setf qvar (nth (- quest-num 1) question-list))
 
     ;;2-MAKE Q-FRAME-INST -- It's selection-callback appends *CSQ-DATA-LIST
     (setf  q-frame-inst (make-question-frame qvar  'scale-sym  
                                               :quest-num quest-num)) ;; :selection-type selection-type))
     ;;3-HOLD THIS FUNCTION'S PROCESSING UNTIL IT GETS POKED by callback
     ;;    let question hang for 1 hour without attention 
     (mp:current-process-pause 3600  'check-for-frame-visible)

     (cond
      ((member 'go-previous-frame *question-frame-results-list :test 'equal)
       ;;note, *CSQ-DATA-LIST reset in the previous-frame-callback
       (setf  *question-frame-results-list (delete-list-items '(go-previous-frame) 
                                                              *question-frame-results-list))
       (if (> quest-num 1)(setf quest-num (- quest-num 1))
         (setf quest-num 1))
       ;;recurse at previous qvar
       (make-scale-frames scale :begin-quest-num quest-num
                          :data-list-name  data-list-name :run-qvarlist  run-qvarlist)

      ;;NOTE: the recursive make-scale-frames MUST finish the rest of the qvars from previous frame, or will get redundant questions, so add RETURN here.
      (return)
       )
      (t nil))
     ;;end loop
     )
    ;;end let, make-scale-frames
    ))|#


 ;;"The system cannot find the drive specified."

