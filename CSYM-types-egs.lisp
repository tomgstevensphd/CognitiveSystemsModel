;;*********************** CSYM-types-egs.lisp ****************************





;;xxx  EG  ELMSYMS -----------------------------------------------------------------
;; 
;; MOTHER =  
#|("MOTHER"
 "mother"
 ELM2-1-1-99
 NIL
 NIL
 :BIPATH
 (((MOTHER NIL (CAREFOROTHERS (POLE1) NIL)))
  ((MOTHER NIL (INTIMATE (POLE1) NIL)))
  ((MOTHER NIL (FLEXIBLE (POLE1) NIL)))
  ((MOTHER NIL (CASUAL (POLE1) NIL)))
  ((MOTHER NIL (EGOTISTICAL (POLE2) NIL)))
  ((MOTHER NIL (EXUBERANT (POLE2) NIL)))
  ((MOTHER NIL (NOTTHEORIST (POLE1) NIL)))
  ((MOTHER NIL (LOVEX (POLE1) NIL)))
  ((MOTHER NIL (LOVEDANCE (POLE1) NIL)))
  ((MOTHER NIL (HELPINGCAREER (POLE2) NIL)))
  ((MOTHER NIL (HIGHIMPACT (POLE2) NIL)))))|#

;; BEST-M-FRIEND =
#|("BEST-M-FRIEND"
 "best-m-friend"
 ELM4-1-1-99
 NIL
 "DAVE"
 :BIPATH
 (((BEST-M-FRIEND NIL (CAREFOROTHERS (POLE1) NIL))))
 ((BEST-M-FRIEND NIL (INTIMATE (POLE2) NIL)))
 ((BEST-M-FRIEND NIL (PSYCHOLOGISTS (POLE1) NIL)))
 ((BEST-M-FRIEND NIL (CAREABOUTOTHERSFEE (POLE1) NIL)))
 ((BEST-M-FRIEND NIL (INSPIREOTHERS (POLE1) NIL)))
 ((BEST-M-FRIEND NIL (BESTFRIEND (POLE2) NIL)))
 ((BEST-M-FRIEND NIL (DIRECT-HONEST (POLE1) NIL)))
 ((BEST-M-FRIEND NIL (UNBRIDLEDHUMOR (POLE2) NIL)))
 ((BEST-M-FRIEND NIL (FANTASYWORLD (POLE2) NIL)))
 ((BEST-M-FRIEND NIL (ATHLETIC (POLE1) NIL)))
 ((BEST-M-FRIEND NIL (ESPOSECHRISTIAN (POLE2) NIL)))
 ((BEST-M-FRIEND NIL (CRITICAL (POLE2) NIL))))|#

;; ENGINEER = ("ENGINEER" "engineer" ELM16-1-1-99 NIL NIL :BIPATH (((ENGINEER NIL (SOLVEPROBLEMS (POLE1) NIL))) ((ENGINEER NIL (NOTANALYTIC (POLE2) NIL))) ) )
;;CHURCH-MINISTER = ("CHURCH-MINISTER" "church-minister" ELM20-1-1-99 NIL NIL :BIPATH (((CHURCH-MINISTER NIL (PROFESSIONAL (POLE1) NIL))) ((CHURCH-MINISTER NIL (EUROCENTRICVALUES (POLE1) NIL))) ((CHURCH-MINISTER NIL (SPIRITUALINTEGRATI (POLE1) NIL))) ) )

;;xxx  ALL  *FILE-ELMSYMS ---------------------------------------------------------------------
;; (setf *file-elmsyms  '(MOTHER FATHER BEST-M-FRIEND BEST-F-FRIEND M-DISLIKE F-DISLIKE M-ADMIRE F-ADMIRE PER-MOSTFUN PER-ROMANCE ROLE-MODEL CHILD-FRIEND CHILD-DISLIKE WORK-FRIEND WORK-PER-DISLIKE FAV-BOSS WORST-BOSS FAV-M-STAR FAV-POLITICO FAV-TEACHER FAV-SPIRITUAL DIS-TEACHER TEACHER POLICEMAN SALESPERSON DOCTOR LAWYER BUSINESS-OWNER MANAGER SCIENTIST FARMER DRUG-DEALER POLITICIAN DANCER ARTIST COMEDIAN ENGINEER HOUSE-CLEANER MOVIE-STAR ROCK-STAR CHURCH-MINISTER CATHOLICS PROTESTANTS JEWS MUSLIMS BUDDHISTS ATHEISTS ANGLOS HISPANICS BLACKS ASIANS MOST-IMPORTANT-VALUE MOST-IMPORTANT-ABILITY MOST-IMPORTANT-BELIEF YOUR-PERSONALITY YOUR-BEST-CHARACTERISTIC YOUR-POSSESSIONS YOUR-WORST-CHARACTERISTIC))


;;xxx EG.  PCSYMS -----------------------------------------------------------

;;SSSSSS FORMAT PROBLEM??  (CSYM ("NAME".... END)  :va "0.917" :RNK 3) PUTS  :va "0.917" AND :RNK 3  OUTSIDE OF CSYM SYMVALS LIST.  MUST PUT INSIDE OF THE LIST!!!

;;XXX CORRECT IN  (setf *file-all-pcqvar-lists IN TOM
;; ALSO, THE PCSYMS THAT EXIST ARE CORRECT!!
;; EG.  CAREFOROTHERS = ("CAREFOROTHERS" "CARE FOR OTHERS vs SELFISH" CS2-1-1-99 NIL NIL :PC ("CARE FOR OTHERS" "SELFISH" 1 NIL) :POLE1 "CARE FOR OTHERS" :POLE2 "SELFISH" :BESTPOLE 1 (:BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL))) :va "0.917" :RNK 3)
;; MAYBE THE TOM FILE PCSYMVALS DON'T REFLECT LATEST CHANGES?
;; BE AWARE AND CHECK WHEN NEEDED!!

;;
#|("CAREFOROTHERS"
 "CARE FOR OTHERS vs SELFISH"
 CS2-1-1-99   NIL   NIL
 :PC
 ("CARE FOR OTHERS" "SELFISH" 1 NIL)
 :POLE1
 "CARE FOR OTHERS"
 :POLE2
 "SELFISH"
 :BESTPOLE  1
 :BIPATH
 ((POLE1 NIL MOTHER NIL)
  (POLE1 NIL BEST-M-FRIEND NIL)
  (POLE2 NIL FATHER NIL))
 :va
 "0.917"
 :RNK  3)|#

;; DIFFERENT FORMAT IN U-CS UNDER (set-pcvals-from-datalist )
#|("CREATIVE"
 "CREATIVE vs NOT CREATIVE"
 CS2-1-1-99   NIL   NIL
 :PC
 ("CREATIVE" "NOT CREATIVE" 1 NIL)
 :POLE1
 "CREATIVE"
 :POLE2
 "NOT CREATIVE"
 :BESTPOLE   1
;; NOTE: HERE :BIPATH KEY IS IN LIST
 (:BIPATH
  ((POLE1 NIL DANCER NIL)
   (POLE1 NIL MOVIE-STAR NIL)
   (POLE2 NIL POLICEMAN NIL))  ;;USED TO MATCH KEY PAREN )
 :VAL
 "0.833")|#
 
;;XXX WRONG FORMAT IN  (SETF *file-pcsymval-lists
;;CAREFOROTHERS =  
#|("CAREFOROTHERS"
 "CARE FOR OTHERS vs SELFISH"
 CS2-1-1-99
 NIL
 NIL
 :PC
 ("CARE FOR OTHERS" "SELFISH" 1 NIL)
 :POLE1
 "CARE FOR OTHERS"
 :POLE2
 "SELFISH"
 :BESTPOLE 1
;; HERE BIPATH IN MAIN LIST
 :BIPATH 
 ((POLE1 NIL MOTHER NIL)
  (POLE1 NIL BEST-M-FRIEND NIL)
  (POLE2 NIL FATHER NIL))  ;;EXTRA PAREN PUTS VAL & RANK OUTSIDE )
  :va "0.917" :RNK 3) |#


;;   *ALL-PCQVAR-LISTS=
;;  (setf *file-all-pcqvar-lists
;;RIGHT FORMAT IN ALL 
#|("CAREFOROTHERS"
 "CARE FOR OTHERS vs SELFISH"
 CS2-1-1-99   NIL   NIL
 :PC
 ("CARE FOR OTHERS" "SELFISH" 1 NIL)
 :POLE1
 "CARE FOR OTHERS"
 :POLE2
 "SELFISH"
 :BESTPOLE  1
 :BIPATH
 ((POLE1 NIL MOTHER NIL)
  (POLE1 NIL BEST-M-FRIEND NIL)
  (POLE2 NIL FATHER NIL))
 :va
 "0.917"
 :RNK  3)|#
;; ("INTIMATE" "INTIMATE vs NOT INTIMATE" CS2-1-1-99 NIL NIL :PC ("INTIMATE" "NOT INTIMATE" 1 NIL) :POLE1 "INTIMATE" :POLE2 "NOT INTIMATE" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL BEST-M-FRIEND NIL)) :va "0.750" :RNK 7.5)
;; ("EXUBERANT" "EXUBERANT vs INHIBITED" CS2-1-1-99 NIL NIL :PC ("EXUBERANT" "INHIBITED" 1 NIL) :POLE1 "EXUBERANT" :POLE2 "INHIBITED" :BESTPOLE 1 :BIPATH ((POLE1 NIL M-ADMIRE NIL) (POLE1 NIL FAV-M-STAR NIL) (POLE2 NIL MOTHER NIL))  :va "0.750" :RNK 8)
;; ("HELPINGCAREER" "HELPING CAREER vs NOT HELPING CAREER" CS2-1-1-99 NIL NIL :PC ("HELPING CAREER" "NOT HELPING CAREER" 1 NIL) :POLE1 "HELPING CAREER" :POLE2 "NOT HELPING CAREER" :BESTPOLE 1 :BIPATH ((POLE1 NIL WORK-FRIEND NIL) (POLE1 NIL FAV-SPIRITUAL NIL) (POLE2 NIL MOTHER NIL))  :va "0.917" :RNK 18)
;;
#|("HIGHIMPACT"
 "HIGH IMPACT vs LO IMPACT"
 CS2-1-1-99   NIL   NIL
 :PC
 ("HIGH IMPACT" "LO IMPACT" 1 NIL)
 :POLE1
 "HIGH IMPACT"
 :POLE2
 "LO IMPACT"
 :BESTPOLE   1
 :BIPATH
 ((POLE1 NIL FAV-M-STAR NIL)
  (POLE1 NIL FAV-POLITICO NIL)
  (POLE2 NIL MOTHER NIL))
 :va   "0.917"   :RNK 7)|#
#|("UNDERSTANDING"
 "UNDERSTANDING vs NOT UNDERSTANDING"
 CS2-1-1-99   NIL   NIL
 :PC
 ("UNDERSTANDING" "NOT UNDERSTANDING" 1 NIL)
 :POLE1
 "UNDERSTANDING"
 :POLE2
 "NOT UNDERSTANDING"
 :BESTPOLE  1
 :BIPATH
 ((POLE1 NIL BEST-F-FRIEND NIL)
  (POLE1 NIL FAV-BOSS NIL)
  (POLE2 NIL FATHER NIL))
 :va   "0.833"   :RNK   11)|#


;;xxx  ALL *FILE-PCSYMS ------------------------------------------------------------------
;;
;; (setf *file-pcsyms  '(CAREFOROTHERS INTIMATE FLEXIBLE CASUAL EGOTISTICAL EXUBERANT NOTTHEORIST LOVEX LOVEDANCE HELPINGCAREER HIGHIMPACT PSYCHOLOGISTS UNDERSTANDING IMPULSIVE ENTERTAINER AGGRESSIVE PATERNAL CAREABOUTOTHERSFEE INSPIREOTHERS BESTFRIEND DIRECT-HONEST UNBRIDLEDHUMOR FANTASYWORLD ATHLETIC ESPOSECHRISTIAN CRITICAL SEXDEVIANCE GLOBALPERSPECTIVE FUNCOMPANION SELF-DISCLOSE MISSIONSPREADPSYCH CRUEL COURTEOUS DEEPUNDERSTANDPEOP DEMOCRATICLEADER PSYCHOLOGIST METICULOUS COGNITIVEPSYCHS EMOTIONAL CHARMING VALUEGROUPHAPPINES LOCALLEADER HIGHLYEDUCATED ENLIGHTENWORLD PETTY ENCOURAGING HUMOROUS GREATLEADER CONFIDENT-SELF-EST INTERPERSONALSKILL INTIMATELYASSERTIV GREATSPEAKER AUTONOMOUS HIGHINTELLIGENCE GOODNEGOTIATOR PROGRESSIVE CLOSE PLAYFUL COUNSELORS INDUSTRIOUS SEXY UNDERSTANDING4 SOFTSPOKEN TEAMMATE BEHAVIORALPSYCH OPTIMISTIC CHILDHOODFRIEND DEBONAIRE HIGHSTANDARDS TEACHER1 LIBERALCHRISTIAN EMPATHETICLISTENER OVERCOMEDIFFICULTI FIGHTILLNESS PUBLICSERVANT SECULAR SEEKATTENTION HELPER SPREADKNOWLEDGE LAWFUL MANAGER0 PRAGMATIC GROUPKNOWLEDGEWORK VERBALSKILLS LESSCIVILIZED REPRESENTGROUP PERFORMER SHOWBUSINESS SOLVEPROBLEMS STARPERFORMER LESSWEALTH DEPENDGOV IMMIGRANTS PROFIT-ORIENTED OCCUPATION PHYSICALWELLBEING LEGALEXPERT SELF-DISCIPLINE ENFORCERULES CREATENEWRULES SOCIALCONSTRAINTS RESPECTED SEEKEXTERNALAPPROV CREATIVE RITUALISTIC LESSMORALISTIC PROFESSIONAL DRAMATIC EUROCENTRICVALUES INDIVIDUALISTIC CATHOLIC PEOPLE-JOB GREEDY OWNER PERFORMANCE-ORIENT HIGHSTATUS RATIONAL PRACTICAL PERSUASIVE INFLUENCIAL MANUALWORK NOTHISTORY-ORIENTE NOTANALYTIC NOTLOYAL SPIRITUALINTEGRATI SEEKULTIMATETRUTH MATERIALISTIC SKILLEDMOVEMENTS))


;; xxx *FILE-ALL-CSQ-VALUE-RANKING-LISTS  --------------------------
;;   (setf *file-all-csq-value-ranking-lists '((0.917 (("HELPINGCAREER" 18) ("ATHLETIC" 17) ("CRUEL" 16) ("SOLVEPROBLEMS" 15) ("PROGRESSIVE" 14) ("ESPOSECHRISTIAN" 13) ("SELF-DISCIPLINE" 12) ("OPTIMISTIC" 11) ("AUTONOMOUS" 10) ("HIGHINTELLIGENCE" 9) ("DIRECT-HONEST" 8) ("HIGHIMPACT" 7) ("SEEKULTIMATETRUTH" 6) ("SPIRITUALINTEGRATI" 5) ("SPREADKNOWLEDGE" 4.5) ("ENLIGHTENWORLD" 4) ("CAREFOROTHERS" 3) ("CAREABOUTOTHERSFEE" 2) ("VALUEGROUPHAPPINES" 1))) (0.833 (("PERSUASIVE" 19) ("PETTY" 18) ("SEEKEXTERNALAPPROV" 18) ("AGGRESSIVE" 17) ("GREEDY" 17) ("GOODNEGOTIATOR" 16) ("ENCOURAGING" 15) ("NOTTHEORIST" 14) ("FUNCOMPANION" 13) ("INTERPERSONALSKILL" 12.5) ("IMPULSIVE" 12) ("UNDERSTANDING" 11) ("UNDERSTANDING4" 11) ("GLOBALPERSPECTIVE" 10) ("BESTFRIEND" 9) ("CREATIVE" 8.5) ("LESSCIVILIZED" 8) ("PRACTICAL" 7.5) ("PRAGMATIC" 7) ("INTIMATELYASSERTIV" 6) ("RATIONAL" 6) ("HELPER" 5.5) ("CONFIDENT-SELF-EST" 5) ("HIGHLYEDUCATED" 4) ("DEMOCRATICLEADER" 3) ("MISSIONSPREADPSYCH" 2) ("HIGHSTANDARDS" 2) ("FIGHTILLNESS" 2) ("DEEPUNDERSTANDPEOP" 1))) (0.75 (("PATERNAL" 23) ("COURTEOUS" 22) ("SOCIALCONSTRAINTS" 21) ("RESPECTED" 20) ("NOTHISTORY-ORIENTE" 19) ("CLOSE" 18) ("LAWFUL" 17) ("VERBALSKILLS" 16) ("SKILLEDMOVEMENTS" 16) ("INDIVIDUALISTIC" 15) ("NOTANALYTIC" 14) ("MATERIALISTIC" 13) ("COGNITIVEPSYCHS" 12) ("INFLUENCIAL" 11) ("PLAYFUL" 10) ("EMPATHETICLISTENER" 9) ("EXUBERANT" 8) ("LIBERALCHRISTIAN" 8) ("INTIMATE" 7.5) ("FLEXIBLE" 7) ("PERFORMANCE-ORIENT" 6) ("INDUSTRIOUS" 5) ("LOVEX" 4) ("INSPIREOTHERS" 2) ("GREATLEADER" 1))) (0.667 (("SELF-DISCLOSE" 17) ("MANUALWORK" 16) ("SECULAR" 15) ("DEPENDGOV" 14) ("EMOTIONAL" 13) ("ENFORCERULES" 13) ("LOVEDANCE" 12) ("SEXY" 11) ("NOTLOYAL" 10.5) ("HUMOROUS" 10) ("HIGHSTATUS" 8) ("MANAGER0" 7) ("GREATSPEAKER" 6) ("BEHAVIORALPSYCH" 5) ("CREATENEWRULES" 4) ("LESSWEALTH" 3.5) ("EGOTISTICAL" 3) ("PHYSICALWELLBEING" 2) ("EUROCENTRICVALUES" 1))) (0.583 (("SEXDEVIANCE" 23) ("IMMIGRANTS" 22) ("OCCUPATION" 21) ("RITUALISTIC" 20) ("DRAMATIC" 19) ("LESSMORALISTIC" 18) ("DEBONAIRE" 17) ("PROFIT-ORIENTED" 16) ("SHOWBUSINESS" 15) ("OVERCOMEDIFFICULTI" 14.5) ("CHILDHOODFRIEND" 14) ("TEAMMATE" 13) ("SOFTSPOKEN" 12) ("CHARMING" 11) ("METICULOUS" 10) ("ENTERTAINER" 9) ("LOCALLEADER" 8) ("REPRESENTGROUP" 7) ("OWNER" 6) ("LEGALEXPERT" 5) ("COUNSELORS" 4) ("PSYCHOLOGIST" 3.5) ("PSYCHOLOGISTS" 3) ("PROFESSIONAL" 3) ("TEACHER1" 2) ("GROUPKNOWLEDGEWORK" 1))) (0.5 (("CRITICAL" 9) ("CATHOLIC" 8) ("UNBRIDLEDHUMOR" 7) ("SEEKATTENTION" 7) ("FANTASYWORLD" 6) ("CASUAL" 5) ("PERFORMER" 4) ("PEOPLE-JOB" 3) ("PUBLICSERVANT" 2) ("STARPERFORMER" 1))))  )





;;xxx  *CS-CAT-DB-TREE ==================================
;;
#|(Defparameter   *CS-CAT-DB-TREE
 '(($CS
  "All Main Systems"
  $CS
  :S
  (("$MIS" "Misc" $CS.$MIS NIL NIL :CSS $CS :INFO 1)
   ($EXC
    "Executive"
    $CS.$EXC
    :S
    (("$TBV"
      "Top Belief-Value"
      $CS.$EXC.$TBV
      NIL
      NIL
      :CSS
      $EXC
      :INFO
      2)
     ($WV
      "Worldview"
      $CS.$EXC.$WV
      :S
      (("$SLF" "Self" $CS.$EXC.$WV.$SLF NIL NIL :CSS $WV :INFO 3)
       ($REFG
        "Reference Group"
        $CS.$EXC.$WV.$REFG
        :S
        (("$FAM"
          "Family"
          $CS.$EXC.$WV.$REFG.$FAM
          NIL
          NIL
          :CSS
          $REFG
          :INFO
          3))
        :CLEV
        3))
      :CLEV
      2)
     ($CSK
      "Cognitive Skill"
      $CS.$EXC.$CSK
      :S
      (("$PS" NIL $CS.$EXC.$CSK.$PS NIL NIL :CSS $CSK)
       ("$DM" NIL $CS.$EXC.$CSK.$DM NIL NIL :CSS $CSK)
       ("$PLN" NIL $CS.$EXC.$CSK.$PLN NIL NIL :CSS $CSK)
       ("$COP" NIL $CS.$EXC.$CSK.$COP NIL NIL :CSS $CSK)
       ("$RESN" NIL $CS.$EXC.$CSK.$RESN NIL NIL :CSS $CSK))
      :CLEV
      2)
     ($BSK
      "Behavioral Skill"
      $CS.$EXC.$BSK
      :S
      (("$PEOP" NIL $CS.$EXC.$BSK.$PEOP NIL NIL :CSS $BSK)
       ("$MECH" NIL $CS.$EXC.$BSK.$MECH NIL NIL :CSS $BSK)
       ("$MAIN" NIL $CS.$EXC.$BSK.$MAIN NIL NIL :CSS $BSK))
      :CLEV
      2))
    :CLEV
    1)
   ($KNW
    "Knowledge"
    $CS.$KNW
    :S
    (("$NSC" NIL $CS.$KNW.$NSC NIL NIL :CSS $KNW)
     ("$SSC" NIL $CS.$KNW.$SSC NIL NIL :CSS $KNW)
     ("$BSC" NIL $CS.$KNW.$BSC NIL NIL :CSS $KNW)
     ("$ART" NIL $CS.$KNW.$ART NIL NIL :CSS $KNW)
     ("$BUS" NIL $CS.$KNW.$BUS NIL NIL :CSS $KNW)
     ("$SPT" NIL $CS.$KNW.$SPT NIL NIL :CSS $KNW)
     ("$REC" NIL $CS.$KNW.$REC NIL NIL :CSS $KNW))
    :CLEV
    1)
   ($LNG
    "Language"
    $CS.$LNG
    :S
    (("$VER" "Verbal" $CS.$LNG.$VER NIL NIL :CSS $LNG :INFO 3)
     ("$MTH" "Math" $CS.$LNG.$MTH NIL NIL :CSS $LNG :INFO 3))
    :CLEV
    1)
   ($EP
    "Episode"
    $CS.$EP
    :S
    (("$SCR" "Script" $CS.$EP.$SCR NIL NIL :CSS $EP :INFO 3)
     ("$EVT" "Event" $CS.$EP.$EVT NIL NIL :CSS $EP :INFO 3))
    :CLEV
    1)
   ($ELM
    "Element"
    $CS.$ELM
    :S
    (("$PER" "Person" $CS.$ELM.$PER NIL NIL :CSS $ELM :INFO 3)
     ("$OBJ" "Object" $CS.$ELM.$OBJ NIL NIL :CSS $ELM :INFO 3))
    :CLEV
    1)
   ($EMT
    "Emotion"
    $CS.$EMT
    :S
    (("$HAP" "Happy" $CS.$EMT.$HAP NIL NIL :CSS $EMT :INFO 3)
     ("$CAR" "Caring" $CS.$EMT.$CAR NIL NIL :CSS $EMT :INFO 3)
     ("$ANX" "Anxiety" $CS.$EMT.$ANX NIL NIL :CSS $EMT :INFO 3)
     ("$ANG" "Anger" $CS.$EMT.$ANG NIL NIL :CSS $EMT :INFO 3)
     ("$DEP" "Dpression" $CS.$EMT.$DEP NIL NIL :CSS $EMT :INFO 3))
    :CLEV
    1)
   ($PCPT
    "Percept"
    $CS.$PCPT
    :S
    (("$VER" "Verbal" $CS.$PCPT.$VER NIL NIL :CSS $PCPT :INFO 3)
     ("$IMG" "Image" $CS.$PCPT.$IMG NIL NIL :CSS $PCPT :INFO 3)
     ("$SOND" "Sound" $CS.$PCPT.$SOND NIL NIL :CSS $PCPT :INFO 3)
     ("$SML" "Smell" $CS.$PCPT.$SML NIL NIL :CSS $PCPT :INFO 3)
     ("$TST" "Taste" $CS.$PCPT.$TST NIL NIL :CSS $PCPT :INFO 3)
     ("$TCT" "Tactile" $CS.$PCPT.$TCT NIL NIL :CSS $PCPT :INFO 3))
    :CLEV
    1)
   ("$MOT" "Motor" $CS.$MOT NIL NIL :CSS $CS :INFO 1))
  :CLEV
  0))
  "  *CS-CAT-DB-TREE created by MAKE-CSYM-TREE using  *MASTER-CSART-CAT-DB "  )|#




;;xxx TRY TO CATEGORIZE MY PCS ----------------------------------------------------
;SSSSSS START HERE -- WORKING ON AUTO- PUT IN SUBLIST 
;; GO TO CS-EXPLORE & WORK FROM THAT END NEXT??
#|
;;1. PERSONAL CHARS (INCLUDE some interpersonal values especially)
;;1.1. VALUES
GLOBALPERSPECTIVE  FLEXIBLE  CASUAL EXUBERANT  
FANTASYWORLD(REALISTIC) CONFIDENT-SELF-EST
INDUSTRIOUS  PROGRESSIVE OPTIMISTIC  ESPOSECHRISTIAN 
HIGHSTANDARDS  IMPULSIVE(NOT)  LIBERALCHRISTIAN 
  PLAYFUL  SECULAR SEEKATTENTION HELPER LAWFUL
  LESSCIVILIZED   PROFIT-ORIENTED SELF-DISCIPLINE SEEKEXTERNALAPPROV 
CREATIVE RITUALISTIC LESSMORALISTIC  DRAMATIC EUROCENTRICVALUES INDIVIDUALISTIC CATHOLIC GREEDY PERFORMANCE-ORIENT  
NOTHISTORY-ORIENTE     NOTLOYAL SPIRITUALINTEGRATI SEEKULTIMATETRUTH MATERIALISTIC
;;1.2. COGNITIVE SKILLS/HABITS:
METICULOUS EMOTIONAL    HIGHINTELLIGENCE SOLVEPROBLEMS
RATIONAL PRACTICAL NOTANALYTIC HIGHLYEDUCATED
;;1.3. BEH SKILLS/HABITS: 
 STARPERFORMER  SKILLEDMOVEMENTS
;; 1.4. OUTCOME
HIGHIMPACT OVERCOMEDIFFICULTI

;;2. INTERPERSONAL CHARS
;;2.1. VALUES & VERY GENERAL CHARS INDICATING VALUES
CAREFOROTHERS CAREABOUTOTHERSFEE DIRECT-HONEST 
UNBRIDLEDHUMOR VALUEGROUPHAPPINES  EGOTISTICAL(HUMBLE) 
HUMOROUS INTIMATE DEEPUNDERSTANDPEOP
   AGGRESSIVE(ASSERTIVE) INSPIREOTHERS AUTONOMOUS
SOCIALCONSTRAINTS ENLIGHTENWORLD ENCOURAGING
;;2.2. HABITS  
UNDERSTANDING   INTERPERSONALSKILL
INTIMATELYASSERTIV  CRITICAL PATERNAL  FUNCOMPANION
SELF-DISCLOSE CRUEL COURTEOUS  
  CHARMING     PETTY  SEXY  SOFTSPOKEN   
 DEBONAIRE  EMPATHETICLISTENER [REPEAT UNDERSTANDING4]
 PERSUASIVE   
;;2.3. ROLE-RELATED
GREATLEADER    SEXDEVIANCE GREATSPEAKER   GOODNEGOTIATOR   
DEMOCRATICLEADER
;;2.4.SPECIFIC RELATIONSHIP
BESTFRIEND TEAMMATE LOVEX("LOVE ME") CLOSE
CHILDHOODFRIEND

;;3. ROLES-CAREER
NOTTHEORIST  HELPINGCAREER PSYCHOLOGISTS MISSIONSPREADPSYCH
ENTERTAINER PSYCHOLOGIST COGNITIVEPSYCHS BEHAVIORALPSYCH
TEACHER1  PUBLICSERVANT SPREADKNOWLEDGE MANAGER0
GROUPKNOWLEDGEWORK REPRESENTGROUP PERFORMER SHOWBUSINESS
OCCUPATION LEGALEXPERT ENFORCERULES CREATENEWRULES 
PROFESSIONAL PEOPLE-JOB  OWNER MANUALWORK LOCALLEADER
COUNSELORS

;;4. ACTIVITIES
LOVEDANCE  ATHLETIC

;;5. CIRCUMSTANCES/SITUATIONS/OUTCOMES
FIGHTILLNESS  LESSWEALTH DEPENDGOV IMMIGRANTS
PHYSICALWELLBEING  RESPECTED HIGHSTATUS INFLUENCIAL

|#


                                                                                 )