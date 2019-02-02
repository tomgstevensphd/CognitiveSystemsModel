;;********************* CSQ-value-rank-frame.lisp *********************
;;

(defparameter  *n-ranking-groups 0 "When = 0, uses *csq-value-rate-instrs, otherwise *csq-group-rate-instrs")
(defparameter *csq-value-rate-frame-title "RATE VALUE IMPORTANCE")
(defparameter *csq-value-rank-frame-title "RANK VALUE IMPORTANCE")
(defparameter *csq-value-rank-ext-title (format nil "~%                          HOW IMPORTANT IS EACH TO YOU? "))
(defparameter *csq-value-rank-instrs (format nil "~%   RANK THE RELATIVE IMPORTANCE OF EACH ITEM TO YOU:~% 
    1. Put a number from 1 to the number of items in the list in the box~%        to the right of each item. Do NOT use the same number twice.
    2. If a number is already in the box,~%        REPLACE it with a number from 1 to total number of items."))
(defparameter *csq-group-rate-instrs (format nil "~%   RANK THE OVERALL IMPORTANCE OF EACH ITEM TO YOU--WHERE:
      1= One of the most important values/things in my life.
      2= Very to Extremely important.
      3= Important.
      4= Not very important
      5= Negative to me.
  THEN:
    1. Put a number from 1 to 5 to the right of each item.
    2. If a number is already in the box,~%        REPLACE it with a number from 1 to 5.") "When *n-ranking-groups = 0, uses *csq-value-rate-instrs, otherwise *csq-group-rate-instrs  EG (eg: group1= rank of all = 1; group2= rank of all=2, etc.")

(defparameter *group-items-instrs (format nil 
                                            "~%  Please sort the following items into ~A groups ranked from 1 to ~A. 
   1. Put the items that are MOST important to you in group 1, and the items that are LEAST important in group ~A.
   2. Please try to get about the same number of items in each group. It will make your task easier in the next step.
 " *n-ranking-groups *n-ranking-groups *n-ranking-groups) "More general grouping instructions")
(defparameter   *temp-csq-value-ratings-list NIL "For use in rankings callback")
(defparameter *temp-group-items-instrs NIL)
(defparameter *csq-value-rank-temp-instrs *csq-value-rank-instrs )
;;VALUES
(defparameter  *ALL-ORDERED-VALUES-RATINGS-LISTS NIL "These are all lists= (value rating)--same for grouped rankings")
(defparameter *temp-values-rankings NIL)
(defparameter *temp-values-rankings-strs NIL)
(defparameter *temp-ordered-values-ratings NIL)
(defparameter  *temp-ordered-values-ratings-strs NIL)
(defparameter  *temp-ordered-values-strs NIL)

;;FOR FRAMES




;;CSQ-VALUE-RANK-INTERFACE
;;
;;ddd
(capi:define-interface CSQ-VALUE-RANK-INTERFACE ()
  ;;SLOTS
  ((value-items
    :initarg :value-items
    :accessor value-items
    :type  :string
    :documentation  "Value-items to be rated.")
   #|(ordered-value-items
    :initarg :ordered-value-items
    :accessor ordered-value-items
    :type  :string
    :documentation  "Ordered-Value-Items to be rated.")|#
   (text-input-ratings
    :initarg :text-input-ratings
    :accessor text-input-ratings
    :type  :string
    :documentation  "Data from text input ratings")
   (number-input-ratings
    :initarg :number-input-ratings
    :accessor number-input-ratings
    :type  :number
    :documentation  "Strings converted to numbers from text input ratings")
   (n-ranking-groups
    :initarg :n-ranking-groups
    :accessor n-ranking-groups
    :type  :integer
    :documentation  "Number of groups to rank items by.")
   (calling-process
    :initarg :calling-process
    :accessor calling-process
    :type  :integer
    :documentation  "Process calling interface, poked when GO")
   (higher-process
    :initarg :higher-process
    :accessor higher-process
    :type  :integer
    :documentation  "Process calling interface, poked when GO")
#|   (ordered-number-ratings
    :initarg :ordered-number-ratings
    :accessor ordered-number-ratings
    :type  :number
    :documentation  "Strings converted to numbers from text input ratings") 
   (ordered-rating-strs
    :initarg :ordered-rating-strs
    :accessor ordered-rating-strs
    :type  :string
    :documentation  "Strings converted to numbers from text input ratings")|#
   ;;END SLOTS
   )
  (:PANES
   (title-pane
    capi:rich-text-pane    :accepts-focus-p NIL
    :text (format nil "  ~A   " *csq-value-rank-ext-title)
    :background :lightblue
    :accepts-focus-p NIL
    :visible-min-height 30
    :visible-max-height 40)
   (instr-pane
    capi:rich-text-pane    :accepts-focus-p NIL
    :text (format nil "  ~A   " *csq-value-rank-temp-instrs)
  ;;  :background :tan
      :accepts-focus-p NIL
    :visible-min-height 120
    :visible-max-height 170)
   (num-items-pane
    capi:title-pane
    :accepts-focus-p NIL
    :background :yellow
    :height 25)
   (table-titles-pane
    capi:title-pane
    :height 40
    :background :yellow
    :accepts-focus-p NIL
    :title "           ITEM/VALUE                                                                            RANK")
   (display-titles-pane
    capi:title-pane
    ;;not work :background :yellow
    :accepts-focus-p NIL
    :height 40
    :title "     DISPLAYED BY RATING ORDER                                                   RATING")
   (display-val-list-panel
    capi:list-panel
    :items '() ;; '("              VALUES-ITEMS                " " VERY LONG  VALUE A "  "VALUE B  ")
    :internal-border 5
    )
   (display-rank-list-panel
    capi:list-panel
    :items '()    ;; '("  ORDERED RANKS  "  "    1   "  "     2     ")
    :visible-max-width 80
    :internal-border 5)
   #|   (title-pane-1
    capi:title-pane
    :title " VERY LONG  VALUE A  ")
   (title-pane-2
    capi:title-pane
    :title " VALUE B  ")
   (text-input-pane-1
    capi:text-input-pane
    :visible-max-width 30)
   (text-input-pane-2
    capi:text-input-pane
    :visible-max-width 30)|#
   (go-button
    capi:push-button
    :text "      OK--GO TO NEXT     "
    :data "go button data"
    :callback-type :data-interface
    :callback 'csq-ranking-GO-callback
    )
   (update-rankings-button
    capi:push-button
    :text "  UPDATE RANKINGS LIST (lower window)  "
    :data "update button data"
    :callback-type :data-interface
    :callback 'update-rankings-callback
    )
   (push-button-3
    capi:push-button
    :text "Push-Button-3")   
   
   ;;END PANES
   )
  ;;LAYOUTS
  (:LAYOUTS
   ;;all
   (column-layout-1
    capi:column-layout
    '(title-pane instr-pane num-items-pane table-titles-pane 
                 do-rank-row-layout display-titles-pane display-row-layout button-row-layout))
   ;;do-rank-row-layout
   (do-rank-row-layout
    capi:row-layout
    '(do-val-column-layout do-rank-column-layout)
    :background :yellow
    :visible-min-height 400
    :visible-max-height 500
    :internal-border 10
    :vertical-scroll T 
    )
   (do-val-column-layout
    capi:column-layout
     '() ;;  '(title-pane-1 :separator title-pane-2 :separator)
    )
   (do-rank-column-layout
    capi:column-layout
    '() ;;  '(text-input-pane-1 text-input-pane-2)
    )
   ;;display-row-layout
   (display-row-layout
    capi:row-layout
    '(display-val-list-panel display-rank-list-panel)
    :vertical-scroll T
    )
   (button-row-layout
    capi:row-layout
    '(go-button update-rankings-button))   ;; push-button-2 push-button-3 ))
   ;;END LAYOUTS
   )
  (:default-initargs
   :visible-min-height 800
   :visible-min-width 460
   :external-max-height 1000
   :internal-border 15
   :background :red
   :layout 'column-layout-1
   :title *csq-value-rate-frame-title
  :best-x 40
  :best-y 30
  )
  ;;END CSQ-VALUE-RANK-INTERFACE
  )
;;TEST
;; (let ( (inst (make-instance 'CSQ-VALUE-RANK-INTERFACE))) (capi:display inst))







#|USE TEMPLATE FOR RUNNING RANKING FRAMES BELOW
;; To PROCESS PREVIOUS LIST, PUT :RECURSE IN PLACE OF :items-ratings-listS
    ;;REQUIRED: items-ratings-lists OR items-list AND ratings-list 
  '(:items-ratings-lists  items-ratings-lists :items-list items-list :ratings-list ratings-list
    ;;OPTIONAL: REST CAN BE NIL => DEFAULT SET IN FUNCTION
     :ascending-p NIL  :frame-title *csq-value-rate-frame-title 
     :display-initial-ratings-p T   :ratings-head " " :ratings-tail " "   :sort-lists-p T                 
      :n-ranking-groups 0   :reset-temp-global-vars-p T               
                              :item-rank-instrs *csq-value-rate-instrs
                              :group-items-instrs  (*csq-group-rate-instrs OR *group-items-instrs)
|# 




;;MANAGE-VALUE-RANK-FRAMES
;;
;;ddd
(defun manage-value-rank-frames (rank-parameters-lists 
                                 &key ;;not needed previous-items-ratings-lists
                                 (processing-keys '(:group-by-rating-across-groups :recurse-on-result-p))
                                 (min-n-items-to-rate 1))
  "In CSQ-value-rank-frame,callbacks     RETURNS  (values  all-ordered-items-ratings-lists  all-ordered-items-ratings-strs  all-ordered-items-lists all-ordered-ratings-lists   all-ordered-items-strs all-ordered-ratings-strs n-items-lists)
   SETS GLOBAL VARS, ,  *temp-ordered-values-ratings  *temp-ordered-values-ratings-strs ,   *temp-ordered-values-strs 
  INPUT:  rank-parameters-lists: Each rank-para-list is a keylist. Required keys are EITHER :items-ratings-listS OR :ratings-listS AND :rankings-listS. 
   PROCESSING-KEYS-- causes arbitrary code to process previous parameter-list results that are passed to next para-list as input(s). 
   IF recurse-on-result-p, processes result of last key using the last all-items-ratings-lists
  Note: EACH rank-para-list can run MULTIPLE ranking frames.
  OPTIONAL keys: ascending-p (frame-title *csq-value-rate-frame-title)
                                                   (display-initial-ratings-p T)
                                                   (ratings-head " ")(ratings-tail " ")
                                                   (sort-lists-p T)
                                                   n-ranking-groups (N-Ranking-Groups = integer changes instructions to *csq-group-rate-instrs (ie put items in n-ranking-groups by importance.)
                                                   reset-temp-global-vars-p
                                                   (item-rank-instrs *csq-value-rank-instrs)
                                                   (group-items-instrs *csq-group-rate-instrs)
  ITEM INPUT: Items should either be a list of strings or a list of  lists of ( string  rating etc ).
  USE BACKQUOTE plus comma for any vars to be evaluated (eg *csq-value-rate-frame-title)."
  (let
      ((len-rank-para-items (list-length rank-parameters-lists))
       (all-ordered-items-ratings-lists)
       (all-ordered-items-ratings-strs)
       (all-ordered-items-lists)
       (all-ordered-ratings-lists)
       (all-ordered-items-strs)
       (all-ordered-ratings-strs )
       (all-items-ratings-lists)       
       (all-values-ratings)
       (all-values-ratings-strs)
       (n-items-lists)
       ;;NOTE: both manager and -frames functions run in the SAME LISTENER PROCESS.
       ;;NOT NEEDED? (current-process (mp:get-current-process))
       (non-rank-para-items)
       ;;(last-return-items-ratings)
       )
    ;;EXAMINE EACH rank-para-item (which can run a number of ranking frames)
    (loop
     for rank-para-item in rank-parameters-lists
     for n from 0 to len-rank-para-items
     do
     (let
         ((items-ratings-lists (get-key-value :items-ratings-lists  rank-para-item))
          (items-lists (get-key-value :items-lists rank-para-item))
          (ratings-lists (get-key-value :ratings-lists rank-para-item))
          (ascending-p (get-key-value :ascending-p rank-para-item))
          (frame-title (get-key-value :frame-title rank-para-item)) 
          (display-initial-ratings-p (get-key-value :display-initial-ratings-p rank-para-item))
          (ratings-head )(ratings-tail (get-key-value :ratings-head rank-para-item))
          (sort-lists-p (get-key-value :sort-lists-p rank-para-item))
          (n-ranking-groups (get-key-value :n-ranking-groups rank-para-item))
          (reset-temp-global-vars-p (get-key-value :reset-temp-global-vars-p rank-para-item))
          (item-rank-instrs (get-key-value :item-rank-instrs rank-para-item)) 
          (group-items-instrs (get-key-value :group-items-instrs rank-para-item))
          (recurse-on-result-p)
          (all-temp-new-appended-lists)
          ;;return lists lasting across loops
          (ret-items-ratings-lists)(ret-values-ratings)
          (ret-values-ratings-strs)( ret-ordered-values-ratings)   
          (ret-ordered-values-ratings-strs)( ret-ordered-values-strs n-items-lists)
          ;;(a)(b)(c)(d)(e)(f)(g)
          )
       (unless n-ranking-groups
         (setf n-ranking-groups 0))
       ;;(break "After paras set")
       ;;For use below to keep record of original items-ratings-lists
       (when (and items-ratings-lists (listp items-ratings-lists))
         (setf new-items-ratings-lists items-ratings-lists))
       
       ;;RECURSE ON THE PREVIOUS RESULT?
       (cond
        ((or (equal rank-para-item :recurse-on-result-p)
             (and (listp rank-para-item)(member :recurse-on-result-p 
                   rank-para-item   :test 'equal)))
         (setf recurse-on-result-p T
               new-items-ratings-lists all-items-ratings-lists))
        (t (setf new-items-ratings-lists items-ratings-lists)))
       ;;reset previous-items-ratings-lists
       ;;(setf previous-items-ratings-lists NIL)

       ;;DEFAULT PARAMETER VALUES
       (unless frame-title
         (setf frame-title *csq-value-rate-frame-title))
       (unless display-initial-ratings-p
         (setf display-initial-ratings-p T))
       (unless ratings-head
         (setf ratings-head " "))
       (unless ratings-tail
         (setf ratings-tail " "))
       (unless sort-lists-p
         (setf sort-lists-p T))
       (unless item-rank-instrs
         (setf item-rank-instrs *csq-value-rank-instrs))
       ;;Note default is *group-items-instrs  NOT the CSQ version of *csq-group-rate-instrs
       (unless group-items-instrs  
         (setf group-items-instrs *group-items-instrs))

       ;;IF OK,  SELECT KEY AND FINDING NEW-ITEMS-RATINGS-LISTS
       (cond
        ;;FOR PROCESSING KEYS w/o args
        ;; SSS ADD MORE KEYS OR (KEY ARGS) AS NEEDED
#| old       ((symbolp rank-para-item)
         (setf prockey rank-para-item)|#
        (
         ;;Which key-process to use?
         (cond  
          ;;For key= :group-by-rating-across-groups
          ((or (equal rank-para-item :group-by-rating-across-groups)
               (and (listp rank-para-item)
                    (member :group-by-rating-across-groups  rank-para-item :test 'equal)))
           (let*
               ((proc-group (append-1nested-lists  NIL new-items-ratings-lists)) 
                                                                                      ;;was ret-items-ratings-lists))
              ;; (append-1nested-lists NIL  '(((a 1)(a 2))((b 11)(c 22)))) = ((A 1) (A 2) (B 11) (C 22))   
                (resorted-groups )
                (unsorted-items)
                )
             ;;(break "In :group-by-rating-across-groups")
             ;;sorts into groups by same pc/value rating (1's, 2's...etc)
             (multiple-value-setq (resorted-groups unsorted-items)
                 (group-lists-by-nths  1  proc-group :group-matched-lists-p T))
 ;; (group-lists-by-nths  1  '((a 1)(b 2)(c 3)(x 1)(y 2)(z 3)(w 4)))
;; works=(((A 1) (X 1)) ((B 2) (Y 2)) ((C 3) (Z 3)) ((W 4)))  NIL
             ;;SSS START HERE  DEBUGGING
             (setf new-items-ratings-lists resorted-groups)  ;;was items-ratings-lists
             ;;end :group-by-rating-across-groups
             ))             
             ;;end :process-last-list-p
             ;;FOR PROCESSING KEYS (in list with args)
             ((and (listp rank-para-item)
                   (member (car rank-para-item) processing-keys :test 'equal))
              ;;SSSS WRITE CODE HERE WHEN NEEDED                         
              )
                           
             ;;end mvb,proper rank-para-item
             ))
        ;;end selecting key and finding new-items-ratings-lists
        (t nil))
       
       ;;WHEN PROPER RANK-PARA-ITEM OR NEW-ITEMS-RATINGS-LISTS
       ;; PROCESS 
        ;; FOR PARAMETER LISTS--a DIFFERENT rank-para-item than one before
        (cond
         ;;SSS START HERE--IS THIS OK NOW?
         ((or (and (listp rank-para-item)
               (or new-items-ratings-lists (and items-lists ratings-lists)))
              (and  recurse-on-result-p  (listp new-items-ratings-lists)))                   
#|    was     ((and (listp rank-para-item)
               (or new-items-ratings-lists (and items-lists ratings-lists)))|#

          ;;MVB LISTS are from ALL FRAMES--multiple new-items-ratings-lists, etc.
          ;;2 frames eg= ( ((C 0.1) (B 0.2) (E 0.3) (A 0.4) (D 0.7))  ((N 0.1) (M 0.2) (Q 0.22) (P 0.3) (L 0.41) (O 0.7)))
          (multiple-value-bind (ret-ordered-items-ratings-lists  
                                ret-ordered-items-ratings-strs  
             ret-ordered-items-lists ret-ordered-ratings-lists
             ret-ordered-items-strs ret-ordered-ratings-strs ret-items-lists) 
              ;;MAKE MULTIPLE? RANKING FRAMES
              (make-value-rank-frames new-items-ratings-lists  
                                      :items-lists items-lists :ratings-lists ratings-lists
                                      :ascending-p ascending-p
                                      :frame-title frame-title
                                      :display-initial-ratings-p display-initial-ratings-p
                                      :ratings-head ratings-head :ratings-tail ratings-tail
                                      ;;NOT NEEDED?  :higher-process current-process
                                      :sort-lists-p sort-lists-p
                                      :n-ranking-groups n-ranking-groups
                                      :reset-temp-global-vars-p reset-temp-global-vars-p
                                      :item-rank-instrs item-rank-instrs
                                      :group-items-instrs group-items-instrs
                                      :min-n-items-to-rate min-n-items-to-rate 
                                      )
          ;;(break "BEFORE append-lists")
          ;;APPEND TO ALL LISTS HERE2

          (multiple-value-setq  (all-ordered-items-ratings-lists  
                                 all-ordered-items-ratings-strs  
                                                                  all-ordered-items-lists all-ordered-ratings-lists
                                                                  all-ordered-items-strs all-ordered-ratings-strs 
                                                                  n-items-lists)
              ;; or?(append-multi-lists 
              (append-lists1-with-other-lists (list all-ordered-items-ratings-lists 
                                                    all-ordered-items-ratings-strs  
                                                    all-ordered-items-lists all-ordered-ratings-lists
                                                    all-ordered-items-strs all-ordered-ratings-strs
                                                    n-items-lists)
                                              (list (list ret-ordered-items-ratings-lists  
                                                           ret-ordered-items-ratings-strs  
                                                           ret-ordered-items-lists ret-ordered-ratings-lists
                                                           ret-ordered-items-strs ret-ordered-ratings-strs
                                                           ret-items-lists))
                                              :append-list-p T))

          ;;(setf last-return-items-ratings ret-items-ratings-lists)
          ;;SSSS DO I WANT SEPARATE LISTS??
          ;;with append-multi-lists?    :list-2-lists-p  T))

          ;;HANGS SYSTEM (mp:current-process-pause 1000)
          ;;(break "AFTER append-lists")
           ;end mvb, make-value-rank-frames clause
          ))   
         (t (setf  non-rank-para-items (append  non-rank-para-items rank-para-item))))

       ;;For use with next parameter list, if needed    
       (setf previous-items-ratings-lists new-items-ratings-lists)
       ;;end let, loop
       ))

    #|(values all-items-ratings-lists ;;new-items-ratings-lists
            all-values-ratings  all-values-ratings-strs all-ordered-values-ratings
            all-ordered-values-ratings-strs all-ordered-values-strs n-items-lists non-rank-para-items)|#
    (values  all-ordered-items-ratings-lists  all-ordered-items-ratings-strs  
             all-ordered-items-lists all-ordered-ratings-lists
             all-ordered-items-strs all-ordered-ratings-strs n-items-lists)
    ;;end let, manage-value-rank-frames
    ))
;;TEST
#|USE TEMPLATE FOR RUNNING RANKING FRAMES BELOW
;; To PROCESS PREVIOUS LIST, PUT :RECURSE IN PLACE OF :items-ratings-listS
    ;;REQUIRED: items-ratings-lists OR items-list AND ratings-list 
  '(:items-ratings-lists  items-ratings-lists :items-list items-list :ratings-list ratings-list
    ;;OPTIONAL: REST CAN BE NIL => DEFAULT SET IN FUNCTION
     :ascending-p NIL  :frame-title *csq-value-rate-frame-title 
     :display-initial-ratings-p T   :ratings-head " " :ratings-tail " "   :sort-lists-p T                 
      :n-ranking-groups 0   :reset-temp-global-vars-p T               
                              :item-rank-instrs *csq-value-rank-instrs
                              :group-items-instrs (*csq-group-rate-instrs OR *group-items-instrs)

EG: (manage-value-rank-frames `((:items-ratings-lists  ((("love" 0.8)("money" 0.6)("friends" 0.5)("exercise" 0.7)("cleanliness" 0.3))(("health" 0.8)("success" 0.8)("happiness" 0.8)("good job" 0.7)))
    ;;OPTIONAL: REST CAN BE NIL => DEFAULT SET IN FUNCTION, NOTE COMMAS
     :ascending-p NIL  :frame-title ,*csq-value-rate-frame-title 
     :display-initial-ratings-p T   :ratings-head " " :ratings-tail " "   :sort-lists-p T                 
      :n-ranking-groups 0   :reset-temp-global-vars-p T               
                              :item-rank-instrs ,*csq-value-rank-instrs
                              :group-items-instrs ,*csq-group-rate-instrs)))
|#   
;; SIMPLE CASE- 1 PARAMETER LIST:                           
;; (manage-value-rank-frames '((:items-ratings-lists (((A .4) (B .2)( C .1)  (D .7)( E .3))((L .41) (M .2)( N .1)  (O .7)( P .3)(Q .22))) )))
;; 2 PARAMETER LISTS
;; CASE USED FOR PC/VALUES
;; (manage-value-rank-frames '((:items-ratings-lists (((A .4) (B .2)( C .1)  (D .3)( E .3))((L .4) (M .2)( N .1)  (O .3)( P .3)(Q .2))) :group-by-rating-across-groups))  )                        ;;:append-lists-p T)))
#| works= [after rating in alpha order]= ((((A 1) (L 2)) ((B 1) (M 2) (Q 3)) ((C 1) (N 2)) ((D 1) (E 2) (O 3) (P 4))))
(((("A" "1") ("L" "2")) (("B" "1") ("M" "2") ("Q" "3")) (("C" "1") ("N" "2")) (("D" "1") ("E" "2") ("O" "3") ("P" "4"))))
(((A L) (B M Q) (C N) (D E O P)))
(((1 2) (1 2 3) (1 2) (1 2 3 4)))
((("A" "L") ("B" "M" "Q") ("C" "N") ("D" "E" "O" "P")))
((("1" "2") ("1" "2" "3") ("1" "2") ("1" "2" "3" "4")))
(4)|#
;; REALISTIC EXAMPLE FOR PCs
;;(manage-value-rank-frames `((:items-ratings-lists  ((("love" 0.8)("money" 0.6)("friends" 0.5)("exercise" 0.7)("cleanliness" 0.3))(("health" 0.8)("success" 0.8)("happiness" 0.8)("good job" 0.7))) :group-by-rating-across-groups)))

;; (manage-value-rank-frames '((:items-ratings-lists (((A .4) (B .2)( C .1)  (D .7)( E .3))((L .41) (M .2)( N .1)  (O .7)( P .3)(Q .22))) :append-lists-p T)(:items-ratings-lists :recurse-on-result-p )))


;; WITH PARA-KEY
;; (manage-value-rank-frames '((:items-ratings-lists (((A .4) (B .2)( C .1)  (D .7)( E .3))((L .41) (M .2)( N .1)  (O .7)( P .3)(Q .22))) :append-lists-p T)   :group-by-rating-across-groups  (:items-ratings-lists :recurse )) )
;; MUST include *csq-group-rate-instrs in para list if want to use it.
;; (manage-value-rank-frames `((:items-ratings-lists  ((("love" 0.8)("money" 0.6)("friends" 0.5)("exercise" 0.7)("cleanliness" 0.3))(("health" 0.8)("success" 0.8)("happiness" 0.8)("good job" 0.7)))   :n-ranking-groups 5 :group-items-instrs ,*csq-group-rate-instrs)))  
;;works=
#|(((("love" 1) ("exercise" 1) ("money" 2) ("friends" 2) ("cleanliness" 4)) (("health" 1) ("success" 1) ("happiness" 1) ("good job" 1))))
(((1 1 2 2 4) (1 1 1 1)))
((("  1  " "  1  " "  2  " "  2  " "  4  ") ("1  " "1" "1" "1")))
(((1 1 2 2 4) (1 1 1 1)))
((("1" "1" "2" "2" "4") ("1" "1" "1" "1")))
((("love" "exercise" "money" "friends" "cleanliness") ("health" "success" "happiness" "good job")))   (2)   NIL|#

;;  DO I NEED TO ADD RECURSE? TO GET IT TO WORK ON LAST LISTS?
;;USING A KEY OF :group-by-rating-across-groups
;; (manage-value-rank-frames `((:items-ratings-lists  ((("love" 0.8)("money" 0.6)("friends" 0.5)("exercise" 0.7)("cleanliness" 0.3))(("health" 0.8)("success" 0.8)("happiness" 0.8)("good job" 0.7)))   :n-ranking-groups 5 :group-items-instrs ,*csq-group-rate-instrs  )  :group-by-rating-across-groups))



;;MAKE-VALUE-RANK-FRAMES
;;
;;ddd
(defun make-value-rank-frames (items-ratings-lists &key items-lists 
                                                   ratings-lists
                                                   ascending-p 
                                                   (use-for-csq-value-rankings-p T)
                                                   (frame-title *csq-value-rate-frame-title)
                                                   (display-initial-ratings-p T)
                                                   (ratings-head " ")(ratings-tail " ")
                                                   (higher-process)
                                                   (sort-lists-p T)
                                                   presort-all-lists-into-ordered-same-value-lists
                                                                             ;;USE :ascending or :descending
                                                   (n-ranking-groups 0)
                                                   reset-temp-global-vars-p
                                                   (item-rank-instrs *csq-value-rank-instrs)
                                                   (group-items-instrs *group-items-instrs) ;;not *csq-group-rate-instrs
                                                   (min-n-items-to-rate 1)
                                                   (modify-pcsym-list-p T)
                                                   )
  "In CSQ-value-rank-frame,callbacks     RETURNS  (values  all-ordered-items-ratings-lists  all-ordered-items-ratings-strs  all-ordered-items-lists all-ordered-ratings-lists all-ordered-items-strs all-ordered-ratings-strs n-items-lists) 
   PRESORT-ALL-LISTS-INTO-ORDERED-SAME-VALUE-LISTS creates new lists--with all same-value items. New lists then ordered in ascending lists-- :ascending or :descending.
   SET GLOBAL VARS, ,  *temp-ordered-items-ratings  *temp-ordered-items-ratings-strs ,   *temp-ordered-items-strs 
  INPUT: items should either be a list of strings or a list of  lists of ( string  rating etc ) SETS global vars: *temp-ratings   *temp-ratings-strs *temp-ordered-items-ratings *temp-ordered-items-ratings-strs *temp-ordered-items-strs.  If items-list not strings, converts it before alling frame--which requires strings.        NOTE: Does not modify *csq-data-list"
  (let
      ((lists-to-process)
       (temp-lists)
       (test)
       (all-ratings-lists)
       (all-ratings-strs)
       (all-ordered-ratings)
       (all-items-ratings-lists)
       (all-items-ratings-strs)
       ;;(all-ordered-items-ratings)
       (all-ordered-items-ratings-lists) 
       (all-ordered-items-ratings-strs)
       ;;(temp-items-ratings-lists)
       (all-ordered-items-lists)
       (all-ordered-items-strs)
       (all-ordered-ratings-lists) 
       (all-ordered-ratings-strs)
       (current-process (mp:get-current-process))
       )   

    ;;ITEMS-RATINGS-LISTS OR ITEMS-LISTS?
    (cond
     (items-ratings-lists
      (setf lists-to-process items-ratings-lists))
     (items-lists
      (setf lists-to-process items-lists))
     (t  nil))

    ;;PRESORT-ALL-LISTS-INTO-ORDERED-SAME-ITEMS? 
    ;;  :ascending or :descending
    (when presort-all-lists-into-ordered-same-value-lists
      (cond
       (ascending-p 
        (setf test 'my-lessp))
       (t  (setf test 'my-greaterp)))
        (setf temp-lists (append-1nested-lists NIL lists-to-process)
              temp-lists (sort-1nested-lists 1 temp-lists :test test)
                          ;;here now
              lists-to-process (group-lists-by-nths 1 temp-lists)))
    ;;(break "grouped?")
#|      (when (equal :descending presort-all-lists-into-ordered-same-value-lists)
        (setf lists-to-process (reverse lists-to-process)))
      ;;end outer when
      )   |#

    (setf n-items-lists (list-length lists-to-process))

    (loop
     for list-to-process in  lists-to-process
     do
     ;;(break "list-to-process")
     (let
         ((n-items-list) 
          (items-list)
          (ratings-list)
          (items-ratings-list)
          (ordered-items)
          (ordered-items-ratings)
          )
       ;;GET THE ITEMS-LIST and RATINGS-LIST 
       (cond
        (items-ratings-lists
         (multiple-value-setq (items-list ratings-list)
             (values-list (divide-lists-in-list list-to-process 2))))
        ((and items-lists ratings-lists)
         (setf items-list list-to-process
               ratings-list (nth (- n 1) ratings-lists)))
        (t nil))
       ;;n-items-list
       (setf n-items-list (list-length items-list))
       
       ;;RESET GLOBAL TEMP VARS
       (setf *temp-ratings NIL  *temp-ratings-strs NIL
             *temp-ordered-items-ratings NIL  *temp-ordered-items-ratings-strs NIL
             *temp-ordered-items-strs  NIL)

       ;;CONVERT ITEMS-LIST TO STRINGS IF NECESSARY
       (when (not (stringp (car items-list)))
         (setf items-list (convert-items-to-strings items-list)))
        
       ;;MAKE make-value-rank-frame
       ;;If min-n-items-to-rate > n-items-list
       (cond      
        ((<= min-n-items-to-rate  n-items-list)
         ;;(afout 'out1 (format nil "min-n-items-to-rate= ~A n-items-list= ~A~%items-list=~A " min-n-items-to-rate n-items-list items-list))
         ;;(break "BEFORE make-value-rank-frame")
         (make-value-rank-frame nil :items-list items-list :ratings-list ratings-list
                                :ascending-p ascending-p
                                :frame-title frame-title
                                :display-initial-ratings-p display-initial-ratings-p
                                :ratings-head ratings-head :ratings-tail ratings-tail
                                :calling-process current-process
                                :sort-lists-p sort-lists-p
                                :n-ranking-groups n-ranking-groups
                                :reset-temp-global-vars-p reset-temp-global-vars-p
                                :item-rank-instrs item-rank-instrs
                                :group-items-instrs group-items-instrs)

         ;;MP PAUSE HERE
         (mp:current-process-pause 1000)

            ;;SSS START HERE--TEST MODIFY FOR RANK
    (when (and use-for-csq-value-rankings-p
               *temp-ordered-items-ratings-strs)
      (loop
       for item-rating-list  in *temp-ordered-items-ratings-strs
       do
           (let*
               ((pc-sym (car item-rating-list)) 
                 (pc-name) 
                 (csval-rank (second item-rating-list))
                 )
             (cond
              ((stringp pc-sym)
               (setf pc-name pc-sym
                     pc-sym (my-make-symbol pc-name)))
              (t (setf pc-name (format nil "~A" pc-sym))))

           ;;MODIFY PC-SYM LIST  
           (when modify-pcsym-list-p
             (set-symkeyval pc-sym  *csval-rank-key   csval-rank))

        ;; (break "after modify sym-datalist")

;;("NICE" "nice vs nnice" CS2-1-1-99 NIL NIL :PC ("nice" "nnice" 1 NIL) :POLE1 "nice" :POLE2 "nnice" :BESTPOLE 1 :BIPATHS ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)))
;; *quest-- (HON HON :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12)

           ;;end let,loop,when
           )))

         ;;append the overall lists       
         (setf all-ratings-lists  (append  all-ratings-lists 
                                                 (list *temp-ratings))
               all-ratings-strs (append all-ratings-strs 
                                              (list  *temp-ratings-strs ))
              all-ordered-items-ratings-lists  (append all-ordered-items-ratings-lists                                                        (list *temp-ordered-items-ratings-lists))
               all-ordered-items-ratings-strs (append all-ordered-items-ratings-strs 
                                                      (list  *temp-ordered-items-ratings-strs ))
               all-ordered-items-lists (append all-ordered-items-lists
                                               (list *temp-ordered-items))               
               all-ordered-items-strs  (append all-ordered-items-strs 
                                               (list  *temp-ordered-items-strs ))
               all-ordered-ratings-lists (append all-ordered-ratings-lists
                                                 (list *temp-ordered-ratings))
               all-ordered-ratings-strs (append all-ordered-ratings-strs
                                               (list *temp-ordered-ratings-strs)))

         ;;(break "end of main clause")
         ;;end clause min items to rate
         )
        ;;if (> min-n-items-to-rate  n-items-list)      
        (T
         ;;;here now
         ;;(afout 'out1 (format nil "min-n-items-to-rate= ~A n-items-list= ~A~%items-list=~A " min-n-items-to-rate n-items-list items-list))
         (setf all-items-ratings-lists (append all-items-ratings-lists 
                                               (list list-to-process))
               ;;(group-lists-by-nths 1 list-to-process))
               ;;here 3
               ;;items-list and ratings-list found above
               all-ratings-lists  (append all-ratings-lists (list ratings-list)))

         (multiple-value-setq (ordered-ratings ordered-items)
             (sort-lists-by-list1 ratings-list items-list))

         (setf all-ordered-ratings-lists (append all-ordered-ratings-lists 
                                           (list ordered-ratings))
               ordered-ratings-strs (make-list-of-strings ordered-ratings)
               all-ordered-ratings-strs (append all-ordered-ratings-strs
                                                (list ordered-ratings-strs))
               all-ordered-items-lists (append all-ordered-items-lists
                                               (list ordered-items))
               ordered-items-strs (make-list-of-strings ordered-items)
               all-ordered-items-strs  (append all-ordered-items-strs 
                                               (list ordered-items-strs))
               ordered-items-ratings (sort-1nested-lists 1 list-to-process)
               all-ordered-items-ratings-lists (append all-ordered-items-ratings-lists
                                                       (list ordered-items-ratings))
               ordered-items-ratings-strs (make-list-of-1nested-strings 
                                                             ordered-items-ratings)
               all-ordered-items-ratings-strs (append all-ordered-items-ratings-strs 
                                                      (list ordered-items-ratings-strs )))

         ;;update global vars for callbacks
         ;;not needed because these apply to only each frame?
#|         (setf *temp-ordered-ratings ordered-ratings
               *temp-ordered-ratings-strs ordered-ratings-strs
               *temp-ordered-items ordered-items
               *temp-ordered-items-strs ordered-items-strs
               *temp-ordered-items-ratings-lists ordered-items-ratings
               *temp-ordered-items-ratings-strs ordered-items-ratings-strs)|#
         ;;(break "end of < min")
         ))
       ;;(break "all-items-ratings-lists")

      ;;end let,loop
       ))
    ;;(break "END-make-value-rank-frames")
    ;;NOT NEEDED (mp:process-poke higher-process)

    
  
    (setf *ALL-ORDERED-ITEMS-RATINGS-LISTS all-ordered-items-ratings-lists)
    (values  all-ordered-items-ratings-lists  all-ordered-items-ratings-strs  
             all-ordered-items-lists all-ordered-ratings-lists
             all-ordered-items-strs all-ordered-ratings-strs n-items-lists)
    ;;end let, make-value-rank-frames
    ))
;;TEST
;; (make-value-rank-frames '(((A .4) (B .2)( C .1)  (D .7)( E .3))((L .41) (M .2)( N .1)  (O .7)( P .3)(Q .22))))
#|;;works= (((C 0.1) (B 0.2) (E 0.3) (A 0.4) (D 0.7))((N 0.1) (M 0.2) (Q 0.22) (P 0.3) (L 0.41) (O 0.7)))
((0.1 0.2 0.3 0.4 0.7)(0.1 0.2 0.22 0.3 0.41 0.7))
(("  0.1  " "  0.2  " "  0.3  " "  0.4  " "  0.7  ") ("  0.1  " "  0.2  " "  0.22  " "  0.3  " "  0.41  " "  0.7  "))
((0.1 0.2 0.3 0.4 0.7) (0.1 0.2 0.22 0.3 0.41 0.7))
(("0.1" "0.2" "0.3" "0.4" "0.7") ("0.1" "0.2" "0.22" "0.3" "0.41" "0.7"))
((C B E A D) (N M Q P L O))
2|#
;; FOR GROUPED RATINGS
;; (make-value-rank-frames '(((A .4) (B .2)( C .1)  (D .7)( E .3))((L .41) (M .2)( N .1)  (O .7)( P .3)(Q .22))) :N-RANKING-GROUPS 2)
#|works= (((A 1) (B 1) (C 1) (D 2) (E 2)) ((L 1) (M 1) (N 1) (O 2) (P 2) (Q 2)))
((1 1 2 1 2)( 1 1 2 2 1 2))
(("1" "1" "2 " "1" "2") ("1 " "1" "2" "2" "1 " "2"))
((1 1 1 2 2) (1 1 1 2 2 2))
(("1" "1" "1" "2" "2") ("1" "1" "1" "2" "2" "2"))
((A B C D E) (L M N O P Q))
2|#

;; grouped ratings with min-n-items-to-rate
;; (make-value-rank-frames '(((A .4) (B .2)( C .1)  (D .7)( E .3))((L .4) (M .7 )(O .2))((P .7)(Q .4)(R .1)(S .7))) :presort-all-lists-into-ordered-same-value-lists :descending :min-n-items-to-rate  3)
;;works= 
#|all-ordered-items-ratings-lists= (((S 1) (P 2) (M 3) (D 4)) ((A 1) (L 2) (Q 3)) ((E 0.3)) ((B 0.2) (O 0.2)) ((C 0.1) (R 0.1)))
all-ordered-items-ratings-strs= ((("S" "1") ("P" "2") ("M" "3") ("D" "4")) ( ("A" "1") ("L" "2") ("Q" "3")) (("E" "0.3")) (("B" "0.2") ("O" "0.2")) (("C" "0.1") ("R" "0.1")))
all-ordered-items-lists= ((S P M D) (A L Q) (E) (B O) (C R))
all-ordered-ratings-lists= ((1 2 3 4) (1 2 3) (0.3) (0.2 0.2) (0.1 0.1))
all-ordered-items-strs= (("S" "P" "M" "D") ("A" "L" "Q") ("E") ("B" "O") ("C" "R"))
all-ordered-ratings-strs= (("1" "2" "3" "4") ("1" "2" "3") ("0.3") ("0.2" "0.2") ("0.1" "0.1"))
n-items-lists= 5|#



;;MAKE-VALUE-RANK-FRAME
;;
;;ddd
(defun make-value-rank-frame (items-ratings-list &key items-list ratings-list
                                                 ascending-p 
                                                 (frame-title *csq-value-rate-frame-title)
                                                 (display-initial-ratings-p T)
                                                 (ratings-head " ")(ratings-tail " ")
                                                 (sort-lists-p T)
                                                 calling-process
                                                 higher-process
                                                 (n-ranking-groups 0)
                                                 reset-temp-global-vars-p
                                                 (item-rank-instrs *csq-value-rank-instrs)
                                                 (group-items-instrs *group-items-instrs) ;;not *csq-group-rate-instrs
                                                 )
  "In CSQ-value-rank-frame, callbacks SET GLOBAL VARS, ,  *temp-ordered-items-ratings  *temp-ordered-items-ratings-strs ,   *temp-ordered-items-strs    RETURNS    INPUT: items should either be a list of strings or a list of  lists of ( string  rating etc ) SETS global vars: *temp-items-rankings   *temp-items-rankings-strs *temp-ordered-items-ratings *temp-ordered-items-ratings-strs *temp-ordered-items-strs  N-Ranking-Groups = integer changes instructions to group-rank-instrs (ie put items in n-ranking-groups by importance.(eg: group1= rank of all = 1; group2= rank of all=2, etc."
  (let
      ((items-ranks-list)
       (divided-lists)
       (rating-strs)
       ;;(ratings-strs)
       (n-items) ;;(list-length items-ratings-list))
       (frame-inst) ;;(make-instance 'csq-value-rank-interface :title frame-title))
       (val-rating-panes)
       (rank-rating-panes)
       (sorted-items-list)
       (sorted-ratings-list)
       )

    ;;SELECT N-RANKING-GROUPS OR RANK-ALL TYPE OF FRAME 
    ;;  AND MAKE INSTANCE
    (setf  *n-ranking-groups n-ranking-groups) ;;not needed, use slot-value below?
    (cond
     ;;if rank by groups (limited number of rankings)
     ((> n-ranking-groups 0)
      (cond
       (group-items-instrs
        (setf *temp-group-items-instrs group-items-instrs
              *csq-value-rank-temp-instrs *temp-group-items-instrs))
       (t (setf *temp-group-items-instrs *group-items-instrs
                *csq-value-rank-temp-instrs *temp-group-items-instrs)))
      ;;end if rank by groups
      )
     ;;if rank all items
     (t (setf *csq-value-rank-temp-instrs  item-rank-instrs)))

    ;;MAKE FRAME INSTANCE
    (setf frame-inst (make-instance 'csq-value-rank-interface :title frame-title
                                    :n-ranking-groups n-ranking-groups 
                                    :calling-process calling-process))

    ;;WHEN reset-temp-global-vars-p
    (when reset-temp-global-vars-p
      (setf *csq-value-rank-temp-instrs group-items-instrs
            *temp-items-rankings NIL
            *temp-items-rankings-strs NIL
            *temp-ordered-items-ratings NIL
            *temp-ordered-items-ratings-strs NIL
            *temp-ordered-items-strs NIL))
    
    (when (and items-ratings-list
               (listp (car items-ratings-list)))
      (setf divided-lists
            (divide-lists-in-list items-ratings-list 2)
            items-list (car divided-lists)
            ratings-list (second divided-lists)))

    ;;PRE-SORT THE LISTS? sort-lists-p
    (when (and sort-lists-p items-list ratings-list)
      (multiple-value-setq (sorted-ratings-list sorted-items-list )
          (sort-lists-by-list1 ratings-list items-list)))   
      
    (when (and items-list (listp items-list))
      (setf n-items (list-length items-list))
      (when (not (or  display-initial-ratings-p ratings-list))
        (setf rating-strs (make-list n-items :initial-element "")
              ratings-list (make-list n-items :initial-element 0)))

      (when (not (stringp (car ratings-list)))
        (setf rating-strs (convert-objects-to-strings ratings-list :string-head ratings-head
                                                      :string-tail ratings-tail)))    
      ;;SET *temp-ratings-strs rating-strs for use in callback
      (setf *temp-csq-value-ratings-list ratings-list)

      (with-slots (num-items-pane do-val-column-layout do-rank-column-layout 
                                  display-val-list-panel display-rank-list-panel)   frame-inst
        ;;make title-pane
        (capi:apply-in-pane-process num-items-pane
                                    #'(setf capi:title-pane-text) 
                                    (format nil "   Number of items=  ~A    " n-items) 
                                    num-items-pane)
        ;;MAKE THE INPUT-TEXT LAYOUT with title-panes and text-input-panes cols
        (make-multi-title-textinput-layout  items-ratings-list
                                            do-val-column-layout  do-rank-column-layout   frame-inst 
                                            :items-list items-list    :ratings-list  ratings-list  ;;here5
                                            :display-initial-ratings-p display-initial-ratings-p
                                            :ascending-p ascending-p 
                                            :display-head-str "   " :display-tail-str "  "
                                            :rating-head-str ratings-head  :rating-tail-str ratings-tail
                                            :update-items-slot  'value-items
                                            :update-ratings-slot  'number-input-ratings
                                            :update-ratings-strs-slot  'text-input-ratings
                                            )

        ;;MAKE THE DISPLAY LAYOUT with list-panels
        (when  sorted-items-list
          (setf items-list  sorted-items-list
                ratings-list sorted-ratings-list))

        (make-items-ranks-pane items-ratings-list                              
                               display-val-list-panel  display-rank-list-panel frame-inst 
                               :items-list items-list    :ratings-list  ratings-list
                               :ascending-p ascending-p 
                               :display-head-str "   " :display-tail-str "  "
                               :rating-head-str "   " :rating-tail-str "  ")
        ;;end with-slots
        )

      ;;SET THE SLOT-VALUES
      (setf (slot-value frame-inst 'value-items) items-list
            ;;(slot-value frame-inst 'text-input-ratings) ratings-list
            (slot-value frame-inst 'number-input-ratings) ratings-list)

      (capi:display frame-inst)
      frame-inst
      ;;end when, let, make-value-rank-frame
      )))
;;TEST
;;normal ranking
;; (make-value-rank-frame '((A .4) (B .2)( C .1)  (D .7)( E .3)))
;;
;; (make-value-rank-frame NIL :items-list '(A B C D) :ratings-list '(3 2 1 4)) 
;;group ranking
;; (make-value-rank-frame '((A .4) (B .2)( C .1)  (D .7)( E .3)(F .8)(G .33)(H .42)(I .22)(J .17)(K .53)) :N-RANKING-GROUPS 3)
;;
;; A LONG ONE:
;; (make-value-rank-frame '((A .4) (B .2)( C .1)  (D .7)( E .3)(F .5)(G .3)(H .2)(I .9)(J .3)(K .5)(L .7)(M. .7)(N .2)(O .6)(P .2)(Q .1)(R .4)(S .5)(T .3)(U .5)(V .2)(W .1)(X .9)(Y .2)(Z .4)))





;;CSQ-RANKING-GO-CALLBACK
;;2017
;;ddd
(defun csq-ranking-GO-callback (data interface)
  "In CSQ-value-rank-frame  SETS GLOBAL VARS: *temp-ordered-values-strs *temp-ordered-values-ratings  *temp-ordered-values-ratings-strs "
  (with-slots (do-rank-column-layout) interface
  (let
      ((rating-panes (capi:layout-description  do-rank-column-layout))
       (values (slot-value interface 'value-items))
       (calling-process (slot-value interface 'calling-process))
       ;;(higher-process (slot-value interface 'higher-process))
       )
    (multiple-value-bind (rating-strs ratings)
        (get-multiple-input-pane-text  rating-panes  :return-objects-p T)

      ;;set temp global vars
      (setf *temp-ratings ratings
            *temp-ratings-strs rating-strs)

      (multiple-value-setq (*temp-ordered-ratings *temp-ordered-items)
          (sort-lists-by-list1 ratings values ))
      (setf  *temp-ordered-ratings-strs 
             (make-list-of-strings *temp-ordered-ratings) 
             *temp-ordered-items-strs
             (make-list-of-strings *temp-ordered-items)
             *temp-ordered-items-ratings-lists
             (make-lists-from-items *temp-ordered-items
                                    *temp-ordered-ratings)
             *temp-ordered-items-ratings-strs
             (make-lists-from-items *temp-ordered-items-strs  
                                    *temp-ordered-ratings-strs))

      ;;APPEND *ALL-ORDERED-VALUES-RATINGS-LISTS
      (setf *ALL-ORDERED-VALUES-RATINGS-LISTS (append *ALL-ORDERED-VALUES-RATINGS-LISTS (list (list (car *temp-csq-value-ratings-list) *temp-ordered-items-ratings-lists))))

      ;;(break "in csq-ranking-GO-callback")
      ;;poke calling process?
      (when calling-process
        (mp:process-poke calling-process))
      ;;for csq-main-process if above doesn't work--fix later SSS
       (mp:process-poke *csq-main-process)
      ;;(BREAK "POKED?")
#|   not right place   (when higher-process
        (mp:process-poke higher-process))|#
      
      ;;SSS  set slot-values in a calling interface???
      (capi:destroy interface)
      (values ratings rating-strs)
      ;;end mvb, with, csq-ranking-GO-callback
      ))))



;;UPDATE-RANKINGS-CALLBACK
;;2017
;;ddd
(defun update-rankings-callback (data interface)
  (with-slots (do-val-column-layout  do-rank-column-layout  
                                     display-val-list-panel  display-rank-list-panel) interface
  (let*
      ((val-panes (capi:layout-description  do-val-column-layout))
             ;;no (get-multiple-input-pane-text  val-panes  :return-objects-p NIL))
       (rating-panes (capi:layout-description  do-rank-column-layout))
       (val-pane-strs  (slot-value interface 'value-items))
       (calling-process (slot-value interface 'calling-process))
       (ordered-rating-strs)
       (ordered-ratings)
       (ordered-val-strs )
       (new-frame-inst)
       (n-ranking-groups (slot-value interface 'n-ranking-groups))
       )
    (multiple-value-bind (rating-strs ratings)
        (get-multiple-input-pane-text  rating-panes  :return-objects-p T)

      (multiple-value-bind (ordered-ratings ordered-val-strs)
                  (sort-lists-by-list1 ratings  val-pane-strs)

        (setf ordered-rating-strs (make-list-of-strings ordered-ratings))
      ;;(break "ordered-val-strs")  
   
       ;;SET TEMP GLOBAL VARS
      (setf *temp-ratings ratings
            *temp-ratings-strs rating-strs)

      (multiple-value-setq (*temp-ordered-ratings *temp-ordered-items)
          (sort-lists-by-list1 ratings val-pane-strs ))
      (setf  *temp-ordered-ratings-strs 
             (make-list-of-strings *temp-ordered-ratings) 
             *temp-ordered-items-strs
             (make-list-of-strings *temp-ordered-items)
             *temp-ordered-items-ratings-lists
             (make-lists-from-items *temp-ordered-items
                                    *temp-ordered-ratings)
             *temp-ordered-items-ratings-strs
             (make-lists-from-items *temp-ordered-items-strs  
                                    *temp-ordered-ratings-strs))
        (when (> n-ranking-groups 0)
          (setf *csq-value-rank-temp-instrs *temp-group-items-instrs)
          ;;end when
          )       

        ;;MAKE NEW FRAME (with new values), close old
        (make-value-rank-frame NIL :items-list ordered-val-strs
                               :ratings-list ordered-rating-strs
                               :ascending-p T
                               :frame-title *csq-value-rate-frame-title
                               :calling-process calling-process
                               :display-initial-ratings-p T)

        (capi:destroy interface)
 
        (values ordered-ratings ordered-rating-strs)
        ;;end mvb,mvb, with, update-rankings-callback
        )))))



;;MAKE-MULTI-TITLE-PANES
;;2017
;;ddd
(defun make-multi-title-panes (items interface layout &key (head-str "  ")(tail-str "  ")
                                     (incl-separator-p T))
  (let
      ((title-panes)
       (n-items (list-length items))
       )
    (loop
     for item in items
     for n from 1 to n-items
     do
     (let*
         ((title (format nil "~A~A~A" head-str item tail-str))
          (pane (make-instance 'capi:title-pane :title title
                               :visible-min-height 15
                               ))
          )
       (setf title-panes (append title-panes (list pane)))
       (when incl-separator-p 
         (setf title-panes (append title-panes (list :separator))))
       ;;end let, loop
       ))
    ;;(break "title-panes")
    ;;APPLY THE TITLE-PANES
       (setf (capi:layout-description  layout) title-panes)
    title-panes
    ;;end let, make-multi-title-panes
    ))



;;MAKE-MULTI-TEXT-INPUT-PANES
;;2017
;;ddd
(defun make-multi-text-input-panes (items interface layout 
                                          &key (head-str "  ")(tail-str "  ")
                                          (display-initial-ratings-p T)
                                           (visible-min-width 20) (visible-max-width 30)
                                           (visible-max-height 12)
                                           )
  (let
      ((text-input-panes)
       (n-items (list-length items))
       (item-strs)
       )
    (loop
     for item in items
     for n from 1 to n-items
     do
     (let*
         ((item-str (format nil "~A~A~A" head-str item tail-str))
          (pane (make-instance 'capi:text-input-pane
                               :visible-max-width visible-max-width
                               :visible-min-width visible-min-width
                               :visible-max-height visible-max-height
                               ))
          )
       (setf text-input-panes (append text-input-panes (list pane))
             item-strs (append item-strs (list item-str)))
       ;;end let, loop
       ))
    ;;APPLY THE TEXT-INPUT-PANES
    (setf (capi:layout-description  layout) text-input-panes)

    (when display-initial-ratings-p
      (set-multiple-input-pane-text item-strs text-input-panes))

    text-input-panes
    ;;end let, make-multi-text-input-panes
    ))



;;MAKE-MULTI-TITLE-TEXTINPUT-LAYOUT
;;2017
;;ddd
(defun make-multi-title-textinput-layout (items-ratings-list  
                                          items-layout  ratings-layout interface 
                                          &key  items-list ratings-list  ascending-p   
                                          (display-initial-ratings-p T)
                                          (sort-lists-p T)
                                          (display-head-str "   ")(display-tail-str "  ")
                                          (rating-head-str "   ")(rating-tail-str "  ")
                                          update-items-slot  update-ratings-slot                                            
                                          update-ratings-strs-slot   display-interface-p)
  "In CSQ-value-rank-frame,   RETURNS    INPUT: If items-ratings-list (list of item rating) items or separate already ordered lists OR items-list and ratings-list should already be ordered by how want them printed. Note: pass actual layouts--not layout names. When update-items-slot, updates all 3 slots."
  (let
      ((items-ranks-list)
       (items-strs)
       (ratings-strs)
       (n-items (list-length items-ratings-list))
       )
    (cond
     (items-ratings-list
        (multiple-value-setq (items-list ratings-list)
            (make-ordered-items-sublists items-ratings-list  :ascending-p ascending-p)))
     ((and sort-lists-p (numberp (car ratings-list)))
      (multiple-value-setq (ratings-list items-list )
          (sort-lists-by-list1 ratings-list items-list)))
      (t nil))    
     
    (setf items-strs (convert-items-to-strings items-list
                                                 :head-string display-head-str :tail-string display-tail-str)
            ratings-strs (convert-items-to-strings ratings-list 
                                                   :head-string display-head-str :tail-string display-tail-str))
     ;;(break "make-multi-title-textinput-layout  strs")

        ;;make the values column for rating
        (make-multi-title-panes items-list interface items-layout 
                                :head-str "  " :tail-str "  "
                                :incl-separator-p T)
        ;;make the text-input column for rating
        (make-multi-text-input-panes ratings-list interface ratings-layout
                                     :head-str "  " :tail-str "  "
                                     :display-initial-ratings-p display-initial-ratings-p
                                     :visible-min-width 24 :visible-max-width 30)
       
        (when update-items-slot 
          (setf (slot-value interface update-items-slot) items-strs
                (slot-value interface update-ratings-slot ) ratings-list
                (slot-value interface update-ratings-strs-slot)  ratings-strs ))

    (when display-interface-p
      (capi:display interface))
    ;;end let, make-multi-title-textinput-layout
    ))





;;MAKE-ITEMS-RANKS-PANE
;;2017
;;ddd
(defun make-items-ranks-pane (items-ratings-list display-pane ratings-pane interface 
                                                 &key  items-list ratings-list  ascending-p                      
                                                 (display-head-str "   ")(display-tail-str "  ")
                                                 (rating-head-str "   ")(rating-tail-str "  ")
                                                 display-interface-p)
  "In CSQ-value-rank-frame, RETURNS    INPUT: If items-ratings-list (list of item rating) items or separate already ordered lists OR items-list and ratings-list should already be ordered by how want them printed. Note: pass actual panes--not pane names."
  (let
      ((items-ranks-list)
       (items-strs)
       (ratings-strs)
       (n-items (list-length items-ratings-list))
       )
    (when items-ratings-list
        (multiple-value-setq (items-list ratings-list)
            (make-ordered-items-sublists items-ratings-list  :ascending-p ascending-p))    
      ;;end when
      )   
    (setf items-strs (convert-items-to-strings items-list
                                                 :head-string display-head-str :tail-string display-tail-str)
            ratings-strs (convert-items-to-strings ratings-list 
                                                   :head-string display-head-str :tail-string display-tail-str))
      (capi:apply-in-pane-process display-pane
                                  #'(setf capi:collection-items) items-strs display-pane)
      (capi:apply-in-pane-process ratings-pane
                                  #'(setf capi:collection-items) ratings-strs ratings-pane)

    (when display-interface-p
      (capi:display interface))
    ;;end let, make-items-ranks-pane
    ))
;;





;;SET-MULTIPLE-INPUT-PANE-TEXT
;;2017
;;ddd
(defun set-multiple-input-pane-text (text-list text-input-panes)
    (loop
     for pane in text-input-panes
     for text in text-list
     do
     (capi:apply-in-pane-process pane
                                  #'(setf capi:text-input-pane-text) text pane)
     ;;end loop,set-multiple-input-pane-text
     ))




;;GET-MULTIPLE-INPUT-PANE-TEXT
;;2017
;;ddd
(defun get-multiple-input-pane-text (text-input-panes &key return-objects-p)
  "In  RETURNS (values text-inputs objects) Eg. objects may be numbers."
  (let
      ((text-inputs)
       (objects)
       )
    (loop
     for pane in text-input-panes
     do
     (let ((text (capi:text-input-pane-text pane))
           (object)
           )
       (setf text-inputs (append text-inputs (list text)))
       (when return-objects-p
         (setf object (car (convert-string-to-objects text))
               objects (append objects (list object))))
       ;;end let,loop,set-multiple-input-pane-text
       ))
    ;;(break)
  (values text-inputs objects)
  ;;let, get-multiple-input-pane-text
  ))
;;TEST
;;  need panes to test, use 
;; (convert-string-to-objects "  0.4  ") = (0.4) etc

   