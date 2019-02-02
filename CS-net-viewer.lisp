;;****************** CS-net-viewer.lisp ********************************
;;
;;MY RELATIVE GRAPHIC X, Y PIXEL POSITIONS
;;
;; XPIX =  fixed num of x-axis pixels
;; YPIX =  fixed num of y-axis pixels
;; CELX = L-top xpix of a cell
;; CELY = L-top ypix of a cell
;; CELW = cell width in xpix
;; CELH = cell height in xpix
;; ROW-N = num of cells in a row (accross)
;; COL-N = num of cells in a column (up-down)
;; N-ROWS = num of rows in a FIELD
;; N-COLS = num of columns in a FIELD
;; FIELDS-W = number of FIELDS accross a space (eg window)
;; FIELDS-H = number of FIELDS high in a space (eg window)



;;WINDOW PARAMETERS
(defparameter *NetView-Interface-window-width 1200)
(defparameter *XPIX/X 1 "fixed num of x-axis pixels")
(defparameter *YPIX/Y 1 "fixed num of y-axis pixels")
(defparameter *XPIX  NIL "Used instead of X for x-axis. Fixed num of x-axis pixels")
(defparameter *YPIX NIL "Used instead of Y for y-axis. Fixed num of y-axis pixels")
(defparameter *CELX   0 "L-top xpix of a cell")
(defparameter *CELY   0 "L-top ypix of a cell")
(defparameter *CELW   120 "Window SPACE for cell width in xpix")
(defparameter *CELH    140 "Window SPACE for cell height in xpix")
(defparameter *ROW-N   10 "num of cells in a row (across)")
(defparameter *COL-N   6 "num of cells in a column (up-down)")
(defparameter *N-ROWS  4 "num of rows in a FIELD")
(defparameter *N-COLS   10 "num of columns in a FIELD")
(defparameter *FIELDS-W   1 "number of FIELDS accross a space (eg window)")
(defparameter *FIELDS-H   1 "number of FIELDS high in a space (eg window)")




;;NETVIEW-INTERFACE
;;2018-02
;;ddd
(capi:define-interface NetView-Interface ()
  ;;SLOTS
  ((elp-w                                 
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
    :initform ""
    :documentation "path-type")
   (win-x                                 
    :initarg :win-x
    :accessor win-x
    :initform ""
    :documentation "win-x")
   (win-y                                 
    :initarg :win-y
    :accessor win-y
    :initform ""
    :documentation "win-y")
   (node-pts-slot                                 
    :initarg :node-pts-slot
    :accessor node-pts-slot
    :initform ""
    :documentation "node-pts-slot")
   (node-width                                 
    :initarg :node-width
    :accessor node-width
    :initform ""
    :documentation "node-width")
   (top-ht                                 
    :initarg :top-ht
    :accessor top-ht
    :initform ""
    :documentation "top-ht")
   (mid-ht                                 
    :initarg :mid-ht
    :accessor mid-ht
    :initform ""
    :documentation "mid-ht")
   (bot-ht                                 
    :initarg :bot-ht
    :accessor bot-ht
    :initform ""
    :documentation "bot-ht")
   (top-str-gap                                 
    :initarg :top-str-gap
    :accessor top-str-gap
    :initform ""
    :documentation "top-str-gap")
   (L-str-gap                                 
    :initarg :L-str-gap
    :accessor L-str-gap
    :initform ""
    :documentation "L-str-gap")
   (grouped-pcs                                 
    :initarg :grouped-pcs
    :accessor grouped-pcs
    :initform ""
    :documentation "grouped-pcs")
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
    :visible-min-height 700
    :horizontal-scroll T
    :vertical-scroll T
    :display-callback 'netview-display-callback
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
   :best-height 800
   :best-width *NetView-Interface-window-width
   :internal-border 10
   :background :red
   :layout 'column-layout-1
   :title "Net View Interface"))





;;MAKE-TEST-NETVIEWER
;;
;;ddd
#|(defun make-test-netviewer (node1-x node1-y node2-x node2-y 
                                    &key (win-x 20) (win-y 20) 
                                    (pathtext "PATH TEXT HERE")
                                    draw-pc-node-sym1 draw-pc-node-sym2
                                    (node1pt-type 'mid) (node2pt-type 'mid)
                                    (node1-slot 'node1-pts)(node2-slot 'node2-pts))
  "In CS-net-viewer. Makes a CS-net-view-interface.   "
  (let
      ((inst (make-instance 'NetView-Interface :x win-x :y win-y ))
       (node1-pts)
       (node2-pts)
       (node-message "")
       (path-message "")
       (message "")
       )

    ;;MUST DISPLAY BEFORE CAN DRAW ON IT
    (capi:display inst)

    (with-slots (output-pane title-pane message-pane) inst

      ;;DRAW NODE1
      (cond
       (draw-pc-node-sym1
        (capi:apply-in-pane-process output-pane
                                    'draw-pc-node inst output-pane draw-pc-node-sym1 
                                    node1-x node1-y node1-slot))
;; (draw-pc-node
       (t    
        (capi:apply-in-pane-process output-pane
                                    'draw-cs-node inst output-pane node1-x node1-y node1-slot)))

      ;;DRAW NODE2
      (cond
       (draw-pc-node-sym2
        (capi:apply-in-pane-process output-pane
                                    'draw-pc-node inst output-pane draw-pc-node-sym2
                                    node2-x node2-y node2-slot))
       (t    
        (capi:apply-in-pane-process output-pane
                                    'draw-cs-node inst output-pane node2-x node2-y node2-slot)))

      ;;GET NODE-PTS coordinates
      (setf node1-pts (slot-value inst node1-slot)
            node2-pts (slot-value inst node2-slot))
                
      (multiple-value-bind (list L-toppt1-x   L-toppt1-y   R-toppt1-x R-toppt1-y 
                                 L-midpt1-x L-midpt1-y R-midpt1-x  R-midpt1-y
                                 L-botpt1-x L-botpt1-y R-botpt1-x R-botpt1-y)
          (values-list node1-pts)
        (multiple-value-bind (list L-toppt2-x   L-toppt2-y   R-toppt2-x R-toppt2-y 
                                   L-midpt2-x L-midpt2-y R-midpt2-x  R-midpt2-y
                                   L-botpt2-x L-botpt2-y R-botpt2-x R-botpt2-y)
            (values-list node2-pts)

          ;;DRAW A PATH
          (capi:apply-in-pane-process output-pane 
                                      'draw-cs-path inst output-pane pathtext node1-slot node2-slot 
                                      :draw-ellipse-p draw-ellipse-p :path-type path-type
                                      :node1pt-type  node1pt-type  :node2pt-type node2pt-type)   
  ;;(draw-cs-path
          ;;needed for time to set slot-value in above apply-in-pane-process
          (sleep 1)

          ;;GET & WRITE MESSAGE?
          (setf node-message (slot-value inst 'node-message)
                path-message (slot-value inst 'path-message)) 
          ;;(afout 'out (format nil "AFOUT path-message= ~A~%slot-value= ~A" path-message (slot-value inst 'path-message)))
          
          (setf message (format nil ">>NODE:  ~A~%>>PATH:  ~A" 
                                node-message path-message))
            (capi:apply-in-pane-process message-pane
                                        #'(setf capi:rich-text-pane-text) message  message-pane)
                                      
         
          ;;end mvbs,with-slots
          )))
    ;;end let,make-test-netviewer
    ))|#
;;TEST
;; (make-test-netviewer 100 100 300 300) = works
;; (make-test-netviewer 500 500 300 300  :node1pt-type 'top :node2pt-type 'bot) = works
;; (setf kind3 '("KIND3" "KIND vs UKIND" CS2-1-1-99 NIL NIL :PC ("KIND" "UKIND" 1 NIL) :POLE1 "KIND" :POLE2 "UKIND" :BESTPOLE 1 :BIPATHS ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)) :CSVAL "0.917" :CSRANK "3")   happy2  '("HAPPY2" "HAPPY vs UHAPPY" CS2-1-1-99 NIL NIL :PC ("HAPPY" "UHAPPY" 1 NIL) :POLE1 "HAPPY" :POLE2 "UHAPPY" :BESTPOLE 1 :BIPATHS ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL FATHER NIL)) :CSVAL "1.000" :CSRANK "1")  logical '("LOGICAL" "LOGICAL vs NLOG" CS2-1-1-99 NIL NIL :PC ("LOGICAL" "NLOG" 1 NIL) :POLE1 "LOGICAL" :POLE2 "NLOG" :BESTPOLE 1 :BIPATHS ((POLE1 NIL BEST-M-FRIEND NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL M-DISLIKE NIL)) :CSVAL "0.833" :CSRANK "1"))
;; (make-test-netviewer 500 500 300 300  :node1pt-type 'top :node2pt-type 'bot :draw-pc-node-sym1 'kind3 :draw-pc-node-sym2 'happy2)




;;DRAW-CS-NODE
;;2018-02
;;ddd
(defun draw-cs-node (interface output-pane xpix ypix  node-pts-slot 
                              &key (top-text "") (mid-text "")(bot-text "")  (width 100)
                                 (top-ht 20)(mid-ht 20)(bot-ht 20) (top-str-gap 16) (L-str-gap 4)
                                 (font-size 7)(font-weight :normal))
  "In CS-net-viewer.   RETURNS       (values L-toppt-x   L-toppt-y   R-toppt-x R-toppt-y L-botpt-x L-botpt-y) "
  (let*
      ((mid-y (+ ypix top-ht))
       (bot-y (+ mid-y mid-ht))
       (top-str-x (+ xpix L-str-gap))
        (top-str-y (+ ypix top-str-gap))
        (mid-str-x top-str-x)
         (mid-str-y (+ top-str-y top-ht))
         (bot-str-x top-str-x)
         (bot-str-y (+ mid-str-y mid-ht))
       )
    (multiple-value-bind (L-toppt-x   L-toppt-y   R-toppt-x R-toppt-y 
                                      L-midpt-x L-midpt-y R-midpt-x  R-midpt-y
                                      L-botpt-x L-botpt-y R-botpt-x R-botpt-y)
        ;;calc-node-path-points also sets slot-value when node-pts-slot and interface
        (calc-node-path-points xpix ypix :interface  interface :set-slot-value node-pts-slot
                               :width width :top-ht  top-ht :mid-ht mid-ht  :bot-ht bot-ht 
                               :top-str-gap top-str-gap :L-str-gap L-str-gap )

      ;;draw top rectangle
      (gp:draw-rectangle output-pane xpix ypix width top-ht :filled NIL)
      ;;   :foreground :yellow  :compositing-mode :copy)
      ;;draw mid rectangle
      (gp:draw-rectangle output-pane xpix mid-y width mid-ht :filled Nil)
      ;;     :foreground  :green  :compositing-mode :copy)
      ;;draw bottom rectangle
      (gp:draw-rectangle output-pane xpix bot-y width bot-ht :filled NIL)
      ;  :foreground :blue  :compositing-mode :copy)


      ;;DRAW THE STRINGS
      ;;top
      (my-draw-string output-pane top-text top-str-x top-str-y :size font-size
                      :weight font-weight)
      ;;mid
      (my-draw-string output-pane mid-text mid-str-x mid-str-y :size font-size
                      :weight font-weight)
      ;;(gp:draw-string output-pane mid-text mid-str-x mid-str-y)
      ;;bottom
      (my-draw-string output-pane bot-text bot-str-x bot-str-y :size font-size
                      :weight font-weight)

      ;;(afout 'out (format nil "BEFORE SETTING SLOT-VALUES:~%R-midpt-x= ~A  R-midpt-y= ~A  L-midpt-x= ~A L-midpt-y= ~A~%SLOT= ~A  " R-midpt-x R-midpt-y L-midpt-x L-midpt-y  node-pts-slot ))

      ;;end mvb,let, draw-cs-node
      )))
;;TEST
;; (draw-cs-node output-pane 200 200)







;;DRAW-CS-PATH
;;2018
;;ddd
(defun draw-cs-path (interface output-pane node1-pts node2-pts  pathtext 
                               &key node1-slot node2-slot draw-ellipse-p
                               node1pt-type  node2pt-type (elp-w 50)(elp-ht 20)
                               L-toppt1-x   L-toppt1-y   R-toppt1-x R-toppt1-y 
                               L-midpt1-x  L-midpt1-y  R-MIDPT1-X R-MIDPT1-Y
                               L-botpt1-x   L-botpt1-y R-botpt1-x R-botpt1-y
                               L-toppt2-x   L-toppt2-y   R-toppt2-x R-toppt2-y 
                               L-MIDPT2-X L-MIDPT2-Y  R-midpt2-x R-midpt2-y
                               L-botpt2-x L-botpt2-y R-botpt2-x R-botpt2-y (R-htadj 5)
                                 celx1-n  cely1-n celx2-n  cely2-n 
                               (path-type :bezier) (path-height 10))
  (values-list node1-pts)
  "In CS-net-viewer draws path from node1 to node2. "
  (let
      ((sel-node1pt-x)
       (sel-node1pt-y)
       (sel-node2pt-x)
       (sel-node2pt-y)
       )
    ;;when get node-pts from slot-values
    (when node1-slot
      (setf node1-pts (slot-value interface node1-slot)))
    (when node2-slot
      (setf node2-pts (slot-value interface node2-slot)))

    (afout 'out (format nil "2 BEFORE MVB NODE1-PTS= ~A~%NODE2-PTS= ~A" node1-pts node2-pts))
    ;;GET NODE-PTS coordinates              
    (multiple-value-setq (L-toppt1-x   L-toppt1-y   R-toppt1-x R-toppt1-y 
                                       L-midpt1-x  L-midpt1-y  R-MIDPT1-X R-MIDPT1-Y
                                       L-botpt1-x   L-botpt1-y R-botpt1-x R-botpt1-y)
        (values-list node1-pts))
    (multiple-value-setq (L-toppt2-x   L-toppt2-y   R-toppt2-x R-toppt2-y 
                                       L-MIDPT2-X L-MIDPT2-Y  R-midpt2-x R-midpt2-y
                                       L-botpt2-x L-botpt2-y R-botpt2-x R-botpt2-y)
        (values-list node2-pts))

    (afout 'out (format nil "AFTER VALUES-LIST~%R-midpt1-x= ~A  R-midpt1-y= ~A  L-midpt2-x= ~A  L-midpt2-y= ~A  " R-midpt1-x R-midpt1-y L-midpt2-x L-midpt2-y))            

    ;;DECIDE ON WHICH PTS TO DRAW TO
    (cond
     ((equal node1pt-type 'top)
      (cond
       ((> L-toppt1-x L-toppt2-x )
        (setf sel-node1pt-x L-toppt1-x
              sel-node1pt-y L-toppt1-y
              sel-node2pt-x R-botpt2-x
              sel-node2pt-y (+ R-botpt2-y R-htadj)))
       ((= L-toppt1-x L-toppt2-x )
        (setf sel-node1pt-x R-toppt1-x
              sel-node1pt-y R-toppt1-y
              sel-node2pt-x R-botpt2-x
              sel-node2pt-y (+ R-botpt2-y R-htadj)))
       (t
        (setf sel-node1pt-x R-toppt1-x
              sel-node1pt-y R-toppt1-y
              sel-node2pt-x L-botpt2-x
              sel-node2pt-y L-botpt2-y))))
     ((equal node1pt-type 'mid)
      (cond
       ((> L-toppt1-x L-toppt2-x )
        (setf sel-node1pt-x L-midpt1-x
              sel-node1pt-y L-midpt1-y
              sel-node2pt-x R-midpt2-x
              sel-node2pt-y (+ R-midpt2-y R-htadj)))
       ((= L-toppt1-x L-toppt2-x )
        (setf sel-node1pt-x R-midpt1-x
              sel-node1pt-y R-midpt1-y
              sel-node2pt-x R-midpt2-x
              sel-node2pt-y (+ R-midpt2-y R-htadj)))
       (t
        (setf sel-node1pt-x R-midpt1-x
              sel-node1pt-y R-midpt1-y
              sel-node2pt-x L-midpt2-x
              sel-node2pt-y L-midpt2-y))))
     ((equal node1pt-type 'bot)
      (cond
       ((> L-toppt1-x L-toppt2-x )
        (setf sel-node1pt-x L-botpt1-x
              sel-node1pt-y L-botpt1-y
              sel-node2pt-x R-toppt2-x
              sel-node2pt-y (+ R-toppt2-y R-htadj)))
       ((= L-toppt1-x L-toppt2-x )
        (setf sel-node1pt-x R-botpt1-x
              sel-node1pt-y R-botpt1-y
              sel-node2pt-x R-toppt2-x
              sel-node2pt-y (+ R-toppt2-y R-htadj)))
       (t
        (setf sel-node1pt-x R-botpt1-x
              sel-node1pt-y R-botpt1-y
              sel-node2pt-x L-toppt2-x
              sel-node2pt-y L-toppt2-y))))
     (t nil))
    ;;(break "after set nodes")

    (afout 'out (format nil "AFTER SETTING SEL VALUES:~% sel-node1pt-x= ~A  sel-node1pt-y = ~A sel-node2pt-x = ~A  sel-node2pt-y= ~A   "  sel-node1pt-x sel-node1pt-y    sel-node2pt-x   sel-node2pt-y))

    (setf node-message (format nil "R-midpt1-x= ~A  R-midpt1-y= ~A  L-midpt2-x= ~A  L-midpt2-y= ~A  " R-midpt1-x R-midpt1-y L-midpt2-x L-midpt2-y))
    ;;"L-midpt1-y= ~A  R-midpt1= ~A  L-midpt2-y= ~A  R-midpt2-x= ~A  " L-midpt1-y R-midpt1 L-midpt2-y R-midpt2)

    (setf (slot-value interface 'node-message) node-message)

    (setf path-message (format nil " sel-node1pt-x= ~A  sel-node1pt-y = ~A sel-node2pt-x = ~A  sel-node2pt-y= ~A   "  sel-node1pt-x 
                               sel-node1pt-y    sel-node2pt-x   sel-node2pt-y))

    (setf (slot-value interface 'path-message) path-message)

    ;;(afout 'out (format nil "In draw-cs-path path-message= ~A~% slot-value= ~A"  path-message (slot-value interface 'path-message)))

    ;;DRAW THE PATH
    (draw-cs-path1 output-pane sel-node1pt-x sel-node1pt-y 
                   sel-node2pt-x sel-node2pt-y  pathtext  :draw-ellipse-p draw-ellipse-p 
                   :elp-w elp-w :elp-ht elp-ht
                   :path-type path-type :path-height path-height
                    :celx1-n celx1-n :cely1-n cely1-n  :celx2-n celx2-n :cely2-n cely2-n)
    ;;  transform-line
    ;;end let, draw-cs-path
    ))
      
   




;;DRAW-CS-PATH1
;;2018
;;ddd
;;VERSION NOT USING GP:DRAW-PATH
(defun draw-cs-path1 (output-pane x1 y1 x2 y2 text  &key draw-ellipse-p 
                                  (elp-w 50)(elp-ht 30) transform-line
                                   (path-type :bezier) (path-height 10) 
                                    celx1-n  cely1-n celx2-n cely2-n)
  "In   CS-net-viewer    INPUT:  "
  (let*
      ((path-n-length  (- cely2-n cely1-n ))
       (elp-x   (+ x1 elp-w (/ (- x2 x1) 2) 5)) 
       (elp-y (+ y1  (/ (- y2 y1) (* 2 path-n-length))))
       (str-x (- (+ elp-x 10) elp-w))
       (str-y elp-y)
       )
    ;;(break)

    ;;DRAW ELLIPSE
    ;;(BREAK "sel-node1pt-y=> Y2")
    (when draw-ellipse-p
      (gp:draw-ellipse output-pane  elp-x elp-y elp-w elp-ht :filled NIL :background :white :foreground :black)
  ;;200 300 50 60) ;;
    ;;DRAW INFO STRING
    ;;(gp:draw-string output-pane text  (- str-x (/ elp-w 2))  str-y)
    (my-draw-string output-pane text  str-x str-y :size 7)
    ;;(gp:draw-string output-pane text  str-x str-y)  ;;70 90) ;;
    )
    
     ;;DRAW BASIC PATH
    (cond
     ((equal path-type :bezier)
      ;;SSS START HERE  POINTS OK TO HERE FOR TEST--BUT LINES WRONG--COMPARE TO RECTANGLE FIRST??
      ;;(BREAK "chk x's & y's")
      (my-draw-bezier output-pane x1 y1 x2 y2
                      :draw-cs-path-p T  :reverse-a-p NIL :reverse-b-p NIL)
     ;; (gp:draw-path output-pane (list (list :bezier 20 40 20 10  x2 y2 )) x1 y1)
      ;;(list :bezier 0 10 10 10  0  (- (* *celh  2/3) elp-ht)) ;;(- elp-y elp-ht y1)
      ;;ellipse to node2= x2,y2
      )
#|(gp:draw-path output-pane (list (list :bezier 20 0 10 10  0 (- elp-y elp-ht y1))
      (list :ellipse 0  (- elp-y y1) elp-w elp-ht :filled NIL :background :white
            :foreground :black)   (list :move 0 (+ elp-ht  elp-y))  
        (list :line 7 (- (* *celh  2/3) elp-ht)  7 (- y2  (- (* *celh  2/3) elp-ht)))) |#
      ;;(list :bezier 0 10 10 10  0  (- (* *celh  2/3) elp-ht))) x1 y1)
      ((equal path-type :rectangle)
       (my-draw-rectangle-path output-pane x1 y1 x2 y2 :path-height path-height)
       )
      ;;SSS FIX LATER?? Problem reliably going from point x1,y1 to x2,y2 with draw-arc
      ((equal path-type :arc)
       (my-draw-arc  output-pane x1 y1 x2 y2 arc-height)
       )
      (t
       (gp:draw-line output-pane x1 y1 x2 y2 :transform transform-line)))


    ;;end  let, draw-cs-path
    ))
;;TEST
;; (draw-cs-path output-pane 30 60 90 50 "  PAT Info String ")
;; make happy2 etc below
;; (MAKE-PC-NETVIEWER  '(((happy2 1))((kind3 1))((logical 1) (narcist 2))))






;;MAKE-PC-NETVIEWER
;;2018-02
;;ddd
(defun make-pc-netviewer (grouped-pcs &key (win-x 20) (win-y 20)
                                      draw-ellipse-p (path-type :bezier)
                                      (node-pts-slot 'node1-pts)
                                      (node-width 100) (top-ht 20)(mid-ht 20)(bot-ht 20) 
                                      (top-str-gap 10) (L-str-gap 4)
                                      (elp-w 50)(elp-ht 20))
  "In CS-net-viewer. Makes a CS-net-view-interface.   "
  (let
      ((inst (make-instance 'NetView-Interface :x win-x :y win-y ))
       (node-pts)
       (node-message "")
       (path-message "")
       (message "")
       #|                                    (pathtext "PATH TEXT HERE")
                                    (node1pt-type 'mid) (node2pt-type 'mid)
                                    (node1-slot 'node1-pts)(node2-slot 'node2-pts))|#
       )

    ;;MUST DISPLAY BEFORE CAN DRAW ON IT
    (capi:display inst)
    
    ;;SET SLOT VALUES TO USE IN DISPLAY-CALLBACK
    (setf (slot-value inst 'win-x) win-x
          (slot-value inst 'win-y) win-y 
          (slot-value inst 'node-pts-slot) node-pts-slot
          (slot-value inst 'node-width) node-width
          (slot-value inst  'top-ht) top-ht
          (slot-value inst 'mid-ht) mid-ht
          (slot-value inst 'bot-ht) bot-ht
          (slot-value inst 'top-str-gap) top-str-gap
          (slot-value inst 'L-str-gap) L-str-gap
          (slot-value inst  'elp-w) elp-w
          (slot-value inst 'elp-ht) elp-ht
          (slot-value inst 'path-type) path-type
            (slot-value inst 'grouped-pcs) grouped-pcs)
    ;;end let,make-pc-netviewer
    ))
;;TEST
;;SSSSSS START TESTING make-pc-netviewer
;; (setf kind3 '("KIND3" "KIND vs UKIND" CS2-1-1-99 NIL NIL :PC ("KIND" "UKIND" 1 NIL) :POLE1 "KIND" :POLE2 "UKIND" :BESTPOLE 1 :BIPATHS ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)) :CSVAL "0.917" :CSRANK "3" :TO (NARCIST))   happy2  '("HAPPY2" "HAPPY vs UHAPPY" CS2-1-1-99 NIL NIL :PC ("HAPPY" "UHAPPY" 1 NIL) :POLE1 "HAPPY" :POLE2 "UHAPPY" :BESTPOLE 1 :BIPATHS ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL FATHER NIL)) :CSVAL "1.000" :CSRANK "1" :TO (LOGICAL NARCIST)) narcist  '("NARCIST" "NARCIST vs CARING" CS2-1-1-99 NIL NIL :PC ("NARCIST" "CARING" 1 NIL) :POLE1 "NARCIST" :POLE2 "CARING" :BESTPOLE 1 :BIPATHS ((POLE1 NIL FATHER NIL) (POLE1 NIL M-DISLIKE NIL) (POLE2 NIL MOTHER NIL)) :CSVAL "0.917" :CSRANK "5")      logical  '("LOGICAL" "LOGICAL vs NLOG" CS2-1-1-99 NIL NIL :PC ("LOGICAL" "NLOG" 1 NIL) :POLE1 "LOGICAL" :POLE2 "NLOG" :BESTPOLE 1 :BIPATHS ((POLE1 NIL BEST-M-FRIEND NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL M-DISLIKE NIL)) :CSVAL "0.833" :CSRANK "1")   )
;;
;; (MAKE-PC-NETVIEWER  '(((happy2 1))((kind3 1))((logical 1) (narcist 2))))
;; =WORKS!!



;;NETVIEWER-DISPLAY-CALLBACK
;;2018-02
;;ddd
(defun netview-display-callback (pane x y width height)
  "In CS-net-viewer. Makes a CS-net-view-interface.   "
  (let*
      ((interface (capi:top-level-interface pane))
        (node-pts)
       (node-message "")
       (path-message "")
       (message "")
       ;;get from slots
       (win-x (slot-value interface 'win-x))
       (win-y (slot-value interface 'win-y))
       (node-pts-slot (slot-value interface 'node-pts-slot))
       (node-width (slot-value interface 'node-width))
       (top-ht (slot-value interface  'top-ht))
       (mid-ht (slot-value interface 'mid-ht))
       (bot-ht (slot-value interface 'bot-ht))
       (top-str-gap (slot-value interface 'top-str-gap))
       (L-str-gap (slot-value interface 'L-str-gap))
       (grouped-pcs (slot-value interface 'grouped-pcs) )
       (path-type (slot-value interface 'path-type))
       )

    (with-slots (output-pane title-pane message-pane) interface
      ;;(break "grouped-pcs")
      ;;DRAW THE PANES IN THE WINDOW
      (capi:apply-in-pane-process output-pane      
                                  'place-pc-nodes-in-window interface output-pane node-pts-slot 
                                  grouped-pcs :path-type path-type
                                  :node-width node-width :top-ht top-ht :mid-ht mid-ht
                                  :bot-ht bot-ht
                                  :top-str-gap 10 :L-str-gap 4)

      ;;DRAW PC PATHS?
      ;;DRAW 
      #|          (capi:apply-in-pane-process output-pane
                                      'draw-cs-path interface output-pane pathtext node1-slot node2-slot 
                                      :node1pt-type  node1pt-type  :node2pt-type node2pt-type)   |#
      ;;(draw-cs-path
      ;;needed for time to set slot-value in above apply-in-pane-process
      (sleep 1)

      ;;GET & WRITE MESSAGE?
      (setf node-message (slot-value interface 'node-message)
            path-message (slot-value interface 'path-message)) 
      ;;(afout 'out (format nil "AFOUT path-message= ~A~%slot-value= ~A" path-message (slot-value interface 'path-message)))
          
      (setf message (format nil ">>NODE:  ~A~%>>PATH:  ~A" 
                            node-message path-message))
      (capi:apply-in-pane-process message-pane
                                  #'(setf capi:rich-text-pane-text) message  message-pane)                      
      ;;end with-slots
      )
    ;;end let,
    ))





;;PLACE-PC-NODES-IN-WINDOW
;;NOTE: Must draw graph to a buffer  because having a separate slot for each path and node could result in huge number of slots that would also vary greatly from one network to another.
;;2018-02
;;ddd
(defun place-pc-nodes-in-window (interface output-pane node-pts-slot grouped-pcs
                                          &key draw-ellipse-p (path-type :bezier)
                                          (node-width 100)(xpix 0)(ypix 0)
                                          (top-ht 20)(mid-ht 20)(bot-ht 20) (top-str-gap 10)
                                          (L-str-gap 4))
  ;;SSS do later, elms )
  "In  U-capi-graphics. Places my graphic nodes in a window
  INPUT: PCS arranged in sorted value groups and sorted pcs within each group. "

  (let
      ((n-pc-gps (list-length grouped-pcs))
       (cely-n 0)
       )

    ;;STEP 1: MAKE THE PC-NODES ----------------------------
    ;;FOR EACH VALUE GROUP
    (loop
     for pc-gp in grouped-pcs
     for n from 1 to n-pc-gps
     do
     (let*
         ((n-pcs (list-length pc-gp))
          (celx-n 0)
          )
       (incf cely-n)
       
       ;;FOR EACH PC in a value group
       ;;symval symval list ("KIND3" "KIND vs UKIND" CS2-1-1-99 NIL NIL :PC ("KIND" "UKIND" 1 NIL) :POLE1 "KIND" :POLE2 "UKIND" :BESTPOLE 1 :BIPATHS ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)) :CSVAL "0.917" :CSRANK "3")
       (loop
        for pclist in pc-gp
        for n from 1 to n-pcs
        do
        (incf celx-n)
        (let*
            ;;NOTE: FIX pc W DATA STORAGE SOURCE 
            ((pcsym (my-make-symbol (car pclist))) 
             (pcsymvals (eval pcsym))
#|             (pcname (car pcsymvals))
             (pc-bipole-str (second pcsymvals))
             (pcpole1 (get-keyvalue-in-nested-list '((:pole1 T)) pcsymvals))
             (pcpole2 (get-keyvalue-in-nested-list '((:pole2 T)) pcsymvals))
             (bestpole (get-keyvalue-in-nested-list '((:bestpole T)) pcsymvals))|#
             (topaths (get-keyvalue-in-nested-list '((:TO T)) pcsymvals))
             (bipaths (get-keyvalue-in-nested-list '((:BIPATHS T)) pcsymvals))
            ;;(csval (get-keyvalue-in-nested-list '((:csval T)) pcsymvals))
             ;;(csrank (get-keyvalue-in-nested-list '((:csrank T)) pcsymvals))  
             (xy-n (list celx-n cely-n))
             (x)
             (y)
             )

          ;;ADD THE XY-N celx-n cely-n to the symvals
          (set-key-value :xy-n xy-n  pcsym :append-as-flatlist-p T
                         :append-as-keylist-p NIL :set-listsym-to-newlist-p T)

          ;;CALC THE PIXEL LOCATION
          (setf x (+ (* xpix *xpix/x) (* (- celx-n 1) *celw))
                y (+ (* ypix *ypix/y) (* (- cely-n 1) *celh)))

          ;;(afout 'out (format nil "For pcsym= ~A: celx-n= ~A cely-n= ~A x= ~A  y= ~A " pcsym celx-n cely-n x y))

          ;;MAKE THE PC NODE
          (draw-pc-node interface output-pane pcsym x  y node-pts-slot 
                        :width node-width :top-ht top-ht :mid-ht mid-ht :bot-ht bot-ht
                        :top-str-gap top-str-gap :l-str-gap l-str-gap)

          ;;end let,inner pc loop
          ))

       ;;end let, outer pc-gp loop
       ))
    ;;STEP 2: MAKE THE PC-PATHS 
    ;; SSS START HERE --USE ISA SUP & SUB LISTS
    ;;STEP 2.1: Find the TO PATHS ONLY in the current group.
    ;;USE :TO :BIPATHS or :FROM items pcs or elemsyms
    (loop
     for pc-gp in grouped-pcs
     for n from 1 to n-pc-gps
     do
     (let*
         ((n-pcs (list-length pc-gp))
          (celx-n 0)
          )
       (incf celx-n)
       (loop
        for pclist in pc-gp
        for n from 1 to n-pcs
        do
        (let*
            ((pc (my-make-symbol (car pclist)))
             (pcsymlist1 (eval pc))
             (xyloc1 (get-key-value :xy-n pcsymlist1))          
             (celx1-n (car xyloc1))
             (cely1-n  (second xyloc1))
             (xpix1 (* (- celx1-n 1) *celw))
             (ypix1 (* (- cely1-n 1) *celh))
             (node1-pts (calc-node-path-points xpix1 ypix1))
             (tocels (get-key-value :TO pcsymlist1))
             (n-tocels (list-length tocels))
             )
       
          ;;STEP 2.2 Find all nodes and locations listed in EACH TO PATH
          (loop
           for tocel in tocels
           for n from 1 to n-tocels
           do
           (let*
               ((tosym (my-make-symbol tocel))
                (pcsymlist2 (eval tosym))
                (xyloc2 (get-key-value :xy-n pcsymlist2))          
                (celx2-n (car xyloc2))
                (cely2-n  (second xyloc2))
                (xpix2 (* (- celx2-n 1) *celw))
                (ypix2 (* (- cely2-n 1) *celh))
                (node2-pts (calc-node-path-points xpix2 ypix2))
                (pathtext (format nil "~A>~A" pc tocel))
                (node1pt-type 'BOT)
                (node2pt-type  'TOP)
                (elp-w (slot-value interface  'elp-w))
                (elp-ht (slot-value interface 'elp-ht))
                )          

             #|(L-toppt1-x   L-toppt1-y   R-toppt1-x R-toppt1-y 
                                       L-midpt1-x  L-midpt1-y  R-MIDPT1-X R-MIDPT1-Y
                                       L-botpt1-x   L-botpt1-y R-botpt1-x R-botpt1-y)|#
            
             ;;DRAW THE PATH FROM PC to TO PC
             ;;NOTE: Must draw paths to a buffer (along with everything else?) because having a separate slot for each path could result in huge number of slots that would also vary greatly from one network to another.
             (draw-cs-path interface output-pane node1-pts node2-pts  pathtext 
                           :path-type path-type
                           :draw-ellipse-p draw-ellipse-p
                           :node1-slot  NIL :node2-slot  NIL 
                           :node1pt-type  node1pt-type :node2pt-type node2pt-type
                           :elp-w elp-w :elp-ht elp-ht :celx1-n celx1-n :cely1-n cely1-n 
                           :celx2-n celx2-n :cely2-n cely2-n)

             ;;end let,inner loop
             ))
          ;;end let, middle loop
          ))
       ;;end let, outer pc-gp loop
       ))

    (values    )
    ;;end let, place-pc-nodes-in-window
    ))
;;TEST
;; THIS IS USED BY CALLBACK, SO TEST BY CALLING FRAME
;; 







;;DRAW-PC-NODE
;;2018-02
;;ddd
(defun draw-pc-node (interface output-pane pcsym x y  node-pts-slot
                               &key (width 100) (top-ht 20)(mid-ht 20)(bot-ht 20) 
                               (top-str-gap 10) (L-str-gap 4)
                                 (xpix *xpix)(ypix *ypix)(xpix/x *xpix/x)(ypix/y *ypix/y))
  "In  CS-net-viewer, Makes one pc graphics node for cs-net-viewer. RETURNS  "
  (when (stringp pcsym)
    (setf pcsym (my-make-symbol pcsym)))
        (let*
            ;;NOTE: FIX pc W DATA STORAGE SOURCE 
            ((pcsymvals (eval pcsym))
             (pcname (car pcsymvals))
             (pc-loc (third pcsymvals))
             (pc-bipole-str (second pcsymvals))
             (pcpole1 (get-keyvalue-in-nested-list '((:pole1 T)) pcsymvals))
             (pcpole2 (get-keyvalue-in-nested-list '((:pole2 T)) pcsymvals))
             (bestpole (get-keyvalue-in-nested-list '((:bestpole T)) pcsymvals))
             (bipaths (get-keyvalue-in-nested-list '((:bipaths T)) pcsymvals))
             (csval (get-keyvalue-in-nested-list '((:csval T)) pcsymvals))
             (csrank (get-keyvalue-in-nested-list '((:csrank T)) pcsymvals))     
             (top-text (format nil " ~A" pcname))
             (mid-text (format nil " ~A" pc-loc))
             (bot-text (format nil "Val: ~A,Rank: ~A" csval csrank))
             )
       ;;FOR EACH PC in a value group
;;symval symval list ("KIND3" "KIND vs UKIND" CS2-1-1-99 NIL NIL :PC ("KIND" "UKIND" 1 NIL) :POLE1 "KIND" :POLE2 "UKIND" :BESTPOLE 1 :BIPATHS ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)) :CSVAL "0.917" :CSRANK "3")

       ;;STORE WINDOW LOC IN PCSYMS
       (set-key-value :xyloc (list xpix ypix) pcsym :append-as-keylist-p nil
                      :set-listsym-to-newlist-p T :append-as-flatlist-p T)

           ;;(afout 'out (format nil "pc-loc= ~A  mid-text= ~A " pc-loc mid-text))
           (draw-cs-node interface output-pane x y  node-pts-slot 
                         :top-text top-text  :mid-text mid-text    :bot-text bot-text
                         :width width
                         :top-ht top-ht :mid-ht mid-ht :bot-ht bot-ht :top-str-gap top-str-gap
                         :L-str-gap L-str-gap)

    (values pcsym   )
    ;;end let, draw-pc-node
    ))
;;TEST
;;  (draw-pc-node
;;test for above adding :XYLOC (0 0))
;; (set-key-value :xyloc (list 0  0) 'happy2 :append-as-keylist-p nil :set-listsym-to-newlist-p T :append-as-flatlist-p T)
;; works= ("HAPPY2" "HAPPY vs UHAPPY" CS2-1-1-99 NIL NIL :PC ("HAPPY" "UHAPPY" 1 NIL) :POLE1 "HAPPY" :POLE2 "UHAPPY" :BESTPOLE 1 :BIPATHS ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL FATHER NIL)) :TO ( :CSVAL "1.000" :CSRANK "1" :XYLOC (0 0))

;;change above:
;; (set-key-value :xyloc (list 100  100) 'happy2 :append-as-keylist-p nil :set-listsym-to-newlist-p T :append-as-flatlist-p T)
;; works= ("HAPPY2" "HAPPY vs UHAPPY" CS2-1-1-99 NIL NIL :PC ("HAPPY" "UHAPPY" 1 NIL) :POLE1 "HAPPY" :POLE2 "UHAPPY" :BESTPOLE 1 :BIPATHS ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL FATHER NIL)) :CSVAL "1.000" :CSRANK "1" :XYLOC (100 100))    :XYLOC   (0 0)   (:XYLOC (100 100))






;;DRAW-PC-PATH
;;2018-02
;;ddd
(defun draw-pc-path (interface output-window pcsym1 pcsym2  
                              &key set-slot-value (path-type :bezier)
                              (node-width 100)(xpix 0)(ypix 0)
                              (top-ht 20)(mid-ht 20)(bot-ht 20) (top-str-gap 10)
                              (L-str-gap 4) (elp-w 50)(elp-ht 20))
  "In   RETURNS    INPUT:  "
  ;;If pcsym a string
  (when (stringp pcsym1)
    (setf pcsym (my-make-symbol pcsym1)))
  (when (stringp pcsym2)
    (setf pcsym (my-make-symbol pcsym2)))

  (let*
      ((pcsymvals1 (eval pcsym1))
       (xyloc1 (get-keyvalue-in-nested-list '((:xyloc T)) pcsymvals1))
       (xpix1 (car xyloc1))
       (ypix1 (second  xyloc1))
       (x1 (* xpix1 *xpix/x))
       (y1 (* ypix1 *ypix/y))
       ;;for pcsym2
       (pcsymvals2 (eval pcsym2))
       (xyloc2 (get-keyvalue-in-nested-list '((:xyloc T)) pcsymvals2))
       (xpix2 (car xyloc2))
       (ypix2 (second  xyloc2))
       (x2 (* xpix2 *xpix/x))
       (y2 (* ypix2 *ypix/y))
       (node1-pts)
       (node2-pts)
       (pathtext (format nil " ~A to ~A " pcsym1 pcsym2))
       )

    ;;CALC THE PATH PT LOCATIONS
    #|       (multiple-value-bind (L-toppt-x1   L-toppt-y1   R-toppt-x1 R-toppt-y1 
                                         L-midpt-x1 L-midpt-y1 R-midpt-x1  R-midpt-y1
                                         L-botpt-x1 L-botpt-y1 R-botpt-x1 R-botpt-y1)|#
    ;;calc-node-path-points also sets slot-value when node-pts-slot and interface
    (setf node1-pts
          (calc-node-path-points xpix1 ypix1  interface :set-slot-value nil
                                 :width width :top-ht  top-ht :mid-ht mid-ht  :bot-ht bot-ht 
                                 :top-str-gap top-str-gap :L-str-gap L-str-gap ))

    #|       (multiple-value-bind (L-toppt-x2   L-toppt-y2   R-toppt-x2 R-toppt-y2 
                                         L-midpt-x2 L-midpt-y2 R-midpt-x2  R-midpt-y2
                                         L-botpt-x2 L-botpt-y2 R-botpt-x2 R-botpt-y2)|#
    ;;calc-node-path-points also sets slot-value when node-pts-slot and interface
    (setf node2-pts
          (calc-node-path-points xpix2 ypix2  interface :set-slot-value nil
                                 :width width :top-ht  top-ht :mid-ht mid-ht  :bot-ht bot-ht 
                                 :top-str-gap top-str-gap :L-str-gap L-str-gap ))


    ;;DRAW THE PATH
    (draw-cs-path interface output-pane node1-pts node2-pts pathtext 
                  :path-type path-type
                  :draw-ellipse-p draw-ellipse-p
                  :elp-w elp-w :elp-ht elp-ht)`
    (values  pcsym1 xpix ypix pcsym2   )
    ;;end mvbs,let, draw-pc-path
    ))
;;TEST
;; (draw-pc-path






;;CALC-NODE-PATH-POINTS
;;2018-02
;;ddd
(defun calc-node-path-points (xpix ypix &key interface set-slot-value 
                                    (top-text "") (mid-text "")(bot-text "")  (width 100)
                                   (top-ht 20)(mid-ht 20)(bot-ht 20) (top-str-gap 16) 
                                   (L-str-gap 4)(xpix/x *xpix/x)(ypix/y *ypix/y))
  "In CS-net-viewer.   RETURNS: (LIST (not values) L-toppt-x   L-toppt-y   R-toppt-x R-toppt-y  L-midpt-x L-midpt-y R-midpt-x  R-midpt-y L-botpt-x L-botpt-y R-botpt-x R-botpt-y)) IF set-slot-value = a slot-value symbol and interface sets that slot-value to LIST of above values. "
  (let*
      ((x (* xpix xpix/x))
       (y (* ypix ypix/y))
       (mid-y (+ y top-ht))
       (bot-y (+ mid-y mid-ht))
       (top-str-x (+ x L-str-gap))
       (top-str-y (+ y top-str-gap ))
       (mid-str-x top-str-x)
       (mid-str-y (+ top-str-y top-ht 2))
       (bot-str-x top-str-x)
       (bot-str-y (+ mid-str-y mid-ht 2))
       (L-toppt-x x)
       (L-toppt-y (+ y (* 0.5 top-ht)))
       (R-toppt-x (+ x width))
       (R-toppt-y L-toppt-y)
       (L-midpt-x x)
       (L-midpt-y (+ L-toppt-y mid-ht))
       (R-midpt-x R-toppt-x) ;;1
       (R-midpt-y L-midpt-y);;1
       (L-botpt-x x)
       (L-botpt-y (+ bot-y (* 0.5 top-ht)))
       (R-botpt-x R-toppt-x)
       (R-botpt-y L-botpt-y)
       )

    ;;SET SLOT-VALUES?
    (when set-slot-value
      (setf (slot-value interface set-slot-value )   
            (list L-toppt-x   L-toppt-y   R-toppt-x R-toppt-y 
                                                     L-midpt-x L-midpt-y R-midpt-x  R-midpt-y
                                                     L-botpt-x L-botpt-y R-botpt-x R-botpt-y)))

    (list L-toppt-x   L-toppt-y   R-toppt-x R-toppt-y 
                                                     L-midpt-x L-midpt-y R-midpt-x  R-midpt-y
                                                     L-botpt-x L-botpt-y R-botpt-x R-botpt-y)
    ;;end let, calc-node-path-points
    ))
;;TEST
;; (calc-node-path-points





;;OLD-DELETE AFTER DONE =================================
#|(defun make-test-netviewer (node1-x node1-y node2-x node2-y  &key (win-x 20) (win-y 20) 
                                    (pathtext "PATH TEXT HERE")
                                    draw-pc-node-sym1 draw-pc-node-sym2
                                    (node1pt-type 'mid) (node2pt-type 'mid)
                                    (node1-slot 'node1-pts)(node2-slot 'node2-pts))
  "In CS-net-viewer. Makes a CS-net-view-interface.   "
  (let
      ((inst (make-instance 'NetView-Interface :x win-x :y win-y ))
       (node1-pts)
       (node2-pts)
       (node-message "")
       (path-message "")
       (message "")
       )

    ;;MUST DISPLAY BEFORE CAN DRAW ON IT
    (capi:display inst)

    (with-slots (output-pane title-pane message-pane) inst

      ;;DRAW NODE1
      (cond
       (draw-pc-node-sym1
        (capi:apply-in-pane-process output-pane
                                    'draw-pc-node inst output-pane draw-pc-node-sym1 
                                    node1-x node1-y node1-slot))
;; (draw-pc-node
       (t    
        (capi:apply-in-pane-process output-pane
                                    'draw-cs-node inst output-pane node1-x node1-y node1-slot)))

      ;;DRAW NODE2
      (cond
       (draw-pc-node-sym2
        (capi:apply-in-pane-process output-pane
                                    'draw-pc-node inst output-pane draw-pc-node-sym2
                                    node2-x node2-y node2-slot))
       (t    
        (capi:apply-in-pane-process output-pane
                                    'draw-cs-node inst output-pane node2-x node2-y node2-slot)))

      ;;GET NODE-PTS coordinates
      (setf node1-pts (slot-value inst node1-slot)
            node2-pts (slot-value inst node2-slot))
                
      (multiple-value-bind (list L-toppt1-x   L-toppt1-y   R-toppt1-x R-toppt1-y 
                                 L-midpt1-x L-midpt1-y R-midpt1-x  R-midpt1-y
                                 L-botpt1-x L-botpt1-y R-botpt1-x R-botpt1-y)
          (values-list node1-pts)
        (multiple-value-bind (list L-toppt2-x   L-toppt2-y   R-toppt2-x R-toppt2-y 
                                   L-midpt2-x L-midpt2-y R-midpt2-x  R-midpt2-y
                                   L-botpt2-x L-botpt2-y R-botpt2-x R-botpt2-y)
            (values-list node2-pts)

          ;;DRAW A PATH
          (capi:apply-in-pane-process output-pane
                                      'draw-cs-path inst output-pane pathtext node1-slot node2-slot 
                                      :node1pt-type  node1pt-type  :node2pt-type node2pt-type)   
  ;;(draw-cs-path
          ;;needed for time to set slot-value in above apply-in-pane-process
          (sleep 1)

          ;;GET & WRITE MESSAGE?
          (setf node-message (slot-value inst 'node-message)
                path-message (slot-value inst 'path-message)) 
          ;;(afout 'out (format nil "AFOUT path-message= ~A~%slot-value= ~A" path-message (slot-value inst 'path-message)))
          
          (setf message (format nil ">>NODE:  ~A~%>>PATH:  ~A" 
                                node-message path-message))
            (capi:apply-in-pane-process message-pane
                                        #'(setf capi:rich-text-pane-text) message  message-pane)
                                      
         
          ;;end mvbs,with-slots
          )))
    ;;end let,make-test-netviewer
    ))|#







;;XXX   =============== DELETE LATER?  =========================
#| USING DRAW-PATH MEANS USING X,Y RELATIVE TO X1,Y1
;; MAY BE BETTER TO USE ABSOLUTE COORDINATES
(defun draw-cs-path1 (output-pane x1 y1 x2 y2 text  &key(elp-w 50)(elp-ht 20)
                                  transform-line (path-type :rectangle) (path-height 15))
  "In   CS-net-viewer    INPUT:  "
  (let*
      ((elp-x  (- (+ x1 elp-w (/ (- x2 x1) 2)) 30))
       (elp-y (+ y1  (/ *celh 3)))   ;;was  (/ (- y2 y1) 2.5)))
       (str-x (- (+ elp-x 30) elp-w))
       (str-y elp-y)
       )

    ;;DRAW ELLIPSE
    ;;(gp:draw-ellipse output-pane  elp-x elp-y elp-w elp-ht :filled NIL :background :white :foreground :black)
  ;;200 300 50 60) ;;

;; SSS START HERE REPLACE DRAW-CS-PATH1 WITH GP:DRAW-PATH??
     ;;DRAW BASIC PATH
    ;;NOTE: All points are relative to the x1 y1 in the path
     (gp:draw-path output-pane (list (list :bezier 20 0 10 10  0 (- elp-y elp-ht y1))
      (list :ellipse 0  (- elp-y y1) elp-w elp-ht :filled NIL :background :white
            :foreground :black)   (list :move 0 (+ elp-ht  elp-y))  
        (list :line 7 (- (* *celh  2/3) elp-ht)  7 (- y2  (- (* *celh  2/3) elp-ht))))
      ;;(list :bezier 0 10 10 10  0  (- (* *celh  2/3) elp-ht))) 
      x1 y1)
     ;;(gp:draw-path output-pane (list (list :line (- x2 x1)(- y2 y1)));;  x1 y1)
#|     (cond
      ((equal path-type ::rectangle)
       (my-draw-rectangle-path output-pane x1 y1 x2 y2 :path-height path-height)
       )
      ;;SSS FIX LATER?? Problem reliably going from point x1,y1 to x2,y2 with draw-arc
      ((equal path-type :arc)
       ;;here now
       (my-draw-arc  output-pane x1 y1 x2 y2 arc-height)
       )
      (t
       (gp:draw-line output-pane x1 y1 x2 y2 :transform transform-line)))|#

    ;;DRAW INFO STRING
    (gp:draw-string output-pane text  (- str-x (/ elp-w 2))  str-y)  ;;70 90) ;;
    
    (gp:draw-line output-pane 250 100 300 100)
    (gp:draw-line output-pane 250 200 300 200)
    (gp:draw-line output-pane 250 300 300 300)
    (gp:draw-line output-pane 250 400 300 400)
    ;;end  let, draw-cs-path
    ))|#
