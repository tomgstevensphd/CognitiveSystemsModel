;;********************* U-trees-art-dims *******************************
;;see U-trees for more general tree viewer
;; also see MyUtilities/U-trees-art-dims for dims (CS HQ 3 2) oriented trees based upon tree lists ONLY-not able to eval CSYMs to get roots, but must search a tree.


;;== ARTSYM TREES & OTHER  DIMLIST TREES-----------------------------
;;NOTATION
;;
;; In U-TREES, ROOTN = DIM, ROOTNLIST = DIMLIST, ROOTNLISTS = DIMLISTS


#|Copy, modify make nodes list.
For each node not an int or value,
Instead, keys in any order.Can be no keys. Note, puttng happy CSYM is redundant, since CS-HS-1 evals to list w CSYM. Also value redundant.
For viewing tree, the tree viewer could eval ARTSYM and fill in CSYM and value (also keeps non redundant DB).
Could write a function to fill in csyms and values w csyms from eval artsyms. 
(NodeID :v Value :s sublist :c csym) 
Eg.  (CS :s (HS :s (1 :c happy :v .917 :s (2 :c integrity))(2 :c honest)))
MAKES=> 
((CS) CS :S ((CS HS) CS-HS :S ((CS HS 1) CS-HS-1 :s happy :v .917 :S ((CS HS 1 2)CS-HS-1-2 :s integrity)) ((CS HS 2) CS-HS-2 :s honest)))|#

;;make-treeviewer-options-interface first
(defparameter  *make-treeviewer-options-interface T)

;;dim-treeviewer frame options
(defparameter *dim-treeviewer-frame-title "Tom's Cognitive Systems TreeViewer")
(defparameter  *incl-csymlist-in-treeviewer-p NIL "Includes csymvals in each node printout")
(defparameter *dim-treeviewer-frame-ht 800 )
(defparameter *dim-treeviewer-frame-width (cond (*incl-csymlist-in-treeviewer-p 1300) (t 800)))
(defparameter *dim-treeviewer-frame-x 10 )
(defparameter *dim-treeviewer-frame-y 30)
(defparameter *dim-tree-list NIL "Main dim-tree-list incls all sublists/subtrees. Includes *tree-dimroots")
(defparameter *tree-dimroots  NIL "The tree root(s) above the subtrees") ;;was '(1 2 3 4 5)) 
(defparameter  *tree-dimroot-childlists NIL "Child complete lists/subtrees of a given ROOT including other keys & values at that level.")
(defparameter  *tree-dimroot-sublists NIL "The child subtreekey value= list/subtree w/dims=ROOT.")

;;parameters for adjusting dims-treeviewer node info
(defparameter  *print-all-node-info-p NIL "Prints all node info for each node in frame")
(defparameter *omit-sublists-in-node-info T "Omits printing sublist info in node info")
(defparameter *expanded-node-list-p NIL "Leaves only minimal info in each node")
(defparameter *new-dim-sublist-value "See +" "Replaces sublist in dimlist node info")
(defparameter *tree-dimroot-childlists-w-sublists nil "Temp reset of dim sublists including actual sublists")

(defparameter *treeview-flat-tree-list NIL)
(defparameter *child-root-value NIL"keyvalue value")
(defparameter *child-dimlists NIL)

(defparameter *tree-root-dimlists  NIL)
(defparameter *tree-flat-dimlists NIL)
(defparameter *tree-dimroot-leveln-list NIL)
(defparameter *totaln-nodes  NIL)
(defparameter  *tree-dimroot-sublists NIL )  
(defparameter *treeview-expand-level  99 "Default= 99, expand up to that level")
(defparameter *my-dim-tree NIL)
(defparameter *my-dims-expand-function   'my-dims-expandp-function )


;;XXX FOR TESTING
 (setf *tree-dimroots '((CS))
  *dim-tree-list
 '(((CS)   "CS"  :S
  (((CS HS)    "CS.HS"    :S
    (((CS HS 1)      "CS.HS.1"  :C CAREFOROTHERS     :S
      (((CS HS 1 1) "CS.HS.1.1" :C INTIMATE) ((CS HS 1 2) "CS.HS.1.2" :C UNDERSTANDING)))
     ((CS HS 2)      "CS.HS.2"  :C INTIMATE    :S
      (((CS HS 2 1) "CS.HS.2.1" :C FLEXIBLE )
       ((CS HS 2 2) "CS.HS.2.2" :C EXUBERANT)
       ((CS HS 2 3) "CS.HS.2.3" :C LOVEDANCE)))
     ((CS HS 3) "CS.HS.3")))
   ((CS MS)    "CS.MS"    :S
    (((CS MS MS1)      "CS.MS.MS1"      :S
      (((CS MS MS1 1) "CS.MS.MS1.1") ((CS MS MS1 2) "CS.MS.MS1.2")))))))))


(defparameter *treeviewer-options-interface-title " Cognitive Systems TreeViewer Options")
(defparameter *treeviewer-options-title " Cognitive Systems TreeViewer Options")
(defparameter  *treeviewer-options-instrs "Check the item below for viewing the Cognitive Systems Tree")




;;TREEVIEWER-OPTIONS-INTERFACE
;;2019
;;ddd
(capi:define-interface treeviewer-options-interface ()
  (
   (calling-interface
    :initarg :calling-interface
    :accessor calling-interface
    :initform NIL
    :documentation  "calling-interface")
   )
  (:panes
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
    :text *treeviewer-options-title
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
    :text *treeviewer-options-instrs
   ;;doesn't work :enabled nil
    :visible-border T
    :internal-border 8
    :visible-min-height *instr-pane-height :visible-max-height *instr-pane-height
    :external-min-width *instr-pane-width ;; :external-max-width *instr-pane-width
    ;;   :foreground *instr-pane-foreground 
    :background *instr-pane-background
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
    :items '("Brief info" "Expanded info" "Include CS detailed info")
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
   (radio-button-panel-2
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
    )
   (radio-button-panel-3
    capi:radio-button-panel
    :items '("Radio-Button-Panel-3" "Button 2" "Button 3")
    :max-width t
    :max-height t)
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
    :items '("CHECK-Button-Panel-1" "Button 2" "Button 3")
    :max-width t
    :max-height t)
   (push-button-1
    capi:push-button
    :text "Push-Button-1")
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
        :callback 'treeviewer-go-callback
        :callback-type :data-interface
        :data *text-go-button-callback
        ;;was (gp:make-font-description :size *button-font-size  :weight :bold) ;; :slant :italic)
        ;;doesn't work    :character-format *title-pane-char-format
        ;;doesn't work?    :x 20   :y 20
        ))
  (:layouts
   (column-layout-1
    capi:column-layout
    '(title-rich-text-pane :separator instr-rich-text-pane :separator rich-text-pane-1 
     radio-button-panel-1 :separator
      rich-text-pane-2 radio-button-panel-2 :separator 
      rich-text-pane-3 radio-button-panel-3 :separator
      rich-text-pane-4 check-button-panel-1 :separator row-layout-1))
   (row-layout-1
    capi:row-layout
    '(push-button-1 go-frame-button)))
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
   :layout 'column-layout-1
   :title *treeviewer-options-interface-title)
  ;;end treeviewer-options-interface
  )


;;MAKE-TREEVIEWER-OPTIONS-INTERFACE
;;2019
;;ddd
(defun make-treeviewer-options-interface (calling-interface)
  "U-trees-art-dims "
  (let*
      ((inst (make-instance 'treeviewer-options-interface))
       )
    (setf (slot-value inst 'calling-interface) calling-interface)
    (capi:display inst)
    inst
    
    ;;end let,make-treeviewer-options-interface
    ))
;;TEST
;; (make-treeviewer-options-interface)




;;DIM-TREEVIEWER-INTERFACE
;;2019
;;ddd
(capi:define-interface DIM-TREEVIEWER-INTERFACE ()
  (
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
         :roots  *tree-dimroots  ;;was '(1 2 3 4) 
         :leaf-node-p-function 'MY-LEAF-NODE-P-FUNCTION
         :children-function 'DIM-TREEVIEW-CHILDREN-FUNCTION
         ;; :image-lists (list :normal *my-image-list*)
         ;; :image-function #'(lambda (x) (mod (1- x) 4))
         :checkbox-status 0  ;;or  2=checked initially; NIL= no checkbox
      ;;   :visible-min-width 500
       ;;  :visible-min-height 800
         :has-root-line T
         :retain-expanded-nodes T
         :expandp-function  *MY-DIMS-EXPAND-FUNCTION
         ;;set in the make-instance :expandp-function 'my-expandp-function
         ;; :expandp-function USE TO FIND NESTED-LIST ITEMS TO DISPLAY AT EACH SUB CHILD MODE?? (it is called each time expand a node)
         ;;OR try to design a function for :children-function that auto fills all in at the beginning instead of calling a function to search (possibly deep in a tree) at each node
         :print-function 'MY-DIM-PRINT-FUNCTION  ;;was #'(lambda(x) (format nil "~d : ~r" x x ))
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
   :title *dim-treeviewer-frame-title)
  ;;end interface
  )





;;MAKE-DIMS-TREEVIEWER
;;2019
;;ddd
(defun make-dims-treeviewer (dimstree 
                             &key (frame-title *dim-treeviewer-frame-title)
                             tree-nodes  tree-nodelists
                             (make-treeviewer-options-interface 
                              *make-treeviewer-options-interface)
                             group-by-val-p  order-by-rank-p
                             last-list=value-p (valkey :V) (sublistkey :S)
                             (min-treeview-pane-height *dim-treeviewer-frame-ht)
                             (min-treeview-pane-width *dim-treeviewer-frame-width)
                             (x *dim-treeviewer-frame-x )(y *dim-treeviewer-frame-y)            
                             frame-init-args (expand-tree-p 99)
                             (initial-y 20))
  #|  background   checkbox-change-callback   checkbox-initial-status   delete-item-callback    has-root-line     expandp-function    font  capi:help-key    image-lists   internal-border   keep-selection-p    leaf-node-p-function   retain-expanded-nodes   visible-border|#
  "In U-trees, makes a tree-view frame that uses make-tree-nodes to create a tree view of ANY dimstree to any degree of nesting. expand-tree-p= T for initial expansion of all nodes. last-list=value-p puts the value after the sublists."


  #| NO: DIMSTREE IS INPUT--NOT MADE HERE
    (multiple-value-setq (*tree-dimnodes-list *tree-dimrootn-list 
                                            *tree-flat-dimrootn-list *tree-dimroot-leveln-list
                                            *totaln-dimnodes  *tree-dimroots)
     (make-tree-from-dimlists list :group-by-val-p group-by-val-p  
                            :order-by-rank-p  order-by-rank-p
                            :last-list=value-p last-list=value-p
                            :valkey valkey :sublistkey sublistkey))|#
  ;;here11
  ;;(break "after make-tree-nodes-list")

  ;;CALL *make-treeviewer-options-interface FIRST
  (when make-treeviewer-options-interface
    (make-treeviewer-options-interface (mp:get-current-process))
    ;;pause current                                      
   (mp:current-process-pause 30))

  ;;FIND *tree-dimroots
  (setf *dim-tree-list dimstree)
  ;; SSSSS MAKE AUTOMATIC FROM DIMSTREE? 
  ;;; *tree-dimroots  *tree-dimroot-childlists)

  (let*
      ((frame-call-args `(make-instance 'dim-treeviewer-interface :title ,frame-title :x ,x :y ,y))
       (tree-inst)
       (expand-function)
       )
    (cond
     (expand-tree-p
      (setf *my-expand-function 'my-expandp-function)
      (when (numberp (setf  *treeview-expand-level expand-tree-p))))
     (t (setf *my-expand-function 'my-not-expandp-function)))
    #| doesn't work   (setf frame-call-args (append frame-call-args 
                                  `(:expandp-function (quote ,expand-function))))|#
    ;;herego
    (setf frame-init-args (append frame-init-args 
                                  (list :y initial-y :visible-min-height 
                                        min-treeview-pane-height
                                        :visible-min-width min-treeview-pane-width)))       
    (setf frame-call-args (append frame-call-args frame-init-args))
    ;;(break "before make frame")
    (setf tree-inst (eval frame-call-args))
    ;;(break "after make-frame")
    
    ;;SET THE VARIABLE VALUES
    #|    (setf (slot-value tree-inst 'totaln-nodes) *totaln-nodes
          (slot-value tree-inst 'treeview-expand-level) expand-tree-p
          (slot-value tree-inst 'tree-nodes-list) *dim-tree-list
          (slot-value tree-inst 'tree-roots-list) *tree-roots-list
          (slot-value tree-inst 'tree-rootn-list) *tree-rootn-list
          ;;(slot-value tree-inst ' 
          )|#
    (capi:display tree-inst)
    ;;end let, make-dims-treeviewer
    ))
;;TEST
;;for new-trees
;; (setf *tree-dimroots '(($CS)))
;; (make-dims-treeviewer *CS-CAT-DB-TREE)

;; (setf *tree-dimroots '((CS)))
;; (setf  *dim-tree-list '( ((CS HS) "CS.HS"  :S ((((CS HS 1) "CS.HS.1"  :S (((CS HS 1 1) "CS.HS.1.1") ((CS HS 1 2) "CS.HS.1.2"))) ((CS HS 2) "CS.HS.2" :S (((CS HS 2 1) "CS.HS.2.1") ((CS HS 2 2) "CS.HS.2.2") ((CS HS 2 3) "CS.HS.2.3"))) ((CS HS 3) "CS.HS.3"))) ((CS MS) "CS.MS" :S (((CS MS MS1) "CS.MS.MS1" :S (((CS MS MS1 1) "CS.MS.MS1.1") ((CS MS MS1 2) "CS.MS.MS1.2"))))))))


;; SSSSSS START HERE TESTING make-dims-treeviewer
;; (make-dims-treeviewer *dim-tree-list )


;;MAKE-TREE-FROM-DIMLISTS
;;2019
;;ddd
(defun make-tree-from-dimlists  (tree &key   (cur-dim-n 0) 
                                   group-by-val-p  order-by-rank-p 
                                   (root-separator ".")
                                   last-list=value-p (csymkey :C) (valkey :V)(sublistkey :S)
                                   add-other-keys (default-key-value NIL)
                                   (tree-leveln 0) tree-leveln-list
                                     parent-dimlist parent-dimsymstr
                                   frame-init-args)
#|;; group-by-val-p  order-by-rank-p (root-separator ".")
                                    last-list=value-p (valkey :V=)(sublistkey :S)
                                    parent-rootn parent-rootnlist  (root-leveln 0)
                                    root-leveln-list frame-init-args)|#
  "In U-trees-art-dims, MAKES A COMPLEX TREE FROM A SIMPLIER INPUT FORMULA. Use in CS & ART.
   INPUT: All level-nodelist items (branch) must be a dim, key from keyslist, or following key-value.  Any can be list or not. (Each branch = level-nodelist can have leaves= nodelists within that level) Input eg= (cs :s (hs :s (1 :s (1 2)  2 :s (1  2  3)   3))  (ms :s (ms1 :s (1 2)))).  
  RETURNS (values return-tree. Eg. (((CS)\"CS\" :S (((CS HS) \"CS.HS\":S (((CS HS 1) \"CS.HS.1\":S (((CS HS 1 1) \"CS.HS.1.1\") ((CS HS 1 2) \"CS.HS.1.2\"))) ETC.
  USE IN CS/ART: artloc=dimlist (incl prefix); CSYM can either be found from eval artsym or csym can be stored as a value to csymkey.  Tree can be ART-CS DATABASE partially or completely filled.  If start empty, can add artsym/csym to prexisting dimlists. Or could add whole subtrees. Could either check boundp for dimsymstr or value for csymkey."
  #|All level-nodelist items (branch) must be dim ,key from keyslist, or Val.  Any can be list or not. (Each branch = level-nodelist can have leaves= nodelists).
Make new nodelist of dimlist, dimsynstr on item if it passes thru cond keys/keyvalues.
(when NULL NODELIST) and find new NONKEYORVALUE ITEM or on ITEM
when  last-level-item-p.
Append nodelist to LEVEL-MODELIST after last level item( in cur items loop) or
find new nonkeyorvalue item.
Append return-tree after loop end when nonnil level-nodelist.
Make new nodelist on lastitem when find key or levelist end.
|#
  (let*
      ((len-tree (list-length tree))
       (return-tree) 
       (nodelist)
       (level-nodelists)
       (totaln 0)
       (all-keys (append (list csymkey valkey sublistkey) add-other-keys))
       (previous-item=key-p)
       (next-sublist-p)
       (previous-item)
       (last-level-item-p)
       (root-level-dimlist parent-dimlist)
       (root-level-dimsymstr parent-dimsymstr)
       ;;added from old
       (flat-dims-list)
       (tree-leveln-list)
       (bottom-dimlist)
       )
    (incf tree-leveln)
    ;;WHEN TREE IS NON-NIL LIST
    (when (and tree (listp tree))
      ;;LOOP THRU ITEMS AT THIS LEVEL
      (LOOP
       for item in tree
       for item-n from 1 to len-tree
       do
       (let*
           ((dim)
            (dimlist)
            (dimsymstr)  
            (last-level-item-p (= item-n len-tree))          
            )
         (afout 'out (format nil "NEW LOOP ITEM= ~A~% nodelist= ~A level-nodelists= ~A return-tree= ~A" item nodelist level-nodelists return-tree))
         (cond   
          (next-sublist-p
           (setf next-sublist-p NIL
                 previous-item=key-p NIL)       

           ;;RECURSE 
           (multiple-value-bind (subtree  dimrootns
                                                   flat-dimrootns dimroot-leveln-list
                                                   totaln-dimnodes  dimroots)
               ;;was  flat-dims-list1 tree-leveln-list1 totaln1 bottom-dimlist1)
               ;;tree-leveln-list1 totaln) ;; bottom-dimlist)
               (make-tree-nodes-list item  ;;:n (- n 1) 
                                     :parent-dim dim
                                     :parent-dimlist parent-dimlist
                                     :parent-dimsymstr parent-dimsymstr
                                     :root-separator root-separator
                                     :tree-leveln  tree-leveln
                                     :last-list=value-p  last-list=value-p
                                     ;; :tree-num-list tree-num-list
                                     )
             ;;here22
;;*tree-dimnodes-list *tree-dimrootn-list *tree-flat-dimrootn-list 
                         ;;            *tree-dimroot-leveln-list *totaln-dimnodes  *tree-dimroots)
             ;;add current level info OLD
#|             (setf subtree-parent-node (list rootnlist rootn sublistkey subtree-nodes)
                   tree-nodes (append tree-nodes  (list subtree-parent-node))
                   rootn-list (append rootn-list (list rootn-list1))
                   flat-rootn-list (append flat-rootn-list flat-rootn-list1)
                   ;;flat-rootnlist-list (append flat-rootnlist-list flat-rootnlist-list1)
                   root-leveln-list (append root-leveln-list (list root-leveln-list1)))
             (setf totaln (+ totaln return-n)) |#
          ;;(subtree  dimrootns flat-dimrootns dimroot-leveln-list  totaln-dimnodes  dimroots)
             ;;APPEND NODELIST 
             (when nodelist
               (setf nodelist (append nodelist (list subtree))
                     subtree-parent-dimnode (list dimrootns dim sublistkey subtree);;dimliststr??
                   tree-nodes (append tree-nodes  (list subtree-parent-node))
                   rootn-list (append rootn-list (list rootn-list1))
                   flat-rootn-list (append flat-rootn-list flat-rootn-list1)
                   ;;flat-rootnlist-list (append flat-rootnlist-list flat-rootnlist-list1)
                   root-leveln-list (append root-leveln-list (list root-leveln-list1))
                 ;;end revised

                     flat-dims-list (append flat-dims-list (list flat-dims-list1))
                     tree-leveln-list (append tree-leveln-list (list tree-leveln-list1))
                    totaln (+ totaln totaln1)))
             (afout 'out (format nil "END RECURSE: item= ~A~% level-nodelists= ~A return-tree= ~A~%  subtree= ~A~%  nodelist= ~A~% " item level-nodelists return-tree subtree nodelist))
             ;;(BREAK "END RECURSE")
             ;;end mvb, sublist-recurse clause
             ))
          ;;first item past dim must be a key or end of list
          ((equal item sublistkey)
           (setf next-sublist-p T
                 previous-item=key-p T
                 nodelist (append nodelist (list item)))
           )
          ((member item all-keys :test 'equal)
           (setf previous-item=key-p T
                 nodelist (append nodelist (list item)))
           ;;end member key
           )
          (previous-item=key-p
           (setf previous-item=key-p NIL)
           (setf nodelist (append nodelist (list item)))
           )
          ;;IF NOT A KEY OR KEYVALUE (filtered out above), MUST BE NEW DIM
          ((or item last-level-item-p)        
           ;;CLOSE PREVIOUS NODELIST AND APPEND LEVEL-NODELISTS
           (when nodelist
             (setf level-nodelists (append level-nodelists (list nodelist)))
             (afout 'out (format nil "1-APPENDED LEVEL-NODELISTS= ~A ITEM= ~a" level-nodelists item))
             )         
           ;;START NEW NODELIST, SINCE ITEM MUST BE A DIM (if end of list or no)
           (cond
            (root-level-dimlist
             (setf dim item 
                   dimsymstr (format nil "~A~A~A" root-level-dimsymstr
                                     root-separator item)
                   dimlist (append root-level-dimlist (list  item)))
             (setf parent-dimlist dimlist
                   parent-dimsymstr (format nil "~A~A~A" root-level-dimsymstr 
                                            root-separator item))
             )
            (t (setf dim item
                     dimsymstr (format nil "~A" item)
                     dimlist (list  item)
                     parent-dimlist dimlist
                     parent-dimsymstr (format nil "~A" item)
                     )))
           ;;NEW NODELIST           
           (setf nodelist (list dimlist dimsymstr))
           ;;end T cond
           ))
         (afout 'out (format nil "END LOOP: item= ~A nodelist= ~A~% dimlist= ~A~%dimsymstr= ~A dim=~A~% level-nodelists= ~A "item nodelist dimlist dimsymstr dim level-nodelists))
         ;;end let, loop, when listp clause
         ))
      ;;APPEND RETURN-TREE WITH LEVEL-NODELISTS
      ;;UPDATE PARENT DIMLISTS
      (when  nodelist        
        (setf level-nodelists (append level-nodelists (list nodelist))))            
      (setf return-tree level-nodelists)
      ;;end when listp
      )
    (setf tree-leveln-list (append tree-leveln-list (list tree-leveln)))
#|  *tree-dimnodes-list *tree-dimrootn-list *tree-flat-dimrootn-list 
                                         *tree-dimroot-leveln-list *totaln-dimnodes  *tree-dimroots)|#
    (values  return-tree  flat-dims-list tree-leveln-list totaln bottom-dimlist)
 ;;to set frame values: *tree-rootn-list *tree-flat-rootn-list *tree-dimroot-leveln-list *totaln-nodes  *tree-roots-list)
    ;;end let, make-tree-from-dimlists
    ))
;;TEST
;; SSSS TEST ON REAL CS/ART SYM TREES
;;  (setf *test-artdims-tree1 '(cs :s (hs :s (1 :s (1 2)  2 :s (1  2  3)   3)  ms :s (ms1 :s (1 2)))))
;; (make-tree-from-dimlists *test-artdims-tree1)
;; WORKS=
#| (setf csart-tree-dimsXX '(((CS)   "CS"  :S
  (((CS HS)    "CS.HS"    :S
    (((CS HS 1)      "CS.HS.1"      :S
      (((CS HS 1 1) "CS.HS.1.1") ((CS HS 1 2) "CS.HS.1.2")))
     ((CS HS 2)      "CS.HS.2"      :S
      (((CS HS 2 1) "CS.HS.2.1")
       ((CS HS 2 2) "CS.HS.2.2")
       ((CS HS 2 3) "CS.HS.2.3")))
     ((CS HS 3) "CS.HS.3")))
   ((CS MS)    "CS.MS"    :S
    (((CS MS MS1)      "CS.MS.MS1"      :S
      (((CS MS MS1 1) "CS.MS.MS1.1") ((CS MS MS1 2) "CS.MS.MS1.2")))))))))) |#

;;MAKE-TREE
;; (make-treeview-frame CSART-TREE-DIMSXX)
#|
;;FOLLOWING MANUALLY SET FOR TESTING MAKE-TREE-VIEWER-FRAME  REMOVED :S
 (setf *tree-root-dimslist '((CS)))
 (setf *dim-tree-list
   '(((CS)   "CS"  :S
  (((CS HS)    "CS.HS"    :S
    (((CS HS 1)      "CS.HS.1"      :S
      (((CS HS 1 1) "CS.HS.1.1") ((CS HS 1 2) "CS.HS.1.2")))
     ((CS HS 2)      "CS.HS.2"      :S
      (((CS HS 2 1) "CS.HS.2.1")
       ((CS HS 2 2) "CS.HS.2.2")
       ((CS HS 2 3) "CS.HS.2.3")))
     ((CS HS 3) "CS.HS.3")))
   ((CS MS)    "CS.MS"    :S
    (((CS MS MS1)      "CS.MS.MS1"      :S
      (((CS MS MS1 1) "CS.MS.MS1.1") ((CS MS MS1 2) "CS.MS.MS1.2")))))))))

       *tree-rootn-list   '("CS"  ("CS.HS"  ("CS.HS.1"  ("CS.HS.1.1"  "CS.HS.2")  "CS.HS.2" ("CS.HS.2.1" "CS.HS.2.2" "CS.HS.2.3")   "CS.HS.3")  "CS.MS"  ("CS.MS.MS1"          ("CS.MS.MS1.1"  "CS.MS.MS1.2"))))
       *tree-flat-rootn-list '("CS"  "CS.HS"  "CS.HS.1"  "CS.HS.1.1"  "CS.HS.2"  "CS.HS.2" "CS.HS.2.1" "CS.HS.2.2" "CS.HS.2.3"   "CS.HS.3"  "CS.MS"  "CS.MS.MS1"          "CS.MS.MS1.1"  "CS.MS.MS1.2")
       *tree-dimroot-leveln-list '(cs :s (hs :s (1 :s (1 2)  2 :s (1  2  3)   3)  ms :s (ms1 :s (1 2))))
       *totaln-nodes 14
       *tree-roots-list '(CS))  ;;tree-viewer auto changes this to (1)
 |#

#| (setf *tree-dimroots '((CS)))
 (setf *dim-tree-list
  '(((CS HS)    "CS.HS"    :S
    (((CS HS 1)      "CS.HS.1"      :S
      (((CS HS 1 1) "CS.HS.1.1") ((CS HS 1 2) "CS.HS.1.2")))
     ((CS HS 2)      "CS.HS.2"      :S
      (((CS HS 2 1) "CS.HS.2.1")
       ((CS HS 2 2) "CS.HS.2.2")
       ((CS HS 2 3) "CS.HS.2.3")))
     ((CS HS 3) "CS.HS.3")))
   ((CS MS)    "CS.MS"    :S
    (((CS MS MS1)      "CS.MS.MS1"      :S
      (((CS MS MS1 1) "CS.MS.MS1.1") ((CS MS MS1 2) "CS.MS.MS1.2")))))))|#


;; OLD TEST (make-treeview-frame *dim-tree-list)
;; RESULTS= INACURATE & OVERLY COMPLEX TREE with extra nodes from :S, several extra "CS" nodes, etc. NOT EVEN CLOSE. ALL CS DIMS WERE INCLUDED AS VALUES :V.
;; THE INTERFACE CHANGED THE INPUT LIST (ABOVE) TO *dim-tree-list
;;  (((1) "1" :SL (((1 1) "1.1" :SL (((1 1 1) "1.1.1" :V= CS))) ((1 2) "1.2" :V= "CS") ((1 3) "1.3" :V= :S) ((1 4) "1.4" :SL (((1 4 1) "1.4.1" :SL (((1 4 1 1) "1.4.1.1" :SL (((1 4 1 1 1) "1.4.1.1.1" :V= CS) ((1 4 1 1 2) "1.4.1.1.2" :V= HS))) ((1 4 1 2) "1.4.1.2" :V= "CS.HS") ((1 4 1 3) "1.4.1.3" :V= :S) ((1 4 1 4) "1.4.1.4" :SL (((1 4 1 4 1) "1.4.1.4.1" :SL (((1 4 1 4 1 1) "1.4.1.4.1.1" :SL (((1 4 1 4 1 1 1) "1.4.1.4.1.1.1" :V= CS) ((1 4 1 4 1 1 2) "1.4.1.4.1.1.2" :V= HS) ((1 4 1 4 1 1 3) "1.4.1.4.1.1.3" :V= 1))) ((1 4 1 4 1 2) "1.4.1.4.1.2" :V= "CS.HS.1") ((1 4 1 4 1 3) "1.4.1.4.1.3" :V= :S) ((1 4 1 4 1 4) "1.4.1.4.1.4" :SL (((1 4 1 4 1 4 1) "1.4.1.4.1.4.1" :SL (((1 4 1 4 1 4 1 1) "1.4.1.4.1.4.1.1" :SL (((1 4 1 4 1 4 1 1 1) "1.4.1.4.1.4.1.1.1" :V= CS).)   ETC  ETC  ETC  

       


;;DIM-TREEVIEW-CHILDREN-FUNCTION
;;2019
;;ddd
(defun dim-treeview-children-function (root)
  "U-trees-art-dims - same as U-trees treeview-children-function? RETURNS *child-dimlists. MUST SET *DIM-TREE-LIST TO THE TREE LIST."
  (when root  ;;was 100,  limits node number (larger N means more depth levels).
    (unless (listp root)
      (setf root (list root)))
            
         ;;ORIG--LIKE U-TREES
         (multiple-value-setq (*tree-dimroot-childlists *CHILD-DIMLISTS 
                                                        *child-root-value *tree-dimroot-sublists)  
             (get-dim-node-childlists root *dim-tree-list))  

         ;;*omit-sublists-in-node-info (default = T)
        (when *omit-sublists-in-node-info *omit-sublists-in-node-info
          (setf *tree-dimroot-childlists-w-sublists *tree-dimroot-childlists
                *tree-dimroot-childlists 
                (nth-value 1 (set-singlekey-value-in-nested-lists *new-dim-sublist-value
                                       :S *tree-dimroot-childlists))))
        ;;(break "in callback *tree-dimroot-sublists")
        ;;HERE111
        (afout 'out (format nil "AFTER mvs for root= ~A~%*tree-dimroot-childlists= ~A~%*CHILD-DIMLISTS= ~A~%*tree-dimroot-childlists-w-sublists= ~A" root *tree-dimroot-childlists *child-dimlists *tree-dimroot-childlists-w-sublists))
         ;;(values *tree-dimroot-childlists *child-dimlists *tree-dimroot-childlists-w-sublists)
         *child-dimlists
       ;;end let,when,dim-treeview-children-function
       ))
;;TEST
;;for new-trees
;;;; (setf *tree-dimroots  '(($CS)))
;; (setf *dim-tree-list *CS-CAT-DB-TREE)
;; (dim-treeview-children-function '($CS.$EXC.$WV))

;; (setf *tree-dimroots  '((CS)))
;; (setf  *dim-tree-list '(((CS) "CS"  :S (((CS HS) "CS.HS"  :S (((CS HS 1) "CS.HS.1"  :S (((CS HS 1 1) "CS.HS.1.1") ((CS HS 1 2) "CS.HS.1.2"))) ((CS HS 2) "CS.HS.2" :S (((CS HS 2 1) "CS.HS.2.1") ((CS HS 2 2) "CS.HS.2.2") ((CS HS 2 3) "CS.HS.2.3"))) ((CS HS 3) "CS.HS.3"))) ((CS MS) "CS.MS" :S (((CS MS MS1) "CS.MS.MS1" :S (((CS MS MS1 1) "CS.MS.MS1.1") ((CS MS MS1 2) "CS.MS.MS1.2")))))))))
;;
;; (dim-treeview-children-function '(cs hs))
;; works= ((CS HS 1) (CS HS 2) (CS HS 3))
;; (dim-treeview-children-function '(cs hs 2))
;; works= ((CS HS 2 1) (CS HS 2 2) (CS HS 2 3))





;;GET-DIM-NODE-CHILDLISTS
;; CAN USE U-trees get-node-childlists instead=
;;ddd
(defun get-dim-node-childlists (target-item tree-node-list
                                                  &key (target-leveln 1) rest-keys
                                         (valkey :V)(sublistkey :S) (tree-type 'csym))
  "U-trees  RETURNS: (values return-parent child-rootnlists root-value child-sublists)  Set parent-rootlist= 0 or NIL to find base roots.   TARGET-ROOTNLIST can be a rootn sym or dimlist  REST-KEYS = list of keys. Finds keys w/values."
  (let*
      ((n-levels (list-length target-item))
       (target-rootnsym)
       (target-rootnlist)  
       (speclist (list (list target-item 0 0)))
       (return-parent) ;; (get-set-append-delete-keyvalue-in-nested-list :get speclist                                                                    tree-node-list :return-list-p T))
       (root-value) ;; (get-key-value valkey return-parent))
       (child-sublists) ;; (get-key-value sublistkey return-parent))
       (child-rootnlists) ;;  (get-nth-in-all-lists 0  child-sublists))
       (csym)
       (csymstr)
       (csymvals)
       (sublist-csyms)
       (rest-keys)
       )
    ;;TREE-TYPE
  (cond
   ((equal tree-type 'CSYM)
    (cond
     ;;target-item is a CSYM OR CSYMVALS
     ((and  (boundp target-item)(symbolp target-item))
      (setf csym target-item
            csymvals (eval target-rootnsym csym))
            csymstr (car csymvals))
     ;;target-item is csymvals list
     ((listp target-item) 
      (setf csymvals target-item
            csymstr (car csymvals)
            csym (my-make-cs-symbol csymstr))
      ;;end listp
      )
     ;;SET OTHER VALUES
     (setf sublist-csyms (get-key-value sublistkey csymvals)   
            child-rootnsyms (get-nth-in-all-lists 0  sublist-csyms)
            root-value (get-key-value valkey csymvals)
            rest-keys (nth-value 3 
                                 (get-multi-keyvalues-in-nested-lists rest-keys csymvals
                                                           :add-flat-keylists-p T)))
     ;;TRANSLATE TO RETURN TERMS
     (setf  return-parent csym
            child-rootnlists child-rootnsyms    ;;NOTE: child-rootnlists are child-rootnSYMS
            child-sublists sublist-csyms )
  #|     OLD return-parent (get-set-append-delete-keyvalue-in-nested-list :get speclist
                                                       tree-node-list :return-list-p T))
        (root-value (get-key-value valkey return-parent))
        (child-sublists (get-key-value sublistkey return-parent))
        (child-rootnlists  (get-nth-in-all-lists 0  child-sublists))|#
       )
     ;;end tree-type 'csym
     )
      ;; can be ROOTSYM OR ROOTLIST  
#|     ((tree-type 'ROOT)  
      (cond
     ((and target-item (boundp target-item)(symbolp target-item))
      (setf target-rootnsym target-item))
     ;;target-item is csymvals list
     ((listp target-item) 
      (make-list-symbol target-item)
       (setf target-rootnlist (cond ((listp target-item) target-item)
                               ((symbolp target-item) 
                                 (find-artsym-dims target-item))))
       (setf target-rootnlist (cond ((listp target-item) target-item)
                               ((symbolp target-item) 
                                (find-artsym-dims target-item))))

      (setf n-levels (list-length target-rootnlist)
        speclist (list (list target-item 0 0)))
       return-parent (get-set-append-delete-keyvalue-in-nested-list :get speclist
                                                       tree-node-list :return-list-p T))
        (root-value (get-key-value valkey return-parent))
        (child-sublists (get-key-value sublistkey return-parent))
        (child-rootnlists  (get-nth-in-all-lists 0  child-sublists))
      )|#
#|   ((equal tree-type 'SPECLIST)
    (when (equal target-item 0)
      (setf rootnlist NIL))
    (unless (listp target-item)
      (setf target-item (list target-rootnlist)))
    (setf n-levels (list-length target-item)
          speclist (list (list target-item 0 0))
          return-parent (get-set-append-delete-keyvalue-in-nested-list :get speclist
                                                                       tree-node-list :return-list-p T)
          root-value (get-key-value valkey return-parent)
          child-sublists (get-key-value sublistkey return-parent)
          child-rootnlists  (get-nth-in-all-lists 0  child-sublists))

    ;;FINISH
    )|#
    (t nil))
          ;;;SSSSSS START HERE FINISH
#|    (when (null target-item)
      (setf parent-leveln 0))|#
     ;;(break "get-dim-node-childlists")
     (values return-parent child-rootnlists root-value child-sublists rest-keys)
      ;;end let, get-dim-node-childlists
      ))
;;TEST 
;; (get-dim-node-childlists  '(CS HS 1) *dim-tree-list)
;; works=
;;return-parent= ((CS HS 1) "CS.HS.1" :V (QUOTE VALUE) :S (((CS HS 1 1) "CS.HS.1.1") ((CS HS 1 2) "CS.HS.1.2")))
;;CHILD-ROOTNLISTS= ((CS HS 1 1) (CS HS 1 2))
;;root-value= (QUOTE VALUE)
;;child-sublists= (((CS HS 1 1) "CS.HS.1.1") ((CS HS 1 2) "CS.HS.1.2"))
;; (get-dim-node-childlists  '(CS HS)  *dim-tree-list)
;; works= 
;;return-parent= ((CS HS) "CS.HS" :V 99 :S (((CS HS 1) "CS.HS.1" :V (QUOTE VALUE) :S (((CS HS 1 1) "CS.HS.1.1") ((CS HS 1 2) "CS.HS.1.2"))) ((CS HS 2) "CS.HS.2" :S (((CS HS 2 1) "CS.HS.2.1") ((CS HS 2 2) "CS.HS.2.2") ((CS HS 2 3) "CS.HS.2.3"))) ((CS HS 3) "CS.HS.3")))
;;children= (((CS HS 1) "CS.HS.1" :V (QUOTE VALUE) :S (((CS HS 1 1) "CS.HS.1.1") ((CS HS 1 2) "CS.HS.1.2"))) ((CS HS 2) "CS.HS.2" :S (((CS HS 2 1) "CS.HS.2.1") ((CS HS 2 2) "CS.HS.2.2") ((CS HS 2 3) "CS.HS.2.3"))) ((CS HS 3) "CS.HS.3"))
;;flat-children= ((((CS HS 1 1) "CS.HS.1.1") ((CS HS 1 2) "CS.HS.1.2") NIL NIL) (((CS HS 2 1) "CS.HS.2.1") ((CS HS 2 2) "CS.HS.2.2") ((CS HS 2 3) "CS.HS.2.3") NIL NIL NIL) NIL)


#|ORIGINAL VERSION FOR CS
(defun get-dim-node-childlists (target-rootnlist tree-node-list &key (target-leveln 1)
                                         (valkey :V)(sublistkey :S))
  "U-trees  RETURNS: (values return-parent child-rootnlists root-value child-sublists)  Set parent-rootlist= 0 or NIL to find base roots.  "
  (when (equal target-rootnlist 0)
    (setf rootnlist NIL))
  (unless (listp target-rootnlist)
    (setf target-rootnlist (list target-rootnlist)))
  (let*
      ((n-levels (list-length target-rootnlist))
        (speclist (list (list target-rootnlist 0 0)))
       (return-parent (get-set-append-delete-keyvalue-in-nested-list :get speclist
                                                       tree-node-list :return-list-p T))
        (root-value (get-key-value valkey return-parent))
        (child-sublists (get-key-value sublistkey return-parent))
        (child-rootnlists  (get-nth-in-all-lists 0  child-sublists))
       )
    (when (null target-rootnlist)
      (setf parent-leveln 0))
     ;;(break "get-dim-node-childlists")
     (values return-parent child-rootnlists root-value child-sublists)
      ;;end let, get-dim-node-childlists
      ))|#


;;USING get-node-childlists
;; (get-node-childlists '((CS HS 2)) *dim-tree-list)
;; results= NOT WORK = NIL NIL NIL NIL
;; NON-CS
;; (setf *testcl33 '(((1) "1" :VA A) ((2) "2" :SL (((2 1) "2.1" :VA B) ((2 2) "2.2" :VA C) ((2 3) "2.3" :SL (((2 3 1) "2.3.1" :VA D) ((2 3 2) "2.3.2" :VA E) ((2 3 3) "2.3.3" :SL (((2 3 3 1) "2.3.3.1" :VA F) ((2 3 3 2) "2.3.3.2" :VA G) ((2 3 3 3) "2.3.3.3" :SL (((2 3 3 3 1) "2.3.3.3.1" :VA H) ((2 3 3 3 2) "2.3.3.3.2" :VA I) ((2 3 3 3 3) "2.3.3.3.3" :VA J))))) ((2 3 4) "2.3.4" :SL (((2 3 4 1) "2.3.4.1" :VA K) ((2 3 4 2) "2.3.4.2" :VA L))) ((2 3 5) "2.3.5" :VA M) ((2 3 6) "2.3.6" :SL (((2 3 6 1) "2.3.6.1" :VA N) ((2 3 6 2) "2.3.6.2" :SL (((2 3 6 2 1) "2.3.6.2.1" :VA O) ((2 3 6 2 2) "2.3.6.2.2" :SL (((2 3 6 2 2 1) "2.3.6.2.2.1" :VA P) ((2 3 6 2 2 2) "2.3.6.2.2.2" :VA Q) ((2 3 6 2 2 3) "2.3.6.2.2.3" :SL (((2 3 6 2 2 3 1) "2.3.6.2.2.3.1" :VA R) ((2 3 6 2 2 3 2) "2.3.6.2.2.3.2" :SL (((2 3 6 2 2 3 2 1) "2.3.6.2.2.3.2.1" :VA S))))) ((2 3 6 2 2 4) "2.3.6.2.2.4" :VA T))) ((2 3 6 2 3) "2.3.6.2.3" :VA U) ((2 3 6 2 4) "2.3.6.2.4" :VA V))) ((2 3 6 3) "2.3.6.3" :VA W))) ((2 3 7) "2.3.7" :VA X) ((2 3 8) "2.3.8" :VA Y))) ((2 4) "2.4" :VA Z))) ((3) "3" :VA END))  )
;; for end in value
;; (get-node-childlists  '(2 3 5)  *testcl33 :sublistkey :SL :valkey :VA)
;; works = ((2 3 5) "2.3.5" :VA M) NIL  M   NIL
;; for end in sublists
;; (get-node-childlists  '(2 3 4)  *testcl33 :sublistkey :SL :valkey :VA)
;; works= ((2 3 4) "2.3.4" :SL (((2 3 4 1) "2.3.4.1" :VA K) ((2 3 4 2) "2.3.4.2" :VA L))) 
;;child-dimlists= ((2 3 4 1) (2 3 4 2))
;;   rootvalue= NIL sublists= (((2 3 4 1) "2.3.4.1" :VA K) ((2 3 4 2) "2.3.4.2" :VA L))
;; (get-node-childlists  '(2 3 1) *dim-tree-list)



;;GET-DIMLIST-CHILDIMS     was GET-DIMLIST-SUBLISTS
;;
;;ddd
(defun get-dimlist-childims (parent-dimlist &key (sublistkey :S))
  "U-trees-art-dims RETURNS: (values  child-dimlists children )"
  (let
      ((child-dimlists)
       (children)
       )
    (cond
     ((listp parent-dimlist)
      (setf children (get-key-value sublistkey parent-dimlist))
      ;;(break)
      (loop
       for child in children
       do
       (let
           ((dimlist)
            )
         (when (listp child)
           (setf dimlist (car  child)
                 child-dimlists (append child-dimlists (list dimlist))))
         ;;end let,loop
         ))
      )
     (t nil))
     (values  children child-dimlists  )    ;;end let,get-dimlist-sublists
     ;;end let, get-dimlist-childims
    ))
 ;;TEST
;; (get-dimlist-childims    '((2 3 4) "2.3.4" :SL (((2 3 4 1) "2.3.4.1" :VA K) ((2 3 4 2) "2.3.4.2" :VA L))))        =  ((2 3 4 1) (2 3 4 2))
;;  
;; (get-dimlist-childims   '((CS HS 2)      "CS.HS.2"      :S        (((CS HS 2 1) "CS.HS.2.1")        ((CS HS 2 2) "CS.HS.2.2")       ((CS HS 2 3) "CS.HS.2.3")))  :SUBLISTKEY :S )
;; works= ((CS HS 2 1) (CS HS 2 2) (CS HS 2 3))            (((CS HS 2 1) "CS.HS.2.1") ((CS HS 2 2) "CS.HS.2.2") ((CS HS 2 3) "CS.HS.2.3"))     
;; (get-dimlist-childims



;;SIMPLE-GET-NESTED-CHILDLISTS
;;2019
;;ddd
(defun simple-get-nested-childlists (parents  &key (n-dims 3) (sublistkey :s) (totaln 0)
                                           (return-sublists-in-children-p T))
  "U-trees-art-dims For use making dimlist trees  RETURNS (values  new-parents dimlists flat-children flat-dimlists totaln)   INPUT:  "
     (let*
         ((new-parents)
          (childlists)
          (dimlists)
          (flat-children)
          (flat-dimlists)
          (totaln 0)
          (n-parents (list-length parents))          
          )  
    (loop
     for parent in parents
     for n from 1 to n-parents 
     do
     (when (listp parent)
       (let*
           ((parent-childlists)
            (parent-dimlists)
            (parent-flat-children)
            (parent-flat-dimlists)
            (parent-totaln 0)
            (len-parent (list-length parent))
            (new-parent)
            (next-is-sublist-p)   
            (child-totaln 0)
            )
         (loop
          for item in parent
          for n from 1 to len-parent
          do
          (let*
              ((dimlist) 
               )
            ;;NOTE: NOT necessary to loop through parent and create new-parent
            ;;however, gives opportunity to modify in future--changining or adding parts.
            (cond
             ;;if sublist key
             ((equal item sublistkey)
              (setf next-is-sublist-p T)
             ;;(break "1")
              (setf new-parent (append new-parent (list item))))
             ;;if sublist
             (next-is-sublist-p
              (setf next-is-sublist-p nil)
              ;;add sublist to new-parent 
              (when (and parent return-sublists-in-children-p)
                (setf new-parent (append new-parent (list item))))
              ;;recurse on children
              (multiple-value-bind (chlldlists1 dimlists1 flat-return-children1 
                                                flat-dimlists1 totaln1)
                  (simple-get-childlists item :totaln totaln)
                (when chlldlists1
                  (setf parent-childlists (append parent-childlists (list chlldlists1))))
                (when dimlists1
                        parent-dimlists (append parent-dimlists (list dimlists1)))
                (when flat-dimlists1
                        parent-flat-dimlists (append parent-flat-dimlists flat-dimlists1))
                (when totaln1
                  (setf child-totaln (+ child-totaln totaln1)))
                (cond
                 ((and item flat-return-children1)
                  (setf parent-flat-children (append parent-flat-children item flat-return-children1)))
                 (item (setf parent-flat-children (append parent-flat-children item )))
                 (flat-return-children1
                  (setf parent-flat-children (append parent-flat-children flat-return-children1 ))))
                ;;(break "after mvb")
                ;;end mvb,recurse
                ))
             ;;for dimlist
             ((and (= n 1)(listp item))
              (setf new-parent  (list item)
                    child-totaln (+ child-totaln 1)
                    dimlist item
                    parent-dimlists (append parent-dimlists (list dimlist))
                    parent-flat-dimlists (append parent-flat-dimlists (list dimlist)))
              ;;(break "dimlist")
              )
             ;;otherwise 
             (t  (setf new-parent (append new-parent (list item)))))
            ;;end let,loop, 
            ))
           (setf new-parents (append new-parents (list new-parent))
                 dimlists (append dimlists (list parent-dimlists))
                 flat-children (append flat-children  (list parent-flat-children))
                 flat-dimlists (append flat-dimlists parent-flat-dimlists)
                 totaln (+ totaln child-totaln))          
       ;;end let, loop,when listp
       )))
    (values  new-parents dimlists flat-children flat-dimlists totaln) ;;redundant? flat-children
    ;;end let, simple-get-nested-childlists
    ))
;;TEST
;; (setf *dim-tree-list '(((CS HS) "CS.HS" :S (((CS HS 1) "CS.HS.1" :S (((CS HS 1 1) "CS.HS.1.1") ((CS HS 1 2) "CS.HS.1.2"))) ((CS HS 2) "CS.HS.2" :S (((CS HS 2 1) "CS.HS.2.1") ((CS HS 2 2) "CS.HS.2.2") ((CS HS 2 3) "CS.HS.2.3"))) ((CS HS 3) "CS.HS.3"))) ((CS MS) "CS.MS" :S (((CS MS MS1) "CS.MS.MS1" :S (((CS MS MS1 1) "CS.MS.MS1.1") ((CS MS MS1 2) "CS.MS.MS1.2")))))))
;;
;; (simple-get-nested-childlists *dim-tree-list)
;;works?=  new-parents dimlists flat-children flat-dimlists totaln
;;new-parents=  (((CS HS) "CS.HS" :S (((CS HS 1) "CS.HS.1" :S (((CS HS 1 1) "CS.HS.1.1") ((CS HS 1 2) "CS.HS.1.2"))) ((CS HS 2) "CS.HS.2" :S (((CS HS 2 1) "CS.HS.2.1") ((CS HS 2 2) "CS.HS.2.2") ((CS HS 2 3) "CS.HS.2.3"))) ((CS HS 3) "CS.HS.3"))) ((CS MS) "CS.MS" :S (((CS MS MS1) "CS.MS.MS1" :S (((CS MS MS1 1) "CS.MS.MS1.1") ((CS MS MS1 2) "CS.MS.MS1.2"))))))
;;dimlists= (((CS HS) (((CS HS 1) (((CS HS 1 1)) ((CS HS 1 2)))) ((CS HS 2) (((CS HS 2 1)) ((CS HS 2 2)) ((CS HS 2 3)))) ((CS HS 3)))) ((CS MS) (((CS MS MS1) (((CS MS MS1 1)) ((CS MS MS1 2)))))))
;;flat-children= ((((CS HS 1) "CS.HS.1" :S (((CS HS 1 1) "CS.HS.1.1") ((CS HS 1 2) "CS.HS.1.2")))      ((CS HS 2) "CS.HS.2" :S (((CS HS 2 1) "CS.HS.2.1") ((CS HS 2 2) "CS.HS.2.2") ((CS HS 2 3) "CS.HS.2.3")))     ((CS HS 3) "CS.HS.3")    (((CS HS 1 1) "CS.HS.1.1") ((CS HS 1 2) "CS.HS.1.2") NIL NIL)      (((CS HS 2 1) "CS.HS.2.1") ((CS HS 2 2) "CS.HS.2.2") ((CS HS 2 3) "CS.HS.2.3") NIL NIL NIL)   NIL)      (((CS MS MS1) "CS.MS.MS1" :S (((CS MS MS1 1) "CS.MS.MS1.1") ((CS MS MS1 2) "CS.MS.MS1.2"))) (((CS MS MS1 1) "CS.MS.MS1.1") ((CS MS MS1 2) "CS.MS.MS1.2") NIL NIL)))
;;flat-dimlists= ((CS HS) (CS HS 1) (CS HS 1 1) (CS HS 1 2) (CS HS 2) (CS HS 2 1) (CS HS 2 2) (CS HS 2 3) (CS HS 3) (CS MS) (CS MS MS1) (CS MS MS1 1) (CS MS MS1 2))
;;totaln= 13

(defun print-csym-info (csym)
  "CS-new-trees-viewer. Used in Tree-View Interface"
  ;;(when (equal csym '$PC) (break "in print-csym-info"))   
    (multiple-value-bind (all-info-keylist key-val-pairs keys values node-info-string
                                           all-info-string csym csval)
        (get-csym-info csym)
      node-info-string
      ;;end mvb, print-csym-info
      ))
;; (get-csym-info '$PC)

(defun my-print-function (rootdims)
  "works"
  ;;(break)
  (let
      ((root-list)
       )   
    (unless (listp rootdims)
      (setf rootnlist (list rootdims)))
    ;;SSSSS HERE4
    (multiple-value-setq (*tree-dimroot-childlists *child-dimslists  
                                                   *child-root-value *tree-dimroot-sublists   )  
        (get-dim-node-childlists rootdims *dim-tree-list))
    ;;(break "my-print-function: *tree-dimroot-childlists")
  ;; (get-node-childlists '(2) *tree-nodes-list)
    
    (setf root-list *child-rootnlists) ;;was *tree-dimroot-childlists)
    (print-node-info root-list :omit-root-info-p NIL :valkey :v :sublistkey :s)
    (format nil "~A: ~A" (make-root-string rootdims) (print-node-info root-list))
    ;;was "Node: ~A: Nodelist: ~A" (make-root-string root) root)
    ))
;;TEST
;; (print-node-info *tree-dimroot-childlists :omit-root-info-p T :valkey :v :sublistkey :s)
;; (print-node-info *tree-dimroot-childlists :omit-root-info-p NIL :valkey :v :sublistkey :s)
;; works= (((CS HS 1) "CS.HS.1" :S (((CS HS 1 1) "CS.HS.1.1") ((CS HS 1 2) "CS.HS.1.2"))) ((CS HS 2) "CS.HS.2" :S (((CS HS 2 1) "CS.HS.2.1") ((CS HS 2 2) "CS.HS.2.2") ((CS HS 2 3) "CS.HS.2.3"))) ((CS HS 3) "CS.HS.3"))


;;PRINT-NODE-INFO
;;
;;ddd
#|(defun print-node-info (tree-root-childlists &key (omit-root-info-p T) omit-rootnlist-p
                                             (valkey :V) (sublistkey :S) (csymkey :C) (csymvalkey :CV)
                                             (csymdesckey :CD))
  (let*
      ((sublists-p (member sublistkey tree-root-childlists :test 'equal))
       (value (get-key-value valkey  tree-root-childlists))
       (rootinfo) 
       )
    (cond
     (sublists-p
      (setf rootinfo (butlast tree-root-childlists 1)
            rootinfo (append rootinfo (list  " Select +"))))
     (t (setf rootinfo  tree-root-childlists)))
    (cond
     (omit-root-info-p
      (setf rootinfo (cddr rootinfo))
      )
     (omit-rootnlist-p
      (setf rootinfo (cdr rootinfo))))
    ;;(break "rootinfo")
    rootinfo
    ;;end let, get-node-info
    ))|#
;;TEST
;; (print-node-info '((2 3 4) "2.3.4" :SL (((2 3 4 1) "2.3.4.1" :VA K) ((2 3 4 2) "2.3.4.2" :VA L))) :omit-rootnlist-p NIL :valkey :VA :sublistkey :SL)
;; works= ((2 3 4) "2.3.4"  " Select +")
;

;; (find-keys-and-values-in-list '(:C :CV :CD :V) '((2 3 4) "2.3.4" :C "HAPPY" :V "ARTVAL" :S (((2 3 4 1) "2.3.4.1" ) )) :return-keys-not-found-p T)
;; works= (:C "HAPPY" :V "ARTVAL")    (:C :V)    (:CV :CD)


(defun my-dims-expandp-function (roots)
  "In U-trees"
  (let
      ((expandp T)
       )
   (when (and (listp roots)
              (> (length roots) *treeview-expand-level))
     (setf expandp NIL))
   expandp
  ;;end  let, my-expandp-function
  ))

;;MY-NOT-EXPANDP-FUNCTION
;;
;;ddd
(defun my-NOT-expandp-function (roots)
  "In U-trees"
   NIL
  ;;end  my-expandp-function
  )



;;MY-DIM-PRINT-FUNCTION
;;
;;ddd
(defun my-dim-print-function (rootdims)
  "U-trees-art-dims."
  ;;(break)
  (let
      ((node-print-string "")
       )   
    (unless (listp rootdims)
      (setf rootdims (list rootdims)))

    (multiple-value-bind (node-info-string  all-info-string)
        (get-artsymnode-info rootdims)
     
      (cond
       (*print-all-node-info-p 
        (setf node-print-string all-info-string))
       (t (setf node-print-string node-info-string)))

    ;;SSSSS HERE4
#|    (multiple-value-setq (*tree-dimroot-childlists *child-dimslists  *child-root-value *tree-dimroot-sublists   )  
        (get-dim-node-childlists rootdims *dim-tree-list))
    ;;(break "my-print-function: *tree-dimroot-childlists")
  ;; (get-node-childlists '(2) *tree-nodes-list)
    
    (setf root-list *child-rootnlists) ;;was *tree-dimroot-childlists)
    (print-node-info root-list :omit-root-info-p NIL :valkey :v :sublistkey :s)
    (format nil "~A: ~A" (make-root-string rootdims) (print-node-info root-list))|#
    ;;was "Node: ~A: Nodelist: ~A" (make-root-string root) root)
    ;;(break "node-print-string")
    node-print-string
    ;;end mvb,let, my-dim-print-function
    )))


;;GET-ARTSYMNODE-INFO
;;2019
;;ddd
#|(defun get-csymnode-info (csym  &key csdims (csdimstree *dim-tree-list)
                                     (omit-some-nil-p *expanded-node-list-p) 
                                     (incl-csymlist-p *incl-csymlist-in-treeviewer-p)
                                     (newcskey :C) (csvalkey :V) (sublistkey :S)
                                     (newvalkey :CV)(csvalkey :va)
                                     (newrankey :R) (csrankey :RNK)
                                     rest-keys )
  "U-new-trees-viewer RETURNS (values node-info-string  all-info-string csym csval csnodelist)   INPUT: Can use csym string or sym instead of csdims."
  ;;when csym is actually a csdims list (and csym is last in list)
   (when (listp csym)
      (setf  csdims csym
             csym (my-make-cs-symbol (car (last csdims)))))
   ;;SSSSSS START HERE--USE GET-CSYM-INFO OR IT'S CODE???
   ;; ALSO CHECK AND SEE WHICH FUNCTION PRINTS THE NODE INFO
   
   (multiple-value-bind (all-info-keylist key-val-pairs keys values)
       (get-csym-info  csym)

     (let*
         ((csymlist (eval (my-make-symbol csym)))
          (csname (car csymlist))
          (csphrase (second csymlist))
          (csdims-sym (third csymlist))
          (csdims (find-artsym-dims csdims-sym))
          (csdata  (fourth  csymlist))
          (csdef (fifth  csymlist))
          (sublist (get-key-value sublistkey csymlist))
          (csval (get-key-value csvalkey csymlist))
          (csrank (get-key-value csrankey csymlist))
          (csdesc (second  csymlist))
          (all-info-string "")
          (node-info-string "")
          (rest-key-list)
          )
       (when rest-keys
         (setf rest-key-list (nth-value 3
                                        (get-multi-keyvalues-in-nested-lists rest-keys csymvals
                                                                             :add-flat-keylist-p T))))

       #|((equal tree-type 'CSYM)
    (cond
     ;;target-item is a CSYM OR CSYMVALS
     ((and  (boundp target-item)(symbolp target-item))
      (setf csym target-item
            csymvals (eval target-rootnsym csym))
            csymstr (car csymvals))
     ;;target-item is csymvals list
     ((listp target-item) 
      (setf csymvals target-item
            csymstr (car csymvals)
            csym (my-make-cs-symbol csymstr))
      ;;end listp
      )
     ;;SET OTHER VALUES
     (setf sublist-csyms (get-key-value sublistkey csymvals)   
            child-rootnsyms (get-nth-in-all-lists 0  sublist-csyms)
            root-value (get-key-value valkey csymvals)
            
            )
     ;;TRANSLATE TO RETURN TERMS
     (setf  return-parent csym
            child-rootnlists child-rootnsyms    ;;NOTE: child-rootnlists are child-rootnSYMS
            child-sublists sublist-csyms )
  #|     OLD return-parent (get-set-append-delete-keyvalue-in-nested-list :get speclist
                                                       tree-node-list :return-list-p T))
        (root-value (get-key-value valkey return-parent))
        (child-sublists (get-key-value sublistkey return-parent))
        (child-rootnlists  (get-nth-in-all-lists 0  child-sublists))|#
       )
     ;;end tree-type 'csym
     )|#
       (cond
        (omit-some-nil-p ;;csval, csval, csdesc,csymlist
                         (setf all-info-string (format nil "~A ~S" csymstr csym))
                         (setf node-info-string (format nil "~A ~S" csymstr csym)) 
                         (when csval (setf all-info-string (format nil "~A :~A ~S"all-info-string csvalkey csval)
                                           node-info-string (format nil "~A :~A ~S"node-info-string csvalkey csval))
                           (when csrank
                             (setf all-info-string (format nil "~A :~A ~A"all-info-string rankey csrank)
                                   node-info-string (format nil "~A :~A ~A"node-info-string rankey csrank))))
                         (when csdesc (setf all-info-string (format nil "~A ~S"all-info-string csdesc)
                                            node-info-string (format nil "~A ~S"node-info-string csdesc)))       
                         (when csval (setf all-info-string (format nil "~A :~A ~S"all-info-string csvalkey csval)
                                           node-info-string (format nil "~A :~A ~S"node-info-string csvalvalkey csval)))
                         ;;always include
                         (setf all-info-string (format nil "~A ~A"all-info-string csdims)
                               node-info-string (format nil "~A ~A"node-info-string csdims))
                         (when csval (setf all-info-string (format nil "~A :~A ~S"all-info-string csvalkey csval)
                                           node-info-string (format nil "~A :~A ~S"node-info-string csvalkey csval)))

                         )
        (t
         (setf all-info-string (format nil "~A ~S :~A ~S ~S  ~S :~A ~S" csymstr csym csvalkey csval csdesc  csdims csvalkey csval))
         (setf node-info-string (format nil "~A~S :~A ~S ~S :~A ~S" csymstr csym csvalkey  csval csdesc csvalkey csval))))       
       (when incl-csymlist-p 
         (setf all-info-string (format nil "~A; ~A"all-info-string csymlist)
               node-info-string (format nil "~A;~A"node-info-string csymlist)))
      
       (values node-info-string  all-info-string csym csval csnodelist)
       ;;end let, get-csymnode-info
       ))
|#

;;OLD REVISED
#|(defun get-csymnode-info (csym  &key csdims (csdimstree *dim-tree-list)
                                     (omit-some-nil-p *expanded-node-list-p) 
                                     (incl-csymlist-p *incl-csymlist-in-treeviewer-p)
                                     (newcskey :C) (csvalkey :V) (sublistkey :S)
                                     (newvalkey :CV)(csvalkey :va)
                                     (newrankey :R) (csrankey :RNK)
                                     rest-keys )
  "U-new-trees-viewer RETURNS (values node-info-string  all-info-string csym csval csnodelist)   INPUT: Can use csym string or sym instead of csdims."
  ;;when csym is actually a csdims list (and csym is last in list)
   (when (listp csym)
      (setf  csdims csym
             csym (my-make-cs-symbol (car (last csdims)))))
  (let*
      ((csymlist (eval (my-make-symbol csym)))
       (csname (car csymlist))
       (csphrase (second csymlist))
        (csdims-sym (third csymlist))
        (csdims (find-artsym-dims csdims-sym))
       (csdata  (fourth  csymlist))
       (csdef (fifth  csymlist))
       (sublist (get-key-value sublistkey csymlist))
       (csval (get-key-value csvalkey csymlist))
       (csrank (get-key-value csrankey csymlist))
       (csdesc (second  csymlist))
       (all-info-string "")
       (node-info-string "")
       (rest-key-list)
       )
     (when rest-keys
       (setf rest-key-list (nth-value 3
                                      (get-multi-keyvalues-in-nested-lists rest-keys csymvals
                                                                           :add-flat-keylist-p T))))

     #|((equal tree-type 'CSYM)
    (cond
     ;;target-item is a CSYM OR CSYMVALS
     ((and  (boundp target-item)(symbolp target-item))
      (setf csym target-item
            csymvals (eval target-rootnsym csym))
            csymstr (car csymvals))
     ;;target-item is csymvals list
     ((listp target-item) 
      (setf csymvals target-item
            csymstr (car csymvals)
            csym (my-make-cs-symbol csymstr))
      ;;end listp
      )
     ;;SET OTHER VALUES
     (setf sublist-csyms (get-key-value sublistkey csymvals)   
            child-rootnsyms (get-nth-in-all-lists 0  sublist-csyms)
            root-value (get-key-value valkey csymvals)
            
            )
     ;;TRANSLATE TO RETURN TERMS
     (setf  return-parent csym
            child-rootnlists child-rootnsyms    ;;NOTE: child-rootnlists are child-rootnSYMS
            child-sublists sublist-csyms )
  #|     OLD return-parent (get-set-append-delete-keyvalue-in-nested-list :get speclist
                                                       tree-node-list :return-list-p T))
        (root-value (get-key-value valkey return-parent))
        (child-sublists (get-key-value sublistkey return-parent))
        (child-rootnlists  (get-nth-in-all-lists 0  child-sublists))|#
       )
     ;;end tree-type 'csym
     )|#
     (cond
      (omit-some-nil-p ;;csval, csval, csdesc,csymlist
                       (setf all-info-string (format nil "~A ~S" csymstr csym))
                       (setf node-info-string (format nil "~A ~S" csymstr csym)) 
                       (when csval (setf all-info-string (format nil "~A :~A ~S"all-info-string csvalkey csval)
                                         node-info-string (format nil "~A :~A ~S"node-info-string csvalkey csval))
                         (when csrank
                           (setf all-info-string (format nil "~A :~A ~A"all-info-string rankey csrank)
                                 node-info-string (format nil "~A :~A ~A"node-info-string rankey csrank))))
                       (when csdesc (setf all-info-string (format nil "~A ~S"all-info-string csdesc)
                                          node-info-string (format nil "~A ~S"node-info-string csdesc)))       
                       (when csval (setf all-info-string (format nil "~A :~A ~S"all-info-string csvalkey csval)
                                         node-info-string (format nil "~A :~A ~S"node-info-string csvalvalkey csval)))
                       ;;always include
                       (setf all-info-string (format nil "~A ~A"all-info-string csdims)
                             node-info-string (format nil "~A ~A"node-info-string csdims))
                       (when csval (setf all-info-string (format nil "~A :~A ~S"all-info-string csvalkey csval)
                                         node-info-string (format nil "~A :~A ~S"node-info-string csvalkey csval)))

                       )
      (t
       (setf all-info-string (format nil "~A ~S :~A ~S ~S  ~S :~A ~S" csymstr csym csvalkey csval csdesc  csdims csvalkey csval))
       (setf node-info-string (format nil "~A~S :~A ~S ~S :~A ~S" csymstr csym csvalkey  csval csdesc csvalkey csval))))       
     (when incl-csymlist-p 
       (setf all-info-string (format nil "~A; ~A"all-info-string csymlist)
             node-info-string (format nil "~A;~A"node-info-string csymlist)))
      
     (values node-info-string  all-info-string csym csval csnodelist)
     ;;end let, get-csymnode-info
     ))|# ;;HERE222
;;TEST
;; from info below
;; (get-csymnode-info  '(CS HS 1))
;; works= 
;;node-info-string= "CAREFOROTHERS :CV \"0.917\"; \"CARE FOR OTHERS vs SELFISH\"; CS.HS.1 :V \"ARTVALUE\""
;; [if use ~A instead of ~S get= "CAREFOROTHERS :CV 0.917; CARE FOR OTHERS vs SELFISH" :V ARTVALUE"]
;; all-info-string=  "CS.HS.1 CAREFOROTHERS :va \"0.917\"; \"CARE FOR OTHERS vs SELFISH\";  (CS HS 1) :V \"ARTVALUE\""         
;;csym=  CAREFOROTHERS    csval=     "0.917"        
;;artnodelist=   ((CS HS 1) "CS.HS.1" :C CAREFOROTHERS :V "ARTVALUE" :S (((CS HS 1 1) "CS.HS.1.1") ((CS HS 1 2) "CS.HS.1.2")))  




;;TREEVIEWER-GO-CALLBACK
;;2019
;;ddd
(defun treeviewer-go-callback (data interface)
  "U-trees-art-dims Sets options for dim-treeviewer-interface"
    (with-slots (calling-interface radio-button-panel-1 radio-button-panel-2 
                                   radio-button-panel-3 check-button-panel-1) interface
      ;;note:  (capi:choice-selected-item radio-button-panel-1) => item text output
  (let
      ((radio1-selection (capi:choice-selection radio-button-panel-1))
      (radio2-selection (capi:choice-selected-item radio-button-panel-2))
      (radio3-selection (capi:choice-selected-item radio-button-panel-3))
       )
      ;;FOR radio-button-panel-1
    (cond
     ((= radio1-selection 0)
      (setf  *incl-csymlist-in-treeviewer-p NIL   *expanded-node-list-p NIL))
     ((= radio1-selection 1)
      (setf  *incl-csymlist-in-treeviewer-p NIL  *expanded-node-list-p T))
     ((= radio1-selection 2)
      (setf  *incl-csymlist-in-treeviewer-p T   *expanded-node-list-p T
             *dim-treeviewer-frame-width 1300)))
    ;;(break "*incl-csymlist-in-treeviewer-p")
    (mp:process-poke calling-interface)
    (capi:destroy interface)
    (values  radio1-selection radio2-selection radio3-selection)
    ;;end let, with, let, treeviewer-go-callback
    )))
;;TEST
;; (treeviewer-go-callback


;;ORIGINAL VERSION
#|(defun dim-treeview-children-function (root)
  "U-trees-art-dims - same as U-trees treeview-children-function? RETURNS *child-dimlists"
  (when root  ;;was 100,  limits node number (larger N means more depth levels).
    (unless (listp root)
      (setf root (list root)))
            
         ;;ORIG--LIKE U-TREES
         (multiple-value-setq (*tree-dimroot-childlists *CHILD-DIMLISTS 
                                                        *child-root-value *tree-dimroot-sublists)  
             (get-dim-node-childlists root *dim-tree-list))  

         ;;*omit-sublists-in-node-info (default = T)
        (when *omit-sublists-in-node-info *omit-sublists-in-node-info
          (setf *tree-dimroot-childlists-w-sublists *tree-dimroot-childlists
                *tree-dimroot-childlists 
                (nth-value 1 (set-singlekey-value-in-nested-lists *new-dim-sublist-value
                                       :S *tree-dimroot-childlists))))
        ;;(break "in callback *tree-dimroot-sublists")
        ;;HERE111
        (afout 'out (format nil "AFTER mvs for root= ~A~%*tree-dimroot-childlists= ~A~%*CHILD-DIMLISTS= ~A~%*tree-dimroot-childlists-w-sublists= ~A" root *tree-dimroot-childlists *child-dimlists *tree-dimroot-childlists-w-sublists))
         ;;(values *tree-dimroot-childlists *child-dimlists *tree-dimroot-childlists-w-sublists)
         *child-dimlists
       ;;end let,when,dim-treeview-children-function
       ))|#