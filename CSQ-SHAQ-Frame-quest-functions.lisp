;;*****************  CSQ-SHAQ-Frame-quest-functions.lisp ****************
;;
;;FUNCTIONS FOR CREATING SHAQ QUESTION FRAMES
;;

;;put in all key files
  (my-config-editor-after-start)
                                 
;;(defparameter 

#|(setq buttons (capi:contain
               (make-instance
                'capi:radio-button-panel
                :title "Select a color:"
                :items '(:red :green :blue)
                :print-function 'string-capitalize
                :layout-class 'capi:column-layout)))|#
#|(THEMES
      ("thm1ach" "ta-Being the best" "spss-match" "thm1Ach" ("thm1Ach" "1" "thm1AchQ" "int" "Priority10" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "iLifeThemesAch.java"))
      ("thm3educ" "ta-Advanced degrees" "spss-match" "thm3Educ" ("thm3Educ" "3" "thm3EducQ" "int" "Priority10" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "iLifeThemesAch.java"))|#

#|(defparameter  Priority10AnswerArray    '(
                                            "The most important thing in my life" 
                                            "One of the most important things in my life" 
                                            "Extremely important"  "Very important" 
                                            "Moderately important"  "Mildly important" 
                                            "Not important, unsure, or neutral" 
                                            "Negative to me"  "Very negative to me" 
                                            "Extremely negative to me"))|#
#|(defparameter  Priority10   
    '(Priority10Instructions  10 
                              Priority10AnswerArray  Values10to1Array  "single"  "int"))|#
;;(defparameter Values10to1Array    '(10  9  8  7  6  5  4  3  2  1))



;;XXX =================== ADDED FOR CSQ =====================
;;
;; REPLACEMENT FOR MAKE-QUESTION-FRAME


;;MAKE-QUESTION-FRAME
;;
;;ddd
(defun make-question-frame (qvar-string main-scale-sym 
                                        &key (quest-num 1)  quest-frame (compare-3elms-p T)
                                        (all-qvar-lists  (eval *cur-qvar-lists))
                                        quest-info-list answer-panel label
                                        win-args 
                                        (csq-frame-pane1-title " Answer: ")
                                        (csq-frame-pane2-title " Answer: "))
  "In CSQ-SHAQ-Frame-quest-functions  Takes a qvar, gets a Q-VARLIST . Makes a frame and instance based upon that info. Determines the SELECTION-TYPE (:single-selection or :multiple-selection OR :question-function=> a function to run a special q-frame.).For CSQ, PCs, uses frame make-text-input-frame instead of regular SHAQ question frames. main-scale-sym not used. If QUEST-TEXT, then uses this instead of lookup qtext. Note: ANSWER-PANEL and  label used when no reqular qvar-list exists--eg as for pcsyms.) "
  ;;reset global variables
  (setf *qvar-category nil 
        *multi-selection-qvar-list nil)
  (let*
      ((qvar (my-make-symbol qvar-string))
       (selection-type) 
       (test-result)
       (qvar-list)
       (frame-name-text) 
       (spss-match ) (java-var) 
       (q-num)  ;;not needed (old-q-name ) (data-type) 
       ;;not needed (array) (frame-title) ( fr-width) (fr-height) (java-file)
       (q-text-sym)
       (qvar-name-list)
       (fr-answer-panel-sym)
       (fr-answer-panel-deflist)
       (instrs)(deflist-selection-type) (num-answers) (answer-array) (values)
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
       ;;  (scale-instr-text)
       (title-text) ;;for top-center title area
       (title-text-formated)
       (instruction-text) 
       (instr-text-formated)
       (question-text-list)
       (question-text-formated)
       (single-sel-test-list     (list 'single :single-selection "single""SINGLE" :single-input-frame "single-input-frame"))
       (multi-sel-test-list
        (list 'multiple 'multi "multiple" "MULTIPLE" :multiple-selection :multi-special-frame))
       ;;added 2018-08
       (single-input-test-list  (list  "single-input"  'single-input :single-input ))
       (multi-input-test-list (list  "multi-text"  :multi-text  'multi-text))
       ;;added bec warning
       (ans-values-list)
       (ans-text-list)
       (quest-data-list)     
       ;;for single-text selection type
       (text-input-box-instrs)
       (text-input1-box-text "Type answer below:")
       (text-input2-box-text "")
       ;;added for mbs--not all needed?
       (  spss-match)(  java-var)(  q-num)
       (q-text-sym)(  data-type)
       ;;not needed    (ans-xdata-list)
       (all-args)
       )
    ;; (afout 'out (format nil "BEGINNING MAKE-QUESTION-FRAME, for qvar= ~A~% "qvar ))
    (when compare-3elms-p
      (setf csq-frame-pane1-title *compare-pc-element-input-pane1-title
            csq-frame-pane2-title  *compare-pc-element-input-pane2-title))
    ;;GATHER THE INFO NEEDED TO MAKE THE QUESTION FRAME
    ;;get the SCALE/SUBSCALE INFO
    ;;BBB  in make-question-frame   (find-qvar-selection-type qvar))

    ;;STEP 1: FIND THE QVAR, QUESTION TEXT, ETC
    (cond
     ;;test to qvar not nil
     (qvar
      ;;find selection-type
      (cond
       (answer-panel
        (setf selection-type (fifth (eval answer-panel))))
       (t
        (multiple-value-setq (selection-type test-result qvar-list)
            (find-qvar-selection-type qvar :data-list all-qvar-lists))))
      ;;(afout 'out (format nil "IN MAKE-QUEST-FRAME, selection-type= ~A~%test-result= ~A~%qvar-list= ~A~% " selection-type test-result qvar-list))
      ;;test (find-qvar-selection-type 'stmajgpa)
      ;;test (find-qvar-selection-type 'family)
      ;;test (find-qvar-selection-type 'definition)
      ;;MMM in make-question-frame
      (setf  *current-qvar  qvar
             frame-name-text *cur-frame-name-text
             scale-instr-text *cur-scale-instr-text)
      ;;(BREAK "BEFORE selection-type")

      (cond
       ;;FOR SINGLE-SELECTION (and multi-text, because it is only one question call)
       ((member selection-type  (list :single-selection  :single-text
                                      ;;added 2018-08                                      
                                      :multi-text) :test 'equal)

        ;;find the QUESTION VARIABLE LIST and values for all items in it
        ;;(BREAK "before get-quest-var-values")
        (cond
         ;;added 2016-08
         ;;if provide answer-panel, skip below
         (answer-panel
          (setf label qvar)) ;;zzzz
         (t          
          (multiple-value-setq (label  spss-match  java-var  q-num  q-text-sym  data-type
                                       answer-panel )
              ;;not needed array  frame-title   fr-width  fr-height  java-file)
              (get-quest-var-values qvar :qvar-list qvar-list :return-values-p t 
                                    :all-qvar-lists all-qvar-lists))
          ))
        ;;(get-quest-var-values 'q :qvar-list nil  :return-values-p t :all-qvar-lists *all-pcqvars)

        ;;(BREAK "1 single-sel, get-quest-var-values")

        ;;replace q-num if quest-num key
        (if quest-num (setf q-num quest-num))     
        ;;reversed item??
        (multiple-value-setq (reversed-item-p item-norm-or-rev)
            (calc-is-quest-reversed qvar :answer-array answer-array))
        ;;(afout 'out (format nil "1 SINGLE-SEL CLAUSE:  label= ~A  spss-match= ~A  java-var= ~A~%  q-num= ~A  q-text-sym= ~A  data-type= ~A~%  answer-panel= ~A~%  array= ~A~%" label  spss-match  java-var  q-num  q-text-sym  data-type  answer-panel  array ))
 
        ;;SSS GET  QUESTION TEXT,  TITLE-TEXT,  INSTRUCTION-TEXT
        ;;   (if appropriate, get text-input-box-text)
 
        (cond
         ((null quest-info-list)
          (multiple-value-setq (q-text-sym question-text-list title-text
                                           instruction-text text-input-box-instrs)
              (get-question-text qvar))
          ;;(break "get-question-text")
          )
         (t  ;;added 2016
             (multiple-value-setq (q-text-sym question-text-list title-text
                                              instruction-text text-input-box-instrs)
                 (values-list quest-info-list))))

        ;;for text-input-box-instrs
        (cond
         ((null (listp text-input-box-instrs))
          (setf text-input1-box-text text-input-box-instrs))
         (t
          (setf text-input1-box-text (car text-input-box-instrs))
          (when (> (list-length text-input-box-instrs) 1)
            (setf text-input2-box-text (second text-input-box-instrs)))))

        (if (null question-text-list) (setf question-text-list ""))
        (if (null title-text) (setf title-text ""))
        (if (null instruction-text) (setf instruction-text ""))  
        (if (null text-input1-box-text) (setf text-input1-box-text ""))
        (if (null text-input2-box-text) (setf text-input2-box-text ""))
        ;;creates one string with newlines--CAN USE  :character-format A plist. AND :paragraph-format A plist. TO add lines betw paragraphs, etc.
        ;;END SINGLE-SELECTION TYPE
        )
       ;;FOR MULTIPLE-SELECTION
       ((equal selection-type :multiple-selection)
        ;;find the LIST OF QUESTION VARIABLE LISTS 
        ;;BBB  *multi-selection-qvar-list 
        (setf *qvar-category  qvar-string 
              *multi-selection-qvar-list 
              (get-multi-selection-quest-var-values qvar-string :qvar-list qvar-list ))
         ;;(afout 'out (format nil "*MULTI-SELECTION-QVAR-LIST= ~A~%" *multi-selection-qvar-list))
        (setf  q-text-sym (getf *multi-selection-qvar-list :primary-qvar-sym)
               qvar (my-make-symbol  (getf *multi-selection-qvar-list :primary-qvar-sym))
               label (getf *multi-selection-qvar-list :primary-qvar-label)
               ;; q-name (getf *multi-selection-qvar-list  :primary-qvar-sym
               title-text (getf *multi-selection-qvar-list :primary-title-text)
               instruction-text  (getf *multi-selection-qvar-list :primary-instr-text)
               question-text-list  (getf *multi-selection-qvar-list :quest-text-list)
               qvar-name-list  (getf *multi-selection-qvar-list    :ans-name-list)
               ans-text-list  (getf *multi-selection-qvar-list  :ans-text-list)
               quest-data-list  (getf *multi-selection-qvar-list :ans-data-list)
               num-answers  (getf *multi-selection-qvar-list  :num-answers)
               q-num quest-num
               ;;not needed     ans-xdata-list  (getf *multi-selection-qvar-list :ans-xdata-list)
               )
        ;;(break "multiple-selection vars ans-text-list quest-text-list instruction-text")
        (if  (null instruction-text) (setf instruction-text ""))
        (if (null question-text-list) (setf question-text-list '("")))
  
        ;;question number
        (if quest-num (setf pre-selected-num quest-num)
          (setf pre-selected-num (getf *multi-selection-qvar-list :qnum)))

        ;; HOW TO USE GET -- SEE SEIBEL
        ;;test (setf xx (list :a 1 :b 2))  (getf  xx :b)

        ;;for compatibility with vertical-buttons, single-selection, etc.REPLACE ABOVE?
        (setf ans-instruction-text "Select ALL that apply to you"
              answer-array-list ans-text-list
              ans-values-list  quest-data-list)
        ;;done above reversed-item-p nil) ;;was  scored-reverse nil) ;;why was this here?

        ;;(afout 'out (format nil "*multi-selection-qvar-list ~A~% answer-array-list= ~A~%" *multi-selection-qvar-list answer-array-list))

        ;;VARS ABOVE SHOULD INCLUDE/MATCH SINGLE-SELECTION VARS BELOW
        ;; (label  spss-match  java-var  q-num  q-text-sym  data-type  answer-panel  array  frame-title 
        ;;(q-text-sym question-text-list title-text instruction-text)            
        ;;note: *multi-selection-qvar-list = ( :qvar-category :primary-qvar-sym  :primary-qvar-label :primary-title-text :primary-instr-text :quest-text-list :q-spss-name :ans-name-list (SPSS VAR NAME each item) ans-text-list :num-answers  :primary-title-text :primary-instr-text :quest-text-list  :qnum  :data-type :ans-data-list  :primary-java-var :primary-spss-match :spss-match-list :java-var-list)      
        ;;from below also need (INSTRS num-answers ANSWER-ARRAY VALUES  selection-type data-type reversed-item-p scored-reverse-p pre-selected-num)      
        ;; (last '("bio4job" "b-Primary occupation" "spss-match" ("bio4job")("INSTRUCTIONS: Select ALL of the following best describe your primary OCCUPATION." "If you have multiple occupations, choose all of them.")  (  ) :MULTI-ITEM))
        ;;      (setf answer-array-list  ans-instruction-text ans-values-list 

        ;;end multiple-selection type
        )
       ;;FOR MULTI-SPECIAL-FRAME (calls special frames which already include all the info needed to display)
       ((equal selection-type :multi-special-frame)
        (setf special-frame-interface (ninth qvar-list))
        
        (capi:display (make-instance special-frame-interface))  ;;SS incl win-args here?
        ;;goal (capi:display (make-instance 'frame-family-info))      
        )
       ((equal selection-type :question-function)
        (eval (eval test-result))  
        ;; (afout 'out  "PAST EVAL TEST-RESULT")
        )    
       (t nil))
      ;;(format t "SELECTION-TYPE= ~A" selection-type)

      ;;STEP 2: MAKE THE TEXT TO FILL IN FOR GENERAL SINGLE and MULTIPLE-SELECTION FRAMES
      (unless (member selection-type '( :question-function :multi-special-frame ) :test 'equal)
        ;;FORMAT THE TITLE-TEXT, INSTR-TEXT, QUESTION-TEXT
        (setf  title-text-formated (format nil "~%~A" title-text)
               #| (format-string-list  (list title-text)
                                                    :add-top-lines 1 :add-newlines 1 :justify-type :left 
                                                    :line-width  (- *fr-visible-min-width 80)
                                                    :left-margin-spaces *title-text-left-margin-spaces)|#
               instr-text-formated  (format-string-list (list instruction-text)
                                                        :add-top-lines 1 :add-newlines 1 :justify-type :left 
                                                        :line-width  (- *fr-visible-min-width 80)
                                                        :left-margin-spaces *instr-text-left-margin-spaces)
               question-text-formated (format-question-text-list q-num question-text-list
                                                                 :add-top-lines 2 :add-newlines 1
                                                                 :justify-type :left
                                                                 :left-margin-spaces *quest-text-left-margin-spaces
                                                                 :line-width  *quest-text-width))
        ;;was   title-text (center-text title-text (- *fr-visible-min-width 80)))
        ;;(BREAK "BEFORE answer-panel")
        ;;GET THE FR-ANSWER-PANEL VARIABLES LIST (for single-selection only)
        (cond
         ;;IF NO ANSWER-PANEL, DO NOTHING
         ((null answer-panel) NIL)
         ;;IF ANSWER-PANEL 
         ((and label (member selection-type single-sel-test-list ) :test 'equal)
          (setf fr-answer-panel-sym (my-make-symbol answer-panel))
          (if  fr-answer-panel-sym
              (setf fr-answer-panel-deflist (eval fr-answer-panel-sym)))
          (if  fr-answer-panel-deflist
              (multiple-value-setq (INSTRS num-answers ANSWER-ARRAY VALUES 
                                           deflist-selection-type data-type reversed-item-p 
                                           scored-reverse-p pre-selected-num)
                  (get-answer-panel-keylist fr-answer-panel-deflist)))
          ;;(BREAK "After answer-panel")
          ;;(afout 'out (format nil "2 INSTRS= ~A~% num-answers= ~A~% ANSWER-ARRAY= ~A~% VALUES= ~A~% selection-type= ~A~% data-type= ~A~% reversed-item-p= ~A~% scored-reverse-p= ~A~% pre-selected-num= ~A~%" INSTRS num-answers ANSWER-ARRAY VALUES  selection-type data-type reversed-item-p scored-reverse-p pre-selected-num))
          ;; (get-answer-panel-keylist

          ;;Use above vars to get INSTRUCTIONS, ANSWERS, VALUES, etc
          (setf answer-array-list (eval answer-array)
                ans-instruction-text (eval instrs)
                ans-values-list (eval values))
          ;;not needed?    ans-num-items (list-length answer-array-list))
          ;;added 2014-10, reads answer-panel sym--if contains "reverse" sets
          ;;   it to REVERSE-SCORED if not reverse to nil.
          #|  DONE ABOVE        (if answer-panel
              (setf reversed-item-p (calc-is-quest-reversed qvar answer-panel)))|#

          ;;end single-selection
          )
         ;;MULTIPLE-SELECTION VARS ALL FOUND ABOVE
         (t nil))

        ;;(afout 'out (format nil "3 question-text-list= ~A~% answer-array-list= ~A~%ans-instruction-text= ~A~%ans-values-list= ~A~%title-text-formated= ~A~%instr-text-formated= ~A~%question-text-formated= ~A~%"question-text-list  answer-array-list ans-instruction-text ans-values-list title-text-formated instr-text-formated question-text-formated))


        ;;STEP 3: MAKE ANSWER-BUTTON-PANEL and QUEST FRAME INSTANCE
        (cond
         ;;FOR SINGLE-SELECTION FRAMES
         ((equal selection-type :single-selection) ;;was (member selection-type single-sel-test-list  :test 'equal)
          ;;(afout 'out (format nil "PASSED single-selection test"))
          (setf *call-shaq-question-single-callback-p T
                *single-selection-item T)

          ;; MUST COME BEFORE INSTANCE DEFINED BECAUSE OF :BEFORE METHOD
          (make-answer-button-panel  ans-instruction-text answer-array-list 
                                     ans-values-list
                                     'answer-button-layout 'frame-quest-single-R-interface)

          ;;2018 changed
          (cond
           (win-args
            (setf all-args (append (list  :title frame-name-text
                                          ;;SSS FIX THIS IF NOT GETTING Q-NUM IN *shaq-data-list
                                          :quest-num q-num)  ;;was pre-selected-num
                                   win-args)))
           (t (setf all-args (list  :title frame-name-text
                                    ;;SSS FIX THIS IF NOT GETTING Q-NUM IN *shaq-data-list
                                    :quest-num q-num))))  ;;was pre-selected-num
          ;;make q-frame-inst
          (setf  q-frame-inst 
                 (apply  'make-instance  'frame-quest-single-R-interface  all-args))
#|    old      (setf q-frame-inst (make-instance 'frame-quest-single-R-interface
                                            ;;args here
                                            :title frame-name-text
                                            ;;SSS FIX THIS IF NOT GETTING Q-NUM IN *shaq-data-list
                                            :quest-num q-num ;;was pre-selected-num  ))|#
    
          (capi:display q-frame-inst)
          ;;end single selection fill and display clause
          )

         ;;FOR MULTIPLE-SELECTION FRAMES
         ((equal selection-type :multiple-selection)
          ;;(afout 'out (format nil "FAILED single-selection test, selection-type= ~A~%" selection-type))
          (setf *call-shaq-question-multi-callback-p T
                *single-selection-item NIL)
          ;; (afout 'out (format nil "4 question-text-list= ~A~% answer-array-list= ~A~%ans-instruction-text= ~A~%ans-values-list= ~A~%title-text-formated= ~A~%instr-text-formated= ~A~%question-text-formated= ~A~%"question-text-list  answer-array-list ans-instruction-text ans-values-list title-text-formated instr-text-formated question-text-formated))

          ;;CHOICE OF FRAMES HERE 
          (cond 
           ((null quest-frame)
            (make-answer-button-panel  ans-instruction-text answer-array-list 
                                       ans-values-list
                                       'answer-button-layout 'frame-quest-multi-R-interface
                                       :selection-type 'multiple)
                      ;;2018 changed
          (cond
           (win-args
            (setf all-args (append (list :title frame-name-text
                                              :quest-num pre-selected-num) win-args)))
           (t (setf all-args (list :title frame-name-text
                                              :quest-num pre-selected-num))))
          ;;MAKE frame-quest-multi-R-interface => Q-FRAME-INST
          (setf  q-frame-inst 
                 (apply  'make-instance  'frame-quest-multi-R-interface  all-args))
          ;;end (null quest-frame)
          )
           ((equal quest-frame 'frame-csq) NIL)
           ;;was pre 2018-08  (setf selection-type :single-text)), selection-type set elsewhere
           ;;note: this is within the :multi-selection type clause
           ;; EG. CAN USE  'FRAME-TALL-QUEST-MULTI-R-INTERFACE
           (t
            (make-answer-button-panel  ans-instruction-text answer-array-list 
                                       ans-values-list
                                       'answer-button-layout quest-frame
                                       :selection-type 'multiple)

            ;;2018 changed
          (cond
           (win-args
            (setf all-args (append (list :title frame-name-text
                                              :quest-num pre-selected-num) win-args)))
           (t (setf all-args (list :title frame-name-text
                                              :quest-num pre-selected-num))))
          ;;make q-frame-inst
          (setf  q-frame-inst 
                 (apply  'make-instance  'quest-frame  all-args))
#| old    (setf q-frame-inst (make-instance quest-frame
                                              ;;args here
                                              :title frame-name-text
                                              :quest-num pre-selected-num ))))|#

          ;;NOTE--MUST display BEFORE apply-in-pane-process
          (capi:display q-frame-inst)
          ;;end t,cond and selection-type :multiple-selection
          )))
         ;;MULTI-TEXT (input) frames, just one function call for MANY SUBFRAMES
         ((equal selection-type :multi-text)
          (setf *call-CSQ-question-multi-callback-p T
                *multi-text-item T)

          ;; MUST COME BEFORE INSTANCE DEFINED BECAUSE OF :BEFORE METHOD
          (make-multi-text-box ans-instruction-text answer-array-list 
                               ans-values-list
                               'answer-button-layout 'frame-quest-single-R-interface)
          #|(make-answer-button-panel  ans-instruction-text answer-array-list 
                                    ans-values-list
                                    'answer-button-layout 'frame-quest-single-R-interface)|#
          (cond
           (win-args
            (setf all-args (append (list :title frame-name-text
                                              :quest-num q-num) win-args)))
           (t (setf all-args (list :title frame-name-text
                                              :quest-num q-num )))) ;;was pre-selected-num
          ;;make q-frame-inst
          (setf  q-frame-inst 
                 (apply  'make-instance  'frame-quest-single-R-interface  all-args))
#|  old        (setf q-frame-inst (make-instance 'frame-quest-single-R-interface
                                            ;;args here
                                            :title frame-name-text
                                            ;;SSS FIX THIS IF NOT GETTING Q-NUM IN *shaq-data-list
                                            :quest-num q-num ;;was pre-selected-num
                                            ))|#

          (capi:display q-frame-inst)
          ;;end equal :multi-text
          )
         ;;added 2018-08
         ;;SINGLE-INPUT-FRAME QUESTION
         ((equal selection-type :single-input-frame)
          (cond
           ((listp qlist)
            (setf question (car qlist))
            (unless title (setf title (second qlist)))
            )
           (t (setf question qlist 
                    title default-title)))
          ;;eval the function
              (make-text-input-or-button-interface-instance :instr-text question  :title title
                                                            :win-title "SINGLE INPUT WINDOW"
                                                            :win-border win-border
                                                            :win-background win-background
                                                            :close-interface-p close-interface-p 
                                                            :callback callback
                                                            :callback-type callback-type
                                                            :confirm-input-p confirm-input-p)
          ;;(break "after mvs")
          (mp:current-process-pause 100)
         ;;CALLBACK OUTPUT IS *text-input-OR-button-interface-textdata))
          ;;end :single-input
          )
         ;;SSSSS START HERE IN OLD MAKE-Q FRAME FOR NEW INPUTS
         ;;added 2018-08
         ;;MULTI-TEXT QUESTION (asks for each input answer in separate popup)
         ((equal selection-type :multi-text)
          (cond
           ((listp qlist)
            (setf question (car qlist))
            (unless title (setf title (second qlist)))
            )
           (t (setf question qlist 
                    title default-title)))
          (cond
           (win-args
            (setf all-args (append (list :default-title title 
                                      :confirm-input-p confirm-input-p) win-args)))
           (t (setf all-args (list :default-title title 
                                      :confirm-input-p confirm-input-p))))
            (apply 'make-multi-text-frames question all-args)
          ;;end :multi-text
          )
        (T NIL))
 
        (unless (equal selection-type :single-text)
          ;;ssss
          ;;moved  before apply-in-pane-process; didn't show text if display after apply.
          (capi:display q-frame-inst)

          ;;MODIFY THE Q-FRAME-INST CONTENTS
          (with-slots (title-rich-text-pane  instr-rich-text-pane 
                                             quest-rich-text-pane   
                                             go-frame-button previous-frame-button 
                                             button-row-layout 
                                             quest-ans-row-layout
                                             answer-button-layout
                                             quest-num  input-text-list
                                             )  q-frame-inst

            ;;STEP 4: USE APPLY-IN-PANE-PROCESS TO SET KEY  INFO
            ;;1-SET THE TITLE, INSTR, and QUESTION PANE TEXT
            (capi:apply-in-pane-process title-rich-text-pane
                                        #'(setf capi:rich-text-pane-text) title-text-formated  title-rich-text-pane )
            (capi:apply-in-pane-process instr-rich-text-pane
                                        #'(setf capi:rich-text-pane-text) instr-text-formated
                                        instr-rich-text-pane )
            (capi:apply-in-pane-process quest-rich-text-pane
                                        #'(setf capi:rich-text-pane-text) question-text-formated 
                                        quest-rich-text-pane )
            ;;    (afout (format nil "1 (capi:simple-pane-visible-height 'answer-button-layout)= ~A" (capi:simple-pane-visible-height answer-button-layout)))
            ;;model  (setf (capi:choice-selected-item answer-button-panel) nil)
            ;;set *current-qvar to qvar (above) and *current-qvar-list so can access to this info in callbacks
            ;;can I use CAPI:LAYOUT-DESCRIPTION NIL (CAPI:LAYOUT) instead??
            ;; *current-button-panel answer-button-panel
            ;;BBB -add label moved q-num before num-answers
            (setf  *current-qvar-list (list qvar-string :single q-text-sym label  fr-answer-panel-sym q-num num-answers  item-norm-or-rev nor-or-rev-scored))
            #|    was          *current-qvar-list (list qvar-string :single q-text-sym label  fr-answer-panel-sym q-num num-answers  reversed-item-p scored-reverse-p))|#      
            ;;  (afout (format nil "2 (capi:simple-pane-visible-height 'answer-button-layout)= ~A" (capi:simple-pane-visible-height 'answer-button-layout)))
            ;;end with-slots
            )
          ;;end unless selection-type :single-text
          )
        ;;end unless selection-type is :multi-special-frame  OR :question-function clause
        )
      ;;SSS IF SELECTION-TYPE =  :SINGLE-TEXT
      (when (equal selection-type :single-text)
        (setf *call-CSQ-question-single-callback-p T
              *single-text-item T
              *current-qvar-list (list qvar-string :single-text q-text-sym label 
                                       fr-answer-panel-sym 
                                       q-num num-answers  item-norm-or-rev  nor-or-rev-scored))

        ;;(BREAK "before make-text-input-frame")
        ;;MAKE-TEXT-INPUT-FRAME
        (make-text-input-frame title-text-formated instr-text-formated 
                               question-text-formated text-input1-box-text  
                               text-input2-box-text 'FRAME-CSQ
                               :pane1-title csq-frame-pane1-title 
                               :pane2-title csq-frame-pane2-title )  
        ;;(make-text-input-frame "Title" "Instrs"  "Question 1" "pane1-text" "pane2-text" 'frame-csq) = works
          
        ;;(BREAK "after make-text-input-frame")
        #|         (setf q-frame-inst (make-instance 'frame-quest-single-R-interface
                                           ;;args here
                                           :title frame-name-text
                                           ;;SS FIX THIS IF NOT GETTING Q-NUM IN *shaq-data-list
                                           :quest-num q-num ;;was pre-selected-num
                                           ))|#
        ;;end  (when (equal selection-type :single-text)
        )
      ;;end qvar not nil clause
      )
     (t nil))
     q-frame-inst  ;;was (values q-frame-inst output)
    ;;end make-question-frame
    ))
;;TEST
;; ;;  (make-question-frame "mother" 'scale-sym :quest-frame 'frame-csq)
;; WORKS
;;  *CSQ-DATA-LIST FOR "mother" only = (("mother" :SINGLE MOTHERQ "mother" NIL 1 NIL NORMAL-ITEM NIL ("mother" :SINGLE-TEXT NIL NIL 1 NIL ("mommy") NIL NIL NIL)))

;;SSSSS START TESTING make-question-frame FOR CS-EXPLORE
;;  (setf *cur-qvar-lists '*all-cs-explore-qvars *cur-all-questions  '*All-CS-exploreQs)
;; ;; ;;  (make-question-frame  "DEFINITION" 'scale-sym :quest-frame 'frame-csq :all-qvar-lists *all-cs-explore-qvars)

#|TEST MULTI-ITEM
 (make-question-frame "utype" nil :all-qvar-lists '((UTYPE ("utype" "UserType" NIL NIL (:TITLE ("SHAQ CARES:
 Selection of Your Questionnaires-Part 1") :QUEST ("  ==> FIND YOUR HAPPINESS QUOTIENT (HQ). 
         Research shows that 75% of people's overall happiness score is accounted for by the SHAQ HQ score (Stevens, 2009). Your HQ values, beliefs, and life skills may be powerful influences on your past, current, and future happiness. 
         HQ factors are CONTROLLABLE factors: you can choose to be happy by improving them. 
         ==> Why are you taking SHAQ?")) (:HELP NIL NIL) NIL :MULTI-ITEM) ("twanttho" "t-Want thorough assessment" "spss-match" NIL ("Want a thorough assessment and/or my Happiness Quotient (HQ) Score.") (:HELP NIL NIL) :MULTI-ITEM (:XDATA :SCALES (HQ))) ("tknowmor" "t-Want to know of self" "spss match" NIL ("Want to understand myself better.") (:HELP NIL NIL) NIL :MULTI-ITEM (:XDATA :SCALES (HQ))) ("twanthel" "t-Want help with problem" "spss match" NIL ("Want help with a general problem(s).") (:HELP NIL NIL) :MULTI-ITEM (:XDATA :SCALES (HQ))) ("twantspe" "t-Want specific help" "spss match" NIL ("Want help for specific problem(s).") (:HELP NIL NIL) :MULTI-ITEM (:XDATA :SCALES NIL)) ("texperie" "t-Experienced self-help user" "spss match" NIL ("Experienced self help user. ") (:HELP NIL NIL) :MULTI-ITEM (:XDATA :SCALES NIL)) ("tprevshaq" "t-Previous SHAQ user" NIL NIL ("Previous SHAQ user.") (:HELP NIL NIL) :MULTI-ITEM (:XDATA :SCALES (PREVIOUS-USER))) ("wantspq" "g-Specific questionnaire" "spss match" NIL ("I want to choose specific questionnaire(s).") (:HELP NIL NIL) :MULTI-ITEM (:XDATA :SCALES (SPECIFIC-QUESTS))) ("tu100stu" "t-CSULB U100 student" "spss match" NIL ("I'm a CSULB student completing UNIV 100 assignment") (:HELP NIL NIL) :MULTI-ITEM (:XDATA :SCALES (HQ ACAD-LEARNING))) ("tcsulbst" "t-CSULB other student" "spss match" NIL ("Other CSULB student.") (:HELP NIL NIL) :MULTI-ITEM (:XDATA :SCALES (ACAD-LEARNING))) ("tcolstu" "t-Other college student" "spss match" NIL ("Other college student. ") (:HELP NIL NIL) :MULTI-ITEM (:XDATA :SCALES (ACAD-LEARNING))) ("totherst" "t-Other student" "spss match" NIL ("Other type of student.") (:HELP NIL NIL) :MULTI-ITEM (:XDATA :SCALES (ACAD-LEARNING))) ("tressub" "t-SHAQ research subject" NIL NIL ("Subject  in a SHAQ research project.") (:HELP NIL NIL) :MULTI-ITEM (:XDATA :SCALES NIL)) ("tcolfaca" "t-College faculty-admin" "spss match" NIL ("College faculty member or administrator.") (:HELP NIL NIL) :MULTI-ITEM (:XDATA :SCALES NIL)) ("u-none" "t-none of above" NIL NIL ("Other or None of above.") (:HELP NIL NIL) :MULTI-ITEM (:XDATA :SCALES NIL))))))
 
|# 


;;xxx
;;===================== CSQ ONLY FRAMES ===================


;;MAKE-TEXT-INPUT-FRAME
;;
;;ddd
(defun make-text-input-frame ( title-text instr-text quest-text 
                                          pane1-text  pane2-text
                                          interface &key (pane1-title *compare-pc-element-input-pane1-title)
                                          (pane2-title *compare-pc-element-input-pane2-title))
  "In CSQ-SHAQ-Frame-quest-functions for using SHAQ frame format with 1 or more text-input-pane s instead of buttons for answers."
  (let
      ((interface-inst (make-instance interface))
       (incl-input-pane2-p T)
       )
    ;;reset global callback answer variable 
    (setf *text-input-frame-text-answers nil)

    ;;MUST DISPLAY BEFORE USE APPLY-IN-PANE-PROCESS
    (with-slots ( title-rich-text-pane instr-rich-text-pane quest-rich-text-pane 
                                       rich-text-pane-1 rich-text-pane-2 text-input-pane-1
                                       text-input-pane-2 
                                       go-button answer-button-layout 
                                       answer-column-layout 
                                       simple-pane-1 simple-pane-2) interface-inst    

      ;;PUT INTO LAYOUT (before capi:display)
      (when (or (null pane2-text) (string-equal pane2-text ""))
        (setf incl-input-pane2-p NIL))

      (cond
       (incl-input-pane2-p
        (setf (capi:layout-description  answer-column-layout) 
              (list rich-text-pane-1  text-input-pane-1 simple-pane-2  rich-text-pane-2  text-input-pane-2))) 
       (t (setf (capi:layout-description  answer-column-layout) 
                (list rich-text-pane-1  text-input-pane-1 simple-pane-2))))

      ;;for answer-button-layout
      (setf (capi:layout-description answer-button-layout)
            (list answer-column-layout))

      ;;DISPLAY MUST GO AFTER LAYOUT-DESCRIPTION,
      ;;  BUT BEFORE APPLY-IN-PANE-PROCESS
      (capi:display interface-inst)  
      ;;(after capi:display)

      ;;TO MODIFY TEXT PANES
      (when (stringp title-text)
        (capi:apply-in-pane-process title-rich-text-pane
                                    #'(setf capi:rich-text-pane-text) 
                                    title-text  title-rich-text-pane))
      (when (stringp instr-text)
        (capi:apply-in-pane-process instr-rich-text-pane
                                    #'(setf capi:rich-text-pane-text) 
                                    instr-text  instr-rich-text-pane))
      (when (stringp quest-text)
        (capi:apply-in-pane-process quest-rich-text-pane
                                    #'(setf capi:rich-text-pane-text) 
                                    quest-text  quest-rich-text-pane))

      (when (stringp pane1-text)
        (capi:apply-in-pane-process rich-text-pane-1
                                    #'(setf  capi:rich-text-pane-text) 
                                    pane1-text rich-text-pane-1) ) ;; title-rich-text-pane )

      (when incl-input-pane2-p       
        (capi:apply-in-pane-process rich-text-pane-2
                                    #'(setf capi:rich-text-pane-text) 
                                    pane2-text  rich-text-pane-2))

      (when (stringp pane1-title)
        (capi:apply-in-pane-process text-input-pane-1
                                    #'(setf capi:titled-object-title) 
                                    pane1-title  text-input-pane-1))
      ;;added 2018-08
      (when (stringp pane2-title)
        (capi:apply-in-pane-process text-input-pane-2
                                    #'(setf capi:titled-object-title) 
                                    pane2-title  text-input-pane-2))

      ;;set focus on text-input-pane-1
      ;;(capi:apply-in-pane-process rich-text-pane-1
      (capi:activate-pane text-input-pane-1)
      ;;didn't work (capi:set-pane-focus text-input-pane-1))
           
      ;;end inner with-slots
      )

    ;;end let, make-text-input-frame
    ))
;; (make-text-input-frame "TITLE" "INSTR TEXT" "QUEST TEXT" "PANE1-TEXT" NIL 'FRAME-CSQ :pane1-title "Test title")
;; works 2017-07
;  (make-text-input-frame "Title" "Instrs"  "Question 1" "pane1-text" "pane2-text" 'frame-csq) = works    
;; (make-text-input-frame "Title" "Instrs"  "Question 1" "pane1-text" NIL  'frame-csq) = works
;;
;; (make-text-input-frame "Title" "Instrs"  "Question 1" "pane1-text" NIL  'frame-csq  :pane1-title "pane1-title") = works
;; (make-text-input-frame "" "" "NO QUESTION TEXT" NIL NIL 'FRAME-CSQ  :pane1-title "NAME:") = works  (was ERROR: rich-text-pane no slot for initial-text bec text was NIL)





;;TEXT-GO-BUTTON-CALLBACK
;;used in frame-CSQ
;;
;;ddd
(defun text-go-button-callback (data interface)
  "In CSQ-SHAQ-Frame-quest-functions.lisp, Main single-selection callback, converts and records from the selection. NOTE: capi returns values 0 to (n - 1) in reverse order of my scheme. Therefore I use (- n (+ item-selected-data 1)) for normally scored items and (+ item-selected-data 1) for REV scored items. The integer scores are after these adjustments have been made. Appends *shaq-data-list with (list qvar-string :single relative-score adjusted-int-score  num-answers item-selected  item-selected-data nor-or-rev-scored RETURNS (values result simple-result) simple result = (qvar text-input1 text-input2)"
  (with-slots (text-input-pane-1 text-input-pane-2) interface  ;;was *current-button-panel
    (let*
        (
         ;;item-selected-list-name
         (text-input1 (capi:text-input-pane-text text-input-pane-1))
         (text-input2 (capi:text-input-pane-text text-input-pane-2)) 
         (qvar *current-qvar)
         (qvar-string (first *current-qvar-list))
         (q-type (second *current-qvar-list))
         (q-text-sym (third *current-qvar-list))
         (q-num (slot-value interface 'quest-num))  ;;was (fourth *current-qvar-list))
         ;;use global vars from 
         (text-answers)
         (item-data-list)
         (adjusted-int-score)
         (relative-score)
         (nor-or-rev-scored ) 
         (ans-data-list)
         (result)
         (simple-result)
         )
      ;;
      ;;(setf out1 (format nil "text-input1= ~A~% text-input2= ~A~%"  text-input1 text-input2))

      ;;yyy
      (cond
       ;;For text input
       ((> (length text-input1) 0)
        (cond
         ((> (length text-input2) 0)
          (setf num-answers 2
                text-answers (list text-input1 text-input2)))
         (t (setf num-answers 1
                  text-answers (list text-input1))))  
 
        ;;For external to callback checking
        (setf *no-text-input-frame-input-p NIL)


  ;;LEAVE UPDATING DATA-LISTS TO CALLING FUNCTIONS,
     ;; JUST       (setf *question-frame-results-list result 
     ;;                         *text-input-frame-text-answers text-answers) BELOW:

     ;;(format T "AFTER text-go-button-callback, ~% item-data-list= ~A" item-data-list)
      (setf *question-frame-results-list result ;;currently NIL
            *text-input-frame-text-answers text-answers)

      ;;END TEXT-INPUT LENGTH > 0
      )
       (t
        ;;For external to callback checking
        (setf *no-text-input-frame-input-p T)))

        ;;POKES SHAQ-process-manager running *shaq-main-process to continue (run next frame)
        (capi:destroy interface)
        (when *run-csq-p
          (mp:process-poke *csq-main-process))
        (when *run-shaq-p
          (mp:process-poke *shaq-main-process))   

      ;;end with-slots, let*, text-go-button-callback
      )))



;;MAKE-PC-POLES-FRAME
;;
;;ddd
(defun make-pc-poles-frame (title-text instr-text quest-text pane1-text pane2-text
                                       interface
                                          &key input-pane1-title  input-pane2-title text-pane3-text
                                          (incl-input-pane2-p T)(incl-ans-buttons-p T))
  "In CSQ-SHAQ-Frame-quest-functions for using SHAQ frame format with 1 or more text-input-pane s instead of buttons for answers."
  (let
     ((interface-inst (make-instance interface))
       )
    ;;reset global callback answer variable 
    (setf *text-input-frame-text-answers nil )


    ;;MUST DISPLAY BEFORE USE APPLY-IN-PANE-PROCESS
     (with-slots ( title-rich-text-pane instr-rich-text-pane quest-rich-text-pane 
                                        rich-text-pane-1 rich-text-pane-2 rich-text-pane-3
                                        text-input-pane-1 text-input-pane-2 
                                        go-frame-button answer-button-layout 
                                        answer-column-layout 
                                        simple-pane-1 simple-pane-3 simple-pane-4
                                        dif-button-panel ;;alike-button-panel  
                                        bestpole-button-panel
                                        ) interface-inst    

       ;;PUT INTO LAYOUT (before capi:display)
       (when (or (null pane2-text) (string-equal pane2-text ""))
         (setf incl-input-pane2-p NIL))

       (cond
        (incl-input-pane2-p
         (setf (capi:layout-description  answer-column-layout) 
               (list rich-text-pane-1  text-input-pane-1 ;;alike-button-panel 
                     :divider ;; simple-pane-3
                     rich-text-pane-2  text-input-pane-2 dif-button-panel 
                     :divider ;; simple-pane-4
                     rich-text-pane-3 bestpole-button-panel ))) 
        (t (setf (capi:layout-description  answer-column-layout) 
                 (list rich-text-pane-1  text-input-pane-1 simple-pane-2))))
       ;;simple-pane-3

       ;;for answer-button-layout
       (setf (capi:layout-description answer-button-layout)
             (list answer-column-layout))

       ;;DISPLAY MUST GO AFTER LAYOUT-DESCRIPTION,
       ;;  BUT BEFORE APPLY-IN-PANE-PROCESS
       (capi:display interface-inst)  ;;(after capi:display)

    ;;TO MODIFY TEXT PANES
       (capi:apply-in-pane-process title-rich-text-pane
                                   #'(setf capi:rich-text-pane-text) 
                                   title-text  title-rich-text-pane)
       (capi:apply-in-pane-process instr-rich-text-pane
                                   #'(setf capi:rich-text-pane-text) 
                                   instr-text  instr-rich-text-pane)
       (capi:apply-in-pane-process quest-rich-text-pane
                                   #'(setf capi:rich-text-pane-text) 
                                   quest-text  quest-rich-text-pane)

       (capi:apply-in-pane-process rich-text-pane-1
                                   #'(setf  capi:rich-text-pane-text) 
                                   pane1-text rich-text-pane-1) ;; title-rich-text-pane )

       (when incl-input-pane2-p       
         (capi:apply-in-pane-process rich-text-pane-2
                                     #'(setf capi:rich-text-pane-text) 
                                     pane2-text  rich-text-pane-2))

       (when input-pane1-title
         (capi:apply-in-pane-process text-input-pane-1
                                     #'(setf capi:titled-object-title) 
                                     input-pane1-title  text-input-pane-1))
         
       (when input-pane2-title text-input-pane-2
         (capi:apply-in-pane-process text-input-pane-2
                                     #'(setf capi:titled-object-title) 
                                     input-pane2-title  text-input-pane-2))

       (when text-pane3-text
         (capi:apply-in-pane-process rich-text-pane-3
                                     #'(setf capi:rich-text-pane-text) 
                                     text-pane3-text  rich-text-pane-3))

       (capi:apply-in-pane-process go-frame-button
                                   #'(setf  capi:callbacks-selection-callback) 
                                   'pc-poles-frame-callback   go-frame-button)

       ;;set focus on text-input-pane-1 (note: capi:activate-pane activates & sets focus)
       (capi:activate-pane text-input-pane-1)
           
       ;;end inner with-slots
       )

    ;;end let, make-pc-poles-frame
    ))
;;TEST
;; (make-pc-poles-frames '((mother father best-m-friend)))  ;;:interface 'frame-csq-1)






;;PC-POLES-FRAME-CALLBACK
;;
;;ddd
(defun pc-poles-frame-callback (data interface)
  "In CSQ-SHAQ-Frame-quest-functions.lisp, Main single-selection callback, converts and records data from the selection. NOTE: capi returns values 0 to (n - 1) in reverse order of my scheme. Therefore I use (- n (+ item-selected-data 1)) for normally scored items and (+ item-selected-data 1) for REV scored items. The integer scores are after these adjustments have been made. Appends *shaq-data-list with (list qvar-string :single relative-score adjusted-int-score  num-answers item-selected  item-selected-data nor-or-rev-scored RETURNS (values result simple-result) simple result = (qvar text-input1 text-input2)"

  (with-slots (text-input-pane-1 text-input-pane-2 dif-button-panel ;;alike-button-panel 
                       bestpole-button-panel) interface  ;;was *current-button-panel
    (let*
        (
         ;; (item-selected-name (capi:item-text item-selected))
         ;; (item-selected-data (my-make-symbol (capi:item-data item-selected)))
         (pole1 (capi:text-input-pane-text text-input-pane-1))
         (pole2 (capi:text-input-pane-text text-input-pane-2)) 
         (dif-button-selection (capi:choice-selected-items dif-button-panel)) 
         (alike-button-selections) ;;calc below
         (bestpole)
         ;;(capi:collection-data-function alike-button-panel))
         (bestpole-button-sel (capi:choice-selected-item bestpole-button-panel))
         (3elmsyms  *cur-pc-compare-3elements) ;;set in make-pc-poles-frames
         ;;(qvar *current-qvar)
         ;;(qvar-string (first *current-qvar-list))
         ;;(q-type (second *current-qvar-list))
         ;;(q-text-sym (third *current-qvar-list))
         (q-num (slot-value interface 'quest-num))  ;;was (fourth *current-qvar-list))
         ;; (answer-panel-sym (fifth *current-qvar-list))
         ;; (num-answers (sixth  *current-qvar-list))
         ;; (item-norm-or-rev (eighth *current-qvar-list))
         ;; (nor-or-rev-scored (ninth *current-qvar-list))
         ;; (reversed-item-p (calc-is-quest-reversed answer-panel-sym)) ;;was(eighth *current-qvar-list))
         ;;(scored-reverse-p) ;;was (ninth *current-qvar-list))
         ;;   (item-selected  (capi:choice-selection answer-button-panel))
         ;;use global vars from 
         ;;(text-answers)
         (pcsym)
         (pcname)
         (quest-name "quest-name") ;;not sure if needed, not used right now
         (pcsymvals)
         (elmsyms)
         (3elmsymvals)
         (pole1-alike-elms) 
         (pole2-dif-elms)
         (pc-bipaths)
         (elm-bipaths)
         (cur-csq-data-list)
         (dif-elm-num)
         (alike-elm-nums)

         ;;(item-data-list)
         ;;(adjusted-int-score)
         ;;(relative-score)
         ;;(nor-or-rev-scored ) 
         ;;(ans-data-list)
         ;;(result)
         ;;(simple-result)
         )

      ;;PRE-PROCESSING
      ;;FOR BESTPOLE
      (cond
       ((string-equal bestpole-button-sel (car *bestpole-button-items))
        (setf  bestpole 1))
       ((string-equal bestpole-button-sel (second *bestpole-button-items))
        (setf  bestpole 2))
       ((string-equal bestpole-button-sel (third *bestpole-button-items))
        (setf  bestpole 0))
       (t nil))

      ;;FOR ALIKE AND DIF ELEMENTS
      (multiple-value-setq (alike-button-selections  dif-elm-num alike-elm-nums)
          (nonselected&selected-buttons dif-button-selection
                                        *element-button-items))
       
      ;;FOR BUTTON INPUT (SSS LATER ADD ERROR CHECKING?)
      (cond
       ((and alike-button-selections dif-button-selection)

        ;;MAKE PC and ELEMENTS SYMS for this PC -----------------

        ;;MAKE PCSYM
        (multiple-value-setq (pcsymvals pcsym)
            (make-pc  pole1 pole2 bestpole  nil :bipaths pc-bipaths )) 
        (setf pcname (format nil "~A" pcsym))

        ;;MAKE ELMSYMS (USUALLY made at startup) ;;NOT USED?
        (cond
         (*make-elmsyms-in-callback-p
          (multiple-value-setq (3elmsyms  3elmsymvals)
              (make-elmsyms elm-bipaths  :if-exists-simple-reset-p T
                      :if-exists-do-nothing-p T )))
         ;;otherwise just add the bipaths
         (t 
          elm-bipaths
          ))
        ;;(break "After bipaths on elmsyms")

         ;;FIND-PCPOLE-ELM-LINKS
        (multiple-value-setq(pole1-alike-elms  pole2-dif-elms pc-bipaths elm-bipaths)
            (find-pcpole-elm-links pcsym 3elmsyms
                                     alike-button-selections  dif-button-selection))
        ;;(break "after FIND-PCPOLE-ELM-LINKS")

        ;;ADD THE PC-ELEMENT LINKS IN BOTH PCs AND ELEMENTS 
        ;;       AFTER THEY ARE CREATED SO USE RIGHT CSYMS
        ;;add all elmsyms to pcsym
        (add-pcs-to-elm-bipaths elm-bipaths)

        ;;add pcsym path to all elmsyms 
        (set pcsym (append-key-value-in-list :bipaths  pc-bipaths pcsymvals))
      

        ;;APPEND NEW PC-QVAR TO *all-PCqvars
        (incf *cur-pcqvar-n)
        (setf  *all-PCqvars (append *all-PCqvars (list pcname))
                  *all-PCqvar-lists (append  *all-PCqvar-lists           
                  (list (list  pcname  (format nil "~A vs ~A" pole1 pole2) nil pcname 
                         (list pcname  (format nil "~A" *cur-pcqvar-n)  'PCSYM-VALQ
                               "int" "Priority12" nil 12 nil nil)))))
;;eg ( "thm1ach"  "ta-Being the best"  "spss-match"  "thm1Ach"  ("thm1Ach" "1" "thm1AchQ" "int" "Priority10" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "iLifeThemesAch.java")  (:help nil nil)  )
;; add to let quest-name

        ;; (BREAK "after append *all-PCqvars")
        ;;end clause (and alike-button-selections dif-button-selection
      
      ;;(setf ans-data-list (list qvar-string :single-text  nil nil  num-answers nil  text-answers nil nil q-num))

      ;;*current-qvar-list = (qvar :single q-text-sym q-num fr-answer-panel-sym num-answers  reversed-item-p scored-reverse-p)
      ;;(setf item-data-list (append *current-qvar-list (list ans-data-list)))

      ;;APPENDS (PCSYM  3ELMSYMS TO *csq-data-list
      ;;SSSS START HERE PROBLEM NOT RIGHT LIST AFTER KEY--EITHER LIST OF LISTS OR SEPARATE LISTS--NOT JUST APPEND FIRST LIST
;; I ADDED LIST (LIST cur-csq-data-list) NOT JUST cur-csq-data-list
      (setf  cur-csq-data-list (append *cur-csq-data-list (list pcsym 3elmsyms)))
      ;;was       (unless (listp (car cur-csq-data-list))  WHY UNLESS LISTP?
      ;;(unless (listp (car cur-csq-data-list))
        ;;was (setf cur-csq-data-list (list cur-csq-data-list) ;;not needed after fixed append
        (setf  *csq-data-list  (append-key-value-in-list
          :pcsym-elm-lists  cur-csq-data-list  '*csq-data-list  ;;MUST QUOTE
              :append-value-p T :list-first-item-in-append-p T))
            ;;) ;;was cur-csq-data-list)))
      ;;(BREAK "after append-key-value-in-list in callback")
;; (append-key-value-in-list  :pcsym-elm-lists  '(KIND6 (MOTHER FATHER BEST-M-FRIEND))  '*csq-data-list :append-value-p T :list-first-item-in-append-p T ) = (:PCSYM-ELM-LISTS ((KIND6 (MOTHER FATHER BEST-M-FRIEND))))
;; UND6 = ("UND6" "und vs nund" CS2-1-1-99 NIL NIL :PC ("und" "nund" 1 NIL) :POLE1 "und" :POLE2 "nund" :BESTPOLE 1 :BIPATHS (((POLE1 NIL BEST-F-FRIEND NIL) (POLE1 NIL FATHER NIL) (POLE2 NIL MOTHER NIL))))

      ;;(setf result item-data-list)  
      ;;(setf  *csq-data-list (append *csq-data-list (list qvar nil result)))
      ;;end t, cond      
      ;;(afout 'out (format nil "AFTER text-go-button-callback, ~% item-data-list= ~A" item-data-list))
    ;;(format T "AFTER text-go-button-callback, ~% item-data-list= ~A" item-data-list)
   ;; (setf *question-frame-results-list result
    ;;      *text-input-frame-text-answers text-answers)
    ;;(BREAK "In callback")
    ;;POKES SHAQ-process-manager running *shaq-main-process to continue (run next frame)
        (capi:destroy interface)
        (mp:process-poke  *csq-main-process)
        )
       (t (break "PROBLEM IN CALLBACK")))
     (values pcsym 3elmsyms)
    ;;end with-slots, let*, pc-poles-frame-callback
    )))
;;TEST
;; To test callback,  ;; (make-pc-poles-frames '((mother father best-m-friend)))
;;RESULTS=
#|CL-USER 55 > *csq-data-list  
((BLACK1 (MOTHER FATHER BEST-M-FRIEND)) (RED3 (MOTHER FATHER BEST-M-FRIEND)) (BLUE5 (MOTHER FATHER BEST-M-FRIEND)) (SMART (MOTHER FATHER BEST-M-FRIEND)))
CL-USER 56 > SMART
("SMART" "smart vs dumb" CS1-1-1-1 NIL NIL :PC ("smart" "dumb" 1 NIL) :POLE1 "smart" :POLE2 "dumb" :BESTPOLE 1 (:BIPATHS ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL))))
CL-USER 57 > MOTHER
("MOTHER" "mother" ELM2-1-1-99 NIL NIL :BIPATHS (((MOTHER NIL (SMART (POLE1) NIL)))))
CL-USER 58 > BEST-M-FRIEND
("BEST-M-FRIEND" "best-m-friend" ELM4-1-1-99 NIL NIL :BIPATHS (((BEST-M-FRIEND NIL (SMART (POLE1) NIL)))))
CL-USER 59 > FATHER
("FATHER" "father" ELM3-1-1-99 NIL NIL :BIPATHS (((FATHER NIL (SMART (POLE2) NIL)))))|#








;;MAKE-PC-RATE-VALUE-FRAMES
;;
;;ddd
(defun make-pc-rate-value-frames (data-list) ;; &key testing-p)
  "In CSQ-SHAQ-Frame-quest-functions . eg. data-list= ((pc1 (elm1 elm2 elm3)) ...)"
;;eg *csq-data-list = (:PCSYM-ELM-LISTS ((KIND (MOTHER FATHER BEST-M-FRIEND)) (FEM (MOTHER BEST-M-FRIEND BEST-F-FRIEND)) (UNDERS (MOTHER BEST-F-FRIEND FATHER))))
  (let*
      ((pc-list)
       (frame-inst)
       (pcqvar)
       (pcqvarlist)
       (pcsymvals)
       (pc-str)
       (quest-info-list)
       (pole1)
       (pole2)
       (bestpole)
       (pcsyms-list (get-key-value :PCSYM-ELM-LISTS  data-list))
       (csval-rating)
       )
    ;;USE THE PCSYMS-LIST TO RATE VALUE OF EACH PC
    (loop
     for pc-datalist-item in pcsyms-list
     ;; eg pc-datalist-item = (KIND (MOTHER FATHER BEST-M-FRIEND))
     do
     (when (and pc-datalist-item (listp pc-datalist-item))
       ;;(BREAK "before make-pc-rate-value-frame")

       ;;MAKE Q-FRAME-INST -- It's selection-callback appends *csq-data-list   
       (make-pc-rate-value-frame  pc-datalist-item)

       ;;(BREAK "BEFORE mp:current-process-pause in make-pc-rate-value-frames")

       ;;HOLD THIS FUNCTION'S PROCESSING UNTIL IT GETS POKED by callback; except testing ONLY this function outside of CSQ-Manager
      ;; (cond
        ;;(testing-p  (sleep 6))
       ;; let question hang for 1 hour without attention 
        ;;(t 
         (mp:current-process-pause 3600  'check-for-frame-visible)
         ;;))

         ;;GET THE DATA (done in single-  -callback => *question-frame-results-list
         ;;eg *question-frame-results-list = (UNDERST1 UNDERST1 :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12)
         ;;(get-set-append-delete-keyvalue-in-nested-list   0.85 '(( "KIND1")(:csval)) *CSQ-DATA-LIST :append-value-p nil  ) = (:CSVAL 0.85)   (:PCSYM-ELM-LISTS ((KIND1 (MOTHER FATHER BEST-M-FRIEND))) :CSVAL 0.85)
  ;;FIX ABOVE APPEND SHOULD PUT NEW ITEM INSIDE KEYLIST = (:PCSYM-ELM-LISTS ((KIND1 (MOTHER FATHER BEST-M-FRIEND) :CSVAL 0.85)))
;; USE THIS INSTEAD??
;; (get-set-append-delete-keyvalue-in-nested-list  '(:CSVAL 0.85) '(( "KIND1")) *CSQ-DATA-LIST :append-value-p NIL :ADD-VALUE-P T  )
;; =   ("KIND1" (MOTHER FATHER BEST-M-FRIEND) (:CSVAL 0.85))     (:PCSYM-ELM-LISTS ((KIND1 (MOTHER FATHER BEST-M-FRIEND) (:CSVAL 0.85))))
;; ABOVE MEANS ALL KEYLISTS WILL BE ADDED AS LISTS NOT KEY VALUE = EXTRA LAYER OF LISTS. 
;; OR INITIALLY CREATE TEMPLATES WITH ALL KEYS INCLUDED EXACTLY WHERE WANT THEM WHEN CREATE A NEW ITEM.

        ;;(break "*question-frame-results-list")
         (when *question-frame-results-list
           ;;SSS WHICH IS THE STRING, WHICH SYMBOL?
           (setf pc-sym (car *question-frame-results-list)
                 pc-name (format nil "~A" pc-sym)
                 csval-rating (fifth *question-frame-results-list))                 

           ;;APPEND PCSYM LIST 
           ;;(cond
           ;; ((and (boundp pc-sym)(listp pc-sym))
            (set-symkeyval pc-sym  *csval-key   csval-rating)
                ;;(` *csval-key csval-rating :keyloc-n T:old-keylist (eval pc-sym)))
           ;; (t (set pc-sym (list pc-sym *csval-key csval-rating))))

           ;;NO--ONLY PCSYMS--MODIFY DATA-LIST
#|          (multiple-value-bind (newkeylist new-datalist)
               (get-set-append-delete-keyvalue-in-nested-list :get 
                                                              (list (list pc-name T))
                                                              data-list)|#
#|                                                              :add-value-p T :append-value-p nil
                                                              :key-in-prev-keylist-p T
                                                              :if-not-found-append-key-value-p NIL)|#

;;("NICE" "NICE vs NNICE" CS2-1-1-99 NIL NIL :PC ("NICE" "NNICE" 1 NIL) :POLE1 "NICE" :POLE2 "NNICE" :BESTPOLE 1 :BIPATHS ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL FATHER NIL)) :CSVAL "0.917" :CSRANK "1")
;; *quest-- (HON HON :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12)

           ;;SET MODIFIED LISTS (data-list is unchanged)
           (setf  *pc-items-ratings-lists (append *pc-items-ratings-lists 
                                                 (list (list pc-sym csval-rating)))
                 *question-frame-results-list nil)

           ;;(BREAK "PC-SYM MODIFIED")
           ;;end when
           )
       ;;(BREAK "after mp:current-process-pause in make-pc-rate-value-frames")     
       ;;end outer when, loop
       ))
    ;;end let, make-pc-rate-value-frames
    ))
;;TEST
;; (make-pc-rate-value-frames *csq-data-list)
;;  (make-pc-rate-value-frames *csq-data-list :testing-p T)
;; WORKS, output append *CSQ-DATA-LIST
;; eg. *CSQ-DATA-LIST = ((MILD (ROLE-MODEL CHILD-FRIEND TEACHER)) (MILD "MILD vs NOT MILD" :SINGLE "The most important (positive) thing in my life" "0.121" 12 1 99 12 SCORED-NORMAL PRIORITY12))






;;MAKE-PC-RATE-VALUE-FRAME
;;
;;ddd
(defun make-pc-rate-value-frame (pc-datalist-item)
  "In CSQ-SHAQ-Frame-quest-functions . eg. pc-datalist-item= (KIND (MOTHER FATHER BEST-M-FRIEND)) "
  (let*
      ((pc-list)
       (frame-inst)
       (pcqvar)
       (pcqvarlist)
       (pcsymvals)
       (pcqvar-str (car pc-datalist-item))
       (quest-text)
       (quest-info-list)
       (pole1)
       (pole2)
       (bestpole)
       ;;not needed (pcsyms-list (get-key-value :PCSYM-ELM-LISTS  pc-datalist-item))
       ) ;;here now 3

       ;;1-FIND PCQVAR     
       (cond
        ((stringp pcqvar-str)
         (setf pcqvar (my-make-symbol pcqvar-str)))
        (t (setf pcqvar pcqvar-str
                 pcqvar-str (format nil "~A" pcqvar-str))))

      ;;(break "pcqvar")
       (setf pcqvarlist    (eval pcqvar)  
             bestpole (get-key-value :bestpole pcqvarlist)
             pole1 (get-key-value :pole1 pcqvarlist)
             pole2 (get-key-value :pole2 pcqvarlist))

      ;;(BREAK "check bestpole")

       ;;2-MAKE QUEST TEXT FROM POLES
       (cond
        ((or (= bestpole 1)(= bestpole 3))
         (setf quest-text (format nil "~A versus ~A" pole1 pole2)))
        (t (setf quest-text (format nil "~A versus ~A" pole2 pole1))))
                                   
       ;;(get-qvar-list pcqvar :all-qvar-lists *all-pcqvars)
           
       ;;(break "setf pcqvar")
       #|     (make-scale-frames scale (begin-quest-num 1)
                                (data-list-name *cur-data-list)  run-qvar-list)
   OR USE make-question-frame
  eg. ( "thm1ach"  "ta-Being the best"  "spss-match"  "thm1Ach"  ("thm1Ach" "1" "thm1AchQ" "int" "Priority10" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "iLifeThemesAch.java")  (:help nil nil)  )  |#

       ;; 3-MAKE INSTR TEXT LIST 
       ;;Eg. from CSQ elements Qs: (M-DISLIKEQ ("A male you very strongly dislike") PCE-PEOPLE-INSTR *input-box-instrs) 
       (setf quest-info-list (list pcqvar (list quest-text)
                                   *Rate-pc-title    *Instr-rate-value ))

       ;;(break "before make-question-frame called")
#|       (multiple-value-bind (label  spss-match  java-var  qnum  q-name  data-type  answer-panel  array  frame-title   fr-width  fr-height  java-file help-info  help-links)|#
     ;;4-MAKE Q-FRAME-INST -- It's selection-callback appends *csq-data-list    
     (setf frame-inst
           (make-question-frame pcqvar nil
                                :all-qvar-lists  *all-pcqvar-lists
                                :answer-panel 'Priority12
                                :quest-frame  'frame-quest-single-R-interface
                                :quest-info-list  quest-info-list
                                :answer-panel priority12))

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
       )
      (t nil))

    ;;end let, make-pc-rate-value-frame
    ))
;;TEST
;; SSSS START HERE -- PROBLEM WITH answer-panel, not using qvar list TRIED TO FIX IT IN MAKE-QUESTION-FRAME--THO SHOULD WORK W PRIORITY12 BELOW
;; START TESTING HERE
;;  (make-pc-rate-value-frame '(A4 (MOTHER FATHER BEST-M-FRIEND (A4 "a vs nota" :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))))




;;MAKE-ELMENT-RATE-VALUE-FRAMES
;;
;;ddd
(defun make-elment-rate-value-frames (&key (elmsyms *elmsyms))
  "In CSQ-SHAQ-Frame-quest-functions . )"
  (let*
      ((frame-inst)
       (elmqvar)
       ;;(elmqvarlist)
       (elmsymvals)
       )

    (loop
     for elmsym in elmsyms
     do
       ;;MAKE Q-FRAME-INST -- It's selection-callback appends *csq-data-list   
       (make-elment-rate-value-frame  elmsym)

       ;;(BREAK "BEFORE mp:current-process-pause in make-elm-rate-value-frames")

       ;;HOLD THIS FUNCTION'S PROCESSING UNTIL IT GETS POKED by callback
       ;;    let question hang for 1 hour without attention 
       (mp:current-process-pause 3600  'check-for-frame-visible)

       ;;(BREAK "after mp:current-process-pause in make-elm-rate-value-frames")
     
       ;;end  loop
       )

    ;;NOW POKE TO MOVE TO NEXT STEP
    (mp:process-poke *csq-main-process)
    ;;(BREAK "POKED? INmake-elment-rate-value-frames")

    ;;end let, make-elment-rate-value-frames
    ))
;;TEST
;; (make-elment-rate-value-frames) 




;;MAKE-ELMENT-RATE-VALUE-FRAME
;;
;;ddd
(defun make-elment-rate-value-frame (elmqvar    
                                     &key (elmsyms-list *elmsymvals))
  "In CSQ-SHAQ-Frame-quest-functions.  eg. elm-datalist-item=  "
  (let*
      ((elm-list)
       (frame-inst)
       ;;(elmqvarlist)
       (elmsymvals)
       (elm-str)
       (name)
       (quest-text)
       (quest-info-list)
       )

       ;;1-FIND ELMQVAR    
       (when (stringp elmqvar)
         (setf elmqvar (my-make-symbol elmqvar)))

       ;;FIND THE NAME (given name or user-provided name?)
       (setf elmqvarlist   (eval elmqvar)
             elm-str (car elmqvarlist)
             elm-val (fifth elmqvarlist))
       (cond
        (elm-val
         (setf name elm-val))
        (t (setf name elm-str)))

       ;;2-MAKE QUEST TEXT 
       ;;SSSS MODIFY FOR ELMS  & USE PRIORITY11 FOR Questions etc
       (setf quest-text   (format nil "=>  ~A" name))
                                   
       ;; 3-MAKE INSTR TEXT LIST 
       ;;Eg. from CSQ elements Qs: (M-DISLIKEQ ("A male you very strongly dislike") PCE-PEOPLE-INSTR *input-box-instrs) 
       (setf quest-info-list (list elmqvar (list quest-text)
                                   *Rate-elm-title    *Instr-rate-elm-value ))

       ;;(break "before make-question-frame called")
     ;;4-MAKE Q-FRAME-INST -- It's selection-callback appends *csq-data-list    
     (setf frame-inst
           (make-question-frame elmqvar nil
                                :all-qvar-lists  *all-PC-element-qvars
                                :quest-frame  'frame-quest-single-R-interface
                                :answer-panel 'Priority11
                                :quest-info-list  quest-info-list))
     (break "after setf frame-inst")
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
       )
      (t nil))

    ;;end let, make-elment-rate-value-frame
    ))
;;TEST zzzz
;;  (make-elment-rate-value-frame 'MOTHER)





;;FIND-QUEST-SELECTION-TYPE
;;
;;ddd
(defun find-qvar-selection-type (qvar &key (return-qvar-list T) 
                                      (data-list (eval *cur-qvar-lists)) non-nested-datalist-p)
  ;;was *SHAQ-question-variable-lists
  "In CSQ-SHAQ-Frame-quest-functions, RETURNS (values selection-type test-result qvar-list), selection-type is either :SINGLE-SELECTION , :MULTIPLE-SELECTION, or :MULTI-SPECIAL-FRAME. test result is either the selection-type  or NIL if no qvar-list found.  IF QVAR calls for a special function to run it, then it should return :QUESTION-FUNCTION as type and the function call quoted as its test-result. IF selection-type is  :MULTI-SPECIAL-FUNCTION, test-result is the symbol for the special frame interface. NOTE: In multi sel qvars returns entire list of all answers ."
  (when (not (listp (second (car data-list))))
    (setf non-nested-datalist-p T))

  (let*
      ((qvar-list (get-qvar-list qvar :not-nested-p non-nested-datalist-p)) ;;for multi-selection, ONLY GETS FIRST PART OF LIST
       ;;(get-qvar-list "ugoals") (get-qvar-list "movie-star")
       (selection-type)
       (test-result)
       )
    ;;(afout 'out (format nil "IN find-qvar-selection-type, qvar-list= ~A~%" qvar-list))
    (cond
     ((> (list-length qvar-list) 7)
      (setf selection-type (eighth  qvar-list))
      (cond
       ((equal selection-type :multi-item) 
        (setf selection-type :multiple-selection
              test-result :multiple-selection))
       ;;kkkk     ;;added 2014-11:multi-special-frame
       ((equal selection-type  :multi-special-frame)
        (setf selection-type :multi-special-frame
              test-result (ninth qvar-list)))           
       ((setf test-result (member :question-function qvar-list :test 'equal))
        (setf test-result (ninth qvar-list)
              selection-type :question-function))
       (t nil))
      ;;end list-length > 7 clause
      )
     ;;added for CSQ
     ((> (list-length qvar-list) 2)
      (cond
       ((string-equal (third qvar-list) "single-text")
        (setf selection-type :single-text
              test-result :text))
       ((string-equal (third qvar-list) "text-input")
        (setf selection-type :single-text-input
              test-result :text))   
       ((string-equal (third qvar-list) "multi-text")
        (setf selection-type :multi-text
              test-result :text))   
#|       ((string-equal (third qvar-list) "multi-text-frame")
        (setf selection-type :multi-text-frame
              test-result :text))   |#
       #|       ((string-equal (third qvar-list) "")
        (setf selection-type :single-text-input
              test-result :text))    |#      
       #|     ((and (> (list-length qvar-list) 2)
           (string-equal (third qvar) "single-text"))
      (setf selection-type :single-text
            test-result :list))|#
       ))
     ;;end added for CSQ
     (T
      (setf selection-type :single-selection
            test-result :single-selection)))
    ;;to return the full multi-selection list -- returns NIL for single-selection
    (if (member selection-type '(:multiple-selection :question-function) :test 'equal)
        (setf qvar-list (get-key-list qvar data-list)))
    ;;works (get-key-list 'ugoals *SHAQ-question-variable-lists)
    ;;(afout 'out (format nil "SELECTION-TYPE= ~A~%" selection-type))
    (values selection-type test-result qvar-list)
    ;;end let, find-qvar-selection-type
    ))
;; (get-qvar-list 'bio7lang)
;; (get-qvar-list 'ugoals)
;;TEST
;;  (find-qvar-selection-type 'bio7lang)
;;  (find-qvar-selection-type 'stmajgpa) = :SINGLE-SELECTION   :SINGLE-SELECTION    ("stmajgpa" "st-Major GPA" "spss-match" NIL ("stuMajorGPA" 10 "stumajorgpaq" "int" GPA8ANSARRAY "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "StudentBasicData.java") (:HELP NA NA))
;;  (find-qvar-selection-type 'STURESOURCE)
;;  (find-qvar-selection-type 'DEFINITION)
;;   (find-qvar-selection-type 'family) =  :QUESTION-FUNCTION   (QUOTE (RUN-FRAME-FAMILY-INFO))    (FAMILY ("family" "famConstellation" NIL NIL NIL (HELP NA NA) NIL :QUESTION-FUNCTION (QUOTE (RUN-FRAME-FAMILY-INFO))) ("OlderBrN" "NumOlderBros" NIL NIL (:HELP NA NA)) ("OlderSisN" "NumOlderSis" NIL NIL (:HELP NA NA)) ("YoungBrN" "NumYoungrBros" NIL NIL (:HELP NA NA)) ("YoungSisN" "NumYoungrSis" NIL NIL (:HELP NA NA)) ("Raised2Parents" "Raised by 2 Parents" NIL NIL (:HELP NA NA)) ("SingleMparent" "RaisedBySingleMale" NIL NIL (:HELP NA NA)) ("SingleFparent" "RaisedBySingleFemale" NIL NIL (:HELP NA NA)) ("RaisedNoParents" "RaisedByNoParents" NIL NIL (:HELP NA NA)) ("RaisedOther" "RaisedOther" NIL NIL (:HELP NA NA)))
;;    ;;test (find-qvar-selection-type 'bio7lang)
;;  (find-qvar-selection-type "bio1ethn")
;; (find-qvar-selection-type 'bio4job):MULTIPLE-SELECTION :MULTIPLE-SELECTION     (BIO4JOB ("bio4job" "b-Primary occupation" "spss-match" ("bio4job") (:QUEST ("Select ALL of the following that best describe your primary OCCUPATION." "If you have multiple occupations, choose all of them.") :TITLE ("YOUR OCCUPATION")) (:HELP NA NA) NIL :MULTI-ITEM) ("student" "1-Student" "spss-match" ("Student") NIL (:HELP NA NA) :MULTI-ITEM) ("manager" "2-Manager" "spss-match" ("Manager/executive") NIL (:HELP NA NA) :MULTI-ITEM) ("propeop" "3-People professional" "spss-match" NIL NIL (:HELP NA NA) :MULTI-ITEM) ("protech" "4-Technical professional" "spss-match" ("Technician") NIL (:HELP NA NA) :MULTI-ITEM) ("consulta" "5-Consultant" NIL ("Consultant") NIL (:HELP NA NA) :MULTI-ITEM) ("educator" "6-Educator" "spss-match" ("Educator") NIL (:HELP NA NA) :MULTI-ITEM) ("sales" "7-Sales" "spss-match" ("Sales") NIL (:HELP NA NA) :MULTI-ITEM) ("technici" "8-Other technical" "spss-match" ("Technician") NIL (:HELP NA NA) :MULTI-ITEM) ("clerical" "9-Clerical" "spss-match" ("Clerical") NIL (:HELP NA NA) :MULTI-ITEM) ("service" "10-Service" "spss-match" ("Service") NIL (:HELP NA NA) :MULTI-ITEM) ("ownbus10" "11-Own business" "spss-match" ("Own business +10 employees") NIL (:HELP NA NA) :MULTI-ITEM) ("othrsfem" "12-other occupation" "spss-match" (("Other self-employed")) ("other" "13-Other" "spss-match" ("Other")) (:HELP NA NA) ("bio5inco" "b-Highest personal income" "spss-match" ("bio5income")) NIL :MULTI-ITEM))
;; (find-qvar-selection-type "rangdest") =  :SINGLE-SELECTION  :SINGLE-SELECTION PLUS THE QVAR-LIST
;;(setf test-multiX (get-qvar-list 'bio4job))  =  ("bio4job" "b-Primary occupation" "spss-match" ("bio4job") (:QUEST ("Select ALL of the following that best describe your primary OCCUPATION." "If you have multiple occupations, choose all of them.") :TITLE ("YOUR OCCUPATION")) (:HELP NA NA) NIL :MULTI-ITEM)     "bio4job"
;; STUCOLLE  "lrnwrpap" "rangdest"
;; (setf test-singleX (get-qvar-list  'lrnwrpap))  =  ("lrnwrpap" "la-A's on term papers" "spss-match" "lrnWRITEskills" ("lrnWRITEskills" "4" "lrnWRITEskillsQ" "int" "LikeMe7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "bsLearningAreas.java") (:HELP NA NA))   "lrnwrpap"
;;
;;Find the selection-type
;; (member :multi-item test-singleX :test 'equal) = nil
;;  (member :multi-item test-multiX :test 'equal) = (:MULTI-ITEM)









;;APPENDED-MY-VERTICAL-BUTTON-PANEL-CALLBACK
;;
;;ddd
(defun append-my-vertical-button-panel-single-selection-callback (item-selected  interface)
  "In CSQ-SHAQ-Frame-quest-functions. Appends the callback built into make-my-vertical-button-panel in U-capi-buttons-etc.lisp.  WAS  In Frame-quest-functions.lisp, Main single-selection callback, converts and records data from the selection. NOTE: capi returns values 0 to (n - 1) in reverse order of my scheme. Therefore I use (- n (+ item-selected-data 1)) for normally scored items and (+ item-selected-data 1) for REV scored items. The integer scores are after these adjustments have been made. Appends *shaq-data-list with (list qvar-string :single selected-text relative-score adjusted-int-score  num-answers item-selected  selected-data nor-or-rev-scored)"
  (with-slots (selected-item-datalist) interface  ;;was *current-button-panel
    ;;selected-item-datalist = (list selected-text selected-data selected-n[begins with 1]  selected-button-instance last-button-on-top-p)
    (multiple-value-bind (selected-text selected-data 
                                      selected-n selected-button-instance  last-button-on-top-p)  
        (values-list selected-item-datalist)

    (let*
        ((reverse-the-score-p) ;;if needed later set this to a real outside variable such as last-button-on-top-p.   scored-reverse-p below is from questions that already are using ans-value-arrays that have reverse scores already built in.
      ;;    (item-selected-name (capi:item-text item-selected))
      ;;    (item-selected-data (my-make-symbol (capi:item-data item-selected)))
;;eg:  *current-qvar-list = (list qvar-string :single q-text-sym label  fr-answer-panel-sym q-num num-answers  reversed-item-p scored-reverse-p))
        ;;BBB first, second, etc in *current-qvar-list in append-my-vertical-button-panel-single-selection-callback
         (qvar *current-qvar)
         (qvar-string (first *current-qvar-list))
         (q-type (second *current-qvar-list))
         (q-text-sym (third *current-qvar-list))
         (q-label (fourth *current-qvar-list))
         (q-num (slot-value interface 'quest-num))   ;;was (fourth *current-qvar-list))
         (answer-panel-sym (fifth *current-qvar-list))
         (num-answers (seventh  *current-qvar-list))
         ;;yyyy
         (item-norm-or-rev (eighth *current-qvar-list))
         (nor-or-rev-scored (ninth *current-qvar-list))
         (reversed-item-p) ;;was(eighth *current-qvar-list))
         (scored-reverse-p) ;;was (ninth *current-qvar-list))
      ;;   (item-selected  (capi:choice-selection answer-button-panel))
      ;;use global vars from 
         (item-data-list)
         (adjusted-int-score)
         (relative-score)
         (nor-or-rev-scored ) 
         (ans-data-list)
         (result)
         )
      (when (equal item-norm-or-rev 'REVERSED-ITEM)
        (setf reversed-item-p  'REVERSED-ITEM))
      (when (equal nor-or-rev-scored 'SCORED-REVERSE)
        (setf scored-reverse-p 'SCORED-REVERSE))
 ;; (setf out1 (format nil "selected-text= ~A~% selected-data= ~A~%"selected-text selected-data))
      ;;yyy
      (cond
       ;;item-selected NOT NIL from being reset 
       (item-selected
        (cond
         ((equal q-type :single) 
          (cond
           ((numberp selected-data)
            (cond
             ;;NOTE: APPARENTLY ALL scored-reverse-p ITEMS USE ANS-VALUES-ARRAYS THAT ARE ALREADY IN REVERSE ORDER, SO NO ADJUSTMENT IS NEEDED HERE. FOR scored-reverse-p.  HOWEVER, I INCLUDED A NEW VARIABLE REVERSE-THE-SCORE-P IN CASE IT IS LATER NEEDED.
             ((null reverse-the-score-p)
              (setf adjusted-int-score (+ selected-data)))                 
             (t (setf adjusted-int-score (- num-answers selected-data))))

            ;;is it scored normal or reverse? Info for the user and data collection only
           (cond 
            ((null REVERSED-ITEM-P)
             (setf  nor-or-rev-scored 'scored-normal))
            (t (setf nor-or-rev-scored 'scored-reverse)))

          ;;calc the relative-score
          (setf relative-score (/  adjusted-int-score  (* 1.0 num-answers)))

          ;;SSS use a different converter than format or $??
          (setf relative-score  (format nil "~3$" relative-score))
          ;;end numberp
          )
          (t (format T "ANSWER DATA IS NOT A NUMBER= ~A" selected-data)))

          ;;IN ANY CASE, MAKE/APPEND THE DATA LISTS
          ;;BBB MMM  (setf ans-data-list (list qvar-string :single  selected-text relative-score  IN append-my-vertical-button-panel-single-selection-callback
          (setf ans-data-list (list qvar-string q-label :single  selected-text relative-score adjusted-int-score q-num num-answers  ;;replaced with q-label item-selected  
                                    selected-data nor-or-rev-scored answer-panel-sym))

          ;;(BREAK "in vertical callback after setf ans-data-list")
          (when *run-CSQ-p
            (setf item-data-list  ans-data-list 
                  *csq-data-list  (append-key-value-in-list
                                   qvar-string ;;was pc-name ;;was :pc-values
                                  item-data-list  *csq-data-list)
                  result ans-data-list))
          (when *run-SHAQ-p
            (setf item-data-list  ans-data-list 
                  *shaq-data-list (append *shaq-data-list (list item-data-list))
                  result ans-data-list))

;;SSSS START HERE, FIX PROBLEM OF APPEND TOO MUCH DATA
;; (CAREFOROTHERS (MOTHER FATHER BEST-M-FRIEND (CAREFOROTHERS CAREFOROTHERS :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12) (CAREFOROTHERS CAREFOROTHERS :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12) (CAREFOROTHERS CAREFOROTHERS :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12)))

#|    WAS      (setf item-data-list (append  ans-data-list (list *current-qvar-list))
                *shaq-data-list (append *shaq-data-list (list item-data-list))
                result ans-data-list)  |#

          ;;POKES SHAQ-process-manager running *shaq-main-process to continue (run next frame)
        ;;not needed?? or better here? gives no choice!  (capi:destroy interface)
        (when *run-csq-p 
          (mp:process-poke *csq-main-process))
        (when *run-shaq-p 
          (mp:process-poke *shaq-main-process))

          ;;end single-selection-clause
          )
         (t (setf  
             result  "ERROR: QUESTION IS NOT OF :SINGLE SELECTION TYPE")
            (when *run-csq-p 
              *csq-data-list  (append *csq-data-list  (list qvar nil result)))
            (when *run-shaq-p 
             *shaq-data-list (append *shaq-data-list (list qvar nil result)))
            ))
        ;;end item-selected clause
        )
       (t (format nil "SELECTED ITEM IS NIL")))
      ;;(afout 'out (format nil "AFTER SINGLE-SELECTION-CALLBACK, ~% item-data-list= ~A" item-data-list))
      ;;Note: fout out here doesn't report previous frame right--but it's ok in *shaq-data-list
      ;;(fout out)
      (setf *question-frame-results-list result)
      result
      ;;end let*, with-slots, multiple-value-bind, append-my-vertical-button-panel-single-selection-callback
      ))))



;;SINGLE-SELECTION-CALLBACK -- works pretty well, but needs some debugging
;;  ;;  >>USED AS A CALLBACK IN  MAKE-RADIO-BUTTON-PANEL 
;;
;;ddd
(defun single-selection-callback (item-selected  interface)
  "In CSQ-SHAQ-Frame-quest-functions, Main single-selection callback, converts and records data from the selection. NOTE: capi returns values 0 to (n - 1) in reverse order of my scheme. Therefore I use (- n (+ item-selected-data 1)) for normally scored items and (+ item-selected-data 1) for REV scored items. The integer scores are after these adjustments have been made. Appends *shaq-data-list with (list qvar-string :single relative-score adjusted-int-score  num-answers item-selected  item-selected-data nor-or-rev-scored). [used as a callback in  make-radio-button-panel]."
  (with-slots (answer-button-panel ) interface  ;;was *current-button-panel
    (let*
        (
         ;;item-selected-list-name
         #|         (global-selected-values-list (my-make-symbol 
                                     (format nil "*~A-selected-values-list" parent-layout-name))))|#
         ;;BBB
         (item-selected-name (capi:item-text item-selected))
         (item-selected-data (my-make-symbol (capi:item-data item-selected)))
         (qvar *current-qvar)
         (qvar-string (first *current-qvar-list))
         (q-type (second *current-qvar-list))
         (q-text-sym (third *current-qvar-list))
         (q-num (slot-value interface 'quest-num))  ;;was (fourth *current-qvar-list))
         (answer-panel-sym (fifth *current-qvar-list))
         (num-answers (sixth  *current-qvar-list))
         (item-norm-or-rev (eighth *current-qvar-list))
         (nor-or-rev-scored (ninth *current-qvar-list))
         (reversed-item-p (calc-is-quest-reversed answer-panel-sym)) ;;was(eighth *current-qvar-list))
         (scored-reverse-p) ;;was (ninth *current-qvar-list))
         ;;   (item-selected  (capi:choice-selection answer-button-panel))
         ;;use global vars from 
         (item-data-list)
         (adjusted-int-score)
         (relative-score)
         (nor-or-rev-scored ) 
         (ans-data-list)
         (result)
         )
      (if reversed-item-p
          (setf  item-norm-or-rev 'SCORED-REVERSE))

      ;; (setf out1 (format nil "item-selected-name= ~A~% item-selected-data= ~A~%"item-selected-name item-selected-data))
      ;;yyy
      (cond
       ;;item-selected NOT NIL from being reset 
       (item-selected
        (cond
         ((equal q-type :single) 
          (cond
           ((numberp item-selected-data)
            (cond
             ;;("rhlfreqi" :SINGLE RHLFREQIQ "1" FREQ7REVERSE 7 T NIL 
             ;; ("rhlfreqi" "1.000" 7 7 "More than 60 days per year" SCORED-NORMAL))
             ((null scored-reverse-p)
              (setf adjusted-int-score (- num-answers item-selected-data)
                    nor-or-rev-scored 'normally-scored))
             (t (setf adjusted-int-score (+ item-selected-data)
                      nor-or-rev-scored 'reverse-scored)))
            ;;was 
            ;;calc the relative-score
            (setf relative-score (/  adjusted-int-score  (* 1.0 num-answers)))

            ;;SSS use a different converter than format or $??
            (setf relative-score  (format nil "~3$" relative-score))
            ;;end numberp
            )
           (t nil))

          (setf ans-data-list (list qvar-string :single relative-score adjusted-int-score  num-answers item-selected  item-selected-data item-norm-or-rev nor-or-rev-scored q-num))
          ;;(BREAK "After setf ans-data-list")

          ;;*current-qvar-list = (qvar :single q-text-sym q-num fr-answer-panel-sym num-answers  reversed-item-p scored-reverse-p)
          (setf item-data-list (append *current-qvar-list (list ans-data-list)))
          (when *run-csq-p 
            (setf  *csq-data-list  
                   (append-key-value-in-list :pc-values item-data-list *csq-data-list)))  
          ;;was (list qvar nil result))))
          (when *run-shaq-p
            (setf *shaq-data-list (append *shaq-data-list (list item-data-list))))

          (setf result ans-data-list)  

          ;;POKES SHAQ-process-manager running *shaq-main-process to continue (run next frame)
          ;;was here, but may close before poke (capi:destroy interface)
          (when *run-csq-p
            (mp:process-poke *csq-main-process))
          ;; (break "after poke")
          (when *run-shaq-p
            (mp:process-poke *shaq-main-process))

          (capi:destroy interface)
          ;;end single-selection-clause
          )
         (t (setf result  "ERROR: QUESTION IS NOT OF :SINGLE SELECTION TYPE")
            (when *run-csq-p
              (setf  *csq-data-list  (append *csq-data-list  (list qvar nil result))))
            (when *run-shaq-p
              (setf  *shaq-data-list (append *shaq-data-list (list qvar nil result))))
            ))
        ;;end item-selected clause
        )
       (t (format nil "SELECTED ITEM IS NIL")))
      ;;(afout 'out (format nil "AFTER SINGLE-SELECTION-CALLBACK, ~% item-data-list= ~A" item-data-list))
      ;;Note: fout out here doesn't report previous frame right--but it's ok in *shaq-data-list
      ;;(fout out)
      (setf *question-frame-results-list result)
      result
      ;;end with-slots, let*, single-selection-callback
      )))
;;

#|(defun test ()
  (let ((panel (make-instance 'capi:radio-button-panel :items '("He" "She" "They"))))
    (setf (capi:choice-item-selected panel) nil)
    (capi:contain panel)))|#

;;("rhlfreqi" :SINGLE RHLFREQIQ "1" FREQ7REVERSE 7 T NIL ("rhlfreqi" "1.000" 7 7 "More than 60 days per year" SCORED-NORMAL))

#|
(("thm14ind" :SINGLE THM14INDQ "14" PRIORITY10 10 NIL NIL ("thm14ind" "1.000" 10 10 "The most important thing in my life" SCORED-NORMAL)) ("smtfutur" :SINGLE SMTFUTURQ "2" LIKEME7 7 NIL NIL ("smtfutur" "1.000" 7 7 "EXTREMELY accurate / like me" SCORED-NORMAL)) ("cr1issue" :SINGLE CR1ISSUEQ "1" LIKEUS7 7 NIL NIL ("cr1issue" "1.000" 7 7 "EXTREMELY accurate / like us" SCORED-NORMAL)) ("rhlfreqi" :SINGLE RHLFREQIQ "1" FREQ7REVERSE 7 T NIL ("rhlfreqi" "1.000" 7 7 "More than 60 days per year" SCORED-NORMAL)))
|#
#|
(defun show-callback-args-and-selection-INTEGER  (arg1 arg2)
  (let
      ((item-selected)
       )
    (setf item-selected (capi:choice-selection example-button-panel))
  ;;(afout 'out (format nil "ARG1= ~S, ARG2= ~S~%ITEM-SELECTED= ~A~%" arg1 arg2 item-selected))
  (fout out)
  ))
(defun testbp ()
  (let ((x)  ;;(example-button-panel)
        )
        (setf example-button-panel
         (make-instance 'capi:radio-button-panel
    :items '("Radio 1" "Radio 2" "Radio 3" "Radio 4")
    :callback-type :data-interface
    :selection-callback 'show-callback-args-and-selection-INTEGER
                                   ;;was ;; 'show-callback-args ;; 'button-selection-callback
  ;;  :extend-callback    'button-extend-callback
   ;; :retract-callback   'button-retract-callback
                        :title "Push Me"
                       ;; :callback 'show-callback-args
                      ;;  :data "Here is some data"
                      ;;  :callback-type :data-interface
                        ))
        (capi:contain example-button-panel)
        ))|#



;;MAKE-ANSWER-BUTTON-PANEL
;;
;;ddd
(defun make-answer-button-panel (ans-instruction-text  answer-array-list 
                                                    answer-value-list  qa-parent-row-layout  interface
                                                       &key (selection-type 'single) 
                                                       (close-interface-on-selection-p t)
                                                       background 
                                                       font-size)
  "In CSQ-SHAQ-Frame-quest-functions, Uses  make-my-vertical-button-panel from U-capi-buttons-etc.lisp. Can modify several inner parameters to change appearance, keep frame after selection, etc."
  (let
      ((button-text-title ans-instruction-text)
       (answer-array-list1  `(quote ,answer-array-list))
       (answer-value-list1  `(quote ,answer-value-list))
       ) 
    (unless background
      (setf background *answer-pane-background))
    (unless font-size
        (setf font-size  *answer-pane-font-size))

    (setf out5 (format nil "answer-array-list1= ~A~% answer-value-list1= ~A~%qa-parent-row-layout=~A~% interface= ~A"answer-array-list1  answer-value-list1 qa-parent-row-layout interface))
    (make-my-vertical-button-panel qa-parent-row-layout
                                   interface
                                   answer-array-list1  
                                   answer-value-list1
                                   :selection-type selection-type
                                   :close-interface-on-selection-p close-interface-on-selection-p
                                   :last-button-on-top-p NIL
                                   ;;debug if wanted :send-datalist-to-instance-slot '(list *mb-testinst 'selection-datalist)
                                   :button-layout-arglist  `(list
                                                                   :visible-max-width 20
                                                                   :visible-min-width 20                                                                                                              :visible-min-height 500
                                                                   ;;*answer-pane-height ;;300
                                                                   :background ,background
                                                                   :title "  ";;controls button position
                                                                   :title-gap 0  ;;no effect?
                                                                   ;;no effect    :x 0  :y 0
                                                                        :internal-border 0 ;;important
                                                                        :border nil
                                                                        :title-adjust :center
                                                                        :title-font (gp:make-font-description 
                                                                                    ;; :family *answer-pane-font-face
                                                                                     :weight :bold  :slant :italic
                                                                                     :size ,font-size)       
                                                                        )
                                   :button-arglist    `(list                     
                                                             :title " " ;;adjust left gap within button area
                                                             :title-gap 0  ;;gap betw end of title and button
                                                             :background ,background
                                                             :internal-border 0 ;;no effect??
                                                             :visible-max-width 25
                                                             :visible-min-width 25
                                                         ;;was    :visible-min-height   *button-text-pane-height ;;25?
                                                            ;;was :external-max-height  *button-text-pane-height
;;*button-text-pane-height
                                                             :font nil
                                                             )
                                   :button-text-pane-arglist
                                    `(list
                                      ;;didn't help     :WINDOW-STYLES (list :always-on-top)
                                           :background  ,background
                                           :internal-border nil
                                           :visible-min-width (- *answer-pane-width 65)
                                     ;;was      :visible-min-height  *button-text-pane-height
                                      ;;was     :visible-max-height *button-text-pane-height
                                           ;;  :external-max-height 30
                                           ;;SSS SHOULD THIS BE A RICH-TEXT-PANE CHARLIST
                                           :font   (gp:make-font-description 
                                                  ;;  :family *answer-pane-font-face
                                                    :weight :normal :size ,font-size)
                                           )
                                   :button-text-layout-arglist
                                   `(list
                                    ;;didn't help  :WINDOW-STYLES (list :always-on-top)
                                     :background  ,background
                                     :internal-border nil
                                     :visible-min-width (- *answer-pane-width 60)
                                     :visible-min-height   *answer-pane-height
                                     :visible-max-height  *answer-pane-height
                                     ;;  :visible-max-height 30
                                     :title ,button-text-title
                                     :title-position  :center
                                    :title-font   (gp:make-font-description 
                                                   ;; :family *answer-pane-font-face
                                                    :weight :bold
                                                    :slant :italic :size ,font-size)
                                     )
                                   ;;end make-my-verticalbutton-panel
                                   )
                                 
   ;;(capi:display (setf *ma-testinst (make-instance 'make-answer-button-panel-interface)))  
    ;;END MAKE-ANSWER-BUTTON-PANEL
    ))
;;TEST
;;  (capi:display (setf *ma-testinst (make-answer-button-panel))) 
;;  (defun goab () (progn (setf out nil)  (make-answer-button-panel "INSTRUCTIONS"  '("XXX" "YYY" "ZZZ") '(1000 100 10) 'quest-ans-row-layout  'make-answer-button-panel-interface)))
;;  *quest-ans-row-layout-selected-values-list
;;  (slot-value *ma-testinst 'item-selected-datalist)
;; both of above work = ("XXX" 1000 1 #<CAPI:RADIO-BUTTON "1" 21EC26B3> NIL)





;;MAKE-DOUBLE-ANSWER-BUTTON-PANEL
;;
;;ddd
;;VERY COMPLEX--DOESN'T WORK.  TRIED USING 2 SEPARATE CALLBACKS, BEFORE METHODS ETC.  IF DO AGAIN, USE ONE OF EACH AND ONLY CHANGE THE BUTTONS TO PUT 2 BUTTONS, TEXT, ETC ON EACH BUTTON-TEXT ROW.
#|(defun make-double-answer-button-panel (ans-instruction-text1  answer-array-list1 
                                                    answer-value-list1  parent-row-layout1 
                                                    ans-instruction-text2  answer-array-list2 
                                                    answer-value-list2  parent-row-layout2 
                                                    interface
                                                       &key (selection-type 'single) 
                                                       (close-interface-on-selection-p t)
                                                       last-button-on-top-p
                                                       background
                                                       font-size)

  "In Frame-quest-functions.lisp, Uses  make-my-vertical-button-panel from U-capi-buttons-etc.lisp. Can modify several inner parameters to change appearance, keep frame after selection, etc."
  (let
      ((button-text-title ans-instruction-text1) ;;only one title right now for both sides
     ;;  (button-text-title2 ans-instruction-text2)
  ;;     (answer-array-list1  `(quote ,answer-array-list))
   ;;    (answer-value-list1  `(quote ,answer-value-list))
       ) 
    (unless background
      (setf background *answer-pane-background))
    (unless font-size
        (setf font-size *answer-pane-font-size))

    (setf out5 (format nil "answer-array-list1= ~A~% answer-value-list1= ~A~%parent-row-layout1=~A~%"answer-array-list1  answer-value-list1 parent-row-layout1))
    (make-my-double-vertical-button-panel 
                  parent-row-layout1 parent-row-layout2  interface
                                   answer-array-list1  answer-value-list1
                                   answer-array-list2  answer-value-list2
                                   :selection-type selection-type
                                   :close-interface-on-selection-p close-interface-on-selection-p
                                   :last-button-on-top-p last-button-on-top-p            
                                   :button-layout-arglist  `(list
                                                                   :visible-max-width 20
                                                                   :visible-min-width 20                                                                                                              :visible-min-height *answer-pane-height ;;300
                                                                   :background ,background
                                                                   :title "  ";;controls button position
                                                                   :title-gap 0  ;;no effect?
                                                                   ;;no effect    :x 0  :y 0
                                                                        :internal-border 0 ;;important
                                                                        :border nil
                                                                        :title-adjust :center
                                                                        :title-font (gp:make-font-description 
                                                                                    ;; :family *answer-pane-font-face
                                                                                     :weight :bold  :slant :italic
                                                                                     :size ,font-size)       
                                                                        )
                                   :button-arglist    `(list                     
                                                             :title " " ;;adjust left gap within button area
                                                             :title-gap 0  ;;gap betw end of title and button
                                                             :background ,background
                                                             :internal-border 0 ;;no effect??
                                                             :visible-max-width 25
                                                             :visible-min-width 25
                                                             :visible-min-height *button-text-pane-height ;;25?
                                                             :external-max-height *button-text-pane-height
                                                             :font nil
                                                             )
                                   :button-text-pane-arglist
                                    `(list
                                      ;;didn't help     :WINDOW-STYLES (list :always-on-top)
                                           :background  ,background
                                           :internal-border nil
                                           :visible-min-width (- *answer-pane-width 65)
                                           :visible-min-height *button-text-pane-height
                                           :visible-max-height *button-text-pane-height
                                           ;;  :external-max-height 30
                                           ;;SSS SHOULD THIS BE A RICH-TEXT-PANE CHARLIST
                                           :font   (gp:make-font-description 
                                                    ;; :family *answer-pane-font-face
                                                    :weight :normal :size ,font-size)
                                           )
                                   :button-text-layout-arglist
                                   `(list
                                    ;;didn't help  :WINDOW-STYLES (list :always-on-top)
                                     :background  ,background
                                     :internal-border nil
                                     :visible-min-width (- *answer-pane-width 60)
                                     :visible-min-height  *answer-pane-height
                                     :visible-max-height *answer-pane-height
                                     ;;  :visible-max-height 30
                                     :title ,button-text-title
                                     :title-position  :center
                                    :title-font   (gp:make-font-description 
                                                    ;; :family *answer-pane-font-face
                                                    :weight :bold
                                                    :slant :italic :size ,font-size)
                                     )
                                   ;;end call to make-double-vertical-button-panel
                                   )
    ;;end let, make-double-answer-button-panel
    ))|#

;;MAKE-ANSWER-BUTTON-PANEL-INTERFACE
;;
;;
;;ddd
(capi:define-interface make-answer-button-panel-interface ()
    ;;sets the button/item data values
    ((selected-item-datalist                                     ;;was (data :initform (list 1 2 3))
      :initarg :name
      :accessor selection-datalist
      :initform nil
      :documentation "Store selected button-result list")
     )
    (:layouts
     (quest-ans-row-layout
      capi:row-layout
      ()
      :background *answer-pane-background
      :visible-min-width (- *fr-visible-min-width 40)
      :visible-min-height  *answer-pane-height
      )
     )
    (:default-initargs
     :title "TEST MY INTERFACE"
     :visible-min-width *fr-visible-min-width
     :visible-min-height *fr-visible-min-height
     :background background
     :internal-border *fr-internal-border
     ))




;;MAKE-RADIO-BUTTON-PANEL
;;
;;ddd
(defun make-radio-button-panel (ans-instruction-text answer-array-list)
  "In CSQ-SHAQ-Frame-quest-functions. This version works, but according to LW may not be entirely portable bec of using choice selection to begin all buttons with unselected."
  (make-instance 'capi:radio-button-panel
                 :items answer-array-list
                 ;;'(1 2 3 4 5 6 7 8 9 10 11) 
                 :layout-class 'capi:column-layout
                 :layout-args (list :adjust :center :x 25 :y 25
                                    :y-gap *answer-panel-y-gap
                                    :x-gap 20                                                                       
                                    :internal-border 25)
                 :font (gp:make-font-description 
                        ;; :family *answer-pane-font-face
                        :weight :normal  :size *answer-font-size)
                 :visible-border T
                 :visible-min-height *answer-pane-height
                 :visible-max-height *answer-pane-height
                 :visible-min-width *answer-pane-width
                 ;; :visible-max-width *answer-pane-width
                 :background *answer-pane-background
                ;; :selected-items nil  ;; :none
                 :title ans-instruction-text 
                 :title-adjust  :left
                 ;;   :title-args
                 :title-font (gp:make-font-description 
                              ;; :family *answer-pane-font-face
                              :weight :normal  :size *answer-font-size)
                 :title-gap 15
                 :title-position :top
                 :mnemonics nil         ;;only works for each item'(:none)
                 :callback-type :data-interface
                ;; :selected nil                 
                ;;doesn't work capi:choice-selected-item nil  must use setf outside init-args
                 ;;:selection :none  ;;:nothing works
                 :selection-callback 'single-selection-callback
                 )
  )
#|(defun make-radio-button-panel (ans-instruction-text answer-array-list)
  (make-instance 'capi:radio-button-panel
                 :items answer-array-list
                 ;;'(1 2 3 4 5 6 7 8 9 10 11) 
                 :layout-class 'capi:column-layout
                 :layout-args (list :adjust :center :x 25 :y 25
                                    :y-gap *answer-panel-y-gap
                                    :x-gap 20                                                                       
                                    :internal-border 25)
                 :font (gp:make-font-description 
                        ;; :family *answer-pane-font-face
                        :weight :normal  :size *answer-font-size)
                 :visible-border T
                 :visible-min-height *answer-pane-height
                 :visible-max-height *answer-pane-height
                 :visible-min-width *answer-pane-width
                 ;; :visible-max-width *answer-pane-width
                 :background *answer-pane-background
                ;; :selected-items nil  ;; :none
                 :title ans-instruction-text 
                 :title-adjust  :left
                 ;;   :title-args
                 :title-font (gp:make-font-description 
                              ;; :family *answer-pane-font-face
                              :weight :normal  :size *answer-font-size)
                 :title-gap 15
                 :title-position :top
                 :mnemonics nil         ;;only works for each item'(:none)
                 :callback-type :data-interface
                ;;doesn't work capi:choice-selected-item nil  must use setf outside init-args
                 ;;:selection :none  ;;:nothing works
                 :selection-callback 'single-selection-callback
                 )
  )|#



;;MAKE-CHECK-BUTTON-PANEL
;;
;;ddd
(defun make-check-button-panel (ans-instruction-text answer-array-list)
  (make-instance 'capi:check-button-panel
                 :items answer-array-list
                 ;;'(1 2 3 4 5 6 7 8 9 10 11) 
                 :layout-class 'capi:column-layout
                 :layout-args (list :adjust :center :x 25 :y 25
                                    :y-gap *answer-panel-y-gap
                                    :x-gap 20                                                                       
                                    :internal-border 25)
                 :font (gp:make-font-description 
                        ;; :family *answer-pane-font-face
                        :weight :normal  :size *answer-font-size)
                 :visible-border T
                 :visible-min-height *answer-pane-height
                 :visible-max-height *answer-pane-height
                 :visible-min-width *answer-pane-width
                 ;; :visible-max-width *answer-pane-width
                 :background *answer-pane-background
                ;; :selected-items nil  ;; :none
                 :title ans-instruction-text 
                 :title-adjust  :left
                 ;;   :title-args
                 :title-font (gp:make-font-description 
                              ;; :family *answer-pane-font-face
                              :weight :normal  :size *answer-font-size)
                 :title-gap 15
                 :title-position :top
                 :mnemonics nil         ;;only works for each item'(:none)
                 :callback-type :data-interface
                ;;doesn't work capi:choice-selected-item nil  must use setf outside init-args
                 ;;:selection :none  ;;:nothing works
                 :selection-callback 'multiple-selection-callback
                 )
  )

;;FORMAT-QUESTION-TEXT-LIST
;;      
;;ddd
(defun format-question-text-list (q-num question-text-list 
                                   &key add-newlines add-top-lines justify-type line-width
                                   left-margin-spaces
                                   )
  "In CSQ-SHAQ-Frame-quest-functions. Can now use format nil statements as first string"
  (let
      ((first-string)
       (new-first-string)
       (new-question-text-list)
       )
    (setf first-string (first question-text-list))
    ;;added 2018, can now use format nil statements as first string
    (when (and (listp first-string) (equal (car first-string) 'format))
      (setf first-string (eval first-string)))
    (setf new-first-string (format nil "~A. ~A" q-num first-string)
          new-question-text-list (replace-list question-text-list 0 new-first-string))

    (format-string-list  new-question-text-list :add-top-lines 2 :add-newlines 1 :justify-type :left :line-width  *quest-text-width :left-margin-spaces left-margin-spaces)
    ))
;;test
;;  (format-question-text 3 '("question part-one" "question part 2"))
;; works,= ("3. question part-one" "question part 2")    
;;  (format nil "~vA" 10  #\space)
;;current in make-question-frame
#|    (setf question-text-formated (format-question-text q-num question-text-list
                                                       :add-top-lines 2 :add-newlines 1
                                                       :justify-type :left :line-width  *quest-text-width)
          title-text (center-text title-text (- *fr-visible-min-width 80)))|#

;;(defparameter @SSS-callback nil)
 ;; MODIFY THIS FUNCTION, THEN TEST
;;MULTIPLE-SELECTION-CALLBACK
;;
;;ddd
(defun go-multiple-selection-callback (data interface)
  "In CSQ-SHAQ-Frame-quest-functions, Main multi-selection callback, converts and records data from the selection on *shaq-data-list. Multiple-selection items are simply recorded as the text answer in most or all cases in both lists of  1=checked 0=not-checked plus a list of the texts of checked items. RETURNS *question-frame-results-list form = Eg. (BIO4JOB :MULTI \"bio4job\" \"b-Primary occupation\" 1 (\"student\" \"1\" 1 T 1) (\"manager\" \"2\" 1 NIL 0) -- Each sublist is the spss var name, the button-num, the value if selected, selected T or NIL, data= 0 or 1, q-num"
  (with-slots (answer-button-layout) interface
    (let*
        ((selected-items-list)
         (button-layout)
         (button-list)
         (num-buttons)
         ;;information about the qvar/question information from shaq database
         ;;set in the :before method
         #|(setf *multi-selection-qvar-list
            (get-multi-selection-quest-var-values 'bio4job))|#
         ;;(afout 'out (format nil "*multi-selection-qvar-list= ~A~%" *multi-selection-qvar-list))

         ;;get the PRIMARY QVAR INFO
         (q-text-sym (getf *multi-selection-qvar-list :primary-qvar-sym))
         (qvar (my-make-symbol  (getf *multi-selection-qvar-list :primary-qvar-sym)))
         (label (getf *multi-selection-qvar-list :primary-qvar-label))
         ;; (q-name (getf *multi-selection-qvar-list  :primary-qvar-sym))
         #|  not used         ( title-text (getf *multi-selection-qvar-list :primary-title-text))
            (instruction-text  (getf *multi-selection-qvar-list :primary-instr-text))|#
         (q-num (slot-value interface 'quest-num)) 
         ;;was  (car (slot-value interface 'quest-num)))
         ;;old (getf *multi-selection-qvar-list :qnum))
         ;;the lists related to each answer item = the spss variable items (scores 0 or 1)
         (question-text-list  (getf *multi-selection-qvar-list :quest-text-list))
         (qvar-name-list  (getf *multi-selection-qvar-list    :ans-name-list))
         (ans-text-list  (getf *multi-selection-qvar-list  :ans-text-list))
         ;;not needed, in ans-xdata-lists (quest-data-list  (getf *multi-selection-qvar-list :ans-data-list))
         (num-answers  (getf *multi-selection-qvar-list  :num-answers))
         (ans-xdata-lists  (getf *multi-selection-qvar-list :ans-xdata-lists))
         (multi-ans-data-list 
          (list *qvar-category :multi q-text-sym label q-num))  
         (multi-ans-data-list-brief (list label q-num))
         (sel-value)
         (data)
         (ans-num)
         (q-text)
         (qvar-name)
         (ans-text)
         (quest-data) 
         #|  (item-data-list)
         (adjusted-int-score)
         (relative-score)
         (nor-or-rev-scored ) 
         (ans-data-list)|#
         ;;use
         )
      ;;RESET *question-frame-results-list
      (setf *question-frame-results-list nil
            *quest-frame-results-list-brief nil)

      (cond
       ;;make sure qvar not nil
       (qvar
        ;;get the button-list from its parent layout which is in parent answer-button-layout
        (setf button-layout (car (capi:layout-description answer-button-layout))
              button-list (capi:layout-description button-layout)
              num-buttons (list-length button-list))
        ;;note: num-buttons should equal num-answers above
        (unless (= num-answers num-buttons)
          (format T "ERROR: NUM-ANSWERS= ~A NOT EQUAL NUM-BUTTONS= ~A~%" num-answers num-buttons))

        ;;check result of each button
        (loop
         for button in button-list
         for button-n from 0 to (- num-buttons 1)
         for answer-n from 1 to num-buttons
         for ans-xdata-list in ans-xdata-lists
         ;;not needed, xdata in ans-xdata-list       with qvar-data-item
         do
         ;;get the INTERFACE  button info
         (setf sel-value (capi:item-selected button) ;;nil or T
               data (capi:item-data button)  ;; the value of the button if selected = 1   
               ;;include for checking data purposes
               ans-num (capi:item-text button) ;;eg "3"
               ;;get the qvar info from SHAQ DATA BASE
               ;;not needed?  q-text (nth button-n question-text-list)
               qvar-name (nth button-n qvar-name-list)   ;; spss string name
               ;;not needed?  ans-text (nth button-n ans-text-list)
               ;; quest-data (nth button-n quest-data-list)  ;;set at 0, but never changed
               )
         ;;set quest-data here--this is value sent to spss var qvar-name
         (if sel-value (setf quest-data 1)
           (setf quest-data 0))

         ;;NEW find the eg. (:DATA :scales (HQ)) list, last item in qvar list,
         ;;         if not exist set to NIL
         (setf qvar-data-item  (last (get-qvar-list  qvar-name))) ;;was car
         #|       (unless (equal (car qvar-data-item) :DATA)
         (setf qvar-data-item nil))   |#    
        
         ;;MMM   ;;MAKE THE NEW DATA LISTS 
           (setf multi-ans-data-list
                 (append multi-ans-data-list 
                         (list (list qvar-name ans-num data sel-value quest-data 
                                     q-num  ans-xdata-list))))  ;;qvar-data-item was next to end
          ;;for only essential data
           (setf multi-ans-data-list-brief
                 (append multi-ans-data-list-brief
                         (list (list qvar-name sel-value quest-data))))

         ;;(break "multi-ans-data-list")
         ;;end loop
         )
        ;;append *shaq-data-list -- which accumulates ALL test results data JJJ
        (when *run-csq-p
          (setf *csq-data-list  (append *csq-data-list  
                                       (list :multi-sel-quest q-text-sym  multi-ans-data-list)))
          (setf *csq-scaledata-list 
                (append *csq-scaledata-list 
                        (list :multi-sel-quest  q-text-sym multi-ans-data-list))))
        (when *run-shaq-p
          (setf *shaq-data-list (append *shaq-data-list 
                                        (list :multi-sel-quest q-text-sym  multi-ans-data-list)))
          ;;append *shaq-scaledata-list
          (setf *shaq-scaledata-list 
                (append *shaq-scaledata-list 
                        (list :multi-sel-quest  q-text-sym multi-ans-data-list))))

        (setf *question-frame-results-list    multi-ans-data-list
              *quest-frame-results-list-brief  multi-ans-data-list-brief)
       ;;(break "*quest-frame-results-list-brief")
        ;;qvar-name outside loop
        ;;end qvar not nil clause
        )
       (t nil))

      ;;use somehow if score some multi-choice items ???
      #|   (cond
;;("rhlfreqi" :SINGLE RHLFREQIQ "1" FREQ7REVERSE 7 T NIL 
         ;; ("rhlfreqi" "1.000" 7 7 "More than 60 days per year" SCORED-NORMAL))
           ((null scored-reverse-p)
            (setf adjusted-int-score (- num-answers selected-item)
                  nor-or-rev-scored 'scored-normal))
           (t (setf adjusted-int-score (+ selected-item 1)
                  nor-or-rev-scored ''scored-reverse)))
            ;;was 
          ;;calc the relative-score
          (setf relative-score (/  adjusted-int-score  (* 1.0 num-answers)))
          ;;SSS use a different converter than format or $??
          (setf relative-score  (format nil "~3$" relative-score)
                ans-data-list (list qvar-string relative-score adjusted-int-score  num-answers item-slected-name nor-or-rev-scored))
          ;;end part used for scoring
          |#

      ;;POKES SHAQ-process-manager running *shaq-main-process to continue (run next frame)

      (when *run-csq-p
        (mp:process-poke *csq-main-process))
      (when *run-shaq-p
        (mp:process-poke *shaq-main-process))
      ;;must this be after poke?
       (capi:destroy interface)
     
      *question-frame-results-list
      ;;end with-slots, let*, go-multiple-selection-callback
      )))
;;TEST
;;works
#|CL-USER 75 > *question-frame-results-list
(BIO4JOB :MULTI "bio4job" "b-Primary occupation" 1 ("student" "1" 1 T 1) ("manager" "2" 1 NIL 0) ("propeop" "3" 1 T 1) ("protech" "4" 1 NIL 0) ("consulta" "5" 1 T 1) ("educator" "6" 1 NIL 0) ("sales" "7" 1 T 1) ("technici" "8" 1 NIL 0) ("clerical" "9" 1 T 1) ("service" "10" 1 NIL 0) ("ownbus10" "11" 1 T 1) ("othrsfem" "12" 1 NIL 0))
|#
     
;;PREVIOUS-QUEST-FRAME-CALLBACK
;;
;;ddd
(defun previous-quest-frame-callback (interface)
  "In CSQ-SHAQ-Frame-quest-functions, provides signal for main work function to select previous frame"
   
  ;;FOR CSQ
  (when *run-csq-p
    (setf  *csq-data-list  (butlast *csq-data-list)
           *question-frame-results-list (list 'go-previous-frame))
    (if (member (car (last *csq-data-list))
                '(:scale :subscale :multi-sel-quest) :test 'equal)
        (setf  *csq-data-list  (butlast *csq-data-list)))

    ;;POKES CSQ-process-manager running *csq-main-process to continue (run next frame)
    (mp:process-poke *csq-main-process)
  ;;should this follow poke and other code?
    (capi:destroy interface))
  ;;FOR SHAQ
  (when *run-shaq-p
    (setf  *shaq-data-list (butlast *shaq-data-list)
           *question-frame-results-list (list 'go-previous-frame))
    (if (member (car (last *shaq-data-list))
                '(:scale :subscale :multi-sel-quest) :test 'equal)
        (setf  *shaq-data-list (butlast *shaq-data-list)))

    ;;POKES SHAQ-process-manager running *shaq-main-process to continue (run next frame)
    (capi:destroy interface)
    (mp:process-poke *shaq-main-process))
  ;;END PREVIOUS-QUEST-CALLBACK
  )
  


;;GET-ANSWER-PANEL-KEYLIST
;;
;;ddd
(defun get-answer-panel-keylist (answer-panel-deflist &key return-keylist-p)
  "In CSQ-SHAQ-Frame-quest-functions.  Note: just evaluating the answer-panel-deflist SYMBOL provides the list. This function just separates out the various items in the list."
  (let
      ((deflist-length (list-length answer-panel-deflist))
       (instrs)
       (num-answers)
       (answers)
       (values)
       (selection-type) ;;single or multiple ?
       (data-type)  ;;always int?
       (reversed-item-p)   ;; MEANS NEEDS TO BE REVERSE SCORED
       (scored-reverse-p)  ;; MEANS WAS SCORED REVERSE BY ARRAY
       (pre-selected-num)  ;; an integer of pre-selected answer
       )
    ;;the reversed-item-p and scored-reverse-p below are meaningless in shaq 
    ;; instead go by whether the array has "reverse" in it (calc-is-quest-reverse-scored)
    (multiple-value-setq (instrs num-answers answers values selection-type data-type
                                 reversed-item-p scored-reverse-p pre-selected-num) 
        (values-list  answer-panel-deflist))
    (cond
     (return-keylist-p   ;;was :instrs instrs
      (list :instrs instrs :num-answers num-answers :answers answers :values values
            :selection-type selection-type :data-type data-type
                                 :reversed-item-p reversed-item-p :scored-reverse-p scored-reverse-p 
                                 :pre-selected-num pre-selected-num))
     (t  (values instrs num-answers answers values selection-type data-type
                                 reversed-item-p scored-reverse-p pre-selected-num)))
    ))
;;test
;; (get-answer-panel-keylist Agree7Reverse)
;; works = AGREE7INSTRUCTIONS  7 AGREE7ANSWERARRAY VALUES1TO7ARRAY "single" "int" T NIL NIL
;; (make-answer-panel-keylist Agree7Reverse :return-keylist-p t)
;;  works = (:INSTRS AGREE7INSTRUCTIONS :NUM-ANSWERS 7 :ANSWERS AGREE7ANSWERARRAY :VALUES VALUES1TO7ARRAY :SELECTION-TYPE "single" :DATA-TYPE "int" :REVERSED-ITEM-P T :SCORED-REVERSE-P NIL :PRE-SELECTED-NUM NIL)
     ;;for l(String answerInstructions1,    int numResponsesPerQuestion1, String[] answerTextArray1,    int[] intAnswerValueArray1,  String choiceType1, String valueType1) 
     



;;MAKE-PC-POLES-FRAMES
;;
;;ddd
(defun make-pc-poles-frames (3elmsyms-lists 
                             &key (data-list *csq-data-list) (interface 'frame-csq))
  "In CSQ-SHAQ-Frame-quest-functions, Compares 3 pc elements at a time to find way 2 similar and different from 3rd. pcpoles-list = (alike-pole dif-pole 3elmsyms).  RETURNS  "
  (let
      ((result)
       (alike-text)
       (dif-text)
       (elmQ1)( elmQ2)(elmQ3)
       )
    ;;RESET GLOBAL VARS
    (setf       ;;was  *cur-csq-data-list NIL
           *cur-pc-compare-3elements NIL)

    (loop
     for 3elmsyms in 3elmsyms-lists
     do

     ;;1-FIND 3 ELMS TO COMPARE
     (multiple-value-bind (elm1 elm2 elm3)
         (values-list 3elmsyms)
       ;;1B-FIND Q TEXT FOR EACH ELM
       (setf elmQ1  (get-elmsym-quest-text elm1)
             elmQ2  (get-elmsym-quest-text elm2)
             elmQ3 (get-elmsym-quest-text elm3))
       
       ;;global var for use in callback
       (setf *cur-pc-compare-3elements 3elmsyms)

       (setf quest-text (format nil "ITEM 1: ~A~%ITEM 2: ~A~%ITEM 3: ~A~%~%" elmQ1 elmQ2 elmQ3))

       ;;2-MAKE COMPARISON TEXT FRAME
       (make-pc-poles-frame *compare-pc-element-title 
                              *compare-pc-element-instr    quest-text 
                              *compare-pc-element-alike-text  
                              *compare-pc-element-dif-text  interface
                             ;;not work :input-pane1-title *compare-pc-element-input-pane1-title
                             ;;not work :input-pane2-title *compare-pc-element-input-pane2-title
                              :text-pane3-text *compare-pc-element-text-pane3-text)

     ;;3-HOLD THIS FUNCTION'S PROCESSING UNTIL IT GETS POKED by callback
     ;;    let question hang for 1 hour without attention 
     (mp:current-process-pause 3600  'check-for-frame-visible)

#|       (setf *all-elm-combos-list (append *all-elm-combos-list 
                                  (list *cur-pc-compare-3elements)))|#

       ;;end mvb, loop
       ))

      ;; Must add key to *csq-data-list
      ;;(setf *csq-data-list  (append *csq-data-list  (list :pc-values)))

    ;;*all-elm-combos-list
    ;;end let, make-pc-poles-frames
    ))
;;TEST  VVVV
;; (make-pc-poles-frames '((mother father best-m-friend)))
;;  (make-pc-poles-frames '((f-dislike m-admire per-mostfun)))
;;  (make-pc-poles-frames '((muslims buddhists atheists)))
;;  (make-pc-poles-frames '((role-model child-friend teacher)))
;; (make-pc-poles-frames '((mother father best-m-friend)(f-dislike m-admire per-mostfun)))

;;works? 
;; role-model = ("ROLE-MODEL" "role-model" ELM12-1-1-99 NIL NIL :BIPATHS (((ROLE-MODEL NIL (BLOND (POLE2) NIL)))))
;; blond = ("BLOND" "blond vs not blond" CS2-1-1-99 NIL NIL :PC ("blond" "not blond" 1 NIL) :POLE1 "blond" :POLE2 "not blond" :BESTPOLE 1 (:BIPATHS ((POLE1 NIL CHILD-FRIEND NIL) (POLE1 NIL TEACHER NIL) (POLE2 NIL ROLE-MODEL NIL))))
;; *csq-data-list  = ((BLOND (ROLE-MODEL CHILD-FRIEND TEACHER)))














;;XXX ********************************** OLD DELETE?? ************************


#|(defun compare-pc-elements ( element3-lists &key (data-list *csq-data-list) (interface 'frame-csq))
  "In CSQ-SHAQ-Frame-quest-functions, Compares 3 pc elements at a time to find way 2 similar and different from 3rd. INPUT element3 = 3 qvar nums.  RETURNS  "
  (let
      ((result)
       (simple-result)
       (qvar)
       (alike-text)
       (dif-text)
       )
    (loop
     for element3 in element3-lists
     do
       (loop
        for n in element3
        do
        (multiple-value-bind (qvar qvarlist ans-type)
            (get-qvar-from-catnum 
       (setf quest-text (format nil "* ~A~%* ~A~%* ~A~%~%" elm1 elm2 elm3))

       (multiple-value-setq (result simple-result)
           (make-text-input-frame *compare-pc-element-title *compare-pc-element-instr quest-text *compare-pc-element-alike-text  *compare-pc-element-dif-text  interface))
       
     ;; needed?  (multiple-value-setq (qvar alike-text dif-text)
           ;;           (values-list simple-result))
           ;;SSS WHAT DO I WANT TO DO WITH THE RESULT?? FEED TO (make-pc-poles-frames or ???
       (pc-poles-list (setf pc-poles-list (append pc-poles-list (list simple-result))))

       ;;end mvb, loop
       ))
    ;;end let, compare-pc-elements
    ))|#





;;MAKE-PCQVAR-QUEST   (not used??)
;;
;;ddd
#|(defun make-pcqvar-quest (pc-list &key (all-pcqvars *all-pcqvars) (append-*all-pcqvars-p T))
  "In CSQ-SHAQ-Frame-quest-functions, makes qvar and Q from PC pos-neg poles to be used in value ratings of PCs. PC-list item is (pos-pole-text neg-pole-text PC-category  elementsQ).NOTE: PC-LIST is different from ALL-PCQVARS = same format as shaq-qvars-list. RETURNS (value pcqvar-list pcqvarQ-syms)."
  (let
      ((pos-pole)
       (neg-pole)
       (pc-cat)
       (last-pc-cat "")
       (pcqvar-list)
       (pcqvars-list)
       (pcqvarQ-syms)
       (pcqvar-name)
       (pcqvar-sym)
       (pcqvarQ-name)
       (pcqvarQ-sym)
       (pcqvar-n 0)
       (cat-pre-str "qv")
       (pcqvar-Q "")
       (sub-pcqvars-list)
       (n-pcs (length PC-list))
       (new-all-pcpcqvars)
       )
    (loop
     for item in PC-list
     for n from 0 to (- n-pcs 1)
     do

     (setf pos-pole (car item)
           neg-pole (second item)
           pc-cat (third item)
           pc-cat-str (string pc-cat))

     ;;Start pcqvar-n over with each new cat [ONLY WORKS IF CAT ITEMS GROUPED EXCLUSIVELY TOGETHER]
     (cond
      ((or (= n 0)
           (equal last-pc-cat  pc-cat))
       (incf pcqvar-n)
       )
      ((or (> n 0) (= n (- n-pcs 1)))
       (setf pcqvar-n 1
             new-all-pcqvars (append new-all-pcqvars  (list sub-qvars-list))))       
      (t (setf pcqvar-n 1)))
     ;;update last
     (setf last-pc-cat pc-cat)

     (when (= pcqvar-n 1)
             (setf sub-pcqvars-list (list pc-cat)))

     (cond
      ((> (length pc-cat-str) 2)
       (setf cat-pre-str (subseq pc-cat-str 0 2)))
      ((= (length pc-cat-str) 2)
       (setf cat-pre-str (subseq pc-cat-str 0 1)))
      (t (setf cat-pre-str "qv")))

     ;;make pcqvar name
     (setf pcqvar-name (format nil "~A~A" cat-pre-str pcqvar-n)
           pcqvarQ-name (format nil "~AQ" pcqvar-name)
           pcqvar-sym (my-make-symbol pcqvar-name)
           pcqvarQ-sym (my-make-symbol pcqvarQ-name)
           pcqvar-Q (format nil "~A  (vs. ~A)" pos-pole neg-pole))
     (set pcqvarQ-sym pcqvar-Q)
     ;;append lists
     (setf pcqvar-list (append pcqvar-list (list pcqvar-sym))
           pcqvars-list (append pcqvars-list (list pcqvar-list))
           pcqvarQ-syms (append pcqvarQ-syms (list pcqvarQ-sym))
           pcqvar-list (append pcqvar-list (list pcqvar-name pcqvar-Q nil nil (list pcqvar-name (format nil "~A" pcqvar-n) pcqvarQ-name "int" "Priority12AnswerArray")))
           sub-pcqvars-list (append sub-pcqvars-list (list pcqvar-list))
           pcqvar-list nil)

     (when (= n (- n-pcs 1))
       (setf new-all-pcqvars (append new-all-pcqvars (list sub-pcqvars-list))))
           
     ;;end loop
     )
    ;;MAKE PCQVAR LIST AND APPEND OVERALL PCQVAR-LIST
    (setf  all-pcqvars (append all-pcqvars new-all-pcqvars))
    (when append-*all-PCqvars-p
      (setf *all-PCqvars all-pcqvars))

    (values pcqvars-list  pcqvarQ-syms all-pcqvars)
    ;;end let, make-PCqvar-quest
    ))|#
;;TEST
;; (setf *all-PCqvars nil)
;; (make-PCqvar-quest 

;; older -------------
;; (make-PCqvar-quest '(("very kind" "mean" INTERP)("very smart" "stupid" INTERP)("disorganized" "organized" SELFMAN)))
;;works= (IN1 IN2 SE1) (IN1Q IN2Q SE1Q)  ((INTERP (IN1 "IN1" "very kind  (vs. mean)" NIL NIL ("IN1" "1" "IN1Q" "int" "Priority12AnswerArray")) (IN2 "IN2" "very smart  (vs. stupid)" NIL NIL ("IN2" "2" "IN2Q" "int" "Priority12AnswerArray"))) (SELFMAN (SE1 "SE1" "disorganized  (vs. organized)" NIL NIL ("SE1" "1" "SE1Q" "int" "Priority12AnswerArray"))))
;;also: CL-USER 20 > IN1Q = "very kind  (vs. mean)" CL-USER 48 > IN2Q = "very smart  (vs. stupid)"
;;CL-USER 22 > SE1Q = "disorganized  (vs. organized)"  
;;ALSO:     
;; *all-PCqvars = ((INTERP (IN1 "IN1" "very kind  (vs. mean)" NIL NIL ("IN1" "1" "IN1Q" "int" "Priority12AnswerArray")) (IN2 "IN2" "very smart  (vs. stupid)" NIL NIL ("IN2" "2" "IN2Q" "int" "Priority12AnswerArray"))) (SELFMAN (SE1 "SE1" "disorganized  (vs. organized)" NIL NIL ("SE1" "1" "SE1Q" "int" "Priority12AnswerArray"))))








;;MAKE-ELMSYM-NAME-FRAMES
;;
;;ddd
(defun make-elmsym-name-frames (&key (elmsym-qvars *all-PC-element-qvars))
  "In CSQ-SHAQ-Frame-quest-functions. Makes frames to get specific names for some elmsym qvars. RETURNS (values elmsyms names)"
  (let
      ((names)
       (name)
       (elmsym)
       (elmsyms)
       )
    (loop
     for elmcat in elmsym-qvars
     do
     (loop
      for elmqvarlist in elmcat
      do
      ;;(BREAK "before when  (equal (sixth (fourth elmqvarlist)) 'getname-p"))
      ;;DOES IT REQUIRE A SPECIFIC NAME?
      (when (AND (listp elmqvarlist) 
             (equal (sixth (fourth elmqvarlist)) 'getname-p))     

        (setf elmsym (my-make-symbol (car elmqvarlist))
              elmsyms (append elmsyms (list elmsym)))
       
        ;;If so, MAKE THE QUESTION FRAME
        (make-elmsym-name-frame elmsym)

        ;;    let question hang for 1 hour without attention 
        (mp:current-process-pause 3600  'check-for-frame-visible)
        ;;(BREAK "In make-elmsym-name-frames, after make-elmsym-name-frame")

        ;;GET THE RESULTS = NAMES
        (cond
         ((null *no-text-input-frame-input-p)
          (setf name (car *text-input-frame-text-answers)
                names (append names (list name)))

          ;;set elmsym 5th to name
          (set elmsym (set-nth-in-list name 4 (eval elmsym)))

          ;;append *csq-data-list
          (setf *CSQ-elmsym-lists  (append-key-value-in-list :ELMSYM-LISTS (eval elmsym)  *CSQ-elmsym-lists :add-value-p T :append-value-p NIL)) 
;; (append-key-value-in-list :ELMSYM-LISTS   (quote (quote ("BEST-F-FRIEND" "best-f-friend" ELM5-1-1-99 NIL "jan"))) '(:ELMSYM-LISTS (("BEST-M-FRIEND" "best-m-friend" ELM4-1-1-99 NIL "dave") )))


          ;;(BREAK "append *CSQ-elmsym-lists")

          ;;end text input clause
          )  
         ;;IF NO INPUT TEXT, RE-RERUN FRAME
         (t (make-elmsym-name-frame elmsym)))

        ;;(break)
        ;;NOTE: RESULTS FROM CALLBACK
        #|      (setf *question-frame-results-list result
              ;;eg ((NIL :SINGLE-TEXT NIL NIL 1 NIL ("mom") NIL NIL NIL))
            *text-input-frame-text-answers text-answers)
           *no-text-input-frame-input-p
              ;;eg ("mom")
          |#
        ;;end outer when getname-p
        )
      ;;end loops
      )) 
    (values elmsyms names)
    ;;end let,make-elmsym-name-frames
    ))
;;TEST
;; (make-elmsym-name-frames) = 
;; (get-qvar-list 'best-m-friend)




;;MAKE-ELMSYM-NAME-FRAME
;;
;;ddd
(defun make-elmsym-name-frame (elmsym)
  "In CSQ-SHAQ-Frame-quest-functions. Makes frames to get specific names for some elmsyms"
       (multiple-value-bind (q-text-sym q-text-list q-title q-instr pane-instr)
           (get-question-text elmsym)
         (unless q-title (setf q-title ""))
         (unless q-instr (setf q-instr ""))
         (unless q-text-list (setf q-text-list '("")))

  (let*
      ((title q-title) ;;"TITLE")
       (instr-text q-instr) ;; "INSTR TEXT")
       (q-text  (car q-text-list)) ;; "QUEST TEXT")
       (pane1-text  q-instr) ;; "PANE1-TEXT")
       (pane1-title "Name:")                   
       )
    ;;(break "in frame")
    (when (null q-text)
      (setf q-text ""))
    
    ;;FOR CALLBACK TO MAKE RIGHT DATA FOR *CSQ-DATA-LIST
    (setf *current-qvar elmsym
          *current-qvar-list (get-qvar-list elmsym))

    (when  (listp pane-instr)
      (setf pane-instr (car pane-instr)))
    (when (stringp pane-instr)
      (make-text-input-frame title instr-text  q-text pane-instr
                             NIL 'FRAME-CSQ  :pane1-title pane1-title))

       
   ;;RESULTS FROM CALLBACK
#|      (setf *question-frame-results-list result
              ;;eg ((NIL :SINGLE-TEXT NIL NIL 1 NIL ("mom") NIL NIL NIL))
            *text-input-frame-text-answers text-answers)
              ;;eg ("mom")
|#
    ;;mvb,let, make-elmsym-name-frame
    )))
;;TEST
;; (make-elmsym-name-frame 'mother)
;; (make-elmsym-name-frame  'best-m-friend )














;;xxx ---------------------------- EXTRA-- DELETE?? -----------------------------

  ;;sixth  row (bottom) color block
#|   (simple-layout-9
    capi:simple-layout
    '()
    :external-min-width *frame-internal-width  :external-max-width *frame-internal-width
    :external-min-height *border-width
    :background *fr-border-color)|#

  #| ;;SIDE COLOR BLOCKS
   ;;second row blocks
   (simple-layout-2
    capi:simple-layout
    '()
    :external-min-width *border-width  :external-max-width *border-width
    :external-min-height *title-pane-height
    :background *fr-border-color :visible-border nil)
   (simple-layout-3
    capi:simple-layout
    '()
    :external-min-width *border-width  :internal-max-width *border-width
    :internal-min-height *title-pane-height
    :background *fr-border-color :visible-border nil )

   ;;for row 
   (simple-layout-4
    capi:simple-layout
    '()
    :external-min-width *border-width  :external-max-width *border-width
    :external-min-height *instructions-pane-height
    :background *fr-border-color :visible-border nil)
   ;;for row 
   (simple-layout-5
    capi:simple-layout
    '()
    :external-min-width *border-width  :internal-max-width *border-width
    :internal-min-height *instructions-pane-height
    :background *fr-border-color :visible-border nil )
   ;;yyy

   ;;fourth  row color block -- left of button panel
   (simple-layout-6
    capi:simple-layout
    '()
    :external-min-width *button-left-color-block 
    :external-max-width *button-left-color-block
    :external-min-height *border-width
    :background *fr-border-color)

   ;;fourth row blocks  -- question text area
   (simple-layout-7
    capi:simple-layout
    '()
    :external-min-width *border-width :external-max-width *border-width
    :external-min-height *question-pane-height
    :background *fr-border-color)
   (simple-layout-8
    capi:simple-layout
    '()
    :external-min-width *border-width :external-max-width *border-width
    :external-min-height *question-pane-height
    :background *fr-border-color)
   ;;end layouts
|#

;;BACK-UP VERSION  -- LATER DELETE??
#|
(capi:define-interface frame-question-interface ()
  ()
  (:panes
   (title-rich-text-pane
    capi:rich-text-pane
    :character-format (list :face "times new roman"
                            :size  *title-pane-font-size 
                        :color *title-pane-font-color  :bold T :slant :roman  :underline nil )
    :paragraph-format  (list :alignment :center  ;; :left :right
                        ;;  :start-indent 5
                        :offset-indent 20
                        ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                        :tab-stops nil   ;;eg  (10 20 10)
                        :numbering nil 
                        ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                        )
    :visible-border T
    :visible-min-height *title-pane-height :visible-max-height *title-pane-height
    :external-min-width *title-pane-width  ;; :external-max-width *title-pane-width
 ;;   :foreground *title-pane-foreground 
    :background *title-pane-background
    :text *title-area-text 
    )
   (instr-rich-text-pane
    capi:rich-text-pane
    :character-format  (list :face "times new roman" :size  *instr-pane-font-size                         :color *instr-pane-font-color
                        :bold T :slant :roman  :underline nil )
    :paragraph-format '(:alignment :center  ;; :left :right
                        ;;  :start-indent 5
                        :offset-indent 20
                        ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                        :tab-stops nil   ;;eg  (10 20 10)
                        :numbering nil 
                        ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                        )
    :visible-border T
    :visible-min-height *instr-pane-height :visible-max-height *instr-pane-height
    :external-min-width *instr-pane-width ;; :external-max-width *instr-pane-width
;;    :foreground *instr-pane-foreground 
    :background *instr-pane-background
    :text *instr-area-text 
    )
   (push-button-panel-1
    capi:push-button-panel
    ;;SSS START HERE FORMATING BUTTON PANEL
    :items '(previous-button  go-button)
    (list "   Go to PREVIOUS   " " Exit SHAQ " (format nil "~%        GO TO NEXT QUESTION ~%          "))
    ;;  :buttons   :button-class  
    ;;   :selection-callback 
    ;; :callbacks :callback-type  :action-callback
    ;; :items-callback  :items-count-function  :initial-focus
   ;;  :external-min-width *edit-pane-width ;; :external-max-width *edit-pane-width
    :visible-border nil
    :background *button-panel-background 
   :visible-min-height *button-pane-height
   :visible-min-width *button-pane-width
  ;;  :default-x  :default-y
   ;; :window-styles 
   ;; :title-font  :title-gap  :title  :name  :message-args :message-font
  
    )
   (quest-rich-text-pane
    capi:rich-text-pane
    :character-format (list :face "times new roman" :size *quest-pane-font-size
                        :color *quest-pane-font-color  :bold T :slant :roman  :underline nil )
    :paragraph-format '(:alignment :left ;; :center  ;; :left :right
                        ;;  :start-indent 5
                        :offset-indent 20
                        ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                        :tab-stops nil   ;;eg  (10 20 10)
                        :numbering nil 
                        ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                        )
    :visible-border T
    :visible-min-height *quest-pane-height :visible-max-height *quest-pane-height
    :visible-min-width *quest-pane-width ;; :visible-max-width *quest-pane-width
 ;;   :foreground *quest-pane-foreground 
    :background *quest-pane-background
    :text *quest-area-text 
    )
   (answer-button-panel
    capi:push-button-panel
#|    :character-format '(:face "times new roman" :size 12 ;;error  *pane3-font-size
                        :color :black :bold T :slant :roman  :underline nil )
    :paragraph-format '(:alignment :left ;; :center  ;; :left :right
                        ;;  :start-indent 5
                        :offset-indent 20
                        ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                        :tab-stops nil   ;;eg  (10 20 10)
                        :numbering nil 
                        ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                        )|#
    :visible-border T
    :visible-min-height *answer-pane-height :visible-max-height *answer-pane-height
    :visible-min-width *answer-pane-width ;; :visiblel-max-width *answer-pane-width
;;    :foreground *answer-pane-foreground 
    :background *answer-pane-background
  ;;   :text *answer-area-text 
    )
   ;;end panes
   )
  (:layouts
   ;;overall, column layout, 5 rows.
   (column-layout-1
    capi:column-layout ;; capi:grid-layout
    '( row-layout-1 row-layout-2 row-layout-3 row-layout-4) 
    )
  ;;was  '(simple-layout-1 row-layout-1 row-layout-2 row-layout-3 row-layout-4 simple-layout-7))
   ;;first row --title text
   (row-layout-1
    capi:row-layout
    '(title-rich-text-pane)
  ;;  :visible-min-height *title-pane-height
    )   
   ;;second row --instructions text
   (row-layout-2
    capi:row-layout
    '(instr-rich-text-pane )
 ;;   :visible-min-height *instructions-pane-height
    )  
   ;;third row -- push buttons
   (row-layout-3
    capi:row-layout
    '( push-button-panel-1)
    )
   ;;fourth row -- question text and answer buttons/text
   (row-layout-4
    capi:row-layout
    '( quest-rich-text-pane answer-button-panel)
 ;;   :visible-min-height *info-pane-height
  ;;  :background *fr-border-color
    ) 
   ;;end layouts
   )
  ;;menus
  (:menu-bar file-menu )
  (:menus
   (file-menu
    "File"
    (
     ("Select  Directory"
      :callback 'select-dir-callback
      :callback-type :interface)
     ("SAVE ALL SETTINGS"
      :callback 'save-settings-callback
      :callback-type :interface
      )
     ("Close"
      :callback 'close-frame-callback
      :callback-type :interface
      )
     ;;   photo-order-menu
     ;;   dir-or-file-order-menu
     )))
  ;;end new menus
  (:default-initargs
   :x *initial-x  :y *initial-y
   :visible-min-width *fr-visible-min-width
   ::visible-min-height *fr-visible-min-height
#|   :best-width *frame-internal-width
   :best-height *frame-internal-height|#
   :external-border  *external-border
   :internal-border *internal-border-width
   :window-styles '(:always-on-top)
   :layout 'column-layout-1
   :background *fr-border-color
   :title *shaq-frame-title  ;; "SHAQ FRAME TITLE"
   ))
|#

#|  ;;not valid CHECK  :items-callback '(previous-quest-frame-callback go-frame-callback)
    ;;was  (list "   Go to PREVIOUS   " " Exit SHAQ " (format nil "~%        GO TO NEXT QUESTION ~%          "))|#

#| error, not needed?   (setf test-layout-description-info (capi:layout-description 'answer-column-layout))
    ;;(afout 'out (format nil "XX test-layout-description-info= ~A~%" test-layout-description-info))|#
#|      (setf answer-array-list (eval answer-array)
            ans-instruction-text (eval instrs)
            ans-values-list (eval values))|#

          ;;  (capi:rich-text-pane-text quest-rich-text-pane question-text-formated)
                 ;;causes errorAPI::INITIAL-TEXT is missing from #<CAPI:RICH-TEXT-PANE QUEST-RICH-TEXT-PANE  23A5501B> (of class #<STANDARD-CLASS  CAPI:RICH-TEXT-PANE 20F13883>), when reading the value.
    ;; (setf (capi:rich-text-pane-text  quest-rich-text-pane )  question-text-formated )

         #|    (capi:rich-text-pane-text instr-rich-text-pane)  scale-instr-text)   |#       
        
#|        (if (string-equal selection-type "single")
            (setf (capi::layout-panes button-row-layout) '(previous-frame-button)))|#
        ;;not work (setf (capi-internals:enabled go-frame-button) NIL))
        ;;set the ans-instr-text
        ;;set the radio-button-panel items and ans-instr-text

        #|  (capi:set-button-panel-enabled-items
     controller1 :set t)|#
#| (setq list (capi:contain
               (make-instance 'capi:list-panel
                              :ITEMS '(:red :blue :green)
                              :SELECTED-ITEM :BLUE
                              :print-function
                              'string-capitalize)))
(capi:apply-in-pane-process
 layout #'(setf capi:layout-description)
 (list (make-instance 'capi:title-pane :text "Three")
       (make-instance 'capi:title-pane :text "Four")
       (make-instance 'capi:title-pane :text "Five"))
 layout)
|#


;;MAKE-QUESTION-FRAME
;;THIS VERSION WORKED WELL, EXCEPT POSSIBLE PROBLEM
;;   WITH PORTABILITY OF CHOICE-SELECTION TO NIL according to
;;  LW Hug feedback
;;
#|
(defun make-question-frame (qvar-string main-scale-sym previous-q-name)
  "In Frame-quest-functions.lisp.  Takes a qvar, gets a Q-VARLIST . Makes a frame and instance based upon that info."
  (let
      ((qvar (my-make-symbol qvar-string))
       (frame-name-text)
       (label) (spss-match ) (java-var) (q-num) (old-q-name ) (data-type) 
       (answer-panel) (array) (frame-title) ( fr-width) (fr-height) (java-file)
       (fr-answer-panel-sym)
       (fr-answer-panel-deflist)
       (instrs) (num-answers) (answer-array) (values) (selection-type) (data-type)  
       (reversed-item-p) (scored-reverse-p) (pre-selected-num)
       (ans-instruction-text)
       (answer-array-list)
       (ans-instr-text)
       (q-frame-inst)
     ;;  (scale-instr-text)
      (title-text)
       (instruction-text) ;;was (format nil "~%       SCALE INSTRUCTIONS GO HERE"))
      ;;doesn't work right  (format nil " ~V<~;SCALE INSTRUCTIONS GO HERE~;~;~>" *instr-text-width))
       (question-text-list)
       (question-text-formated)
       )
    ;;GATHER THE INFO NEEDED TO MAKE THE QUESTION FRAME
    ;;get the SCALE/SUBSCALE INFO
    (setf frame-name-text "Success and Happiness Questionnaire (SHAQ) QUESTIONS"
          scale-instr-text "EXAMPLE>> Instructions: How IMPORTANT is this to you?")

    ;;find the QUESTION VARIABLE LIST and values for all items in it
    (multiple-value-setq (label  spss-match  java-var  q-num  q-text-sym  data-type  answer-panel  array  frame-title   fr-width  fr-height  java-file)
        (get-quest-var-values qvar :return-values-p t))
    ;;(afout 'out (format nil "1 label= ~A  spss-match= ~A  java-var= ~A~%  q-num= ~A  q-text-sym= ~A  data-type= ~A~%  answer-panel= ~A~%  array= ~A~%" label  spss-match  java-var  q-num  q-text-sym  data-type  answer-panel  array ))
    
    ;;GET  QUESTION TEXT,  TITLE-TEXT,  INSTRUCTION-TEXT
    (multiple-value-setq (q-text-sym question-text-list title-text instruction-text)
        (get-question-text qvar))
    ;;creates one string with newlines--CAN USE  :character-format A plist. AND :paragraph-format A plist. TO add lines betw paragraphs, etc.
    ;;format them
    (setf question-text-formated (format-question-text q-num question-text-list :add-top-lines 2 :add-newlines 1 :justify-type :left :line-width  *quest-text-width)
          title-text (center-text title-text (- *fr-visible-min-width 80)))

    ;;get the FR-ANSWER-PANEL VARIABLES LIST
    (cond
     (label
      (setf fr-answer-panel-sym (my-make-symbol answer-panel))
      (if  fr-answer-panel-sym
          (setf fr-answer-panel-deflist (eval fr-answer-panel-sym)))
      (if  fr-answer-panel-deflist
          (multiple-value-setq (INSTRS num-answers ANSWER-ARRAY VALUES 
                                       selection-type data-type reversed-item-p 
                                       scored-reverse-p pre-selected-num)
              (get-answer-panel-keylist fr-answer-panel-deflist)))
     ;;(afout 'out (format nil "2 INSTRS= ~A~% num-answers= ~A~% ANSWER-ARRAY= ~A~% VALUES= ~A~% selection-type= ~A~% data-type= ~A~% reversed-item-p= ~A~% scored-reverse-p= ~A~% pre-selected-num= ~A~%" INSTRS num-answers ANSWER-ARRAY VALUES  selection-type data-type reversed-item-p scored-reverse-p pre-selected-num))

      ;;Use above vars to get INSTRUCTIONS, ANSWERS, VALUES, etc
      (setf answer-array-list (eval answer-array)
            ans-instruction-text (eval instrs)
            ans-values-list (eval values))
        ;;not needed?    ans-num-items (list-length answer-array-list))

      ;;(afout 'out (format nil "3 question-text-list= ~A~% answer-array-list= ~A~%ans-instruction-text= ~A~%ans-values-list= ~A~%title-text= ~A~%instruction-text= ~A~%question-text-formated= ~A~%"question-text-list  answer-array-list ans-instruction-text ans-values-list title-text instruction-text question-text-formated))

      (cond
       ((string-equal selection-type "single")
        (setf q-frame-inst (make-instance 'frame-quest-single-R-interface
                                          ;;args here
                                          :title frame-name-text
                                           ))
        (capi:display q-frame-inst))
       (t (setf q-frame-inst (make-instance 'frame-quest-multi-R-interface
                                            ;;args here
                                            :title frame-name-text
                                            ))
                  (capi:display q-frame-inst)))
       
      ;;MODIFY THE Q-FRAME-INST CONTENTS
      (with-slots (title-rich-text-pane instr-rich-text-pane 
                                        quest-rich-text-pane answer-button-panel
                                        go-frame-button previous-frame-button button-row-layout 
                                        answer-column-layout)  q-frame-inst
      ;;1-SET THE TITLE, INSTR, and QUESTION PANE TEXT
      (capi:apply-in-pane-process title-rich-text-pane
                   #'(setf capi:rich-text-pane-text) title-text  title-rich-text-pane )
        (capi:apply-in-pane-process instr-rich-text-pane
                   #'(setf capi:rich-text-pane-text) instruction-text  instr-rich-text-pane )
        (capi:apply-in-pane-process quest-rich-text-pane
                   #'(setf capi:rich-text-pane-text) question-text-formated quest-rich-text-pane )

      ;;SSS START HERE MAKING FRAMES W/ BUTTON PANELS
      (setf answer-button-panel 
            (make-radio-button-panel ans-instruction-text answer-array-list))
      (capi:apply-in-pane-process answer-column-layout
                                  #'(setf capi:layout-description)
                                          (list answer-button-panel)                                            
                                          answer-column-layout)

      ;;SSS START HERE   previous-q-name
      ;;Set button-panel with NO preselected buttons -- may cause extra firing of callback!!
      (capi:apply-in-pane-process answer-column-layout
                                  #'(setf capi:choice-selected-item)
                                          (list nil)                                            
                                          answer-button-panel)
  ;;model  (setf (capi:choice-selected-item answer-button-panel) nil)
  ;;yyy
    ;;set *current-qvar to qvar and *current-qvar-list so can access to this info in callbacks
    (setf *current-qvar  qvar
          ;;can I use CAPI:LAYOUT-DESCRIPTION NIL (CAPI:LAYOUT) instead??
          *current-button-panel answer-button-panel
          *current-qvar-list (list qvar-string :single q-text-sym q-num fr-answer-panel-sym num-answers  reversed-item-p scored-reverse-p))
      
        ;;display the frame-inst
        (capi:display q-frame-inst)
        ;;end with-slots
        )
      ;;end label clause
      )
     (t nil))
    q-frame-inst
    ))
|#

;;DELETE AFTER FINISH NEW VERSION??
;; THIS IS A WORKING SLIGHTLY MODIFIED SINGLE-SELECTION ONLY VERSION OF MAKE-QUESTION-FRAME
#|(defun make-question-frame (qvar-string main-scale-sym previous-q-name)
  "In Frame-quest-functions.lisp.  Takes a qvar, gets a Q-VARLIST . Makes a frame and instance based upon that info."
  (let
      ((qvar (my-make-symbol qvar-string))
       (frame-name-text)
       (label) (spss-match ) (java-var) (q-num) (old-q-name ) (data-type) 
       (answer-panel) (array) (frame-title) ( fr-width) (fr-height) (java-file)
       (fr-answer-panel-sym)
       (fr-answer-panel-deflist)
       (instrs) (num-answers) (answer-array) (values) (selection-type) (data-type)  
       (reversed-item-p) (scored-reverse-p) (pre-selected-num)
       (ans-instruction-text)
       (answer-array-list)
       (ans-instr-text)
       (q-frame-inst)
       ;;answer-button-layout -SPECIFIES SLOT NAME later in this function
     ;;  (scale-instr-text)
      (title-text)
      (title-text-formated)
       (instruction-text) 
       (instr-text-formated)
       (question-text-list)
       (question-text-formated)
       )
    ;;GATHER THE INFO NEEDED TO MAKE THE QUESTION FRAME
    ;;get the SCALE/SUBSCALE INFO
    (setf frame-name-text "Success and Happiness Questionnaire (SHAQ) QUESTIONS"
          scale-instr-text "EXAMPLE>> Instructions: How IMPORTANT is this to you?")

    ;;find the QUESTION VARIABLE LIST and values for all items in it
    (multiple-value-setq (label  spss-match  java-var  q-num  q-text-sym  data-type  answer-panel  array  frame-title   fr-width  fr-height  java-file)
        (get-quest-var-values qvar :return-values-p t))
    ;;(afout 'out (format nil "1 label= ~A  spss-match= ~A  java-var= ~A~%  q-num= ~A  q-text-sym= ~A  data-type= ~A~%  answer-panel= ~A~%  array= ~A~%" label  spss-match  java-var  q-num  q-text-sym  data-type  answer-panel  array ))
    
    ;;GET  QUESTION TEXT,  TITLE-TEXT,  INSTRUCTION-TEXT
    (multiple-value-setq (q-text-sym question-text-list title-text instruction-text)
        (get-question-text qvar))
    ;;creates one string with newlines--CAN USE  :character-format A plist. AND :paragraph-format A plist. TO add lines betw paragraphs, etc.

    ;;format the title-text, instr-text, question-text
    (setf  title-text-formated (format nil "~%~A" title-text)
#|           (format-string-list  (list title-text)
                                                    :add-top-lines 1 :add-newlines 1 :justify-type :left 
                                                    :line-width  (- *fr-visible-min-width 80)
                                                    :left-margin-spaces *title-text-left-margin-spaces)|#
           instr-text-formated  (format-string-list (list instruction-text)
                                                   :add-top-lines 1 :add-newlines 1 :justify-type :left 
                                                   :line-width  (- *fr-visible-min-width 80)
                                                   :left-margin-spaces *instr-text-left-margin-spaces)
           question-text-formated (format-question-text-list q-num question-text-list
                                                             :add-top-lines 2 :add-newlines 1
                                                             :justify-type :left
                                                             :left-margin-spaces *quest-text-left-margin-spaces
                                                             :line-width  *quest-text-width))
  ;;was        title-text (center-text title-text (- *fr-visible-min-width 80)))
         
    ;;get the FR-ANSWER-PANEL VARIABLES LIST
    (cond
     (label
      (setf fr-answer-panel-sym (my-make-symbol answer-panel))
      (if  fr-answer-panel-sym
          (setf fr-answer-panel-deflist (eval fr-answer-panel-sym)))
      (if  fr-answer-panel-deflist
          (multiple-value-setq (INSTRS num-answers ANSWER-ARRAY VALUES 
                                       selection-type data-type reversed-item-p 
                                       scored-reverse-p pre-selected-num)
              (get-answer-panel-keylist fr-answer-panel-deflist)))
    ;; (afout 'out (format nil "2 INSTRS= ~A~% num-answers= ~A~% ANSWER-ARRAY= ~A~% VALUES= ~A~% selection-type= ~A~% data-type= ~A~% reversed-item-p= ~A~% scored-reverse-p= ~A~% pre-selected-num= ~A~%" INSTRS num-answers ANSWER-ARRAY VALUES  selection-type data-type reversed-item-p scored-reverse-p pre-selected-num))

      ;;Use above vars to get INSTRUCTIONS, ANSWERS, VALUES, etc
      (setf answer-array-list (eval answer-array)
            ans-instruction-text (eval instrs)
            ans-values-list (eval values))
        ;;not needed?    ans-num-items (list-length answer-array-list))

      ;;(afout 'out (format nil "3 question-text-list= ~A~% answer-array-list= ~A~%ans-instruction-text= ~A~%ans-values-list= ~A~%title-text-formated= ~A~%instr-text-formated= ~A~%question-text-formated= ~A~%"question-text-list  answer-array-list ans-instruction-text ans-values-list title-text-formated instr-text-formated question-text-formated))

      ;;MAKE ANSWER-BUTTON-PANEL and QUEST FRAME INSTANCE
      (cond
       ((string-equal selection-type "single")
        (setf *call-shaq-question-single-callback-p T
              *single-selection-item T)

;; new version ============== SSS   ============ was later
;; MUST COME BEFORE INSTANCE DEFINED BECAUSE OF :BEFORE METHOD
         (make-answer-button-panel  ans-instruction-text answer-array-list 
                                   ans-values-list
                                   'answer-button-layout 'frame-quest-single-R-interface)
        (setf q-frame-inst (make-instance 'frame-quest-single-R-interface
                                          ;;args here
                                          :title frame-name-text
                                           ))
        (capi:display q-frame-inst))
       (t
        (setf *call-shaq-question-multi-callback-p T
              *single-selection-item NIL)
         (make-answer-button-panel  ans-instruction-text answer-array-list 
                                   ans-values-list
                                   'answer-button-layout 'frame-quest-multi-R-interface)
;;end new version ============
        (setf q-frame-inst (make-instance 'frame-quest-multi-R-interface
                                          ;;args here
                                          :title frame-name-text
                                           ))
        (capi:display q-frame-inst)))


 ;;  SSS    (break) I checked and the button panel is established at this point 
 ;; PROBLEM MUST BE BEFORE HERE   

      ;;MODIFY THE Q-FRAME-INST CONTENTS
      (with-slots (title-rich-text-pane instr-rich-text-pane 
                                        quest-rich-text-pane    ;;was answer-button-panel
                                        go-frame-button previous-frame-button button-row-layout 
                                        quest-ans-row-layout
                                        answer-button-layout)  q-frame-inst
      ;;1-SET THE TITLE, INSTR, and QUESTION PANE TEXT
      (capi:apply-in-pane-process title-rich-text-pane
                   #'(setf capi:rich-text-pane-text) title-text-formated  title-rich-text-pane )
        (capi:apply-in-pane-process instr-rich-text-pane
                   #'(setf capi:rich-text-pane-text) instr-text-formated  instr-rich-text-pane )
        (capi:apply-in-pane-process quest-rich-text-pane
                   #'(setf capi:rich-text-pane-text) question-text-formated quest-rich-text-pane )
    ;;    (afout (format nil "1 (capi:simple-pane-visible-height 'answer-button-layout)= ~A" (capi:simple-pane-visible-height answer-button-layout)))

;;THIS WAS OLD VERSION -- portability problem with choice-selection to nil??
#|
      (setf answer-button-panel 
            (make-radio-button-panel ans-instruction-text answer-array-list))
      (capi:apply-in-pane-process answer-column-layout
                                  #'(setf capi:layout-description)
                                          (list answer-button-panel)                                            
                                          answer-column-layout)

      ;;SSS START HERE   previous-q-name
      ;;Set button-panel with NO preselected buttons -- may cause extra firing of callback!!
      (capi:apply-in-pane-process answer-column-layout
                                  #'(setf capi:choice-selected-item)
                                          (list nil)                                            
                                          answer-button-panel)
 |#
  ;;model  (setf (capi:choice-selected-item answer-button-panel) nil)
  ;;yyy
    ;;set *current-qvar to qvar and *current-qvar-list so can access to this info in callbacks
    (setf *current-qvar  qvar
          ;;can I use CAPI:LAYOUT-DESCRIPTION NIL (CAPI:LAYOUT) instead??
         ;; *current-button-panel answer-button-panel
          *current-qvar-list (list qvar-string :single q-text-sym q-num fr-answer-panel-sym num-answers  reversed-item-p scored-reverse-p))
      
        ;;display the frame-inst
        (capi:display q-frame-inst)
      ;;  (afout (format nil "2 (capi:simple-pane-visible-height 'answer-button-layout)= ~A" (capi:simple-pane-visible-height 'answer-button-layout)))
        ;;end with-slots
        )
      ;;end label clause
      )
     (t nil))
    q-frame-inst
    ))|#

;;MORE TO DELETE 

;;SET THE GLOBAL VARIABLES
;;  (set-global-question-variables)

;; EXPERIMENTAL -- DROPPING MIDDLE LAYOUT FOR BUTTONS
;;  BEC CANT GET TEXT TO APPEAR
;;
#|(capi:define-interface frame-quest-single-R-interface ()
  ((selected-item-datalist
    :initarg :selected-item-datalist
    :accessor selected-item-datalist
    :initform nil
    :type :list
    :documentation "Data from selected item")
   )
  (:PANES
   ;;TITLE-RICH-TEXT-PANE xxx
   (title-rich-text-pane
    capi:rich-text-pane
    :character-format (list ;; :face *title-pane-font-face
                            :size  *title-pane-font-size 
                           ;; :color *title-pane-font-color
                            :bold T :slant :roman  :underline nil )
    :paragraph-format  (list :alignment :center  ;; :left :right
                           ;;no effect?  :start-indent 20
                            ;;no effect? :offset-indent 20
                             ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                             :tab-stops  '(5 10 15 20)
                             :numbering nil 
                             ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                             )
    :visible-border T
   ;;only adds at bottom when use format? 
    :internal-border 8
    :visible-min-height *title-pane-height  :visible-max-height *title-pane-height
    :external-min-width *title-pane-width  ;; :external-max-width *title-pane-width
;;    :foreground *title-pane-foreground 
    :background *title-pane-background
 ;;text done elsewhere  :text *title-area-text 
  ;;doesn't work :y 10
    )
   ;;INSTR-RICH-TEXT-PANE
   (instr-rich-text-pane
    capi:rich-text-pane
    :character-format  (list ;; :face *instr-pane-font-face 
                             :size  *instr-pane-font-size  
                          ;;   :color *instr-pane-font-color
                             :bold T :slant :roman  :underline nil )
    :paragraph-format '(:alignment :center  ;; :left :right
                         :start-indent 20
                       :offset-indent 20
                        ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                        :tab-stops  '(5 10 15 20)
                        :numbering nil 
                        ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                        )
    :visible-border T
    :internal-border 5
    :visible-min-height *instr-pane-height :visible-max-height *instr-pane-height
    :external-min-width *instr-pane-width ;; :external-max-width *instr-pane-width
 ;;   :foreground *instr-pane-foreground 
    :background *instr-pane-background
 ;;text done elsewhere   :text  (format nil "~%   ~A  " *instr-area-text)
    )

   ;;QUESTION-RICH-TEXT-PANE xxx
   (quest-rich-text-pane
    capi:rich-text-pane
    :character-format (list  ;; :face *quest-pane-font-face
                            :size *quest-pane-font-size
                          ;;  :color *quest-pane-font-color
                            :bold *quest-pane-font-weight
                           :slant :roman  :underline nil )
    :paragraph-format '(:alignment :left ;; :center  ;; :left :right
                        ;;  :start-indent 5
                        :offset-indent 10
                        ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                        :tab-stops nil   ;;eg  (10 20 10)
                        :numbering nil 
                        ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                        )
    :visible-border T
    :internal-border 10
  ;;  :visible-min-height *quest-pane-height :visible-max-height *quest-pane-height
    :visible-min-width *quest-pane-width ;; :visible-max-width *quest-pane-width
;;    :foreground *quest-pane-foreground 
    :background *quest-pane-background
 ;;   :text *quest-area-text 
    )
#|   (answer-button-panel
    capi:radio-button-panel
    )|#
   (previous-frame-button
    capi:push-button
    :background *previous-frame-button-background
    :text  *previous-frame-button-text
    :internal-min-width  *previous-frame-button-width
    :internal-min-height  *previous-frame-button-height
    :default-x *previous-frame-button-x
    :default-y *previous-frame-button-y
    :font  *previous-frame-button-font
    :callback 'previous-quest-frame-callback
    :callback-type :interface
    ;;was (gp:make-font-description :size *button-font-size  :weight :bold) ;; :slant :italic)
    ;;doesn't work    :character-format *title-pane-char-format
    ;;doesn't work?    :x 20   :y 20
    )
   ;;end panes
   )
   
  (:layouts
   ;;overall, column layout, 5 rows.
   (column-layout-1
    capi:column-layout ;; capi:grid-layout
    '(row-layout-1 row-layout-2 button-row-layout  quest-ans-row-layout) 
    )
   ;;first row --title text
   (row-layout-1
    capi:row-layout
    '(title-rich-text-pane)
    ;;  :visible-min-height *title-pane-height
    )   
   ;;second row --instructions text
   (row-layout-2
    capi:row-layout
    '(instr-rich-text-pane )
    ;;   :visible-min-height *instructions-pane-height
    )  
   ;;third row -- push buttons
   (button-row-layout
    capi:row-layout
     '(previous-frame-button) ;;  go-frame-button)    ;;left-button-filler-pane
  ;;  :visible-border *button-panel-visible-border
    :background *button-panel-background 
    :visible-min-height (- *button-pane-height 10)
    :visible-min-width *button-pane-width
    ;;  :x-adjust :center
    :y-adjust :center
 ;;    :x-ratios '(1.0   1.5)
   ;; :x-gap 400
    :visible-border nil
   )
   ;;fourth row -- question text and answer buttons/text
   ;;QUEST-ANS-ROW-LAYOUT
   (quest-ans-row-layout
    capi:row-layout
    '( quest-rich-text-pane  answer-button-layout) ;;was answer-button-panel)
    ;;   :visible-min-height *info-pane-height
    ;;  :background *fr-border-color
  ;;  :visible-min-height *answer-pane-height
  ;;  :visible-max-height *answer-pane-height
 ;;   :visible-min-width  (- *fr-visible-min-width (* 2 *fr-internal-border)) ;; :visiblel-max-width *answer-pane-width
    :background  *answer-pane-background
    ) 
  (answer-button-layout
    capi:row-layout
    ()
    :internal-border 10
    )
   ;;end layouts
   )
  ;;MENUS
  (:menu-bar help-menu )
  (:menus
   (help-menu
    "SHAQ Help"
    (
     ("Help"
      :callback 'shaq-help-callback
      :callback-type :interface
      )
     ("Question Help"
      :callback 'question-help-callback
      :callback-type :interface
      )
     ("SAVING Your SHAQ Results"
      :callback 'shaq-saving-results-help-callback
      :callback-type :interface
      )
     ("Your SHAQ Results Help"
      :callback 'shaq-results-help-callback
      :callback-type :interface
      )
     ("Close"
      :callback 'close-frame-callback
      :callback-type :interface
      )
     ("Exit SHAQ"
      :callback 'exit-shaq-callback
      :callback-type :interface
     ;;   photo-order-menu
     ;;   dir-or-file-order-menu
     ))))
  ;;end new menus
  (:default-initargs
   :x *initial-x  :y *initial-y
   :visible-min-width *fr-visible-min-width
   :visible-min-height *fr-visible-min-height
   :external-border  *external-border
   :internal-border *internal-border-width
 ;;  :window-styles '(:always-on-top)
   :layout 'column-layout-1
   :background *fr-border-color
   :title *shaq-frame-title
   ))|#


#| ORIGINAL BEFORE EXPERIMENT
;;FRAME-QUEST-SINGLE-R-INTERFACE
;;
;;ddd
(capi:define-interface frame-quest-single-R-interface ()
  ((selected-item-datalist
    :initarg :selected-item-datalist
    :accessor selected-item-datalist
    :initform nil
    :type :list
    :documentation "Data from selected item")
   )
  (:PANES
   ;;TITLE-RICH-TEXT-PANE xxx
   (title-rich-text-pane
    capi:rich-text-pane
    :character-format (list :face *title-pane-font-face
                            :size  *title-pane-font-size 
                            :color *title-pane-font-color  :bold T :slant :roman  :underline nil )
    :paragraph-format  (list :alignment :center  ;; :left :right
                             ;;  :start-indent 5
                             :offset-indent 20
                             ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                             :tab-stops  '(5 10 15 20)
                             :numbering nil 
                             ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                             )
    :visible-border T
;;    :internal-border 20
    :visible-min-height *title-pane-height  :visible-max-height *title-pane-height
    :external-min-width *title-pane-width  ;; :external-max-width *title-pane-width
;;    :foreground *title-pane-foreground 
    :background *title-pane-background
   :text *title-area-text 
    )
   ;;INSTR-RICH-TEXT-PANE
   (instr-rich-text-pane
    capi:rich-text-pane
    :character-format  (list :face *instr-pane-font-face 
                             :size  *instr-pane-font-size  
                             :color *instr-pane-font-color
                             :bold nil:slant :roman  :underline nil )
    :paragraph-format '(:alignment :center  ;; :left :right
                        ;;  :start-indent 5
                        :offset-indent 10
                        ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                        :tab-stops  '(5 10 15 20)
                        :numbering nil 
                        ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                        )
    :visible-border T
;;    :internal-border 20
    :visible-min-height *instr-pane-height :visible-max-height *instr-pane-height
    :external-min-width *instr-pane-width ;; :external-max-width *instr-pane-width
 ;;   :foreground *instr-pane-foreground 
    :background *instr-pane-background
    :text *instr-area-text 
    )

   ;;QUESTION-RICH-TEXT-PANE xxx
   (quest-rich-text-pane
    capi:rich-text-pane
    :character-format (list :face *quest-pane-font-face :size *quest-pane-font-size
                            :color *quest-pane-font-color  :bold nil:slant :roman  :underline nil )
    :paragraph-format '(:alignment :left ;; :center  ;; :left :right
                        ;;  :start-indent 5
                        :offset-indent 10
                        ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                        :tab-stops nil   ;;eg  (10 20 10)
                        :numbering nil 
                        ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                        )
    :visible-border T
    :visible-min-height *quest-pane-height :visible-max-height *quest-pane-height
    :visible-min-width *quest-pane-width ;; :visible-max-width *quest-pane-width
;;    :foreground *quest-pane-foreground 
    :background *quest-pane-background
 ;;   :text *quest-area-text 
    )
   (answer-button-panel
    capi:radio-button-panel
    )
   (previous-frame-button
    capi:push-button
    :background *previous-frame-button-background
    :text  *previous-frame-button-text
    :internal-min-width  *previous-frame-button-width
    :internal-min-height  *previous-frame-button-height
    :default-x *previous-frame-button-x
    :default-y *previous-frame-button-y
    :font  *previous-frame-button-font
    :callback 'previous-quest-frame-callback
    :callback-type :interface
    ;;was (gp:make-font-description :size *button-font-size  :weight :bold) ;; :slant :italic)
    ;;doesn't work    :character-format *title-pane-char-format
    ;;doesn't work?    :x 20   :y 20
    )
#|was (answer-button-panel
    capi:radio-button-panel
    #|    :character-format '(:face "times new roman" :size 12 ;;error  *pane3-font-size
                        :color :black :bold T :slant :roman  :underline nil )
    :paragraph-format '(:alignment :left ;; :center  ;; :left :right
                        ;;  :start-indent 5
                        :offset-indent 20
                        ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                        :tab-stops nil   ;;eg  (10 20 10)
                        :numbering nil 
                        ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                        )|#
    :items '(9 8 7 6 5 4 3 2 1)
   :layout-class 'capi:column-layout
    :layout-args '(:adjust :center :x 25 :y 25 :y-gap 20 :internal-border 25)
    :visible-border T
    :visible-min-height *answer-pane-height :visible-max-height *answer-pane-height
    :visible-min-width *answer-pane-width ;; :visiblel-max-width *answer-pane-width
;;    :foreground *answer-pane-foreground 
    :background *answer-pane-background
    :selected-items nil
    ;;   :text *answer-area-text 
    )|#
   )
   
  (:layouts
   ;;overall, column layout, 5 rows.
   (column-layout-1
    capi:column-layout ;; capi:grid-layout
    '(row-layout-1 row-layout-2 button-row-layout  quest-ans-row-layout) 
    )
   ;;was  '(simple-layout-1 row-layout-1 row-layout-2 row-layout-3 row-layout-4 simple-layout-7))
   ;;first row --title text
   (row-layout-1
    capi:row-layout
    '(title-rich-text-pane)
    ;;  :visible-min-height *title-pane-height
    )   
   ;;second row --instructions text
   (row-layout-2
    capi:row-layout
    '(instr-rich-text-pane )
    ;;   :visible-min-height *instructions-pane-height
    )  
   ;;third row -- push buttons
   ;;yyy
   (button-row-layout
    capi:row-layout
     '(previous-frame-button) ;;  go-frame-button)    ;;left-button-filler-pane
  ;;  :visible-border *button-panel-visible-border
    :background *button-panel-background 
    :visible-min-height (- *button-pane-height 10)
    :visible-min-width *button-pane-width
    ;;  :x-adjust :center
    :y-adjust :center
 ;;    :x-ratios '(1.0   1.5)
    :x-gap 400
    :visible-border nil
#|   USE LONLY FOR BUTTON-PANELS Can't use button-panels for capi:button class
    :layout-class 'capi:row-layout
   :layout-args '( :x-adjust  :center :x-gap 100 :fixed-size nil )|#
    ;;  :buttons   :button-class  
    ;;   :selection-callback 
    ;; :callbacks :callback-type  :action-callback
    ;; :items-callback  :items-count-function  :initial-focus
    ;;  :external-min-width *edit-pane-width ;; :external-max-width *edit-pane-width
    ;;  :default-x  :default-y
    ;; :window-styles 
    ;; :title-font  :title-gap  :title  :name  :message-args :message-font
   )
   ;;AAA QUEST-ANS-ROW-LAYOUT
   ;;fourth row -- question text and answer buttons/text
   (quest-ans-row-layout
    capi:row-layout
    '( quest-rich-text-pane  answer-button-layout) ;;was answer-button-panel)
    ;;   :visible-min-height *info-pane-height
    ;;  :background *fr-border-color
    :visible-min-height *answer-pane-height
    :visible-max-height *answer-pane-height
  ;;  :visible-min-width (- *fr-visible-min-width 30) ;; :visiblel-max-width *answer-pane-width
    :background *answer-pane-background
    ) 
   (answer-button-layout
    capi:column-layout
    ()
    :visible-min-height *answer-pane-height
    :visible-max-height *answer-pane-height
    :visible-min-width *answer-pane-width ;; :visiblel-max-width *answer-pane-width
    :background *answer-pane-background
    )
   ;;used with other make-button-panel
   #|(answer-column-layout
    capi:column-layout
    '(answer-button-panel)
    :visible-min-height *answer-pane-height :visible-max-height *answer-pane-height
    :visible-min-width *answer-pane-width ;; :visiblel-max-width *answer-pane-width
    :background *answer-pane-background
    )|#
   ;;end layouts
   )
  ;;MENUS
  (:menu-bar help-menu )
  (:menus
   (help-menu
    "SHAQ Help"
    (
     ("Question Help"
      :callback 'question-help-callback
      :callback-type :interface
      )
     ("Your SHAQ Results Help"
      :callback 'shaq-results-help-callback
      :callback-type :interface
      )
     ("Close"
      :callback 'close-frame-callback
      :callback-type :interface
      )
     ("Exit SHAQ"
      :callback 'exit-shaq-callback
      :callback-type :interface
     ;;   photo-order-menu
     ;;   dir-or-file-order-menu
     ))))
  ;;end new menus
  (:default-initargs
   :x *initial-x  :y *initial-y
   :visible-min-width *fr-visible-min-width
   ::visible-min-height *fr-visible-min-height
   #|   :best-width *frame-internal-width
   :best-height *frame-internal-height|#
   :external-border  *external-border
   :internal-border *internal-border-width
   :window-styles '(:always-on-top)
   :layout 'column-layout-1
   :background *fr-border-color
   :title *shaq-frame-title  ;; "SHAQ FRAME TITLE"
   ))
|#



;;------ TEST AREA --------- HELP ----------------------
#|
;;THIS ONLY uses popup, can't use in a frame??
(capi:prompt-for-integer
"Enter an integer in the inclusive range [10,20]:"
:min 10 :max 20)
|#

;; (afout 'out (format nil "This is a test of x= ~A" 99))



;; DELETE IF NEW ONE WORKS
#|
(defun make-question-frame (qvar-string main-scale-sym previous-q-name 
                                        &key (selection-type :single-selection) quest-frame)
  "In Frame-quest-functions.lisp.  Takes a qvar, gets a Q-VARLIST . Makes a frame and instance based upon that info."
  (let
      ((qvar (my-make-symbol qvar-string))
       (frame-name-text)
       (label) (spss-match ) (java-var) (q-num) (old-q-name ) (data-type) 
       (answer-panel) (array) (frame-title) ( fr-width) (fr-height) (java-file)
       (fr-answer-panel-sym)
       (fr-answer-panel-deflist)
       (instrs) (num-answers) (answer-array) (values)
     ;;now an arg above (selection-type) 
       (data-type)  
       (reversed-item-p) (scored-reverse-p) (pre-selected-num)
       (ans-instruction-text)
       (answer-array-list)
       (ans-instr-text)
       (q-frame-inst)
       ;;answer-button-layout -SPECIFIES SLOT NAME later in this function
     ;;  (scale-instr-text)
      (title-text) ;;for top-center title area
      (title-text-formated)
       (instruction-text) 
       (instr-text-formated)
       (question-text-list)
       (question-text-formated)
       (single-sel-test-list
        (list 'single :single-selection "single""SINGLE"))
       (multi-sel-test-list   
        (list 'multiple 'multi "multiple" "MULTIPLE" :multiple-selection))
       )
    ;;(afout 'out (format nil "BEGINNING MAKE-QUESTION-FRAME, for qvar= ~A~% selection-type= ~A~% "qvar selection-type))
    ;;GATHER THE INFO NEEDED TO MAKE THE QUESTION FRAME
    ;;get the SCALE/SUBSCALE INFO
    
    (setf frame-name-text "Success and Happiness Questionnaire (SHAQ) QUESTIONS"
          scale-instr-text "EXAMPLE>> Instructions: How IMPORTANT is this to you?")

    (cond
     ((member selection-type (member selection-type single-sel-test-list :test 'equal ))
      ;;find the QUESTION VARIABLE LIST and values for all items in it
      (multiple-value-setq (label  spss-match  java-var  q-num  q-text-sym  data-type  answer-panel  array  frame-title   fr-width  fr-height  java-file)
          (get-quest-var-values qvar :return-values-p t))
      ;;(afout 'out (format nil "1 SINGLE-SEL CLAUSE:  label= ~A  spss-match= ~A  java-var= ~A~%  q-num= ~A  q-text-sym= ~A  data-type= ~A~%  answer-panel= ~A~%  array= ~A~%" label  spss-match  java-var  q-num  q-text-sym  data-type  answer-panel  array ))
    
      ;;GET  QUESTION TEXT,  TITLE-TEXT,  INSTRUCTION-TEXT
      (multiple-value-setq (q-text-sym question-text-list title-text instruction-text)
          (get-question-text qvar))
      ;;creates one string with newlines--CAN USE  :character-format A plist. AND :paragraph-format A plist. TO add lines betw paragraphs, etc.
    
      ;;end single-selection type
      )
     ((member selection-type multi-sel-test-list :test 'equal)
      ;;find the LIST OF QUESTION VARIABLE LISTS
      (setf *qvar-category qvar-string 
            *multi-selection-qvar-list (get-multi-selection-quest-var-values qvar-string))
      ;;(afout 'out (format nil "*MULTI-SELECTION-QVAR-LIST= ~A~%" *multi-selection-qvar-list))
      (setf  q-text-sym (getf *multi-selection-qvar-list :primary-qvar-sym)
            qvar (my-make-symbol  (getf *multi-selection-qvar-list :primary-qvar-sym))
            label (getf *multi-selection-qvar-list :primary-qvar-label)
            ;; q-name (getf *multi-selection-qvar-list  :primary-qvar-sym
            title-text (getf *multi-selection-qvar-list :primary-title-text)
            instruction-text  (getf *multi-selection-qvar-list :primary-instr-text)
            q-num  (getf *multi-selection-qvar-list :qnum)
            question-text-list  (getf *multi-selection-qvar-list :quest-text-list)
            qvar-name-list  (getf *multi-selection-qvar-list    :ans-name-list)
            ans-text-list  (getf *multi-selection-qvar-list  :ans-text-list)
            quest-data-list  (getf *multi-selection-qvar-list :ans-data-list)
            num-answers  (getf *multi-selection-qvar-list  :num-answers)
            )
      ;;test (setf xx (list :a 1 :b 2))  (getf  xx :b)

      ;;for compatibility with vertical-buttons, single-selection, etc.REPLACE ABOVE?
      (setf ans-instruction-text "Select ALL that apply to you"
            answer-array-list ans-text-list
            ans-values-list  quest-data-list
            reversed-item-p nil  scored-reverse nil
            ;;use another scheme for numbering???
            pre-selected-num q-num)

      ;;(afout 'out (format nil "*multi-selection-qvar-list ~A~% answer-array-list= ~A~%" *multi-selection-qvar-list answer-array-list))

      ;;VARS ABOVE SHOULD INCLUDE/MATCH SINGLE-SELECTION VARS BELOW
      ;; (label  spss-match  java-var  q-num  q-text-sym  data-type  answer-panel  array  frame-title 
      ;;(q-text-sym question-text-list title-text instruction-text)            
      ;;note: *multi-selection-qvar-list = ( :qvar-category :primary-qvar-sym  :primary-qvar-label :primary-title-text :primary-instr-text :quest-text-list :q-spss-name :ans-name-list (SPSS VAR NAME each item) ans-text-list :num-answers  :primary-title-text :primary-instr-text :quest-text-list  :qnum  :data-type :ans-data-list  :primary-java-var :primary-spss-match :spss-match-list :java-var-list)      
      ;;from below also need (INSTRS num-answers ANSWER-ARRAY VALUES  selection-type data-type reversed-item-p scored-reverse-p pre-selected-num)      
      ;; (last '("bio4job" "b-Primary occupation" "spss-match" ("bio4job")("INSTRUCTIONS: Select ALL of the following best describe your primary OCCUPATION." "If you have multiple occupations, choose all of them.")  (  ) :MULTI-ITEM))
      ;;      (setf answer-array-list  ans-instruction-text ans-values-list 

      ;;end multiple-selection type
      )
      (t (format t "SELECTION-TYPE UNSPECIFIED")))

    ;;FORMAT THE TITLE-TEXT, INSTR-TEXT, QUESTION-TEXT
    (setf  title-text-formated (format nil "~%~A" title-text)
          #| (format-string-list  (list title-text)
                                                    :add-top-lines 1 :add-newlines 1 :justify-type :left 
                                                    :line-width  (- *fr-visible-min-width 80)
                                                    :left-margin-spaces *title-text-left-margin-spaces)|#
           instr-text-formated  (format-string-list (list instruction-text)
                                                   :add-top-lines 1 :add-newlines 1 :justify-type :left 
                                                   :line-width  (- *fr-visible-min-width 80)
                                                   :left-margin-spaces *instr-text-left-margin-spaces)
           question-text-formated (format-question-text-list q-num question-text-list
                                                             :add-top-lines 2 :add-newlines 1
                                                             :justify-type :left
                                                             :left-margin-spaces *quest-text-left-margin-spaces
                                                             :line-width  *quest-text-width))
  ;;was        title-text (center-text title-text (- *fr-visible-min-width 80)))
         
    ;;get the FR-ANSWER-PANEL VARIABLES LIST (for single-selection only)
    (cond
     ((and label (member selection-type single-sel-test-list :test 'equal))
      (setf fr-answer-panel-sym (my-make-symbol answer-panel))
      (if  fr-answer-panel-sym
          (setf fr-answer-panel-deflist (eval fr-answer-panel-sym)))
      (if  fr-answer-panel-deflist
          (multiple-value-setq (INSTRS num-answers ANSWER-ARRAY VALUES 
                                       selection-type data-type reversed-item-p 
                                       scored-reverse-p pre-selected-num)
              (get-answer-panel-keylist fr-answer-panel-deflist)))
    ;;(afout 'out (format nil "2 INSTRS= ~A~% num-answers= ~A~% ANSWER-ARRAY= ~A~% VALUES= ~A~% selection-type= ~A~% data-type= ~A~% reversed-item-p= ~A~% scored-reverse-p= ~A~% pre-selected-num= ~A~%" INSTRS num-answers ANSWER-ARRAY VALUES  selection-type data-type reversed-item-p scored-reverse-p pre-selected-num))

      ;;Use above vars to get INSTRUCTIONS, ANSWERS, VALUES, etc
      (setf answer-array-list (eval answer-array)
            ans-instruction-text (eval instrs)
            ans-values-list (eval values))
        ;;not needed?    ans-num-items (list-length answer-array-list))
     ;;end single-selection
     )
     ;;multiple-selection vars all found above
     (t nil))
      ;;(afout 'out (format nil "3 question-text-list= ~A~% answer-array-list= ~A~%ans-instruction-text= ~A~%ans-values-list= ~A~%title-text-formated= ~A~%instr-text-formated= ~A~%question-text-formated= ~A~%"question-text-list  answer-array-list ans-instruction-text ans-values-list title-text-formated instr-text-formated question-text-formated))

      ;;MAKE ANSWER-BUTTON-PANEL and QUEST FRAME INSTANCE
      (cond
       ;;for single-selection frames
       ((member selection-type single-sel-test-list  :test 'equal)
        (setf *call-shaq-question-single-callback-p T
              *single-selection-item T)

;; MUST COME BEFORE INSTANCE DEFINED BECAUSE OF :BEFORE METHOD
        (make-answer-button-panel  ans-instruction-text answer-array-list 
                                   ans-values-list
                                   'answer-button-layout 'frame-quest-single-R-interface)

          (setf q-frame-inst (make-instance 'frame-quest-single-R-interface
                                            ;;args here
                                            :title frame-name-text
                                            ))

        (capi:display q-frame-inst))

;;AAA
       ;;for multiple-selection frames
       (t
        (setf *call-shaq-question-multi-callback-p T
              *single-selection-item NIL)
        ;;(afout 'out (format nil "4 question-text-list= ~A~% answer-array-list= ~A~%ans-instruction-text= ~A~%ans-values-list= ~A~%title-text-formated= ~A~%instr-text-formated= ~A~%question-text-formated= ~A~%"question-text-list  answer-array-list ans-instruction-text ans-values-list title-text-formated instr-text-formated question-text-formated))

         (make-answer-button-panel  ans-instruction-text answer-array-list 
                                   ans-values-list
                                   'answer-button-layout 'frame-quest-multi-R-interface
                                   :selection-type 'multiple)

        (setf q-frame-inst (make-instance 'frame-quest-multi-R-interface
                                          ;;args here
                                          :title frame-name-text
                                           ))

        ;;NOTE--MUST display BEFORE apply-in-pane-process
        (capi:display q-frame-inst)))

      ;;MODIFY THE Q-FRAME-INST CONTENTS
      (with-slots (title-rich-text-pane instr-rich-text-pane 
                                        quest-rich-text-pane   
                                        go-frame-button previous-frame-button 
                                        button-row-layout 
                                        quest-ans-row-layout
                                        answer-button-layout)  q-frame-inst
      ;;1-SET THE TITLE, INSTR, and QUESTION PANE TEXT
      (capi:apply-in-pane-process title-rich-text-pane
                   #'(setf capi:rich-text-pane-text) title-text-formated  title-rich-text-pane )
        (capi:apply-in-pane-process instr-rich-text-pane
                   #'(setf capi:rich-text-pane-text) instr-text-formated  instr-rich-text-pane )
        (capi:apply-in-pane-process quest-rich-text-pane
                   #'(setf capi:rich-text-pane-text) question-text-formated quest-rich-text-pane )
    ;;    (afout (format nil "1 (capi:simple-pane-visible-height 'answer-button-layout)= ~A" (capi:simple-pane-visible-height answer-button-layout)))

;;THIS WAS OLD VERSION -- portability problem with choice-selection to nil??
#|
      (setf answer-button-panel 
            (make-radio-button-panel ans-instruction-text answer-array-list))
      (capi:apply-in-pane-process answer-column-layout
                                  #'(setf capi:layout-description)
                                          (list answer-button-panel)                                            
                                          answer-column-layout)
      ;;Set button-panel with NO preselected buttons -- may cause extra firing of callback!!
      (capi:apply-in-pane-process answer-column-layout
                                  #'(setf capi:choice-selected-item)
                                          (list nil)                                            
                                          answer-button-panel)
 |#
  ;;model  (setf (capi:choice-selected-item answer-button-panel) nil)
  ;;yyy
    ;;set *current-qvar to qvar and *current-qvar-list so can access to this info in callbacks
    (setf *current-qvar  qvar
          ;;can I use CAPI:LAYOUT-DESCRIPTION NIL (CAPI:LAYOUT) instead??
         ;; *current-button-panel answer-button-panel
          *current-qvar-list (list qvar-string :single q-text-sym q-num fr-answer-panel-sym num-answers  reversed-item-p scored-reverse-p))
      
        ;;display the frame-inst
        (capi:display q-frame-inst)
      ;;  (afout (format nil "2 (capi:simple-pane-visible-height 'answer-button-layout)= ~A" (capi:simple-pane-visible-height 'answer-button-layout)))
        ;;end with-slots
        )

    q-frame-inst
    ;;end make-question-frame
    ))
|#





;;OLDER SHAQ VERSION
;;MAKE-QUESTION-FRAME (new single or multi-selection version)
;;
;;ddd 
;; SEE VERSION IN TEST-FUNCTIONS FILE
#|
(defun make-question-frame (qvar-string main-scale-sym 
                               &key (quest-num 1)  quest-frame)
  "In Frame-quest-functions.lisp.  Takes a qvar, gets a Q-VARLIST . Makes a frame and instance based upon that info. Determines the SELECTION-TYPE (:single-selection or :multiple-selection OR :question-function=> a function to run a special q-frame.)."
  ;;reset global variables
  (setf *qvar-category nil 
        *multi-selection-qvar-list nil)

  (let*
      ((qvar (my-make-symbol qvar-string))
       (selection-type) 
       (test-result)
       (qvar-list)
       (frame-name-text) 
       (label) (spss-match ) (java-var) 
       (q-num)  ;;not needed (old-q-name ) (data-type) 
       (answer-panel) 
      ;;not needed (array) (frame-title) ( fr-width) (fr-height) (java-file)
      (q-text-sym)
      (qvar-name-list)
       (fr-answer-panel-sym)
       (fr-answer-panel-deflist)
       (instrs)(deflist-selection-type) (num-answers) (answer-array) (values)
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
     ;;  (scale-instr-text)
      (title-text) ;;for top-center title area
      (title-text-formated)
       (instruction-text) 
       (instr-text-formated)
       (question-text-list)
       (question-text-formated)
       (single-sel-test-list     (list 'single :single-selection "single""SINGLE"))
       (multi-sel-test-list   
           (list 'multiple 'multi "multiple" "MULTIPLE" :multiple-selection :multi-special-frame))
       ;;added bec warning
       (ans-values-list)
       (ans-text-list)
       (quest-data-list)
     ;;not needed    (ans-xdata-list)
       )
   ;; (afout 'out (format nil "BEGINNING MAKE-QUESTION-FRAME, for qvar= ~A~% "qvar ))
    ;;GATHER THE INFO NEEDED TO MAKE THE QUESTION FRAME
    ;;get the SCALE/SUBSCALE INFO
   ;;BBB  in make-question-frame   (find-qvar-selection-type qvar))
   
   (cond
    ;;test to qvar not nil
    (qvar
     (multiple-value-setq (selection-type test-result qvar-list)
         (find-qvar-selection-type qvar))
     ;;(afout 'out (format nil "IN MAKE-QUEST-FRAME, selection-type= ~A~%test-result= ~A~%qvar-list= ~A~% " selection-type test-result qvar-list))
     ;;test (find-qvar-selection-type 'stmajgpa)
     ;;test (find-qvar-selection-type 'family)
     ;;MMM in make-question-frame
     (setf frame-name-text *cur-frame-name-text
           scale-instr-text *cur-scale-instr-text)

     (cond
      ;;FOR SINGLE-SELECTION
      ((equal selection-type :single-selection )
       ;;find the QUESTION VARIABLE LIST and values for all items in it
       (multiple-value-setq (label  spss-match  java-var  q-num  q-text-sym  data-type  answer-panel ) ;;not needed array  frame-title   fr-width  fr-height  java-file)
           (get-quest-var-values qvar :qvar-list qvar-list :return-values-p t ))
 
       ;;replace q-num if quest-num key
       (if quest-num (setf q-num quest-num))     
       ;;reversed item??
       (multiple-value-setq (reversed-item-p item-norm-or-rev)
           (calc-is-quest-reversed qvar :answer-array answer-array))
       ;;(afout 'out (format nil "1 SINGLE-SEL CLAUSE:  label= ~A  spss-match= ~A  java-var= ~A~%  q-num= ~A  q-text-sym= ~A  data-type= ~A~%  answer-panel= ~A~%  array= ~A~%" label  spss-match  java-var  q-num  q-text-sym  data-type  answer-panel  array ))
    
       ;;GET  QUESTION TEXT,  TITLE-TEXT,  INSTRUCTION-TEXT
       (multiple-value-setq (q-text-sym question-text-list title-text instruction-text)
           (get-question-text qvar))
       (if (null question-text-list) (setf question-text-list ""))
       (if (null title-text) (setf title-text ""))
       (if (null instruction-text) (setf instruction-text ""))      
       ;;creates one string with newlines--CAN USE  :character-format A plist. AND :paragraph-format A plist. TO add lines betw paragraphs, etc.
       ;;end single-selection type
       )
      ;;FOR MULTIPLE-SELECTION
      ((equal selection-type :multiple-selection)
       ;;find the LIST OF QUESTION VARIABLE LISTS 
       ;;BBB  *multi-selection-qvar-list 
       (setf *qvar-category  qvar-string 
             *multi-selection-qvar-list 
             (get-multi-selection-quest-var-values qvar-string :qvar-list qvar-list ))
       ;; (afout 'out (format nil "*MULTI-SELECTION-QVAR-LIST= ~A~%" *multi-selection-qvar-list))
       (setf  q-text-sym (getf *multi-selection-qvar-list :primary-qvar-sym)
              qvar (my-make-symbol  (getf *multi-selection-qvar-list :primary-qvar-sym))
              label (getf *multi-selection-qvar-list :primary-qvar-label)
              ;; q-name (getf *multi-selection-qvar-list  :primary-qvar-sym
              title-text (getf *multi-selection-qvar-list :primary-title-text)
              instruction-text  (getf *multi-selection-qvar-list :primary-instr-text)
              question-text-list  (getf *multi-selection-qvar-list :quest-text-list)
              qvar-name-list  (getf *multi-selection-qvar-list    :ans-name-list)
              ans-text-list  (getf *multi-selection-qvar-list  :ans-text-list)
              quest-data-list  (getf *multi-selection-qvar-list :ans-data-list)
              num-answers  (getf *multi-selection-qvar-list  :num-answers)
              q-num quest-num
              ;;not needed     ans-xdata-list  (getf *multi-selection-qvar-list :ans-xdata-list)
              )
       (if  (null instruction-text) (setf instruction-text ""))
       (if (null question-text-list) (setf question-text-list '("")))
  
       ;;question number
       (if quest-num (setf pre-selected-num quest-num)
         (setf pre-selected-num (getf *multi-selection-qvar-list :qnum)))

       ;; HOW TO USE GET -- SEE SEIBEL
       ;;test (setf xx (list :a 1 :b 2))  (getf  xx :b)

       ;;for compatibility with vertical-buttons, single-selection, etc.REPLACE ABOVE?
       (setf ans-instruction-text "Select ALL that apply to you"
             answer-array-list ans-text-list
             ans-values-list  quest-data-list)
       ;;done above reversed-item-p nil) ;;was  scored-reverse nil) ;;why was this here?

       ;;(afout 'out (format nil "*multi-selection-qvar-list ~A~% answer-array-list= ~A~%" *multi-selection-qvar-list answer-array-list))

       ;;VARS ABOVE SHOULD INCLUDE/MATCH SINGLE-SELECTION VARS BELOW
       ;; (label  spss-match  java-var  q-num  q-text-sym  data-type  answer-panel  array  frame-title 
       ;;(q-text-sym question-text-list title-text instruction-text)            
       ;;note: *multi-selection-qvar-list = ( :qvar-category :primary-qvar-sym  :primary-qvar-label :primary-title-text :primary-instr-text :quest-text-list :q-spss-name :ans-name-list (SPSS VAR NAME each item) ans-text-list :num-answers  :primary-title-text :primary-instr-text :quest-text-list  :qnum  :data-type :ans-data-list  :primary-java-var :primary-spss-match :spss-match-list :java-var-list)      
       ;;from below also need (INSTRS num-answers ANSWER-ARRAY VALUES  selection-type data-type reversed-item-p scored-reverse-p pre-selected-num)      
       ;; (last '("bio4job" "b-Primary occupation" "spss-match" ("bio4job")("INSTRUCTIONS: Select ALL of the following best describe your primary OCCUPATION." "If you have multiple occupations, choose all of them.")  (  ) :MULTI-ITEM))
       ;;      (setf answer-array-list  ans-instruction-text ans-values-list 

       ;;end multiple-selection type
       )
      ;;kkkk FOR MULTI-SPECIAL-FRAME (calls special frames which already include all the info needed to display)
      ((equal selection-type :multi-special-frame)
       (setf special-frame-interface (ninth qvar-list))
       (capi:display (make-instance special-frame-interface))
       ;;goal (capi:display (make-instance 'frame-family-info))      
       )
      ((equal selection-type :question-function)
       (eval (eval test-result))  
       ;; (afout 'out  "PAST EVAL TEST-RESULT")
       )
      (t (format t "SELECTION-TYPE UNSPECIFIED")))

     ;;MAKE THE TEXT TO FILL IN FOR GENERAL SINGLE and MULTIPLE-SELECTION FRAMES
     (unless (member selection-type '( :question-function :multi-special-frame) :test 'equal)
       ;;FORMAT THE TITLE-TEXT, INSTR-TEXT, QUESTION-TEXT
       (setf  title-text-formated (format nil "~%~A" title-text)
              #| (format-string-list  (list title-text)
                                                    :add-top-lines 1 :add-newlines 1 :justify-type :left 
                                                    :line-width  (- *fr-visible-min-width 80)
                                                    :left-margin-spaces *title-text-left-margin-spaces)|#
              instr-text-formated  (format-string-list (list instruction-text)
                                                       :add-top-lines 1 :add-newlines 1 :justify-type :left 
                                                       :line-width  (- *fr-visible-min-width 80)
                                                       :left-margin-spaces *instr-text-left-margin-spaces)
              question-text-formated (format-question-text-list q-num question-text-list
                                                                :add-top-lines 2 :add-newlines 1
                                                                :justify-type :left
                                                                :left-margin-spaces *quest-text-left-margin-spaces
                                                                :line-width  *quest-text-width))
       ;;was        title-text (center-text title-text (- *fr-visible-min-width 80)))
         
       ;;GET THE FR-ANSWER-PANEL VARIABLES LIST (for single-selection only)
       (cond
        ((and label (member selection-type single-sel-test-list :test 'equal))
         (setf fr-answer-panel-sym (my-make-symbol answer-panel))
         (if  fr-answer-panel-sym
             (setf fr-answer-panel-deflist (eval fr-answer-panel-sym)))
         (if  fr-answer-panel-deflist
             (multiple-value-setq (INSTRS num-answers ANSWER-ARRAY VALUES 
                                          deflist-selection-type data-type reversed-item-p 
                                          scored-reverse-p pre-selected-num)
                 (get-answer-panel-keylist fr-answer-panel-deflist)))
         ;;(afout 'out (format nil "2 INSTRS= ~A~% num-answers= ~A~% ANSWER-ARRAY= ~A~% VALUES= ~A~% selection-type= ~A~% data-type= ~A~% reversed-item-p= ~A~% scored-reverse-p= ~A~% pre-selected-num= ~A~%" INSTRS num-answers ANSWER-ARRAY VALUES  selection-type data-type reversed-item-p scored-reverse-p pre-selected-num))

         ;;Use above vars to get INSTRUCTIONS, ANSWERS, VALUES, etc
         (setf answer-array-list (eval answer-array)
               ans-instruction-text (eval instrs)
               ans-values-list (eval values))
         ;;not needed?    ans-num-items (list-length answer-array-list))
         ;;added 2014-10, reads answer-panel sym--if contains "reverse" sets
         ;;   it to REVERSE-SCORED if not reverse to nil.
         #|  DONE ABOVE        (if answer-panel
              (setf reversed-item-p (calc-is-quest-reversed qvar answer-panel)))|#

         ;;end single-selection
         )
        ;;MULTIPLE-SELECTION VARS ALL FOUND ABOVE
        (t nil))

       ;;(afout 'out (format nil "3 question-text-list= ~A~% answer-array-list= ~A~%ans-instruction-text= ~A~%ans-values-list= ~A~%title-text-formated= ~A~%instr-text-formated= ~A~%question-text-formated= ~A~%"question-text-list  answer-array-list ans-instruction-text ans-values-list title-text-formated instr-text-formated question-text-formated))

       ;;MAKE ANSWER-BUTTON-PANEL and QUEST FRAME INSTANCE
       (cond
        ;;FOR SINGLE-SELECTION FRAMES
        ((equal selection-type :single-selection) ;;was (member selection-type single-sel-test-list  :test 'equal)
         ;;(afout 'out (format nil "PASSED single-selection test"))
         (setf *call-shaq-question-single-callback-p T
               *single-selection-item T)

         ;; MUST COME BEFORE INSTANCE DEFINED BECAUSE OF :BEFORE METHOD
         (make-answer-button-panel  ans-instruction-text answer-array-list 
                                    ans-values-list
                                    'answer-button-layout 'frame-quest-single-R-interface)

         (setf q-frame-inst (make-instance 'frame-quest-single-R-interface
                                           ;;args here
                                           :title frame-name-text
                                           ;;SSFIX THIS IF NOT GETTING Q-NUM IN *shaq-data-list
                                           :quest-num q-num ;;was pre-selected-num
                                           ))

         (capi:display q-frame-inst)
         ;;end single selection fill and display clause
         )

        ;;FOR MULTIPLE-SELECTION FRAMES
        ((equal selection-type :multiple-selection)
         ;;(afout 'out (format nil "FAILED single-selection test, selection-type= ~A~%" selection-type))
         (setf *call-shaq-question-multi-callback-p T
               *single-selection-item NIL)
         ;; (afout 'out (format nil "4 question-text-list= ~A~% answer-array-list= ~A~%ans-instruction-text= ~A~%ans-values-list= ~A~%title-text-formated= ~A~%instr-text-formated= ~A~%question-text-formated= ~A~%"question-text-list  answer-array-list ans-instruction-text ans-values-list title-text-formated instr-text-formated question-text-formated))

         ;;CHOICE OF FRAMES HERE 
         (cond 
          ((null quest-frame)
           (make-answer-button-panel  ans-instruction-text answer-array-list 
                                      ans-values-list
                                      'answer-button-layout 'frame-quest-multi-R-interface
                                      :selection-type 'multiple)
           (setf q-frame-inst (make-instance 'frame-quest-multi-R-interface
                                             ;;args here
                                             :title frame-name-text
                                             :quest-num pre-selected-num
                                             )))
          ;; eg. can use  'frame-TALL-quest-multi-R-interface
          (t
           (make-answer-button-panel  ans-instruction-text answer-array-list 
                                      ans-values-list
                                      'answer-button-layout quest-frame
                                      :selection-type 'multiple)

           (setf q-frame-inst (make-instance quest-frame
                                             ;;args here
                                             :title frame-name-text
                                             :quest-num pre-selected-num
                                             ))))

         ;;NOTE--MUST display BEFORE apply-in-pane-process
         (capi:display q-frame-inst))

        ;;TEXT ANS
        ((equal selection-type :single-text)
        (setf *call-CSQ-question-single-callback-p T
               *single-text-item T)

         ;; MUST COME BEFORE INSTANCE DEFINED BECAUSE OF :BEFORE METHOD

         (setf q-frame-inst (make-instance 'frame-quest-single-R-interface
                                           ;;args here
                                           :title frame-name-text
                                           ;;SS FIX THIS IF NOT GETTING Q-NUM IN *shaq-data-list
                                           :quest-num q-num ;;was pre-selected-num
                                           ))

         (capi:display q-frame-inst)
         )
        ((equal selection-type :multi-text)
         (setf *call-CSQ-question-multi-callback-p T
               *multi-text-item T)

         ;; MUST COME BEFORE INSTANCE DEFINED BECAUSE OF :BEFORE METHOD
         (make-multi-text-box ans-instruction-text answer-array-list 
                              ans-values-list
                              'answer-button-layout 'frame-quest-single-R-interface)
         #|(make-answer-button-panel  ans-instruction-text answer-array-list 
                                    ans-values-list
                                    'answer-button-layout 'frame-quest-single-R-interface)|#

         (setf q-frame-inst (make-instance 'frame-quest-single-R-interface
                                           ;;args here
                                           :title frame-name-text
                                           ;;S FIX THIS IF NOT GETTING Q-NUM IN *shaq-data-list
                                           :quest-num q-num ;;was pre-selected-num
                                           ))

         (capi:display q-frame-inst)
         )
        (T NIL))
 

       ;;MODIFY THE Q-FRAME-INST CONTENTS
       (with-slots (title-rich-text-pane  instr-rich-text-pane 
                                         quest-rich-text-pane   
                                         go-frame-button previous-frame-button 
                                         button-row-layout 
                                         quest-ans-row-layout
                                         answer-button-layout)  q-frame-inst
         ;;1-SET THE TITLE, INSTR, and QUESTION PANE TEXT
         (capi:apply-in-pane-process title-rich-text-pane
                                     #'(setf capi:rich-text-pane-text) title-text-formated  title-rich-text-pane )
         (capi:apply-in-pane-process instr-rich-text-pane
                                     #'(setf capi:rich-text-pane-text) instr-text-formated  instr-rich-text-pane )
         (capi:apply-in-pane-process quest-rich-text-pane
                                     #'(setf capi:rich-text-pane-text) question-text-formated quest-rich-text-pane )
         ;;    (afout (format nil "1 (capi:simple-pane-visible-height 'answer-button-layout)= ~A" (capi:simple-pane-visible-height answer-button-layout)))

         ;;model  (setf (capi:choice-selected-item answer-button-panel) nil)
         ;;yyy
         ;;set *current-qvar to qvar and *current-qvar-list so can access to this info in callbacks
         (setf *current-qvar  qvar
               ;;can I use CAPI:LAYOUT-DESCRIPTION NIL (CAPI:LAYOUT) instead??
               ;; *current-button-panel answer-button-panel
               ;;BBB -add label moved q-num before num-answers
               *current-qvar-list (list qvar-string :single q-text-sym label  fr-answer-panel-sym q-num num-answers  item-norm-or-rev nor-or-rev-scored))
         #|    was          *current-qvar-list (list qvar-string :single q-text-sym label  fr-answer-panel-sym q-num num-answers  reversed-item-p scored-reverse-p))|#
      
         ;;display the frame-inst
         (capi:display q-frame-inst)
         ;;  (afout (format nil "2 (capi:simple-pane-visible-height 'answer-button-layout)= ~A" (capi:simple-pane-visible-height 'answer-button-layout)))
         ;;end with-slots
         )
       ;;end unless selection-type is :multi-special-frame  OR :question-function clause
       )
     ;;end qvar not nil clause
     )
    (t nil))
    q-frame-inst
    ;;end make-question-frame
    ))

;;(defparameter @SSS-TEST2 nil)
;;TEST
;;  (setf out nil)
;;  (make-question-frame "acmselfs" nil)
;;  (make-question-frame "acmstudy" nil)
;;  (make-question-frame "rangfeel" 'outcome)
;;  (make-question-frame "userrate" 'sUserFeedback )
;;  (make-question-frame "sFamily" 'sfamily)
;; (make-question-frame "stmajgpa" 'scale-sym ) 
;; (make-question-frame "bio4job" 'scale-sym )  :quest-frame 'frame-xtall-multi-answer-button-interface )
;; (make-question-frame "family" 'scale-sym )
;; (make-question-frame "bio7lang" 'scale-sym )
;; (make-question-frame "bio1ethn" 'scale-sym )
;; (make-question-frame "bio7lang" 'scale-sym )
;;  (make-question-frame "biorelaf" 'scale-sym )
 #| (defun goq5 ()  (progn (setf out nil) (setf *qfr4-inst (make-question-frame 'utype 'scale-sym   :quest-frame 'frame-xtall-multi-answer-button-interface ))))
  (defun goq4 ()  (progn (setf out nil) (setf *qfr4-inst (make-question-frame 'SCALESSEL 'scale-sym   :quest-frame 'frame-xtall-multi-answer-button-interface ))))|#
;;WORKS, appends *shaq-data-list with following:
;;CL-USER 11 > *shaq-data-list =  ((SCALESSEL :MULTI "scalessel" "Direct-scales-selected" 1 ("xhqonly" "1" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("xhq-acad" "2" 1 NIL 0 1 (:XDATA :SCALES (HQ ACAD-LEARNING))) ("xhq-acad" "3" 1 NIL 0 1 (:XDATA :SCALES (HQ ACAD-LEARNING))) ("xvalues-th" "4" 1 NIL 0 1 (:XDATA :SCALES (VALUES-THEMES))) ("xworldview" "5" 1 NIL 0 1 (:XDATA :SCALES ("sworldview" "sgrfears"))) ("xsel-f-bels" "6" 1 NIL 0 1 (:XDATA :SCALES ("stbslfwo" "swvgratent" "sethbel"))) ("xiecontrol" "7" 1 NIL 0 1 (:XDATA :SCALES ("siecontr"))) ("xselfconf" "8" 1 NIL 0 1 (:XDATA :SCALES ("sslfconf"))) ("xselfman" "9" 1 NIL 0 1 (:XDATA :SCALES ("sselfman"))) ("xemotcop" "10" 1 NIL 0 1 (:XDATA :SCALES ("semotcop"))) ("xinterpers" "11" 1 NIL 0 1 (:XDATA :SCALES (INTERPERSONAL))) ("xacadlearn" "12" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING))) ("xcarint" "13" 1 NIL 0 1 (:XDATA :SCALES (CAREER-INTEREST))) ("xsehappy" "14" 1 NIL 0 1 (:XDATA :SCALES ("sehappy"))) ("xsehappy" "15" 1 T 1 1 (:XDATA :SCALES ("sehappy"))) ("xsrdepres" "16" 1 T 1 1 (:XDATA :SCALES ("srdepres"))) ("xsranxiet" "17" 1 T 1 1 (:XDATA :SCALES ("sranxiet"))) ("xsrangagg" "18" 1 T 1 1 (:XDATA :SCALES ("srangagg")))))
;; (defun goq3 ()   (progn (setf out nil) (setf *qfr3-inst (make-question-frame 'BIO4JOB 'scale-sym )))) ;;"CR1ISSUE"
;; (defun goq2 ()   (progn (setf out nil) (setf *qfr2-inst (make-question-frame "thm1ach" 'scale-sym "CR1ISSUE"))))
#|( JOB4JOB
      ("bio4job" "b-Primary occupation" "spss-match" ("bio4job")("INSTRUCTIONS: Select ALL of the following best describe your primary OCCUPATION." "If you have multiple occupations, choose all of them.")  (  ) :MULTI-ITEM)
      ("student" "1-Student" "spss-match" ("Student") (  ) :MULTI-ITEM)
      ("manager" "2-Manager" "spss-match" ("Manager/executive") (  ) :MULTI-ITEM)
      ("propeop" "3-People professional" "spss-match" NIL (  ) :MULTI-ITEM)
      ("protech" "4-Technical professional" "spss-match" ("Technician") (  ) :MULTI-ITEM)
      ("consulta" "5-Consultant" NIL ("Consultant") (  ) :MULTI-ITEM)
      ("educator" "6-Educator" "spss-match" ("Educator") (  ) :MULTI-ITEM)
      ("sales" "7-Sales" "spss-match" ("Sales") (  ) :MULTI-ITEM)
      ("technici" "8-Other technical" "spss-match" ("Technician") (  ) :MULTI-ITEM)
      ("clerical" "9-Clerical" "spss-match" ("Clerical") (  ) :MULTI-ITEM)
      ("service" "10-Service" "spss-match" ("Service") (  ) :MULTI-ITEM)
      ("ownbus10" "11-Own business" "spss-match" ("Own business +10 employees") (  ) :MULTI-ITEM)
      ("othrsfem" "12-othrsfem" "spss-match" (("Other self-employed")) ("other" "13-Other" "spss-match" ("Other")) ("bio5inco" "b-Highest personal income" "spss-match" ("bio5income")) (  ) :MULTI-ITEM)
      )|#

;;SINGLE-SELECTION
;; (defun goq ()   (progn (setf out nil) (setf *qfr1-inst  (make-question-frame "thm1ach" 'scale-sym "CR1ISSUE")))) ;; (fout out)))
;;  (progn (setf out nil)  (make-question-frame "CR1ISSUE" 'scale-sym ) (fout out))
;; *answer-button-layout-selected-values-list
;;  (slot-value *qfr1-inst 'selected-item-datalist)
;; results, both =  ("Extremely negative to me" 1 10 #<CAPI:RADIO-BUTTON "10" 2497A09F> NIL)
;; *SHAQ-DATA-LIST
;; result = (("thm1ach" :SINGLE "Extremely negative to me" "0.100" 1 10 #<CAPI:RADIO-BUTTON "10" 2497A09F> 1 SCORED-NORMAL ("thm1ach" :SINGLE THM1ACHQ "1" PRIORITY10 10 NIL NIL)))
;;test special single-selection answer list
;;  (make-question-frame "rpeCommi" nil) rhlWeight
;;  (make-question-frame "rhlWeight" nil)
;;MULTIPLE-SELECTION TEST
;;  (defun goqM ()   (progn (setf out nil) (setf *qfr1-inst  (make-question-frame "BIO4JOB" 'scale-sym "CR1ISSUE" :SELECTION-TYPE :MULTIPLE-SELECTION))))
;;  (GOQM), creates frame and if go, appends *shaq-data-list with (("BIO4JOB" :MULTI "bio4job" "b-Primary occupation" 3 ("student" "1" 1 T 1) ("manager" "2" 1 NIL 0) ("propeop" "3" 1 NIL 0) ("protech" "4" 1 T 1) ("consulta" "5" 1 NIL 0) ("educator" "6" 1 NIL 0) ("sales" "7" 1 NIL 0) ("technici" "8" 1 NIL 0) ("clerical" "9" 1 T 1) ("service" "10" 1 NIL 0) ("ownbus10" "11" 1 NIL 0) ("othrsfem" "12" 1 NIL 0)))
;;NOTE: FOLLOWING USE A DIFFERENT FRAME
;;  (defun goqM1 ()   (progn (setf out nil) (setf *qfr1-inst  (make-question-frame "UGOALS" 'scale-sym "CR1ISSUE" :SELECTION-TYPE :MULTIPLE-SELECTION :QUEST-FRAME 'frame-TALL-quest-multi-R-interface))))
;;;;  (GOQM1)
;;  (defun goqM2 ()   (progn (setf out nil) (setf *qfr1-inst  (make-question-frame "UTYPE" 'scale-sym "CR1ISSUE" :SELECTION-TYPE :MULTIPLE-SELECTION :QUEST-FRAME 'frame-TALL-quest-multi-R-interface))))
;;;;  (GOQM2)
;;
;;other tests
;;;; works  (setf (slot-value *mb-testinst 'selected-item-datalist) '(SLOT-TEST))
;; (capi:simple-pane-visible-height 'answer-button-layout)
;;  *answer-button-layout-A-selected-values-list
;;  (CAPI::SIMPLE-PANE-VISIBLE-WIDTH   )
|#



#|SINGLE FUNCTION VERSION--WOULDN'T BE POKED
(defun make-pc-rate-value-frames (data-list)
  "In CSQ-SHAQ-Frame-quest-functions . eg. data-list= ((pc1 (elm1 elm2 elm3)) ...)"
  (let*
      ((pc-list)
       (frame-inst)
       (pcqvar)
       (pcqvarlist)
       (pcsymvals)
       (pc-str)
       (quest-info-list)
       (pole1)
       (pole2)
       (bestpole)
       (pcsyms-list (get-key-value :PCSYM-ELM-LISTS  data-list))
       )
    (loop
     for pc-item in pcsyms-list
     do
     (when (and pc-item (listp pc-item))
       ;;1-FIND PCQVAR
       (setf pcqvar (car pc-item)
             pcqvarlist   (eval pcqvar)
             bestpole (get-key-value :bestpole pcqvarlist)
             pole1 (get-key-value :pole1 pcqvarlist)
             pole2 (get-key-value :pole2 pcqvarlist))

       ;;2-MAKE QUEST TEXT FROM POLES
       (cond
        ((or (= bestpole 1)(= bestpole 3))
         (setf quest-text (format nil "~A versus ~A" pole1 pole2)))
        (t (setf quest-text (format nil "~A versus ~A" pole2 pole1))))
                                   
       ;;(get-qvar-list pcqvar :all-qvar-lists *all-pcqvars)
           
       ;;(break "setf pcqvar")
       #|     (make-scale-frames scale (begin-quest-num 1)
                                (data-list-name *cur-data-list)  run-qvar-list)
   OR USE make-question-frame
  eg. ( "thm1ach"  "ta-Being the best"  "spss-match"  "thm1Ach"  ("thm1Ach" "1" "thm1AchQ" "int" "Priority10" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "iLifeThemesAch.java")  (:help nil nil)  )  |#

       ;; 3-MAKE INSTR TEXT LIST 
       ;;Eg. from CSQ elements Qs: (M-DISLIKEQ ("A male you very strongly dislike") PCE-PEOPLE-INSTR *input-box-instrs) 
       (setf quest-info-list (list pcqvar (list quest-text)
                                   *Rate-pc-title    *Instr-rate-value ))

       ;;(break "before make-question-frame called")
#|       (multiple-value-bind (label  spss-match  java-var  qnum  q-name  data-type  answer-panel  array  frame-title   fr-width  fr-height  java-file help-info  help-links)|#
     ;;4-MAKE Q-FRAME-INST -- It's selection-callback appends *csq-data-list   
     (setf frame-inst
           (make-question-frame pcqvar nil
                                :all-qvar-lists *all-pcqvars
                                :quest-frame  'frame-quest-single-R-interface
                                :quest-info-list  quest-info-list))
     ;;(BREAK "BEFORE mp:current-process-pause in make-pc-rate-value-frames")
     ;;5-HOLD THIS FUNCTION'S PROCESSING UNTIL IT GETS POKED by callback
     ;;    let question hang for 1 hour without attention 
     (mp:current-process-pause 3600  'check-for-frame-visible)

     ;;(BREAK "after mp:current-process-pause in make-pc-rate-value-frames")
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

         ;;end when, loop
         ))

    ;;end let, make-pc-rate-value-frames
    ))|#

