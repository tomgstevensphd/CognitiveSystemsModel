;;********************** CS-netview-frames.lisp ***********************



;;NETVIEW-INTERFACE
;;2018-02
;;ddd
(capi:define-interface NetView-Interface ()
  ;;SLOTS
  ((left-margin                                 
    :initarg :left-margin
    :accessor left-margin
    :initform 20
    :documentation "left-margin")
   (top-margin                                 
    :initarg :top-margin
    :accessor top-margin
    :initform 10
    :documentation "top-margin.")
   (xpix                                 
    :initarg :xpix
    :accessor xpix
    :initform nil
    :documentation "xpix")
   (ypix                                 
    :initarg :ypix
    :accessor ypix
    :initform nil
    :documentation "ypix")
   (elp-w                                 
    :initarg :elp-w
    :accessor elp-w
    :initform nil
    :documentation "Width of each node section.")
   (elp-ht                                 
    :initarg :elp-ht
    :accessor elp-ht
    :initform nil
    :documentation "Height of each node section")
   (node1-pts                                 
    :initarg :node1-pts
    :accessor node1-pts
    :initform nil
    :documentation "Store  TEMP node1-pts connecting points x,y coordinates")
   (node2-pts                                 
    :initarg :node2-pts
    :accessor node2-pts
    :initform nil
    :documentation "Store  TEMP node2-pts connecting points x,y coordinates")
   (pathtext
    :initarg :pathtext
    :accessor pathtext
    :initform ""
    :documentation "pathtext")
   (node-message                                 
    :initarg :node-message
    :accessor node-message
    :initform ""
    :documentation "node-message")
   (path-message                                 
    :initarg :path-message
    :accessor path-message
    :initform ""
    :documentation "path-message")
   (path-type
    :initarg :path-type
    :accessor path-type
    :initform :bezier
    :documentation "path-type")
   (win-x                                 
    :initarg :win-x
    :accessor win-x
    :initform 0
    :documentation "win-x")
   (win-y                                 
    :initarg :win-y
    :accessor win-y
    :initform 0
    :documentation "win-y")
   (node-pts-slot                                 
    :initarg :node-pts-slot
    :accessor node-pts-slot
    :initform nil
    :documentation "node-pts-slot")
   (node-width                                 
    :initarg :node-width
    :accessor node-width
    :initform 100
    :documentation "node-width")
   (top-ht                                 
    :initarg :top-ht
    :accessor top-ht
    :initform 20
    :documentation "top-ht")
   (mid-ht                                 
    :initarg :mid-ht
    :accessor mid-ht
    :initform 20
    :documentation "mid-ht")
   (bot-ht                                 
    :initarg :bot-ht
    :accessor bot-ht
    :initform 20
    :documentation "bot-ht")
   (top-str-gap                                 
    :initarg :top-str-gap
    :accessor top-str-gap
    :initform 10
    :documentation "top-str-gap")
   (L-str-gap                                 
    :initarg :L-str-gap
    :accessor L-str-gap
    :initform 10
    :documentation "L-str-gap")
   (grouped-pcs                                 
    :initarg :grouped-pcs
    :accessor grouped-pcs
    :initform NIL
    :documentation "grouped-pcs")
   (pcsym-pairs                                 
    :initarg :pcsym-pairs
    :accessor pcsym-pairs
    :initform NIL
    :documentation "pcsym-pairs")
   ;;END SLOTS
   )
  ;;PANES
  (:PANES
   ;;EDITOR PANES
   (title-pane
    capi:rich-text-pane
    :visible-max-height 30
    :accepts-focus-p NIL
    )
   (editor-pane-2
    capi:rich-text-pane
    :visible-max-height 30
    :accepts-focus-p NIL
    )
   (editor-pane-3
    capi:rich-text-pane
    :visible-max-height 30
    :accepts-focus-p NIL
    )
   (message-pane
    capi:rich-text-pane
    :visible-min-height 40
    :visible-max-height 60
    :accepts-focus-p NIL
    )
   ;;OUTPUT PANE
   (output-pane
    capi:output-pane
    :draw-with-buffer T
    :display-callback 'netviewer-display-callback
   :scroll-height 1400
    :scroll-width 12000
    :scroll-vertical-page-size 600  ;;works almost like :visible-max-height
  :scroll-horizontal-page-size 1200 ;;works almost like :visible-max-width
    :horizontal-scroll T
    :vertical-scroll T
#|    :visible-max-height 600
    :visible-max-width 1350|#
     :coordinate-origin :fixed-graphics 
#|     :pane-can-scroll T
    :scroll-if-not-visible-p T|#
    )
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
    :callback 'go-next-frame-callback
    :callback-type :data-interface
    :data *go-next-frame-callback-data
    ;;was (gp:make-font-description :size *button-font-size  :weight :bold) ;; :slant :italic)
    ;;doesn't work    :character-format *title-pane-char-format
    ;;doesn't work?    :x 20   :y 20
    )
   (push-button2
    capi:push-button
    :text "Push button 2"
    )

   ;;END PANES
   )
  (:LAYOUTS
   (column-layout-1
    capi:column-layout
    '(title-pane editor-pane-2 editor-pane-3 output-pane message-pane
                 push-button-row-layout-1))
   
   (push-button-row-layout-1
    capi:row-layout
    '(go-fr-button push-button2 ))
   ;;END LAYOUTS
   )

  ;;MENUS
  (:menu-bar menu-1)
  (:MENUS
   (menu-1
    "Menu-1"
    ("Item-1"
     "Item-2"
     "Item-3")))
  (:DEFAULT-INITARGS
   :visible-min-height 800
   :visible-min-width *NetView-Interface-window-width
   :internal-border 10
   :background :red
   :layout 'column-layout-1
   :title "Net View Interface"))


