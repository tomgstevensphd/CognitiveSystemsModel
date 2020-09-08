;;************************* CSQ-QVARS.lisp **********************
;;

;;*ALL-PCQVARS  [Created programatically]
;;
;;ddd
(defparameter  *all-PCqvars NIL)



;;*ALL-PC-ELEMENT-COMBOS
;;
;;ddd
#|NOT USED?
(defparameter *all-PC-element-combo-nums
  '(
    (PC-PEOPLE
     (1 2 3)
     (4 5 6)
     (7 8 9)
     (8 9 10)
     (5 7 11)
     (1 5 9)
     (3 6 11)
     (4 7 10)
     (6 7 8)
     (4 9 10)
     (2 4 7)
#|     (10 11 12)
     (13 14 15)
     (16 17 18)
     (19 20 21)
     (22 23 1)|#
     )
    #|(PC-SELF
     (1 2 3)

     )|#
    ))|#


(defparameter *TEST-PC-element-qvars
  '((PCE-PEOPLE
     ("mother""mother"  "single-text" ("mother" "1" "motherQ" "pc-element" "Pc-Element"))
     ("father""father"  "single-text" ("father" "2" "fatherQ" "pc-element" "Pc-Element"))
     ("best-m-friend""best-m-friend"  "single-text" ("best-m-friend" "3" "best-m-friendQ" "pc-element" "pc-Element" getname-p))
     ("best-f-friend""best-f-friend"  "single-text" ("best-f-friend" "4" "best-f-friendQ" "pc-element" "pc-Element" getname-p))
     ("m-dislike""m-dislike"  "single-text" ("m-dislike" "5" "m-dislikeQ" "pc-element" "pc-Element" getname-p))
     :single-text
;;delete parens after test
)))


#|(defparameter *test-PC-element-qvars
  '((PCE-PEOPLE
     ("mother""mother"  "single-text" ("mother" "1" "motherQ" "pc-element" "Pc-Element"))
     ("father""father"  "single-text" ("father" "2" "fatherQ" "pc-element" "Pc-Element"))
     ("best-m-friend""best-m-friend"  "single-text" ("best-m-friend" "3" "best-m-friendQ" "pc-element" "pc-Element" getname-p))
     ("best-f-friend""best-f-friend"  "single-text" ("best-f-friend" "4" "best-f-friendQ" "pc-element" "pc-Element" getname-p))
     ("m-dislike""m-dislike"  "single-text" ("m-dislike" "5" "m-dislikeQ" "pc-element" "pc-Element" getname-p))
   ("f-dislike""f-dislike"  "single-text" ("f-dislike" "6" "f-dislikeQ" "pc-element" "pc-Element" getname-p))
    ("m-admire""m-admire"  "single-text" ("m-admire" "7" "m-admireQ" "pc-element" "pc-Element" getname-p))
     ("f-admire""f-admire"  "single-text" ("f-admire" "8" "f-admireQ" "pc-element" "pc-Element" getname-p))
     ("per-mostfun""per-mostfun"  "single-text" ("per-mostfun" "9" "per-mostfunQ""pc-element" "pc-Element" getname-p))
     ("per-romance""per-romance"  "single-text" ("per-romance" "10" "per-romanceQ" "pc-element" "pc-Element" getname-p))
     ("role-model""role-model"  "single-text" ("role-model" "11" "role-modelQ" "pc-element" "pc-Element" getname-p))

       :SINGLE-TEXT
     )))|#

;;TEST ELM COMBOS


;;*ALL-PC-ELEMENT-QVARS [These are in SHAQ qvar form]
;; IF 6th in 4th = getname-p, CSQ queries for specific name.
;; eg of SHAQ qvar: ( "lrntxund"  "lh-Stop to understand readings"  "spss-match"  "lrnTXUNDerstand"  ("lrnTXUNDerstand" "9" "lrnTXUNDerstandQ" "int" "LikeMe7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "bsLearning.java")   (:help nil nil) )
;;
;;ddd
(defparameter *all-PC-element-qvars
  '((PCE-PEOPLE
     ("mother""mother"  "single-text" ("mother" "1" "motherQ" "pc-element" "Pc-Element"))
     ("father""father"  "single-text" ("father" "2" "fatherQ" "pc-element" "Pc-Element"))
     ("best-m-friend""best-m-friend"  "single-text" ("best-m-friend" "3" "best-m-friendQ" "pc-element" "pc-Element" getname-p))
     ("best-f-friend""best-f-friend"  "single-text" ("best-f-friend" "4" "best-f-friendQ" "pc-element" "pc-Element" getname-p))
     ("m-dislike""m-dislike"  "single-text" ("m-dislike" "5" "m-dislikeQ" "pc-element" "pc-Element" getname-p))
     ("f-dislike""f-dislike"  "single-text" ("f-dislike" "6" "f-dislikeQ" "pc-element" "pc-Element" getname-p))
    ("m-admire""m-admire"  "single-text" ("m-admire" "7" "m-admireQ" "pc-element" "pc-Element" getname-p))
     ("f-admire""f-admire"  "single-text" ("f-admire" "8" "f-admireQ" "pc-element" "pc-Element" getname-p))
     ("per-mostfun""per-mostfun"  "single-text" ("per-mostfun" "9" "per-mostfunQ""pc-element" "pc-Element" getname-p))
     ("per-romance""per-romance"  "single-text" ("per-romance" "10" "per-romanceQ" "pc-element" "pc-Element" getname-p))
     ("role-model""role-model"  "single-text" ("role-model" "11" "role-modelQ" "pc-element" "pc-Element" getname-p))
     ("child-friend""child-friend"  "single-text" ("child-friend" "12" "child-friendQ" "pc-element" "pc-Element" getname-p))
     ("child-dislike""child-dislike"  "single-text" ("child-dislike" "13" "child-dislikeQ" "pc-element" "pc-Element" getname-p))
     ("work-friend""work-friend"  "single-text" ("work-friend" "14""work-friendQ" "pc-element" "pc-Element" getname-p))
     ("work-per-dislike""work-per-dislike"  "single-text" ("work-per-dislike" "15""work-per-dislikeQ" "pc-element" "pc-Element" getname-p))
     ("fav-boss""fav-boss"  "single-text" ("fav-boss" "16" "fav-bossQ" "pc-element" "pc-Element" getname-p))
     ("worst-boss""worst-boss"  "single-text" ("worst-boss" "17" "worst-bossQ" "pc-element" "pc-Element" getname-p))
     ("fav-m-star""fav-m-star"  "single-text" ("fav-m-star" "18" "fav-m-starQ""pc-element" "pc-Element" getname-p))
     ("fav-politico""fav-politico"  "single-text" ("fav-politico" "19" "fav-politicoQ""pc-element" "pc-Element" getname-p))
     ("fav-teacher""fav-teacher"  "single-text" ("fav-teacher" "20""fav-teacherQ" "pc-element" "pc-Element" getname-p))
     ("fav-spiritual""fav-spiritual"  "single-text" ("fav-spiritual" "22""fav-spiritualQ" "pc-element" "pc-Element" getname-p))
     ("dis-teacher""dis-teacher"  "single-text" ("dis-teacher" "23" "dis-teacherQ" "pc-element" "pc-Element" getname-p))
     :single-text
     )
    (PCE-GROUPS
     ( "teacher""teacher"  "single-text" ("teacher" "1" "teacherQ" "pc-element" "pc-element"))
     ("policeman""policeman"  "single-text" ("policeman" "2" "policemanQ" "pc-element" "pc-element"))
     ("salesperson""salesperson"  "single-text" ("salesperson" "3" "salespersonQ" "pc-element" "pc-element"))
     ("doctor""doctor"  "single-text" ("doctor" "4" "doctorQ" "pc-element" "pc-element"))
     ("lawyer""lawyer"  "single-text" ("lawyer" "5" "lawyerQ" "pc-element" "pc-element"))
     ("business-owner""business-owner"  "single-text" ("business-owner" "6" "business-ownerQ" "pc-element" "pc-element"))
     ("manager""manager"  "single-text" ("manager" "7" "managerQ" "pc-element" "pc-element"))
     ("scientist""scientist"  "single-text" ("scientist" "8" "scientistQ" "pc-element" "pc-element"))
     ("farmer""farmer"  "single-text" ("farmer" "9" "farmerQ" "pc-element" "pc-element"))
     ("drug-dealer""drug dealer"  "single-text" ("drug-dealerQ" "10" "drug-dealerQ" "pc-element" "pc-element"))
     ("politician""politician"  "single-text" ("politician" "11" "politicianQ" "pc-element" "pc-element"))
     ("dancer""dancer"  "single-text" ("dancer" "12" "dancerQ" "pc-element" "pc-element"))
     ("artist""artist"  "single-text" ("artist" "13" "artistQ" "pc-element" "pc-element"))
     ("comedian""comedian"  "single-text" ("comedian" "14" "comedianQ" "pc-element" "pc-element"))
     ("engineer""engineer"  "single-text" ("engineer" "15" "engineerQ" "pc-element" "pc-element"))
     ("house-cleaner""house cleaner"  "single-text" ("house-cleaner" "16" "house-cleanerQ" "pc-element" "pc-element"))
     ("movie-star""movie-star"  "single-text" ("movie-star" "17" "movie-starQ" "pc-element" "pc-element"))
     ("rock-star""rock-star"  "single-text" ("rock-star" "18" "rock-starQ" "pc-element" "pc-element"))
     ("church-minister""church-minister"  "single-text" ("church-minister" "19" "church-ministerQ" "pc-element" "pc-element"))
     ("catholics""catholics"  "single-text" ("catholics" "20" "catholicsQ" "pc-element" "pc-element"))
     ("protestants""protestants"  "single-text" ("protestants" "21" "protestantsQ" "pc-element" "pc-element"))
     ("jews""jews"  "single-text" ("jews" "22" "jewsQ" "pc-element" "pc-element"))
     ("muslims""muslims"  "single-text" ("muslims" "23" "muslimsQ" "pc-element" "pc-element"))
     ("buddhists""buddhists"  "single-text" ("buddhists" "24" "buddhistsQ" "pc-element" "pc-element"))
     ("atheists" "atheists"  "single-text" ("atheists" "25" "atheistsQ" "pc-element" "pc-element"))
     ("Anglos""Anglos"  "single-text" ("Anglos" "1" "AnglosQ" "pc-element" "pc-element"))
     ("Hispanics""Hispanics"  "single-text" ("Hispanics" "1" "HispanicsQ" "pc-element" "pc-element"))
     ("Blacks""Blacks"  "single-text" ("Blacks" "1" "BlacksQ" "pc-element" "pc-element"))
     ("Asians""Asians"  "single-text" ("Asians" "1" "AsiansQ" "pc-element" "pc-element"))
     :SINGLE-TEXT
     )  
    (PCE-SELF
     ("Most-Important-Value""Most-Important-Value"  "single-text" ("Most-Important-Value" "1" "Most-Important-ValueQ" "pc-element" "pc-Element" getname-p))
     ("Most-Important-Ability""Most-Important-Ability"  "single-text" ("Most-Important-Ability" "2" "Most-Important-AbilityQ" "pc-element" "pc-Element" getname-p))
     ("Most-Important-Belief""Most-Important-Belief"  "single-text" ("Most-Important-Belief" "3" "Most-Important-BeliefQ" "pc-element" "pc-Element" getname-p))
     ("Your-Personality""Your-Personality"  "single-text" ("Your-Personality" "4" "Your-PersonalityQ" "pc-element" "pc-Element" getname-p))
     ("Your-Best-Characteristic""Your-Best-Characteristic"  "single-text" ("Your-Best-Characteristic" "5" "Your-Best-CharacteristicQ" "pc-element" "pc-Element" getname-p))
     ("Your-Possessions""Your-Possessions"  "single-text" ("Your-Possessions" "6" "Your-PossessionsQ" "pc-element" "pc-Element" getname-p))
     ("Your-Worst-Characteristic""Your-Worst-Characteristic"  "single-text" ("Your-Worst-Characteristic" "7" "Your-Worst-CharacteristicQ" "pc-element" "pc-Element" getname-p))
     :SINGLE-TEXT
     ))
  "All PCE-elements for use in generating Personal Constructs. If getname-p, CSQ queries for specific name."
  )



;;*ALL-CS-EXPLORE-QVARS
;;2019  NOTE: THESE CATS REFER TO TYPE OF RELATIONSHIP--NOT CS-CATS
;;  :LNTP = CSYM KEY IF STORED INSIDE OF THE TARGET CSYM AS A SEP KEY,
;;    VALUE IS THE CSYM KEY

;;SSS TO DO?? Make function to ADD CSCATS TO ISA ETC LINKS AFTER PUT IN DATABASE.
;; OR???:  MODIFY/MAKE FUNCS TO PUT ANSWERS WITH CSCATS IN THE PCSYMs ETC.
 ;;(BREAK "BEFORE *ALL-CS-EXPLORE-QVARS")
(defparameter *ALL-CS-EXPLORE-QVARS
  '((CS-DECLARATIVE ;; $KNW?
                    ("ISA" "ISA" "multi-text" ("ISA" "1" "ISAQ" "cs-link" "$KNW") NIL NIL :LNTP :ISA :LN2 :ISA2)
                    ("PART" "PART" "multi-text" ("PART" "2" "PARTQ" "cs-link" "$KNW") NIL NIL :LNTP :PART :LN2 :PART2 ) 
                    ("WHY" "WHY" "single-text" ("WHY" "3" "WHYQ" "cs-link" "$KNW") NIL NIL :LNTP :WHY :LN2 :WHY2)  
                    ("CAUSE" "CAUSE" "multi-text" ("CAUSE" "4" "CAUSEQ" "cs-link" "$KNW") NIL NIL :LNTP :CAUS :LN2 :CAUS2) 
                    ("EVID" "EVIDENCE" "single-text" ("EVID" "5" "EVIDQ" "cs-link" "$KNW") NIL NIL :LNTP :EVID :LN2 :EVID2)  
                    ("HOW" "HOW" "multi-text" ("HOW" "6" "HOWQ" "cs-link" "$KNW") NIL NIL :LNTP :HOW :LN2 :HOW2) 
                    ("EX" "EXAMPLE" "single-text" ("EG" "7" "EXQ" "$KNW" "$KNW")NIL NIL :LNTP :EX :LN2 :EX2) 
                    ("FEAT" "FEATURE" "multi-text" ("FEATR" "9" "FEATQ" "$KNW" "$KNW") NIL NIL :LNTP :FETR :LN2 :FETR2) 
                    ;;("STERT" "STEREOTYPE" "single-text" ("STEREOTYPE" "10" "STERETQ" "$KNW" "$KNW") NIL NIL :LNTP :STERT)  
                    ;;("REGN" "REGNANT" "single-text" ("REGNANT" "11" "REGNQ" "$KNW" "$KNW") NIL NIL :LNTP :REGN)  
                    ;;("PROTO" "PROTOTYPE" "single-text" ("PROTOTYPE" "12" "PROT0Q" "$KNW" "$KNW") NIL NIL :LNTP :PROTO)  
                    ;;end CS-DECLARATIVE
                    )
    (CS-SEMANTIC
     ("NAME" "NAME" "single-text" ("NAME" "14" "NAMEQ" "cs-link" "$KNW") NIL NIL :LNTP :NAME :LN2 :NAME2) 
     ("DEF" "DEFINE" "single-text" ("DEF" "15" "DEFQ" "cs-link" "$KNW") NIL NIL :LNTP :DEF :LN2 :DEF2) 
     ("DESC" "DESCRIBE" "single-text" ("DESC" "16" "DESCQ" "cs-link" "$KNW") NIL NIL :LNTP :DESC :LN2 :DESC2 ) 
     ("OPP" "OPPOSITE" "single-text" ("OPP" "17" "OPPQ" "cs-link" "$KNW") NIL NIL :LNTP :OPP)
     ("SYN" "SYNONYM" "multi-text" ("SYN" "18" "SYNQ" "cs-link" "$KNW") NIL NIL :LNTP :SYN) 
     ;;end CS-SEMANTIC
     )
    (CS-EPISODIC
     ("EVNT" "EVENT" "multi-text" ("EVENT" "8" "EVNTQ" "cs-link" "$EP") NIL NIL :LNTP :EVT :LN2 :EVT2) 
     ;;end CS-EPISODIC
     )
    (CS-WORLDVIEW
     ("VALNK" "VALUE LINK" "multi-text" ("VAL" "27" "VALNKQ" "cs-link" "$TBV") NIL NIL :LNTP :VALNK :LN2 :VALNK2 ) 
     ("SELF" "SELF" "multi-text" ("SELF" "27" "SELFQ" "cs-link" "$SLF") NIL NIL :LNTP :SELFLNK :LN2 :SELFLNK2 ) 
     ("OBJ" "OBJECT" "multi-text" ("OBJQ" 27.5 "$KNW" "$OBJ") NIL NIL :LNTP :OBJLNK :LN2 :OBJLNK2)
     ("POSEXP" "POSEXPECT" "multi-text" ("POSEXPECT" "27" "POSEXPQ" "$KNW" "$KNW") NIL NIL :LNTP :POSEXP :LN2 :POSEXP2)    
     ("NEGEXP" "NEGEXPECT" "multi-text" ("NEGEXPECT" "27" "NEGEXPQ" "$KNW" "$KNW") NIL NIL :LNTP :NEGEXP  :LN2 :NEGEXP2)
     ;;end CS-WORLDVIEW
     )
    ;;SSSS START HERE FINISH CSCAT ADDITIONS BELOW
    (CS-PROCEDURAL
     ("SUPG" "SUPGOAL" "multi-text" ("SUPG" "28" "SUPGQ" "cs-link" "$TBV") NIL NIL :LNTP :SUPG :LNTP :SUPG2 ) 
     ("SUBG" "SUBGOAL" "multi-text" ("SUBGL" "29" "SUBGQ" "cs-link" "$TBV") NIL NIL :LNTP :SUBG  :LN2 :SUBG2)  
     ("SRCPT" "SCRIPT" "multi-text" ("SRCPT" "32" "SCRPTQ" "cs-link" "$TBV")NIL NIL :LNTP :SCPT  :LN2 :SCPT2)
     ("SIT" "SITUATION-SD" "multi-text" ("SIT" "25" "SITQ" "cs-link" "$SIT") NIL NIL :LNTP :SIT :LN2 :SIT2)  
     ("ALTR" "ALT-R" "multi-text" ("ALTR" "13" "ALTRQ" "cs-link" "$BSK") NIL NIL :LNTP :ALTR :LN2 :ALTR2)  
     ("ACT" "ACTION SKILL" "multi-text" ("ACT" "26" "ACTQ" "cs-link" "$BSK") NIL NIL :LNTP :ACT  :LN2 :ACT2)    
     ("REINF" "REINF" "multi-text" ("REINF" "30" "REINFQ" "cs-link" "$TBV") NIL NIL :LNTP :REINF  :LN2 :REINF2)
     ("PUNISH" "PUNISH" "multi-text" ("PUNISH" "31" "PUNISHQ" "cs-link" "$TBV") NIL NIL :LNTP :PUNISH  :LN2 :PUNISH2)
     ;;end CS-PROCEDURAL
     )
    (CS-MODALITY
     ("IMG" "IMAGE" "single-text" ("IMG" "19" "IMGQ" "$KNW" "IMG") NIL NIL :LNTP :IMG  :LN2 :IMG2)  
     ("SND" "SOUND" "single-text" ("SND" "20" "SNDQ" "$KNW" "$SOND") NIL NIL :LNTP :SND  :LN2 :SND2)  
     ("SENS" "SENSATIONS" "single-text" ("SENS" "21" "SENSQ" "$KNW" "$PCPT") NIL NIL :LNTP :SENS  :LN2 :SENS2)
     ("SMELL" "SMELL" "single-text" ("SMELL" "21" "SMELLQ" "$KNW" "$SML") NIL NIL :LNTP :SMELL :LN2 :SMELL2)    
   ("TASTE" "TASTE" "single-text" ("TASTE" "22" "TASTEQ" "$KNW" "$TST") NIL NIL :LNTP :TASTE  :LN2 :TASTE2)    
   ("TACTL" "TACTILE" "single-text" ("TACTILE" "24" "TACTLQ" "$TCT" "$KNW") NIL NIL :LNTP :TACTL  :LN2 :TACTL2)
     ;;end CS-MODALITY
     )  
    (EMOT 
     ;;INTRO INFO
     ("EMOT"  "EMOT" NIL NIL (:TITLE  ("   TYPE OF EMOTION")
                      :QUEST ("    Select the EMOTION(S) that is/are MOST strongly associated with this item") NIL NIL :LNTP :EMOT :LN2 :EMOT2) 
      (:help nil nil) NIL :MULTI-ITEM)
     ;;ITEMS FOLLOW
     ("HAP" "HAPPY"     
      "spss-match"  NIL
      ("  HAPPY")
      (:help nil nil)
      :css "$HAP"
      :LNTP :HAP
      :LN2 :HAP2
      :MULTI-ITEM
      ;;(:XDATA :scales (HQ))
      )
     ( "CARE" "CARING"     
      "spss-match"  NIL
      ("  CARING")
      (:help nil nil)
      :css "$CAR"
      :LNTP :CAR
      :LN2 :CAR2
      :MULTI-ITEM
      ;;(:XDATA :scales (HQ))
      )
     ( "ANX" "ANXIETY"     
      "spss-match"  NIL
      ("  ANXIETY")
      (:help nil nil)
      :css "$ANX"
      :LNTP :ANX
      :LN2 :ANX2
      :MULTI-ITEM
      ;;(:XDATA :scales (HQ))
      )
     ( "ANG" "ANGER"     
      "spss-match"  NIL
      ("  ANGER")
      (:help nil nil)
      :css "$ANG"
      :LNTP :ANG
      :LN2 :ANG2
      :MULTI-ITEM
      ;;(:XDATA :scales (HQ))
      )
     ( "DEP"
      "DEP"
      "spss-match"  NIL
      ("  SAD")
      (:help nil nil)
      :css "$DEP"
      :LNTP :DEP
      :LN2 :DEP2
      :MULTI-ITEM)
     ;;(:XDATA :scales (HQ))
     (  "NONE" "UNSURE or NONE"
      "spss-match"  NIL
      (" UNSURE or NONE")
      (:help nil nil)
      :MULTI-ITEM)
     ;;end EMOT
     )
    ) "QVARS for making CS-explore questions to explore a CS links in depth")


 ;;(break "2 BEFORE *N-CS-EXPLORE-QVARS-LIST")
(defparameter *N-CS-EXPLORE-QVARS-LIST
  (nth-value 1 (get-nested-list-leveln-items *ALL-CS-EXPLORE-QVARS :nest-level-n 1)))  ;;*N-CS-EXPLORE-QVARS-LIST = 42




;;MAKE-LINKTYPE-KEYS
;;2019
;;ddd
(defun make-linktype-keys (qvarlist)
  "CSQ-QVARS RETURNS: (values linktype-keys qvars) "
  (let*
      ((qvars)
       (linktype-keys)
       )
    (loop
     for catlist in qvarlist
     do
     (loop
      for qlist in catlist
      do
      (when (and qlist (listp qlist))
        (let*
            ((qvar (my-make-cs-symbol (car qlist)))
             (key (my-make-keyword qvar))
             )
          (setf linktype-keys (append linktype-keys (list key))
                qvars (append qvars (list qvar)))
              
          ;;end inner loop
          )))
     ;;end outer loop
     )
    ;;end let, make-linktype-keys
    (values linktype-keys qvars)
    ))
;;TEST
;; (make-linktype-keys *ALL-CS-EXPLORE-QVARS)


;; FIND ALL LINK TYPES: *ALL-CS-EXPLORE-LINK-TYPES, QVARS--see below:
(defparameter *ALL-CS-EXPLORE-LINK-TYPES NIL)
;;= (:ISA :PART :WHY :CAUSE :EVID :HOW :EX :FEAT :NAME :DEF :DESC :OPP :SYN :EVNT :VALNK :SELF :OBJ :POSEXP :NEGEXP :SUPG :SUBG :SRCPT :SIT :ALTR :ACT :REINF :PUNISH :IMG :SND :SENS :SMELL :TASTE :TACTL :EMOT :HAP :CARE :ANX :ANG :DEP :NONE)
(defparameter *ALL-CS-EXPLORE-QVAR-SYMS NIL)
;;= (ISA PART WHY CAUSE EVID HOW EX FEAT NAME DEF DESC OPP SYN EVNT VALNK SELF OBJ POSEXP NEGEXP SUPG SUBG SRCPT SIT ALTR ACT REINF PUNISH IMG SND SENS SMELL TASTE TACTL EMOT HAP CARE ANX ANG DEP NONE)
;;MAKE THE ABOVE LISTS
;;(break "3 (make-linktype-keys *ALL-CS-EXPLORE-QVARS)")
 (multiple-value-setq (*ALL-CS-EXPLORE-LINK-TYPES
                       *ALL-CS-EXPLORE-QVAR-SYMS)
  (make-linktype-keys *ALL-CS-EXPLORE-QVARS))
(defparameter *CUR-CS-EXPLORE-QVAR-SYMS
  '(ISA PART WHY CAUSE EVID HOW EX FEAT NAME DEF DESC OPP SYN EVNT VALNK SELF OBJ 
  ;;POSEXP NEGEXP SUPG SUBG SRCPT
 SIT ALTR ACT REINF PUNISH IMG
 ;;SND SENS SMELL TASTE TACTL 
 EMOT ;;NO-- HAP CARE ANX ANG DEP NONE
    )   "Manually modified qvar syms to use in CS-EXPLORE")
  


;;
;;*ALL-CS-EXPLORE-QVARS
;; 2018 VERSION, REPLACED WITH NEW CATS, ETC
;;ddd
#|(defparameter *ALL-CS-EXPLORE-QVARS
  '((CS-DECLARATIVE 
     ("ISA" "ISA" "multi-text" ("ISA" "1" "ISAQ" "$KNW" "$KNW")) 
     ("PART" "PART" "multi-text" ("PART" "2" "PARTQ" "$KNW" "$KNW")) 
     ("WHY" "WHY" "single-text" ("WHY" "3" "WHYQ" "$KNW" "$KNW")) 
     ("CAUSE" "CAUSE" "multi-text" ("CAUSE" "4" "CAUSEQ" "$KNW" "$KNW")) 
     ("EVIDENCE" "EVIDENCE" "single-text" ("EVID" "5" "EVIDENCEQ" "$KNW" "$KNW")) 
     ("HOW" "HOW" "multi-text" ("HOW" "6" "HOWQ" "$KNW" "$KNW")) 
     ("EXAMPLE" "EXAMPLE" "single-text" ("EG" "7" "EXQ" "$KNW" "$KNW")) 
     ("FEATURE" "FEATURE" "multi-text" ("FEATR" "9" "FEATUREQ" "$KNW" "$KNW")) 
     ;;("STEREOTYPE" "STEREOTYPE" "single-text" ("STEREOTYPE" "10" "STEREOTYPEQ" "$KNW" "$KNW")) 
     ;;("REGNANT" "REGNANT" "single-text" ("REGNANT" "11" "REGNANTQ" "$KNW" "$KNW")) 
     ;;("PROTOTYPE" "PROTOTYPE" "single-text" ("PROTOTYPE" "12" "PROTOTYPEQ" "$KNW" "$KNW")) 
     ;;end CS-DECLARATIVE
     )
    (CS-SEMANTIC
     ("NAME" "NAME" "single-text" ("NAME" "14" "NAMEQ" "$KNW" "$KNW")) 
     ("DEFINE" "DEFINE" "single-text" ("DEF" "15" "DEFINEQ" "$KNW" "$KNW")) 
     ("DESCRIBE" "DESCRIBE" "single-text" ("DESC" "16" "DESCRIBEQ" "$KNW" "$KNW")) 
     ("OPPOSITE" "OPPOSITE" "single-text" ("OPP" "17" "OPPOSITEQ" "$KNW" "$KNW")) 
     ("SYNONYM" "SYNONYM" "multi-text" ("SYN" "18" "SYNONYMQ" "$KNW" "$KNW")) 
     ;;end CS-SEMANTIC
     )
    (CS-EPISODIC
     ("EVENT" "EVENT" "multi-text" ("EVENT" "8" "EVENTQ" "$KNW" "$KNW")) 
     ;;end CS-EPISODIC
     )
    (CS-WORLDVIEW
     ("VALUE" "VALUE" "multi-text" ("VAL" "27" "VALUEQ" "$KNW" "$KNW")) 
     ("SELF" "SELF" "multi-text" ("SELF" "27" "SELFQ" "$KNW" "$KNW")) 
     ;;("POSEXPECT" "POSEXPECT" "multi-text" ("POSEXPECT" "27" "POSEXPECTQ" "$KNW" "$KNW")) 
     ;;("NEGEXPECT" "NEGEXPECT" "multi-text" ("NEGEXPECT" "27" "NEGEXPECTQ" "$KNW" "$KNW")) 
     ;;end CS-WORLDVIEW
     )
    (CS-PROCEDURAL
     ("SUPGOAL" "SUPGOAL" "multi-text" ("SUPGL" "28" "SUPGOALQ" "$KNW" "$KNW")) 
     ("SUBGOAL" "SUBGOAL" "multi-text" ("SUBGL" "29" "SUBGOALQ" "$KNW" "$KNW")) 
     ("SCRIPT" "SCRIPT" "multi-text" ("SCRIPT" "32" "SCRIPTQ" "$KNW" "$KNW"))
     ("SITUATION-SD" "SITUATION-SD" "multi-text" ("SITD" "25" "SITUATION-SDQ" "$KNW" "$KNW")) 
     ("ALT-R" "ALT-R" "multi-text" ("ALTR" "13" "ALT-RQ" "$KNW" "$KNW")) 
     ("MOTOR" "MOTOR" "multi-text" ("MOTOR" "26" "MOTORQ" "$KNW" "$KNW")) 
     ;;("REINF" "REINF" "multi-text" ("REINF" "30" "REINFQ" "$KNW" "$KNW"))
     ;;("PUNISH" "PUNISH" "multi-text" ("PUNISH" "31" "PUNISHQ" "$KNW" "$KNW"))
    ;;end CS-PROCEDURAL
    )
  (CS-MODALITY
   ("IMAGE" "IMAGE" "single-text" ("IMAGE" "19" "IMAGEQ" "$KNW" "$KNW")) 
   ("SOUND" "SOUND" "single-text" ("SOUND" "20" "SOUNDQ" "$KNW" "$KNW")) 
   ("SENSATIONS" "SENSATIONS" "single-text" ("SENS" "21" "SENSATIONSQ" "$KNW" "$KNW"))
#|   ("SMELL" "SMELL" "single-text" ("SMELL" "21" "SMELLQ" "$KNW" "$KNW")) 
   ("TASTE" "TASTE" "single-text" ("TASTE" "22" "TASTEQ" "$KNW" "$KNW")) 
   ("TACTILE" "TACTILE" "single-text" ("TACTILE" "24" "TACTILEQ" "$KNW" "$KNW")) |#
   ;;end CS-MODALITY
   )  
  (EMOTION
   ;;    ("EMOTION" "EMOTION" "single-text" ("EMOTION" "23" "EMOTIONQ" "$KNW" "$KNW")) 
   ;;experiment with multi-item
  ;;(EMOTION
    ;;INTRO INFO
    ("EMOTION"
     "EMOTION" NIL NIL (:TITLE  ("   TYPE OF EMOTION")
                        :QUEST ("    Select the EMOTION(S) that is/are MOST strongly associated with this item"))
     (:help nil nil) NIL :MULTI-ITEM)
    ;;ITEMS FOLLOW
    ( "HAPPY"
     "HAP"
     "spss-match"  NIL
     ("  HAPPY")
     (:help nil nil)
     :MULTI-ITEM
     ;;(:XDATA :scales (HQ))
     )
    ( "CARING"
     "CARE"
     "spss-match"  NIL
     ("  CARING")
     (:help nil nil)
     :MULTI-ITEM
     ;;(:XDATA :scales (HQ))
     )
    ( "ANXIETY"
     "ANX"
     "spss-match"  NIL
     ("  ANXIETY")
     (:help nil nil)
     :MULTI-ITEM
     ;;(:XDATA :scales (HQ))
     )
    ( "ANGER"
     "ANG"
     "spss-match"  NIL
     ("  ANGER")
     (:help nil nil)
     :MULTI-ITEM
     ;;(:XDATA :scales (HQ))
     )
    ( "DEP"
     "DEP"
     "spss-match"  NIL
     ("  SAD")
     (:help nil nil)
     :MULTI-ITEM)
    ;;(:XDATA :scales (HQ))
    ( "UNSURE or NONE"
     "NONE"
     "spss-match"  NIL
     (" UNSURE or NONE")
     (:help nil nil)
     :MULTI-ITEM)
    ;;END EMOTION
    ;;)
      ;;end CS-EMOTIONAL
      )
  ) "QVARS for making CS-explore questions to explore a CS links in depth")|#

;;(break "4 BEFORE *TEST VARS")
(defparameter *TEST-CS-EXPLORE-BRIEF   '((CS-EPISODIC
     ("EVNT" "EVENT" "multi-text" ("EVENT" "8" "EVENTQ" "cs-link" "$EP") NIL NIL :LNTP :EVT) 
     ;;end CS-EPISODIC
     )))

;;*TEST-CS-EXPLORE-QVARS
;;2019
(defparameter *TEST-CS-EXPLORE-QVARS
   '((CS-DECLARATIVE ;; $KNW?
    ("ISA" "ISA" "multi-text" ("ISA" "1" "ISAQ" "cs-link" "$KNW") NIL NIL :LNTP :ISA) 
   
     ("EX" "EXAMPLE" "single-text" ("EG" "7" "EXQ" "$KNW" "$KNW") NIL NIL :LNTP :EX)
     ;;end CS-DECLARATIVE
     )
    (CS-SEMANTIC
     ("NAME" "NAME" "single-text" ("NAME" "14" "NAMEQ" "cs-link" "$KNW") NIL NIL :LNTP :NAME) 
   ;;("DEF" "DEFINE" "single-text" ("DEF" "15" "DEFINEQ" "cs-link" "$KNW") NIL NIL :LNTP :DEF) 
     ("OPP" "OPPOSITE" "single-text" ("OPP" "17" "OPPOSITEQ" "cs-link" "$KNW") NIL NIL :LNTP :OPP) 
   ;;  ("SYN" "SYNONYM" "multi-text" ("SYN" "18" "SYNONYMQ" "cs-link" "$KNW") NIL NIL :LNTP :SYN) 
     ;;end CS-SEMANTIC
     )
    (CS-EPISODIC
     ("EVNT" "EVENT" "multi-text" ("EVENT" "8" "EVENTQ" "cs-link" "$EP") NIL NIL :LNTP :EVT) 
     ;;end CS-EPISODIC
     )
    (CS-WORLDVIEW
   ;;  ("VALNK" "VALUE LINK" "multi-text" ("VAL" "27" "VALUEQ" "cs-link" "$TBV") NIL NIL :LNTP :VALNK ) 
    ;;"SELF" "SELF" "multi-text" ("SELF" "27" "SELFQ" "cs-link" "$SLF") NIL NIL :LNTP :SELFLNK) 
     ("OBJ" "OBJECT" "multi-text" ("OBJECTQ" 27.5 "$KNW" "$OBJ") NIL NIL :LNTP :OBJLNK)
     ;;end CS-WORLDVIEW
     )
;;SSSSS START HERE FINISH CSCAT ADDITIONS BELOW
    (CS-PROCEDURAL
     ("SUPGL" "SUPGOAL" "multi-text" ("SUPGL" "28" "SUPGOALQ" "cs-link" "$GOL") NIL NIL :LNTP :SUPG) 
     ("SUBGL" "SUBGOAL" "multi-text" ("SUBGL" "29" "SUBGOALQ" "cs-link" "$GOL") NIL NIL :LNTP :SUBG) 
     ("SIT" "SITUATION-SD" "multi-text" ("SIT" "25" "SITUATION-SDQ" "cs-link" "$SIT") NIL NIL :LNTP :SD) 
     ;;ALT-R" "ALT-R" "multi-text" ("ALT-R" "13" "ALT-RQ" "cs-link" "$BSK") NIL NIL :LNTP :ALTR) 
     ;;(REINF" "REINF" "multi-text" ("REINF" "30" "REINFQ" "cs-link" "$TBV") NIL NIL :LNTP :RNF)
    ;;end CS-PROCEDURAL
    )
  (CS-MODALITY
   ("IMG" "IMAGE" "single-text" ("IMG" "19" "IMAGEQ" "$KNW" "$IMG")
NIL NIL :LNTP :IMG) 
   ;;("SND" "SOUND" "single-text" ("SND" "20" "SOUNDQ" "$KNW" "$SOND") NIL NIL :LNTP :SND) 
   ;;("SENS" "SENSATIONS" "single-text" ("SENS" "21" "SENSATIONSQ" "$KNW" "$KNW") NIL NIL :LNTP :SENS)
#|   ("SMELL" "SMELL" "single-text" ("SMELL" "21" "SMELLQ" "$KNW" "$SML")) 
   ("TASTE" "TASTE" "single-text" ("TASTE" "22" "TASTEQ" "$KNW" "$TST")) 
   ("TACTILE" "TACTILE" "single-text" ("TACTILE" "24" "TACTILEQ" "$TCT" "$KNW")) |#
   ;;end CS-MODALITY
   )  
  (EMOTION
   ;;    ("EMOTION" "EMOTION" "single-text" ("EMOTION" "23" "EMOTIONQ" "$KNW" "$KNW")) 
   ;;experiment with multi-item
  ;;(EMOTION
    ;;INTRO INFO
    ("EMOTION"
     "EMOTION" NIL NIL (:TITLE  ("   TYPE OF EMOTION")
                        :QUEST ("    Select the EMOTION(S) that is/are MOST strongly associated with this item"))
     (:help nil nil) NIL :MULTI-ITEM)
    ;;ITEMS FOLLOW
    ("HAP" "HAPPY"     
     "spss-match"  NIL
     ("  HAPPY")
     (:help nil nil)
      :css "$HAP"
     :MULTI-ITEM
     ;;(:XDATA :scales (HQ))
     )
    ( "CARE" "CARING"     
     "spss-match"  NIL
     ("  CARING")
     (:help nil nil)
     :css "$CAR"
     :MULTI-ITEM
     ;;(:XDATA :scales (HQ))
     )
    ( "ANX" "ANXIETY"     
     "spss-match"  NIL
     ("  ANXIETY")
     (:help nil nil)
     :css "$ANX"
     :MULTI-ITEM
     ;;(:XDATA :scales (HQ))
     )
    ( "ANG" "ANGER"     
     "spss-match"  NIL
     ("  ANGER")
     (:help nil nil)
     :css "$ANG"
     :MULTI-ITEM
     ;;(:XDATA :scales (HQ))
     )
    ( "DEP"
     "DEP"
     "spss-match"  NIL
     ("  SAD")
     (:help nil nil)
     :css "$DEP"
     :MULTI-ITEM)
    ;;(:XDATA :scales (HQ))
    (  "NONE" "UNSURE or NONE"
     "spss-match"  NIL
     (" UNSURE or NONE")
     (:help nil nil)
     :MULTI-ITEM)
    ;;END EMOTION
    ;;)
      ;;end CS-EMOTIONAL
      )
  ))





#|  '((PCE-PEOPLE
     ("mother""mother"  "single-text" ("mother" "1" "motherQ" "pc-element" "Pc-Element"))|#

;;XXX
;;(break "5 BEFORE *All-PC-elmsym-names")
(defparameter *All-PC-elmsym-names
  (get-all-csq-qvarnames :return-var&label-p NIL :all-qvarlists *all-PC-element-qvars ))
;; works= 
;; (get-question-text  'mother)

(defparameter *All-PC-element-qvar-cats NIL "Set by set-catsym-to-nested-names below.")
(defparameter *All-PC-elmsym-global-cats  NIL "Set by set-catsym-to-nested-names below.")


;;SET GLOBAL PCE CAT NAMES TO NESTED PCE QVAR NAMES
;;EG SETS *PCE-PEOPLE-ELMSYMS TO ("mother" "father" ....) etc for each pce category
;; *pce-groups-elmsyms  *pce-self-elmsyms
(multiple-value-setq (*All-PC-element-qvar-cats *All-PC-elmsym-global-cats)
    (set-catsym-to-nested-names *all-PC-element-qvars :append-postfix "-elmsyms"))




;; (find-qvars-for-scale


#|(SFAMILY
 ( "sFamily"
  "SibPosit-Parnts"
 NIL nil
 (:TITLE ("Information about your family situation")
 :QUEST ("What type of family were you primarily raised in?"))
 (:help nil nil)
 NIL
 :MULTI-SPECIAL-FRAME
  ;;the name of the frame interface
 frame-family-info
  )
 ( "OlderBrosN"
 "NumOlderBros"
 nil
 NIL
 ("Your number of OLDER Brothers (0 to ?)")
 (:help nil nil)
 :MULTI-ITEM)
 ( "OlderSisN"
 "NumOlderSis"
 nil
 NIL
 ("Your number of OLDER Sisters (0 to ?)")
 (:help nil nil)
 :MULTI-ITEM)
 ( "YoungerBrosN"
 "NumYoungerBros"
 nil
 NIL
 ("Your number of YOUNGER Brothers (0 to ?)")
 (:help nil nil)
 :MULTI-ITEM)
( "YoungerSisN"
 "NumYoungerSis"
 nil
 NIL
 ("Your number of YOUNGER Sisters (0 to ?)")
 (:help nil nil)
 :MULTI-ITEM)
( "Raised2Parents"
 "Raised2Parents"
 nil
 NIL
 ("Raised primarily by 2 PARENTS")
 (:help nil nil)
 :MULTI-ITEM)
( "SingleFparent"
 "SingleFparent"
 nil
 NIL
 ("Raised primarily by SINGLE MOM")
 (:help nil nil)
 :MULTI-ITEM)
 ( "SingleMparent"
 "SingleMparent"
 nil
 NIL
 ("Raised primarily by SINGLE DAD")
 (:help nil nil)
 :MULTI-ITEM)
( "RaisedNoParents"
 "RaisedNoParents"
 nil
 NIL
 ("Not raised by my parents")
 (:help nil nil)
 :MULTI-ITEM)
( "RaisedOther"
 "RaisedOther"
 nil
 NIL
 ("Raised by other than parents")
 (:help nil nil)
 :MULTI-ITEM)
;;end sFamily
)|#

;;EG
#|
(IE
 ( "iecselfs"
 "ie-Take care of self & probs"
 "spss-match"
 "iecSelfSufficient"
 ("iecSelfSufficient" "1" "iecSelfSufficientQ" "int" "LikeMe7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "iIEcontrol.java")
 (:help nil "text")
  )
 ( "iecicont"
 "ie-I control life-happiness"
 "spss-match"
 "iecILOFCiVSe"
 ("iecILOFCiVSe" "2" "iecILOFCiVSeQ" "int" "Agree7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "iIEcontrol.java")
 (:help nil "text")
  )
 ( "iecgenet"
 "ie-Not genetics-biology control my hap"
 "spss-match"
 "iecGenetic"
 ("iecGenetic" "3" "iecGeneticQ" "int" "Agree7Reverse" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "iIEcontrol.java")
 (:help nil "text")
  )
 ( "iecpeopl"
 "ie-Not others control my happiness"
 "spss-match"
 "iecPeople"
 ("iecPeople" "4" "iecPeopleQ" "int" "Agree7Reverse" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "iIEcontrol.java")
 (:help nil "text")
  )
 ( "iecdepen"
 "ie-Not dependent on one person"
 "spss-match"
 "iecDependent"
 ("iecDependent" "5" "iecDependentQ" "int" "LikeMe7Reverse" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "iIEcontrol.java")
 (:help nil "text")
  )
 ( "ieccofee"
 "ie-Not care for another above self"
 "spss-match"
 "iecCodependent"
 ("iecCodependent" "6" "iecCodependentQ" "int" "LikeMe7Reverse" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "iIEcontrol.java")
 (:help nil "text")
  )
 ( "ieccoprb"
 "ie-Not worry carrying for one's serious prob"
 "spss-match"
 "iecCodepProblem"
 ("iecCodepProblem" "7" "iecCodepProblemQ" "int" "LikeMe7Reverse" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "iIEcontrol.java")
 (:help nil "text")
  )
 )|#