;;************************* CS-Top-System.lisp **************************

;;2020-07-15 PROBLEMS IN VIEWER
;; $SOREL & $SOCAR under 2 Headings  




;;THIS IS THE NEW *MASTER-CSART-CAT-DB & LATEST COPY
;;LEVELS: (determined by supord level of ultimate behavioral,etc control
;;   analogous to organizational chart).
;;   1: HIGHEST SUPORD Cognitive Systems (highest brain systems)
;;   2. DIRECTLY SUBORD CSs to level 1. (high subord brain systems)
;;   3. Next subord CS Level.
;;   4. Other Lower-control level Cognitive Systems
;;   5. Other [mostly] NON-COGNITIVE Systems (lower brain systems)


;;TO MAKE *CS-CAT-DB-TREE 
;;STEPS: 1. MADE WITH (MAKE-CSYM-TREE)
;;  (setf *CS-CAT-DB-TREE (MAKE-CSYM-TREE))
;;  2. COPY FROM OUTPUT-FILE: CS-CAT-DB-TREE.lisp
;;  3. PASTE IN THIS FILE
;;
;; NON-FILE VERSION
;;  2. USE PPRINT-LISTS *CS-CAT-DB-TREE)
;; (pprint-lists *CS-CAT-DB-TREE)
;;  3. Copied output text to a new buffer.
;; 4. SEARCH & REPLACED following: \", keywords ":CSS" to :CSS, ":S", ":QT", ":SYS", ":CLEV", etc??
;; 5. copied back to the defparameter *CS-CAT-DB-TREE
;;
;;SSSSSS MAKE NEW CSYM TREE
;;NOTE: make-csym-tree creates MINIMAL CSQ SCALES CSYMS.  Must REPLACE the scale & qvar csyms with new ones made by Make-CSQ-csyms.

(Defparameter $P '("$P" "Persim Model" NIL "Person Simulation Model" :S ($CS) :CLEV 0 :QT :SYS) "Root of all CSYMs" )

;;TO MAKE THE *MASTER-CSART-CAT-DB CSYMS
;; EVAL: (set-syms-to-second *MASTER-CSART-CAT-DB)

(Defparameter *MASTER-CSART-CAT-DB 
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
    ($BIO ("$BIO" "Bio Info" NIL NIL NIL :CSS $SLF :CLEV 4 :QT :SYS
           :S (<UserID <sex <age <nation <zipcode <HrsWork <utype <ugoals <bio3educ <bio4job <bi07lang <bio1ethn <biorelaf)))
    ;;$DOM: Higher order domains of integrated knowledge/skills/etc.
    ($DOM ("$DOM" "Domain" NIL NIL NIL  :CSS $EXC :S ($PERS $OREL $CARR $ACAD   $TBD) :QT :SYS :CLEV  2))
    ($PERS ("$PERS" "Personal Domain"  NIL NIL NIL :CSS $DOM :S nil  :QT :SYS :CLEV  2)) ;;not work (<BIO-TEXT)
    ($OREL ("$OREL" "Relationship Outcomes" NIL  NIL NIL :S (<srpeople) :CSS $DOM   :QT :SYS :CLEV  4))
    ($CARR ("$CARR" "Career Domain"  NIL NIL NIL  :CSS $DOM :S ($CARI $OCAR) :QT :SYS :CLEV  2))
    ($CARI ("$CARI" "Career Interest"   NIL NIL NIL  :CSS $CARR :QT :SYS :CLEV  3 :S (<sincar <sinbus <sinengr  <sinfinea  <sinhelp <sinlang  <sinmed  <sinmiltc  <inNatSci  <sinsocsc  <sinwoeth  <sinwrite )))
    ($OCAR ("$OCAR" "Career Outcomes"  NIL  NIL NIL :S NIL :CSS $CARR   :QT :SYS :CLEV  3))      
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

    ( $LNG ("$LNG""Language"  NIL  NIL NIL :S ($VER $MTH $LOG) :CSS $CS  :QT :SYS :CLEV  1))
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
    ($BOD ("$BOD" "Body-Health" NIL NIL NIL :S ($HLTH) :QT :SYS :CLEV  5))
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

    ;;MISC CSYMS: use modified regular qvars instead
#|    (<UserID ("<UserID" "User ID" NIL NIL NIL :CSS $BIO :QT :TXT :CLEV 5))
    (<SEX ("<Sex" "Sex" NIL NIL NIL   :CSS $BIO :QT :TEXT  :CLEV 5))
    (<AGE ("<Age" "Age"NIL NIL NIL   :CSS $BIO :QT :TEXT :CLEV 5))
    ;; ("USA?" "Live in USA?" NIL NIL NIL NIL NIL :CSS $BIO :QT :TXT))
    (<NATION ("<Nation" "Nation" NIL NIL NIL   :CSS $BIO :QT :TEXT :CLEV 5))
    (<ZIPCODE ("<ZipCode" "ZipCode" NIL NIL  NIL   :CSS $BIO :QT :TEXT :CLEV 5))
    (<HrsWork ("<HrsWork" "HrsWork" NIL NIL  NIL :CSS $BIO :QT :TEXT :CLEV 5))|#
    )
  "All CSART category symbols where each list= (long-csartsym (short-csartsym :S subcsyms-list :QT :SYS :CLEV  integer; where :QT :SYS :CLEV  is the category abstraction/brain level [1=top]")




;;USED FOR MAKING CSYMS from CSQ-SHAQ data
(defparameter *CSQ-MAIN-SCALE-CLASSES '(VALUES-THEMES BELIEFS 
                                                      SKILLS-CONFIDENCE INTERPERSONAL 
                                                      ACAD-LEARNING CAREER-INTEREST 
                                                      OUTCOME BIO) "Main categories of standard, 
                                                   usually single-selection questions.")

(defparameter *CSQ-BIO-ACAD-ETC-SYS/QVARS 
   ;;not needed ($BIO (UTYPE UGOALS BIO3EDUC BIO4JOB BI07LANG BIO1ETHN BIORELAF))
     '($ACAD (STUCOLLE STUMAJOR STUSPECI STURESID STU-DATA STGPATRE STUAPT STUFEEL STURESOURCE STUACMOTIV STU-LRN))
  ;; ($PERS (      )) ($CAREER (    ))
  "Used for making QVAR-CSYMS")

;;(MAKE-CSYM arglists: (csym csphrase csdata csdef &key (if-csym-exists :do-nothing) (csartloc-origin :supsys-csartloc) (topdim (quote $sc)) dims supsys (def-supsys (quote $mis)) parents (last-dim :csym) supsys-csartloc new-csartloc (make-new-csartloc-p t) new-csartloc-vals (update-supsys-sublist-p t) csartloc-n3-item csartloc-rest-vals (supsys-key :css) sublist (sublist-key :s) linktype (linktype-key :lntp) value1 value2 sd ETC.
(defparameter *CUSTOM-ARGLISTS-FOR-CSYMS  
  '(("UserID" "User ID" NIL NIL  :supsys $BIO :csartloc-origin :supsys-csartloc :supsys-csartloc $CS.$BIO :QT :TXT)
   ("Sex" "Sec" NIL NIL  :supsys $BIO :csartloc-origin :supsys-csartloc :supsys-csartloc $CS.$BIO :QT :TXT)
   ("Age" "Age"NIL NIL  :supsys $BIO :csartloc-origin :supsys-csartloc :supsys-csartloc $CS.$BIO :QT :TXT)
  ;; ("USA?" "Live in USA?" NIL NIL  :supsys $BIO  :valnth 3)
   ("Nation" "Nation" NIL NIL  :supsys $BIO :csartloc-origin :supsys-csartloc :supsys-csartloc $CS.$BIO :QT :TXT)
   ("ZipCode" "ZipCode" NIL NIL  :supsys $BIO :csartloc-origin :supsys-csartloc :supsys-csartloc $CS.$BIO :QT :TXT)
   ("HrsWork" "HrsWork" NIL NIL  :supsys $BIO :csartloc-origin :supsys-csartloc :supsys-csartloc $CS.$BIO :QT :TXT)
    )
   "CSQ-SHAQ questions converted into arglists for CSYMS")

;;SSSSS DO HQ LATER -- USE WITH HIGHER-SELF CS??
(defparameter *CSQ-SPECIAL-SCALE-CSYM-ARGLISTS   '(("sID" )("BIO-MAQ")("BIO-TEXT"  ) ("INTRO-MAQ") ("HQ"  )("HigherSelfScale")) "Arglists for making CSYMS from special CSQ scales & items that don't work with regular make-csym functions")
















 ;; (SETF *CS-CAT-DB-TREE NIL)
#|(DEFPARAMETER *CS-CAT-DB-TREE
  '(("$CS"
  "All Main Systems"
  $P.$CS
  NIL
  NIL
  :QT
  :SYS
  :QT :SYS :CLEV 
  0
  :S
  ($EXC $PC $ELM $EP $PCPT $LNG $BHB $BOD $OUTC $MIS))
 ((("$EXC"
    "Executive"
    $P.$CS.$EXC
    NIL
    NIL
    :QT
    :SYS
    :CSS
    $CS
    :QT :SYS :CLEV 
    1
    :S
    ($BV $GPL $SKL))
   ((("$BV"
      "Beliefs-Values"
      $P.$CS.$EXC.$BV
      NIL
      NIL
      :QT
      :SYS
      :CSS
      $CS
      :QT :SYS :CLEV 
      2
      :S
      ($TBV $HISF $WV $SLF $DOM))
     ((("$TBV"
        "Top Belief-Value"
        $P.$CS.$EXC.$BV.$TBV
        NIL
        NIL
        :QT
        :SYS
        :CSS
        $BV
        :QT :SYS :CLEV 
        2
        :S
        (<ST2SOCINTIMNOFAM
         <ST3FAMCARE
         <ST4SUCCESSSTATUSMATER
         <ST5-ORDERPERFECTIONGOODNESS
         <ST6GODSPIRITRELIG
         <ST7IMPACTCHALLENGEEXPLOR
         <ST8ATTENTIONFUNEASY
         <ST9VALUESELFALLUNCOND
         <ST10OVERCMPROBACCEPTSELF
         <ST11DUTYPUNCTUAL
         <SETHBEL
         <SGRFEARS))
       NIL
       ("$HISF"
        "Higher Self"
        $P.$CS.$EXC.$BV.$HISF
        NIL
        NIL
        :QT
        :SYS
        :CSS
        $BV
        :QT :SYS :CLEV 
        2
        :S
        (<ST1HIGHERSELF))
       NIL
       ("$WV"
        "Worldview"
        $P.$CS.$EXC.$BV.$WV
        NIL
        NIL
        :QT
        :SYS
        :CSS
        $BV
        :QT :SYS :CLEV 
        2
        :S
        (<SWORLDVIEW))
       NIL
       ("$SLF"
        "Self"
        $P.$CS.$EXC.$BV.$SLF
        NIL
        NIL
        :QT
        :SYS
        :CSS
        $BV
        :QT :SYS :CLEV 
        3
        :S
        (<STBSLFWO <SSLFCONF))
       NIL
       ("$DOM"
        "Domain"
        $P.$CS.$EXC.$BV.$DOM
        NIL
        NIL
        :QT
        :SYS
        :CSS
        $BV
        :QT :SYS :CLEV 
        2
        :S
        ($PERS $CARR $ACAD $TBD))
       NIL))
     ("$GPL"
      "SupOrd Goals&Plans"
      $P.$CS.$EXC.$GPL
      NIL
      NIL
      :QT
      :SYS
      :CSS
      $EXC
      :QT :SYS :CLEV 
      2)
     NIL
     ("$SKL"
      "Supord Cog Skills"
      $P.$CS.$EXC.$SKL
      NIL
      NIL
      :QT
      :SYS
      :QT :SYS :CLEV 
      2
      :S
      ($PS $DM $PLN $COP $LNRE $INTP $MECH $MAIN <SSLFCONF))
     ((("$PS" "ProbSolv" $P.$CS.$EXC.$SKL.$PS NIL NIL :QT :SYS :CSS $SM :QT :SYS :CLEV  3)
       NIL
       ("$DM" "DecMaking" $P.$CS.$EXC.$SKL.$DM NIL NIL :QT :SYS :CSS $SM :QT :SYS :CLEV  3)
       NIL
       ("$PLN" "Planning" $P.$CS.$EXC.$SKL.$PLN NIL NIL :QT :SYS :CSS $SM :QT :SYS :CLEV  3)
       NIL
       ("$COP"
        "EmotCope"
        $P.$CS.$EXC.$SKL.$COP
        NIL
        NIL
        :QT
        :SYS
        :CSS
        $SM
        :QT :SYS :CLEV 
        3
        :S
        (<SEMOTCOP))
       NIL
       ("$LNRE"
        "ResearchLearn"
        $P.$CS.$EXC.$SKL.$LNRE
        NIL
        NIL
        :QT
        :SYS
        :CSS
        $SKL
        :QT :SYS :CLEV 
        3)
       NIL
       ("$INTP"
        "Interpersonal Skill"
        $P.$CS.$EXC.$SKL.$INTP
        NIL
        NIL
        :QT
        :SYS
        :CSS
        $SKL
        :QT :SYS :CLEV 
        3
        :S
        (<INTSS1AASSERTCR
         <INTSS1BOPENHON
         <INTSS2ROMANTC
         <INTSS3LIBROLE
         <INTSS4LOVERES
         <INTSS5INDEP
         <INTSS6POSSUP
         <INTSS7COLLAB))
       NIL
       ("$MECH" "Mech" $P.$CS.$EXC.$SKL.$MECH NIL NIL :QT :SYS :CSS $SKL :QT :SYS :CLEV  3)
       NIL
       ("$MAIN"
        "Mainenance"
        $P.$CS.$EXC.$SKL.$MAIN
        NIL
        NIL
        :QT
        :SYS
        :CSS
        $SKL
        :QT :SYS :CLEV 
        3)
       NIL
       ("<SSLFCONF" NIL $P.$CS.$EXC.$SKL.<SSLFCONF NIL NIL :QT :SYS)
       NIL))))
   ("$PC" "Personal Construct" $P.$CS.$PC NIL NIL :QT :SYS :QT :SYS :CLEV  1)
   NIL
   ("$ELM"
    "Element"
    $P.$CS.$ELM
    NIL
    NIL
    :QT
    :SYS
    :CSS
    $CS
    :QT :SYS :CLEV 
    1
    :S
    ($PER $GRP $OBJ))
   ((("$PER" "Person" $P.$CS.$ELM.$PER NIL NIL :QT :SYS :QT :SYS :CLEV  3)
     NIL
     ("$GRP" "Group" $P.$CS.$ELM.$GRP NIL NIL :QT :SYS :QT :SYS :CLEV  3 :S ($RFGP))
     ((("$RFGP" NIL $P.$CS.$ELM.$GRP.$RFGP NIL NIL :QT :SYS) NIL))
     ("$OBJ" "Object" $P.$CS.$ELM.$OBJ NIL NIL :QT :SYS :QT :SYS :CLEV  3)
     NIL))
   ("$EP" "Episode" $P.$CS.$EP NIL NIL :QT :SYS :QT :SYS :CLEV  2 :S ($SCR $EVT))
   ((("$SCR" "Script" $P.$CS.$EP.$SCR NIL NIL :QT :SYS :QT :SYS :CLEV  3)
     NIL
     ("$EVT" "Event" $P.$CS.$EP.$EVT NIL NIL :QT :SYS :QT :SYS :CLEV  3)
     NIL))
   ("$PCPT"
    "Percept"
    $P.$CS.$PCPT
    NIL
    NI
    :QT
    :SYS
    :CSS
    $SC
    :QT :SYS :CLEV 
    1
    :S
    ($IMG $SOND $SML $TST $TCT $BND))
   ((("$IMG" "Image" $P.$CS.$PCPT.$IMG NIL NIL :QT :SYS :CSS $PCPT :QT :SYS :CLEV  3)
     NIL
     ("$SOND" "Sound" $P.$CS.$PCPT.$SOND NIL NIL :QT :SYS :CSS $PCPT :QT :SYS :CLEV  3)
     NIL
     ("$SML" "Smell" $P.$CS.$PCPT.$SML NIL NIL :QT :SYS :CSS $PCPT :QT :SYS :CLEV  3)
     NIL
     ("$TST" "Taste" $P.$CS.$PCPT.$TST NIL NIL :QT :SYS :CSS $PCPT :QT :SYS :CLEV  3)
     NIL
     ("$TCT" "Tactile" $P.$CS.$PCPT.$TCT NIL NIL :QT :SYS :CSS $PCPT :QT :SYS :CLEV  3)
     NIL
     ("$BND" "Bio Need" $P.$CS.$PCPT.$BND NIL NIL :QT :SYS :CSS $PCPT :QT :SYS :CLEV  3)
     NIL))
   ("$LNG" "Language" $P.$CS.$LNG NIL NIL :QT :SYS :QT :SYS :CLEV  1 :S ($VER $MTH $LOG))
   ((("$VER" "Verbal" $P.$CS.$LNG.$VER NIL NIL :QT :SYS :CSS $LNG :QT :SYS :CLEV  3)
     NIL
     ("$MTH" "Math" $P.$CS.$LNG.$MTH NIL NIL :QT :SYS :CSS $LNG :QT :SYS :CLEV  3)
     NIL
     ("$LOG" "Logic" $P.$CS.$LNG.$LOG NIL NIL :QT :SYS :CSS $LNG :QT :SYS :CLEV  3)
     NIL))
   ("$BHB"
    "Behavioral Habit"
    $P.$CS.$BHB
    NIL
    NIL
    :QT
    :SYS
    :CSS
    $CS
    :QT :SYS :CLEV 
    3
    :S
    ($SIT $R))
   ((("$SIT" "Situation" $P.$CS.$BHB.$SIT NIL NIL :QT :SYS :CSS $BHB :QT :SYS :CLEV  4)
     NIL
     ("$R" "Responses" $P.$CS.$BHB.$R NIL NIL :QT :SYS :CSS $BHB :QT :SYS :CLEV  4 :S ($MOT))
     ((("$MOT" "Motor" $P.$CS.$BHB.$R.$MOT NIL NIL :QT :SYS :QT :SYS :CLEV  5) NIL))))
   ("$BOD" NIL $P.$CS.$BOD NIL :S ($HLTH) :SYS :QT :SYS :CLEV  5)
   ((("$HLTH"
      "Health"
      $P.$CS.$BOD.$HLTH
      NIL
      NIL
      :QT
      :SYS
      :CSS
      $BOD
      :QT :SYS :CLEV 
      5
      :S
      (<SRELHLTH))
     ((("<SRELHLTH" NIL $P.$CS.$BOD.$HLTH.<SRELHLTH NIL NIL :QT :SYS) NIL))))
   ("$OUTC"
    "Outcome-Emotion"
    $P.$CS.$OUTC
    NIL
    NIL
    :QT
    :SYS
    :QT :SYS :CLEV 
    1
    :S
    ($EMOT $OREL $OCAR))
   ((("$EMOT"
      "Emotions"
      $P.$CS.$OUTC.$EMOT
      NIL
      NIL
      :QT
      :SYS
      :CSS
      $CS
      :QT :SYS :CLEV 
      5
      :S
      ($HAP $CARE $ANX $ANG $DEP))
     ((("$HAP"
        "Happy"
        $P.$CS.$OUTC.$EMOT.$HAP
        NIL
        NIL
        :QT
        :SYS
        :CSS
        $EMOT
        :QT :SYS :CLEV 
        5
        :S
        (<SEHAPPY))
       NIL
       ("$CARE"
        "Caring"
        $P.$CS.$OUTC.$EMOT.$CARE
        NIL
        NIL
        :QT
        :SYS
        :CSS
        $EMOT
        :QT :SYS :CLEV 
        5)
       NIL
       ("$ANX"
        "Anxiety"
        $P.$CS.$OUTC.$EMOT.$ANX
        NIL
        NIL
        :QT
        :SYS
        :CSS
        $EMOT
        :QT :SYS :CLEV 
        5
        :S
        (<SRANXIET))
       NIL
       ("$ANG"
        "Anger"
        $P.$CS.$OUTC.$EMOT.$ANG
        NIL
        NIL
        :QT
        :SYS
        :CSS
        $EMOT
        :QT :SYS :CLEV 
        5
        :S
        (<SRANGAGG))
       NIL
       ("$DEP"
        "Depression"
        $P.$CS.$OUTC.$EMOT.$DEP
        NIL
        NIL
        :QT
        :SYS
        :CSS
        $EMOT
        :QT :SYS :CLEV 
        5
        :S
        (<SRDEPRES))
       NIL))
     ("$OREL"
      "Relationship Outcomes"
      $P.$CS.$OUTC.$OREL
      NIL
      NIL
      :QT
      :SYS
      :CSS
      $EMOT
      :QT :SYS :CLEV 
      5
      :S
      (<SRPEOPLE))
     ((("<SRPEOPLE" NIL $P.$CS.$OUTC.$OREL.<SRPEOPLE NIL NIL :QT :SYS) NIL))
     ("$OCAR"
      "Career Outcomes"
      $P.$CS.$OUTC.$OCAR
      NIL
      NIL
      :QT
      :SYS
      :CSS
      $EMOT
      :QT :SYS :CLEV 
      5)
     NIL))
   ("$MIS" "Misc" $P.$CS.$MIS NIL NIL :QT :SYS :QT :SYS :CLEV  1)
   NIL)))
  
   "MASTER SYS DB TREE"
  )|#










;;======CURRENT *CS-CAT-DB-TREE ===========



;; $BIO = ("$BIO" "Bio Info" $P.$CS.$EXC.$BV.$SLF.$BIO NIL NIL :QT :SYS :CSS $SLF :CLEV 4 :SYSTEM :S (<OTHRNOAN <NOAFFIL <PROLIBER <LUTHERAN <METHODST <ISLAM <LATTERD <CATHOLIC <EOTHER <ESOUTHAM <EMEXICO <EVIETNAM <EKOREA <ECAMBODN <ESOUEUR <EAFRICA <BIO4JOB (<STUDENT <MANAGER <PROPEOP <PROTECH <CONSULTA <EDUCATOR <SALES <TECHNICI <CLERICAL <SERVICE <OWNBUS10 <OTHRSFEM <OTHER) <OTHRSFEM <SERVICE <TECHNICI <EDUCATOR <PROTECH <MANAGER <BIO3EDUC <GNOTTAKE <GCARPLAN <GCOMPLTANOAC <GCOMPLTA1 <GAGGRANG <GDEPRES <GLONELYF <GRELAT <GPROCRST <GEMOCOP <UTYPE (<TWANTTHO <TKNOWMOR <TWANTHEL <TWANTSPE <TEXPERIE <TPREVSHAQ <WANTSPQ <TU100STU <TCSULBST <TCOLSTU <TOTHERST <TRESSUB <TCOLFACA <U-NONE) <TCOLFACA <TOTHERST <TCSULBST ...) :S (<OTHRNOAN <NOAFFIL <PROLIBER <LUTHERAN <METHODST <ISLAM <LATTERD <CATHOLIC <EOTHER <ESOUTHAM <EMEXICO <EVIETNAM <EKOREA <ECAMBODN <ESOUEUR <EAFRICA <BIO4JOB (<STUDENT <MANAGER <PROPEOP <PROTECH <CONSULTA <EDUCATOR <SALES <TECHNICI <CLERICAL <SERVICE <OWNBUS10 <OTHRSFEM <OTHER) <OTHRSFEM <SERVICE <TECHNICI <EDUCATOR <PROTECH <MANAGER <BIO3EDUC <GNOTTAKE <GCARPLAN <GCOMPLTANOAC <GCOMPLTA1 <GAGGRANG <GDEPRES <GLONELYF <GRELAT <GPROCRST <GEMOCOP <UTYPE (<TWANTTHO <TKNOWMOR <TWANTHEL <TWANTSPE <TEXPERIE <TPREVSHAQ <WANTSPQ <TU100STU <TCSULBST <TCOLSTU <TOTHERST <TRESSUB <TCOLFACA <U-NONE) <TCOLFACA <TOTHERST <TCSULBST ...))

;;<LATTERD  = ("<LATTERD" "Latter Day Saints--Morman" $P.$CS.$EXC.$BV.$SLF.$BIO.<BIORELAF.<LATTERD NIL "Latter Day Saints--Morman" :QT :QVAR :CSS $BIO :ADAT ("latterd" NIL))