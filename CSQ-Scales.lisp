;;******************************* CSQ-scales.lisp  ************************
;;
;;
;;LIST-CSQ-CLASSES
;;
;;ddd
(defun list-CSQ-classes ()
  (list-file-objects "CSQ-scales" '(my-defclass) :dir "CogSys-Model")
  )
;; (list-CSQ-classes)

;;PC-CATEGORIES =======================================

(my-defclass PC-BV (PC assessment)
               ()           
               (:default-initargs
                :title "PC-BV"
                :scale-group-description "Higher order (superordinate) belief-value personal constructs. Created by user as a way 2 elements are alike and different from the third. Created on the fly."
                ))

(my-defclass PC-ELEMENT (PC assessment )
               ()           
               (:default-initargs
                :title "PC-BV"
                :scale-group-description "Elements used to find higher order (superordinate) belief-value personal constructs. Compared in combos of 3."
                ))


;;PC-SCALES ===============================================

;;SET 1: CLASSES OF PC-ELEMENTS -----------------------------------------------

(my-defclass PCE-PEOPLE  (PC-ELEMENT SCALE) 
               ()
               (:default-initargs
                :scale-name "PCE-PEOPLE"
                :name-string "PCE-PEOPLE"
                :label  "PCE-PEOPLE"
                :title "PCE-PEOPLE"
                :description "PCE-PEOPLE (23 items)"
                ;;scale questions created on fly and added later
                :scale-questions  '(MOTHER FATHER BEST-M-FRIEND BEST-F-FRIEND M-DISLIKE F-DISLIKE M-ADMIRE F-ADMIRE PER-MOSTFUN PER-ROMANCE ROLE-MODEL CHILD-FRIEND) ;; CHILD-DISLIKE WORK-FRIEND WORK-PER-DISLIKE FAV-BOSS WORST-BOSS FAV-M-STAR FAV-POLITICO FAV-TEACHER WORST-BOSS FAV-SPIRITUAL DIS-TEACHER)
                :num-questions  12   ;;23 
                ))
#|CL-USER 32 > (find-qvars-for-scale *all-pc-elements 'pce-people)
(MOTHER FATHER BEST-M-FRIEND BEST-F-FRIEND M-DISLIKE F-DISLIKE M-ADMIRE F-ADMIRE PER-MOSTFUN PER-ROMANCE ROLE-MODEL CHILD-FRIEND CHILD-DISLIKE WORK-FRIEND WORK-PER-DISLIKE FAV-BOSS WORST-BOSS FAV-M-STAR FAV-POLITICO FAV-TEACHER WORST-BOSS FAV-SPIRITUAL DIS-TEACHER)
(MOTHERQ FATHERQ BEST-M-FRIENDQ BEST-F-FRIENDQ M-DISLIKEQ F-DISLIKEQ M-ADMIREQ F-ADMIREQ PER-MOSTFUNQ PER-ROMANCEQ ROLE-MODELQ CHILD-FRIENDQ CHILD-DISLIKEQ WORK-FRIENDQ WORK-PER-DISLIKEQ FAV-BOSSQ WORST-BOSSQ FAV-M-STARQ FAV-POLITICOQ FAV-TEACHERQ WORST-BOSSQ FAV-SPIRITUALQ DIS-TEACHERQ)
((MOTHER 1 "mother" MOTHERQ) (FATHER 2 "father" FATHERQ) (BEST-M-FRIEND 3 "best-m-friend" BEST-M-FRIENDQ) (BEST-F-FRIEND 4 "best-f-friend" BEST-F-FRIENDQ) (M-DISLIKE 5 "m-dislike" M-DISLIKEQ) (F-DISLIKE 6 "f-dislike" F-DISLIKEQ) (M-ADMIRE 7 "m-admire" M-ADMIREQ) (F-ADMIRE 8 "f-admire" F-ADMIREQ) (PER-MOSTFUN 9 "per-mostfun" PER-MOSTFUNQ) (PER-ROMANCE 10 "per-romance" PER-ROMANCEQ) (ROLE-MODEL 11 "role-model" ROLE-MODELQ) (CHILD-FRIEND 12 "child-friend" CHILD-FRIENDQ) (CHILD-DISLIKE 13 "child-dislike" CHILD-DISLIKEQ) (WORK-FRIEND 14 "work-friend" WORK-FRIENDQ) (WORK-PER-DISLIKE 15 "work-per-dislike" WORK-PER-DISLIKEQ) (FAV-BOSS 16 "fav-boss" FAV-BOSSQ) (WORST-BOSS 17 "worst-boss" WORST-BOSSQ) (FAV-M-STAR 18 "fav-m-star" FAV-M-STARQ) (FAV-POLITICO 19 "fav-politico" FAV-POLITICOQ) (FAV-TEACHER 20 "fav-teacher" FAV-TEACHERQ) (WORST-BOSS 21 "worst-boss" WORST-BOSSQ) (FAV-SPIRITUAL 22 "fav-spiritual" FAV-SPIRITUALQ) (DIS-TEACHER 23 "dis-teacher" DIS-TEACHERQ))
23|#


(my-defclass PCE-GROUPS  (PC-ELEMENT SCALE)
               ()
               (:default-initargs
                :scale-name "PCE-GROUPS"
                :name-string "PCE-GROUPS"
                :label  "PCE-GROUPS"
                :title "PCE-GROUPS"
                :description "PCE-GROUPS (25 items)"
                ;;scale questions created on fly and added later
                :scale-questions  '(TEACHER POLICEMAN SALESPERSON DOCTOR LAWYER BUSINESS MANAGER SCIENTIST FARMER DRUG POLITICIAN DANCER ARTIST COMEDIAN ENGINEER HOUSE MOVIE-STAR ROCK-STAR CHURCH-MINISTER CATHOLICS PROTESTANTS JEWS MUSLIMS BUDDHISTS ATHEISTS)
                :num-questions  25
                ))
#|CL-USER 39 > (find-qvars-for-scale *all-pc-elements 'pce-groups)
(TEACHER POLICEMAN SALESPERSON DOCTOR LAWYER BUSINESS-OWNER MANAGER SCIENTIST FARMER DRUG-DEALER POLITICIAN DANCER ARTIST COMEDIAN ENGINEER HOUSE-CLEANER MOVIE-STAR ROCK-STAR CHURCH-MINISTER CATHOLICS PROTESTANTS JEWS MUSLIMS BUDDHISTS ATHEISTS)
(TEACHERQ POLICEMANQ SALESPERSONQ DOCTORQ LAWYERQ BUSINESS-OWNERQ MANAGERQ SCIENTISTQ FARMERQ DRUG-DEALERQ POLITICIANQ DANCERQ ARTISTQ COMEDIANQ ENGINEERQ HOUSE-CLEANERQ MOVIE-STARQ ROCK-STARQ CHURCH-MINISTERQ CATHOLICSQ PROTESTANTSQ JEWSQ MUSLIMSQ BUDDHISTSQ ATHEISTSQ)
((TEACHER 1 "teacher" TEACHERQ) (POLICEMAN 2 "policeman" POLICEMANQ) (SALESPERSON 3 "salesperson" SALESPERSONQ) (DOCTOR 4 "doctor" DOCTORQ) (LAWYER 5 "lawyer" LAWYERQ) (BUSINESS-OWNER 6 "business-owner" BUSINESS-OWNERQ) (MANAGER 7 "manager" MANAGERQ) (SCIENTIST 8 "scientist" SCIENTISTQ) (FARMER 9 "farmer" FARMERQ) (DRUG-DEALER 10 "drug-dealer" DRUG-DEALERQ) (POLITICIAN 11 "politician" POLITICIANQ) (DANCER 12 "dancer" DANCERQ) (ARTIST 13 "artist" ARTISTQ) (COMEDIAN 14 "comedian" COMEDIANQ) (ENGINEER 15 "engineer" ENGINEERQ) (HOUSE-CLEANER 16 "house-cleaner" HOUSE-CLEANERQ) (MOVIE-STAR 17 "movie-star" MOVIE-STARQ) (ROCK-STAR 18 "rock-star" ROCK-STARQ) (CHURCH-MINISTER 19 "church-minister" CHURCH-MINISTERQ) (CATHOLICS 20 "catholics" CATHOLICSQ) (PROTESTANTS 21 "protestants" PROTESTANTSQ) (JEWS 22 "jews" JEWSQ) (MUSLIMS 23 "muslims" MUSLIMSQ) (BUDDHISTS 24 "buddhists" BUDDHISTSQ) (ATHEISTS 25 "atheists" ATHEISTSQ))
25
|#

(my-defclass PCE-SELF  (PC-ELEMENT SCALE)
             ()
             (:default-initargs
              :scale-name "PCE-SELF"
              :name-string "PCE-SELF"
              :label  "PCE-SELF"
              :title "PCE-SELF"
              :description "PCE-SELF (? items)"
              :scale-questions '(MOST-IMPORTANT-VALUE MOST-IMPORTANT-ABILITY MOST-IMPORTANT-BELIEF YOUR-PERSONALITY YOUR-BEST-CHARACTERISTIC YOUR-POSSESSIONS YOUR-WORST-CHARACTERISTIC)
              :num-questions  7
              ))
#|CL-USER 34 > (find-qvars-for-scale *all-pc-elements 'pce-self)
(MOST-IMPORTANT-VALUE MOST-IMPORTANT-ABILITY MOST-IMPORTANT-BELIEF YOUR-PERSONALITY YOUR-BEST-CHARACTERISTIC YOUR-POSSESSIONS YOUR-WORST-CHARACTERISTIC)
(MOST-IMPORTANT-VALUEQ MOST-IMPORTANT-ABILITYQ MOST-IMPORTANT-BELIEFQ YOUR-PERSONALITYQ YOUR-BEST-CHARACTERISTICQ YOUR-POSSESSIONSQ YOUR-WORST-CHARACTERISTICQ)
((MOST-IMPORTANT-VALUE 1 "Most-Important-Value" MOST-IMPORTANT-VALUEQ) (MOST-IMPORTANT-ABILITY 2 "Most-Important-Ability" MOST-IMPORTANT-ABILITYQ) (MOST-IMPORTANT-BELIEF 3 "Most-Important-Belief" MOST-IMPORTANT-BELIEFQ) (YOUR-PERSONALITY 4 "Your-Personality" YOUR-PERSONALITYQ) (YOUR-BEST-CHARACTERISTIC 5 "Your-Best-Characteristic" YOUR-BEST-CHARACTERISTICQ) (YOUR-POSSESSIONS 6 "Your-Possessions" YOUR-POSSESSIONSQ) (YOUR-WORST-CHARACTERISTIC 7 "Your-Worst-Characteristic" YOUR-WORST-CHARACTERISTICQ))
7|#



;;SET 2:  USER-DEFINED  PERSONAL CONSTRUCTS ------------------
;; POS AND NEG POLES BASED UPON ABOVE PC-ELEMENTS


(my-defclass PC-PEOPLE  (PC-BV SCALE) 
               ()
               (:default-initargs
                :name-string "PC-PEOPLE"
                :label  "PC-PEOPLE"
                :title "PC-PEOPLE"
                :description "PC-PEOPLE (23 items)"
                ;;scale questions created on fly and added later
                :scale-questions  NIL
                :num-questions  23 
                :element-combo-nums '((1 2 3)(4 5 6)(7 8 9)(10 11 12)) ;;(13 14 15)(16 17 18)(19 20 21)(22 23 24)(1 4 7)(10 13 16)(19 22  2)(3 5 8)(11 14 17)(20 23 9))
                ))



(my-defclass PC-GROUPS  (PC-BV SCALE)
               ()
               (:default-initargs
                :name-string "PC-GROUPS"
                :label  "PC-GROUPS"
                :title "PC-GROUPS"
                :description "PC-GROUPS (24 items)"
                ;;scale questions created on fly and added later
                :scale-questions  NIL
                :num-questions  24
                :element-combo-nums '((1 2 3)(4 5 6)(7 8 9)) ;;(10 11 12)(13 14 15)(16 17 18)(19 20 21)(23 24 25)(1 4 7)(10 13 16)(19 22  2)(3 5 8)(11 14 17)(20 23 25))
                ))


(my-defclass PC-SELF  (PC-BV SCALE)
               ()
               (:default-initargs
                :name-string "PC-SELF"
                :label  "PC-SELF"
                :title "PC-SELF"
                :description "PC-SELF (? items)"
                :scale-questions NIL
                :element-combo-nums '((1 2 3)(4 5 6)) ;;(7 8 9)) ;;(10 11 12)(13 14 15)(16 17 18)(19 20 21)(22 23 24)(1 4 7)(10 13 16)(19 22  2)(3 5 8)(11 14 17)(20 23 9))
                ))









;;TO FIND SCALE QUESTION QVARS ------------------------------

;;FIND-QVARS-FOR-SCALE 
;;
;;ddd
(defun find-qvars-for-scale (all-qvar-list scale-sym)
  "In CSQ-Scales"
  (let
      ((target-scale-list)
       (qvar)
       (quest)
       (qnum)
       (qvars)
       (quests)
       (quest-str)
       (quest-strs)
       (num-qs 0)
       (num-qvar-Qs)
       )
    ;;FIND TARGET-SCALE-LIST
    (loop
     for scale-list in all-qvar-list
     do
     (when (equal (car scale-list) scale-sym)
       (setf target-scale-list scale-list)
       (return))
     )
    
    (loop
     for item in target-scale-list
     do
     (when (listp item)
       (incf num-qs)
       (setf qvar-str (car item)
             qvar (my-make-symbol qvar-str)
             in-list (fifth item))
       (when (listp in-list)
         (setf qnum (my-make-symbol (second in-list))
               quest-str (third in-list)
               quest (my-make-symbol quest-str)))
       (setf qvars (append qvars (list qvar))
             quests (append quests (list quest))
             quest-strs (append quest-strs (list quest-str))
             num-qvar-Qs (append num-qvar-Qs (list (list qvar qnum qvar-str quest))))
       ;;end outer when
       )
     ;;end loop
     )
    (values qvars quests num-qvar-Qs num-qs)
    ;;let, find-qvars-for-scale
    ))
;;TEST
;; USE DATA IN SCALES BELOW
#|CL-USER 32 > (find-qvars-for-scale *all-pc-elements 'pce-people)
(MOTHER FATHER BEST-M-FRIEND BEST-F-FRIEND M-DISLIKE F-DISLIKE M-ADMIRE F-ADMIRE PER-MOSTFUN PER-ROMANCE ROLE-MODEL CHILD-FRIEND CHILD-DISLIKE WORK-FRIEND WORK-PER-DISLIKE FAV-BOSS WORST-BOSS FAV-M-STAR FAV-POLITICO FAV-TEACHER WORST-BOSS FAV-SPIRITUAL DIS-TEACHER)
(MOTHERQ FATHERQ BEST-M-FRIENDQ BEST-F-FRIENDQ M-DISLIKEQ F-DISLIKEQ M-ADMIREQ F-ADMIREQ PER-MOSTFUNQ PER-ROMANCEQ ROLE-MODELQ CHILD-FRIENDQ CHILD-DISLIKEQ WORK-FRIENDQ WORK-PER-DISLIKEQ FAV-BOSSQ WORST-BOSSQ FAV-M-STARQ FAV-POLITICOQ FAV-TEACHERQ WORST-BOSSQ FAV-SPIRITUALQ DIS-TEACHERQ)
((MOTHER 1 "mother" MOTHERQ) (FATHER 2 "father" FATHERQ) (BEST-M-FRIEND 3 "best-m-friend" BEST-M-FRIENDQ) (BEST-F-FRIEND 4 "best-f-friend" BEST-F-FRIENDQ) (M-DISLIKE 5 "m-dislike" M-DISLIKEQ) (F-DISLIKE 6 "f-dislike" F-DISLIKEQ) (M-ADMIRE 7 "m-admire" M-ADMIREQ) (F-ADMIRE 8 "f-admire" F-ADMIREQ) (PER-MOSTFUN 9 "per-mostfun" PER-MOSTFUNQ) (PER-ROMANCE 10 "per-romance" PER-ROMANCEQ) (ROLE-MODEL 11 "role-model" ROLE-MODELQ) (CHILD-FRIEND 12 "child-friend" CHILD-FRIENDQ) (CHILD-DISLIKE 13 "child-dislike" CHILD-DISLIKEQ) (WORK-FRIEND 14 "work-friend" WORK-FRIENDQ) (WORK-PER-DISLIKE 15 "work-per-dislike" WORK-PER-DISLIKEQ) (FAV-BOSS 16 "fav-boss" FAV-BOSSQ) (WORST-BOSS 17 "worst-boss" WORST-BOSSQ) (FAV-M-STAR 18 "fav-m-star" FAV-M-STARQ) (FAV-POLITICO 19 "fav-politico" FAV-POLITICOQ) (FAV-TEACHER 20 "fav-teacher" FAV-TEACHERQ) (WORST-BOSS 21 "worst-boss" WORST-BOSSQ) (FAV-SPIRITUAL 22 "fav-spiritual" FAV-SPIRITUALQ) (DIS-TEACHER 23 "dis-teacher" DIS-TEACHERQ))
23|#





;;============= SHAQ EXAMPLES ========================
;;EG FOR CATEGORY CLASSES
#|(my-defclass VALUES-THEMES (assessment per-system)
               ()           
               (:default-initargs
                :title "VALUES-THEMES"
                :scale-group-description "The 11 Value-Themes scales are the result of a factor and logical analysis of the original four scales Achievement-Status; Social-Family Related; Internal-Intrinsic; and Non-Dysfunctional Values-Themes. "
                ))|#
;;EG FOR SCALE CLASSES
#|(my-defclass siecontr  (beliefs HQ scale)
               ()
               (:default-initargs
                :name-string "siecontr"
                :label  "s-Int-Ext control beliefs"
                :scale-name "Internal vs External Control (I-E) Beliefs"
                :description "Degree of self-sufficiency and responsibility one takes for his/her own life, health, and happiness without undue influence from others. More internal direction, planning, and self-control versus influence by others or external forces. Internal control correlates .357 with overall happiness, .366 with low depression, .393 with low anxiety, .255 with low anger/aggression. 
      Believing that you are in control of your own emotions, behavior, likes and dislikes, and your life increases internal control. Making your own decisions and plans and giving adequate priority to your own needs also helps. (7 items)"
                :scale-group-name   "beliefs"
                :scale-questions '(iecselfs iecicont iecgenet iecpeopl iecdepen ieccofee ieccoprb)
                :mean-score "616"  :standard-deviation ".162" :sample-N 3246
                :num-questions  7  ;;is it really 7 or 8 SSS ???
                :help-priority 1
                :help-info "Learning how to increase your internal control can increase self-esteem and assertiveness, and it can lower anxiety and depression. Start with the help link."
                :help-links '("h6intern.htm")
                ))|#