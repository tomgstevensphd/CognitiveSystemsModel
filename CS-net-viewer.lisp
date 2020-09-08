;;****************** CS-net-viewer.lisp ********************************
;;
;; NOTE: THESE FUNCTIONS ARE PRIMARILY FOR MAKING A GRAPHIC ILLUSTRATION OF A SYMBOL-TREE WITH NODES AND PATHS vs CSART TREE which 1. ATTEMPTS TO ROUGHLY ILLUSTSRATE BRAIN STRUCTURE with CSART NODES placed in approximate parts and 2. the CSART TREE does NOT SHOW PATHS (the path info is stored in the CSYMVALS). 
;;FROM 2019/04/11 
;;
;;==== MAIN NETVIEWER MANAGER & CREATOR FUNCTIONS ====
;;ALSO SEE: CS-netview-frames.lisp, CS-netview-Utils.lisp, U-CS.lisp
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

;;SIZE & SPEED OF VIEWING LARGE NUMBER OF NODES/PATHS
;; Make a large graphic pane & store in a file??
;;


;;WINDOW PARAMETERS
(defparameter *NetView-Interface-window-width 1400)
(defparameter *XPIX/X 1 "fixed num of x-axis pixels")
(defparameter *YPIX/Y 1 "fixed num of y-axis pixels")
(defparameter *XPIX  NIL "Used instead of X for x-axis. Fixed num of x-axis pixels")
(defparameter *YPIX  NIL "Used instead of Y for y-axis. Fixed num of y-axis pixels")
(defparameter *CELX   4 "L-top xpix of a cell") ;;was 10
(defparameter *CELY   8 "L-top ypix of a cell") ;;was 10
(defparameter *CELW   130 "Window SPACE for cell width in xpix") ;;was 140
(defparameter *CELH    80 "Window SPACE for cell height in xpix") ;;was 120
(defparameter *ROW-N   12 "num of cells in a row (across)")
(defparameter *COL-N   8 "num of cells in a column (up-down)")
(defparameter *N-ROWS  4 "num of rows in a FIELD")
(defparameter *N-COLS   12 "num of columns in a FIELD")
(defparameter *FIELDS-W   1 "number of FIELDS accross a space (eg window)")
(defparameter *FIELDS-H   1 "number of FIELDS high in a space (eg window)")

;;USE output-pane-cache-display to cache output display?
(defparameter *cache-netv-output-p T "Use output-pane-cache-display func to save output")
(defparameter *cache-netv-output-from-display-p NIL "If from display= T, only saves visible output?")

;;KEYS
(defparameter *pcvalkey :CSVAL)
(defparameter *rankey :CSRANK)





;;MAKE-CS-NETVIEWER
;;2018-02
;;ddd
(defun make-cs-netviewer (grouped-pcs &key (win-x 20) (win-y 20)
                                       (path-type :direct) (pre-order-by-rank-p T)
                                      (node-pts-slot 'node1-pts)
                                      (node-width 120) (top-ht 20)(mid-ht 20)(bot-ht 20) 
                                      (top-str-gap 10) (L-str-gap 4)
                                      (pathtext "PATHTEXT")
                                      (left-margin 20)(top-margin 10) ( xpix 0)  (ypix 0) 
                                      set-xy-n-p (init-celx-n 0)(init-cely-n 0)
                                      (elp-w 50)(elp-ht 20))
  "In CS-net-viewer. Makes a CS-net-view-interface. Grouped-pcs eg.= '(((happy 1)(kind 1)) etc.))); SET-XY-N-P sets :xy-n  window locations by group = cely-n; celx-n = nth in grouped-pcs.  :xyloc is the win (x y) pixels. xpix & ypix are origin (within L"
  (let
      ((inst (make-instance 'NetView-Interface :x win-x :y win-y ))
       (node-pts)
       (node-message "")
       (path-message "")
       (message "")
#|                                        (pathtext "PATH TEXT HERE")
                                    (node1pt-type 'mid) (node2pt-type 'mid)
                                    (node1-slot 'node1-pts)(node2-slot 'node2-pts)|#
       )

    ;;PRE-ORDER-BY-RANK-P
    (when pre-order-by-rank-p
      (setf grouped-pcs
            (sort-grouped-pcs-by-keyvalue :csrank grouped-pcs)))

    ;;PRE-SET THE XYLOCS?
    (when set-xy-n-p
      (set-node-xylocs-from-grouped-pcs grouped-pcs :xy-n :init-x init-celx-n :init-y init-cely-n))

      ;;SELECT THE PATHS TO DRAW
      ;; FOR NOW DO MANUALLY- SSSS FIND AN ALGO TO DO IT?
      ;;currently assumes that :xyloc key in pcsym is set (above?). Func can set them below.
   
      ;;SSSSS WRITE NEW FUNC FOR FINDING LINKS--USE HERE??
      (setf pcsym-pairs (list (select-node-pair-from-grouped-pcs 0 0 0 1 grouped-pcs)
                              (select-node-pair-from-grouped-pcs 0 1 1 1 grouped-pcs)
                              ))

    ;;MUST DISPLAY BEFORE CAN DRAW ON IT
    (capi:display inst)

    ;;SET SLOT VALUES TO PASS TO NODES AND PATHS
    (setf (slot-value inst 'node-pts-slot   ) node-pts-slot
          (slot-value inst 'grouped-pcs   ) grouped-pcs
          (slot-value inst 'path-type   ) path-type
          (slot-value inst 'node-width   ) node-width
          (slot-value inst 'top-ht   ) top-ht
          (slot-value inst 'mid-ht   ) mid-ht
          (slot-value inst 'bot-ht   ) bot-ht
          (slot-value inst 'left-margin   ) left-margin
          (slot-value inst 'top-margin   ) top-margin
          (slot-value inst 'top-str-gap   ) top-str-gap
          (slot-value inst 'L-str-gap   ) L-str-gap
          ;;for paths
          (slot-value inst 'pcsym-pairs   ) pcsym-pairs
          (slot-value inst 'xpix   ) xpix
          (slot-value inst 'ypix   ) ypix
          (slot-value inst 'elp-w   ) elp-w
          (slot-value inst 'elp-ht  ) elp-ht
          )

#|    (setf *xtest-val (slot-value inst 'grouped-pcs   ))
    (break "test-val")|#
    (sleep 0.2)
    
   ;; (with-slots (output-pane title-pane message-pane) inst
      ;;(break "grouped-pcs")
;; (place-pc-nodes-in-window
      ;;1. DRAW THE PANES IN THE WINDOW WITH NODES
#|      (capi:apply-in-pane-process output-pane      
                                  'place-pc-nodes-in-window inst output-pane node-pts-slot 
                                  grouped-pcs :path-type path-type
                                  :node-width node-width :top-ht top-ht :mid-ht mid-ht
                                  :bot-ht bot-ht :left-margin left-margin :top-margin top-margin
                                  :top-str-gap top-str-gap :L-str-gap L-str-gap)|#

      ;;(BREAK "before apply draw-pc-paths")
      ;;3. DRAW THE NODE PATHS
#|      (capi:apply-in-pane-process output-pane      
                                  'draw-pc-paths inst output-pane pcsym-pairs 
                                  :set-slot-value nil
                                   :path-type path-type
                                  :node-width node-width :top-ht top-ht :mid-ht mid-ht
                                  :bot-ht bot-ht :xpix xpix :ypix ypix
                                  :top-str-gap top-str-gap :L-str-gap L-str-gap
                                  :elp-w elp-w :elp-ht elp-ht)|#

     ;;end with-slots, let,make-cs-netviewer
    ))
;; 




;;NETVIEWER-DISPLAY-CALLBACK
;;2019
;;ddd
(defun netviewer-display-callback (output-pane x y width height) 
  "   RETURNS    INPUT:  "
  ;;(declare (ignore  x y width height))
  (let*
      ((inst (capi:top-level-interface output-pane))
       (node-pts-slot (slot-value inst 'node-pts-slot )) 
       (grouped-pcs  (slot-value inst 'grouped-pcs )) 
       (path-type  (slot-value inst 'path-type )) 
       (node-width  (slot-value inst 'node-width )) 
       (top-ht  (slot-value inst 'top-ht )) 
       (mid-ht  (slot-value inst 'mid-ht )) 
       (bot-ht  (slot-value inst 'bot-ht )) 
       (left-margin  (slot-value inst 'left-margin )) 
       (top-margin  (slot-value inst 'top-margin )) 
       (top-str-gap  (slot-value inst 'top-str-gap )) 
       (L-str-gap  (slot-value inst 'L-str-gap )) 
       ;;for paths
       (pcsym-pairs   (slot-value inst 'pcsym-pairs )) 
       (xpix X) ;;  (slot-value inst 'xpix )) 
       (ypix Y) ;; (slot-value inst 'ypix )) 
       (elp-w  (slot-value inst 'elp-w )) 
       (elp-ht  (slot-value inst 'elp-ht)) 
       (scroll-dx x)
       (scroll-dy y)
       )
    ;;ADD THE NODES TO WINDOW
    (place-pc-nodes-in-window inst output-pane node-pts-slot 
                                  grouped-pcs :path-type path-type
                                  :node-width node-width :top-ht top-ht :mid-ht mid-ht
                                  :bot-ht bot-ht :left-margin left-margin :top-margin top-margin
                                  :top-str-gap top-str-gap :L-str-gap L-str-gap
                                  :scroll-dx scroll-dx :scroll-dy scroll-dy)

    ;;PUT A COPY OF OUTPUT IN CACHE?
#|    (when *cache-netv-output-p
      (capi:output-pane-cache-display output-pane *cache-netv-output-from-display-p))|#
    ;;NOTE: WHEN REDRAW,
    ;; ==> USE (OUTPUT-PANE-DRAW-FROM-CACHED-DISPLAY pane x y width height)?

    ;;IS THIS PART OF PLACE-PC  ????? IF NOT NEED SCROLL-DX DY HERE TOO
    (break "Before draw-pc-paths")
    (draw-pc-paths inst output-pane pcsym-pairs 
                                  :set-slot-value nil
                                   :path-type path-type
                                  :node-width node-width :top-ht top-ht :mid-ht mid-ht
                                  :bot-ht bot-ht :xpix xpix :ypix ypix
                                  :top-str-gap top-str-gap :L-str-gap L-str-gap
                                  :elp-w elp-w :elp-ht elp-ht)

    ;;end let, netviewer-display-callback
    ))
;;TEST
;;SSSSSS START TESTING make-cs-netviewer
;;------------- PARTIAL/SMALLER N-PCs TEST ------------------------------
;;FIRST LOAD USER DATA (if not loaded) 
;;USING TEST DATA WITH MORE LINKS
;; (load-eval-syms&vals "C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\CS-netviewer-test-data.lisp")   
;; (MAKE-CS-NETVIEWER '((CAREFOROTHERSX INTIMATEX FLEXIBLEX CASUALX IMPULSIVEx  ENTERTAINERX  INSPIREOTHERSX)( MOTHERX FATHERX  BEST-M-FRIENDX BEST-F-FRIENDX)))




;;USING REAL DATA
;; (LOAD-USER-CSQ-DATA "C:/3-TS/LISP PROJECTS TS/CogSysOutputs/Tom-AllData2019-03.lisp")
;; OLD: NOT NEEDED WITH PRE-SORT ALL THE PCS?
;;  1. (setf **pcs-by-value&rank (sort-pcs-by-value&rank  *file-pcsyms))

;; SSSSS START HERE -- MAKE VIEWER SLIDE BARS, ADD PATHS
;; SMALLER, TEST LIST:
;; ;; (MAKE-CS-NETVIEWER  '(((VALUEGROUPHAPPINES 1)(FLEXIBLE 1)(SEEKULTIMATETRUTH 1))((INTERPERSONALSKILL 2)(PRACTICAL 2))))
;; =WORKS!!
;;  ;; ;; (MAKE-CS-NETVIEWER  '((VALUEGROUPHAPPINES CAREABOUTOTHERSFEE CAREFOROTHERS  ENLIGHTENWORLD SPREADKNOWLEDGE SPIRITUALINTEGRATI SEEKULTIMATETRUTH HIGHIMPACT )   (GREATLEADER INSPIREOTHERS LOVEX INDUSTRIOUS PERFORMANCE-ORIENT FLEXIBLE INTIMATE LIBERALCHRISTIAN EXUBERANT) ))   

;; ;; (MAKE-CS-NETVIEWER  '(((VALUEGROUPHAPPINES "0.917" 1) (CAREABOUTOTHERSFEE "0.917" 2) (CAREFOROTHERS "0.917" 3) (ENLIGHTENWORLD "0.917" 4) (SPREADKNOWLEDGE "0.917" 4.5) (SPIRITUALINTEGRATI "0.917" 5) (SEEKULTIMATETRUTH "0.917" 6) (HIGHIMPACT "0.917" 7))   ((GREATLEADER "0.750" 1) (INSPIREOTHERS "0.750" 2) (LOVEX "0.750" 4) (INDUSTRIOUS "0.750" 5) (PERFORMANCE-ORIENT "0.750" 6) (FLEXIBLE "0.750" 7) (INTIMATE "0.750" 7.5) (LIBERALCHRISTIAN "0.750" 8) (EXUBERANT "0.750" 8) )               ((STARPERFORMER 0.5 1) (PUBLICSERVANT 0.5 2) (PEOPLE-JOB 0.5 3) (PERFORMER 0.5 4) (CASUAL 0.5 5) (FANTASYWORLD 0.5 6) (SEEKATTENTION 0.5 7) (UNBRIDLEDHUMOR 0.5 7) (CATHOLIC 0.5 8) )          ((EUROCENTRICVALUES "0.667" 1) (PHYSICALWELLBEING "0.667" 2) (EGOTISTICAL "0.667" 3) (LESSWEALTH "0.667" 3.5) (CREATENEWRULES "0.667" 4) (BEHAVIORALPSYCH "0.667" 5) (GREATSPEAKER "0.667" 6) )                 ((DEEPUNDERSTANDPEOP "0.833" 1) (FIGHTILLNESS "0.833" 2) (HIGHSTANDARDS "0.833" 2) (MISSIONSPREADPSYCH "0.833" 2) (DEMOCRATICLEADER "0.833" 3) (HIGHLYEDUCATED "0.833" 4) (CONFIDENT-SELF-EST "0.833" 5) (HELPER "0.833" 5.5) (RATIONAL "0.833" 6) (INTIMATELYASSERTIV "0.833" 6) (PRAGMATIC "0.833" 7)  (LESSCIVILIZED "0.833" 8))) )
;;   extra line   ((GROUPKNOWLEDGEWORK "0.583" 1) (TEACHER1 "0.583" 2) (PROFESSIONAL "0.583" 3) (PSYCHOLOGISTS "0.583" 3) (PSYCHOLOGIST "0.583" 3.5) (COUNSELORS "0.583" 4) (LEGALEXPERT "0.583" 5) (OWNER "0.583" 6) (REPRESENTGROUP "0.583" 7) )))
;;
;;  ;; ;; (MAKE-CS-NETVIEWER  '(((CAREFOROTHERS 1)( INTIMATE FLEXIBLE CASUAL 1)(  EGOTISTICAL 1)(  EXUBERANT 1)) (( NOTTHEORIST 2)(  LOVEX 2)(  LOVEDANCE 2)(  HELPINGCAREER 2)(  HIGHIMPACT 2)(  PSYCHOLOGISTS 2))(( UNDERSTANDING 3)(  IMPULSIVE 3)(  ENTERTAINER 3)( AGGRESSIVE 3)( PATERNAL 3)( CAREABOUTOTHERSFEE 3))(( INSPIREOTHERS 4)( BESTFRIEND 4)( DIRECT-HONEST 4)( UNBRIDLEDHUMOR 4))))   => WORKS
;; 
;; xxx ----------------- FULL TOM DATA TEST (all Tom PCs) ---------------------
;;
;;FIRST LOAD USER DATA (if not loaded) 
;; (LOAD-USER-CSQ-DATA "C:/3-TS/LISP PROJECTS TS/CogSysOutputs/Tom-AllData2019-03.lisp")
;; PRE-SORT ALL THE PCS?
;;  1. (setf **pcs-by-value&rank (sort-pcs-by-value&rank  *file-pcsyms))
;; works= (((VALUEGROUPHAPPINES "0.917" 1) (CAREABOUTOTHERSFEE "0.917" 2) (CAREFOROTHERS "0.917" 3) (ENLIGHTENWORLD "0.917" 4) (SPREADKNOWLEDGE "0.917" 4.5) (SPIRITUALINTEGRATI "0.917" 5) (SEEKULTIMATETRUTH "0.917" 6) (HIGHIMPACT "0.917" 7) (DIRECT-HONEST "0.917" 8) (HIGHINTELLIGENCE "0.917" 9) (AUTONOMOUS "0.917" 10) (OPTIMISTIC "0.917" 11) (SELF-DISCIPLINE "0.917" 12) (ESPOSECHRISTIAN "0.917" 13) (PROGRESSIVE "0.917" 14) (SOLVEPROBLEMS "0.917" 15) (CRUEL "0.917" 16) (ATHLETIC "0.917" 17) (HELPINGCAREER "0.917" 18)) ((GREATLEADER "0.750" 1) (INSPIREOTHERS "0.750" 2) (LOVEX "0.750" 4) (INDUSTRIOUS "0.750" 5) (PERFORMANCE-ORIENT "0.750" 6) (FLEXIBLE "0.750" 7) (INTIMATE "0.750" 7.5) (LIBERALCHRISTIAN "0.750" 8) (EXUBERANT "0.750" 8) (EMPATHETICLISTENER "0.750" 9) (PLAYFUL "0.750" 10) (INFLUENCIAL "0.750" 11) (COGNITIVEPSYCHS "0.750" 12) (MATERIALISTIC "0.750" 13) (NOTANALYTIC "0.750" 14) (INDIVIDUALISTIC "0.750" 15) (SKILLEDMOVEMENTS "0.750" 16) (VERBALSKILLS "0.750" 16) (LAWFUL "0.750" 17) (CLOSE "0.750" 18) (NOTHISTORY-ORIENTE "0.750" 19) (RESPECTED "0.750" 20) (SOCIALCONSTRAINTS "0.750" 21) (COURTEOUS "0.750" 22) (PATERNAL "0.750" 23)) ((STARPERFORMER 0.5 1) (PUBLICSERVANT 0.5 2) (PEOPLE-JOB 0.5 3) (PERFORMER 0.5 4) (CASUAL 0.5 5) (FANTASYWORLD 0.5 6) (SEEKATTENTION 0.5 7) (UNBRIDLEDHUMOR 0.5 7) (CATHOLIC 0.5 8) (CRITICAL 0.5 9)) ((EUROCENTRICVALUES "0.667" 1) (PHYSICALWELLBEING "0.667" 2) (EGOTISTICAL "0.667" 3) (LESSWEALTH "0.667" 3.5) (CREATENEWRULES "0.667" 4) (BEHAVIORALPSYCH "0.667" 5) (GREATSPEAKER "0.667" 6) (MANAGER0 "0.667" 7) (HIGHSTATUS "0.667" 8) (HUMOROUS "0.667" 10) (NOTLOYAL "0.667" 10.5) (SEXY "0.667" 11) (LOVEDANCE "0.667" 12) (ENFORCERULES "0.667" 13) (EMOTIONAL "0.667" 13) (DEPENDGOV "0.667" 14) (SECULAR "0.667" 15) (MANUALWORK "0.667" 16) (SELF-DISCLOSE "0.667" 17)) ((DEEPUNDERSTANDPEOP "0.833" 1) (FIGHTILLNESS "0.833" 2) (HIGHSTANDARDS "0.833" 2) (MISSIONSPREADPSYCH "0.833" 2) (DEMOCRATICLEADER "0.833" 3) (HIGHLYEDUCATED "0.833" 4) (CONFIDENT-SELF-EST "0.833" 5) (HELPER "0.833" 5.5) (RATIONAL "0.833" 6) (INTIMATELYASSERTIV "0.833" 6) (PRAGMATIC "0.833" 7) (PRACTICAL "0.833" 7.5) (LESSCIVILIZED "0.833" 8) (CREATIVE "0.833" 8.5) (BESTFRIEND "0.833" 9) (GLOBALPERSPECTIVE "0.833" 10) (UNDERSTANDING4 "0.833" 11) (UNDERSTANDING "0.833" 11) (IMPULSIVE "0.833" 12) (INTERPERSONALSKILL "0.833" 12.5) (FUNCOMPANION "0.833" 13) (NOTTHEORIST "0.833" 14) (OVERCOMEDIFFICULTI "0.833" 14.5) (ENCOURAGING "0.833" 15) (GOODNEGOTIATOR "0.833" 16) (GREEDY "0.833" 17) (AGGRESSIVE "0.833" 17) (SEEKEXTERNALAPPROV "0.833" 18) (PETTY "0.833" 18) (PERSUASIVE "0.833" 19)) ((GROUPKNOWLEDGEWORK "0.583" 1) (TEACHER1 "0.583" 2) (PROFESSIONAL "0.583" 3) (PSYCHOLOGISTS "0.583" 3) (PSYCHOLOGIST "0.583" 3.5) (COUNSELORS "0.583" 4) (LEGALEXPERT "0.583" 5) (OWNER "0.583" 6) (REPRESENTGROUP "0.583" 7) (LOCALLEADER "0.583" 8) (ENTERTAINER "0.583" 9) (METICULOUS "0.583" 10) (CHARMING "0.583" 11) (SOFTSPOKEN "0.583" 12) (TEAMMATE "0.583" 13) (CHILDHOODFRIEND "0.583" 14) (SHOWBUSINESS "0.583" 15) (PROFIT-ORIENTED "0.583" 16) (DEBONAIRE "0.583" 17) (LESSMORALISTIC "0.583" 18) (DRAMATIC "0.583" 19) (RITUALISTIC "0.583" 20) (OCCUPATION "0.583" 21) (IMMIGRANTS "0.583" 22) (SEXDEVIANCE "0.583" 23)))
;;  2. (MAKE-CS-NETVIEWER **pcs-by-value&rank)
;; works

;; after loading above:
;; LIST PCSYMS=> 
;;  *ALL-PCSYMS = (CAREFOROTHERS INTIMATE FLEXIBLE CASUAL EGOTISTICAL EXUBERANT NOTTHEORIST LOVEX LOVEDANCE HELPINGCAREER HIGHIMPACT PSYCHOLOGISTS UNDERSTANDING IMPULSIVE ENTERTAINER AGGRESSIVE PATERNAL CAREABOUTOTHERSFEE INSPIREOTHERS BESTFRIEND DIRECT-HONEST UNBRIDLEDHUMOR FANTASYWORLD ATHLETIC ESPOSECHRISTIAN CRITICAL SEXDEVIANCE GLOBALPERSPECTIVE FUNCOMPANION SELF-DISCLOSE MISSIONSPREADPSYCH CRUEL COURTEOUS DEEPUNDERSTANDPEOP DEMOCRATICLEADER PSYCHOLOGIST METICULOUS COGNITIVEPSYCHS EMOTIONAL CHARMING VALUEGROUPHAPPINES LOCALLEADER HIGHLYEDUCATED ENLIGHTENWORLD PETTY ENCOURAGING HUMOROUS GREATLEADER CONFIDENT-SELF-EST INTERPERSONALSKILL INTIMATELYASSERTIV GREATSPEAKER AUTONOMOUS HIGHINTELLIGENCE GOODNEGOTIATOR PROGRESSIVE CLOSE PLAYFUL COUNSELORS INDUSTRIOUS SEXY UNDERSTANDING4 SOFTSPOKEN TEAMMATE BEHAVIORALPSYCH OPTIMISTIC CHILDHOODFRIEND DEBONAIRE HIGHSTANDARDS TEACHER1 LIBERALCHRISTIAN EMPATHETICLISTENER OVERCOMEDIFFICULTI FIGHTILLNESS PUBLICSERVANT SECULAR SEEKATTENTION HELPER SPREADKNOWLEDGE LAWFUL MANAGER0 PRAGMATIC GROUPKNOWLEDGEWORK VERBALSKILLS LESSCIVILIZED REPRESENTGROUP PERFORMER SHOWBUSINESS SOLVEPROBLEMS STARPERFORMER LESSWEALTH DEPENDGOV IMMIGRANTS PROFIT-ORIENTED OCCUPATION PHYSICALWELLBEING LEGALEXPERT SELF-DISCIPLINE ENFORCERULES CREATENEWRULES SOCIALCONSTRAINTS RESPECTED SEEKEXTERNALAPPROV CREATIVE RITUALISTIC LESSMORALISTIC PROFESSIONAL DRAMATIC EUROCENTRICVALUES INDIVIDUALISTIC CATHOLIC PEOPLE-JOB GREEDY OWNER PERFORMANCE-ORIENT HIGHSTATUS RATIONAL PRACTICAL PERSUASIVE INFLUENCIAL MANUALWORK NOTHISTORY-ORIENTE NOTANALYTIC NOTLOYAL SPIRITUALINTEGRATI SEEKULTIMATETRUTH MATERIALISTIC SKILLEDMOVEMENTS)
;; 



     #|((interface (capi:top-level-interface pane))
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
       (pathtext (slot-value interface 'pathtext))
       (path-type (slot-value interface 'path-type))
       )|#
    ;;(break "grouped-pcs")
   ;; (with-slots (output-pane title-pane message-pane) interface
    ;;  (break "grouped-pcs")
      ;;DRAW THE PANES IN THE WINDOW
#|      (capi:apply-in-pane-process output-pane      
                                  'place-pc-nodes-in-window interface output-pane node-pts-slot 
                                  grouped-pcs :path-type path-type
                                  :node-width node-width :top-ht top-ht :mid-ht mid-ht
                                  :bot-ht bot-ht
                                  :top-str-gap top-str-gap :L-str-gap L-str-gap)|#
   ;;   (break "node-pts-slot")
      ;;DRAW PC PATHS?  
      ;;DRAW FOR SOME? PC-PAIRS











;;XXX  OLDER-DELETE LATER?? ============================================
;; REPLACED BY INTEGRATING INTO MAKE-NET-VIEWER ETC.

;;NETVIEWER-DISPLAY-CALLBACK
;; REPLACED BY INTEGRATING INTO MAKE-NET-VIEWER ETC.
;;2018-02
;;ddd
#|(defun netview-display-callback (pane x y width height)
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
       (pathtext (slot-value interface 'pathtext))
       (path-type (slot-value interface 'path-type))
       )
    ;;(break "grouped-pcs")
    (with-slots (output-pane title-pane message-pane) interface
      (break "grouped-pcs")
      ;;DRAW THE PANES IN THE WINDOW
      (capi:apply-in-pane-process output-pane      
                                  'place-pc-nodes-in-window interface output-pane node-pts-slot 
                                  grouped-pcs :path-type path-type
                                  :node-width node-width :top-ht top-ht :mid-ht mid-ht
                                  :bot-ht bot-ht
                                  :top-str-gap top-str-gap :L-str-gap L-str-gap)
      (break "node-pts-slot")
      ;;DRAW PC PATHS?  SSSSS START HERE DRAWING PATHS
      ;;DRAW FOR SOME? PC-PAIRS
        (let*
            ((pc-list (car grouped-pcs))
             (pcpair1 (car pc-list))
             (pcpair2 (second pc-list))
             (pcsym1 (car pcpair1))
             (pcsym2 (car pcpari2))
             )
            ;;DRAW ONE PATH BETW pcsym1 pcsym2zas
                (capi:apply-in-pane-process output-pane
                                            'draw-pc-path interface output-pane pcsym1 pcsym2  
                               :set-slot-value T  :path-type path-type
                              :node-width node-width :xpix xpix :ypix ypix
                              :top-ht top-ht :mid-ht mid-ht :bot-ht bot-ht  :top-str-gap top-str-gap
                              :L-str-gap L-str-gap :elp-w elp-w :elp-ht elp-ht)
                                            
#|   NO-use draw-pc-path which uses draw-cs-path
                                   'draw-cs-path interface output-pane pathtext
                                      node1-slot node2-slot 
                                      :node1pt-type  node1pt-type  :node2pt-type node2pt-type)   |#
      ;;(draw-cs-path
      ;;needed for time to set slot-value in above apply-in-pane-process
      (sleep 1)

      ;;end pc-pair let
      )

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
    ;;end let, netview-display-callback
    ))|#




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
;; (setf kind3 '("KIND3" "KIND vs UKIND" CS2-1-1-99 NIL NIL :PC ("KIND" "UKIND" 1 NIL) :POLE1 "KIND" :POLE2 "UKIND" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)) :va "0.917" :RNK "3")   happy2  '("HAPPY2" "HAPPY vs UHAPPY" CS2-1-1-99 NIL NIL :PC ("HAPPY" "UHAPPY" 1 NIL) :POLE1 "HAPPY" :POLE2 "UHAPPY" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL FATHER NIL)) :va "1.000" :RNK "1")  logical '("LOGICAL" "LOGICAL vs NLOG" CS2-1-1-99 NIL NIL :PC ("LOGICAL" "NLOG" 1 NIL) :POLE1 "LOGICAL" :POLE2 "NLOG" :BESTPOLE 1 :BIPATH ((POLE1 NIL BEST-M-FRIEND NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL M-DISLIKE NIL)) :va "0.833" :RNK "1"))
;; (make-test-netviewer 500 500 300 300  :node1pt-type 'top :node2pt-type 'bot :draw-pc-node-sym1 'kind3 :draw-pc-node-sym2 'happy2)



;;NET-VIEWER VERSION NOT USING DISPLAY-CALLBACK TO DRAW NODES & PATHS
#|(defun make-cs-netviewer (grouped-pcs &key (win-x 20) (win-y 20)
                                       (path-type :bezier)
                                      (node-pts-slot 'node1-pts)
                                      (node-width 120) (top-ht 20)(mid-ht 20)(bot-ht 20) 
                                      (top-str-gap 10) (L-str-gap 4)
                                      (pathtext "PATHTEXT")
                                      (left-margin 20)(top-margin 10) ( xpix 0)  (ypix 0) 
                                      set-xy-n-p (init-celx-n 0)(init-cely-n 0)
                                      (elp-w 50)(elp-ht 20))
  "In CS-net-viewer. Makes a CS-net-view-interface. Grouped-pcs eg.= '(((happy 1)(kind 1)) etc.))); SET-XY-N-P sets :xy-n  window locations by group = cely-n; celx-n = nth in grouped-pcs.  :xyloc is the win (x y) pixels. xpix & ypix are origin (within L"
  (let
      ((inst (make-instance 'NetView-Interface :x win-x :y win-y ))
       (node-pts)
       (node-message "")
       (path-message "")
       (message "")
#|                                        (pathtext "PATH TEXT HERE")
                                    (node1pt-type 'mid) (node2pt-type 'mid)
                                    (node1-slot 'node1-pts)(node2-slot 'node2-pts)|#
       )

    ;;PRE-SET THE XYLOCS?
    (when set-xy-n-p
      (set-node-xylocs-from-grouped-pcs grouped-pcs :xy-n :init-x init-celx-n :init-y init-cely-n))


    ;;MUST DISPLAY BEFORE CAN DRAW ON IT
    (capi:display inst)
    
    (with-slots (output-pane title-pane message-pane) inst
      ;;(break "grouped-pcs")
;; (place-pc-nodes-in-window
      ;;1. DRAW THE PANES IN THE WINDOW WITH NODES
      (capi:apply-in-pane-process output-pane      
                                  'place-pc-nodes-in-window inst output-pane node-pts-slot 
                                  grouped-pcs :path-type path-type
                                  :node-width node-width :top-ht top-ht :mid-ht mid-ht
                                  :bot-ht bot-ht :left-margin left-margin :top-margin top-margin
                                  :top-str-gap top-str-gap :L-str-gap L-str-gap)

      ;;2. SELECT THE PATHS TO DRAW
      ;; FOR NOW DO MANUALLY- SSSS FIND AN ALGO TO DO IT?
      ;;currently assumes that :xyloc key in pcsym is set (above?). Func can set them below.
      (setf pcsym-pairs (list (select-node-pair-from-grouped-pcs 0 0 0 1 grouped-pcs)
                              (select-node-pair-from-grouped-pcs 0 1 1 1 grouped-pcs)
                              ))

      ;;(BREAK "before apply draw-pc-paths")
      ;;3. DRAW THE NODE PATHS
      (capi:apply-in-pane-process output-pane      
                                  'draw-pc-paths inst output-pane pcsym-pairs 
                                  :set-slot-value nil
                                   :path-type path-type
                                  :node-width node-width :top-ht top-ht :mid-ht mid-ht
                                  :bot-ht bot-ht :xpix xpix :ypix ypix
                                  :top-str-gap top-str-gap :L-str-gap L-str-gap
                                  :elp-w elp-w :elp-ht elp-ht)

     ;;end with-slots, let,make-cs-netviewer
    )))|#






 
