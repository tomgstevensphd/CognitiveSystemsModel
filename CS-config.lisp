;;************************** CS-config.lisp **************************
;;
;;OVERALL CogSys Model CONFIG FILE
;; (CSQ CONFIGS ARE IN CSQ-config.lisp)

;;  NOTE: GENERALLY LOAD THIS FILE FROM CSQ-MANAGE.LISP (GOCSQ T)
;;
(defparameter *n-bot-CSs 5 "Bottom level instances in tree. Can be changed")
(defparameter *n-out-CSs 1 "Bottom level instances in tree. Can be changed")
(defparameter *default-csart-rootstr "CS" "Default rootstr for the CS-ART network skeleton tree")
(defparameter *init-CSart-dims  '(1 1 1 1) "Default beginning dims for adding CS nodes to existing (or created on fly) CSart nodes")
(defparameter *cur-CSart-dims *init-CSart-dims "Current dims for adding CS nodes to existing (or created on fly) CSart nodes. Modified as needed.")
(defparameter *init-CSart-elment-dims '(1 1 1 99) "Initial dims for adding element nodes to existing (or created on fly) CSart nodes. Modified as needed.")
(defparameter  *cur-CSart-elment-dims  *init-CSart-elment-dims  "Current dims for adding CS ELEMENTS to existing (or created on fly) CSart nodes. Modified as needed.")
(defparameter  *cs-init-ran-p NIL "Indicates function cs-init was run after this compilation.")
(defparameter *cs-elm-rootsr "ELM" "Rootstr for art element network")
(defparameter *make-elmsyms-in-CSQ-INIT-p T )

;;FOR KEEPING TRACK OF CSYMS (and DB-CSYMS)
(defparameter  *ALL-CSYMS NIL "MAKE-CSYM adds new csyms to this list")
(defparameter  *ALL-STORED-CSYMS NIL "STORE-IN-CSDBSYM adds new csyms to this list--usually *DB syms")


;;USING FIND-SYMBOL MUST TYPE ALL CAPS FOR SYMBOL NAME
;;(find-symbol "ART-multipane-interface" 'common-lisp-user)=> WORKS
;;LOAD ART3 FILES (unless already loaded)
#|(unless (or (and (boundp '*load-ART3-files-p) (null *load-ART3-files-p))
            (find-symbol "ART-MULTIPANE-INTERFACE" 'common-lisp-user))
  (load-ART3-files))|#

;;Sets curser and other Editor variables
(my-config-editor-after-start)
;
;; LATER?? Define a separate name space package for this software module??
;;(make-package :ART)   ;; optional
;;(export '(ART ART-postprocess ART-init)  :cg-user)  ;; optional


;;------------------------- SOME PARAMETERS (OTHERS LATER) ----------
(defparameter *print-details  0  "*print-detail= 1 less than = 2, w/in do loops 3." )
(defparameter  *num-cs-qvar-elms 0 "Calc in cs-init function, num of qvars")
(defparameter *load-treeview-files T)
;;(defparameter *fout-reset-info T "Outputs a fout window with all reset info")
;;done below (defparameter *learnPatterns-cycles 10)
;;done below (setf  **n-inputs 5 **n-outputs 3)

;;ART GLOBAL PARAMETERS
;;(defparameter *n-inputs 9 "Number of input nodes (F1,F2 nodes/layer)")
;;(defparameter *n-outputs 7 "Number of output nodes (F3 nodes/layer)") ;;was 5
;;ART CYCLE PARAMETERS
;;(defparameter *art-overall-cycle-n 0 "TOTAL number of cycles run")
;;(defparameter *n-art-overall-cycles 0 "TOTAL number of cycles.")
;;(defparameter *n-pattern-set-cycles  1 "Total number of times current pattern set will be run")
;;(defparameter  *pattern-set-cycle-n 0 "Run number for current pattern set")
;;(defparameter *n-pattern-cycles  5  "Num of cycles within each RUN-ART-PATTERN-CYCLE run (or car of each pattern)")  ;;for ART2 didn't have 5 STM cycles 10) ;;was 20
;;(defparameter *n-patterns 0 "Number of  items/patterns in pattern list")
;;(defparameter *pattern-n 0 "In pattern list set, this is pattern-n")
;;(defparameter *pattern-cycle-n 0  " pattern cycle within RUN-ART-PATTERN-CYCLE")
;;(defparameter  *n-cycles-per-tdelta 2 "Completes this many cycles of F1-F3 runs including update-weights in run-art-pattern-cycle. Grossberg used 5.")
;;(defparameter  *tdelta-cycle-n 0 "t-delta time cycle within *n-cycles-per-tdelta")
;;(defparameter *time 0 "Current time, incremented in run-art-pattern-cyle by *delta-t")
;;not used(defparameter  *test-reset-cycle-n 0 "Completes this many cycles of F1-F3 runs including update-weights between test-resets in run-art-pattern-cycle. Grossberg used 5.")
;;(defparameter  *run-random-test-p  NIL "SSS Check to see what this does in detail")
;;(defparameter  *ignore-n-pattern-cycles-p nil "Used with *run-random-test-p (or otherwise?) to prevent use of normal pattern sequencing including repeating pattern a certain number of times.")
;; ART3 FORMULA CALCULATION PARAMETERS ---------------
; Neuron size for plots:
(setq PEsize 18)
(setq PEsizem1 (- PEsize 1))
(setq PEsizep1 (+ PEsize 1))

;;MODEL DESIGN PARAMETERS
;;(defparameter *F3-all-or-none-competative-output-p T "Determines whether yi-3-3 is subject to all-or-none one-output competition or not" )
;;(defparameter *F1-all-or-none-competative-output-p T "Determines whether yi-3-1 is subject to all-or-none one-output competition or not" )
;;(defparameter *def-compet-val 0.01  "Default value for losing competitive nodes")

;;ON-CENTER, OFF-SURROUND COMPETITION
;;(defparameter *F3-compet-every-nth-time-interval  *n-cycles-per-tdelta "On-center, off-surround competition at F3 occurs every nth delta time interval cycle instead of only once every pattern-cycle")
;;(defparameter *test-compet-overall-cycle-nums-list NIL)
;;(defparameter  *F3L1-compet-p T "Causes competition inside F3-Cycle at F3,L1.")
;;(defparameter *recalc-F3L1xy-postreset-p nil  "Recalculate Xi-1-3 and yi-1-3 post reset IF there is a reset.")
;;(defparameter *recalc-yi-3-3-postcompet-p T "Recalculate xi-3-3 and yi-3-3 after F3 competion ON ONLY LAST PATTERN CYCLE (if nil, not at all).")

;;RESET
;;Where is reset checked and how often?
;;(defparameter  *reset-compare-layers 1 "Which F1 vs F2 layers to compare, 1 or 2?")
;;(defparameter  *F2-test-reset-p T "Reset tested after F2-cycle")
;;(defparameter  *F3-test-reset-p NIL "Reset tested after F2-cycle")
;;(defparameter  *test-reset-every-nth-pattern-cycle  *n-cycles-per-tdelta)-
;;(defparameter  *test-reset-every-nth-time-interval NIL)
;;(defparameter  *test-reset-overall-cycle-nums-list NIL)
;;Reset of ALL nodes in Field 1 and/or Field 2 to default *art-initial-x, y
;;(defparameter *reset-all-F1F2-p T "Reset all F1, F2 x-y nodes on reset")
;;(defparameter *reset-all-F1F2L1-p NIL "Reset all F1, F2 Layer 1 nodes on reset")
;;(defparameter *reset-all-F1F2L2-p NIL "Reset all F1, F2 Layer 1 nodes on reset")
;;(defparameter *reset-all-F3Layer-maxs-p T "Reset all F3 Layer max output nodes on reset")
;;Check which F3 Layer for max output?
;;(defparameter *find-yi-1-3-max-output-p NIL "Check yi-1-3 for max output to reset (either layer 1 or 3)")
;;(defparameter *find-yi-3-3-max-output-p  T  "Check yi-3-3 for max output to reset (either layer 1 or 3)")
;;Reset of ONLY the max nodes
;;(defparameter  *reset-F2-p  NIL "If T, reset Yi-2-2 when there is a reset wave.Only applies if only max values are reset.")
;;(defparameter  *reset-XI-1-3-p  NIL  "If T, reset Xi-1-3 when there is a reset wave.")
;;(defparameter  *reset-XI-2-3-p  NIL  "If T, reset Xi-2-3 when there is a reset wave.")
;;(defparameter  *reset-XI-3-3-p  NIL  "If T, reset Xi-2-3 when there is a reset wave.")

; MODEL CONSTANTS
;;(defparameter a 0.7 "LTM Weight parameter") ;;default= 0.5
;;(defparameter b 0.2 "v parameter")  ;;default= 0.2
;;(defparameter c  -1.0 "??" )   ;;default= -1.0
;;(defparameter d  0.6 "wUp and wdn parameter")  ;;default= 0.4
;;(defparameter e  0.04  "norm parameter?")  ;;default= 0.04
;;(defparameter theta 0.4 "f(x) Activation criteria in function G. Very important sharpening parameter.")  ;;default= 0.3
;;(defparameter *vigilance-multiplier 2.0  "In res= (* *vigilance-multiplier l2-norm-r)") ;;default = 2.0 ;;GR=3??
;;(defparameter *vigilance  0.9 "Sigmoid degree of match criteria, max 1.00")  ;;default= 0.94
                       ;;higher number may increase final output
;;(defparameter alpha 1.0 "LTM weight w parameter")  ;;default= 1.0

;;(defparameter *onCenterThreshold 0.25 "Threshold for F2 min y activity for on-center, off-surround. Watson used term resetThreshold")  ;;default= 0.05, Watson used term resetThreshold  
;;(defparameter *min-input-criteria  0.20 "Min input for testing x r mismatch for F2 reset.")
;;not used (defparameter  *v-activity-reset-criteria 0.20 "Threshold for mismatch betw p  and u  thru wdn to cause reset of y")
;;(defparameter  *min-g  0.02  "Min value of  (g  j *n-outputs) for updating wup")
;;(defparameter *reset-y-criteria 0.40 "y must be greater than this to cause on-center, off-") ;;;was 0.25)  
;;(defparameter  *def-nonresetnin-out-val 0  "Value resetnin or resetnout set to if NOT reset")
;;(defparameter  *def-resetnin-out-val  1.0  "Default value resetnin or resetnout set to if  reset. Normally set to res instead.")
;;(defparameter  *def-reset-xy-val 999  "Value to set x or y node to if RESET. IN CHOICE-RESET, Checks to see if 999, if so doesn't process it. IN DISTRIBUTED-RESET MODEL, set value to .0001?")
;;(defparameter   *def-y-testout-val 0.0001 "After test-xy-node-reset, the value returned when calc the dif layer x value")
;;INITIAL CONSTANTS, VAR VALUES, LATER MOVE TO CONFIG-ART3
;;ART3 PARAMETERS 
;;(defparameter *delta-t  0.1 "Time increment on each complete ART cycle" )
;;(defparameter *init-t  0.0  "Initial time")
;;Parameters from Grossberg Table 4.
;;(defparameter *p1-all  0.7 "Function g stm activity multipler for F1") ;;Gr 10.0
;;(defparameter *p2-all 2.0 "Function g stm activity multipler for F2") ;;Gr 10.0
;;(defparameter *p3-all 0.0001 "Function g stm activity multipler for F3")
;;(defparameter *p4-3 0.9 "G's p4c")
;;(defparameter *p5-all 0.1 "")
;;(defparameter *P6-all 1.0 "")
;;For Sigma and G
;;(defparameter *def-sigmoid-val 0.001 "Default value of sigmoid output if activity level not > theta criterion.")
;;(defparameter *def-g-val 0.001)

;;ART3 SIGNAL FUNCTIONS g1 g2 g3  (G: ga, gb, gc) from Grossberg Table 4.
;;F1, F2 Distributed
;;(defparameter *pd7-12 0.0001 "Function g stm activity criterion for F1-2 distributed output." )     ;; Gs Distr: p7a, p7b
;;(defparameter *pd8-12 0.3 "Function g stm activity criterion for F1-2 distributed output") 
    ;;F3 Distributed
;;(defparameter *pd7-3  "Function g stm activity criterion for F3 choice output") ;;Gs Choice:  p7c  =  1/ SqRt nc
;;(defparameter *pd8-3  0.3 "" )                 ;;Gs Choice: p8c  =  0.2
    ;;F3 Choice (all F1-2 are distributed?)
;;(defparameter *pc7-3   '(/ 1 (sqrt n3)) "MUST EVAL IT Function g stm activity criterion for F3 choice output")                ;;Gs Distr: p7c  =  1/ SqRt nc
;;(defparameter *pc8-3  0.2)                 ;;Gs: Distr: p8c  =  0.4

    ;; Distributed
    ;;          g (w)  =  {0                          ;if w <= p7  +  p8}
    ;;                        {(w  -  p7) / p8      ;if w  >  p7  +  p8}
#|          (cond
           ((<= w (pd7-all + pd8-all))
            (setf  g(w)  0))
           ((> w (pd7-all + pd8-all))
           (setf g(w)  (-  w  (/  pd7-all pd8-all)))))|#
      
    ;;Choice
    ;;          g (w)  =  {0                                ;if w <=  p7}
    ;;                        { (w  -  p7 / p8) Sq      ;if w  >   p7 }
#|             (cond
               ((<=  w   pc7-all)
                (setf w 0))
               ((>  w  pc7-all)
                (setf w (-  w  (expt (/  pc7-all  pc8-all) 2))))|#

;;(defparameter  *show-last-reset-vals-n 20 "Number of reset-vals in graph")

;;INITIAL ART3 VARIABLE VALUES
;;INITIAL X AND Y VALUES
;;(defparameter  *art-initial-x  0.01 "Initial value for all xi-l-f")
;;(defparameter  *art-initial-y  0.01 "Initial value for all yi-l-f")
;;INITIAL RANDOM HI-LO VALUES
;;(defparameter upLR 0.5 "wUp parameter")  ;;default= 0.12
;;(defparameter downLR 0.4 "wdn parameter")  ;;default= 0.12
;;(defparameter *p-wdn-floor -0.2 "My-floor value for (- pi wdnji)")
;;(defparameter *p-wup-floor -0.2 "My-floor value for (- pi wupij)")
;;(defparameter *wUpInitLo 0.40 "random init low value")
;;(defparameter *wUpInitHi  0.50 "random init high value. Must be not too small-grossberg.")
;;(defparameter *wDnInitLo 0.20 "random init low value. Must be SMALL-grossberg.");; was .20
;;(defparameter *wDnInitHi 0.40"random init high value") ;;was .4
;;for creating limits in ART3 variables-during processing (with my-floor-ceiling)
;;(defparameter *wt-floor  0.0001) ;;for both wup and wdn
;;(defparameter *wt-ceiling 1.00)  ;;for both wup and wdn
;;(defparameter *x-activity-floor -100)
;;(defparameter *x-activity-ceiling 1000)
;;(defparameter *y-output-floor -100)
;;(defparameter *y-output-ceiling 1000)
;;ART3 DATA TEXT
;;(defparameter *make-ART-cycle-data-text-p NIL "Make summary data text for each cycle")
;;(defparameter *ART-cycle-data-text nil "A list of  data text lists for each art cycle")
;;(defparameter *art-data-text nil "A list of more detailed data text lists.")

;;for initializing 1-dim values with zeroActivations function
;;zzz
;;;;(defparameter *1-dim-*n-inputs-sym-list  '((X-Activity  .01) (V  .01) (R  .01) (U  .01) (Q  .01) (P  .01) (W  .01))   ;;was '((X-Activity  .01) (V  .01) (R  .01) (U  .01) (Q  .01) (P  .01) (W  .01)))
;;;;(defparameter *1-dim-*n-outputs-sym-list  '((Y-Output  .01)(Temp  .01) (reset-Val 0) (reset nil) (reset-cntr 0) (Temp2  .01)))

;;FOR DRAWING GRAPHS ETC
;;(defparameter  *art-graph-points-syms-list  '(INPUTI-1-1 XI-2-2  YI-3-3 WUPI-3-2TOI-1-3  WDNI-1-3TOI-3-2   RESETNINI-2-2 RESETNOUTI-2-2) "The symbols that are graphed") ;;UUPI-3-2TOI-1-3 UDNI-1-3TOI-3-2  ) 
;;(defparameter  *sortdim-n2-syms  '(WUPI-3-2TOI-1-3) "Symbols to be sorted by sortdim-n = 2 for graphing")
;;(defparameter  *art-datatext-syms-list '(INPUTI-1-1 XI-2-2  YI-3-3 WUPI-3-2TOI-1-3  WDNI-1-3TOI-3-2   R RESETNINI-2-2 RESETNOUTI-2-2)  "Symbols used for datatext output") ;;UUPI-3-2TOI-1-3 UDNI-1-3TOI-3-2
;;was (input v-activity p wup wdn reset y-output)
;;(defparameter *make-art-graphs-p T "Must be T to create any kind of graph windows")
;;(defparameter *no-graph-p nil "Prevents any graph windows from being created")
;;(defparameter  *art-inst-counter 0 "Number of art graph window instances.")
;;(defparameter  *art-inst-name-root  "*art-inst-sym"  "Root name for making *art-inst-syms")
;;(defparameter  *art-inst-sym  nil  "New instance for each graph window, renewed for each runart")
;;(defparameter  *art-graph-win-counter 0 "Number of art graph window instances.")
;;(defparameter  *art-graph-win-root  "*art-graph-sym"  "Root name for making *art-inst-syms")
;;(defparameter  *art-graph-win-sym  nil  "New instance for each graph window, renewed for each runart")
;;(defparameter *graphing-symbols-list  *art-graph-points-syms-list) 
;;(defparameter  *art-graph-var-slots '(input-points  X-points    XI-2-2-POINTS  XI-L-3-points   YI-L-2-points  YI-L-3-points YI-3-3-POINTS RESETNINI-2-2-POINTS RESETNOUTI-2-2-POINTS   wup-points  wdn-points  ) "Slots in ART-instance for storing graph values") ;;uup-points  udn-points
;;(defparameter  *graph-every-x-overall-cycle  999 "Graphs every Xth cycle of *overall-cycle-n")
;;(defparameter  *graph-every-x-pattern-set-cycle  1  "Graphs every Xth cycle of *pattern-set-cycle-n")  
;;(defparameter *graph-every-x-pattern-cycle   *n-cycles-per-tdelta  "Graph every Xth cycle within a PATTERN run")  ;;was 1
;;(defparameter *graph-every-x-pattern-cycle-list  NIL " Was '(1   5  10) or '(1 2 3 4 5 6 7 8 9 10). ")
;;(defparameter *display-graphs-on-reset t  "Displays graphs when reset takes place")
;;(defparameter  *end-test-all-patterns-n 0 "Test all patterns n times at end")
;;(defparameter  *graph-end-tests-p T "If end-tests, then graph last end test pattern")
;;(defparameter *sort-wup-dim 2 "Graph wup points by dim-n (1 or 2)")
;;(defparameter *sort-wdn-dim 1  "Graph wdn points by dim-n (1 or 2)")
;;(defparameter *initial-x-pix 0)
;;(defparameter *initial-y-pix 0)
;;(defparameter *incr-x-pix 40)
;;(defparameter *v-activity-y-increment  1.0)    ;;was 10 ;;*x-activity-y-increment
;;(defparameter  *x-max 400)   ;;was 250
;;(defparameter *graph-last-cycle  T)
;;(defparameter *graph-color-list '(:red :blue :orange :green :black :yellow :lightblue :magenta :pink  :gray :violet :cyan1 :darkorchid :tomato :slateblue :salmon3 :mistyrose1 :brown ))
;;(defparameter *graph-sym-abrv-begin-n 3 "N begin digits when abreviate graph label on x-axis")
;;(defparameter *graph-sym-abrv-end-n 3 "N end digits on abrev label" )
;;(defparameter *setsym-2dim-nested-lists-p T "Puts 2-dim points in nested lists")

;;FOR DEBUGGING
(defparameter *out1 nil)
(defparameter *out2 nil)
(defparameter *out3 nil)



(defparameter *all-art-symbol-strings
  '("CS" "Input" "X" "Y" "R" "Wup" "Wdn"   "Y-Output"  "RESETNIN" "RESETNOUT" "RESET-COUNTER" "N-CATS" "TEMP" "TEMP2") "Symbol strings from ART3-init symbol-spec-list") ;;NO RESET "Uup" "Udn"
(defparameter *all-art-symbols
  '(CS Input X Y R P  Wup Wdn   Y-Output  RESETNIN  RESETNOUT RESET-COUNTER N-CATS TEMP TEMP2) ) ;;NO RESET Uup Udn
(defparameter *all-art-class-rootsyms
  '(CS Input X Y R P  Wup Wdn   Y-Output  RESETIN RESETNOUT  RESET-COUNTER N-CATS TEMP TEMP2) "Root syms that eval to  (root-str dim-specs-list [not dims lists] nil nil (topsym)) Egs dims-specs-list ((9 1 1)(3 1 1)(3 1 1))  topsym= XI-L-F") ;;Uup Udn


(defparameter *art-index-syms '(I L F M) "Symbols/letters used in art dim lists for making art symbols")
(defparameter *art-index-separator "-")
(defparameter *art-node-separator 'TO)
(defparameter *art-max-index  99 "Used when searching for bound artsyms.")
;;(defparameter *all-reset-syms  NIL "For convenience calculating if a var was reset. Set in ART3-init")

;;MUST BE DEFINED BEFORE CSQ-SHAQ-new-scales
(defparameter *MAKE-DEFS-FILE-P NIL "For making classes work in delivered version must use T. Load before CSQ-SHAQ-new-scales.")


;;LOAD-CS-FILES
;;
;;ddd
(defun load-CS-files ()
  ;;these should load in .lispworks
  (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-BASIC-functions.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-function-plotter.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-files.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-lists.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-debug.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-tstring.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-symbol-info.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-capi.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-math.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-clos.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-LW-editor.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-capi-buttons-etc.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-capi-input-interfaces.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-fonts.lisp")

  ;;FROM ART
  ;;(load "C:\\3-TS\\LISP PROJECTS TS\\SHAQ\\U-data-functions.lisp")
  ;;(load "C:\\3-TS\\LISP PROJECTS TS\\ART-Utilities\\ART-multipane-interface.lisp")
  ;;(load "C:\\3-TS\\LISP PROJECTS TS\\ART-Utilities\\U-art-math-utilities.lisp")
  ;;(load "C:\\3-TS\\LISP PROJECTS TS\\ART-Utilities\\ART-data-analysis.lisp")
  ;;(load "C:\\3-TS\\LISP PROJECTS TS\\ART-Utilities\\ART-inputs.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\ART-Utilities\\U-ART.lisp")

  ;;FROM SHAQ
  (load "C:\\3-TS\\LISP PROJECTS TS\\SHAQ\\help-info.lisp")

  ;;CogSys-Model files
  ;;Modifications? of ART files?
  ;;Config files
  ;;THIS FILE--DON'T LOAD IT FROM HERE
  ;;THIS FILE (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CS-config.lisp")
 ;;LOADED SEPARATELY
;; (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-config.lisp")

  ;;utility files
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\U-CS-ART.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\U-CS-symbol-trees.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\U-CS-data-results-functions.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\U-CS.lisp")
  ;;(load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\U-CSQ.lisp")

  ;;CS (CogSys) files
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CS-network.lisp")
  ;;model files
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CS-PERSIM.lisp")  
  ;;CSQ-SHAQ INIT FILE(S)
   (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-config.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-value-rank-frame.lisp")

  ;;Other CSQ-SHAQ joint files
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-SHAQ-new-scales.lisp")
  ;;only SHAQ (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-SHAQ-all-scale-and-question-var-lists.lisp")
 (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-SHAQ-Frames.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-SHAQ-Frame-quest-functions.lisp")

  ;;CSQ only files (not incl utility files)
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-Manage.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-QVARS.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-Questions.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-scales.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-frames-intros.lisp")
  ;;LOAD TREEVIEW FILES??
  (when *load-treeview-files
    (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-trees.lisp")
    (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CS-net-viewer.lisp")
    (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-capi.lisp")
    ;;(load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-capi.lisp")
   )
    
  
  (defparameter *CogSys-loaded-p T)

  ;;NOTE: NOT LOADED HERE, load it manually.
  )

;;LOAD THE CS FILES
 (when (OR 
           (or (null (boundp '*load-CS-files-p))
                    (and (boundp '*load-CS-files-p)
                   (null *load-CS-files-p)))
          (not (and (boundp '*CogSys-loaded-p)
              *CogSys-loaded-p)))
   (load-CS-files))


  ;;RUN HELP FUNCTIONS
  (when (null (boundp '*initial-help-functions))
   ;; DISPLAY A KEY BINDINGS WINDOW
  (my-keybinds)
   ;; DISPLAY A TEMPLATE WINDOW open in buffer 0-CODE-TEMPLATES.lisp
   (my-edit-file "C:/3-TS/LISP PROJECTS TS/CogSys-Model/0-CODE-TEMPLATES.lisp")
   ;; (pathnamep "C:/3-TS/LISP PROJECTS TS/CogSys-Model/0-CODE-TEMPLATES.lisp") = NIL
   (defparameter *initial-help-functions T)
   ;;end when  *intial-help-functions
  )



;;CS-INIT
;;
;;ddd
(defun CS-init (&key n-inputs n-outputs  (make-sublists-for-each-dim-p T)  
                            unbind-global-vars-p  return-flat-lists-p
                             ;;not needed?
                               prFefix)

  "In CS-config, initializes an ART3 network and creates strings, data lists, and arrays related to both running ART3 and analyzing and reporting it's data based upon lists. RETURNS (values new-symbol-type-list  new-symbols-type-list-of-lists  new-symbol-type-spec-list-of-lists  new-root-list  new-symbol-type-symbol-string-list-of-lists). GLOBAL VARS SET=  *new-seq-nested-lists  *new-symbol-nested-lists *new-dim-list-nested-lists) . Each symbol-type eval to a nested list of all its symbols. Each symbol evals to a spec-list eg."

;;FOR INITIALIZING THE ART3 NEURAL NETWORK
  (declare 
   (special 
    *cum-array-list *cum-inputs *cum-v-activity *cum-wdn *cum-wup  *cum-y-output *cum-reset-vals 
;;FOR THE GRAPHICS DATA DISPLAYS -----------------------------------
    ;;*n-dims
    ;;*value
    ;;*converted-arrays-list
    ;;*new-symbol-list
    *input-points
    ;; DO I WANT  XIL2F1M1 or XI-2-1-1?? FOR NOW SECOND
    *xi2-1-points   ;;was *v-points
    *wup-points
    *wdn-points
    ;;*uup-points
   ;; *udn-points
    *yi-3-3-points  ;; *y-points
    *resetnin-points
    *resetnout-points
    ;;*reset-points
    ;;cells
    *input-list
    *x-list
    *wup-list
    *wdn-list
    ;;*uup-list
    ;;*udn-list
    *y-list
   ;; *p-list
    *reset-list
    *ART3-instance
    ))

   (setf   
    *time 0
    *cum-inputs nil *cum-v-activity nil *cum-wdn nil 
    *cum-wup nil  *cum-y-output nil  ;;*cum-reset-vals nil
     *cum-resetnin-vals nil *cum-resetnout-vals nil
  ;; *n-dims 0
   ;;*value 0
   ;;*converted-arrays-list nil
   ;;*new-symbol-list nil
 #|  *input-points nil
   *p-points nil
   *wup-points nil
   *wdn-points nil
   ;;*uup-points nil
   ;;*udn-points nil
   *y-points nil
   ;;*reset-points nil
   *resetnin-points nil
   *resetnout-points  nil
   *input-list nil
   *x-list nil
   *wup-list nil
   *wdn-list nil
   *uup-list nil
   *udn-list nil
   *y-list nil
   *reset-list nil|#
   *ART3-instance nil
   )
;;EACH symbol-spec-list= (ROOT all-dims-spec-list  default-graph-slot-name. ALL-DIMS-SPEC-LIST= (sublist1 sublist2 etc).  Each dim sublist =  (n-elements begin-n/or/cur-dim-n  dim-incr  begin-str end-str. Eg. (\"root\" '((4 1 1 \"C\" \"F\")(3 1 1 \"C\" \"F\"))).

    ;;FIND *NUM-CS-QVAR-ELMS (for making art network)
    (loop
     for list in *all-PC-element-qvars     
     do
     (loop
      for sublist in list
      do
       (when (listp sublist)
         (incf *num-cs-qvar-elms))
       ;;end loops
       ))
    ;;VVV

;;KEYS: If set-global-vars-p, sets global * versions of all return vars. 
  (let 
      ((symbol-spec-lists
        `(
          (CSI-L-F-M    ("CS"  ((,*n-bot-CSs 1 1)(3 1 1)(2 1 1)(2 1 1))) CS-points)
          (ELMI-L-F-M    ("ELM"  ((,*num-cs-qvar-elms   1 1)(1 1 1)(1 1 1)(1 1 1))) CS-points)
          ;;test versions
          ;;(CCI-L-F-M    ("CC"  ((4 1 1)(3 1 1)(2 1 1)(2 1 1))) CC-points) ;; = works
          ;;(ZzMI-L-F-M  ("ZzM" ((4 1 1 )(3 1 1)(2 1 1 )(1 1 1))) ZzMI-L-2-1-points) ;;= works
          ;; (ZzI-L-F-M  ("Zz"  ((4 1 1 )(3 1 1)(2 1 1 )(1 1 1))) ZzI-L-2-1-points) ;;= works
          ;;(ZI-L-F-M    ("Z"    ((4 1 1 )(3 1 1)(2 1 1 )(1 1 1))) ZI-L-2-1-points) ;;= works
          ;;(ELMxI-L-F-M    ("ELMx"  ((3   1 1)(1 1 1)(1 1 1)(1 1 1))) CS-points)
          ;;(XI-L-F           ("X"      ((,4 1 1 )(3 1 1)(2 1 1 ))) X-points)
          ;;(YI-L-F-M          ("Y"    ((4 1 1 )(3 1 1)(2 1 1 )(1 1 1))) YI-L-2-1-points)
          ;;(BI-L-F          ("B"    ((4 1 1 )(3 1 1)(2 1 1 ))) BI-L-2-points)

          #|(INPUTI-L-F ("Input" ((,*n-inputs 1 1)(1 1 1 )(1 1 1)))  input-points)
          ;;NOTE: can reuse the top-syms, just chane the dim-specs and all instances are combined in the subsyms list with eg XI-L-F
          (XI-L-F           ("X"      ((,*n-inputs 1 1 )(3 1 1)(2 1 1 ))) X-points)       
          (XI-L-F           ("X"      ((,*n-outputs 1 1 )(3 1 1)(1 3 1 ))) XI-L-3-points)         
          (YI-L-F           ("Y"    ((,*n-inputs 1 1 )(3 1 1)(2 1 1 ))) YI-L-2-points)   
          (YI-L-F           ("Y"    ((,*n-outputs 1 1 )(3 1 1)(1 3 1 ))) YI-L-3-points)   
         ;; ("X-Activity" ((,*n-inputs 1 1 )) )  ;;was X-Activity
         ;; ("V-Activity" ((,*n-inputs 1 1 )) )  ;;V-Activity
          (RI-L-F  ("R" ((,*n-inputs 1 1 )(1 2 1)(1 2 1)) )) ;;used in RESET
          ;;("Q-Activity" ((,*n-inputs 1 1 )) )
          ;;not needed?? (PI-L-F  ("P"  ((,*n-inputs 1 1)(3 1 1 )(3 1 1)))  )
          ;; (var-root (fromcelldim fromfielddim  tocelldim tofielddim))   EACH DIM SPEC= (N  begin incr end-str) 
          (WUPI-L-FTOI-L-F  ("Wup" ((,*n-inputs  1 1)(1 3 1)(1 2 1   ) TO (,*n-outputs 1 1) (1 1 1   )(1 3 1 ))) wup-points)            ;;was ((,*n-inputs 1 1 ) (,*n-outputs 1 1) ))
          (WDNI-L-FTOI-L-F ("Wdn" ((,*n-outputs 1 1  )(1 1 1   )(1 3 1   )TO (,*n-inputs 1 1  )(1 3 1  )(1 2 1 ))) wdn-points)
          ;;(UUPI-L-FTOI-L-F ("Uup" ((,*n-inputs 1 1)(1 3 1  )(1 2 1 )TO (,*n-outputs 1 1   )(1 1 1   )(1 3 1 ))) uup-points)        
          ;;(UDNI-L-FTOI-L-F ("Udn" ((,*n-outputs 1 1  )(1 1 1   )(1 3 1   ) TO (,*n-inputs 1 1  )(1 3 1  )(1 2 1 ))) udn-points)
         ;; ("Y-Output" ((,*n-outputs 1 1)) )
          ;;others
         ;;("Temp" ((1 1 1 )) )
         (RESETNINI-L-F ("resetnin" ((,*n-inputs 1 1  )(1 2 1 ) (2 2 1 ))) resetnin-points)
         (RESETNOUTI-L-F ("resetnout" ((,*n-outputs 1 1  )(1 2 1 ) (2 2 1 ))) resetnout-points)
          ;;was (RESETI-L-F ("reset" ((,*n-inputs 1 1  )(1 2 1 ) (2 2 1 ))) reset-points)
          ;;for ART3 F2
          ;;SSS  CHECK CREATION OF THE SYMVALS ETC
          ;;(RESET-NINPUTSI  ("reset-ninputs" ((,*n-inputs 1 1))))
          ;;for ART3 F3
          ;;(RESET-NOUTPUTSI ("reset-noutputs" ((,*n-outputs 1 1)) ))
          (RESET-CNTRI-L-F ("reset-cntr" ((,*n-outputs 1 1)(1 2 1)(1 2 1) )))
      |#  ;;  (N-CATSI ("n-cats" ((,*n-outputs 1 1 ))))   ;;was(1 2 1)) )
          ;;("Temp2" ((,*n-outputs 1 1 ))))  ;;was(1 2 1)) )
          ;;end list, symbol-spec-lists
          ))

       ;;other let vars
       (n-symbol-types)
       (dims-list)

       ;;for spec lists
       (ncells1) ;; =  (length spec-list1)
       (dims-lists1) ;; =  (second (car spec-list1))
       (n-dims1) ;;= (length dims-lists1)

       ;;for return values
       (all-root-syms)
       (all-node-trees-syms)
       (all-path-syms-by-levels)
       ;;(new-symbol-type-list)
       ;;(new-symbols-type-list-of-lists)
       ;;(new-symbol-type-spec-list-of-lists)
       ;;(new-root-list)
       ;;(new-symbol-type-symbol-string-list-of-lists)
       ;;end let vars
       )
    (if (> *print-details 0)  (afout 'out (format nil "1 symbol-spec-lists= ~A~%" symbol-spec-lists)))

    ;; USING NEW FUNCTIONS??
    (multiple-value-setq  (all-root-syms all-node-trees-syms all-path-syms-by-levels)
        (make-dimsyms-trees  symbol-spec-lists))

    ;;SET THE SYMBOL-TYPE  =  (root-str dim-spec-list graph-slot default-value topsyms-list)
    ;;eg X  = ("X" ((5 1 1) (3 1 1) (3 1 1)) X-POINTS NIL ((XI-L-F)))
    ;;eg WUP = ("Wup" (((5 1 1) (1 3 1) (1 2 1)) TO ((3 1 1) (1 1 1) (1 3 1))) WUP-POINTS NIL (WUPI-L-FTOI-L-F))
    ;;old,was: (sym-root-str LIST OF INSTANCES)
    ;; eg. WDN = ((WDN1-1 ... WDN1-5) (WDN2-1 ...WDN2-5) (WDN3-1 ...WDN3-5))
    ;; The symbols were set to eg ("Wup" (2 4) 9) in a lower function
    ;; and the class symbol (eg. WUP set = ("Wup" ((WUP1-3-1TO1-1-2) (WUP1-3-1TO2-1-2) (WUP1-3-1TO3-1-2) (WUP2-3-1TO1-1-2) (WUP2-3-1TO2-1-2) (WUP2-3-1TO3-1-2) (WUP3-3-1TO1-1-2) (WUP3-3-1TO2-1-2) (WUP3-3-1TO3-1-2)))


    ;;ELMSYMS MADE IN CSQ-INIT

    ;;for convenience in calcs to check for reset
    (setf  *cs-init-ran-p T)
     ;;*all-reset-syms (find-bottom-art-instances 'reset))

   
   ;;note global versions with * in front also created for each value below
   (values all-root-syms all-node-trees-syms all-path-syms-by-levels)
    ;;was new-symbol-type-list  new-symbols-type-list-of-lists new-symbol-type-spec-list-of-lists  new-root-list)
    ;;end defun ART3-init
    ))