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
(defparameter *run-qvar-list NIL)
       ;; '(stmajgpa)) '(STURESID) ) ;;'(STURESOURCE)) ;; NIL ) ;;


;; USE TO CHECK *SHAQ-DATA-LIST 
;;  (pretty-print-shaq-data-list *shaq-data-list)

;;; GOSHAQ -- (FOR LISP INTERPRETED VERSION)
;; 
;;ddd GGG
(defun goshaq (&key (run-qvar-list *run-qvar-list) (test-scale-list *test-scale-list )                     (run-shaq-intros-p *run-shaq-intros-p))
  "In U-SHAQ-management, RUN-QVAR-LIST is a list of qvars/questions to run that EXCLUDES running all other questions. TEST-SCALE-LIST is a list of test scales."
  (setf out nil)
  ;;MUST SET *make-defs-file TO NIL or writes scale defclasses and instances to files to be used in the application builder instead of evaluating them.
  (setf *make-defs-file-p NIL)

  ;;IF SHAQ CONFIG VARS NOT INITIALIZED, DO IT NOW 
  (unless  (boundp '*config-shaq-loaded )
    (load  "C:\\3-TS\\LISP PROJECTS TS\\SHAQ\\config-shaq.lisp"))
  (unless *shaq-data-list
    (load  "C:\\3-TS\\LISP PROJECTS TS\\SHAQ\\config-vars.lisp"))
  (unless *shaq-initialized
    (shaq-initialize))
  (setf *shaq-data-list '(:shaq-data-list)
        *shaq-scaledata-list '(:shaq-scaledata-list)
        *run-shaq-intros-p run-shaq-intros-p)
  (SHAQ-process-manager    ;;  *shaq-post-sym-list *shaq-scale-sym-list  
                           :run-qvar-list run-qvar-list :test-scale-list test-scale-list
                           :run-shaq-intros-p run-shaq-intros-p)
  ;;end goshaq
  )


;;RUN-SHAQ
;;
;;ddd
(defun run-shaq (&key (run-qvar-list *run-qvar-list) (test-scale-list *test-scale-list )                     (run-shaq-intros-p *run-shaq-intros-p))
  "In U-SHAQ-management, RUN-QVAR-LIST is a list of qvars/questions to run that EXCLUDES running all other questions. TEST-SCALE-LIST is a list of test scales.
THIS VERSION FOR USE IN APPLICATION BUILDER TO MAKE RUNTIME DELIVERY VERSION."
 (setf out nil)
;;IMPORTANT FOR DELIVER, CREATE THE CLASS COMPILE AND INST FILES
;;no, DO OUTSIDE OF DELIVERY  (setf *make-defs-file-p T)

  ;;for debugging
  (setq *debugger-hook* 'my-debugger-hook) ;;function my-debugger-hook defined below

;;SET KEY GLOBAL VARIABLES
  ;;NO (shaq-initialize) FOR RUN-TIME VERSION
;; (unless *shaq-initialized   (shaq-initialize))
  (setf *shaq-data-list '(:shaq-data-list)
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
(defparameter *test-scale-list '()) ;; '(ssl3WritingSkills)) ;;'(ACAD-LEARNING));; '(scollege)) ;; )
;;OK-LIST '(BIO NO-SCALE BELIEFS OUTCOME VALUES-THEMES SKILLS-CONFIDENCE INTERPERSONAL ACAD-LEARNING CAREER-INTEREST)) 
(defparameter *run-qvar-list NIL) ;; '(stmajgpa)) '(STURESID) ) ;;'(STURESOURCE)) ;; NIL ) ;;
(defparameter *load-CS-files-p NIL)
(defparameter *no-elmsym-combo-reset-p nil "Keeps from running make-elmsym-compare-lists--which takes a lot of time")

;; USE TO CHECK *csq-data-list  
;;  (pretty-print-CSQ-data-list *CSQ-data-list)

;;; GOCSQ -- (FOR LISP INTERPRETED VERSION)  ;;(csq-manager
;; 
;;ddd GGG
(defun gocsq (&optional load-cs-config-p csq-reinit-p  USE-TEST-QVARS-P
                        &key (use-existing-elmsym-combos T)
                        no-elmsym-reset-p 
                        (run-select-csq-parts-p T))
  "In CSQ-manage, STARTS CSQ w/o args--except load-cs-config-p."
  (when (or  load-cs-config-p (not (boundp 'cs-init)))
    (setf *load-CS-files-p T)
    (load  "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CS-config.lisp"))

  (cond
   (no-elmsym-reset-p
      (setf *no-elmsym-combo-reset-p T))
   (t (setf *no-elmsym-combo-reset-p NIL)))
 
  (when run-select-csq-parts-p
    (setf *run-select-csq-parts-p T))

  (when (not (boundp '*RUN-CSQ-INTROS-P))
    (setf  *RUN-CSQ-INTROS-P nil))
  (when (not (boundp '*CS-INIT-RAN-P))
    (setf   *CS-INIT-RAN-P nil))

  ;;use main function
  (gocsq1 nil csq-reinit-p use-test-qvars-p
          :run-qvar-list *run-qvar-list 
          :use-existing-elmsym-combos use-existing-elmsym-combos
          :test-scale-list *test-scale-list   :run-CSQ-intros-p *run-CSQ-intros-p)
  )

;;GOCSQ1
;;
;;ddd the main worker function
(defun goCSQ1 (&optional load-configs-p  csq-reinit-p use-test-qvars-p
                         &key (run-qvar-list *run-qvar-list) 
                         (use-existing-elmsym-combos *use-existing-elmsym-combos)
                        (test-scale-list *test-scale-list ) (run-CSQ-intros-p *run-CSQ-intros-p) 
                        (run-SHAQ-intros-p *run-SHAQ-intros-p))
  "In CSQ-manage, RUN-QVAR-LIST is a list of qvars/questions to run that EXCLUDES running all other questions. TEST-SCALE-LIST is a list of test scales."
  (setf out nil)
  ;;MUST SET *make-defs-file TO NIL or writes scale defclasses and instances to files to be used in the application builder instead of evaluating them.
  (setf *make-defs-file-p NIL)


  ;;IF CSQ CONFIG VARS NOT INITIALIZED, DO IT NOW 
  (unless  (or (null load-configs-p)
               (and  (boundp '*CogSys-loaded-p)
                     *CogSys-loaded-p))
    (csq-initialize :use-test-qvars-p use-test-qvars-p 
                    :if-elmsym-exists-reset-p t :unbind-csq-vars-p t
                    :if-elmsym-exists-do-nothing-p NIL :save-all-userdata-p t))
    (sleep 2)

  ;;FOR CS-INIT
  (unless  *cs-init-ran-p
    (cs-init))

  ;;FOR CSQ-INITIALIZE
  ;;(unless *shaq-data-list  (load  "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\config-vars.lisp"))
 (unless *CSQ-initialized
  (CSQ-initialize :use-test-qvars-p use-test-qvars-p))
 (when csq-reinit-p
   (csq-reinit :use-test-qvars-p use-test-qvars-p))

 ;;INIT DATA LISTS ETC --done in csq-initialize

  (setf *run-CSQ-intros-p  run-CSQ-intros-p
        *run-SHAQ-intros-p  run-SHAQ-intros-p)

  ;;RUN MAIN FUNCTION
  (CSQ-process-manager    ;;  *shaq-post-sym-list *shaq-scale-sym-list  
                :run-qvar-list run-qvar-list :test-scale-list test-scale-list
                :run-shaq-intros-p run-shaq-intros-p 
                :run-CSQ-intros-p run-CSQ-intros-p)
                :use-existing-elmsym-combos use-existing-elmsym-combos
  ;;end goCSQ
  )


;;RUN-CSQ
;;
;;ddd
(defun run-CSQ (&key (run-qvar-list *run-qvar-list) (test-scale-list *test-scale-list )                     (run-CSQ-intros-p *run-CSQ-intros-p) 
                     (use-existing-elmsym-combos *use-existing-elmsym-combos)
                     run-shaq-intros-p)
  "In CSQ-manage, RUN-QVAR-LIST is a list of qvars/questions to run that EXCLUDES running all other questions. TEST-SCALE-LIST is a list of test scales. THIS VERSION FOR USE IN APPLICATION BUILDER TO MAKE RUNTIME DELIVERY VERSION."
 (setf out nil)
;;IMPORTANT FOR DELIVER, CREATE THE CLASS COMPILE AND INST FILES
;;no, DO OUTSIDE OF DELIVERY  (setf *make-defs-file-p T)

  (when *run-shaq-p
  ;;for debugging
  (setq *debugger-hook* 'my-debugger-hook) ;;function my-debugger-hook defined below

;;SET KEY GLOBAL VARIABLES
  ;;NO (shaq-initialize) FOR RUN-TIME VERSION
;; (unless *shaq-initialized   (shaq-initialize))
  (setf *shaq-data-list '(:shaq-data-list)
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
                :run-qvar-list run-qvar-list :test-scale-list test-scale-list
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
(defun CSQ-process-manager (&key (question-sym-list *All-PCE-elementQs)  
                                   run-qvar-list test-scale-list 
                                   (run-CSQ-intros-p *run-CSQ-intros-p)
                                   (run-shaq-intros-p *run-shaq-intros-p)
                                   (use-existing-elmsym-combos *use-existing-elmsym-combos)
                                   append-to-scale-cat-list )
                                                   ;;no args for Deliver?  text height)
  "In U-SHAQ-management.lisp, manages all processes makes the basic specific-instance elements.  RUN-QVAR-LIST is a list of qvars/questions to run that EXCLUDES running all other questions.  =  question-sym-list "
  (let (  ;;not used?? (manager-mailbox (mp:ensure-process-mailbox))
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
     (setf *CSQ-main-process
           (mp:process-run-function "CSQ MAIN PROCESS"
                                    '(:mailbox "CSQ-main-process-mailbox")
                                    'CSQ-manager  question-sym-list 
                                    run-qvar-list test-scale-list run-CSQ-intros-p 
                                    run-shaq-intros-p
                                    append-to-scale-cat-list
                                    :use-existing-elmsym-combos use-existing-elmsym-combos))
     ;; (csq-manager
     ;;end when *run-csq-p
     )

   ;;TO RUN SHAQ -------------------
   (when *run-SHAQ-p
          (setf text "Success and Happiness Attributes Question (SHAQ)")
     (setf *SHAQ-main-process
           (mp:process-run-function "SHAQ MAIN PROCESS"
                                    '(:mailbox "SHAQ-main-process-mailbox")
                                    'SHAQ-manager  question-sym-list 
                                    run-qvar-list test-scale-list  
                                    run-shaq-intros-p
                                    append-to-scale-cat-list))
     ;;end when *run-SHAQ-p
     )
         
   ;;end let, CSQ-process-manager
   ))





;;xxx
;;------------------------------- FOR CSQ ONLY -----------------------------------------


;;CSQ-MANAGER
;;
;;ddd
(defun CSQ-manager (question-sym-list  run-qvar-list test-scale-list
                                       run-CSQ-intros-p  run-SHAQ-intros-p
                                       append-to-scale-cat-list 
                                       &key (not-send-csqdat-p T) 
                                       (use-existing-elmsym-combos T)
                                       (reset-*all-elmsym-compare-combos-p T)
                                       (all-elmsyms *all-elmsyms)
                                       (all-elmsym-qvars '*all-pc-element-qvars))
  "In CSQ-manager,  Called by CSQ main process.  Code for management of entire CSQ process. APPEND-TO-SCALE-CAT-LIST adds superclass scale categories get scale-lists from."  

  ;;Following is over-ridden by the step choice frame below
  (cond
   (use-existing-elmsym-combos (setf *use-existing-elmsym-combos T))
   (t (setf *use-existing-elmsym-combos NIL)))
  ;;(break (format nil "*use-existing-elmsym-combos= ~A" *use-existing-elmsym-combos))
  (format T "*use-existing-elmsym-combos= ~A" *use-existing-elmsym-combos)

  ;;RESET OTHER GLOBAL VARS
  (setf *pc-items-ratings-lists nil)

  (let 
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

    ;;(BREAK "B0")

    ; STEP 1: RUN THE INTRO FRAMES and SELECT SCALES/QUESTIONS
    ;;MUST RUN before assemble rest of data to select questions
    ;; normally used by ALL incl picking specific scales
    ;; don't use for testing only purposes
    (cond
     ;;IF WANT TO RUN CSQ INTROS--done below
     #|     ((and *run-CSQ-intros-p (null test-scale-list)(null run-qvar-list))
      (make-CSQ-intro-frames)
      )|#
     ;;PREVENTS RUNNING SHAQ INTROS
     (*run-csq-p
      NIL
      )
     ;;IF WANT TO RUN SHAQ INTROS
     (*run-shaq-intros-p
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
      ;;(afout 'out (format nil "2.selected-scalecats= ~a~%" selected-scalecats))
      ;;end if *run-shaq-intros-p
      )
     (t nil))

    
    ;;STEP 2: RUN SCALES,QUESTIONS and and GATHER DATA into *CSQ-data-list
    ;;
    (cond
     (*run-csq-p

      ;;STEP 2.0: MAKE KEY CSQ CHOICES, 1. where to begin, 2. make new pc combos?
      ;;MAKE-CSQ-CHOICE-INTERFACE
      ;;    1.chooses entry point = *run-complete-csq-p; 
      ;;              *run-begin-with-find-pcs-p; and/or  *csq-begin-step
      ;;    2. file to load data from (if any) = *csq-previous-data-file

      ;;SSSSS CHECK NEW ALTERN FOR EXPLORE A PC
      (run-csq-choice-interface current-process) 
      
      (mp:current-process-pause 1000) ;;  'check-for-frame-visible)
      ;;(break "after run-csq-choice-interface") 
        ;;FROM go-csq-choices-callback
     #|    ((string-equal begin-selection (first  *csq-step-button-strings))
          (setf *run-complete-csq-p T))
         ((string-equal begin-selection (second  *csq-step-button-strings))
          (setf  *run-begin-with-find-pcs-p T))
         ((string-equal begin-selection (third  *csq-step-button-strings))
          (setf *csq-begin-step 'find-pc-values
                *run-begin-with-find-csvalues-p T))
         (t  (setf *run-complete-csq-p T)))|#
      ;;HERE1
      ;; LATER??  WRITE FUNCTION TO SEE WHAT DATA ARE IN DATA FILE, TO SEE WHICH STEP TO START AT INSTEAD OF CHOICE BELOW??

      ;;RUN CSQ INTROS-ID INFO
      (when *run-CSQ-intros-p
        (make-CSQ-intro-frames)
        ;;hold until poked
        ;;(mp:current-process-pause 3600  'check-for-frame-visible)
        (BREAK "CSQ 1- POST make-CSQ-intro-frames")
        )

      ;;STEP 2.1 IDENTIFY ACTUAL NAMES OF PEOPLE FROM PEOPLE  ELMS--OR OTHERS   
      ;;Names are added to FIFTH position in ELMSYM values list

      (when (or *run-complete-csq-p *run-only-write-elms-p)
        (make-elmsym-name-frames )
        ;;done in make-elmsym-name-frames
        ;;(mp:current-process-pause 3600  'check-for-frame-visible)
        )      
      ;;(BREAK "CSQ 2-POST make-elmsym-name-frames")
      
      ;;STEP 2.2 MAKE FRAMES FOR IDENTIFYING PC ELEMENTS
      ;;Step 2.1.1: FIND OR MAKE ELMSYM COMPARISON COMBOS
      (when (or *run-complete-csq-p 
                *run-begin-with-find-pcs-p 
                *run-only-find-pcs-p)

        ;;GET COMBOS OF 3 ELEMENTS
        ;;EITHER (1) USE STANDARDIZED SET or
        ;;  (2) CALC NEW SET BELOW
        (cond
         ;;set in config file default T
         (*use-existing-elmsym-combos 
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
         ;;NORMAL USING NEW COMBOS                 
         (t 
          ;;Make combinations of 3 elements 
          (unless *no-elmsym-combo-reset-p  ;;why is this here??
            (multiple-value-setq (global-combos-sym n-combos return-combos all-combos )
                (make-elmsym-compare-lists))  ;;defaults to *all-elmsyms and *all-elmsym-compare-combos))
            (when (and (boundp reset-*all-elmsym-compare-combos-p)
                       reset-*all-elmsym-compare-combos-p)
              (setf  *all-elmsym-compare-combos return-combos))
            )))
        ;;SS START HERE  PUT CODE ABOVE SO CAN EITHER  START WITH 
        ;;   1. MAKING PERM COMBOS AND/OR 2. COMPARE, FIND PCs, 3. RATE PCS?
        ;;NOTE: I COMPLETED CSQ THRU FINDING ALL ELMSYMS (see test1 file)

        ;;(BREAK "AFTER COMBOS SELECTED")
        
        ;;SAVE ALL USERDATA FROM UP TO NOW?
        (when *save-all-userdata-after-find-elms
          (save-csq-data-to-file *save-all-userdata-p))

        ;; OUTPUTS
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

        ;;STEP 2.1.2 MAKE THE FRAMES TO FIND THE NEW PCS
        (make-pc-poles-frames  return-combos)  ;;was using old functions *all-elmsyms-comparisons)
        (BREAK "CSQ 3-POST make-pc-poles-frames")

        ;;pc-groups pc-self)) ;;*all-pc-element-qvar-cats)
        ;;  (make-pc-poles-frames '(:CSQ-DATA-LIST :PCSYM-ELM-LISTS ((A (MOTHER FATHER TEACHER)) (B (MOTHER BEST-M-FRIEND TEACHER)) (C (MOTHER FATHER BEST-M-FRIEND)) (D (FATHER BEST-M-FRIEND TEACHER)))))

        ;;hold until poked, NO? done inside make-pc-poles-frames??

        ;;STEP 3: RATE THE VALUE OF EACH PC
        ;;adds values to *csq-data-list
        ;; First, add key to *csq-data-list
        ;;seems to cause error--processed before above function?? put inside it.
        ;; (setf *csq-data-list  (append *csq-data-list  (list :pc-values)))
        ;;(BREAK "aftter (append *csq-data-list  (list :pc-values))")

        ;;END WHEN (or *run-complete-csq-p *run-begin-with-find-pcs-p *run-only-find-pcs-p)
        )   

        ;;if make-pc-poles-frames not called must pause here?
        ;;(mp:current-process-pause 1000) ;;  'check-for-frame-visible)      

      ;;STEP 2.3: RATE PC VALUES & RANK THEM
      (when (or *run-complete-csq-p *run-begin-with-find-csvalues-p
                *run-only-find-csvalues-p)
        ;; MAKE-PC-RATE-VALUE-FRAMES TO RATE PC VALUES
        (make-pc-rate-value-frames *csq-data-list)   
        (mp:current-process-pause 3600)
        (BREAK "CSQ 4-POST make-pc-rate-value-frames")
        ;;end when (or *run-complete-csq-p *run-begin-with-find-pcs-p *run-only-find-pcs-p)
        )
      ;;hold until poked --NO, done inside make-pc-rate-value-frames??
      ;;If start here, need pause here?
       ;;  'check-for-frame-visible)

      ;;STEP 2.4 RANK TOP VALUES WITHIN EACH RATING CATEGORY
      ;; (setf *pc-items-ratings-lists  '(((KIND5 "0.917") (K1 "0.917") (NICE "0.917"))((TALL "0.833") (FEMAL "0.667") (PAR "0.833"))))
      ;;works= (((("NICE" 1) ("K1" 2) ("KIND5" 3)) (("TALL" 1) ("PAR" 2)) (("FEMAL" 1))))
     ;;unders= ("UNDERS" "UNDERS vs NUND" CS2-1-1-99 NIL NIL :PC ("UNDERS" "NUND" 1 NIL) :POLE1 "UNDERS" :POLE2 "NUND" :BESTPOLE 1 :BIPATHS ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL FATHER NIL)))
     ;;SSSS CHECK *pc-items-ratings-lists IN SAVED DATA FILE
     ;;NOT if make new ones here??     
     (when  (or *run-complete-csq-p *run-begin-with-find-csvalues-p
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
   ;;eg KIND = "KIND" "kind vs ukind" CS2-1-1-99 NIL NIL :PC ("kind" "ukind" 1 NIL) :POLE1 "kind" :POLE2 "ukind" :BESTPOLE 1 :BIPATHS ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)) :CSVAL "0.917" :CSRANK "2")
      (mp:current-process-pause 3600)
      (break "after rank top values")
      ;;end when
      )
     ;;STEP 3: EXPLORE A COG SYS IN DEPTH?
     (when *run-begin-with-cs-explore-p
       ;;initialize the global vars, etc.
       (initialize-cs-explore)
     ;;SSSSS START HERE WRITE AND ADD NEW CS-EXPLORE FUNCTION
       )
     
     (break "Before SAVE ALL THE USER DATA")
      ;;STEP 4: SAVE ALL THE USER DATA
      (when *save-all-userdata-p
        (save-csq-data-to-file *save-all-csq-data-file))
      ;; (save-csq-data-to-file  "Tom-AllData2017-01.lisp")

      ;;LAST STEP SO FAR
      (when (or *run-complete-csq-p *run-begin-with-find-csvalranks-p
                *run-only-find-csvalues-p *run-begin-with-cs-explore-p
                *run-begin-with-find-last-p)
        (BREAK "END OF CSQ SO FAR"))
     ;;SSSSS END OF CSQ SO FAR---------------

      ;;END RUN-CSQ
      )
      
     ;;FOR SHAQ (unquote later)
     (*run-shaq-p
      ;;2.1. FIND USERID, UNLESS USERID = "NO-BIO",
      ;;    LATER, ADD OUTCOME SCALES UNLESS "NO-BIO"
      #| (multiple-value-setq (user-CSQdata-list userid)
        ;;  (get-selected-values
        (get-qvarlist-in-CSQdatalist  "userid"))

    ;;2.2 NORMALLY, RUN THE BIO  QUESTIONS NEXT (put OUTCOME at end)
    ;;Don't run BIO, add to list to run later -- may confuse 
    (cond
     ((or (string-equal userid "NO-BIO") test-scale-list  run-qvar-list)
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

    ;;2.3  USE FUNCTION THAT DOES ALL THE WORK FOR REST OF SELECTIONS
    #| ?? WHAT IS THIS??   (multiple-value-setq (all-selected-scales  all-selected-questions selected-cats all-scalecats selected-scales all-scale-inst-strings all-scale-inst-objects)|#

    #|   Put in all-scalecats-list order above  ;;2.4 RUN OUTCOME LAST 
     (unless (or (string-equal userid "NO-BIO") test-scale-list run-qvar-list)
      (make-scales-frames '(OUTCOME) :scale-cat-list scale-cat-list))|#

    ;;2.5 RUN USER-FEEDBACK FRAME
    ;;DO THIS LAST to replace all other questions in selected-question-list
    ;;if run-qvar-list, then RUN ONLY THE QUESTS ON run-qvar-list
    ;;BBB MMM  In CSQ-manager, call to make-scale-frames
   ;;(afout 'out (format nil "BB: IF run-qvar-list= ~A~%" run-qvar-list))
    (if run-qvar-list 
        (make-scale-frames  nil :run-qvar-list run-qvar-list)) ;; :scale-cat-list scale-cat-list
   |#
      ;;END *run-shaq-p
      )
     (t nil))

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
          *CSQ-scaledata-list (append *CSQ-scaledata-list all-scale-data-list))
    ;; (setf   *CSQ-scaledata-list (append *CSQ-scaledata-list (calc-scale&subscale-scores)))
    ;; (setf *testcss (calc-scale&subscale-scores))

    (sleep 5)
 
    ;;STEP 4: MAKE THE QUESTION TEXT and SCALE TEXT

    ;;4.1 SET THE QVAR CONVERTED SYMS (add a T to end) 
    ;;      TO EACH QUEST TEXT and 
    ;;   make a list of them all (later eval the syms to get the quest-text)
    (when *run-shaq-p
      (setf all-text-questsyms-list  (make-all-questions-text)))

    ;;4.2 MAKE SCALE + QUEST TEXT
    ;;   Make the text for the two windows 1-SCALES ONLY and 
    ;;    2-ALL RESULTS=SCALES, SUBSCALES/QUESTS
    (when *run-shaq-p
      (multiple-value-setq (scales-subscales-results-text scales-ss-quests-results-text)
          (process-scales-results)))

    ;;STEP 5: CREATE THE WHOLE TEXT AND 3  RESULTS WINDOWS
    ;; 1-SCALES ONLY, 2-ALL RESULTS, 3-HELPLINKS 
    ;; (Do this before send-CSQ-dat to prevent connection error from preventing printout
    (when *run-shaq-p
      (make-CSQ-results-text))

    ;;STEP 6: SEND DATA TO SERVER and  PRINT THE RESULTS
    (unless not-send-CSQdat-p
      (send-CSQ-dat))
 
    ;;end let, CSQ--manager
    ))



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
(defun SHAQ-manager (question-sym-list  run-qvar-list test-scale-list run-shaq-intros-p append-to-scale-cat-list &key not-send-shaqdat-p)
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
     ((and *run-shaq-intros-p (null test-scale-list)(null run-qvar-list))
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
    
    ;;STEP 2: RUN SCALES,QUESTIONS and and GATHER DATA into *shaq-data-list
    ;;
    ;;2.1. FIND USERID, UNLESS USERID = "NO-BIO",
    ;;    LATER, ADD OUTCOME SCALES UNLESS "NO-BIO"
    (multiple-value-setq (user-shaqdata-list userid)
        ;;  (get-selected-values
        (get-qvarlist-in-shaqdatalist  "userid"))

    ;;2.2 NORMALLY, RUN THE BIO  QUESTIONS NEXT (put OUTCOME at end)
    ;;Don't run BIO, add to list to run later -- may confuse 
    (cond
     ((or (string-equal userid "NO-BIO") test-scale-list  run-qvar-list)
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
     (unless (or (string-equal userid "NO-BIO") test-scale-list run-qvar-list)
      (make-scales-frames '(OUTCOME) :scale-cat-list scale-cat-list))|#

    ;;2.5 RUN USER-FEEDBACK FRAME


    ;;DO THIS LAST to replace all other questions in selected-question-list
    ;;if run-qvar-list, then RUN ONLY THE QUESTS ON run-qvar-list
    ;;BBB MMM  In SHAQ-manager, call to make-scale-frames
   ;;(afout 'out (format nil "BB: IF run-qvar-list= ~A~%" run-qvar-list))
    (if run-qvar-list 
        (make-scale-frames  nil :run-qvar-list run-qvar-list)) ;; :scale-cat-list scale-cat-list

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

    ;;STEP 3:  CALC SCALE & SUBSCALE SCORES and ADD TO *SHAQ-DATA-LIST
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
#|(defun make-question-selection-list (matching-scales-lists &key (shaq-data-list *shaq-data-list))
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
  "In U-SHAQ-management--move??  1. Finds the results list for qvar in *shaq-data-list, 2. RETURNS (values selected-lists-with-cdr-match-list matched-items-list) (selected from matched items in matching-items-list--if supplied-otherwise, matched-items-list = nil.= matching-items-list eg= '((\"answer 1\" \"scale-name1\")...)."
  (let*
      ((qvar-list (get-qvarlist-in-shaqdatalist qvar))
       (answer-lists (nthcdr 5 qvar-list))
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
;;TEST (must run (select-shaq-scales) first to generate *shaq-data-list
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
     with qvar-list
     do
     (setf qvar-list (get-category-qvars category)
           selected-question-list qvar-list)
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
                                (data-list-name *cur-data-list) run-qvar-list)
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
     ;;if only use run-qvar-list, must not use scale
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
    ;;Append question-list if run-qvar-list
    (if run-qvar-list (setf question-list (append question-list run-qvar-list)))
    ;;(afout 'out (format nil "BBB question-list= ~A~% run-qvar-list= ~A%" question-list run-qvar-list))
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

       ;;2-MAKE Q-FRAME-INST -- It's selection-callback appends *shaq-data-list
       (setf  q-frame-inst (make-question-frame qvar  'scale-sym  
                                                :quest-num quest-num)) ;; :selection-type selection-type))
        
       ;;3-HOLD THIS FUNCTION'S PROCESSING UNTIL IT GETS POKED by callback
       ;;    let question hang for 1 hour without attention 
       (mp:current-process-pause 3600  'check-for-frame-visible)

       (cond
        ((member 'go-previous-frame *question-frame-results-list :test 'equal)
         ;;note, *shaq-data-list reset in the previous-frame-callback
         (setf  *question-frame-results-list (delete-list-items '(go-previous-frame) 
                                                                *question-frame-results-list))
         (if (> quest-num 1)(setf quest-num (- quest-num 1))
           (setf quest-num 1))
         ;;recurse at previous qvar
         (make-scale-frames scale :begin-quest-num quest-num
                            :data-list-name  data-list-name :run-qvar-list  run-qvar-list)

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
                                (data-list-name '*shaq-data-list) run-qvar-list)
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
     ;;if only use run-qvar-list, must not use scale
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
    ;;Append question-list if run-qvar-list
    (if run-qvar-list (setf question-list (append question-list run-qvar-list)))
    ;;(afout 'out (format nil "BBB question-list= ~A~% run-qvar-list= ~A%" question-list run-qvar-list))
    (loop
     ;;no for qvar  in question-list  ;;qvar = category for multi quests
     for quest-num from begin-quest-num to (list-length question-list)
     with cat-name 
     with qvar
     with q-frame-inst
     do
     ;;1-FIND QVAR
     (setf qvar (nth (- quest-num 1) question-list))
 
     ;;2-MAKE Q-FRAME-INST -- It's selection-callback appends *shaq-data-list
     (setf  q-frame-inst (make-question-frame qvar  'scale-sym  
                                               :quest-num quest-num)) ;; :selection-type selection-type))
     ;;3-HOLD THIS FUNCTION'S PROCESSING UNTIL IT GETS POKED by callback
     ;;    let question hang for 1 hour without attention 
     (mp:current-process-pause 3600  'check-for-frame-visible)

     (cond
      ((member 'go-previous-frame *question-frame-results-list :test 'equal)
       ;;note, *shaq-data-list reset in the previous-frame-callback
       (setf  *question-frame-results-list (delete-list-items '(go-previous-frame) 
                                                              *question-frame-results-list))
       (if (> quest-num 1)(setf quest-num (- quest-num 1))
         (setf quest-num 1))
       ;;recurse at previous qvar
       (make-scale-frames scale :begin-quest-num quest-num
                          :data-list-name  data-list-name :run-qvar-list  run-qvar-list)

      ;;NOTE: the recursive make-scale-frames MUST finish the rest of the qvars from previous frame, or will get redundant questions, so add RETURN here.
      (return)
       )
      (t nil))
     ;;end loop
     )
    ;;end let, make-scale-frames
    ))|#



