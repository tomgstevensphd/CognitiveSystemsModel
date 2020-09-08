;; *************** CS-csym-trees.lisp *****************************

;; sss start here make-treeview-frame use new make-tree-nodes fun
;;(setf *test-artdims-tree1 '(cs :s (hs :s (1 :s (1 2)  2 :s (1  2  3)   3)  ms :s (ms1 :s (1 2)))))
;; (setf *treenodes-test11 (make-tree-nodes-list *test-artdims-tree1))
;; (make-treeview-frame  *treenodes-test11)


;;assumptions of new trees
;;
;; each csym represents one brain/system or cell location
;; therefore, each subsystem (which can be 1. a multi-system with no one cell representing it, a UNI-SYSTEM which has a cell/node that actually connects to lower subsystems/cells, or a SINGLE CELL.
;; The TOP NODE in a uni-system has all the keys/values of a single cell; unlike the multi-system top node, which only links the subsystems for graphic illustration.


;;FORMAT OF EACH CSYM (which can represent any kind of node)
;; Each csym (whether a system, subsystem, element, or anything else (class, cat, etc)
;; (CSYM-STR  NAME-ID-STR CSLOC  DATA  DEF/DESC  PLUS KEY-VALUE PAIRS);; each place MUST be the value or NIL in any csymvals list.
;;
;; KEYS:  :S SUBLIST,  :V VALUE, :CSS ELEMENT OF SUBSYSTEM, ELEMENTS, :CAT category, :va overall CS value--used for heirarchy ranking, etc.  :RNK (rank within given :va--see CSQ).  :CLEV (clev ; cs-cat level-- 1 is major brain system, etc.
;;  :INFO  :PC :BIPATH (POLE1( ) POLE2 ( ) see eg) :BESTPOLE
;;                       :TOPATH :FROM :WTO :WFROM   :PCLIST  :SYSTEM (depreciated?)
;; NEW KEYS CAN BE ADDED TO MAIN LIST OR DATA-LIST
;;
;;EG 1.  ("NEWCSYM0" "new0" CSLOC1 "data" "def" :CSS $MISC :S (DON JOE) :CAT (CAT1 CAT2))
;;EG 2. ("AUTONOMOUS" "AUTONOMOUS vs NOT AUTONOMOUS" CS2-1-1-99 NIL NIL :PC ("AUTONOMOUS" "NOT AUTONOMOUS" 1 NIL) :POLE1 "AUTONOMOUS" :POLE2 "NOT AUTONOMOUS" :BESTPOLE 1 (:BIPATH ((POLE1 NIL F-ADMIRE NIL) (POLE1 NIL PER-ROMANCE NIL) (POLE2 NIL CHILD-DISLIKE NIL))) :va "0.917" :RNK 10)


;;NEW: CSLOC WILL BE EITHER A TRADITIONAL ARTDIMLIST (IN M F L I)
;; OR A LIST WITH A SYMBOL (or symbols?)  REPRESENTING THE (TOP)  CLEV 1 PLUS A   STRICTLY? NUMERICAL ADDRESS LOCATION (which includes the top level system digit (eg. $EXC = 1? $EXC symbol = EXC, SS w/o $)
;; ALL CSYMS WILL BE GIVEN A UNIQUE LOCATOR NUMBER-LIST = DIGITAL NUMBER as they are made using the following convention.
;; NUMBERING SYSTEM
;; EACH DIGIT REPRESENTS A SYSTEM HEIRARCHY LEVEL
;; First digit is :clev 1, etc.
;; NUMBERING SYSTEM FOLLOWS THE :ELM of :CSS SUBSYSTEM, since can ONLY BE ONE CSS FOR WHICH IT IS AN (PRIMARY) ELEMENT  on  ELMS list.
;;
;; SUBSYSTEM LISTS (:S LISTS) CAN OVERLAP AND HAVE MULTIPLE INHERIETANCE.  
;; INDIVIDUAL CELLS CAN BE LISTED IN :S LISTS AND SHOULD ALSO BE IN AN, ALSO THE NEXT-LEVEL SUBSYSTEM(S) SHOULD BE LISTED IN THE CELL/NODES' :CSS LIST.
;; DIMLIST EG.  (EXC 1  4  22  19)
;; DIMSYM EG.  EXC.1.4.22.19

;;THE TREE WILL USE THE DIMLISTS TO CREATE THE TREE



#|CL-USER 91 > (setf c.1.3 '(that))
Warning: Setting unbound variable C.1.3 = (THAT)
CL-USER 92 > C.1.3 = (THAT)
;;note:  can set numbers as a symbol to a list
CL-USER 89 > (setf 1.2.3.6 'this) 
Warning: Setting unbound variable |1.2.3.6|  = THIS
CL-USER 90 > 1.2.3.6 = THIS|#


;;FORMAT OF A TREE NODE PRINT LIST
;; Should be able to print out any way want
;; EG.  (DIMSYM CSYM DESC VALUE etc)
;; note: sublists (and elements printed out below)



;;MAKE-CSDIMSYM&LIST -- FOR AUTO INCREMENT DIM NUMBERS
;;2019
;;ddd
(defun make-csartsym&list (dimsobj &key (incf-nths 'last)
                                   (make-new-artsym-p T) set-nth-dim-val)
  " In U-CS RETURNS: (values artsym dimslist).   INPUT: Assumes dims is NEW artsym or dimslist. Making nil and using old- keys create new ones INCF-NTH = digit increments the incf-nth dim. When SET-NTH-DIM-VAL = (nth value) eg (2 5) sets nth value in dimslist. 
  When MAKE-NEW-ARTSYM-P, makes new artsym = (type dim"
  (let*
      ((dimslist (cond ((listp dimsobj) dimsobj)
                       ((symbolp dimsobj) (find-sym-dims dimsobj))))
       (n-dims (list-length dimslist))
       (new-dimslist)   ;; (incf-list-nths
       (new-csartsymstr)
       (new-csartsym)
       )
    ;;for INCF-NTHS values
       (cond
        ((equal incf-nths 'last)
         (setf new-dimslist (incf-list-nths (- n-dims 1) dimslist)))
        ((null incf-nths)
         (setf new-dimslist dimslist))
        ((listp incf-nths)
         (setf new-dimslist (incf-list-nths incf-nths dimslist)))
        (t nil))
       ;;SET-NTH-DIM-VAL
       (when set-nth-dim-val
         (setf new-dimslist (replace-nth dimslist (car set-nth-dim-val)
                                         (second set-nth-dim-val))))

       ;;MAKE THE NEW CSARTSYM
       (setf new-csartsymstr (make-dims-string new-dimslist)
             new-csartsym (my-make-cs-symbol new-csartsymstr))
       ;;MAKE NEW ARTSYM VALS?
       (when make-new-artsym-p
         (make-artsyms-from-dims-p (car new-dimslist) (list (list (cdr new-dimslist)))))
           ;;eg (make-artsyms-from-dims  "INPUT" '(((I L 1))((I L 2))))
       
    ;;end let,make-csdimsym&list
    (values new-csartsym new-dimslist new-csartsymstr)
    ))
;;TEST


;;SSSSS -- DECIDE HOW TO MIX PCs INTO THE CS CAT FRAMEWORK AND PCs  AMONG THEMSELVES (eg value levels, ??)
;; MUST USE SUBLISTS OF CSYMS SUBORD CSYMS (FOR LOCS ??)
;; IDEA--IDEAS/CSYMS, pcs, may CHANGE NODES/LOCS to a higher, more suprord/comprehensive location HIGHER (or lower) in the network CHANGING its meaning as well.  (Maybe a conversion experience that moves (eg happiness) to a new location and attaches more paths and power to it actually involves a CHANGE in meaning and location. A more limited node meant "happy" before, now a higher one does as the meaning/comprehensiveness/power does.
;; Use member-of, kind, example, how, etc questions cause listing in SUBLIST? though of course could be linked to many higher nodes by same questions. 
;; PROBLEM: HOW TO LINK TO ONLY ONE SUBLIST??



;;MAKE-CSYM-TREE
;; USE *MASTER-CSART-CAT-DB as MASTER CS-CAT DATABASE,
;; because both MAKE-CSYM-TREE AND MAKE-CSART-SYMS depend upon it.
;;   and it is easier? to edit?
;;2019
;;ddd 
(defun make-csym-tree (&key top-csyms ;;leave nil if using cats DB
                            (ALL-CATS-LIST *MASTER-CSART-CAT-DB)
                              (if-csym-exists :set-only-csartloc&supsys)
                            make-csym-treeviewer-p
                            omit-special-vars-p
                            ;;or:modify :replace
                            (tree-leveln 1) (max-tree-leveln 100) incl-only-SYS-csyms-p
                            use-old-csymvals-p  (csym-pre "<")
                            ;;make-scale&qvar-csyms-p ;;doesn't work--later fix?? not needed
                             return-entire-tree-p ;;added 2020-08
                            ;;tree levels
                            (csartloc-origin :supsys-csartloc)(make-new-csartloc-p T)
                            (update-supsys-sublist-p T)
                            topdim dims  (last-dim :csym) supsys
                            topdimslist  def-topdimsym   def-supsys
                            (supsys-csartloc '$P) new-csartloc new-csartloc-vals
                            parents  
                            ;;elmsyms & pcsyms
                            (set-elm-supsys-csartloc '$CS.$ELM)
                            (set-pc-supsys-csartloc '$CS.$PC)
                            (elm-supsys '$ELM)(pc-supsys '$PC)
                            (get-existing-elmsyms&pcsyms-p T)
                            (all-elmsyms-sym '*ALL-ELMSYMS)
                            (all-pcsyms-sym '*ALL-PCSYMS)
                            (set-global-syms&vars-p T)
                            (all-elmsymvals-sym '*ALL-ELMSYMS&VALS)        
                            (all-pcsymvals-sym '*ALL-PCSYMS&VALS)
                            set-global-all-csyms&vals-p ;;creates huge list of all info!
                            ;;RETURN
                            (return-only :csyms) ;;OR :CSYMS&TREE)
                            ;;storing to file
                            (user-data-dir *CSQ-DATA-DIR)
                            (use-dated-filename-p T)
                            (use-time-wdate-p T)
                            pre-listname-str
                            (append-filename-begin "2-TOM-")
                            append-filename-end   
                            (eval-syms-p T)
                            accumulate-all-syms&vals-p
                            accumulate-all-lists-p 
                            (listsyms-sym '*ALL-CSYMS-LIST-SYMS)
                            #| NO--resets on every call to tree-leveln = 1
                          (reset-global-csyms-vars '( *ALL-TREE-CSYMS
                                                        ;;used ONLY by make-csym
                                                            *ALL-MAKE-CSYMS
                                                            *ALL-MAKE-CSARTLOC-SYMS))|#
                            (store-data-listsyms '( 
                                                   *ALL-ELMSYMS ;;N=58
                                                   *ALL-PCSYMS ;;N=128 
                                                   *ALL-MAKE-CSYMS ;;N=795             
                                                   *ALL-MAKE-CSARTLOC-SYMS ;;N=855
                                                   ;;*ALL-TREE-CSYMS
                                                   ;;*ALL-TREE-CSARTLOC-SYMS 
                                                   ;;*ALL-CSARTLOC-SYMS&VALS
                                                   ;;*ALL-TREE-CSYMS  ;;*ALL-CSYMS&VALS
                                                   )) 
                            (if-output-file-exists :append)
                            eval-nth-in-symlist 
                            (file-head-message 
                             ";;TOM ALL STORED CSYMS & CSYM-VALS")
                            (artsym-n 2) (if-exists-replace-p t)  csartloc-n3-item 
                            csartloc-rest-vals   set-as-csartdims-p
                            (separator-str ".") (return-csartdims-p t) 
                            (append-all-csartloc-syms&vals-p t) 
                            (clevkey :CLEV)
                            (sublist-key :S) (supsys-key :CSS ) 
                            (qtype-key :QT)  
                            (catkey :CAT) (valkey :V) 
                            (csvalkey :VA) (csrankey :RNK)
                            (infokey  :INFO) (pckey  :PC)
                            (bipathkey :BIPATH) (bestpolekey :BESTPOLE)
                            (tokey :TO) ;;was :topath
                            (fromkey :FROM) 
                            (wtokey :WTO) (wfromkey :WFROM)
                            (pclistkey :PCLIST) (systemkey  :SYSTEM) ;;not used?
                            linktype (linktype-key :LNTP)    restkeys 
                            (sys-csyms-varname '*ALL-STORED-SYS-CSYMS)
                            (all-tree-csyms-sym '*ALL-TREE-CSYMS) 
                            set-all-tree-csyms-to-global-var-p
                            unbind-all-sys-csyms-p
                            ;;global OUTPUT vars
                            (save-csym-tree-to-file *CS-CAT-DB-TREE-file)
                            (save-csyms&vals-to-file *CSQ-USER-CSYM-DATA-FILE)
                            (use-dated-csyms-file-p T)
                            (custom-csym-arglists *CUSTOM-ARGLISTS-FOR-CSYMS)
                            )                                  
  "U-trees, Creates a csym tree from either 1. a previously DEFINED CSYM LIST OR a cSYM-PREVAL-LISTS (eg. ((csym1 (csymvals1))(csym2 (csymvals2) etc  OR from  OR an ALL-CATS-LIST '(eg ((csym-preval-lists1)(cat2 csym-preval-lists2) etc.  RETURNS:  (when RETURN-ONLY= :csyms (values all-tree-csyms all-csartloc-syms)  
 = :csyms&tree (values all-tree-csyms all-csartloc-syms tree-list); T= (values all-syms all-syms&vals tree-list listsyms all-listsym-nth-syms all-listsym-nth-syms&vals pathname)
     INPUT: top-csyms assumes each csym evals to csymvals. If null top-csyms, uses :CLEV = 0
     Set SUPSYS-CSARTLOC priority:  FIND SUPSYS-CSARTLOC priority 1. csartloc, 2. (last1 dims) 3. topdim 4. topdimslist, 5. def-topdimsym 6. default-csartloc 7. NONE 
        If  supsys-csartloc = NONE or NIL, uses CSYM as top csartloc.
  NOTE: make-csym-tree creates MINIMAL CSQ SCALES CSYMS.  Must REPLACE the scale & qvar csyms with new ones made by Make-CSQ-csyms.
 MAX-TREE-LEVELN = 3 to prevent lower, non-sys csyms in tree.
     TO RETURN A NEW SYS DB TREE: SET 1. incl-only-SYS-csyms-p=T & 2. return-only-csyms-p=NIL"
  (let*
      ((tree-list)
       (all-tree-csyms)
       (all-tree-csartloc-syms)
       ;;(rootlist)
       ;;(all-rootlists)
       ;;(top-csartlocs) 
       ;;(supsys-csartloc) ;; csartloc)
       (all-csartloc-syms)
       )
    ;;NO--RESETS TO ON EVERY CALL TO LEVELN=1
    ;; RESET-GLOBAL-CSYMS-VARS
#|    (when (and (equal tree-leveln 1) reset-global-csyms-vars)
      (set-vars-to-value NIL reset-global-csyms-vars))|#
                                                   
    ;;(afout 'out (format nil "BEGIN MAKE-CSYM-TREE: top-csyms= ~A~% tree-leveln= ~A supsys-csartloc= ~A" top-csyms tree-leveln supsys-csartloc))
    ;;STEP 1: PRE-PROCESSING
    ;;1.1 MAKE DATED CSYM FILE?
    (when (and use-dated-csyms-file-p save-csym-tree-to-file 
               save-csyms&vals-to-file)      
      (setf save-csym-tree-to-file (make-dated-pathname save-csym-tree-to-file)
              save-csyms&vals-to-file (make-dated-pathname save-csyms&vals-to-file)))

    ;;1.2 WHEN UNBIND-ALL-SYS-CSYMS-P FOR FRESH START
    (when unbind-all-sys-csyms-p
      (makunbound-vars (eval sys-csyms-varname)))

    ;;. If top-csyms= symbol, make a list, so can be processed below, assume it is a ROOT
    ;;STEP 2: DB CATLISTS (CSYM CSYM-VALS) LISTS (eg CS DB list)
    (cond
     ;;If top-csyms = symbol, make list and go to second loop.
     ((and top-csyms (symbolp top-csyms)(boundp top-csyms))
      (setf top-csyms (list top-csyms)))
     ;;If (listp top-csyms), go to second loop
     ((and top-csyms (listp top-csyms)) NIL)
     ;;If all-cats-list, use it to make top-csyms list, then go to second loop
     (all-cats-list
      ;;FIND THE CSYMS WITH TOP CLEV ROOT(S)
      (loop
       for catlist in all-cats-list
       for catn from 1 to (length all-cats-list)
       do
       (let*
           ((csym1 (car catlist))
            (csym1vals (second catlist))
            (clev1 (get-key-value clevkey csym1vals))
            )
         ;; FIND TOP-CSYMS FROM  (clev = 0) 
         (when  (equal clev1 0) ;;was also set-csart-root 
           (setf top-csyms (my-append1 top-csyms csym1)))
         ;;(break "2-catlist")  
        ;;(afout 'out (format nil "BEGIN LOOP: catlist= ~A~% csym1= ~A" catlist csym1))
        ;;end let, loop,all-cats-list clause
         )))
     (t nil))

    ;;STEP 3: PROCESS THE TOP-CSYMS
    (when (listp top-csyms)
      (loop
       for csym1 in top-csyms
       for sym-n from 1 to 1000
       do
       (multiple-value-bind (csym csymstr csym-base-str csym-base)
           (my-make-cs-symbol csym1 :prestr  csym-pre :make-base-sym-p T)
         
       (let*
           ;;FIND CSYMVALS and its main data values
           ((csymvals (cond 
                       ;;if csym has csymvals and use-old-csymvals-p
                       ((and use-old-csymvals-p (boundp csym))
                        (eval csym))
                       ;;if only in all-cats-list, get that csymval list
                       (all-cats-list
                        (get-key-value csym all-cats-list))))
            ;; (get-key-value '$EXC *ALL-CATS-LIST-XX) = ("$EXC" "Executive" NIL NIL NIL :S ($TBV $WV $CSK $BSK) :CLEV 1)
            ;;from make-csym (list csymstr  csphrase csloc csdata  csdef)
            ;;(curdims (nth 2 csymvals))  ;;same as csloc below
          ;;  (csymstr (format nil "~A" csym))  
          ;;  (csym-base (subseq csymstr 1))
            (csphrase (second csymvals))
            (csdata (fourth csymvals))
            (csdef (fifth csymvals))
            (qtype (get-key-value qtype-key csymvals)) 
            (sublist (get-key-value sublist-key csymvals)) ;;sublist for cur csym (= a top-csym)
            (value1 (get-key-value csvalkey csymvals))
            (value2 (get-key-value valkey csymvals))
            (sd (get-key-value :SD csymvals))
           ;;(csartloc1 (nth (- sym-n 1)  top-csartlocs))
            ;;not needed (subsyms (get-key-value sublist-key cat-sublist))
            (new-subtree-csymvals)
            (clev (get-key-value clevkey csymvals))  
            (new-csymvals)
            (dimcat)
            (dimcatstr "")
            ;;not used?(dimcat-n topsym-n)
            ;;dimslist
            (dimslist)
            ;;(dimstr)
            (newdimslist)
            (new-tree-csymlist)  
            (sub-csyms-tree)
            (sub-csyms)
            (new-csyms)
            (new-csartlocs)
            ;;(sub-rootlist)
            (subdimslist)
            (value (get-key-value :VA csymvals))
            (csval (get-key-value :VA csymvals))
            (csrank (get-key-value :RNK csymvals))
            (supsys (get-key-value supsys-key csymvals))
            (cats (get-key-value :cscats csymvals))
            (info (get-key-value :info csymvals))
            (system (get-key-value :csys csymvals))
            (pole1 (get-key-value :pole1 csymvals))
            (pole2 (get-key-value :pole2 csymvals))
            (bestpole (get-key-value :bestpole csymvals))
            (rev-poles-p (get-key-value :rev-poles-p csymvals))  
            (BIPATH (get-key-value :BIPATH csymvals))
            (to (get-key-value :to csymvals))
            (from (get-key-value :form csymvals))
            (wto (get-key-value :wto csymvals))
            (wfrom (get-key-value :wfrom csymvals))
            (pclist (get-key-value :pclist csymvals))
            (key-values-list)  ;;SSS FINISH LATER USE restkeys
            ;;NOTE: POLE1 AND POLE2 should be inside of :BIPATH, ETC.
            ;;(XX (get-key-value key csymvals))
            ;;(topdimsym (cond (dimslist (car dimslist))(t def-topdimsym)))
            (new-subtree-list)
            (new-subtree-csyms)
            (new-subtree-csartlocs)
            )
         ;;to prevent recurse problems, if returns UNBOUND-SLOT
         (when (not (listp sublist))
           (setf sublist nil))
         ;;(break "In MAKE-CSYM-TREE after LOOP LET") 
         ;;(afout 'out (format nil "In MAKE-CSYM-TREE after LOOP LET: csym= ~A csymvals= ~A supsys= ~A supsys-csartloc= ~A"  csym csymvals supsys supsys-csartloc  ))
   
         (cond
         ;;3.1: PROCESS QTYPE = :SYS CSYMS
         ;;           MAKE-CSYM TO MAKE NEW CSYMVALS 
         ((and csym (member qtype  '(:SYS :QMA :TXT))) ;;HERENOW
          ;;not needed? (null incl-only-SYS-csyms-p))
          (multiple-value-bind (new-csymvals1 csym1 new-csartloc1 
                                              new-csartloc-vals1 supsys1 supsys-vals1)
              ;;(values csymvals csym csartloc-sym csartloc-vals supsys supsys-vals 
              (make-csym csym csphrase  csdata csdef
                         :if-csym-exists if-csym-exists :clev clev :qtype qtype
                         :csartloc-origin csartloc-origin
                         :topdim topdim :dims dims :last-dim last-dim
                         :supsys supsys :def-supsys def-supsys :parents  parents  
                         :supsys-csartloc supsys-csartloc :new-csartloc new-csartloc 
                         :make-new-csartloc-p make-new-csartloc-p 
                         ;; :change-csloc-p change-csloc-p
                         :new-csartloc-vals new-csartloc-vals 
                         ;;SSSS IS THIS NEEDED IF USING SCALES/QVARS?
                         :update-supsys-sublist-p update-supsys-sublist-p
                         :csartloc-n3-item csartloc-n3-item
                         :csartloc-rest-vals csartloc-rest-vals
                         :sublist SUBLIST ;;OK: csym is a top-csym, sublist is its sublist
                         :supsys-key supsys-key   :sublist-key sublist-key
                         :linktype linktype :linktype-key linktype-key 
                         :value1 value1  :value2  value2 
                         ;;not needed? :cs-categories cs-categories
                         :info  info  :system system
                         :bipath bipath :pole1  pole1 :pole2  pole2 :bestpole bestpole
                         :rev-poles-p rev-poles-p :to to  :from from 
                         :wto wto :wfrom  wfrom                                                     
                         :cs-categories cats  :BIPATH BIPATH
                         :bestpole bestpole :to to :from from :wto wto
                         :wfrom wfrom :pclist pclist :restkeys restkeys)
            ;;must do bind, then setf for same named vars??
            (setf new-csymvals new-csymvals1
                  csym csym1
                  new-csartloc new-csartloc1
                  new-csartloc-vals new-csartloc-vals1
                  supsys supsys1 
                  supsys-vals supsys-vals1)
            ;;set :SYS csyms
            ;;done in make-csym              
            ;;end mvb
            )
          ;;(when (equal csym '$EXC) (break "after make-csym"))
          ;;(break "after make-csym")
          ;;not used :default-csart-rootstr  newdimsym))
          ;;other keys (separator *art-index-separator) (node-separator *art-node-separator) store-all-csyms-to-file-p  (all-csyms-listsym (quote *all-stored-csyms)) (tlink-artlocsym (quote *new-tlink-artloc)))

          ;;NO-SET THE CSYM TO THE NEW-CSYMVALS
          ;;redundant, done in make-csym (set csym new-csymvals)
          (setf all-tree-csyms (my-append1 all-tree-csyms csym)
                all-tree-csartloc-syms (my-append1 all-tree-csartloc-syms
                                                   new-csartloc))
          ;;TREE new
          (setf tree-list (my-append1 tree-list new-csymvals))

          ;;(afout'out (format nil "BEFORE RECURSE: csym= ~A~% ~%  new-csartloc= ~A~% (EVAL csym)= ~A~% new-csymvals= ~A~% tree-list=~A" csym new-csartloc (eval csym) new-csymvals tree-list))
          ;;(afout 'out (format nil "MAKE-CSYM-TREE: before recurse on sublist ~% csym= ~A sublist= ~A" csym sublist))
          
          ;;WHEN SUBLIST, RECURSE and MAKE LIST OF SUBTREES
          ;; makes the CSYM SUBLIST (of subtrees)             
          (when (and sublist (<= tree-leveln max-tree-leveln)
                     (not (intersection (list csym csym-base) sublist :test 'equal))) ;;not needed??
            ;;(break "before recurse on sublist") 
            (multiple-value-bind (sub-csyms1 sub-csartloc-syms1 subtree-list1) 
                ;;could add all-syms&vals listsyms all-listsym-nth-syms etc.
                (make-csym-tree :top-csyms  SUBLIST   :if-csym-exists if-csym-exists
                                :use-old-csymvals-p  use-old-csymvals-p  
                                :tree-leveln (+ tree-leveln 1) 
                                :csartloc-origin csartloc-origin 
                                :topdim topdim :dims dims :last-dim last-dim
                                :supsys supsys :topdimslist topdimslist
                                :supsys-csartloc NEW-CSARTLOC 
                                :def-supsys def-supsys
                                :new-csartloc nil
                                :new-csartloc-vals new-csartloc-vals
                                :if-exists-replace-p if-exists-replace-p
                                :artsym-n artsym-n :csartloc-n3-item csartloc-n3-item
                                :csartloc-rest-vals csartloc-rest-vals
                                :set-as-csartdims-p  set-as-csartdims-p 
                                :all-cats-list all-cats-list
                                :def-topdimsym def-topdimsym
                                :return-only return-only
                                :sublist-key sublist-key :supsys-key supsys-key
                                :clevkey clevkey :catkey catkey :csvalkey valkey
                                :csrankey csrankey :infokey infokey :pckey pckey
                                :BIPATHkey BIPATHkey :bestpolekey bestpolekey
                                :tokey tokey :fromkey fromkey :wtokey wtokey
                                :wfromkey wfromkey :pclistkey pclistkey
                                :systemkey systemkey :restkeys restkeys
                                :qtype-key qtype-key )
              ;;MAKE ONLY THE NEW SUBLIST= subtree-list1 (which includes all subtrees)
              (when (and subtree-list1 (not (null-list-p subtree-list1)))
                (setf new-csymvals 
                      (set-key-value sublist-key subtree-list1 
                                     new-csymvals  :append-as-flatlist-p T
                                     :append-values-p T :no-dupl-p T))
                ;;RESET THE CSYM CSYMVALS
                (set csym csymvals)
                ;;reset the original sublist to prevent accidental false recurse
                (setf sublist nil)
                ;;(afout'out (format nil "RESET after RECURSE: csym= ~A~% (EVAL csym)= ~A~% new-csymvals= ~A~% $CS= ~A" csym (eval csym) new-csymvals $CS ))              
                ;;new  ck num parens
                ;;(subtree-list1 sub-csyms1 sub-csartloc-syms1)
                (when return-entire-tree-p
                  (setf new-subtree-list (my-append1 new-subtree-list subtree-list1)
                        new-subtree-csyms (append1 new-subtree-csyms sub-csyms1)
                        new-subtree-csartlocs (my-append1 new-subtree-csartlocs
                                                          sub-csartloc-syms1)))
                ;;(break "new-csymvals w/ :S")
                ;;end when
                )            
              ;;ACCUMULATE ALL CSYM SUBTREE LISTS in loop
              (when return-entire-tree-p
                (setf tree-list (my-append1 tree-list new-subtree-list)
                      all-tree-csyms (append1 all-tree-csyms new-subtree-csyms)
                      all-tree-csartloc-syms (append1 all-tree-csartloc-syms
                                                      new-subtree-csartlocs)))
              ;;(afout'out (format nil "END LOOP csym= ~A~% (EVAL csym)= ~A~% new-csymvals= ~A~% $CS= ~A~% tree-list=~A" csym (eval csym) new-csymvals $CS tree-list))
              ;;(break "end loop")
              ;;end when sublist 
              ))
          ;;end csym qtype = :SYS /not :scale
          )
          ;;3.2: PROCESS CSQ SCALE or QVAR  [qtype not :sys,:txt, or :qma -only specified in predefined special DB csyms] CSYMS
          ((and (null incl-only-SYS-csyms-p)(boundp '$CS)
                (not (intersection (list csym csym-base) sublist :test 'equal)))
           ;;is above needed to prevent infinite recurse?

               ;;LOOK UP TO SEE IF CAN FIND SCALE??
               (multiple-value-bind (csym1 sublist-csyms1 all-new-csyms1
                                                 all-new-scale-csyms1 all-qvar-csyms1 
                                                 all-csartloc-syms1 all-tree-csyms1)
                   (make-csyms-from-subscales&qvars CSYM
                                                    :if-csym-exists :REPLACE
                                                    :csartloc-origin :SUPSYS-CSARTLOC 
                                                    :supsys-csartloc SUPSYS-CSARTLOC 
                                                    :supsys SUPSYS
                                                    :incl-helplinks-p NIL
                                                    ;;SSSS ADD OTHER ARGS LATER??
                                                    )
                 ;;(afout 'out (format nil "subscales&qvars: SUPSYS-CSARTLOC= ~A new-csartloc= ~A" supsys-csartloc new-csartloc))
                 ;;(values tree-list all-tree-csyms all-csartloc-syms)
                 ;;ACCUMULATE -- Making a true subtree would require
                 ;;   accumulating ALL csymvals into giant nested list: VERY INEFFICIENT
                 ;;better to just use the sublists of csyms--evaled as needed for viewing, etc.
                 (when (and csym1 (boundp csym1))
                   (setf csym csym1
                         csymvals (eval csym1)
                         tree-list csymvals)
                   (setf all-tree-csyms (append all-tree-csyms all-new-csyms1)  
                         ;;omit? sublist-csyms1
                         all-tree-csartloc-syms (append all-tree-csartloc-syms 
                                                        all-csartloc-syms1))
                   ;;end when
                   )
                 ;;(BREAK "After processed A SCALE or QVAR")
                 ;;end mvb, scale/qvar clause
                 ))     
          (T NIL))

         ;;(afout'out (format nil "END LOOP csym= ~A~% (EVAL csym)= ~A~% new-csymvals= ~A~% $CS= ~A~% tree-list= ADD??" csym (eval csym) new-csymvals $CS )) ;;add tree-list?
         ;;end mvb,let,loop csyms,
         )))
      ;;(break "After a top-csym loop")
      ;;end when top-csyms
      )

    ;;SET GLOBAL VAR TO NEW NO-DUPLICATES ALL-TREE-CSYMS
    ;;done in make-csym (set all-tree-csyms-sym (delete-duplicates all-csyms))
    (when set-all-tree-csyms-to-global-var-p 
        (setf all-tree-csyms (delete-duplicates all-tree-csyms))
        (set all-tree-csyms-sym all-tree-csyms))
         ;;all-tree-csartloc-syms (delete-duplicates all-csartloc-syms))
     
    ;;SAVE TREE AND/OR CSYMS TO FILE?
    (when (and save-csym-tree-to-file (= tree-leveln 1) (boundp '$CS))
      ;;SSSS FINISH SAVE DB TREE--SOME ERRORS
      ;;(pprint-object-to-file tree-list save-csym-tree-to-file :if-exists-keyword :overwrite)
      (write-to-file  save-csym-tree-to-file tree-list :if-exists :overwrite)
      ;;OR USE
      ;;(pprint-to-file save-csym-tree-to-file tree-list :if-exists :overwrite)
      ;;(pprint-nested-list-to-file tree-list save-csym-tree-to-file :if-exists-keyword :overwrite)
      )
    ;;ONLY PROCESS REST IF (NULL INCL-ONLY-SYS-CSYMS-P)
    (unless incl-only-sys-csyms-p

      ;;STEP 4: GET & MODIFY? CSYMS FOR ALL-ELMSYMS and ALL-PCSYMS
      ;;LEVEL 1 ONLY
      (when (and (boundp '$CS) (= tree-leveln 1) get-existing-elmsyms&pcsyms-p)
        (setf all-elmsyms (eval-sym all-elmsyms-sym)
              all-pcsyms (eval-sym all-pcsyms-sym))

        ;;RESET ELM, PC CSARTLOC-SYMS?
        (when  set-elm-supsys-csartloc
          (multiple-value-setq (ALL-ELM-CSARTLOC-SYMS  
                                ALL-ELM-ARTSYM-VALS  ALL-ELM-CSYMS&VALS)
              (set-csyms-csartlocs all-elmsyms :csartloc-origin  :supsys-csartloc
                                   :supsys-csartloc set-elm-supsys-csartloc
                                   :supsys elm-supsys)))
        (when  set-pc-supsys-csartloc
          (multiple-value-setq (ALL-PC-CSARTLOC-SYMS  
                                ALL-PC-ARTSYM-VALS ALL-PC-CSYMVALS)
              (set-csyms-csartlocs all-pcsyms :csartloc-origin  :supsys-csartloc
                                   :supsys-csartloc set-pc-supsys-csartloc
                                   :supsys pc-supsys)))

        ;;PUT ELMs & PCs IN SUPSYM SUBLISTS (:S) 
        ;;ELMs
        (set elm-supsys (set-key-value  sublist-key
                                        (eval all-elmsyms-sym) elm-supsys
                                         :no-dupl-p T
                                        :replace-old-value-p NIL  :append-values-p T 
                                        :set-listsym-to-newlist-p NIL :append-as-flatlist-p T))
        ;;PCs
        (set pc-supsys (set-key-value sublist-key (eval all-pcsyms-sym)  pc-supsys 
                                       :no-dupl-p T
                                      :replace-old-value-p NIL  :append-values-p T 
                                      :set-listsym-to-newlist-p NIL :append-as-flatlist-p T))
        ;;(break "after set $ELMS & $PCs")
      
        ;;ACCUMULATE REST (non-duplicates w/ all-tree-csyms using union)
        ;;Keep pcs and elms separate from rest--so don't do this?
        #|      (setf ALL-TREE-CSYMS (append all-tree-csyms all-elmsyms all-pcsyms)    
            ALL-TREE-CSARTLOC-SYMS (append all-tree-csartloc-syms
                               all-elm-csartloc-syms all-pc-csartloc-syms))|#

        ;;SETTING ELM & PC GLOBAL VARS
        ;; all-elmsyms-sym and all-pcsyms-sym already set above
        (when set-global-syms&vars-p
          (set all-elmsymvals-sym ALL-ELM-CSYMS&VALS)        
          (set all-pcsymvals-sym ALL-PC-CSYMVALS))
        ;;end when get-existing-elmsyms&pcsyms-p
        )
  ;;HERENOW
      ;;STEP 5: Process SPECIAL SCALES & ITEMS ;;PUT UNDER NEW $BIO?
      ;;(csym bvphrase bvart-loc bvdata  bvdef   :info info :paths paths
      ;;eg '(("UserID" "User ID" $BIO.USERID NIL NIL)) 
      ;;DEPRECIATED: MAKE CSYMS and add to Top-System.lisp DB INSTEAD.
      #|(when (and (= tree-leveln 1) (null omit-special-vars-p))
        (multiple-value-bind (all-new-csyms1 all-csartloc-syms1)
            ;;not used csartloc-sym1)
            ;;not used csartloclist all-csyms)
            (make-custom-csyms custom-csym-arglists) ;;*CUSTOM-ARGLISTS-FOR-CSYMS
          ;; (csyms-arglists &key (use-new-csartlocs-p T)    supsys  (def-supsys '$CS)                                   auto-art-dims  init-dims (csym-prestring "<")) 
          ;;ACCUMULATE??
          (setf  all-special-csyms all-new-csyms1
                 all-tree-csyms (append all-tree-csyms all-special-csyms)
                 all-tree-csartloc-syms (append all-csartloc-syms all-csartloc-syms1))
          ;;all-csyms (append all-csyms all-new-csyms1))
          ;;(break "END after make-custom-csyms")
          ;;end mvb,unless
          )
        #|      (when set-all-global-vars-p 
        (set  all-special-csyms-sym all-special-csyms))|#
        ;;end unless omit-special-vars-p
        )|#

      ;;STEP 6: STORE THE DATA TO FILE?
      ;;LEFT OUT A LOT OF INFO--CHECK  [MOST INFO NOT IN SYMVALS]
      (when (and save-csyms&vals-to-file (= tree-leveln 1) (boundp '$CS))
        (multiple-value-bind  (listsyms all-syms all-syms&vals all-listsym-nth-syms
                                        all-listsym-nth-syms&vals pathname)
            (store-cs-syms&symvals save-csyms&vals-to-file  
                                   :pprint-p  NIL
                                   :dir  user-data-dir 
                                   :use-dated-path-p use-dated-filename-p
                                   :incl-time-p use-time-wdate-p
                                   :pre-listsyms-sym-str pre-listname-str
                                   :append-filename-begin append-filename-begin 
                                   :append-filename-end append-filename-end   
                                   :eval-syms-p eval-syms-p
                                   :accumulate-all-syms&vals-p accumulate-all-syms&vals-p
                                   :accumulate-all-lists-p NIL ;;mem crash accumulate-all-lists-p 
                                   :listsyms-sym listsyms-sym
                                   :listsyms store-data-listsyms  ;;HERENOW
                                   :if-file-exists if-output-file-exists
                                   :eval-nth-in-symlist eval-nth-in-symlist 
                                   :file-head-message file-head-message)
          (when set-global-all-csyms&vals-p
            (setf *ALL-CSYMS&VALS (append-no-nth-sublist-dupls 0
                                                               *ALL-CSYMS&VALS all-syms&vals)))
          ;;end mvb,when save-csyms&vals-to-file
          ))
      ;;end (unless incl-only-sys-csyms-p
      )
    (when  (= tree-leveln 1)
      (format T "===>> FINISHED PROCESSING ALL TREE ELEMENTS~%"))
      
   (when (and (= tree-leveln 1) make-csym-treeviewer-p (boundp '$CS))
      (make-csym-treeviewer '$CS ))

    ;;(break "END")
    ;;(afout'out (format nil "DEFUN END  TREE-LEVELN= ~A~%$CS= ~A~% tree-list=~A" tree-leveln $CS tree-list))
    (cond
     ((equal return-only :csyms)
       (values all-tree-csyms all-csartloc-syms))
     ((equal return-only :csyms&tree)
      (values all-tree-csyms all-csartloc-syms tree-list))
     (T
      (values all-tree-csyms all-csartloc-syms tree-list
              all-syms&vals listsyms all-listsym-nth-syms 
              all-listsym-nth-syms&vals pathname)))
    ;;end let,let, make-csym-tree
    ))
;;TEST
;;;; ;;COMPLETE
;; (setf **new-csym-tree (make-csym-tree :unbind-all-sys-csyms-p NIL))
;; (setf **new-csym-tree (make-csym-tree :unbind-all-sys-csyms-p T :if-csym-exists :replace))
;; (setf **new-csym-tree-W (make-csym-tree :top-csyms '($WV) :supsys-csartloc '$SC.$BV :unbind-all-sys-csyms-p NIL))

;;FOR ONLY :SYS CSYMS
;; (setf **NEW-SYS-TREE (make-csym-tree :INCL-ONLY-SYS-CSYMS-P T :unbind-all-sys-csyms-p NIL :if-csym-exists :do-nothing ))

;;testing for :VA & :SD
;; NOTE: (make-csyms-from-subscales&qvars 'SWORLDVIEW :supsys-csartloc '$SC.$BV.$WV)      PRODUCES:  <SWORLDVIEW = ("<SWORLDVIEW" "Positive World View" $SC.$BV.$WV.<SWORLDVIEW NIL "Optimism about the future of the world and own life, lack of entitlement thinking, plus daily positive versus negative thoughts. How constructively and positively you view the world and the future can" :QT :SCALE :CSS $WV :VA 0.926 :SD 1.863082 :S (<SSWVGRATPT <SSWVOPTIMS <SSWVENTIT <TBVGRATI <WOVABUND <WOVGRATE <WOVPROGR <WOVGOODF <WOVMYLIF <WOVPOSTH <TBVENTIT <WOVNFAIR <WOVINJUR <WOVENTIT))
;; (setf **new-csym-tree1 (make-csym-tree :top-csyms '(<SWORLDVIEW) :unbind-all-sys-csyms-p NIL :if-csym-exists :replace))
;; (setf *learn-tree-x  (make-csym-tree  :top-csyms '(<ACAD-LEARNING) :ALL-CATS-LIST nil :unbind-all-sys-csyms-p NIL :if-csym-exists :replace))

;; (make-csym-tree :TOP-CSYMS '(<sehappy) :unbind-all-sys-csyms-p NIL :if-csym-exists :replace) 

;;take existing csyms created from scales, etc & put new csartlocs & put in sublists of system csyms.
;; ;; (setf **new-csym-tree (make-csym-tree :unbind-all-sys-csyms-p NIL :if-csym-exists :set-only-csartloc&supsys  :max-tree-leveln 100    ))


;;SSSSS PROBLEMS
;; 1. ALL-CSYMS AND ALL-CSARTLOC-SYMS both symval-lists not sym lists.
;; 2. stored lists all = nil
;; *NO SUBSCALES FOR (<SRPEOPLE <SSELFMAN <SEMOTCOP <INTSS1AASSERTCR <INTSS1BOPENHON <INTSS2ROMANTC <INTSS3LIBROLE <INTSS4LOVERES <INTSS5INDEP <INTSS6POSSUP <INTSS7COLLAB <SRELHLTH <SEHAPPY <SRANXIET <SRANGAGG <SRDEPRES)
;;






;;MAKE-CSART-SYMS--IS THIS DEPRECIATED??
;;2019
;;ddd
(defun make-csart-syms (&key subcat
                                (cscatsym-db *MASTER-CSART-CAT-DB) 
                                (omit-long-sym-p T) (long-sym-key :ls)
                                topdimslist )
  "CS-cym-trees. Sets short csart cat syms to csartsymvals   RETURNS    INPUT: eg ( $GROUP ($GRP \"Reference Group\" NIL NIL :S ($RFGP ) :clev 3))  "
  ;; NEW ($NO-CLASS ("$MISC" "No-Class" (MIS 99) NIL :S NIL   :clev 1))

  (let
      ((all-csyms)
       (rootlist)
       )  
    ;;FIND SUBLISTS
    (loop
     for db-sublist in cscatsym-db
     do
     (let*
         ((root (car db-sublist ))
          (rootstr (format nil "~A" root))
          (db-sublist-catlists (cdr db-sublist))
          (n-cats  (list-length db-sublist-catlists))
          )
       (setf rootlist (my-append1 rootlist  root))

       (loop
        for catlist in db-sublist-catlists
        for catn from 1 to n-cats       
        do
        (let*
            ((long-catsym (car catlist))
             (cat-sublist (second catlist))          
             (cscatsym (car cat-sublist))
             (cscatstr (format nil "~A" csym))          
             (csname (second cat-sublist))
             ;;not needed (subsyms (get-key-value sublist-key cat-sublist))
             (new-cscatvals-list)
             (dimcat)
             (dimcatstr "")
            ;;not used? (dimcat-n topsym-n)
             (dimslist)
             (sublist (get-key-value sublist-key cat-sublist))
             )
          ;;FIND TOPSYM  (W/O $); HERENOW
          (cond
           ;;append current dimslist
           (topdimslist
            (setf dimslist (append  topdimslist catn)))
           (t 
            ;;make top cat symbol and dimslist
            (cond
             ((string-equal (subseq cscatstr  0 1) "$")
              (setf dimcatstr (subseq cscatstr 1)))
             (t (setf dimcatstr cscatstr)))            
            (setf dimcat (my-make-cs-symbol dimcatstr)
                  dimslist (list dimcat catn))))

          ;;MAKE THE NEW-CSCATVALS-LIST
          (cond
           (omit-long-sym-p 
            (setf new-cscatvals-list (append (list cscatstr csname dimslist) 
                                             (nthcdr 2 cat-sublist))))
           (t (setf new-cscatvals-list (append (list cscatsym csname dimslist) 
                                               (nthcdr 2 cat-sublist) 
                                               (list long-sym-key long-catsym)))))
         
          (set cscatsym new-cscatvals-list)
          (setf all-cscatsyms (append all-cscatsyms (list cscatsym)))   

          ;;WHEN :S SUBLIST, RECURSE AND MAKE IT'S SYMBOLS
          (when sublist
            (multiple-value-bind (subcat-tree sub-cscatsyms sub-rootlist)
                (make-csym-tree       )
              ;;end let,inner loop
                  
              ;;FINISH HERE AFTER FINISH make-csym-tree
              ;;end  mvb,when
              ))
          ;;end, inner loop
          ))
       ;;end let, outer loop
       ))    
    (values new-tree-sub-csymlist-list all-cscatsyms rootlist)
    ;;end let, make-csart-syms
    ))
;;TEST
;; (make-csart-syms ) ;;SEE *csart-cat-syms BELOW
;; WORKS= ($MISC $EXC $KNW $CSK $BSK $EP $ELM $PCPT $LNG $EMT $MOT $BV $TBV $WV $HISF $SLF $OBJ $PER $GRP $REFG $FAM $SCR $EVT $VER $MTH $IMG $SOND $SML $TST $TCT $HAP $CAR $ANX $ANG $DEP)
;; $EXC  = ($EXC "Executive" :S ($TBV $TBE $WV $KNW $CSK $BSK $EP $ELM $PCPT)   :CLEV 1)


