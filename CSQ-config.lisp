;;******************************** CSQ-config.lisp ***************


;;LOAD MY DATA?
;;FOR LOADING MY DATA FILE
(defparameter *selected-TOM-user-data  "C:/3-TS/LISP PROJECTS TS/CogSysOutputs/Tom-USE-AllData2019-10.lisp")


;;===> LATER, STRAIGHTEN OUT EVAL ORDERS OF PARAMS &  
;;APPEND-WHEN-BOUNDP-OR-LISTP
;;2020
;;ddd
(defun append-when-boundp-or-listp (list &key incl-symbols-p append-list-list-p)
  "CSQ-config [another copy in U-lists] Only appends items in list that are either a boundp symbol that evals to a list or is a listp itself. "
   (let*
       ((appended-list)
        (rejected-items)
        (evaled-symbol-result)
        )
  (loop
   for item in list
   do
   (cond
    ((listp item)
     (cond
      (append-list-list-p
       (setf appended-list (append appended-list (list item))))
      (t  (setf appended-list (append appended-list  item)))))
    ((and (symbolp item)(boundp item))
     (setf evaled-symbol-result (eval item))
     (cond 
      ((listp evaled-symbol-result)
       (cond
        (append-list-list-p
         (setf appended-list (append appended-list (list evaled-symbol-result))))
        (t  (setf appended-list (append appended-list evaled-symbol-result)))))
      (incl-symbols-p
       (cond
        (append-list-list-p
         (setf appended-list (append appended-list (list (list evaled-symbol-result)))))
        (t (setf appended-list (append appended-list (list evaled-symbol-result))))))    
      ;;end incl-symbols-p
      (t (setf rejected-items (append rejected-items `(,item))))))
    ;;end bound symbolp item
    (t (setf rejected-items (append rejected-items `(,item)))))
   ;;end loop
   )
   (values appended-list rejected-items)
   ;;end let, append-when-boundp-or-listp
   ))
;;TEST
;;SSSSSS START HERE FINISH, THEN LOAD ALL, FIX MOVE FUNCTION
;; (SETF LIST1 '(1 2 3) LIST2 '(4 5 6)  sym1 'not-list)
;; (append-when-boundp-or-listp '(list1 list3 list2 sym1 (a b c d) ))
;; works =(1 2 3 4 5 6 A B C D)   (LIST3 SYM1)
;; :INCL-SYMBOLS-P
;; (append-when-boundp-or-listp '(list1 list3 list2 sym1 (a b c d) ) :incl-symbols-p T)
;; works= (1 2 3 4 5 6 NOT-LIST A B C D)    (LIST3)
;; :append-list-list-p
;; (append-when-boundp-or-listp '(list1 list3 list2 sym1 (a b c d) ) :incl-symbols-p T :append-list-list-p T)
;; ((1 2 3) (4 5 6) (NOT-LIST) (A B C D))   (LIST3)


;;QUESTIONNAIRE TO RUN
(defparameter *run-CSQ-p  T "Useful in revised SHAQ functions to change input or processing that varies between questionnaires (SHAQ and CSQ). 2019 ADDED SHAQ qvars and questions to other CSQ lists")
(defparameter *run-only-CSQ-p  T "Useful in revised SHAQ functions to change input or processing that varies between questionnaires (SHAQ and CSQ).")
(defparameter *run-SHAQ-p  NIL  "Useful in revised SHAQ functions to change input or processing that varies between questionnaires (SHAQ and CSQ). LATER POSSIBLE TO RUN BOTH QUESTIONNAIRES?")
(defparameter *cur-data-list  '*csq-data-list )
 (when *run-SHAQ-p
   (setf *cur-data-list '*CSQ-DATA-LIST))
(defparameter *CSQ-elmsym-lists  '( :ELMSYM-LISTS) "For supplemental CSQ information (eg. needed to restart CSQ at any point.")
(defparameter *CSQ-pcxdata-list  '( :PCX-DATA) "For supplemental CSQ information (eg. needed to restart CSQ at any point.")
(defparameter *CS-EXPLORE-DATALIST NIL "Used for CS-EXPLORE related function outputs") 
(defparameter *cur-frame-namA-text  "Cognitive Systems Questionnaire (CSQ) QUESTIONS")
;; CSQ QVARS 
(defparameter  *cur-scale-instr-text "")
(defparameter *ALL-CSQ-QVARS  NIL "ALL CSQ and SHAQ qvars-set in CS-ART-init")
(defparameter *ALL-CSQ-QVARLIST-SYMS  '(*All-PC-element-qvars  *SHAQ-question-variable-lists *ALL-CS-EXPLORE-QVARS) " ALL CSQ and SHAQ qvars-LISTS.  MUST BE EVALUATED to get actual list.")
(defparameter *cur-qvarlists  '*ALL-CSQ-QVARS "Must eval later or caues problems")
(defparameter *cur-all-questions-sym  '*ALL-CSQ-Questions "Must eval later or caues problems.")
;;*ALL-CSQ-QUESTIONS
(defparameter *ALL-CSQ-QUESTIONS NIL   "All CSQ and SHAQ QUESTIONS combined list")  ;;do later (append-when-boundp-or-listp '( *All-PCE-elementQs *All-CS-exploreQs *all-SHAQ-questions))
(defparameter *ALL-CSQ-QUESTION-LIST-SYMS   '( *All-PCE-elementQs *All-CS-exploreQs *all-SHAQ-questions) "All CSQ and SHAQ QUESTION LISTS. MUST EVAL to get list of ALL CSQ QUESTIONS.")
(defparameter  *MK-Q-FRAME-MULTI-INPUT-RESULTS NIL "For make-question-frame :multi-input results outputs")

;;IF *RUN-CSQ-P CHANGE FOLLOWING VARIABLES
(when *run-csq-p 
  (setf *cur-frame-name-text "Cognitive Systems Questionnaire (CSQ) QUESTIONS"
        *cur-scale-instr-text "EXAMPLE>> Instructions: How IMPORTANT is this to you?"
        *cur-qvarlists '*ALL-CSQ-QUESTION-LIST-SYMS
        *cur-all-questions '*ALL-CSQ-QUESTION-LIST-SYMS))

(when *run-only-csq-p 
  (setf *cur-frame-name-text "Cognitive Systems Questionnaire (CSQ) QUESTIONS"
        *cur-scale-instr-text "EXAMPLE>> Instructions: How IMPORTANT is this to you?"
        *cur-qvarlists '*all-PC-element-qvars
        *cur-all-questions  *ALL-CSQ-QUESTION-LIST-SYMS ))



;;IF *RUN-SHAQ-P CHANGE FOLLOWING VARIABLES
(when *run-shaq-p 
  (setf *cur-frame-name-text "Success and Happiness Questionnaire (SHAQ) QUESTIONS"
        *cur-scale-instr-text "EXAMPLE>> Instructions: How IMPORTANT is this to you?"
        *cur-qvarlists *SHAQ-question-variable-lists
        *cur-all-questions *all-shaq-questions))


;;RUN OPTIONS
(defparameter *run-CSQ-intros-p NIL)
(defparameter *run-SHAQ-intros-p NIL)
(defparameter *test-scale-list '()) ;; '(ssl3WritingSkills)) ;;'(ACAD-LEARNING));; '(scollege)) ;; )
;;OK-LIST '(BIO NO-SCALE BELIEFS OUTCOME VALUES-THEMES SKILLS-CONFIDENCE INTERPERSONAL ACAD-LEARNING CAREER-INTEREST)) 
(defparameter *run-qvarlist NIL) ;; '(stmajgpa)) '(STURESID) ) ;;'(STURESOURCE)) ;; NIL ) ;;

  ;;Interface args
(defparameter  *initial-x 20)
(defparameter  *initial-y 0)
(defparameter *visible-border-p T)
(defparameter *fr-internal-border 20)
(defparameter  *external-border 20)
(defparameter *internal-border-width 25)
(defparameter *fr-visible-min-width  960) 
(defparameter *fr-visible-min-height 700)   ;; error :maximize)
(defparameter *fr-border-color :red)
(defparameter  *frame-title  "CSQ PART1: QUESTION")
(defparameter *CSQ-frame-title  " Cognitive Systems Questionnaire (CSQ) " "Used on some intro frames?")
(defparameter *text-input-frame-text-answers NIL "Used in Make-question-frame")

  ;;for multi-selection questions
;;(defparameter *default-multi-choice-title "MULTIPLE-SELECTION QUESTION"              "primary-title-text default text")
;;(defparameter  *default-multi-choice-instr "Select ALL that apply to you"     "primary-instr-text default text")
(defparameter  *current-multi-selection-qnum 0)
  ;;pane args
  ;;title-rich-text-pane
(defparameter *title-pane-height 70) ;;was 40)
(defparameter *title-pane-width nil)
(defparameter *title-text-left-margin-spaces 20)
(defparameter *title-pane-font-face nil)
(defparameter *title-pane-font-size 14)
(defparameter *title-pane-font-color  :red )
(defparameter *title-pane-background :LIGHTYELLOW )
;;(defparameter *title-pane-foreground  :LIGHTYELLOW )
(defparameter *title-area-text (format nil "Question scale description goes here."))
(defparameter *csq-intro-pane-text "*csq-intro-pane-text in csq-config")


  ;;title-pane fonts SSS CREATE  FONT DESCRIPTIONS HERE INSTEAD? 
#|(defparameter *title-pane-char-format '(:face "times new roman" :size 18
                                          :color :red :bold T :slant :roman  :underline nil ))
(defparameter *title-pane-parag-format   '(:alignment :center  ;; :left :right 
                                             :offset-indent 20 :tab-stops nil   ;;eg  (10 20 10)
                                             :numbering nil  ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                                             ;;  :start-indent 5
                                             ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                                             ))   |#
  ;;instr-rich-text-pane
(defparameter *instr-pane-height 90)
(defparameter *instr-pane-width nil)
(defparameter *instr-text-left-margin-spaces 7)
(defparameter *instr-text-width (- *fr-visible-min-width 40))
(defparameter *instr-pane-background :LIGHT-BLUE  )  
;;(defparameter *instr-pane-foreground  :LIGHT-BLUE  )  
(defparameter *instr-pane-font-face nil)
(defparameter *instr-pane-font-size 12)
(defparameter *instr-pane-font-color  :black )
(defparameter *instr-area-text (format nil "Question instructions text goes here."))

  ;;quest-rich-text-pane
(defparameter *quest-pane-height nil) ;;  460)
(defparameter *quest-pane-width 430)
(defparameter *quest-text-width (- *quest-pane-width 20))
(defparameter *quest-text-left-margin-spaces 0)
(defparameter *quest-pane-background  :LIGHT-BLUE)  
(defparameter *quest-pane-foreground  :LIGHT-BLUE)
(defparameter *quest-pane-font-face nil)
(defparameter *quest-pane-font-size 12)
(defparameter *quest-pane-font-weight nil) ;;or :bold 
(defparameter *quest-pane-font-color  :black )
(defparameter *quest-area-text (format nil "~%~%Question areas text goes here."))

  ;;answer-button-panel
(defparameter *answer-pane-height  *quest-pane-height)
(defparameter *answer-pane-width 470)
(defparameter *answer-pane-background  :yellow)  
(defparameter *answer-pane-foreground  :yellow)  
(defparameter *answer-pane-font-face nil)
(defparameter *answer-pane-font-size 11)
(defparameter *answer-pane-font-color :black)
(defparameter *answer-panel-y-gap 10)
(defparameter *answer-font-family nil) 
(defparameter *answer-font-size 11)
(defparameter *max-ans-text-line-length 66 "Max length of answer text line--leads to second line if longer and increased pane height")
(defparameter *button-text-pane-height 22  "Determines height of each button-text-item row")
  ;; (defparameter *answer-area-text (format nil "~%~%ANSWER areas text goes here."))

  ;;button-panel
(defparameter *button-panel-background :red)  
(defparameter *button-pane-height  40)
(defparameter *button-pane-width 940)
 ;; (defparameter *button-pane-font-size 14)
 ;; (defparameter *button-pane-font-color :black)
(defparameter *button-panel-visible-border nil)  ;; to keep from prob w/ red border?
  ;;to change color (setf (capi:simple-pane-foreground self) color))

  ;;buttons (types of panes) ;;yyy
  ;;go-frame-button
(defparameter  *go-frame-button-background :red)
(defparameter  *go-frame-button-foreground :green)  
(defparameter *go-frame-button-text "         GO to NEXT Question >>>       ")
(defparameter *go-frame-button-width  330)
(defparameter  *go-frame-button-height  30)
(defparameter  *go-frame-button-x nil)
(defparameter *go-frame-button-y  nil)
(defparameter *go-frame-button-font  (gp:make-font-description :family "times new roman" :size 14 :weight  :bold :slant :italic  :underline nil )) ;;:size  13 :color :black
(defparameter *help-font (gp:make-font-description :family "times new roman" :size 12 :weight  :bold)) ;; :slant :italic  :underline nil )
  ;; :family :weight :slant  :underline :strikeout :width  :orientation :charset :w-family
  ;;  (gp:make-font-description :size  13 );; :color :red  :weight :bold :face "times new roman":slant :roman  :underline nil))

  ;;previous-frame-button
(defparameter  *previous-frame-button-background :green)
(defparameter *previous-frame-button-text "   <<  GO to PREVIOUS Question    ")
(defparameter *previous-frame-button-width  180)
(defparameter  *previous-frame-button-height  20)
(defparameter  *previous-frame-button-x 50)
(defparameter *previous-frame-button-y  10)
(defparameter *previous-frame-button-font (gp:make-font-description :family "times new roman" :size 10 :weight  :bold :slant :roman  :underline nil ))
                       ;;     :size  11 :color :black  :bold T :underline nil ))

  ;;exit-CSQ-button
(defparameter  *exit-CSQ-button-background :red)
(defparameter *exit-CSQ-button-text " EXIT ALL of CSQ ")
(defparameter *exit-CSQ-button-width  100)
(defparameter  *exit-CSQ-button-height  30)
(defparameter  *exit-CSQ-button-x 120)
(defparameter *exit-CSQ-button-y  10)
(defparameter *exit-CSQ-button-font(gp:make-font-description :family "times new roman" :size 10 :weight  :bold :slant :roman  :underline nil )) ;;  :color 

;;NA-NONE-BUTTON
(defparameter *na-none-button-output  "NA-NONE" "Currently optionally used in text-input-OR-button-interface")

;;yyy
   ;;left-button-filler-pane
(defparameter *left-button-filler-pane-width 50)

;;FOR SHAQ CLASSES, SCALES, ETC
(defparameter  *COMPARE-3ELMS-P NIL "SET TO T FOR finding PC's. Answer Panel INSTRS used when finding/making PC's")
(defparameter *all-PCqvars NIL "This list of  pc qvar syms is created on the fly as users reveal PCs by make-pcqvar-quest function.")
(defparameter *all-PCQVAR-LISTs NIL "This list of pc qvar lists is created on the fly as users reveal PCs by make-pcqvar-quest function.")
(defparameter  *save-all-userdata-p  T "Appends *all-csq-user-data-lists with *csq-data-list  whenever initialization or reinitialization occurs (if exists) AND saves to file *save-all-userdata-p ")
(defparameter  *save-all-userdata-after-find-elms  T "Saves to file *save-all-userdata-p")
;;CSQ DATA PATHS
(defparameter  *csq-save-all-dirpath "C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\" "Used by save-csq-data-to-file")
(defparameter  *CSQ-CSYMS-DATA-PATH "C:/3-TS/LISP PROJECTS TS/CogSysOutputs/CSQ-CSYMS-DATA.lisp" "DATED--Main file for storing ALL USER DATA-incl ALL CSYMS (elms, pc w/vals, links, and SHAQ if available." )
(defparameter  *RAW-CSQ-DATA-PATH "C:/3-TS/LISP PROJECTS TS/CogSysOutputs/RAW-CSQ-DATA.lisp" "DATED--Main file for storing CSQ USER RAW DATA (elms, pc w/vals, links, NOT SHAQ DATA." )
(defparameter  *RAW-SHAQ-DATA-PATH "C:/3-TS/LISP PROJECTS TS/CogSysOutputs/RAW-SHAQ-DATA.lisp" "DATED--Main file for storing SHAQ USER RAW DATA ." )
(defparameter  *RAW-SHAQ-RESULTS-PATH "C:/3-TS/LISP PROJECTS TS/CogSysOutputs/RAW-SHAQ-RESULTS.lisp" "DATED--Main file for storing SHAQ USER RAW DATA ." )

;;GLOBAL DATA VARS
(defparameter *all-user-pcqvars  NIL "This list is appended when new *all-PCqvars are initialized, so will have an overall list of ALL PCSYMS-elements.")
(defparameter *default-is-pc-p T "In setcsymval *default-is-pc-p causes..FINISH")
;;(defparameter
;;(defparameter

;;DATA LISTS =========================
;;DATA FILES TO LOAD
(defparameter *SHAQ-PREVIOUS-DATA-FILE NIL "Optional previous SHAQ data file to load--selected in menu") 
(defparameter  *CSQ-PREVIOUS-DATA-FILE NIL "Optional previous CSQ data file to load--selected in menu")

;;FOR CSQ DATA SAVED IN FILES
(defparameter  *ALL-CSQ-DATAFILE-VARS  '(*FILE-ALL-PC-ELEMENT-QVARS *FILE-ALL-PCQVAR-LISTS *FILE-CSQ-DATA-LIST *FILE-ELMSYMS *FILE-ELMSYMVALS *FILE-PCSYMS *FILE-PCSYMVAL-LISTS) "All global vars that are set when read and eval csq saved data files")
(defparameter *FILE-ALL-PC-ELEMENT-QVARS NIL)
(defparameter  *FILE-ALL-PCQVAR-LISTS  NIL)
(defparameter  *FILE-CSQ-DATA-LIST  NIL)
(defparameter *FILE-ELMSYMS  NIL)
(defparameter *FILE-ELMSYMVALS NIL)
(defparameter *FILE-PCSYMS NIL)
(defparameter *FILE-PCSYMVAL-LISTS NIL)
(defparameter *file-all-csq-value-ranking-lists NIL)


;FOR THE TREEVIEW-FRAME
(defparameter *csq-treeview-data-lists 
  '(
#|    (:datasym  *file-all-pc-element-qvars :frame-args 
     (:expandp 2  :title "CSQ ALL-PC-ELEMENT-QVARS" :width 450))    
    (:datasym  *file-all-pcqvar-lists :frame-args 
     (:expandp 2  :title "CSQ ALL-PCQVAR-LISTS" :width 450))    |#
    (:datasym  *file-csq-data-list :frame-args 
     (:expandp 99  :title "CSQ-DATA-LIST-ARGS":width 500))    
    (:datasym  *file-elmsymvals :frame-args 
     (:expandp 99  :title "CSQ ELMSYMVALS":width 500))    
#|    (:datasym  *file-pcsyms :frame-args
     (:expandp 1  :title "CSQ PCSYMS":width 300 :group-by-valrating-p T :order-by-rank-p T))    ))   |# 
    (:datasym  *file-pcsymval-lists :frame-args 
     (:expandp 99  :title "CSQ PCSYMVAL-LISTS" :width 450 :group-by-val-p T :order-by-rank-p T))    
    (:datasym  *file-elmsyms :frame-args 
     (:expandp 1  :title "CSQ ELMSYMS" :width 300))    
    ))


;;=============== FROM SHAQ'S  CONFIG-VARS MODIFIED ==============
;; ********************* config-vars.lisp ************************
;;800.539.2219

;;GENERAL CSQ GLOBAL VARIABLES
;;
;;SELECTION OF CSQ PARTS
(defparameter *run-select-csq-parts-p T)
(defparameter *csq-begin-step NIL "Set in go-csq-choices-callback")
(defparameter *run-complete-csq-p NIL "Set in go-csq-choices-callback")
(defparameter *run-begin-with-find-pcs-p NIL "Set in go-csq-choices-callback")
(defparameter *run-begin-with-find-csvalues-p NIL "Set in go-csq-choices-callback")
(defparameter *run-only-write-elms-p NIL "Set in go-csq-choices-callback")          
(defparameter *run-only-find-pcs-p NIL "Set in go-csq-choices-callback")
(defparameter *run-only-find-csvalues-p NIL "Set in go-csq-choices-callback")
(defparameter  *run-begin-with-find-csvalranks-p NIL "Set in go-csq-choices-callback")
(defparameter  *run-begin-with-cs-explore-p NIL "Set in go-csq-choices-callback")
(defparameter  *run-shaq-only-p NIL "Set in go-csq-choices-callback")
(defparameter   *cs-explore-indepth-p NIL "Set in go-csq-choices-callback")
(defparameter  *run-begin-with-load&view-data "Set in go-csq-choices-callback")
(defparameter *begin-csq-manager-store-data-p "Set in go-csq-choices-callback")
(defparameter *begin-csq-manager-view-data-p "Set in go-csq-choices-callback")
;;(defparameter  *run-begin-with-find-last-p NIL)
;;
;;
;;MAIN DATA LISTS
;;general/overall main lists
(defparameter  *CSQ-DATA-LIST  NIL "SEE NOTES--REVISE data list of lists= (qvar :single q-text-sym q-num fr-answer-panel-sym num-answers  reversed-item-p scored-reverse-p ans-data-list) ans-data-list= (relval selected-item num-answers scored-reverse-p) or (mult-ans-list)REVISE THIS")
(defparameter  *SHAQ-ALL-DATA-LIST  NIL "All SHAQ data results retreived from file where all saved SHAQ data was stored")
;;more specific data related variables
(defparameter  *pcsyms (unless (boundp '*pcsyms) NIL) "All user pcsyms")
(defparameter  *all-csq-data-list-syms  '(*elmsyms *elmsymvals  *pcsyms  *pcsymval-lists  *csq-data-list *all-pc-element-qvars  *all-pcqvar-lists))
(defparameter  *all-user-csq-PCdata-lists  nil "For all users, appended whenever reinitilialized if *save-all-userdata-p and it exists.")
(defparameter  *all-user-csq-PCXdata-lists  nil "For all users, appended whenever reinitilialized if *save-all-userdata-p and it exists.")
(defparameter  *all-user-csq-elmdata-lists  nil "For all users, appended whenever reinitilialized if *save-all-userdata-p and it exists.")
(defparameter *cur-csq-data-list NIL "For use in callbacks")
(defparameter  *all-elmsyms NIL "Made in csq-initialize or by pc-poles-frames callback")
(defparameter  *elmsym-combos-sym  '*all-elmsym-compare-combos "Symbol set to list of all elmsym combos used in actual CSQ, may be a sample of possible combos")
(defparameter *all-elmsym-compare-combos  nil "Symbol set to all elmsym combos used for comparisons for discovering PCs")
(defparameter *pce-people-elmsyms NIL "Elmsyms in pce-people category, set below.")
(defparameter *pce-groups-elmsyms NIL "Elmsyms in pce-groups category, set below.")
(defparameter *pce-self-elmsyms NIL "Elmsyms in pce-self category, set below.")
(defparameter *n-people-combos NIL)
(defparameter *n-group-combos nil )
(defparameter *n-self-combos NIL)
(defparameter *all-elmsyms-comparisons nil "The list used to make the frames to generate pcsyms from comparing 3 elmsyms.")
(defparameter *reset-*all-elmsyms-p T "Causes making new list of *all-elmsyms-p during start-up in CSQ-manager.")
(defparameter *make-elmsyms-in-callback-p NIL "Make elmsyms after used in frames instead of at CSQ initialization. During initialization preferable?")
(defparameter  *n-elmsym-combos NIL "Set in CSQ-manager")
(defparameter  *cur-pc-compare-3elements NIL "Set in make-pc-poles-frames, used in its callback.")
(defparameter *randomize-elm-combos T "Randomize the lists of 3 elements (and therefore the frames) for finding underlying PCs.")
(defparameter *percent-of-test-elmsym-combos 20 "Percent of elmsym combos used in finding PCs. Also means only that percent of PCs will be produced.")

;;not used?(defparameter  *all-pcpoles-list NIL  "list of pcpoles lists (alike-pole-str unlike-pole-str 3elements-list)")
(defparameter *CSQ-scaledata-list '(:CSQ-scaledata-list) "REVISE--LIST VARS")
(defparameter *CSQ-intro-sym-list NIL "To be completed later")
;;(defparameter *CSQ-question-list IN FILE Q-questions.lisp
(defparameter *CSQ-post-sym-list NIL "To be completed later")
(defparameter *CSQ-scale-sym-list NIL "To be completed later")
(defparameter *CSQ-files-loaded NIL "Value changed after load-CSQ-files run")
(defparameter *CSQ-main-process nil "Main CSQ management-calc process runs in thread separate from CSQ frames.")
(defparameter *CSQ-run-questions-list "Main list of questions that CSQ creates frames for and runs to collect user data, started in select-CSQ-scales function.")

;;QUESTION SELECTION LISTS 
;; These are set by callbacks in intro frames etc.
(defparameter *run-select-CSQ-scales nil)
(defparameter *run-all-CSQ-scales nil)
(defparameter *run-all-except-career-scales-p nil)
(defparameter *run-HQ-scales-p nil)
(defparameter *run-only-academic-and-career-p  nil)
(defparameter *run-only-academic-p nil)
(defparameter *run-only-career-p nil)
(defparameter  *run-CSQ-student-quests-p  nil)
(defparameter  *run-values-beliefs-quests-p nil)
(defparameter  *run-life-skills-quests-p  nil)
(defparameter  *run-interpersonal-quests-p  nil)
(defparameter  *run-outcome-quests-p  nil)
(defparameter  *run-career-quests-p  nil)


;;FROM FRAME-QUEST-FUNCTIONS.LISP
(defparameter  *cur-pc-scale-cats  '(PC-PEOPLE)  "Current PC categories to use in the SC PC questionnaire")  ;;PC-GROUPS
(defparameter  *current-qvar nil "used to pass info to callbacks from CSQ-manager")
(defparameter   *cur-pcqvar-n 0 "Used within list for making new pc qvars")
(defparameter  *current-qvarlist nil "(qvar :single q-text-sym q-num fr-answer-panel-sym num-answers  reversed-item-p scored-reverse-p)")
(defparameter  *call-CSQ-question-single-callback-p nil "causes the make-my-vertical-button-panel callback function to call the CSQ append-my-vertical-button-panel-single-selection-callback")
(defparameter  *call-CSQ-question-multi-callback-p nil "causes the make-my-vertical-button-panel callback function to call the CSQ append-my-vertical-button-panel-multi-selection-callback")
;;moved to cs-config
;;(defparameter  *csvalkey :VA "Key for value ratings (eg 0 to 1.0)")
;;(defparameter *csval-rank-key :RNK  "Within a given pc value rating, the rank compared to other values with same rating")
(defparameter *pc-items-ratings-lists nil "For use in manage-value-rank-frames to make rank ratings within same value rating categories")
(defparameter  *all-grouped-csval-ranks nil "Ranks of csvals with same rating groups")

;;
(defparameter  *CSQ-initialized NIL "*CSQ-initialized is set to T when all files loaded by CSQ-initialize below:")
(defparameter  *cur-pc-compare-3elements NIL "List of 3 elements being compared in Frame-CSQ")



;;CSQ-REINIT  -- SSSS CHECK & REVISE??
;;
;;ddd
(defun CSQ-reinit (&key use-test-qvars-p (unbind-csq-vars-p T)
                        reload-userdata-file-p 
                        (userdata-pathname *DEFAULT-CSQ-USERDATA-PATH)
                   (save-all-userdata-p *save-all-userdata-p))
  "CSQ-config.  Used programatically to RESET ALL VARS & UNBIND ELM, PC, & USER-CREATED CSYMS, etc"
  ;;PCs for all users
  (append-all-user-datalists save-all-userdata-p)

  (when unbind-csq-vars-p
    (makunbound-csq-vars))
  ;;here88
  (csq-initialize :read-userdata-file-p reload-userdata-file-p
                  :userdata-pathname userdata-pathname
                  :use-test-qvars-p use-test-qvars-p
                  :if-elmsym-exists-reset-p T  :if-elmsym-exists-do-nothing-p NIL
                  :save-all-userdata-p save-all-userdata-p)
  ;;end CSQ-reinit
  )
;; (csq-reinit)



;;APPEND-ALL-USER-DATALISTS
;;
;;ddd
(defun append-all-user-datalists (&optional save-all-userdata-p)

  (when (and save-all-userdata-p *all-pcqvars)
    (setf *all-user-pcqvars (append *all-user-pcqvars (list *all-pcqvars))))
  (when (and save-all-userdata-p *csq-data-list )
    (setf *all-user-csq-pcdata-lists (append *all-user-csq-pcdata-lists
                                             (list *csq-data-list ))))
  (when (and save-all-userdata-p *csq-pcxdata-list)
    (setf *all-user-csq-pcxdata-lists (append *all-user-csq-pcxdata-lists
                                              (list *CSQ-pcxdata-list))))
  (when (and save-all-userdata-p *CSQ-elmsym-lists)
    (setf *all-user-csq-elmdata-lists (append *all-user-csq-elmdata-lists
                                              (list *CSQ-elmsym-lists))))
  )



;;TO JUST RESET THE ELMS CAN USE (reset-all-elmsl)


;;CSQ-INITIALIZE
;;
;;ddd
(defun CSQ-initialize ( &key use-test-qvars-p ;;*test-pc-element-qvars
                             read-userdata-file-p userdata-pathname
                             (if-elmsym-exists-reset-p T)  (unbind-csq-vars-p T)
                             if-elmsym-exists-do-nothing-p  (save-all-userdata-p T))
  "In CSQ-config If USE-TEST-QVARS-P, uses  *test-pc-element-qvars 
 =>DON'T USE IN DELIVER-- LOADED IN DELIVER FILE"
  ;;load files and defparameters -- SSS later move here?
  (let
      ((elmsyms)
       (type-list)
       (catsyms *All-PC-elmsym-global-cats)
       )
    ;;RELOAD KEY GLOBAL VARS, etc.
    (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CS-config.lisp")
    (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\csq-elmsym-sel-combos.lisp")
    (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-QVARS.lisp")

   ;;INTITIALIZE COMBINED GLOBAL VARS
   (unless *ALL-CSQ-QUESTIONS
     (setf *ALL-CSQ-QUESTIONS (append-when-boundp-or-listp '( *All-PCE-elementQs *All-CS-exploreQs *all-SHAQ-questions))))

   (unless *ALL-CSQ-QVARS
     (setf *ALL-CSQ-QVARS (append-when-boundp-or-listp '(*All-PC-element-qvars *ALL-CS-EXPLORE-QVARS *SHAQ-question-variable-lists ))))

   (when *INITIALIZE-CSYM-GLOBAL-VARS-P
     (set-vars-to-value NIL '(*ALL-CSYMS *ALL-CSYMS&VALS  
                                         *ALL-ELMSYMS  *ALL-ELMSYMS&VALS
                                         *ALL-PCSYMS *ALL-PCSYMS&VALS
                                         *ALL-CSARTLOC-SYMS *ALL-CSARTLOC-SYMS&VALS )))
;;csq-reinit-p
    ;; OVERIDES *all-PC-element-qvars set to ALL QVARS when loaded CSQ-QVARS.lisp
    (when use-test-qvars-p
      (setf *all-PC-element-qvars *test-pc-element-qvars))

  ;;SHOW-DETAILS?
  ;;used selectively for calling show-text to make containers
  (defparameter *show-details nil)
  (setf *cur-pc-compare-3elements NIL
        *cur-pcqvar-n 0)

  ;;SAVE PREVIOUS DATA?
  (append-all-user-datalists save-all-userdata-p)

  ;;MAKUNBOUND ALL PREVIOUS VARIABLES?
  (when unbind-csq-vars-p
    (makunbound-csq-vars))

  ;;INITIALIZE
  (init-main-csq-variables)

  ;;MAKE  ELMSYMS
  ;;Also sets eg *people-elmsyms to sublist of elmsyms
  (when (and (null *all-elmsyms) *make-elmsyms-in-CSQ-INIT-p)
    (loop
     for cat in *all-PC-element-qvars
     for catsym in catsyms
     do
    (multiple-value-setq (elmsyms  type-list)
        (make-elmsyms-from-qvars  (list cat) 
                                  ::if-exists-reset-p if-elmsym-exists-reset-p
                                  :if-exists-do-nothing-p if-elmsym-exists-do-nothing-p))

    (setf  *all-elmsyms (append *all-elmsyms elmsyms))
    ;;set catsyms to elmsyms
    (set catsym elmsyms)
    
    (when (and read-userdata-file-p userdata-pathname)
      (read-saved-csq-data userdata-pathname :set-csq-symbols-to-data-p T
                           :eval-objects-p T)
      (format T "==>> USER FILE DATA LOADED from: ~A " userdata-pathname)
      )
    ;;end loop, when
    ))

     ;;(BREAK "after make-elmsyms-from-qvars")

  ;;SETTINGS PATH
  ;;note: ~/ writes to C:\\USERS\\SHERRY BENE STEVENS
  (defparameter *settings-filename "~/CSQ-settings.db")
  (defparameter *results-filename "C:/CSQ-RESULTS.txt")
  ;;FOR CAPI
  ;;  (defparameter *visible-border-p nil)

  ;;FOR MP
  (setf *CSQ-initialized T)
  ;;END let, CSQ-INITIALIZE
  ))
;; TEST
;; (csq-initialize)
  ;;to change color (setf (capi:simple-pane-foreground self) color))



;;INIT-MAIN-CSQ-VARIABLES
;;
;;ddd
(defun init-main-csq-variables ()
  "In csq-config, initializes main csq variables"
  (setf *CSQ-elmsym-lists '( :ELMSYM-LISTS)
        *csq-data-list  '(:PCSYM-ELM-LISTS)  
        *CSQ-pcxdata-list '(:PCXDATA)
        *CSQ-scaledata-list '(:CSQ-SCALEDATA-LISTS)
        *all-pcqvars NIL
        *all-elmsyms NIL))



;;MAKUNBOUND-CSQ-VARS
;;
;;ddd
(defun makunbound-csq-vars (&key (all-csyms-p T)(all-csartloc-syms-p T)
                                 pcsyms-only-p elmsyms-only-p
                                 all-stored-csyms-only-p
                                 (global-var-syms 
                                  '((all-user-pcqvars  *all-user-pcqvars)
                                    (all-pcqvars *all-pcqvars)  
                                    (all-elmsyms *all-elmsyms)
                                    (all-csyms *all-csyms)
                                    (all-stored-csyms *all-stored-csyms)
                                    (all-csartloc-syms *all-csartloc-syms)))
                                 )
  "In CSQ-config, unbinds all pcsyms and/or elmsyms.  Default is all are made unbound.  Use key if want only one type." 
  (let
      ((varlist)
       )
    ;;1. Check to see if global vars are bound & set lists [sets to NIL if unbound]
    (loop
     for list in global-var-syms
     do
     (let*
         ((local-sym (car list))
          (global-sym (second list))
          (symvals (cond ((boundp global-sym) (eval global-sym))
                         (t nil)))
          )
       (set local-sym symvals)
       ;;end let,loop
       ))
    ;;2. FOR PC SYMS
    (when  (and (null elmsyms-only-p)(null all-stored-csyms-only-p)
                all-user-pcqvars (listp all-user-pcqvars))
      (loop
       for item in all-user-pcqvars
       do
       (cond
        ;;when all-user-pcqvars is list of all-user-pcqvars
        ((listp item)
         (setf varlist  (append varlist item)))
        (t (setf varist (append varlist (list item)))))
       ;;end loop, when
       ))
    ;;FOR ELMSYMS
     (when (and (null pcsyms-only-p)(null all-stored-csyms-only-p)
                all-elmsyms (listp all-elmsyms))
        (loop
         for elmsym in all-elmsyms
         do
         (setf varlist (append varlist (list elmsym)))
         ))
     ;;FOR STORED-CSYMS
     (when (and (null pcsyms-only-p) 
                all-stored-csyms (listp all-stored-csyms))
       (setf varlist (append varlist all-stored-csyms)))
     ;;FOR ALL-CSYMS
     (when all-csyms-p
       (setf varlist (append varlist all-csyms)))
     ;;FOR ALL-CSARTLOC-SYMS
     (when all-csartloc-syms-p
       (setf varlist (append varlist all-csartloc-syms)))

      ;;(break)
      ;;MAKUNBOUND-VARS
       (makunbound-vars  varlist  :convert-strings-p T) 
       varlist
    ;;end let, makunbound-csq-vars
    ))
;;TEST
;; (makunbound-csq-vars)
                                
