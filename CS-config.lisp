;;************************** CS-config.lisp **************************
;;
;;OVERALL CogSys Model CONFIG FILE
;; (CSQ CONFIGS ARE IN CSQ-config.lisp)


;;  NOTE: GENERALLY LOAD THIS FILE FROM CSQ-MANAGE.LISP (GOCSQ T)
;;
(defparameter *n-bot-CSs 5 "Bottom level instances in tree. Can be changed")
(defparameter *n-out-CSs 1 "Bottom level instances in tree. Can be changed")
(defparameter *default-csart-rootstr "$CS" "Default rootstr for the CS-ART network skeleton tree")
(defparameter *init-CSart-dims  '$CS "Default beginning dims for adding CS nodes to existing (or created on fly) CSart nodes")
(defparameter *cur-CSart-dims *init-CSart-dims "Current dims for adding CS nodes to existing (or created on fly) CSart nodes. Modified as needed.")
(defparameter *init-CSart-elment-dims NIL "Initial dims for adding element nodes to existing (or created on fly) CSart nodes. Modified as needed.")
(defparameter  *cur-CSart-elment-dims  *init-CSart-elment-dims  "Current dims for adding CS ELEMENTS to existing (or created on fly) CSart nodes. Modified as needed.")
(defparameter  *CS-ART-init-ran-p NIL "Indicates function CS-ART-init was run after this compilation.")
(defparameter *cs-elm-rootsr "ELM" "Rootstr for art element network")
(defparameter *make-elmsyms-in-CSQ-INIT-p T )

;;GLOBAL USER DATA VARS
(when *INITIALIZE-USER-DATA-VARS-P
;;FOR KEEPING TRACK OF CSYMS
(defparameter  *ALL-STORED-SYS-CSYMS NIL "STORE-IN-CSDBSYM adds new csyms used as basic CS SUBSYSTEM OR BRAIN CATS, ETC to this list--usually *DB syms") ;;N = 49 ;;was ($CS $EXC $TBV $WV $SLF $REFG $FAM $CSK $PS $DM $PLN $COP $RESN $BSK $PEOP $MECH $MAIN $KNW $NSC $SSC $BSC $ART $BUS $SPT $REC $LNG $MTH $EP $SCR $EVT $ELM $PER $OBJ $EMT $HAP $CAR $ANX $ANG $DEP $PCPT $VER $IMG $SOND $SML $TST $TCT $BND $MOT $MIS)
(defparameter   *CSQ-DATA-DIR "C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\"  "Main directory for storing USER CSQ DATA" )
(defparameter   *ALL-STORED-CSYMS-FILE "C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\all-stored-csyms-file.lisp" "A DATED file that store-csym uses to make lasting copies for all csyms it creates")
(defparameter   *CSQ-USER-CSYM-DATA-FILE "C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\CSQ-USER-CSYM-DATA.lisp" "A DATED USER file for permanent records OR later USER INPUT.")
(defparameter *ALL-NON-SYS-CSYMS NIL "NON-SYS csyms incls newlink-made-csyms")

;INITIALIZE CSYM-RELATED GLOBAL VARS SEPARATELY
(when *INITIALIZE-CSYM-GLOBAL-VARS-P  ;;-------------------------------------
(when (not (boundp  '*ALL-STORED-CSYMS))
(defparameter  *ALL-STORED-CSYMS NIL "Cum list of all stored CSYMS--NOT including  *ALL-STORED-SYS-CSYMS"))
(when (not (boundp  '*ALL-CSYMS))
(defvar *ALL-CSYMS NIL " ALL csyms from all sources?"))
(when (not (boundp  '*ALL-MAKE-CSYMS))
(defvar *ALL-MAKE-CSYMS NIL " ALL csyms from all sources?"))
(when (not (boundp  '*ALL-CSYMS))
(defvar *ALL-CSYMS NIL " ALL csyms from all sources?"))
(when (not (boundp  '*ALL-SCALE-CSYMS))
(defparameter *ALL-SCALE-CSYMS NIL "ALL csyms made from CSQ-SHAQ scales"))
(when (not (boundp  '*ALL-QVAR-CSYMS))
(defparameter *ALL-QVAR-CSYMS NIL " ALL csyms made from CSQ-SHAQ question (or multi-answer) variables."))
(when (not (boundp  '*ALL-CSARTLOC-SYMS))
(defparameter *ALL-CSARTLOC-SYMS NIL " ALL csartloc csyms. Appended in make-csym"))
(when (not (boundp  '*ALL-MAKE-CSARTLOC-SYMS))
(defparameter *ALL-MAKE-CSARTLOC-SYMS NIL " ALL csartloc csyms. Appended in make-csym"))
(when (not (boundp  '*ALL-CSARTLOC-SYMS&VALS))
(defparameter *ALL-CSARTLOC-SYMS&VALS NIL " ALL csartloc (csartsym csart-vals) lists. Appended in make-csym"))
(when (not (boundp  '*ALL-SPECIAL-CSYMS))
(defparameter *ALL-SPECIAL-CSYMS NIL " ALL csyms made from CSQ-SHAQ non-standard OR other special questions/input  variables OR from special ARGLISTS."))
(when (not (boundp  '*NEWLINK-MADE-CSYMS))
(defparameter *NEWLINK-MADE-CSYMS NIL "Csyms made during CS-EXPLORE,etc when making new CSLINKs. NOT already existing csms"))
(when (not (boundp  '*ALL-ELMSYMS))
(defparameter *ALL-ELMSYMS NIL))
(when (not (boundp  '*ALL-ELMSYMS&VALS))
(defparameter *ALL-ELMSYMS&VALS NIL))
(when (not (boundp  '*ALL-PCSYMS))
(defparameter *ALL-PCSYMS NIL))
(when (not (boundp  '*ALL-PCSYMS&VALS))
(defparameter *ALL-PCSYMS&VALS NIL))        
;;RESET *INITIALIZE-CSYM-GLOBAL-VARS-P
  (setf *INITIALIZE-CSYM-GLOBAL-VARS-P NIL)
;;end initialize csym-related global vars separately ------------------------
)
;;END *INITIALIZE-USER-DATA-VARS-P  ====================
)

;; replaces *ALL-CSDB-SUBSYMS in original CS-EXPLORE FUNC,etc

(defparameter *ALL-CS-EXPLORE-OUTPUTS NIL "Used by CS-Explore and to reinitualize All CS-Explore variables, can be unbound")

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
(defparameter  *num-cs-qvar-elms 0 "Calc in CS-ART-init function, num of qvars")
(defparameter *load-treeview-files T)

#|(when INITIALIZE-ART-GLOBAL-VARS-P
  ;;(defparameter *fout-reset-info T "Outputs a fout window with all reset info")
  ;;done below (defparameter *learnPatterns-cycles 10)
  ;;done below (setf  **n-inputs 5 **n-outputs 3)

  ;;ART GLOBAL PARAMETERS
  (defparameter *n-inputs 9 "Number of input nodes (F1,F2 nodes/layer)")
  (defparameter *n-outputs 7 "Number of output nodes (F3 nodes/layer)") ;;was 5
  ;;ART CYCLE PARAMETERS
  (defparameter *art-overall-cycle-n 0 "TOTAL number of cycles run")
  (defparameter *n-art-overall-cycles 0 "TOTAL number of cycles.")
  (defparameter *n-pattern-set-cycles  1 "Total number of times current pattern set will be run")
  (defparameter  *pattern-set-cycle-n 0 "Run number for current pattern set")
  (defparameter *n-pattern-cycles  5  "Num of cycles within each RUN-ART-PATTERN-CYCLE run (or car of each pattern)")  ;;for ART2 didn't have 5 STM cycles 10) ;;was 20
  (defparameter *n-patterns 0 "Number of  items/patterns in pattern list")
  (defparameter *pattern-n 0 "In pattern list set, this is pattern-n")
  (defparameter *pattern-cycle-n 0  " pattern cycle within RUN-ART-PATTERN-CYCLE")
  (defparameter  *n-cycles-per-tdelta 2 "Completes this many cycles of F1-F3 runs including update-weights in run-art-pattern-cycle. Grossberg used 5.")
  (defparameter  *tdelta-cycle-n 0 "t-delta time cycle within *n-cycles-per-tdelta")
  (defparameter *time 0 "Current time, incremented in run-art-pattern-cyle by *delta-t")
  ;;not used(defparameter  *test-reset-cycle-n 0 "Completes this many cycles of F1-F3 runs including update-weights between test-resets in run-art-pattern-cycle. Grossberg used 5.")
  (defparameter  *run-random-test-p  NIL "SSS Check to see what this does in detail")
  (defparameter  *ignore-n-pattern-cycles-p nil "Used with *run-random-test-p (or otherwise?) to prevent use of normal pattern sequencing including repeating pattern a certain number of times.")
  ;; ART3 FORMULA CALCULATION PARAMETERS ---------------
; Neuron size for plots:
  (setq PEsize 18)
  (setq PEsizem1 (- PEsize 1))
  (setq PEsizep1 (+ PEsize 1))

  ;;MODEL DESIGN PARAMETERS
  (defparameter *F3-all-or-none-competative-output-p T "Determines whether yi-3-3 is subject to all-or-none one-output competition or not" )
  (defparameter *F1-all-or-none-competative-output-p T "Determines whether yi-3-1 is subject to all-or-none one-output competition or not" )
  (defparameter *def-compet-val 0.01  "Default value for losing competitive nodes")

  ;;ON-CENTER, OFF-SURROUND COMPETITION
  (defparameter *F3-compet-every-nth-time-interval  *n-cycles-per-tdelta "On-center, off-surround competition at F3 occurs every nth delta time interval cycle instead of only once every pattern-cycle")
  (defparameter *test-compet-overall-cycle-nums-list NIL)
  (defparameter  *F3L1-compet-p T "Causes competition inside F3-Cycle at F3,L1.")
  (defparameter *recalc-F3L1xy-postreset-p nil  "Recalculate Xi-1-3 and yi-1-3 post reset IF there is a reset.")
  (defparameter *recalc-yi-3-3-postcompet-p T "Recalculate xi-3-3 and yi-3-3 after F3 competion ON ONLY LAST PATTERN CYCLE (if nil, not at all).")

  ;;RESET
  ;;Where is reset checked and how often?
  (defparameter  *reset-compare-layers 1 "Which F1 vs F2 layers to compare, 1 or 2?")
  (defparameter  *F2-test-reset-p T "Reset tested after F2-cycle")
  (defparameter  *F3-test-reset-p NIL "Reset tested after F2-cycle")
  (defparameter  *test-reset-every-nth-pattern-cycle  *n-cycles-per-tdelta)-
  (defparameter  *test-reset-every-nth-time-interval NIL)
  (defparameter  *test-reset-overall-cycle-nums-list NIL)
  ;;Reset of ALL nodes in Field 1 and/or Field 2 to default *art-initial-x, y
  (defparameter *reset-all-F1F2-p T "Reset all F1, F2 x-y nodes on reset")
  (defparameter *reset-all-F1F2L1-p NIL "Reset all F1, F2 Layer 1 nodes on reset")
  (defparameter *reset-all-F1F2L2-p NIL "Reset all F1, F2 Layer 1 nodes on reset")
  (defparameter *reset-all-F3Layer-maxs-p T "Reset all F3 Layer max output nodes on reset")
  ;;Check which F3 Layer for max output?
  (defparameter *find-yi-1-3-max-output-p NIL "Check yi-1-3 for max output to reset (either layer 1 or 3)")
  (defparameter *find-yi-3-3-max-output-p  T  "Check yi-3-3 for max output to reset (either layer 1 or 3)")
  ;;Reset of ONLY the max nodes
  (defparameter  *reset-F2-p  NIL "If T, reset Yi-2-2 when there is a reset wave.Only applies if only max values are reset.")
  (defparameter  *reset-XI-1-3-p  NIL  "If T, reset Xi-1-3 when there is a reset wave.")
  (defparameter  *reset-XI-2-3-p  NIL  "If T, reset Xi-2-3 when there is a reset wave.")
  (defparameter  *reset-XI-3-3-p  NIL  "If T, reset Xi-2-3 when there is a reset wave.")

; MODEL CONSTANTS
  (defparameter a 0.7 "LTM Weight parameter") ;;default= 0.5
  (defparameter b 0.2 "v parameter")  ;;default= 0.2
  (defparameter c  -1.0 "??" )   ;;default= -1.0
  (defparameter d  0.6 "wUp and wdn parameter")  ;;default= 0.4
  (defparameter e  0.04  "norm parameter?")  ;;default= 0.04
  (defparameter theta 0.4 "f(x) Activation criteria in function G. Very important sharpening parameter.")  ;;default= 0.3
  (defparameter *vigilance-multiplier 2.0  "In res= (* *vigilance-multiplier l2-norm-r)") ;;default = 2.0 ;;GR=3??
  (defparameter *vigilance  0.9 "Sigmoid degree of match criteria, max 1.00")  ;;default= 0.94
  ;;higher number may increase final output
  (defparameter alpha 1.0 "LTM weight w parameter")  ;;default= 1.0

  (defparameter *onCenterThreshold 0.25 "Threshold for F2 min y activity for on-center, off-surround. Watson used term resetThreshold")  ;;default= 0.05, Watson used term resetThreshold  
  (defparameter *min-input-criteria  0.20 "Min input for testing x r mismatch for F2 reset.")
  ;;not used (defparameter  *v-activity-reset-criteria 0.20 "Threshold for mismatch betw p  and u  thru wdn to cause reset of y")
  (defparameter  *min-g  0.02  "Min value of  (g  j *n-outputs) for updating wup")
  (defparameter *reset-y-criteria 0.40 "y must be greater than this to cause on-center, off-") ;;;was 0.25)  
  (defparameter  *def-nonresetnin-out-val 0  "Value resetnin or resetnout set to if NOT reset")
  (defparameter  *def-resetnin-out-val  1.0  "Default value resetnin or resetnout set to if  reset. Normally set to res instead.")
  (defparameter  *def-reset-xy-val 999  "Value to set x or y node to if RESET. IN CHOICE-RESET, Checks to see if 999, if so doesn't process it. IN DISTRIBUTED-RESET MODEL, set value to .0001?")
  (defparameter   *def-y-testout-val 0.0001 "After test-xy-node-reset, the value returned when calc the dif layer x value")
  ;;INITIAL CONSTANTS, VAR VALUES, LATER MOVE TO CONFIG-ART3
  ;;ART3 PARAMETERS 
  (defparameter *delta-t  0.1 "Time increment on each complete ART cycle" )
  (defparameter *init-t  0.0  "Initial time")
  ;;Parameters from Grossberg Table 4.
  (defparameter *p1-all  0.7 "Function g stm activity multipler for F1") ;;Gr 10.0
  (defparameter *p2-all 2.0 "Function g stm activity multipler for F2") ;;Gr 10.0
  (defparameter *p3-all 0.0001 "Function g stm activity multipler for F3")
  (defparameter *p4-3 0.9 "G's p4c")
  (defparameter *p5-all 0.1 "")
  (defparameter *P6-all 1.0 "")
  ;;For Sigma and G
  (defparameter *def-sigmoid-val 0.001 "Default value of sigmoid output if activity level not > theta criterion.")
  (defparameter *def-g-val 0.001)

  ;;ART3 SIGNAL FUNCTIONS g1 g2 g3  (G: ga, gb, gc) from Grossberg Table 4.
  ;;F1, F2 Distributed
  (defparameter *pd7-12 0.0001 "Function g stm activity criterion for F1-2 distributed output." )     ;; Gs Distr: p7a, p7b
  (defparameter *pd8-12 0.3 "Function g stm activity criterion for F1-2 distributed output") 
  ;;F3 Distributed
  (defparameter *pd7-3  "Function g stm activity criterion for F3 choice output") ;;Gs Choice:  p7c  =  1/ SqRt nc
  (defparameter *pd8-3  0.3 "" )                 ;;Gs Choice: p8c  =  0.2
  ;;F3 Choice (all F1-2 are distributed?)
  (defparameter *pc7-3   '(/ 1 (sqrt n3)) "MUST EVAL IT Function g stm activity criterion for F3 choice output")                ;;Gs Distr: p7c  =  1/ SqRt nc
  (defparameter *pc8-3  0.2)                 ;;Gs: Distr: p8c  =  0.4

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

  (defparameter  *show-last-reset-vals-n 20 "Number of reset-vals in graph")

  ;;INITIAL ART3 VARIABLE VALUES
  ;;INITIAL X AND Y VALUES
  (defparameter  *art-initial-x  0.01 "Initial value for all X-F-L-I")
  (defparameter  *art-initial-y  0.01 "Initial value for all Y-F-L-I")
  ;;INITIAL RANDOM HI-LO VALUES
  (defparameter upLR 0.5 "wUp parameter")  ;;default= 0.12
  (defparameter downLR 0.4 "wdn parameter")  ;;default= 0.12
  (defparameter *p-wdn-floor -0.2 "My-floor value for (- pi wdnji)")
  (defparameter *p-wup-floor -0.2 "My-floor value for (- pi wupij)")
  (defparameter *wUpInitLo 0.40 "random init low value")
  (defparameter *wUpInitHi  0.50 "random init high value. Must be not too small-grossberg.")
  (defparameter *wDnInitLo 0.20 "random init low value. Must be SMALL-grossberg.");; was .20
  (defparameter *wDnInitHi 0.40"random init high value") ;;was .4
  ;;for creating limits in ART3 variables-during processing (with my-floor-ceiling)
  (defparameter *wt-floor  0.0001) ;;for both wup and wdn
  (defparameter *wt-ceiling 1.00)  ;;for both wup and wdn
  (defparameter *x-activity-floor -100)
  (defparameter *x-activity-ceiling 1000)
  (defparameter *y-output-floor -100)
  (defparameter *y-output-ceiling 1000)
  ;;ART3 DATA TEXT
  (defparameter *make-ART-cycle-data-text-p NIL "Make summary data text for each cycle")
  (defparameter *ART-cycle-data-text nil "A list of  data text lists for each art cycle")
  (defparameter *art-data-text nil "A list of more detailed data text lists.")

  ;;for initializing 1-dim values with zeroActivations function
  ;;zzz
  ;;(defparameter *1-dim-*n-inputs-sym-list  '((X-Activity  .01) (V  .01) (R  .01) (U  .01) (Q  .01) (P  .01) (W  .01))   ;;was '((X-Activity  .01) (V  .01) (R  .01) (U  .01) (Q  .01) (P  .01) (W  .01)))
  ;;(defparameter *1-dim-*n-outputs-sym-list  '((Y-Output  .01)(Temp  .01) (reset-Val 0) (reset nil) (reset-cntr 0) (Temp2  .01)))

  ;;FOR DRAWING GRAPHS ETC
  (defparameter  *art-graph-points-syms-list  '(INPUTI-1-1 XI-2-2  YI-3-3 WUPI-3-2TOI-1-3  WDNI-1-3TOI-3-2   RESETNINI-2-2 RESETNOUTI-2-2) "The symbols that are graphed") ;;UUPI-3-2TOI-1-3 UDNI-1-3TOI-3-2  ) 
  (defparameter  *sortdim-n2-syms  '(WUPI-3-2TOI-1-3) "Symbols to be sorted by sortdim-n = 2 for graphing")
  (defparameter  *art-datatext-syms-list '(INPUTI-1-1 XI-2-2  YI-3-3 WUPI-3-2TOI-1-3  WDNI-1-3TOI-3-2   R RESETNINI-2-2 RESETNOUTI-2-2)  "Symbols used for datatext output") ;;UUPI-3-2TOI-1-3 UDNI-1-3TOI-3-2
  ;;was (input v-activity p wup wdn reset y-output)
  (defparameter *make-art-graphs-p T "Must be T to create any kind of graph windows")
  (defparameter *no-graph-p nil "Prevents any graph windows from being created")
  (defparameter  *art-inst-counter 0 "Number of art graph window instances.")
  (defparameter  *art-inst-name-root  "*art-inst-sym"  "Root name for making *art-inst-syms")
  (defparameter  *art-inst-sym  nil  "New instance for each graph window, renewed for each runart")
  (defparameter  *art-graph-win-counter 0 "Number of art graph window instances.")
  (defparameter  *art-graph-win-root  "*art-graph-sym"  "Root name for making *art-inst-syms")
  (defparameter  *art-graph-win-sym  nil  "New instance for each graph window, renewed for each runart")
  (defparameter *graphing-symbols-list  *art-graph-points-syms-list) 
  (defparameter  *art-graph-var-slots '(input-points  X-points    X-2-2-I-points  X-3-L-I-points   Y-2-L-I-points  Y-3-L-I-points Y-3-3-I-POINTS RESETNINI-2-2-POINTS RESETNOUTI-2-2-POINTS   wup-points  wdn-points  ) "Slots in ART-instance for storing graph values") ;;uup-points  udn-points
  (defparameter  *graph-every-x-overall-cycle  999 "Graphs every Xth cycle of *overall-cycle-n")
  (defparameter  *graph-every-x-pattern-set-cycle  1  "Graphs every Xth cycle of *pattern-set-cycle-n")  
  (defparameter *graph-every-x-pattern-cycle   *n-cycles-per-tdelta  "Graph every Xth cycle within a PATTERN run")  ;;was 1
  (defparameter *graph-every-x-pattern-cycle-list  NIL " Was '(1   5  10) or '(1 2 3 4 5 6 7 8 9 10). ")
  (defparameter *display-graphs-on-reset t  "Displays graphs when reset takes place")
  (defparameter  *end-test-all-patterns-n 0 "Test all patterns n times at end")
  (defparameter  *graph-end-tests-p T "If end-tests, then graph last end test pattern")
  (defparameter *sort-wup-dim 2 "Graph wup points by dim-n (1 or 2)")
  (defparameter *sort-wdn-dim 1  "Graph wdn points by dim-n (1 or 2)")
  (defparameter *initial-x-pix 0)
  (defparameter *initial-y-pix 0)
  (defparameter *incr-x-pix 40)
  (defparameter *v-activity-y-increment  1.0)    ;;was 10 ;;*x-activity-y-increment
  (defparameter  *x-max 400)   ;;was 250
  (defparameter *graph-last-cycle  T)
  (defparameter *graph-color-list '(:red :blue :orange :green :black :yellow :lightblue :magenta :pink  :gray :violet :cyan1 :darkorchid :tomato :slateblue :salmon3 :mistyrose1 :brown ))
  (defparameter *graph-sym-abrv-begin-n 3 "N begin digits when abreviate graph label on x-axis")
  (defparameter *graph-sym-abrv-end-n 3 "N end digits on abrev label" )
  (defparameter *setsym-2dim-nested-lists-p T "Puts 2-dim points in nested lists")
  ;;END INITIALIZE-ART-GLOBAL-VARS-P
  )|#

;;FOR DEBUGGING
(defparameter *out1 nil)
(defparameter *out2 nil)
(defparameter *out3 nil)

(defparameter *all-art-symbol-strings
  '("CS" "Input" "X" "Y" "R" "Wup" "Wdn"   "Y-Output"  "RESETNIN" "RESETNOUT" "RESET-COUNTER" "N-CATS" "TEMP" "TEMP2") "Symbol strings from ART3-init symbol-spec-list") ;;NO RESET "Uup" "Udn"
(defparameter *all-art-symbols
  '(CS Input X Y R P  Wup Wdn   Y-Output  RESETNIN  RESETNOUT RESET-COUNTER N-CATS TEMP TEMP2) ) ;;NO RESET Uup Udn
(defparameter *all-art-class-rootsyms
  '(CS Input X Y R P  Wup Wdn   Y-Output  RESETIN RESETNOUT  RESET-COUNTER N-CATS TEMP TEMP2) "Root syms that eval to  (root-str dim-specs-list [not dims lists] nil nil (topsym)) Egs dims-specs-list ((9 1 1)(3 1 1)(3 1 1))  topsym= X-F-L-I") ;;Uup Udn


(defparameter *art-index-syms '(M F L I) "Symbols/letters used in art dim lists for making art symbols")
(defparameter *art-index-separator ".") ;; "-")
(defparameter *art-node-separator 'TO)
(defparameter *art-max-index  99 "Used when searching for bound artsyms.")
(defparameter *all-reset-syms  NIL "For convenience calculating if a var was reset. Set in ART3-init")
(defparameter *initial-tlink-artloc '(1 1 1 NEW) "Initial *new-tlink-artloc value")
(defparameter *new-tlink-artloc nil  "Used for making new artsyms when make new csyms for links between cells -- using CS-EXPLORE")
;;MUST BE DEFINED BEFORE CSQ-SHAQ-new-scales
(defparameter *MAKE-DEFS-FILE-P NIL "For making classes work in delivered version must use T. Load before CSQ-SHAQ-new-scales.")


;;=== CSARTSYM ARCHITECTURE STRUCTURE DB SYMBOLS ==========
;;2019

;;

;; SYSTEM (LONG) SYMBOLS
;; The SHORT SYMBOLS are included in the long symbol def list below.
;; The SHORT SYMBOLS ARE USED IN THE CSART DB & TREES.
;; These categories are largely DOMAIN AREAS which may correspond roughly to Brain areas
;; These are symbols representing different (brain?) systems--mostly cognitive systems, but can be any psychological system (or other type of eg. environmental system?). Of course only the psych systems can be nodes or linked to nodes.
;;see below (Defparameter *CS-CATEGORIES NIL)  ;;was  *CSARTSYS-TREE-SPEC-LIST)
;;FILE WHERE CS-CAT-DB OUTPUT STORED
(Defparameter  *CS-CAT-DB-TREE-file "C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\CS-CAT-DB-TREE.lisp" )
(Defparameter  *CS-CAT-DB-CSYMS&VALS-file "C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\CS-CAT-DB-CSYMS&VALS.lisp")
(Defparameter *ALL-STORED-CSYMS-FILE "C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\ALL-STORED-CSYMS.lisp" "Used ONLY when EACH csym and its vals are saved by make-csym to a file: Normally not used bec of time")
(Defparameter *ALL-STORED-CSARTLOCS-FILE "C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\ALL-STORED-CSYMS.lisp" "Used ONLY when EACH csartloc-sym and its vals are saved by make-csym to a file: Normally not used bec of time")
;; GO TO CSQ-CONFIG FOR USER CS/CSQ DATA IS STORED!

;;CSYM KEYS, etc
(defparameter  *csphrkey :PHR "2nd-item OR phrase/title key")
(defparameter  *cslockey :CSLOC "3rd-item OR csartloc key")
(defparameter  *datakey :DATA "4th item OR  data (= a list) key")
(defparameter  *defkey :DEF "5th item OR definition may= scale desc key")
(defparameter  *desckey :DESC "Description key: long description")
;;value keys
(defparameter  *csvalkey :VA "Key for value1 ratings (eg 0 to 1.0)")
(defparameter  *csval2key :VA2 "Key for value2 ratings (eg 0 to 1.0)")
(defparameter *csval-rank-key :RNK  "Within a given pc value rating, the rank compared to other values with same rating")
(defparameter  *sdkey :SD "Standard Deviation key")
(defparameter  *multivalkey :ADAT "Key for multi-sel answer-value pairs")
(defparameter *txtinputkey :TXT "For CSQ/SHAQ text input data in csymvals")
;;etc
(defparameter  *clevkey :CLEV "CS hierarchy (supord/control?) level.")
(defparameter  *qtypekey :QT "Question/source type: :SYS, :SCALE, :QVAR, :TXT,  etc")
(defparameter  *csyskey :CSYS "Cognitive System key--also see CSARTLOC")
(defparameter  *supsyskey :CSS "CS SuperSystem (supsys) key-strict hier")
(defparameter  *sublistkey :S "CS sublist key--strict hierarchy")
(defparameter  *linktypekey :LNTP "CS path link key")
(defparameter  *revpoleskey :REVPOL "Reverse PC Poles")
(defparameter  *revscorekey :REVSCOR "Scored in Reverse")

;;CSYM SOURCE/TYPES
(Defparameter *CSYM-SOURCE-TYPES   '(:SYS :SCALE :SSCALE :QVAR :ELM :PC :LNK) "CSQ SOURCE/TYPE= Q-TYPE (eg SYS, SHAQ scale, subscale, or qvar; ELM; PC, LINK, etc")

(Defparameter $COGSYS '($CS ($CS) :S (EVAL *$CS-SUBTYPES)))


;;
;;STEPS: 1. MADE WITH (MAKE-CSYM-TREE)
;;  (setf *CS-CAT-DB-TREE (MAKE-CSYM-TREE))
;;  2. USED PPRINT-LISTS *CS-CAT-DB-TREE)
;;  3. Copied output text to a new buffer.
;; 4. SEARCH & REPLACED following: \", keywords ":CSS" to :CSS, ":S", ":QT", ":SYS", ":CLEV", etc??
;; 5. copied back to the defparameter *CS-CAT-DB-TREE
;;revised to make levels only determined by SUBSYSs  = :S
;;DO NOT USE THIS AS MASTER FOR EDITING!
;;  ==> USE *CS-CAT-DB-CSYMS
#|(DEFPARAMETER   *CS-CAT-DB-TREE ;;OLD VERSION
  '(( "$CS" "All Main Systems" $CS.$CS.$CS NIL NIL :QT :SYS :S                                 
     (( "$EXC" "Executive" $CS.$EXC.$CS.$EXC NIL NIL :QT :SYS :S                
       ( ( "$TBV" "Top Belief-Value" $CS.$EXC.$TBV.$EXC.$TBV NIL NIL :QT :SYS :CSS $EXC :CLEV 2)               
         ( "$WV" "Worldview" $CS.$EXC.$WV.$EXC.$WV NIL NIL :QT :SYS :S               
          (  ( "$SLF" "Self" $CS.$EXC.$WV.$SLF.$WV.$SLF NIL NIL :QT :SYS :CSS $WV :CLEV 3)                  
             ( "$REFG" "Reference Group" $CS.$EXC.$WV.$REFG.$WV.$REFG NIL NIL :QT :SYS :S          
              (  ( "$FAM" "Family" $CS.$EXC.$WV.$REFG.$FAM.$REFG.$FAM NIL NIL :QT :SYS :CSS $REFG :CLEV 3)    )
              :CSS $WV :CLEV 3)  )
          :CSS $EXC :CLEV 2)              
         ( "$SKL" "Skill" $CS.$EXC.$SKL.$EXC.$SKL NIL NIL :QT :SYS :S                                                         
          (  ( "$PS" "ProbSolv" $CS.$EXC.$SKL.$PS.$SKL.$PS NIL NIL :QT :SYS :CSS $SKL :CLEV 3)          
             ( "$DM" "DecMaking" $CS.$EXC.$SKL.$DM.$SKL.$DM NIL NIL :QT :SYS :CSS $SKL :CLEV 3)          
             ( "$PLN" "Planning" $CS.$EXC.$SKL.$PLN.$SKL.$PLN NIL NIL :QT :SYS :CSS $SKL :CLEV 3)          
             ( "$COP" "EmotCope" $CS.$EXC.$SKL.$COP.$SKL.$COP NIL NIL :QT :SYS :CSS $SKL :CLEV 3)          
             ( "$RESN" "ResearchLearn" $CS.$EXC.$SKL.$RESN.$SKL.$RESN NIL NIL :QT :SYS :CSS $SKL :CLEV 3)          
             ( "$INTP" "Interpersonal Skill" $CS.$EXC.$SKL.$INTP.$SKL.$INTP NIL NIL :QT :SYS :CSS $SKL :CLEV 3)          
             ( "$MECH" "Mech" $CS.$EXC.$SKL.$MECH.$SKL.$MECH NIL NIL :QT :SYS :CSS $SKL :CLEV 3)          
             ( "$MAIN" "Mainenance" $CS.$EXC.$SKL.$MAIN.$SKL.$MAIN NIL NIL :QT :SYS :CSS $SKL :CLEV 3) )
          :CSS $EXC :CLEV 2)  )
       :CSS $CS :CLEV 1)          
      ( "$BV" "Belief-Value" $CS.$BV.$CS.$BV NIL NIL :QT :SYS :S                
       (  ( "$TBV" "Top Belief-Value" $CS.$BV.$TBV.$BV.$TBV NIL NIL :QT :SYS :CSS $BV :CLEV 2)
          ( "$HISF" "Higher Self" $CS.$BV.$HISF.$BV.$HISF NIL NIL :QT :SYS :CSS $BV :CLEV 2)              
          ( "$WV" "Worldview" $CS.$BV.$WV.$BV.$WV NIL NIL :QT :SYS :S               
           ( ( "$SLF" "Self" $CS.$BV.$WV.$SLF.$WV.$SLF NIL NIL :QT :SYS :CSS $WV :CLEV 3)                  
             ( "$REFG" "Reference Group" $CS.$BV.$WV.$REFG.$WV.$REFG NIL NIL :QT :SYS :S          
              (         ( "$FAM" "Family" $CS.$BV.$WV.$REFG.$FAM.$REFG.$FAM NIL NIL :QT :SYS :CSS $REFG :CLEV 3)    )
              :CSS $WV :CLEV 3)   )
           :CSS $BV :CLEV 2)   )
       :CSS $CS :CLEV 2)
      ( "$PC" "Personal Construct" $CS.$PC.$CS.$PC NIL NIL :QT :SYS :CSS $CS :CLEV 1)
      ( "$KNW" "Knowledge" $CS.$KNW.$CS.$KNW NIL NIL :QT :SYS :S                                    
       (  ( "$NSC" "NatSci" $CS.$KNW.$NSC.$KNW.$NSC NIL NIL :QT :SYS :CSS $KNW :CLEV 3)        
          ( "$SSC" "SocSci" $CS.$KNW.$SSC.$KNW.$SSC NIL NIL :QT :SYS :CSS $KNW :CLEV 3)        
          ( "$BSC" "BehSci" $CS.$KNW.$BSC.$KNW.$BSC NIL NIL :QT :SYS :CSS $KNW :CLEV 3)        
          ( "$ART" "Art" $CS.$KNW.$ART.$KNW.$ART NIL NIL :QT :SYS :CSS $KNW :CLEV 3)        
          ( "$BUS" "Bus" $CS.$KNW.$BUS.$KNW.$BUS NIL NIL :QT :SYS :CSS $KNW :CLEV 3)        
          ( "$SPT" NIL $CS.$KNW.$SPT.$KNW.$SPT NIL NIL :QT :SYS :CSS $KNW :CLEV 3)        
          ( "$REC" "Recreat" $CS.$KNW.$REC.$KNW.$REC NIL NIL :QT :SYS :CSS $KNW :CLEV 3)       )
       :CSS $CS :CLEV 1)          
      ( "$LNG" "Language" $CS.$LNG.$CS.$LNG NIL NIL :QT :SYS :S           
       (  ( "$VER" "Verbal" $CS.$LNG.$VER.$LNG.$VER NIL NIL :QT :SYS :CSS $LNG :CLEV 3)        
          ( "$MTH" "Math" $CS.$LNG.$MTH.$LNG.$MTH NIL NIL :QT :SYS :CSS $LNG :CLEV 3))
       :CSS $CS :CLEV 1)          
      ( "$EP" "Episode" $CS.$EP.$CS.$EP NIL NIL :QT :SYS :S           
       (  ( "$SCR" "Script" $CS.$EP.$SCR.$EP.$SCR NIL NIL :QT :SYS :CSS $EP :CLEV 3)        
          ( "$EVT" "Event" $CS.$EP.$EVT.$EP.$EVT NIL NIL :QT :SYS :CSS $EP :CLEV 3)    )
       :CSS $CS :CLEV 1)          
      ( "$ELM" "Element" $CS.$ELM.$CS.$ELM NIL NIL :QT :SYS :S           
       (   ( "$PER" "Person" $CS.$ELM.$PER.$ELM.$PER NIL NIL :QT :SYS :CSS $ELM :CLEV 3)        
           ( "$OBJ" "Object" $CS.$ELM.$OBJ.$ELM.$OBJ NIL NIL :QT :SYS :CSS $ELM :CLEV 3)    )
       :CSS $CS :CLEV 1)      
      ( "$EMT" NIL $CS.$EMT.$CS.$EMT NIL NIL :QT :SYS :CSS $CS)          
      ( "$PCPT" "Percept" $CS.$PCPT.$CS.$PCPT NIL NIL :QT :SYS :S                                    
       (   ( "$VER" "Verbal" $CS.$PCPT.$VER.$PCPT.$VER NIL NIL :QT :SYS :CSS $PCPT :CLEV 3)        
           ( "$IMG" "Image" $CS.$PCPT.$IMG.$PCPT.$IMG NIL NIL :QT :SYS :CSS $PCPT :CLEV 3)        
           ( "$SOND" "Sound" $CS.$PCPT.$SOND.$PCPT.$SOND NIL NIL :QT :SYS :CSS $PCPT :CLEV 3)        
           ( "$SML" "Smell" $CS.$PCPT.$SML.$PCPT.$SML NIL NIL :QT :SYS :CSS $PCPT :CLEV 3)        
           ( "$TST" "Taste" $CS.$PCPT.$TST.$PCPT.$TST NIL NIL :QT :SYS :CSS $PCPT :CLEV 3)        
           ( "$TCT" "Tactile" $CS.$PCPT.$TCT.$PCPT.$TCT NIL NIL :QT :SYS :CSS $PCPT :CLEV 3)        
           ( "$BND" "Bio Need" $CS.$PCPT.$BND.$PCPT.$BND :CSS $PCPT :QT :SYS :CLEV 3)
           )
       :CSS $CS :CLEV 1)      
      ( "$MOT" "Motor" $CS.$MOT.$CS.$MOT NIL NIL :QT :SYS :CSS $CS :CLEV 1)
      ( "$MIS" "Misc" $CS.$MIS.$CS.$MIS NIL NIL :QT :SYS :CSS $CS :CLEV 1)   )
     :CSS $CS :CLEV 0)   )
  "*CS-CAT-DB-TREE--made from *master-csart-cat-db using (make-csym-tree"
  ;;end defparameter
  )|#

    #|OLD
 '((\"$CS\" \"All Main Systems\" $CS.$CS.$CS NIL NIL QT SYS S                          
     ((\"$EXC\" \"Executive\" $CS.$EXC.$CS.$EXC NIL NIL QT SYS S                
       ((\"$TBV\" \"Top Belief-Value\" $CS.$EXC.$TBV.$EXC.$TBV NIL NIL QT SYS CSS $EXC CLEV 2)              
        (\"$WV\" \"Worldview\" $CS.$EXC.$WV.$EXC.$WV NIL NIL QT SYS S               
         ((\"$SLF\" \"Self\" $CS.$EXC.$WV.$SLF.$WV.$SLF NIL NIL QT SYS CSS $WV CLEV 3)                  
          (\"$REFG\" \"Reference Group\" $CS.$EXC.$WV.$REFG.$WV.$REFG NIL NIL QT SYS S          
           ((\"$FAM\" \"Family\" $CS.$EXC.$WV.$REFG.$FAM.$REFG.$FAM NIL NIL QT SYS CSS $REFG CLEV 3)           )           CSS $WV CLEV 3)         )         CSS $EXC CLEV 2)              
        (\"$SKL\" \"Skill\" $CS.$EXC.$SKL.$EXC.$SKL NIL NIL QT SYS S                                                         
         ((\"$PS\" \"ProbSolv\" $CS.$EXC.$SKL.$PS.$SKL.$PS NIL NIL QT SYS CSS $SKL CLEV 3)          
          (\"$DM\" \"DecMaking\" $CS.$EXC.$SKL.$DM.$SKL.$DM NIL NIL QT SYS CSS $SKL CLEV 3)          
          (\"$PLN\" \"Planning\" $CS.$EXC.$SKL.$PLN.$SKL.$PLN NIL NIL QT SYS CSS $SKL CLEV 3)          
          (\"$COP\" \"EmotCope\" $CS.$EXC.$SKL.$COP.$SKL.$COP NIL NIL QT SYS CSS $SKL CLEV 3)          
          (\"$RESN\" \"ResearchLearn\" $CS.$EXC.$SKL.$RESN.$SKL.$RESN NIL NIL QT SYS CSS $SKL CLEV 3)          
          (\"$INTP\" \"Interpersonal Skill\" $CS.$EXC.$SKL.$INTP.$SKL.$INTP NIL NIL QT SYS CSS $SKL CLEV 3)          
          (\"$MECH\" \"Mech\" $CS.$EXC.$SKL.$MECH.$SKL.$MECH NIL NIL QT SYS CSS $SKL CLEV 3)          
          (\"$MAIN\" \"Mainenance\" $CS.$EXC.$SKL.$MAIN.$SKL.$MAIN NIL NIL QT SYS CSS $SKL CLEV 3)         )         CSS $EXC CLEV 2)       )       CSS $CS CLEV 1)          
      (\"$BV\" \"Belief-Value\" $CS.$BV.$CS.$BV NIL NIL QT SYS S                
       ((\"$TBV\" \"Top Belief-Value\" $CS.$BV.$TBV.$BV.$TBV NIL NIL QT SYS CSS $BV CLEV 2)        
        (\"$HISF\" \"Higher Self\" $CS.$BV.$HISF.$BV.$HISF NIL NIL QT SYS CSS $BV CLEV 2)              
        (\"$WV\" \"Worldview\" $CS.$BV.$WV.$BV.$WV NIL NIL QT SYS S               
         ((\"$SLF\" \"Self\" $CS.$BV.$WV.$SLF.$WV.$SLF NIL NIL QT SYS CSS $WV CLEV 3)                  
          (\"$REFG\" \"Reference Group\" $CS.$BV.$WV.$REFG.$WV.$REFG NIL NIL QT SYS S          
           ( (\"$FAM\" \"Family\" $CS.$BV.$WV.$REFG.$FAM.$REFG.$FAM NIL NIL QT SYS CSS $REFG CLEV 3)           )           CSS $WV CLEV 3)         )         CSS $BV CLEV 2)       )       CSS $CS CLEV 2)      
      (\"$PC\" \"Personal Construct\" $CS.$PC.$CS.$PC NIL NIL QT SYS CSS $CS CLEV 1)          
      (\"$KNW\" \"Knowledge\" $CS.$KNW.$CS.$KNW NIL NIL QT SYS S                                    
       ( 
        (\"$NSC\" \"NatSci\" $CS.$KNW.$NSC.$KNW.$NSC NIL NIL QT SYS CSS $KNW CLEV 3)        
        (\"$SSC\" \"SocSci\" $CS.$KNW.$SSC.$KNW.$SSC NIL NIL QT SYS CSS $KNW CLEV 3)        
        (\"$BSC\" \"BehSci\" $CS.$KNW.$BSC.$KNW.$BSC NIL NIL QT SYS CSS $KNW CLEV 3)        
        (\"$ART\" \"Art\" $CS.$KNW.$ART.$KNW.$ART NIL NIL QT SYS CSS $KNW CLEV 3)        
        (\"$BUS\" \"Bus\" $CS.$KNW.$BUS.$KNW.$BUS NIL NIL QT SYS CSS $KNW CLEV 3)        
        (\"$SPT\" NIL $CS.$KNW.$SPT.$KNW.$SPT NIL NIL QT SYS CSS $KNW CLEV 3)        
        (\"$REC\" \"Recreat\" $CS.$KNW.$REC.$KNW.$REC NIL NIL QT SYS CSS $KNW CLEV 3)       )       CSS $CS CLEV 1)          
      (\"$LNG\" \"Language\" $CS.$LNG.$CS.$LNG NIL NIL QT SYS S           
       ( 
        (\"$VER\" \"Verbal\" $CS.$LNG.$VER.$LNG.$VER NIL NIL QT SYS CSS $LNG CLEV 3)        
        (\"$MTH\" \"Math\" $CS.$LNG.$MTH.$LNG.$MTH NIL NIL QT SYS CSS $LNG CLEV 3)       )       CSS $CS CLEV 1)          
      (\"$EP\" \"Episode\" $CS.$EP.$CS.$EP NIL NIL QT SYS S           
       ( 
        (\"$SCR\" \"Script\" $CS.$EP.$SCR.$EP.$SCR NIL NIL QT SYS CSS $EP CLEV 3)        
        (\"$EVT\" \"Event\" $CS.$EP.$EVT.$EP.$EVT NIL NIL QT SYS CSS $EP CLEV 3)       )       CSS $CS CLEV 1)          
      (\"$ELM\" \"Element\" $CS.$ELM.$CS.$ELM NIL NIL QT SYS S           
       ( 
        (\"$PER\" \"Person\" $CS.$ELM.$PER.$ELM.$PER NIL NIL QT SYS CSS $ELM CLEV 3)        
        (\"$OBJ\" \"Object\" $CS.$ELM.$OBJ.$ELM.$OBJ NIL NIL QT SYS CSS $ELM CLEV 3)       )       CSS $CS CLEV 1)      
      (\"$EMT\" NIL $CS.$EMT.$CS.$EMT NIL NIL QT SYS CSS $CS)          
      (\"$PCPT\" \"Percept\" $CS.$PCPT.$CS.$PCPT NIL NIL QT SYS S                                    
       ( 
        (\"$VER\" \"Verbal\" $CS.$PCPT.$VER.$PCPT.$VER NIL NIL QT SYS CSS $PCPT CLEV 3)        
        (\"$IMG\" \"Image\" $CS.$PCPT.$IMG.$PCPT.$IMG NIL NIL QT SYS CSS $PCPT CLEV 3)        
        (\"$SOND\" \"Sound\" $CS.$PCPT.$SOND.$PCPT.$SOND NIL NIL QT SYS CSS $PCPT CLEV 3)        
        (\"$SML\" \"Smell\" $CS.$PCPT.$SML.$PCPT.$SML NIL NIL QT SYS CSS $PCPT CLEV 3)        
        (\"$TST\" \"Taste\" $CS.$PCPT.$TST.$PCPT.$TST NIL NIL QT SYS CSS $PCPT CLEV 3)        
        (\"$TCT\" \"Tactile\" $CS.$PCPT.$TCT.$PCPT.$TCT NIL NIL QT SYS CSS $PCPT CLEV 3)        
        (\"$BND\" \"Bio Need\" $CS.$PCPT.$BND.$PCPT.$BND CSS $PCPT QT SYS CLEV 3)       )       CSS $CS CLEV 1)      
      (\"$MOT\" \"Motor\" $CS.$MOT.$CS.$MOT NIL NIL QT SYS CSS $CS CLEV 1)      
      (\"$MIS\" \"Misc\" $CS.$MIS.$CS.$MIS NIL NIL QT SYS CSS $CS CLEV 1)     )     CSS $CS CLEV 0))|# 

 
#| OLD (Defparameter   *CS-CAT-DB-TREE
  '(("$CS"   "All Main Systems"   $CS    NIL  NIL  :QT  :SYS  :S
  (("$EXC"     "Executive"     $CS.$EXC     NIL     NIL     :QT     :SYS   :S
    (("$TBV"   "Top Belief-Value"  $EXC.$TBV  NIL NIL :QT :SYS  :CSS   $EXC  :CLEV  2)
     ("$WV" "Worldview"   $EXC.$WV  NIL  NIL :QT :SYS   :S
      (("$SLF" "Self" $WV.$SLF NIL NIL :QT :SYS :CSS $WV :CLEV 3)
       ("$REFG"   "Reference Group"   $WV.$REFG  NIL NIL :QT  :SYS     :S
        (("$FAM" "Family" $REFG.$FAM NIL NIL :QT :SYS :CSS $REFG :CLEV 3)) :CSS $WV  :CLEV  3))
      :CSS   $EXC :CLEV 2)
     ("$CSK" NIL $EXC.$CSK NIL NIL :QT :SYS :CSS $EXC :CLEV 2)
     ("$BSK" NIL $EXC.$BSK NIL NIL :QT :SYS :CSS $EXC  :CLEV 2)
     ("$INTP" "Interpersonal" NIL  $EXC.$INTP    :QT :SYS :CSS $EXC  :CLEV 2))
    :CSS   $CS  :CLEV  1)
   ("$KNW" "Knowledge" $CS.$KNW  NIL  NIL :QT :SYS    :S
    (("$NSC" "NatSci" $KNW.$NSC NIL NIL :QT :SYS :CSS $KNW :CLEV 3)
     ("$SSC" "SocSci" $KNW.$SSC NIL NIL :QT :SYS :CSS $KNW :CLEV 3)
     ("$BSC" "BehSci" $KNW.$BSC NIL NIL :QT :SYS :CSS $KNW :CLEV 3)
     ("$ART" "Art" $KNW.$ART NIL NIL :QT :SYS :CSS $KNW :CLEV 3)
     ("$BUS" "Bus" $KNW.$BUS NIL NIL :QT :SYS :CSS $KNW :CLEV 3)
     ("$SPT" NIL $KNW.$SPT NIL NIL :QT :SYS :CSS $KNW :CLEV 3)
     ("$REC" "Recreat" $KNW.$REC NIL NIL :QT :SYS :CSS $KNW :CLEV 3))
    :CSS   $CS  :CLEV 1)
   ("$LNG"  "Language" $CS.$LNG  NIL  NIL :QT :SYS   :S
    (("$VER" "Verbal" $LNG.$VER NIL NIL :QT :SYS :CSS $LNG :CLEV 3)
     ("$MTH" "Math" $LNG.$MTH NIL NIL :QT :SYS :CSS $LNG :CLEV 3))
    :CSS  $CS :CLEV 1)
   ("$EP"  "Episode"$CS.$EP  NIL  NIL :QT :SYS  :S
    (("$SCR" "Script" $EP.$SCR NIL NIL :QT :SYS :CSS $EP :CLEV 3)
     ("$EVT" "Event" $EP.$EVT NIL NIL :QT :SYS :CSS $EP :CLEV 3))
    :CSS $CS :CLEV 1)
   ("$ELM"  "Element" $CS.$ELM  NIL NIL :QT :SYS    :S
    (("$PER" "Person" $ELM.$PER NIL NIL :QT :SYS :CSS $ELM :CLEV 3)
     ("$OBJ" "Object" $ELM.$OBJ NIL NIL :QT :SYS :CSS $ELM :CLEV 3))
    :CSS   $CS :CLEV  1)
   ("$EMT" NIL $CS.$EMT NIL NIL :QT :SYS :CSS $CS)
   ("$PCPT"  "Percept"  $CS.$PCPT NIL  NIL  :QT  :SYS    :S
    (("$VER" "Verbal" $PCPT.$VER NIL NIL :QT :SYS :CSS $PCPT :CLEV 3)
     ("$IMG" "Image" $PCPT.$IMG NIL NIL :QT :SYS :CSS $PCPT :CLEV 3)
     ("$SOND" "Sound" $PCPT.$SOND NIL NIL :QT :SYS :CSS $PCPT :CLEV 3)
     ("$SML" "Smell" $PCPT.$SML NIL NIL :QT :SYS :CSS $PCPT :CLEV 3)
     ("$TST" "Taste" $PCPT.$TST NIL NIL :QT :SYS :CSS $PCPT :CLEV 3)
     ("$TCT" "Tactile" $PCPT.$TCT NIL NIL :QT :SYS :CSS $PCPT :CLEV 3)
     ("$BND" "Bio Need" $PCPT.$BND :CSS $PCPT :QT :SYS :CLEV 3))
    :CSS   $CS  :CLEV  1)
   ("$MOT" "Motor" $CS.$MOT NIL NIL :QT :SYS :CSS $CS :CLEV 1)
   ("$MIS" "Misc" $CS.$MIS NIL NIL :QT :SYS :CSS $CS :CLEV 1))
  :CSS  $CS :CLEV 0)))|#



;;*MASTER-CSART-CAT-DB 
;; (was *MASTER-CSART-CAT-DB)
;; ==== ORIGINAL USED TO CREATE *CS-CAT-DB-TREE =======
;; EDIT THIS and NOT *CS-CAT-DB-TREE
;; Use MAKE-CSYM-TREE and MAKE-CSART-SYMS functions to 
;; make REVISED TREES AND CSYMS
;;USE NEW: (pprint-lists (make-csym-tree *MASTER-CSART-CAT-DB))
;; (pprint (make-csym-tree :top-csyms '($CS )))

;; STEPS: 1. (setf *CS-CAT-DB-CSYMS (MAKE-CSYM-TREE :TOP-CSYMS '($CS)))
;;               2. (setf *CS-CAT-DB-TREE (PPRINT-LISTS  *CS-CAT-DB-CSYMS))
;;
;;REVISED 2020-0
;;THIS IS A COPY OF NEW MASTER IN CS-Top-System.lisp

(Defparameter *MASTER-CSART-CAT-DB-COPY
  ;;$CS = ROOT LEVEL 0  :S INCLS ALL TOP CSYMS (no matter which level)
  '(($CS ("$CS" "All Main Systems" $P.$CS NIL NIL  :CSS $P   :S ($EXC  $PC  $ELM $EP  $PCPT $LNG $BHB $BOD $EMOT $MIS ) :QT :SYS :CLEV  0))  ;;was $OUTC
      ;;FIRST ORDER (Brain systems, key abstract CS types-systems):QT :SYS :CLEV  1
      ;;$EXC: Executive Brain System: PF Cortex LEVEL 1
      ( $EXC ("$EXC" "Executive" NIL  NIL NIL :CSS $CS :S ($BV $GPL  $SKL $DOM )  :QT :SYS :CLEV  1))
      ;;$EXC Subsystems
      ;;$BV
      ($BV ("$BV""Beliefs-Values"  NIL  NIL NIL  :CSS $EXC :S ($TBV $HISF  $WV $SLF ) :doc "Belief-Value"   :QT :SYS :CLEV  2))
      ($TBV ("$TBV""Top Belief-Value"   NIL  NIL NIL  :CSS $BV
             :S (<sT2SocIntimNoFam  <sT3FamCare  <sT4SuccessStatusMater 
                              <sT5-OrderPerfectionGoodness  <sT6GodSpiritRelig 
                              <sT7ImpactChallengeExplor  <sT8AttentionFunEasy  
                            <sT9ValueSelfAllUncond  <sT10OvercmProbAcceptSelf 
                            <sT11DutyPunctual  ;;ethics & fears
                                <sethbel  <sgrfears)  :QT :SYS :CLEV  2))
      ($HISF ("$HISF" "Higher Self" NIL  NIL NIL  :CSS $BV :S (<sT1HigherSelf)   :QT :SYS :CLEV  2))
       ;;higher level goals and plans, cutting across areas.
      ($GPL ("$GPL" "SupOrd Goals&Plans" NIL NIL NIL  :CSS $EXC  :S NIL :QT :SYS :CLEV  2 ))
      ($WV ("$WV""Worldview"  NIL  NIL NIL  :CSS $BV :S (<sworldview   )    :QT :SYS :CLEV  2))
      ( $SLF ("$SLF""Self"  NIL  NIL NIL  :CSS $BV :S (<stbslfwo <sslfconf $BIO)  :CSS $  :QT :SYS :CLEV  3))
      ($BIO ("$BIO" "Bio Info" NIL NIL NIL :CSS $SLF :CLEV 4 :QT :SYS :S NIL))
      ;;$DOM: Higher order domains of integrated knowledge/skills/etc.
      ($DOM ("$DOM" "Domain" NIL NIL NIL  :CSS $EXC :S ($PERS $OREL $CARR $ACAD   $TBD) :QT :SYS :CLEV  2))
      ($PERS ("$PERS" "Personal Domain"  NIL NIL NIL :CSS $DOM :S nil  :QT :SYS :CLEV  2)) ;;not work (<BIO-TEXT)
      ($OREL ("$OREL" "Relationship Outcomes" NIL  NIL NIL :S (<srpeople) :CSS $DOM   :QT :SYS :CLEV  4))
      ($CARR ("$CARR" "Career Domain"  NIL NIL NIL  :CSS $DOM :S ($CARI $OCAR) :QT :SYS :CLEV  2)) 
      ($CARI ("$CARI" "Career Interest"   NIL NIL NIL  :CSS $CARR :S NIL :QT :SYS :CLEV  4))
      ($OCAR ("$OCAR" "Career Outcomes"  NIL  NIL NIL :S NIL :CSS $CARR   :QT :SYS :CLEV  4))      
      ($ACAD ("$ACAD" "Academic Domain"   NIL NIL NIL :CSS $DOM :QT :SYS :CLEV  2 :S (<acad-ach)))    
     ;;$SKL: Higher Cognitive Skills--Procedural Memory
      ( $SKL  ("$SKL" "Supord Cog Skills"  NIL  NIL NIL :CSS $EXC :S  ($SM $LNRE $INTP $MECH $MAIN)   :QT :SYS :CLEV  2))
      ;;HIGHER LEVEL (mostly cognitive) SKILLS
      ;;Self-Management Skills
      ($SM ("$SM" "Self-Management" NIL NIL NIL :CSS $SKL :QT :SYS :CLEV  2 
            :S (<sselfman $PS $DM $PLN $COP)))
      ($PS ("$PS" "ProbSolv" NIL NIL NIL :S  NIL  :CSS $SM :QT :SYS :CLEV  3))
      ($DM ("$DM" "DecMaking" NIL NIL NIL :CSS $SM :S  NIL  :QT :SYS :CLEV  3))
      ($PLN  ("$PLN" "Planning" NIL NIL NIL :CSS $SM  :S  NIL  :QT :SYS :CLEV  3))
      ($COP   ("$COP" "EmotCope" NIL NIL NIL :CSS $SM :S (<semotcop )  :QT :SYS :CLEV  3))
      ($LNRE   ("$LNRE" "Learn/Research" NIL NIL NIL :CSS $SKL  :QT :SYS :CLEV   3 :S (<ACAD-LEARNING) ))
      ;;NOT (<ssl1ConfidEfficStudyTest <ssl1bConfidNotAvoidStudy                <ssl2SatisCampusFacFriendsGrdes   <ssl3WriteReadSkills   <ssl4BldMentalStruct               <ssl5BasicStudySkills  <ssl6SelfmanAcadGoals <ssl7MathSciPrinc  <ssl8StudyEnvir               <ssl9AttendHW  <ssl10MemNotAnx <ssl11NotNonAcadMot               <ssl12StdyTmAvail   <ssl13VerbalApt  <ssl14MathApt )     

      ($INTP ("$INTP" "Interpersonal Skill"  NIL NIL NIL :CSS $SKL :QT :SYS :CLEV  3               :S ( <IntSS1aAssertCR  <IntSS1bOpenHon  <IntSS2Romantc   <IntSS3LibRole                   <IntSS4LoveRes   <IntSS5Indep    <IntSS6PosSup   <IntSS7Collab )))       ($MECH  ("$MECH" "Mech" NIL NIL NIL :CSS $SKL :QT :SYS :CLEV  3))
      ($MAIN  ("$MAIN" "Mainenance" NIL NIL NIL :CSS $SKL  :QT :SYS :CLEV   3))

      ;;$KNW: Semantic Memory/Knowledge
      ( $KNW ("$KNW" "Knowledge"  NIL NIL NIL :S ($NSC $SSC $BSC $ART $BUS $ENGR $KHTH $SPT $REC $MECH $MAIN)   :QT :SYS :CLEV  1))
      ($NSC ("$NSC" "NatSci" NIL NIL NIL :CSS $KNW :QT :SYS :CLEV  3))
      ($SSC ("$SSC" "SocSci" NIL NIL NIL :CSS $KNW :QT :SYS :CLEV  3))
      ($BSC ("$BSC" "BehSci" NIL NIL NIL :CSS $KNW :QT :SYS :CLEV  3))
      ($ART ("$ART" "Art" NIL NIL NIL :CSS $KNW :QT :SYS :CLEV  3))
      ($BUS ("$BUS" "Bus" NIL NIL NIL :CSS $KNW :QT :SYS :CLEV  3))
      ($ENGR ("$ENGR" "Engr" NIL NIL NIL :CSS $KNW :QT :SYS :CLEV  3))
      ($KHTH ("$KHTH" "Health Knowl" NIL NIL NIL :CSS $KNW :CLE 3))
      ($SPT ("$SPT" NIL NIL NIL NIL :CSS $KNW :QT :SYS :CLEV  3))
      ($REC ("$REC" "Recreat" NIL NIL NIL :CSS $KNW :QT :SYS :CLEV  3))

      ;;$PC: Personal Constructs--mostly beliefs, but mixture
      ($PC ("$PC" "Personal Construct" NIL NIL NIL :CSS $CS  :S NIL :QT :SYS :CLEV  1))
      ;; NOT CLASSIFIED ELEMENTS, ETC.
      ($MIS ("$MIS" "Misc"  NIL  NIL  NIL NIL :S NIL :QT :SYS :CLEV  1))

      ;;$EP: Episodic Memory, memory for events. Hippocampus-related?
      ($EP ("$EP""Episode"  NIL  NIL NIL :S ($SCR $EVT)   :QT :SYS :CLEV  2))
      ;;Episodic
      ( $SCR ("$SCR" "Script"  NIL  NIL NIL :S NIL   :QT :SYS :CLEV  3))
      ( $EVT ("$EVT""Event"  NIL  NIL NIL :S NIL   :QT :SYS :CLEV  3))

      ;;ELM: Elements: People, Objects. Integrated perceptions/events.
      ( $ELM ("$ELM""Element"  NIL  NIL NIL :CSS $CS  :S ( $PER $GRP $OBJ)    :QT :SYS :CLEV  1))
      ;;Elements
      ;;($GOL ("$GOL" "Goals" NIL NIL NIL :S NIL  :QT :SYS :CLEV  3))
      ( $PER ("$PER""Person"  NIL  NIL NIL :CSS $ELM :S NIL   :QT :SYS :CLEV  3))
      ( $GRP ("$GRP""Group"  NIL  NIL NIL :CSS $ELM  :S ($REFG )   :QT :SYS :CLEV  3))
      ( $REFG ("$REFG" "Reference Group"  NIL  NIL NIL :CSS $GRP  :S ($FAM )  :QT :SYS :CLEV  3))
      ( $FAM ("$FAM" "Family"  NIL  NIL NIL :CSS $REFG  :S NIL   :QT :SYS :CLEV  3))
      ( $OBJ ("$OBJ""Object"  NIL  NIL NIL :CSS $ELM  :S NIL   :QT :SYS :CLEV  3))

      ;;$PCPT: Higher Percept integration of sensory?
      ( $PCPT ("$PCPT""Percept"  NIL  NIL NI :CSS $SC   :QT :SYS :CLEV  1 :S ( $IMG $SOND $SML $TST $TCT $BND ) ))
      ;;Percept-sense
      ( $IMG ("$IMG""Image"  NIL  NIL NIL :CSS $PCPT :S NIL    :QT :SYS :CLEV  3))
      ( $SOND ("$SOND""Sound"  NIL  NIL NIL :CSS $PCPT :S NIL    :QT :SYS :CLEV  3))
      ( $SML  ("$SML" "Smell"  NIL  NIL NIL :CSS $PCPT :S NIL    :QT :SYS :CLEV  3))
      ( $TST  ("$TST""Taste"  NIL  NIL NIL :CSS $PCPT :S NIL    :QT :SYS :CLEV  3))
      ( $TCT ("$TCT""Tactile"  NIL  NIL NIL :CSS $PCPT :S NIL    :QT :SYS :CLEV  3))
      ($BND  ("$BND" "Bio Need" $CS.$PCPT.$BND NIL  NIL NIL :CSS $PCPT :QT :SYS :CLEV  3))

      ( $LNG ("$LNG""Language"  NIL  NIL NIL :S ($VER $MTH $LOG)   :QT :SYS :CLEV  1))
      ;;Language
      ( $VER ("$VER" "Verbal"   NIL  NIL NIL :CSS $LNG :S NIL    :QT :SYS :CLEV  3))
      ( $MTH ("$MTH""Math"  NIL  NIL NIL :CSS $LNG :S NIL    :QT :SYS :CLEV  3))
      ( $LOG  ("$LOG""Logic"  NIL NIL NIL :CSS $LNG :S NIL :QT :SYS :CLEV  3))
     
      ;;$BHB: Behavioral Habits Procedural Memory (programed?)
      ($BHB  ("$BHB" "Behavioral Habit"  NIL  NIL NIL :CSS $CS :S ($SIT $R)    :QT :SYS :CLEV  3)) 
            ($SIT ("$SIT""Situation" NIL NIL NIL :CSS $BHB :S  ($TBD)  :QT :SYS :CLEV  4))
            ($TBD ("$TBD""ToBeDeterm"  NIL  NIL NIL :CSS $SIT :QT :SYS :CLEV  2))
            ($R ("$R" "Responses" NIL  NIL NIL :CSS $BHB :S ($MOT) :QT :SYS :CLEV  4))
      ;;Pure motor--overlap or part of parietal?
      ( $MOT ("$MOT""Motor"  NIL  NIL NIL :CSS $R  :S NIL    :QT :SYS :CLEV  5))    

      ;;LEVEL 5: NON-COGNITIVE SYSTEMS
      ;;Body-Health
      ($BOD ( "Body-Health" NIL NIL NIL :S ($HLTH) :QT :SYS :CLEV  5))
      ($HLTH ("$HLTH" "Health" NIL NIL NIL :CSS $BOD :S (<srelhlth) :QT :SYS :CLEV  5))

      ;;$OUTC: Outcomes--Emotional, Health, Career, Relations, etc.
     ;;( $OUTC ("$OUTC" "Outcome-Emotion"  NIL  NIL NIL :S ($EMOT $OREL $OCAR)     :QT :SYS :CLEV  1))  
      ;;Emotions: 
      ;;$EMOT: Emotion--Limbic, etc See $OUT to match shaq 
      ($EMOT ("$EMOT" "Emotions" NIL NIL NIL :CSS $CS :QT :SYS :CLEV  4 :S ($HAP $CARE $ANX $ANG $DEP)))
      ($HAP ("$HAP""Happy" NIL  NIL NIL :S (<sehappy) :CSS $EMOT   :QT :SYS :CLEV  5))
      ($CARE ("$CARE""Caring"  NIL  NIL NIL :S NIL :CSS $EMOT :QT :SYS :CLEV  5))
      ($ANX ("$ANX""Anxiety"  NIL NIL NIL :S (<sranxiet)  :CSS $EMOT  :QT :SYS :CLEV  5))
      ($ANG ("$ANG" "Anger"  NIL  NIL NIL :S (<srangagg) :CSS $EMOT  :QT :SYS :CLEV  5))
      ($DEP ("$DEP""Depression"  NIL  NIL NIL :S (<srdepres) :CSS $EMOT  :QT :SYS :CLEV  5))
      )
  "All CSART category symbols where each list= (long-csartsym (short-csartsym :S subcsyms-list :QT :SYS :CLEV  integer; where :QT :SYS :CLEV  is the category abstraction/brain level [1=top]")


#|(Defparameter *MASTER-CSART-CAT-DB
  ;;$CS = ROOT LEVEL 0  :S INCLS ALL TOP CSYMS (no matter which level)
  '(($CS ("$CS" "All Main Systems" $CS NIL NIL NIL    :S (  $EXC   $KNW $LNG  $EP $ELM   $EMT $PCPT $MOT $MIS ) :clev 0))
    ;;FIRST ORDER (Brain systems, key abstract CS types-systems) :CLEV 1
    ;;Executive Brain System: PF Cortex LEVEL 1
    ( $EXC ("$EXC" "Executive" NIL  NIL NIL :S ($TBV  $WV  $CSK $BSK  )   :clev 1))
    ;;Semantic Memory
    ( $KNW ("$KNW" "Knowledge"  NIL NIL NIL :S ($NSC $SSC $BSC $ART $BUS $SPT $REC)   :clev 1))
    ;; NOT CLASSIFIED ELEMENTS, ETC.
    ($MIS ("$MIS" "Misc"  NIL  NIL  NIL NIL :S NIL :clev 1))

    ;;LEVEL 2 EXEC-RELATED
    ;;Higher Procedural Memory (programed?); Lower PFC?
    ( $CSK  ("$CSK" "Cognitive Skill"  NIL  NIL NIL :S  ($PS $DM $PLN  $COP $RESN )   :clev 2))
    ;;Behavioral Habits Procedural Memory (programed?), Pariatal?
    ( $BSK  ("$BSK" "Behavioral Skill"  NIL  NIL NIL :S  ($PEOP $MECH $MAIN )   :clev 2)) 
    ;;OTHER LEVEL 1  COGNITIVE-RELATED SYSTEMS 
    ;;Situations @ domains, if an element, skill, etc, put under those cats first.
    ("$DOM" "Domain" NIL :S ($PERS $CAREER $ACAD) :CLEV 1)
    ("$SIT""Situation" NIL :S  ($TBD)         :CLEV 1)
    ;;Episodic Memory; Hippocampus-related?
    ( $EP ("$EP""Episode"  NIL  NIL NIL :S ($SCR $EVT)   :clev 1))
    ;;Elements: People, Objects, etc.
    ( $ELM ("$ELM""Element"  NIL  NIL NIL :S ($PER $OBJ)    :clev 1))
    ;;Higher Percept integration of sensory?
    ( $PCPT ("$PCPT""Percept"  NIL  NIL NIL :S ($VER $IMG $SOND $SML $TST $TCT $BND )   :clev 1))
    ( $LNG ("$LNG""Language"  NIL  NIL NIL :S ($VER $MTH)   :clev 1))

    ;;LEVEL 1 NON-COGNITIVE SYSTEMS
    ;;Emotions: Limbic, etc
    ( $EMT ("$EMT""Emotion"  NIL  NIL NIL :S  ($HAP $CAR $ANX $ANG $DEP  )    :clev 1))    
    ;;Pure motor--overlap or part of parietal?
    ( $MOT ("$MOT""Motor"  NIL  NIL NIL :S NIL    :clev 1))    

    ;;SECOND ORDER: mostly HIGHER ORDER $EXEC and $KNOWB currently
    ;;END :CLEV 1 --MOSTLY BRAIN SYSTEMS

    ;;SUBSYSTEMS OF :CLEV 1 (CLEV 2, 3, 3TC)
    ( $BV ("$BV""Belief-Value"  NIL  NIL NIL :S ($TBV $HISF  $WV) :doc "Belief-Value"    :clev 2))
    ( $TBV ("$TBV""Top Belief-Value"   NIL  NIL NIL :S NIL   :clev 2))
    ( $WV ("$WV""Worldview"  NIL  NIL NIL :S ($SLF $REFG )    :clev 2))
    ( $HISF ("$HISF" "Higher Self" NIL  NIL NIL :S NIL    :clev 2))
    ($TBD ("$TBD""ToBeDeterm"  $CS.$EXC.$SIT.$TBD NIL NIL :CSS $SIT :clev 2))
    ($PERS ("$PERS" "Personal Domain" NIL NIL NIL :S :clev 2))
    ($CAREER ("$CAREER" "Career Domain"   NIL NIL NIL :S :clev 2))
    ($ACAD ("$ACAD" "Academic Domain"   NIL NIL NIL :S :clev 2))

    ;;THIRD ORDER: More specific objects, events, percepts, emotions, etc
    ;;Element
    ($GOL ("$GOL" "Goals" NIL NIL NIL :S NIL  :CLEV 3))
    ( $SLF ("$SLF""Self"  NIL  NIL NIL :S NIL   :clev 3))
    ( $OBJ ("$OBJ""Object"  NIL  NIL NIL :S NIL   :clev 3))
    ( $PER ("$PER""Person"  NIL  NIL NIL :S NIL   :clev 3))
    ( $GRP ("$GRP""Group"  NIL  NIL NIL :S ($RFGP )   :clev 3))
    ( $REFG ("$REFG" "Reference Group"  NIL  NIL NIL :S ($FAM )    :clev 3))
    ( $FAM ("$FAM" "Family"  NIL  NIL NIL :S NIL   :clev 3))
    ($PS ("$PS" "ProbSolv" NIL NIL NIL :CSS $CSK :clev 3))
    ($DM ("$DM" "DecMaking" NIL NIL NIL :CSS $CSK :clev 3))
    ($PLN  ("$PLN" "Planning" NIL NIL NIL :CSS $CSK :clev 3))
    ($COP   ("$COP" "EmotCope" NIL NIL NIL :CSS $CSK :clev 3))
    ($RESN   ("$RESN" "ResearchLearn" NIL NIL NIL :CSS $CSK :CLEV  3))
    ($PEOP ("$PEOP" "People Skill"  NIL NIL NIL :CSS $BSK :clev 3))
    ($MECH  ("$MECH" "Mech" NIL NIL NIL :CSS $BSK :clev 3))
    ($MAIN  ("$MAIN" "Mainenance" NIL NIL NIL :CSS $BSK  :CLEV  3))
    ($NSC ("$NSC" "NatSci" NIL NIL NIL :CSS $KNW :clev 3))
    ($SSC ("$SSC" "SocSci" NIL NIL NIL :CSS $KNW :clev 3))
    ($BSC ("$BSC" "BehSci" NIL NIL NIL :CSS $KNW :clev 3))
    ($ART ("$ART" "Art" NIL NIL NIL :CSS $KNW :clev 3))
    ($BUS ("$BUS" "Bus" NIL NIL NIL :CSS $KNW :clev 3))
    ($SPT ("$SPT" NIL NIL NIL NIL :CSS $KNW :clev 3))
    ($REC ("$REC" "Recreat" NIL NIL NIL :CSS $KNW :clev 3))
    ;;Episodic
    ( $SCR ("$SCR" "Script"  NIL  NIL NIL :S NIL   :clev 3))
    ( $EVT ("$EVT""Event"  NIL  NIL NIL :S NIL   :clev 3))
    ;;Language
    ( $VER ("$VER" "Verbal"   NIL  NIL NIL :S NIL    :clev 3))
    ( $MTH ("$MTH""Math"  NIL  NIL NIL :S NIL    :clev 3))
    ( $LOG  ("$LOG""Logic"  NIL NIL NIL :S NIL :clev 3))
    ;;Percept-sense
    ( $IMG ("$IMG""Image"  NIL  NIL NIL :S NIL    :clev 3))
    ( $SOND ("$SOND""Sound"  NIL  NIL NIL :S NIL    :clev 3))
    ( $SML  ("$SML" "Smell"  NIL  NIL NIL :S NIL    :clev 3))
    ( $TST  ("$TST""Taste"  NIL  NIL NIL :S NIL    :clev 3))
    ( $TCT ("$TCT""Tactile"  NIL  NIL NIL :S NIL    :clev 3))
    ($BND  ("$BND" "Bio Need" $CS.$PCPT.$BND :CSS $PCPT :CLEV 3))
    ;;Emotion
    ($HAP ("$HAP""Happy" NIL  NIL NIL :S NIL    :clev 3))
    ($CAR ("$CAR""Caring"  NIL  NIL NIL :S NIL    :clev 3))
    ($ANX ("$ANX""Anxiety"  NIL NIL NIL :S NIL    :clev 3))
    ($ANG ("$ANG" "Anger"  NIL  NIL NIL :S NIL    :clev 3))
    ($DEP ("$DEP""Depression"  NIL  NIL NIL :S NIL    :clev 3))
    )
  "All CSART category symbols where each list= (long-csartsym (short-csartsym :S subcsyms-list :clev integer; where :clev is the category abstraction/brain level [1=top]")|#


;;SIMPLE LIST OF ALL NEW CS-CATEGORIES (from $CS
(Defparameter *CS-CATEGORIES  '($CS $MIS $EXC $KNW $CSK $BSK $EP $ELM $PCPT $LNG $EMT $MOT $BV $TBV $WV $HISF $SLF $SBIO$OBJ $PER $GRP $REFG $FAM $SCR $EVT $VER $MTH $LOG $IMG $SOND $SML $TST $TCT $HAP $CAR $ANX $ANG $DEP) "Simple $CS cat list. Update using (get-nth-in-all-lists 0 *MASTER-CSART-CAT-DB)")

  
;; ALL DB-TYPES
#|(Defparameter *$CS-SUBTYPES '($TOPBV $WRLDVW $SELF $REFGRP $VALUE  $BELIEF  $KNOWB $COGSK $BEHSK  $SCRIPT $EVENT $ELM) "Separate DB-ITEM TYPES. Each item a separate entity, Can have LINKS (eg BIPATHS where a linked db-item is listed in the BIPATH, etc.")|#
;;(Defparameter  *ALL-CS-BRAIN-SYSTEMS '($CS  $VERBAL        $IMAGE       $SOUND       $SMELL       $TASTE       $TACTILE       $EMOTION       $MOTOR))
;;(Defparameter *ALL-CS-DB-ITEM-FEATURES *ALL-CS-BRAIN-SYSTEMS)

#|(defparameter *CS-CATEGORIES '((CS (BV (TOPV (HS () ))(TOPB (WV ()  )))  (ROLES ( ))  (LBS (SM ()) (COPE ()) (LRN ()) (INTR ()) (HLTH ()) (CAR ()) (MANU ()) (ATHL ())))(EMOT (HAP)(CARE)(ANX)(DEP)(ANG))  (SENS (VIS)(AUD)(PROP))(MOT))     "WV= worldview, LBS=LifeBeliefsSkills, SM COPE LRN INTR=Interpers, HLTH CAR MANU ATHL")|#



;;(defparameter *CSART-CAT-SYMS (make-csartcat-syms)) ;; :omit-long-sym-p NIL)) 
;;current *CSART-CAT-SYMS
;;=> ($EXC $KNW $CSK $BSK $EP $ELM $PCPT $LNG $EMT $MOT $BV $TBV $WV $HISF $SLF $OBJ $PER $GRP $REFG $FAM $SCR $EVT $VER $MTH $IMG $SOND $SML $TST $TCT $HAP $CAR $ANX $ANG $DEP)
;;EG.(omit-long-sym-p)  $EXC  =>  ($EXC "Executive" :S ($TBV $TBE $WV $KNW $CSK $BSK $EP $ELM $PCPT) :CLEV 1)
;;EG. (null omit-long-sym-p) $EXC  => ($EXC "Executive" :S ($TBV $TBE $WV $KNW $CSK $BSK $EP $ELM $PCPT) :CLEV 1 :LS $EXEC)




;;MAKE-CSARTSYS-TREE-SPEC-LIST
;;2019
;;ddd
#|(defun make-csartsys-tree-spec-list (&key (cs-cats-db '*MASTER-CSART-CAT-DB)
                                          (for-clev 1) (clev-key :clev)
                                     ;;(cs-categories *csart-cat-syms) 
                                         ;;not needed (tree-dimroots-sym '*tree-dimroots) 
                                           (sublist-key :S))
  "CS-config. Uses *csart-cat-symbols to make *CSARTSYS-TREE-SPEC-LIST land a *tree-dimroots"
  (let*
      ((cs-tree-spec-list)
       ;;here1
       )
    ;; START HERE FINISH make-csartsys-tree-spec-list --FIND OLD ONE
    (multiple-value-bind (csart-cat-syms  tree-dimroots)
        (make-csartcat-syms :catsym-db cs-cats-db :omit-long-sym-p T)

    (loop
     for cscat in csart-cat-syms
     do
     (let*
         ((catlist (eval cscat))
          (subcats (get-key-value sublist-key catlist))
          (subtree (list cscat (list )))
          (clev (get-key-value clev-key for-clev catlist))
          )
       ;;ONLY PROCESS CSCATS AT FOR-CLEV
       (When (equal clev for-clev)
         (
          ))

    ;;SSSSS FINISH
       ;;end let,loop
       ))
    (when set-tree-dimroots
      (set set-tree-dimroots tree-dimroots))
    (values cs-tree-spec-list tree-dimroots)
    ;;end let, mvb, make-csartsys-tree-spec-list
    )))
;;TEST
;;  (make-csartsys-tree-spec-list)
|#


;;MAKE-SUBTREE-SPECLIST
;;2019
;;ddd
#|(defun make-subtree-speclist (csartsym  &key csartdims  (sublist-key :S)
                                        for-clev (clev-key :clev))
  "   RETURNS    INPUT:  "
  (let*
      ((csymvals (when (boundp csartsym) (eval csartsym)))
       (csym
       (subsyms (get-key-value sublist-key csymvals))
       (clev) 
       )
  ;;If no for-clev or is right clev, process the csartsym
  (when (or (null for-clev)
            (and for-clev 
                 (equal for-clev (setf clev (get-key-value clev-key csymvals)))))   
    (loop
     for csym in subsyms
     do
     (let*
         ((x)
          )
    (cond
     (
      )
     (
      )
     (t nil))
     
     ;;end let,loop
     ))

    ;;END WHEN
    )

    (values    )
    ;;end let, make-subtree-speclist
    ))  )|#
;;TEST
;; (make-subtree-speclist 





;;no longer needed-done in make-csartsys-tree-spec-list (setf *tree-dimroots '(($CS)( $VER) ($IMG)( $SND$)( $SML)( $TST)($EMT)( $MOT)))
;; '(($CS $VER $IMG $SND$ $SML $TST $EMT $MOT)))

#|(Defparameter *CSARTSYS-TREE-SPEC-LIST
  (make-csartsys-tree-spec-list) "Makes a current *CSARTSYS-TREE-SPEC-LIST")|#

 #|OLDER-WAS  '(($CS  
                                          (($TBV ($WV (($SLF )($REFG )($FAM )) ))
                                          ($KNW (($NSC )($BSC  )($SSC )($ART )($BUS)
                                                 ( $SPT )($REC)))
                                          ($CSK (($LRN )($RESN ($MTH )($LOG ))))
                                          ($SM (($PS )($DM )($PLN )($COP)($HTH)($FIN)))
                                          ($CAR)                                                     
                                          ($BSK (($PEOP )($MECH )($MAIN )($ATH )($MAN)))
                                          ($SCR ($ROLE))
                                          ($EVT (($PER )($HIST )($HYP)))
                                          ($ELM (($PEO )($OBJ )($ANM)))))
                                         ($VER (($GRA )($SEN )($WRD)))
                                         ($IMG)( $SND$)( $SML)( $TST)
                                         ($EMT (($HAP )($LOV  )($ANX )($ANG )($DEP)))
                                         ($MOT ($SPH ))
                                         ))|#
;;"Use *CSART-CAT-TREE ONLY for category syms.  Use the MOST SPECIFIC 
#|ORIGINAL, BUT DEPRECIATED
(Defparameter *CSART-CATS-TREE
  '((($CS)   $CS  :S
     ((($CS $TBV)    $CS.$TBV    :S
       (($CS $TBV $WV)     $CS.$TBV.$WV     :S
        ((($CS $TBV $WV $SLF) $CS.$TBV.$WV.$SLF)
         ((R $CS $EXC $WV $SLF $BIO) R.$CS.$EXC.$WV.$SLF.$BIO)         (($CS $TBV $WV $REFG) $CS.$TBV.$WV.$REFG)
         (($CS $TBV $WV $FAM) $CS.$TBV.$WV.$FAM))))
      (($CS $KNW)    $CS.$KNW    :S
       ((($CS $KNW $NSC) $CS.$KNW.$NSC)
        (($CS $KNW $BSC) $CS.$KNW.$BSC)
        (($CS $KNW $SSC) $CS.$KNW.$SSC)
        (($CS $KNW $ART) $CS.$KNW.$ART)
        (($CS $KNW $BUS) $CS.$KNW.$BUS)
        (($CS $KNW $SPT) $CS.$KNW.$SPT)
        (($CS $KNW $REC) $CS.$KNW.$REC)))
      (($CS $CSK)    $CS.$CSK    :S
       ((($CS $CSK $LRN) $CS.$CSK.$LRN)
        (($CS $CSK $RESN)      $CS.$CSK.$RESN      :S
         (($CS $CSK $RESN $MTH) $CS.$CSK.$RESN.$MTH)
         (($CS $CSK $RESN $LOG) $CS.$CSK.$RESN.$LOG))))
      (($CS $SM)    $CS.$SM    :S
       ((($CS $SM $PS) $CS.$SM.$PS)
        (($CS $SM $DM) $CS.$SM.$DM)
        (($CS $SM $PLN) $CS.$SM.$PLN)
        (($CS $SM $COP) $CS.$SM.$COP)
        (($CS $SM $HTH) $CS.$SM.$HTH)
        (($CS $SM $FIN) $CS.$SM.$FIN)))
      (($CS $CAR) $CS.$CAR)
      (($CS $BSK)    $CS.$BSK    :S
       ((($CS $BSK $PEOP) $CS.$BSK.$PEOP)
        (($CS $BSK $MECH) $CS.$BSK.$MECH)
        (($CS $BSK $MAIN) $CS.$BSK.$MAIN)
        (($CS $BSK $ATH) $CS.$BSK.$ATH)
        (($CS $BSK $MAN) $CS.$BSK.$MAN)))
      (($CS $SCR) $CS.$SCR :S (($CS $SCR $ROLE) $CS.$SCR.$ROLE))
      (($CS $EVT)    $CS.$EVT     :S
       ((($CS $EVT $PER) $CS.$EVT.$PER)
        (($CS $EVT $HIST) $CS.$EVT.$HIST)
        (($CS $EVT $HYP) $CS.$EVT.$HYP)))
      (($CS $ELM)    $CS.$ELM    :S
       ((($CS $ELM $PEO) $CS.$ELM.$PEO)
        (($CS $ELM $OBJ) $CS.$ELM.$OBJ)
        (($CS $ELM $ANM) $CS.$ELM.$ANM)))))
    (($VER)  $VER  :S
     ((($VER $GRA) $VER.$GRA) (($VER $SEN) $VER.$SEN) (($VER $WRD) $VER.$WRD)))
    (($IMG) $IMG)
    (($SND$) $SND$)
    (($SML) $SML)
    (($TST) $TST)
    (($EMT)  $EMT  :S
     ((($EMT $HAP) $EMT.$HAP)
      (($EMT $LOV) $EMT.$LOV)
      (($EMT $ANX) $EMT.$ANX)
      (($EMT $ANG) $EMT.$ANG)
      (($EMT $DEP) $EMT.$DEP)))
    (($MOT) $MOT :S (($MOT $SPH) $MOT.$SPH)))
 "Use *CS-CATS-TREE only for category syms.  Use the MOST SPECIFIC CAT AS THE BEGIN CAT for individual cells, etc.")|#






;;LOAD-MY-UTILITY-FILES
;;2020 revised
;;ddd
(defun load-MY-UTILITY-files ()
  ;;these should load in .lispworks
  (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-BASIC-functions.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-function-plotter.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-files.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-lists.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-file&buffers.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-file&buffers-frames.lisp")
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

  (defparameter *my-utility-files-loaded-p T)
  ;;end load-MY-UTILITY-files
  )
 ;;LOAD-MY-UTILITY-FILES?
 (when (OR (and (boundp '*load-MY-UTILITY-files-p) *load-MY-UTILITY-files-p)
   (and (boundp '*my-utility-files-loaded-p) *my-utility-files-loaded-p))
   (load-MY-UTILITY-files))


;;LOAD-CS-UTILITY-FILES
;;2020 revised
;;ddd
(defun load-CS-UTILITY-files ()
  ;;FROM ART
  ;;(load "C:\\3-TS\\LISP PROJECTS TS\\SHAQ\\U-data-functions.lisp")
  ;;(load "C:\\3-TS\\LISP PROJECTS TS\\ART-Utilities\\ART-multipane-interface.lisp")
  ;;(load "C:\\3-TS\\LISP PROJECTS TS\\ART-Utilities\\U-art-math-utilities.lisp")
  ;;(load "C:\\3-TS\\LISP PROJECTS TS\\ART-Utilities\\ART-data-analysis.lisp")
  ;;(load "C:\\3-TS\\LISP PROJECTS TS\\ART-Utilities\\ART-inputs.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\cogsys-model\\U-CS-ART.lisp")

  ;;CogSys-Model files
  ;;Modifications? of ART files?
  ;;Config files
  ;;THIS FILE--DON'T LOAD IT FROM HERE
  ;;THIS FILE (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CS-config.lisp")
  ;;LOADED SEPARATELY
  ;; (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-config.lisp")

  ;;CS UTILITY FILES
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\U-CS-ART.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\U-CS-symbol-trees.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\U-CS-data-results-functions.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\U-CS.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CS-csym-tree-viewer.lisp")
  ;;(load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\U-CSQ.lisp")
  ;;CS netviewer files
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CS-net-viewer.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CS-net-view-utils.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CS-netview-frames.lisp")
  ;;CS (CogSys) files
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CS-network.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-frames-intros.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CS-csym-tree-viewer.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CS-csym-trees.lisp")
  ;;LOAD TREEVIEW FILES??
  (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-trees.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CS-net-viewer.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-capi.lisp")
  
  (defparameter *cs-utility-files-loaded-p T)
  ;;end load-CS-UTILITY-files
  )
 ;;LOAD-CS-UTILITY-FILES?
 (when (OR (and (boundp '*load-CS-UTILITY-files-p) *load-CS-UTILITY-files-p)
   (and (boundp '*cs-utility-files-loaded-p) (null *cs-utility-files-loaded-p)))
   (load-CS-UTILITY-files))

;;LOAD-CS-MODEL-FILES
;;2020 revised
;;ddd
(defun load-CS-MODEL-files ()
  ;;model files
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CS-Top-System.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CS-PERSIM.lisp")  
  ;;CSQ-SHAQ INIT FILE(S)
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-config.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-value-rank-frame.lisp")
  ;;only SHAQ 
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-SHAQ-all-scale-and-question-var-lists.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-SHAQ-Frames.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-SHAQ-Frame-quest-functions.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CS-Explore.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CS-explore-Questions.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\help-info.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\help-links.lisp")
  ;;Other CSQ-SHAQ joint files
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-SHAQ-questions.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-SHAQ-new-scales.lisp")
  ;;CSQ only files (not incl utility files)
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-Manage.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-QVARS.lisp")
  ;;(BREAK "IN CS-CONFIG: After LOAD CSQ-QVARS.lisp, BEFORE CSQ-Questions.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-Questions.lisp")
  (load "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\CSQ-scales.lisp")

  ;;(load "C:\\3-TS\\LISP PROJECTS TS\\MyUtilities\\U-capi.lisp")
 ;;set parameter   
  (defparameter *CogSys-loaded-p T)
  ;;end load-CS-MODEL-files
  )

;;LOAD THE CS FILES
 (when (OR 
           (or (null (boundp '*load-CS-MODEL-files-p))
                    (and (boundp '*load-CS-files-p)
                   (null *load-CS-MODEL-files-p)))
          (not (and (boundp '*CogSys-loaded-p)
              *CogSys-loaded-p)))
   (load-CS-MODEL-files))


  ;;RUN HELP FUNCTIONS--use (MLI) INSTEAD
 ;; (when (null (boundp '*initial-help-functions))
   ;; DISPLAY A KEY BINDINGS WINDOW
 ;; (my-keybinds)
   ;; DISPLAY A TEMPLATE WINDOW open in buffer 0-CODE-TEMPLATES.lisp
  ;; (my-edit-file "C:/3-TS/LISP PROJECTS TS/CogSys-Model/0-CODE-TEMPLATES.lisp")
   ;; (pathnamep "C:/3-TS/LISP PROJECTS TS/CogSys-Model/0-CODE-TEMPLATES.lisp") = NIL
  ;; (defparameter *initial-help-functions T)
   ;;end when  *intial-help-functions
  ;;)



;;CS-ART-init
;;
;;ddd
(defun CS-ART-init (&key n-inputs n-outputs  (make-sublists-for-each-dim-p T)  
                            unbind-global-vars-p  return-flat-lists-p make-dimsyms-trees-p
                             ;;not needed?
                               prFefix)
  "In CS-config, INITIALIZES an ART3 network and creates strings, data lists, and arrays related to both running ART3 and analyzing and reporting it's data based upon lists. RETURNS (values new-symbol-type-list  new-symbols-type-list-of-lists  new-symbol-type-spec-list-of-lists  new-root-list  new-symbol-type-symbol-string-list-of-lists). GLOBAL VARS SET=  *new-seq-nested-lists  *new-symbol-nested-lists *new-dim-list-nested-lists) . Each symbol-type eval to a nested list of all its symbols. Each symbol evals to a spec-list eg."

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
    *Y-3-3-I-POINTS  ;; *y-points
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
          (CSM-F-L-I    ("CS"  ((,*n-bot-CSs 1 1)(3 1 1)(2 1 1)(2 1 1))) CS-points)
          (ELMM-F-L-I    ("ELM"  ((,*num-cs-qvar-elms   1 1)(1 1 1)(1 1 1)(1 1 1))) CS-points)
          ;;test versions
          ;;(CCM-F-L-I    ("CC"  ((4 1 1)(3 1 1)(2 1 1)(2 1 1))) CC-points) ;; = works
          ;;(ZzMM-F-L-I  ("ZzM" ((4 1 1 )(3 1 1)(2 1 1 )(1 1 1))) ZzMI-L-2-1-points) ;;= works
          ;; (ZzM-F-L-I  ("Zz"  ((4 1 1 )(3 1 1)(2 1 1 )(1 1 1))) ZzI-L-2-1-points) ;;= works
          ;;(ZM-F-L-I    ("Z"    ((4 1 1 )(3 1 1)(2 1 1 )(1 1 1))) ZI-L-2-1-points) ;;= works
          ;;(ELMX-M-F-L-I    ("ELMx"  ((3   1 1)(1 1 1)(1 1 1)(1 1 1))) CS-points)
          ;;(X-F-L-I           ("X"      ((,4 1 1 )(3 1 1)(2 1 1 ))) X-points)
          ;;(Y-M-F-L-I          ("Y"    ((4 1 1 )(3 1 1)(2 1 1 )(1 1 1))) YI-L-2-1-points)
          ;;(BF-L-I          ("B"    ((4 1 1 )(3 1 1)(2 1 1 ))) BI-L-2-points)

          #|(INPUT-F-L-I ("Input" ((,*1 1 ,*n-inputs)(1 1 1 )(1 1 1)))  input-points)
          ;;NOTE: can reuse the top-syms, just chane the dim-specs and all instances are combined in the subsyms list with eg X-F-L-I
          (X-F-L-I           ("X"      ((,*1 1 ,*n-inputs )(3 1 1)(2 1 1 ))) X-points)       
          (X-F-L-I           ("X"      ((,*n-outputs 1 1 )(3 1 1)(1 3 1 ))) X-3-L-I-points)         
          (Y-F-L-I           ("Y"    ((,*1 1 ,*n-inputs )(3 1 1)(2 1 1 ))) Y-2-L-I-points)   
          (Y-F-L-I           ("Y"    ((,*n-outputs 1 1 )(3 1 1)(1 3 1 ))) Y-3-L-I-points)   
         ;; ("X-Activity" ((,*1 1 ,*n-inputs )) )  ;;was X-Activity
         ;; ("V-Activity" ((,*1 1 ,*n-inputs )) )  ;;V-Activity
          (R-F-L-I  ("R" ((,*1 1 ,*n-inputs )(1 2 1)(1 2 1)) )) ;;used in RESET
          ;;("Q-Activity" ((,*1 1 ,*n-inputs )) )
          ;;not needed?? (PF-L-I  ("P"  ((,*1 1 ,*n-inputs)(3 1 1 )(3 1 1)))  )
          ;; (var-root (fromcelldim fromfielddim  tocelldim tofielddim))   EACH DIM SPEC= (N  begin incr end-str) 
          (WUP-F-L-I-TO-F-L-I  ("Wup" ((,*n-inputs  1 1)(1 3 1)(1 2 1   ) TO (,*n-outputs 1 1) (1 1 1   )(1 3 1 ))) wup-points)            ;;was ((,*1 1 ,*n-inputs ) (,*n-outputs 1 1) ))
          (WDN-F-L-I-TO-F-L-I ("Wdn" ((,*n-outputs 1 1  )(1 1 1   )(1 3 1   )TO (,*1 1 ,*n-inputs  )(1 3 1  )(1 2 1 ))) wdn-points)
          ;;(UUPF-L-ITOF-L-I ("Uup" ((,*1 1 ,*n-inputs)(1 3 1  )(1 2 1 )TO (,*n-outputs 1 1   )(1 1 1   )(1 3 1 ))) uup-points)        
          ;;(UDNF-L-ITOF-L-I ("Udn" ((,*n-outputs 1 1  )(1 1 1   )(1 3 1   ) TO (,*1 1 ,*n-inputs  )(1 3 1  )(1 2 1 ))) udn-points)
         ;; ("Y-Output" ((,*n-outputs 1 1)) )
          ;;others
         ;;("Temp" ((1 1 1 )) )
         (RESETNIN-F-L-I ("resetnin" ((,*1 1 ,*n-inputs  )(1 2 1 ) (2 2 1 ))) resetnin-points)
         (RESETNOUT-F-L-I ("resetnout" ((,*n-outputs 1 1  )(1 2 1 ) (2 2 1 ))) resetnout-points)
          ;;was (RESETF-L-I ("reset" ((,*1 1 ,*n-inputs  )(1 2 1 ) (2 2 1 ))) reset-points)
          ;;for ART3 F2
          ;;SSS  CHECK CREATION OF THE SYMVALS ETC
          ;;(RESET-NINPUTSI  ("reset-ninputs" ((,*1 1 ,*n-inputs))))
          ;;for ART3 F3
          ;;(RESET-NOUTPUTSI ("reset-noutputs" ((,*n-outputs 1 1)) ))
          (RESET-CNTR-F-L-I ("reset-cntr" ((,*n-outputs 1 1)(1 2 1)(1 2 1) )))
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
    ;;(if (> *print-details 0)  (afout 'out (format nil "1 symbol-spec-lists= ~A~%" symbol-spec-lists)))

    ;; USING NEW FUNCTIONS??
    (when make-dimsyms-trees-p
      (multiple-value-setq  (all-root-syms all-node-trees-syms all-path-syms-by-levels)
          (make-dimsyms-trees  symbol-spec-lists)))

    ;;SET THE SYMBOL-TYPE  =  (root-str dim-spec-list graph-slot default-value topsyms-list)
    ;;eg X  = ("X" ((5 1 1) (3 1 1) (3 1 1)) X-POINTS NIL ((X-F-L-I)))
    ;;eg WUP = ("Wup" (((5 1 1) (1 3 1) (1 2 1)) TO ((3 1 1) (1 1 1) (1 3 1))) WUP-POINTS NIL (WUP-F-L-I-TO-F-L-I))
    ;;old,was: (sym-root-str LIST OF INSTANCES)
    ;; eg. WDN = ((WDN1-1 ... WDN1-5) (WDN2-1 ...WDN2-5) (WDN3-1 ...WDN3-5))
    ;; The symbols were set to eg ("Wup" (2 4) 9) in a lower function
    ;; and the class symbol (eg. WUP set = ("Wup" ((WUP1-3-1TO1-1-2) (WUP1-3-1TO2-1-2) (WUP1-3-1TO3-1-2) (WUP2-3-1TO1-1-2) (WUP2-3-1TO2-1-2) (WUP2-3-1TO3-1-2) (WUP3-3-1TO1-1-2) (WUP3-3-1TO2-1-2) (WUP3-3-1TO3-1-2)))


    ;;ELMSYMS MADE IN CSQ-INIT

    ;;for convenience in calcs to check for reset
    (setf  *CS-ART-init-ran-p T)
     ;;*all-reset-syms (find-bottom-art-instances 'reset))

   
   ;;note global versions with * in front also created for each value below
   (values all-root-syms all-node-trees-syms all-path-syms-by-levels)
    ;;was new-symbol-type-list  new-symbols-type-list-of-lists new-symbol-type-spec-list-of-lists  new-root-list)
    ;;end defun ART3-init
    ))