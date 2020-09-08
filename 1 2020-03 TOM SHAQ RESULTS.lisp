;;********************** 1 2020-03 TOM SHAQ RESULTS.lisp ****************

;;FOR TOM 2020-03
(setf *SHAQ-ALL-DATA-LIST   '((:SHAQ-DATA-LIST
  (:TEXT-DATA
   "sID"
   ("UserID" "555555" :SINGLE "555555")
   ("Sex" "Male" :SINGLE "Male" 1)
   ("Age" 78 :SINGLE 78 78)
   ("USA?" "USA" :SINGLE "USA" 1)
   ("Nation" "USA" :SINGLE "USA")
   ("ZipCode" 92260 :SINGLE 92260)
   ("HrsWork" 78 :SINGLE 78 78))
  :MULTI-SEL-QUEST
  "utype"
  ("UTYPE"
   :MULTI
   "utype"
   "UserType"
   1
   ("twanttho" "1" 1 T 1 1 (:XDATA :SCALES (HQ)))
   ("tknowmor" "2" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("twanthel" "3" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("twantspe" "4" 1 NIL 0 1 (:XDATA :SCALES NIL))
   ("texperie" "5" 1 NIL 0 1 (:XDATA :SCALES NIL))
   ("tprevshaq" "6" 1 NIL 0 1 (:XDATA :SCALES (PREVIOUS-USER)))
   ("wantspq" "7" 1 NIL 0 1 (:XDATA :SCALES (SPECIFIC-QUESTS)))
   ("tu100stu" "8" 1 NIL 0 1 (:XDATA :SCALES (HQ ACAD-LEARNING)))
   ("tcsulbst" "9" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING)))
   ("tcolstu" "10" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING)))
   ("totherst" "11" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING)))
   ("tressub" "12" 1 NIL 0 1 (:XDATA :SCALES NIL))
   ("tcolfaca" "13" 1 NIL 0 1 (:XDATA :SCALES NIL))
   ("u-none" "14" 1 NIL 0 1 (:XDATA :SCALES NIL)))
  :MULTI-SEL-QUEST
  "ugoals"
  ("UGOALS"
   :MULTI
   "ugoals"
   "UserGoals"
   1
   ("gsuchap" "1" 1 T 1 1 (:XDATA :SCALES (HQ)))
   ("gemocop" "2" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("gslfest"
    "3"
    1
    NIL
    0
    1
    (:XDATA :SCALES (VALUES-THEMES BELIEFS SKILLS-CONFIDENCE)))
   ("gprocrst"
    "4"
    1
    NIL
    0
    1
    (:XDATA :SCALES (VALUES-THEMES "siecontr" "sselfman" "semotcop")))
   ("gtimeman" "5" 1 NIL 0 1 (:XDATA :SCALES ("sselfman" "semotcop")))
   ("grelat" "6" 1 NIL 0 1 (:XDATA :SCALES (INTERPERSONAL)))
   ("gmeetpeo" "7" 1 NIL 0 1 (:XDATA :SCALES (INTERPERSONAL)))
   ("glonelyf" "8" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("gexvalus" "9" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("gdepres" "10" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("ganxfear" "11" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("gaggrang" "12" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("gacadsuc" "13" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING)))
   ("gcomplta1"
    "14"
    1
    T
    1
    1
    (:XDATA :SCALES (HQ ACAD-LEARNING CAREER-INTEREST)))
   ("gcompltanomaj" "15" 1 NIL 0 1 (:XDATA :SCALES (HQ ACAD-LEARNING)))
   ("gcompltanoac" "16" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("gAcadOnly" "17" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING)))
   ("gcarplan" "18" 1 NIL 0 1 (:XDATA :SCALES (CAREER-INTEREST)))
   ("gcaronly" "19" 1 NIL 0 1 (:XDATA :SCALES (CAREER-INTEREST)))
   ("gnottake" "20" 1 NIL 0 1 (:XDATA :SCALES NIL)))
  :SCALE
  BIO-MAQ
  :MULTI-SEL-QUEST
  "bio4job"
  (BIO4JOB
   :MULTI
   "bio4job"
   "b-Primary occupation"
   1
   ("student" "1" 1 NIL 0 1 NIL)
   ("manager" "2" 1 NIL 0 1 NIL)
   ("propeop" "3" 1 T 1 1 NIL)
   ("protech" "4" 1 NIL 0 1 NIL)
   ("consulta" "5" 1 NIL 0 1 NIL)
   ("educator" "6" 1 T 1 1 NIL)
   ("sales" "7" 1 NIL 0 1 NIL)
   ("technici" "8" 1 NIL 0 1 NIL)
   ("clerical" "9" 1 NIL 0 1 NIL)
   ("service" "10" 1 NIL 0 1 NIL)
   ("ownbus10" "11" 1 NIL 0 1 NIL)
   ("othrsfem" "12" 1 NIL 0 1 NIL)
   ("other" "13" 1 NIL 0 1 NIL))
  :MULTI-SEL-QUEST
  "bio7lang"
  (BIO7LANG
   :MULTI
   "bio7lang"
   "b-Fluent languages"
   2
   ("lenglish" "1" 1 T 1 2 NIL)
   ("lspanish" "2" 1 NIL 0 2 NIL)
   ("lvietnam" "3" 1 NIL 0 2 NIL)
   ("lcambodn" "4" 1 NIL 0 2 NIL)
   ("lchinese" "5" 1 NIL 0 2 NIL)
   ("lkorean" "6" 1 NIL 0 2 NIL)
   ("lportugu" "7" 1 NIL 0 2 NIL)
   ("lgerman" "8" 1 NIL 0 2 NIL)
   ("lfrench" "9" 1 NIL 0 2 NIL)
   ("lmideast" "10" 1 NIL 0 2 NIL)
   ("lothrasn" "11" 1 NIL 0 2 NIL)
   ("lothreur" "12" 1 NIL 0 2 NIL)
   ("lother" "13" 1 NIL 0 2 NIL))
  :MULTI-SEL-QUEST
  "bio1ethn"
  (BIO1ETHN
   :MULTI
   "bio1ethn"
   "Primary Ethnic Group"
   3
   ("enortham" "1" 1 T 1 3 NIL)
   ("eafrica" "2" 1 NIL 0 3 NIL)
   ("enoreur" "3" 1 NIL 0 3 NIL)
   ("esoueur" "4" 1 NIL 0 3 NIL)
   ("mideast" "5" 1 NIL 0 3 NIL)
   ("ecambodn" "6" 1 NIL 0 3 NIL)
   ("echina" "7" 1 NIL 0 3 NIL)
   ("ekorea" "8" 1 NIL 0 3 NIL)
   ("ejapan" "9" 1 NIL 0 3 NIL)
   ("evietnam" "10" 1 NIL 0 3 NIL)
   ("eothrasn" "11" 1 NIL 0 3 NIL)
   ("emexico" "12" 1 NIL 0 3 NIL)
   ("ecentram" "13" 1 NIL 0 3 NIL)
   ("esoutham" "14" 1 NIL 0 3 NIL)
   ("epacific" "15" 1 NIL 0 3 NIL)
   ("eother" "16" 1 NIL 0 3 NIL))
  :MULTI-SEL-QUEST
  "biorelaf"
  (BIORELAF
   :MULTI
   "biorelaf"
   "bioRelAffiliation"
   4
   ("catholic" "1" 1 NIL 0 4 NIL)
   ("jewish" "2" 1 NIL 0 4 NIL)
   ("latterd" "3" 1 NIL 0 4 NIL)
   ("buddhist" "4" 1 NIL 0 4 NIL)
   ("islam" "5" 1 NIL 0 4 NIL)
   ("baptist" "6" 1 NIL 0 4 NIL)
   ("methodst" "7" 1 T 1 4 NIL)
   ("episcop" "8" 1 NIL 0 4 NIL)
   ("lutheran" "9" 1 NIL 0 4 NIL)
   ("presbyte" "10" 1 NIL 0 4 NIL)
   ("proliber" "11" 1 NIL 0 4 NIL)
   ("profunda" "12" 1 NIL 0 4 NIL)
   ("noaffil" "13" 1 NIL 0 4 NIL)
   ("agnostic" "14" 1 NIL 0 4 NIL)
   ("othrnoan" "15" 1 NIL 0 4 NIL))
  :MULTI-SEL-QUEST
  "sFamily"
  ("sFamily"
   :MULTI
   "sFamily"
   "Origin Family"
   1
   ("OlderBrosN" "1" 1 NIL 0)
   ("OlderSisN" "2" 1 NIL 0)
   ("YoungerBrosN" "3" 1 NIL 1)
   ("YoungerSisN" "4" 1 NIL 1)
   ("Raised2Parents" "5" 1 NIL 0)
   ("SingleFparent" "6" 1 NIL 1)
   ("SingleMparent" "7" 1 NIL 0)
   ("RaisedNoParents" "8" 1 NIL 0)
   ("RaisedOther" "9" 1 NIL 0))
  :SCALE
  ACAD-ACH
  (BIO3EDUC
   "b-Highest education completed"
   :SINGLE
   "Doctorate"
   "1.000"
   8
   1
   8
   8
   SCORED-NORMAL
   BIO3EDUCANSARRAY)
  (BIOHSGPA
   "b-High school GPA"
   :SINGLE
   "3.75-4.00"
   "1.000"
   14
   2
   14
   14
   SCORED-NORMAL
   GPAANSARRAY)
  (BIOCOLLE
   "b-College GPA"
   :SINGLE
   "3.25-3.49"
   "0.857"
   12
   3
   14
   12
   SCORED-NORMAL
   GPAANSARRAY)
  :SCALE
  ST1HIGHERSELF
  (THM6LEAR
   "ti-Learning, self-development"
   :SINGLE
   "One of the most important things in my life"
   "0.900"
   9
   1
   10
   9
   SCORED-NORMAL
   PRIORITY10)
  (THM9SHAP
   "ti-Self-happiness"
   :SINGLE
   "The most important thing in my life"
   "1.000"
   10
   2
   10
   10
   SCORED-NORMAL
   PRIORITY10)
  (THM14IND
   "ti-Independence"
   :SINGLE
   "One of the most important things in my life"
   "0.900"
   9
   3
   10
   9
   SCORED-NORMAL
   PRIORITY10)
  (THM22BOD
   "ti-Health and longevity"
   :SINGLE
   "The most important thing in my life"
   "1.000"
   10
   4
   10
   10
   SCORED-NORMAL
   PRIORITY10)
  (THM23BAL
   "ti-Life balance"
   :SINGLE
   "One of the most important things in my life"
   "0.900"
   9
   5
   10
   9
   SCORED-NORMAL
   PRIORITY10)
  (THMCOMPC
   "ti-Competence, best I can be"
   :SINGLE
   "One of the most important things in my life"
   "0.900"
   9
   6
   10
   9
   SCORED-NORMAL
   PRIORITY10)
  (THMINTEG
   "ti-Integrity"
   :SINGLE
   "One of the most important things in my life"
   "0.900"
   9
   7
   10
   9
   SCORED-NORMAL
   PRIORITY10)
  (THMPHIL
   "ti-Personal philosophy"
   :SINGLE
   "One of the most important things in my life"
   "0.900"
   9
   8
   10
   9
   SCORED-NORMAL
   PRIORITY10)
  (THMSESUF
   "ti-Self-sufficiency"
   :SINGLE
   "One of the most important things in my life"
   "0.900"
   9
   9
   10
   9
   SCORED-NORMAL
   PRIORITY10)
  (THMSEDIS
   "ti-Self-discipline"
   :SINGLE
   "One of the most important things in my life"
   "0.900"
   9
   10
   10
   9
   SCORED-NORMAL
   PRIORITY10)
  :SCALE
  ST2SOCINTIMNOFAM
  (THM8ROMA
   "ts-Love-romance"
   :SINGLE
   "One of the most important things in my life"
   "0.900"
   9
   1
   10
   9
   SCORED-NORMAL
   PRIORITY10)
  (THM12PLE
   "ts-Pleasing others-avoid conflict"
   :SINGLE
   "Moderately important"
   "0.600"
   6
   2
   10
   6
   SCORED-NORMAL
   PRIORITY10)
  (THMRESPE
   "ts-Respect from others"
   :SINGLE
   "Moderately important"
   "0.600"
   6
   3
   10
   6
   SCORED-NORMAL
   PRIORITY10)
  (THM20INT
   "ts-Intimacy-close relationships"
   :SINGLE
   "Extremely important"
   "0.800"
   8
   4
   10
   8
   SCORED-NORMAL
   PRIORITY10)
  (THMLIKED
   "ts-Well-liked by many"
   :SINGLE
   "Moderately important"
   "0.600"
   6
   5
   10
   6
   SCORED-NORMAL
   PRIORITY10)
  (THMSUPPO
   "ts-Emotional support from others"
   :SINGLE
   "Moderately important"
   "0.600"
   6
   6
   10
   6
   SCORED-NORMAL
   PRIORITY10)
  :SCALE
  ST3FAMCARE
  (THMCAREG
   "ts-Care-giving-parent, others"
   :SINGLE
   "Moderately important"
   "0.600"
   6
   1
   10
   6
   SCORED-NORMAL
   PRIORITY10)
  (THMPARLV
   "td-Parental love and respect"
   :SINGLE
   "Moderately important"
   "0.600"
   6
   2
   10
   6
   SCORED-NORMAL
   PRIORITY10)
  (THMFAMIL
   "ts-Family"
   :SINGLE
   "Mildly important"
   "0.500"
   5
   3
   10
   5
   SCORED-NORMAL
   PRIORITY10)
  :SCALE
  ST4SUCCESSSTATUSMATER
  (THM3EDUC
   "ta-Advanced degrees"
   :SINGLE
   "Extremely important"
   "0.800"
   8
   1
   10
   8
   SCORED-NORMAL
   PRIORITY10)
  (THM4MONE
   "ta-Very high income"
   :SINGLE
   "Moderately important"
   "0.600"
   6
   2
   10
   6
   SCORED-NORMAL
   PRIORITY10)
  (THM25POS
   "ta-High quality possessions"
   :SINGLE
   "Mildly important"
   "0.500"
   5
   3
   10
   5
   SCORED-NORMAL
   PRIORITY10)
  (THM26SUC
   "ta-Career success"
   :SINGLE
   "Very important"
   "0.700"
   7
   4
   10
   7
   SCORED-NORMAL
   PRIORITY10)
  (THM30CEO
   "ta-Power-ceo, owner"
   :SINGLE
   "Moderately important"
   "0.600"
   6
   5
   10
   6
   SCORED-NORMAL
   PRIORITY10)
  (THM33GOA
   "ta-Complete all important goals"
   :SINGLE
   "Extremely important"
   "0.800"
   8
   6
   10
   8
   SCORED-NORMAL
   PRIORITY10)
  (THMRESPE
   "ts-Respect from others"
   :SINGLE
   "Moderately important"
   "0.600"
   6
   7
   10
   6
   SCORED-NORMAL
   PRIORITY10)
  (THM1ACH
   "ta-Being the best"
   :SINGLE
   "Very important"
   "0.700"
   7
   8
   10
   7
   SCORED-NORMAL
   PRIORITY10)
  (THMRECOG
   "ts-Recognition-respect,status,etc"
   :SINGLE
   "Moderately important"
   "0.600"
   6
   9
   10
   6
   SCORED-NORMAL
   PRIORITY10)
  :SCALE
  ST5-ORDERPERFECTIONGOODNESS
  (THMORDER
   "ti-Orderliness organization"
   :SINGLE
   "Very important"
   "0.700"
   7
   1
   10
   7
   SCORED-NORMAL
   PRIORITY10)
  (THMCLEAN
   "ti-Cleanliness"
   :SINGLE
   "Moderately important"
   "0.600"
   6
   2
   10
   6
   SCORED-NORMAL
   PRIORITY10)
  (THMPERFE
   "ti-Perfection and idealism"
   :SINGLE
   "Moderately important"
   "0.600"
   6
   3
   10
   6
   SCORED-NORMAL
   PRIORITY10)
  (THMJUSTI
   "ti-Justice"
   :SINGLE
   "Very important"
   "0.700"
   7
   4
   10
   7
   SCORED-NORMAL
   PRIORITY10)
  (THMSIMPL
   "ti-Simplicity"
   :SINGLE
   "Moderately important"
   "0.600"
   6
   5
   10
   6
   SCORED-NORMAL
   PRIORITY10)
  (THMBEAUT
   "ti-Beauty"
   :SINGLE
   "Extremely important"
   "0.800"
   8
   6
   10
   8
   SCORED-NORMAL
   PRIORITY10)
  (THMGOODN
   "ti-Goodness"
   :SINGLE
   "Extremely important"
   "0.800"
   8
   7
   10
   8
   SCORED-NORMAL
   PRIORITY10)
  (THMWHOLE
   "ti-Wholeness"
   :SINGLE
   "Very important"
   "0.700"
   7
   8
   10
   7
   SCORED-NORMAL
   PRIORITY10)
  :SCALE
  ST6GODSPIRITRELIG
  (THMOBGOD
   "td-Obedience to God"
   :SINGLE
   "Moderately important"
   "0.600"
   6
   1
   10
   6
   SCORED-NORMAL
   PRIORITY10)
  (THMRELGD
   "ti-Spiritual intimacy"
   :SINGLE
   "Very important"
   "0.700"
   7
   2
   10
   7
   SCORED-NORMAL
   PRIORITY10)
  (THMSPIRI
   "ti-God and/or spirituality"
   :SINGLE
   "Moderately important"
   "0.600"
   6
   3
   10
   6
   SCORED-NORMAL
   PRIORITY10)
  (THMRELIG
   "ti-Religion"
   :SINGLE
   "Mildly important"
   "0.500"
   5
   4
   10
   5
   SCORED-NORMAL
   PRIORITY10)
  :SCALE
  ST7IMPACTCHALLENGEEXPLOR
  (THM10OTH
   "ti-Giving to others happiness, world"
   :SINGLE
   "One of the most important things in my life"
   "0.900"
   9
   1
   10
   9
   SCORED-NORMAL
   PRIORITY10)
  (THMIMPAC
   "ta-Impact-change world"
   :SINGLE
   "One of the most important things in my life"
   "0.900"
   9
   2
   10
   9
   SCORED-NORMAL
   PRIORITY10)
  (THM28CRE
   "ta-Creation-major contribution"
   :SINGLE
   "One of the most important things in my life"
   "0.900"
   9
   3
   10
   9
   SCORED-NORMAL
   PRIORITY10)
  (THMMENCH
   "ti-Mental Challenge"
   :SINGLE
   "One of the most important things in my life"
   "0.900"
   9
   4
   10
   9
   SCORED-NORMAL
   PRIORITY10)
  (THM34EXP
   "ti-Exploration find answers"
   :SINGLE
   "Extremely important"
   "0.800"
   8
   5
   10
   8
   SCORED-NORMAL
   PRIORITY10)
  (THMUNIQU
   "ti-Uniqueness & diversity"
   :SINGLE
   "Moderately important"
   "0.600"
   6
   6
   10
   6
   SCORED-NORMAL
   PRIORITY10)
  (THMCREAT
   "ti-Creativeness"
   :SINGLE
   "Extremely important"
   "0.800"
   8
   7
   10
   8
   SCORED-NORMAL
   PRIORITY10)
  :SCALE
  ST8ATTENTIONFUNEASY
  (THMATTEN
   "ts-Attention from others"
   :SINGLE
   "Mildly important"
   "0.500"
   5
   1
   10
   5
   SCORED-NORMAL
   PRIORITY10)
  (THM5ADVE
   "ti-Adventure"
   :SINGLE
   "Mildly important"
   "0.500"
   5
   2
   10
   5
   SCORED-NORMAL
   PRIORITY10)
  (THMEFORT
   "ti-Effortlessness"
   :SINGLE
   "Mildly important"
   "0.500"
   5
   3
   10
   5
   SCORED-NORMAL
   PRIORITY10)
  (THMPLAYF
   "ti-Fun playfulness"
   :SINGLE
   "Very important"
   "0.700"
   7
   4
   10
   7
   SCORED-NORMAL
   PRIORITY10)
  :SCALE
  ST9VALUESELFALLUNCOND
  (THVUNCON
   "bu-Value all unconditionally"
   :SINGLE
   "One of the most important beliefs in my life"
   "0.900"
   9
   1
   10
   9
   SCORED-NORMAL
   BELIEF10)
  (THVSELFW
   "bu-Value self unconditionally"
   :SINGLE
   "One of the most important beliefs in my life"
   "0.900"
   9
   2
   10
   9
   SCORED-NORMAL
   BELIEF10)
  (THVSELFA
   "bu-Accept all parts of self"
   :SINGLE
   "Not important, unsure, or neutral about this"
   "0.700"
   7
   3
   10
   7
   SCORED-REVERSE
   BELIEF10REVERSE)
  (THMUNCON
   "ti-Unconditional love of all people"
   :SINGLE
   "One of the most important things in my life"
   "0.900"
   9
   4
   10
   9
   SCORED-NORMAL
   PRIORITY10)
  :SCALE
  ST10OVERCMPROBACCEPTSELF
  (THMSPROT
   "td-Self-protection"
   :SINGLE
   "Mildly important"
   "0.500"
   5
   1
   10
   5
   SCORED-NORMAL
   PRIORITY10)
  (THMPHURT
   "td-Personal healing-overcome problems"
   :SINGLE
   "Mildly important"
   "0.500"
   5
   2
   10
   5
   SCORED-NORMAL
   PRIORITY10)
  :SCALE
  ST11DUTYPUNCTUAL
  (THMPUNCT
   "td-Punctuality"
   :SINGLE
   "Mildly important"
   "0.500"
   5
   1
   10
   5
   SCORED-NORMAL
   PRIORITY10)
  (THMOBLIG
   "td-Obligation"
   :SINGLE
   "Mildly important"
   "0.500"
   5
   2
   10
   5
   SCORED-NORMAL
   PRIORITY10)
  :SCALE
  SWORLDVIEW
  (WOVPROGR
   "wv-World will improve"
   :SINGLE
   "EXTREMELY agree"
   "1.000"
   7
   1
   7
   7
   SCORED-NORMAL
   AGREE7)
  (WOVGOODF
   "wv-Good forces control world"
   :SINGLE
   "EXTREMELY agree"
   "1.000"
   7
   2
   7
   7
   SCORED-NORMAL
   AGREE7)
  (WOVMYLIF
   "wv-My life will improve"
   :SINGLE
   "MODERATELY agree"
   "0.857"
   6
   3
   7
   6
   SCORED-NORMAL
   AGREE7)
  (WOVNFAIR
   "wv-Not life unfair to me"
   :SINGLE
   "EXTREMELY disagree"
   "1.000"
   7
   4
   7
   7
   SCORED-REVERSE
   AGREE7REVERSE)
  (TBVENTIT
   "bu-Not entitled to good life"
   :SINGLE
   "Strongly disagree, very negative to me"
   "0.900"
   9
   5
   10
   9
   SCORED-REVERSE
   BELIEF10REVERSE)
  (WOVINJUR
   "wv-Not one ruined my life"
   :SINGLE
   "EXTREMELY disagree"
   "1.000"
   7
   6
   7
   7
   SCORED-REVERSE
   AGREE7REVERSE)
  (WOVABUND
   "wv-Have all I need to be happy"
   :SINGLE
   "EXTREMELY agree"
   "1.000"
   7
   7
   7
   7
   SCORED-NORMAL
   AGREE7)
  (TBVGRATI
   "bu-Gratitude-abundance thinking"
   :SINGLE
   "The most important belief in my life"
   "1.000"
   10
   8
   10
   10
   SCORED-NORMAL
   BELIEF10)
  (WOVENTIT
   "wv-Not entitled to basic necessities"
   :SINGLE
   "MILDLY agree"
   "0.429"
   3
   9
   7
   3
   SCORED-REVERSE
   AGREE7REVERSE)
  (WOVGRATE
   "wv-Extremely grateful"
   :SINGLE
   "EXTREMELY agree"
   "1.000"
   7
   10
   7
   7
   SCORED-NORMAL
   AGREE7)
  (WOVPOSTH
   "wv-Percent of time positive thoughts"
   :SINGLE
   "Greater than 90 percent"
   "1.000"
   10
   11
   10
   10
   SCORED-NORMAL
   PERCENT10)
  :SCALE
  STBSLFWO
  (TBVOTHFI
   "bu-Not always others first"
   :SINGLE
   "Strongly disagree, very negative to me"
   "0.900"
   9
   1
   10
   9
   SCORED-REVERSE
   BELIEF10REVERSE)
  (TBVLIKED
   "bu-Not loved by all"
   :SINGLE
   "Strongly disagree, very negative to me"
   "0.900"
   9
   2
   10
   9
   SCORED-REVERSE
   BELIEF10REVERSE)
  (TBVWEAK
   "bu-Not weak and dependent"
   :SINGLE
   "Extremely disagree, extremely negative to me"
   "1.000"
   10
   3
   10
   10
   SCORED-REVERSE
   BELIEF10REVERSE)
  (TBVBEST
   "bu-Not must be best"
   :SINGLE
   "Strongly disagree, very negative to me"
   "0.900"
   9
   4
   10
   9
   SCORED-REVERSE
   BELIEF10REVERSE)
  (TBVRULES
   "bu-Not if break rules--severe punishment"
   :SINGLE
   "Disagree, negative to me"
   "0.800"
   8
   5
   10
   8
   SCORED-REVERSE
   BELIEF10REVERSE)
  (TBVWINNE
   "bu-Not winners and losers"
   :SINGLE
   "Strongly disagree, very negative to me"
   "0.900"
   9
   6
   10
   9
   SCORED-REVERSE
   BELIEF10REVERSE)
  (TBVBALAN
   "bu-Balance present-future, self-others hap"
   :SINGLE
   "One of the most important beliefs in my life"
   "0.900"
   9
   7
   10
   9
   SCORED-NORMAL
   BELIEF10)
  (TBVHAPCA
   "bu-Decisions-max happiness"
   :SINGLE
   "The most important belief in my life"
   "1.000"
   10
   8
   10
   10
   SCORED-NORMAL
   BELIEF10)
  (THVSELFA
   "bu-Accept all parts of self"
   :SINGLE
   "Strongly disagree, very negative to me"
   "0.900"
   9
   9
   10
   9
   SCORED-REVERSE
   BELIEF10REVERSE)
  (THVUNCON
   "bu-Value all unconditionally"
   :SINGLE
   "One of the most important beliefs in my life"
   "0.900"
   9
   10
   10
   9
   SCORED-NORMAL
   BELIEF10)
  (THVSELFW
   "bu-Value self unconditionally"
   :SINGLE
   "Extremely important belief"
   "0.800"
   8
   11
   10
   8
   SCORED-NORMAL
   BELIEF10)
  :SCALE
  SIECONTR
  (IECSELFS
   "ie-Take care of self & probs"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   1
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (IECICONT
   "ie-I control life-happiness"
   :SINGLE
   "EXTREMELY agree"
   "1.000"
   7
   2
   7
   7
   SCORED-NORMAL
   AGREE7)
  (IECGENET
   "ie-Not genetics-biology control my hap"
   :SINGLE
   "EXTREMELY disagree"
   "1.000"
   7
   3
   7
   7
   SCORED-REVERSE
   AGREE7REVERSE)
  (IECPEOPL
   "ie-Not others control my happiness"
   :SINGLE
   "EXTREMELY disagree"
   "1.000"
   7
   4
   7
   7
   SCORED-REVERSE
   AGREE7REVERSE)
  (IECDEPEN
   "ie-Not dependent on one person"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "1.000"
   7
   5
   7
   7
   SCORED-REVERSE
   LIKEME7REVERSE)
  (IECCOFEE
   "ie-Not care for another above self"
   :SINGLE
   "MODERATELY inaccurate / unlike me"
   "0.857"
   6
   6
   7
   6
   SCORED-REVERSE
   LIKEME7REVERSE)
  (IECCOPRB
   "ie-Not worry carrying for one's serious prob"
   :SINGLE
   "MILDLY inaccurate / unlike me"
   "0.714"
   5
   7
   7
   5
   SCORED-REVERSE
   LIKEME7REVERSE)
  :SCALE
  SETHBEL
  (TB2RELAT
   "b2-RevNo absolute right--situational ethics"
   :SINGLE
   "Mildly important belief"
   "0.600"
   6
   1
   10
   6
   SCORED-REVERSE
   BELIEF10REVERSE)
  (TB2PUNIS
   "b2-RevBad only happens if bad"
   :SINGLE
   "Strongly disagree, very negative to me"
   "0.900"
   9
   2
   10
   9
   SCORED-REVERSE
   BELIEF10REVERSE)
  (TBV2NOTR
   "b2-RevNot responsible if bad environ/genes"
   :SINGLE
   "Disagree, negative to me"
   "0.800"
   8
   3
   10
   8
   SCORED-REVERSE
   BELIEF10REVERSE)
  (TB2GROUM
   "b2-RevLife no meaning w/o spec group"
   :SINGLE
   "Strongly disagree, very negative to me"
   "0.900"
   9
   4
   10
   9
   SCORED-REVERSE
   BELIEF10REVERSE)
  (TB2SELFM
   "b2-RevAll meaning supplied by person"
   :SINGLE
   "Disagree, negative to me"
   "0.800"
   8
   5
   10
   8
   SCORED-REVERSE
   BELIEF10REVERSE)
  (TB2GDWRK
   "b2-RevForgiveness depends on works"
   :SINGLE
   "Disagree, negative to me"
   "0.800"
   8
   6
   10
   8
   SCORED-REVERSE
   BELIEF10REVERSE)
  (TB2GDATT
   "b2-Goodness depends more on attitude"
   :SINGLE
   "Mildly important belief"
   "0.500"
   5
   7
   10
   5
   SCORED-NORMAL
   BELIEF10)
  (TB2ALLGD
   "b2-Lots of good in all people"
   :SINGLE
   "Moderately important belief"
   "0.600"
   6
   8
   10
   6
   SCORED-NORMAL
   BELIEF10)
  (TB2REASO
   "b2-RevScience-reason can solve all worries"
   :SINGLE
   "Moderately important belief"
   "0.500"
   5
   9
   10
   5
   SCORED-REVERSE
   BELIEF10REVERSE)
  (TBV2ASTR
   "b2-RevBelief in spirits,astrology"
   :SINGLE
   "Extremely disagree, extremely negative to me"
   "1.000"
   10
   10
   10
   10
   SCORED-REVERSE
   BELIEF10REVERSE)
  (TB2IDHUM
   "b2-Identify with all human over any group"
   :SINGLE
   "Extremely important belief"
   "0.800"
   8
   11
   10
   8
   SCORED-NORMAL
   BELIEF10)
  (TB2LIFAD
   "b2-Believe in life after death"
   :SINGLE
   "Not important, unsure, or neutral about this"
   "0.400"
   4
   12
   10
   4
   SCORED-NORMAL
   BELIEF10)
  (TB2MOVEM
   "b2-Part of progress greater than family etc"
   :SINGLE
   "Very important belief"
   "0.700"
   7
   13
   10
   7
   SCORED-NORMAL
   BELIEF10)
  (TBV2CORE
   "b2-Strong phil/rel beliefs guide daily life"
   :SINGLE
   "Extremely important belief"
   "0.800"
   8
   14
   10
   8
   SCORED-NORMAL
   BELIEF10)
  :SCALE
  SGRFEARS
  (WOVHAPPY
   "wf-Not fear unhappy career"
   :SINGLE
   "No fear at all"
   "1.000"
   7
   1
   7
   7
   SCORED-REVERSE
   FEAR7REVERSE)
  (WOVPOOR
   "wf-Not fear of poverty"
   :SINGLE
   "No fear at all"
   "1.000"
   7
   2
   7
   7
   SCORED-REVERSE
   FEAR7REVERSE)
  (WOVILL
   "wf-Not fear of illness"
   :SINGLE
   "One of the most important fears in my life"
   "0.286"
   2
   3
   7
   2
   SCORED-REVERSE
   FEAR7REVERSE)
  (WOVDEATH
   "wf-Not fear of death"
   :SINGLE
   "The most important fear in my life"
   "0.143"
   1
   4
   7
   1
   SCORED-REVERSE
   FEAR7REVERSE)
  (WOVALONE
   "wf-Not fear of being alone"
   :SINGLE
   "Very important fear"
   "0.571"
   4
   5
   7
   4
   SCORED-REVERSE
   FEAR7REVERSE)
  (WOVNOLOV
   "wf-Not fear of poor marriage-family"
   :SINGLE
   "No fear at all"
   "1.000"
   7
   6
   7
   7
   SCORED-REVERSE
   FEAR7REVERSE)
  (WOVLIKED
   "wf-Not fear of not close friends"
   :SINGLE
   "Moderately important fear"
   "0.714"
   5
   7
   7
   5
   SCORED-REVERSE
   FEAR7REVERSE)
  (WOVPERSO
   "wf-Not fear of not being person want"
   :SINGLE
   "No fear at all"
   "1.000"
   7
   8
   7
   7
   SCORED-REVERSE
   FEAR7REVERSE)
  (WOVPROBL
   "wf-Not fear of overcoming problem"
   :SINGLE
   "No fear at all"
   "1.000"
   7
   9
   7
   7
   SCORED-REVERSE
   FEAR7REVERSE)
  (WOVDISCO
   "wf-Not fear of something discovered"
   :SINGLE
   "No fear at all"
   "1.000"
   7
   10
   7
   7
   SCORED-REVERSE
   FEAR7REVERSE)
  (WOVSUCCE
   "wf-Not fear of lack acad-career success"
   :SINGLE
   "Mildly important fear"
   "0.857"
   6
   11
   7
   6
   SCORED-REVERSE
   FEAR7REVERSE)
  (WOVOVERC
   "wf-Could be happy if worst fear happened"
   :SINGLE
   "EXTREMELY agree"
   "1.000"
   7
   12
   7
   7
   SCORED-NORMAL
   AGREE7)
  :SCALE
  SSLFCONF
  (SLFLEARN
   "sc-Learning and study skills"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   1
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFCRITT
   "sc-Critical thinking and logic"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   2
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFRESEA
   "sc-Research & methodology"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   3
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFANALY
   "sc-Analytical thinking"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   4
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFSYNTH
   "sc-Synthesis"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   5
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFCREAT
   "sc-Creative thinking-ideas"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   6
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFCOMPU
   "sc-Computer-related"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   7
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFBIOSC
   "sc-Biological science"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   8
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFNATSC
   "sc-Natural science--physics, chem"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   9
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFLIBAR
   "sc-Liberal arts"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   10
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFSOCSC
   "sc-Beh-social science"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   11
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFPHILR
   "sc-Philosophy-religion"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   12
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFPERFA
   "sc-Performing arts"
   :SINGLE
   "Moderately confident"
   "0.857"
   6
   13
   7
   6
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFFINEA
   "sc-Fine arts"
   :SINGLE
   "Moderately confident"
   "0.857"
   6
   14
   7
   6
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFBUSAN
   "sc-Business or management"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   15
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFHEAL2
   "sc-Health or medicine"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   16
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFENGIN
   "sc-Engineering or technical"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   17
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFEDUCH
   "sc-Educ,Counseling, or helping"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   18
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFIQ
   "sc-Intelligence"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   19
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFDECMA
   "sc-Decision-making/planning"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   20
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFTIMEM
   "sc-Time management"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   21
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFCOPE
   "sc-Emotional coping skills"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   22
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFSELF4
   "sc-Ach motivation-work habits, focus"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   23
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFSELFM
   "sc-Self-motivation of unpleasant"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   24
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFACHAN
   "sc-Self-development/change"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   25
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFMANA6
   "sc-Managing finances"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   26
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFHEAL3
   "sc-Health detailed knowl & habits"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   27
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFMEETP
   "sc-Meeting people"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   28
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFLISTE
   "sc-Empathetic listening skills"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   29
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFSELF5
   "sc-Self-disclosure"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   30
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFCONFL
   "sc-Conflict resolution skills"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   31
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFPERSU
   "sc-Persuasion skills"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   32
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFMANA7
   "sc-Management-leadership skills"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   33
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFHELPS
   "sc-Helping-teaching skills"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   34
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFSPEAK
   "sc-Public speaking skills"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   35
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFJOBSE
   "sc-Job search skills"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   36
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFADAPT
   "sc-Adaptable-success in any situation"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   37
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFHAPPY
   "sc-Happiness IQ"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   38
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFOPTIM
   "sc-Optimism"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   39
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (SLFFRIEN
   "sc-Caring, friendly, outgoing"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   40
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (SLFINDEP
   "sc-Strong, independent, self-disciplined"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   41
   7
   7
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  SSELFMAN
  (SMTBUSY
   "sm-Rarely upset about too rushed"
   :SINGLE
   "MODERATELY accurate / like me"
   "0.857"
   6
   1
   7
   6
   SCORED-NORMAL
   LIKEME7)
  (SMTFUTUR
   "sm-Time planning and distant goals"
   :SINGLE
   "MODERATELY accurate / like me"
   "0.857"
   6
   2
   7
   6
   SCORED-NORMAL
   LIKEME7)
  (SMTEXERC
   "sm-Exercise freq-20 mins"
   :SINGLE
   "More than once per day"
   "1.000"
   12
   3
   12
   12
   SCORED-NORMAL
   FREQ12)
  (SMTEATH
   "sm-Healthy diet"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   4
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (SMTSLEEP
   "sm-Hours sleep"
   :SINGLE
   "8"
   "0.692"
   9
   5
   13
   9
   SCORED-NORMAL
   NUMBERTO12)
  (SMTSDEVE
   "sm-Managed self-change"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   6
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (SMTNPROC
   "sm-Start & complete big projects"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   7
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (SMTPTODO
   "sm-To-do list--all areas"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   8
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (SMTGOALS
   "sm-Objectives lists used"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   9
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (SMTSCHD
   "sm-Weekly schedule"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   10
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (SMT2DTOD
   "sm-2-D to-do lists--assignments"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   11
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (SMTACMPL
   "sm-High accomplishment, lo pressure"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   12
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (SMTGHELP
   "sm-Regular self-development habits"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   13
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (SMTBALAN
   "sm-Life area balance/satisfaction"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   14
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (SMTHABCH
   "sm-Take good advice--make changes"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   15
   7
   7
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  SEMOTCOP
  (COPNEGTH
   "cp-Not worry, neg thoughts"
   :SINGLE
   "Never/Almost never"
   "1.000"
   6
   1
   6
   6
   SCORED-REVERSE
   PERCENT6COPEREVERSE)
  (COPCOPEA
   "cp-Not eat"
   :SINGLE
   "1 to 20 percent"
   "0.833"
   5
   2
   6
   5
   SCORED-REVERSE
   PERCENT6COPEREVERSE)
  (COPPSOLV
   "cp-Face & problem solve"
   :SINGLE
   "81 to 100 percent"
   "1.000"
   6
   3
   6
   6
   SCORED-NORMAL
   PERCENT6COPE)
  (COPAVOPS
   "cp-Not avoid thinking about-dealing w/problemNEW"
   :SINGLE
   "1 to 20 percent"
   "0.833"
   5
   4
   6
   5
   SCORED-REVERSE
   PERCENT6COPEREVERSE)
  (COPEMOTA
   "cp-Not outward anger"
   :SINGLE
   "1 to 20 percent"
   "0.833"
   5
   5
   6
   5
   SCORED-REVERSE
   PERCENT6COPEREVERSE)
  (COPBLAME
   "cp-Not blame others or self"
   :SINGLE
   "1 to 20 percent"
   "0.833"
   5
   6
   6
   5
   SCORED-REVERSE
   PERCENT6COPEREVERSE)
  (COPWDRW
   "cp-Not withdraw from others"
   :SINGLE
   "1 to 20 percent"
   "0.833"
   5
   7
   6
   5
   SCORED-REVERSE
   PERCENT6COPEREVERSE)
  (COPFUN
   "cp-Fun or involving activity"
   :SINGLE
   "81 to 100 percent"
   "1.000"
   6
   8
   6
   6
   SCORED-NORMAL
   PERCENT6COPE)
  (COPTALKS
   "cp-Talk about problem"
   :SINGLE
   "81 to 100 percent"
   "1.000"
   6
   9
   6
   6
   SCORED-NORMAL
   PERCENT6COPE)
  (COPPEPTA
   "cp-Positive thoughts-pep talk"
   :SINGLE
   "81 to 100 percent"
   "1.000"
   6
   10
   6
   6
   SCORED-NORMAL
   PERCENT6COPE)
  (COPSMOKE
   "cp-Not smoke tobacco"
   :SINGLE
   "Never/Almost never"
   "1.000"
   6
   11
   6
   6
   SCORED-REVERSE
   PERCENT6COPEREVERSE)
  (COPDRUG
   "cp-Not drink alcohol, street drugs,or meds"
   :SINGLE
   "Never/Almost never"
   "1.000"
   6
   12
   6
   6
   SCORED-REVERSE
   PERCENT6COPEREVERSE)
  (COPPE
   "cp-Vigorous physical activity"
   :SINGLE
   "81 to 100 percent"
   "1.000"
   6
   13
   6
   6
   SCORED-NORMAL
   PERCENT6COPE)
  (COPNEGPH
   "cp-Not critical-punative thoughts"
   :SINGLE
   "Never/Almost never"
   "1.000"
   6
   14
   6
   6
   SCORED-REVERSE
   PERCENT6COPEREVERSE)
  (COPSELFB
   "cp-Not anger at self"
   :SINGLE
   "Never/Almost never"
   "1.000"
   6
   15
   6
   6
   SCORED-REVERSE
   PERCENT6COPEREVERSE)
  (COPPOSPH
   "cp-Phil or religious viewpoint"
   :SINGLE
   "61 to 80 percent"
   "0.833"
   5
   16
   6
   5
   SCORED-NORMAL
   PERCENT6COPE)
  (COPEXPEC
   "cp-Examine expectations"
   :SINGLE
   "61 to 80 percent"
   "0.833"
   5
   17
   6
   5
   SCORED-NORMAL
   PERCENT6COPE)
  (COPHAPPY
   "cp-Think happy no matter what"
   :SINGLE
   "81 to 100 percent"
   "1.000"
   6
   18
   6
   6
   SCORED-NORMAL
   PERCENT6COPE)
  (COPAVOAT
   "cp-Not miss work, school, etc-"
   :SINGLE
   "Less than once per year"
   "1.000"
   7
   19
   7
   7
   SCORED-REVERSE
   FREQ7REVERSE)
  (COPSELFE
   "cp-Self-exploration enjoyment"
   :SINGLE
   "Extremely important to me"
   "1.000"
   9
   20
   9
   9
   SCORED-NORMAL
   PRIORITY9)
  :SCALE
  INTSS1AASSERTCR
  (CR1ISSUE
   "cr-One issue at a time"
   :SINGLE
   "EXTREMELY accurate / like us"
   "1.000"
   7
   1
   7
   7
   SCORED-NORMAL
   LIKEUS7)
  (CRRESOLV
   "cr-Rarely repeat arguments of same issue"
   :SINGLE
   "MILDLY accurate / like us"
   "0.714"
   5
   2
   7
   5
   SCORED-NORMAL
   LIKEUS7)
  (CRNTHREA
   "cr-I rarely make threats"
   :SINGLE
   "MILDLY inaccurate / unlike us"
   "0.429"
   3
   3
   7
   3
   SCORED-NORMAL
   LIKEUS7)
  (CRUNDERL
   "cr-Discuss underlying issues"
   :SINGLE
   "EXTREMELY accurate / like us"
   "1.000"
   7
   4
   7
   7
   SCORED-NORMAL
   LIKEUS7)
  (CRWINWIN
   "cr-Discuss until win-win solution"
   :SINGLE
   "MODERATELY accurate / like us"
   "0.857"
   6
   5
   7
   6
   SCORED-NORMAL
   LIKEUS7)
  (CRLONGTK
   "cr-Keep going until reach a solution"
   :SINGLE
   "MODERATELY accurate / like us"
   "0.857"
   6
   6
   7
   6
   SCORED-NORMAL
   LIKEUS7)
  (CRSUMMAR
   "cr-I repeat summary"
   :SINGLE
   "MILDLY accurate / like us"
   "0.714"
   5
   7
   7
   5
   SCORED-NORMAL
   LIKEUS7)
  (CRCPRAIS
   "cr-We laugh & praise during disagree"
   :SINGLE
   "MILDLY accurate / like us"
   "0.714"
   5
   8
   7
   5
   SCORED-NORMAL
   LIKEUS7)
  (CRBOASSR
   "cr-Both assertive pos,firm,diplom"
   :SINGLE
   "EXTREMELY accurate / like us"
   "1.000"
   7
   9
   7
   7
   SCORED-NORMAL
   LIKEUS7)
  (CROPHONE
   "cr-We open,nondefensive,honest"
   :SINGLE
   "EXTREMELY accurate / like us"
   "1.000"
   7
   10
   7
   7
   SCORED-NORMAL
   LIKEUS7)
  (CRANGRES
   "cr-If one angry, other assertive back"
   :SINGLE
   "MODERATELY accurate / like us"
   "0.857"
   6
   11
   7
   6
   SCORED-NORMAL
   LIKEUS7)
  (CRTLKMOR
   "cr-One partner not much more talkative"
   :SINGLE
   "MILDLY accurate / like us"
   "0.429"
   3
   12
   7
   3
   SCORED-REVERSE
   LIKEUS7REVERSE)
  (CREQWIN
   "cr-Equal winning of disagreements"
   :SINGLE
   "MODERATELY accurate / like us"
   "0.857"
   6
   13
   7
   6
   SCORED-NORMAL
   LIKEUS7)
  (INTUNDRL
   "in-We discuss underlying issues"
   :SINGLE
   "EXTREMELY accurate / like us"
   "1.000"
   7
   14
   7
   7
   SCORED-NORMAL
   LIKEUS7)
  :SCALE
  INTSS1BOPENHON
  (INTTELAL
   "in-Told partner all about self"
   :SINGLE
   "EXTREMELY accurate / like us"
   "1.000"
   7
   1
   7
   7
   SCORED-NORMAL
   LIKEUS7)
  (INTSMGOA
   "in-We agree on long term goals"
   :SINGLE
   "EXTREMELY accurate / like us"
   "1.000"
   7
   2
   7
   7
   SCORED-NORMAL
   LIKEUS7)
  (INTEQDEC
   "in-Equality in decision influence"
   :SINGLE
   "MODERATELY accurate / like us"
   "0.857"
   6
   3
   7
   6
   SCORED-NORMAL
   LIKEUS7)
  (INTIOPEN
   "in-We tell almost exactly what we thinking"
   :SINGLE
   "EXTREMELY accurate / like us"
   "1.000"
   7
   4
   7
   7
   SCORED-NORMAL
   LIKEUS7)
  (INTWEOPN
   "in-We open, nondefensive,honest"
   :SINGLE
   "MODERATELY accurate / like us"
   "0.857"
   6
   5
   7
   6
   SCORED-NORMAL
   LIKEUS7)
  (INTDAILY
   "in-Daily sharing of feelings on events"
   :SINGLE
   "EXTREMELY accurate / like us"
   "1.000"
   7
   6
   7
   7
   SCORED-NORMAL
   LIKEUS7)
  (INTALLOP
   "in-Open, specific about sensitive issues"
   :SINGLE
   "EXTREMELY accurate / like us"
   "1.000"
   7
   7
   7
   7
   SCORED-NORMAL
   LIKEUS7)
  (INTKNPFE
   "in-Not frequently don't know p- feelings"
   :SINGLE
   "EXTREMELY inaccurate / unlike us"
   "1.000"
   7
   8
   7
   7
   SCORED-REVERSE
   LIKEUS7REVERSE)
  (INCOMTWO
   "id-Not-worries of other's commitment"
   :SINGLE
   "EXTREMELY inaccurate / unlike us"
   "1.000"
   7
   9
   7
   7
   SCORED-REVERSE
   LIKEUS7REVERSE)
  :SCALE
  INTSS2ROMANTC
  (ROMSURPR
   "ro-Surprise p- once/week"
   :SINGLE
   "MILDLY accurate / like me"
   "0.714"
   5
   1
   7
   5
   SCORED-NORMAL
   LIKEME7)
  (ROMFANTA
   "ro-Freq fantasies about p-"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   2
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (ROMCELEB
   "ro-Celebrate special days 1/month"
   :SINGLE
   "EXTREMELY accurate / like us"
   "1.000"
   7
   3
   7
   7
   SCORED-NORMAL
   LIKEUS7)
  (ROMPLACE
   "ro-We go to romantic places 1/week"
   :SINGLE
   "MODERATELY accurate / like us"
   "0.857"
   6
   4
   7
   6
   SCORED-NORMAL
   LIKEUS7)
  (ROMATTRA
   "ro-Sexually attracted to partner"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   5
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (ROMPLAYF
   "ro-Some playful interactions weekly"
   :SINGLE
   "EXTREMELY accurate / like us"
   "1.000"
   7
   6
   7
   7
   SCORED-NORMAL
   LIKEUS7)
  (ROMCHARM
   "ro-Partner charming & romantic"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   7
   7
   7
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  INTSS3LIBROLE
  (LROMTASK
   "find"
   :SINGLE
   "MILDLY disagree"
   "0.714"
   5
   1
   7
   5
   SCORED-REVERSE
   AGREE7REVERSE)
  (LROFTASK
   "find"
   :SINGLE
   "MODERATELY disagree"
   "0.857"
   6
   2
   7
   6
   SCORED-REVERSE
   AGREE7REVERSE)
  (LRMFINAL
   "find"
   :SINGLE
   "EXTREMELY disagree"
   "1.000"
   7
   3
   7
   7
   SCORED-REVERSE
   AGREE7REVERSE)
  (LROEMBAR
   "find"
   :SINGLE
   "EXTREMELY disagree"
   "1.000"
   7
   4
   7
   7
   SCORED-REVERSE
   AGREE7REVERSE)
  (LROMSTRO
   "find"
   :SINGLE
   "EXTREMELY disagree"
   "1.000"
   7
   5
   7
   7
   SCORED-REVERSE
   AGREE7REVERSE)
  (LROEQINC
   "find"
   :SINGLE
   "MODERATELY agree"
   "0.857"
   6
   6
   7
   6
   SCORED-NORMAL
   AGREE7)
  (LRCARCON
   "find"
   :SINGLE
   "EXTREMELY disagree"
   "1.000"
   7
   7
   7
   7
   SCORED-REVERSE
   AGREE7REVERSE)
  :SCALE
  INTSS4LOVERES
  (CRIFAVOR
   "cr-I do favors cheerfully when asked"
   :SINGLE
   "EXTREMELY accurate / like us"
   "1.000"
   7
   1
   7
   7
   SCORED-NORMAL
   LIKEUS7)
  (CRIFOLUP
   "cr-I do what I tell partner"
   :SINGLE
   "EXTREMELY accurate / like us"
   "1.000"
   7
   2
   7
   7
   SCORED-NORMAL
   LIKEUS7)
  (INTCOMIT
   "in-Not-commitment cause feel trapped"
   :SINGLE
   "EXTREMELY inaccurate / unlike us"
   "1.000"
   7
   3
   7
   7
   SCORED-REVERSE
   LIKEUS7REVERSE)
  (INTRESPT
   "in-Respect partner above others"
   :SINGLE
   "EXTREMELY accurate / like us"
   "1.000"
   7
   4
   7
   7
   SCORED-NORMAL
   LIKEUS7)
  (INTLSQPR
   "in-Tell of respect, love of p- to others"
   :SINGLE
   "EXTREMELY accurate / like us"
   "1.000"
   7
   5
   7
   7
   SCORED-NORMAL
   LIKEUS7)
  (INTLOVE
   "in-I love partner very much"
   :SINGLE
   "EXTREMELY accurate / like us"
   "1.000"
   7
   6
   7
   7
   SCORED-NORMAL
   LIKEUS7)
  (INNEVARG
   "id-Not-partners never disagree if happy"
   :SINGLE
   "EXTREMELY inaccurate / unlike us"
   "1.000"
   7
   7
   7
   7
   SCORED-REVERSE
   LIKEUS7REVERSE)
  :SCALE
  INTSS5INDEP
  (INRLUNCH
   "id-Lunch with opposite sex OK"
   :SINGLE
   "MODERATELY accurate / like us"
   "0.857"
   6
   1
   7
   6
   SCORED-NORMAL
   LIKEUS7)
  (INRINHAP
   "id-Marriage not greater than ind- happy"
   :SINGLE
   "MODERATELY inaccurate / unlike us"
   "0.857"
   6
   2
   7
   6
   SCORED-REVERSE
   LIKEUS7REVERSE)
  (INRIGROW
   "id-I end relationship if can't grow"
   :SINGLE
   "UNCERTAIN, neutral, or midpoint"
   "0.571"
   4
   3
   7
   4
   SCORED-NORMAL
   LIKEUS7)
  (INRSAYWE
   "id-Not say we'when mean 'I"
   :SINGLE
   "MODERATELY inaccurate / unlike us"
   "0.857"
   6
   4
   7
   6
   SCORED-REVERSE
   LIKEUS7REVERSE)
  (INDIFGOA
   "id-Ok for different goals"
   :SINGLE
   "MODERATELY accurate / like us"
   "0.857"
   6
   5
   7
   6
   SCORED-NORMAL
   LIKEUS7)
  (INFINDAN
   "id-Could be happy with another"
   :SINGLE
   "MODERATELY accurate / like us"
   "0.857"
   6
   6
   7
   6
   SCORED-NORMAL
   LIKEUS7)
  (INENALON
   "id-Not-can't enjoy being w/o partner"
   :SINGLE
   "MODERATELY inaccurate / unlike us"
   "0.857"
   6
   7
   7
   6
   SCORED-REVERSE
   LIKEUS7REVERSE)
  (INOKALON
   "id-Not-not happy if not partner"
   :SINGLE
   "MODERATELY inaccurate / unlike us"
   "0.857"
   6
   8
   7
   6
   SCORED-REVERSE
   LIKEUS7REVERSE)
  (INRHATEA
   "id-Not-I hate to be alone"
   :SINGLE
   "EXTREMELY inaccurate / unlike us"
   "1.000"
   7
   9
   7
   7
   SCORED-REVERSE
   LIKEUS7REVERSE)
  (INSEPINT
   "id-sep-interests"
   :SINGLE
   "EXTREMELY accurate / like us"
   "1.000"
   7
   10
   7
   7
   SCORED-NORMAL
   LIKEUS7)
  (INRMONEY
   "id-SeparateFunds"
   :SINGLE
   "EXTREMELY accurate / like us"
   "1.000"
   7
   11
   7
   7
   SCORED-NORMAL
   LIKEUS7)
  (INRBEALN
   "id-OK for weekends alone"
   :SINGLE
   "MODERATELY inaccurate / unlike us"
   "0.857"
   6
   12
   7
   6
   SCORED-REVERSE
   LIKEUS7REVERSE)
  (INALCNST
   "id-Not consult for small decisions"
   :SINGLE
   "MODERATELY inaccurate / unlike us"
   "0.857"
   6
   13
   7
   6
   SCORED-REVERSE
   LIKEUS7REVERSE)
  (INRFREEH
   "id-Free at home if partner there"
   :SINGLE
   "EXTREMELY accurate / like us"
   "1.000"
   7
   14
   7
   7
   SCORED-NORMAL
   LIKEUS7)
  (INRFRIEN
   "id-P- has opposite sex social friends"
   :SINGLE
   "MODERATELY accurate / like us"
   "0.857"
   6
   15
   7
   6
   SCORED-NORMAL
   LIKEUS7)
  :SCALE
  INTSS6POSSUP
  (CRNTHREA
   "cr-I rarely make threats"
   :SINGLE
   "MODERATELY accurate / like us"
   "0.857"
   6
   1
   7
   6
   SCORED-NORMAL
   LIKEUS7)
  (CRNNEGLB
   "cr-I rarely use negative labels"
   :SINGLE
   "EXTREMELY accurate / like us"
   "1.000"
   7
   2
   7
   7
   SCORED-NORMAL
   LIKEUS7)
  (CREXAGGR
   "cr-I not freq use 'always' or exaggeration"
   :SINGLE
   "EXTREMELY inaccurate / unlike us"
   "1.000"
   7
   3
   7
   7
   SCORED-REVERSE
   LIKEUS7REVERSE)
  (CRANGANG
   "cr-If p-angry at me, I don't get angry-def"
   :SINGLE
   "MODERATELY inaccurate / unlike us"
   "0.857"
   6
   4
   7
   6
   SCORED-REVERSE
   LIKEUS7REVERSE)
  (CRIPRAIS
   "cr-I not criticize more than praise p-"
   :SINGLE
   "EXTREMELY inaccurate / unlike us"
   "1.000"
   7
   5
   7
   7
   SCORED-REVERSE
   LIKEUS7REVERSE)
  (CRANGRES
   "cr-If one angry, other assertive back"
   :SINGLE
   "MODERATELY accurate / like us"
   "0.857"
   6
   6
   7
   6
   SCORED-NORMAL
   LIKEUS7)
  (INDIFDEC
   "id-Support p decision if disagree"
   :SINGLE
   "MODERATELY accurate / like us"
   "0.857"
   6
   7
   7
   6
   SCORED-NORMAL
   LIKEUS7)
  (INSTSHLP
   "in-Partner helps if I under stress"
   :SINGLE
   "EXTREMELY accurate / like us"
   "1.000"
   7
   8
   7
   7
   SCORED-NORMAL
   LIKEUS7)
  :SCALE
  INTSS7COLLAB
  (CRTKLONG
   "cr-Not one talk long before other"
   :SINGLE
   "MODERATELY accurate / like us"
   "0.286"
   2
   1
   7
   2
   SCORED-REVERSE
   LIKEUS7REVERSE)
  (CRTEWEAK
   "cr-Not uncomfortable about tell weakness"
   :SINGLE
   "EXTREMELY inaccurate / unlike us"
   "1.000"
   7
   2
   7
   7
   SCORED-REVERSE
   LIKEUS7REVERSE)
  (CRMANIPU
   "cr-Not feel me or partner manipulate"
   :SINGLE
   "EXTREMELY inaccurate / unlike us"
   "1.000"
   7
   3
   7
   7
   SCORED-REVERSE
   LIKEUS7REVERSE)
  (CRREPRAI
   "cr-Partner gives more praise than criticism"
   :SINGLE
   "MODERATELY inaccurate / unlike us"
   "0.857"
   6
   4
   7
   6
   SCORED-REVERSE
   LIKEUS7REVERSE)
  (CRTEACH
   "cr-Not problem teaching other"
   :SINGLE
   "MODERATELY inaccurate / unlike us"
   "0.857"
   6
   5
   7
   6
   SCORED-REVERSE
   LIKEUS7REVERSE)
  (CRTLKMOR
   "cr-One partner not much more talkative"
   :SINGLE
   "MODERATELY accurate / like us"
   "0.286"
   2
   6
   7
   2
   SCORED-REVERSE
   LIKEUS7REVERSE)
  (INTWKTOG
   "in-We enjoy working together"
   :SINGLE
   "UNCERTAIN, neutral, or midpoint"
   "0.571"
   4
   7
   7
   4
   SCORED-REVERSE
   LIKEUS7REVERSE)
  :SCALE
  SCOLLEGE
  (STPARED
   "b-Highest parents educ level"
   :SINGLE
   "High school degree"
   "0.625"
   5
   1
   8
   5
   SCORED-NORMAL
   STUPARENTSEDUC)
  (STUCLASS
   "st-Class level"
   :SINGLE
   "Unsure or Other"
   "0.100"
   1
   2
   10
   1
   SCORED-NORMAL
   STUCLASSLEVEL)
  (STUDEGRE
   "st-Educ objective level"
   :SINGLE
   "Doctorate"
   "1.000"
   7
   3
   7
   7
   SCORED-NORMAL
   STUDEGREEOBJECTIVE)
  (STUSEMES
   "st-Units this semester"
   :SINGLE
   "0"
   "0.083"
   1
   4
   12
   1
   SCORED-NORMAL
   UNITS)
  (STMAJGPA
   "st-Major GPA"
   :SINGLE
   "3.5-4.0 (A)"
   "1.000"
   8
   5
   8
   8
   SCORED-NORMAL
   GPA8ANSARRAY)
  (STACADST
   "st-AcadStatus"
   :SINGLE
   "President's List--over 3.5 GPA last semester"
   "1.000"
   6
   6
   6
   6
   SCORED-NORMAL
   STUACADEMICSTATUS)
  :MULTI-SEL-QUEST
  "stucolle"
  (STUCOLLE
   :MULTI
   "stucolle"
   "st-College attending"
   7
   ("cocsulb" "1" 1 NIL 0 7 NIL)
   ("cccsu" "2" 1 NIL 0 7 NIL)
   ("coucal" "3" 1 NIL 0 7 NIL)
   ("coopublc" "4" 1 NIL 0 7 NIL)
   ("coprivca" "5" 1 NIL 0 7 NIL)
   ("coprivot" "6" 1 NIL 0 7 NIL)
   ("cocacomc" "7" 1 NIL 0 7 NIL)
   ("coothcc" "8" 1 NIL 0 7 NIL)
   ("coothnat" "9" 1 NIL 0 7 NIL)
   ("coprgrad" "10" 1 NIL 0 7 NIL)
   ("cotech" "11" 1 NIL 0 7 NIL)
   ("highsch" "12" 1 NIL 0 7 NIL)
   ("coother" "13" 1 T 1 7 NIL))
  :MULTI-SEL-QUEST
  "stumajor"
  (STUMAJOR
   :MULTI
   "stumajor"
   "st-Major study area"
   8
   ("mlibart" "1" 1 NIL 0 8 NIL)
   ("msocsci" "2" 1 T 1 8 NIL)
   ("mbiolsci" "3" 1 NIL 0 8 NIL)
   ("mart" "4" 1 NIL 0 8 NIL)
   ("mnatsci" "5" 1 NIL 0 8 NIL)
   ("mbus" "6" 1 NIL 0 8 NIL)
   ("menginr" "7" 1 T 1 8 NIL)
   ("meducat" "8" 1 NIL 0 8 NIL)
   ("mmedical" "9" 1 NIL 0 8 NIL)
   ("motcompu" "10" 1 NIL 0 8 NIL)
   ("mothtech" "11" 1 NIL 0 8 NIL)
   ("mrecrpe" "12" 1 NIL 0 8 NIL)
   ("mdoesna" "13" 1 NIL 0 8 NIL)
   ("mundecid" "14" 1 NIL 0 8 NIL))
  :MULTI-SEL-QUEST
  "stuspeci"
  (STUSPECI
   :MULTI
   "stuspeci"
   "st-Special status"
   9
   ("strancc" "1" 1 NIL 0 9 NIL)
   ("stran4yr" "2" 1 NIL 0 9 NIL)
   ("sadultre" "3" 1 NIL 0 9 NIL)
   ("seop" "4" 1 NIL 0 9 NIL)
   ("susimmig" "5" 1 NIL 0 9 NIL)
   ("svisa" "6" 1 NIL 0 9 NIL)
   ("shonor" "7" 1 NIL 0 9 NIL)
   ("svisastu" "8" 1 NIL 0 9 NIL)
   ("sdisabld" "9" 1 NIL 0 9 NIL)
   ("soutofst" "10" 1 NIL 0 9 NIL)
   ("smilitar" "11" 1 NIL 0 9 NIL)
   ("sathlete" "12" 1 NIL 0 9 NIL)
   ("snone" "13" 1 T 1 9 NIL))
  :MULTI-SEL-QUEST
  "sturesid"
  (STURESID
   :MULTI
   "sturesid"
   "st-Residence"
   10
   ("rsinwpar" "1" 1 NIL 0 10 NIL)
   ("rsindorm" "2" 1 NIL 0 10 NIL)
   ("rsinwchl" "3" 1 NIL 0 10 NIL)
   ("rsinothr" "4" 1 NIL 0 10 NIL)
   ("rmarwoch" "5" 1 T 1 10 NIL)
   ("rmarwchl" "6" 1 NIL 0 10 NIL)
   ("rmarlike" "7" 1 NIL 0 10 NIL)
   ("rother" "8" 1 NIL 0 10 NIL))
  :MULTI-SEL-QUEST
  "stgpatre"
  (STGPATRE
   :MULTI
   "stgpatre"
   "st-GPA Trends"
   11
   ("trconhi" "1" 1 T 1 11 NIL)
   ("trincryr" "2" 1 NIL 0 11 NIL)
   ("trincyru" "3" 1 NIL 0 11 NIL)
   ("trincyrs" "4" 1 NIL 0 11 NIL)
   ("trgradin" "5" 1 NIL 0 11 NIL)
   ("trconave" "6" 1 NIL 0 11 NIL)
   ("trdecyru" "7" 1 NIL 0 11 NIL)
   ("trdecyr" "8" 1 NIL 0 11 NIL)
   ("trconlow" "9" 1 NIL 0 11 NIL)
   ("trupandd" "10" 1 NIL 0 11 NIL)
   ("trother" "11" 1 NIL 0 11 NIL))
  :MULTI-SEL-QUEST
  "sturesource"
  (STURESOURCE
   :MULTI
   "sturesource"
   "am-All interference factors"
   12
   ("afinanc" "1" 1 NIL 0 12 NIL)
   ("afampres" "2" 1 NIL 0 12 NIL)
   ("afamresp" "3" 1 NIL 0 12 NIL)
   ("aworktim" "4" 1 NIL 0 12 NIL)
   ("awrkpres" "5" 1 NIL 0 12 NIL)
   ("arelprob" "6" 1 NIL 0 12 NIL)
   ("aloneli" "7" 1 NIL 0 12 NIL)
   ("ahomstpl" "8" 1 NIL 0 12 NIL)
   ("aschstpl" "9" 1 NIL 0 12 NIL)
   ("acompavl" "10" 1 NIL 0 12 NIL)
   ("awrngcls" "11" 1 NIL 0 12 NIL)
   ("afacconn" "12" 1 NIL 0 12 NIL)
   ("astuconn" "13" 1 NIL 0 12 NIL)
   ("alowmotv" "14" 1 NIL 0 12 NIL)
   ("atimconf" "15" 1 T 1 12 NIL)
   ("aprocras" "16" 1 NIL 0 12 NIL))
  :SCALE
  SSL1CONFIDEFFICSTUDYTEST
  (LRNUNASN
   "ld-Understand & begin assignments"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "1.000"
   7
   1
   7
   7
   SCORED-REVERSE
   LIKEME7REVERSE)
  (LRNCOLMT
   "ld-Not made to feel not college material"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "1.000"
   7
   2
   7
   7
   SCORED-REVERSE
   LIKEME7REVERSE)
  (LRNKNOWT
   "ld-Not know more than test"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "1.000"
   7
   3
   7
   7
   SCORED-REVERSE
   LIKEME7REVERSE)
  (LRNPROOF
   "ld-Not unsure of un-proofed-by-other paper"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "1.000"
   7
   4
   7
   7
   SCORED-REVERSE
   LIKEME7REVERSE)
  (LRNRREAD
   "ld-Not read texts 2-3 times to make sense"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "1.000"
   7
   5
   7
   7
   SCORED-REVERSE
   LIKEME7REVERSE)
  (LRNEFFIC
   "ld-Not more time, lower grades"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   6
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (LRNTESTT
   "ld-Not test better if more time"
   :SINGLE
   "MODERATELY accurate / like me"
   "0.286"
   2
   7
   7
   2
   SCORED-REVERSE
   LIKEME7REVERSE)
  (LRNTIMAS
   "ld-Not too much time on assignments"
   :SINGLE
   "UNCERTAIN, neutral, or midpoint"
   "0.571"
   4
   8
   7
   4
   SCORED-REVERSE
   LIKEME7REVERSE)
  (LRNTIRED
   "ld-Not reading 1 hour make tired"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "1.000"
   7
   9
   7
   7
   SCORED-REVERSE
   LIKEME7REVERSE)
  (LRNTANXI
   "ld-Not more anxiety about tests"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "1.000"
   7
   10
   7
   7
   SCORED-REVERSE
   LIKEME7REVERSE)
  (LRNSMART
   "ld-Not smarter than grades indicate"
   :SINGLE
   "MILDLY accurate / like me"
   "0.429"
   3
   11
   7
   3
   SCORED-REVERSE
   LIKEME7REVERSE)
  (LRNAREAD
   "ld-Not problem avoiding reading"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "1.000"
   7
   12
   7
   7
   SCORED-REVERSE
   LIKEME7REVERSE)
  (LRNRSLOW
   "ld-Not slower reader"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "1.000"
   7
   13
   7
   7
   SCORED-REVERSE
   LIKEME7REVERSE)
  :SCALE
  SSL1BCONFIDNOTAVOIDSTUDY
  (LRNUNASN
   "ld-Understand & begin assignments"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "1.000"
   7
   1
   7
   7
   SCORED-REVERSE
   LIKEME7REVERSE)
  (LRNCOLMT
   "ld-Not made to feel not college material"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "1.000"
   7
   2
   7
   7
   SCORED-REVERSE
   LIKEME7REVERSE)
  (LRNTIRED
   "ld-Not reading 1 hour make tired"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "1.000"
   7
   3
   7
   7
   SCORED-REVERSE
   LIKEME7REVERSE)
  (LRNAREAD
   "ld-Not problem avoiding reading"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "1.000"
   7
   4
   7
   7
   SCORED-REVERSE
   LIKEME7REVERSE)
  (LRNPROOF
   "ld-Not unsure of un-proofed-by-other paper"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "1.000"
   7
   5
   7
   7
   SCORED-REVERSE
   LIKEME7REVERSE)
  :SCALE
  SSL2SATISCAMPUSFACFRIENDSGRDES
  (STULOOKF
   "sa-Look forward to campus"
   :SINGLE
   "MODERATELY accurate / like me"
   "0.857"
   6
   1
   7
   6
   SCORED-NORMAL
   LIKEME7)
  (STULIKEI
   "sa-Like instructors-can talk"
   :SINGLE
   "MODERATELY accurate / like me"
   "0.857"
   6
   2
   7
   6
   SCORED-NORMAL
   LIKEME7)
  (STUCOMFO
   "sa-Comfortable w/ area fac & students"
   :SINGLE
   "MILDLY accurate / like me"
   "0.714"
   5
   3
   7
   5
   SCORED-NORMAL
   LIKEME7)
  (STUFRIEN
   "sa-Current school friends"
   :SINGLE
   "MODERATELY accurate / like me"
   "0.857"
   6
   4
   7
   6
   SCORED-NORMAL
   LIKEME7)
  (STUENJOY
   "sa-Enjoy learning, classes, homework"
   :SINGLE
   "MODERATELY accurate / like me"
   "0.857"
   6
   5
   7
   6
   SCORED-NORMAL
   LIKEME7)
  (STUEACTR
   "sa-Enjoying life and fun in school"
   :SINGLE
   "MODERATELY accurate / like me"
   "0.857"
   6
   6
   7
   6
   SCORED-NORMAL
   LIKEME7)
  (STHAPCOL
   "sa-Overall college exper happiness"
   :SINGLE
   "MODERATELY accurate / like me"
   "0.857"
   6
   7
   7
   6
   SCORED-NORMAL
   LIKEME7)
  (STHAPGPA
   "sa-Happiness with grades"
   :SINGLE
   "MODERATELY accurate / like me"
   "0.857"
   6
   8
   7
   6
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  SSL3WRITEREADSKILLS
  (LRNWRPAP
   "la-A's on term papers"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   1
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (LRNWRSKL
   "la-Satisfied with writing skills"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   2
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (LRNSEE
   "la-No vision problems"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   3
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (LRNVOCAB
   "la-No vocabulary problems reading"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   4
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (LRNWRORG
   "la-Organizing writing good"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   5
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (LRNSREAD
   "la-Not read slower"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   6
   7
   1
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  SSL4BLDMENTALSTRUCT
  (LRNTXUND
   "lh-Stop to understand readings"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   1
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (LRNINTER
   "lh-If text boring, make interesting"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   2
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (LRNROTE
   "lh-New view--not rote methods"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   3
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (LRNASSOC
   "lh-Try to create associations"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   4
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (LRNSTRUG
   "lh-Struggle with difficult material"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   5
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (LRNTHEOR
   "lh-Build own theories"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   6
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (LRNALONE
   "lh-Study alone-minimal help"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   7
   7
   7
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  SSL5BASICSTUDYSKILLS
  (ACMCONCE
   "am-Great task-HW concentration"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   1
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (LRNTXOVE
   "lh-Prevew, points, review chapters"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   2
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (LRNTSREV
   "lh-Review 3 times before exam"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   3
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (LRNMAP
   "lh-Create visual map of readings"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   4
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (LRNTXOUT
   "la-Outline textbooks"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   5
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (LRNNOTES
   "la-Good class notes"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   6
   7
   7
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  SSL6SELFMANACADGOALS
  (ACMCOMPL
   "am-Confident will complete degree"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   1
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (ACMQUITC
   "am-Won't drop out in year"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   2
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (ACMFINAN
   "am-Confidence school finances"
   :SINGLE
   "Extremely confident"
   "1.000"
   7
   3
   7
   7
   SCORED-NORMAL
   CONFIDENCE7)
  (ACMDEGRE
   "am-Motivation for degree"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   4
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (STUCONFU
   "sa-NotConfused why I am in college"
   :SINGLE
   "EXTREMELY accurate / like me"
   "0.143"
   1
   5
   7
   1
   SCORED-REVERSE
   LIKEME7REVERSE)
  (ACMSELFS
   "am-Self-manage college life well"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   6
   7
   7
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  SSL7MATHSCIPRINC
  (LRNMATH
   "la-Enjoy & good at math"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   1
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (LRNTEXTN
   "lh-Math science seek basic principles"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   2
   7
   7
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  SSL8STUDYENVIR
  (ACMEFAML
   "am-HW encouraged by fam & friends"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   1
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (ACMESOCS
   "am-No chores if conflict w HW"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   2
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (LRNESTUD
   "lh-Good study place w/o distract"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   3
   7
   7
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  SSL9ATTENDHW
  (ACMSTUDY
   "Study time per class hour"
   :SINGLE
   "1 to 2 hours per class hour"
   "0.500"
   3
   1
   6
   3
   SCORED-NORMAL
   ACMSTUDYANSARRAY)
  (ACMNDROP
   "am-Never drop or take incomplete"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   2
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (ACMATTEN
   "am-Attendance & do homework"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   3
   7
   7
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  SSL10MEMNOTANX
  (LRNMEMOR
   "la-Memory for terms,formulas,facts"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   1
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (LRNTENSE
   "la-Rarely tense in exams"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   2
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (LRNSEFIC
   "la-Learning time efficient"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   3
   7
   7
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  SSL11NOTNONACADMOT
  (STUEXTMO
   "sa-NotParents expectations main motive"
   :SINGLE
   "MILDLY inaccurate / unlike me"
   "0.714"
   5
   1
   7
   5
   SCORED-REVERSE
   LIKEME7REVERSE)
  (STUMONEYNEW
   "sa-Money main motive"
   :SINGLE
   "MILDLY accurate / like me"
   "0.714"
   5
   2
   7
   5
   SCORED-NORMAL
   LIKEME7)
  (STUCONFU
   "sa-NotConfused why I am in college"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "1.000"
   7
   3
   7
   7
   SCORED-REVERSE
   LIKEME7REVERSE)
  (STUFINDE
   "sa-Financial support"
   :SINGLE
   "Family support and work"
   "0.500"
   3
   4
   6
   3
   SCORED-NORMAL
   STUFINDEPEND)
  (STUCAREE
   "sa-Career-job main motive"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   5
   7
   7
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  SSL12STDYTMAVAIL
  (ACMTIME
   "am-Time available to study"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "1.000"
   7
   1
   7
   7
   SCORED-REVERSE
   LIKEME7REVERSE)
  :SCALE
  SSL13VERBALAPT
  (STUVERBA
   "st-Verbal aptitude scores"
   :SINGLE
   "Greater than 90 percent"
   "1.000"
   10
   1
   10
   10
   SCORED-NORMAL
   PERCENTILE10)
  :SCALE
  SSL14MATHAPT
  (STUMATHA
   "st-Math aptitude scores"
   :SINGLE
   "Greater than 90 percent"
   "1.000"
   10
   1
   10
   10
   SCORED-NORMAL
   PERCENTILE10)
  :SCALE
  SINCAR
  (CAR1CARG
   "ca-Great time and thorough career plan process"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   1
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (CAR1CARP
   "ca-Have goal,plan,likely success"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   2
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (CAR1INAT
   "ca-Natural science"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   3
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (CARIBIOH
   "ca-Biological science"
   :SINGLE
   "UNCERTAIN, neutral, or midpoint"
   "0.571"
   4
   4
   7
   4
   SCORED-NORMAL
   LIKEME7)
  (CARISOCS
   "ca-Learn about self & people"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   5
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (CARIHELP
   "ca-Helping people-teach coun etc"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   6
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (CARIMATH
   "ca-Math"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   7
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (CARIMED
   "ca-Medical-related"
   :SINGLE
   "MILDLY accurate / like me"
   "0.714"
   5
   8
   7
   5
   SCORED-NORMAL
   LIKEME7)
  (CARIWRIT
   "ca-Writing-related"
   :SINGLE
   "MODERATELY inaccurate / unlike me"
   "0.286"
   2
   9
   7
   2
   SCORED-NORMAL
   LIKEME7)
  (CARIFNAR
   "ca-Fine art-related"
   :SINGLE
   "MODERATELY inaccurate / unlike me"
   "0.286"
   2
   10
   7
   2
   SCORED-NORMAL
   LIKEME7)
  (CARIETHN
   "ca-Ethnic studies-women"
   :SINGLE
   "MODERATELY inaccurate / unlike me"
   "0.286"
   2
   11
   7
   2
   SCORED-NORMAL
   LIKEME7)
  (CARILEAR
   "ca-Love higher ed"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   12
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (CARIEXPE
   "ca-Want to be expert"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   13
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (CARIGENE
   "ca-Love variety-know little about many"
   :SINGLE
   "MODERATELY accurate / like me"
   "0.857"
   6
   14
   7
   6
   SCORED-NORMAL
   LIKEME7)
  (CARINOIN
   "ca-Never interest in school"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   15
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARILIT
   "ca-Literature-history"
   :SINGLE
   "MODERATELY inaccurate / unlike me"
   "0.286"
   2
   16
   7
   2
   SCORED-NORMAL
   LIKEME7)
  (CARIRECP
   "ca-Sports-rec helping others w/sports"
   :SINGLE
   "MODERATELY inaccurate / unlike me"
   "0.286"
   2
   17
   7
   2
   SCORED-NORMAL
   LIKEME7)
  (CARIPOLI
   "ca-Law politics government"
   :SINGLE
   "MILDLY inaccurate / unlike me"
   "0.429"
   3
   18
   7
   3
   SCORED-NORMAL
   LIKEME7)
  (CARIMIL6
   "ca-Law enforcement military etc"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   19
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARIMANU
   "ca-Manual-tech electr computers etc-"
   :SINGLE
   "MODERATELY accurate / like me"
   "0.857"
   6
   20
   7
   6
   SCORED-NORMAL
   LIKEME7)
  (CARILANG
   "ca-Languages travel etc"
   :SINGLE
   "MILDLY inaccurate / unlike me"
   "0.429"
   3
   21
   7
   3
   SCORED-NORMAL
   LIKEME7)
  (CARIPHIL
   "ca-Philosophy-religion"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   22
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (CARIBUSI
   "ca-Business"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   23
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARIENGI
   "ca-Engineering sci design"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   24
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (CARIFAMC
   "ca-Family & Consumer Sci"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   25
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARIWOMA
   "ca-Ethnic-women"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   26
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARICOM8
   "ca-Computer-related"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   27
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (CARINTE0
   "ca-Interdisciplinary"
   :SINGLE
   "MODERATELY accurate / like me"
   "0.857"
   6
   28
   7
   6
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  SINBUS
  (CARIBMAR
   "cb-Marketing"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   1
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARIBMAN
   "cb-Management"
   :SINGLE
   "MILDLY accurate / like me"
   "0.714"
   5
   2
   7
   5
   SCORED-NORMAL
   LIKEME7)
  (CARIBINF
   "cb-Inform Systems"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   3
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (CARIBFIN
   "cb-Finance"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   4
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARIBHRD
   "cb-Human Resources"
   :SINGLE
   "MILDLY inaccurate / unlike me"
   "0.429"
   3
   5
   7
   3
   SCORED-NORMAL
   LIKEME7)
  (CARIBACC
   "cb-Accounting"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   6
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARISPBU
   "cb-Public Relations"
   :SINGLE
   "MILDLY accurate / like me"
   "0.714"
   5
   7
   7
   5
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  SINENGR
  (CARIEENG
   "ce-Elect Engr"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   1
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (CARIME
   "ce-Mech Engr"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   2
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (CARICHE2
   "ce-Chem Engr"
   :SINGLE
   "MODERATELY inaccurate / unlike me"
   "0.286"
   2
   3
   7
   2
   SCORED-NORMAL
   LIKEME7)
  (CARICIVE
   "ce-Cival Engr"
   :SINGLE
   "MILDLY accurate / like me"
   "0.714"
   5
   4
   7
   5
   SCORED-NORMAL
   LIKEME7)
  (CARIAERO
   "ce-Aerospace Engr"
   :SINGLE
   "MILDLY inaccurate / unlike me"
   "0.429"
   3
   5
   7
   3
   SCORED-NORMAL
   LIKEME7)
  (CARIEITE
   "ce-Engr Tech"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   6
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARICOM9
   "ce-Computer Engr"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   7
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (CARIBCOM
   "ce-Bus Computer"
   :SINGLE
   "MODERATELY inaccurate / unlike me"
   "0.286"
   2
   8
   7
   2
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  SINFINEA
  (CARIMUSI
   "cart-Music"
   :SINGLE
   "MODERATELY inaccurate / unlike me"
   "0.286"
   2
   1
   7
   2
   SCORED-NORMAL
   LIKEME7)
  (CARIART
   "cart-Art"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   2
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARIDRAM
   "cart-Theatre Arts"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   3
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARIDANC
   "cart-Dance"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   4
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARIPHOT
   "cart-Photog or Ph Journ"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   5
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARINDDE
   "cart-Indust Design"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   6
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARINTE1
   "cart-Interior Design"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   7
   7
   1
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  SINHELP
  (CARITEAC
   "ch-Teaching"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   1
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (CARICOUN
   "ch-Counseling"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   2
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (CARIEDUC
   "ch-Education"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   3
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (CARIHADU
   "ch-Help Adults"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   4
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (CARIHCHI
   "ch-Help children-teens"
   :SINGLE
   "MODERATELY inaccurate / unlike me"
   "0.286"
   2
   5
   7
   2
   SCORED-NORMAL
   LIKEME7)
  (CARITVOC
   "ch-Voc Ed"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   6
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARICOM4
   "ch-Speech-hearing"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   7
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARSOCWO
   "ch-Social Work"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   8
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARK12TE
   "ch-Teach K-12"
   :SINGLE
   "MILDLY inaccurate / unlike me"
   "0.429"
   3
   9
   7
   3
   SCORED-NORMAL
   LIKEME7)
  (CARMINIS
   "ch-Minister-priest"
   :SINGLE
   "MODERATELY accurate / like me"
   "0.857"
   6
   10
   7
   6
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  SINLANG
  (CARIFREN
   "cl-French"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   1
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARIITAL
   "cl-Italian"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   2
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARIGERM
   "cl-German"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   3
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARIRUSS
   "cl-Russian"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   4
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARIJAPN
   "cl-Japanese"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   5
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARICHIN
   "cl-Chinese"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   6
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARICLAS
   "cl-Classic Lang"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   7
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARISPAN
   "cl-Spanish"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   8
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARIPOR
   "cl-Portugese"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   9
   7
   1
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  SINMED
  (CARIMD
   "cm-Physician"
   :SINGLE
   "MILDLY inaccurate / unlike me"
   "0.429"
   3
   1
   7
   3
   SCORED-NORMAL
   LIKEME7)
  (CARINURS
   "cm-Nurse"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   2
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARIPTHE
   "cm-Phys Therapy"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   3
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARIHEAL
   "cm-Health Science"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   4
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARIKINE
   "cm-Kinesiology"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   5
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARICOM5
   "cm-Commicative Dis"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   6
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARMEDTE
   "cm-Med Tech/imaging"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   7
   7
   1
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  SINMILTC
  (CARILAW
   "cleg-Law"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   1
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARICRIM
   "cleg-Law enforcement"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   2
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARIMIL7
   "cleg-Military"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   3
   7
   1
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  INNATSCI
  (CARICHE3
   "cn-Chemistry"
   :SINGLE
   "MODERATELY inaccurate / unlike me"
   "0.286"
   2
   1
   7
   2
   SCORED-NORMAL
   LIKEME7)
  (CARIPHYS
   "cn-Physics"
   :SINGLE
   "MILDLY accurate / like me"
   "0.714"
   5
   2
   7
   5
   SCORED-NORMAL
   LIKEME7)
  (CARIGEOL
   "cn-Geology"
   :SINGLE
   "MODERATELY inaccurate / unlike me"
   "0.286"
   2
   3
   7
   2
   SCORED-NORMAL
   LIKEME7)
  (CARIASTR
   "cn-Astronomy"
   :SINGLE
   "MODERATELY inaccurate / unlike me"
   "0.286"
   2
   4
   7
   2
   SCORED-NORMAL
   LIKEME7)
  (CARIENVI
   "cn-Environmental Sci"
   :SINGLE
   "MODERATELY inaccurate / unlike me"
   "0.286"
   2
   5
   7
   2
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  SINSOCSC
  (CARIPSYC
   "cs-Psychology"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   1
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (CARISOCO
   "cs-Sociology"
   :SINGLE
   "MODERATELY accurate / like me"
   "0.857"
   6
   2
   7
   6
   SCORED-NORMAL
   LIKEME7)
  (CARIHIST
   "cs-History"
   :SINGLE
   "MILDLY inaccurate / unlike me"
   "0.429"
   3
   3
   7
   3
   SCORED-NORMAL
   LIKEME7)
  (CARIPOLS
   "cs-Political Science"
   :SINGLE
   "UNCERTAIN, neutral, or midpoint"
   "0.571"
   4
   4
   7
   4
   SCORED-NORMAL
   LIKEME7)
  (CARIECON
   "cs-Economics"
   :SINGLE
   "MILDLY inaccurate / unlike me"
   "0.429"
   3
   5
   7
   3
   SCORED-NORMAL
   LIKEME7)
  (CARGEOGR
   "cs-Geography"
   :SINGLE
   "MODERATELY inaccurate / unlike me"
   "0.286"
   2
   6
   7
   2
   SCORED-NORMAL
   LIKEME7)
  (CARIAMER
   "cs-American Studies"
   :SINGLE
   "MODERATELY inaccurate / unlike me"
   "0.286"
   2
   7
   7
   2
   SCORED-NORMAL
   LIKEME7)
  (CARIANTR
   "cs-Anthropology???-AntR not AntH"
   :SINGLE
   "MODERATELY inaccurate / unlike me"
   "0.286"
   2
   8
   7
   2
   SCORED-NORMAL
   LIKEME7)
  (CARIANTH
   "cs-Anthropology"
   :SINGLE
   "MODERATELY inaccurate / unlike me"
   "0.286"
   2
   9
   7
   2
   SCORED-NORMAL
   LIKEME7)
  (CARISPEE
   "cs-Speech-Commun"
   :SINGLE
   "MODERATELY inaccurate / unlike me"
   "0.286"
   2
   10
   7
   2
   SCORED-NORMAL
   LIKEME7)
  (CARLING
   "cs-Linguistics"
   :SINGLE
   "MODERATELY inaccurate / unlike me"
   "0.286"
   2
   11
   7
   2
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  SINWOETH
  (CARIAIST
   "cs-Native Amer Studies"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   1
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARIBSTU
   "cs-African Amer Studies"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   2
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARIMEXA
   "cs-Mexican Amer Studies"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   3
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARIASAM
   "cs-Asian Amer Studies"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   4
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARIAMST
   "cs-American Studies"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   5
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARIWSTU
   "cs-Women's Studies"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   6
   7
   1
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  SINWRITE
  (CARIENGL
   "cw-English"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   1
   7
   1
   SCORED-NORMAL
   LIKEME7)
  (CARIJOUR
   "cw-Journalism"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "0.143"
   1
   2
   7
   1
   SCORED-NORMAL
   LIKEME7)
  :SCALE
  NO-SCALE
  (BIO5INCO
   "b-Highest personal income"
   :SINGLE
   "$150,000 to $200,000"
   "0.909"
   10
   1
   11
   10
   SCORED-NORMAL
   BIO5INCOANSARRAY)
  :SCALE
  SEHAPPY
  (HAPCLFRN
   "h-Happy w/ number & closeness of friends"
   :SINGLE
   "Extremely happy"
   "1.000"
   7
   1
   7
   7
   SCORED-NORMAL
   HAPPY7)
  (HAPCARNW
   "h-Happy w/ my career now"
   :SINGLE
   "Extremely happy"
   "1.000"
   7
   2
   7
   7
   SCORED-NORMAL
   HAPPY7)
  (HAPCARFU
   "h-Happy w/ future career expectations"
   :SINGLE
   "Extremely happy"
   "1.000"
   7
   3
   7
   7
   SCORED-NORMAL
   HAPPY7)
  (HAPFRIEN
   "h-Happy w/ friendships"
   :SINGLE
   "Extremely happy"
   "1.000"
   7
   4
   7
   7
   SCORED-NORMAL
   HAPPY7)
  (HAPAREA
   "h-Happy living in area, home"
   :SINGLE
   "Extremely happy"
   "1.000"
   7
   5
   7
   7
   SCORED-NORMAL
   HAPPY7)
  (HAPWKREL
   "h-Happy w/ work-school relationships"
   :SINGLE
   "Extremely happy"
   "1.000"
   7
   6
   7
   7
   SCORED-NORMAL
   HAPPY7)
  (HAPPE
   "h-Happy w/ physical activity"
   :SINGLE
   "Extremely happy"
   "1.000"
   7
   7
   7
   7
   SCORED-NORMAL
   HAPPY7)
  (HAPRECRE
   "h-Happy w/ recreation"
   :SINGLE
   "Extremely happy"
   "1.000"
   7
   8
   7
   7
   SCORED-NORMAL
   HAPPY7)
  (HAPSEXRE
   "h-Happy w/ sex/romance"
   :SINGLE
   "Extremely happy"
   "1.000"
   7
   9
   7
   7
   SCORED-NORMAL
   HAPPY7)
  (HAPFAMIL
   "h-Happy w/ family relationships"
   :SINGLE
   "Extremely happy"
   "1.000"
   7
   10
   7
   7
   SCORED-NORMAL
   HAPPY7)
  (HAPSELFD
   "h-Happy w/ self & development"
   :SINGLE
   "Extremely happy"
   "1.000"
   7
   11
   7
   7
   SCORED-NORMAL
   HAPPY7)
  (HAPSPIRI
   "h-Happy w/ meaning & spiritual/religious"
   :SINGLE
   "Extremely happy"
   "1.000"
   7
   12
   7
   7
   SCORED-NORMAL
   HAPPY7)
  (HAPYEAR
   "h-Happiness during past year"
   :SINGLE
   "Extremely happy"
   "1.000"
   7
   13
   7
   7
   SCORED-NORMAL
   HAPPY7)
  (HAP3YEAR
   "h-Happiness 1-3 years ago"
   :SINGLE
   "Extremely happy"
   "1.000"
   7
   14
   7
   7
   SCORED-NORMAL
   HAPPY7)
  (HAPLIFE
   "h-Happiness up to 3 years ago"
   :SINGLE
   "Extremely happy"
   "1.000"
   7
   15
   7
   7
   SCORED-NORMAL
   HAPPY7)
  (HAPEXPEC
   "h-Happiness expected in future"
   :SINGLE
   "Extremely happy"
   "1.000"
   7
   16
   7
   7
   SCORED-NORMAL
   HAPPY7)
  :SCALE
  SRDEPRES
  (RDEPFEEL
   "de-Not often sad,apathetic,depressed"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "1.000"
   7
   1
   7
   7
   SCORED-REVERSE
   LIKEME7REVERSE)
  (RDEPTHOU
   "de-Not worthless, very neg a-death,etc"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "1.000"
   7
   2
   7
   7
   SCORED-REVERSE
   LIKEME7REVERSE)
  (RDEPDYSS
   "de-RevDysthemia symptoms checklist"
   :SINGLE
   "Never/Not at all"
   "1.000"
   11
   3
   11
   11
   SCORED-REVERSE
   DURATION11REVERSE)
  (RDEPMAJS
   "de-RevMajor depression symptoms chkl"
   :SINGLE
   "Never/None"
   "1.000"
   9
   4
   9
   9
   SCORED-REVERSE
   EPISODEFREQ9REVERSE)
  (RDEPMEDS
   "de-RevLength of time meds for depression"
   :SINGLE
   "Never/Not at all"
   "1.000"
   11
   5
   11
   11
   SCORED-REVERSE
   DURATION11REVERSE)
  (RDEPTHER
   "de-RevAmount of therapy for depression"
   :SINGLE
   "Never/None"
   "1.000"
   9
   6
   9
   9
   SCORED-REVERSE
   EPISODEFREQ9REVERSE)
  :SCALE
  SRANXIET
  (RANXPERF
   "ax-RevPerformance anxiety level"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "1.000"
   7
   1
   7
   7
   SCORED-REVERSE
   LIKEME7REVERSE)
  (RANXALLT
   "ax-Not feel anxious almost all time"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "1.000"
   7
   2
   7
   7
   SCORED-REVERSE
   LIKEME7REVERSE)
  (RANXPSTD
   "ax-RevPSTD symptoms chkl"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "1.000"
   7
   3
   7
   7
   SCORED-REVERSE
   LIKEME7REVERSE)
  (RANXSOCI
   "ax-RevAnxiety with other people"
   :SINGLE
   "EXTREMELY inaccurate / unlike me"
   "1.000"
   7
   4
   7
   7
   SCORED-REVERSE
   LIKEME7REVERSE)
  (RANXOCD
   "ax-RevTimes lasting OCD problems"
   :SINGLE
   "Never/None"
   "1.000"
   9
   5
   9
   9
   SCORED-REVERSE
   EPISODEFREQ9REVERSE)
  (RANXPHOB
   "ax-RevNumber of phobias"
   :SINGLE
   "0"
   "1.000"
   13
   6
   13
   13
   SCORED-REVERSE
   NUMBERTO12REVERSE)
  (RANXPANI
   "ax-RevNumber of panic attacks"
   :SINGLE
   "0"
   "1.000"
   13
   7
   13
   13
   SCORED-REVERSE
   NUMBERTO12REVERSE)
  (RANXTHER
   "ax-Amount of therapy for anxiety"
   :SINGLE
   "Never/None"
   "1.000"
   9
   8
   9
   9
   SCORED-REVERSE
   EPISODEFREQ9REVERSE)
  (RANXMEDS
   "ax-RevTime meds for anxiety DEPRESSION?"
   :SINGLE
   "Never/Not at all"
   "1.000"
   11
   9
   11
   11
   SCORED-REVERSE
   DURATION11REVERSE)
  :SCALE
  SRANGAGG
  (RANGFEEL
   "ag-RevFreq lose temper"
   :SINGLE
   "1 to 5 per month"
   "0.625"
   5
   1
   8
   5
   SCORED-REVERSE
   FREQ8REVERSE)
  (RANGYELL
   "ag-RevFreq yell or call hurtful names"
   :SINGLE
   "Less than 1 per month"
   "0.750"
   6
   2
   8
   6
   SCORED-REVERSE
   FREQ8REVERSE)
  (RANGDOMI
   "ag-RevFreq get way by [aggression]"
   :SINGLE
   "Less than 1 per month"
   "0.750"
   6
   3
   8
   6
   SCORED-REVERSE
   FREQ8REVERSE)
  (RANGTHOU
   "ag-RevFreq think about get even"
   :SINGLE
   "Less than 1 per month"
   "0.750"
   6
   4
   8
   6
   SCORED-REVERSE
   FREQ8REVERSE)
  (RANGDEST
   "ag-RevFreq damage prop etc/break law"
   :SINGLE
   "Never/None"
   "1.000"
   8
   5
   8
   8
   SCORED-REVERSE
   FREQ8REVERSE)
  :SCALE
  SRELHLTH
  (RHLFREQI
   "he-LoFreq of illness past 3 years"
   :SINGLE
   "About 1-3 per year"
   "0.857"
   6
   1
   7
   6
   SCORED-REVERSE
   FREQ7REVERSE)
  (RHLALCOH
   "he-LoFreq of alcohol drinks"
   :SINGLE
   "1-6 per week"
   "0.500"
   4
   2
   8
   4
   SCORED-REVERSE
   FREQ8REVERSE)
  (RHLSMOKE
   "he-LoFreq of cigarrettes"
   :SINGLE
   "Never/None"
   "1.000"
   8
   3
   8
   8
   SCORED-REVERSE
   FREQ8REVERSE)
  (RHLDRUGS
   "he-LoFreq of illegal drugs"
   :SINGLE
   "Never/None"
   "1.000"
   8
   4
   8
   8
   SCORED-REVERSE
   FREQ8REVERSE)
  (RHLPHYSI
   "he-Physical conditioning level"
   :SINGLE
   "Excellent for competitive athlete"
   "1.000"
   9
   5
   9
   9
   SCORED-NORMAL
   RHLPHYSIANSARRAY)
  (RHLWEIGH
   "he-LoWeight"
   :SINGLE
   "Ideal for my height"
   "1.000"
   10
   6
   10
   10
   SCORED-NORMAL
   RHLWEIGHANSARRAY)
  :SCALE
  SRPEOPLE
  (RPEHAPFR
   "re-Friends happy-successful"
   :SINGLE
   "EXTREMELY accurate / like me"
   "1.000"
   7
   1
   7
   7
   SCORED-NORMAL
   LIKEME7)
  (RPEHMARR
   "re-Have or had happy marital rel"
   :SINGLE
   "EXTREMELY agree"
   "1.000"
   8
   2
   8
   8
   SCORED-NORMAL
   LIKEME8NOTAPPLY)
  (RPENETW
   "re-Close network of friends & career-rel"
   :SINGLE
   "MODERATELY accurate / like me"
   "0.857"
   6
   3
   7
   6
   SCORED-NORMAL
   LIKEME7)
  (RPECLFRN
   "re-Have/had friends share innermost"
   :SINGLE
   "MODERATELY accurate / like me"
   "0.857"
   6
   4
   7
   6
   SCORED-NORMAL
   LIKEME7)
  (RPENUMFR
   "re-Number friends socialize 1/month"
   :SINGLE
   "3-4"
   "0.250"
   3
   5
   12
   3
   SCORED-NORMAL
   NUMBERBY2)
  (RPENUMCL
   "re-Number extremely close friends"
   :SINGLE
   "7-8"
   "0.417"
   5
   6
   12
   5
   SCORED-NORMAL
   NUMBERBY2)
  (RPECOMMI
   "re-Degree of commit to 3 mo romantic"
   :SINGLE
   "Married--extremely high commitment"
   "1.000"
   13
   7
   13
   13
   SCORED-NORMAL
   RPECOMMITANSARRAY)
  :SCALE
  SUSERFEEDBACK
  (USERRATE
   "UserRate"
   :SINGLE
   "Very interesting/beneficial"
   "1.000"
   7
   1
   7
   7
   SCORED-NORMAL
   USERRATE7)
  :DATE
  "3.3.2020"
  :TIME
  "12:14")
;;XXX SHAQ-SCALEDATA-LIST
 (:SHAQ-SCALEDATA-LIST
  (:TEXT-DATA
   "sID"
   ("UserID" "555555" :SINGLE "555555")
   ("Sex" "Male" :SINGLE "Male" 1)
   ("Age" 78 :SINGLE 78 78)
   ("USA?" "USA" :SINGLE "USA" 1)
   ("Nation" "USA" :SINGLE "USA")
   ("ZipCode" 92260 :SINGLE 92260)
   ("HrsWork" 78 :SINGLE 78 78))
  :MULTI-SEL-QUEST
  "utype"
  ("UTYPE"
   :MULTI
   "utype"
   "UserType"
   1
   ("twanttho" "1" 1 T 1 1 (:XDATA :SCALES (HQ)))
   ("tknowmor" "2" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("twanthel" "3" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("twantspe" "4" 1 NIL 0 1 (:XDATA :SCALES NIL))
   ("texperie" "5" 1 NIL 0 1 (:XDATA :SCALES NIL))
   ("tprevshaq" "6" 1 NIL 0 1 (:XDATA :SCALES (PREVIOUS-USER)))
   ("wantspq" "7" 1 NIL 0 1 (:XDATA :SCALES (SPECIFIC-QUESTS)))
   ("tu100stu" "8" 1 NIL 0 1 (:XDATA :SCALES (HQ ACAD-LEARNING)))
   ("tcsulbst" "9" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING)))
   ("tcolstu" "10" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING)))
   ("totherst" "11" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING)))
   ("tressub" "12" 1 NIL 0 1 (:XDATA :SCALES NIL))
   ("tcolfaca" "13" 1 NIL 0 1 (:XDATA :SCALES NIL))
   ("u-none" "14" 1 NIL 0 1 (:XDATA :SCALES NIL)))
  :MULTI-SEL-QUEST
  "ugoals"
  ("UGOALS"
   :MULTI
   "ugoals"
   "UserGoals"
   1
   ("gsuchap" "1" 1 T 1 1 (:XDATA :SCALES (HQ)))
   ("gemocop" "2" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("gslfest"
    "3"
    1
    NIL
    0
    1
    (:XDATA :SCALES (VALUES-THEMES BELIEFS SKILLS-CONFIDENCE)))
   ("gprocrst"
    "4"
    1
    NIL
    0
    1
    (:XDATA :SCALES (VALUES-THEMES "siecontr" "sselfman" "semotcop")))
   ("gtimeman" "5" 1 NIL 0 1 (:XDATA :SCALES ("sselfman" "semotcop")))
   ("grelat" "6" 1 NIL 0 1 (:XDATA :SCALES (INTERPERSONAL)))
   ("gmeetpeo" "7" 1 NIL 0 1 (:XDATA :SCALES (INTERPERSONAL)))
   ("glonelyf" "8" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("gexvalus" "9" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("gdepres" "10" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("ganxfear" "11" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("gaggrang" "12" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("gacadsuc" "13" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING)))
   ("gcomplta1"
    "14"
    1
    T
    1
    1
    (:XDATA :SCALES (HQ ACAD-LEARNING CAREER-INTEREST)))
   ("gcompltanomaj" "15" 1 NIL 0 1 (:XDATA :SCALES (HQ ACAD-LEARNING)))
   ("gcompltanoac" "16" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("gAcadOnly" "17" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING)))
   ("gcarplan" "18" 1 NIL 0 1 (:XDATA :SCALES (CAREER-INTEREST)))
   ("gcaronly" "19" 1 NIL 0 1 (:XDATA :SCALES (CAREER-INTEREST)))
   ("gnottake" "20" 1 NIL 0 1 (:XDATA :SCALES NIL)))
  :MULTI-SEL-QUEST
  "bio4job"
  (BIO4JOB
   :MULTI
   "bio4job"
   "b-Primary occupation"
   1
   ("student" "1" 1 NIL 0 1 NIL)
   ("manager" "2" 1 NIL 0 1 NIL)
   ("propeop" "3" 1 T 1 1 NIL)
   ("protech" "4" 1 NIL 0 1 NIL)
   ("consulta" "5" 1 NIL 0 1 NIL)
   ("educator" "6" 1 T 1 1 NIL)
   ("sales" "7" 1 NIL 0 1 NIL)
   ("technici" "8" 1 NIL 0 1 NIL)
   ("clerical" "9" 1 NIL 0 1 NIL)
   ("service" "10" 1 NIL 0 1 NIL)
   ("ownbus10" "11" 1 NIL 0 1 NIL)
   ("othrsfem" "12" 1 NIL 0 1 NIL)
   ("other" "13" 1 NIL 0 1 NIL))
  :MULTI-SEL-QUEST
  "bio7lang"
  (BIO7LANG
   :MULTI
   "bio7lang"
   "b-Fluent languages"
   2
   ("lenglish" "1" 1 T 1 2 NIL)
   ("lspanish" "2" 1 NIL 0 2 NIL)
   ("lvietnam" "3" 1 NIL 0 2 NIL)
   ("lcambodn" "4" 1 NIL 0 2 NIL)
   ("lchinese" "5" 1 NIL 0 2 NIL)
   ("lkorean" "6" 1 NIL 0 2 NIL)
   ("lportugu" "7" 1 NIL 0 2 NIL)
   ("lgerman" "8" 1 NIL 0 2 NIL)
   ("lfrench" "9" 1 NIL 0 2 NIL)
   ("lmideast" "10" 1 NIL 0 2 NIL)
   ("lothrasn" "11" 1 NIL 0 2 NIL)
   ("lothreur" "12" 1 NIL 0 2 NIL)
   ("lother" "13" 1 NIL 0 2 NIL))
  :MULTI-SEL-QUEST
  "bio1ethn"
  (BIO1ETHN
   :MULTI
   "bio1ethn"
   "Primary Ethnic Group"
   3
   ("enortham" "1" 1 T 1 3 NIL)
   ("eafrica" "2" 1 NIL 0 3 NIL)
   ("enoreur" "3" 1 NIL 0 3 NIL)
   ("esoueur" "4" 1 NIL 0 3 NIL)
   ("mideast" "5" 1 NIL 0 3 NIL)
   ("ecambodn" "6" 1 NIL 0 3 NIL)
   ("echina" "7" 1 NIL 0 3 NIL)
   ("ekorea" "8" 1 NIL 0 3 NIL)
   ("ejapan" "9" 1 NIL 0 3 NIL)
   ("evietnam" "10" 1 NIL 0 3 NIL)
   ("eothrasn" "11" 1 NIL 0 3 NIL)
   ("emexico" "12" 1 NIL 0 3 NIL)
   ("ecentram" "13" 1 NIL 0 3 NIL)
   ("esoutham" "14" 1 NIL 0 3 NIL)
   ("epacific" "15" 1 NIL 0 3 NIL)
   ("eother" "16" 1 NIL 0 3 NIL))
  :MULTI-SEL-QUEST
  "biorelaf"
  (BIORELAF
   :MULTI
   "biorelaf"
   "bioRelAffiliation"
   4
   ("catholic" "1" 1 NIL 0 4 NIL)
   ("jewish" "2" 1 NIL 0 4 NIL)
   ("latterd" "3" 1 NIL 0 4 NIL)
   ("buddhist" "4" 1 NIL 0 4 NIL)
   ("islam" "5" 1 NIL 0 4 NIL)
   ("baptist" "6" 1 NIL 0 4 NIL)
   ("methodst" "7" 1 T 1 4 NIL)
   ("episcop" "8" 1 NIL 0 4 NIL)
   ("lutheran" "9" 1 NIL 0 4 NIL)
   ("presbyte" "10" 1 NIL 0 4 NIL)
   ("proliber" "11" 1 NIL 0 4 NIL)
   ("profunda" "12" 1 NIL 0 4 NIL)
   ("noaffil" "13" 1 NIL 0 4 NIL)
   ("agnostic" "14" 1 NIL 0 4 NIL)
   ("othrnoan" "15" 1 NIL 0 4 NIL))
  :MULTI-SEL-QUEST
  "stucolle"
  (STUCOLLE
   :MULTI
   "stucolle"
   "st-College attending"
   7
   ("cocsulb" "1" 1 NIL 0 7 NIL)
   ("cccsu" "2" 1 NIL 0 7 NIL)
   ("coucal" "3" 1 NIL 0 7 NIL)
   ("coopublc" "4" 1 NIL 0 7 NIL)
   ("coprivca" "5" 1 NIL 0 7 NIL)
   ("coprivot" "6" 1 NIL 0 7 NIL)
   ("cocacomc" "7" 1 NIL 0 7 NIL)
   ("coothcc" "8" 1 NIL 0 7 NIL)
   ("coothnat" "9" 1 NIL 0 7 NIL)
   ("coprgrad" "10" 1 NIL 0 7 NIL)
   ("cotech" "11" 1 NIL 0 7 NIL)
   ("highsch" "12" 1 NIL 0 7 NIL)
   ("coother" "13" 1 T 1 7 NIL))
  :MULTI-SEL-QUEST
  "stumajor"
  (STUMAJOR
   :MULTI
   "stumajor"
   "st-Major study area"
   8
   ("mlibart" "1" 1 NIL 0 8 NIL)
   ("msocsci" "2" 1 T 1 8 NIL)
   ("mbiolsci" "3" 1 NIL 0 8 NIL)
   ("mart" "4" 1 NIL 0 8 NIL)
   ("mnatsci" "5" 1 NIL 0 8 NIL)
   ("mbus" "6" 1 NIL 0 8 NIL)
   ("menginr" "7" 1 T 1 8 NIL)
   ("meducat" "8" 1 NIL 0 8 NIL)
   ("mmedical" "9" 1 NIL 0 8 NIL)
   ("motcompu" "10" 1 NIL 0 8 NIL)
   ("mothtech" "11" 1 NIL 0 8 NIL)
   ("mrecrpe" "12" 1 NIL 0 8 NIL)
   ("mdoesna" "13" 1 NIL 0 8 NIL)
   ("mundecid" "14" 1 NIL 0 8 NIL))
  :MULTI-SEL-QUEST
  "stuspeci"
  (STUSPECI
   :MULTI
   "stuspeci"
   "st-Special status"
   9
   ("strancc" "1" 1 NIL 0 9 NIL)
   ("stran4yr" "2" 1 NIL 0 9 NIL)
   ("sadultre" "3" 1 NIL 0 9 NIL)
   ("seop" "4" 1 NIL 0 9 NIL)
   ("susimmig" "5" 1 NIL 0 9 NIL)
   ("svisa" "6" 1 NIL 0 9 NIL)
   ("shonor" "7" 1 NIL 0 9 NIL)
   ("svisastu" "8" 1 NIL 0 9 NIL)
   ("sdisabld" "9" 1 NIL 0 9 NIL)
   ("soutofst" "10" 1 NIL 0 9 NIL)
   ("smilitar" "11" 1 NIL 0 9 NIL)
   ("sathlete" "12" 1 NIL 0 9 NIL)
   ("snone" "13" 1 T 1 9 NIL))
  :MULTI-SEL-QUEST
  "sturesid"
  (STURESID
   :MULTI
   "sturesid"
   "st-Residence"
   10
   ("rsinwpar" "1" 1 NIL 0 10 NIL)
   ("rsindorm" "2" 1 NIL 0 10 NIL)
   ("rsinwchl" "3" 1 NIL 0 10 NIL)
   ("rsinothr" "4" 1 NIL 0 10 NIL)
   ("rmarwoch" "5" 1 T 1 10 NIL)
   ("rmarwchl" "6" 1 NIL 0 10 NIL)
   ("rmarlike" "7" 1 NIL 0 10 NIL)
   ("rother" "8" 1 NIL 0 10 NIL))
  :MULTI-SEL-QUEST
  "stgpatre"
  (STGPATRE
   :MULTI
   "stgpatre"
   "st-GPA Trends"
   11
   ("trconhi" "1" 1 T 1 11 NIL)
   ("trincryr" "2" 1 NIL 0 11 NIL)
   ("trincyru" "3" 1 NIL 0 11 NIL)
   ("trincyrs" "4" 1 NIL 0 11 NIL)
   ("trgradin" "5" 1 NIL 0 11 NIL)
   ("trconave" "6" 1 NIL 0 11 NIL)
   ("trdecyru" "7" 1 NIL 0 11 NIL)
   ("trdecyr" "8" 1 NIL 0 11 NIL)
   ("trconlow" "9" 1 NIL 0 11 NIL)
   ("trupandd" "10" 1 NIL 0 11 NIL)
   ("trother" "11" 1 NIL 0 11 NIL))
  :MULTI-SEL-QUEST
  "sturesource"
  (STURESOURCE
   :MULTI
   "sturesource"
   "am-All interference factors"
   12
   ("afinanc" "1" 1 NIL 0 12 NIL)
   ("afampres" "2" 1 NIL 0 12 NIL)
   ("afamresp" "3" 1 NIL 0 12 NIL)
   ("aworktim" "4" 1 NIL 0 12 NIL)
   ("awrkpres" "5" 1 NIL 0 12 NIL)
   ("arelprob" "6" 1 NIL 0 12 NIL)
   ("aloneli" "7" 1 NIL 0 12 NIL)
   ("ahomstpl" "8" 1 NIL 0 12 NIL)
   ("aschstpl" "9" 1 NIL 0 12 NIL)
   ("acompavl" "10" 1 NIL 0 12 NIL)
   ("awrngcls" "11" 1 NIL 0 12 NIL)
   ("afacconn" "12" 1 NIL 0 12 NIL)
   ("astuconn" "13" 1 NIL 0 12 NIL)
   ("alowmotv" "14" 1 NIL 0 12 NIL)
   ("atimconf" "15" 1 T 1 12 NIL)
   ("aprocras" "16" 1 NIL 0 12 NIL))
  (:TEXT-DATA
   "sID"
   ("UserID" "555555" :SINGLE "555555")
   ("Sex" "Male" :SINGLE "Male" 1)
   ("Age" 78 :SINGLE 78 78)
   ("USA?" "USA" :SINGLE "USA" 1)
   ("Nation" "USA" :SINGLE "USA")
   ("ZipCode" 92260 :SINGLE 92260)
   ("HrsWork" 78 :SINGLE 78 78))
  ("UTYPE"
   :MULTI
   "utype"
   "UserType"
   1
   ("twanttho" "1" 1 T 1 1 (:XDATA :SCALES (HQ)))
   ("tknowmor" "2" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("twanthel" "3" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("twantspe" "4" 1 NIL 0 1 (:XDATA :SCALES NIL))
   ("texperie" "5" 1 NIL 0 1 (:XDATA :SCALES NIL))
   ("tprevshaq" "6" 1 NIL 0 1 (:XDATA :SCALES (PREVIOUS-USER)))
   ("wantspq" "7" 1 NIL 0 1 (:XDATA :SCALES (SPECIFIC-QUESTS)))
   ("tu100stu" "8" 1 NIL 0 1 (:XDATA :SCALES (HQ ACAD-LEARNING)))
   ("tcsulbst" "9" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING)))
   ("tcolstu" "10" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING)))
   ("totherst" "11" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING)))
   ("tressub" "12" 1 NIL 0 1 (:XDATA :SCALES NIL))
   ("tcolfaca" "13" 1 NIL 0 1 (:XDATA :SCALES NIL))
   ("u-none" "14" 1 NIL 0 1 (:XDATA :SCALES NIL)))
  ("UGOALS"
   :MULTI
   "ugoals"
   "UserGoals"
   1
   ("gsuchap" "1" 1 T 1 1 (:XDATA :SCALES (HQ)))
   ("gemocop" "2" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("gslfest"
    "3"
    1
    NIL
    0
    1
    (:XDATA :SCALES (VALUES-THEMES BELIEFS SKILLS-CONFIDENCE)))
   ("gprocrst"
    "4"
    1
    NIL
    0
    1
    (:XDATA :SCALES (VALUES-THEMES "siecontr" "sselfman" "semotcop")))
   ("gtimeman" "5" 1 NIL 0 1 (:XDATA :SCALES ("sselfman" "semotcop")))
   ("grelat" "6" 1 NIL 0 1 (:XDATA :SCALES (INTERPERSONAL)))
   ("gmeetpeo" "7" 1 NIL 0 1 (:XDATA :SCALES (INTERPERSONAL)))
   ("glonelyf" "8" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("gexvalus" "9" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("gdepres" "10" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("ganxfear" "11" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("gaggrang" "12" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("gacadsuc" "13" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING)))
   ("gcomplta1"
    "14"
    1
    T
    1
    1
    (:XDATA :SCALES (HQ ACAD-LEARNING CAREER-INTEREST)))
   ("gcompltanomaj" "15" 1 NIL 0 1 (:XDATA :SCALES (HQ ACAD-LEARNING)))
   ("gcompltanoac" "16" 1 NIL 0 1 (:XDATA :SCALES (HQ)))
   ("gAcadOnly" "17" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING)))
   ("gcarplan" "18" 1 NIL 0 1 (:XDATA :SCALES (CAREER-INTEREST)))
   ("gcaronly" "19" 1 NIL 0 1 (:XDATA :SCALES (CAREER-INTEREST)))
   ("gnottake" "20" 1 NIL 0 1 (:XDATA :SCALES NIL)))
  (BIO4JOB
   :MULTI
   "bio4job"
   "b-Primary occupation"
   1
   ("student" "1" 1 NIL 0 1 NIL)
   ("manager" "2" 1 NIL 0 1 NIL)
   ("propeop" "3" 1 T 1 1 NIL)
   ("protech" "4" 1 NIL 0 1 NIL)
   ("consulta" "5" 1 NIL 0 1 NIL)
   ("educator" "6" 1 T 1 1 NIL)
   ("sales" "7" 1 NIL 0 1 NIL)
   ("technici" "8" 1 NIL 0 1 NIL)
   ("clerical" "9" 1 NIL 0 1 NIL)
   ("service" "10" 1 NIL 0 1 NIL)
   ("ownbus10" "11" 1 NIL 0 1 NIL)
   ("othrsfem" "12" 1 NIL 0 1 NIL)
   ("other" "13" 1 NIL 0 1 NIL))
  (BIO7LANG
   :MULTI
   "bio7lang"
   "b-Fluent languages"
   2
   ("lenglish" "1" 1 T 1 2 NIL)
   ("lspanish" "2" 1 NIL 0 2 NIL)
   ("lvietnam" "3" 1 NIL 0 2 NIL)
   ("lcambodn" "4" 1 NIL 0 2 NIL)
   ("lchinese" "5" 1 NIL 0 2 NIL)
   ("lkorean" "6" 1 NIL 0 2 NIL)
   ("lportugu" "7" 1 NIL 0 2 NIL)
   ("lgerman" "8" 1 NIL 0 2 NIL)
   ("lfrench" "9" 1 NIL 0 2 NIL)
   ("lmideast" "10" 1 NIL 0 2 NIL)
   ("lothrasn" "11" 1 NIL 0 2 NIL)
   ("lothreur" "12" 1 NIL 0 2 NIL)
   ("lother" "13" 1 NIL 0 2 NIL))
  (BIO1ETHN
   :MULTI
   "bio1ethn"
   "Primary Ethnic Group"
   3
   ("enortham" "1" 1 T 1 3 NIL)
   ("eafrica" "2" 1 NIL 0 3 NIL)
   ("enoreur" "3" 1 NIL 0 3 NIL)
   ("esoueur" "4" 1 NIL 0 3 NIL)
   ("mideast" "5" 1 NIL 0 3 NIL)
   ("ecambodn" "6" 1 NIL 0 3 NIL)
   ("echina" "7" 1 NIL 0 3 NIL)
   ("ekorea" "8" 1 NIL 0 3 NIL)
   ("ejapan" "9" 1 NIL 0 3 NIL)
   ("evietnam" "10" 1 NIL 0 3 NIL)
   ("eothrasn" "11" 1 NIL 0 3 NIL)
   ("emexico" "12" 1 NIL 0 3 NIL)
   ("ecentram" "13" 1 NIL 0 3 NIL)
   ("esoutham" "14" 1 NIL 0 3 NIL)
   ("epacific" "15" 1 NIL 0 3 NIL)
   ("eother" "16" 1 NIL 0 3 NIL))
  (BIORELAF
   :MULTI
   "biorelaf"
   "bioRelAffiliation"
   4
   ("catholic" "1" 1 NIL 0 4 NIL)
   ("jewish" "2" 1 NIL 0 4 NIL)
   ("latterd" "3" 1 NIL 0 4 NIL)
   ("buddhist" "4" 1 NIL 0 4 NIL)
   ("islam" "5" 1 NIL 0 4 NIL)
   ("baptist" "6" 1 NIL 0 4 NIL)
   ("methodst" "7" 1 T 1 4 NIL)
   ("episcop" "8" 1 NIL 0 4 NIL)
   ("lutheran" "9" 1 NIL 0 4 NIL)
   ("presbyte" "10" 1 NIL 0 4 NIL)
   ("proliber" "11" 1 NIL 0 4 NIL)
   ("profunda" "12" 1 NIL 0 4 NIL)
   ("noaffil" "13" 1 NIL 0 4 NIL)
   ("agnostic" "14" 1 NIL 0 4 NIL)
   ("othrnoan" "15" 1 NIL 0 4 NIL))
  ("sFamily"
   :MULTI
   "sFamily"
   "Origin Family"
   1
   ("OlderBrosN" "1" 1 NIL 0)
   ("OlderSisN" "2" 1 NIL 0)
   ("YoungerBrosN" "3" 1 NIL 1)
   ("YoungerSisN" "4" 1 NIL 1)
   ("Raised2Parents" "5" 1 NIL 0)
   ("SingleFparent" "6" 1 NIL 1)
   ("SingleMparent" "7" 1 NIL 0)
   ("RaisedNoParents" "8" 1 NIL 0)
   ("RaisedOther" "9" 1 NIL 0))
  (:SCALEDATA
   ACAD-ACH
   :N
   3
   :REL
   0.9523334
   :MN
   11.333333
   :TOT
   34
   :MAX
   36
   :SD
   2.4944382
   :VAR
   6.222222
   :QV
   (BIO3EDUC BIOHSGPA BIOCOLLE))
  (:SCALEDATA
   ST1HIGHERSELF
   :N
   10
   :REL
   0.91999996
   :MN
   9.2
   :TOT
   92
   :MAX
   100
   :SD
   0.4
   :VAR
   0.16000001
   :QV
   (THM6LEAR
    THM9SHAP
    THM14IND
    THM22BOD
    THM23BAL
    THMCOMPC
    THMINTEG
    THMPHIL
    THMSESUF
    THMSEDIS))
  (:SCALEDATA
   ST2SOCINTIMNOFAM
   :N
   6
   :REL
   0.68333334
   :MN
   6.8333335
   :TOT
   41
   :MAX
   60
   :SD
   1.2133516
   :VAR
   1.4722222
   :QV
   (THM8ROMA THM12PLE THMRESPE THM20INT THMLIKED THMSUPPO))
  (:SCALEDATA
   ST3FAMCARE
   :N
   3
   :REL
   0.56666667
   :MN
   5.6666665
   :TOT
   17
   :MAX
   30
   :SD
   0.47140452
   :VAR
   0.22222223
   :QV
   (THMCAREG THMPARLV THMFAMIL))
  (:SCALEDATA
   ST4SUCCESSSTATUSMATER
   :N
   9
   :REL
   0.65555555
   :MN
   6.5555554
   :TOT
   59
   :MAX
   90
   :SD
   0.9558139
   :VAR
   0.91358024
   :QV
   (THM3EDUC
    THM4MONE
    THM25POS
    THM26SUC
    THM30CEO
    THM33GOA
    THMRESPE
    THM1ACH
    THMRECOG))
  (:SCALEDATA
   ST5-ORDERPERFECTIONGOODNESS
   :N
   8
   :REL
   0.6875001
   :MN
   6.875
   :TOT
   55
   :MAX
   80
   :SD
   0.78062475
   :VAR
   0.609375
   :QV
   (THMORDER THMCLEAN THMPERFE THMJUSTI THMSIMPL THMBEAUT THMGOODN THMWHOLE))
  (:SCALEDATA
   ST6GODSPIRITRELIG
   :N
   4
   :REL
   0.6
   :MN
   6.0
   :TOT
   24
   :MAX
   40
   :SD
   0.70710677
   :VAR
   0.5
   :QV
   (THMOBGOD THMRELGD THMSPIRI THMRELIG))
  (:SCALEDATA
   ST7IMPACTCHALLENGEEXPLOR
   :N
   7
   :REL
   0.82857144
   :MN
   8.285714
   :TOT
   58
   :MAX
   70
   :SD
   1.0301576
   :VAR
   1.0612246
   :QV
   (THM10OTH THMIMPAC THM28CRE THMMENCH THM34EXP THMUNIQU THMCREAT))
  (:SCALEDATA
   ST8ATTENTIONFUNEASY
   :N
   4
   :REL
   0.55
   :MN
   5.5
   :TOT
   22
   :MAX
   40
   :SD
   0.8660254
   :VAR
   0.75
   :QV
   (THMATTEN THM5ADVE THMEFORT THMPLAYF))
  (:SCALEDATA
   ST9VALUESELFALLUNCOND
   :N
   4
   :REL
   0.85
   :MN
   8.5
   :TOT
   34
   :MAX
   40
   :SD
   0.8660254
   :VAR
   0.75
   :QV
   (THVUNCON THVSELFW THVSELFA THMUNCON))
  (:SCALEDATA
   ST10OVERCMPROBACCEPTSELF
   :N
   2
   :REL
   0.5
   :MN
   5.0
   :TOT
   10
   :MAX
   20
   :SD
   0.0
   :VAR
   0.0
   :QV
   (THMSPROT THMPHURT))
  (:SCALEDATA
   ST11DUTYPUNCTUAL
   :N
   2
   :REL
   0.5
   :MN
   5.0
   :TOT
   10
   :MAX
   20
   :SD
   0.0
   :VAR
   0.0
   :QV
   (THMPUNCT THMOBLIG))
  (:SCALEDATA
   SWORLDVIEW
   :N
   11
   :REL
   0.926
   :MN
   7.2727275
   :TOT
   80
   :MAX
   86
   :SD
   1.863082
   :VAR
   3.4710746
   :QV
   (WOVPROGR
    WOVGOODF
    WOVMYLIF
    WOVNFAIR
    TBVENTIT
    WOVINJUR
    WOVABUND
    TBVGRATI
    WOVENTIT
    WOVGRATE
    WOVPOSTH)
   :SS
   ("SSWVGRATPT" "SSWVOPTIMS" "SSWVENTIT"))
  (:SUBSCALEDATA
   "SSWVGRATPT"
   :N
   3
   :REL
   1.0
   :MN
   8.0
   :TOT
   24
   :MAX
   24
   :SD
   1.4142135
   :VAR
   2.0
   :QV
   (TBVGRATI WOVABUND WOVGRATE))
  (:SUBSCALEDATA
   "SSWVOPTIMS"
   :N
   4
   :REL
   0.96425
   :MN
   7.5
   :TOT
   30
   :MAX
   31
   :SD
   1.5
   :VAR
   2.25
   :QV
   (WOVPROGR WOVGOODF WOVMYLIF WOVPOSTH))
  (:SUBSCALEDATA
   "SSWVENTIT"
   :N
   4
   :REL
   0.83225
   :MN
   6.5
   :TOT
   26
   :MAX
   31
   :SD
   2.1794496
   :VAR
   4.75
   :QV
   (TBVENTIT WOVNFAIR WOVINJUR WOVENTIT))
  (:SCALEDATA
   STBSLFWO
   :N
   11
   :REL
   0.90000004
   :MN
   9.0
   :TOT
   99
   :MAX
   110
   :SD
   0.6030227
   :VAR
   0.36363637
   :QV
   (TBVOTHFI
    TBVLIKED
    TBVWEAK
    TBVBEST
    TBVRULES
    TBVWINNE
    TBVBALAN
    TBVHAPCA
    THVSELFA
    THVUNCON
    THVSELFW)
   :SS
   ("SSSWNONCONT" "SSSWHAPALLGRAT" "SSSWACALLSELF"))
  (:SUBSCALEDATA
   "SSSWNONCONT"
   :N
   6
   :REL
   0.9000001
   :MN
   9.0
   :TOT
   54
   :MAX
   60
   :SD
   0.57735026
   :VAR
   0.33333334
   :QV
   (TBVOTHFI TBVLIKED TBVWEAK TBVBEST TBVRULES TBVWINNE))
  (:SUBSCALEDATA
   "SSSWHAPALLGRAT"
   :N
   4
   :REL
   0.90000004
   :MN
   9.0
   :TOT
   36
   :MAX
   40
   :SD
   0.70710677
   :VAR
   0.5
   :QV
   (TBVBALAN TBVHAPCA TBVGRATI THVUNCON THVSELFW))
  (:SUBSCALEDATA
   "SSSWACALLSELF"
   :N
   1
   :REL
   0.90000004
   :MN
   9.0
   :TOT
   9
   :MAX
   10
   :SD
   0.0
   :VAR
   0.0
   :QV
   (THVSELFA))
  (:SCALEDATA
   SIECONTR
   :N
   7
   :REL
   0.9387143
   :MN
   6.571429
   :TOT
   46
   :MAX
   49
   :SD
   0.7284314
   :VAR
   0.5306123
   :QV
   (IECSELFS IECICONT IECGENET IECPEOPL IECDEPEN IECCOFEE IECCOPRB)
   :SS
   ("SSIEAUTONY" "SSIENCODEP" "SSIENOTHER"))
  (:SUBSCALEDATA
   "SSIEAUTONY"
   :N
   3
   :REL
   1.0
   :MN
   7.0
   :TOT
   21
   :MAX
   21
   :SD
   0.0
   :VAR
   0.0
   :QV
   (IECSELFS IECICONT IECDEPEN))
  (:SUBSCALEDATA
   "SSIENCODEP"
   :N
   2
   :REL
   0.78550005
   :MN
   5.5
   :TOT
   11
   :MAX
   14
   :SD
   0.5
   :VAR
   0.25
   :QV
   (IECCOFEE IECCOPRB))
  (:SUBSCALEDATA
   "SSIENOTHER"
   :N
   2
   :REL
   1.0
   :MN
   7.0
   :TOT
   14
   :MAX
   14
   :SD
   0.0
   :VAR
   0.0
   :QV
   (IECPEOPL IECGENET))
  (:SCALEDATA
   SETHBEL
   :N
   14
   :REL
   0.7214285
   :MN
   7.214286
   :TOT
   101
   :MAX
   140
   :SD
   1.6978377
   :VAR
   2.882653
   :QV
   (TB2RELAT
    TB2PUNIS
    TBV2NOTR
    TB2GROUM
    TB2SELFM
    TB2GDWRK
    TB2GDATT
    TB2ALLGD
    TB2REASO
    TBV2ASTR
    TB2IDHUM
    TB2LIFAD
    TB2MOVEM
    TBV2CORE)
   :SS
   ("SSB2ETHIC"
    "SSB2FORGIV"
    "SSB2IDGRND"
    "SSB2GRNDMNG"
    "SSB2INRGOOD"
    "SSB2NOASTR"
    "SSB2LIFAD"))
  (:SUBSCALEDATA
   "SSB2ETHIC"
   :N
   4
   :REL
   0.675
   :MN
   6.75
   :TOT
   27
   :MAX
   40
   :SD
   1.299038
   :VAR
   1.6875
   :QV
   (TB2RELAT TBV2NOTR TB2REASO TBV2CORE))
  (:SUBSCALEDATA
   "SSB2FORGIV"
   :N
   2
   :REL
   0.85
   :MN
   8.5
   :TOT
   17
   :MAX
   20
   :SD
   0.5
   :VAR
   0.25
   :QV
   (TB2PUNIS TB2GDWRK))
  (:SUBSCALEDATA
   "SSB2IDGRND"
   :N
   2
   :REL
   0.75
   :MN
   7.5
   :TOT
   15
   :MAX
   20
   :SD
   0.5
   :VAR
   0.25
   :QV
   (TB2IDHUM TB2MOVEM))
  (:SUBSCALEDATA
   "SSB2GRNDMNG"
   :N
   2
   :REL
   0.85
   :MN
   8.5
   :TOT
   17
   :MAX
   20
   :SD
   0.5
   :VAR
   0.25
   :QV
   (TB2GROUM TB2SELFM))
  (:SUBSCALEDATA
   "SSB2INRGOOD"
   :N
   2
   :REL
   0.55
   :MN
   5.5
   :TOT
   11
   :MAX
   20
   :SD
   0.5
   :VAR
   0.25
   :QV
   (TB2GDATT TB2ALLGD))
  (:SUBSCALEDATA
   "SSB2NOASTR"
   :N
   1
   :REL
   1.0
   :MN
   10.0
   :TOT
   10
   :MAX
   10
   :SD
   0.0
   :VAR
   0.0
   :QV
   (TBV2ASTR))
  (:SUBSCALEDATA
   "SSB2LIFAD"
   :N
   1
   :REL
   0.4
   :MN
   4.0
   :TOT
   4
   :MAX
   10
   :SD
   0.0
   :VAR
   0.0
   :QV
   (TB2LIFAD))
  (:SCALEDATA
   SGRFEARS
   :N
   12
   :REL
   0.79758335
   :MN
   5.5833335
   :TOT
   67
   :MAX
   84
   :SD
   2.0598679
   :VAR
   4.2430554
   :QV
   (WOVHAPPY
    WOVPOOR
    WOVILL
    WOVDEATH
    WOVALONE
    WOVNOLOV
    WOVLIKED
    WOVPERSO
    WOVPROBL
    WOVDISCO
    WOVSUCCE
    WOVOVERC)
   :SS
   ("SSWFSOCIAL" "SSWFSELF" "SSWFPOVFAI" "SSWFILLDEA"))
  (:SUBSCALEDATA
   "SSWFSOCIAL"
   :N
   4
   :REL
   0.82125
   :MN
   5.75
   :TOT
   23
   :MAX
   28
   :SD
   1.299038
   :VAR
   1.6875
   :QV
   (WOVALONE WOVNOLOV WOVLIKED WOVPROBL))
  (:SUBSCALEDATA
   "SSWFSELF"
   :N
   3
   :REL
   1.0
   :MN
   7.0
   :TOT
   21
   :MAX
   21
   :SD
   0.0
   :VAR
   0.0
   :QV
   (WOVPERSO WOVDISCO WOVOVERC))
  (:SUBSCALEDATA
   "SSWFPOVFAI"
   :N
   3
   :REL
   0.9523334
   :MN
   6.6666665
   :TOT
   20
   :MAX
   21
   :SD
   0.47140452
   :VAR
   0.22222223
   :QV
   (WOVHAPPY WOVPOOR WOVSUCCE))
  (:SUBSCALEDATA
   "SSWFILLDEA"
   :N
   2
   :REL
   0.21450001
   :MN
   1.5
   :TOT
   3
   :MAX
   14
   :SD
   0.5
   :VAR
   0.25
   :QV
   (WOVILL WOVDEATH))
  (:SCALEDATA
   SSLFCONF
   :N
   41
   :REL
   0.9930244
   :MN
   6.9512196
   :TOT
   285
   :MAX
   287
   :SD
   0.21540882
   :VAR
   0.046400957
   :QV
   (SLFLEARN
    SLFCRITT
    SLFRESEA
    SLFANALY
    SLFSYNTH
    SLFCREAT
    SLFCOMPU
    SLFBIOSC
    SLFNATSC
    SLFLIBAR
    SLFSOCSC
    SLFPHILR
    SLFPERFA
    SLFFINEA
    SLFBUSAN
    SLFHEAL2
    SLFENGIN
    SLFEDUCH
    SLFIQ
    SLFDECMA
    SLFTIMEM
    SLFCOPE
    SLFSELF4
    SLFSELFM
    SLFACHAN
    SLFMANA6
    SLFHEAL3
    SLFMEETP
    SLFLISTE
    SLFSELF5
    SLFCONFL
    SLFPERSU
    SLFMANA7
    SLFHELPS
    SLFSPEAK
    SLFJOBSE
    SLFADAPT
    SLFHAPPY
    SLFOPTIM
    SLFFRIEN
    SLFINDEP)
   :SS
   ("SSSCLEARN"
    "SSSCCOPOPT"
    "SSSCSMSMSD"
    "SSSCINTERP"
    "SSSCALLHELP"
    "SSSCSCIENCE"
    "SSSCARTCRE"))
  (:SUBSCALEDATA
   "SSSCLEARN"
   :N
   7
   :REL
   1.0
   :MN
   7.0
   :TOT
   49
   :MAX
   49
   :SD
   0.0
   :VAR
   0.0
   :QV
   (SLFLEARN SLFCRITT SLFRESEA SLFANALY SLFSYNTH SLFCOMPU SLFIQ))
  (:SUBSCALEDATA
   "SSSCCOPOPT"
   :N
   6
   :REL
   1.0
   :MN
   7.0
   :TOT
   42
   :MAX
   42
   :SD
   0.0
   :VAR
   0.0
   :QV
   (SLFSELF4 SLFCOPE SLFSELF5 SLFCONFL SLFOPTIM SLFFRIEN))
  (:SUBSCALEDATA
   "SSSCSMSMSD"
   :N
   7
   :REL
   1.0
   :MN
   7.0
   :TOT
   49
   :MAX
   49
   :SD
   0.0
   :VAR
   0.0
   :QV
   (SLFDECMA SLFTIMEM SLFSELFM SLFACHAN SLFMANA6 SLFHEAL3 SLFINDEP))
  (:SUBSCALEDATA
   "SSSCINTERP"
   :N
   7
   :REL
   1.0
   :MN
   7.0
   :TOT
   49
   :MAX
   49
   :SD
   0.0
   :VAR
   0.0
   :QV
   (SLFADAPT SLFMEETP SLFPERSU SLFMANA7 SLFBUSAN SLFSPEAK SLFJOBSE))
  (:SUBSCALEDATA
   "SSSCALLHELP"
   :N
   6
   :REL
   1.0
   :MN
   7.0
   :TOT
   42
   :MAX
   42
   :SD
   0.0
   :VAR
   0.0
   :QV
   (SLFSOCSC SLFPHILR SLFLIBAR SLFEDUCH SLFLISTE SLFHELPS))
  (:SUBSCALEDATA
   "SSSCSCIENCE"
   :N
   4
   :REL
   1.0
   :MN
   7.0
   :TOT
   28
   :MAX
   28
   :SD
   0.0
   :VAR
   0.0
   :QV
   (SLFBIOSC SLFNATSC SLFHEAL2 SLFENGIN))
  (:SUBSCALEDATA
   "SSSCARTCRE"
   :N
   3
   :REL
   0.9046667
   :MN
   6.3333335
   :TOT
   19
   :MAX
   21
   :SD
   0.47140452
   :VAR
   0.22222223
   :QV
   (SLFCREAT SLFPERFA SLFFINEA))
  (:SCALEDATA
   SSELFMAN
   :N
   15
   :REL
   0.9604
   :MN
   7.3333335
   :TOT
   110
   :MAX
   116
   :SD
   1.3984116
   :VAR
   1.9555551
   :QV
   (SMTBUSY
    SMTFUTUR
    SMTEXERC
    SMTEATH
    SMTSLEEP
    SMTSDEVE
    SMTNPROC
    SMTPTODO
    SMTGOALS
    SMTSCHD
    SMT2DTOD
    SMTACMPL
    SMTGHELP
    SMTBALAN
    SMTHABCH)
   :SS
   ("SSSMTIMEMANGOALSET"
    "SSSMACCOMPLORUSH"
    "SSSMSELFDEVEL"
    "SSSMHEALTHHABS"))
  (:SUBSCALEDATA
   "SSSMTIMEMANGOALSET"
   :N
   5
   :REL
   0.9714001
   :MN
   6.8
   :TOT
   34
   :MAX
   35
   :SD
   0.39999998
   :VAR
   0.15999998
   :QV
   (SMTFUTUR SMTPTODO SMTGOALS SMTSCHD SMT2DTOD))
  (:SUBSCALEDATA
   "SSSMACCOMPLORUSH"
   :N
   2
   :REL
   0.92850006
   :MN
   6.5
   :TOT
   13
   :MAX
   14
   :SD
   0.5
   :VAR
   0.25
   :QV
   (SMTBUSY SMTACMPL))
  (:SUBSCALEDATA
   "SSSMSELFDEVEL"
   :N
   3
   :REL
   1.0
   :MN
   7.0
   :TOT
   21
   :MAX
   21
   :SD
   0.0
   :VAR
   0.0
   :QV
   (SMTSDEVE SMTGHELP SMTHABCH))
  (:SUBSCALEDATA
   "SSSMHEALTHHABS"
   :N
   3
   :REL
   0.8973333
   :MN
   9.333333
   :TOT
   28
   :MAX
   32
   :SD
   2.0548046
   :VAR
   4.222222
   :QV
   (SMTEXERC SMTEATH SMTSLEEP))
  (:SCALEDATA
   SEMOTCOP
   :N
   20
   :REL
   0.9415501
   :MN
   5.85
   :TOT
   117
   :MAX
   124
   :SD
   0.90967024
   :VAR
   0.8275
   :QV
   (COPNEGTH
    COPCOPEA
    COPPSOLV
    COPAVOPS
    COPEMOTA
    COPBLAME
    COPWDRW
    COPFUN
    COPTALKS
    COPPEPTA
    COPSMOKE
    COPDRUG
    COPPE
    COPNEGPH
    COPSELFB
    COPPOSPH
    COPEXPEC
    COPHAPPY
    COPAVOAT
    COPSELFE)
   :SS
   ("SSCPPROBSOLV"
    "SSCPPOSTHOUGHTS"
    "SSCPPOSACTS"
    "SSCPNOBLAMEANGERWDRAW"
    "SSCPNOTSMOKDRUGMED"
    "SSCPNOTEAT"))
  (:SUBSCALEDATA
   "SSCPPROBSOLV"
   :N
   4
   :REL
   0.95825005
   :MN
   6.5
   :TOT
   26
   :MAX
   27
   :SD
   1.5
   :VAR
   2.25
   :QV
   (COPPSOLV COPTALKS COPEXPEC COPSELFE))
  (:SUBSCALEDATA
   "SSCPPOSTHOUGHTS"
   :N
   2
   :REL
   1.0
   :MN
   6.0
   :TOT
   12
   :MAX
   12
   :SD
   0.0
   :VAR
   0.0
   :QV
   (COPNEGTH COPPEPTA))
  (:SUBSCALEDATA
   "SSCPPOSACTS"
   :N
   2
   :REL
   1.0
   :MN
   6.0
   :TOT
   12
   :MAX
   12
   :SD
   0.0
   :VAR
   0.0
   :QV
   (COPFUN COPPE))
  (:SUBSCALEDATA
   "SSCPNOBLAMEANGERWDRAW"
   :N
   5
   :REL
   0.8998
   :MN
   5.4
   :TOT
   27
   :MAX
   30
   :SD
   0.48989797
   :VAR
   0.24000001
   :QV
   (COPEMOTA COPBLAME COPWDRW COPNEGPH COPSELFB))
  (:SUBSCALEDATA
   "SSCPNOTSMOKDRUGMED"
   :N
   2
   :REL
   1.0
   :MN
   6.0
   :TOT
   12
   :MAX
   12
   :SD
   0.0
   :VAR
   0.0
   :QV
   (COPSMOKE COPDRUG))
  (:SUBSCALEDATA
   "SSCPNOTEAT"
   :N
   1
   :REL
   0.83300007
   :MN
   5.0
   :TOT
   5
   :MAX
   6
   :SD
   0.0
   :VAR
   0.0
   :QV
   (COPCOPEA))
  (:SCALEDATA
   INTSS1AASSERTCR
   :N
   14
   :REL
   0.8162857
   :MN
   5.714286
   :TOT
   80
   :MAX
   98
   :SD
   1.3324827
   :VAR
   1.7755102
   :QV
   (CR1ISSUE
    CRRESOLV
    CRNTHREA
    CRUNDERL
    CRWINWIN
    CRLONGTK
    CRSUMMAR
    CRCPRAIS
    CRBOASSR
    CROPHONE
    CRANGRES
    CRTLKMOR
    CREQWIN
    INTUNDRL))
  (:SCALEDATA
   INTSS1BOPENHON
   :N
   9
   :REL
   0.9682223
   :MN
   6.7777777
   :TOT
   61
   :MAX
   63
   :SD
   0.41573972
   :VAR
   0.17283952
   :QV
   (INTTELAL
    INTSMGOA
    INTEQDEC
    INTIOPEN
    INTWEOPN
    INTDAILY
    INTALLOP
    INTKNPFE
    INCOMTWO))
  (:SCALEDATA
   INTSS2ROMANTC
   :N
   7
   :REL
   0.9387143
   :MN
   6.571429
   :TOT
   46
   :MAX
   49
   :SD
   0.7284314
   :VAR
   0.53061235
   :QV
   (ROMSURPR ROMFANTA ROMCELEB ROMPLACE ROMATTRA ROMPLAYF ROMCHARM))
  (:SCALEDATA
   INTSS3LIBROLE
   :N
   7
   :REL
   0.9182857
   :MN
   6.428571
   :TOT
   45
   :MAX
   49
   :SD
   0.7284314
   :VAR
   0.53061235
   :QV
   (LROMTASK LROFTASK LRMFINAL LROEMBAR LROMSTRO LROEQINC LRCARCON))
  (:SCALEDATA
   INTSS4LOVERES
   :N
   7
   :REL
   1.0
   :MN
   7.0
   :TOT
   49
   :MAX
   49
   :SD
   0.0
   :VAR
   0.0
   :QV
   (CRIFAVOR CRIFOLUP INTCOMIT INTRESPT INTLSQPR INTLOVE INNEVARG))
  (:SCALEDATA
   INTSS5INDEP
   :N
   15
   :REL
   0.87606675
   :MN
   6.133333
   :TOT
   92
   :MAX
   105
   :SD
   0.71802205
   :VAR
   0.5155557
   :QV
   (INRLUNCH
    INRINHAP
    INRIGROW
    INRSAYWE
    INDIFGOA
    INFINDAN
    INENALON
    INOKALON
    INRHATEA
    INSEPINT
    INRMONEY
    INRBEALN
    INALCNST
    INRFREEH
    INRFRIEN))
  (:SCALEDATA
   INTSS6POSSUP
   :N
   8
   :REL
   0.9285
   :MN
   6.5
   :TOT
   52
   :MAX
   56
   :SD
   0.5
   :VAR
   0.25
   :QV
   (CRNTHREA CRNNEGLB CREXAGGR CRANGANG CRIPRAIS CRANGRES INDIFDEC INSTSHLP))
  (:SCALEDATA
   INTSS7COLLAB
   :N
   7
   :REL
   0.6938572
   :MN
   4.857143
   :TOT
   34
   :MAX
   49
   :SD
   2.0303815
   :VAR
   4.122449
   :QV
   (CRTKLONG CRTEWEAK CRMANIPU CRREPRAI CRTEACH CRTLKMOR INTWKTOG))
  (STUCOLLE
   :MULTI
   "stucolle"
   "st-College attending"
   7
   ("cocsulb" "1" 1 NIL 0 7 NIL)
   ("cccsu" "2" 1 NIL 0 7 NIL)
   ("coucal" "3" 1 NIL 0 7 NIL)
   ("coopublc" "4" 1 NIL 0 7 NIL)
   ("coprivca" "5" 1 NIL 0 7 NIL)
   ("coprivot" "6" 1 NIL 0 7 NIL)
   ("cocacomc" "7" 1 NIL 0 7 NIL)
   ("coothcc" "8" 1 NIL 0 7 NIL)
   ("coothnat" "9" 1 NIL 0 7 NIL)
   ("coprgrad" "10" 1 NIL 0 7 NIL)
   ("cotech" "11" 1 NIL 0 7 NIL)
   ("highsch" "12" 1 NIL 0 7 NIL)
   ("coother" "13" 1 T 1 7 NIL))
  (STUMAJOR
   :MULTI
   "stumajor"
   "st-Major study area"
   8
   ("mlibart" "1" 1 NIL 0 8 NIL)
   ("msocsci" "2" 1 T 1 8 NIL)
   ("mbiolsci" "3" 1 NIL 0 8 NIL)
   ("mart" "4" 1 NIL 0 8 NIL)
   ("mnatsci" "5" 1 NIL 0 8 NIL)
   ("mbus" "6" 1 NIL 0 8 NIL)
   ("menginr" "7" 1 T 1 8 NIL)
   ("meducat" "8" 1 NIL 0 8 NIL)
   ("mmedical" "9" 1 NIL 0 8 NIL)
   ("motcompu" "10" 1 NIL 0 8 NIL)
   ("mothtech" "11" 1 NIL 0 8 NIL)
   ("mrecrpe" "12" 1 NIL 0 8 NIL)
   ("mdoesna" "13" 1 NIL 0 8 NIL)
   ("mundecid" "14" 1 NIL 0 8 NIL))
  (STUSPECI
   :MULTI
   "stuspeci"
   "st-Special status"
   9
   ("strancc" "1" 1 NIL 0 9 NIL)
   ("stran4yr" "2" 1 NIL 0 9 NIL)
   ("sadultre" "3" 1 NIL 0 9 NIL)
   ("seop" "4" 1 NIL 0 9 NIL)
   ("susimmig" "5" 1 NIL 0 9 NIL)
   ("svisa" "6" 1 NIL 0 9 NIL)
   ("shonor" "7" 1 NIL 0 9 NIL)
   ("svisastu" "8" 1 NIL 0 9 NIL)
   ("sdisabld" "9" 1 NIL 0 9 NIL)
   ("soutofst" "10" 1 NIL 0 9 NIL)
   ("smilitar" "11" 1 NIL 0 9 NIL)
   ("sathlete" "12" 1 NIL 0 9 NIL)
   ("snone" "13" 1 T 1 9 NIL))
  (STURESID
   :MULTI
   "sturesid"
   "st-Residence"
   10
   ("rsinwpar" "1" 1 NIL 0 10 NIL)
   ("rsindorm" "2" 1 NIL 0 10 NIL)
   ("rsinwchl" "3" 1 NIL 0 10 NIL)
   ("rsinothr" "4" 1 NIL 0 10 NIL)
   ("rmarwoch" "5" 1 T 1 10 NIL)
   ("rmarwchl" "6" 1 NIL 0 10 NIL)
   ("rmarlike" "7" 1 NIL 0 10 NIL)
   ("rother" "8" 1 NIL 0 10 NIL))
  (STGPATRE
   :MULTI
   "stgpatre"
   "st-GPA Trends"
   11
   ("trconhi" "1" 1 T 1 11 NIL)
   ("trincryr" "2" 1 NIL 0 11 NIL)
   ("trincyru" "3" 1 NIL 0 11 NIL)
   ("trincyrs" "4" 1 NIL 0 11 NIL)
   ("trgradin" "5" 1 NIL 0 11 NIL)
   ("trconave" "6" 1 NIL 0 11 NIL)
   ("trdecyru" "7" 1 NIL 0 11 NIL)
   ("trdecyr" "8" 1 NIL 0 11 NIL)
   ("trconlow" "9" 1 NIL 0 11 NIL)
   ("trupandd" "10" 1 NIL 0 11 NIL)
   ("trother" "11" 1 NIL 0 11 NIL))
  (STURESOURCE
   :MULTI
   "sturesource"
   "am-All interference factors"
   12
   ("afinanc" "1" 1 NIL 0 12 NIL)
   ("afampres" "2" 1 NIL 0 12 NIL)
   ("afamresp" "3" 1 NIL 0 12 NIL)
   ("aworktim" "4" 1 NIL 0 12 NIL)
   ("awrkpres" "5" 1 NIL 0 12 NIL)
   ("arelprob" "6" 1 NIL 0 12 NIL)
   ("aloneli" "7" 1 NIL 0 12 NIL)
   ("ahomstpl" "8" 1 NIL 0 12 NIL)
   ("aschstpl" "9" 1 NIL 0 12 NIL)
   ("acompavl" "10" 1 NIL 0 12 NIL)
   ("awrngcls" "11" 1 NIL 0 12 NIL)
   ("afacconn" "12" 1 NIL 0 12 NIL)
   ("astuconn" "13" 1 NIL 0 12 NIL)
   ("alowmotv" "14" 1 NIL 0 12 NIL)
   ("atimconf" "15" 1 T 1 12 NIL)
   ("aprocras" "16" 1 NIL 0 12 NIL))
  (:SCALEDATA
   SCOLLEGE
   :N
   6
   :REL
   0.6346667
   :MN
   4.6666665
   :TOT
   28
   :MAX
   51
   :SD
   2.748737
   :VAR
   7.555556
   :QV
   (STPARED STUCLASS STUDEGRE STUSEMES STMAJGPA STACADST))
  (:SCALEDATA
   SSL1CONFIDEFFICSTUDYTEST
   :N
   13
   :REL
   0.86815387
   :MN
   6.076923
   :TOT
   79
   :MAX
   91
   :SD
   1.7303417
   :VAR
   2.9940825
   :QV
   (LRNUNASN
    LRNCOLMT
    LRNKNOWT
    LRNPROOF
    LRNRREAD
    LRNEFFIC
    LRNTESTT
    LRNTIMAS
    LRNTIRED
    LRNTANXI
    LRNSMART
    LRNAREAD
    LRNRSLOW))
  (:SCALEDATA
   SSL1BCONFIDNOTAVOIDSTUDY
   :N
   5
   :REL
   1.0
   :MN
   7.0
   :TOT
   35
   :MAX
   35
   :SD
   0.0
   :VAR
   0.0
   :QV
   (LRNUNASN LRNCOLMT LRNTIRED LRNAREAD LRNPROOF))
  (:SCALEDATA
   SSL2SATISCAMPUSFACFRIENDSGRDES
   :N
   8
   :REL
   0.839125
   :MN
   5.875
   :TOT
   47
   :MAX
   56
   :SD
   0.3307189
   :VAR
   0.109375
   :QV
   (STULOOKF STULIKEI STUCOMFO STUFRIEN STUENJOY STUEACTR STHAPCOL STHAPGPA))
  (:SCALEDATA
   SSL3WRITEREADSKILLS
   :N
   6
   :REL
   0.8571667
   :MN
   6.0
   :TOT
   36
   :MAX
   42
   :SD
   2.236068
   :VAR
   5.0
   :QV
   (LRNWRPAP LRNWRSKL LRNSEE LRNVOCAB LRNWRORG LRNSREAD))
  (:SCALEDATA
   SSL4BLDMENTALSTRUCT
   :N
   7
   :REL
   1.0
   :MN
   7.0
   :TOT
   49
   :MAX
   49
   :SD
   0.0
   :VAR
   0.0
   :QV
   (LRNTXUND LRNINTER LRNROTE LRNASSOC LRNSTRUG LRNTHEOR LRNALONE))
  (:SCALEDATA
   SSL5BASICSTUDYSKILLS
   :N
   6
   :REL
   1.0
   :MN
   7.0
   :TOT
   42
   :MAX
   42
   :SD
   0.0
   :VAR
   0.0
   :QV
   (ACMCONCE LRNTXOVE LRNTSREV LRNMAP LRNTXOUT LRNNOTES))
  (:SCALEDATA
   SSL6SELFMANACADGOALS
   :N
   6
   :REL
   0.8571667
   :MN
   6.0
   :TOT
   36
   :MAX
   42
   :SD
   2.236068
   :VAR
   5.0
   :QV
   (ACMCOMPL ACMQUITC ACMFINAN ACMDEGRE STUCONFU ACMSELFS))
  (:SCALEDATA
   SSL7MATHSCIPRINC
   :N
   2
   :REL
   1.0
   :MN
   7.0
   :TOT
   14
   :MAX
   14
   :SD
   0.0
   :VAR
   0.0
   :QV
   (LRNMATH LRNTEXTN))
  (:SCALEDATA
   SSL8STUDYENVIR
   :N
   3
   :REL
   1.0
   :MN
   7.0
   :TOT
   21
   :MAX
   21
   :SD
   0.0
   :VAR
   0.0
   :QV
   (ACMEFAML ACMESOCS LRNESTUD))
  (:SCALEDATA
   SSL9ATTENDHW
   :N
   3
   :REL
   0.8333333
   :MN
   5.6666665
   :TOT
   17
   :MAX
   20
   :SD
   1.885618
   :VAR
   3.5555554
   :QV
   (ACMSTUDY ACMNDROP ACMATTEN))
  (:SCALEDATA
   SSL10MEMNOTANX
   :N
   3
   :REL
   1.0
   :MN
   7.0
   :TOT
   21
   :MAX
   21
   :SD
   0.0
   :VAR
   0.0
   :QV
   (LRNMEMOR LRNTENSE LRNSEFIC))
  (:SCALEDATA
   SSL11NOTNONACADMOT
   :N
   5
   :REL
   0.7856
   :MN
   5.4
   :TOT
   27
   :MAX
   34
   :SD
   1.496663
   :VAR
   2.24
   :QV
   (STUEXTMO STUMONEYNEW STUCONFU STUFINDE STUCAREE))
  (:SCALEDATA
   SSL12STDYTMAVAIL
   :N
   1
   :REL
   1.0
   :MN
   7.0
   :TOT
   7
   :MAX
   7
   :SD
   0.0
   :VAR
   0.0
   :QV
   (ACMTIME))
  (:SCALEDATA
   SSL13VERBALAPT
   :N
   1
   :REL
   1.0
   :MN
   10.0
   :TOT
   10
   :MAX
   10
   :SD
   0.0
   :VAR
   0.0
   :QV
   (STUVERBA))
  (:SCALEDATA
   SSL14MATHAPT
   :N
   1
   :REL
   1.0
   :MN
   10.0
   :TOT
   10
   :MAX
   10
   :SD
   0.0
   :VAR
   0.0
   :QV
   (STUMATHA))
  (:SCALEDATA
   SINCAR
   :N
   28
   :REL
   0.6378215
   :MN
   4.464286
   :TOT
   125
   :MAX
   196
   :SD
   2.4854167
   :VAR
   6.177296
   :QV
   (CAR1CARG
    CAR1CARP
    CAR1INAT
    CARIBIOH
    CARISOCS
    CARIHELP
    CARIMATH
    CARIMED
    CARIWRIT
    CARIFNAR
    CARIETHN
    CARILEAR
    CARIEXPE
    CARIGENE
    CARINOIN
    CARILIT
    CARIRECP
    CARIPOLI
    CARIMIL6
    CARIMANU
    CARILANG
    CARIPHIL
    CARIBUSI
    CARIENGI
    CARIFAMC
    CARIWOMA
    CARICOM8
    CARINTE0))
  (:SCALEDATA
   SINBUS
   :N
   7
   :REL
   0.46942857
   :MN
   3.2857144
   :TOT
   23
   :MAX
   49
   :SD
   2.2497166
   :VAR
   5.0612245
   :QV
   (CARIBMAR CARIBMAN CARIBINF CARIBFIN CARIBHRD CARIBACC CARISPBU))
  (:SCALEDATA
   SINENGR
   :N
   8
   :REL
   0.60725
   :MN
   4.25
   :TOT
   34
   :MAX
   56
   :SD
   2.384848
   :VAR
   5.6875
   :QV
   (CARIEENG CARIME CARICHE2 CARICIVE CARIAERO CARIEITE CARICOM9 CARIBCOM))
  (:SCALEDATA
   SINFINEA
   :N
   7
   :REL
   0.16342858
   :MN
   1.1428572
   :TOT
   8
   :MAX
   49
   :SD
   0.34992707
   :VAR
   0.12244896
   :QV
   (CARIMUSI CARIART CARIDRAM CARIDANC CARIPHOT CARINDDE CARINTE1))
  (:SCALEDATA
   SINHELP
   :N
   10
   :REL
   0.60010005
   :MN
   4.2
   :TOT
   42
   :MAX
   70
   :SD
   2.6758175
   :VAR
   7.16
   :QV
   (CARITEAC
    CARICOUN
    CARIEDUC
    CARIHADU
    CARIHCHI
    CARITVOC
    CARICOM4
    CARSOCWO
    CARK12TE
    CARMINIS))
  (:SCALEDATA
   SINLANG
   :N
   9
   :REL
   0.143
   :MN
   1.0
   :TOT
   9
   :MAX
   63
   :SD
   0.0
   :VAR
   0.0
   :QV
   (CARIFREN
    CARIITAL
    CARIGERM
    CARIRUSS
    CARIJAPN
    CARICHIN
    CARICLAS
    CARISPAN
    CARIPOR))
  (:SCALEDATA
   SINMED
   :N
   7
   :REL
   0.18385716
   :MN
   1.2857143
   :TOT
   9
   :MAX
   49
   :SD
   0.6998542
   :VAR
   0.4897959
   :QV
   (CARIMD CARINURS CARIPTHE CARIHEAL CARIKINE CARICOM5 CARMEDTE))
  (:SCALEDATA
   SINMILTC
   :N
   3
   :REL
   0.143
   :MN
   1.0
   :TOT
   3
   :MAX
   21
   :SD
   0.0
   :VAR
   0.0
   :QV
   (CARILAW CARICRIM CARIMIL7))
  (:SCALEDATA
   INNATSCI
   :N
   5
   :REL
   0.3716
   :MN
   2.6
   :TOT
   13
   :MAX
   35
   :SD
   1.1999999
   :VAR
   1.4399998
   :QV
   (CARICHE3 CARIPHYS CARIGEOL CARIASTR CARIENVI))
  (:SCALEDATA
   SINSOCSC
   :N
   11
   :REL
   0.45472735
   :MN
   3.1818183
   :TOT
   35
   :MAX
   77
   :SD
   1.6958871
   :VAR
   2.876033
   :QV
   (CARIPSYC
    CARISOCO
    CARIHIST
    CARIPOLS
    CARIECON
    CARGEOGR
    CARIAMER
    CARIANTR
    CARIANTH
    CARISPEE
    CARLING))
  (:SCALEDATA
   SINWOETH
   :N
   6
   :REL
   0.143
   :MN
   1.0
   :TOT
   6
   :MAX
   42
   :SD
   0.0
   :VAR
   0.0
   :QV
   (CARIAIST CARIBSTU CARIMEXA CARIASAM CARIAMST CARIWSTU))
  (:SCALEDATA
   SINWRITE
   :N
   2
   :REL
   0.143
   :MN
   1.0
   :TOT
   2
   :MAX
   14
   :SD
   0.0
   :VAR
   0.0
   :QV
   (CARIENGL CARIJOUR))
  (:SCALEDATA
   SEHAPPY
   :N
   1
   :REL
   0.90900004
   :MN
   10.0
   :TOT
   10
   :MAX
   11
   :SD
   0.0
   :VAR
   0.0
   :QV
   NIL
   :SS
   ("HAPSDMEANSPIRITSS"
    "HAPCAREEREXSS"
    "HAPRECPESS"
    "HAPAREASS"
    "HAPFAMSS"
    "HAPROMSS"
    "HAPFRIENDSSS"
    "HAPFUTURESS"
    "HAPPASTSS"
    "HAPRECENTSS"))
  (:QV (HAPSELFD HAPSPIRI))
  (:QV (HAPCARFU HAPCARNW))
  (:QV (HAPPE HAPRECRE))
  (:QV (HAPAREA))
  (:QV (HAPFAMIL))
  (:QV (HAPSEXRE))
  (:QV (HAPCLFRN HAPFRIEN HAPWKREL))
  (:QV (HAPEXPEC))
  (:QV (HAPLIFE))
  (:QV (HAPYEAR HAP3YEAR))
  (:SCALEDATA
   SEHAPPY
   :N
   16
   :REL
   1.0
   :MN
   7.0
   :TOT
   112
   :MAX
   112
   :SD
   0.0
   :VAR
   0.0
   :QV
   (HAPCLFRN
    HAPCARNW
    HAPCARFU
    HAPFRIEN
    HAPAREA
    HAPWKREL
    HAPPE
    HAPRECRE
    HAPSEXRE
    HAPFAMIL
    HAPSELFD
    HAPSPIRI
    HAPYEAR
    HAP3YEAR
    HAPLIFE
    HAPEXPEC)
   :SS
   ("HAPSDMEANSPIRITSS"
    "HAPCAREEREXSS"
    "HAPRECPESS"
    "HAPAREASS"
    "HAPFAMSS"
    "HAPROMSS"
    "HAPFRIENDSSS"
    "HAPFUTURESS"
    "HAPPASTSS"
    "HAPRECENTSS"))
  (:SUBSCALEDATA
   "HAPSDMEANSPIRITSS"
   :N
   2
   :REL
   1.0
   :MN
   7.0
   :TOT
   14
   :MAX
   14
   :SD
   0.0
   :VAR
   0.0
   :QV
   (HAPSELFD HAPSPIRI))
  (:SUBSCALEDATA
   "HAPCAREEREXSS"
   :N
   2
   :REL
   1.0
   :MN
   7.0
   :TOT
   14
   :MAX
   14
   :SD
   0.0
   :VAR
   0.0
   :QV
   (HAPCARFU HAPCARNW))
  (:SUBSCALEDATA
   "HAPRECPESS"
   :N
   2
   :REL
   1.0
   :MN
   7.0
   :TOT
   14
   :MAX
   14
   :SD
   0.0
   :VAR
   0.0
   :QV
   (HAPPE HAPRECRE))
  (:SUBSCALEDATA
   "HAPAREASS"
   :N
   1
   :REL
   1.0
   :MN
   7.0
   :TOT
   7
   :MAX
   7
   :SD
   0.0
   :VAR
   0.0
   :QV
   (HAPAREA))
  (:SUBSCALEDATA
   "HAPFAMSS"
   :N
   1
   :REL
   1.0
   :MN
   7.0
   :TOT
   7
   :MAX
   7
   :SD
   0.0
   :VAR
   0.0
   :QV
   (HAPFAMIL))
  (:SUBSCALEDATA
   "HAPROMSS"
   :N
   1
   :REL
   1.0
   :MN
   7.0
   :TOT
   7
   :MAX
   7
   :SD
   0.0
   :VAR
   0.0
   :QV
   (HAPSEXRE))
  (:SUBSCALEDATA
   "HAPFRIENDSSS"
   :N
   3
   :REL
   1.0
   :MN
   7.0
   :TOT
   21
   :MAX
   21
   :SD
   0.0
   :VAR
   0.0
   :QV
   (HAPCLFRN HAPFRIEN HAPWKREL))
  (:SUBSCALEDATA
   "HAPFUTURESS"
   :N
   1
   :REL
   1.0
   :MN
   7.0
   :TOT
   7
   :MAX
   7
   :SD
   0.0
   :VAR
   0.0
   :QV
   (HAPEXPEC))
  (:SUBSCALEDATA
   "HAPPASTSS"
   :N
   1
   :REL
   1.0
   :MN
   7.0
   :TOT
   7
   :MAX
   7
   :SD
   0.0
   :VAR
   0.0
   :QV
   (HAPLIFE))
  (:SUBSCALEDATA
   "HAPRECENTSS"
   :N
   2
   :REL
   1.0
   :MN
   7.0
   :TOT
   14
   :MAX
   14
   :SD
   0.0
   :VAR
   0.0
   :QV
   (HAPYEAR HAP3YEAR))
  (:SCALEDATA
   SRDEPRES
   :N
   6
   :REL
   1.0
   :MN
   9.0
   :TOT
   54
   :MAX
   54
   :SD
   1.6329932
   :VAR
   2.6666668
   :QV
   (RDEPFEEL RDEPTHOU RDEPDYSS RDEPMAJS RDEPMEDS RDEPTHER)
   :SS
   ("SSDELODEPSYMP" "SSDELODEPTREATS"))
  (:SUBSCALEDATA
   "SSDELODEPSYMP"
   :N
   4
   :REL
   1.0
   :MN
   8.5
   :TOT
   34
   :MAX
   34
   :SD
   1.6583124
   :VAR
   2.75
   :QV
   (RDEPFEEL RDEPTHOU RDEPDYSS RDEPMAJS))
  (:SUBSCALEDATA
   "SSDELODEPTREATS"
   :N
   2
   :REL
   1.0
   :MN
   10.0
   :TOT
   20
   :MAX
   20
   :SD
   1.0
   :VAR
   1.0
   :QV
   (RDEPMEDS RDEPTHER))
  (:SCALEDATA
   SRANXIET
   :N
   9
   :REL
   1.0
   :MN
   9.222222
   :TOT
   83
   :MAX
   83
   :SD
   2.3934067
   :VAR
   5.728395
   :QV
   (RANXPERF
    RANXALLT
    RANXPSTD
    RANXSOCI
    RANXOCD
    RANXPHOB
    RANXPANI
    RANXTHER
    RANXMEDS)
   :SS
   ("SSAXLOPERFGENANX" "SSAXLOWFEAROCD" "SSAXLOANXTREATS"))
  (:SUBSCALEDATA
   "SSAXLOPERFGENANX"
   :N
   4
   :REL
   1.0
   :MN
   7.0
   :TOT
   28
   :MAX
   28
   :SD
   0.0
   :VAR
   0.0
   :QV
   (RANXPERF RANXALLT RANXPSTD RANXSOCI))
  (:SUBSCALEDATA
   "SSAXLOWFEAROCD"
   :N
   3
   :REL
   1.0
   :MN
   11.666667
   :TOT
   35
   :MAX
   35
   :SD
   1.885618
   :VAR
   3.5555554
   :QV
   (RANXOCD RANXPHOB RANXPANI))
  (:SUBSCALEDATA
   "SSAXLOANXTREATS"
   :N
   2
   :REL
   1.0
   :MN
   10.0
   :TOT
   20
   :MAX
   20
   :SD
   1.0
   :VAR
   1.0
   :QV
   (RANXTHER RANXMEDS))
  (:SCALEDATA
   SRANGAGG
   :N
   5
   :REL
   0.775
   :MN
   6.2
   :TOT
   31
   :MAX
   40
   :SD
   0.97979594
   :VAR
   0.96000004
   :QV
   (RANGFEEL RANGYELL RANGDOMI RANGTHOU RANGDEST))
  (:SCALEDATA
   SRELHLTH
   :N
   6
   :REL
   0.8928334
   :MN
   7.5
   :TOT
   45
   :MAX
   50
   :SD
   1.9790571
   :VAR
   3.9166668
   :QV
   (RHLFREQI RHLALCOH RHLSMOKE RHLDRUGS RHLPHYSI RHLWEIGH)
   :SS
   ("SSHELONEGADDICTHABS" "SSHELOFREQILL" "SSHEPELOWEIGHT"))
  (:SUBSCALEDATA
   "SSHELONEGADDICTHABS"
   :N
   3
   :REL
   0.8333333
   :MN
   6.6666665
   :TOT
   20
   :MAX
   24
   :SD
   1.885618
   :VAR
   3.5555554
   :QV
   (RHLALCOH RHLSMOKE RHLDRUGS))
  (:SUBSCALEDATA
   "SSHELOFREQILL"
   :N
   1
   :REL
   0.85700006
   :MN
   6.0
   :TOT
   6
   :MAX
   7
   :SD
   0.0
   :VAR
   0.0
   :QV
   (RHLFREQI))
  (:SUBSCALEDATA
   "SSHEPELOWEIGHT"
   :N
   2
   :REL
   1.0
   :MN
   9.5
   :TOT
   19
   :MAX
   19
   :SD
   0.5
   :VAR
   0.25
   :QV
   (RHLPHYSI RHLWEIGH))
  (:SCALEDATA
   SRPEOPLE
   :N
   7
   :REL
   0.7687143
   :MN
   6.857143
   :TOT
   48
   :MAX
   66
   :SD
   2.8996833
   :VAR
   8.408163
   :QV
   (RPEHAPFR RPEHMARR RPENETW RPECLFRN RPENUMFR RPENUMCL RPECOMMI)
   :SS
   ("SSRECLOSEFRIENDS" "SSREROMRELSUC" "SSRENUMFRIENDS" "SSREHAPSUCFRS"))
  (:SUBSCALEDATA
   "SSRECLOSEFRIENDS"
   :N
   2
   :REL
   0.85700006
   :MN
   6.0
   :TOT
   12
   :MAX
   14
   :SD
   0.0
   :VAR
   0.0
   :QV
   (RPENETW RPECLFRN))
  (:SUBSCALEDATA
   "SSREROMRELSUC"
   :N
   2
   :REL
   1.0
   :MN
   10.5
   :TOT
   21
   :MAX
   21
   :SD
   2.5
   :VAR
   6.25
   :QV
   (RPEHMARR RPECOMMI))
  (:SUBSCALEDATA
   "SSRENUMFRIENDS"
   :N
   2
   :REL
   0.33350003
   :MN
   4.0
   :TOT
   8
   :MAX
   24
   :SD
   1.0
   :VAR
   1.0
   :QV
   (RPENUMFR RPENUMCL))
  (:SUBSCALEDATA
   "SSREHAPSUCFRS"
   :N
   2
   :REL
   1.0
   :MN
   10.5
   :TOT
   21
   :MAX
   21
   :SD
   2.5
   :VAR
   6.25
   :QV
   (RPEHMARR RPECOMMI)))))





;;'((:SHAQ-DATA-LIST (:TEXT-DATA "sID" ("UserID" "555555" :SINGLE "555555") ("Sex" "Male" :SINGLE "Male" 1) ("Age" 78 :SINGLE 78 78) ("USA?" "USA" :SINGLE "USA" 1) ("Nation" "USA" :SINGLE "USA") ("ZipCode" 92260 :SINGLE 92260) ("HrsWork" 78 :SINGLE 78 78)) :MULTI-SEL-QUEST "utype" ("UTYPE" :MULTI "utype" "UserType" 1 ("twanttho" "1" 1 T 1 1 (:XDATA :SCALES (HQ))) ("tknowmor" "2" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("twanthel" "3" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("twantspe" "4" 1 NIL 0 1 (:XDATA :SCALES NIL)) ("texperie" "5" 1 NIL 0 1 (:XDATA :SCALES NIL)) ("tprevshaq" "6" 1 NIL 0 1 (:XDATA :SCALES (PREVIOUS-USER))) ("wantspq" "7" 1 NIL 0 1 (:XDATA :SCALES (SPECIFIC-QUESTS))) ("tu100stu" "8" 1 NIL 0 1 (:XDATA :SCALES (HQ ACAD-LEARNING))) ("tcsulbst" "9" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING))) ("tcolstu" "10" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING))) ("totherst" "11" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING))) ("tressub" "12" 1 NIL 0 1 (:XDATA :SCALES NIL)) ("tcolfaca" "13" 1 NIL 0 1 (:XDATA :SCALES NIL)) ("u-none" "14" 1 NIL 0 1 (:XDATA :SCALES NIL))) :MULTI-SEL-QUEST "ugoals" ("UGOALS" :MULTI "ugoals" "UserGoals" 1 ("gsuchap" "1" 1 T 1 1 (:XDATA :SCALES (HQ))) ("gemocop" "2" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("gslfest" "3" 1 NIL 0 1 (:XDATA :SCALES (VALUES-THEMES BELIEFS SKILLS-CONFIDENCE))) ("gprocrst" "4" 1 NIL 0 1 (:XDATA :SCALES (VALUES-THEMES "siecontr" "sselfman" "semotcop"))) ("gtimeman" "5" 1 NIL 0 1 (:XDATA :SCALES ("sselfman" "semotcop"))) ("grelat" "6" 1 NIL 0 1 (:XDATA :SCALES (INTERPERSONAL))) ("gmeetpeo" "7" 1 NIL 0 1 (:XDATA :SCALES (INTERPERSONAL))) ("glonelyf" "8" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("gexvalus" "9" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("gdepres" "10" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("ganxfear" "11" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("gaggrang" "12" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("gacadsuc" "13" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING))) ("gcomplta1" "14" 1 T 1 1 (:XDATA :SCALES (HQ ACAD-LEARNING CAREER-INTEREST))) ("gcompltanomaj" "15" 1 NIL 0 1 (:XDATA :SCALES (HQ ACAD-LEARNING))) ("gcompltanoac" "16" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("gAcadOnly" "17" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING))) ("gcarplan" "18" 1 NIL 0 1 (:XDATA :SCALES (CAREER-INTEREST))) ("gcaronly" "19" 1 NIL 0 1 (:XDATA :SCALES (CAREER-INTEREST))) ("gnottake" "20" 1 NIL 0 1 (:XDATA :SCALES NIL))) :SCALE BIO-MAQ :MULTI-SEL-QUEST "bio4job" (BIO4JOB :MULTI "bio4job" "b-Primary occupation" 1 ("student" "1" 1 NIL 0 1 NIL) ("manager" "2" 1 NIL 0 1 NIL) ("propeop" "3" 1 T 1 1 NIL) ("protech" "4" 1 NIL 0 1 NIL) ("consulta" "5" 1 NIL 0 1 NIL) ("educator" "6" 1 T 1 1 NIL) ("sales" "7" 1 NIL 0 1 NIL) ("technici" "8" 1 NIL 0 1 NIL) ("clerical" "9" 1 NIL 0 1 NIL) ("service" "10" 1 NIL 0 1 NIL) ("ownbus10" "11" 1 NIL 0 1 NIL) ("othrsfem" "12" 1 NIL 0 1 NIL) ("other" "13" 1 NIL 0 1 NIL)) :MULTI-SEL-QUEST "bio7lang" (BIO7LANG :MULTI "bio7lang" "b-Fluent languages" 2 ("lenglish" "1" 1 T 1 2 NIL) ("lspanish" "2" 1 NIL 0 2 NIL) ("lvietnam" "3" 1 NIL 0 2 NIL) ("lcambodn" "4" 1 NIL 0 2 NIL) ("lchinese" "5" 1 NIL 0 2 NIL) ("lkorean" "6" 1 NIL 0 2 NIL) ("lportugu" "7" 1 NIL 0 2 NIL) ("lgerman" "8" 1 NIL 0 2 NIL) ("lfrench" "9" 1 NIL 0 2 NIL) ("lmideast" "10" 1 NIL 0 2 NIL) ("lothrasn" "11" 1 NIL 0 2 NIL) ("lothreur" "12" 1 NIL 0 2 NIL) ("lother" "13" 1 NIL 0 2 NIL)) :MULTI-SEL-QUEST "bio1ethn" (BIO1ETHN :MULTI "bio1ethn" "Primary Ethnic Group" 3 ("enortham" "1" 1 T 1 3 NIL) ("eafrica" "2" 1 NIL 0 3 NIL) ("enoreur" "3" 1 NIL 0 3 NIL) ("esoueur" "4" 1 NIL 0 3 NIL) ("mideast" "5" 1 NIL 0 3 NIL) ("ecambodn" "6" 1 NIL 0 3 NIL) ("echina" "7" 1 NIL 0 3 NIL) ("ekorea" "8" 1 NIL 0 3 NIL) ("ejapan" "9" 1 NIL 0 3 NIL) ("evietnam" "10" 1 NIL 0 3 NIL) ("eothrasn" "11" 1 NIL 0 3 NIL) ("emexico" "12" 1 NIL 0 3 NIL) ("ecentram" "13" 1 NIL 0 3 NIL) ("esoutham" "14" 1 NIL 0 3 NIL) ("epacific" "15" 1 NIL 0 3 NIL) ("eother" "16" 1 NIL 0 3 NIL)) :MULTI-SEL-QUEST "biorelaf" (BIORELAF :MULTI "biorelaf" "bioRelAffiliation" 4 ("catholic" "1" 1 NIL 0 4 NIL) ("jewish" "2" 1 NIL 0 4 NIL) ("latterd" "3" 1 NIL 0 4 NIL) ("buddhist" "4" 1 NIL 0 4 NIL) ("islam" "5" 1 NIL 0 4 NIL) ("baptist" "6" 1 NIL 0 4 NIL) ("methodst" "7" 1 T 1 4 NIL) ("episcop" "8" 1 NIL 0 4 NIL) ("lutheran" "9" 1 NIL 0 4 NIL) ("presbyte" "10" 1 NIL 0 4 NIL) ("proliber" "11" 1 NIL 0 4 NIL) ("profunda" "12" 1 NIL 0 4 NIL) ("noaffil" "13" 1 NIL 0 4 NIL) ("agnostic" "14" 1 NIL 0 4 NIL) ("othrnoan" "15" 1 NIL 0 4 NIL)) :MULTI-SEL-QUEST "sFamily" ("sFamily" :MULTI "sFamily" "Origin Family" 1 ("OlderBrosN" "1" 1 NIL 0) ("OlderSisN" "2" 1 NIL 0) ("YoungerBrosN" "3" 1 NIL 1) ("YoungerSisN" "4" 1 NIL 1) ("Raised2Parents" "5" 1 NIL 0) ("SingleFparent" "6" 1 NIL 1) ("SingleMparent" "7" 1 NIL 0) ("RaisedNoParents" "8" 1 NIL 0) ("RaisedOther" "9" 1 NIL 0)) :SCALE ACAD-ACH (BIO3EDUC "b-Highest education completed" :SINGLE "Doctorate" "1.000" 8 1 8 8 SCORED-NORMAL BIO3EDUCANSARRAY) (BIOHSGPA "b-High school GPA" :SINGLE "3.75-4.00" "1.000" 14 2 14 14 SCORED-NORMAL GPAANSARRAY) (BIOCOLLE "b-College GPA" :SINGLE "3.25-3.49" "0.857" 12 3 14 12 SCORED-NORMAL GPAANSARRAY) :SCALE ST1HIGHERSELF (THM6LEAR "ti-Learning, self-development" :SINGLE "One of the most important things in my life" "0.900" 9 1 10 9 SCORED-NORMAL PRIORITY10) (THM9SHAP "ti-Self-happiness" :SINGLE "The most important thing in my life" "1.000" 10 2 10 10 SCORED-NORMAL PRIORITY10) (THM14IND "ti-Independence" :SINGLE "One of the most important things in my life" "0.900" 9 3 10 9 SCORED-NORMAL PRIORITY10) (THM22BOD "ti-Health and longevity" :SINGLE "The most important thing in my life" "1.000" 10 4 10 10 SCORED-NORMAL PRIORITY10) (THM23BAL "ti-Life balance" :SINGLE "One of the most important things in my life" "0.900" 9 5 10 9 SCORED-NORMAL PRIORITY10) (THMCOMPC "ti-Competence, best I can be" :SINGLE "One of the most important things in my life" "0.900" 9 6 10 9 SCORED-NORMAL PRIORITY10) (THMINTEG "ti-Integrity" :SINGLE "One of the most important things in my life" "0.900" 9 7 10 9 SCORED-NORMAL PRIORITY10) (THMPHIL "ti-Personal philosophy" :SINGLE "One of the most important things in my life" "0.900" 9 8 10 9 SCORED-NORMAL PRIORITY10) (THMSESUF "ti-Self-sufficiency" :SINGLE "One of the most important things in my life" "0.900" 9 9 10 9 SCORED-NORMAL PRIORITY10) (THMSEDIS "ti-Self-discipline" :SINGLE "One of the most important things in my life" "0.900" 9 10 10 9 SCORED-NORMAL PRIORITY10) :SCALE ST2SOCINTIMNOFAM (THM8ROMA "ts-Love-romance" :SINGLE "One of the most important things in my life" "0.900" 9 1 10 9 SCORED-NORMAL PRIORITY10) (THM12PLE "ts-Pleasing others-avoid conflict" :SINGLE "Moderately important" "0.600" 6 2 10 6 SCORED-NORMAL PRIORITY10) (THMRESPE "ts-Respect from others" :SINGLE "Moderately important" "0.600" 6 3 10 6 SCORED-NORMAL PRIORITY10) (THM20INT "ts-Intimacy-close relationships" :SINGLE "Extremely important" "0.800" 8 4 10 8 SCORED-NORMAL PRIORITY10) (THMLIKED "ts-Well-liked by many" :SINGLE "Moderately important" "0.600" 6 5 10 6 SCORED-NORMAL PRIORITY10) (THMSUPPO "ts-Emotional support from others" :SINGLE "Moderately important" "0.600" 6 6 10 6 SCORED-NORMAL PRIORITY10) :SCALE ST3FAMCARE (THMCAREG "ts-Care-giving-parent, others" :SINGLE "Moderately important" "0.600" 6 1 10 6 SCORED-NORMAL PRIORITY10) (THMPARLV "td-Parental love and respect" :SINGLE "Moderately important" "0.600" 6 2 10 6 SCORED-NORMAL PRIORITY10) (THMFAMIL "ts-Family" :SINGLE "Mildly important" "0.500" 5 3 10 5 SCORED-NORMAL PRIORITY10) :SCALE ST4SUCCESSSTATUSMATER (THM3EDUC "ta-Advanced degrees" :SINGLE "Extremely important" "0.800" 8 1 10 8 SCORED-NORMAL PRIORITY10) (THM4MONE "ta-Very high income" :SINGLE "Moderately important" "0.600" 6 2 10 6 SCORED-NORMAL PRIORITY10) (THM25POS "ta-High quality possessions" :SINGLE "Mildly important" "0.500" 5 3 10 5 SCORED-NORMAL PRIORITY10) (THM26SUC "ta-Career success" :SINGLE "Very important" "0.700" 7 4 10 7 SCORED-NORMAL PRIORITY10) (THM30CEO "ta-Power-ceo, owner" :SINGLE "Moderately important" "0.600" 6 5 10 6 SCORED-NORMAL PRIORITY10) (THM33GOA "ta-Complete all important goals" :SINGLE "Extremely important" "0.800" 8 6 10 8 SCORED-NORMAL PRIORITY10) (THMRESPE "ts-Respect from others" :SINGLE "Moderately important" "0.600" 6 7 10 6 SCORED-NORMAL PRIORITY10) (THM1ACH "ta-Being the best" :SINGLE "Very important" "0.700" 7 8 10 7 SCORED-NORMAL PRIORITY10) (THMRECOG "ts-Recognition-respect,status,etc" :SINGLE "Moderately important" "0.600" 6 9 10 6 SCORED-NORMAL PRIORITY10) :SCALE ST5-ORDERPERFECTIONGOODNESS (THMORDER "ti-Orderliness organization" :SINGLE "Very important" "0.700" 7 1 10 7 SCORED-NORMAL PRIORITY10) (THMCLEAN "ti-Cleanliness" :SINGLE "Moderately important" "0.600" 6 2 10 6 SCORED-NORMAL PRIORITY10) (THMPERFE "ti-Perfection and idealism" :SINGLE "Moderately important" "0.600" 6 3 10 6 SCORED-NORMAL PRIORITY10) (THMJUSTI "ti-Justice" :SINGLE "Very important" "0.700" 7 4 10 7 SCORED-NORMAL PRIORITY10) (THMSIMPL "ti-Simplicity" :SINGLE "Moderately important" "0.600" 6 5 10 6 SCORED-NORMAL PRIORITY10) (THMBEAUT "ti-Beauty" :SINGLE "Extremely important" "0.800" 8 6 10 8 SCORED-NORMAL PRIORITY10) (THMGOODN "ti-Goodness" :SINGLE "Extremely important" "0.800" 8 7 10 8 SCORED-NORMAL PRIORITY10) (THMWHOLE "ti-Wholeness" :SINGLE "Very important" "0.700" 7 8 10 7 SCORED-NORMAL PRIORITY10) :SCALE ST6GODSPIRITRELIG (THMOBGOD "td-Obedience to God" :SINGLE "Moderately important" "0.600" 6 1 10 6 SCORED-NORMAL PRIORITY10) (THMRELGD "ti-Spiritual intimacy" :SINGLE "Very important" "0.700" 7 2 10 7 SCORED-NORMAL PRIORITY10) (THMSPIRI "ti-God and/or spirituality" :SINGLE "Moderately important" "0.600" 6 3 10 6 SCORED-NORMAL PRIORITY10) (THMRELIG "ti-Religion" :SINGLE "Mildly important" "0.500" 5 4 10 5 SCORED-NORMAL PRIORITY10) :SCALE ST7IMPACTCHALLENGEEXPLOR (THM10OTH "ti-Giving to others happiness, world" :SINGLE "One of the most important things in my life" "0.900" 9 1 10 9 SCORED-NORMAL PRIORITY10) (THMIMPAC "ta-Impact-change world" :SINGLE "One of the most important things in my life" "0.900" 9 2 10 9 SCORED-NORMAL PRIORITY10) (THM28CRE "ta-Creation-major contribution" :SINGLE "One of the most important things in my life" "0.900" 9 3 10 9 SCORED-NORMAL PRIORITY10) (THMMENCH "ti-Mental Challenge" :SINGLE "One of the most important things in my life" "0.900" 9 4 10 9 SCORED-NORMAL PRIORITY10) (THM34EXP "ti-Exploration find answers" :SINGLE "Extremely important" "0.800" 8 5 10 8 SCORED-NORMAL PRIORITY10) (THMUNIQU "ti-Uniqueness & diversity" :SINGLE "Moderately important" "0.600" 6 6 10 6 SCORED-NORMAL PRIORITY10) (THMCREAT "ti-Creativeness" :SINGLE "Extremely important" "0.800" 8 7 10 8 SCORED-NORMAL PRIORITY10) :SCALE ST8ATTENTIONFUNEASY (THMATTEN "ts-Attention from others" :SINGLE "Mildly important" "0.500" 5 1 10 5 SCORED-NORMAL PRIORITY10) (THM5ADVE "ti-Adventure" :SINGLE "Mildly important" "0.500" 5 2 10 5 SCORED-NORMAL PRIORITY10) (THMEFORT "ti-Effortlessness" :SINGLE "Mildly important" "0.500" 5 3 10 5 SCORED-NORMAL PRIORITY10) (THMPLAYF "ti-Fun playfulness" :SINGLE "Very important" "0.700" 7 4 10 7 SCORED-NORMAL PRIORITY10) :SCALE ST9VALUESELFALLUNCOND (THVUNCON "bu-Value all unconditionally" :SINGLE "One of the most important beliefs in my life" "0.900" 9 1 10 9 SCORED-NORMAL BELIEF10) (THVSELFW "bu-Value self unconditionally" :SINGLE "One of the most important beliefs in my life" "0.900" 9 2 10 9 SCORED-NORMAL BELIEF10) (THVSELFA "bu-Accept all parts of self" :SINGLE "Not important, unsure, or neutral about this" "0.700" 7 3 10 7 SCORED-REVERSE BELIEF10REVERSE) (THMUNCON "ti-Unconditional love of all people" :SINGLE "One of the most important things in my life" "0.900" 9 4 10 9 SCORED-NORMAL PRIORITY10) :SCALE ST10OVERCMPROBACCEPTSELF (THMSPROT "td-Self-protection" :SINGLE "Mildly important" "0.500" 5 1 10 5 SCORED-NORMAL PRIORITY10) (THMPHURT "td-Personal healing-overcome problems" :SINGLE "Mildly important" "0.500" 5 2 10 5 SCORED-NORMAL PRIORITY10) :SCALE ST11DUTYPUNCTUAL (THMPUNCT "td-Punctuality" :SINGLE "Mildly important" "0.500" 5 1 10 5 SCORED-NORMAL PRIORITY10) (THMOBLIG "td-Obligation" :SINGLE "Mildly important" "0.500" 5 2 10 5 SCORED-NORMAL PRIORITY10) :SCALE SWORLDVIEW (WOVPROGR "wv-World will improve" :SINGLE "EXTREMELY agree" "1.000" 7 1 7 7 SCORED-NORMAL AGREE7) (WOVGOODF "wv-Good forces control world" :SINGLE "EXTREMELY agree" "1.000" 7 2 7 7 SCORED-NORMAL AGREE7) (WOVMYLIF "wv-My life will improve" :SINGLE "MODERATELY agree" "0.857" 6 3 7 6 SCORED-NORMAL AGREE7) (WOVNFAIR "wv-Not life unfair to me" :SINGLE "EXTREMELY disagree" "1.000" 7 4 7 7 SCORED-REVERSE AGREE7REVERSE) (TBVENTIT "bu-Not entitled to good life" :SINGLE "Strongly disagree, very negative to me" "0.900" 9 5 10 9 SCORED-REVERSE BELIEF10REVERSE) (WOVINJUR "wv-Not one ruined my life" :SINGLE "EXTREMELY disagree" "1.000" 7 6 7 7 SCORED-REVERSE AGREE7REVERSE) (WOVABUND "wv-Have all I need to be happy" :SINGLE "EXTREMELY agree" "1.000" 7 7 7 7 SCORED-NORMAL AGREE7) (TBVGRATI "bu-Gratitude-abundance thinking" :SINGLE "The most important belief in my life" "1.000" 10 8 10 10 SCORED-NORMAL BELIEF10) (WOVENTIT "wv-Not entitled to basic necessities" :SINGLE "MILDLY agree" "0.429" 3 9 7 3 SCORED-REVERSE AGREE7REVERSE) (WOVGRATE "wv-Extremely grateful" :SINGLE "EXTREMELY agree" "1.000" 7 10 7 7 SCORED-NORMAL AGREE7) (WOVPOSTH "wv-Percent of time positive thoughts" :SINGLE "Greater than 90 percent" "1.000" 10 11 10 10 SCORED-NORMAL PERCENT10) :SCALE STBSLFWO (TBVOTHFI "bu-Not always others first" :SINGLE "Strongly disagree, very negative to me" "0.900" 9 1 10 9 SCORED-REVERSE BELIEF10REVERSE) (TBVLIKED "bu-Not loved by all" :SINGLE "Strongly disagree, very negative to me" "0.900" 9 2 10 9 SCORED-REVERSE BELIEF10REVERSE) (TBVWEAK "bu-Not weak and dependent" :SINGLE "Extremely disagree, extremely negative to me" "1.000" 10 3 10 10 SCORED-REVERSE BELIEF10REVERSE) (TBVBEST "bu-Not must be best" :SINGLE "Strongly disagree, very negative to me" "0.900" 9 4 10 9 SCORED-REVERSE BELIEF10REVERSE) (TBVRULES "bu-Not if break rules--severe punishment" :SINGLE "Disagree, negative to me" "0.800" 8 5 10 8 SCORED-REVERSE BELIEF10REVERSE) (TBVWINNE "bu-Not winners and losers" :SINGLE "Strongly disagree, very negative to me" "0.900" 9 6 10 9 SCORED-REVERSE BELIEF10REVERSE) (TBVBALAN "bu-Balance present-future, self-others hap" :SINGLE "One of the most important beliefs in my life" "0.900" 9 7 10 9 SCORED-NORMAL BELIEF10) (TBVHAPCA "bu-Decisions-max happiness" :SINGLE "The most important belief in my life" "1.000" 10 8 10 10 SCORED-NORMAL BELIEF10) (THVSELFA "bu-Accept all parts of self" :SINGLE "Strongly disagree, very negative to me" "0.900" 9 9 10 9 SCORED-REVERSE BELIEF10REVERSE) (THVUNCON "bu-Value all unconditionally" :SINGLE "One of the most important beliefs in my life" "0.900" 9 10 10 9 SCORED-NORMAL BELIEF10) (THVSELFW "bu-Value self unconditionally" :SINGLE "Extremely important belief" "0.800" 8 11 10 8 SCORED-NORMAL BELIEF10) :SCALE SIECONTR (IECSELFS "ie-Take care of self & probs" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 1 7 7 SCORED-NORMAL LIKEME7) (IECICONT "ie-I control life-happiness" :SINGLE "EXTREMELY agree" "1.000" 7 2 7 7 SCORED-NORMAL AGREE7) (IECGENET "ie-Not genetics-biology control my hap" :SINGLE "EXTREMELY disagree" "1.000" 7 3 7 7 SCORED-REVERSE AGREE7REVERSE) (IECPEOPL "ie-Not others control my happiness" :SINGLE "EXTREMELY disagree" "1.000" 7 4 7 7 SCORED-REVERSE AGREE7REVERSE) (IECDEPEN "ie-Not dependent on one person" :SINGLE "EXTREMELY inaccurate / unlike me" "1.000" 7 5 7 7 SCORED-REVERSE LIKEME7REVERSE) (IECCOFEE "ie-Not care for another above self" :SINGLE "MODERATELY inaccurate / unlike me" "0.857" 6 6 7 6 SCORED-REVERSE LIKEME7REVERSE) (IECCOPRB "ie-Not worry carrying for one's serious prob" :SINGLE "MILDLY inaccurate / unlike me" "0.714" 5 7 7 5 SCORED-REVERSE LIKEME7REVERSE) :SCALE SETHBEL (TB2RELAT "b2-RevNo absolute right--situational ethics" :SINGLE "Mildly important belief" "0.600" 6 1 10 6 SCORED-REVERSE BELIEF10REVERSE) (TB2PUNIS "b2-RevBad only happens if bad" :SINGLE "Strongly disagree, very negative to me" "0.900" 9 2 10 9 SCORED-REVERSE BELIEF10REVERSE) (TBV2NOTR "b2-RevNot responsible if bad environ/genes" :SINGLE "Disagree, negative to me" "0.800" 8 3 10 8 SCORED-REVERSE BELIEF10REVERSE) (TB2GROUM "b2-RevLife no meaning w/o spec group" :SINGLE "Strongly disagree, very negative to me" "0.900" 9 4 10 9 SCORED-REVERSE BELIEF10REVERSE) (TB2SELFM "b2-RevAll meaning supplied by person" :SINGLE "Disagree, negative to me" "0.800" 8 5 10 8 SCORED-REVERSE BELIEF10REVERSE) (TB2GDWRK "b2-RevForgiveness depends on works" :SINGLE "Disagree, negative to me" "0.800" 8 6 10 8 SCORED-REVERSE BELIEF10REVERSE) (TB2GDATT "b2-Goodness depends more on attitude" :SINGLE "Mildly important belief" "0.500" 5 7 10 5 SCORED-NORMAL BELIEF10) (TB2ALLGD "b2-Lots of good in all people" :SINGLE "Moderately important belief" "0.600" 6 8 10 6 SCORED-NORMAL BELIEF10) (TB2REASO "b2-RevScience-reason can solve all worries" :SINGLE "Moderately important belief" "0.500" 5 9 10 5 SCORED-REVERSE BELIEF10REVERSE) (TBV2ASTR "b2-RevBelief in spirits,astrology" :SINGLE "Extremely disagree, extremely negative to me" "1.000" 10 10 10 10 SCORED-REVERSE BELIEF10REVERSE) (TB2IDHUM "b2-Identify with all human over any group" :SINGLE "Extremely important belief" "0.800" 8 11 10 8 SCORED-NORMAL BELIEF10) (TB2LIFAD "b2-Believe in life after death" :SINGLE "Not important, unsure, or neutral about this" "0.400" 4 12 10 4 SCORED-NORMAL BELIEF10) (TB2MOVEM "b2-Part of progress greater than family etc" :SINGLE "Very important belief" "0.700" 7 13 10 7 SCORED-NORMAL BELIEF10) (TBV2CORE "b2-Strong phil/rel beliefs guide daily life" :SINGLE "Extremely important belief" "0.800" 8 14 10 8 SCORED-NORMAL BELIEF10) :SCALE SGRFEARS (WOVHAPPY "wf-Not fear unhappy career" :SINGLE "No fear at all" "1.000" 7 1 7 7 SCORED-REVERSE FEAR7REVERSE) (WOVPOOR "wf-Not fear of poverty" :SINGLE "No fear at all" "1.000" 7 2 7 7 SCORED-REVERSE FEAR7REVERSE) (WOVILL "wf-Not fear of illness" :SINGLE "One of the most important fears in my life" "0.286" 2 3 7 2 SCORED-REVERSE FEAR7REVERSE) (WOVDEATH "wf-Not fear of death" :SINGLE "The most important fear in my life" "0.143" 1 4 7 1 SCORED-REVERSE FEAR7REVERSE) (WOVALONE "wf-Not fear of being alone" :SINGLE "Very important fear" "0.571" 4 5 7 4 SCORED-REVERSE FEAR7REVERSE) (WOVNOLOV "wf-Not fear of poor marriage-family" :SINGLE "No fear at all" "1.000" 7 6 7 7 SCORED-REVERSE FEAR7REVERSE) (WOVLIKED "wf-Not fear of not close friends" :SINGLE "Moderately important fear" "0.714" 5 7 7 5 SCORED-REVERSE FEAR7REVERSE) (WOVPERSO "wf-Not fear of not being person want" :SINGLE "No fear at all" "1.000" 7 8 7 7 SCORED-REVERSE FEAR7REVERSE) (WOVPROBL "wf-Not fear of overcoming problem" :SINGLE "No fear at all" "1.000" 7 9 7 7 SCORED-REVERSE FEAR7REVERSE) (WOVDISCO "wf-Not fear of something discovered" :SINGLE "No fear at all" "1.000" 7 10 7 7 SCORED-REVERSE FEAR7REVERSE) (WOVSUCCE "wf-Not fear of lack acad-career success" :SINGLE "Mildly important fear" "0.857" 6 11 7 6 SCORED-REVERSE FEAR7REVERSE) (WOVOVERC "wf-Could be happy if worst fear happened" :SINGLE "EXTREMELY agree" "1.000" 7 12 7 7 SCORED-NORMAL AGREE7) :SCALE SSLFCONF (SLFLEARN "sc-Learning and study skills" :SINGLE "Extremely confident" "1.000" 7 1 7 7 SCORED-NORMAL CONFIDENCE7) (SLFCRITT "sc-Critical thinking and logic" :SINGLE "Extremely confident" "1.000" 7 2 7 7 SCORED-NORMAL CONFIDENCE7) (SLFRESEA "sc-Research & methodology" :SINGLE "Extremely confident" "1.000" 7 3 7 7 SCORED-NORMAL CONFIDENCE7) (SLFANALY "sc-Analytical thinking" :SINGLE "Extremely confident" "1.000" 7 4 7 7 SCORED-NORMAL CONFIDENCE7) (SLFSYNTH "sc-Synthesis" :SINGLE "Extremely confident" "1.000" 7 5 7 7 SCORED-NORMAL CONFIDENCE7) (SLFCREAT "sc-Creative thinking-ideas" :SINGLE "Extremely confident" "1.000" 7 6 7 7 SCORED-NORMAL CONFIDENCE7) (SLFCOMPU "sc-Computer-related" :SINGLE "Extremely confident" "1.000" 7 7 7 7 SCORED-NORMAL CONFIDENCE7) (SLFBIOSC "sc-Biological science" :SINGLE "Extremely confident" "1.000" 7 8 7 7 SCORED-NORMAL CONFIDENCE7) (SLFNATSC "sc-Natural science--physics, chem" :SINGLE "Extremely confident" "1.000" 7 9 7 7 SCORED-NORMAL CONFIDENCE7) (SLFLIBAR "sc-Liberal arts" :SINGLE "Extremely confident" "1.000" 7 10 7 7 SCORED-NORMAL CONFIDENCE7) (SLFSOCSC "sc-Beh-social science" :SINGLE "Extremely confident" "1.000" 7 11 7 7 SCORED-NORMAL CONFIDENCE7) (SLFPHILR "sc-Philosophy-religion" :SINGLE "Extremely confident" "1.000" 7 12 7 7 SCORED-NORMAL CONFIDENCE7) (SLFPERFA "sc-Performing arts" :SINGLE "Moderately confident" "0.857" 6 13 7 6 SCORED-NORMAL CONFIDENCE7) (SLFFINEA "sc-Fine arts" :SINGLE "Moderately confident" "0.857" 6 14 7 6 SCORED-NORMAL CONFIDENCE7) (SLFBUSAN "sc-Business or management" :SINGLE "Extremely confident" "1.000" 7 15 7 7 SCORED-NORMAL CONFIDENCE7) (SLFHEAL2 "sc-Health or medicine" :SINGLE "Extremely confident" "1.000" 7 16 7 7 SCORED-NORMAL CONFIDENCE7) (SLFENGIN "sc-Engineering or technical" :SINGLE "Extremely confident" "1.000" 7 17 7 7 SCORED-NORMAL CONFIDENCE7) (SLFEDUCH "sc-Educ,Counseling, or helping" :SINGLE "Extremely confident" "1.000" 7 18 7 7 SCORED-NORMAL CONFIDENCE7) (SLFIQ "sc-Intelligence" :SINGLE "Extremely confident" "1.000" 7 19 7 7 SCORED-NORMAL CONFIDENCE7) (SLFDECMA "sc-Decision-making/planning" :SINGLE "Extremely confident" "1.000" 7 20 7 7 SCORED-NORMAL CONFIDENCE7) (SLFTIMEM "sc-Time management" :SINGLE "Extremely confident" "1.000" 7 21 7 7 SCORED-NORMAL CONFIDENCE7) (SLFCOPE "sc-Emotional coping skills" :SINGLE "Extremely confident" "1.000" 7 22 7 7 SCORED-NORMAL CONFIDENCE7) (SLFSELF4 "sc-Ach motivation-work habits, focus" :SINGLE "Extremely confident" "1.000" 7 23 7 7 SCORED-NORMAL CONFIDENCE7) (SLFSELFM "sc-Self-motivation of unpleasant" :SINGLE "Extremely confident" "1.000" 7 24 7 7 SCORED-NORMAL CONFIDENCE7) (SLFACHAN "sc-Self-development/change" :SINGLE "Extremely confident" "1.000" 7 25 7 7 SCORED-NORMAL CONFIDENCE7) (SLFMANA6 "sc-Managing finances" :SINGLE "Extremely confident" "1.000" 7 26 7 7 SCORED-NORMAL CONFIDENCE7) (SLFHEAL3 "sc-Health detailed knowl & habits" :SINGLE "Extremely confident" "1.000" 7 27 7 7 SCORED-NORMAL CONFIDENCE7) (SLFMEETP "sc-Meeting people" :SINGLE "Extremely confident" "1.000" 7 28 7 7 SCORED-NORMAL CONFIDENCE7) (SLFLISTE "sc-Empathetic listening skills" :SINGLE "Extremely confident" "1.000" 7 29 7 7 SCORED-NORMAL CONFIDENCE7) (SLFSELF5 "sc-Self-disclosure" :SINGLE "Extremely confident" "1.000" 7 30 7 7 SCORED-NORMAL CONFIDENCE7) (SLFCONFL "sc-Conflict resolution skills" :SINGLE "Extremely confident" "1.000" 7 31 7 7 SCORED-NORMAL CONFIDENCE7) (SLFPERSU "sc-Persuasion skills" :SINGLE "Extremely confident" "1.000" 7 32 7 7 SCORED-NORMAL CONFIDENCE7) (SLFMANA7 "sc-Management-leadership skills" :SINGLE "Extremely confident" "1.000" 7 33 7 7 SCORED-NORMAL CONFIDENCE7) (SLFHELPS "sc-Helping-teaching skills" :SINGLE "Extremely confident" "1.000" 7 34 7 7 SCORED-NORMAL CONFIDENCE7) (SLFSPEAK "sc-Public speaking skills" :SINGLE "Extremely confident" "1.000" 7 35 7 7 SCORED-NORMAL CONFIDENCE7) (SLFJOBSE "sc-Job search skills" :SINGLE "Extremely confident" "1.000" 7 36 7 7 SCORED-NORMAL CONFIDENCE7) (SLFADAPT "sc-Adaptable-success in any situation" :SINGLE "Extremely confident" "1.000" 7 37 7 7 SCORED-NORMAL CONFIDENCE7) (SLFHAPPY "sc-Happiness IQ" :SINGLE "Extremely confident" "1.000" 7 38 7 7 SCORED-NORMAL CONFIDENCE7) (SLFOPTIM "sc-Optimism" :SINGLE "Extremely confident" "1.000" 7 39 7 7 SCORED-NORMAL CONFIDENCE7) (SLFFRIEN "sc-Caring, friendly, outgoing" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 40 7 7 SCORED-NORMAL LIKEME7) (SLFINDEP "sc-Strong, independent, self-disciplined" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 41 7 7 SCORED-NORMAL LIKEME7) :SCALE SSELFMAN (SMTBUSY "sm-Rarely upset about too rushed" :SINGLE "MODERATELY accurate / like me" "0.857" 6 1 7 6 SCORED-NORMAL LIKEME7) (SMTFUTUR "sm-Time planning and distant goals" :SINGLE "MODERATELY accurate / like me" "0.857" 6 2 7 6 SCORED-NORMAL LIKEME7) (SMTEXERC "sm-Exercise freq-20 mins" :SINGLE "More than once per day" "1.000" 12 3 12 12 SCORED-NORMAL FREQ12) (SMTEATH "sm-Healthy diet" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 4 7 7 SCORED-NORMAL LIKEME7) (SMTSLEEP "sm-Hours sleep" :SINGLE "8" "0.692" 9 5 13 9 SCORED-NORMAL NUMBERTO12) (SMTSDEVE "sm-Managed self-change" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 6 7 7 SCORED-NORMAL LIKEME7) (SMTNPROC "sm-Start & complete big projects" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 7 7 7 SCORED-NORMAL LIKEME7) (SMTPTODO "sm-To-do list--all areas" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 8 7 7 SCORED-NORMAL LIKEME7) (SMTGOALS "sm-Objectives lists used" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 9 7 7 SCORED-NORMAL LIKEME7) (SMTSCHD "sm-Weekly schedule" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 10 7 7 SCORED-NORMAL LIKEME7) (SMT2DTOD "sm-2-D to-do lists--assignments" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 11 7 7 SCORED-NORMAL LIKEME7) (SMTACMPL "sm-High accomplishment, lo pressure" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 12 7 7 SCORED-NORMAL LIKEME7) (SMTGHELP "sm-Regular self-development habits" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 13 7 7 SCORED-NORMAL LIKEME7) (SMTBALAN "sm-Life area balance/satisfaction" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 14 7 7 SCORED-NORMAL LIKEME7) (SMTHABCH "sm-Take good advice--make changes" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 15 7 7 SCORED-NORMAL LIKEME7) :SCALE SEMOTCOP (COPNEGTH "cp-Not worry, neg thoughts" :SINGLE "Never/Almost never" "1.000" 6 1 6 6 SCORED-REVERSE PERCENT6COPEREVERSE) (COPCOPEA "cp-Not eat" :SINGLE "1 to 20 percent" "0.833" 5 2 6 5 SCORED-REVERSE PERCENT6COPEREVERSE) (COPPSOLV "cp-Face & problem solve" :SINGLE "81 to 100 percent" "1.000" 6 3 6 6 SCORED-NORMAL PERCENT6COPE) (COPAVOPS "cp-Not avoid thinking about-dealing w/problemNEW" :SINGLE "1 to 20 percent" "0.833" 5 4 6 5 SCORED-REVERSE PERCENT6COPEREVERSE) (COPEMOTA "cp-Not outward anger" :SINGLE "1 to 20 percent" "0.833" 5 5 6 5 SCORED-REVERSE PERCENT6COPEREVERSE) (COPBLAME "cp-Not blame others or self" :SINGLE "1 to 20 percent" "0.833" 5 6 6 5 SCORED-REVERSE PERCENT6COPEREVERSE) (COPWDRW "cp-Not withdraw from others" :SINGLE "1 to 20 percent" "0.833" 5 7 6 5 SCORED-REVERSE PERCENT6COPEREVERSE) (COPFUN "cp-Fun or involving activity" :SINGLE "81 to 100 percent" "1.000" 6 8 6 6 SCORED-NORMAL PERCENT6COPE) (COPTALKS "cp-Talk about problem" :SINGLE "81 to 100 percent" "1.000" 6 9 6 6 SCORED-NORMAL PERCENT6COPE) (COPPEPTA "cp-Positive thoughts-pep talk" :SINGLE "81 to 100 percent" "1.000" 6 10 6 6 SCORED-NORMAL PERCENT6COPE) (COPSMOKE "cp-Not smoke tobacco" :SINGLE "Never/Almost never" "1.000" 6 11 6 6 SCORED-REVERSE PERCENT6COPEREVERSE) (COPDRUG "cp-Not drink alcohol, street drugs,or meds" :SINGLE "Never/Almost never" "1.000" 6 12 6 6 SCORED-REVERSE PERCENT6COPEREVERSE) (COPPE "cp-Vigorous physical activity" :SINGLE "81 to 100 percent" "1.000" 6 13 6 6 SCORED-NORMAL PERCENT6COPE) (COPNEGPH "cp-Not critical-punative thoughts" :SINGLE "Never/Almost never" "1.000" 6 14 6 6 SCORED-REVERSE PERCENT6COPEREVERSE) (COPSELFB "cp-Not anger at self" :SINGLE "Never/Almost never" "1.000" 6 15 6 6 SCORED-REVERSE PERCENT6COPEREVERSE) (COPPOSPH "cp-Phil or religious viewpoint" :SINGLE "61 to 80 percent" "0.833" 5 16 6 5 SCORED-NORMAL PERCENT6COPE) (COPEXPEC "cp-Examine expectations" :SINGLE "61 to 80 percent" "0.833" 5 17 6 5 SCORED-NORMAL PERCENT6COPE) (COPHAPPY "cp-Think happy no matter what" :SINGLE "81 to 100 percent" "1.000" 6 18 6 6 SCORED-NORMAL PERCENT6COPE) (COPAVOAT "cp-Not miss work, school, etc-" :SINGLE "Less than once per year" "1.000" 7 19 7 7 SCORED-REVERSE FREQ7REVERSE) (COPSELFE "cp-Self-exploration enjoyment" :SINGLE "Extremely important to me" "1.000" 9 20 9 9 SCORED-NORMAL PRIORITY9) :SCALE INTSS1AASSERTCR (CR1ISSUE "cr-One issue at a time" :SINGLE "EXTREMELY accurate / like us" "1.000" 7 1 7 7 SCORED-NORMAL LIKEUS7) (CRRESOLV "cr-Rarely repeat arguments of same issue" :SINGLE "MILDLY accurate / like us" "0.714" 5 2 7 5 SCORED-NORMAL LIKEUS7) (CRNTHREA "cr-I rarely make threats" :SINGLE "MILDLY inaccurate / unlike us" "0.429" 3 3 7 3 SCORED-NORMAL LIKEUS7) (CRUNDERL "cr-Discuss underlying issues" :SINGLE "EXTREMELY accurate / like us" "1.000" 7 4 7 7 SCORED-NORMAL LIKEUS7) (CRWINWIN "cr-Discuss until win-win solution" :SINGLE "MODERATELY accurate / like us" "0.857" 6 5 7 6 SCORED-NORMAL LIKEUS7) (CRLONGTK "cr-Keep going until reach a solution" :SINGLE "MODERATELY accurate / like us" "0.857" 6 6 7 6 SCORED-NORMAL LIKEUS7) (CRSUMMAR "cr-I repeat summary" :SINGLE "MILDLY accurate / like us" "0.714" 5 7 7 5 SCORED-NORMAL LIKEUS7) (CRCPRAIS "cr-We laugh & praise during disagree" :SINGLE "MILDLY accurate / like us" "0.714" 5 8 7 5 SCORED-NORMAL LIKEUS7) (CRBOASSR "cr-Both assertive pos,firm,diplom" :SINGLE "EXTREMELY accurate / like us" "1.000" 7 9 7 7 SCORED-NORMAL LIKEUS7) (CROPHONE "cr-We open,nondefensive,honest" :SINGLE "EXTREMELY accurate / like us" "1.000" 7 10 7 7 SCORED-NORMAL LIKEUS7) (CRANGRES "cr-If one angry, other assertive back" :SINGLE "MODERATELY accurate / like us" "0.857" 6 11 7 6 SCORED-NORMAL LIKEUS7) (CRTLKMOR "cr-One partner not much more talkative" :SINGLE "MILDLY accurate / like us" "0.429" 3 12 7 3 SCORED-REVERSE LIKEUS7REVERSE) (CREQWIN "cr-Equal winning of disagreements" :SINGLE "MODERATELY accurate / like us" "0.857" 6 13 7 6 SCORED-NORMAL LIKEUS7) (INTUNDRL "in-We discuss underlying issues" :SINGLE "EXTREMELY accurate / like us" "1.000" 7 14 7 7 SCORED-NORMAL LIKEUS7) :SCALE INTSS1BOPENHON (INTTELAL "in-Told partner all about self" :SINGLE "EXTREMELY accurate / like us" "1.000" 7 1 7 7 SCORED-NORMAL LIKEUS7) (INTSMGOA "in-We agree on long term goals" :SINGLE "EXTREMELY accurate / like us" "1.000" 7 2 7 7 SCORED-NORMAL LIKEUS7) (INTEQDEC "in-Equality in decision influence" :SINGLE "MODERATELY accurate / like us" "0.857" 6 3 7 6 SCORED-NORMAL LIKEUS7) (INTIOPEN "in-We tell almost exactly what we thinking" :SINGLE "EXTREMELY accurate / like us" "1.000" 7 4 7 7 SCORED-NORMAL LIKEUS7) (INTWEOPN "in-We open, nondefensive,honest" :SINGLE "MODERATELY accurate / like us" "0.857" 6 5 7 6 SCORED-NORMAL LIKEUS7) (INTDAILY "in-Daily sharing of feelings on events" :SINGLE "EXTREMELY accurate / like us" "1.000" 7 6 7 7 SCORED-NORMAL LIKEUS7) (INTALLOP "in-Open, specific about sensitive issues" :SINGLE "EXTREMELY accurate / like us" "1.000" 7 7 7 7 SCORED-NORMAL LIKEUS7) (INTKNPFE "in-Not frequently don't know p- feelings" :SINGLE "EXTREMELY inaccurate / unlike us" "1.000" 7 8 7 7 SCORED-REVERSE LIKEUS7REVERSE) (INCOMTWO "id-Not-worries of other's commitment" :SINGLE "EXTREMELY inaccurate / unlike us" "1.000" 7 9 7 7 SCORED-REVERSE LIKEUS7REVERSE) :SCALE INTSS2ROMANTC (ROMSURPR "ro-Surprise p- once/week" :SINGLE "MILDLY accurate / like me" "0.714" 5 1 7 5 SCORED-NORMAL LIKEME7) (ROMFANTA "ro-Freq fantasies about p-" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 2 7 7 SCORED-NORMAL LIKEME7) (ROMCELEB "ro-Celebrate special days 1/month" :SINGLE "EXTREMELY accurate / like us" "1.000" 7 3 7 7 SCORED-NORMAL LIKEUS7) (ROMPLACE "ro-We go to romantic places 1/week" :SINGLE "MODERATELY accurate / like us" "0.857" 6 4 7 6 SCORED-NORMAL LIKEUS7) (ROMATTRA "ro-Sexually attracted to partner" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 5 7 7 SCORED-NORMAL LIKEME7) (ROMPLAYF "ro-Some playful interactions weekly" :SINGLE "EXTREMELY accurate / like us" "1.000" 7 6 7 7 SCORED-NORMAL LIKEUS7) (ROMCHARM "ro-Partner charming & romantic" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 7 7 7 SCORED-NORMAL LIKEME7) :SCALE INTSS3LIBROLE (LROMTASK "find" :SINGLE "MILDLY disagree" "0.714" 5 1 7 5 SCORED-REVERSE AGREE7REVERSE) (LROFTASK "find" :SINGLE "MODERATELY disagree" "0.857" 6 2 7 6 SCORED-REVERSE AGREE7REVERSE) (LRMFINAL "find" :SINGLE "EXTREMELY disagree" "1.000" 7 3 7 7 SCORED-REVERSE AGREE7REVERSE) (LROEMBAR "find" :SINGLE "EXTREMELY disagree" "1.000" 7 4 7 7 SCORED-REVERSE AGREE7REVERSE) (LROMSTRO "find" :SINGLE "EXTREMELY disagree" "1.000" 7 5 7 7 SCORED-REVERSE AGREE7REVERSE) (LROEQINC "find" :SINGLE "MODERATELY agree" "0.857" 6 6 7 6 SCORED-NORMAL AGREE7) (LRCARCON "find" :SINGLE "EXTREMELY disagree" "1.000" 7 7 7 7 SCORED-REVERSE AGREE7REVERSE) :SCALE INTSS4LOVERES (CRIFAVOR "cr-I do favors cheerfully when asked" :SINGLE "EXTREMELY accurate / like us" "1.000" 7 1 7 7 SCORED-NORMAL LIKEUS7) (CRIFOLUP "cr-I do what I tell partner" :SINGLE "EXTREMELY accurate / like us" "1.000" 7 2 7 7 SCORED-NORMAL LIKEUS7) (INTCOMIT "in-Not-commitment cause feel trapped" :SINGLE "EXTREMELY inaccurate / unlike us" "1.000" 7 3 7 7 SCORED-REVERSE LIKEUS7REVERSE) (INTRESPT "in-Respect partner above others" :SINGLE "EXTREMELY accurate / like us" "1.000" 7 4 7 7 SCORED-NORMAL LIKEUS7) (INTLSQPR "in-Tell of respect, love of p- to others" :SINGLE "EXTREMELY accurate / like us" "1.000" 7 5 7 7 SCORED-NORMAL LIKEUS7) (INTLOVE "in-I love partner very much" :SINGLE "EXTREMELY accurate / like us" "1.000" 7 6 7 7 SCORED-NORMAL LIKEUS7) (INNEVARG "id-Not-partners never disagree if happy" :SINGLE "EXTREMELY inaccurate / unlike us" "1.000" 7 7 7 7 SCORED-REVERSE LIKEUS7REVERSE) :SCALE INTSS5INDEP (INRLUNCH "id-Lunch with opposite sex OK" :SINGLE "MODERATELY accurate / like us" "0.857" 6 1 7 6 SCORED-NORMAL LIKEUS7) (INRINHAP "id-Marriage not greater than ind- happy" :SINGLE "MODERATELY inaccurate / unlike us" "0.857" 6 2 7 6 SCORED-REVERSE LIKEUS7REVERSE) (INRIGROW "id-I end relationship if can't grow" :SINGLE "UNCERTAIN, neutral, or midpoint" "0.571" 4 3 7 4 SCORED-NORMAL LIKEUS7) (INRSAYWE "id-Not say we'when mean 'I" :SINGLE "MODERATELY inaccurate / unlike us" "0.857" 6 4 7 6 SCORED-REVERSE LIKEUS7REVERSE) (INDIFGOA "id-Ok for different goals" :SINGLE "MODERATELY accurate / like us" "0.857" 6 5 7 6 SCORED-NORMAL LIKEUS7) (INFINDAN "id-Could be happy with another" :SINGLE "MODERATELY accurate / like us" "0.857" 6 6 7 6 SCORED-NORMAL LIKEUS7) (INENALON "id-Not-can't enjoy being w/o partner" :SINGLE "MODERATELY inaccurate / unlike us" "0.857" 6 7 7 6 SCORED-REVERSE LIKEUS7REVERSE) (INOKALON "id-Not-not happy if not partner" :SINGLE "MODERATELY inaccurate / unlike us" "0.857" 6 8 7 6 SCORED-REVERSE LIKEUS7REVERSE) (INRHATEA "id-Not-I hate to be alone" :SINGLE "EXTREMELY inaccurate / unlike us" "1.000" 7 9 7 7 SCORED-REVERSE LIKEUS7REVERSE) (INSEPINT "id-sep-interests" :SINGLE "EXTREMELY accurate / like us" "1.000" 7 10 7 7 SCORED-NORMAL LIKEUS7) (INRMONEY "id-SeparateFunds" :SINGLE "EXTREMELY accurate / like us" "1.000" 7 11 7 7 SCORED-NORMAL LIKEUS7) (INRBEALN "id-OK for weekends alone" :SINGLE "MODERATELY inaccurate / unlike us" "0.857" 6 12 7 6 SCORED-REVERSE LIKEUS7REVERSE) (INALCNST "id-Not consult for small decisions" :SINGLE "MODERATELY inaccurate / unlike us" "0.857" 6 13 7 6 SCORED-REVERSE LIKEUS7REVERSE) (INRFREEH "id-Free at home if partner there" :SINGLE "EXTREMELY accurate / like us" "1.000" 7 14 7 7 SCORED-NORMAL LIKEUS7) (INRFRIEN "id-P- has opposite sex social friends" :SINGLE "MODERATELY accurate / like us" "0.857" 6 15 7 6 SCORED-NORMAL LIKEUS7) :SCALE INTSS6POSSUP (CRNTHREA "cr-I rarely make threats" :SINGLE "MODERATELY accurate / like us" "0.857" 6 1 7 6 SCORED-NORMAL LIKEUS7) (CRNNEGLB "cr-I rarely use negative labels" :SINGLE "EXTREMELY accurate / like us" "1.000" 7 2 7 7 SCORED-NORMAL LIKEUS7) (CREXAGGR "cr-I not freq use 'always' or exaggeration" :SINGLE "EXTREMELY inaccurate / unlike us" "1.000" 7 3 7 7 SCORED-REVERSE LIKEUS7REVERSE) (CRANGANG "cr-If p-angry at me, I don't get angry-def" :SINGLE "MODERATELY inaccurate / unlike us" "0.857" 6 4 7 6 SCORED-REVERSE LIKEUS7REVERSE) (CRIPRAIS "cr-I not criticize more than praise p-" :SINGLE "EXTREMELY inaccurate / unlike us" "1.000" 7 5 7 7 SCORED-REVERSE LIKEUS7REVERSE) (CRANGRES "cr-If one angry, other assertive back" :SINGLE "MODERATELY accurate / like us" "0.857" 6 6 7 6 SCORED-NORMAL LIKEUS7) (INDIFDEC "id-Support p decision if disagree" :SINGLE "MODERATELY accurate / like us" "0.857" 6 7 7 6 SCORED-NORMAL LIKEUS7) (INSTSHLP "in-Partner helps if I under stress" :SINGLE "EXTREMELY accurate / like us" "1.000" 7 8 7 7 SCORED-NORMAL LIKEUS7) :SCALE INTSS7COLLAB (CRTKLONG "cr-Not one talk long before other" :SINGLE "MODERATELY accurate / like us" "0.286" 2 1 7 2 SCORED-REVERSE LIKEUS7REVERSE) (CRTEWEAK "cr-Not uncomfortable about tell weakness" :SINGLE "EXTREMELY inaccurate / unlike us" "1.000" 7 2 7 7 SCORED-REVERSE LIKEUS7REVERSE) (CRMANIPU "cr-Not feel me or partner manipulate" :SINGLE "EXTREMELY inaccurate / unlike us" "1.000" 7 3 7 7 SCORED-REVERSE LIKEUS7REVERSE) (CRREPRAI "cr-Partner gives more praise than criticism" :SINGLE "MODERATELY inaccurate / unlike us" "0.857" 6 4 7 6 SCORED-REVERSE LIKEUS7REVERSE) (CRTEACH "cr-Not problem teaching other" :SINGLE "MODERATELY inaccurate / unlike us" "0.857" 6 5 7 6 SCORED-REVERSE LIKEUS7REVERSE) (CRTLKMOR "cr-One partner not much more talkative" :SINGLE "MODERATELY accurate / like us" "0.286" 2 6 7 2 SCORED-REVERSE LIKEUS7REVERSE) (INTWKTOG "in-We enjoy working together" :SINGLE "UNCERTAIN, neutral, or midpoint" "0.571" 4 7 7 4 SCORED-REVERSE LIKEUS7REVERSE) :SCALE SCOLLEGE (STPARED "b-Highest parents educ level" :SINGLE "High school degree" "0.625" 5 1 8 5 SCORED-NORMAL STUPARENTSEDUC) (STUCLASS "st-Class level" :SINGLE "Unsure or Other" "0.100" 1 2 10 1 SCORED-NORMAL STUCLASSLEVEL) (STUDEGRE "st-Educ objective level" :SINGLE "Doctorate" "1.000" 7 3 7 7 SCORED-NORMAL STUDEGREEOBJECTIVE) (STUSEMES "st-Units this semester" :SINGLE "0" "0.083" 1 4 12 1 SCORED-NORMAL UNITS) (STMAJGPA "st-Major GPA" :SINGLE "3.5-4.0 (A)" "1.000" 8 5 8 8 SCORED-NORMAL GPA8ANSARRAY) (STACADST "st-AcadStatus" :SINGLE "President's List--over 3.5 GPA last semester" "1.000" 6 6 6 6 SCORED-NORMAL STUACADEMICSTATUS) :MULTI-SEL-QUEST "stucolle" (STUCOLLE :MULTI "stucolle" "st-College attending" 7 ("cocsulb" "1" 1 NIL 0 7 NIL) ("cccsu" "2" 1 NIL 0 7 NIL) ("coucal" "3" 1 NIL 0 7 NIL) ("coopublc" "4" 1 NIL 0 7 NIL) ("coprivca" "5" 1 NIL 0 7 NIL) ("coprivot" "6" 1 NIL 0 7 NIL) ("cocacomc" "7" 1 NIL 0 7 NIL) ("coothcc" "8" 1 NIL 0 7 NIL) ("coothnat" "9" 1 NIL 0 7 NIL) ("coprgrad" "10" 1 NIL 0 7 NIL) ("cotech" "11" 1 NIL 0 7 NIL) ("highsch" "12" 1 NIL 0 7 NIL) ("coother" "13" 1 T 1 7 NIL)) :MULTI-SEL-QUEST "stumajor" (STUMAJOR :MULTI "stumajor" "st-Major study area" 8 ("mlibart" "1" 1 NIL 0 8 NIL) ("msocsci" "2" 1 T 1 8 NIL) ("mbiolsci" "3" 1 NIL 0 8 NIL) ("mart" "4" 1 NIL 0 8 NIL) ("mnatsci" "5" 1 NIL 0 8 NIL) ("mbus" "6" 1 NIL 0 8 NIL) ("menginr" "7" 1 T 1 8 NIL) ("meducat" "8" 1 NIL 0 8 NIL) ("mmedical" "9" 1 NIL 0 8 NIL) ("motcompu" "10" 1 NIL 0 8 NIL) ("mothtech" "11" 1 NIL 0 8 NIL) ("mrecrpe" "12" 1 NIL 0 8 NIL) ("mdoesna" "13" 1 NIL 0 8 NIL) ("mundecid" "14" 1 NIL 0 8 NIL)) :MULTI-SEL-QUEST "stuspeci" (STUSPECI :MULTI "stuspeci" "st-Special status" 9 ("strancc" "1" 1 NIL 0 9 NIL) ("stran4yr" "2" 1 NIL 0 9 NIL) ("sadultre" "3" 1 NIL 0 9 NIL) ("seop" "4" 1 NIL 0 9 NIL) ("susimmig" "5" 1 NIL 0 9 NIL) ("svisa" "6" 1 NIL 0 9 NIL) ("shonor" "7" 1 NIL 0 9 NIL) ("svisastu" "8" 1 NIL 0 9 NIL) ("sdisabld" "9" 1 NIL 0 9 NIL) ("soutofst" "10" 1 NIL 0 9 NIL) ("smilitar" "11" 1 NIL 0 9 NIL) ("sathlete" "12" 1 NIL 0 9 NIL) ("snone" "13" 1 T 1 9 NIL)) :MULTI-SEL-QUEST "sturesid" (STURESID :MULTI "sturesid" "st-Residence" 10 ("rsinwpar" "1" 1 NIL 0 10 NIL) ("rsindorm" "2" 1 NIL 0 10 NIL) ("rsinwchl" "3" 1 NIL 0 10 NIL) ("rsinothr" "4" 1 NIL 0 10 NIL) ("rmarwoch" "5" 1 T 1 10 NIL) ("rmarwchl" "6" 1 NIL 0 10 NIL) ("rmarlike" "7" 1 NIL 0 10 NIL) ("rother" "8" 1 NIL 0 10 NIL)) :MULTI-SEL-QUEST "stgpatre" (STGPATRE :MULTI "stgpatre" "st-GPA Trends" 11 ("trconhi" "1" 1 T 1 11 NIL) ("trincryr" "2" 1 NIL 0 11 NIL) ("trincyru" "3" 1 NIL 0 11 NIL) ("trincyrs" "4" 1 NIL 0 11 NIL) ("trgradin" "5" 1 NIL 0 11 NIL) ("trconave" "6" 1 NIL 0 11 NIL) ("trdecyru" "7" 1 NIL 0 11 NIL) ("trdecyr" "8" 1 NIL 0 11 NIL) ("trconlow" "9" 1 NIL 0 11 NIL) ("trupandd" "10" 1 NIL 0 11 NIL) ("trother" "11" 1 NIL 0 11 NIL)) :MULTI-SEL-QUEST "sturesource" (STURESOURCE :MULTI "sturesource" "am-All interference factors" 12 ("afinanc" "1" 1 NIL 0 12 NIL) ("afampres" "2" 1 NIL 0 12 NIL) ("afamresp" "3" 1 NIL 0 12 NIL) ("aworktim" "4" 1 NIL 0 12 NIL) ("awrkpres" "5" 1 NIL 0 12 NIL) ("arelprob" "6" 1 NIL 0 12 NIL) ("aloneli" "7" 1 NIL 0 12 NIL) ("ahomstpl" "8" 1 NIL 0 12 NIL) ("aschstpl" "9" 1 NIL 0 12 NIL) ("acompavl" "10" 1 NIL 0 12 NIL) ("awrngcls" "11" 1 NIL 0 12 NIL) ("afacconn" "12" 1 NIL 0 12 NIL) ("astuconn" "13" 1 NIL 0 12 NIL) ("alowmotv" "14" 1 NIL 0 12 NIL) ("atimconf" "15" 1 T 1 12 NIL) ("aprocras" "16" 1 NIL 0 12 NIL)) :SCALE SSL1CONFIDEFFICSTUDYTEST (LRNUNASN "ld-Understand & begin assignments" :SINGLE "EXTREMELY inaccurate / unlike me" "1.000" 7 1 7 7 SCORED-REVERSE LIKEME7REVERSE) (LRNCOLMT "ld-Not made to feel not college material" :SINGLE "EXTREMELY inaccurate / unlike me" "1.000" 7 2 7 7 SCORED-REVERSE LIKEME7REVERSE) (LRNKNOWT "ld-Not know more than test" :SINGLE "EXTREMELY inaccurate / unlike me" "1.000" 7 3 7 7 SCORED-REVERSE LIKEME7REVERSE) (LRNPROOF "ld-Not unsure of un-proofed-by-other paper" :SINGLE "EXTREMELY inaccurate / unlike me" "1.000" 7 4 7 7 SCORED-REVERSE LIKEME7REVERSE) (LRNRREAD "ld-Not read texts 2-3 times to make sense" :SINGLE "EXTREMELY inaccurate / unlike me" "1.000" 7 5 7 7 SCORED-REVERSE LIKEME7REVERSE) (LRNEFFIC "ld-Not more time, lower grades" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 6 7 7 SCORED-NORMAL LIKEME7) (LRNTESTT "ld-Not test better if more time" :SINGLE "MODERATELY accurate / like me" "0.286" 2 7 7 2 SCORED-REVERSE LIKEME7REVERSE) (LRNTIMAS "ld-Not too much time on assignments" :SINGLE "UNCERTAIN, neutral, or midpoint" "0.571" 4 8 7 4 SCORED-REVERSE LIKEME7REVERSE) (LRNTIRED "ld-Not reading 1 hour make tired" :SINGLE "EXTREMELY inaccurate / unlike me" "1.000" 7 9 7 7 SCORED-REVERSE LIKEME7REVERSE) (LRNTANXI "ld-Not more anxiety about tests" :SINGLE "EXTREMELY inaccurate / unlike me" "1.000" 7 10 7 7 SCORED-REVERSE LIKEME7REVERSE) (LRNSMART "ld-Not smarter than grades indicate" :SINGLE "MILDLY accurate / like me" "0.429" 3 11 7 3 SCORED-REVERSE LIKEME7REVERSE) (LRNAREAD "ld-Not problem avoiding reading" :SINGLE "EXTREMELY inaccurate / unlike me" "1.000" 7 12 7 7 SCORED-REVERSE LIKEME7REVERSE) (LRNRSLOW "ld-Not slower reader" :SINGLE "EXTREMELY inaccurate / unlike me" "1.000" 7 13 7 7 SCORED-REVERSE LIKEME7REVERSE) :SCALE SSL1BCONFIDNOTAVOIDSTUDY (LRNUNASN "ld-Understand & begin assignments" :SINGLE "EXTREMELY inaccurate / unlike me" "1.000" 7 1 7 7 SCORED-REVERSE LIKEME7REVERSE) (LRNCOLMT "ld-Not made to feel not college material" :SINGLE "EXTREMELY inaccurate / unlike me" "1.000" 7 2 7 7 SCORED-REVERSE LIKEME7REVERSE) (LRNTIRED "ld-Not reading 1 hour make tired" :SINGLE "EXTREMELY inaccurate / unlike me" "1.000" 7 3 7 7 SCORED-REVERSE LIKEME7REVERSE) (LRNAREAD "ld-Not problem avoiding reading" :SINGLE "EXTREMELY inaccurate / unlike me" "1.000" 7 4 7 7 SCORED-REVERSE LIKEME7REVERSE) (LRNPROOF "ld-Not unsure of un-proofed-by-other paper" :SINGLE "EXTREMELY inaccurate / unlike me" "1.000" 7 5 7 7 SCORED-REVERSE LIKEME7REVERSE) :SCALE SSL2SATISCAMPUSFACFRIENDSGRDES (STULOOKF "sa-Look forward to campus" :SINGLE "MODERATELY accurate / like me" "0.857" 6 1 7 6 SCORED-NORMAL LIKEME7) (STULIKEI "sa-Like instructors-can talk" :SINGLE "MODERATELY accurate / like me" "0.857" 6 2 7 6 SCORED-NORMAL LIKEME7) (STUCOMFO "sa-Comfortable w/ area fac & students" :SINGLE "MILDLY accurate / like me" "0.714" 5 3 7 5 SCORED-NORMAL LIKEME7) (STUFRIEN "sa-Current school friends" :SINGLE "MODERATELY accurate / like me" "0.857" 6 4 7 6 SCORED-NORMAL LIKEME7) (STUENJOY "sa-Enjoy learning, classes, homework" :SINGLE "MODERATELY accurate / like me" "0.857" 6 5 7 6 SCORED-NORMAL LIKEME7) (STUEACTR "sa-Enjoying life and fun in school" :SINGLE "MODERATELY accurate / like me" "0.857" 6 6 7 6 SCORED-NORMAL LIKEME7) (STHAPCOL "sa-Overall college exper happiness" :SINGLE "MODERATELY accurate / like me" "0.857" 6 7 7 6 SCORED-NORMAL LIKEME7) (STHAPGPA "sa-Happiness with grades" :SINGLE "MODERATELY accurate / like me" "0.857" 6 8 7 6 SCORED-NORMAL LIKEME7) :SCALE SSL3WRITEREADSKILLS (LRNWRPAP "la-A's on term papers" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 1 7 7 SCORED-NORMAL LIKEME7) (LRNWRSKL "la-Satisfied with writing skills" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 2 7 7 SCORED-NORMAL LIKEME7) (LRNSEE "la-No vision problems" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 3 7 7 SCORED-NORMAL LIKEME7) (LRNVOCAB "la-No vocabulary problems reading" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 4 7 7 SCORED-NORMAL LIKEME7) (LRNWRORG "la-Organizing writing good" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 5 7 7 SCORED-NORMAL LIKEME7) (LRNSREAD "la-Not read slower" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 6 7 1 SCORED-NORMAL LIKEME7) :SCALE SSL4BLDMENTALSTRUCT (LRNTXUND "lh-Stop to understand readings" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 1 7 7 SCORED-NORMAL LIKEME7) (LRNINTER "lh-If text boring, make interesting" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 2 7 7 SCORED-NORMAL LIKEME7) (LRNROTE "lh-New view--not rote methods" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 3 7 7 SCORED-NORMAL LIKEME7) (LRNASSOC "lh-Try to create associations" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 4 7 7 SCORED-NORMAL LIKEME7) (LRNSTRUG "lh-Struggle with difficult material" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 5 7 7 SCORED-NORMAL LIKEME7) (LRNTHEOR "lh-Build own theories" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 6 7 7 SCORED-NORMAL LIKEME7) (LRNALONE "lh-Study alone-minimal help" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 7 7 7 SCORED-NORMAL LIKEME7) :SCALE SSL5BASICSTUDYSKILLS (ACMCONCE "am-Great task-HW concentration" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 1 7 7 SCORED-NORMAL LIKEME7) (LRNTXOVE "lh-Prevew, points, review chapters" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 2 7 7 SCORED-NORMAL LIKEME7) (LRNTSREV "lh-Review 3 times before exam" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 3 7 7 SCORED-NORMAL LIKEME7) (LRNMAP "lh-Create visual map of readings" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 4 7 7 SCORED-NORMAL LIKEME7) (LRNTXOUT "la-Outline textbooks" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 5 7 7 SCORED-NORMAL LIKEME7) (LRNNOTES "la-Good class notes" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 6 7 7 SCORED-NORMAL LIKEME7) :SCALE SSL6SELFMANACADGOALS (ACMCOMPL "am-Confident will complete degree" :SINGLE "Extremely confident" "1.000" 7 1 7 7 SCORED-NORMAL CONFIDENCE7) (ACMQUITC "am-Won't drop out in year" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 2 7 7 SCORED-NORMAL LIKEME7) (ACMFINAN "am-Confidence school finances" :SINGLE "Extremely confident" "1.000" 7 3 7 7 SCORED-NORMAL CONFIDENCE7) (ACMDEGRE "am-Motivation for degree" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 4 7 7 SCORED-NORMAL LIKEME7) (STUCONFU "sa-NotConfused why I am in college" :SINGLE "EXTREMELY accurate / like me" "0.143" 1 5 7 1 SCORED-REVERSE LIKEME7REVERSE) (ACMSELFS "am-Self-manage college life well" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 6 7 7 SCORED-NORMAL LIKEME7) :SCALE SSL7MATHSCIPRINC (LRNMATH "la-Enjoy & good at math" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 1 7 7 SCORED-NORMAL LIKEME7) (LRNTEXTN "lh-Math science seek basic principles" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 2 7 7 SCORED-NORMAL LIKEME7) :SCALE SSL8STUDYENVIR (ACMEFAML "am-HW encouraged by fam & friends" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 1 7 7 SCORED-NORMAL LIKEME7) (ACMESOCS "am-No chores if conflict w HW" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 2 7 7 SCORED-NORMAL LIKEME7) (LRNESTUD "lh-Good study place w/o distract" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 3 7 7 SCORED-NORMAL LIKEME7) :SCALE SSL9ATTENDHW (ACMSTUDY "Study time per class hour" :SINGLE "1 to 2 hours per class hour" "0.500" 3 1 6 3 SCORED-NORMAL ACMSTUDYANSARRAY) (ACMNDROP "am-Never drop or take incomplete" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 2 7 7 SCORED-NORMAL LIKEME7) (ACMATTEN "am-Attendance & do homework" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 3 7 7 SCORED-NORMAL LIKEME7) :SCALE SSL10MEMNOTANX (LRNMEMOR "la-Memory for terms,formulas,facts" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 1 7 7 SCORED-NORMAL LIKEME7) (LRNTENSE "la-Rarely tense in exams" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 2 7 7 SCORED-NORMAL LIKEME7) (LRNSEFIC "la-Learning time efficient" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 3 7 7 SCORED-NORMAL LIKEME7) :SCALE SSL11NOTNONACADMOT (STUEXTMO "sa-NotParents expectations main motive" :SINGLE "MILDLY inaccurate / unlike me" "0.714" 5 1 7 5 SCORED-REVERSE LIKEME7REVERSE) (STUMONEYNEW "sa-Money main motive" :SINGLE "MILDLY accurate / like me" "0.714" 5 2 7 5 SCORED-NORMAL LIKEME7) (STUCONFU "sa-NotConfused why I am in college" :SINGLE "EXTREMELY inaccurate / unlike me" "1.000" 7 3 7 7 SCORED-REVERSE LIKEME7REVERSE) (STUFINDE "sa-Financial support" :SINGLE "Family support and work" "0.500" 3 4 6 3 SCORED-NORMAL STUFINDEPEND) (STUCAREE "sa-Career-job main motive" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 5 7 7 SCORED-NORMAL LIKEME7) :SCALE SSL12STDYTMAVAIL (ACMTIME "am-Time available to study" :SINGLE "EXTREMELY inaccurate / unlike me" "1.000" 7 1 7 7 SCORED-REVERSE LIKEME7REVERSE) :SCALE SSL13VERBALAPT (STUVERBA "st-Verbal aptitude scores" :SINGLE "Greater than 90 percent" "1.000" 10 1 10 10 SCORED-NORMAL PERCENTILE10) :SCALE SSL14MATHAPT (STUMATHA "st-Math aptitude scores" :SINGLE "Greater than 90 percent" "1.000" 10 1 10 10 SCORED-NORMAL PERCENTILE10) :SCALE SINCAR (CAR1CARG "ca-Great time and thorough career plan process" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 1 7 7 SCORED-NORMAL LIKEME7) (CAR1CARP "ca-Have goal,plan,likely success" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 2 7 7 SCORED-NORMAL LIKEME7) (CAR1INAT "ca-Natural science" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 3 7 7 SCORED-NORMAL LIKEME7) (CARIBIOH "ca-Biological science" :SINGLE "UNCERTAIN, neutral, or midpoint" "0.571" 4 4 7 4 SCORED-NORMAL LIKEME7) (CARISOCS "ca-Learn about self & people" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 5 7 7 SCORED-NORMAL LIKEME7) (CARIHELP "ca-Helping people-teach coun etc" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 6 7 7 SCORED-NORMAL LIKEME7) (CARIMATH "ca-Math" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 7 7 7 SCORED-NORMAL LIKEME7) (CARIMED "ca-Medical-related" :SINGLE "MILDLY accurate / like me" "0.714" 5 8 7 5 SCORED-NORMAL LIKEME7) (CARIWRIT "ca-Writing-related" :SINGLE "MODERATELY inaccurate / unlike me" "0.286" 2 9 7 2 SCORED-NORMAL LIKEME7) (CARIFNAR "ca-Fine art-related" :SINGLE "MODERATELY inaccurate / unlike me" "0.286" 2 10 7 2 SCORED-NORMAL LIKEME7) (CARIETHN "ca-Ethnic studies-women" :SINGLE "MODERATELY inaccurate / unlike me" "0.286" 2 11 7 2 SCORED-NORMAL LIKEME7) (CARILEAR "ca-Love higher ed" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 12 7 7 SCORED-NORMAL LIKEME7) (CARIEXPE "ca-Want to be expert" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 13 7 7 SCORED-NORMAL LIKEME7) (CARIGENE "ca-Love variety-know little about many" :SINGLE "MODERATELY accurate / like me" "0.857" 6 14 7 6 SCORED-NORMAL LIKEME7) (CARINOIN "ca-Never interest in school" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 15 7 1 SCORED-NORMAL LIKEME7) (CARILIT "ca-Literature-history" :SINGLE "MODERATELY inaccurate / unlike me" "0.286" 2 16 7 2 SCORED-NORMAL LIKEME7) (CARIRECP "ca-Sports-rec helping others w/sports" :SINGLE "MODERATELY inaccurate / unlike me" "0.286" 2 17 7 2 SCORED-NORMAL LIKEME7) (CARIPOLI "ca-Law politics government" :SINGLE "MILDLY inaccurate / unlike me" "0.429" 3 18 7 3 SCORED-NORMAL LIKEME7) (CARIMIL6 "ca-Law enforcement military etc" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 19 7 1 SCORED-NORMAL LIKEME7) (CARIMANU "ca-Manual-tech electr computers etc-" :SINGLE "MODERATELY accurate / like me" "0.857" 6 20 7 6 SCORED-NORMAL LIKEME7) (CARILANG "ca-Languages travel etc" :SINGLE "MILDLY inaccurate / unlike me" "0.429" 3 21 7 3 SCORED-NORMAL LIKEME7) (CARIPHIL "ca-Philosophy-religion" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 22 7 7 SCORED-NORMAL LIKEME7) (CARIBUSI "ca-Business" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 23 7 1 SCORED-NORMAL LIKEME7) (CARIENGI "ca-Engineering sci design" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 24 7 7 SCORED-NORMAL LIKEME7) (CARIFAMC "ca-Family & Consumer Sci" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 25 7 1 SCORED-NORMAL LIKEME7) (CARIWOMA "ca-Ethnic-women" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 26 7 1 SCORED-NORMAL LIKEME7) (CARICOM8 "ca-Computer-related" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 27 7 7 SCORED-NORMAL LIKEME7) (CARINTE0 "ca-Interdisciplinary" :SINGLE "MODERATELY accurate / like me" "0.857" 6 28 7 6 SCORED-NORMAL LIKEME7) :SCALE SINBUS (CARIBMAR "cb-Marketing" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 1 7 1 SCORED-NORMAL LIKEME7) (CARIBMAN "cb-Management" :SINGLE "MILDLY accurate / like me" "0.714" 5 2 7 5 SCORED-NORMAL LIKEME7) (CARIBINF "cb-Inform Systems" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 3 7 7 SCORED-NORMAL LIKEME7) (CARIBFIN "cb-Finance" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 4 7 1 SCORED-NORMAL LIKEME7) (CARIBHRD "cb-Human Resources" :SINGLE "MILDLY inaccurate / unlike me" "0.429" 3 5 7 3 SCORED-NORMAL LIKEME7) (CARIBACC "cb-Accounting" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 6 7 1 SCORED-NORMAL LIKEME7) (CARISPBU "cb-Public Relations" :SINGLE "MILDLY accurate / like me" "0.714" 5 7 7 5 SCORED-NORMAL LIKEME7) :SCALE SINENGR (CARIEENG "ce-Elect Engr" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 1 7 7 SCORED-NORMAL LIKEME7) (CARIME "ce-Mech Engr" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 2 7 7 SCORED-NORMAL LIKEME7) (CARICHE2 "ce-Chem Engr" :SINGLE "MODERATELY inaccurate / unlike me" "0.286" 2 3 7 2 SCORED-NORMAL LIKEME7) (CARICIVE "ce-Cival Engr" :SINGLE "MILDLY accurate / like me" "0.714" 5 4 7 5 SCORED-NORMAL LIKEME7) (CARIAERO "ce-Aerospace Engr" :SINGLE "MILDLY inaccurate / unlike me" "0.429" 3 5 7 3 SCORED-NORMAL LIKEME7) (CARIEITE "ce-Engr Tech" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 6 7 1 SCORED-NORMAL LIKEME7) (CARICOM9 "ce-Computer Engr" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 7 7 7 SCORED-NORMAL LIKEME7) (CARIBCOM "ce-Bus Computer" :SINGLE "MODERATELY inaccurate / unlike me" "0.286" 2 8 7 2 SCORED-NORMAL LIKEME7) :SCALE SINFINEA (CARIMUSI "cart-Music" :SINGLE "MODERATELY inaccurate / unlike me" "0.286" 2 1 7 2 SCORED-NORMAL LIKEME7) (CARIART "cart-Art" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 2 7 1 SCORED-NORMAL LIKEME7) (CARIDRAM "cart-Theatre Arts" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 3 7 1 SCORED-NORMAL LIKEME7) (CARIDANC "cart-Dance" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 4 7 1 SCORED-NORMAL LIKEME7) (CARIPHOT "cart-Photog or Ph Journ" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 5 7 1 SCORED-NORMAL LIKEME7) (CARINDDE "cart-Indust Design" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 6 7 1 SCORED-NORMAL LIKEME7) (CARINTE1 "cart-Interior Design" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 7 7 1 SCORED-NORMAL LIKEME7) :SCALE SINHELP (CARITEAC "ch-Teaching" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 1 7 7 SCORED-NORMAL LIKEME7) (CARICOUN "ch-Counseling" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 2 7 7 SCORED-NORMAL LIKEME7) (CARIEDUC "ch-Education" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 3 7 7 SCORED-NORMAL LIKEME7) (CARIHADU "ch-Help Adults" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 4 7 7 SCORED-NORMAL LIKEME7) (CARIHCHI "ch-Help children-teens" :SINGLE "MODERATELY inaccurate / unlike me" "0.286" 2 5 7 2 SCORED-NORMAL LIKEME7) (CARITVOC "ch-Voc Ed" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 6 7 1 SCORED-NORMAL LIKEME7) (CARICOM4 "ch-Speech-hearing" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 7 7 1 SCORED-NORMAL LIKEME7) (CARSOCWO "ch-Social Work" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 8 7 1 SCORED-NORMAL LIKEME7) (CARK12TE "ch-Teach K-12" :SINGLE "MILDLY inaccurate / unlike me" "0.429" 3 9 7 3 SCORED-NORMAL LIKEME7) (CARMINIS "ch-Minister-priest" :SINGLE "MODERATELY accurate / like me" "0.857" 6 10 7 6 SCORED-NORMAL LIKEME7) :SCALE SINLANG (CARIFREN "cl-French" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 1 7 1 SCORED-NORMAL LIKEME7) (CARIITAL "cl-Italian" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 2 7 1 SCORED-NORMAL LIKEME7) (CARIGERM "cl-German" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 3 7 1 SCORED-NORMAL LIKEME7) (CARIRUSS "cl-Russian" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 4 7 1 SCORED-NORMAL LIKEME7) (CARIJAPN "cl-Japanese" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 5 7 1 SCORED-NORMAL LIKEME7) (CARICHIN "cl-Chinese" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 6 7 1 SCORED-NORMAL LIKEME7) (CARICLAS "cl-Classic Lang" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 7 7 1 SCORED-NORMAL LIKEME7) (CARISPAN "cl-Spanish" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 8 7 1 SCORED-NORMAL LIKEME7) (CARIPOR "cl-Portugese" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 9 7 1 SCORED-NORMAL LIKEME7) :SCALE SINMED (CARIMD "cm-Physician" :SINGLE "MILDLY inaccurate / unlike me" "0.429" 3 1 7 3 SCORED-NORMAL LIKEME7) (CARINURS "cm-Nurse" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 2 7 1 SCORED-NORMAL LIKEME7) (CARIPTHE "cm-Phys Therapy" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 3 7 1 SCORED-NORMAL LIKEME7) (CARIHEAL "cm-Health Science" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 4 7 1 SCORED-NORMAL LIKEME7) (CARIKINE "cm-Kinesiology" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 5 7 1 SCORED-NORMAL LIKEME7) (CARICOM5 "cm-Commicative Dis" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 6 7 1 SCORED-NORMAL LIKEME7) (CARMEDTE "cm-Med Tech/imaging" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 7 7 1 SCORED-NORMAL LIKEME7) :SCALE SINMILTC (CARILAW "cleg-Law" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 1 7 1 SCORED-NORMAL LIKEME7) (CARICRIM "cleg-Law enforcement" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 2 7 1 SCORED-NORMAL LIKEME7) (CARIMIL7 "cleg-Military" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 3 7 1 SCORED-NORMAL LIKEME7) :SCALE INNATSCI (CARICHE3 "cn-Chemistry" :SINGLE "MODERATELY inaccurate / unlike me" "0.286" 2 1 7 2 SCORED-NORMAL LIKEME7) (CARIPHYS "cn-Physics" :SINGLE "MILDLY accurate / like me" "0.714" 5 2 7 5 SCORED-NORMAL LIKEME7) (CARIGEOL "cn-Geology" :SINGLE "MODERATELY inaccurate / unlike me" "0.286" 2 3 7 2 SCORED-NORMAL LIKEME7) (CARIASTR "cn-Astronomy" :SINGLE "MODERATELY inaccurate / unlike me" "0.286" 2 4 7 2 SCORED-NORMAL LIKEME7) (CARIENVI "cn-Environmental Sci" :SINGLE "MODERATELY inaccurate / unlike me" "0.286" 2 5 7 2 SCORED-NORMAL LIKEME7) :SCALE SINSOCSC (CARIPSYC "cs-Psychology" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 1 7 7 SCORED-NORMAL LIKEME7) (CARISOCO "cs-Sociology" :SINGLE "MODERATELY accurate / like me" "0.857" 6 2 7 6 SCORED-NORMAL LIKEME7) (CARIHIST "cs-History" :SINGLE "MILDLY inaccurate / unlike me" "0.429" 3 3 7 3 SCORED-NORMAL LIKEME7) (CARIPOLS "cs-Political Science" :SINGLE "UNCERTAIN, neutral, or midpoint" "0.571" 4 4 7 4 SCORED-NORMAL LIKEME7) (CARIECON "cs-Economics" :SINGLE "MILDLY inaccurate / unlike me" "0.429" 3 5 7 3 SCORED-NORMAL LIKEME7) (CARGEOGR "cs-Geography" :SINGLE "MODERATELY inaccurate / unlike me" "0.286" 2 6 7 2 SCORED-NORMAL LIKEME7) (CARIAMER "cs-American Studies" :SINGLE "MODERATELY inaccurate / unlike me" "0.286" 2 7 7 2 SCORED-NORMAL LIKEME7) (CARIANTR "cs-Anthropology???-AntR not AntH" :SINGLE "MODERATELY inaccurate / unlike me" "0.286" 2 8 7 2 SCORED-NORMAL LIKEME7) (CARIANTH "cs-Anthropology" :SINGLE "MODERATELY inaccurate / unlike me" "0.286" 2 9 7 2 SCORED-NORMAL LIKEME7) (CARISPEE "cs-Speech-Commun" :SINGLE "MODERATELY inaccurate / unlike me" "0.286" 2 10 7 2 SCORED-NORMAL LIKEME7) (CARLING "cs-Linguistics" :SINGLE "MODERATELY inaccurate / unlike me" "0.286" 2 11 7 2 SCORED-NORMAL LIKEME7) :SCALE SINWOETH (CARIAIST "cs-Native Amer Studies" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 1 7 1 SCORED-NORMAL LIKEME7) (CARIBSTU "cs-African Amer Studies" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 2 7 1 SCORED-NORMAL LIKEME7) (CARIMEXA "cs-Mexican Amer Studies" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 3 7 1 SCORED-NORMAL LIKEME7) (CARIASAM "cs-Asian Amer Studies" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 4 7 1 SCORED-NORMAL LIKEME7) (CARIAMST "cs-American Studies" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 5 7 1 SCORED-NORMAL LIKEME7) (CARIWSTU "cs-Women's Studies" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 6 7 1 SCORED-NORMAL LIKEME7) :SCALE SINWRITE (CARIENGL "cw-English" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 1 7 1 SCORED-NORMAL LIKEME7) (CARIJOUR "cw-Journalism" :SINGLE "EXTREMELY inaccurate / unlike me" "0.143" 1 2 7 1 SCORED-NORMAL LIKEME7) :SCALE NO-SCALE (BIO5INCO "b-Highest personal income" :SINGLE "$150,000 to $200,000" "0.909" 10 1 11 10 SCORED-NORMAL BIO5INCOANSARRAY) :SCALE SEHAPPY (HAPCLFRN "h-Happy w/ number & closeness of friends" :SINGLE "Extremely happy" "1.000" 7 1 7 7 SCORED-NORMAL HAPPY7) (HAPCARNW "h-Happy w/ my career now" :SINGLE "Extremely happy" "1.000" 7 2 7 7 SCORED-NORMAL HAPPY7) (HAPCARFU "h-Happy w/ future career expectations" :SINGLE "Extremely happy" "1.000" 7 3 7 7 SCORED-NORMAL HAPPY7) (HAPFRIEN "h-Happy w/ friendships" :SINGLE "Extremely happy" "1.000" 7 4 7 7 SCORED-NORMAL HAPPY7) (HAPAREA "h-Happy living in area, home" :SINGLE "Extremely happy" "1.000" 7 5 7 7 SCORED-NORMAL HAPPY7) (HAPWKREL "h-Happy w/ work-school relationships" :SINGLE "Extremely happy" "1.000" 7 6 7 7 SCORED-NORMAL HAPPY7) (HAPPE "h-Happy w/ physical activity" :SINGLE "Extremely happy" "1.000" 7 7 7 7 SCORED-NORMAL HAPPY7) (HAPRECRE "h-Happy w/ recreation" :SINGLE "Extremely happy" "1.000" 7 8 7 7 SCORED-NORMAL HAPPY7) (HAPSEXRE "h-Happy w/ sex/romance" :SINGLE "Extremely happy" "1.000" 7 9 7 7 SCORED-NORMAL HAPPY7) (HAPFAMIL "h-Happy w/ family relationships" :SINGLE "Extremely happy" "1.000" 7 10 7 7 SCORED-NORMAL HAPPY7) (HAPSELFD "h-Happy w/ self & development" :SINGLE "Extremely happy" "1.000" 7 11 7 7 SCORED-NORMAL HAPPY7) (HAPSPIRI "h-Happy w/ meaning & spiritual/religious" :SINGLE "Extremely happy" "1.000" 7 12 7 7 SCORED-NORMAL HAPPY7) (HAPYEAR "h-Happiness during past year" :SINGLE "Extremely happy" "1.000" 7 13 7 7 SCORED-NORMAL HAPPY7) (HAP3YEAR "h-Happiness 1-3 years ago" :SINGLE "Extremely happy" "1.000" 7 14 7 7 SCORED-NORMAL HAPPY7) (HAPLIFE "h-Happiness up to 3 years ago" :SINGLE "Extremely happy" "1.000" 7 15 7 7 SCORED-NORMAL HAPPY7) (HAPEXPEC "h-Happiness expected in future" :SINGLE "Extremely happy" "1.000" 7 16 7 7 SCORED-NORMAL HAPPY7) :SCALE SRDEPRES (RDEPFEEL "de-Not often sad,apathetic,depressed" :SINGLE "EXTREMELY inaccurate / unlike me" "1.000" 7 1 7 7 SCORED-REVERSE LIKEME7REVERSE) (RDEPTHOU "de-Not worthless, very neg a-death,etc" :SINGLE "EXTREMELY inaccurate / unlike me" "1.000" 7 2 7 7 SCORED-REVERSE LIKEME7REVERSE) (RDEPDYSS "de-RevDysthemia symptoms checklist" :SINGLE "Never/Not at all" "1.000" 11 3 11 11 SCORED-REVERSE DURATION11REVERSE) (RDEPMAJS "de-RevMajor depression symptoms chkl" :SINGLE "Never/None" "1.000" 9 4 9 9 SCORED-REVERSE EPISODEFREQ9REVERSE) (RDEPMEDS "de-RevLength of time meds for depression" :SINGLE "Never/Not at all" "1.000" 11 5 11 11 SCORED-REVERSE DURATION11REVERSE) (RDEPTHER "de-RevAmount of therapy for depression" :SINGLE "Never/None" "1.000" 9 6 9 9 SCORED-REVERSE EPISODEFREQ9REVERSE) :SCALE SRANXIET (RANXPERF "ax-RevPerformance anxiety level" :SINGLE "EXTREMELY inaccurate / unlike me" "1.000" 7 1 7 7 SCORED-REVERSE LIKEME7REVERSE) (RANXALLT "ax-Not feel anxious almost all time" :SINGLE "EXTREMELY inaccurate / unlike me" "1.000" 7 2 7 7 SCORED-REVERSE LIKEME7REVERSE) (RANXPSTD "ax-RevPSTD symptoms chkl" :SINGLE "EXTREMELY inaccurate / unlike me" "1.000" 7 3 7 7 SCORED-REVERSE LIKEME7REVERSE) (RANXSOCI "ax-RevAnxiety with other people" :SINGLE "EXTREMELY inaccurate / unlike me" "1.000" 7 4 7 7 SCORED-REVERSE LIKEME7REVERSE) (RANXOCD "ax-RevTimes lasting OCD problems" :SINGLE "Never/None" "1.000" 9 5 9 9 SCORED-REVERSE EPISODEFREQ9REVERSE) (RANXPHOB "ax-RevNumber of phobias" :SINGLE "0" "1.000" 13 6 13 13 SCORED-REVERSE NUMBERTO12REVERSE) (RANXPANI "ax-RevNumber of panic attacks" :SINGLE "0" "1.000" 13 7 13 13 SCORED-REVERSE NUMBERTO12REVERSE) (RANXTHER "ax-Amount of therapy for anxiety" :SINGLE "Never/None" "1.000" 9 8 9 9 SCORED-REVERSE EPISODEFREQ9REVERSE) (RANXMEDS "ax-RevTime meds for anxiety DEPRESSION?" :SINGLE "Never/Not at all" "1.000" 11 9 11 11 SCORED-REVERSE DURATION11REVERSE) :SCALE SRANGAGG (RANGFEEL "ag-RevFreq lose temper" :SINGLE "1 to 5 per month" "0.625" 5 1 8 5 SCORED-REVERSE FREQ8REVERSE) (RANGYELL "ag-RevFreq yell or call hurtful names" :SINGLE "Less than 1 per month" "0.750" 6 2 8 6 SCORED-REVERSE FREQ8REVERSE) (RANGDOMI "ag-RevFreq get way by [aggression]" :SINGLE "Less than 1 per month" "0.750" 6 3 8 6 SCORED-REVERSE FREQ8REVERSE) (RANGTHOU "ag-RevFreq think about get even" :SINGLE "Less than 1 per month" "0.750" 6 4 8 6 SCORED-REVERSE FREQ8REVERSE) (RANGDEST "ag-RevFreq damage prop etc/break law" :SINGLE "Never/None" "1.000" 8 5 8 8 SCORED-REVERSE FREQ8REVERSE) :SCALE SRELHLTH (RHLFREQI "he-LoFreq of illness past 3 years" :SINGLE "About 1-3 per year" "0.857" 6 1 7 6 SCORED-REVERSE FREQ7REVERSE) (RHLALCOH "he-LoFreq of alcohol drinks" :SINGLE "1-6 per week" "0.500" 4 2 8 4 SCORED-REVERSE FREQ8REVERSE) (RHLSMOKE "he-LoFreq of cigarrettes" :SINGLE "Never/None" "1.000" 8 3 8 8 SCORED-REVERSE FREQ8REVERSE) (RHLDRUGS "he-LoFreq of illegal drugs" :SINGLE "Never/None" "1.000" 8 4 8 8 SCORED-REVERSE FREQ8REVERSE) (RHLPHYSI "he-Physical conditioning level" :SINGLE "Excellent for competitive athlete" "1.000" 9 5 9 9 SCORED-NORMAL RHLPHYSIANSARRAY) (RHLWEIGH "he-LoWeight" :SINGLE "Ideal for my height" "1.000" 10 6 10 10 SCORED-NORMAL RHLWEIGHANSARRAY) :SCALE SRPEOPLE (RPEHAPFR "re-Friends happy-successful" :SINGLE "EXTREMELY accurate / like me" "1.000" 7 1 7 7 SCORED-NORMAL LIKEME7) (RPEHMARR "re-Have or had happy marital rel" :SINGLE "EXTREMELY agree" "1.000" 8 2 8 8 SCORED-NORMAL LIKEME8NOTAPPLY) (RPENETW "re-Close network of friends & career-rel" :SINGLE "MODERATELY accurate / like me" "0.857" 6 3 7 6 SCORED-NORMAL LIKEME7) (RPECLFRN "re-Have/had friends share innermost" :SINGLE "MODERATELY accurate / like me" "0.857" 6 4 7 6 SCORED-NORMAL LIKEME7) (RPENUMFR "re-Number friends socialize 1/month" :SINGLE "3-4" "0.250" 3 5 12 3 SCORED-NORMAL NUMBERBY2) (RPENUMCL "re-Number extremely close friends" :SINGLE "7-8" "0.417" 5 6 12 5 SCORED-NORMAL NUMBERBY2) (RPECOMMI "re-Degree of commit to 3 mo romantic" :SINGLE "Married--extremely high commitment" "1.000" 13 7 13 13 SCORED-NORMAL RPECOMMITANSARRAY) :SCALE SUSERFEEDBACK (USERRATE "UserRate" :SINGLE "Very interesting/beneficial" "1.000" 7 1 7 7 SCORED-NORMAL USERRATE7) :DATE "3.3.2020" :TIME "12:14") (:SHAQ-SCALEDATA-LIST (:TEXT-DATA "sID" ("UserID" "555555" :SINGLE "555555") ("Sex" "Male" :SINGLE "Male" 1) ("Age" 78 :SINGLE 78 78) ("USA?" "USA" :SINGLE "USA" 1) ("Nation" "USA" :SINGLE "USA") ("ZipCode" 92260 :SINGLE 92260) ("HrsWork" 78 :SINGLE 78 78)) :MULTI-SEL-QUEST "utype" ("UTYPE" :MULTI "utype" "UserType" 1 ("twanttho" "1" 1 T 1 1 (:XDATA :SCALES (HQ))) ("tknowmor" "2" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("twanthel" "3" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("twantspe" "4" 1 NIL 0 1 (:XDATA :SCALES NIL)) ("texperie" "5" 1 NIL 0 1 (:XDATA :SCALES NIL)) ("tprevshaq" "6" 1 NIL 0 1 (:XDATA :SCALES (PREVIOUS-USER))) ("wantspq" "7" 1 NIL 0 1 (:XDATA :SCALES (SPECIFIC-QUESTS))) ("tu100stu" "8" 1 NIL 0 1 (:XDATA :SCALES (HQ ACAD-LEARNING))) ("tcsulbst" "9" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING))) ("tcolstu" "10" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING))) ("totherst" "11" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING))) ("tressub" "12" 1 NIL 0 1 (:XDATA :SCALES NIL)) ("tcolfaca" "13" 1 NIL 0 1 (:XDATA :SCALES NIL)) ("u-none" "14" 1 NIL 0 1 (:XDATA :SCALES NIL))) :MULTI-SEL-QUEST "ugoals" ("UGOALS" :MULTI "ugoals" "UserGoals" 1 ("gsuchap" "1" 1 T 1 1 (:XDATA :SCALES (HQ))) ("gemocop" "2" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("gslfest" "3" 1 NIL 0 1 (:XDATA :SCALES (VALUES-THEMES BELIEFS SKILLS-CONFIDENCE))) ("gprocrst" "4" 1 NIL 0 1 (:XDATA :SCALES (VALUES-THEMES "siecontr" "sselfman" "semotcop"))) ("gtimeman" "5" 1 NIL 0 1 (:XDATA :SCALES ("sselfman" "semotcop"))) ("grelat" "6" 1 NIL 0 1 (:XDATA :SCALES (INTERPERSONAL))) ("gmeetpeo" "7" 1 NIL 0 1 (:XDATA :SCALES (INTERPERSONAL))) ("glonelyf" "8" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("gexvalus" "9" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("gdepres" "10" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("ganxfear" "11" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("gaggrang" "12" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("gacadsuc" "13" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING))) ("gcomplta1" "14" 1 T 1 1 (:XDATA :SCALES (HQ ACAD-LEARNING CAREER-INTEREST))) ("gcompltanomaj" "15" 1 NIL 0 1 (:XDATA :SCALES (HQ ACAD-LEARNING))) ("gcompltanoac" "16" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("gAcadOnly" "17" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING))) ("gcarplan" "18" 1 NIL 0 1 (:XDATA :SCALES (CAREER-INTEREST))) ("gcaronly" "19" 1 NIL 0 1 (:XDATA :SCALES (CAREER-INTEREST))) ("gnottake" "20" 1 NIL 0 1 (:XDATA :SCALES NIL))) :MULTI-SEL-QUEST "bio4job" (BIO4JOB :MULTI "bio4job" "b-Primary occupation" 1 ("student" "1" 1 NIL 0 1 NIL) ("manager" "2" 1 NIL 0 1 NIL) ("propeop" "3" 1 T 1 1 NIL) ("protech" "4" 1 NIL 0 1 NIL) ("consulta" "5" 1 NIL 0 1 NIL) ("educator" "6" 1 T 1 1 NIL) ("sales" "7" 1 NIL 0 1 NIL) ("technici" "8" 1 NIL 0 1 NIL) ("clerical" "9" 1 NIL 0 1 NIL) ("service" "10" 1 NIL 0 1 NIL) ("ownbus10" "11" 1 NIL 0 1 NIL) ("othrsfem" "12" 1 NIL 0 1 NIL) ("other" "13" 1 NIL 0 1 NIL)) :MULTI-SEL-QUEST "bio7lang" (BIO7LANG :MULTI "bio7lang" "b-Fluent languages" 2 ("lenglish" "1" 1 T 1 2 NIL) ("lspanish" "2" 1 NIL 0 2 NIL) ("lvietnam" "3" 1 NIL 0 2 NIL) ("lcambodn" "4" 1 NIL 0 2 NIL) ("lchinese" "5" 1 NIL 0 2 NIL) ("lkorean" "6" 1 NIL 0 2 NIL) ("lportugu" "7" 1 NIL 0 2 NIL) ("lgerman" "8" 1 NIL 0 2 NIL) ("lfrench" "9" 1 NIL 0 2 NIL) ("lmideast" "10" 1 NIL 0 2 NIL) ("lothrasn" "11" 1 NIL 0 2 NIL) ("lothreur" "12" 1 NIL 0 2 NIL) ("lother" "13" 1 NIL 0 2 NIL)) :MULTI-SEL-QUEST "bio1ethn" (BIO1ETHN :MULTI "bio1ethn" "Primary Ethnic Group" 3 ("enortham" "1" 1 T 1 3 NIL) ("eafrica" "2" 1 NIL 0 3 NIL) ("enoreur" "3" 1 NIL 0 3 NIL) ("esoueur" "4" 1 NIL 0 3 NIL) ("mideast" "5" 1 NIL 0 3 NIL) ("ecambodn" "6" 1 NIL 0 3 NIL) ("echina" "7" 1 NIL 0 3 NIL) ("ekorea" "8" 1 NIL 0 3 NIL) ("ejapan" "9" 1 NIL 0 3 NIL) ("evietnam" "10" 1 NIL 0 3 NIL) ("eothrasn" "11" 1 NIL 0 3 NIL) ("emexico" "12" 1 NIL 0 3 NIL) ("ecentram" "13" 1 NIL 0 3 NIL) ("esoutham" "14" 1 NIL 0 3 NIL) ("epacific" "15" 1 NIL 0 3 NIL) ("eother" "16" 1 NIL 0 3 NIL)) :MULTI-SEL-QUEST "biorelaf" (BIORELAF :MULTI "biorelaf" "bioRelAffiliation" 4 ("catholic" "1" 1 NIL 0 4 NIL) ("jewish" "2" 1 NIL 0 4 NIL) ("latterd" "3" 1 NIL 0 4 NIL) ("buddhist" "4" 1 NIL 0 4 NIL) ("islam" "5" 1 NIL 0 4 NIL) ("baptist" "6" 1 NIL 0 4 NIL) ("methodst" "7" 1 T 1 4 NIL) ("episcop" "8" 1 NIL 0 4 NIL) ("lutheran" "9" 1 NIL 0 4 NIL) ("presbyte" "10" 1 NIL 0 4 NIL) ("proliber" "11" 1 NIL 0 4 NIL) ("profunda" "12" 1 NIL 0 4 NIL) ("noaffil" "13" 1 NIL 0 4 NIL) ("agnostic" "14" 1 NIL 0 4 NIL) ("othrnoan" "15" 1 NIL 0 4 NIL)) :MULTI-SEL-QUEST "stucolle" (STUCOLLE :MULTI "stucolle" "st-College attending" 7 ("cocsulb" "1" 1 NIL 0 7 NIL) ("cccsu" "2" 1 NIL 0 7 NIL) ("coucal" "3" 1 NIL 0 7 NIL) ("coopublc" "4" 1 NIL 0 7 NIL) ("coprivca" "5" 1 NIL 0 7 NIL) ("coprivot" "6" 1 NIL 0 7 NIL) ("cocacomc" "7" 1 NIL 0 7 NIL) ("coothcc" "8" 1 NIL 0 7 NIL) ("coothnat" "9" 1 NIL 0 7 NIL) ("coprgrad" "10" 1 NIL 0 7 NIL) ("cotech" "11" 1 NIL 0 7 NIL) ("highsch" "12" 1 NIL 0 7 NIL) ("coother" "13" 1 T 1 7 NIL)) :MULTI-SEL-QUEST "stumajor" (STUMAJOR :MULTI "stumajor" "st-Major study area" 8 ("mlibart" "1" 1 NIL 0 8 NIL) ("msocsci" "2" 1 T 1 8 NIL) ("mbiolsci" "3" 1 NIL 0 8 NIL) ("mart" "4" 1 NIL 0 8 NIL) ("mnatsci" "5" 1 NIL 0 8 NIL) ("mbus" "6" 1 NIL 0 8 NIL) ("menginr" "7" 1 T 1 8 NIL) ("meducat" "8" 1 NIL 0 8 NIL) ("mmedical" "9" 1 NIL 0 8 NIL) ("motcompu" "10" 1 NIL 0 8 NIL) ("mothtech" "11" 1 NIL 0 8 NIL) ("mrecrpe" "12" 1 NIL 0 8 NIL) ("mdoesna" "13" 1 NIL 0 8 NIL) ("mundecid" "14" 1 NIL 0 8 NIL)) :MULTI-SEL-QUEST "stuspeci" (STUSPECI :MULTI "stuspeci" "st-Special status" 9 ("strancc" "1" 1 NIL 0 9 NIL) ("stran4yr" "2" 1 NIL 0 9 NIL) ("sadultre" "3" 1 NIL 0 9 NIL) ("seop" "4" 1 NIL 0 9 NIL) ("susimmig" "5" 1 NIL 0 9 NIL) ("svisa" "6" 1 NIL 0 9 NIL) ("shonor" "7" 1 NIL 0 9 NIL) ("svisastu" "8" 1 NIL 0 9 NIL) ("sdisabld" "9" 1 NIL 0 9 NIL) ("soutofst" "10" 1 NIL 0 9 NIL) ("smilitar" "11" 1 NIL 0 9 NIL) ("sathlete" "12" 1 NIL 0 9 NIL) ("snone" "13" 1 T 1 9 NIL)) :MULTI-SEL-QUEST "sturesid" (STURESID :MULTI "sturesid" "st-Residence" 10 ("rsinwpar" "1" 1 NIL 0 10 NIL) ("rsindorm" "2" 1 NIL 0 10 NIL) ("rsinwchl" "3" 1 NIL 0 10 NIL) ("rsinothr" "4" 1 NIL 0 10 NIL) ("rmarwoch" "5" 1 T 1 10 NIL) ("rmarwchl" "6" 1 NIL 0 10 NIL) ("rmarlike" "7" 1 NIL 0 10 NIL) ("rother" "8" 1 NIL 0 10 NIL)) :MULTI-SEL-QUEST "stgpatre" (STGPATRE :MULTI "stgpatre" "st-GPA Trends" 11 ("trconhi" "1" 1 T 1 11 NIL) ("trincryr" "2" 1 NIL 0 11 NIL) ("trincyru" "3" 1 NIL 0 11 NIL) ("trincyrs" "4" 1 NIL 0 11 NIL) ("trgradin" "5" 1 NIL 0 11 NIL) ("trconave" "6" 1 NIL 0 11 NIL) ("trdecyru" "7" 1 NIL 0 11 NIL) ("trdecyr" "8" 1 NIL 0 11 NIL) ("trconlow" "9" 1 NIL 0 11 NIL) ("trupandd" "10" 1 NIL 0 11 NIL) ("trother" "11" 1 NIL 0 11 NIL)) :MULTI-SEL-QUEST "sturesource" (STURESOURCE :MULTI "sturesource" "am-All interference factors" 12 ("afinanc" "1" 1 NIL 0 12 NIL) ("afampres" "2" 1 NIL 0 12 NIL) ("afamresp" "3" 1 NIL 0 12 NIL) ("aworktim" "4" 1 NIL 0 12 NIL) ("awrkpres" "5" 1 NIL 0 12 NIL) ("arelprob" "6" 1 NIL 0 12 NIL) ("aloneli" "7" 1 NIL 0 12 NIL) ("ahomstpl" "8" 1 NIL 0 12 NIL) ("aschstpl" "9" 1 NIL 0 12 NIL) ("acompavl" "10" 1 NIL 0 12 NIL) ("awrngcls" "11" 1 NIL 0 12 NIL) ("afacconn" "12" 1 NIL 0 12 NIL) ("astuconn" "13" 1 NIL 0 12 NIL) ("alowmotv" "14" 1 NIL 0 12 NIL) ("atimconf" "15" 1 T 1 12 NIL) ("aprocras" "16" 1 NIL 0 12 NIL)) (:TEXT-DATA "sID" ("UserID" "555555" :SINGLE "555555") ("Sex" "Male" :SINGLE "Male" 1) ("Age" 78 :SINGLE 78 78) ("USA?" "USA" :SINGLE "USA" 1) ("Nation" "USA" :SINGLE "USA") ("ZipCode" 92260 :SINGLE 92260) ("HrsWork" 78 :SINGLE 78 78)) ("UTYPE" :MULTI "utype" "UserType" 1 ("twanttho" "1" 1 T 1 1 (:XDATA :SCALES (HQ))) ("tknowmor" "2" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("twanthel" "3" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("twantspe" "4" 1 NIL 0 1 (:XDATA :SCALES NIL)) ("texperie" "5" 1 NIL 0 1 (:XDATA :SCALES NIL)) ("tprevshaq" "6" 1 NIL 0 1 (:XDATA :SCALES (PREVIOUS-USER))) ("wantspq" "7" 1 NIL 0 1 (:XDATA :SCALES (SPECIFIC-QUESTS))) ("tu100stu" "8" 1 NIL 0 1 (:XDATA :SCALES (HQ ACAD-LEARNING))) ("tcsulbst" "9" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING))) ("tcolstu" "10" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING))) ("totherst" "11" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING))) ("tressub" "12" 1 NIL 0 1 (:XDATA :SCALES NIL)) ("tcolfaca" "13" 1 NIL 0 1 (:XDATA :SCALES NIL)) ("u-none" "14" 1 NIL 0 1 (:XDATA :SCALES NIL))) ("UGOALS" :MULTI "ugoals" "UserGoals" 1 ("gsuchap" "1" 1 T 1 1 (:XDATA :SCALES (HQ))) ("gemocop" "2" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("gslfest" "3" 1 NIL 0 1 (:XDATA :SCALES (VALUES-THEMES BELIEFS SKILLS-CONFIDENCE))) ("gprocrst" "4" 1 NIL 0 1 (:XDATA :SCALES (VALUES-THEMES "siecontr" "sselfman" "semotcop"))) ("gtimeman" "5" 1 NIL 0 1 (:XDATA :SCALES ("sselfman" "semotcop"))) ("grelat" "6" 1 NIL 0 1 (:XDATA :SCALES (INTERPERSONAL))) ("gmeetpeo" "7" 1 NIL 0 1 (:XDATA :SCALES (INTERPERSONAL))) ("glonelyf" "8" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("gexvalus" "9" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("gdepres" "10" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("ganxfear" "11" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("gaggrang" "12" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("gacadsuc" "13" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING))) ("gcomplta1" "14" 1 T 1 1 (:XDATA :SCALES (HQ ACAD-LEARNING CAREER-INTEREST))) ("gcompltanomaj" "15" 1 NIL 0 1 (:XDATA :SCALES (HQ ACAD-LEARNING))) ("gcompltanoac" "16" 1 NIL 0 1 (:XDATA :SCALES (HQ))) ("gAcadOnly" "17" 1 NIL 0 1 (:XDATA :SCALES (ACAD-LEARNING))) ("gcarplan" "18" 1 NIL 0 1 (:XDATA :SCALES (CAREER-INTEREST))) ("gcaronly" "19" 1 NIL 0 1 (:XDATA :SCALES (CAREER-INTEREST))) ("gnottake" "20" 1 NIL 0 1 (:XDATA :SCALES NIL))) (BIO4JOB :MULTI "bio4job" "b-Primary occupation" 1 ("student" "1" 1 NIL 0 1 NIL) ("manager" "2" 1 NIL 0 1 NIL) ("propeop" "3" 1 T 1 1 NIL) ("protech" "4" 1 NIL 0 1 NIL) ("consulta" "5" 1 NIL 0 1 NIL) ("educator" "6" 1 T 1 1 NIL) ("sales" "7" 1 NIL 0 1 NIL) ("technici" "8" 1 NIL 0 1 NIL) ("clerical" "9" 1 NIL 0 1 NIL) ("service" "10" 1 NIL 0 1 NIL) ("ownbus10" "11" 1 NIL 0 1 NIL) ("othrsfem" "12" 1 NIL 0 1 NIL) ("other" "13" 1 NIL 0 1 NIL)) (BIO7LANG :MULTI "bio7lang" "b-Fluent languages" 2 ("lenglish" "1" 1 T 1 2 NIL) ("lspanish" "2" 1 NIL 0 2 NIL) ("lvietnam" "3" 1 NIL 0 2 NIL) ("lcambodn" "4" 1 NIL 0 2 NIL) ("lchinese" "5" 1 NIL 0 2 NIL) ("lkorean" "6" 1 NIL 0 2 NIL) ("lportugu" "7" 1 NIL 0 2 NIL) ("lgerman" "8" 1 NIL 0 2 NIL) ("lfrench" "9" 1 NIL 0 2 NIL) ("lmideast" "10" 1 NIL 0 2 NIL) ("lothrasn" "11" 1 NIL 0 2 NIL) ("lothreur" "12" 1 NIL 0 2 NIL) ("lother" "13" 1 NIL 0 2 NIL)) (BIO1ETHN :MULTI "bio1ethn" "Primary Ethnic Group" 3 ("enortham" "1" 1 T 1 3 NIL) ("eafrica" "2" 1 NIL 0 3 NIL) ("enoreur" "3" 1 NIL 0 3 NIL) ("esoueur" "4" 1 NIL 0 3 NIL) ("mideast" "5" 1 NIL 0 3 NIL) ("ecambodn" "6" 1 NIL 0 3 NIL) ("echina" "7" 1 NIL 0 3 NIL) ("ekorea" "8" 1 NIL 0 3 NIL) ("ejapan" "9" 1 NIL 0 3 NIL) ("evietnam" "10" 1 NIL 0 3 NIL) ("eothrasn" "11" 1 NIL 0 3 NIL) ("emexico" "12" 1 NIL 0 3 NIL) ("ecentram" "13" 1 NIL 0 3 NIL) ("esoutham" "14" 1 NIL 0 3 NIL) ("epacific" "15" 1 NIL 0 3 NIL) ("eother" "16" 1 NIL 0 3 NIL)) (BIORELAF :MULTI "biorelaf" "bioRelAffiliation" 4 ("catholic" "1" 1 NIL 0 4 NIL) ("jewish" "2" 1 NIL 0 4 NIL) ("latterd" "3" 1 NIL 0 4 NIL) ("buddhist" "4" 1 NIL 0 4 NIL) ("islam" "5" 1 NIL 0 4 NIL) ("baptist" "6" 1 NIL 0 4 NIL) ("methodst" "7" 1 T 1 4 NIL) ("episcop" "8" 1 NIL 0 4 NIL) ("lutheran" "9" 1 NIL 0 4 NIL) ("presbyte" "10" 1 NIL 0 4 NIL) ("proliber" "11" 1 NIL 0 4 NIL) ("profunda" "12" 1 NIL 0 4 NIL) ("noaffil" "13" 1 NIL 0 4 NIL) ("agnostic" "14" 1 NIL 0 4 NIL) ("othrnoan" "15" 1 NIL 0 4 NIL)) ("sFamily" :MULTI "sFamily" "Origin Family" 1 ("OlderBrosN" "1" 1 NIL 0) ("OlderSisN" "2" 1 NIL 0) ("YoungerBrosN" "3" 1 NIL 1) ("YoungerSisN" "4" 1 NIL 1) ("Raised2Parents" "5" 1 NIL 0) ("SingleFparent" "6" 1 NIL 1) ("SingleMparent" "7" 1 NIL 0) ("RaisedNoParents" "8" 1 NIL 0) ("RaisedOther" "9" 1 NIL 0)) (:SCALEDATA ACAD-ACH :N 3 :REL 0.9523334 :MN 11.333333 :TOT 34 :MAX 36 :SD 2.4944382 :VAR 6.222222 :QV (BIO3EDUC BIOHSGPA BIOCOLLE)) (:SCALEDATA ST1HIGHERSELF :N 10 :REL 0.91999996 :MN 9.2 :TOT 92 :MAX 100 :SD 0.4 :VAR 0.16000001 :QV (THM6LEAR THM9SHAP THM14IND THM22BOD THM23BAL THMCOMPC THMINTEG THMPHIL THMSESUF THMSEDIS)) (:SCALEDATA ST2SOCINTIMNOFAM :N 6 :REL 0.68333334 :MN 6.8333335 :TOT 41 :MAX 60 :SD 1.2133516 :VAR 1.4722222 :QV (THM8ROMA THM12PLE THMRESPE THM20INT THMLIKED THMSUPPO)) (:SCALEDATA ST3FAMCARE :N 3 :REL 0.56666667 :MN 5.6666665 :TOT 17 :MAX 30 :SD 0.47140452 :VAR 0.22222223 :QV (THMCAREG THMPARLV THMFAMIL)) (:SCALEDATA ST4SUCCESSSTATUSMATER :N 9 :REL 0.65555555 :MN 6.5555554 :TOT 59 :MAX 90 :SD 0.9558139 :VAR 0.91358024 :QV (THM3EDUC THM4MONE THM25POS THM26SUC THM30CEO THM33GOA THMRESPE THM1ACH THMRECOG)) (:SCALEDATA ST5-ORDERPERFECTIONGOODNESS :N 8 :REL 0.6875001 :MN 6.875 :TOT 55 :MAX 80 :SD 0.78062475 :VAR 0.609375 :QV (THMORDER THMCLEAN THMPERFE THMJUSTI THMSIMPL THMBEAUT THMGOODN THMWHOLE)) (:SCALEDATA ST6GODSPIRITRELIG :N 4 :REL 0.6 :MN 6.0 :TOT 24 :MAX 40 :SD 0.70710677 :VAR 0.5 :QV (THMOBGOD THMRELGD THMSPIRI THMRELIG)) (:SCALEDATA ST7IMPACTCHALLENGEEXPLOR :N 7 :REL 0.82857144 :MN 8.285714 :TOT 58 :MAX 70 :SD 1.0301576 :VAR 1.0612246 :QV (THM10OTH THMIMPAC THM28CRE THMMENCH THM34EXP THMUNIQU THMCREAT)) (:SCALEDATA ST8ATTENTIONFUNEASY :N 4 :REL 0.55 :MN 5.5 :TOT 22 :MAX 40 :SD 0.8660254 :VAR 0.75 :QV (THMATTEN THM5ADVE THMEFORT THMPLAYF)) (:SCALEDATA ST9VALUESELFALLUNCOND :N 4 :REL 0.85 :MN 8.5 :TOT 34 :MAX 40 :SD 0.8660254 :VAR 0.75 :QV (THVUNCON THVSELFW THVSELFA THMUNCON)) (:SCALEDATA ST10OVERCMPROBACCEPTSELF :N 2 :REL 0.5 :MN 5.0 :TOT 10 :MAX 20 :SD 0.0 :VAR 0.0 :QV (THMSPROT THMPHURT)) (:SCALEDATA ST11DUTYPUNCTUAL :N 2 :REL 0.5 :MN 5.0 :TOT 10 :MAX 20 :SD 0.0 :VAR 0.0 :QV (THMPUNCT THMOBLIG)) (:SCALEDATA SWORLDVIEW :N 11 :REL 0.926 :MN 7.2727275 :TOT 80 :MAX 86 :SD 1.863082 :VAR 3.4710746 :QV (WOVPROGR WOVGOODF WOVMYLIF WOVNFAIR TBVENTIT WOVINJUR WOVABUND TBVGRATI WOVENTIT WOVGRATE WOVPOSTH) :SS ("SSWVGRATPT" "SSWVOPTIMS" "SSWVENTIT")) (:SUBSCALEDATA "SSWVGRATPT" :N 3 :REL 1.0 :MN 8.0 :TOT 24 :MAX 24 :SD 1.4142135 :VAR 2.0 :QV (TBVGRATI WOVABUND WOVGRATE)) (:SUBSCALEDATA "SSWVOPTIMS" :N 4 :REL 0.96425 :MN 7.5 :TOT 30 :MAX 31 :SD 1.5 :VAR 2.25 :QV (WOVPROGR WOVGOODF WOVMYLIF WOVPOSTH)) (:SUBSCALEDATA "SSWVENTIT" :N 4 :REL 0.83225 :MN 6.5 :TOT 26 :MAX 31 :SD 2.1794496 :VAR 4.75 :QV (TBVENTIT WOVNFAIR WOVINJUR WOVENTIT)) (:SCALEDATA STBSLFWO :N 11 :REL 0.90000004 :MN 9.0 :TOT 99 :MAX 110 :SD 0.6030227 :VAR 0.36363637 :QV (TBVOTHFI TBVLIKED TBVWEAK TBVBEST TBVRULES TBVWINNE TBVBALAN TBVHAPCA THVSELFA THVUNCON THVSELFW) :SS ("SSSWNONCONT" "SSSWHAPALLGRAT" "SSSWACALLSELF")) (:SUBSCALEDATA "SSSWNONCONT" :N 6 :REL 0.9000001 :MN 9.0 :TOT 54 :MAX 60 :SD 0.57735026 :VAR 0.33333334 :QV (TBVOTHFI TBVLIKED TBVWEAK TBVBEST TBVRULES TBVWINNE)) (:SUBSCALEDATA "SSSWHAPALLGRAT" :N 4 :REL 0.90000004 :MN 9.0 :TOT 36 :MAX 40 :SD 0.70710677 :VAR 0.5 :QV (TBVBALAN TBVHAPCA TBVGRATI THVUNCON THVSELFW)) (:SUBSCALEDATA "SSSWACALLSELF" :N 1 :REL 0.90000004 :MN 9.0 :TOT 9 :MAX 10 :SD 0.0 :VAR 0.0 :QV (THVSELFA)) (:SCALEDATA SIECONTR :N 7 :REL 0.9387143 :MN 6.571429 :TOT 46 :MAX 49 :SD 0.7284314 :VAR 0.5306123 :QV (IECSELFS IECICONT IECGENET IECPEOPL IECDEPEN IECCOFEE IECCOPRB) :SS ("SSIEAUTONY" "SSIENCODEP" "SSIENOTHER")) (:SUBSCALEDATA "SSIEAUTONY" :N 3 :REL 1.0 :MN 7.0 :TOT 21 :MAX 21 :SD 0.0 :VAR 0.0 :QV (IECSELFS IECICONT IECDEPEN)) (:SUBSCALEDATA "SSIENCODEP" :N 2 :REL 0.78550005 :MN 5.5 :TOT 11 :MAX 14 :SD 0.5 :VAR 0.25 :QV (IECCOFEE IECCOPRB)) (:SUBSCALEDATA "SSIENOTHER" :N 2 :REL 1.0 :MN 7.0 :TOT 14 :MAX 14 :SD 0.0 :VAR 0.0 :QV (IECPEOPL IECGENET)) (:SCALEDATA SETHBEL :N 14 :REL 0.7214285 :MN 7.214286 :TOT 101 :MAX 140 :SD 1.6978377 :VAR 2.882653 :QV (TB2RELAT TB2PUNIS TBV2NOTR TB2GROUM TB2SELFM TB2GDWRK TB2GDATT TB2ALLGD TB2REASO TBV2ASTR TB2IDHUM TB2LIFAD TB2MOVEM TBV2CORE) :SS ("SSB2ETHIC" "SSB2FORGIV" "SSB2IDGRND" "SSB2GRNDMNG" "SSB2INRGOOD" "SSB2NOASTR" "SSB2LIFAD")) (:SUBSCALEDATA "SSB2ETHIC" :N 4 :REL 0.675 :MN 6.75 :TOT 27 :MAX 40 :SD 1.299038 :VAR 1.6875 :QV (TB2RELAT TBV2NOTR TB2REASO TBV2CORE)) (:SUBSCALEDATA "SSB2FORGIV" :N 2 :REL 0.85 :MN 8.5 :TOT 17 :MAX 20 :SD 0.5 :VAR 0.25 :QV (TB2PUNIS TB2GDWRK)) (:SUBSCALEDATA "SSB2IDGRND" :N 2 :REL 0.75 :MN 7.5 :TOT 15 :MAX 20 :SD 0.5 :VAR 0.25 :QV (TB2IDHUM TB2MOVEM)) (:SUBSCALEDATA "SSB2GRNDMNG" :N 2 :REL 0.85 :MN 8.5 :TOT 17 :MAX 20 :SD 0.5 :VAR 0.25 :QV (TB2GROUM TB2SELFM)) (:SUBSCALEDATA "SSB2INRGOOD" :N 2 :REL 0.55 :MN 5.5 :TOT 11 :MAX 20 :SD 0.5 :VAR 0.25 :QV (TB2GDATT TB2ALLGD)) (:SUBSCALEDATA "SSB2NOASTR" :N 1 :REL 1.0 :MN 10.0 :TOT 10 :MAX 10 :SD 0.0 :VAR 0.0 :QV (TBV2ASTR)) (:SUBSCALEDATA "SSB2LIFAD" :N 1 :REL 0.4 :MN 4.0 :TOT 4 :MAX 10 :SD 0.0 :VAR 0.0 :QV (TB2LIFAD)) (:SCALEDATA SGRFEARS :N 12 :REL 0.79758335 :MN 5.5833335 :TOT 67 :MAX 84 :SD 2.0598679 :VAR 4.2430554 :QV (WOVHAPPY WOVPOOR WOVILL WOVDEATH WOVALONE WOVNOLOV WOVLIKED WOVPERSO WOVPROBL WOVDISCO WOVSUCCE WOVOVERC) :SS ("SSWFSOCIAL" "SSWFSELF" "SSWFPOVFAI" "SSWFILLDEA")) (:SUBSCALEDATA "SSWFSOCIAL" :N 4 :REL 0.82125 :MN 5.75 :TOT 23 :MAX 28 :SD 1.299038 :VAR 1.6875 :QV (WOVALONE WOVNOLOV WOVLIKED WOVPROBL)) (:SUBSCALEDATA "SSWFSELF" :N 3 :REL 1.0 :MN 7.0 :TOT 21 :MAX 21 :SD 0.0 :VAR 0.0 :QV (WOVPERSO WOVDISCO WOVOVERC)) (:SUBSCALEDATA "SSWFPOVFAI" :N 3 :REL 0.9523334 :MN 6.6666665 :TOT 20 :MAX 21 :SD 0.47140452 :VAR 0.22222223 :QV (WOVHAPPY WOVPOOR WOVSUCCE)) (:SUBSCALEDATA "SSWFILLDEA" :N 2 :REL 0.21450001 :MN 1.5 :TOT 3 :MAX 14 :SD 0.5 :VAR 0.25 :QV (WOVILL WOVDEATH)) (:SCALEDATA SSLFCONF :N 41 :REL 0.9930244 :MN 6.9512196 :TOT 285 :MAX 287 :SD 0.21540882 :VAR 0.046400957 :QV (SLFLEARN SLFCRITT SLFRESEA SLFANALY SLFSYNTH SLFCREAT SLFCOMPU SLFBIOSC SLFNATSC SLFLIBAR SLFSOCSC SLFPHILR SLFPERFA SLFFINEA SLFBUSAN SLFHEAL2 SLFENGIN SLFEDUCH SLFIQ SLFDECMA SLFTIMEM SLFCOPE SLFSELF4 SLFSELFM SLFACHAN SLFMANA6 SLFHEAL3 SLFMEETP SLFLISTE SLFSELF5 SLFCONFL SLFPERSU SLFMANA7 SLFHELPS SLFSPEAK SLFJOBSE SLFADAPT SLFHAPPY SLFOPTIM SLFFRIEN SLFINDEP) :SS ("SSSCLEARN" "SSSCCOPOPT" "SSSCSMSMSD" "SSSCINTERP" "SSSCALLHELP" "SSSCSCIENCE" "SSSCARTCRE")) (:SUBSCALEDATA "SSSCLEARN" :N 7 :REL 1.0 :MN 7.0 :TOT 49 :MAX 49 :SD 0.0 :VAR 0.0 :QV (SLFLEARN SLFCRITT SLFRESEA SLFANALY SLFSYNTH SLFCOMPU SLFIQ)) (:SUBSCALEDATA "SSSCCOPOPT" :N 6 :REL 1.0 :MN 7.0 :TOT 42 :MAX 42 :SD 0.0 :VAR 0.0 :QV (SLFSELF4 SLFCOPE SLFSELF5 SLFCONFL SLFOPTIM SLFFRIEN)) (:SUBSCALEDATA "SSSCSMSMSD" :N 7 :REL 1.0 :MN 7.0 :TOT 49 :MAX 49 :SD 0.0 :VAR 0.0 :QV (SLFDECMA SLFTIMEM SLFSELFM SLFACHAN SLFMANA6 SLFHEAL3 SLFINDEP)) (:SUBSCALEDATA "SSSCINTERP" :N 7 :REL 1.0 :MN 7.0 :TOT 49 :MAX 49 :SD 0.0 :VAR 0.0 :QV (SLFADAPT SLFMEETP SLFPERSU SLFMANA7 SLFBUSAN SLFSPEAK SLFJOBSE)) (:SUBSCALEDATA "SSSCALLHELP" :N 6 :REL 1.0 :MN 7.0 :TOT 42 :MAX 42 :SD 0.0 :VAR 0.0 :QV (SLFSOCSC SLFPHILR SLFLIBAR SLFEDUCH SLFLISTE SLFHELPS)) (:SUBSCALEDATA "SSSCSCIENCE" :N 4 :REL 1.0 :MN 7.0 :TOT 28 :MAX 28 :SD 0.0 :VAR 0.0 :QV (SLFBIOSC SLFNATSC SLFHEAL2 SLFENGIN)) (:SUBSCALEDATA "SSSCARTCRE" :N 3 :REL 0.9046667 :MN 6.3333335 :TOT 19 :MAX 21 :SD 0.47140452 :VAR 0.22222223 :QV (SLFCREAT SLFPERFA SLFFINEA)) (:SCALEDATA SSELFMAN :N 15 :REL 0.9604 :MN 7.3333335 :TOT 110 :MAX 116 :SD 1.3984116 :VAR 1.9555551 :QV (SMTBUSY SMTFUTUR SMTEXERC SMTEATH SMTSLEEP SMTSDEVE SMTNPROC SMTPTODO SMTGOALS SMTSCHD SMT2DTOD SMTACMPL SMTGHELP SMTBALAN SMTHABCH) :SS ("SSSMTIMEMANGOALSET" "SSSMACCOMPLORUSH" "SSSMSELFDEVEL" "SSSMHEALTHHABS")) (:SUBSCALEDATA "SSSMTIMEMANGOALSET" :N 5 :REL 0.9714001 :MN 6.8 :TOT 34 :MAX 35 :SD 0.39999998 :VAR 0.15999998 :QV (SMTFUTUR SMTPTODO SMTGOALS SMTSCHD SMT2DTOD)) (:SUBSCALEDATA "SSSMACCOMPLORUSH" :N 2 :REL 0.92850006 :MN 6.5 :TOT 13 :MAX 14 :SD 0.5 :VAR 0.25 :QV (SMTBUSY SMTACMPL)) (:SUBSCALEDATA "SSSMSELFDEVEL" :N 3 :REL 1.0 :MN 7.0 :TOT 21 :MAX 21 :SD 0.0 :VAR 0.0 :QV (SMTSDEVE SMTGHELP SMTHABCH)) (:SUBSCALEDATA "SSSMHEALTHHABS" :N 3 :REL 0.8973333 :MN 9.333333 :TOT 28 :MAX 32 :SD 2.0548046 :VAR 4.222222 :QV (SMTEXERC SMTEATH SMTSLEEP)) (:SCALEDATA SEMOTCOP :N 20 :REL 0.9415501 :MN 5.85 :TOT 117 :MAX 124 :SD 0.90967024 :VAR 0.8275 :QV (COPNEGTH COPCOPEA COPPSOLV COPAVOPS COPEMOTA COPBLAME COPWDRW COPFUN COPTALKS COPPEPTA COPSMOKE COPDRUG COPPE COPNEGPH COPSELFB COPPOSPH COPEXPEC COPHAPPY COPAVOAT COPSELFE) :SS ("SSCPPROBSOLV" "SSCPPOSTHOUGHTS" "SSCPPOSACTS" "SSCPNOBLAMEANGERWDRAW" "SSCPNOTSMOKDRUGMED" "SSCPNOTEAT")) (:SUBSCALEDATA "SSCPPROBSOLV" :N 4 :REL 0.95825005 :MN 6.5 :TOT 26 :MAX 27 :SD 1.5 :VAR 2.25 :QV (COPPSOLV COPTALKS COPEXPEC COPSELFE)) (:SUBSCALEDATA "SSCPPOSTHOUGHTS" :N 2 :REL 1.0 :MN 6.0 :TOT 12 :MAX 12 :SD 0.0 :VAR 0.0 :QV (COPNEGTH COPPEPTA)) (:SUBSCALEDATA "SSCPPOSACTS" :N 2 :REL 1.0 :MN 6.0 :TOT 12 :MAX 12 :SD 0.0 :VAR 0.0 :QV (COPFUN COPPE)) (:SUBSCALEDATA "SSCPNOBLAMEANGERWDRAW" :N 5 :REL 0.8998 :MN 5.4 :TOT 27 :MAX 30 :SD 0.48989797 :VAR 0.24000001 :QV (COPEMOTA COPBLAME COPWDRW COPNEGPH COPSELFB)) (:SUBSCALEDATA "SSCPNOTSMOKDRUGMED" :N 2 :REL 1.0 :MN 6.0 :TOT 12 :MAX 12 :SD 0.0 :VAR 0.0 :QV (COPSMOKE COPDRUG)) (:SUBSCALEDATA "SSCPNOTEAT" :N 1 :REL 0.83300007 :MN 5.0 :TOT 5 :MAX 6 :SD 0.0 :VAR 0.0 :QV (COPCOPEA)) (:SCALEDATA INTSS1AASSERTCR :N 14 :REL 0.8162857 :MN 5.714286 :TOT 80 :MAX 98 :SD 1.3324827 :VAR 1.7755102 :QV (CR1ISSUE CRRESOLV CRNTHREA CRUNDERL CRWINWIN CRLONGTK CRSUMMAR CRCPRAIS CRBOASSR CROPHONE CRANGRES CRTLKMOR CREQWIN INTUNDRL)) (:SCALEDATA INTSS1BOPENHON :N 9 :REL 0.9682223 :MN 6.7777777 :TOT 61 :MAX 63 :SD 0.41573972 :VAR 0.17283952 :QV (INTTELAL INTSMGOA INTEQDEC INTIOPEN INTWEOPN INTDAILY INTALLOP INTKNPFE INCOMTWO)) (:SCALEDATA INTSS2ROMANTC :N 7 :REL 0.9387143 :MN 6.571429 :TOT 46 :MAX 49 :SD 0.7284314 :VAR 0.53061235 :QV (ROMSURPR ROMFANTA ROMCELEB ROMPLACE ROMATTRA ROMPLAYF ROMCHARM)) (:SCALEDATA INTSS3LIBROLE :N 7 :REL 0.9182857 :MN 6.428571 :TOT 45 :MAX 49 :SD 0.7284314 :VAR 0.53061235 :QV (LROMTASK LROFTASK LRMFINAL LROEMBAR LROMSTRO LROEQINC LRCARCON)) (:SCALEDATA INTSS4LOVERES :N 7 :REL 1.0 :MN 7.0 :TOT 49 :MAX 49 :SD 0.0 :VAR 0.0 :QV (CRIFAVOR CRIFOLUP INTCOMIT INTRESPT INTLSQPR INTLOVE INNEVARG)) (:SCALEDATA INTSS5INDEP :N 15 :REL 0.87606675 :MN 6.133333 :TOT 92 :MAX 105 :SD 0.71802205 :VAR 0.5155557 :QV (INRLUNCH INRINHAP INRIGROW INRSAYWE INDIFGOA INFINDAN INENALON INOKALON INRHATEA INSEPINT INRMONEY INRBEALN INALCNST INRFREEH INRFRIEN)) (:SCALEDATA INTSS6POSSUP :N 8 :REL 0.9285 :MN 6.5 :TOT 52 :MAX 56 :SD 0.5 :VAR 0.25 :QV (CRNTHREA CRNNEGLB CREXAGGR CRANGANG CRIPRAIS CRANGRES INDIFDEC INSTSHLP)) (:SCALEDATA INTSS7COLLAB :N 7 :REL 0.6938572 :MN 4.857143 :TOT 34 :MAX 49 :SD 2.0303815 :VAR 4.122449 :QV (CRTKLONG CRTEWEAK CRMANIPU CRREPRAI CRTEACH CRTLKMOR INTWKTOG)) (STUCOLLE :MULTI "stucolle" "st-College attending" 7 ("cocsulb" "1" 1 NIL 0 7 NIL) ("cccsu" "2" 1 NIL 0 7 NIL) ("coucal" "3" 1 NIL 0 7 NIL) ("coopublc" "4" 1 NIL 0 7 NIL) ("coprivca" "5" 1 NIL 0 7 NIL) ("coprivot" "6" 1 NIL 0 7 NIL) ("cocacomc" "7" 1 NIL 0 7 NIL) ("coothcc" "8" 1 NIL 0 7 NIL) ("coothnat" "9" 1 NIL 0 7 NIL) ("coprgrad" "10" 1 NIL 0 7 NIL) ("cotech" "11" 1 NIL 0 7 NIL) ("highsch" "12" 1 NIL 0 7 NIL) ("coother" "13" 1 T 1 7 NIL)) (STUMAJOR :MULTI "stumajor" "st-Major study area" 8 ("mlibart" "1" 1 NIL 0 8 NIL) ("msocsci" "2" 1 T 1 8 NIL) ("mbiolsci" "3" 1 NIL 0 8 NIL) ("mart" "4" 1 NIL 0 8 NIL) ("mnatsci" "5" 1 NIL 0 8 NIL) ("mbus" "6" 1 NIL 0 8 NIL) ("menginr" "7" 1 T 1 8 NIL) ("meducat" "8" 1 NIL 0 8 NIL) ("mmedical" "9" 1 NIL 0 8 NIL) ("motcompu" "10" 1 NIL 0 8 NIL) ("mothtech" "11" 1 NIL 0 8 NIL) ("mrecrpe" "12" 1 NIL 0 8 NIL) ("mdoesna" "13" 1 NIL 0 8 NIL) ("mundecid" "14" 1 NIL 0 8 NIL)) (STUSPECI :MULTI "stuspeci" "st-Special status" 9 ("strancc" "1" 1 NIL 0 9 NIL) ("stran4yr" "2" 1 NIL 0 9 NIL) ("sadultre" "3" 1 NIL 0 9 NIL) ("seop" "4" 1 NIL 0 9 NIL) ("susimmig" "5" 1 NIL 0 9 NIL) ("svisa" "6" 1 NIL 0 9 NIL) ("shonor" "7" 1 NIL 0 9 NIL) ("svisastu" "8" 1 NIL 0 9 NIL) ("sdisabld" "9" 1 NIL 0 9 NIL) ("soutofst" "10" 1 NIL 0 9 NIL) ("smilitar" "11" 1 NIL 0 9 NIL) ("sathlete" "12" 1 NIL 0 9 NIL) ("snone" "13" 1 T 1 9 NIL)) (STURESID :MULTI "sturesid" "st-Residence" 10 ("rsinwpar" "1" 1 NIL 0 10 NIL) ("rsindorm" "2" 1 NIL 0 10 NIL) ("rsinwchl" "3" 1 NIL 0 10 NIL) ("rsinothr" "4" 1 NIL 0 10 NIL) ("rmarwoch" "5" 1 T 1 10 NIL) ("rmarwchl" "6" 1 NIL 0 10 NIL) ("rmarlike" "7" 1 NIL 0 10 NIL) ("rother" "8" 1 NIL 0 10 NIL)) (STGPATRE :MULTI "stgpatre" "st-GPA Trends" 11 ("trconhi" "1" 1 T 1 11 NIL) ("trincryr" "2" 1 NIL 0 11 NIL) ("trincyru" "3" 1 NIL 0 11 NIL) ("trincyrs" "4" 1 NIL 0 11 NIL) ("trgradin" "5" 1 NIL 0 11 NIL) ("trconave" "6" 1 NIL 0 11 NIL) ("trdecyru" "7" 1 NIL 0 11 NIL) ("trdecyr" "8" 1 NIL 0 11 NIL) ("trconlow" "9" 1 NIL 0 11 NIL) ("trupandd" "10" 1 NIL 0 11 NIL) ("trother" "11" 1 NIL 0 11 NIL)) (STURESOURCE :MULTI "sturesource" "am-All interference factors" 12 ("afinanc" "1" 1 NIL 0 12 NIL) ("afampres" "2" 1 NIL 0 12 NIL) ("afamresp" "3" 1 NIL 0 12 NIL) ("aworktim" "4" 1 NIL 0 12 NIL) ("awrkpres" "5" 1 NIL 0 12 NIL) ("arelprob" "6" 1 NIL 0 12 NIL) ("aloneli" "7" 1 NIL 0 12 NIL) ("ahomstpl" "8" 1 NIL 0 12 NIL) ("aschstpl" "9" 1 NIL 0 12 NIL) ("acompavl" "10" 1 NIL 0 12 NIL) ("awrngcls" "11" 1 NIL 0 12 NIL) ("afacconn" "12" 1 NIL 0 12 NIL) ("astuconn" "13" 1 NIL 0 12 NIL) ("alowmotv" "14" 1 NIL 0 12 NIL) ("atimconf" "15" 1 T 1 12 NIL) ("aprocras" "16" 1 NIL 0 12 NIL)) (:SCALEDATA SCOLLEGE :N 6 :REL 0.6346667 :MN 4.6666665 :TOT 28 :MAX 51 :SD 2.748737 :VAR 7.555556 :QV (STPARED STUCLASS STUDEGRE STUSEMES STMAJGPA STACADST)) (:SCALEDATA SSL1CONFIDEFFICSTUDYTEST :N 13 :REL 0.86815387 :MN 6.076923 :TOT 79 :MAX 91 :SD 1.7303417 :VAR 2.9940825 :QV (LRNUNASN LRNCOLMT LRNKNOWT LRNPROOF LRNRREAD LRNEFFIC LRNTESTT LRNTIMAS LRNTIRED LRNTANXI LRNSMART LRNAREAD LRNRSLOW)) (:SCALEDATA SSL1BCONFIDNOTAVOIDSTUDY :N 5 :REL 1.0 :MN 7.0 :TOT 35 :MAX 35 :SD 0.0 :VAR 0.0 :QV (LRNUNASN LRNCOLMT LRNTIRED LRNAREAD LRNPROOF)) (:SCALEDATA SSL2SATISCAMPUSFACFRIENDSGRDES :N 8 :REL 0.839125 :MN 5.875 :TOT 47 :MAX 56 :SD 0.3307189 :VAR 0.109375 :QV (STULOOKF STULIKEI STUCOMFO STUFRIEN STUENJOY STUEACTR STHAPCOL STHAPGPA)) (:SCALEDATA SSL3WRITEREADSKILLS :N 6 :REL 0.8571667 :MN 6.0 :TOT 36 :MAX 42 :SD 2.236068 :VAR 5.0 :QV (LRNWRPAP LRNWRSKL LRNSEE LRNVOCAB LRNWRORG LRNSREAD)) (:SCALEDATA SSL4BLDMENTALSTRUCT :N 7 :REL 1.0 :MN 7.0 :TOT 49 :MAX 49 :SD 0.0 :VAR 0.0 :QV (LRNTXUND LRNINTER LRNROTE LRNASSOC LRNSTRUG LRNTHEOR LRNALONE)) (:SCALEDATA SSL5BASICSTUDYSKILLS :N 6 :REL 1.0 :MN 7.0 :TOT 42 :MAX 42 :SD 0.0 :VAR 0.0 :QV (ACMCONCE LRNTXOVE LRNTSREV LRNMAP LRNTXOUT LRNNOTES)) (:SCALEDATA SSL6SELFMANACADGOALS :N 6 :REL 0.8571667 :MN 6.0 :TOT 36 :MAX 42 :SD 2.236068 :VAR 5.0 :QV (ACMCOMPL ACMQUITC ACMFINAN ACMDEGRE STUCONFU ACMSELFS)) (:SCALEDATA SSL7MATHSCIPRINC :N 2 :REL 1.0 :MN 7.0 :TOT 14 :MAX 14 :SD 0.0 :VAR 0.0 :QV (LRNMATH LRNTEXTN)) (:SCALEDATA SSL8STUDYENVIR :N 3 :REL 1.0 :MN 7.0 :TOT 21 :MAX 21 :SD 0.0 :VAR 0.0 :QV (ACMEFAML ACMESOCS LRNESTUD)) (:SCALEDATA SSL9ATTENDHW :N 3 :REL 0.8333333 :MN 5.6666665 :TOT 17 :MAX 20 :SD 1.885618 :VAR 3.5555554 :QV (ACMSTUDY ACMNDROP ACMATTEN)) (:SCALEDATA SSL10MEMNOTANX :N 3 :REL 1.0 :MN 7.0 :TOT 21 :MAX 21 :SD 0.0 :VAR 0.0 :QV (LRNMEMOR LRNTENSE LRNSEFIC)) (:SCALEDATA SSL11NOTNONACADMOT :N 5 :REL 0.7856 :MN 5.4 :TOT 27 :MAX 34 :SD 1.496663 :VAR 2.24 :QV (STUEXTMO STUMONEYNEW STUCONFU STUFINDE STUCAREE)) (:SCALEDATA SSL12STDYTMAVAIL :N 1 :REL 1.0 :MN 7.0 :TOT 7 :MAX 7 :SD 0.0 :VAR 0.0 :QV (ACMTIME)) (:SCALEDATA SSL13VERBALAPT :N 1 :REL 1.0 :MN 10.0 :TOT 10 :MAX 10 :SD 0.0 :VAR 0.0 :QV (STUVERBA)) (:SCALEDATA SSL14MATHAPT :N 1 :REL 1.0 :MN 10.0 :TOT 10 :MAX 10 :SD 0.0 :VAR 0.0 :QV (STUMATHA)) (:SCALEDATA SINCAR :N 28 :REL 0.6378215 :MN 4.464286 :TOT 125 :MAX 196 :SD 2.4854167 :VAR 6.177296 :QV (CAR1CARG CAR1CARP CAR1INAT CARIBIOH CARISOCS CARIHELP CARIMATH CARIMED CARIWRIT CARIFNAR CARIETHN CARILEAR CARIEXPE CARIGENE CARINOIN CARILIT CARIRECP CARIPOLI CARIMIL6 CARIMANU CARILANG CARIPHIL CARIBUSI CARIENGI CARIFAMC CARIWOMA CARICOM8 CARINTE0)) (:SCALEDATA SINBUS :N 7 :REL 0.46942857 :MN 3.2857144 :TOT 23 :MAX 49 :SD 2.2497166 :VAR 5.0612245 :QV (CARIBMAR CARIBMAN CARIBINF CARIBFIN CARIBHRD CARIBACC CARISPBU)) (:SCALEDATA SINENGR :N 8 :REL 0.60725 :MN 4.25 :TOT 34 :MAX 56 :SD 2.384848 :VAR 5.6875 :QV (CARIEENG CARIME CARICHE2 CARICIVE CARIAERO CARIEITE CARICOM9 CARIBCOM)) (:SCALEDATA SINFINEA :N 7 :REL 0.16342858 :MN 1.1428572 :TOT 8 :MAX 49 :SD 0.34992707 :VAR 0.12244896 :QV (CARIMUSI CARIART CARIDRAM CARIDANC CARIPHOT CARINDDE CARINTE1)) (:SCALEDATA SINHELP :N 10 :REL 0.60010005 :MN 4.2 :TOT 42 :MAX 70 :SD 2.6758175 :VAR 7.16 :QV (CARITEAC CARICOUN CARIEDUC CARIHADU CARIHCHI CARITVOC CARICOM4 CARSOCWO CARK12TE CARMINIS)) (:SCALEDATA SINLANG :N 9 :REL 0.143 :MN 1.0 :TOT 9 :MAX 63 :SD 0.0 :VAR 0.0 :QV (CARIFREN CARIITAL CARIGERM CARIRUSS CARIJAPN CARICHIN CARICLAS CARISPAN CARIPOR)) (:SCALEDATA SINMED :N 7 :REL 0.18385716 :MN 1.2857143 :TOT 9 :MAX 49 :SD 0.6998542 :VAR 0.4897959 :QV (CARIMD CARINURS CARIPTHE CARIHEAL CARIKINE CARICOM5 CARMEDTE)) (:SCALEDATA SINMILTC :N 3 :REL 0.143 :MN 1.0 :TOT 3 :MAX 21 :SD 0.0 :VAR 0.0 :QV (CARILAW CARICRIM CARIMIL7)) (:SCALEDATA INNATSCI :N 5 :REL 0.3716 :MN 2.6 :TOT 13 :MAX 35 :SD 1.1999999 :VAR 1.4399998 :QV (CARICHE3 CARIPHYS CARIGEOL CARIASTR CARIENVI)) (:SCALEDATA SINSOCSC :N 11 :REL 0.45472735 :MN 3.1818183 :TOT 35 :MAX 77 :SD 1.6958871 :VAR 2.876033 :QV (CARIPSYC CARISOCO CARIHIST CARIPOLS CARIECON CARGEOGR CARIAMER CARIANTR CARIANTH CARISPEE CARLING)) (:SCALEDATA SINWOETH :N 6 :REL 0.143 :MN 1.0 :TOT 6 :MAX 42 :SD 0.0 :VAR 0.0 :QV (CARIAIST CARIBSTU CARIMEXA CARIASAM CARIAMST CARIWSTU)) (:SCALEDATA SINWRITE :N 2 :REL 0.143 :MN 1.0 :TOT 2 :MAX 14 :SD 0.0 :VAR 0.0 :QV (CARIENGL CARIJOUR)) (:SCALEDATA SEHAPPY :N 1 :REL 0.90900004 :MN 10.0 :TOT 10 :MAX 11 :SD 0.0 :VAR 0.0 :QV NIL :SS ("HAPSDMEANSPIRITSS" "HAPCAREEREXSS" "HAPRECPESS" "HAPAREASS" "HAPFAMSS" "HAPROMSS" "HAPFRIENDSSS" "HAPFUTURESS" "HAPPASTSS" "HAPRECENTSS")) (:QV (HAPSELFD HAPSPIRI)) (:QV (HAPCARFU HAPCARNW)) (:QV (HAPPE HAPRECRE)) (:QV (HAPAREA)) (:QV (HAPFAMIL)) (:QV (HAPSEXRE)) (:QV (HAPCLFRN HAPFRIEN HAPWKREL)) (:QV (HAPEXPEC)) (:QV (HAPLIFE)) (:QV (HAPYEAR HAP3YEAR)) (:SCALEDATA SEHAPPY :N 16 :REL 1.0 :MN 7.0 :TOT 112 :MAX 112 :SD 0.0 :VAR 0.0 :QV (HAPCLFRN HAPCARNW HAPCARFU HAPFRIEN HAPAREA HAPWKREL HAPPE HAPRECRE HAPSEXRE HAPFAMIL HAPSELFD HAPSPIRI HAPYEAR HAP3YEAR HAPLIFE HAPEXPEC) :SS ("HAPSDMEANSPIRITSS" "HAPCAREEREXSS" "HAPRECPESS" "HAPAREASS" "HAPFAMSS" "HAPROMSS" "HAPFRIENDSSS" "HAPFUTURESS" "HAPPASTSS" "HAPRECENTSS")) (:SUBSCALEDATA "HAPSDMEANSPIRITSS" :N 2 :REL 1.0 :MN 7.0 :TOT 14 :MAX 14 :SD 0.0 :VAR 0.0 :QV (HAPSELFD HAPSPIRI)) (:SUBSCALEDATA "HAPCAREEREXSS" :N 2 :REL 1.0 :MN 7.0 :TOT 14 :MAX 14 :SD 0.0 :VAR 0.0 :QV (HAPCARFU HAPCARNW)) (:SUBSCALEDATA "HAPRECPESS" :N 2 :REL 1.0 :MN 7.0 :TOT 14 :MAX 14 :SD 0.0 :VAR 0.0 :QV (HAPPE HAPRECRE)) (:SUBSCALEDATA "HAPAREASS" :N 1 :REL 1.0 :MN 7.0 :TOT 7 :MAX 7 :SD 0.0 :VAR 0.0 :QV (HAPAREA)) (:SUBSCALEDATA "HAPFAMSS" :N 1 :REL 1.0 :MN 7.0 :TOT 7 :MAX 7 :SD 0.0 :VAR 0.0 :QV (HAPFAMIL)) (:SUBSCALEDATA "HAPROMSS" :N 1 :REL 1.0 :MN 7.0 :TOT 7 :MAX 7 :SD 0.0 :VAR 0.0 :QV (HAPSEXRE)) (:SUBSCALEDATA "HAPFRIENDSSS" :N 3 :REL 1.0 :MN 7.0 :TOT 21 :MAX 21 :SD 0.0 :VAR 0.0 :QV (HAPCLFRN HAPFRIEN HAPWKREL)) (:SUBSCALEDATA "HAPFUTURESS" :N 1 :REL 1.0 :MN 7.0 :TOT 7 :MAX 7 :SD 0.0 :VAR 0.0 :QV (HAPEXPEC)) (:SUBSCALEDATA "HAPPASTSS" :N 1 :REL 1.0 :MN 7.0 :TOT 7 :MAX 7 :SD 0.0 :VAR 0.0 :QV (HAPLIFE)) (:SUBSCALEDATA "HAPRECENTSS" :N 2 :REL 1.0 :MN 7.0 :TOT 14 :MAX 14 :SD 0.0 :VAR 0.0 :QV (HAPYEAR HAP3YEAR)) (:SCALEDATA SRDEPRES :N 6 :REL 1.0 :MN 9.0 :TOT 54 :MAX 54 :SD 1.6329932 :VAR 2.6666668 :QV (RDEPFEEL RDEPTHOU RDEPDYSS RDEPMAJS RDEPMEDS RDEPTHER) :SS ("SSDELODEPSYMP" "SSDELODEPTREATS")) (:SUBSCALEDATA "SSDELODEPSYMP" :N 4 :REL 1.0 :MN 8.5 :TOT 34 :MAX 34 :SD 1.6583124 :VAR 2.75 :QV (RDEPFEEL RDEPTHOU RDEPDYSS RDEPMAJS)) (:SUBSCALEDATA "SSDELODEPTREATS" :N 2 :REL 1.0 :MN 10.0 :TOT 20 :MAX 20 :SD 1.0 :VAR 1.0 :QV (RDEPMEDS RDEPTHER)) (:SCALEDATA SRANXIET :N 9 :REL 1.0 :MN 9.222222 :TOT 83 :MAX 83 :SD 2.3934067 :VAR 5.728395 :QV (RANXPERF RANXALLT RANXPSTD RANXSOCI RANXOCD RANXPHOB RANXPANI RANXTHER RANXMEDS) :SS ("SSAXLOPERFGENANX" "SSAXLOWFEAROCD" "SSAXLOANXTREATS")) (:SUBSCALEDATA "SSAXLOPERFGENANX" :N 4 :REL 1.0 :MN 7.0 :TOT 28 :MAX 28 :SD 0.0 :VAR 0.0 :QV (RANXPERF RANXALLT RANXPSTD RANXSOCI)) (:SUBSCALEDATA "SSAXLOWFEAROCD" :N 3 :REL 1.0 :MN 11.666667 :TOT 35 :MAX 35 :SD 1.885618 :VAR 3.5555554 :QV (RANXOCD RANXPHOB RANXPANI)) (:SUBSCALEDATA "SSAXLOANXTREATS" :N 2 :REL 1.0 :MN 10.0 :TOT 20 :MAX 20 :SD 1.0 :VAR 1.0 :QV (RANXTHER RANXMEDS)) (:SCALEDATA SRANGAGG :N 5 :REL 0.775 :MN 6.2 :TOT 31 :MAX 40 :SD 0.97979594 :VAR 0.96000004 :QV (RANGFEEL RANGYELL RANGDOMI RANGTHOU RANGDEST)) (:SCALEDATA SRELHLTH :N 6 :REL 0.8928334 :MN 7.5 :TOT 45 :MAX 50 :SD 1.9790571 :VAR 3.9166668 :QV (RHLFREQI RHLALCOH RHLSMOKE RHLDRUGS RHLPHYSI RHLWEIGH) :SS ("SSHELONEGADDICTHABS" "SSHELOFREQILL" "SSHEPELOWEIGHT")) (:SUBSCALEDATA "SSHELONEGADDICTHABS" :N 3 :REL 0.8333333 :MN 6.6666665 :TOT 20 :MAX 24 :SD 1.885618 :VAR 3.5555554 :QV (RHLALCOH RHLSMOKE RHLDRUGS)) (:SUBSCALEDATA "SSHELOFREQILL" :N 1 :REL 0.85700006 :MN 6.0 :TOT 6 :MAX 7 :SD 0.0 :VAR 0.0 :QV (RHLFREQI)) (:SUBSCALEDATA "SSHEPELOWEIGHT" :N 2 :REL 1.0 :MN 9.5 :TOT 19 :MAX 19 :SD 0.5 :VAR 0.25 :QV (RHLPHYSI RHLWEIGH)) (:SCALEDATA SRPEOPLE :N 7 :REL 0.7687143 :MN 6.857143 :TOT 48 :MAX 66 :SD 2.8996833 :VAR 8.408163 :QV (RPEHAPFR RPEHMARR RPENETW RPECLFRN RPENUMFR RPENUMCL RPECOMMI) :SS ("SSRECLOSEFRIENDS" "SSREROMRELSUC" "SSRENUMFRIENDS" "SSREHAPSUCFRS")) (:SUBSCALEDATA "SSRECLOSEFRIENDS" :N 2 :REL 0.85700006 :MN 6.0 :TOT 12 :MAX 14 :SD 0.0 :VAR 0.0 :QV (RPENETW RPECLFRN)) (:SUBSCALEDATA "SSREROMRELSUC" :N 2 :REL 1.0 :MN 10.5 :TOT 21 :MAX 21 :SD 2.5 :VAR 6.25 :QV (RPEHMARR RPECOMMI)) (:SUBSCALEDATA "SSRENUMFRIENDS" :N 2 :REL 0.33350003 :MN 4.0 :TOT 8 :MAX 24 :SD 1.0 :VAR 1.0 :QV (RPENUMFR RPENUMCL)) (:SUBSCALEDATA "SSREHAPSUCFRS" :N 2 :REL 1.0 :MN 10.5 :TOT 21 :MAX 21 :SD 2.5 :VAR 6.25 :QV (RPEHMARR RPECOMMI))))




;;xxx
;; (setf *pc-csq-data-list '(:PCSYM-ELM-LISTS ((CAREFOROTHERS (MOTHER FATHER BEST-M-FRIEND (CAREFOROTHERS CAREFOROTHERS :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12) (CAREFOROTHERS CAREFOROTHERS :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12) (CAREFOROTHERS CAREFOROTHERS :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12))) (INTIMATE (MOTHER BEST-M-FRIEND BEST-F-FRIEND (INTIMATE INTIMATE :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (FLEXIBLE (MOTHER BEST-F-FRIEND F-DISLIKE (FLEXIBLE FLEXIBLE :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (CASUAL (MOTHER M-DISLIKE PER-MOSTFUN (CASUAL CASUAL :SINGLE "Not important, unsure, or neutral" "0.500" 6 1 12 6 SCORED-NORMAL PRIORITY12))) (EGOTISTICAL (MOTHER F-DISLIKE CHILD-DISLIKE (EGOTISTICAL EGOTISTICAL :SINGLE "Moderately important" "0.667" 8 1 12 8 SCORED-NORMAL PRIORITY12))) (EXUBERANT (MOTHER M-ADMIRE FAV-M-STAR (EXUBERANT EXUBERANT :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (NOTTHEORIST (MOTHER PER-MOSTFUN ROLE-MODEL (NOTTHEORIST NOTTHEORIST :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (LOVEX (MOTHER PER-ROMANCE FAV-POLITICO (LOVEX LOVEX :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (LOVEDANCE (MOTHER CHILD-FRIEND FAV-M-STAR (LOVEDANCE LOVEDANCE :SINGLE "Moderately important" "0.667" 8 1 12 8 SCORED-NORMAL PRIORITY12))) (HELPINGCAREER (MOTHER WORK-FRIEND FAV-SPIRITUAL (HELPINGCAREER HELPINGCAREER :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12))) (HIGHIMPACT (MOTHER FAV-M-STAR FAV-POLITICO (HIGHIMPACT HIGHIMPACT :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12))) (PSYCHOLOGISTS (FATHER BEST-M-FRIEND WORK-FRIEND (PSYCHOLOGISTS PSYCHOLOGISTS :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (UNDERSTANDING (FATHER BEST-F-FRIEND FAV-BOSS (UNDERSTANDING UNDERSTANDING :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (IMPULSIVE (FATHER M-DISLIKE FAV-POLITICO (IMPULSIVE IMPULSIVE :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (ENTERTAINER (FATHER ROLE-MODEL FAV-M-STAR (ENTERTAINER ENTERTAINER :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (AGGRESSIVE (FATHER CHILD-DISLIKE FAV-POLITICO (AGGRESSIVE AGGRESSIVE :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (PATERNAL (FATHER FAV-BOSS FAV-M-STAR (PATERNAL PATERNAL :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (CAREABOUTOTHERSFEE (BEST-M-FRIEND BEST-F-FRIEND M-DISLIKE (CAREABOUTOTHERSFEE CAREABOUTOTHERSFEE :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12))) (INSPIREOTHERS (BEST-M-FRIEND M-DISLIKE F-ADMIRE (INSPIREOTHERS INSPIREOTHERS :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (BESTFRIEND (BEST-M-FRIEND F-DISLIKE CHILD-FRIEND (BESTFRIEND BESTFRIEND :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (DIRECT-HONEST (BEST-M-FRIEND M-ADMIRE WORST-BOSS (DIRECT-HONEST DIRECT-HONEST :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12))) (UNBRIDLEDHUMOR (BEST-M-FRIEND PER-MOSTFUN PER-ROMANCE (UNBRIDLEDHUMOR UNBRIDLEDHUMOR :SINGLE "Not important, unsure, or neutral" "0.500" 6 1 12 6 SCORED-NORMAL PRIORITY12))) (FANTASYWORLD (BEST-M-FRIEND PER-ROMANCE FAV-M-STAR (FANTASYWORLD FANTASYWORLD :SINGLE "Not important, unsure, or neutral" "0.500" 6 1 12 6 SCORED-NORMAL PRIORITY12))) (ATHLETIC (BEST-M-FRIEND CHILD-FRIEND WORST-BOSS (ATHLETIC ATHLETIC :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12))) (ESPOSECHRISTIAN (BEST-M-FRIEND WORK-FRIEND FAV-TEACHER (ESPOSECHRISTIAN ESPOSECHRISTIAN :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12))) (CRITICAL (BEST-M-FRIEND WORST-BOSS DIS-TEACHER (CRITICAL CRITICAL :SINGLE "Not important, unsure, or neutral" "0.500" 6 1 12 6 SCORED-NORMAL PRIORITY12))) (SEXDEVIANCE (BEST-F-FRIEND M-DISLIKE WORK-PER-DISLIKE (SEXDEVIANCE SEXDEVIANCE :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (GLOBALPERSPECTIVE (BEST-F-FRIEND F-DISLIKE FAV-POLITICO (GLOBALPERSPECTIVE GLOBALPERSPECTIVE :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (FUNCOMPANION (BEST-F-FRIEND F-ADMIRE PER-ROMANCE (FUNCOMPANION FUNCOMPANION :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (SELF-DISCLOSE (BEST-F-FRIEND PER-MOSTFUN WORST-BOSS (SELF-DISCLOSE SELF-DISCLOSE :SINGLE "Moderately important" "0.667" 8 1 12 8 SCORED-NORMAL PRIORITY12))) (MISSIONSPREADPSYCH (BEST-F-FRIEND ROLE-MODEL WORK-FRIEND (MISSIONSPREADPSYCH MISSIONSPREADPSYCH :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (CRUEL (BEST-F-FRIEND CHILD-DISLIKE WORK-PER-DISLIKE (CRUEL CRUEL :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12))) (COURTEOUS (BEST-F-FRIEND WORK-PER-DISLIKE FAV-TEACHER (COURTEOUS COURTEOUS :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (DEEPUNDERSTANDPEOP (BEST-F-FRIEND FAV-POLITICO DIS-TEACHER (DEEPUNDERSTANDPEOP DEEPUNDERSTANDPEOP :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (DEMOCRATICLEADER (M-DISLIKE M-ADMIRE F-ADMIRE (DEMOCRATICLEADER DEMOCRATICLEADER :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (PSYCHOLOGIST (M-DISLIKE F-ADMIRE WORK-FRIEND (PSYCHOLOGIST PSYCHOLOGIST :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (METICULOUS (M-DISLIKE PER-MOSTFUN FAV-SPIRITUAL (METICULOUS METICULOUS :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (COGNITIVEPSYCHS (M-DISLIKE ROLE-MODEL FAV-M-STAR (COGNITIVEPSYCHS COGNITIVEPSYCHS :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (EMOTIONAL (M-DISLIKE CHILD-DISLIKE FAV-POLITICO (EMOTIONAL EMOTIONAL :SINGLE "Moderately important" "0.667" 8 1 12 8 SCORED-NORMAL PRIORITY12))) (CHARMING (M-DISLIKE FAV-BOSS FAV-M-STAR (CHARMING CHARMING :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (VALUEGROUPHAPPINES (F-DISLIKE M-ADMIRE F-ADMIRE (VALUEGROUPHAPPINES VALUEGROUPHAPPINES :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12))) (LOCALLEADER (F-DISLIKE F-ADMIRE WORK-FRIEND (LOCALLEADER LOCALLEADER :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (HIGHLYEDUCATED (F-DISLIKE PER-MOSTFUN FAV-SPIRITUAL (HIGHLYEDUCATED HIGHLYEDUCATED :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (ENLIGHTENWORLD (F-DISLIKE ROLE-MODEL FAV-M-STAR (ENLIGHTENWORLD ENLIGHTENWORLD :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12))) (PETTY (F-DISLIKE CHILD-DISLIKE FAV-POLITICO (PETTY PETTY :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (ENCOURAGING (F-DISLIKE FAV-BOSS FAV-M-STAR (ENCOURAGING ENCOURAGING :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (HUMOROUS (M-ADMIRE F-ADMIRE PER-MOSTFUN (HUMOROUS HUMOROUS :SINGLE "Moderately important" "0.667" 8 1 12 8 SCORED-NORMAL PRIORITY12))) (GREATLEADER (M-ADMIRE PER-MOSTFUN FAV-BOSS (GREATLEADER GREATLEADER :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (CONFIDENT-SELF-EST (M-ADMIRE ROLE-MODEL CHILD-DISLIKE (CONFIDENT-SELF-EST CONFIDENT-SELF-EST :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (INTERPERSONALSKILL (M-ADMIRE CHILD-DISLIKE WORK-FRIEND (INTERPERSONALSKILL INTERPERSONALSKILL :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (INTIMATELYASSERTIV (M-ADMIRE WORK-PER-DISLIKE FAV-POLITICO (INTIMATELYASSERTIV INTIMATELYASSERTIV :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (GREATSPEAKER (M-ADMIRE FAV-POLITICO FAV-SPIRITUAL (GREATSPEAKER GREATSPEAKER :SINGLE "Moderately important" "0.667" 8 1 12 8 SCORED-NORMAL PRIORITY12))) (AUTONOMOUS (F-ADMIRE PER-ROMANCE CHILD-DISLIKE (AUTONOMOUS AUTONOMOUS :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12))) (HIGHINTELLIGENCE (F-ADMIRE ROLE-MODEL DIS-TEACHER (HIGHINTELLIGENCE HIGHINTELLIGENCE :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12))) (GOODNEGOTIATOR (F-ADMIRE WORK-FRIEND WORK-PER-DISLIKE (GOODNEGOTIATOR GOODNEGOTIATOR :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (PROGRESSIVE (F-ADMIRE FAV-BOSS DIS-TEACHER (PROGRESSIVE PROGRESSIVE :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12))) (CLOSE (PER-MOSTFUN PER-ROMANCE WORK-PER-DISLIKE (CLOSE CLOSE :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (PLAYFUL (PER-MOSTFUN CHILD-FRIEND WORK-FRIEND (PLAYFUL PLAYFUL :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (COUNSELORS (PER-MOSTFUN WORK-FRIEND WORST-BOSS (COUNSELORS COUNSELORS :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (INDUSTRIOUS (PER-MOSTFUN WORST-BOSS FAV-POLITICO (INDUSTRIOUS INDUSTRIOUS :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (SEXY (PER-ROMANCE ROLE-MODEL FAV-M-STAR (SEXY SEXY :SINGLE "Moderately important" "0.667" 8 1 12 8 SCORED-NORMAL PRIORITY12))) (UNDERSTANDING4 (PER-ROMANCE CHILD-DISLIKE FAV-POLITICO (UNDERSTANDING4 UNDERSTANDING4 :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (SOFTSPOKEN (PER-ROMANCE FAV-BOSS FAV-M-STAR (SOFTSPOKEN SOFTSPOKEN :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (TEAMMATE (ROLE-MODEL CHILD-FRIEND CHILD-DISLIKE (TEAMMATE TEAMMATE :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (BEHAVIORALPSYCH (ROLE-MODEL WORK-FRIEND FAV-BOSS (BEHAVIORALPSYCH BEHAVIORALPSYCH :SINGLE "Moderately important" "0.667" 8 1 12 8 SCORED-NORMAL PRIORITY12))) (OPTIMISTIC (ROLE-MODEL WORST-BOSS FAV-M-STAR (OPTIMISTIC OPTIMISTIC :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12))) (CHILDHOODFRIEND (CHILD-FRIEND CHILD-DISLIKE FAV-POLITICO (CHILDHOODFRIEND CHILDHOODFRIEND :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (DEBONAIRE (CHILD-FRIEND FAV-BOSS FAV-M-STAR (DEBONAIRE DEBONAIRE :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (HIGHSTANDARDS (CHILD-DISLIKE WORK-FRIEND WORK-PER-DISLIKE (HIGHSTANDARDS HIGHSTANDARDS :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (TEACHER1 (CHILD-DISLIKE FAV-BOSS DIS-TEACHER (TEACHER1 TEACHER1 :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (LIBERALCHRISTIAN (WORK-FRIEND WORK-PER-DISLIKE FAV-TEACHER (LIBERALCHRISTIAN LIBERALCHRISTIAN :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (EMPATHETICLISTENER (WORK-FRIEND FAV-POLITICO DIS-TEACHER (EMPATHETICLISTENER EMPATHETICLISTENER :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (OVERCOMEDIFFICULTI (WORK-PER-DISLIKE FAV-POLITICO FAV-SPIRITUAL (OVERCOMEDIFFICULTI OVERCOMEDIFFICULTI :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (FIGHTILLNESS (WORST-BOSS FAV-M-STAR FAV-POLITICO (FIGHTILLNESS FIGHTILLNESS :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (PUBLICSERVANT (TEACHER POLICEMAN SALESPERSON (PUBLICSERVANT PUBLICSERVANT :SINGLE "Not important, unsure, or neutral" "0.500" 6 1 12 6 SCORED-NORMAL PRIORITY12))) (SECULAR (TEACHER POLICEMAN MUSLIMS (SECULAR SECULAR :SINGLE "Moderately important" "0.667" 8 1 12 8 SCORED-NORMAL PRIORITY12))) (SEEKATTENTION (TEACHER SALESPERSON MOVIE-STAR (SEEKATTENTION SEEKATTENTION :SINGLE "Not important, unsure, or neutral" "0.500" 6 1 12 6 SCORED-NORMAL PRIORITY12))) (HELPER (TEACHER DOCTOR DANCER (HELPER HELPER :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (SPREADKNOWLEDGE (TEACHER LAWYER SCIENTIST (SPREADKNOWLEDGE SPREADKNOWLEDGE :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12))) (LAWFUL (TEACHER LAWYER BLACKS (LAWFUL LAWFUL :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (MANAGER0 (TEACHER BUSINESS-OWNER ATHEISTS (MANAGER0 MANAGER0 :SINGLE "Moderately important" "0.667" 8 1 12 8 SCORED-NORMAL PRIORITY12))) (PRAGMATIC (TEACHER MANAGER MUSLIMS (PRAGMATIC PRAGMATIC :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (GROUPKNOWLEDGEWORK (TEACHER SCIENTIST JEWS (GROUPKNOWLEDGEWORK GROUPKNOWLEDGEWORK :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (VERBALSKILLS (TEACHER FARMER JEWS (VERBALSKILLS VERBALSKILLS :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (LESSCIVILIZED (TEACHER DRUG-DEALER MUSLIMS (LESSCIVILIZED LESSCIVILIZED :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (REPRESENTGROUP (TEACHER POLITICIAN ATHEISTS (REPRESENTGROUP REPRESENTGROUP :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (PERFORMER (TEACHER DANCER BLACKS (PERFORMER PERFORMER :SINGLE "Not important, unsure, or neutral" "0.500" 6 1 12 6 SCORED-NORMAL PRIORITY12))) (SHOWBUSINESS (TEACHER COMEDIAN MOVIE-STAR (SHOWBUSINESS SHOWBUSINESS :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (SOLVEPROBLEMS (TEACHER ENGINEER MUSLIMS (SOLVEPROBLEMS SOLVEPROBLEMS :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12))) (STARPERFORMER (TEACHER MOVIE-STAR ROCK-STAR (STARPERFORMER STARPERFORMER :SINGLE "Not important, unsure, or neutral" "0.500" 6 1 12 6 SCORED-NORMAL PRIORITY12))) (LESSWEALTH (TEACHER ROCK-STAR HISPANICS (LESSWEALTH LESSWEALTH :SINGLE "Moderately important" "0.667" 8 1 12 8 SCORED-NORMAL PRIORITY12))) (DEPENDGOV (TEACHER CATHOLICS BLACKS (DEPENDGOV DEPENDGOV :SINGLE "Moderately important" "0.667" 8 1 12 8 SCORED-NORMAL PRIORITY12))) (IMMIGRANTS (TEACHER MUSLIMS HISPANICS (IMMIGRANTS IMMIGRANTS :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (PROFIT-ORIENTED (POLICEMAN SALESPERSON BUSINESS-OWNER (PROFIT-ORIENTED PROFIT-ORIENTED :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (OCCUPATION (POLICEMAN SALESPERSON ANGLOS (OCCUPATION OCCUPATION :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (PHYSICALWELLBEING (POLICEMAN DOCTOR PROTESTANTS (PHYSICALWELLBEING PHYSICALWELLBEING :SINGLE "Moderately important" "0.667" 8 1 12 8 SCORED-NORMAL PRIORITY12))) (LEGALEXPERT (POLICEMAN LAWYER MOVIE-STAR (LEGALEXPERT LEGALEXPERT :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (SELF-DISCIPLINE (POLICEMAN BUSINESS-OWNER COMEDIAN (SELF-DISCIPLINE SELF-DISCIPLINE :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12))) (ENFORCERULES (POLICEMAN MANAGER DANCER (ENFORCERULES ENFORCERULES :SINGLE "Moderately important" "0.667" 8 1 12 8 SCORED-NORMAL PRIORITY12))) (CREATENEWRULES (POLICEMAN SCIENTIST POLITICIAN (CREATENEWRULES CREATENEWRULES :SINGLE "Moderately important" "0.667" 8 1 12 8 SCORED-NORMAL PRIORITY12))) (SOCIALCONSTRAINTS (POLICEMAN FARMER POLITICIAN (SOCIALCONSTRAINTS SOCIALCONSTRAINTS :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (RESPECTED (POLICEMAN DRUG-DEALER DANCER (RESPECTED RESPECTED :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (SEEKEXTERNALAPPROV (POLICEMAN POLITICIAN COMEDIAN (SEEKEXTERNALAPPROV SEEKEXTERNALAPPROV :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (CREATIVE (POLICEMAN DANCER MOVIE-STAR (CREATIVE CREATIVE :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (RITUALISTIC (POLICEMAN ARTIST PROTESTANTS (RITUALISTIC RITUALISTIC :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (LESSMORALISTIC (POLICEMAN COMEDIAN ANGLOS (LESSMORALISTIC LESSMORALISTIC :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (PROFESSIONAL (POLICEMAN HOUSE-CLEANER CHURCH-MINISTER (PROFESSIONAL PROFESSIONAL :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (DRAMATIC (POLICEMAN MOVIE-STAR HISPANICS (DRAMATIC DRAMATIC :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (EUROCENTRICVALUES (POLICEMAN CHURCH-MINISTER ANGLOS (EUROCENTRICVALUES EUROCENTRICVALUES :SINGLE "Moderately important" "0.667" 8 1 12 8 SCORED-NORMAL PRIORITY12))) (INDIVIDUALISTIC (POLICEMAN PROTESTANTS ASIANS (INDIVIDUALISTIC INDIVIDUALISTIC :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (CATHOLIC (POLICEMAN ATHEISTS HISPANICS (CATHOLIC CATHOLIC :SINGLE "Not important, unsure, or neutral" "0.500" 6 1 12 6 SCORED-NORMAL PRIORITY12))) (PEOPLE-JOB (SALESPERSON DOCTOR HOUSE-CLEANER (PEOPLE-JOB PEOPLE-JOB :SINGLE "Not important, unsure, or neutral" "0.500" 6 1 12 6 SCORED-NORMAL PRIORITY12))) (GREEDY (SALESPERSON LAWYER DANCER (GREEDY GREEDY :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (OWNER (SALESPERSON BUSINESS-OWNER FARMER (OWNER OWNER :SINGLE "Mildly important" "0.583" 7 1 12 7 SCORED-NORMAL PRIORITY12))) (PERFORMANCE-ORIENT (SALESPERSON BUSINESS-OWNER ASIANS (PERFORMANCE-ORIENT PERFORMANCE-ORIENT :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (HIGHSTATUS (SALESPERSON MANAGER HISPANICS (HIGHSTATUS HIGHSTATUS :SINGLE "Moderately important" "0.667" 8 1 12 8 SCORED-NORMAL PRIORITY12))) (RATIONAL (SALESPERSON SCIENTIST ANGLOS (RATIONAL RATIONAL :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (PRACTICAL (SALESPERSON FARMER ANGLOS (PRACTICAL PRACTICAL :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (PERSUASIVE (SALESPERSON DRUG-DEALER HISPANICS (PERSUASIVE PERSUASIVE :SINGLE "Extremely important" "0.833" 10 1 12 10 SCORED-NORMAL PRIORITY12))) (INFLUENCIAL (SALESPERSON POLITICIAN ASIANS (INFLUENCIAL INFLUENCIAL :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (MANUALWORK (SALESPERSON ARTIST HOUSE-CLEANER (MANUALWORK MANUALWORK :SINGLE "Moderately important" "0.667" 8 1 12 8 SCORED-NORMAL PRIORITY12))) (NOTHISTORY-ORIENTE (SALESPERSON COMEDIAN PROTESTANTS (NOTHISTORY-ORIENTE NOTHISTORY-ORIENTE :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (NOTANALYTIC (SALESPERSON ENGINEER HISPANICS (NOTANALYTIC NOTANALYTIC :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (NOTLOYAL (SALESPERSON MOVIE-STAR JEWS (NOTLOYAL NOTLOYAL :SINGLE "Moderately important" "0.667" 8 1 12 8 SCORED-NORMAL PRIORITY12))) (SPIRITUALINTEGRATI (SALESPERSON CHURCH-MINISTER PROTESTANTS (SPIRITUALINTEGRATI SPIRITUALINTEGRATI :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12))) (SEEKULTIMATETRUTH (SALESPERSON PROTESTANTS BUDDHISTS (SEEKULTIMATETRUTH SEEKULTIMATETRUTH :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12))) (MATERIALISTIC (SALESPERSON BUDDHISTS ANGLOS (MATERIALISTIC MATERIALISTIC :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (SKILLEDMOVEMENTS (DOCTOR LAWYER DANCER (SKILLEDMOVEMENTS SKILLEDMOVEMENTS :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))))))