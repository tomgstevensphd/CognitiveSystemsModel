;;************************* CS-notes.lisp ***************************
;;
;;******************* CS-NOTES.lisp ***********************************
;;NOTES FOR CS SYSTEMS AND CSQ QUESTIONNAIRES


#|xxx
===========   SYSTEM TERMS =========================


SYSTEM (S)-Basic system, large main model system
SUBSYSTEM (SS)-Can have many levels of subsystems
METASYSTEM (MS)-Overlaps systems/subsystems


USE ART TERMS & My ART3 model symbols, etc as much as possible
(Use last of basic def list to be a whole defining tree for BVs??)
NODE
PATH


;;xxx ===================== COG-BV-SYSTEMS =====================
TOPBV
WORLDVIEW
SELF
REFGROUPS
KNOWBASE (Univ in head)

SKILLS (SELFMAN INTERP  LEARN HEALTH ... see self-confid)

ELEMENTS (ELMSYMS) (Actual objects, people, groups, ??) Still is partly abstraction, but mostly sensory-related concrete. Should there be a distinction between abstract and concrete elements? FORMAT same as rest using csym.

ACTIONS (Relatively concrete? actions by concrete objects, people, etc.) Should there be a distinction between levels of abstract vs concrete actions?   FORMAT same as rest using 

;;xxx ========= CS SYSTEMS DISCOVERY METHODOLOGY =============

;;   PC:  WAY 2 ELMS ALIKE AND DIF FROM 3RD VS DIF
;;   HIGHER, SUP PCS: WHY? ISA/PARENT=> HIGHER-ORDER PCS, R HIER.
;;   LOWER, SUB PCS:   HOW? CHILD, GOAL-INSTUMENT? ONE R IN R HIER => LOWER-ORDER PCS, 
;;   ENTITIES: = ELMS
;;   EVENTS:  COMPLEX INTERACTIONS OVER TIME, VIEWED/STORED FROM VARISOUS PERPECTIVES/LEVELS
;;   EPISODES: SIMILAR TO EVENTS, BUT DEFINE BEHAVIORALLY??





;;xxx ================ CS SYMNODE FORMAT ===============

CS DEF LIST (Can "PC" be interchanged for "CS" in most situations. PC is used when the CSs are the result of the Reptest procedure).
* Is LAST OR ?? in an ART node.
* The ART value (4th in symvals) is the csym.(can use setsymval etc on the BV-node symbol).

CSYM evals to CSYMVALS = 
          (csname  csphrase  csdata csart-loc csdef  keywords )
CSNAME (string) the symbol string for the meaning csphrase.
CSPHRASE (string) The meaning phrase of the belief/value. For PCs writes a string of pole1 vs pole2 (eg. "hot vs cold")
CSDATA (list) a list.  (value  etc--to be added?) Eg dif types of values etc)
CSART-LOC: ART symbol whose symvals it is embedded in.
CSDEF (string) definitions/expanded meanings

xxx ======  CSQ DATA KEYWORDS =======================
:INFO Misc info relating to the symnode
:BIPATHS a list of pathlists to/from other nodes (eg. pole to/from element)
  BIPATHLIST = FOR NON-PCs only 1 node: (node-sym (data))
    [Note: PC :bipaths go to every elm, Each elm links to ONE pc pole]
        FOR PCs [either or both poles can have links] 
         eg. :bipaths ((pole1 nil (mother NIL))(pole1 nil (best-friend nil))(pole2 nil (father nil)))
        FOR ELMS TO PCS:  :bipaths (("mother" NIL (TEST-PCSYM (POLE1) NIL))
:TO a list of pathlists to other nodes eg.  (to-element ...)
  TOPATHLIST = ()
:FROM  a list of pathlists from other nodes (eg pole from element)
  FROMPATH  eg (from-element ...)
:WTO a list of weighted pathlists to other nodes
  WPATHLIST = (   )
:WFROM  a list of weighted pathlists from other nodes 
  WFROMPATH = (  )
;;SUBITEMS WITHIN ABOVE KEYS
  :SUBITEM
       (eg. *DBGOAL :BIPATHS (TENNIS NIL  :SUBITEM "win tourney")

;;PATH SUBTYPES BASED UPON CS-EXPLORE QUESTIONS
;; (STORE-IN-CSDBSYM  "*DGOAL" :BIPATHS '("TENNIS" NIL) :subitem "Win Tourney")
;;works=(:BIPATHS (("TENNIS" NIL :SUBITEM "Win Tourney")))  *DGOAL  NIL   "testgetsetsym"  ("TENNIS" NIL :SUBITEM "Win Tourney")
;;also works=  *DGOAL=> (:BIPATHS (("TENNIS" NIL :SUBITEM "Win Tourney"))) 
;; meaning of above: CSDB is *DGOAL it is linked to a NODE="TENNIS". TENNIS IS linked to GOAL with subitem (subgoal)= "Win Touurney" TENNIS also has a :BIPATHS ((*DGOAL NIL :subitem "Win Tourney") etc)

  (SEE CS-explore-questions.lisp for current list)

#|xxx === CS-EXPLORE STEPS: ==============
1. PRESENT CS-EXPLORE-QUESTIONS from CS-explore-questions.lisp
  output to: *CS-EXPLORE-DATALIST
2. ASK TO NAME EACH INPUT ANSWER (VERBAL LABEL)
3. IDENTIFY LINKING PC: Check to see if NAME/PC ALREADY EXISTS
        3.1 IF PC EXISTS, LINK IT TO THIS PCSYM
        3.2 IF PC NOT EXIST,  Make NAME a pcsym and set to a pcsymlist with first INPUT as :description, etc.
4. ADD DATA TO EACH PC in LINK
    4.1 ADD DATA AND TYPE TO PCSYMLIST OF PC BEING EXPLORED (mostly under (:BIPATHS (:ISA (THISPC THATPC ..) 
    4.2 ADD DATA TO NEW/OLD PC ON OTHER END.
5. LATER? Fill in missing parts (eg opposite pole, best pole, value rating, etc.)
6. STORE IN MAIN PCSYMS DATABASE
|#


xxx SSSSSS START HERE BUILDING NEW GRAPH NET MODEL
2018-02 Added for graphing
NODE:  POLE1 POLE2 CNTR (center=for connections affecting entire node)
  P1VARS, P2VARS, CNTVARS
PATH:  INPUT, OUTPUT, BIPATHS  (INVARS, OUTVARS, BIVARS)
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
;;MOTHER=  ("MOTHER" "mother" ELM2-1-1-99 NIL NIL :BIPATHS (((MOTHER NIL (A4 (POLE2) NIL))) ((MOTHER NIL (B7 (POLE2) NIL))) ((MOTHER NIL (C0 (POLE2) NIL))))) 
;;named 
;; BEST-M-FRIEND =  ("BEST-M-FRIEND" "best-m-friend" ELM4-1-1-99 NIL "dave" :BIPATHS (((BEST-M-FRIEND NIL (A4 (POLE1) NIL))) ((BEST-M-FRIEND NIL (C0 (POLE1) NIL))) ((BEST-M-FRIEND NIL (D4 (POLE1) NIL))))) 
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
;; HAPPY2 => ("HAPPY2" "HAPPY vs UHAPPY" CS2-1-1-99 NIL NIL :PC ("HAPPY" "UHAPPY" 1 NIL) :POLE1 "HAPPY" :POLE2 "UHAPPY" :BESTPOLE 1 :BIPATHS ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL FATHER NIL)) :CSVAL "1.000" :CSRANK "1" :XYLOC (100 100))

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
("MOTHER" "mother" ELM2-1-1-99 NIL NIL :BIPATHS (((MOTHER NIL (CAREFOROTHERS (POLE1) NIL))) ((MOTHER NIL (INTIMATE (POLE1) NIL))) ((MOTHER NIL (FLEXIBLE (POLE1) NIL))) ((MOTHER NIL (CASUAL (POLE1) NIL))) ((MOTHER NIL (EGOTISTICAL (POLE2) NIL))) ((MOTHER NIL (EXUBERANT (POLE2) NIL))) ((MOTHER NIL (NOTTHEORIST (POLE1) NIL))) ((MOTHER NIL (LOVEX (POLE1) NIL))) ((MOTHER NIL (LOVEDANCE (POLE1) NIL))) ((MOTHER NIL (HELPINGCAREER (POLE2) NIL))) ((MOTHER NIL (HIGHIMPACT (POLE2) NIL)))))
EG. PCSYM of  CAREFOROTHERS=>
("CAREFOROTHERS" "CARE FOR OTHERS vs SELFISH" CS2-1-1-99 NIL NIL :PC ("CARE FOR OTHERS" "SELFISH" 1 NIL) :POLE1 "CARE FOR OTHERS" :POLE2 "SELFISH" :BESTPOLE 1 (:BIPATHS ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL))))


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
4. ADD IT AND TYPE TO PCSYMLIST OF PC BEING EXPLORED (mostly under (:BIPATHS (:ISA (THISPC THATPC ..) etc
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