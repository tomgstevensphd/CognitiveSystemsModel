;;************ 0-CogSys-OVERVIEW NOTES-incl ART-ACTR.lisp  ************
;; Overview of my Cognitive Systems Theory and Software (lisp) programs that potentially could eventually be used/combined in a larger project.

#| PURPOSE of this file
   One purpose of this file is to provide enough detail about each part so that I understand its rationale, function, potential use within a larger CS theory/system, and have a basic understanding of what each one does and how it works (lisp databases, functions, etc.).  If the detail is not explained here, then a reference should be made to a file of notes that does explain the detail.

==>   THIS FILE IS TO SERVE AS THE OVERVIEW DOCUMENTATION FOR ALL MY CS LISP SYSTEMS.



xxx == NEW PROJECTS -- LINK NETWORK [LINKNET] GRAPHS
#|
GUIDELINES
1. Multi graphs: 1 for each type of link?  
2. Different Colors/lines? for each type of link.
3. Directed lines <--   --> for :ISA etc. linktypes.
4. Nodes w/name, phr, and/or cat/type/id/csartloc?  
5. Click on link to get info printed in window (at bottom?).
6. Tabs to be able to select linktype view. (and/or csym tree view?)
7. Ability to zoom in or out on network.




|#
xxx ===  OVERVIEW of ALL COGNITIVE SYSTEMS THEORY & SOFTWARE

1. MY CS THEORY, NETWORK, and CSQ
    Focus on higher order cognitive systems and executive functions important in psychological functioning, personality, behavior.  Top beliefs, values, skills are key components. George A. Kelly's Personal Constructs and some theory integrated into model as is SHAQ and other CSQ questions/software.
    Also includes theoretical concepts from my book, You Can Choose To Be Happy, from my research paper on SHAQ, etc.  Top Value/Beliefs/Goals,  the Higher Self, key Life Skills [Self-Management, Emotional Coping, Interpersonal, Learning, Career, etc], the Harmonious Functioning Model, Spiritual Cognitive Therapy (Eg Tillich), my (dissertation Imagery Functions/Therapy ideas), etc.

xxx EG. BELIEF SPANNING SEVERAL BRAIN SYSTEMS
 1.1. EXEC CS: The belief CSYM node acts to directly influence decisions, plans, etc.
 1.2. SEMANTIC KNOWL CS: The belief may be closely tied to theory, hypothesis, evidence, etc in this system; and even just be a duplicate of a hypothesis, etc.
 1.3 LANGUAGE CS: Meaning and definitions of words, etc used in belief statements.
 1.4. EPISODIC CS: The belief may be associated with its use, etc in many real life events.
 1.5. EMOT SYS: Strong emotions may be attached.
 1.6. SENSORY-MOTOR SYS: May have programmed in automatic S-Rs.
 1.7. PERCEPTUAL (VISUAL, AUDITORY, ETC) IMAGE SYS: Associated with belief.



2. ART-Stephen Grossberg, Boston College, etc.  
    Neural Network Model, detailed model of Neural Net Theory, good pattern matcher.
*** IMPORTANT COMPATIBILITY ISSUE WITH MY ART NETWORK *****
ORIGINAL; ARTSYM (eg CS3-11-1-1) evaled to a value list.
CONFLICTS WITH CSQ VERSION WHERE CSYM IS A WORD SYMBOL.
SOLUTION: REVISE ARTSYM SO THAT 



xxx ========================================================
3. ACTR- John Anderson, CMU
    Production System which is a good molar model of many brain activities and psychological functions.  May be more useable with my CS than ART.

4. LEARNING THEORY: Arthur Staats, Skinner, etc.  integrated into learning principles.  Grossberg and Anderson's theories integrated learning concepts/principles into their theories. Learning in Internal and External Sd-R-Sr Episodes and theory.

4. PERSONAL CONTRUCT THEORY, George Kelly 
   PCs and Role-Repretory Test (used in CSQ), PC heirarchical systems, etc.

5. LIFE THEMES, SCRIPTS, ROLES, etc. Shank and Abelson [and Reference Groups--Sherif]

6. HUMANISTIC THEORY,  Abraham Maslow, etc. Characteristics of functional people.


;;xxx ******************* MY CS NETWORK NOTES *********************
;;
;;NOTES FOR CS SYSTEMS AND CSQ QUESTIONNAIRES


===========   SYSTEM TERMS =========================

SYSTEM (S)-Basic system, large main model system
SUBSYSTEM (SS)-Can have many levels of subsystems
METASYSTEM (MS)-Overlaps systems/subsystems


USE ART TERMS & My ART3 model symbols, etc as much as possible
(Use last of basic def list to be a whole defining tree for BVs??)
NODE
PATH


;;xxx ===================== COG-BV-SYSTEMS =====================

PSYCHOLOGICAL/COGNITIVE SYSTEM TERMS ---------------------------

===>>> SEE NEWER CS & BRAIN SYSTEMS TAXONOMY ABOVE

TOPBV
WORLDVIEW
SELF
REFGROUPS
KNOWBASE (Univ in head)

SKILLS (SKLSYM) (Egs SELFMAN INTERP  LEARN HEALTH ... see self-confid)
 1. CONCRETE SKILLS (SKLCSYM)
 2. ABSTRACT SKILLS (SKLASYM)


WORLD SYSTEM TERMS ------------------------------------------------------------

ELEMENTS-ENTITIES (ELMSYM) Actual ENTITIES, objects, people, groups, ??) Still is partly abstraction, but mostly sensory-related concrete. Should there be a distinction between abstract and concrete elements? FORMAT same as rest using csym 1. CONCRETE ENTITIES (ELMCSYM)
 2. ABSTRACT ENTITIES (ELMASYM)

ACTIONS (ACTSYM) (Relatively concrete? actions by concrete objects, people, etc.) Should there be a distinction between levels of abstract vs concrete actions?   FORMAT same as rest using 
  1. CONCRETE ACTIONS (ACTCSYM)
  2. ABSTRACT ACTIONS (ACTASYM)

EVENTS-EPISODES (EVTSYM) Interactions of elms, acts, in environs over defined time period)  "Episode" used more for behavioral description--eg theme, motives, etc.
  1. CONCRETE EVENT (EVTCSYM)  Brief, limited, of specific concrete elms, acts, etc)
  2. ABSTRACT EVENTS (EVTASYM)

ENVIRONMENTS  (ENVSYM) Combinations of elms, acts, events, systems,etc
  1. CONCRETE ENVIRONS (ENVCSYM)
  2. ABSTRACT ENVIRONS (ENVASYM)

SYSTEMS (SYS) Complex connections/relationships between ELMS
  1. CONCRETE SYSTEMS (SYSCSYM)
  2. ABSTRACT (SYSASYM)

SSSSS START HERE WINDOWS FOR ELMS, ACTS, EVTS, ENVS?
 WITH A SCHEME FOR CONNECTING THEM OR CLICKING TO GET A POPUP WITH INFO RE OTHER WINDOW, ETC.

  END OLDER
 ===>>> SEE NEWER CS & BRAIN SYSTEMS TAXONOMY ABOVE


;;xxx ========= CS SYSTEMS DISCOVERY METHODOLOGY =============

;;   PC:  WAY 2 ELMS ALIKE AND DIF FROM 3RD VS DIF
;;   HIGHER, SUP PCS: WHY? ISA/PARENT=> HIGHER-ORDER PCS, R HIER.
;;   LOWER, SUB PCS:   HOW? INSTANCE,CHILD, GOAL-INSTUMENT? ONE R IN R HIER => LOWER-ORDER PCS, 
;;   ENTITIES: = ELMS
;;   EVENTS:  COMPLEX INTERACTIONS OVER TIME, VIEWED/STORED FROM VARISOUS PERPECTIVES/LEVELS
;;   EPISODES: SIMILAR TO EVENTS, BUT DEFINE BEHAVIORALLY??





;;xxx ================ CSYM NODE FORMAT ===============

CS DEF LIST (Can "PC" be interchanged for "CS" in most situations. PC is used when the CSs are the result of the Reptest procedure).
* Is LAST OR ?? in an ART node.
* The ART value (4th in symvals) is the csym.(can use setsymval etc on the BV-node symbol).

CSYM evals to CSYMVALS = 
          (csname  csphrase  csdata csartloc csdef  keywords )
CSNAME (string, sometimes symbol) the symbol string for the meaning csphrase.
CSPHRASE (string) The meaning phrase of the belief/value. For PCs writes a string of pole1 vs pole2 (eg. "hot vs cold")
CSDATA (list) a list.  (value  etc--to be added?) Eg dif types of values etc)
CSARTLOC: CSART symbol which evals to a list: (rootstr dimslist    value etc)
  eg: ("INPUT" (2 7 23) NIL  0.7)
   [NOTE: for now eg ELM14-1-1-99 CS2-1-1-99 are not being accurately/systematically created. SSSS FIX ARTSYMS LATER?]
CSDEF (string) definitions/expanded meanings

***>> NOTE 1: A CSYM can REPRESENT AN ENTIRE BELIEF or SUBSYSTEM--verbal or nonverbal. This is important for the belief/subsystem to ACT AS A UNIT (with own Value, connections, etc).  Also, means SIMPLIER CS MODEL NETWORK when not all of the subparts (or even detailed description of belief) needs to be included in the CS MODEL.

xxx==RELATION BETWEEN CS NN/NODES AND ART NN/NODES ==
Not completely determined yet. However, the following may apply:
1. CS NN is the molar NN.
2. Any CS NN NODE can have TO, FROM, WTO, WFROM, BIPATH connections ART INPUT and/or OUTPUT nodes.  
3. CS NN and ART NN have similar lisp program functions and data structures (eg name symbols, nodes, paths, trees, viewers, etc. for convenience and interoperability.
;;SSS, ADD :CSS TO MAKE ART SYMS
4. In ART the root of a dimlist is the node TYPE (eg. INPUT, OUTPUT, etc the brain/cs system location is specified by :CSS KEY in the artlist); in CS the root is the LOWEST BRAIN SUB-SYSTEM LOCATION DIRECTLY ABOVE THE individual node.


xxx ======  CSQ DATA KEYWORDS =======================
:INFO Misc info relating to the symnode

:TSYS= "TYPE SYSTEM" PRIMARY (lowest in hierarchy) SYSTEM THAT THIS SYM IS A MEMBER OF.  To find higher systems it is a member of, must use the primary system sym to find which higher system(s) it is a member of.

xxx  
RELATION BETWEEN LINKTYPE (:LNTP) and SUBSYS (:S)--SUPSYS (:CSS) LISTS
  1. ASSUME that ANY SUBSYS is LINKED TO its SUPSYS (:CSS)
  2. Default PATHTYPE=  :BIPATH, 
  3. Default LINKTYPES:  SUPSYS= :MEM SUBSYS= :ISA.
;;SSSSS FIX WHERE :ISA USED ON BOTH ENDS IN CS-EXPLORE
  4. Can LATER/OPTIONALLY REPLACE ASSUMED LINKS 
  thru  SUBSYS :S and SUPSYS :CSS lists to MAKE NEW LINK LISTS inside of the CSYMS in addition to listing in :S lists.
  5. May need to modify functions using links to search SUBLISTS and SUPLISTS as well.
  6. SUPSYS-SUBSYS LISTS ARE MORE FIXED-RIGID RELATIONS THAN LINKS in general. Generally only 1 to 1 SUBSYS-SUPSYS relations; whereas links can be MULTIPLE to many other cells/nodes.
  7. SUPSYS-SUBSYS LINK KEYS:  The LINK QVAR is usually limited to one end of the link (eg :LNTP :ISA), which is often the SUBSYS or lower level FROM node.  The OPPOSITE end/node of the link (supplied by the user) is often the SUPSYS or TO node and its symbol (if different from the FROM/ qvar pole is SPECIFIED BY KEY= :LN2 (eg :LN2 :ISA2). The DEFAULT LINK KEY= 2 added to the other end node keyname.
If the LINKTYPE is RECIPROCAL or SAME (eg. :LNTP :OPP or :SYN), then only :LNTP (eg: :LNTP :SYN)  is included in the qvar/csym lists.

:LNTP= "TYPE LINK" BETWEEN NODES/CELLS (FROM CS-EXPLORE) -------
   Each type reflects a different cs-explore question (see *ALL-CS-EXPLORE-QVARS)
Currently :LNTP TYPES are ISA, PART, WHY, CAUSE, EVID, HOW, EG, FEATR,
 NAME, DEF, DESC, OPP, SYN, EVENT, VAL, SELF, SUPGL, SUBGL, SCRIPT,
 SITD, ALTR, MOTOR, IMAGE, SOUND, SENS, HAP, CARE, ANX, ANG, DEP 
PLACEMENT OF :LNTP TYPES:
   INSIDE THE :BIPATH (or other path type) INSIDE EACH PATH LIST
  Eg. (:BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 (:LNTP SUPGL) SMART NIL) (POLE2 (:LNTP NAME) GOODSTUDENT NIL)))

;;2019-12 EG.  CHANGED
;; BASIC PC INFO
;; GROUPKNOWLEDGEWORK  =  ("GROUPKNOWLEDGEWORK" "GROUP KNOWLEDGE WORKER vs NOT GROUP KNOWL WORK" CS2-1-1-99 NIL NIL :PC ("GROUP KNOWLEDGE WORKER" "NOT GROUP KNOWL WORK" 1 NIL) :POLE1 "GROUP KNOWLEDGE WORKER" :POLE2 "NOT GROUP KNOWL WORK" :BESTPOLE 1 :va "0.583" :RNK 1 . . .cont below
;;
;; PATH INFO :LNTP IS SUBORD TO :TO, :FROM, OR :BIPATH (default)
;;2019-12 FORMULA FOR CSYM PATHS/LINKS
;; (PATHTYPE (POLE-&OR-LINKSYM  LINKKEY LINKTYPE) see below:
;;  (PATHTYPE [:TO, :FROM, OR :BIPATH] 
;;   2. (POLE-&OR-LINKSYM [If pole1 or pole2, (POLE1 NIL NODE2 [If node2 pole is specified use list (POLE2 NODE2) instead of symbol NODE2.
;;  3. LINKTYPE (optional), use key :LNTP with linktype-key eg. :ISA in list0
;;EXAMPLES
;; (:BIPATH 
;; from pole1:  ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL) . . . cont below
;;assumed pole1:  (HELPER :LNTP :ISA)  (TEACHER :LNTP :EX) (TEACHNAME :LNTP :NAME) (DONTRUMP :LNTP :OPP)  (BOOKZ :LNTP :OBJLNK)  (IGNORANTPEOP  :LNTP :SD) (JESUS  :LNTP :IMG) . . . eg (POLE1 NIL (POLE2 SMART) :LNTP :ISA))
;; OLD WAS DIF LISTS (:BIPATH ((HELPERB3) :LNTP :ISA (HELPERZ) :LNTP :ISA (TEACHERD) :LNTP :EX (TEACHNAME7) :LNTP :NAME (DONTRUMP) :LNTP :OPP (HELPERZ0) :LNTP :EVT (HELPERZ2) :LNTP :OBJLNK (GOTOCLASSES7) :LNTP :OBJLNK (BOOKZ) :LNTP :OBJLNK (HELPERZ5) :LNTP :SUPG (BOOKZ0) :LNTP :SUPG (MORECIVILSOC) :LNTP :SUPG (BOOKZ7) :LNTP :SUBG (MORECIVILSOC6) :LNTP :SUBG (DORESEARCH) :LNTP :SUBG (HELPERZ4) :LNTP :SD (GOTOCLASSES3) :LNTP :SD (BOOKZ2) :LNTP :SD (MORECIVILSOC7) :LNTP :SD (DORESEARCH5) :LNTP :SD (IGNORANTPEOP) :LNTP :SD (JESUSZ) :LNTP :IMG)))

MAKING ART-LOC VALUES (and therefore artsyms) FOR NEW CSYMS


NO--USE NODE TREES FORMAT INSTEAD
SIMPLE (not accurate) EXAMPLE:  SSSSSS
;; (setf *testartlist22 '(CS (HS (1 (1 (1 ) 2 (1 (1)2 (1 2)) 3 (1 (1 2) 2 3)))) (VB (1 2 (1 (1 2) 2) 3))))
;; (make-tree-nodes-list *TESTARTLIST22)
1. START NEW TLINK ART-LOC NODES WITH *initial-tlink-artloc '(1 1 1 NEW)
2. INCR NEW NODES TO *new-tlink-artloc with:
          (setf *new-tlink-artloc (incf-artdims *new-tlink-artloc   :i ))

PATH TYPES -----------------------------------------------------------------
:BIPATH a list of pathlists to/from other nodes (eg. pole to/from element)
  BIPATHLIST = FOR NON-PCs only 1 node: (node-sym (data))
        where node-sym default = N1
    [Note: PC :BIPATH go to every elm, Each elm links to ONE pc pole]
        FOR PCs [either or both poles can have links] 
         eg. :BIPATH ((pole1 nil (mother NIL))(pole1 nil (best-friend nil))(pole2 nil (father nil)))
        FOR ELMS TO PCS:  :BIPATH (("mother" NIL (TEST-PCSYM (POLE1) NIL))
:TO a list of pathlists to other nodes eg.  (to-element ...)
  TOPATHLIST = ()
:FROM  a list of pathlists from other nodes (eg pole from element)
  FROMPATH  eg (from-element ...)
:WTO a list of weighted pathlists to other nodes
  WPATHLIST = (   )
:WFROM  a list of weighted pathlists from other nodes 
  WFROMPATH = (  )
;;------------- FOLLOWING REPLACED BY :LNTP (ABOVE) ----------------------
;; IN NEW :LNTP SYSTEM  ALL? LINKS ARE (NEW?) CS SYMBOLS LIKE ANY OTHER CSYM.
;;NO-replaced with :LNTP [SUBITEMS WITHIN ABOVE KEYS   :SUBITEM (eg. *DBGOAL :BIPATH (TENNIS NIL  :SUBITEM "win tourney")]

;;PATH SUBTYPES BASED UPON CS-EXPLORE QUESTIONS
;; (STORE-IN-CSDBSYM  "*DGOAL" :BIPATH '("TENNIS" NIL) :subitem "Win Tourney")
;;works=(:BIPATH (("TENNIS" NIL :SUBITEM "Win Tourney")))  *DGOAL  NIL   "testgetsetsym"  ("TENNIS" NIL :SUBITEM "Win Tourney")
;;also works=  *DGOAL=> (:BIPATH (("TENNIS" NIL :SUBITEM "Win Tourney"))) 
;; meaning of above: CSDB is *DGOAL it is linked to a NODE="TENNIS". TENNIS IS linked to GOAL with subitem (subgoal)= "Win Touurney" TENNIS also has a :BIPATH ((*DGOAL NIL :subitem "Win Tourney") etc)
;; END OF OLD NO LONGER USED ----------------------------------------------------

#|xxx === CS-EXPLORE STEPS: ==============
1. PRESENT CS-EXPLORE-QUESTIONS from CS-explore-questions.lisp
  output to: *CS-EXPLORE-DATALIST
2. ASK TO NAME EACH INPUT ANSWER (VERBAL LABEL)
3. IDENTIFY LINKING PC: Check to see if NAME/PC ALREADY EXISTS
        3.1 IF PC EXISTS, LINK IT TO THIS PCSYM
        3.2 IF PC NOT EXIST,  Make NAME a pcsym and set to a pcsymlist with first INPUT as :description, etc.
4. ADD DATA TO EACH PC in LINK
    4.1 ADD DATA AND TYPE TO PCSYMLIST OF PC BEING EXPLORED (mostly under (:BIPATH (:ISA (THISPC THATPC ..) 
    4.2 ADD DATA TO NEW/OLD PC ON OTHER END.
5. LATER? Fill in missing parts (eg opposite pole, best pole, value rating, etc.)
6. STORE IN MAIN PCSYMS DATABASE
|#


xxx SSSSSS START HERE BUILDING NEW GRAPH NET MODEL
2018-02 Added for graphing
NODE:  POLE1 POLE2 CNTR (center=for connections affecting entire node)
  P1VARS, P2VARS, CNTVARS
PATH:  INPUT, OUTPUT, BIPATH  (INVARS, OUTVARS, BIVARS)
EG:
  __________________
 | P1                                   
 |__________________<-----------------------------> BI           <------------>
 | B                                                                 _____________
 | _________________ <---------------------<  IN                    |<-----------------<
 | P2f                                                             _____________|
 | __________________<-----------------------------> BI         <------------------>

xxx---------- LEVEL/RHEIR SUBKEYS WITHIN PATHS (OPTIONAL):
(A RHEIR IS THE ALTERNATIVES IN A S-R PAIR or production system)
=> Order following nested lists by csval and csrank?
Generally CSVAL partially determines LEVEL and CSRANK determines priority order within a LEVEL/RHEIR. If equal, then random choice between Rs.
:SUP = superordinate/parent nodes (a nested list) :SUP (node1 ... noden)
:SUB = subordinate/child nodes (a nested list) :SUB (node1 .. noden)
:LEQ = nodes at same level (a nested list) :LEQ (node1 .. noden)
NOT NESTED ITEMS = unknown "loose" items in one of the main keys above.
NOTE: Processing problems of  loose items vs nested items in same major key above.
  
:PC list of  (pole1 pole2 bestpole  value)  ;;bestpole = rated best  1, 2, or 0 = same.

PATHLIST














xxx ======================== TREES ==============================

I. ORIGINAL ARTSYM TREES -- see U-symbol-trees.lisp
 1. Used for ART NETWORKS, functions can create elaborate ART2 or ART3 networks that currently have no direct connection to the CS MODEL. 

U-CS-symbol-trees.lisp is a file to be modified to incorporate the CS MODEL (LATER)


II. CSART TREES  -- see U-trees-art-dims.lisp
  1. ATTEMPT TO ROUGHLY ILLUSTSRATE BRAIN STRUCTURE with CSART NODES placed in approximate parts and 
  2. the CSART TREE does NOT SHOW PATHS (the path info is stored in the CSYMVALS). 
STRATEGY:
1. CREATE A CSART TREE using (make-csartdims-tree tree-specs-list) or a function from U-CS-symbol-trees.lisp. This tree has ART NODES ONLY, but the specs use the Main CS/brain system types as subtrees and further divided CS MODEL subtrees.
(setf *CSARTSYS-TREE-SPEC-LIST  '(($CS (($TBV ($WV (($SLF) ($REFG) ($FAM)))) ($KNW (($NSC) ($BSC) ($SSC) ($ART) ($BUS) ($SPT) ($REC))) ($CSK (($LRN) ($RESN ($MTH) ($LOG)))) ($SM (($PS) ($DM) ($PLN) ($COP) ($HTH) ($FIN))) ($CAR) ($BSK (($PEOP) ($MECH) ($MAIN) ($ATH) ($MAN))) ($SCR ($ROLE)) ($EVT (($PER) ($HIST) ($HYP))) ($ELM (($PEO) ($OBJ) ($ANM))))) ($VER (($GRA) ($SEN) ($WRD))) ($IMG) ($SND$) ($SML) ($TST) ($EMT (($HAP) ($LOV) ($ANX) ($ANG) ($DEP))) ($MOT ($SPH))))
((($CS)   $CS  :S
  ((($CS $TBV)    $CS.$TBV    :S
    (($CS $TBV $WV)     $CS.$TBV.$WV     :S
     ((($CS $TBV $WV $SLF) $CS.$TBV.$WV.$SLF)
      (($CS $TBV $WV $REFG) $CS.$TBV.$WV.$REFG)
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
   (($CS $BSK)  $CS.$BSK     :S
    ((($CS $BSK $PEOP) $CS.$BSK.$PEOP)
     (($CS $BSK $MECH) $CS.$BSK.$MECH)
     (($CS $BSK $MAIN) $CS.$BSK.$MAIN)
     (($CS $BSK $ATH) $CS.$BSK.$ATH)
     (($CS $BSK $MAN) $CS.$BSK.$MAN)))
   (($CS $SCR) $CS.$SCR :S (($CS $SCR $ROLE) $CS.$SCR.$ROLE))
   (($CS $EVT)    $CS.$EVT    :S
    ((($CS $EVT $PER) $CS.$EVT.$PER)
     (($CS $EVT $HIST) $CS.$EVT.$HIST)
     (($CS $EVT $HYP) $CS.$EVT.$HYP)))
   (($CS $ELM)    $CS.$ELM    :S
    ((($CS $ELM $PEO) $CS.$ELM.$PEO)
     (($CS $ELM $OBJ) $CS.$ELM.$OBJ)
     (($CS $ELM $ANM) $CS.$ELM.$ANM)))))
 (($VER)   $VER  :S
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

SSSSSS 8-29 START HERE TIE CSQ/ EXPLORE DATA TO CSARTSYM DB
2. NODES are filled in from CSQ test results using CSYMs.  Their csartlocs (dims) are determined from
   2.1  the  CSYM TYPE (using SAME CS/BRAIN MODEL (value, belief, skill, etc)
   2.2  the LEVELN with is determined by a formula (dif for dif systems?) with variables such as VALUE (0 - 1.0), Rank w/in value levels, ABSTN (abstract level), and/or POWER? etc.
   2.3  the CELLN of each CSARTSYM is arbitray/random within a type and level.
   2.4  If other ART cell types or layers are later modelled, they will be added later.
III. MAKE-DIMS-TREEVIEWER uses LW capi:tree-view. 
Doesn't show paths, but path info stored in CSYMs which are accessible from each CSYM nodes. 

;;2019-10-17
;;SSSSSS START HERE -- DECIDE HOW TO MIX PCs INTO THE CS CAT FRAMEWORK AND PCs  AMONG THEMSELVES (eg value levels, ??)
;; MUST USE SUBLISTS OF CSYMS SUBORD CSYMS (FOR LOCS ??)
;; IDEA--IDEAS/CSYMS, pcs, may CHANGE NODES/LOCS to a higher, more suprord/comprehensive location HIGHER (or lower) in the network CHANGING its meaning as well.  (Maybe a conversion experience that moves (eg happiness) to a new location and attaches more paths and power to it actually involves a CHANGE in meaning and location. A more limited node meant "happy" before, now a higher one does as the meaning/comprehensiveness/power does.
;; Use member-of, kind, example, how, etc questions cause listing in SUBLIST? though of course could be linked to many higher nodes by same questions. 
;; PROBLEM: HOW TO LINK TO ONLY ONE SUBLIST??

;;SSSSSS START HERE -- DECIDE HOW TO MIX PCs INTO THE CS CAT FRAMEWORK AND PCs  AMONG THEMSELVES (eg value levels, ??)
;; MUST USE SUBLISTS OF CSYMS SUBORD CSYMS (FOR LOCS ??)
;; IDEA--IDEAS/CSYMS, pcs, may CHANGE NODES/LOCS to a higher, more suprord/comprehensive location HIGHER (or lower) in the network CHANGING its meaning as well.  (Maybe a conversion experience that moves (eg happiness) to a new location and attaches more paths and power to it actually involves a CHANGE in meaning and location. A more limited node meant "happy" before, now a higher one does as the meaning/comprehensiveness/power does.
;; Use member-of, kind, example, how, etc questions cause listing in SUBLIST? though of course could be linked to many higher nodes by same questions. 

;;DATA NEEDED FOR LINKS/STORAGE

;; CS-FROM & POLE; CS-TO & POLE, 
;;  LINK-DIR :TO, :FROM, OR :BIPATH (When do :TO, normally do a :FROM)
;; POLE if relevant/PC
;;  TYPE-LINK (eg :ISA)
;;  LINK-DATA
;; CS-CAT LINKS: USE A CS-CAT INSTEAD OF A SECOND PC or other CSYM.

;;UNMODIFIED :TO PC EG: ("INTIMATE" "INTIMATE vs NOT INTIMATE" CS2-1-1-99 NIL NIL :PC ("INTIMATE" "NOT INTIMATE" 1 NIL) :POLE1 "INTIMATE" :POLE2 "NOT INTIMATE" :BESTPOLE 1 (:BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL BEST-M-FRIEND NIL))) :va "0.750" :RNK 7.5)
;;MODIFIED??
;;ADDED=>  :TO (POLE1 :ISA  CAREFOROTHERS :POLE 1 :DATA NIL)

;;SECOND :FROM PC
;; UNMODIFIED: (CAREFOROTHERS ("CAREFOROTHERS" "CARE FOR OTHERS vs SELFISH" CS2-1-1-99 NIL NIL :PC ("CARE FOR OTHERS" "SELFISH" 1 NIL) :POLE1 "CARE FOR OTHERS" :POLE2 "SELFISH" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL))) :va "0.917" :RNK 3)
;;ADDED=> :FROM (POLE1 :ISA INTIMATE :POLE 1 :DATA NIL)

;;GENERALLY FOR PC LINKS
;; LINK-DIR:  (:TO, :FROM,or :BIPATH) (POLE1or2 LINK-TYPE (:ISA etc) TO-CSYM :POLE 1or2 :DATA whatever)

;;GENERALLY FOR NON-PC LINKS
;; LINK-DIR:  (:TO, :FROM,or :BIPATH) (LINK-TYPE (:ISA etc) TO-CSYM  :DATA whatever)

NOTE: 
IV. CS-NET-VIEWER.LISP  FUNCTIONS ARE PRIMARILY FOR MAKING A GRAPHIC ILLUSTRATION OF A SYMBOL-TREE WITH NODES AND PATHS vs

[EARLY NOTES:
Copy, modify make nodes list.
For each node not an int or value,
Instead, keys in any order.Can be no keys. Note, puttng happy CSYM is redundant, since CS-HS-1 evals to list w CSYM. Also value redundant.
For viewing tree, the tree viewer could eval ARTSYM and fill in CSYM and value (also keeps non redundant DB).
Could write a function to fill in csyms and values w csyms from eval artsyms. 
(NodeID :v Value :sl sublist :s csym) 
Eg.  (CS :sl (HS :sl (1 :s happy :v .917 :sl (2 :s integrity))(2 :s honest)))
MAKES=> 
((CS) CS :sl ((CS HS) CS-HS :sl ((CS HS 1) CS-HS-1 :s happy :v .917 :sl ((CS HS 1 2)CS-HS-1-2 :s integrity)) ((CS HS 2) CS-HS-2 :s honest)))]

;;CSYM INFO & TYPES: [2020-05] =======================
;;
;;CSYMS  are the NODES of the Cognitive System (Neural) Network.
;;All user data points are converted to csyms to use in the CS Network
;;
;;USE MAKE-CSQ-CSYMS to convert SYSTEM VARS, SHAQ SCALES, SUBSCALES, and QVARS to CSYMS.  ELMSYMS, PCSYMS, and LINKSYMS are made by RUN-CSQ and CS-EXPLORE.
;;
;;CSARTLOC SYMS/DIMLISTS specify UNIQUE, fixed CS Network addresses (like artdims in ART networks).
;; NOTES: 
;;    1. TOP-NODE:  R is top root node; but in practice $CS is top [R can be omitted]
;;    2. SUPSYS TOP DIM can start at ANY SYS NODE, since they are in a fixed hierarchy and the top dim specified in the csartloc-sym can be properly placed [using a function that looks up its place = (FIND-SUP-DIMS DIM)

;;PATHS (bipaths, etc) are the NETWORK LINKS between NODES, and could go from any node to any other. COMPLEX HIERARICAL RELATIONS ARE MODELED BY PATHS--NOT CSARTLOCS OR SUBLIST CSYMS.

;;NOTE: SYSTEM and ALL SHAQ-related CSYMS begin with <.
;;  ELMSYMS, PCSYMS, and LINKSYMS do NOT have a prefix.

;;SOURCE/TYPES: [Indicated by Q-TYPE-KEY :QT]
;; *CSYM-SOURCE-TYPES = '(:SYS :SCALE :SSCALE :QVAR :QMA (qvar multi-answers) :TXT (text-input) :ELM :PC :LNK). 

;;xxx ------------- CSARTLOC-SYMS FOR ELMSYMS & PCSYMS ----------------
;; This is the temporary default way of assigning csartlocs to ELMs and PCs
;;FOR ELMSYMS 
;; Generally make the top-csartsym  "$ELM" R.$CS.$ELM  or one of its subsyms "$PER" or "$OBJ" the top sym.
;;FOR PCSYMS
#| Generally make the top-csartsym "$TBV" "Top Belief-Value" R.$CS.$EXC.$TBV NIL NIL :CSS $EXC :CLEV 2) or one of its SUBCSYMS below:
     ("$WV"      "Worldview"      R.$CS.$EXC.$WV      :S
      (("$SLF" "Self" R.$CS.$EXC.$WV.$SLF NIL NIL :CSS $WV :CLEV 3)
       ("$REFG"        "Reference Group"        R.$CS.$EXC.$WV.$REFG  :S
        (("$FAM"   "Family"  R.$CS.$EXC.$WV.$REFG.$FAM   NIL  NIL|#
;;FOR CSLINKS  -- SSSSSS To be finished later.
;;   Suggest using supsyms and csartlocs of their nodes somehow.



(MAKE-CSYM
xxx========  CS and ART MAKE SYMBOL FUNCTIONS  =================
;;NOTE: ALWAYS STORE CSARTLOC AS A SYMBOL IN CSYMS
;; and make an ARTSYM from the symbol. Then to look up the dimslist,
;;  eval the artsym. (Can store as dimslist, but this is STANDARD).

(1) MAKE-CSYM function [main func to make ALL csyms]
;;  CSARTLOC for all CS DB,SCALES, QVARS, ELMs, PCs, etc are dotted lists in rigid SUPSYS--SUBLIST HIERARCHIES with the target CSYM being the last dim in the symbol.. eg for an ELM= BEST-F-FRIEND => $ELM.BEST-F-FRIEND; PC= LESSWEALTH =>  $TBV.LESSWEALTH
;;DEPRECIATED--FOR CS/Q directly; uses ARTSYM eg CS3-11-1-1 as a VALUE ONLY [Does NOT set the CS3-11-1-1 to the symvalist].
;; ARGS: (csym csphrase csdata csdef &key (if-csym-exists :modify-csartloc) prestr poststr csname (csartloc-origin :supsys-csartloc) topdim dims supsys (def-supsys (quote $mis)) parents (last-dim :csym) supsys-csartloc new-csartloc (make-new-csartloc-p t) new-csartloc-vals (update-supsys-sublist-p t) csartloc-n3-item csartloc-rest-vals (supsys-key *supsyskey) sublist (sublist-key *sublistkey) linktype (linktype-key *linktypekey) value1 value2 sd (valuekey1 *csvalkey) (valuekey2 *csval2key) revscoredp (revscorekey *revscorekey) valrank (valrankey *csval-rank-key) (sdkey *sdkey) ans-data-list (ans-data-key *multivalkey) (txtinputkey *txtinputkey) text-input (qtype-key *qtypekey) qtype change-csloc-p cs-categories info system (systemkey *csyskey) bipath pole1 pole2 bestpole rev-poles-p (revpoleskey *revpoleskey) to from wto wfrom clev (clevkey *clevkey) pclist restkeys (no-nil-restkeys-p t) (dim-separator *art-index-separator) (node-separator *art-node-separator) store-all-csyms-to-file-p (all-stored-csyms-file *all-stored-csyms-file) (all-stored-csartlocs-file *all-stored-csartlocs-file) (all-stored-csyms-listsym (quote *all-stored-csyms)) (all-csyms-sym (quote *all-make-csyms)) (all-csartloc-syms-sym (quote *all-make-csartloc-syms)) append-all-syms&vals-p (all-csartloc-syms&vals-sym (quote *all-csartloc-syms&vals)) (tlink-artlocsym (quote *new-tlink-artloc)))
;;>>>> Documentation : 
#|U-CS, csym (sym or string).  makes NEW CSYM [a cs name sym] set to a CSYMVALS = (CSNAME  CSPHRASE CSARTLOC CSDATA  CSDEF KEYWORDS ). KEYWORDS are :info, :system, :pc,  and :path set to lists. also sets the value (4th of symvals) of csartloc sym (created if not exist) to csym. ALSO makes new CSARTSYM [made from cs-art-loc] set to a list Eg ("CS" (3 11 1 1) CSTESTSYM  'ART-DATALIST)
  RETURNS (values csymvals csym csartloc-sym csartloclist supsys supsys-vals ).  Note1: DOES auto-advance cur-CSart-dims and *cur-CSart-dims. Note2: Can set or get CSdata with setsymval or getsymval functions. pclist = (pole1 pole2 value) causes csphrase to be sritten as pole1 vs pole2 and a list with both poles written after keyword :pc. :CLEV is cstree supord level.  CHANGED? pre+dims eg (CS 3 L 2 M HS)
  NAMED KEYS include :INFO, :BIPATH, etc  Both named-keys and restkeys' valulues are APPENDED TO ANY EXISTING values (unless :do-nothing or :replace). SUPSYS (key :css) is the main cs subsystem where it is placed as an element.
  Q-TYPE:  One of *CSYM-SOURCE-TYPES = '(:SYS :SCALE :SSCALE :QVAR :ELM :PC :LNK).
  RESTKEYS allows a list of keylists eg. ((key1 value1)(key2 value2) etc). Should be a standard key such as :to :from :wto :wfrom NOTE:  :SUBITEM standard key is useful to put INSIDE a value-list for any other key (eg. :BIPATH '(\"MOTHER\" NIL    :SUBITEM \"Jane Doe\")).  When track-all-csyms,  appends new csyms to *ALL-STORED-CSYMS.   
   IF-CSYM-EXISTS either  :do-nothing :replace :modify (with KEY VALUES ONLY) 
  GLOBAL-VARS SET: *ALL-CSARTLOC-SYMS


|#
 EXAMPLE: CL-USER 56 > (make-csym 'csmysym "cs test sym" 'cs3-11-1-1  '(4 "data"  :key1 (a b c)) "test definition" :system '$TOPBV :info "more info")
works= ("CSMYSYM" "cs test sym" CS3-11-1-1 (4 "data" :KEY1 (A B C)) "test definition" :SYSTEM $TOPBV :INFO "more info")    CSMYSYM
If eval CS NAME SYM; CL-USER 57 > CSMYSYM, get ALL CSYMVALS
works= ("CSMYSYM" "cs test sym" CS3-11-1-1 (4 "data" :KEY1 (A B C)) "test definition" :SYSTEM $TOPBV :INFO "more info")

If eval, the CS NAME SYM IS 4th value and EVALS as above to full CSYMVALS;  CL-USER 58 > CS3-11-1-1 =>  ("CS" (3 11 1 1) NIL CSMYSYM NIL)
  DOC: U-CS, csym (sym or string).  makes NEW CSYM [a cs name sym] set to a CSYMVALS = (CSNAME  CSPHRASE CSARTLOC CSDATA  CSDEF KEYWORDS ). KEYWORDS are :info, :system, :pc,  and :path set to lists. also sets the value (4th of symvals) of csartloc sym (created if not exist) to csym. ALSO makes new CSARTSYM [made from cs-art-loc] set to a list Eg ("CS" (3 11 1 1) CSTESTSYM  'ART-DATALIST)
  RETURNS (values csymvals csym csartloc-sym csartloclist supsys supsys-vals ).  Note1: DOES auto-advance cur-CSart-dims and *cur-CSart-dims. Note2: Can set or get CSdata with setsymval or getsymval functions. pclist = (pole1 pole2 value) causes csphrase to be sritten as pole1 vs pole2 and a list with both poles written after keyword :pc. :CLEV is cstree supord level.  CHANGED? pre+dims eg (CS 3 L 2 M HS)
  NAMED KEYS include :INFO, :BIPATH, etc  Both named-keys and restkeys' valulues are APPENDED TO ANY EXISTING values (unless :do-nothing or :replace). SUPSYS (key :css) is the main cs subsystem where it is placed as an element.
  RESTKEYS allows a list of keylists eg. ((key1 value1)(key2 value2) etc). Should be a standard key such as :to :from :wto :wfrom NOTE:  :SUBITEM standard key is useful to put INSIDE a value-list for any other key (eg. :BIPATH '("MOTHER" NIL    :SUBITEM "Jane Doe")).  When track-all-csyms,  appends new csyms to *ALL-STORED-CSYMS.   
   IF-CSYM-EXISTS either  :do-nothing :replace :modify (with KEY VALUES ONLY)  

(2) MAKE-PC [Uses make-csym] Makes both CS name sym and CSARTSYM
  ARGS:  (pole1 pole2 bestpole value  &key pcsym pcname  pcphrase pcdata
                      pcart-loc pcdef  info system  BIPATH  (min-sym-length 5)
                      (max-sym-length 18) 
                      restkeys (if-exists-do-nothing-p T) (update-dims-dimsym :C) )
  EXAMPLE:  ;; (make-pc "very hot" "cold" 1 .9 :pcphrase "very hot phrase" :BIPATH '((path1 xx)(path2 xx)) )
;; works=  ("VERYHOT2" "very hot phrase" CS2-1-1-99 NIL NIL :PC ("very hot" "cold" 1 0.9) :POLE1 "very hot" :POLE2 "cold" :BESTPOLE 1 :BIPATH ((PATH1 XX) (PATH2 XX)))     VERYHOT2
;;ALSO  VERYHOT2 =>  ("VERYHOT2" "very hot phrase" CS2-1-1-99 NIL NIL :PC ("very hot" "cold" 1 0.9) :POLE1 "very hot" :POLE2 "cold" :BESTPOLE 1 :BIPATH ((PATH1 XX) (PATH2 XX)))
;; AND   CS2-1-1-99  =>  ("CS" (2 1 1 99) NIL VERYHOT2 NIL)
  DOC: U-CS, makes a new PC node (inside of an ART type network with csartloc symbol Uses make-csym function.  RESTKEYS allows a list of keylists eg. ((key1 value1)(key2 value2) etc). Should be a standard key such as :to :from :wto :wfrom. RETURNS (values pcsymvals pcsym)."

(3) MAKE-ELMSYM
  EXAMPLE: (make-elmsym  "mother" nil)
;; works= ("MOTHER7" "mother" CS1-1-1-1 NIL NIL)    MOTHER7
  DOC: U-CS, makes a new ELEMENT node (inside of an ART type network with csartloc symbol. Uses make-csym function. sym-long-str can simple-name or longer phrase  that is condensed.
RESTKEYS allows a list of keylists eg. ((key1 value1)(key2 value2) etc). Should be a
standard key such as :to :from :wto :wfrom.   RETURNS (values elmsym elmsymvals
similar-sym).  If detail-data-list, the appends redundant-detail info needed to begin CSQ at  point where discontinued. :IF-EXISTS-RESET-P resets only elmsym not art node to  value (and takes precedence over if-exists-do-nothing-p.

(4) MAKE-ART-TOPSYM
  EXAMPLE: (make-art-topsym "test" '(1 2 3) :value 0.66 :subsyms '(this that))
;; works= TESTF-L-I  ("test" (I L F) NIL 0.66 (THIS THAT))  "testF-L-I"
  DOC: In U-CS-symbol-trees.lisp. Makes a  topsym symbol eg. WUP-F-L-I-TO-F-L-I and if it is unbound, sets it to symvals = (root dims nil default-value default-subsyms) if set-symvals-if-unbound-p. If already bound, returns OLD value and subsyms.
 
(5) MAKE-ARTSYMS-FROM-DIMS
  EXAMPLE: (make-artsyms-from-dims  "Wup" '(((I L 1)(I L 2))((I L 2)(I L 1))))
;; works=  (WUPI-L-1TOI-L-2 WUPI-L-2TOI-L-1)  ("WupI-L-1TOI-L-2" "WupI-L-2TOI-L-1")
;; also: WUPI-L-2TOI-L-1  = ("Wup" (I L 2 TO I L 1) NIL NIL)
  DOC: In U-CS-symbol-trees.lisp.  Makes a list of artsyms from dimslists (not dimspec-lists) eg. (I L 2)  (3 2 2).  Also, appends list of superord-artsyms values to include these new artsyms. INPUT: Can be in form of  (I L F), ((I L F)), (((I L F)(I L F))), or (I L F TO I L F)  RETURNS (values newsym-list newsymstr-list) 


xxx--------  CS and ART  SET FUNCTIONS ----------------
(1) SETSYMVAL - for ART ASSUMES ARTSYM = eg CS3-11-1-1 is set to a symvalist
 where FOURTH ITEM is the artsym VALUE. In the case using a CSYM name, then the CSYM IS the artsym value. 
 ARGS: (artsym &optional dims value  &key get-only-p 
                         (betw-dims-strs '("-" "")) (2-node-symbol-list '(wup wdn)) ;; uup udn))
                         (node-separator "To")(node-separator-n 3) (value-n 3)
                         append-value-p subsyms)
 EXAMPLE, set artsym value to a number: (setsymval 'WDN2-1-2TO4-3-1 NIL  0.7) 
        works= ("Wdn" (2 1 2 TO 4 3 1) NIL 0.7)  WDN2-1-2TO4-3-1  0.7  NIL
 EXAMPLE, set artsym value to a CSYM: (setfsymval  'WDN2-1-2TO4-3-1 NIL  'MYCSYM) 
        works= ("Wdn" (2 1 2 TO 4 3 1) NIL MYCSYM)  WDN2-1-2TO4-3-1 MYCSYM  0.7
 DOCS: U-CS-ART, Adds value to fourth place in the sym-vals list (eg WUP2-3 = (\"Wup\"(2 3) 9 value). RETURNS new sym-vals list (values sym-vals new-sym value old-value). INPUT EITHER1.symbol with dims (eg. sym2-4 nil) or root plus dims (eg. sym (2 4). Use instead of aref. betw-dims-strs is a list of strings to be inserted in order betw dims. NOTE: symbol must be quoted. append-value-p causes it to append the value to the list instead of puttting it in value-n place. dims = list of the i j etc of each dim. If use append-value-p, item should be a list. If no previous value or 3rd item, adds NIL value to old list eg. (a b NIL value). USE subsyms TO APPEND SUBORD SYMS IN A LIST.

(2) SETCSYMVAL - for CS/Q assumes csym is a CSARTSYM; but can change the data in a CSYM name sym AS WELL [the cs name sym that is 4th in the csartsym list].  
  ARGS: (csartsym value &optional dims &key (data-only-p T) 
                              all-symvals-p nth-value csdata-nth 
                              set-csdata-key-value set-cs-key-value 
                              append-setkey-as-list-p)
  EXAMPLE:  SEE THE FUNCTION DEF TEST SECTION [too long to put here]
  DOC: U-CS, takes a csartsym and sets whatever  csym as its value. then sets the CS data-value to either value (if data-only-p) OR if all-symvals-p, sets the ENTIRE CSYMVALS to value.  BOTH ARTSYM and CSYM assume that 'VALUE is the 4th ITEM in its symvalist.
  :NTH-VALUE, sets the nth CSYM symvalist item to value. 
  :CSDATA-NTH, changes 4th item in CSYM VALUE list.  If :CSDATA-
  :SET-CSDATA-KEY-VALUE is a key eg. :PC.  and changes csdata list containing key to key value (or appends it if not).  (Does NOT affect any other values). NOTE: CSDATA IS 4th item in the csymvals (which is 4th in csartsym). 
   :SET-CS-KEY-VALUE sets or appends value to key in main cssymvals list (eg. :info).  RETURNS (values new-csymvals csym old-value old-keyval new-csdata)

(3) SET-SYMKEYVAL for CS/Q assumes csym is a cs-name symbol.
  DOC:  In U-CS,  RETURNS (values newsymval-list  new-keylist old-value old-keylist )  
 


  To CHANGE THE CSYM VALUES MORE DIRECTLY, USE SETCSYMVAL. OR SET-SYMKEYVAL   SSSSSS START HERE CHECKING THESE 2 SET FUNCS


;;xxx ================  CSQ  DATA LISTS ===================

;;  FOR PROCESS (and SAVING TO FILE and LATER restarting CSQ)
;; Use  SAVE-CSQ-DATA-TO-FILE and READ-SAVED-CSQ-DATA functions
;; NOTE: *ALL-CSQ-DATA-LIST-SYMS = 
;; (*ELMSYMS *ELMSYMVALS *PCSYMS *PCSYMVAL-LISTS *CSQ-DATA-LIST *ALL-PC-ELEMENT-QVARS *ALL-PCQVAR-LISTS)

;;
;;xxx ------------- FOR ELMSYMS ----------------------------------------------
;;For CREATING THE Original Frame Questions, use:
;;*ALL-PC-ELEMENT-QVARS = 
;;When use original name in frames:
;; ("mother""mother"  "single-text" ("mother" "1" "motherQ" "pc-element" "Pc-Element"))
;;When user provides name:
;; ("best-m-friend""best-m-friend"  "single-text" ("best-m-friend" "3" "best-m-friendQ" "pc-element" "pc-Element" getname-p))
;; For QUESTION TEXT:
;; *All-PCE-elementQs =
;; '((PCE-PEOPLE
;;     (PCE-PEOPLE-INSTR ("People Important To You"  *Instr-Name-element))
 ;;    (MOTHERQ ("Your Mother [or person most like a mother to you]") PCE-PEOPLE-INSTR *input-box-instrs) ...
;;     (BEST-M-FRIENDQ ("A best male friend") PCE-PEOPLE-INSTR *input-box-instrs)

;;xxx-------------- For ELMSYM DATA ---------------------------------------
;; 1. For Defining the PC network.
;;ELMSYMVALS:  [in egs, A4 v notA,B7,etc are PCs]
;;The SYMBOL (eg mother) is set to the SYMVALS list. [When saved to a file, saved in form of a list with car=elmsym and second= elmsymvals.]
;;no name--use "mother"
;;MOTHER=  ("MOTHER" "mother" ELM2-1-1-99 NIL NIL :BIPATH (((MOTHER NIL (A4 (POLE2) NIL))) ((MOTHER NIL (B7 (POLE2) NIL))) ((MOTHER NIL (C0 (POLE2) NIL))))) 
;;named 
;; BEST-M-FRIEND =  ("BEST-M-FRIEND" "best-m-friend" ELM4-1-1-99 NIL "dave" :BIPATH (((BEST-M-FRIEND NIL (A4 (POLE1) NIL))) ((BEST-M-FRIEND NIL (C0 (POLE1) NIL))) ((BEST-M-FRIEND NIL (D4 (POLE1) NIL))))) 
;;
;; 2. For Q-DATA such as "Value" questions, store data in 
;;  *CSQ-DATA-LIST, key= :ELMSYM-LISTS


;;xxx --------------------- FOR PC SYMS ---------------------------------------
;;
;;Once PCs are created using comparisons of ELMSYMS, 
;; New DEFINING QVARS are created:
;; *ALL-PCQVAR-LISTS = [A vs not a, B, etc are the PCs below]
 (("A" "a vs not a" NIL "A" ("A" "1" PCSYM-VALQ "int" "Priority12" NIL 12 NIL NIL)) 
("B" "b vs not b" NIL "B" ("B" "2" PCSYM-VALQ "int" "Priority12" NIL 12 NIL NIL)) etc
;; PCSYM EVALS TO PCSYMVALS (eg =
;; HAPPY2 => ("HAPPY2" "HAPPY vs UHAPPY" CS2-1-1-99 NIL NIL :PC ("HAPPY" "UHAPPY" 1 NIL) :POLE1 "HAPPY" :POLE2 "UHAPPY" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL FATHER NIL)) :va "1.000" :RNK "1" :XYLOC (100 100))

xxx========== DATA DIMENSIONS --------------------------------
1. ID/LOCATION INFO
POLE1 is the answered pole
POLE2 is the opposite pole
BESTPOLE IS THE PREFERRED POLE (1, 2, or 0)
CSLOC is the CS symbol tree location  (eg CS2-1-1-99)

2. VALUE INFO
CSVAL is value 0 to 1.000
CSRANK is rank within group with same CSVAL 

3. RELATIONS TO OTHER PCs & Elmsyms
SUPORD is a list of lists of PCs that are clearly superordinate all the time.
SUBORD  is a list of lists of PCs that are clearly subordinate all the time.
LEV  is a list of lists of PCs that are clearly at the SAME LEVEL--usually alternatives in choice situations to the SAME SUPORD PC.
ELM  is a list of lists of PCs that are clearly ELEMENTS (generally represent objects, events,etc)
OTHORD is a list of connections to PCs, etc? that are NOT CLEARLY in any of above categories
POSAST  is the POSITIVE ASSOCIATION STRENGTH (related to freq of firing?) of a CONNECTION to another pc or elem; but can be a general arousal or inhibitory source.
NEGAST  is the NEGATIVE (INHIBITORY) ASSOCIATION STRENGTH (related to freq of firing?) of a CONNECTION to another pc or elem but can be a general arousal or inhibitory source.

4. PATH DIMENSIONS
BIPATH?
TO
FROM
POS
NEG
POSNEG

xxx
5. SIGNAL DIMENSIONS
SIGNALS are the pulsing transmissions along the paths and have a number of characterixtics.
SIGVAL  (- 1.000 to + 1.000) though a particular path may have a 0 or other limit on either pole.
SIGFREQ frequency of firing of the signal pulses.

6. DATA FOR TRACKING/VIEWING
;; :XY-N = (NTH-X NTH-Y) in a grid of rectangles. The graphics uses these Ns to put them in order.  This maintains the graphic window's control over the actual xpix, ypix = x, y coorinates of each cell, etc.
;; (DEPRECIATED? USE :XY-N INSTEAD) :XYLOC is the XPIX and YPIX top-left location within a pc netviewer window.



XXX
===== RELATIONSHIP TO SOME GKELLY DIMENS ============
EXPLICIT VS IMPLICIT POLE
PERMEABILITY (add new elems); me- all paths/connections saturated/inflexible-therefore no new connections can be made (overlearning?)?
RANGE OF CONVENIENCE (me-number and variety of subord pcs/elms?)
FOCUS OF CONVENIENCE (strongest connections--above some criteria?)

CONTROL DIMS
PREEMPTIVE not allow elms to be elms of any other pcs. [me- Subord elms have saturated connections?]
CONSTELLATORY stereotyping.  If in pc, fixes elm in other pcs automatically (fast but oft invalid). [me- SUPORD pc itself is strongly linked to other pcs--therefore firing them when new elm is added and increasing possibility of new pc linking to them?]
PROPOSITIONAL assumes nothing about an elem except it is one of its elems
 [me SUPERORD pc NOT strongly linked to other pcs?]
AVAILABILITY DIMS
PREVERBAL [me- few/no associated verbal labels]
SUBMERGENT a pole is constantly submergent and other pole is EMERGENT
 [me num and strength of links greater on emergent pole?]
SUSPENSION construct is incompatible with other super pcs and falls outside their range of conv. It can have a highly developed subsystem. EG REPRESSION, FORGETTING [me SUPERORD and lower pcs CS has few links to dominant CS]
LEVEL OF COGNITIVE AWARENESS  In range of conv of major pcs, verbal labels, freq access.  Overlap, but not same as above dims.
ORDINATION LEVEL OF PCS
SUPEROR
SUBORD
REGNANT assigns each of elms to a category on an all-or-none basis.  Eg If ALL Fords are autos, then auto is regnant over ford. [me  could be either exclusive/strong eonnection betw pc-elem ORoutside CS that monitors the DICHOTIMOUS VS PROB?]
CONTENT OF PC DIMS
VALID/INVALID
CORE PCs SELF and MAINTENANCE SYSTEMS (me ID plus EGO?)
PERIPHERAL PCS

COVERAGE & PRECISION OF PCs
COMPREHENSIVE PC wide variety of elems in range of conv & cuts accross many other PCs.  SUPERORD SHOULD BE COMPREHENSIVE
INCIDENTAL PC subsume a small variety of pcs
DILATION broadening the range of perceptual field in order to REORGANIZE at a more COMPREHENSIVE LEVEL (EG. may lower anx by put in perspective if superpcs good, increase anx if they don't)
 CONSTRICTION narrowing of perceptual field in order to minimize apparent incompatibilities. May EXCLUDE pcs that are incompat with others in the field. Overconstriction can lead to boredom and depression.
TIGHT PC pcs that lead to UNVARYING PREDICTIONS (EG good science hypt). Makes same prediction every time.  People WILL buy more fords vs loose MAY buy more fords.
Common with people who hae impermeable superords.  Not much tolerance for ambiguitr.  By using constriction leads to SMALL, ORDERED WORLD.

LOOSE PC opposite of tight.  Loose pcs can lead to incosistent predictions, confusion, Often dilated field with little structure to rely on.

DEGREE OF DEPENDENCY DISPERSION

DIMS OF TRANSITION
THREAT,FEAR, ANXIETY, GUILT, HOSTILITY

AGGRESSIVENESS highly active elaboration

CONSTRUCTION CYCLE DIMS
CPC CYCLE decision-making, narrowing alternatives to one.
-CIRCUMSPECTION -  view situation/alternatives with many pcs/perspectives (multi-deimensional view)
-PREEMPTION- narrowing pcs down to one (summing up as much info/etc as possible in one). Then viewing all other pcs/dims as irrelevant.
-CONTROL -  choosing which pole .
IMPULSIVE -shortening the CPC cycle
OVERCONTROL- delays decision, therefore testing, feedback, and learning.

CREATIVITIY CYCLE (discovery cycle)
Starts with loose pcs and ends with tighter pcs.  Test, validate, revise as a vague painting that gradually makes precise figures.

;;xxx ============ FROM MY BOOK, CH2, SELF-EXPLORATION ======

START WITH FEELING, Find other situations with same feeling. Are there similar theme(s) or comminalities across these situations?
COMMON THEME(S) across situations, time
Associations with SELF-DESCRIPTION, SELF-IMAGE, IDENTITY
Associations with MAJOR LIFE DECISIONS/COMMITMENTS
PRECEDING AND FOLLOWING STIMULI, events, situations

WHY? What are causes/explanations?
ASSUMPTIONS? what am i assuming?

INTERNAL and EXTERNAL causes/precedents,outcomes/reinfs

;;end Self-Exploration notes ===================================



;;xxx====== *CSQ-DATA-LIST (For Q-data such as "Importance") ========
;;  is the MAIN DATA LIST (replacing *shaq-data-list) that accumulates most data directly usef for results/research, etc. It holds ID data, and other misc data in addition to :PCSYM-ELM-LISTS AND :ELMSYM-LISTS
 
;; ----------- FOR SUPPLEMENTARY PC DATA ------------------------
;;*CSQ-PCXDATA-LIST = ( :PCXDATA ( ?????? ))
;;NOTES: Not used for actual processing.  Uses to save data and be able to restore CSQ state.  ELMSYMS main storage. 

;;NOTE: MAIN KEYS (eg :PCSYM-ELM-LISTS on basic flat list)

;;

;;xxx ====== ADDITIONAL QUESTS FOR NODES, PATHS =======
*YOUR MOST IMPORTANT BELIEFS
*YOUR MOST IMPORTANT LIFE GOALS
*YOUR MOST IMPORTANT GOALS THIS YEAR


*YOUR FAVORITE: ACTIVITIES, PLACES, PEOPLE, SPORTS, SCHOOL/ACADEMIC SUBJECTS, MUSIC TYPE, CAREERS


|#



;; xxx --------------------- SORTING, RATING, RANKING PCs/VALUES ----------
#|  Use function MANAGE-VALUE-RANK-FRAMES to tailor make the sorting/ranking process to be used when want values/pcs ranked or assigned integers. 
  Can be used for large numbers of pcs to focus on finer soring of only higher pc/values.
;;Suggested sequence for large pc/value N:
     1. Sort by make-pc-rate-value-frames rating scale for SEVERAL GROUPS of pc/values.
     2. Group by same value ratings.
     3. RANK all (or first 1 to 3? highest value groups) pc/values from 1 to N (num pc/values).
     4. Include both original absolute value ratings (0 to 1.0) and relative ratings withing groups (eg. :rating .9 :rank 2) in storing the info.  May be used later forr creating hierarchy--breaking ties, etc.


;;OLD Suggested sequence for large pc/value N:
     1. Sort by 1 (best) to 5 (absolute) rating scale for SEVERAL GROUPS of pc/values.
     2. Take all highest (1's?) and put into ONE GROUP.
     3. RANK all (or first x) pc/values from 1 to N (num pc/values).



XXX=========== For use in CS-explore.lisp =====================
PC LINK TYPES
* LEVEL
    * SUPERORD
    * SUBORD
         * SUBPC
         * STIMULUS (Sd, CS, UCS, etc)
         * RESPONSE (plan, action, etc)        
    * SAME
           * ALTERNATIVE-R
* AROUSAL 
     * EXPAND SEARCH /anx, drive/bio-need/etc,
     * CONSTRICT SEARCH /depress, wdraw, satiation, etc.

* RATIONALE
* EPISODES
      * EX-SUPPORT
      * EX-NONSUPPORT
      * OTHER


* RANGE-OF-CONVENIENCE

SSSSS START HERE--WORK ON MODEL (refer to Kelly, etc)
 THEN FUNCTIONS TO EXPLORE ONE PC

***> DON'T TRY TO MODEL DETAILED CogSystems--instead USE SYMBOLS TO REPRESENT THEM IN CS NETWORKS (eg. as a PC represents a whole subsystem of connections not explicitly represented.  If the CS SYMBOL is a well-definced (eg dictionary, etc) common symbol, often don't need to elaborate it.  Otherwise project becomes overwhelmingly complex.

;;Explores Superordinate (up)-subordinate (down) relationships in hierarchies using:
;;   1. WHY to elaborate up and HOW to elaborate down relationships.
;;   2. Should be used with cogsys-model CSQ and SHAQ results.
;;   3. Generalizable to other hierarchies.
;;   4. OUTPUT suitable for my tree-frames and/or cogsys-model hierarchies (see  CS-notes.lisp)

;;INPUTS
;; 1.SIMPLE LIST INPUTS (won't work because 


;; 2.  CS-NETWORK INPUTS
;;  ??Make simple lists of CS-network PCs first


;;OUTPUTS
;;NOTE: Over time exploring one CS/PC at a time and saving the results (and exploring new links from them) could lead to a huge database/network of  EXPLORED CS/PCs.
;; Therefore, there must be a way of saving them to files, later accessing the files, and loading in only the needed info for a particular operation/network exploration.
;; SSSSS TO-DO: DEVELOP A SYSTEM FOR CREATING A MODULARIZED NEURAL NETWORK with a system for storing and retreiving modules in files.
;; 1. QVAR SYM OF THE CS/PC-SYM being explored is evaled and APPENDED with the  NEW results of the exploration of that sym.  
;;; However, the larger lists of all syms discovered in the initial elmsym and pc discovery are NOT updated (at least yet).
;; 2. The appended CS-SYM/QVARs are SAVED to SPECIAL FILES.

;; 3. CS-NETWORK OUTPUTS
;;  ?? Convert simple list outputs to modify exisiting CS-network PCs or create new ones.

;;xxx === NETWORK CS-EXPLORED SAVE AND RETREIVAL =====
#|
 1. KEEP ORIGINAL CS/PC NETWORK FROM REPTEST
 2. SEARCH FOR EXISTING SIMILAR CSYM FOUND IN CS-EXPLORE.
      If not found CREATE NEW CSYM FOR EACH NEW NODE.
 3. STORE CSYM IN BOTH ENDS OF LINKS.

;;CURRENT 2019-08 =======================================

;; ===> SYSTEM (LONG) CSART SYSTEM SYMBOLS
;;
;; The SHORT SYMBOLS are included in the long symbol def list below.
;; The SHORT SYMBOLS ARE USED IN THE CSART DB & TREES.
;; These are symbols representing different (brain?) systems--mostly cognitive systems, but can be any psychological system (or other type of eg. environmental system?). Of course only the psych systems can be nodes or linked to nodes.
($CS  
                                              ($TBV ($WV ($SLF)($REFG ($FAM )) ))
                                                     ($KNW ($NSC)( $SSC)( $BSC)( $ART)( $BUS)
                                                           ( $SPT)( $REC))
                                                     ($CSK ($LRN)( $RESN ($MTH)( $LOG )))
                                                     ($SM ($PS)( $DM)( $PLN)( $COP)($HTH)($FIN))
                                                     ($CAR)                                                     
                                                     ($BSK ($PEOP)( $MECH)( $MAIN)( $ATH)( $MAN))
                                                     ($SCR ($ROLE))
                                                     ($EVT ($PER)( $HIST)( $HYP))
                                                     ($ELM ($PEO)( $OBJ)( $ANM))            
                                               ($VER ($GRA)( $SEN)( $WRD))
                                                ($IMG)( $SND$)( $SML)( $TST)
                                               ($EMT ($HAP)( $LOV)( $ANX)( $ANG)( $DEP))
                                               ($MOT ($SPH ))
                                                )
(Defparameter $COGSYS '($CS ($CS) :S (EVAL *$CS-SUBTYPES)))
(Defparameter $TOPBV '($TBV ($TBV) :S NIL) )
(Defparameter $WRLDVW '($WV :S NIL) )
(Defparameter $SELF '($SLF :S NIL) )
(Defparameter $REFGRP '($REFG :S NIL) )
(Defparameter  $VALUE '($VAL :S NIL) ) 
(Defparameter $BELIEF '($BEL :S NIL) )
(Defparameter $KNOWB '($KNW :S NIL) )
(Defparameter $COGSK  '($CSK :S  ($PS $DM $PLN $LRN $COP $RESN )) )
(Defparameter $BEHSK  '($BSK :S  ($PEOP $MECH $MAIN )) )
(Defparameter $SCRIPT '($SCR :S NIL) )
(Defparameter $EVENT '($EVT :S NIL) )
(Defparameter $ELMENT ' ($ELM :S NIL) )
;;INTEGRAL PARTS OF DB-ITEMS ABOVE
(Defparameter $VERBAL '($VER  :S NIL) )
(Defparameter $IMAGE '($IMG :S NIL) )
(Defparameter $SOUND '($SOND :S NIL) )
(Defparameter $SMELL  '($SML :S NIL) )
(Defparameter $TASTE  '($TST :S NIL) )
(Defparameter $TACTILE '($TCT :S NIL) )
(Defparameter $EMOT '($EMT :S  ($HAP $CAR $ANX $ANG $DEP  )) )
(Defparameter $MOTOR '($MOT :S NIL) )
;; ALL DB-TYPES
(Defparameter *$CS-SUBTYPES '($TOPBV $WRLDVW $SELF $REFGRP $VALUE  $BELIEF  $KNOWB $COGSK $BEHSK  $SCRIPT $EVENT $ELM) "Separate DB-ITEM TYPES. Each item a separate entity, Can have LINKS (eg BIPATHS where a linked db-item is listed in the BIPATH, etc.")
(Defparameter  *ALL-CS-BRAIN-SYSTEMS '($CS  $VERBAL        $IMAGE       $SOUND       $SMELL       $TASTE       $TACTILE       $EMOTION       $MOTOR))
(Defparameter *ALL-CS-DB-ITEM-FEATURES *ALL-CS-BRAIN-SYSTEMS)
;;
;;U
(Defparameter *CSART-CATS-TREE
 ((($CS)   $CS
  :S   (($CS $TBV)    $CS.$TBV
   :S
   (($CS $TBV $WV)     $CS.$TBV.$WV
    :S
    ((($CS $TBV $WV $SLF) $CS.$TBV.$WV.$SLF)
     (($CS $TBV $WV $REFG) $CS.$TBV.$WV.$REFG)
     (($CS $TBV $WV $FAM) $CS.$TBV.$WV.$FAM))))
  (($CS $KNW)    $CS.$KNW
   :S
   ((($CS $KNW $NSC) $CS.$KNW.$NSC)
    (($CS $KNW $BSC) $CS.$KNW.$BSC)
    (($CS $KNW $SSC) $CS.$KNW.$SSC)
    (($CS $KNW $ART) $CS.$KNW.$ART)
    (($CS $KNW $BUS) $CS.$KNW.$BUS)
    (($CS $KNW $SPT) $CS.$KNW.$SPT)
    (($CS $KNW $REC) $CS.$KNW.$REC)))
  (($CS $CSK)    $CS.$CSK
   :S
   ((($CS $CSK $LRN) $CS.$CSK.$LRN)
    (($CS $CSK $RESN)  $CS.$CSK.$RESN
     :S
     (($CS $CSK $RESN $MTH) $CS.$CSK.$RESN.$MTH)
     (($CS $CSK $RESN $LOG) $CS.$CSK.$RESN.$LOG))))
  (($CS $SM)  $CS.$SM
   :S
   ((($CS $SM $PS) $CS.$SM.$PS)
    (($CS $SM $DM) $CS.$SM.$DM)
    (($CS $SM $PLN) $CS.$SM.$PLN)
    (($CS $SM $COP) $CS.$SM.$COP)
    (($CS $SM $HTH) $CS.$SM.$HTH)
    (($CS $SM $FIN) $CS.$SM.$FIN)))
  (($CS $CAR) $CS.$CAR)
  (($CS $BSK)    $CS.$BSK
   :S
   ((($CS $BSK $PEOP) $CS.$BSK.$PEOP)
    (($CS $BSK $MECH) $CS.$BSK.$MECH)
    (($CS $BSK $MAIN) $CS.$BSK.$MAIN)
    (($CS $BSK $ATH) $CS.$BSK.$ATH)
    (($CS $BSK $MAN) $CS.$BSK.$MAN)))
  (($CS $SCR) $CS.$SCR
   :S (($CS $SCR $ROLE) $CS.$SCR.$ROLE))
  (($CS $EVT) $CS.$EVT
   :S
   ((($CS $EVT $PER) $CS.$EVT.$PER)
    (($CS $EVT $HIST) $CS.$EVT.$HIST)
    (($CS $EVT $HYP) $CS.$EVT.$HYP)))
  (($CS $ELM)    $CS.$ELM
   :S
   ((($CS $ELM $PEO) $CS.$ELM.$PEO)
    (($CS $ELM $OBJ) $CS.$ELM.$OBJ)
    (($CS $ELM $ANM) $CS.$ELM.$ANM))))
 (($VER)   $VER
  :S
  ((($VER $GRA) $VER.$GRA) (($VER $SEN) $VER.$SEN) (($VER $WRD) $VER.$WRD)))
 (($IMG) $IMG)
 (($SND$) $SND$)
 (($SML) $SML)
 (($TST) $TST)
 (($EMT)   $EMT
  :S
  ((($EMT $HAP) $EMT.$HAP)
   (($EMT $LOV) $EMT.$LOV)
   (($EMT $ANX) $EMT.$ANX)
   (($EMT $ANG) $EMT.$ANG)
   (($EMT $DEP) $EMT.$DEP)))
 (($MOT) $MOT :S (($MOT $SPH) $MOT.$SPH)))
 "Use *CS-CATS-TREE only for category syms.  Use the MOST SPECIFIC CAT AS THE BEGIN CAT for individual cells, etc.")



;;OLDER --------------------------------------------------------------------
POSSIBLE FILE STORAGE SCHEMES
NOW--FOR LIMITED SIZE PERSON DATABASE
SET EACH TYPE TO A SYMBOL (Question Syms follow) 
    I. DB-ITEM TYPES (Make a separate DB-ITEM LIST for each separate item.
      Each has PARTS (separate keys for each part in II. with links to those brain ares) and each may have LINKS (specifiec in paths (eg :BIPATH) to other DB-ITEMS of the same or different type as it. 
  Note: Classes may overlap and a db-item may be a member of more than one type [to list in both or just one--probably just one. Later search both cats to find it.]
       *DB-VALUE (VALUE)
       *DB-BELIEF (SELF STEREOTYPE REGNANT)
       *DB-PC (OPPOSITE)
       *DB-KNOWB (ISA PART WHY CAUSE EVIDENCE HOW EXAMPLE FEATURE PROTOTYPE)
       *DB-COGSK (SM DEC PLAN LEARN COPE CRITTHK)
       *DB-BEHSK (PEOP MECH MAINT )
       *DB-SCRIPT (SCRIPT)
       *DB-EVENT (EVENT)
       *DB-ELM (ELM)   Any abstract or concrete object or entity (eg person,group, object, city, ocean, factory, university, congress, )

  II. INTEGRAL PARTS OF THE DB-ITEM (put within defining/describing list)
       *DB-VERBAL  (NAME DEFINE DESCRIPTION OPPOSITE SYNONYM)
       *DB-IMAGE (IMAGE)
       *DB-SOUND (SOUND)
       *DB-SMELL (SMELL)
       *DB-TASTE (TASTE)
       *DB-TACTILE (TACTILE)
       *DB-EMOTION (EMOTION HAPPY CARE ANXIETY ANGER SAD  )
       *DB-MOTOR (MOTOR)


 WHAT TO DO WITH  ?? ALT-R OPPOSITE SYNONYM
EG. ELMSYM of MOTHER=>
("MOTHER" "mother" ELM2-1-1-99 NIL NIL :BIPATH (((MOTHER NIL (CAREFOROTHERS (POLE1) NIL))) ((MOTHER NIL (INTIMATE (POLE1) NIL))) ((MOTHER NIL (FLEXIBLE (POLE1) NIL))) ((MOTHER NIL (CASUAL (POLE1) NIL))) ((MOTHER NIL (EGOTISTICAL (POLE2) NIL))) ((MOTHER NIL (EXUBERANT (POLE2) NIL))) ((MOTHER NIL (NOTTHEORIST (POLE1) NIL))) ((MOTHER NIL (LOVEX (POLE1) NIL))) ((MOTHER NIL (LOVEDANCE (POLE1) NIL))) ((MOTHER NIL (HELPINGCAREER (POLE2) NIL))) ((MOTHER NIL (HIGHIMPACT (POLE2) NIL)))))
EG. PCSYM of  CAREFOROTHERS=>
("CAREFOROTHERS" "CARE FOR OTHERS vs SELFISH" CS2-1-1-99 NIL NIL :PC ("CARE FOR OTHERS" "SELFISH" 1 NIL) :POLE1 "CARE FOR OTHERS" :POLE2 "SELFISH" :BESTPOLE 1 (:BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL))))


LATER--FOR VERY LARGE INDIVIDUAL PERSON DATABASE
  * Divide by TYPES of CSYMs (eg. value, concept, object, event, sensory, motor, etc) and
  by SUBTYPES (eg concept subtypes, phil, psy, soc, history, political, math, physics, (univ in head) ETC. with a file with filename = a symbol using a code to tell what type and subtype of csym is stored in each file.
  * Don't try to develop a complete catogorization system at first. start with larger categories and break into subtypes as needed.
   FILENAME=  MAJORCATN-SUBCATN-ETC.lisp  ETC could be sub-subcats, etc.
        EG. SENS5-VIS3.lisp (CAT=Sensory, N=file5; Subcat= Visual, N=3)
 
 xxx  ===== PROPOSED MAJOR EXPLORE DATA  CATEGORIES ======
  SUPERORDINATE (SUP) the overall top CSs include VAL, BEL, ??? Lower CSs can also have values, beliefs, skills, etc too?
  VALUES (VAL)
  (PERSONAL) BELIEFS-PHILOSOPHY (BEL)
  PERSONAL CONSTRUCTS (PC)
  KNOWLEDGE BASE (KB)  University in head
    Subareas are academic depts
  COGNITIVE-SKILLS (COGSK) Egs SM, PLAN, DEC, 
  BEHAVIORAL-SKILLS (BEHSK) Egs. PEOP (interpersonal), MECH, MAINT,

  ELEMENT (ELM) Any abstract or concrete object or entity (eg person,group, object, city, ocean, factory, university, congress, )

  EVENT-TYPES (EVTYP)
  SCRIPTS (SCPT) An abstract description/expectation(s) (with alternatives and super/subscripts) that relates to expected actions and (sub)events in a larger event.
           see Abelson, et for more on this whole concept.
  EVENT (EV) any related system of actions/changes in elements over a specified time.


|#
xxx ======= CS RELATIONSHIPS/LINKS (from CS-explore-questions.lisp)  ===
ISA Q: What kind/type? Member of class=?
MEMBER/PART Q: List members/parts of ... 
WHY Q: Why is it important? Why does it exist? 
CAUSE Q: What caused it?
EVIDENCE  Q: What is the evidence for ?
HOW TO  Q: Ways to ..?  Steps to ?
EXAMPLE,INSTANCE Q: Example of ?  Concrete Ex/Instance of ?
EVENT Q: What event(s)  led to? are examples of?
FEATURE Q: What are the features of ?
STEREOTYPE Q: What are other (features/chars/..) of ?
REGNANT Q: Is X the only ? Are X and Y always/exclusively associated?
PROTOTYPE Q: What example best demonstrates the essence of/most features of ?
ALTERNATE RESPONSES  Q: What are some (of the main?) alternatives to ?
VALUES, GOALS, SD, REINFS,
  VALUES Q "What values do you strongly associate with  ~A?"
  GOALS Q: "What goals do you strongly associate with  ~A?" 
  SITUATIONS-SD Q  "What situations or stimuli usually or frequently PRECEDE  ~A?"
  REINFS Q "What rewards or positive outcomes do you associate with  ~A?"
  PUNISHS Q "What negative outcomes do you associate with  ~A?"
SCRIPTS Q "What SCRIPTS for behavior (eg. 'ordering in a restaurant') do you associate with  ~A?

MODALITY LINKS--------
VERBAL
  NAME Q: What is the (best) name(s) of ? 
  DEFINTION   Q: What is the best definition(s) of ?
  DESCRIPTION Q: What is the best descriptions(s) of ?
  OPPOSITE Q: What is the opposite of ?
  SYNONYM Q: What words have a meaning similar to ?
VISUAL IMAGE Q: What visual image(s) come to mind when you think of/do you associate with ?
SOUND Q: What sounds come to mind when you think of/do you associate with ?
SMELL,TASTE Q: What smells or tastes come to mind when you think of /do you associate with?
EMOTIONAL  Q: What emotions do you associate with ?  Anxiety, sad, anger, happiness, love, etc ask each separately? With FU Q: Why, What events/situations/ etc come to mind?
TACTILE Q: What tactile sensations come to mind when you think of /do you associate with?
SITUATIONS (Sd, cS)  Q: What situations or stimuli do you associate with ?
MOTOR S-R LINKS  Q: What habits or actions do you associate with ?



== END CS RELATIONSHIPS (to follow-quiz?)  ===========================

CS-EXPLORE STEPS:
1. PRESENT CS-EXPLORE-QUESTIONS from CS-explore-questions.lisp;   output to: *CS-EXPLORE-DATALIST
2. ASK TO NAME EACH INPUT ANSWER (VERBAL LABEL)
3. Make NAME a pcsym and set to a pcsymlist with first INPUT as :description, etc.
4. ADD IT AND TYPE TO PCSYMLIST OF PC BEING EXPLORED (mostly under (:BIPATH (:ISA (THISPC THATPC ..) etc
5. LATER? Fill in missing parts (eg opposite pole, best pole, value rating, etc.)
6. STORE IN MAIN PCSYMS DATABASE

;;ALSO, TRY PC REPTEST ON 3 VALUES AT A TIME TO GET HIGHER ORDER
;; NOTE: My value of happiness NEVER was elicited by my taking the CS-REPTEST the first time.
S






xxx ================ BRAIN SUBSYSTEMS ===================
CLASS BY LOCATION

FRONTAL
  PREFRONTAL

  RIGHT HEMI

  LEFT HEMI


TEMPORAL


OCCIPITAL


PARIETAL


CEREBELLUM


LIMBIC


BRAIN STEM, SPINAL



xxx ===============CS-BRAIN CLASS BY FUNCTION =================
;;SSSSS -USE CS-BRAIN CLASS BY FUNCTION  AS A MAIN CS CAT SYSTEM??

I. KNOWLEDGE BASE (KB)  [DECLARATIVE KNOWLEDGE]
  * RELATIONSHIPS (MATH, MAP/VISUAL, VERBAL, CAUSATION,)
  * OBJECTS (INANIMATE, ANIMATE)
  * ABSTRACT KNOWLEDGE DOMAINS (UNIV IN HEAD)

  CLASSIFICATIONS
   1. ABSTRACTION: General/scientific to applied/practical (engineering) knowledge.
   2. SCOPE: Cosmology--Earth Sciences-Biology-Sociology-Psychology, Chemistry, Physics
   3. HUMAN/SOCIETAL DOMAIN: Political/Organizational/Business, Behavioral, Engineering, Medical, Communication/Media/Internet, Transportation, Arts (Literature, Music,  News,, Sports, Food, Building/Housing, Infrastructure, Education, Police/Military, Economic, Finance/accounting, History/records, Safety/Fire/etc, Geography, Computation/AI

  
  
II. WORLDVIEW (WV)  [SELF, WORLD, OTHERS]
  * PHIL OF LIFE
  * VALUES
  * PERSONAL VIEW of world, nation, state/city/neighborhood,  etc.
  * PERSONAL WORLD; work, groups (family, friends, orgs,)  maintenance, play,hobbies


III. PROCEDURAL-EXECUTIVE FUNCTIONS (EXECFUN)

EXECUTIVE STRUCTURE (EXEC)
  * COMMITMENTS/DECISIONS
  * GOALS
  * PLANS

GOAL-PLAN DOMAINS (GOALS)
  * CAREER COMMIT,GOAL,PLAN
  * PERSONAL COMMIT,GOAL,PLANS
  * INTERPERSONAL COMMIT,GOAL,PLANS

EXECUTIVE SKILLS (EXECSK)
  * SELF/TIME-MANAGEMENT
  * DECISION-MAKING/PROBLEM-SOLVING
  * LEARNING/METHODOLOGY/CRITICAL-THINKING
  * SELF-MOTIVATION/DISCIPLINE
  * EMOTIONAL COPING

 LIFE AREA SKILL DOMAINS (Integrated with KB declarative above)
  * CAREER-RELATED/SPECIALTY SKILLS PHD
  * PERSONAL (exec skills above plus ??)
  * INTERPERSONAL SKILLS

  

VERBAL/SPEECH (VERB)
  LABELS/NOUNS

EVENTS/EPISODES (EP)
   * THEMES
   * SCRIPTS
   * CHAPTER
   * EPISODE
   * EVENT
   * STORIES (may be real or imagined)
   * HABITS/SKLLS: Sd--R--Sr units (overlaps with skills above)


EMOTIONAL (EMOT) [close connect to values, goals, etc.]
  HAPPY/LOVE
  ANXIETY/FEAR
  ANGER
  DEPRESSION



INPUT (INPUT)
 * VISUAL
 * AUDITORY/VERBAL
 * SMELL
 * TASTE
  * TACTILE


OUTPUT
  * MOTOR (voluntary cns)
  * AUTONOMIC (involuntary ns)




|#


;;xxx =========== FORMAT FOR ALL QVARS & QUESTIONS =====
;;EXAMPLES 
#|
;;QVARS ;;here99 -----------------------------------------------------------
;;
  ;;SINGLE-SELECTION SHAQ
( STUFEEL
 ( "stulookf"
 "sa-Look forward to campus"
 "spss-match" 
 ("stuLookForward")
 ("stuLookForward" "21" "stuLookForwardQ" "int" "LikeMe7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "StudentBasicData.java")
 (:help nil nil)
  )
[NOTE: FROM ABOVE  (fifth sublist) = "LikeMe7"; eval to get quest info below:
(defparameter  LikeMe7   
    '(LikeMe7Instructions  7 
                           LikeMe7AnswerArray  Values7to1Array  "single"  "int"))
(defparameter  LikeMe7Instructions   
    "Accuracy/degree like you:")
(defparameter   LikeMe7AnswerArray   
    '("EXTREMELY accurate / like me"  "MODERATELY accurate / like me" 
              "MILDLY accurate / like me"  "UNCERTAIN, neutral, or midpoint" 
             "MILDLY inaccurate / unlike me"  "MODERATELY inaccurate / unlike me" 
              "EXTREMELY inaccurate / unlike me"))
END NOTE]


 ( "stulikei"
 "sa-Like instructors-can talk"
 "spss-match"
 ("stuLikeInstr")
("stuLikeInstr" "22" "stuLikeInstrQ" "int" "LikeMe7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "StudentBasicData.java")
 (:help *CONNECT-COL  na)
  )  ETC
  ;;no more data in overall category list
  )
;;SM QVARS
(SM
 ( "smtbusy"
 "sm-Rarely upset about too rushed"
 "spss-match"
 "smtBUSY"
 ("smtBUSY" "13" "smtBUSYQ" "int" "LikeMe7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "bsSelfManagement.java")
 (:help nil nil)
  )
 ( "smtfutur"
 "sm-Time planning and distant goals"
 "spss-match"
 "smtFUTURePlan"
 ("smtFUTURePlan" "2" "smtFUTURePlanQ" "int" "LikeMe7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "bsSelfManagement.java")
 (:help nil nil)
  ) ETC
  ;;no more data in category list
  )
;;SM QUESTION VARS
     (SM
       (SM-INSTR ("Self-Management Questions:"   "Honest answers give you the most accurate results."))
       (SMTBUSYQ ("I rarely get upset about being too rushed, having too many things to do, or not having any time to relax.") SM-INSTR  SMTBUSYQ) ETC
  ;;end SM )
  ;;MULTI-ITEM SHAQ QVARS
(UTYPE
 ( "utype"
  "UserType"
 NIL NIL
 (:TITLE ("SHAQ CARES:
 Selection of Your Questionnaires-Part 1") 
  :QUEST ( "  ==> FIND YOUR HAPPINESS QUOTIENT (HQ). 
         Research shows that 75% of people's overall happiness score is accounted for by the SHAQ HQ score (Stevens, 2009). Your HQ values, beliefs, and life skills may be powerful influences on your past, current, and future happiness. 
         HQ factors are CONTROLLABLE factors: you can choose to be happy by improving them. 
         ==> Why are you taking SHAQ?" ))
  (:help nil nil)
 NIL
 :MULTI-ITEM
  )
( "twanttho"
 "t-Want thorough assessment"
 "spss-match"
 NIL
 ("Want a thorough assessment and/or my Happiness Quotient (HQ) Score.")
 (:help nil nil)
 :MULTI-ITEM
 (:XDATA :scales (HQ))
  )
ETC
 ( "u-none"
 "t-none of above"
 NIL
 NIL
 ("Other or None of above.")
 (:help nil nil)
 :MULTI-ITEM
  (:XDATA :scales NIL)
  )
;;end UTYPE CAT LIST
 )

  ;;PC QVARS
  '((PCE-PEOPLE
     ("mother""mother"  "single-text" ("mother" "1" "motherQ" "pc-element" "Pc-Element"))
     ("father""father"  "single-text" ("father" "2" "fatherQ" "pc-element" "Pc-Element"))  ETC
     :single-text
     )
    
    (CS-DECLARATIVE ;; $KNW?
    ("ISA" "ISA" "multi-text" ("ISA" "1" "ISAQ" "cs-link" "$KNW") NIL NIL :LNTP :ISA) 
   
     ("EX" "EXAMPLE" "single-text" ("EG" "7" "EXQ" "$KNW" "$KNW") NIL NIL :LNTP :EX)
     ;;end CS-DECLARATIVE
     )

   ;;MULTI-ITEM LNTP
    (EMOT 
     ;;INTRO INFO
     ("EMOT"  "EMOT" NIL NIL (:TITLE  ("   TYPE OF EMOTION")
                      :QUEST ("    Select the EMOTION(S) that is/are MOST strongly associated with this item") NIL NIL :LNTP :EMOT) 
      (:help nil nil) NIL :MULTI-ITEM)
     ;;ITEMS FOLLOW
     ("HAP" "HAPPY"     
      "spss-match"  NIL
      ("  HAPPY")
      (:help nil nil)
      :css "$HAP"
      :LNTP :HAP
      :MULTI-ITEM
      ;;(:XDATA :scales (HQ))
      ) ETC
     (  "NONE" "UNSURE or NONE"
      "spss-match"  NIL
      (" UNSURE or NONE")
      (:help nil nil)
      :MULTI-ITEM)
     ;;end EMOT
     )

|#


