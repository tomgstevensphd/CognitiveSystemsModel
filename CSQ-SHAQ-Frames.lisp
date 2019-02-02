;;******************************* CSQ-SHAQ-Frames.lisp *********************
;;

;;INTERFACES/FRAMES  USED  FOR CSQ AND SHAQ QUESTIONNAIRES
;;
;;
  ;;INTERFACE ARGS
(defparameter  *initial-x 20)
(defparameter  *initial-y 0)
(defparameter *visible-border-p T)
(defparameter *fr-internal-border 20)
(defparameter  *external-border 20)
(defparameter *internal-border-width 25)
(defparameter *fr-visible-min-width  960) 
(defparameter *fr-visible-min-height 640)   ;; error :maximize)
(defparameter *fr-border-color :red)
(defparameter  *frame-title "Cognitive Systems Questionnaire (CSQ) QUESTIONS")
  (when *run-shaq-p (setf  *frame-title "Success and Happiness Attributes Questionnaire (SHAQ) QUESTIONS"))
(defparameter *shaq-frame-title  "SHAQ CARES-Computer Assessment and Referral System" "Used on some intro frames?")

  ;;for multi-selection questions
(defparameter *default-multi-choice-title "MULTIPLE-SELECTION QUESTION"     
                                          "primary-title-text default text")
(defparameter  *default-multi-choice-instr "Select ALL that apply to you"
    "primary-instr-text default text")
(defparameter  *current-multi-selection-qnum 0)
  ;;pane args
  ;;title-rich-text-pane
(defparameter *title-pane-height 40)
(defparameter *title-pane-width nil)
(defparameter *title-text-left-margin-spaces 20)
(defparameter *title-pane-font-face nil)
(defparameter *title-pane-font-size 14)
(defparameter *title-pane-font-color  :red )
(defparameter *title-pane-background :LIGHTYELLOW )
(defparameter *title-area-text (format nil "Question scale description goes here."))
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
(defparameter *instr-pane-height 70)
(defparameter *instr-pane-width nil)
(defparameter *instr-text-left-margin-spaces 7)
(defparameter *instr-text-width (- *fr-visible-min-width 40))
(defparameter *instr-pane-background :LIGHT-BLUE  )  
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
(defparameter *quest-pane-font-face nil)
(defparameter *quest-pane-font-size 12)
(defparameter *quest-pane-font-weight nil) ;;or :bold 
(defparameter *quest-pane-font-color  :black )
(defparameter *quest-area-text (format nil "~%~%Question areas text goes here."))

  ;;answer-button-panel
(defparameter *answer-pane-height  *quest-pane-height)
(defparameter *answer-pane-width 470)
(defparameter *answer-pane-background  :yellow)  
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
;;added for CSQ
(defparameter *text-go-button-callback nil)

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

  ;;exit-shaq-button
(defparameter  *exit-shaq-button-background :red)
(defparameter *exit-shaq-button-text " EXIT ALL of SHAQ ")
(defparameter *exit-shaq-button-width  100)
(defparameter  *exit-shaq-button-height  30)
(defparameter  *exit-shaq-button-x 120)
(defparameter *exit-shaq-button-y  10)
(defparameter *exit-shaq-button-font (gp:make-font-description :family "times new roman" :size 10 :weight  :bold :slant :roman  :underline nil )) ;;  :color 

;;yyy
   ;;left-button-filler-pane
(defparameter *left-button-filler-pane-width 50)
  ;;end set-global-question-variables

(defparameter  *csq-step-button-strings  '("1. BEGINNING" "2. After Elements NAMED" "3. After COMPARING 3 elements at a time." "4. After RATING all values" "5. After RANKING values with SAME ratings." "6. Before Exploring a Cognitive System in DEPTH") "In csq-choices frame")
(defparameter  *csq-load-user-data-options  '("1. Load last user data" "2. Start user data from beginning." "3. Load another user data source") "In csq-choices frame")
(defparameter *cs-explore-options '("1. Explore ONE Cog System in DEPTH" "2. Do NOT explore any Cog Systems") "In csq-choices frame")
#|FROM SHAQ
(defparameter  *go-frame-button-background :red)
(defparameter  *go-frame-button-foreground :green)  
(defparameter *go-frame-button-text "         GO to NEXT Question >>>       ")
(defparameter *go-frame-button-width  330)
(defparameter  *go-frame-button-height  30)
(defparameter  *go-frame-button-x nil)
(defparameter *go-frame-button-y  nil)|#

;;  )



;;FRAME-QUEST-SINGLE-R-INTERFACE
;;
;;ddd
;;
(capi:define-interface frame-quest-single-R-interface ()
  ((selected-item-datalist
    :initarg :selected-item-datalist
    :accessor selected-item-datalist
    :initform nil
    :type :list
    :documentation "Data from selected item")
  (quest-num
    :initarg :quest-num
    :accessor quest-num
    :initform nil
    :type  :integer
    :documentation "Question number")
  )
  (:PANES
   ;;TITLE-RICH-TEXT-PANE xxx
   (title-rich-text-pane
    capi:rich-text-pane
    :accepts-focus-p NIL
    :character-format (list ;; :face *title-pane-font-face
                            :size  *title-pane-font-size 
                            :color *title-pane-font-color
                            :bold T :italic nil :underline nil )
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
                             :color *instr-pane-font-color
                             :bold nil :italic nil :underline nil )
    :paragraph-format '(:alignment :center  ;; :left :right
                         :start-indent 20
                       :offset-indent 20
                        ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                        :tab-stops  '(5 10 15 20)
                        :numbering nil 
                        ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                        )
    :visible-border T
    :internal-border 8
    :visible-min-height *instr-pane-height :visible-max-height *instr-pane-height
    :external-min-width *instr-pane-width ;; :external-max-width *instr-pane-width
 ;;   :foreground *instr-pane-foreground 
    :background *instr-pane-background
 ;;text done elsewhere   :text  (format nil "~%   ~A  " *instr-area-text)
    )

   ;;QUESTION-RICH-TEXT-PANE xxx
   (quest-rich-text-pane
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format (list  ;; :face *quest-pane-font-face
                            :size *quest-pane-font-size
                            :color *quest-pane-font-color
                            :bold *quest-pane-font-weight
                           :italic nil  :underline nil )
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
    :background *answer-pane-background
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
   )
  ;;END FRAME-QUEST-SINGLE-R-INTERFACE
  )



;;FRAME-QUEST-MULTI-R-INTERFACE
;;
;;ddd
(capi:define-interface frame-quest-multi-R-interface ()
  ((selected-item-datalist
    :initarg :selected-item-datalist
    :accessor selected-item-datalist
    :initform nil
    :type :list
    :documentation "Data from selected item")
  (quest-num
    :initarg :quest-num
    :accessor quest-num
    :initform nil
    :type :list
    :documentation "Question number")
  )
  (:PANES
   ;;TITLE-RICH-TEXT-PANE
   (title-rich-text-pane
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format (list ;; ;;:face *title-pane-font-face
                            :size *title-pane-font-size 
                           :color *title-pane-font-color 
                            :bold T :italic nil  :underline nil )
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
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format  (list ;;:face *instr-pane-font-face 
                             :size  *instr-pane-font-size  
                             :color *instr-pane-font-color
                             :bold T :italic nil :underline nil )
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
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format (list ;;:face *quest-pane-font-face
                            :size *quest-pane-font-size
                            :color *quest-pane-font-color
                            :bold *quest-pane-font-weight
                           :italic nil :underline nil )
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
   (go-frame-button
    capi:push-button
    :background *go-frame-button-background
    :foreground *go-frame-button-foreground
    :text  *go-frame-button-text
    :internal-min-width  *go-frame-button-width
    :internal-max-width  *go-frame-button-width
    :internal-min-height  *go-frame-button-height
    :internal-max-height  *go-frame-button-height
    :external-min-width  (+ *go-frame-button-width 10)
    ;; :external-max-width  *go-frame-button-width
    :external-min-height  (+ *go-frame-button-height 20)  ;;was 10
    ;;  :external-max-height  *go-frame-button-height   
    :default-x *go-frame-button-x
    :default-y *go-frame-button-y
    :font  *go-frame-button-font 
    ;;   :color-requirements 
  ;;   :selected T
    :default-p T  ;;means if return hit, selects this button
    :callback 'go-multiple-selection-callback
    ;;    :callback-type :interface
    ;;was (gp:make-font-description :size *button-font-size  :weight :bold) ;; :slant :italic)
    ;;doesn't work    :character-format *title-pane-char-format
    ;;doesn't work?    :x 20   :y 20
    ;; :button-group
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
 ;;AAA
   ;;third row -- push buttons
   (button-row-layout
    capi:row-layout
     '(previous-frame-button  go-frame-button)    ;;left-button-filler-pane
  ;;  :visible-border *button-panel-visible-border
    :background *button-panel-background 
    :visible-min-height  *button-pane-height
    :visible-min-width *button-pane-width
    ;;  :x-adjust :center
    :y-adjust :center
 ;;    :x-ratios '(1.0   1.5)
    :x-gap 450
    :visible-border nil
   )
   ;;fourth row -- question text and answer buttons/text
   ;;QUEST-ANS-ROW-LAYOUT
   (quest-ans-row-layout
    capi:row-layout
    '(quest-rich-text-pane answer-button-layout) 
    ;;   :visible-min-height *info-pane-height
    ;;  :background *fr-border-color
  ;;  :visible-min-height *answer-pane-height
  ;;  :visible-max-height *answer-pane-height
 ;;   :visible-min-width  (- *fr-visible-min-width (* 2 *fr-internal-border)) ;; :visiblel-max-width *answer-pane-width
  ;;  :background  *answer-pane-background
    ) 
  (answer-button-layout
    capi:row-layout
    ()
   :internal-border 10
    :background *answer-pane-background
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

   ;;end frame-quest-multi-R-interface
   ))
;;TEST
;;  (defun testmf3 () (let ((testmf3 (make-instance 'frame-quest-multi-R-interface))) (capi:display testmf3)))





;;FRAME-TALL-QUEST-MULTI-R-INTERFACE
;;
;; for use with make-question-function for TALL/MORE ANSWERS
;;
;;ddd
(capi:define-interface frame-TALL-quest-multi-R-interface ()
  ((selected-item-datalist
    :initarg :selected-item-datalist
    :accessor selected-item-datalist
    :initform nil
    :type :list
    :documentation "Data from selected item")
   (quest-num
    :initarg :quest-num
    :accessor quest-num
    :initform nil
    :type :list
    :documentation "Question number")
   )
  (:PANES
   ;;TITLE-RICH-TEXT-PANE
   (title-rich-text-pane
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format (list ;; ;;:face *title-pane-font-face
                            :size *title-pane-font-size 
                           :color *title-pane-font-color 
                            :bold T :italic nil :underline nil )
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
    :visible-min-height (* 2 *title-pane-height)
    :visible-max-height (* 2 *title-pane-height)
;;    :external-min-width (* 0.5 *title-pane-width) ;; :external-max-width *title-pane-width
;;    :foreground *title-pane-foreground 
    :background *title-pane-background
 ;;text done elsewhere  :text *title-area-text 
  ;;doesn't work :y 10
    )
   ;;INSTR-RICH-TEXT-PANE
   (instr-rich-text-pane
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format  (list ;;:face *instr-pane-font-face 
                             :size  *instr-pane-font-size  
                             :color *instr-pane-font-color
                             :bold T :italic nil  :underline nil )
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
    :visible-min-height (* 2 *instr-pane-height)
    :visible-max-height (* 2 *instr-pane-height)
    ;;  :external-min-width (* 0.5 *instr-pane-width) ;; :external-max-width *instr-pane-width
    ;;   :foreground *instr-pane-foreground 
    :background *instr-pane-background
    ;;text done elsewhere   :text  (format nil "~%   ~A  " *instr-area-text)
    )

   ;;QUESTION-RICH-TEXT-PANE xxx
   (quest-rich-text-pane
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format (list ;;:face *quest-pane-font-face
                            :size *quest-pane-font-size
                            :color *quest-pane-font-color
                            :bold *quest-pane-font-weight
                            :italic nil  :underline nil )
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
    :visible-max-height 350 
    :visible-min-width *quest-pane-width ;; :visible-max-width *quest-pane-width
;;    :foreground *quest-pane-foreground 
    :visible-max-width *quest-pane-width
    :background *quest-pane-background
 ;;   :text *quest-area-text 
    )
   (go-frame-button
    capi:push-button
    :background *go-frame-button-background
    :foreground *go-frame-button-foreground
    :text  *go-frame-button-text
    :internal-min-width  *go-frame-button-width
    :internal-max-width  *go-frame-button-width
    :internal-min-height  *go-frame-button-height
    :internal-max-height  *go-frame-button-height
    :external-min-width  (+ *go-frame-button-width 10)
    ;; :external-max-width  *go-frame-button-width
    :external-min-height  (+ *go-frame-button-height 20)  ;;was 10
    ;;  :external-max-height  *go-frame-button-height   
    :default-x *go-frame-button-x
    :default-y *go-frame-button-y
    :font  *go-frame-button-font 
    ;;   :color-requirements 
  ;;   :selected T
    :default-p T  ;;means if return hit, selects this button
    :callback 'go-multiple-selection-callback
    ;;    :callback-type :interface
    ;;was (gp:make-font-description :size *button-font-size  :weight :bold) ;; :slant :italic)
    ;;doesn't work    :character-format *title-pane-char-format
    ;;doesn't work?    :x 20   :y 20
    ;; :button-group
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
   ;;end panes
   )
   
  (:layouts
   ;;overall, column layout, 5 rows.
   (top-row-layout
    capi:row-layout
    '(column-layout-1 answer-button-layout)
    )
#|   (test-layout
    capi:row-layout
    '()
    :background :green
    :visible-min-width 200
    :visible-min-height 200
    )|#
   (column-layout-1
    capi:column-layout ;; capi:grid-layout
    '(row-layout-1 row-layout-2 button-row-layout  quest-ans-row-layout) 
    :visible-max-width 400
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
 ;;AAA
   ;;third row -- push buttons
   (button-row-layout  ;;kept same name as non-tall frame
    capi:column-layout
     '(go-frame-button previous-frame-button )    ;;left-button-filler-pane
  ;;  :visible-border *button-panel-visible-border
    :background *button-panel-background 
    :visible-min-height  (* 2.2 *button-pane-height)
    :visible-max-width  (* 0.5 *button-pane-width)
    ;;  :x-adjust :center
    :y-adjust :center
 ;;    :x-ratios '(1.0   1.5)
    :y-gap 10
    :visible-border nil
   )
   ;;fourth row -- question text and answer buttons/text
   ;;QUEST-ANS-ROW-LAYOUT
   (quest-ans-row-layout
    capi:row-layout
    '(quest-rich-text-pane ) ;;did incl answer-button-layout
    ;;   :visible-min-height *info-pane-height
    ;;  :background *fr-border-color
  ;;  :visible-min-height *answer-pane-height
  ;;  :visible-max-height *answer-pane-height
 ;;   :visible-min-width  (- *fr-visible-min-width (* 2 *fr-internal-border)) ;; :visiblel-max-width *answer-pane-width
  ;;  :background  *answer-pane-background
    ) 
  (answer-button-layout
    capi:row-layout
    ()
   :internal-border 10
    :background :yellow ;;*answer-pane-background
   :visible-min-width 500
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
   :layout 'top-row-layout
   :background *fr-border-color
   :title *shaq-frame-title

   ;;end frame-quest-multi-R-interface
   ))
;;TEST
;;  (let ((inst (make-instance 'frame-quest-multi-R-interface))) (capi:display inst))


;;HIGH-ANSWER-BUTTON-INTERFACE
;;
;;ddd
(capi:define-interface frame-tall-multi-answer-button-interface ()
 ;; "In frame-quest-functions.lisp, for MORE buttons, lacks a second top text pane."
  ((selected-item-datalist
    :initarg :selected-item-datalist
    :accessor selected-item-datalist
    :initform nil
    :type :list
    :documentation "Data from selected item")
  (quest-num
    :initarg :quest-num
    :accessor quest-num
    :initform nil
    :type :list
    :documentation "Question number")
  )
  (:panes
   (top-rich-text-pane
    capi:rich-text-pane    :accepts-focus-p NIL  ;;WAS ~%SHAQ SUBPARTS and SCALES first
    :background :light-blue
    ;;no effect :internal-border 20
    :visible-border :default
    :character-format (list :face *title-pane-font-face
                            :size  16  ;;*title-pane-font-size 
                            :color *title-pane-font-color  :bold T :italic nil  :underline nil )
    :paragraph-format  (list :alignment :center  ;; :left :right
                             ;;no effect?  :start-indent 20
                             ;;no effect? :offset-indent 20
                             ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                             :tab-stops  '(5 10 15 20)
                             :numbering nil 
                             ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                             )
    )

   #|(bottom-rich-text-pane
        capi:rich-text-pane
        :text (format nil "")
        :background :yellow
        :character-format (list :face *quest-pane-font-face :size *intro-text-font-size
                                :color *quest-pane-font-color  :bold T :italic nil  :underline nil )
        :paragraph-format '(:alignment :left ;; :center  ;; :left :right
                            ;;  :start-indent 5
                            :offset-indent 10
                            ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                            :tab-stops nil   ;;eg  (10 20 10)
                            :numbering nil 
                            ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                            )
        )|#
   ;;panes--buttons
   (go-fr-button
    capi:push-button
    :background *go-frame-button-background
    :foreground *go-frame-button-foreground
    :text  "GO to NEXT Frame >>"
    :visible-min-width  *go-frame-button-width
    :visible-max-width  *go-frame-button-width
    :visible-min-height  *go-frame-button-height
    :visible-max-height  *go-frame-button-height
    ;;  :external-max-height  *go-frame-button-height   
    #|        :default-x *go-frame-button-x
        :default-y *go-frame-button-y|#
    :font  *go-frame-button-font 
    ;;   :color-requirements 
    ;;   :selected T
    :default-p T  ;;means if return hit, selects this button
    ;;was (gp:make-font-description :size *button-font-size  :weight :bold) ;; :slant :italic)
    :callback 'go-select-scales-frame-callback
    :callback-type :data-interface
    :data *go-next-frame-callback-data
    ;;was (gp:make-font-description :size *button-font-size  :weight :bold) ;; :slant :italic)
    ;;doesn't work    :character-format *title-pane-char-format
    ;;doesn't work?    :x 20   :y 20
    )
   (previous-fr-button
    capi:push-button
    :background :yellow
    :background *previous-frame-button-background
    :text "<< GO to PREVIOUS Frame"
    :internal-min-width  *previous-frame-button-width
    :internal-min-height  *previous-frame-button-height
    :default-x *previous-frame-button-x
    :default-y *previous-frame-button-y
    :font  *previous-frame-button-font
    :callback 'previous-intro-frame-callback
    :callback-type :data-interface
    :data *previous-intro-frame-callback-data
    )
   (quest-rich-text-pane
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format  (list ;;:face *instr-pane-font-face 
                             :size  *instr-pane-font-size  
                             :color *instr-pane-font-color
                             :bold T :italic nil  :underline nil )
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
    :visible-min-height (+ *instr-pane-height 200)
  ;;:visible-max-height *instr-pane-height
    :external-min-width *instr-pane-width ;; :external-max-width *instr-pane-width
 ;;   :foreground *instr-pane-foreground 
    :background *instr-pane-background
 ;;text done elsewhere   :text  (format nil "~%   ~A  " *instr-area-text)
    )

   ;;INSTR-RICH-TEXT-PANE
   (instr-rich-text-pane
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format (list ;;:face *quest-pane-font-face
                            :size *quest-pane-font-size
                            :color *quest-pane-font-color
                            :bold *quest-pane-font-weight
                           :italic nil  :underline nil )
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
    :visible-min-width (- *quest-pane-width 20) ;; :visible-max-width *quest-pane-width
;;    :foreground *quest-pane-foreground 
    :background *quest-pane-background
 ;;   :text *quest-area-text 
    )
             
   ;;end panes
   )
  (:layouts
   (column-layout-1
    capi:column-layout
    '(top-text-layout button-row-layout quest-ans-row-layout))
   ;;each layout
   (top-text-layout
    capi:simple-layout
    '(top-rich-text-pane)
    ;;  :parent 'simple-layout-1
    ;;doesn't work?   :internal-border 40
    :background :light-blue
    :visible-max-height 60
    )
   (button-row-layout
    capi:row-layout
    '(previous-fr-button go-fr-button)
    :internal-border 5
    :visible-min-height 32
    :visible-max-height 32
    :background :red
    :x-gap 340
    )
   ;;QUEST-ANS-ROW-LAYOUT
   (quest-ans-row-layout
    capi:row-layout
    '(quest-rich-text-pane answer-button-layout) 
    ;;   :visible-min-height *info-pane-height
    ;;  :background *fr-border-color
    ;;  :visible-min-height *answer-pane-height
    ;;  :visible-max-height *answer-pane-height
    ;;   :visible-min-width  (- *fr-visible-min-width (* 2 *fr-internal-border)) ;; :visiblel-max-width *answer-pane-width
    ;;  :background  *answer-pane-background
    ) 
   (answer-button-layout
    capi:row-layout
    ()
    :internal-border 10
    :background *answer-pane-background
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
  (:default-initargs
   :internal-border 20
   :background :red
   :visible-min-height 600
   :visible-min-width 860
   :external-border 10 ;;min pixels from edge of screen
   :layout 'column-layout-1
   :title "Success and Happiness Attributes Questionnaire (SHAQ)"
   :x 10
   :y 10
   ;;end default-initargs
   )
  ;;end define-interface  frame-tall-multi-answer-button-interface
  )
;;TEST
;;  (let ((test-inst (make-instance 'frame-tall-multi-answer-button-interface))) (capi:display test-inst))

;;FRAME-XTALL-MULTI-ANSWER-BUTTON-INTERFACE
;;
;;frame with entire side for buttons
;;ddd
(capi:define-interface frame-Xtall-multi-answer-button-interface ()
 ;; "In frame-quest-functions.lisp, for MORE buttons, lacks a second top text pane."
   ((selected-item-datalist
    :initarg :selected-item-datalist
    :accessor selected-item-datalist
    :initform nil
    :type :list
    :documentation "Data from selected item")
  (quest-num
    :initarg :quest-num
    :accessor quest-num
    :initform nil
    :type :list
    :documentation "Question number")
  )
  (:panes
   (title-rich-text-pane
    capi:rich-text-pane    :accepts-focus-p NIL  ;;WAS ~%SHAQ SUBPARTS and SCALES first
    :background  :honeydew1 ;; :lightyellow
    :visible-min-height 80
    :visible-max-height 80
    ;;no effect :internal-border 20
    :visible-border :default
    :character-format (list :face *title-pane-font-face
                            :size  16  ;;*title-pane-font-size 
                            :color *title-pane-font-color  :bold T :italic nil  :underline nil )
    :paragraph-format  (list :alignment :center  ;; :left :right
                             ;;no effect?  :start-indent 20
                             ;;no effect? :offset-indent 20
                             ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                             :tab-stops  '(5 10 15 20)
                             :numbering nil 
                             ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                             )
    )
   
   ;;PANES--BUTTONS
   (go-fr-button
    capi:push-button
    :background *go-frame-button-background
    :foreground *go-frame-button-foreground
    :text  "GO to NEXT Frame >>"
    :visible-min-width  *go-frame-button-width
    :visible-max-width  *go-frame-button-width
    :visible-min-height  *go-frame-button-height
    :visible-max-height  *go-frame-button-height
    ;;  :external-max-height  *go-frame-button-height   
    #|        :default-x *go-frame-button-x
        :default-y *go-frame-button-y|#
    :font  *go-frame-button-font 
    ;;   :color-requirements 
    ;;   :selected T
    :default-p T  ;;means if return hit, selects this button
    ;;was (gp:make-font-description :size *button-font-size  :weight :bold) ;; :slant :italic)
    :callback 'go-multiple-selection-callback ;;'go-select-scales-frame-callback
    :callback-type :data-interface
    :data *go-next-frame-callback-data
    ;;was (gp:make-font-description :size *button-font-size  :weight :bold) ;; :slant :italic)
    ;;doesn't work    :character-format *title-pane-char-format
    ;;doesn't work?    :x 20   :y 20
    )
   (previous-fr-button
    capi:push-button
    :background :yellow
    :background *previous-frame-button-background
    :text "<< GO to PREVIOUS Frame"
    :internal-min-width  *previous-frame-button-width
    :internal-min-height  *previous-frame-button-height
    :default-x *previous-frame-button-x
    :default-y *previous-frame-button-y
    :font  *previous-frame-button-font
    :callback 'previous-intro-frame-callback
    :callback-type :data-interface
    :data *previous-intro-frame-callback-data
    )
   ;;QUEST-RICH-TEXT-PANE
   (quest-rich-text-pane ;;was   instr-rich-text-pane
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format  (list ;;:face *instr-pane-font-face 
                             :size  *instr-pane-font-size  
                             :color *instr-pane-font-color
                             :bold nil  :italic nil  :underline nil )
    :paragraph-format '(:alignment :left   ;; :left :right :center
                         :start-indent 20
                       :offset-indent 20
                        ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                        :tab-stops  '(5 10 15 20)
                        :numbering nil 
                        ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                        )
    :visible-border T
    :internal-border 5
    :visible-min-height (+ *instr-pane-height 200)
  ;;  :visible-max-height (+ *instr-pane-height 200)
  ;;  :external-min-width *instr-pane-width ;; :external-max-width *instr-pane-width
 ;;   :foreground *instr-pane-foreground 
    :background *instr-pane-background
 ;;text done elsewhere   :text  (format nil "~%   ~A  " *instr-area-text)
    )
   (instr-rich-text-pane ;;was quest-rich-text-pane
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format (list ;;:face *quest-pane-font-face
                            :size *quest-pane-font-size
                            :color *quest-pane-font-color
                            :bold *quest-pane-font-weight
                           :italic nil  :underline nil )
    :paragraph-format '(:alignment :left ;; :center  ;; :left :right
                        ;;  :start-indent 5
                        :offset-indent 10
                        ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                        :tab-stops nil   ;;eg  (10 20 10)
                        :numbering nil 
    :background *instr-pane-background
                        ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                        )
  ;;  :visible-border T
    :internal-border 10
  ;;  :visible-min-height *quest-pane-height :visible-max-height *quest-pane-height
;;    :visible-min-width (- *quest-pane-width 20) ;; :visible-max-width *quest-pane-width
;;    :foreground *quest-pane-foreground 
    :background *quest-pane-background
 ;;   :text *quest-area-text 
    )
             
   ;;end panes
   )
  ;;LAYOUTS
  (:layouts
   (frame-row-layout
    capi:row-layout
    '(text-column-layout  answer-button-layout)  ;;was (top-text-layout button-row-layout quest-ans-row-layout))
    )
   ;;LEFT COLUMN FOR TEXT
   (text-column-layout
    capi:column-layout
    '(top-text-layout  text-separator-layout quest-text-layout button-row-layout)
    ;;  :parent 'simple-layout-1
    ;;doesn't work?   :internal-border 40
    :background :red
    )
   (top-text-layout
    capi:simple-layout
    '(title-rich-text-pane)
    )
   
   (text-separator-layout
    capi:simple-layout
    ()
    :background :red
    :visible-max-height 20
    )
   (quest-text-layout
    capi:simple-layout
    '(quest-rich-text-pane)
    :visible-min-height 400
    :background :red
  ;;  :visible-max-height 350
    ) 
   (button-row-layout
    capi:row-layout
    '(button-column-layout button-filler-layout)
    )
   (button-column-layout
    capi:column-layout
    '(go-fr-button previous-fr-button )
    :internal-border 15
    :visible-min-height 70
    :visible-max-height 70
 ;;   :visible-min-width *quest-pane-width 
    :background :red
  ;;  :x-gap 340
  :y-gap 15
    )
   (button-filler-layout
    capi:simple-layout
    ()
    :background :red
  ;;  :visible-min-width 100
    :visible-min-height 40
  ;;  :visible-max-height 
    )   
   ;;RIGHT COLUMN LAYOUT-ANSWERS ONLY
   (answer-button-layout
    capi:row-layout
    ()
    :internal-border 10
    :background *answer-pane-background
    :visible-min-width  *answer-pane-width
    :visible-max-width  *answer-pane-width
#| don't work
    :scroll-if-not-visible-p T
    :scroll-vertical-page-size 700
  ;; :scroll-height 700|#
  
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
  (:default-initargs
   :internal-border 20
   :background :red
   :visible-min-height 640
   :visible-min-width 920
   :external-border 10 ;;min pixels from edge of screen
   :layout 'frame-row-layout
   :title "Success and Happiness Attributes Questionnaire (SHAQ)"
   :x 10
   :y 10
   ;;end default-initargs
   )
  ;;end define-interface  frame-tall-multi-answer-button-interface
  )
;;TEST
;;  (let ((test-inst (make-instance 'frame-Xtall-multi-answer-button-interface))) (capi:display test-inst))








;;xxx
;;================= ADDED FOR CSQ & PC =========================

#|(defun runp3frame ()
  (let
      ((instance (make-instance 'frame-CSQ))
       )
    (capi:display instance)
    ))|#
;; (runp3frame)




;;INTERFACE  FRAME-CSQ
;;
;;ddd
(capi:define-interface frame-CSQ ()
  ((selected-item-datalist
    :initarg :selected-item-datalist
    :accessor selected-item-datalist
    :initform nil
    :type :list
    :documentation "Data from selected item")
  (quest-num
    :initarg :quest-num
    :accessor quest-num
    :initform nil
    :type  :integer
    :documentation "Question number")
  (input-text-list
       :initarg :input-text-list
    :accessor input-text-list
    :initform nil
    :type  :list
    :documentation "List of input-text answers")
  )
  (:PANES
   ;;TITLE-RICH-TEXT-PANE xxx
   (title-rich-text-pane
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format (list ;; :face *title-pane-font-face
                            :size  *title-pane-font-size 
                            :color *title-pane-font-color
                            :bold T :italic nil :underline nil )
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
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format  (list ;; :face *instr-pane-font-face 
                             :size  *instr-pane-font-size  
                             :color *instr-pane-font-color
                             :bold nil :italic nil :underline nil )
    :paragraph-format '(:alignment :center  ;; :left :right
                        :start-indent 20
                        :offset-indent 20
                        ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                        :tab-stops  '(5 10 15 20)
                        :numbering nil 
                        ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                        )
   ;;doesn't work :enabled nil
    :visible-border T
    :internal-border 8
    :visible-min-height *instr-pane-height :visible-max-height *instr-pane-height
    :external-min-width *instr-pane-width ;; :external-max-width *instr-pane-width
    ;;   :foreground *instr-pane-foreground 
    :background *instr-pane-background
    ;;text done elsewhere   :text  (format nil "~%   ~A  " *instr-area-text)
    )

   ;;QUESTION-RICH-TEXT-PANE xxx
   (quest-rich-text-pane
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format (list  ;; :face *quest-pane-font-face
                             :size *quest-pane-font-size
                             :color *quest-pane-font-color
                             :bold *quest-pane-font-weight
                             :italic nil  :underline nil )
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
    :foreground *quest-pane-foreground 
    :background *quest-pane-background
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
   (go-frame-button
        capi:push-button
        :background *go-frame-button-background
        :foreground *go-frame-button-foreground
        :text  "GO to NEXT Frame >>"
        :visible-min-width  *go-frame-button-width
        :visible-max-width  *go-frame-button-width
        :visible-min-height  *go-frame-button-height
        :visible-max-height  *go-frame-button-height
        ;;  :external-max-height  *go-frame-button-height   
#|        :default-x *go-frame-button-x
        :default-y *go-frame-button-y|#
        :font  *go-frame-button-font 
        ;;   :color-requirements 
        ;;   :selected T
        :default-p T  ;;means if return hit, selects this button
        ;;was (gp:make-font-description :size *button-font-size  :weight :bold) ;; :slant :italic)
        :callback 'text-go-button-callback
        :callback-type :data-interface
        :data *text-go-button-callback
        ;;was (gp:make-font-description :size *button-font-size  :weight :bold) ;; :slant :italic)
        ;;doesn't work    :character-format *title-pane-char-format
        ;;doesn't work?    :x 20   :y 20
        )

   ;;ADDEDfor CSC--REMOVE IF LEARN HOW TO ADD ON FLY
   ;;FOR TITLES
   (rich-text-pane-1
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format (list  ;; :face *quest-pane-font-face
                             :size *quest-pane-font-size
                             :color *quest-pane-font-color
                             :bold *quest-pane-font-weight
                             :italic nil  :underline nil )
    :paragraph-format '(:alignment :left ;; :center  ;; :left :right
                        ;;  :start-indent 5
                       ;; :offset-indent 10
                        ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                        :tab-stops nil   ;;eg  (10 20 10)
                        :numbering nil 
                        ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                        )
    :visible-border NIL
    :accepts-focus-p NIL
    ;;:internal-border 20
    ;;  :visible-min-height *quest-pane-height
    :visible-max-height 40 ;; *quest-pane-height
    :visible-min-width *quest-pane-width ;; :visible-max-width *quest-pane-width
    :foreground *answer-pane-foreground 
    :background *answer-pane-background
    ;;   :text *quest-area-text 
    )
   (rich-text-pane-2
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format (list  ;; :face *quest-pane-font-face
                             :size *quest-pane-font-size
                             :color  :black ;;*quest-pane-font-color
                             :bold *quest-pane-font-weight
                             :italic nil  :underline nil )
    :paragraph-format '(:alignment :left ;; :center  ;; :left :right
                        ;;  :start-indent 5
                       ;;  :offset-indent 10
                        ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                        :tab-stops nil   ;;eg  (10 20 10)
                        :numbering nil 
                        ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                        )
    :visible-border NIL
    :accepts-focus-p NIL
    ;; :internal-border 20
    ;;  :visible-min-height *quest-pane-height
    :visible-max-height 40 ;;*quest-pane-height
    :visible-min-width *quest-pane-width ;; :visible-max-width *quest-pane-width
    :foreground *answer-pane-foreground 
    :background *answer-pane-background
    ;;   :text *quest-area-text 
    ) 
   (rich-text-pane-3
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format (list  ;; :face *quest-pane-font-face
                             :size *quest-pane-font-size
                             :color  :black ;;*quest-pane-font-color
                             :bold *quest-pane-font-weight
                             :italic nil  :underline nil )
    :paragraph-format '(:alignment :left ;; :center  ;; :left :right
                        ;;  :start-indent 5
                       ;; :offset-indent 10
                        ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                        :tab-stops nil   ;;eg  (10 20 10)
                        :numbering nil 
                        ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                        )
    :visible-border NIL
    :accepts-focus-p NIL
    ;; :internal-border 20
    ;;  :visible-min-height *quest-pane-height :visible-max-height *quest-pane-height
    :visible-min-width *quest-pane-width ;; :visible-max-width *quest-pane-width
    :visible-max-height 40
    :foreground *answer-pane-foreground 
    :background *answer-pane-background
    ;;   :text *quest-area-text 
    )
   ;;TEXT-INPUT-PANES
   (text-input-pane-1
    capi:text-input-pane
    :take-focus T
  ;;was  :title *compare-pc-element-input-pane1-title done in make-text-input-frame
    :internal-border 10
    )
   (text-input-pane-2
    capi:text-input-pane
  ;;was  :title *compare-pc-element-input-pane2-title done in make-text-input-frame
    :internal-border 10
    )
   (simple-pane-1
    capi:simple-pane
    :background *fr-border-color
    :foreground *fr-border-color
    :internal-border nil
    :visible-border nil
    )
   (simple-pane-2
    capi:simple-pane
    :visible-min-height 150
    :background *answer-pane-background
    :foreground *answer-pane-background
    )
#|   (simple-pane-3
    capi:simple-pane
    :visible-min-height 10
    :background *answer-pane-background
    :foreground *answer-pane-background
    )
   (simple-pane-4
    capi:simple-pane
    :visible-min-height 10
    :background *answer-pane-background
    :foreground *answer-pane-background
    )|#

   ;;BUTTON PANES
#|   (alike-button-panel
    capi:check-button-panel
    :items *element-button-items
    :title "1b. Check the 2 that are ALIKE: "
        :internal-border 10
    )|#
   (dif-button-panel
    capi:radio-button-panel
    :items *element-button-items  
    :title "2b. Check the one that is DIFFERENT: "
    :internal-border 10
    )
   ;;initial panel args= (:CALLBACK-TYPE :ALTERNATIVE-ACTION-CALLBACK :ACTION-CALLBACK :RETRACT-CALLBACK :EXTEND-CALLBACK :SELECTION-CALLBACK :ITEMS :TEST-FUNCTION :KEY-FUNCTION :ITEMS-CALLBACK :DATA-FUNCTION :PRINT-FUNCTION :ITEMS-MAP-FUNCTION :ITEMS-GET-FUNCTION :ITEMS-COUNT-FUNCTION :DO-CACHE :ALTERNATING-BACKGROUND :SELECTED-ITEMS :SELECTED-ITEM :SELECTION :FOCUS-ITEM :INITIAL-FOCUS-ITEM :KEEP-SELECTION-P :INTERACTION :FILTER :MESSAGE :MESSAGE-ARGS :MESSAGE-FONT :MESSAGE-GAP :MNEMONIC-TITLE :MNEMONIC :TITLE :TITLE-ARGS :TITLE-FONT :BUTTONS :TOOLBAR :TITLE-ADJUST :TITLE-GAP :TITLE-POSITION :PLIST ...)
   (bestpole-button-panel
    capi:radio-button-panel
    :items *bestpole-button-items
   ;; :title "Which of the above 2 ways (way alike or way different) is BETTER (you value most)?"
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
     '(previous-frame-button simple-pane-1  go-frame-button)    ;;left-button-filler-pane
  ;;  :visible-border *button-panel-visible-border
    :background *button-panel-background 
    :visible-min-height (- *button-pane-height 10)
    :visible-max-height (- *button-pane-height 10)
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
    :background *answer-pane-background
    :foreground *answer-pane-foreground
    )
  ;;ADDED FOR CSQ
  (answer-column-layout
    capi:column-layout
    ()
    :internal-border 10
    :background *answer-pane-background
    :foreground *answer-pane-foreground
    :visible-min-width 150
    :visible-min-height 200
    )
   ;;end layouts
   )
  ;;MENUS
  (:menu-bar help-menu )
  (:menus
   (help-menu
    "CSQ Help"
    (
     ("Help"
      :callback 'CSQ-help-callback
      :callback-type :interface
      )
     ("Question Help"
      :callback 'question-help-callback
      :callback-type :interface
      )
     ("SAVING Your CSQ Results"
      :callback 'CSQ-saving-results-help-callback
      :callback-type :interface
      )
     ("Your CSQ Results Help"
      :callback 'CSQ-results-help-callback
      :callback-type :interface
      )
     ("Close"
      :callback 'close-frame-callback
      :callback-type :interface
      )
     ("Exit CSQ"
      :callback 'exit-CSQ-callback
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
   :title *CSQ-frame-title
   )
  ;;END FRAME-CSQ
  )








;;CSQPC-LOAD-SOURCE-CALLBACK
;; replaced by the go-button callback
;;
;;ddd
#|(defun csqpc-load-source-callback (data interface)
  "In CSQ-SHAQ-Frames, selects previous user data source (or none for new user restart). *csq-load-user-data-options = (\"1. Load last user data\" \"2. Start user data from beginning.\" \"3. Load another user data source\")"
  ;;(break "data")
  (setf *text-input-OR-button-interface-textdata nil)
  (cond
   ((string-equal data (first *csq-load-user-data-options) )               
    (setf  *csq-previous-data-file  *save-all-csq-data-file))
   ((string-equal data (second *csq-load-user-data-options) )               
    (setf  *csq-previous-data-file NIL))
   ;;to type in pathname of saved user data
   ((string-equal data (third *csq-load-user-data-options))   
    (make-text-input-OR-button-interface-instance :title "PATHNAME for Previous data file" :instr-text "Type PATHNAME for previous user data file below:" :confirm-input-p T :poke-process (mp:get-current-process ))

    (mp:current-process-pause 300)
    (setf  *csq-previous-data-file *text-input-OR-button-interface-textdata)
    ;;do in above callback (setf  *csq-previous-data-file 
    )
   (t NIL))
           
 ;;;END AND POKE
#|  moved to go-button     (capi:destroy interface)
      (when *run-csq-p
        (mp:process-poke *csq-main-process))
      (when *run-shaq-p
        (mp:process-poke *shaq-main-process))|#
  )|#







;;MAKE-NEW-COMBOS-CALLBACK
;;
;;ddd
(defun make-new-combos-callback (data interface)
  " Causes *use-existing-elmsym-combos set to NIL "
  (when data
    (setf *use-existing-elmsym-combos nil))

  ;; don't close interface here
 ;;;END AND POKE
#|      (capi:destroy interface)
      (when *run-csq-p
        (mp:process-poke *csq-main-process))
      (when *run-shaq-p
        (mp:process-poke *shaq-main-process))|#
  )



















;; OLD FRAME-QUEST-MULTI-R-INTERFACE
;;
;;ddd
#|(capi:define-interface frame-quest-multi-R-interface ()
  ()
  (:PANES
   ;;TITLE-RICH-TEXT-PANE xxx
   (title-rich-text-pane
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format (list :face *title-pane-font-face
                            :size  *title-pane-font-size 
                            :color *title-pane-font-color  :bold T :italic nil  :underline nil )
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
    :visible-min-height *title-pane-height :visible-max-height *title-pane-height
    :external-min-width *title-pane-width  ;; :external-max-width *title-pane-width
;;    :foreground *title-pane-foreground 
    :background *title-pane-background
   :text *title-area-text 
    )
   ;;INSTR-RICH-TEXT-PANE
   (instr-rich-text-pane
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format  (list :face *instr-pane-font-face 
                             :size  *instr-pane-font-size  
                             :color *instr-pane-font-color
                             :bold nil:italic nil  :underline nil )
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
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format (list :face *quest-pane-font-face :size *quest-pane-font-size
                            :color *quest-pane-font-color  :bold nil:italic nil  :underline nil )
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
    capi:check-button-panel
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
   ;;end panes
   )
   
  (:layouts
   ;;overall, column layout, 5 rows.
   (column-layout-1
    capi:column-layout ;; capi:grid-layout
    '(row-layout-1 row-layout-2 button-row-layout  row-layout-3) 
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
   ;;fourth row -- question text and answer buttons/text
   (row-layout-4
    capi:row-layout
    '( quest-rich-text-pane  answer-column-layout) ;;was answer-button-panel)
    ;;   :visible-min-height *info-pane-height
    ;;  :background *fr-border-color
    ) 
   (answer-column-layout
    capi:column-layout
    '(answer-button-panel)
    :visible-min-height *answer-pane-height :visible-max-height *answer-pane-height
    :visible-min-width *answer-pane-width ;; :visiblel-max-width *answer-pane-width
    :background *answer-pane-background
    )
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
   ))|#

#| older(capi:define-interface frame-quest-multi-R-interface ()
  ()
  (:PANES
   ;;TITLE-RICH-TEXT-PANE xxx
   (title-rich-text-pane
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format (list :face "times new roman"
                            :size  *title-pane-font-size 
                            :color *title-pane-font-color  :bold T :italic nil  :underline nil )
    :paragraph-format  (list :alignment :center  ;; :left :right
                             ;;  :start-indent 5
                             :offset-indent 20
                             ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                             :tab-stops nil   ;;eg  (10 20 10)
                             :numbering nil 
                             ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                             )
    :visible-border T
;;    :internal-border 20
    :visible-min-height *title-pane-height :visible-max-height *title-pane-height
    :external-min-width *title-pane-width  ;; :external-max-width *title-pane-width
;;    :foreground *title-pane-foreground 
    :background *title-pane-background
    :text *title-area-text 
    )
   ;;INSTR-RICH-TEXT-PANE
   (instr-rich-text-pane
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format  (list :face "times new roman" :size  *instr-pane-font-size                         :color *instr-pane-font-color
                             :bold T :italic nil  :underline nil )
    :paragraph-format '(:alignment :center  ;; :left :right
                        ;;  :start-indent 5
                        :offset-indent 20
                        ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                        :tab-stops nil   ;;eg  (10 20 10)
                        :numbering nil 
                        ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                        )
    :visible-border T
;;    :internal-border 20
    :visible-min-height *instr-pane-height :visible-max-height *instr-pane-height
    :external-min-width *instr-pane-width ;; :external-max-width *instr-pane-width
;;    :foreground *instr-pane-foreground 
    :background *instr-pane-background
    :text *instr-area-text 
    )

   ;;QUESTION-RICH-TEXT-PANE xxx
   (quest-rich-text-pane
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format (list :face "times new roman" :size *quest-pane-font-size
                            :color *quest-pane-font-color  :bold T :italic nil  :underline nil )
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
;;    :foreground *quest-pane-foreground 
    :background *quest-pane-background
    :text *quest-area-text 
    )

   ;;ANSWER-BUTTON-PANEL xxx
   ;;SSS START HERE MAKING MODEL RADIO-BUTTON-PANEL
   (answer-button-panel
    capi:radio-button-panel
    #|    :character-format '(:face "times new roman" :size 12 ;;error  *pane3-font-size
                        :color :black :bold T :italic nil  :underline nil )
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
    )
  
   ;;PANES--PUSH-BUTTON-PANEL xxx ACTUALLY A ROW-LAYOUT
   
   ;;PANES--BUTTONS ;;yyy
   (go-frame-button
    capi:push-button
    :background *go-frame-button-background
    :foreground *go-frame-button-foreground
    :text  *go-frame-button-text
    :internal-min-width  *go-frame-button-width
     :internal-max-width  *go-frame-button-width
    :internal-min-height  *go-frame-button-height
    :internal-max-height  *go-frame-button-height
     :external-min-width  (+ *go-frame-button-width 10)
    ;; :external-max-width  *go-frame-button-width
    :external-min-height  (+ *go-frame-button-height 10)
  ;;  :external-max-height  *go-frame-button-height   
    :default-x *go-frame-button-x
    :default-y *go-frame-button-y
    :font  *go-frame-button-font 
 ;;   :color-requirements 
    :selected T
    :default-p T  ;;means if return hit, selects this button
    ;;    :callback 'go-frame-callback
    ;;    :callback-type :interface
    ;;was (gp:make-font-description :size *button-font-size  :weight :bold) ;; :slant :italic)
    ;;doesn't work    :character-format *title-pane-char-format
    ;;doesn't work?    :x 20   :y 20
    ;; :button-group
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
    ;; :callback 'previous-quest-frame-callback
    ;;  :callback-type :interface
    ;;was (gp:make-font-description :size *button-font-size  :weight :bold) ;; :slant :italic)
    ;;doesn't work    :character-format *title-pane-char-format
    ;;doesn't work?    :x 20   :y 20
    )
   (exit-shaq-button
    capi:push-button
    :background *exit-shaq-button-background
    :text  *exit-shaq-button-text
    :internal-min-width  *exit-shaq-button-width
    :internal-min-height  *exit-shaq-button-height
    :default-x *exit-shaq-button-x
    :default-y *exit-shaq-button-y
    :font  *exit-shaq-button-font
    :callback 'interface-close-callback
    :callback-type :interface
    ;;was (gp:make-font-description :size *button-font-size  :weight :bold) ;; :slant :italic)
    ;;doesn't work    :character-format *title-pane-char-format
    ;;doesn't work?    :x 20   :y 20
    )
   (left-button-filler-pane
    capi:simple-pane
    :background *exit-shaq-button-background
    :visible-min-width *left-button-filler-pane-width
    :visible-border nil
    )

   ;;end panes
   )
  (:layouts
   ;;overall, column layout, 5 rows.
   (column-layout-1
    capi:column-layout ;; capi:grid-layout
    '( row-layout-1 row-layout-2 button-row-layout  row-layout-4) 
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
     '( previous-frame-button  go-frame-button)    ;;left-button-filler-pane
  ;;  :visible-border *button-panel-visible-border
    :background *button-panel-background 
    :visible-min-height *button-pane-height
    :visible-min-width *button-pane-width
    ;;  :x-adjust :center
    :y-adjust :center
    :x-ratios '(1.0   1.5)
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
   ;;fourth row -- question text and answer buttons/text
   (row-layout-4
    capi:row-layout
    '( quest-rich-text-pane answer-button-panel)
    ;;   :visible-min-height *info-pane-height
    ;;  :background *fr-border-color
    ) 
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
   ))|#

;;(capi:display (make-instance 'frame-interface))

;;test
#|
(defun testf2 ()
  (let
      ((frame-inst1 (make-instance 'frame-question-interface)) 
       (frame-inst2)
    )
  ;;  (setf *info-pane-height 350)
    (capi:display frame-inst1)

    ;;TEST LATER
    ;;now change the color
#|    (setf   *fr-border-color :green)
   (setf  *title-area-text (format nil "~%NEW SHAQ TITLE TEXT GOES HERE"))
   (setf  *info-area-text (format nil "~%~%This is NEW test text, SHAQ info text goes here.")) 
    (setf frame-inst2 (make-instance 'frame-interface))
    (capi:display frame-inst2)
    |#
  ))
|#



  



;;hhh -------------------------------- HELP ---------------------------------------

;;following works 
#|(capi:contain
 (make-instance 'capi:title-pane
                :text "A title pane"
                :font (gp:make-font-description
                       :family "Times"
                       :size 12
                       :weight :medium
                       :slant :roman)))|#

;; CAPI:APPLY-IN-PANE-PROCESS  EXAMPLE
;;from capi ref
#|(setq EDITOR
      (capi:contain
       (make-instance 'capi:editor-pane
                      :text "Once upon a time...")))
(CAPI:APPLY-IN-PANE-PROCESS  EDITOR
                             'capi:call-editor editor "End Of Buffer")
(CAPI:APPLY-IN-PANE-PROCESS  editor
                             'capi:call-editor editor "Beginning Of Buffer")
|#


#|
It is very important that users do not see any checked buttons before
 they make their own choices—NO DEFAULT SELECTION.
(defun test ()
  (let ((panel (make-instance 'capi:radio-button-panel :items '("He" "She" "They"))))
    (setf (capi:choice-selected-item panel) nil)
    (capi:contain panel)))
;;XXX
;;CREATING A BUTTON PANEL FROM FUNCTION (WITH NO DEFAULT SELECTION)
;;IF INSIDE A FUNCTION CREATING AN INTERFACE INSTANCE,
      (with-slots (answer-button-panel)  q-frame-inst
        ;;MAKE THE  BUTTON PANEL
      (setf answer-button-panel (make-radio-button-panel ans-instruction-text answer-array-list))
      ;;Put the BUTTON IN THE ALREADY CREATED FRAME
      (capi:apply-in-pane-process answer-column-layout
                                  #'(setf capi:layout-description)
                                          (list answer-button-panel)                                            
                                          answer-column-layout)
      ;;This SETS PREVENTS A DEFAULT SELECTION from being checked
      (capi:apply-in-pane-process answer-column-layout
                                  #'(setf CAPI:CHOICE-SELECTED-ITEM)
                                          (list nil)                                            
                                          answer-button-panel)
  ;;model  (setf (capi:choice-selected-item answer-button-panel) nil)
|#

;;from interface builder
#|
(capi:define-interface interface-3 ()
  ()
  (:panes
   (editor-pane-1
    capi:editor-pane)
   (push-button-panel-1
    capi:push-button-panel
    :items '("Push-Button-Panel-1" "Button 2" "Button 3")
    :max-width t
    :max-height t)
   (editor-pane-2
    capi:editor-pane))
  (:layouts
   (grid-layout-1
    capi:grid-layout
    '(simple-layout-1 simple-layout-2 simple-layout-3))
   (simple-layout-1
    capi:simple-layout
    '(editor-pane-1))
   (simple-layout-2
    capi:simple-layout
    '(push-button-panel-1))
   (simple-layout-3
    capi:simple-layout
    '(editor-pane-2)))
  (:default-initargs
   :best-height 300
   :best-width 458
   :layout 'grid-layout-1
   :title "Interface-3"))
|#


;;ALL RICH-TEXT-PANE INITARGS 
#|
:ACCEPTS-FOCUS-P
:AUTOMATIC-RESIZE
:BACKGROUND  X
:CHANGE-CALLBACK
:CHARACTER-FORMAT
:COLOR-REQUIREMENTS
:CONTROL-ID
:CURSOR
:DEFAULT-BACKGROUND
:DEFAULT-HEIGHT
:DEFAULT-WIDTH
:DEFAULT-X
:DEFAULT-Y
:DRAG-CALLBACK
:DROP-CALLBACK
:ENABLED
:EXTERNAL-HEIGHT
:EXTERNAL-MAX-HEIGHT
:EXTERNAL-MAX-WIDTH
:EXTERNAL-MIN-HEIGHT
:EXTERNAL-MIN-WIDTH
:EXTERNAL-WIDTH
:FILENAME
:FONT  X
:FOREGROUND
:HEIGHT
:HELP-KEY
:HORIZONTAL-SCROLL
:INITIAL-CONSTRAINTS
:INTERFACE
:INTERNAL-BORDER
:INTERNAL-MAX-HEIGHT
:INTERNAL-MAX-WIDTH
:INTERNAL-MIN-HEIGHT X
:INTERNAL-MIN-WIDTH  X
:MAX-HEIGHT (DEPRECIATED?)
:MAX-WIDTH  (DEPRECIATED?)
:MIN-HEIGHT  (DEPRECIATED?)
:MIN-WIDTH  (DEPRECIATED?)
:NAME
:PANE-MENU
:PARAGRAPH-FORMAT
:PARENT
:PLIST
:PROTECTED-CALLBACK
:SCROLL-CALLBACK
:SCROLL-HEIGHT
:SCROLL-HORIZONTAL-PAGE-SIZE
:SCROLL-HORIZONTAL-SLUG-SIZE
:SCROLL-HORIZONTAL-STEP-SIZE
:SCROLL-IF-NOT-VISIBLE-P
:SCROLL-INITIAL-X
:SCROLL-INITIAL-Y
:SCROLL-START-X
:SCROLL-START-Y
:SCROLL-VERTICAL-PAGE-SIZE
:SCROLL-VERTICAL-SLUG-SIZE
:SCROLL-VERTICAL-STEP-SIZE
:SCROLL-WIDTH
:TAKE-FOCUS
:TEXT
:TEXT-LIMIT
:TOOLBAR-CALLBACK
:TOOLBAR-TITLE
:VERTICAL-SCROLL
:VISIBLE-BORDER X
:VISIBLE-HEIGHT
:VISIBLE-MAX-HEIGHT
:VISIBLE-MAX-WIDTH
:VISIBLE-MIN-HEIGHT
:VISIBLE-MIN-WIDTH
:VISIBLE-WIDTH
:WIDGET-NAME
:WIDTH
:WINDOW-STYLES X
:X
:Y
|#



;;XXX
;;RICH-TEXT-PANE
#|
INITARGS
 :character-format A plist.
:paragraph-format A plist.
:change-callback A function called when a change is made.
:protected-callback A function determining whether the user
may edit a protected part of the text, on Microsoft Windows.
:filename A file to display.
:text A string or nil.
:text-limit An integer.

ACCESSORS 
rich-text-pane-change-callback
rich-text-pane-limit
rich-text-pane-text

DESCRIPTION The class rich-text-pane provides a text editor which supports
character and paragraph formatting of its text.
character-format is the default character format. It is a plist
which is interpreted in the same way as the attributes-plist
argument of set-rich-text-pane-character-format. The
default value of character-format is nil.
paragraph-format is the default paragraph
|#
;;XXX IMPORTANT -- NON-INITARG MODIFICATIONS OF RTFs
#|
3. The functions that are specific to rich-text-pane CANNOT
BE CALLED BEFORE THE PANE IS CREATED.
If you need to perform OPERATIONS ON THE PANE BEFORE IT APPEARS, 
and which cannot be performed using the initargs, the best approach
is to DEFINE AN :AFTER METHOD ON INTERFACE-DISPLAY
on the class of the interface containing the rich-textpane,
and perform the operations inside this method.
|#
;;
;;XXX
;;SET-RICH-TEXT-PANE-CHARACTER-FORMAT Function
#|
If there is a current selection in the pane, then the attributes
are set for the selected text. If there is no selection, then it sets
the "typing attributes", which are applied to characters that
are typed by the user. Note that any cursor movement
changes these attributes, so the setting is ephemeral.
The selection argument is deprecated. If selection is nil an
error is signalled. The default value of selection is t.
If attributes-plist is the symbol :default then the default
character format of the pane (that is, the value of the richtext-
pane initarg :character-format) is used. Otherwise
attributes-plist is a plist of keywords and values. These are the
valid keywords on Microsoft Windows and Cocoa:
:bold A boolean.
:italic A boolean.
:underline A boolean.
:face A string naming a font.
:color A color spec or alias specifying the foreground
color.
:size The size of the font.
Additionally these attributes-plist keywords are valid on
Microsoft Windows only:
:strikeout A boolean.
|#

;;EXAMPLE
#|
(defun ok-to-edit-p (pane start end s)
  (declare (ignore pane))
  (capi:prompt-for-confirmation
   (format nil "Editing~:[ ~; selection ~]from ~a to ~a"
           s start end)))
(setq rtp
      (capi:contain
       (make-instance
        'capi:rich-text-pane
        :protected-callback 'ok-to-edit-p
        :character-format
        '(:size 14 :color :red)
        :visible-min-height 300
        :visible-min-width 400
        :paragraph-format
        '(:start-indent 20 :offset -15)
        :text-limit 160
        :text (format nil "First paragraph.~%Second
paragraph, a little longer.~%Another paragraph, which
should be long long enough that it spans more than one
line. ~%" ))))
|#

;;FROM CAPI REF P 566
;;
;;SET-RICH-TEXT-PANE-PARAGRAPH-FORMAT
;;xxx
#|
Summary Sets the paragraph format.
Package capi
Signature set-rich-text-pane-paragraph-format pane attributesplist
=> result
ARGUMENTS pane A rich-text-pane.

ATTRIBUTESPLIST A plist, or :default.
Values result A plist.
DESCRIPTION The function set-rich-text-pane-paragraph-format sets
paragraph attributes for the current paragraphs in pane.
The current paragraphs are those paragraphs which overlap
the current selection, or the paragraph containing the insertion
point if there is no selection.
539
If attributes-plist is the symbol :default then the default
paragraph format of the pane is used. Otherwise
 ATTRIBUTESPLIST
is a plist of keywords and values. These are the valid
KEYWORDS ON MICROSOFT WINDOWS and Cocoa:
:ALIGNMENT :left, :right or :center.
:START-INDENT A number setting the indentation.
:OFFSET-INDENT A number modifying the indentation.
:OFFSET A number setting the relative indentation of SUBSEQUENT LINES in a paragraph.
:RIGHT-INDENT A number setting the right margin.
:TAB-STOPS A list of numbers.
Additionally this attributes-list keyword is valid on Microsoft
Windows, only: :numbering nil, t,  :bullet, :arabic, :lowercase, :uppercase, :lower-roman or :upper-roman.
NUMBERING specifies the numbering style. Rich Edit 3.0 supports
all the above values of numbering. Please note that the
ARABIC AND ROMAN STYLES START NUMBERING FROM ZERO, and that
only t and :bullet work with versions of Rich Edit before
3.0 (other values of numbering are quietly ignored).
start-indent specifies the indentation of the first line of a paragraph.
A NEGATIVE VALUE REMOVES THE INDENTATION.

OFFSET-INDENT takes effect only when start-indent is not passed.
It specifies an increase in the current indentation. Therefore, a
negative value of offset-indent decreases the indentation.
offset specifies the offset of the second and following lines relative
to the first line of the paragraph. That is, when the
indentation of the first line is indent, the indentation of the
second and subsequent lines is indent + offset. When offset is
negative, the second and subsequent lines are indented less
than the first line.
 If INDENT + OFFSET IS NEGATIVE, then these lines are not indented.
TAB-STOPS should be a list of numbers specifiying the locations of tabs. 
No more than 32 tabs are allowed.
EXAMPLE 
         (setq rtp
              (capi:contain
               (make-instance
                'capi:rich-text-pane
                :visible-min-height 300
                :visible-min-width 400
                :paragraph-format
                '(:start-indent 20 :offset -15)
                :text (format nil "First paragraph.~%Second
paragraph, a little longer.~%Another paragraph, which
should be long long enough that it spans more than one
line. ~%" ))))
(capi:set-rich-text-pane-paragraph-format
rtp '(:offset-indent 30 :numbering :lowercase))
;;end set-rich-text-pane-paragraph-format function
|#

#|
PUSH BUTTON PANEL 
INITARGS
:ACCEPTS-FOCUS-P
:ACTION-CALLBACK
:ALTERNATING-BACKGROUND
:ALTERNATIVE-ACTION-CALLBACK
:ARMED-IMAGES
:AUTOMATIC-RESIZE
:BACKGROUND
:BUTTON-CLASS
:BUTTONS
:CALLBACK-TYPE
:CALLBACKS
:CANCEL-BUTTON
:COLOR-REQUIREMENTS
:CONTROL-ID
:CURSOR
:DATA-FUNCTION
:DEFAULT-BACKGROUND
:DEFAULT-BUTTON
:DEFAULT-HEIGHT
:DEFAULT-WIDTH
:DEFAULT-X 
:DEFAULT-Y
:DISABLED-IMAGES
:DO-CACHE
:DRAG-CALLBACK
:DROP-CALLBACK
:ENABLED
:EXTEND-CALLBACK
:EXTERNAL-HEIGHT
:EXTERNAL-MAX-HEIGHT
:EXTERNAL-MAX-WIDTH
:EXTERNAL-MIN-HEIGHT
:EXTERNAL-MIN-WIDTH
:EXTERNAL-WIDTH
:FILTER
:FOCUS-ITEM
:FONT
:FORCE-WINDOW-HANDLE
:FOREGROUND
:HEIGHT
:HELP-KEY
:HELP-KEYS
:HORIZONTAL-SCROLL
:IMAGES
:INDICATOR
:INITIAL-CONSTRAINTS
:INITIAL-FOCUS
:INITIAL-FOCUS-ITEM
:INTERACTION
:INTERFACE
:INTERNAL-BORDER
:INTERNAL-MAX-HEIGHT
:INTERNAL-MAX-WIDTH
:INTERNAL-MIN-HEIGHT
:INTERNAL-MIN-WIDTH
:ITEMS
:ITEMS-CALLBACK
:ITEMS-COUNT-FUNCTION
:ITEMS-GET-FUNCTION
:ITEMS-MAP-FUNCTION
:KEEP-SELECTION-P
:KEY-FUNCTION
:LAYOUT
:LAYOUT-ARGS
:LAYOUT-CLASS
:MAX-HEIGHT
:MAX-WIDTH
:MESSAGE
:MESSAGE-ARGS
:MESSAGE-FONT
:MESSAGE-GAP
:MIN-HEIGHT
:MIN-WIDTH
:MNEMONIC
:MNEMONIC-ESCAPE
:MNEMONIC-ITEMS
:MNEMONIC-TITLE
:MNEMONICS
:NAME
:NAMES
:PANE-MENU
:PARENT
:PLIST
:PRINT-FUNCTION
:RETRACT-CALLBACK
:SCROLL-CALLBACK
:SCROLL-HEIGHT
:SCROLL-HORIZONTAL-PAGE-SIZE
:SCROLL-HORIZONTAL-SLUG-SIZE
:SCROLL-HORIZONTAL-STEP-SIZE
:SCROLL-IF-NOT-VISIBLE-P
:SCROLL-INITIAL-X
:SCROLL-INITIAL-Y
:SCROLL-START-X
:SCROLL-START-Y
:SCROLL-VERTICAL-PAGE-SIZE
:SCROLL-VERTICAL-SLUG-SIZE
:SCROLL-VERTICAL-STEP-SIZE
:SCROLL-WIDTH
:SELECTED-DISABLED-IMAGES
:SELECTED-IMAGES
:SELECTED-ITEM
:SELECTED-ITEMS
:SELECTION
:SELECTION-CALLBACK
:STOCK-IDS
:TAKE-FOCUS
:TEST-FUNCTION
:TITLE
:TITLE-ADJUST
:TITLE-ARGS
:TITLE-FONT
:TITLE-GAP
:TITLE-POSITION
:TOOLBAR
:TOOLBAR-CALLBACK
:TOOLBAR-TITLE
:VERTICAL-SCROLL
:VISIBLE-BORDER
:VISIBLE-HEIGHT
:VISIBLE-MAX-HEIGHT
:VISIBLE-MAX-WIDTH
:VISIBLE-MIN-HEIGHT
:VISIBLE-MIN-WIDTH
:VISIBLE-WIDTH
:WIDGET-NAME
:WIDTH
:WINDOW-STYLES
:X
:Y
|#


;;xxx
;; PUSH-BUTTON  INIT-ARGS
#|
:ACCEPTS-FOCUS-P
:ACTION-CALLBACK
:ALTERNATE-CALLBACK
:ALTERNATIVE-ACTION-CALLBACK
:ARMED-IMAGE
:AUTOMATIC-RESIZE
:BACKGROUND
:BEZEL-STYLE
:BUTTON-GROUP
:BUTTONS
:CALLBACK
:CALLBACK-TYPE
:CANCEL-P
:COLLECTION
:COLOR-REQUIREMENTS
:CONTROL-ID
:CURSOR
:DATA
:DATA-FUNCTION
:DEFAULT-BACKGROUND
:DEFAULT-HEIGHT
:DEFAULT-P
:DEFAULT-WIDTH
:DEFAULT-X
:DEFAULT-Y
:DISABLED-IMAGE
:DRAG-CALLBACK
:DROP-CALLBACK
:ENABLED
:EXTEND-CALLBACK
:EXTERNAL-HEIGHT
:EXTERNAL-MAX-HEIGHT
:EXTERNAL-MAX-WIDTH
:EXTERNAL-MIN-HEIGHT
:EXTERNAL-MIN-WIDTH
:EXTERNAL-WIDTH
:FILTER
:FONT
:FOREGROUND
:HEIGHT
:HELP-KEY
:HORIZONTAL-SCROLL
:IMAGE
:INDICATOR
:INITIAL-CONSTRAINTS
:INTERACTION
:INTERFACE
:INTERNAL-BORDER
:INTERNAL-MAX-HEIGHT
:INTERNAL-MAX-WIDTH
:INTERNAL-MIN-HEIGHT
:INTERNAL-MIN-WIDTH
:KEY-FUNCTION
:MAX-HEIGHT
:MAX-WIDTH
:MESSAGE
:MESSAGE-ARGS
:MESSAGE-FONT
:MESSAGE-GAP
:MIN-HEIGHT
:MIN-WIDTH
:MNEMONIC
:MNEMONIC-ESCAPE
:MNEMONIC-TEXT
:MNEMONIC-TITLE
:NAME
:PANE-MENU
:PARENT
:PLIST
:PRESS-CALLBACK
:PRINT-FUNCTION
:RETRACT-CALLBACK
:SCROLL-CALLBACK
:SCROLL-HEIGHT
:SCROLL-HORIZONTAL-PAGE-SIZE
:SCROLL-HORIZONTAL-SLUG-SIZE
:SCROLL-HORIZONTAL-STEP-SIZE
:SCROLL-IF-NOT-VISIBLE-P
:SCROLL-INITIAL-X
:SCROLL-INITIAL-Y
:SCROLL-START-X
:SCROLL-START-Y
:SCROLL-VERTICAL-PAGE-SIZE
:SCROLL-VERTICAL-SLUG-SIZE
:SCROLL-VERTICAL-STEP-SIZE
:SCROLL-WIDTH
:SELECTED
:SELECTED-DISABLED-IMAGE
:SELECTED-IMAGE
:SELECTION-CALLBACK
:STOCK-ID
:TAKE-FOCUS
:TEXT
:TEXT-ALIGNMENT
:TITLE
:TITLE-ADJUST
:TITLE-ARGS
:TITLE-FONT
:TITLE-GAP
:TITLE-POSITION
:TOOLBAR
:TOOLBAR-CALLBACK
:TOOLBAR-TITLE
:VERTICAL-SCROLL
:VISIBLE-BORDER
:VISIBLE-HEIGHT
:VISIBLE-MAX-HEIGHT
:VISIBLE-MAX-WIDTH
:VISIBLE-MIN-HEIGHT
:VISIBLE-MIN-WIDTH
:VISIBLE-WIDTH
:WIDGET-NAME
:WIDTH
:WINDOW-STYLES
:X
:Y
|#


;;FROM MISC SECTIONS OF CAPI:USER-MAN AND CAPI:REF -------
#|
evaluate the following:
(APPLY-IN-PANE-PROCESS
 button #'(setf titled-object-title-font)
 (gp:merge-font-descriptions 
  (gp:make-font-description :size 42) 
  (GP:CONVERT-TO-FONT-DESCRIPTION 
   BUTTON 
   (titled-object-title-font button))) button)
Notice how the window automatically resizes in steps 2 and 3, to make allow-
ance for the new size of the title.


3.5  STREAM PANES
There are three subclasses of editor-pane which handle Common Lisp 
streams.
3.5.1  COLLECTOR PANES
A collector pane displays anything printed to the stream associated with it. 
Background output windows, for instance, are examples of collector panes.
1. (contain (make-instance 'collector-pane
                         :title "Example collector pane:"))
2. (princ "abc" (collector-pane-stream *))


4.1  THE CORRECT THREAD FOR CAPI OPERATIONS
All operations on displayed CAPI elements need to be in the thread (that is, 
the mp:process) that runs their interface. ON SOME PLATFORMS, DISPLAY AND 
CONTAIN MAKE A NEW THREAD. On Cocoa, all interfaces run in a single thread.

In most cases this issue does not arise, because CAPI CALLBACKS ARE RUN IN THE CORRECT THREAD. 
However, if your code needs to communicate with a CAPI win-
dow from a random thread, it should 
USE EXECUTE-WITH-INTERFACE, 
EXECUTE-WITH-INTERFACE-IF-ALIVE,
APPLY-IN-PANE-PROCESS OR 
APPLY-IN-PANE-PROCESS-IF-ALIVE to send the function to the correct thread.
This is why the brief interactive examples in this manual generally use exe-
cute-with-interface or apply-in-pane-process when modifying a dis-
played CAPI element. In contrast, the demo example in "Connecting an 
interface to an application" on page 102 is modified only by callbacks which 
run in the demo interface's own process, and so there is no need to use exe-
cute-with-interface or apply-in-pane-process.

5.1.3  THE BREAK GESTURE
If a CAPI window is busy and unresponsive you can use the break gesture 
Ctrl+Break to regain control.
Note that this break gesture is specific to the window system your CAPI pro-
gram is running in.

;;USING A SEPARATE THREAD FOR WORK-CALCULATIONS
;;
(defun MY-WORK-FUNCTION ()
  (let ((mbox (mp:ensure-process-mailbox)))
    ;; This should REALLY HAVE AN ERROR HANDLER.
    (loop (let ((EVENT (MP:PROCESS-READ-EVENT mbox
                        "Waiting for events")))
            (cond ((consp event)
                   (apply (car event) (cdr event)))
                  ((functionp event)
                   (funcall event)))))))
(setf *worker*
      (MP:PROCESS-RUN-FUNCTION "Worker process" ()
                               'my-work-function))
(defun change-text (win text)
  (APPLY-IN-PANE-PROCESS win
                         #'(SETF title-pane-text)
                         text win))
(defun my-callback (win)
  (mp:process-send
   *worker*
   #'(lambda ()
       (change-text win "Go")
       (loop
        for i from 0 to 20 do 
        (change-text win (format nil "~D" i)


;;FONTS
;;xxx
 13.1  SET OF PORTABLE FONT ATTRIBUTES
Attribute           Possible values            Comments
:family                   string             Values are not portable.
:weight       (member :normal :bold) 
:slant          (member :roman :italic) 
:size            (or (eql :any)  (integer 0 *)) 
:any                means a scalable font 
:stock     (member :system-font :system-fixed-font)   Stock fonts are guaranteed to exist.
:char-set                keyword 


SET-RICH-TEXT-PANE-CHARACTER-FORMAT    Function
SummarySets the character format.

Signature     set-rich-text-pane-character-format    pane  
attributes-plist => result
Arguments  pane    A rich-text-pane.
attributes-plist     A plist or :default.
Values  result    A plist.
Description   The function set-rich-text-pane-character-format sets current character attributes for text in pane.

(setq rtp 
      (capi:contain 
       (make-instance 
        'capi:rich-text-pane 
        :protected-callback 'ok-to-edit-p
        :CHARACTER-FORMAT 
        '(:size 14  :color :red)
        :visible-min-height 300
        :visible-min-width 400
        :PARAGRAPH-FORMAT 
        '(:start-indent 20 :offset -15)
        :text-limit 160
        :text (FORMAT nil "First paragraph.~%Second 
paragraph, a little longer.~%Another paragraph, which 
should be long long enough that it spans more than one 
line. ~%" ))))
Enter some characters

(setq rtp 
      (capi:contain 
       (make-instance 
        'capi:rich-text-pane 
        :visible-min-height 300
        :visible-min-width 400
        :paragraph-format 
        '(:start-indent 20 :offset -15)
        :text (format nil "First paragraph.~%Second 
paragraph, a little longer.~%Another paragraph, which 
should be long long enough that it spans more than one 
line. ~%" ))))

BUTTON-PANEL
Accessors   pane-layout
Description   The class button-panel inherits most of its behavior from 
CHOICE, which is an abstract class providing support for han-
dling items and selections. By default, a button panel has 
single selection interaction style (meaning that only one of 
the buttons can be selected at any one time), but this can be 
CHANGED BY SPECIFYING AN INTERACTION. 

The SUBCLASSES push-button-panel, radio-button-panel 
and check-button-panel are provided as convenience 
classes, but they are just button panels with different interac-
tions (:NO-SELECTION, :SINGLE-SELECTION AND 
:MULTIPLE-SELECTION RESPECTIVELY). 

The LAYOUT OF THE BUTTONS is controlled by a layout of class 
LAYOUT-CLASS (which defaults to row-layout) but this can be 
changed TO BE ANY OTHER CAPI LAYOUT. When the layout is cre-
ated, the list of initargs layout-args is passed to 

|#

;; -------------------------------- BUTTON  PANEL HELP ------------------------

;;XXX
#|
6.8.2 SELECTIONS

All choices have a selection. This is a state representing the items currently
selected. The selection is represented 
as a VECTOR OF OFFSETS INTO THE LIST of the choice’s items, 
unless it is 
a SINGLE-SELECTION CHOICE, in which case it is just represented AS AN OFFSET
.
The INITIAL SELECTION is controlled with the INITARG :SELECTION. 
The accessor CHOICE-SELECTION is provided.

Generally, it is EASIER to refer to the selection in terms of the items selected,
rather than by offsets, so the CAPI provides the 
notion of a SELECTED ITEM and
the SELECTED ITEMS. The first of these is the selected item in a single-selection
choice. The second is a list of the selected items in any choice.

The ACCESSORS CHOICE-SELECTED-ITEM and 
CHOICE-SELECTED-ITEMS provide access to these conceptual slots, 
and you can also SUPPLY THE VALUES at make-instance time 
via the initargs :selected-item and :selected-items







6.8.3 CALLBACKS
All choices can have callbacks associated with them. Callbacks are invoked
both by mouse button presses and keyboard gestures that change the selection
or are "Action Gestures" such as Return. Different sorts of gesture can have
different sorts of callback associated with them.
The following callbacks are available: :selection-callback, :retractcallback
(called when a deselection is made), :extend-callback, :actioncallback
(called when a double-click occurs) and :alternative-actioncallback
(called when a modified double-click occurs). What makes one
choice different from another is that they permit different combinations of
these callbacks. This is a consequence of the differing interactions. For example,
you cannot have an :extend-callback in a radio button panel, because
you cannot extend selection in one.
Callbacks pass data to the function they call. There are default arguments for
each type of callback. Using the :callback-type keyword allows you to
change these defaults. Example values of callback-type are :interface (which
causes the interface to be passed as an argument to the callback function),
:data (the value of the selected data is passed), :element (the element
containing the callback is passed) and :none (no arguments are passed). Also
there is a variety of composite :callback-type values, such as :datainterface
(which causes two arguments, the data and the interface, to be
passed). See the callbacks entry in the LispWorks CAPI Reference Manual for a
complete description of :callback-type values.
The following example uses a push button and a callback function to display
the arguments it receives.
|#
#|(defun show-callback-args (arg1 arg2)
  (display-message "The arguments were ~S and ~S" arg1 arg2))
(setq example-button
      (make-instance 'push-button
                     :text "Push Me"
                     :callback 'show-callback-args
                     :data "Here is some data"
                     :callback-type :data-interface))
(contain example-button)
Try changing the :callback-type to other values
|#
;;NOTE THE FOLLOWING BUTTON-PANEL AND CALLBACK WORK TO SET
;; VALUES FROM 0 TO 3 FOR BUTTONS Radio 1 to Radio 4
;;  INTEGER values accessed via (CAPI:CHOICE-SELECTION EXAMPLE-BUTTON-PANEL)
;; ARG1 ACCESSES THE TEXT SELECTION eg. "Radio 2"
#|(defun show-callback-args-and-selection-INTEGER  (arg1 arg2)
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
;;test
;;works, = ARG1= "Radio 3", ARG2= #<CAPI:INTERFACE "Container" 26E00823>  ITEM-SELECTED= 2

;;RADIO-BUTTON INITARGS LIST (from listener output)
 #|      (:CALLBACK-TYPE :ALTERNATIVE-ACTION-CALLBACK
 :ACTION-CALLBACK
 :RETRACT-CALLBACK :EXTEND-CALLBACK
 :SELECTION-CALLBACK
 :ITEMS
 :TEST-FUNCTION :KEY-FUNCTION
 :ITEMS-CALLBACK :DATA-FUNCTION :PRINT-FUNCTION 
:ITEMS-MAP-FUNCTION :ITEMS-GET-FUNCTION 
:ITEMS-COUNT-FUNCTION
 :DO-CACHE :ALTERNATING-BACKGROUND
 :SELECTED-ITEMS :SELECTED-ITEM :SELECTION
 :FOCUS-ITEM :INITIAL-FOCUS-ITEM 
 :KEEP-SELECTION-P
 :INTERACTION :FILTER
 :MESSAGE :MESSAGE-ARGS :MESSAGE-FONT :MESSAGE-GAP
 :MNEMONIC-TITLE :MNEMONIC
 :TITLE :TITLE-ARGS :TITLE-FONT
 :BUTTONS
 :TOOLBAR 
:TITLE-ADJUST :TITLE-GAP :TITLE-POSITION :PLIST ...)
|#





         
#|(progn 
  (let ((example-button)
        )
        (setf example-button
         (make-instance 'capi:push-button
                        :text "Push Me"
                        :callback 'show-callback-args
                        :data "Here is some data"
                        :callback-type :data-interface))
        (capi:contain example-button)))|#;;Try changing the :callback-type to other values
#|
6.8 GENERAL PROPERTIES OF CHOICES

If you do not use the :callback-type argument and you do not know what
the default is, you can define your callback function with lambda list (&rest
args) to account for all the arguments that might be passed.
Specifying a callback
|#

#|
;;from LW examples
(radio-button-panel
    capi:radio-button-panel
    :items '("Radio 1" "Radio 2" "Radio 3")
    :callback-type :data-interface
    :selection-callback 'button-selection-callback
    :extend-callback    'button-extend-callback
    :retract-callback   'button-retract-callback)
|#





