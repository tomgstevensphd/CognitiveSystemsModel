;;****************** CS-net-view-Utils.lisp ********************************
;;
;;UTILITIES FOR CS-NETVIEWER (and other functions?)




;;DRAW-CS-NODE
;;2018-02
;;ddd
(defun draw-cs-node (interface output-pane xpix ypix  node-pts-slot 
                              &key (top-text "") (mid-text "")(bot-text "")  (width 120)
                                 (top-ht 20)(mid-ht 20)(bot-ht 20) (top-str-gap 16) (L-str-gap 4)
                                 (font-size 7)(font-weight :normal))
  "CS-net-view-Utils  RETURNS       (values L-toppt-x   L-toppt-y   R-toppt-x R-toppt-y L-botpt-x L-botpt-y) "
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
                               &key node1-slot node2-slot 
                               get-node-pts-from-slots-p
                               (node1pt-type 'mid) (node2pt-type 'mid) (elp-w 50)(elp-ht 20)
                               L-toppt1-x   L-toppt1-y   R-toppt1-x R-toppt1-y 
                               L-midpt1-x  L-midpt1-y  R-MIDPT1-X R-MIDPT1-Y
                               L-botpt1-x   L-botpt1-y R-botpt1-x R-botpt1-y
                               L-toppt2-x   L-toppt2-y   R-toppt2-x R-toppt2-y 
                               L-MIDPT2-X L-MIDPT2-Y  R-midpt2-x R-midpt2-y
                               L-botpt2-x L-botpt2-y R-botpt2-x R-botpt2-y (R-htadj 5)
                                 celx1-n  cely1-n celx2-n  cely2-n 
                               (path-type :bezier) (path-height 10))
  "CS-net-view-Utils draws path from node1 to node2. "
  (let
      ((sel-node1pt-x)
       (sel-node1pt-y)
       (sel-node2pt-x)
       (sel-node2pt-y) 
       )

    ;;when get node-pts from slot-values
    (when get-node-pts-from-slots-p
      (when node1-slot
        (setf node1-pts (slot-value interface node1-slot)))
      (when node2-slot
        (setf node2-pts (slot-value interface node2-slot))))

    ;;(afout 'out (format nil "2 BEFORE MVB NODE1-PTS= ~A~%NODE2-PTS= ~A" node1-pts node2-pts))
    ;;GET NODE-PTS coordinates              
    (multiple-value-setq (L-toppt1-x   L-toppt1-y   R-toppt1-x R-toppt1-y 
                                       L-midpt1-x  L-midpt1-y  R-MIDPT1-X R-MIDPT1-Y
                                       L-botpt1-x   L-botpt1-y R-botpt1-x R-botpt1-y)
        (values-list node1-pts))
    (multiple-value-setq (L-toppt2-x   L-toppt2-y   R-toppt2-x R-toppt2-y 
                                       L-MIDPT2-X L-MIDPT2-Y  R-midpt2-x R-midpt2-y
                                       L-botpt2-x L-botpt2-y R-botpt2-x R-botpt2-y)
        (values-list node2-pts))

    ;;(afout 'out (format nil "AFTER VALUES-LIST~%R-midpt1-x= ~A  R-midpt1-y= ~A  L-midpt2-x= ~A  L-midpt2-y= ~A  " R-midpt1-x R-midpt1-y L-midpt2-x L-midpt2-y))            

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

    ;;(afout 'out (format nil "AFTER SETTING SEL VALUES:~%node1pt-type= ~A node2pt-type= ~A ~% sel-node1pt-x= ~A  sel-node1pt-y = ~A sel-node2pt-x = ~A  sel-node2pt-y= ~A   " node1pt-type node2pt-type sel-node1pt-x sel-node1pt-y    sel-node2pt-x   sel-node2pt-y))

    (setf node-message (format nil "R-midpt1-x= ~A  R-midpt1-y= ~A  L-midpt2-x= ~A  L-midpt2-y= ~A  " R-midpt1-x R-midpt1-y L-midpt2-x L-midpt2-y))
    ;;"L-midpt1-y= ~A  R-midpt1= ~A  L-midpt2-y= ~A  R-midpt2-x= ~A  " L-midpt1-y R-midpt1 L-midpt2-y R-midpt2)

    (setf (slot-value interface 'node-message) node-message)

    (setf path-message (format nil " sel-node1pt-x= ~A  sel-node1pt-y = ~A sel-node2pt-x = ~A  sel-node2pt-y= ~A   "  sel-node1pt-x 
                               sel-node1pt-y    sel-node2pt-x   sel-node2pt-y))

    (setf (slot-value interface 'path-message) path-message)

    ;;(afout 'out (format nil "In draw-cs-path path-message= ~A~% slot-value= ~A"  path-message (slot-value interface 'path-message)))

    ;;DRAW THE PATH
    (draw-cs-path1 output-pane sel-node1pt-x sel-node1pt-y 
                   sel-node2pt-x sel-node2pt-y  pathtext 
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
(defun draw-cs-path1 (output-pane x1 y1 x2 y2 text    
                                  &key (elp-w 50)(elp-ht 30) transform-line
                                   (path-type :bezier) (path-height 10) 
                                    celx1-n  cely1-n celx2-n cely2-n)
  "CS-net-view-Utils   INPUT:  "
  (let*
      ((path-n-length  (- cely2-n cely1-n ))
       (elp-x   (+ x1 elp-w (/ (- x2 x1) 2) 5)) 
       (elp-y (cond  ((= path-n-length 0) (+ y1   (- y2 y1))) 
               (t (+ y1  (/ (- y2 y1) (* 2 path-n-length))))))
       (str-x (- (+ elp-x 10) elp-w))
       (str-y elp-y)
       )
    ;;(break)

    ;;DRAW ELLIPSE
    ;;(BREAK "sel-node1pt-y=> Y2")
    (when (equal path-type :ellipse)
      (gp:draw-ellipse output-pane  elp-x elp-y elp-w elp-ht :filled NIL :background :white :foreground :black)
      ;;200 300 50 60) ;;
      ;;DRAW INFO STRING
      ;;(gp:draw-string output-pane text  (- str-x (/ elp-w 2))  str-y)
      (my-draw-string output-pane text  str-x str-y :size 7)
      ;;(gp:draw-string output-pane text  str-x str-y)  ;;70 90) ;;
      ;;end when ellipse
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
;; (MAKE-CS-NETVIEWER  '(((happy2 1))((kind3 1))((logical 1) (narcist 2))))






;;PLACE-PC-NODES-IN-WINDOW
;;NOTE: Must draw graph to a buffer  because having a separate slot for each path and node could result in huge number of slots that would also vary greatly from one network to another.
;;2018-02
;;ddd
(defun place-pc-nodes-in-window (interface output-pane node-pts-slot grouped-pcs
                                          &key  (path-type :bezier)
                                          (node-width 100)(xpix 0)(ypix 0)
                                          (top-ht 20)(mid-ht 20)(bot-ht 20) (top-str-gap 10)
                                          (left-margin 20)(top-margin 10)
                                          (L-str-gap 4)  
                                          )
  ;;SSS do later, elms )
  "CS-net-view-Utils Places my graphic nodes in a window
  INPUT: PCS arranged in sorted value groups and sorted pcs within each group. Each group starts a new ROW (cely-n). Each cell a new node in row (celx-n). XPIX,YPIX= starting point inside L&R margins."
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
       ;;MAKE NEW ROW CELY-N FOR EACH GROUP
       (incf cely-n)
       
       ;;FOR EACH PC in a value group
       ;;symval symval list ("KIND3" "KIND vs UKIND" CS2-1-1-99 NIL NIL :PC ("KIND" "UKIND" 1 NIL) :POLE1 "KIND" :POLE2 "UKIND" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)) :va "0.917" :RNK "3")
       (loop
        for pclist in pc-gp
        for n from 1 to n-pcs
        do
        ;;MAKE NEW CELX-N FOR EACH CELL IN GROUP
        (incf celx-n)
        (let*
            ;;NOTE: FIX pc W DATA STORAGE SOURCE 
            ((pcsym (my-make-cs-symbol (car pclist))) 
             (pcsymvals (eval pcsym))
#|             (pcname (car pcsymvals))
             (pc-bipole-str (second pcsymvals))
             (pcpole1 (get-keyvalue-in-nested-list '((:pole1 T)) pcsymvals))
             (pcpole2 (get-keyvalue-in-nested-list '((:pole2 T)) pcsymvals))
             (bestpole (get-keyvalue-in-nested-list '((:bestpole T)) pcsymvals))|#
             (topaths (get-keyvalue-in-nested-list '((:TO T)) pcsymvals))
             (BIPATH (get-keyvalue-in-nested-list '((:BIPATH T)) pcsymvals))
            ;;(csval (get-keyvalue-in-nested-list '((:va T)) pcsymvals))
             ;;(csrank (get-keyvalue-in-nested-list '((:RNK T)) pcsymvals))  
             (xy-n (list celx-n cely-n))
             (x)
             (y)
             )

          ;;ADD THE XY-N celx-n cely-n to the symvals
          (set-key-value :xy-n xy-n  pcsym :append-as-flatlist-p T
                         :append-as-keylist-p NIL :set-listsym-to-newlist-p T)

          ;;CALC THE PIXEL LOCATION
          (setf x (+ left-margin (* xpix *xpix/x) (* (- celx-n 1) *celw))
                y (+ top-margin (* ypix *ypix/y) (* (- cely-n 1) *celh)))

         ;;ADD THE :XYLOC celx-n cely-n to the symvals
          (set-key-value :xyloc (list x y)  pcsym :append-as-flatlist-p T
                         :append-as-keylist-p NIL :set-listsym-to-newlist-p T)
         ;;(afout 'out (format nil "x= ~A y=~A pcsym=~A" x y pcsym))
          ;;(sleep 0.2)

;;TEST
;; (set-key-value :xyloc (list 20 10)  'CAREFOROTHERS :append-as-flatlist-p T   :append-as-keylist-p NIL :set-listsym-to-newlist-p T) = works
          ;;(afout 'out (format nil "For pcsym= ~A: celx-n= ~A cely-n= ~A x= ~A  y= ~A " pcsym celx-n cely-n x y))

          ;;MAKE THE PC NODE
          (draw-pc-node interface output-pane pcsym x  y node-pts-slot 
                        :store-xy-p T
                        :width node-width :top-ht top-ht :mid-ht mid-ht :bot-ht bot-ht
                        :top-str-gap top-str-gap :l-str-gap l-str-gap)

          ;;end let,inner pc loop
          ))

       ;;end let, outer pc-gp loop
       ))
    ;;STEP 2: MAKE THE PC-PATHS 
    ;; SSS START HERE --USE ISA SUP & SUB LISTS
    ;;STEP 2.1: Find the TO PATHS ONLY in the current group.
    ;;USE :TO :BIPATH or :FROM items pcs or elemsyms
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
            ((pc (my-make-cs-symbol (car pclist)))
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
               ((tosym (my-make-cs-symbol tocel))
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
                           :node1-slot  NIL :node2-slot  NIL 
                           :node1pt-type  node1pt-type :node2pt-type node2pt-type
                           :elp-w elp-w :elp-ht elp-ht
                           :celx1-n celx1-n :cely1-n cely1-n 
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
                               (top-str-gap 10) (L-str-gap 4) store-xy-p 
                                 (xpix *xpix)(ypix *ypix)(xpix/x *xpix/x)(ypix/y *ypix/y))
  "CS-net-view-Utils, Makes one pc graphics node for cs-net-viewer. RETURNS  "
  (when (stringp pcsym)
    (setf pcsym (my-make-cs-symbol pcsym)))
        (let*
            ;;NOTE: FIX pc W DATA STORAGE SOURCE 
            ((pcsymvals (eval pcsym))
             (pcname (car pcsymvals))
             (pc-loc (third pcsymvals))
             (pc-bipole-str (second pcsymvals))
             (pcpole1 (get-keyvalue-in-nested-list '((:pole1 T)) pcsymvals))
             (pcpole2 (get-keyvalue-in-nested-list '((:pole2 T)) pcsymvals))
             (bestpole (get-keyvalue-in-nested-list '((:bestpole T)) pcsymvals))
             (BIPATH (get-keyvalue-in-nested-list '((:BIPATH T)) pcsymvals))
             (csval (get-keyvalue-in-nested-list '((:va T)) pcsymvals))
             (csrank (get-keyvalue-in-nested-list '((:RNK T)) pcsymvals))     
             (top-text (format nil " ~A" pcname))
             (mid-text (format nil " ~A" pc-loc))
             (bot-text (format nil "Val: ~A,Rank: ~A" csval csrank))
             )
       ;;FOR EACH PC in a value group
;;symval symval list ("KIND3" "KIND vs UKIND" CS2-1-1-99 NIL NIL :PC ("KIND" "UKIND" 1 NIL) :POLE1 "KIND" :POLE2 "UKIND" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)) :va "0.917" :RNK "3")

       ;;STORE WINDOW LOC IN PCSYMS
       (when store-xy-p
        (set-key-value :xyloc (list x y) pcsym :append-as-keylist-p nil
                       :set-listsym-to-newlist-p T :append-as-flatlist-p T))

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
;; works= ("HAPPY2" "HAPPY vs UHAPPY" CS2-1-1-99 NIL NIL :PC ("HAPPY" "UHAPPY" 1 NIL) :POLE1 "HAPPY" :POLE2 "UHAPPY" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL FATHER NIL)) :TO ( :va "1.000" :RNK "1" :XYLOC (0 0))

;;change above:
;; (set-key-value :xyloc (list 100  100) 'happy2 :append-as-keylist-p nil :set-listsym-to-newlist-p T :append-as-flatlist-p T)
;; works= ("HAPPY2" "HAPPY vs UHAPPY" CS2-1-1-99 NIL NIL :PC ("HAPPY" "UHAPPY" 1 NIL) :POLE1 "HAPPY" :POLE2 "UHAPPY" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL FATHER NIL)) :va "1.000" :RNK "1" :XYLOC (100 100))    :XYLOC   (0 0)   (:XYLOC (100 100))





;;DRAW-PC-PATHS
;;2019
;;ddd
(defun draw-pc-paths (interface output-pane pcsym-pairs
                              &key set-slot-value (path-type :bezier)
                              (node-width 100) xpix ypix
                              (top-ht 20)(mid-ht 20)(bot-ht 20) (top-str-gap 10)
                              (L-str-gap 4) (elp-w 50)(elp-ht 20))
  "CS-net-view-Utils   INPUT: pcsym-pairs is list of lists with (((pcsym1 etc)(pcsym2 etc)) ETC)"
  (let*
      ((x)
       )
    (with-slots (output-pane message-pane) interface
      (loop
       for pcsym-pair in pcsym-pairs
       do
       (let*
           ((pclist1 (car pcsym-pair))
            (pclist2 (second pcsym-pair))
            (pcsym1 (car pclist1))
            (pcsym2 (car pclist2))
            (xy-pix1 (get-symkeyval pcsym1 :xyloc))
            (xy-pix2 (get-symkeyval pcsym2 :xyloc))
            (xpix1 (car xy-pix1))
            (ypix1 (second xy-pix1))
           ;;not used? (xpix2 (car xy-pix2))
           ;;not used? (ypix2 (second xy-pix2))            
            )
         ;;BREAK HERE CAUSED LW TO CRASH (opened in cmd window) 
         ;;(break "xpix") OPENS CMD WINDOW ON ANY ERROR--CRASHES
        
         ;;SSSSS START HERE draw-pc-path NEEDS XPIX AND YPIX
         ;;DRAW ONE PATH BETW pcsym1 pcsym2zas
         ;;SSS CAN DO NESTED APPLY-IN- OR should this not be in apply-in
         (capi:apply-in-pane-process output-pane
                                    'draw-pc-path interface output-pane pcsym1 pcsym2  
                                    ;; (draw-pc-path interface output-pane pcsym1 pcsym2  
                                     :set-slot-value T  :path-type path-type
                                     :node-width node-width :xpix xpix1 :ypix ypix1
                                     :top-ht top-ht :mid-ht mid-ht :bot-ht bot-ht
                                     :top-str-gap top-str-gap
                                     :L-str-gap L-str-gap :elp-w elp-w :elp-ht elp-ht)
                                            
         #|   NO-use draw-pc-path which uses draw-cs-path
                                   'draw-cs-path interface output-pane pathtext
                                      node1-slot node2-slot 
                                      :node1pt-type  node1pt-type  :node2pt-type node2pt-type)   |#
         ;;(draw-cs-path
         ;;needed for time to set slot-value in above apply-in-pane-process
         (sleep .01)
         ;;GET & WRITE MESSAGE?
         (setf node-message (slot-value interface 'node-message)
               path-message (slot-value interface 'path-message)) 
         ;;(afout 'out (format nil "AFOUT path-message= ~A~%slot-value= ~A" path-message (slot-value interface 'path-message)))
          
#|  UNQUOTE
        (setf message (format nil ">>NODE:  ~A~%>>PATH:  ~A" 
                               node-message path-message))
         (capi:apply-in-pane-process message-pane
                                     #'(setf capi:rich-text-pane-text) message  message-pane)        |#              
         ;;end pc-pair let, loop
         ))
      ;;end with-slots,let, draw-pc-paths
      )))





;;DRAW-PC-PATH
;;2018-02
;;ddd
(defun draw-pc-path (interface output-pane pcsym1 pcsym2  
                              &key set-slot-value (path-type :bezier)   
                              (node1pt-type 'mid) (node2pt-type 'mid)
                              (node-width 100)(xpix 0)(ypix 0)
                              (top-ht 20)(mid-ht 20)(bot-ht 20) (top-str-gap 10)
                              (L-str-gap 4) (elp-w 50)(elp-ht 20))
  "CS-net-view-Utils   RETURNS    INPUT:  Uses DRAW-CS-PATH.
 node1pt-type ('top 'mid or 'bot) where path begins; 2, path ends"
  ;;If pcsym a string
  (when (stringp pcsym1)
    (setf pcsym (my-make-cs-symbol pcsym1)))
  (when (stringp pcsym2)
    (setf pcsym (my-make-cs-symbol pcsym2)))

  (let*
      ((pcsymvals1 (eval pcsym1))
       (xyloc1 (get-keyvalue-in-nested-list '((:xyloc T)) pcsymvals1))
       ;; (get-key-value
       (xpix1 (car xyloc1))
       (ypix1 (second  xyloc1))
       (x1 (* xpix1 *xpix/x))
       (y1 (* ypix1 *ypix/y))
       (cel1xy-n (get-keyvalue-in-nested-list '((:xy-n T)) pcsymvals1))
       (celx1-n (car cel1xy-n))
       (cely1-n (second cel1xy-n))
       ;;for pcsym2
       (pcsymvals2 (eval pcsym2))
       (xyloc2 (get-keyvalue-in-nested-list '((:xyloc T)) pcsymvals2))
       (xpix2 (car xyloc2))
       (ypix2 (second  xyloc2))
       (x2 (* xpix2 *xpix/x))
       (y2 (* ypix2 *ypix/y))
       (cel2xy-n (get-keyvalue-in-nested-list '((:xy-n T)) pcsymvals2))
       (celx2-n (car cel2xy-n))
       (cely2-n (second cel2xy-n))
       (node1-pts)
       (node2-pts)
       (pathtext (format nil " ~A to ~A " pcsym1 pcsym2))
       )
    ;;CAUSES CRASH? (break "xyloc1 xpix1 x1")

    ;;CALC THE PATH PT LOCATIONS
    #|       (multiple-value-bind (L-toppt-x1   L-toppt-y1   R-toppt-x1 R-toppt-y1 
                                         L-midpt-x1 L-midpt-y1 R-midpt-x1  R-midpt-y1
                                         L-botpt-x1 L-botpt-y1 R-botpt-x1 R-botpt-y1)|#
    ;;calc-node-path-points also sets slot-value when node-pts-slot and interface
    (setf node1-pts
          (calc-node-path-points xpix1 ypix1 :interface interface :set-slot-value nil
                                 :width node-width
                                 :top-ht  top-ht :mid-ht mid-ht  :bot-ht bot-ht 
                                 :top-str-gap top-str-gap :L-str-gap L-str-gap ))

    #|       (multiple-value-bind (L-toppt-x2   L-toppt-y2   R-toppt-x2 R-toppt-y2 
                                         L-midpt-x2 L-midpt-y2 R-midpt-x2  R-midpt-y2
                                         L-botpt-x2 L-botpt-y2 R-botpt-x2 R-botpt-y2)|#
    ;;calc-node-path-points also sets slot-value when node-pts-slot and interface
    (setf node2-pts
          (calc-node-path-points xpix2 ypix2 :interface  interface :set-slot-value nil
                                 :width node-width :top-ht  top-ht :mid-ht mid-ht  :bot-ht bot-ht 
                                 :top-str-gap top-str-gap :L-str-gap L-str-gap ))


    ;;DRAW THE PATH
    (draw-cs-path interface output-pane node1-pts node2-pts pathtext 
                  :node1pt-type node1pt-type :node2pt-type node2pt-type
                  :celx1-n celx1-n :cely1-n cely1-n
                  :celx2-n celx2-n :cely2-n cely2-n
                  :path-type path-type
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
  "CS-net-view-Utils  RETURNS: (LIST (not values) L-toppt-x   L-toppt-y   R-toppt-x R-toppt-y  L-midpt-x L-midpt-y R-midpt-x  R-midpt-y L-botpt-x L-botpt-y R-botpt-x R-botpt-y)) IF set-slot-value = a slot-value symbol and interface sets that slot-value to LIST of above values. "
  (when (null xpix) (setf xpix 0))
  (when (null ypix) (setf ypix 0))

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



;;SET-NODE-XYLOCS-FROM-GROUPED-PCS
;;2019
;;ddd
(defun set-node-xylocs-from-grouped-pcs ( grouped-pcs
                                                &key (init-x 0)(init-y 0) 
                                                (return-changed-pcsyms-p T) )
  "U-net-view-Utils.   RETURNS list of pcsyms that have had :xyloc (x y) set.    INPUT:  grouped-pcs eg (((pcsym1 1)(pcsym2 1)(pcsym3 1))(( etc))). Where cely-n is nth group and celx-n is nth within a group. "
  (let*
      ((len-grouped-pcs (list-length grouped-pcs))
       (cely-n 0)
       (changed-pcsyms)
       )
    (loop
     for pcgroup in grouped-pcs
     for n from 1 to len-grouped-pcs
     do
     (incf cely-n)
     (let
         ((celx-n 0)
          )
       (loop
        for pclist in pcgroup
        do
        (let*
            ((pcsym (car pclist))
             )
          (set-symkeyval pcsym :xyloc (list celx-n cely-n))
          (when return-changed-pcsyms-p
            (setf changed-pcsyms (append changed-pcsyms (list pcsym))))
          ;;end lets,loops
      ))))
    changed-pcsyms
    ;;end let, set-node-xylocs-from-grouped-pcs
    ))
;; (set-node-xylocs-from-grouped-pcs '(((VALUEGROUPHAPPINES 1)(FLEXIBLE 1)(SEEKULTIMATETRUTH 1))((INTERPERSONALSKILL 2)(PRACTICAL 2))))
;; works= (VALUEGROUPHAPPINES FLEXIBLE SEEKULTIMATETRUTH INTERPERSONALSKILL PRACTICAL)
;; ALSO: PRACTICAL  =>  ("PRACTICAL" "PRACTICAL vs NOT PRACTICAL" CS2-1-1-99 NIL NIL :PC ("PRACTICAL" "NOT PRACTICAL" 1 NIL) :POLE1 "PRACTICAL" :POLE2 "NOT PRACTICAL" :BESTPOLE 1 (:BIPATH ((POLE1 NIL FARMER NIL) (POLE1 NIL ANGLOS NIL) (POLE2 NIL SALESPERSON NIL))) :va "0.833" :RNK 7.5 :XY-N (2 2) :XYLOC (0 2))






;;SELECT-NODE-PAIR-FROM-GROUPED-PCS
;;2019
;;ddd
(defun select-node-pair-from-grouped-pcs (celx1 cely1 celx2 cely2 grouped-pcs
                                                &key set-xyloc-keyval-p )
  "U-net-view-Utils.   RETURNS a selected pair of pcs (used for making node paths).   INPUT:  grouped-pcs eg (((pcsym1 1)(pcsym2 1)(pcsym3 1))(( etc))). Where cely-n is nth group and celx-n is nth within a group. "
  (let*
      ((group1 (nth cely1 grouped-pcs))
       (group2 (nth cely2 grouped-pcs))
       (node1 (nth celx1 group1))
       (node2 (nth celx2 group2))
       )
    (when set-xyloc-keyval-p
      (set-symkeyval (car node1) :xyloc (list celx1 cely1))
      (set-symkeyval (car node2) :xyloc  (list celx2 cely2))
      )
    (list node1 node2)
    ;;end let, select-node-pair-from-grouped-pcs
    ))
;;TEST
;;  (select-node-pair-from-grouped-pcs 0 0 0 1  '(((VALUEGROUPHAPPINES 1)(FLEXIBLE 1)(SEEKULTIMATETRUTH 1))((INTERPERSONALSKILL 2)(PRACTICAL 2))))
;; works = ((VALUEGROUPHAPPINES 1)  (INTERPERSONALSKILL 2))

;;    (set-key-value  :xyloc  '(0 0) 'VALUEGROUPHAPPINES :set-listsym-to-newlist-p T) = works


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




;;LIST-BY-VALUES-RANKS
;;2019
;;ddd
(defun list-by-values-ranks (  &key  )
  "   RETURNS    INPUT:  "
  (let
      ((x)
       )


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
    ))
;;TEST
;;













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


;;xxx ======================= KEEP FOR TEST? =================

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
          #|(capi:apply-in-pane-process output-pane 
                                      'draw-cs-path inst output-pane pathtext node1-slot node2-slot 
                                      :draw-ellipse-p draw-ellipse-p :path-type path-type
                                      :node1pt-type  node1pt-type  :node2pt-type node2pt-type)|#   
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
;; (setf kind3 '("KIND3" "KIND vs UKIND" CS2-1-1-99 NIL NIL :PC ("KIND" "UKIND" 1 NIL) :POLE1 "KIND" :POLE2 "UKIND" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)) :va "0.917" :RNK "3")   happy2  '("HAPPY2" "HAPPY vs UHAPPY" CS2-1-1-99 NIL NIL :PC ("HAPPY" "UHAPPY" 1 NIL) :POLE1 "HAPPY" :POLE2 "UHAPPY" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL FATHER NIL)) :va "1.000" :RNK "1")  logical '("LOGICAL" "LOGICAL vs NLOG" CS2-1-1-99 NIL NIL :PC ("LOGICAL" "NLOG" 1 NIL) :POLE1 "LOGICAL" :POLE2 "NLOG" :BESTPOLE 1 :BIPATH ((POLE1 NIL BEST-M-FRIEND NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL M-DISLIKE NIL)) :va "0.833" :RNK "1"))
;; (make-test-netviewer 500 500 300 300  :node1pt-type 'top :node2pt-type 'bot :draw-pc-node-sym1 'kind3 :draw-pc-node-sym2 'happy2)

