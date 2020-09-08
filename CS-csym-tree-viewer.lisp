;;********************* CS-csym-tree-viewer.lisp *****************************
;;
;; A TREE-VIEW FRAME FOR ANY CSYM SET OF FUNCTION,
;;   where each subordinate list included in the csymvals with key = :S (sublistkey)
;;  VERY VERSATILE
;;  Can also use CAPI:GRAPH-PANE, which is very similar but NOT strictly hierarchical as tree-view is.  Since every node has only ONE location and the tree reflects (eg brain) locations, then tree-view should work for laying out the PHYSICAL LOCATION NETWORK.
;;  ALSO, can use a WRAPPER if want to refer to a NODE in MORE than one SUBLIST.
;;
;;

;;SEE U-TREES, U-TREES-ART-DIMS AND U-SYMBOL-TREES  FOR MORE OTHER TREE-VIEWERS
;;
;; also see MyUtilities/U-trees-art-dims for dims (CS HQ 3 2) oriented trees based upon tree lists ONLY-not able to eval CSYMs to get roots, but must search a tree.


;;
;; In U-TREES, ROOTN = DIM, ROOTNLIST = DIMLIST, ROOTNLISTS = DIMLISTS


;;make-treeviewer-options-interface first?
(defparameter  *make-treeviewer-options-interface T)

;;tree view options
;;omit-def-p omit-desc-p omit-data-p
(defparameter *omit-csym-treeview-def-p NIL "Print def for each node?")
(defparameter *omit-csym-treeview-desc-p NIL "Print desc for each node?")
(defparameter *omit-csym-treeview-data-p NIL "Print data for each node?")

;;csym-treeviewer frame options
(defparameter *max-tree-def-n 200 "Max length of printed csym def")
(defparameter *max-tree-desc-n 200 "Max length of printed csym description")
  
(defparameter *incl-sublist-in-treeviewer-nodes-p NIL )
(defparameter *incl-csartloc-in-treeviewer-nodes-p T)

(defparameter *csym-treeviewer-frame-title "Tom's Cognitive Systems TreeViewer")
(defparameter  *incl-csymlist-in-treeviewer-p NIL "Includes csymvals in each node printout")
(defparameter *csym-treeviewer-frame-ht 800 )
(defparameter *csym-treeviewer-frame-width (cond (*incl-csymlist-in-treeviewer-p 1300) (t 800)))
(defparameter *csym-treeviewer-frame-x 10 )
(defparameter *csym-treeviewer-frame-y 30)
(defparameter *csym-tree-list NIL "Main csym-tree-list incls all sublists/subtrees. Includes *tree-csyms")
(defparameter *tree-csyms  NIL "The tree root(s) above the subtrees") ;;was '(1 2 3 4 5)) 
(defparameter  *tree-csym-childlists NIL "Child complete lists/subtrees of a given ROOT including other keys & values at that level.")
(defparameter  *tree-csym-sublists NIL "The child subtreekey value= list/subtree w/dims=ROOT.")
;;pane and text parameters
(defparameter  *cs-title-pane-font-size  14 )
(defparameter *cs-title-pane-font-color :RED )
(defparameter *cs-title-pane-height 40 )
(defparameter *cs-title-pane-width NIL)
(defparameter *cs-title-pane-background :LIGHTYELLOW)
(defparameter *cs-instr-pane-font-size  12)
(defparameter *cs-instr-pane-font-color :BLACK)
(defparameter  *cs-instr-pane-height 70)
(defparameter *cs-instr-pane-background :LIGHT-BLUE)
(defparameter *cs-instr-pane-width  NIL)

(defparameter *cs-text-go-button-callback nil)
(defparameter *cs-checkbox-button-text   "  NO CHECK BOX     ")
(defparameter  *cs-expanded-view-text  "   COLLAPSED VIEW   " )
(defparameter  *incl-cs-viewer-check-boxes T)

(defparameter  *cs-checkbox-button-text-def  " OMIT DEFINITIONS ")
(defparameter  *cs-checkbox-button-text-desc " OMIT DESCRIPTIONS ")
(defparameter  *cs-checkbox-button-text-data  " OMIT DATA--except scores ")

;;parameters for adjusting csym-treeviewer node info
(defparameter  *print-all-cs-node-info-p T "Prints all node info for each node in frame")
(defparameter *omit-sublists-in-node-info T "Omits printing sublist info in node info")
(defparameter *expanded-csym-node-list-p T "Leaves only minimal info in each node")
(defparameter *new-csym-sublist-value "See +" "Replaces sublist in dimlist node info")
(defparameter *tree-csym-childlists-w-sublists nil "Temp reset of dim sublists including actual sublists")

(defparameter *treeview-flat-tree-list NIL)
(defparameter *child-root-value NIL"keyvalue value")
;;(defparameter *child-dimlists NIL)
(defparameter *cs-tree-root-csyms '($CS) "Roots for entire cs-tree-viewer")
;;(defparameter *tree-root-dimlists  NIL)
(defparameter *tree-flat-dimlists NIL)
(defparameter *tree-csym-leveln-list NIL)
(defparameter *totaln-nodes  NIL)
(defparameter  *tree-csym-sublists NIL )  
(defparameter *treeview-expand-level  99 "Default= 99, expand up to that level")
(defparameter *my-dim-tree NIL)
(defparameter *my-node-expand-function   'my-csym-node-expandp-function )

(defparameter *treeviewer-options-interface-title " Cognitive Systems TreeViewer Options")
(defparameter *treeviewer-options-title " Cognitive Systems TreeViewer Options")
(defparameter  *treeviewer-options-instrs "Check the item below for viewing the Cognitive Systems Tree")




;;TREEVIEWER-OPTIONS-INTERFACE
;;2019
;;ddd
(capi:define-interface treeviewer-options-interface ()
  (
   (calling-process
    :initarg :calling-process
    :accessor calling-process
    :initform NIL
    :documentation  "calling-process")
   )
  (:panes
   (title-rich-text-pane
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format (list ;; :face *cs-title-pane-font-face
                            :size  *cs-title-pane-font-size 
                            :color *cs-title-pane-font-color
                            :bold T :italic nil :underline nil )
    :paragraph-format  (list :alignment :center  ;; :left :right
                             ;;no effect?  :start-indent 20
                             ;;no effect? :offset-indent 20
                             ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                             :tab-stops  '(5 10 15 20)
                             :numbering nil 
                             ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                             )
    :text *treeviewer-options-title
    :visible-border T
    ;;only adds at bottom when use format? 
    :internal-border 8
    :visible-min-height *cs-title-pane-height  :visible-max-height *cs-title-pane-height
    :external-min-width *cs-title-pane-width  ;; :external-max-width *cs-title-pane-width
 ;;    :foreground *cs-title-pane-foreground 
    :background *cs-title-pane-background
    ;;text done elsewhere  :text *cs-title-area-text 
    ;;doesn't work :y 10
    )
   (instr-rich-text-pane
    capi:rich-text-pane    :accepts-focus-p NIL
    :character-format  (list ;; :face *instr-pane-font-face 
                             :size  *cs-instr-pane-font-size  
                             :color *cs-instr-pane-font-color
                             :bold nil :italic nil :underline nil )
    :paragraph-format '(:alignment :center  ;; :left :right
                        :start-indent 20
                        :offset-indent 20
                        ;;  :relative-indent 1.0  ;;relative indent for rest of paragraphs
                        :tab-stops  '(5 10 15 20)
                        :numbering nil 
                        ;;OR :bullet, :arabic, :lowercase,:uppercase, :lower-roman or :upper-roman.
                        )
    :text *treeviewer-options-instrs
   ;;doesn't work :enabled nil
    :visible-border T
    :internal-border 8
    :visible-min-height *cs-instr-pane-height :visible-max-height *cs-instr-pane-height
    :external-min-width *cs-instr-pane-width ;; :external-max-width *instr-pane-width
    ;;   :foreground *instr-pane-foreground 
    :background *cs-instr-pane-background
    ;;text done elsewhere   :text  (format nil "~%   ~A  " *instr-area-text)
    )
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
    :text "Print how much information at EVERY tree node."
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
   (radio-button-panel-1
    capi:radio-button-panel
    :items '("   DETAILED info  " "  LESS info  "  "  BRIEFEST info  ")
    :selection 0
    :max-width t
    :max-height t)
   (rich-text-pane-2
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
  #| (radio-button-panel-2
    capi:radio-button-panel
    :items '("Radio-Button-Panel-2" "Button 2" "Button 3")
    :max-width t
    :max-height t)
   (rich-text-pane-3
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
    )|#
   #|(radio-button-panel-3
    capi:radio-button-panel
    :items '("Radio-Button-Panel-3" "Button 2" "Button 3")
    :max-width t
    :max-height t)|#
   (rich-text-pane-4
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
    :text "Select ALL that you want"
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
   (check-button-panel-1
    capi:check-button-panel
    :items (list *cs-checkbox-button-text  *cs-expanded-view-text)
        ;;  "  NO CHECK BOX     " "   COLLAPSED VIEW   " 
    :max-width t
    :max-height t)
   (rich-text-pane-5  
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
    :text "Select information to OMIT in EVERY tree node."
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
(check-button-panel-2
    capi:check-button-panel
    :items (list *cs-checkbox-button-text-def  *cs-checkbox-button-text-desc
                 *cs-checkbox-button-text-data)
        ;;  "  NO CHECK BOX     " "   COLLAPSED VIEW   " 
    :max-width t
    :max-height t)
   #|(push-button-1
    capi:push-button
    :text "Push-Button-1")|#
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
        :callback 'CS-treeviewer-go-callback
        :callback-type :data-interface
        :data *cs-text-go-button-callback ;;nil
        ;;was (gp:make-font-description :size *button-font-size  :weight :bold) ;; :slant :italic)
        ;;doesn't work    :character-format *cs-title-pane-char-format
        ;;doesn't work?    :x 20   :y 20
        ))
  (:layouts
   (column-layout-1
    capi:column-layout
    '(title-rich-text-pane :separator instr-rich-text-pane :separator 
     rich-text-pane-1 
     radio-button-panel-1 :separator
#|      rich-text-pane-2 radio-button-panel-2 :separator 
      rich-text-pane-3 radio-button-panel-3 :separator|#
      rich-text-pane-4 check-button-panel-1 :separator
      rich-text-pane-5 check-button-panel-2 :separator row-layout-1))
   (row-layout-1
    capi:row-layout
    '( go-frame-button)))
  (:menu-bar menu-1 menu-2)
  (:menus
   (menu-2
    "Menu-2"
    ("Item-3"
     "Item-4"
     (:component
      ())))
   (menu-1
    "Menu-1"
    ("Item-1"
     "Item-2")))
  (:default-initargs
   :best-height 600
   :best-width 600
   :internal-border 15
   :background :green
   :layout 'column-layout-1
   :title *treeviewer-options-interface-title)
  ;;end treeviewer-options-interface
  )


;;MAKE-TREEVIEWER-OPTIONS-INTERFACE
;;2019
;;ddd
(defun make-treeviewer-options-interface (calling-interface)
  "CS-csym-tree-viewer "
  (let*
      ((inst (make-instance 'treeviewer-options-interface))
       )
    (setf (slot-value inst 'calling-process) calling-interface)
    (capi:display inst)
    inst    
    ;;end let,make-treeviewer-options-interface
    ))
;;TEST
;; (make-treeviewer-options-interface nil)




;;CSYM-TREEVIEWER-INTERFACE
;;2019
;;ddd
(capi:define-interface CSYM-TREEVIEWER-INTERFACE ()
  (
   (calling-process
    :initarg :calling-process
    :accessor calling-process
    :initform NIL
    :documentation  "mp process calling it")
#|   (tree-nodes-list
    :initarg :tree-nodes-list
    :accessor tree-nodes-list
    :initform NIL
    :type  :list
    :documentation  "tree-nodes-list")
   (tree-roots-list
    :initarg :tree-roots-list
    :accessor tree-roots-list
    :initform NIL
    :documentation  "tree-roots-list")
   (tree-dimlists
    :initarg :tree-dimlists
    :accessor tree-dimlists
    :initform NIL
    :documentation  "tree-rootn-list")
   (treeview-expand-level
    :initarg :treeview-expand-level
    :accessor treeview-expand-level
    :initform NIL
    :documentation  "Data from text input")
   (totaln-nodes
    :initarg :totaln-nodes
    :accessor totaln-nodes
    :initform NIL
    :documentation  "totaln-nodes")
  |#
   ;;end SLOT VARIABLES
   ) 
  (:PANES
   (tree capi:tree-view
         :roots  *cs-tree-root-csyms  ;;was '(1 2 3 4) 
         :leaf-node-p-function 'MY-LEAF-NODE-P-FUNCTION
         :children-function 'CSYM-TREEVIEW-CHILDREN-FUNCTION
         ;; :image-lists (list :normal *my-image-list*)
         ;; :image-function #'(lambda (x) (mod (1- x) 4))
         :checkbox-status 0  ;;or  2=checked initially; NIL= no checkbox
      ;;   :visible-min-width 500
       ;;  :visible-min-height 800
         :has-root-line T
         :retain-expanded-nodes T
         :expandp-function  *my-expand-function
         ;;set in the make-instance :expandp-function 'my-expandp-function
         ;; :expandp-function USE TO FIND NESTED-LIST ITEMS TO DISPLAY AT EACH SUB CHILD MODE?? (it is called each time expand a node)
         ;;OR try to design a function for :children-function that auto fills all in at the beginning instead of calling a function to search (possibly deep in a tree) at each node
         :print-function 'PRINT-CSYM-NODE-INFO  ;;was #'(lambda(x) (format nil "~d : ~r" x x ))
         :selection-callback #'(lambda (item self)
                                 (declare (ignore self))
                                 (format t "~&Select item ~S~%" item))
         :action-callback 'action-callback ;;was  #'(lambda (item self)    (declare (ignore self))   (format t "~&Activate item ~S~%" item))
         :delete-item-callback #'(lambda (self item)
                                   (declare (ignore self))
                                   (format t "~&Delete item ~S~%" item))))
  (:layouts
   (default-layout
    capi:simple-layout
    '(tree)))
  (:default-initargs
   :title *csym-treeviewer-frame-title
 ;;  :checkbox-status *cs-ch
   )
  ;;end interface
  )





;;MAKE-CSYM-TREEVIEWER
;;2019
;;ddd
(defun make-csym-treeviewer (top-csym-list
                             &key (frame-title *csym-treeviewer-frame-title)    
                             (check-boxes-p *incl-cs-viewer-check-boxes)
                             (make-treeviewer-options-interface 
                              *make-treeviewer-options-interface)
                             group-by-val-p  order-by-rank-p
                             omit-def-p omit-desc-p omit-data-p
                             last-list=value-p (valkey :V) (sublistkey :S)
                             (min-treeview-pane-height *csym-treeviewer-frame-ht)
                             (min-treeview-pane-width *csym-treeviewer-frame-width)
                             (x *csym-treeviewer-frame-x )(y *csym-treeviewer-frame-y)        
                             frame-init-args (expand-tree-p 99)
                             (initial-y 20))
  #|  background   checkbox-change-callback   checkbox-initial-status   delete-item-callback    has-root-line     expandp-function    font  capi:help-key    image-lists   internal-border   keep-selection-p    leaf-node-p-function   retain-expanded-nodes   visible-border|#
  "CS-csym-tree-viewer, makes a tree-view frame that uses make-tree-nodes to create a tree view of ANY dimstree to any degree of nesting. expand-tree-p= T for initial expansion of all nodes. last-list=value-p puts the value after the sublists."
  ;;make sure it is a list
  (unless (listp top-csym-list)
    (setf top-csym-list (list top-csym-list)))

  ;;set the global roots var for :roots arg of tree-viewer pane
  (setf *cs-tree-root-csyms top-csym-list)
  ;;used in expand func to track unbound vars (temp ones created).
  (defvar *UNBOUND-TREE-SYMS NIL)

  ;;CALL *make-treeviewer-options-interface FIRST
  ;;pre-set some view options
  (setf *omit-csym-treeview-def-p omit-def-p     
        *omit-csym-treeview-desc-p omit-desc-p 
        *omit-csym-treeview-data-p omit-data-p)
  ;;interface overides above settings
  (when make-treeviewer-options-interface
    (make-treeviewer-options-interface (mp:get-current-process))
    ;;pause current                                      
   (mp:current-process-pause 20))

  ;; SSSSS MAKE AUTOMATIC FROM DIMSTREE? 
  ;;; *tree-csyms  *tree-csym-childlists)
  (let*
      ((frame-call-args `(make-instance 'CSYM-TREEVIEWER-INTERFACE
                                        :title ,frame-title :x ,x :y ,y 
                                        :calling-process (mp:get-current-process)))
       ;;error :checkbox-status ,check-boxes-p))                                     
       (tree-inst)
       (expand-function)
       )
    (mp:current-process-pause 20)
#|   (cond
     (expand-tree-p
      (setf *my-expand-function 'my-csym-node-expandp-function)
      (when (numberp expand-tree-p)
        (setf  *treeview-expand-level expand-tree-p)))
     (t (setf *my-expand-function 'my-not-expandp-function)))|#

    (setf frame-init-args (append frame-init-args 
                                  (list  :visible-min-height 
                                        min-treeview-pane-height
                                        :visible-min-width min-treeview-pane-width)))       
    (setf frame-call-args (append frame-call-args frame-init-args))
    ;;(break "before make frame")

    ;;MAKE OPTIONS INSTANCE AFTER ALL ABOVE VALUES SET
    (setf tree-inst (eval frame-call-args))
    (break "after make-frame before display tree")
    
    ;;SET THE VARIABLE VALUES
    #|    (setf (slot-value tree-inst 'totaln-nodes) *totaln-nodes
          (slot-value tree-inst 'treeview-expand-level) expand-tree-p
          (slot-value tree-inst 'tree-nodes-list) *csym-tree-list
          (slot-value tree-inst 'tree-roots-list) *tree-roots-list
          (slot-value tree-inst 'tree-rootn-list) *tree-rootn-list
          ;;(slot-value tree-inst ' 
          )|#

    (capi:display tree-inst)
    (format T "==> UNBOUND CSYMS= ~A" *unbound-tree-syms)
    ;;end let, make-csym-treeviewer
    ))
;;TEST
;;for new-trees
;; (setf *tree-csyms '(($CS)))
;; (make-csym-treeviewer '$CS )

;;SSSSS PROBLEMS FOUND WITH TREEVIEWER & CRASH ON LOAD CSQ-QVARS.lisp  >>>> THIS IS FRESH LW SESSION!!
;; 1. NO SCORES FOR NON-MC = TXT CSYMS
;; 2. NO SCORES FOR MC
;; 3. STUCOLLE HAS NO SCORE :VA OR :MDAT
;; 4. 


;;OLDER--CHECK
;;2..  <SCOLLEGE SUB-CSYMS HAVE NO SCORES & NO SUB-ANS QVARS --EG COLLEGE ATTENDING, ETC. BUT <STUMAJOR WORKS PERFECTLY!!
;; PROBLEM ABOVE MAY BE THAT SUB-ANS CSYMS NOT IN :S OF MAIN QUEST
;; 3. <ACAD-ACH  HAS NO SCORES FOR ANY 

;
;; 5. ELMS HAVE NO LINK INFO--DO I WANT IT???
;;

;; ALL? SCALES W/ SUBSCALES: QVARS LISTED UNDER BOTH.
;; CAUSE?? ADDED TO SUBSCALES IN BOTH SCALE & SUB :S.
;; egs.
;;. <SWORLDVIEW, $HISF, + <SGRFEARS, <SETHBEL HAVE QVARS UNDER BOTH SUBSCALES & MAIN SCALE, GRFEARS
;;        NOTE: THEY ARE LISTED IN SUBSCALES & QUESTS IN NEW-SCALES
 ;;  $HISF HAS 2 COPIES OF QVARS UNDER $HISF.<T1HIGHSLF W/ ONE << 
;;            PLUS 1 COPY UNDER $HISF

;;  
;; 
 

;;

;; *CS-CAT-DB-TREE



;;================ SUB FUNCTIONS ======================
;;FUNCTIONS USED BY METHOD INITIALIZE-INSTANCE :AROUND
;; 0 :ROOTS
#|1 ($CS)
 :LEAF-NODE-P-FUNCTION =  MY-LEAF-NODE-P-FUNCTION
 :CHILDREN-FUNCTION = 5 CSYM-TREEVIEW-CHILDREN-FUNCTION
 :CHECKBOX-STATUS =  0
 :HAS-ROOT-LINE =  T
 :RETAIN-EXPANDED-NODES =  T
 :EXPANDP-FUNCTION = MY-CSYM-NODE-EXPANDP-FUNCTION
 :PRINT-FUNCTION =  PRINT-CSYM-NODE-INFO
  :SELECTION-CALLBACK =  #<Function 1 subfunction of (METHOD CAPI::INITIALIZE-INTERFACE :AFTER (CSYM-TREEVIEWER-INTERFACE)) 42D00183B4>
 :ACTION-CALLBACK =  ACTION-CALLBACK
 :DELETE-ITEM-CALLBACK =  #<Function 2 subfunction of (METHOD CAPI::INITIALIZE-INTERFACE :AFTER (CSYM-TREEVIEWER-INTERFACE)) 42D001833C>
 :NAME =  TREE
 :DO-CACHE =  NIL
 :ITEMS-COUNT-FUNCTION =  #<Function LENGTH 419004A304>
 :ITEMS-GET-FUNCTION =  #<Function ELT 419004A574>
 :ITEMS-MAP-FUNCTION =  #<Function 1 subfunction of CLOS::NON-TRIVIAL-INITFORM-INITFUNCTION 419004A684>
 :VERTICAL-SCROLL =  T    :HELP-KEY =  NIL
|#



;;CSYM-TREEVIEW-CHILDREN-FUNCTION
;;2019
;;ddd
(defun csym-treeview-children-function (csym)
  "CS-csym-tree-viewer - same as U-trees treeview-children-function? RETURNS *child-dimlists. MUST SET *CSYM-TREE-LIST TO THE TREE LIST."
  (when (and csym (boundp csym))  
    (let*
        ((csymvals (eval csym))
         (child-sublist (eval-syms (get-key-value :S csymvals)))
         )      
      ;;(when (equal csym 'careforothers)  (break "childlist"))
         child-sublist
       ;;end let,when,csym-treeview-children-function
       )))
;;TEST
;;for new-trees
;;;; (setf *tree-csyms  '(($CS)))






;;PRINT-CSYM-NODE-INFO
;;2019
;;ddd
(defun print-csym-node-info (csym) 
  "CS-new-trees-viewer. Used in Tree-View Interface"
  (let
      ((node-print-string)
       )
   #|(when (equal csym 'careforothers)
        (break "all-node-info-text OR all-info-keylist"))|#   
    (multiple-value-bind (all-node-info-text  all-info-keylist key-val-pairs keys values)  
        (get-csym-info csym :max-def-n *max-tree-def-n 
                       :max-desc-n *max-tree-desc-n  
                       :omit-def-p  *omit-csym-treeview-def-p   
                       :omit-desc-p *omit-csym-treeview-desc-p
                       :omit-data-p *omit-csym-treeview-data-p)
      (cond
       (*print-all-cs-node-info-p 
        (setf node-print-string all-node-info-text))
       (t (setf node-print-string all-info-keylist)))
      #|(when (equal csym 'careforothers)
        (break "all-node-info-text OR all-info-keylist"))|#
      node-print-string
      ;;end mvb, let,print-csym-node-info
      )))


#|OLD -note error on print-info-string vs node-info-string
(defun print-csym-node-info (csym) 
  "CS-new-trees-viewer. Used in Tree-View Interface"
  (let
      ((node-print-string)
       )
    (multiple-value-bind (all-info-keylist key-val-pairs keys values print-info-string
                                            csyms csvals)       
        (get-csym-info csym )

      (cond
       (*print-all-cs-node-info-p 
        (setf node-print-string all-info-string))
       (t (setf node-print-string node-info-string)))
      node-print-string
      ;;end mvb, let,print-csym-node-info
      )))|#


;;MY-CSYM-NODE-EXPANDP-FUNCTION
;;2019
;;ddd
(defun my-csym-node-expandp-function (csym)
  "In CS-csym-tree-viewer"
  ;;(when (equal csym :qt) (break "CSYM= :QT"))
  ;;if problems in conversion of scales, etc.
  (unless (boundp csym)
    (setf csym (my-make-cs-symbol  csym :prestr "<"))
    (set csym (list (format nil "~A" csym) (format nil "~A" csym) csym NIL NIL))
    (setf *unbound-tree-syms (append *unbound-tree-syms (list csym))))
  (let
      ((expandp T)
       (roots (nth-value 2 (make-art-symdims-list (third (eval csym)))))
       )
;; (nth-value 2 (make-art-symdims-list (third (eval '$CS))))
   (when (and (listp roots)
              (> (length roots) *treeview-expand-level))
     (setf expandp NIL))
    ;;(when (equal csym 'careforothers) (break "roots"))
   ;;(afout 'out (format nil "IN my-csym-node-expandp-function: ~% CSYM= ~A  ROOTS= ~A" csym roots))
   ;;added
   (when *expanded-csym-node-list-p 
     (setf expandp T))  
   expandp
  ;;end  let, my-csym-node-expandp-function
  ))


;;MY-NOT-EXPANDP-FUNCTION
;;
;;ddd
(defun my-NOT-expandp-function (roots)
  "CS-csym-tree-viewer"
   NIL
  ;;end  my-expandp-function
  )





;;CS-TREEVIEWER-GO-CALLBACK
;;2019
;;ddd
(defun CS-treeviewer-go-callback (data interface)
  "CS-csym-tree-viewer Sets options for CSYM-TREEVIEWER-INTERFACE"
    (with-slots (calling-process radio-button-panel-1  check-button-panel-1 
                                 check-button-panel-2) interface
                                   ;;radio-button-panel-2 radio-button-panel-3
      ;;note:  (capi:choice-selected-item radio-button-panel-1) => item text output
  (let
      ((radio1-selection (capi:choice-selection radio-button-panel-1))
      ;;(radio2-selection (capi:choice-selected-item radio-button-panel-2))
      ;;(radio3-selection (capi:choice-selected-item radio-button-panel-3))
      ;;for check-button-panel-1
      (check-panel-1-selected (capi:choice-selected-items  check-button-panel-1))
      (check-panel-2-selected (capi:choice-selected-items  check-button-panel-2))
      (calling-process (slot-value interface 'calling-process))
      )    
      ;;FOR radio-button-panel-1
      (cond
       ((= radio1-selection 0)
        (setf  *incl-all-node-info-p T
               *csym-treeviewer-frame-width 1300));;was *incl-csymlist-in-treeviewer-p NIL
       ((= radio1-selection 1)
        (setf  *incl-all-node-info-p NIL             
               *incl-csymlist-in-treeviewer-p T
               *csym-treeviewer-frame-width 1300));;  *expanded-csym-node-list-p T))
       ((= radio1-selection 2)
        (setf *incl-all-node-info-p NIL
              *incl-csymlist-in-treeviewer-p NIL)))

      ;;FOR CHECK BOX  
      (cond
       ((member *cs-checkbox-button-text check-panel-1-selected
                :test 'string-equal)
        (setf *incl-cs-viewer-check-boxes NIL))
        (t (setf *incl-cs-viewer-check-boxes T)))
;;(defparameter *cs-checkbox-button-text   "  NO CHECK BOX     ")
;;(defparameter  *cs-expanded-view-text) "   COLLAPSED VIEW   ")
    
      ;;FOR EXPANDED VIEW  HERENOW
      (cond
       ((member *cs-expanded-view-text check-panel-1-selected :test 'string-equal)
        (setf  *expanded-csym-node-list-p NIL
               *my-expand-function 'my-not-expandp-function))
       (t (setf  *expanded-csym-node-list-p T
                 *my-expand-function 'my-csym-node-expandp-function)
          (when (numberp expand-tree-p)
            (setf  *treeview-expand-level expand-tree-p))))
      ;;(break "In Callback: *expanded-csym-node-list-p")
      ;;FOR CHECK BOX 2: OMITS
      (cond
       ((member *cs-checkbox-button-text-def check-panel-2-selected
                :test 'string-equal)       
        (setf  *omit-csym-treeview-def-p T))
       (t (setf  *omit-csym-treeview-def-p NIL)))
      (cond
       ((member *cs-checkbox-button-text-desc check-panel-2-selected
                :test 'string-equal)       
        (setf  *omit-csym-treeview-desc-p T))
       (t (setf  *omit-csym-treeview-desc-p NIL)))
      (cond
       ((member *cs-checkbox-button-text-data check-panel-2-selected
                :test 'string-equal)       
        (setf  *omit-csym-treeview-data-p T))
       (t (setf  *omit-csym-treeview-data-p NIL)))
     ;; (sleep 1)
      ;;POKE
      (when calling-process
        (mp:process-poke calling-process))
       ;;DESTROY
       (capi:destroy interface)
       (values  radio1-selection) ;; radio2-selection radio3-selection)
       ;;end let, with, let, CS-treeviewer-go-callback
       )))
;;TEST
;; (CS-treeviewer-go-callback



