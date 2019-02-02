;;************************ U-CS.lisp ***************************
;;
;;MODIFIED TO WORK WITH BOTH SHAQ AND CSQ
;;
;; WILL NEED TO MODIFY THESE IF ADD NEW QUEST NAMES OR MAKE
;;    OTHER CHANGES IN *SHAQ-question-variable-lists
;;INCLUDES ALL FUNCTIONS FROM FORMER U-CS-data-functions.lisp 


;;  UTILITIES ADDED TO ART UTILITIES 
;;  FOR DEFINING CS-NODES AND PATHS
;;  ETC
  

;;STACK SIZE & NUM STACKS
;;Must extend stack size to make large numbers of elmsyms & combos
(setf *default-stack-group-list-length* 12 ) ;;default is 10, num of stacks
(extend-current-stack 100 ) ;; = 63488 ;;100% extension to stack size,default = 31744; HAVE TO EXTEND FOR EACH STACK??
;;*sg-default-size*

(setf *stack-overflow-behaviour* :error) ;;default is :error
#| Var i ab l e *STACK-OVERFLOW-BEHAVIOUR*
Summary Controls behavior when stack overflow is detected.
Initial value :ERROR
Description The variable *stack-overflow-behaviour* controls behavior
when stack overflow is detected. When *stack-overflow-behaviour* is set to :error, LispWorks signals an error. 
When it is set to :WARN, LispWorks increases the stack size automatically to accommodate the overflow, but prints a warning message to signal that this has happened. MAY CAUSE LW TO CRASH--ME??
When it is set to NIL, LispWorks increases stack size silently. Notes Stack overflow is only detected when code was compiled with optimize qualities safety >= 1 or interruptible > 0|# 

(defparameter *cur-stack-size (current-stack-length))   ;;default = 31744

;;
;;MODIFIED TO WORK WITH BOTH SHAQ AND CSQ
;;
;; WILL NEED TO MODIFY THESE IF ADD NEW QUEST NAMES OR MAKE
;;    OTHER CHANGES IN *SHAQ-question-variable-lists


;;GET-CATEGORY-QVARS
;;
;;ddd
(defun get-category-qvars (category &key (all-category-lists  (eval *cur-qvar-lists)))
  ;;was *shaq-question-variable-lists
  "In U-CS (inSHAQ U-data-functions), RETURNS (values category-qvar-list = a list of all the qvar-lists for qvar category AND category)."
  (let 
      ((category-list)
       (category-qvar-list)
       )
    (multiple-value-setq (category-list return-qvar)
        (get-key-value-in-nested-lists (list (list category 0))
                                       all-category-lists :return-list-p t
                                       :no-return-extra-p t))
    (setf category-qvar-list (cdr category-list))   
    (values category-qvar-list category)
    ;;end let, get-category-qvars
    ))
;;TEST
;;  (get-category-qvars 'bio4job) = works
;;   (get-category-qvars 'stu-data) = works
#|(("stpared" "b-Highest parents educ level" "spss-match" ("stuParentsEduc" 1 STUPARENTSEDUCQ "int" STUPARENTSEDUC "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "StudentBasicData.java")) ("stuclass" "st-Class level" "spss-match" ("stuClassLevel" "3" STUCLASSLEVELQ "int" STUCLASSLEVEL "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "StudentBasicData.java")) ("studegre" "st-Educ objective level"... ETC. SOME DELETED|#
;;FOR CSQ
;; (get-category-qvars 'pce-people)
;; works= ((PCE-PEOPLE ("mother" "mother" "single-text" ("mother" "1" "motherQ" "pc-element" "Pc-Element")) ("father" "father" "single-text" ("father" "2" "fatherQ" "pc-element" "Pc-Element")) ("best-m-friend" "best-m-friend" "single-text" ("best-m-friend" "3" "best-m-friendQ" "pc-element" "pc-Element" GETNAME-P)) ("best-f-friend" "best-f-friend" "single-text" ("best-f-friend" "4" "best-f-friendQ" "pc-element" "pc-Element" GETNAME-P)) ("m-dislike" "m-dislike" "single-text" ("m-dislike" "5" "m-dislikeQ" "pc-element" "pc-Element" GETNAME-P))  etc.



;;GET-CATEGORY-QVAR-NAMES
;;
;;ddd
(defun get-category-qvar-names (category &key (all-category-lists  (eval *cur-qvar-lists))
                                         (return-syms-p T))
  ;;was *shaq-question-variable-lists
  "In U-CS (in SHAQ U-data-functions),  RETURNS (values category-qvar-names category-syms category) where  category-qvar-names = a list of all the qvar names for qvar category."
  (let 
      ((category-qvar-lists)
       (category-qvar-names)
       (sym)
       (category-syms)
       )
    (multiple-value-setq (category-qvar-lists)  
        (get-category-qvars category))
    (setf  category-qvar-names (get-nth-in-all-lists 0 category-qvar-lists))

    (when return-syms-p
      (loop
       for name in category-qvar-names
       do
       (setf  sym (my-make-symbol name)
              category-syms (append category-syms (list sym)))))
 
    (values category-qvar-names category-syms category)
    ;;end let, get-category-qvar-names
    ))
;;TEST
;;  (get-category-qvar-names 'pce-people)  
;;  works= ("mother" "father" "best-m-friend" "best-f-friend" "m-dislike" "f-dislike" "m-admire" "f-admire" "per-mostfun" "per-romance" "role-model" "child-friend" "child-dislike" "work-friend" "work-per-dislike" "fav-boss" "worst-boss" "fav-m-star" "fav-politico" "fav-teacher" "fav-spiritual" "dis-teacher")   (MOTHER FATHER BEST-M-FRIEND BEST-F-FRIEND M-DISLIKE F-DISLIKE M-ADMIRE F-ADMIRE PER-MOSTFUN PER-ROMANCE ROLE-MODEL CHILD-FRIEND CHILD-DISLIKE WORK-FRIEND WORK-PER-DISLIKE FAV-BOSS WORST-BOSS FAV-M-STAR FAV-POLITICO FAV-TEACHER FAV-SPIRITUAL DIS-TEACHER)   PCE-PEOPLE




;;GET-ALL-SHAQ-QVAR-CATEGORIES
;;
;;ddd
(defun get-all-shaq-qvar-categories (&key (all-category-lists (eval *cur-qvar-lists)))
      "In U-CS (inSHAQ U-data-functions), RETURNS all-categories-list."
      (let
          ((all-categories-list)
           )
        (loop
         for cat-list in all-category-lists
         with cat-sym
         do
         (setf cat-sym (car cat-list)
               all-categories-list (append all-categories-list (list cat-sym)))
         ;;end loop
         )
        all-categories-list
        ;;end get-all-shaq-qvar-categories
        ))
;;TEST
;;  (get-all-shaq-qvar-categories) = 
;;works, returns (ID UTYPE UGOALS BIO3EDUC BIO4JOB BI07LANG BIO1ETHN BIORELAF STUCOLLE STUMAJOR STUSPECI STURESID STU-DATA STGPATRE STUAPT STUFEEL STURESOURCE STUACMOTIV STU-LRN SM COPE THEMES TBV IE WORLDVIEW SELF-CONF ASSERTCR INTIMACY INDEP-INT ROM LIBROLE HAP RHEALTH RPEOPLE RDEP RANX RANG REMOT TB2 CARGEN CARBUS CARENGR CARFINE CARHELP CARLANG CARMED CARLAW CARNATSCI CARBESCI CARETHNIC CARWRITE)


;;GET-QVAR-LIST
;;
;;ddd
(defun get-qvar-list (qvar &key  (category T) not-nested-p
                           (all-qvar-lists  (eval *cur-qvar-lists)))
  "In U-CS (inSHAQ U-data-functions). RETURNS  (values qvar-list return-qvar). Used to create *shaq-all-question-categories-list, a global shaq variable."
  (let
      ((qvar-list)
       (return-qvar)
       (qvar-str)
       )
    (cond
     ((stringp qvar)
      (setf qvar-str qvar))
     (t (setf qvar-str (format nil "~A" qvar))))
     
    (cond
     ((null not-nested-p)
      (multiple-value-setq (qvar-list return-qvar)
          (get-key-value-in-nested-lists (list (list category 0)(list qvar-str 0)) all-qvar-lists :return-list-p t  :no-return-extra-p t)))
     (t (multiple-value-setq (qvar-list return-qvar)
            (get-key-value-in-nested-lists  `((,qvar-str 0)) all-qvar-lists :return-list-p t  :no-return-extra-p t))))
    ;;end get-qvar-list
    (values qvar-list return-qvar)
    ))
;;TEST
;;for pcsyms
;; (get-qvar-list 'q :not-nested-p t :all-qvar-lists *all-pcqvars) = ("Q" "q vs nq" NIL "Q" ("Q" "1" "quest-name" "int" "Priority12" NIL NIL NIL NIL))    "Q"
;;  (get-qvar-list 'mother) = ("mother" "mother" "single-text" ("mother" "1" "motherQ" "pc-element" "Pc-Element"))
;; (get-qvar-list 'green)
;;  (get-qvar-list "lrntxout" *cur-qvar-lists)
;;   (get-qvar-list "lrntxout" *SHAQ-question-variable-lists 'STU-LRN)
;; both work, return ("lrntxout" "la-Outline textbooks" "spss-match" "lrnTEXToutline" ("lrnTEXToutline" "2" "lrnTEXToutlineQ" "int" "FrAnswerPanel.LikeMe7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight" "bsLearningAreas.java"))
;;FOR MULTI-SELECTION ITEMS
;;  (get-qvar-list "BIO4JOB") = ("bio4job" "b-Primary occupation" "spss-match" ("bio4job") ("INSTRUCTIONS: Select ALL of the following best describe your primary OCCUPATION." "If you have multiple occupations, choose all of them.") NIL :MULTI-ITEM)
;; (get-key-value-in-nested-lists '(( "BIO4JOB" 0))  *SHAQ-question-variable-lists :return-list-p T) works, returns entire list of lists under BIO4JOB CATEGORY
;; (get-qvar-list 'k :not-nested-p T)




;;GET-ALL-CSQ-QVARNAMES
;;
;;2016  was named get-all-shaq-qvarnames
;;ddd
(defun get-all-CSQ-qvarnames ( &key return-var&qtext-p
                                    return-var&label-p (add-quote "")
                                    (all-qvar-lists (eval *cur-qvar-lists)))
  "In U-CS (inSHAQ U-data-functions). RETURNS (values all-qvars-list all-categories-list  problems-list). If return-var&label-p, then returns a list of qvar label strings for each. If add-quote, puts whatever add-quote is set to on both ends of the label (for spss add single quote). [was get-all-shaq-qvarnames.] If RETURN-VAR&QTEXT-P, returns lists of qvar qtext strings for all qvars."
  (let
      ((all-qvars-list)
       (all-categories-list)
       (problems-list)
       (qtext)
       (qvar)
       )
    (loop
     for catlist in all-qvar-lists
     with catname = nil
     do
     (cond
      ((listp catlist)
       (setf catname (car catlist))
       (loop 
        for qvarlist in (cdr catlist)
        do
        (setf qvar nil)
        (cond
         ((null return-var&label-p)
          (cond
           ((listp qvarlist)
            (setf qvar (car qvarlist))
            (cond
             (return-var&qtext-p
              (setf qtext (nth-value 1 (get-question-text qvar)))
              (when (listp qtext)
                (setf qtext (car qtext)))
              (setf all-qvars-list (append all-qvars-list (list (list qvar qtext))))
              )
             (t (setf qvar (car qvarlist)                
                      all-qvars-list (append all-qvars-list (list qvar)))))
            ;;end listp
            )
           (t (setf problems-list (append problems-list (list qvarlist)))))
          )
         ;;if return-var&label-p
         (t
          (cond
           ((listp qvarlist)
            (setf qvar (car qvarlist)     
                  label (second qvarlist)
                  all-qvars-list (append all-qvars-list (list (list qvar label)))))
           ;;was(format nil "~A  ~A~A~A" qvar add-quote label add-quote))))))
           (t (setf problems-list (append problems-list (list qvarlist)))))))       
        ;;end inner loop, clause
        ))
      (t (setf problems-list (append problems-list (list qvarlist)))))
     ;;end outer loop
     )
    (values all-qvars-list all-categories-list  problems-list)
    ;;end let, get-all-CSQ-qvars
    ))
;;TEST
;; (get-all-CSQ-qvarnames)
;; (setf *all-CSQ-qvarnames-list (get-all-CSQ-qvarnames))
;; ;; (setf *num-qvars (list-length *all-CSQ-qvarnames-list)) = 58
;;  get-all-CSQ-qvars
;;  (setf *all-shaq-qvar&labels (get-all-CSQ-qvarnames :return-var&label-p T :add-quote "\'"))
;;  (get-all-CSQ-qvarnames :return-var&qtext-p T)


;;MY-GET-DATE-TIME
;;
;;ddd
(defun my-get-date-time (&key (date-separator "."))
  "In U-CS (inSHAQ U-data-functions), RETURNS (values date-string  date time year month day hour min sec )"
  (let
      ((date-string)
       (time)
       (date)
       )
    (multiple-value-bind (sec min hour day month year)
        (decode-universal-time (get-universal-time))
    (setf time (format nil "~a:~a" hour min)
          date (format nil "~a~a~a~a~a" month date-separator day date-separator year))
    (setf date-string (format nil "Date: ~A  Time: ~A" date time))
    (values date-string  date time year month day hour min sec )
    ;;end mvb, let, my-get-date-time
    )))
;;TEST
;; (my-get-date-time)
;; works= "Date: 10.29.2014  Time: 11:15"  "10.29.2014"  "11:15"  2014  10  29  11  15  7
;; (format nil "~S" "




 
;;GET-QUEST-VAR-VALUES
;;
;;ddd
(defun get-quest-var-values (qvar &key qvar-list  return-values-p  (category T) label spss-match java-var qnum q-name data-type answer-panel array frame-title fr-width fr-height java-file help-info help-links (all-qvar-lists *cur-qvar-lists ) 
                                  qvarlist-not-nested-p) 
  "In U-CS (inSHAQ U-data-functions)  qvar is the NEW-spss variable sym or string. IF return-values-p,  RETURNS (values   label  spss-match  java-var  qnum  q-name  data-type  answer-panel  array  frame-title   fr-width  fr-height  java-file help-info  help-links) =  a list of key-value pairs with keys=  label spss-match java-var qnum q-name data-type answer-panel array frame-title fr-width fr-height java-file qvar).  For a key = T, returns the first T value (values return-var-value return-var  return-keylist qvar help-info help-links). Category is the category of the qvar.  If qvar-list supplied, then uses it INSTEAD of search long list for qvar--saves time.  [If NULL return-values-p, RETURNS EG.  returns= \"acmFinancialQ\"  Q-NAME  (:LABEL \"am-Confidence school finances\" :SPSS-MATCH \"spss-match\" :JAVA-VAR \"acmFinancial\" :QNUM \"19\" :Q-NAME \"acmFinancialQ\" :DATA-TYPE \"int\" :ANSWER-PANEL \"FrAnswerPanel.Confidence7\" :ARRAY \"questionInstancesArray\" :FRAME-TITLE \"frameTitle\" :FR-WIDTH \"frameDimWidth\" :FR-HEIGHT \"frameDimHeight\" :JAVA-FILE \"iAcademicMotivation.java\")   ACMFINAN"
  (let
      ((return-var-value)  
       (sublist)
       (arg-keylist-vals (list  label spss-match java-var qnum q-name data-type answer-panel array frame-title fr-width fr-height java-file))
       (return-var)
       (key)
       (val)
       (return-qvar)
       (return-keylist)
       (help-info-links-list)
       (help-info)
       (help-links)
       (var1)
       (n2)
       )
    ;;test to see if all-qvar-lists are nested
    (when (not (listp (second (car all-qvar-lists))))
      (setf qvarlist-not-nested-p T))

    ;;(afout 'out (format nil "arg-keylist-vals= ~A~%" arg-keylist-vals))

    ;;see if use return-var (set to T?) before change their values below
    (loop
     for n from 0 to 11  
     do
     (setf key (nth n '(label spss-match java-var qnum q-name  data-type answer-panel array frame-title fr-width fr-height java-file))
           val (nth n arg-keylist-vals))
     (cond
      (val
       (setf  return-var key)
       (return))
      (t nil))
     ;;end loop
     )
    ;;get the list of values
    (cond
     ;;if the qvar-list is supplied, saves a search
     (qvar-list nil)
     (t (multiple-value-setq (qvar-list return-qvar)
            (get-qvar-list qvar :category category :all-qvar-lists all-qvar-lists
                           :not-nested-p qvarlist-not-nested-p))))
    ;;(get-qvar-list 'mild  :category T :all-qvar-lists *all-pcqvars) = ("MILD" "4" "int" "Priority12" NIL NIL NIL NIL) "MILD"
    ;; For pcqvars (get-qvar-list 'q :not-nested-p t :all-qvar-lists *all-pcqvars) = ("Q" "q vs nq" NIL "Q" ("Q" "1" "quest-name" "int" "Priority12" NIL NIL NIL NIL))   "Q"

    ;;set the values
    (setf  label (second qvar-list)
           spss-match (third qvar-list)
           java-var (fourth qvar-list)
           help-info-links-list (sixth qvar-list))
    (if (listp (setf sublist (fifth qvar-list)))
        (setf qnum (second sublist) 
              q-name (third sublist) 
              data-type (fourth sublist) 
              answer-panel (fifth sublist)
              array (sixth sublist)
              frame-title  (seventh sublist)
              fr-width (eighth sublist)
              fr-height  (ninth sublist)
              java-file  (tenth sublist )))

    ;;for help-info-link-list
    (setf  help-info (second help-info-links-list)
           help-links (third help-info-links-list))

    ;;make the return-keylist
    (setf return-keylist (list  :label label :spss-match spss-match :java-var java-var :qnum qnum :q-name q-name :data-type data-type :answer-panel answer-panel :array array :frame-title frame-title :fr-width  fr-width :fr-height fr-height :java-file java-file :help-info help-info :help-links help-links))
    ;;(BREAK "inside get-quest-var-values")
    ;;(afout 'out (format nil "q-name= ~A  return-var= ~A~% " q-name return-var))  
    #|  DOESN'T WORK BUT SHOULD -- (eval return-var) = unbound var
   ;;get the return-var-value  set above
    (if return-var
        (setf return-var-value (eval return-var)))|#
    ;;SSS TEMP SOLUTION
    (loop
     for n from 0 to 12  
     do
     (setf n2 (+ (* n 2) 1)
           var1 (nth n '(label spss-match java-var qnum q-name  data-type answer-panel array frame-title fr-width fr-height java-file help-info-link-list)))
     (cond
      ((equal key var1)
       (setf return-var-value (nth n2 return-keylist)
             return-var key)
       (return))
      (t nil))                 
     ;;end loop
     )

    ;;what to return?
    (cond
     (return-values-p 
      (values   label  spss-match  java-var  qnum  q-name  data-type  answer-panel  array  frame-title   fr-width  fr-height  java-file help-info  help-links))
     ( return-var 
       (values return-var-value   return-var  return-keylist qvar))
     (t (values return-keylist qvar)))
    ;;(BREAK "In get-quest-var-values")

    ;;end let, get-quest-var-values
    ))

;;TEST 
;; (get-quest-var-values 'MILD :return-values-p T  :all-qvar-lists *all-pcqvars )
;;  :not-nested-p T)
;; (get-quest-var-values 'hot)  
;; (get-quest-var-values 'acmfinan) 
;;modified version incl help
#|"iAcademicMotivation.java"
JAVA-FILE
(:LABEL "am-Confidence school finances" :SPSS-MATCH "spss-match" :JAVA-VAR "acmFinancial" :QNUM "19" :Q-NAME "acmFinancialQ" :DATA-TYPE "int" :ANSWER-PANEL "Confidence7" :ARRAY "questionInstancesArray" :FRAME-TITLE "frameTitle" :FR-WIDTH "frameDimWidth" :FR-HEIGHT "frameDimHeight" :JAVA-FILE "iAcademicMotivation.java" :HELP-INFO NA :HELP-LINKS NA)
ACMFINAN|#

   ;; label spss-match java-var qnum q-name data-type answer-panel array frame-title fr-width fr-height java-file)
;;works, returns= (:LABEL "am-Confidence school finances" :SPSS-MATCH "spss-match" :JAVA-VAR "acmFinancial" :QNUM "19" :Q-NAME "acmFinancialQ" :DATA-TYPE "int" :ANSWER-PANEL "FrAnswerPanel.Confidence7" :ARRAY "questionInstancesArray" :FRAME-TITLE "frameTitle" :FR-WIDTH "frameDimWidth" :FR-HEIGHT "frameDimHeight" :JAVA-FILE "iAcademicMotivation.java")       ACMFINAN
;;   (get-quest-var-values 'acmfinan :q-name t) 
;; works, returns= "acmFinancialQ"  Q-NAME  (:LABEL "am-Confidence school finances" :SPSS-MATCH "spss-match" :JAVA-VAR "acmFinancial" :QNUM "19" :Q-NAME "acmFinancialQ" :DATA-TYPE "int" :ANSWER-PANEL "FrAnswerPanel.Confidence7" :ARRAY "questionInstancesArray" :FRAME-TITLE "frameTitle" :FR-WIDTH "frameDimWidth" :FR-HEIGHT "frameDimHeight" :JAVA-FILE "iAcademicMotivation.java")   ACMFINAN
;;(setf  xx 1 yy 2 zz 3)
;; (sort (list zz xx yy) '<) = (1 2 3)
 ;;

;;GET-MULTI-SELECTION-QUEST-VAR-VALUES
;;
;;ddd
(defun get-multi-selection-quest-var-values (qvar-category &key qvar-list) ;;
   ;;should work, but gets error &key (qvar-master-list *SHAQ-question-variable-lists))
  "In U-CS (inSHAQ U-data-functions)  RETURNS PLIST ( :qvar-category :primary-qvar-sym  :primary-qvar-label :primary-title-text :primary-instr-text :quest-text-list :q-spss-name :ans-name-list (SPSS VAR NAME each item) :ans-text-list :num-answers  :primary-title-text :primary-instr-text :quest-text-list  :qnum  :data-type :ans-data-list  :primary-java-var :primary-spss-match :spss-match-list :java-var-list :ans-xdata-lists).  If qvar-list is supplied, saves the search for the qvar category list."
  ;;qvar-category  is the overall sym not used  (eg BIO4JOB)
  (let*
      ((multi-items-list 
        (if qvar-list  qvar-list ;;if provided in key
          ;;otherwise, find the qvar-list
          (eval `(get-key-value-in-nested-lists (quote (( ,qvar-category 0))) (eval *cur-qvar-lists) :return-list-p t))))
 ;;test (get-key-value-in-nested-lists (quote (( ugoals 0))) *cur-qvar-lists :return-list-p t)
;; (find-qvar-selection-type 'ugoals)

       (length-multi-list (list-length multi-items-list))
       (primary-qvar-list) ;;later (car multi-items-list))
       (primary-qvar-sym)  ;; later(car primary-qvar-list))
       (primary-qvar-label)
       (primary-spss-match)
       (primary-java-var)
       (primary-qvar-sublist)
         ;indiv item spss names
       (q-spss-name) ;;for whole category (eg. occupation)
       (ans-name-list)  ;;spss var name for each item (eg. sales, teacher, etc)
       (ans-text-list) ;;actual text of answer items
       (num-answers (- length-multi-list 2)) ;;don't count category name + primary list
       ;;question text title, instrs, overall question

       ;;THESE MAY BE MODIFIED BELOW
       (primary-title-text *default-multi-choice-title)
       (primary-instr-text *default-multi-choice-instr)
       (primary-help-info "")
       (primary-help-links)
       (quest-text-list) ;;PUT IN AS INSTR TEXT
       (qnum 0)
       ;;data info -- generally each item scored 0 or 1(checked)
       (data-type)       ;;usually integer
       (ans-data-list)   ;;list of  1's (1 1 1 ... 1)        
       ;;following rarely used with multi-selection
       (array)
       (frame-title)
       (java-var-list)
       (spss-match-list)
       (fr-width)
       (fr-height)
       (java-file)
       (ans-xdata-lists)
       (qvar)
        (label)
        (spss-match)
        (java-var)
        (sublist)
        (special-title)
        (special-instr)
        (ans-xdata-list)
        ;;added
        (ans-text-sublist)
        (return-multi-selection-keylist)
        (q-instr-sym)
        (answer)


      ;;for helplinks
      (primary-help-list)
      (special-quest-list)
;;yyyy
        )
  
   ;;FOR EACH LIST IN MULTI-SELECT LIST GROUP
   (loop
    for qvar-list in multi-items-list
    for i from 0 to (-  length-multi-list 1)
#|    with qvar
    with label
    with spss-match
    with java-var
    with sublist
    with special-title
    with special-instr
    with ans-xdata-list|#
    do
    ;;set the values
 
    ;;from the primary-qvar get more data for the title, instrs, question
    ;; most ARE NOT SCORED EXCEPT 1 (checked) or 0 (not)  
    (cond
     ((= i 1) 
      (setf  primary-qvar-sym (first qvar-list)
             ;; qvar-syms-list (append qvar-syms-list (list qvar))
             primary-qvar-label (second qvar-list)
             primary-spss-match (third qvar-list)
             primary-java-var (fourth qvar-list) ;;actually usually a list
             primary-qvar-sublist (fifth qvar-list)
             primary-help-list (sixth qvar-list))
      ;;for helplinks
      (if (equal (car primary-help-list) :help)
          (setf primary-help-info (second primary-help-list)
                primary-help-links (third primary-help-list)))
      ;;check for special title and instructions for each category/multi question
      (cond
       ((listp primary-qvar-sublist)
        (setf special-title (getf primary-qvar-sublist :title)
              special-quest-list (getf primary-qvar-sublist :quest))
        (if special-title (setf primary-title-text  (car special-title))
          ;;may cause weird error if nil instead of  a string? After checking, probably not.
          (setf primary-title-text " "))
      ;;NO USED AS QUEST  (if special-instr (setf primary-instr-text  special-instr))
        (setf  QUEST-TEXT-LIST special-quest-list) ;; primary-qvar-sublist)
        ;;(afout 'out (format nil "2 QUEST-TEXT-LIST ~A~%"QUEST-TEXT-LIST))
        )
       (t nil))      
  ;;OLD FORM THAT MAY STILL BE USED??
     ;;(afout 'out (format nil "primary-qvar-sublist= ~A~%"primary-qvar-sublist))
      (cond
#|       ((and (listp primary-qvar-sublist)
             (<  (list-length primary-qvar-sublist) 5))
        (setf  QUEST-TEXT-LIST primary-instr-text) ;; primary-qvar-sublist)
        ;;(afout 'out (format nil "2 QUEST-TEXT-LIST ~A~%"QUEST-TEXT-LIST))
        )   |#     
       ((and (listp primary-qvar-sublist)
             (> (list-length primary-qvar-sublist) 4))
        (if (numberp (second sublist))
            (setf qnum (second sublist)))
        (setf q-name (third sublist) 
              data-type (fourth sublist) 
              answer-panel (fifth sublist)
              array (sixth sublist)
              frame-title  (seventh sublist)
              fr-width (eighth sublist)
              fr-height  (ninth sublist)
              java-file  (tenth sublist ))
        )
       (t   nil     ))
     ;;end (= i 1) clause
      )
     ;;FOR REST OF QVAR ITEMS IN THE MULT-LIST
     ((> i 1) 
      ;;get answer text and other info here
      (cond
       ((listp qvar-list)
        (setf  qvar (first qvar-list)
               ans-name-list (append ans-name-list (list qvar))
               label (second qvar-list)
               spss-match (third qvar-list)
               ;;later comment off these below??
               spss-match-list (append spss-match-list (list spss-match))
               java-var (fourth qvar-list)
               java-var-list (append java-var-list (list java-var))
               ans-text-sublist (fifth qvar-list)
              ans-xdata-list (car (last qvar-list)))
        (unless  (and (listp ans-xdata-list)(equal (car ans-xdata-list) :xdata))
          (setf ans-xdata-list nil))
        (setf ans-xdata-lists (append ans-xdata-lists (list ans-xdata-list)))
             
        (if (stringp (car ans-text-sublist))
            (setf ans-text-list (append ans-text-list  ans-text-sublist))
          ;;else
          (setf  ans-text-list (append ans-text-list (list label))))             
             
        ;;(afout 'out (format nil "label= ~A ans-text-list= ~A~%"   label ans-text-list))
        )
       (t nil))
      ;;end (> i 1),cond
      )
     (t nil))
     ;;end loop
     )
   ;;MAKE QNUM AND ANS-DATA-LIST
     ;;SSS  DEFPARAMETER THIS VARIABLE
     (unless (and (numberp qnum) (> qnum 0))
       (setf qnum (incf *current-multi-selection-qnum)))
     (unless ans-data-list
       (setf data-type 'integer
             ans-data-list (make-sequence 'list (-  length-multi-list 2) :initial-element 1))) ;;don't count cat-sym and primary-var

         ;;MAKE THE RETURN-KEYLIST
         (setf return-multi-selection-keylist
               (list :qvar-category qvar-category
                 :primary-qvar-sym  primary-qvar-sym  ;; later(car primary-qvar-list))
                 :primary-qvar-label  primary-qvar-label
                 ;;question text title, instrs, overall question
                 :primary-title-text primary-title-text
                 :primary-instr-text primary-instr-text
                 :qnum  qnum
                 :quest-text-list quest-text-list
                ;;;indiv item spss names
                 :q-spss-name  q-spss-name ;;for whole category (eg. occupation)
                 :ans-name-list  ans-name-list  ;;SPSS VAR NAME each item 
                 :ans-text-list ans-text-list  ;;actual text of answer items
                 :num-answers  num-answers
                 ;;question text title, instrs, overall question
                 ;;data info -- generally each item scored 0 or 1(checked)
                 :data-type   data-type      ;;usually integer
                 :ans-data-list   ans-data-list  ;;list of  1's (1 1 1 ... 1)       
                 :primary-java-var  primary-java-var 
                 :primary-spss-match  primary-spss-match
                 :spss-match-list spss-match-list
                 :java-var-list java-var-list
                 :ans-xdata-lists ans-xdata-lists
                 :help-info primary-help-info
                 :help-links primary-help-links
                 ))

     ;;end let, defun get-multi-selection-quest-var-values
     ))
(defparameter @SSS-TEST nil)
;;TEST
;;  (get-multi-selection-quest-var-values 'bio4job)
;; works, result= (:QVAR-CATEGORY BIO4JOB :PRIMARY-QVAR-SYM "bio4job" :PRIMARY-QVAR-LABEL "b-Primary occupation" :PRIMARY-TITLE-TEXT "MULTIPLE-SELECTION QUESTION" :PRIMARY-INSTR-TEXT "Select ALL that apply to you" :QNUM 10 :QUEST-TEXT-LIST ("INSTRUCTIONS: Select ALL of the following best describe your primary OCCUPATION." "If you have multiple occupations, choose all of them.") :Q-SPSS-NAME NIL :ANS-NAME-LIST ("student" "manager" "propeop" "protech" "consulta" "educator" "sales" "technici" "clerical" "service" "ownbus10" "othrsfem") :ANS-TEXT-LIST ("1-Student" "2-Manager" "3-People professional" "4-Technical professional" "5-Consultant" "6-Educator" "7-Sales" "8-Other technical" "9-Clerical" "10-Service" "11-Own business" "12-othrsfem") :NUM-ANSWERS 13 :DATA-TYPE INTEGER :ANS-DATA-LIST (1 1 1 1 1 1 1 1 1 1 1 1) :PRIMARY-JAVA-VAR ("bio4job") :PRIMARY-SPSS-MATCH "spss-match" :SPSS-MATCH-LIST ("spss-match" "spss-match" "spss-match" "spss-match" NIL "spss-match" "spss-match" "spss-match" "spss-match" "spss-match" "spss-match" "spss-match") :JAVA-VAR-LIST (("Student") ("Manager/executive") NIL ("Technician") ("Consultant") ("Educator") ("Sales") ("Technician") ("Clerical") ("Service") ("Own business +10 employees") (("Other self-employed"))))
;; 
;; (get-key-value-in-nested-lists '(( "BIO4JOB" 0))  *SHAQ-question-variable-lists :return-list-p T) works, returns entire list of lists under BIO4JOB CATEGORY
;; (defun testx (a &key (b 7))   b) ;; (testx 9) = 7
;;
;;  (get-multi-selection-quest-var-values 'scalessel)



   
;;GET-QUESTION-TEXT
;;
;;ddd
(defun get-question-text (qvar &optional (category T) 
                               &key (all-questions-list *cur-all-questions)
                               (eval-text-input-box-sym-p T))
  "In U-CS (inSHAQ U-data-functions),quest-name = qvar  given quest-symbol RETURNS (values q-text-sym q-text-list q-title q-instr) LIST of question text from nested list--arg string or symbol, will also search for question sym w/o Q if gets nil. 
  NOTE: q-instr can be a list (incl (FORMAT nil ... within) a string or a list with one or more symbols that should be evaluated to a STRING. "
  (let*
      ((q-text-name (format nil "~AQ" qvar))
       (q-text-sym (my-make-symbol q-text-name))
       (q-var-list   (get-set-append-delete-keyvalue-in-nested-list :get  
                              (list  (list q-text-sym  0  1))  
                              (cond ((listp all-questions-list) all-questions-list)
                                    (t (eval  all-questions-list)))
                              :return-nested-list-p NIL))
;; (get-set-append-delete-keyvalue-in-nested-list :get (list (list T 0) (list 'motherq  0 :R))  (eval  *cur-all-questions)) = not work
;; (get-set-append-delete-keyvalue-in-nested-list :get (list (list 'motherq  0  1))  (eval  *cur-all-questions) :return-nested-list-p NIL)
        #|(get-keyvalue-in-nested-list  (list (list category 0 ) 
                                            (list q-text-sym 0 :R))
                                    (eval  *cur-all-questions)  :return-list-p T)|#        
        #|was (get-key-value-in-nested-lists  (list (list category 0) (list q-text-sym 0))
                  (eval  *cur-all-questions)  :return-list-p T)|#  ;;was *all-shaq-questions
       (q-instr-list)
       (q-title)
       (q-instr)
       (q-instr-list)
       (n-instrs)
       (q-instr-sym)
       (q-text-list) 
       (text-input-box-text)
       (proc-q-instr-list)
       (proc-q-text-list)
       (q-instr-out)
       (q-text-out)
       )
    #|    (if
        (null q-var-list)
        (setf new-q-name (my-make-symbol (format nil "~AQ" quest-sym))
              q-var-list  (get-key-value-in-nested-lists 
                           (list (list category 0) (list new-q-name 0))
                           *all-shaq-questions :return-list-p T)))|#
    (cond
     ((and q-var-list (listp q-var-list))
      (setf q-text-list (second q-var-list)
            q-instr-sym (third q-var-list)
            n-text-list (list-length q-text-list))
      ;;was             text-input-box-text (eval (fourth q-var-list))) 
      ;;works with actual list or symbol for a list of  instructions
      (cond
       ((listp (setf text-input-box-text (fourth q-var-list)))
        (setf  text-input-box-text (car text-input-box-text )))
       ((boundp text-input-box-text)
        (setf  text-input-box-text  (car (eval text-input-box-text))))
       (t nil))

      (setf q-instr-list (get-keyvalue-in-nested-list
                          (list  (list q-instr-sym 0 1) ) 
                          (eval *cur-all-questions))) ;;was :return-list-p T))


       ;;(break "here")
;;eg(CS-LINKTYPE-INSTR ("LINKS TO OTHER NODES" (format nil  "Associations with the word, class, concept, or instance \"~A.\" " *cs-explore-phrase)) )
        ;;FOR q-instr-list
        (setf proc-q-instr-list (process-text-list q-instr-list))
        ;;SET TO INSTR SYMA
        (cond
         ((not (listp proc-q-instr-list))
          (setf q-instr-out proc-q-instr-list))
         ((> (list-length proc-q-instr-list) 1)
          (setf q-title (first proc-q-instr-list)
                q-instr-out (second proc-q-instr-list)))
         (t (setf  q-instr-out (car proc-q-instr-list))))
        ;(break)
        ;;FOR q-text-list
        (setf proc-q-text-list (process-text-list q-text-list))
        ;;SET TO TEXT-SYM
        (cond
         ((not (listp proc-q-text-list))
          (setf q-text-out proc-q-text-list))
         ((> (list-length proc-q-text-list) 1)
          (setf q-text-out (string-append* proc-q-text-list)))
         (t (setf  q-text-out (car proc-q-text-list))))
           ;;(break "new")

      ;;ADDED FOR CSQ (from SHAQ) 
      ;;following may no longer be needed bec of new process-text-list function
      (when (symbolp q-title)
        (setf q-title (eval q-title)))
      (when (and (symbolp q-instr) (null q-instr-out))
        (setf q-instr-out (eval q-instr)))
      (when (and eval-text-input-box-sym-p 
                 (symbolp text-input-box-text))
        (setf text-input-box-text (eval text-input-box-text)))
      ;;end listp q-var-list
      )
     (t (setf q-text-list '("NO QUESTION TEXT FOUND"))))
     ;;(break "end")
     (when (not (listp q-text-out))
       (setf q-text-out (list q-text-out)))
    (values q-text-sym q-text-out q-title q-instr-out text-input-box-text)  
    ;;end get-question-text
    ))
;;test
;;  (get-question-text  "mother")
;;works= MOTHERQ     ("Your Mother [or person most like a mother to you]")       "People Important To You"        "Write the (first + last name initial) NAME of a person that fits the description well. DO NOT use the same person twice!"    "Type answer in BOX below:"
;; (get-question-text    "thm1achq")
;;works, = (" Being the best at whatever I do (example: making top grades). Achieving more than most other people.")  "INSTRUCTIONS FOR Life Themes, Dreams, and Values:"  "Answer each question according to how important that theme is to you."   
;; (get-question-text "DEFINITION")
;; (get-question-text  'SLFCOPE)
;;  (list (list 3 0) (list (my-make-symbol "this") 0))
;; (my-make-symbol "thisone")
;; (get-question-text  'COPEMOTA T :all-questions-list *all-shaq-questions :eval-text-input-box-sym-p nil)
;; works= COPEMOTAQ    ("Outwardly express anger by losing your temper, crying, damaging something, or getting even.")    NIL    NIL   COPEMOTAGGRESSQ  
;; (get-question-text "stuextmo")

;; (get-set-append-delete-keyvalue-in-nested-list :get  (list (list 'pce-people 0 )  (list 'mother  0 :R))      (eval  *cur-all-questions)) 
;;  (get-keyvalue-in-nested-list (list (list T 0 )(list 'PCE-PEOPLE-INSTR 0 :R) ) (eval *cur-all-questions))  ("People Important To You" *INSTR-NAME-ELEMENT)  (PCE-PEOPLE-INSTR ("People Important To You" *INSTR-NAME-ELEMENT))   (PCE-PEOPLE-INSTR ("People Important To You" *INSTR-NAME-ELEMENT))   ("return-orig-nested-list-p=NIL") T




;;GET-QUESTION-TEXT-FORMATED
;;
;;ddd
(defun get-question-text-formated (qvar &key add-instrs-p)
  "In U-data-functions RETURNS (values formated-qtext q-text-sym q-title q-instr) formated text from question-text list in the definition of the question in Q-questions.lisp"
  (let
      ((formated-qtext)
       )
    (multiple-value-bind (q-text-sym q-text-list q-title q-instr)
        (get-question-text qvar)
      (setf formated-qtext (print-list q-text-list :no-newline-p t))

      ;;add the question instructions?
      (when add-instrs-p 
        (setf formated-qtext (format nil  "~A~%   INSTRUCTIONS: ~A" formated-qtext q-instr )))
      (values formated-qtext q-text-sym q-title q-instr)
      )))
;;TEST
;; (get-question-text-formated 'SLFCOPE)
;; (get-question-text-formated 'SLFCOPE :add-instrs-p T )
;; (get-question-text-formated 'mother)
        




;;MAKE-QVARSYMS-LIST
;;
;;2016
;;ddd
(defun make-qvarsyms-list (&key (cur-all-qvars-list *cur-qvar-lists))
  "In U-CS-data-functions, makes a list of ALREADY EXISTING (ONLY) qvarsyms from current-qvar-list. Note: if not default list must use QUOTE."
  (let 
      ((qvarsyms)
       (qvar-names (get-all-csq-qvarnames
                    :all-qvar-lists (eval cur-all-qvars-list)))
       (list-length)
       (qvar)
       )
    (loop
     for qname in qvar-names
     do
     (setf qvar (my-make-symbol qname))

     (multiple-value-bind (result list)
         (symbol-listp qvar  :min-length 3)
       ;;(symbol-listp 'fav-spiritual  :min-length 3)
       (when result
         (setf qvarsyms (append qvarsyms (list qvar))))

     ;;end mvb,loop
     ))
    qvarsyms
    ;;end let, make-qvarsyms-list
    ))
;;TEST
;;  (make-qvarsyms-list)
;; works = (MOTHER FATHER BEST-M-FRIEND BEST-F-FRIEND M-DISLIKE F-DISLIKE M-ADMIRE F-ADMIRE PER-MOSTFUN PER-ROMANCE ROLE-MODEL CHILD-FRIEND TEACHER POLICEMAN SALESPERSON DOCTOR LAWYER BUSINESS-OWNER MANAGER SCIENTIST FARMER DRUG-DEALER POLITICIAN DANCER ARTIST COMEDIAN ENGINEER HOUSE-CLEANER MOVIE-STAR ROCK-STAR CHURCH-MINISTER CATHOLICS PROTESTANTS JEWS MUSLIMS BUDDHISTS ATHEISTS YOUR-PERSONALITY YOUR-POSSESSIONS)
;; (make-qvarsyms-list :cur-all-qvars-list '*all-PC-element-qvars)


       
       
    
    



















;;XXX -------------------------------- OLDER -- LATER DELETE?? ----------------
;;
#|  OLDER NOT-WORKING WITH CURRENT SCHEME 
(defun get-multi-question-vars-text (quest-sym)
  "In U-CS (inSHAQ U-data-functions), "
  (let*
      ((q-text-name (format nil "~AQ" quest-name))
       (q-text-sym (my-make-symbol q-text-name))
       (q-multi-var-list 
        (get-key-value-in-nested-lists  (list (list quest-name 0)) 
                                        *all-shaq-questions :return-list-p T))
       (length-q-multi-list (list-length q-multi-var-list))
       (q-instr-list)
       (q-title)
       (q-instr)
       (q-instr-list)
       (q-item-text-list)
       (n -1)
       )
    #|    (if
        (null q-var-list)
        (setf new-q-name (my-make-symbol (format nil "~AQ" quest-sym))
              q-var-list  (get-key-value-in-nested-lists 
                           (list (list category 0) (list new-q-name 0))
                           *all-shaq-questions :return-list-p T)))|#
    (loop
     for q-item-var-list in q-multi-var-list
     do
     (incf n)
     
     (cond
      ((= n 1)
       (setf quest-name (car q-item-var-list)
             quest-label (second q-item-var-list)
             quest-instr-list (fifth q-item-var-list)
             quest-title (first quest-instr-list)
             quest-instr (second  quest-instr-list)
             quest-type (sixth quest-instr-list))
       (cond
        ((listp q-instr-list)
         (setf q-title (first (second  q-instr-list))
               q-instr (second  (second  q-instr-list))
            quest-text (third q-instr-list)))
        ;;unless the q-instr text is specified, use default
        (t (setf quest-title "INSTRUCTIONS: Select ALL that apply to you."
           quest-instr ("Finish this SSS"))))
       ;;end n = 1
       )
      ((listp q-item-var-list)
       (setf q-item-str (first q-item-var-list)
             q-item-sym (my-make-symbol q-item-str)
             q-item-label (second q-item-var-list)
             q-text-list (fourth q-var-list))

       ;;appending the list to pass to the check-button-panel for items text
       (setf q-item-text-list (append q-item-text-list (list (car q-text-list))))
       )
       (t (setf q-text-list '("NO MULTI-QUESTION INFORMATION FOUND"))))

     #|      (setf q-instr-list (get-key-value-in-nested-lists 
                          (list (list category 0) (list q-instr-sym 0))
                          *all-shaq-questions :return-list-p T))|#

     ;;end loop      
     )
      

      (values q-text-sym q-text-list q-title q-instr)  
      ;;end get-question-text
      ))|#





;;xxx      ------------------   TEST DATA -------------------------
;;example date:
#|(setf  *test-quests1 
  '((STRING-VARS
     "RealPeopleSex.java"
     (RPESATISFIEDRELQ "Overall, I am extremely satisfied with my relationship with my partner.")
     (RPEFU "My partner and I have have fun together:")
     (RPEARGUEQ "My partner and I have arguments for at least several minutes:")
     )
    (STRING-VARS
     "RealPeople.java"
     (RPECOMMITQ "Degree of commitment to an intimate(romantic) relationship (lasting at least 3 months)")
     (RPEHAPFRIENDSQ "Almost all of my good friends are very successful and happy in almost every area of their lives including school and interpersonal relationships.")
     (RPEHMARRQ "I have (or have had) a very happy marital -- or marital-like relationship with someone for an extended period of time.")
     (RPENETWQ "I have developed an extensive, close network of friends and career-related persons with whom I share support and information.")
     (RPECLFR "In my life I have had a number of extremely close friends with whom I could discuss my innermost secrets, weaknesses, and problems.")
     (RPECLFAMQ "I feel extremely close with the members of the family I grew up in.")
     (RPENUMFRIENDSQ "Approximate number of friends in general with whom you interact socially -- outside of work or school settings--at least once a month.")
     (RPENUMCLOSEFRIENDSQ "Approximate number of EXTREMELY CLOSE friendships with which you are VERY SATISFIED."))))
|#


;;xxx ---------------------- CONVERSION FUNCTION (No longer needed?) ----------

#|  WORKS,  QUOTED OFF BECAUSE DON'T NEED IT ANYMORE??
;;CONVERT-JAVA-TO-SPSS-QUEST-NAMES
;;
;;ddd
(defun convert-java-to-spss-quest-names (&key (all-qvar-lists *shaq-question-variable-lists))
  "In U-CS (inSHAQ U-data-functions), A TEMP FUNCTION USED TO CHANGE THE NAMES IN THE LIST OF QUESTION  FROM THE OLD JAVA NAMES TO THE NEW SPSS NAMES"
  (let
      ((old-q-sym)
       (new-q-sym)
       (q-string)
       (new-qlist)
       (cat-sym)
       (new-cat-list)
       (new-shaq-quest-list)
       )
    (loop
     for cat-list in all-qvar-lists
     with cat-sym
     do
     (setf cat-sym (first cat-list)
           cat-list (cdr cat-list)
           new-cat-list (list cat-sym))
     (loop
      for sl-list in cat-list
      with qvar
      with sublist
      with q-name
      with q-list
      with q-strings
      with new-q-sym
      do
      (cond
       ((listp sl-list)
        (setf qvar (first sl-list)
              sublist (fifth sl-list))
        (cond
         ((listp sublist)
          (setf q-name (third sublist))
       ;;  (afout 'out (format nil "q-name= ~A~% (list '(T 0)(list q-name 0))= ~A~%" q-name (list '(T 0)(list q-name 0))))
      ;; (afout 'out (format nil "q-name= ~A~%sl-list= ~A~%" q-name sl-list))
         (multiple-value-setq (q-list q-name)
               (get-key-value-in-nested-lists 
                (list '(T 0)(list q-name 0)) *all-shaq-questions :return-list-p t))     
         (setf new-q-sym (my-make-symbol (format nil "~AQ" qvar)))
       ;;  (afout 'out (format nil "q-strings= ~A~%" q-strings))
         )
        (t nil)))
       (t nil))     
      (cond
       (q-list
        (setf  q-strings (cdr q-list)
               new-qlist (list  new-q-sym q-strings q-name)
               new-cat-list (append new-cat-list (list new-qlist))))
       (t (setf new-q-sym (my-make-symbol (format nil "~AQ" qvar))
                new-qlist (list  new-q-sym 'NO-QUEST-STRING-FOUND)
                new-cat-list (append new-cat-list (list new-qlist)))))
        ;;end inner loop
        )
       (setf new-shaq-quest-list (append new-shaq-quest-list (list new-cat-list)))
       ;;end outer loop
       )
      ;;end
      new-shaq-quest-list
      ))
|#
;;test
;; SSS START TESTING HERE--TO RENAME QUESTS
#|  (defun print-new-shaq-questions ()
    (let
       ((new-shaq-qlist)
        )
      (setf new-shaq-qlist (convert-java-to-spss-quest-names))
      (print-nested-list new-shaq-qlist :stream t :incl-quotes-p t)
      ))|#
;; (print-new-shaq-questions)


;;  
;; (get-key-value-in-nested-lists (list '(T 0)(list 'smtExercizeQ 1)) *all-shaq-questions)


;;CALC-IS-QUEST-REVERSE-SCORED
;;
;;ddd
(defun calc-is-quest-reversed  (qvar &key answer-array)
  "In U-data-functions. Checks the scoring array Eg. LikeMe7Reverse vs LikeMe7 to see if question is reverse or normall scored.  Returns (values reversed-item-p item-norm-or-rev) REVERSED-ITEM  if finds word reverse in the name. item-norm-or-rev = NORMAL-ITEM if not reversed/  NOTE: answer-array can be a symbol. "
  (let*
      ((reversed-item-p )
       (item-norm-or-rev 'NORMAL-ITEM)
       )

    (unless answer-array
             (setf answer-array (fifth (fifth (get-qvar-list qvar)))))

    (when (symbolp answer-array)
      (setf answer-array (format nil "~A" answer-array)))

    ;;see if answer-array contains word "reverse"
    (when (search "reverse" answer-array :test 'char-equal)
      (setf reversed-item-p 'REVERSED-ITEM
            item-norm-or-rev 'REVERSED-ITEM))

            item-norm-or-rev 
    ;;return result NIL or REVERSED-ITEM
    (values reversed-item-p item-norm-or-rev)
    ))
;;TEST
;;  (calc-is-quest-reversed 'TBVWEAK)  works = REVERSED-ITEM
;;  (calc-is-quest-reversed 'THM10OTH)  works = nil
;;  (calc-is-quest-reversed 'COPBLAME)  works = REVERSED-ITEM
;;  (calc-is-quest-reversed 'COPBLAME :answer-array "PerCent6CopeReverse") = REVERSED-ITEM
;;  (calc-is-quest-reversed nil :answer-array 'FREQ7REVERSE) = REVERSED-ITEM
;; (calc-is-quest-reversed nil :answer-array 'FREQ7) = NIL
    




;;GET-ELMSYMVAL-LISTS
;;
;;ddd
(defun get-elmsymval-lists (&key (elmsyms *all-elmsyms))
  "In U-CS, RETURNS (values elmsymval-lists elmsyms n-elmsyms).  Gets all elmsyms from *csq-elmsym-lists unless elmsyms. Note: *all-elmsyms includes all elmsyms, while  *all-elmsym-lists contains only those with names."
  (let
      ((elmsym-lists)
       (elmsym-names)
       (elmsymval-list)
       (elmsymval-lists)
       (n-elmsyms)
       )
    
      ;;(break "2")
      (loop
       for elmsym in elmsyms
       do
       (unless (symbolp elmsym)
         (setf elmsym (my-make-symbol elmsym)))

       (when (and (symbolp elmsym)(boundp elmsym))
         (setf elmsymval-list (eval elmsym)
               elmsymval-lists (append elmsymval-lists (list elmsymval-list)))
                                       ;;was (list (list elmsym  elmsymval-list))))
         ;;(break "3")
         (setf n-elmsyms (list-length elmsyms))
         ;;end when
         )
       ;;end loop
       )

    (values elmsymval-lists elmsyms n-elmsyms)
    ;;end let, get-elmsymvals
    ))
;;TEST
;;  (get-elmsymval-lists)
;; works=     REDO    (MOTHER FATHER BEST-M-FRIEND BEST-F-FRIEND)    4






;;MAKE-PCSYMVAL-LISTS
;;
;;ddd
(defun make-pcsymval-lists (&key (all-datalists *csq-data-list))
 "In U-CS, makes a list of all (pcsym (pcsymvals) -- used for saving to a file. RETURNS (values all-pcsymval-lists all-pcsyms)."
 (let
     ((pcsym)
      (all-pcsyms)
      (pcsymvals)
      (all-pcsymval-lists)
      (pcsym-datalists (get-keyvalue-in-nested-list '((:PCSYM-ELM-LISTS T)) all-datalists))
      )
   (loop
    for pcsymdata in pcsym-datalists
    do
    (setf pcsym (car pcsymdata))
    (when (and (symbolp pcsym)(boundp pcsym))
          (setf pcsymvals (eval pcsym)
                all-pcsyms (append all-pcsyms (list pcsym))
                all-pcsymval-lists (append all-pcsymval-lists (list (list pcsym pcsymvals)))))
    ;;end loop
    )
   (values all-pcsymval-lists all-pcsyms)
   ;;end let, get-pcsymval-lists
     ))
;;TEST
;;  (make-pcsymval-lists)
;; works=  ((A4 ("A4" "a vs nota" CS2-1-1-99 NIL NIL :PC ("a" "nota" 1 NIL) :POLE1 "a" :POLE2 "nota" :BESTPOLE 1 (:BIPATHS ((POLE1 NIL FATHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL MOTHER NIL))))) (B7 ("B7" "b vs notb" CS2-1-1-99 NIL NIL :PC ("b" "notb" 1 NIL) :POLE1 "b" :POLE2 "notb" :BESTPOLE 1 (:BIPATHS ((POLE1 NIL FATHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL MOTHER NIL))))) (C0 ("C0" "c vs notc" CS2-1-1-99 NIL NIL :PC ("c" "notc" 1 NIL) :POLE1 "c" :POLE2 "notc" :BESTPOLE 1 (:BIPATHS ((POLE1 NIL BEST-M-FRIEND NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL MOTHER NIL))))) (D4 ("D4" "d vs NOTD" CS2-1-1-99 NIL NIL :PC ("d" "NOTD" 1 NIL) :POLE1 "d" :POLE2 "NOTD" :BESTPOLE 1 (:BIPATHS ((POLE1 NIL BEST-M-FRIEND NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL FATHER NIL))))))        (A4 B7 C0 D4)






;;GETCSYMVALS
;;
;;ddd
(defun getcsymvals (csartsym &optional dims &key (dataval-nth 0))
  "In U-CS, From a CSartsym (network node sym) RETURNS (values CSYMvals CSdata CSYM nth-dataval) of the associated CSYM (located as the CSartsym value). If dataval-nth, returns nth-dataval. "
  (let
      ((CSYM)
       (CSYMvals)
       (CSdata)
       (CSYMstr)
       (nth-dataval)
       )
    (setf CSYM (getsymval CSartsym))

    ;;GET CSYMVALS
    (cond
     ((boundp CSYM)
        (setf CSYMvals (eval CSYM)
              CSdata (fourth CSYMvals)))
     (t (setf CSYM nil)))

    (when (and dataval-nth (listp CSdata))
      (setf nth-dataval (nth dataval-nth CSdata)))

    (values CSYMvals CSdata CSYM nth-dataval)
    ;;end let, getCSYMvals
    ))
;;TEST
;; (getCSYMvals 'CS2-11-1-1)
;; = ("CSTSTSYM" "CS test sym" CS2-11-1-1 (4 "data") "test definition" :INFO "more info")   (4 "data")  CSTSTSYM 4
    




;;SETCSYMVAL
;;
;;ddd
(defun  setcsymval (csartsym value &optional dims &key (data-only-p T) 
                              all-symvals-p nth-value csdata-nth 
                              set-csdata-key-value set-cs-key-value)
  "In U-CS, takes a csartsym and sets whatever  csym is its value. then sets the cs data-value either value (if data-only-p). if all-symvals-p, sets the cs symvals to value.  if nth-value, sets the nth cs value to value. if dataval-nth, sets the nth dataval to value. . SET-CSDATA-KEY-VALUE is a key eg. :PC.  and changes csdata list containing key to key value (or appends it if not).  (Does NOT affect any other values). NOTE: CSDATA IS 4th item in the csymvals (which is 4th in csartsym). SET-CS-KEY-VALUE sets or appends value to key in main cssymvals list (eg. :info).  RETURNS (values new-csymvals csym old-value old-keyval new-csdata)"
  (let
      ((csym)
       (csymvals)
       (csdata)
       (orig-csdata)
       (otherval)
       (new-csdata)
       (new-csymvals)
       (old-value)
       (setkey)
       (keyvalue)
       (key&data)
       (keyfound)
       (old-keyval)
       ) 

    ;;GET CS SYM, SYMVALS, AND DATA
    (setf csym (getsymval csartsym))
    (when (boundp csym)
          (setf csymvals (eval csym)
                csdata (fourth csymvals)))

    (cond
    ;;SET-CSDATA-KEY-VALUE (new) sets a key value in CSDATA list
     ((and set-csdata-key-value (symbolp set-csdata-key-value))
      (setf setkey set-csdata-key-value
            keyvalue value
            orig-csdata csdata)
      (multiple-value-setq (new-csdata keyfound old-keyval)
             (set-key-value setkey keyvalue csdata))
      (multiple-value-setq (new-csymvals old-value)
          (replace-nth csymvals 3 new-csdata)))
     ;;SET-CS-KEY-VALUE  for CSYMVALS
     ((and set-cs-key-value (symbolp set-cs-key-value))
      (setf setkey set-cs-key-value
            keyvalue value)
      (multiple-value-setq (new-csymvals keyfound old-keyval)
         (set-key-value setkey keyvalue csymvals)))
      ;;SET CSDATA-NTH
     (csdata-nth
      (setf new-csdata (replace-nth csdata csdata-nth value))
      (multiple-value-setq (new-csymvals old-value)
          (replace-nth csymvals 3 new-csdata)))
     ;;SET NTH-VALUE
     (nth-value
      (multiple-value-setq (new-csymvals old-value)
          (replace-nth csymvals nth-value  value)))
     ;;SET ENTIRE CSYMVALS
     (all-symvals-p
      (setf new-csymvals value
            old-value csymvals))
     ;;SET CSYM DATA ONLY 
     (data-only-p
      (setf new-csdata value)
      (multiple-value-setq (new-csymvals old-value)
          (replace-nth csymvals 3 value)))
     (t nil))

    ;;SET the CSYM to new-csymvals
    (when csym
      (set csym new-csymvals))

    (values new-csymvals csym old-value old-keyval new-csdata)
    ;;end let, setcsymval
    ))
;;TEST
;; first (make-csym 'csmysym "cs test sym" 'cs3-11-1-1  '(4 "data"  :key1 (a b c)) "test definition" :info "more info")
;;  = ("csmysym" "cs test sym" cs3-11-1-1 (4 "data") "test definition" :info "more info")  csmysym  
;;
;; change csdata
;;  (setcsymval 'cs3-11-1-1 '(6 "more newdata" :key1 (c d e)))
;; works= ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :INFO "more info")   CSMYSYM  (6 "newdata" :KEY1 (C D E))   NIL   (6 "more newdata" :KEY1 (C D E))
;;also csmysym = ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :INFO "more info")
;;
;; change csdata-nth = 4 (appends because is no nth= 2)
;;  (setcsymval 'cs3-11-1-1  "newdata nth=4" nil  :csdata-nth 4 )
;;  works= ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E) "newdata nth=4") "test definition" :INFO "more info")   CSMYSYM  (6 "more newdata" :KEY1 (C D E))   NIL    (6 "more newdata" :KEY1 (C D E) "newdata nth=4")
;;
;; change csdata-nth = 1
;; (setCSYMval 'CS3-11-1-1  "newdata nth=1" nil  :csdata-nth 1 )
;; works= ("CSMYSYM" "CS test sym" CS3-11-1-1 (6 "newdata nth=1" "newdata nth=2") "test definition" :INFO "more info")   CSMYSYM   (6 "newdata" "newdata nth=2")
;;also  CSMYSYM  =  ("CSMYSYM" "CS test sym" CS3-11-1-1 (6 "newdata nth=1" "newdata nth=2") "test definition" :INFO "more info")
;;
;; change nth-value = 1
;; (setCSYMval 'CS3-11-1-1 "CS mysym"  nil     :nth-value 1)
;; ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "newdata nth=1" :KEY1 (C D E) "newdata nth=4") "test definition" :INFO "more info")   CSMYSYM   (6 "more newdata" :KEY1 (C D E) "newdata nth=4")   NIL   (6 "newdata nth=1" :KEY1 (C D E) "newdata nth=4")
;;
;; (setcsymval 'CS3-11-1-1 '(new-key-value) nil :set-csdata-key-value :key1)
;; works = ("CSMYSYM" "cs test sym" CS3-11-1-1 (4 "data" :KEY1 (NEW-KEY-VALUE)) "test definition" :INFO "more info")   CSMYSYM   (4 "data" :KEY1 (A B C))   (A B C)   (4 "data" :KEY1 (NEW-KEY-VALUE))
;; (setcsymval 'CS3-11-1-1 '(new-key-value2) nil :set-csdata-key-value :key2)
;; works = ("CSMYSYM" "cs test sym" CS3-11-1-1 (4 "data" :KEY1 (NEW-KEY-VALUE) :KEY2 (NEW-KEY-VALUE2)) "test definition" :INFO "more info")   CSMYSYM  (4 "data" :KEY1 (NEW-KEY-VALUE))   NIL   (4 "data" :KEY1 (NEW-KEY-VALUE) :KEY2 (NEW-KEY-VALUE2))
;;also 
;; CL-USER 105 > CSMYSYM = ("CSMYSYM" "cs test sym" CS3-11-1-1 (4 "data" :KEY1 (NEW-KEY-VALUE) :KEY2 (NEW-KEY-VALUE2)) "test definition" :INFO "more info")
;;SET-CS-KEY-VALUE
;; (setcsymval 'CS3-11-1-1 "NEW INFO SET" nil :set-cs-key-value :info)
;; works = ("CSMYSYM" "cs test sym" CS3-11-1-1 (4 "data" :KEY1 (NEW-KEY-VALUE) :KEY2 (NEW-KEY-VALUE2)) "test definition" :INFO "NEW INFO SET")    CSMYSYM   NIL   "more info"  NIL
;;append new
;; (setcsymval 'CS3-11-1-1 "APPENDED KEY VALUE" nil :set-cs-key-value  :newkey)
;; works= ("CSMYSYM" "cs test sym" CS3-11-1-1 (4 "data" :KEY1 (NEW-KEY-VALUE) :KEY2 (NEW-KEY-VALUE2)) "test definition" :INFO "NEW INFO SET" :NEWKEY "APPENDED KEY VALUE")  CSMYSYM  NIL  NIL NIL
;;also CL-USER 108 > CSMYSYM  =  ("CSMYSYM" "cs test sym" CS3-11-1-1 (4 "data" :KEY1 (NEW-KEY-VALUE) :KEY2 (NEW-KEY-VALUE2)) "test definition" :INFO "NEW INFO SET" :NEWKEY "APPENDED KEY VALUE")



;;SET-SYMKEYVAL
;;2018
;;ddd
(defun set-symkeyval (sym key value  &key  spec-lists (val-nth 1)
                          append-value-p  add-value-p  splice-newvalue-at-nth-p )
  "In U-CS,  RETURNS (values newsymval-list  new-keylist old-value old-keylist )   INPUT:  "
  (let
      ((oldsymlist (eval sym))
       )
    (unless spec-lists
      (setf spec-lists (list (list key T val-nth))))

    (multiple-value-bind (return-keylist newsymval-list   new-keylist return-value    
              old-keylist last-key-found-p old-value) 
          (get-set-append-delete-keyvalue-in-nested-list value spec-lists oldsymlist
                  :append-value-p append-value-p      :add-value-p add-value-p
                  :splice-newvalue-at-nth-p  splice-newvalue-at-nth-p)
      
    ;;reset the sym
    (set sym newsymval-list)

    (values newsymval-list  new-keylist old-value old-keylist )
    ;;end mvb,let, SET-SYMKEYVAL
    )))
;;TEST 
;; 1. FIRST MAKE A CSYM
;;  (make-csym 'csmysym "cs test sym" 'cs3-11-1-1  '(4 "data"  :key1 (a b c)) "test definition" :info "more info")
;;= ("CSMYSYM" "cs test sym" CS3-11-1-1 (4 "data" :KEY1 (A B C)) "test definition" :INFO "more info")
;; cs3-11-1-1 = ("CS" (3 11 1 1) NIL CSMYSYM NIL)
;; CSMYSYM  = ("CSMYSYM" "cs test sym" CS3-11-1-1 (4 "data" :KEY1 (A B C)) "test definition" :INFO "more info")
;; 2. ADD NEW KEY AND VALUE
;; (set-symkeyval 'CSMYSYM :NEWKEY 'NEWVAL)
;; works= ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :INFO "more info" :NEWKEY NEWVAL)   (:NEWKEY NEWVAL)   NIL  NIL
;; 3. REPLACE THE VALUE
;; (set-symkeyval 'CSMYSYM :NEWKEY 'NEWVAL2)
;; works= ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :INFO "more info" :NEWKEY NEWVAL2)    ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :INFO "more info" :NEWKEY NEWVAL2)   NEWVAL   ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :INFO "more info" :NEWKEY NEWVAL)
;; 4. APPEND THE VALUE
;; (set-symkeyval 'CSMYSYM :NEWKEY 'NEWVAL3 :APPEND-VALUE-P T)
;; works= ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :INFO "more info" :NEWKEY (NEWVAL2 NEWVAL3))     ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :INFO "more info" :NEWKEY (NEWVAL2 NEWVAL3))NEWVAL2   ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :INFO "more info" :NEWKEY NEWVAL2)   
;; 5. ADD-VALUE-P 
;; (set-symkeyval 'CSMYSYM :NEWKEY 'NEWVAL4 :ADD-VALUE-P T)
;; works = ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :INFO "more info" :NEWKEY (NEWVAL2 NEWVAL3) NEWVAL4)   ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :INFO "more info" :NEWKEY (NEWVAL2 NEWVAL3) NEWVAL4)   (NEWVAL2 NEWVAL3)   ("CSMYSYM" "cs test sym" CS3-11-1-1 (6 "more newdata" :KEY1 (C D E)) "test definition" :INFO "more info" :NEWKEY (NEWVAL2 NEWVAL3))





;;MAKE-PC
;;
;;ddd
(defun make-pc (pole1 pole2 bestpole value  &key pcsym pcname  pcphrase pcdata
                      pcart-loc pcdef  info bipaths  (min-sym-length 5)(max-sym-length 18) 
                      restkeys (if-exists-do-nothing-p T) (update-dims-dimsym :C) )
  "U-CS, makes a new PC node (inside of an ART type network with csart-loc symbol Uses make-csym function.  RESTKEYS allows a list of keylists eg. ((key1 value1)(key2 value2) etc). Should be a standard key such as :to :from :wto :wfrom. RETURNS (values pcsymvals pcsym)."
  (let*
      ((pclist (list pole1  pole2 bestpole value)) ;;not used?
       (len-pole1 (length pole1))
       (pcsymvals) 
       (similar-sym)
       
       )
    (unless pcphrase
      (setf pcphrase (format nil "~A vs ~A" pole1 pole2)))

    (unless pcsym
      (multiple-value-setq (pcsym pcname similar-sym pcymvals)
          (make-condensed-sym pole1 :max-length max-sym-length
                                          :min-length min-sym-length))
#|      (setf pcname (make-condensed-string pole1 :max-length max-sym-length
                                          :min-length min-sym-length))
      (multiple-value-setq (pcsym pcname similar-sym pcymvals)
          (make-condensed-sym pcname :max-length max-sym-length
                                          :min-length min-sym-length))   |#
      ;;end unless
      )

    (cond
     ((and if-exists-do-nothing-p pcsym (boundp pcsym)(listp (eval pcsym))
           (>  (list-length (eval pcsym)) 2))
      ;;(break "after and")
      ;;do nothing
      (setf pcsymvals (eval pcsym))
      )
     ;;IF SYM DOESN'T EXIST (or (null if-exists-do-nothing-p))
     (t
      ;;update the *cur-csart-dims
      (setf *cur-csart-dims (incf-artdims *cur-csart-dims update-dims-dimsym))
      ;;The real work function
      (multiple-value-setq (pcsymvals pcsym)
          (make-csym pcsym pcphrase pcart-loc pcdata pcdef :pclist pclist
                     :pole1 pole1 :pole2 pole2 :bestpole bestpole
                     :info info :bipaths bipaths :default-csart-rootstr *default-csart-rootstr
                     :cur-csart-dims *cur-csart-dims :separator *art-index-separator
                     :node-separator *art-node-separator :restkeys restkeys
                     :if-exists-do-nothing-p if-exists-do-nothing-p
                     ))
      ;;(break "after make-csym")
      ;;end t, cond
      ))
    (values pcsymvals pcsym)
    ;;end let, make-pc
    ))
;;TEST
;;  (make-pc  "very cold" "not" "Way 2 alike better" nil)
;;   (make-pc  "very funny" "not" "Way 2 alike better" nil)
;;  ;;  (make-pc  "independent" "dependent" "Way 2 alike better" nil)
;;  (make-pc  "more independent" "less independent" "Way 2 alike better" nil)
;;  (make-pc "lucky" "unlucky""Way 2 alike better" nil     :pcdata '(pcdata)  :pcdef "pc definition" :info "info":bipaths '("bipaths"))
;; results=  ("LUCKY" "lucky vs unlucky" CS1-1-1-1 (PCDATA) "pc definition" :PC ("lucky" "unlucky" NIL) :INFO "info" :BIPATHS ("bipaths"))    LUCKY
;;also 
;;CL-USER 146 > LUCKY  =  ("LUCKY" "lucky vs unlucky" CS1-1-1-1 (PCDATA) "pc definition" :PC ("lucky" "unlucky" NIL) :INFO "info" :BIPATHS ("bipaths"))
;;CL-USER 147 > CS1-1-1-1  =  ("CS" (1 1 1 1) NIL LUCKY NIL)






;;MAKE-ELMSYMS-- NOT USED--
;;REPLACED BY MAKE-ELMSYMS-FROM QVARS?
;;
;;ddd
#|(defun make-elmsyms (elminfo-list &key if-exists-reset-p (if-exists-do-nothing-p T)
                                  keylists)
  "In U-CS. If elminfo-list is a list of BIPATHS, makes elms with bipaths. If list of strings, makes elms w/o bipaths. Does not use longstring, uses exact element name in elminfo to make syms. RETURNS (values elmsyms elmsymvals)"
  (let
      ((elmsym)
       (elmsyms)
       (elsymvals)
       (elmsymvals)
       (bipaths)
       )
    (loop
     for elminfo in elminfo-list
     do
     (cond
      ;;must be bipaths (w elm-str included extra)
      ((listp elminfo)
       (setf elm-str (car elminfo)
             bipaths (cddr elminfo)))
       (t (setf elm-str elminfo)))

     (multiple-value-setq (elsymvals elmsym)
         (make-elmsym nil  nil :elm-name elm-str :bipaths bipaths
                      :if-exists-reset-p if-exists-reset-p
                      :if-exists-do-nothing-p if-exists-do-nothing-p ))
     (setf elm-syms (append elmsyms (list elmsym))
           elmsymvals (append elmsymvals (list elsymvals)))
     ;;end loop
     )
    (values elmsyms elmsymvals)
    ;;end let, make-elm-syms
    ))|#
;;TEST
;; (make-elmsyms '("mother" "father" "best-m-friend"))
;;works= (MOTHER4 FATHER4 BEST-M-FRIEND)   (("MOTHER4" "mother" CS1-1-1-1 NIL NIL) ("FATHER4" "father" CS1-1-1-1 NIL NIL) ("BEST-M-FRIEND" "best-m-friend" CS1-1-1-1 NIL NIL))    
;;for bipaths
;;  (make-elmsyms '(("mother" NIL (TEST-PCSYM (POLE1) NIL)) ("best-m-friend" NIL (TEST-PCSYM (POLE1) NIL)) ("father" NIL (TEST-PCSYM (POLE2) NIL))))




;;MAKE-ELMSYM
;;
;;ddd
(defun make-elmsym (sym-long-str value  &key elmsym elm-name 
                                  elm-phrase elm-data elm-art-loc elm-def 
                                  info bipaths  (min-sym-length 5)(max-sym-length 30) 
                                  restkeys    (if-exists-simple-reset-p T)(if-exists-do-nothing-p T)
                                  (detail-data-list '*CSQ-elmsym-lists))
  "U-CS, makes a new ELEMENT node (inside of an ART type network with csart-loc symbol. Uses make-csym function. sym-long-str can simple-name or longer phrase  that is condensed.  RESTKEYS allows a list of keylists eg. ((key1 value1)(key2 value2) etc). Should be a standard key such as :to :from :wto :wfrom.   RETURNS (values elmsym elmsymvals similar-sym).  If detail-data-list, the appends redundant-detail info needed to begin CSQ at point where discontinued. IF-EXISTS-SIMPLE-RESET-P resets only elmsym not art node to value (and takes precedence over if-exists-do-nothing-p."
  (let*
      ((elmsymvals)     
       (similar-sym)
       (elmsym-exists-p)
       )
    (cond
     ;;if null sym-long-str, use elm-name or elmsym for sym name
     ((and (null sym-long-str) elmsym) 
      (setf sym-long-str (format nil "~A" elmsym)))
     ((and (null sym-long-str) elm-name) 
      ;;does not check for existence of symbol (should I?)
      (setf elmsym (my-make-symbol elm-name)
            sym-long-str (format nil "~A" elmsym)))
     ((and sym-long-str (symbolp sym-long-str)
           (boundp sym-long-str))
      (setf elmsym sym-long-str
            sym-long-str (format nil "~A" sym-long-str)))
     (t nil))

    (when (boundp elmsym)
      (setf elmsymvals (eval elmsym)))

    ;;TEST TO SEE IF ELMSYM EXISTS AND SET TO A LIST > 2
    (when (and (listp elmsymvals)
             (> (list-length elmsymvals) 2))
        ;;set the sym to sym-long-str and eval it
        (setf elmsym-exists-p T))

    ;;IF IT ELMSYM ALREADY EXISTS AND if-exists-do-nothing-p, DO NOTHING 
    (cond
     ;;if elmwym EXISTS AND SIMPLE RESET (elmsymvals only?)
     ((and elmsym-exists-p if-exists-reset-p)
      (setf elmsymvals (append (butlast elmsymvals (- (list-length elmsymvals) 2)) (list value nil)))
      (set elemsym elmsymvals))           
      ;;OTHERWISE
     (t (or (null if-exists-do-nothing-p) (null elmsym-exists-p))
       
      (unless elm-phrase
        (cond 
         (sym-long-str
          (setf elm-phrase sym-long-str))
         (elm-name
          (setf elm-phrase elm-name))
         (t (setf elm-phrase (format nil "~A" elmsym))))
        ;;end unless
        )

      ;;MAKE NEW ELMSYM IF DOESN'T EXIST
      (unless elmsym
        ;;make name string
        (setf elm-name (make-condensed-string sym-long-str
                                              :max-length max-sym-length :min-length min-sym-length))

        ;;make elmsym, but do not set to value (or make-csym won't work right)
        (multiple-value-setq (elmsym elm-name similar-sym) ;;not needed? csymvals)
            (make-condensed-sym elm-name :set-to-value-p NIL
                                :min-length min-sym-length :max-length max-sym-length))   
        ;;end unless
        )
      (unless elm-name
        (setf elm-name (format nil "~A" elmsym)))        

      ;;(BREAK "B2")
      ;;update the *cur-csart-elment-dims
      (setf *cur-csart-dims (incf-artdims *cur-csart-elment-dims 'I))   

      ;;IF RESET OR SETTING NEW SYM AND SYMVALS
      ;;The real work function adding elmsymvals
      (multiple-value-setq (elmsymvals elmsym) 
          (make-csym elmsym elm-phrase elm-art-loc elm-data elm-def 
                     :info info :bipaths bipaths :default-csart-rootstr *default-csart-rootstr
                     :cur-csart-dims *cur-csart-elment-dims :separator *art-index-separator
                     :node-separator *art-node-separator :restkeys restkeys
                     :if-exists-do-nothing-p if-exists-do-nothing-p
                     ))

      ;;store elmsym info in serial form to store to file?
      (when (and detail-data-list elmsymvals)
        (set detail-data-list (append (eval detail-data-list) (list (list elmsym elmsymvals)))))
      ;;(BREAK "B3")          
      ;;end cond exists
      ))

      (values elmsym elmsymvals similar-sym)
      ;;end let, make-elmsym
      ))
;;TEST
;;  (make-elmsym  "mother" nil)
;; works= ("MOTHER7" "mother" CS1-1-1-1 NIL NIL)    MOTHER7
;; (make-elmsym "newnameXX" nil :elm-phrase "qphrase")
;; (make-elmsym "glowABcdefgh" nil :elm-phrase "qphrase")
;; works= GLOWABCDEFGH   ("GLOWABCDEFGH" "qphrase" CS1-1-1-1 NIL NIL)   NIL
;;also GLOWABCDEFGH = ("GLOWABCDEFGH" "qphrase" CS1-1-1-1 NIL NIL)
;;
;;reset
;;  (make-elmsym  "mother" nil :if-exists-do-nothing-p nil :if-exists-simple-reset-p t)
;; works= MOTHER   ("MOTHER" "mother" CS1-1-1-1 NIL NIL)   NIL
;;also
;; CL-USER 62 > mother =  ("MOTHER" "mother" CS1-1-1-1 NIL NIL)


;;RESET-ALL-ELMS
;;
;;ddd
(defun reset-all-elms (&key (all-elms *all-pc-element-qvars))
  "In U-CS, resets all elms to initialization values. RETURNS (values elmsyms type-list)"
  (make-elmsyms-from-qvars all-elms :if-exists-simple-reset-p T  :if-exists-do-nothing-p NIL)
  )
;; (reset-all-elms)


;;MAKE-ELMSYMS-FROM-QVARS
;;
;;ddd
(defun make-elmsyms-from-qvars (all-qvars-list &key
                                            (if-exists-simple-reset-p T) if-exists-do-nothing-p
                                           ( init-art-dims *init-CSart-elment-dims))
  "In U-CS. INPUT= a list of qvar-lists as nested lists of qvar-types. Makes new elmsyms. If make-art-elm-network-p, Makes an ART network framework. RETURNS (values elmsyms type-list). if-exists-do-nothing-p has priority over resetting. ALSO SETS *type-name-elms list to each type elmsyms list.  IF-EXISTS-SIMPLE-RESET-P resets only elmsym not art node to value (and takes precedence over if-exists-do-nothing-p"
  (let
      ((type)
       (type-list)
       (qvar-list)
       (qvar)
       (elmsyms)
       (dims init-art-dims)
       (num-qvars 0)
       (artsym)
       (artsyms)
       )

    (loop
     for qvartype-list  in all-qvars-list
     do
     (setf type (car qvartype-list)
           type-list (append type-list (list type))
           qvar-lists (cdr qvartype-list))

     (loop
      for qvarlist in qvar-lists
      do
      (when (listp qvarlist)
        (multiple-value-bind (qname qphrase qtype qdata)
            (values-list qvarlist)

          (setf qvar (my-make-symbol qname))

          ;;UNBIND PREVIOUS QVAR?
          (when (and if-exists-simple-reset-p (symbol-listp qvar))
            (makunbound qvar))

          
          ;;find already made artsym in network and use to set to values
          (setf dims (incf-artdims dims :I)
                artsym (car (make-artsyms-from-dims *cs-elm-rootsr (list dims))))

          ;;(break "in loop after working on qvar")
          (setf elmsym (make-elmsym qname nil :elm-phrase qphrase
                                     :elm-art-loc artsym
                                      :if-exists-simple-reset-p if-exists-simple-reset-p
                                     :if-exists-do-nothing-p if-exists-do-nothing-p )
                elmsyms (append elmsyms (list elmsym)))
          ;;vvv
          ;;end when,mvb, inner loop
          )))

         ;;SET GLOBAL VAR TO TYPE
          (setf type-name (format nil "*~A-elmsyms" type)
                type-sym (my-make-symbol type-name))

          (set type-sym elmsyms)
     ;;end outer loop
     )
    (values elmsyms type-list)
    ;;end let, make-elmsyms-from-qvars
    ))
;;TEST
;; (make-elmsyms-from-qvars *all-PC-element-qvars)  







;;FIND-POLE-ELM-LINKS
;;
;;ddd
(defun find-pcpole-elm-links (pcsym 3elements alike-button-selections
                                        dif-button-selection)
  "In U-CS, used within callback to link text-input1 with the 2 elements selected as alike, and text-input2 with the element selected as different. RETURNS (values pole1-alike-elms  pole2-dif-elms pc-bipaths-list elm-bipaths-lists)."
  (let*
      ((pole1-alike-elms)
       (pole2-dif-elms)
       (pole1-paths)
       (pole2-paths)
       (pc-bipaths-list)
       (elm-bipaths-list)
       )
    
      (when (member "item 1" alike-button-selections :test 'string-equal)
       (setf  pole1-alike-elms (list (first 3elements))))
      (when (member "item 2" alike-button-selections :test 'string-equal)
       (setf  pole1-alike-elms (append pole1-alike-elms (list (second 3elements)))))
      (when (member "item 3" alike-button-selections :test 'string-equal)
       (setf  pole1-alike-elms (append pole1-alike-elms (list (third 3elements)))))
      (when (member "item 1" dif-button-selection :test 'string-equal)
       (setf  pole2-dif-elms (list  (first 3elements))))
      (when (member "item 2" dif-button-selection :test 'string-equal)
       (setf  pole2-dif-elms  (list  (second 3elements))))
      (when (member "item 3" dif-button-selection :test 'string-equal)
       (setf  pole2-dif-elms  (list  (third 3elements))))


        (setf  pc-bipaths-list  (list (list 'pole1 nil (car pole1-alike-elms) nil)(list 'pole1 nil  (second pole1-alike-elms) NIL)(list 'pole2 nil (car pole2-dif-elms) nil)))

        (setf elm-bipaths-lists
              (list (list (car pole1-alike-elms) nil (list pcsym '(pole1)NIL))
               (list (second pole1-alike-elms) nil (list pcsym '(pole1)NIL))
               (list (car pole2-dif-elms) nil (list pcsym '(pole2) NIL))))

        (values pole1-alike-elms  pole2-dif-elms pc-bipaths-list elm-bipaths-lists)

      ;;end let, find-pcpole-elm-links
      ))
;;TEST
;;  (find-pcpole-elm-links 'TEST-PCSYM '("mother" "father" "best-m-friend") '("item 1" "item 3") '("item 2")   )) 
;;works=("mother" "best-m-friend")   ("father")   ((POLE1 NIL "mother" NIL) (POLE1 NIL "best-m-friend" NIL) (POLE2 NIL "father" NIL))        (("mother" NIL (TEST-PCSYM (POLE1) NIL)) ("best-m-friend" NIL (TEST-PCSYM (POLE1) NIL)) ("father" NIL (TEST-PCSYM (POLE2) NIL)))





;;ADD-ELM-BIPATHS
;;
;;ddd
(defun add-pcs-to-elm-bipaths (elm-bipaths)
  "In U-CS"
  (let
      ((elmsyms)
       (elmsym)
       (elmsymvals)
       )
    (loop
     for pathlist in elm-bipaths
     do
     (setf elmsym  (my-make-symbol (car pathlist))
           elmsymvals (eval elmsym))
     (when elmsym
          (setf elmsyms (append elmsyms (list elmsym))
      elmsymvals (append-key-value-in-list :bipaths (list pathlist) elmsymvals                                 :append-as-flatlist-p NIL 
                                 :append-first-as-flatlist-p T  :list-first-value-p T)))
     ;;(break "after append")
     (when elmsym
       (set elmsym elmsymvals))
     ;;end loop
     )
    (values elmsyms elmsymvals)
    ;;end let, add-elm-bipaths
    ))
;;TEST
;;  (add-pcs-to-elm-bipaths '(("mother" NIL (TEST-PCSYM (POLE1) NIL)) ("best-m-friend" NIL (TEST-PCSYM (POLE1) NIL)) ("father" NIL (TEST-PCSYM (POLE2) NIL))))
;;works=  (MOTHER BEST-M-FRIEND FATHER)
;;("FATHER" "father" ELM3-1-1-99 NIL NIL :BIPATHS ("father" NIL (TEST-PCSYM (POLE2) NIL)))
;; CL-USER 76 > mother = ("MOTHER" "mother" ELM2-1-1-99 NIL NIL :BIPATHS ("mother" NIL (TEST-PCSYM (POLE1) NIL)))
;; CL-USER 77 > best-m-friend  =  ("BEST-M-FRIEND" "best-m-friend" ELM4-1-1-99 NIL NIL :BIPATHS ("best-m-friend" NIL (TEST-PCSYM (POLE1) NIL)))
;;
;;then append more paths
;;  (add-pcs-to-elm-bipaths '(("mother" NIL (NEW-PCSYM (POLE1) NIL)) ("best-m-friend" NIL (NEW-PCSYM (POLE1) NIL)) ("father" NIL (NEW-PCSYM (POLE2) NIL))))         





;;SET-CSYM-KEYVALUE
;;
;;ddd
;;
;;THIS FUNCTION NOT NEEDED, ENTIRELY PRECLUDED BY 
;;   SET-KEY-VALUE  and APPEND-KEY-VALUE FUNCTIONS

;;TEST FOR SET-KEY-VALUE
;; (setf mother '("MOTHER" "mother" CS1-1-1-1 (datalist this :key1 "that") NIL :info "this is info" :key3 (a b c)))
;;  for datalist key item
;;  (set-key-value :key1 "NEW-VALUE" mother)
;; works= ("MOTHER" "mother" CS1-1-1-1 (DATALIST THIS :KEY1 "NEW-VALUE") NIL :INFO "this is info" :KEY3 (A B C))   :KEY1  "that"  (:KEY1 "NEW-VALUE")
;;for flatlist key item
;;  (set-key-value :info "NEW-FLAT-VALUE" mother)
;; works= ("MOTHER" "mother" CS1-1-1-1 (DATALIST THIS :KEY1 "that") NIL :INFO "NEW-FLAT-VALUE" :KEY3 (A B C))   :INFO    "this is info"    (:INFO "NEW-FLAT-VALUE")



;; (replace-list mother 3 '(datalist REPLACEMENT)) = ("MOTHER" "mother" CS1-1-1-1 (DATALIST REPLACEMENT) NIL :INFO "this is info" :KEY3 (A B C))




;;GET-ELMSYM-QUEST-TEXT
;;
;;ddd
(defun get-elmsym-quest-text (elmsym)
  "In U-CS. RETURNS (values  qtext q-text-sym q-text-list q-title q-instr).Uses specific name if value of elmsym set to a name, or default text in Q text null value. "
  (let
      ;;if elmsym value set to a SPECIFIC (eg person) NAME
      ((qtext (fifth (eval elmsym)))
       ) 
    (multiple-value-bind ( q-text-sym q-text-list q-title q-instr)
        (get-question-text elmsym)
     
      ;;If not a name, then use default text
      (when (null qtext)
        (setf qtext (car q-text-list)))

    (values  qtext q-text-sym q-text-list q-title q-instr)    
    ;;end let, get-elmsym-quest-text
    )))
;;TEST
;;  (get-elmsym-quest-text 'MOTHER)
;; "Your Mother [or person most like a mother to you]"   MOTHERQ  ("Your Mother [or person most like a mother to you]")  "People Important To You"   "Write the (first + last name initial) NAME of a person that fits the description well. DO NOT use the same person twice!"





;;MAKE-ELMSYM-COMPARE-LISTS
;;
;;ddd
(defun make-elmsym-compare-lists (&key (all-elmsyms *all-elmsyms)
                                       (global-combos-sym  '*all-elmsym-compare-combos)
                                       compare-within-categories
                                       use-make-combos-from-lists-p
                                       return-every-nth
                                       random-sample-percent
                                       randomize-p
                                       (randomize-min-combo-n 20)
                                       return-all-combos-p
                                       (prefix "") (postfix ""))
  "In U-CS.  Takes large all-elmsyms list and makes combos of items 1, 2, 3; 4,5,6; etc until all-elmsyms used.  If compare-within-categories (must be list of  qvar categories), creates these combos WITHIN each category list. If  return-every-nth, return-combos is every nth. If  random-sample-percent, return-combos is a that percent chosen randomly.  If randomize-p, randomizes the result. If extra elmsyms,  adds item 1, etc from top of list. Note: Using make-combos creates huge number of comparisons. RETURNS (values global-combos-sym n-combos all-return-combos all-combos )"
  (let*
      ((elmsym-lists)
       (combo-lists) 
       (remainders)
       (nth 0)
       (combo)
       (n-combos)       
       (return-combos)
       (all-return-combos)
       (cat-combos)
       (all-combos)
       (elmsyms)
       (catsyms-lists)
       (combos-sym)
       )
    (cond
     ;;RANDOMIZE AND/OR SAMPLE PERCENT
     ((or randomize-p random-sample-percent return-every-nth)

      ;;COMPARE-WITHIN-CATEGORIES OR COMPARE ACROSS ALL-ELMSYMS
      (cond
       (compare-within-categories
        (loop
         for cat in compare-within-categories
         do
         (setf elmsyms (nth-value 1 (get-category-qvar-names cat))
               elmsym-lists (append elmsym-lists (list elmsyms)))
         ;;end loop, compare-within-categories
         )
        (setf elmsyms nil)  ;;RESET
        )
       (t (setf elmsym-lists (list all-elmsyms))))       
      
      ;;(BREAK "1")
      ;;MAKE THE COMBOS for each cat (only 1 cat unless compare-within-categories
      (loop
       for elmsyms in elmsym-lists
       do
       (multiple-value-setq (return-combos n-combos combos-sym cat-combos)
           (make-combos elmsyms 3 :global-combos-sym NIL
                        :return-all-combos-p return-all-combos-p
                        :return-every-nth return-every-nth
                        :random-sample-percent random-sample-percent
                        :randomize-p randomize-p
                        :randomize-min-combo-n randomize-min-combo-n
                        :return-all-combos-p return-all-combos-p 
                        :prefix prefix :postfix postfix  ))
       ;;make one combined flat list
       (setf all-return-combos (append all-return-combos return-combos))
       (unless (equal all-combos 'ALL-COMBOS-NOT-RETURNED)
             (setf all-combos (append all-combos cat-combos)))
       ;;end loop
       )
      ;;(BREAK "2")
      (when global-combos-sym
        (set global-combos-sym all-return-combos))

      (setf n-combos (list-length all-return-combos))
     ;; (break "make-combos")

     ;;END (or randomize-p random-sample-percent return-every-nth)
      )

     ;;USE-MAKE-COMBOS-FROM-LISTS-P
     (use-make-combos-from-lists-p  

      ;;DIVIDE INTO 3 LISTS TO PICK ELEMENTS FROM EACH LIST
      (setf elmsym-lists (divide-list-in-order all-elmsyms 3))

      ;;MAKE THE COMBOS
      (multiple-value-setq (combo-lists remainders)
          (make-combos-from-lists elmsym-lists))

      ;; SSSS START HERE TESTING--USE       (group-by-nth ON REMAINDERS
     (when remainders
        ;;(setf remainders (delete-duplicates remainders :test 'equal))
        (loop
         for rem in remainders
         do
         (cond
          ((null rem) NIL)
#|          ((and rem (not (listp rem)))
           (setf combo (list rem  (nth nth all-elmsyms) (nth (+ nth 1) all-elmsyms))
                 nth (+ nth 2)
                 combo-lists (append combo-lists (list combo))))|#
          ((and rem (listp rem))
           (cond
            ((= (list-length rem) 2)
             (setf combo (append rem (nth nth all-elmsyms))
                   combo-lists (append combo-lists (list combo)))
             (incf nth))
            (t (setf combo (append rem (list (nth nth all-elmsyms) (nth (+ nth 1) all-elmsyms)))
                     nth (+ nth 2)
                     combo-lists (append combo-lists (list combo))))))
          (t nil))
       
         ;; (break "2")
         ;;end loop, when remainders
         ))
      (setf n-combos (+ *n-people-combos *n-group-combos *n-self-combos)
            all-return-combos combo-lists)
      ;;end use-make-combos-from-lists-p
      )    
     (t nil))

    (values global-combos-sym n-combos all-return-combos all-combos )
    ;;end let,make-elmsym-compare-lists
    ))
;;TEST
;;  (make-elmsym-compare-lists  :all-elmsyms  '(A B C D E F G H I J K L M N O P) :return-every-nth 20)
;; works=  *ALL-ELMSYM-COMPARE-COMBOS     28       ((A B C) (A C J) (A E G) (A G H) (A I M) (A M O) (B D G) (B E P) (B H I) (B J P) (C D I) (C F H) (C H K) (C K M) (D E L) (D G M) (D J L) (E F G) (E H J) (E K L) (F G M) (F J L) (G H I) (G J P) (H I N) (H M P) (I M O) (K L M))      ALL-COMBOS-NOT-RETURNED
;;TEST--USING REAL DATA

;; SSS START HERE TESTING
;;  (make-elmsym-compare-lists  :global-combos-sym  '*all-elmsym-compare-combos :compare-within-categories '(PCE-PEOPLE PCE-GROUPS PCE-SELF) :return-every-nth 20  :random-sample-percent NIL  :randomize-p NIL :return-all-combos-p NIL) 
;; FOR A TEST SAMPLE
;; (setf *all-elmsymsX '(MOTHER FATHER BEST-M-FRIEND BEST-F-FRIEND M-DISLIKE F-DISLIKE M-ADMIRE F-ADMIRE PER-MOSTFUN PER-ROMANCE ROLE-MODEL))
;;(make-elmsym-compare-lists :all-elmsyms *all-elmsymsX :return-every-nth 12)
;;works= *ALL-ELMSYM-COMPARE-COMBOS   14     ((MOTHER FATHER BEST-M-FRIEND) (MOTHER BEST-M-FRIEND M-ADMIRE) (MOTHER M-DISLIKE F-DISLIKE) (MOTHER M-ADMIRE PER-MOSTFUN) (FATHER BEST-M-FRIEND M-ADMIRE) (FATHER M-DISLIKE F-DISLIKE) (FATHER M-ADMIRE PER-MOSTFUN) (BEST-M-FRIEND BEST-F-FRIEND F-ADMIRE) (BEST-M-FRIEND F-DISLIKE PER-MOSTFUN) (BEST-M-FRIEND PER-ROMANCE ROLE-MODEL) (BEST-F-FRIEND M-ADMIRE F-ADMIRE) (M-DISLIKE F-DISLIKE PER-MOSTFUN) (M-DISLIKE PER-ROMANCE ROLE-MODEL) (M-ADMIRE F-ADMIRE PER-ROMANCE))      ALL-COMBOS-NOT-RETURNED

;; EVERY 100th FOR ALL QVARS ==========================
;;  (make-elmsym-compare-lists  :return-every-nth 100)
;; works= *ALL-ELMSYM-COMPARE-COMBOS    309    ((MOTHER FATHER BEST-M-FRIEND) (MOTHER BEST-M-FRIEND ANGLOS) (MOTHER M-DISLIKE CHURCH-MINISTER) (MOTHER M-ADMIRE HOUSE-CLEANER) (MOTHER PER-MOSTFUN MOVIE-STAR) (MOTHER ROLE-MODEL JEWS) (MOTHER CHILD-DISLIKE MOST-IMPORTANT-ABILITY) (MOTHER FAV-BOSS POLICEMAN) (MOTHER FAV-M-STAR PROTESTANTS) (MOTHER FAV-SPIRITUAL MANAGER) (MOTHER TEACHER YOUR-WORST-CHARACTERISTIC) (MOTHER LAWYER BUSINESS-OWNER) (MOTHER SCIENTIST CHURCH-MINISTER) (MOTHER DANCER MOVIE-STAR) (MOTHER HOUSE-CLEANER MOST-IMPORTANT-ABILITY) (MOTHER JEWS MOST-IMPORTANT-BELIEF)  ...   etc  --- (HOUSE-CLEANER MOST-IMPORTANT-VALUE YOUR-WORST-CHARACTERISTIC) (MOVIE-STAR MUSLIMS BLACKS) (ROCK-STAR CHURCH-MINISTER YOUR-PERSONALITY) (ROCK-STAR HISPANICS YOUR-PERSONALITY) (CHURCH-MINISTER BUDDHISTS HISPANICS) (CATHOLICS JEWS MOST-IMPORTANT-BELIEF) (PROTESTANTS JEWS HISPANICS) (PROTESTANTS YOUR-POSSESSIONS YOUR-WORST-CHARACTERISTIC) (MUSLIMS BUDDHISTS YOUR-PERSONALITY) (BUDDHISTS BLACKS ASIANS) (ANGLOS BLACKS ASIANS) (ASIANS MOST-IMPORTANT-VALUE MOST-IMPORTANT-ABILITY))     ALL-COMBOS-NOT-RETURNED







;;TEST ONLY
;; (Multiple-value-setq (*global-combos-sym *n-pc-combos *pc-combos *all-combos) (make-elmsym-compare-lists :return-every-nth 100))  ;;if *all-elmsyms nil, run (csq-initialize)
;;   (make-elmsym-compare-lists  :all-elmsyms  '(A B C D E F G H I J K L M N O P) :return-every-nth 5) 
;;  (make-elmsym-compare-lists  :all-elmsyms  '(A B C D E F G H I J K L M N O P) ) 
;; works= CSQ-ELMSYM-COMBOS    112    ((G L M) (F I O) (C L M) (D J L) (C D E) (B C K) (A C J) (A H J) (B K N) (C I L) (A D J) (D E G) (C E P) (H N P) (I K P) (B F J) (H K M) (C E F) (B D L) (A K L) (D H M) (C D L) (L N P) (B H M) (E H N) (A D I) (B F O) (H I K) (B D P) (I K L) (A G I) (H L P) (A C E) (C G P) (C J N) (A O P) (C J O) (A F I) (A C L) (A D L) (F G P) (A E K) (A B K) (C N P) (E M N) (D G J) (G H O) (A B M) (J K P) (D E J) (G I P) (B O P) (B K M) (A D N) (G M N) (E F K) (D K N) (F H P) (D G L) (I O P) (B F I) (D I J) (B E O) (F I P) (H J K) (A J M) (B E K) (E G J) (C D F) (B J K) (E F N) (H J M) (G M O) (G I L) (F H I) (B F N) (K M P) (B H P) (A J P) (C H K) (F G L) (A G J) (B D K) (B H K) (A F G) (H K O) (H I J) (A C O) (G H N) (D G O) (J L M) (B E N) (C E H) (E J M) (B I L) (A C M) (E H P) (C I J) (A B D) (F G I) (B C H) (K L P) (I J K) (K L M) (F J M) (C G I) (A C D) (E L M) (C E K) (F K L) (D G I) (B F P))            ((A B C) (A B D) (A B E) (A B F) (A B G) (A B H) (A B I) (A B J) (A B K) (A B L) (A B M) (A B N) (A B O) (A B P) (A C D) (A C E) (A C F) (A C G) (A C H) (A C I) (A C J) (A C K) (A C L) (A C M) (A C N) (A C O) (A C P)  etc.


;;  (make-elmsym-compare-lists) 
;;works for 4 elmsyms (doesn't find sample, too few)
;; CSQ-ELMSYM-COMBOS  4   ((MOTHER FATHER BEST-M-FRIEND) (MOTHER FATHER BEST-F-FRIEND) (MOTHER BEST-M-FRIEND BEST-F-FRIEND) (FATHER BEST-M-FRIEND BEST-F-FRIEND))    ((MOTHER FATHER BEST-M-FRIEND) (MOTHER FATHER BEST-F-FRIEND) (MOTHER BEST-M-FRIEND BEST-F-FRIEND) (FATHER BEST-M-FRIEND BEST-F-FRIEND))
;; also CL-USER 8 > CSQ-ELMSYM-COMBOS = ((MOTHER FATHER BEST-M-FRIEND) (MOTHER FATHER BEST-F-FRIEND) (MOTHER BEST-M-FRIEND BEST-F-FRIEND) (FATHER BEST-M-FRIEND BEST-F-FRIEND))

;; works= ((MOTHER FATHER BEST-M-FRIEND) (BEST-F-FRIEND M-DISLIKE F-DISLIKE) (M-ADMIRE F-ADMIRE PER-MOSTFUN) .....  (YOUR-PERSONALITY YOUR-BEST-CHARACRISTIC YOUR-POSSESSIONS) (YOUR-WORST-CHARACTERISTIC MOTHER FATHER))   21


;; *all-elmsyms
;; (make-combos '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20) 3);; (setf *all-combos (m;

;;  IF USE MAKE-COMBOS FOR ALL ELMSYMS, => COMBOS-N = 35990
;; (make-combos *all-elmsyms))
;; (setf *all-flat-combos (flatten-1-level *all-combos))
;; (list-length *flat-all-combos) = 35990

;; FOR MAKE-COMBOS ONLY WITHIN CATEGORIES
;; *PCE-PEOPLE  *PCE-GROUPS *PCE-SELF
;; (setf *pce-people-combos (flatten-1-level (make-combos *PCE-PEOPLE 3)))
;; (list-length *pce-people-combos) = 1771
;; (setf *pce-groups-combos (flatten-1-level (make-combos *PCE-GROUPS 3)));; (list-length *;;; (list-length *pce-groups-combos)  = 4495
;; (setf *pce-self-combos (flatten-1-level (make-combos *PCE-SELF 3)))
;; (list-length *pce-self-combos) = 35
;;
;;USING RANDOM-SELECTION
;; (setf *random-pce-people-combos (my-random-selection *pce-people-combos 10))
;; (list-length *random-pce-people-combos) = 178
;; (setf *random-pce-groups-combos (my-random-selection *pce-groups-combos 3))
;; (list-length *random-pce-groups-combos) = 135
;; (setf *random-pce-self-combos (my-random-selection *pce-self-combos 50))
;; (list-length *random-pce-self-combos) = 18

;; (multiple-value-setq (*TEST-return-combos *TEST-n-combos *TEST-global-combos-sym *TEST-all-combos)       (make-combos *all-elmsyms  3 :global-combos-sym 'global-combos-sym     :return-all-combos-p T            :random-sample-percent  100    :randomize-p   T      :return-all-combos-p T   :prefix "" :postfix ""  ))


;;SSS START HERE MAKE FUNCTION TO MAKE 3s of each category??
;;EVERY  20th FOR EACH OF 3 QVAR GROUPS/SETS
;;  (make-elmsym-compare-lists :all-elemsyms   :return-every-nth 20)
;; (get-category-qvars 'pce-people)



;;MAKE-ELMSYMS-FROM-DATALIST
;;
;;ddd
(defun make-elmsyms-from-datalist (datalist 
                                    &key (set-elmsym-to-vals-p T) (elmsym-key :elmsym-lists))
  "In U-CS. For restoring elmsyms from a partially-completed CSQ from *CSQ-elmsym-lists. DOES NOT RESTORE CSYM at this time."
  (let
      ((elmsym-lists (get-key-values elmsym-key datalist))
       (elmsymvals)
       )

    (loop
     for elmlist in elmsym-lists
     do
     (when elmlist
       (setf elmsym (car elmlist)
             elmsymvals (second elmlist)
             elmsyms (append elmsyms (list elmsym)))
       ;;end when
       )

     (when set-elmsym-to-vals-p
       (set elmsym elmsymvals))

     ;;end loop
     ) 
    elmsyms
    ;;end let, make-elmsyms-from-datalist
    ))
;;SSS TEST WHEN HAVE A DATA-LIST
;; 






;;MAKE-MIXED-COMBOS-FOR-PCE-CATS -- WORKS, BUT NOT USED
;;   USE *all-elmsyms INSTEAD OF CATS
;;
;;ddd 
#|(defun make-mixed-combos-for-pce-cats (pce-cat-global-syms 
                                &key (random-sample-percent 10)
                                                   (randomize-p T) return-all-combos-p
                                                   (prefix "") (postfix "-combos")
                                                   cat-combo-global-sym
                                                   (randomize-min-combo-n 20)
                                                   )
  "In U-CS, creates combo-lists of 3 elements and can return a randomized sample of random-sample-percent of the total. RETURNS  If return-all-combos-p, (values cat-global-sym randomized-combos cat-combos) otherwise, (values cat-global-sym randomized-combos). When LISTP pce-cat-global-syms, combine symlists into one large list--so resultant combos are a mix of all cats."
  (let
      ((randomized-combos)
       (n-combos)
       (syms)
       (qsyms)
       (all-qsyms)
      (qnames)
       (all-combos)
       (new-cat-combo-global-sym)
       )

    ;;FIND THE pce-cat-global-syms
    (cond
     ((listp pce-cat-global-syms) 
      (loop 
       for cat in pce-cat-global-syms
       do
       (cond
        ((boundp cat)
         (setf qsyms (eval cat)))
        (t
         (setf qnames (get-category-qvar-names cat)    
               qsyms (find-symbols-for-names qnames))))
           (break "0")
       (setf all-qsyms (append all-qsyms qsyms))
       ;;end loop
       )
      ;;(setf pce-cat-global-syms syms)
      )
     (t (setf all-qsyms (eval pce-cat-global-sym))))
    (break "2 all-qsyms")

    ;;MAKE THE COMBOS
    (setf all-combos (flatten-1-level (make-combos  all-qsyms 3))
          n-combos (list-length all-combos))   
    (break "3")
   
      
      ;;RANDOM SELECT COMBOS FROM EACH CATEGORY?
      (cond
       ((and  randomize-p (> n-combos randomize-min-combo-n))
        (setf return-combos 
              (my-random-selection all-combos random-sample-percent))
        )
       (t (setf return-combos all-combos)))

      ;;SET A cat-combo-global-sym TO THE RETURN-COMBOS?
      (when cat-combo-global-sym
        (setf new-cat-combo-global-sym (my-make-symbol 
                                        (format nil "~A~A~A" prefix  cat-combo-global-sym postfix)))
        (set new-cat-combo-global-sym return-combos))

       (values  return-combos  n-combos new-cat-combo-global-sym)
      ;;end let, make-mixed-combos-for-pce-cats
      ))|#
;;TEST
;; (make-mixed-combos-for-pce-cats '(PCE-PEOPLE PCE-GROUPS PCE-SELF))
;; works= ((MOTHER FATHER BEST-M-FRIEND) (MOTHER FATHER BEST-F-FRIEND) (MOTHER BEST-M-FRIEND BEST-F-FRIEND) (FATHER BEST-M-FRIEND BEST-F-FRIEND))   4   NIL
;; set a new-cat-combo-global-sym
;; (make-mixed-combos-for-pce-cats '(PCE-PEOPLE PCE-GROUPS PCE-SELF) :cat-combo-global-sym 'test-gsym)
;; works= ((MOTHER FATHER BEST-M-FRIEND) (MOTHER FATHER BEST-F-FRIEND) (MOTHER BEST-M-FRIEND BEST-F-FRIEND) (FATHER BEST-M-FRIEND BEST-F-FRIEND))   4   TEST-GSYM-COMBOS
;;CL-USER 7 > TEST-GSYM-COMBOS =  ((MOTHER FATHER BEST-M-FRIEND) (MOTHER FATHER BEST-F-FRIEND) (MOTHER BEST-M-FRIEND BEST-F-FRIEND) (FATHER BEST-M-FRIEND BEST-F-FRIEND))





#|  ;;MAKE-COMBOS-FOR-PCE-CATS  -- NOT CURRENTLY BEING USED
;;
;;ddd 
(defun make-combos-for-pce-cats (pce-cat-global-syms  
                                 &key (random-sample-percent 10)
                                 (randomize-p T) return-all-combos-p
                                 (prefix "") (postfix "-combos"))
  "In U-CS, creates combo-lists of 3 elements and can return a randomized sample of random-sample-percent of the total. RETURNS  If return-all-combos-p, (values cat-global-syms randomized-combos cat-combos n-combos) otherwise, (values cat-global-syms randomized-combos n-combos). Sets each sublist to a global variation of the gloval var subcat set to."
  (let
      ((cat-combos)
       (cat-global-sym)
       ;;IF USE GLOBAL SYMS?(pce-cat-global-syms (eval pce-cat-global-sym))
       (randomized-combos)
       (n-combos)
       (return-combos)
       )
    (loop
     for catsym in pce-cat-global-syms
     do
     (multiple-value-setq (cat-global-sym randomized-combos cat-combos) 
         ;;USE GLOBAL VARS ABOVE HERE?
         (make-combos-for-pce-cat catsym
                                  :random-sample-percent random-sample-percent
                                  :randomize-p randomize-p
                                  :return-all-combos-p return-all-combos-p
                                  :prefix prefix :postfix postfix))

     ;;end loop
     )

#|    (setf  (+ *n-people-combos *n-group-combos *n-self-combos)
          *all-elmsyms-comparisons (append *random-people-elmsym-combos
           *random-groups-elmsym-combos  *random-self-elmsym-combos))|#

    (setf *n-elmsym-combos (list-length randomized-combos))

    ;;end let, make-combos-for-pce-cats
    ))
|#



;;GET-EXISTING-ELMSYM-COMBOS
;;
;;ddd
(defun get-existing-elmsym-combos (global-combos-sym
                                  ;;normally  '*all-elmsym-compare-combos
                                   &key
                                   (combos *all-elmsym-compare-combos)
                                   (all-elmsyms *all-elmsyms)
                                   (find-in-file-p T)
                                   (pathname  "C:\\3-TS\\LISP PROJECTS TS\\CogSys-Model\\csq-permdata.lisp"))
  "In U-CS, gets an elmsym-combo-list and processes it for use by CSQ-Manager, etc. RETURNS (values global-combos-sym n-combos return-combos ) Also SETS global-combos-sym to the return-combos list."
  (let
      ((return-combos)
       (n-combos 0)
       )
    (cond
     (find-in-file-p
      (setf return-combos 
            (find-global-variable-in-file global-combos-sym pathname)))

     (t (setf return-combos combos)
      (set global-combos-sym combos)))

    (setf n-combos (list-length return-combos))

    (values global-combos-sym  return-combos n-combos) 
    ;;end let, get-existing-elmsym-combos
    ))
;;TEST
;; (makunbound '*test-elmsym-4combos)
;;  (get-existing-elmsym-combos  '*test-elmsym-4combos)
;;works= *TEST-ELMSYM-4COMBOS    ((MOTHER FATHER BEST-M-FRIEND) (MOTHER FATHER BEST-F-FRIEND) (MOTHER BEST-M-FRIEND BEST-F-FRIEND) (FATHER BEST-M-FRIEND BEST-F-FRIEND))    4



;;SAVE-CSQ-DATA-TO-FILE
;;
;;ddd
(defun save-csq-data-to-file (file &key 
                                   (dirpath *csq-save-all-dirpath)
                                   ;;"C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\")
                                   (csq-elmsym-lists *csq-elmsym-lists)
                                   (csq-data-list *csq-data-list)
                                   (csq-value-ranking-lists *all-ordered-values-ratings-lists)
                                   set-csq-symbols-to-data-p
                                   (save-cs-explore-data-p T)
                                   )                                   
  "In U-CS, Saves all CSQ data to a file. "
  (let
      ((pathname (format nil "~A~A" dirpath file))
       (pcsym-elm-lists (get-keyvalue-in-nested-list '((:PCSYM-ELM-LISTS T))  csq-data-list))
       (date (my-get-date-time))
       )
    (multiple-value-bind (pcsymval-lists pcsyms)
                (make-pcsymval-lists :all-datalists csq-data-list)

    (multiple-value-bind (elmsymval-lists elmsyms n-elmsyms)
        (get-elmsymval-lists :elmsyms *all-elmsyms)    

   ;;UPDATE THE *all-PCqvar-lists (probably modified after initially created)
   (setf *all-PCqvar-lists NIL)
   (loop
    for pcqvar-str in *all-PCqvars
    do
    (setf *all-PCqvar-lists (append *all-PCqvar-lists
                                    (list (eval (my-make-symbol pcqvar-str)))))
    ;;end loop
    )
   ;;OPEN FILE STREAM
      (with-open-file (out pathname :direction :output :if-exists :append
                           :if-does-not-exist :create)
      (format out ";;FOR DATE: ~S~%;; ELMSYMS=~% (setf *file-elmsyms  '~S)~%;;ELMSYMVALS= ~%  (setf *file-elmsymvals  '~S)~%;;PCSYMS= ~% (setf *file-pcsyms  '~S)~%;;PCSYMVAL-LISTS= ~% (setf *file-pcsymval-lists '~S)~%;;*CSQ-DATA-LIST=~% (setf *file-csq-data-list '~S)~% ~%;;FOR CREATING:~%;;*ALL-PC-ELEMENT-QVARS=~%  (setf *file-all-pc-element-qvars  '~S)~%;;*ALL-PCQVAR-LISTS=~% (setf *file-all-pcqvar-lists '~S)~%;;*ALL-CSQ-VALUE-RANKING-LISTS=~% (setf *file-all-csq-value-ranking-lists '~S)~% " date elmsyms elmsymval-lists  pcsyms  pcsymval-lists *csq-data-list *all-pc-element-qvars  *all-pcqvar-lists csq-value-ranking-lists )
    ;;SAVE CS-EXPLORE DATA?
    ;;get and format data
    (when (and save-cs-explore-data-p *ALL-CSDB-SUBSYMS)
      (multiple-value-bind (formated-db-subsyms-data  
                            formated-explore-csyms-data) 
          ;;not needed? db-subsyms-data explore-csyms-data)
          (get-all-cs-explore-data :csdb-subsyms *ALL-CSDB-SUBSYMS
                                   :cs-explore-stored-csyms *ALL-STORED-CSYMS
                                   :return-data-p NIL)
        ;;write to file
        (format out "~%~A~%~A~%" formated-db-subsyms-data
                formated-explore-csyms-data)
        ))
      ;;end with-
      )
    (values elmsyms pcsyms *all-csq-data-list-syms)
    ;;end let, mvb,mvb, save-csq-data-to-file
    ))))
;;TEST
;;  (save-csq-data-to-file "csq-output-test1.lisp")



;;READ-SAVED-CSQ-DATA
;;
;;ddd
(defun read-saved-csq-data (file &key (set-csq-symbols-to-data-p T)
                                 (eval-objects-p  T)                              
                                 (all-data-list-syms *all-csq-data-list-syms)
                                 (file-data-syms '(*file-elmsyms *file-elmsymvals *file-pcsyms 
                                                                 *file-pcsymval-lists *file-csq-data-list
                                                                 *file-all-pc-element-qvars 
                                                                 *file-all-pcqvar-lists))
                                 ;;not needed (determine-starting-point-p T)
                                 (dirpath "C:\\3-TS\\LISP PROJECTS TS\\CogSysOutputs\\"))
  "In U-CS, Reads in CSQ data and sets to (format out *file-elmsyms *file-elmsymvals *file-pcsyms  *file-pcsymval-lists *csq-data-list. If EVAL-OBJECTS-P, sets car of lists to list[Each begins with *file-].  SET-CSQ-SYMBOLS-TO-DATA-P set regular csq symbols to the data in the file also. Otherwise the word '*file-' precedes the symbol. [Can also later set csq data to '*file- symbol.]  Reads ONLY FIRST 5 OBJECTS IN FILE. When DETERMINE-STARTING-POINT-P , uses data to set where to start rest of CSQ."
  (let
      ((pathname (format nil "~A~A" dirpath file))
       (object)
       (object-list)
       (elmsym)
       )
    ;;RESET GLOBAL VARS
       ;;(*ELMSYMS *ELMSYMVALS *PCSYMS *PCSYMVAL-LISTS *CSQ-DATA-LIST *ALL-PC-ELEMENT-QVARS *ALL-PCQVAR-LISTS)
       (when all-data-list-syms
         (loop
          for sym in all-data-list-syms
          do
          (set sym nil))
         ;;end when
         )
       (when file-data-syms
         (loop
          for sym in file-data-syms
          do
          (set sym nil))
         ;;end when
         )
          
  (with-open-file ( in pathname :direction :input)
    (loop
     ;;for object-n from 1 to (list-length all-data-list-syms)
     for sym in  all-data-list-syms
     do
     (setf object (read in)
           object-list (append object-list (list object)))
     ;;(break "object 1")
     (when (and eval-objects-p (listp object)(equal (car object) 'setf))
      (eval object))
       ;;(break "object 2")
     (when set-csq-symbols-to-data-p
       (set sym (eval (second object))))
       ;;end loop
     )
    ;;end with-
    )

  ;;EVAL THE  INNER CONTENTS OF SOME LISTS--IF EXIST
;;*ALL-CSQ-DATAFILE-VARS = (*file-all-pc-element-qvars *file-all-pcqvar-lists *file-csq-data-list          *file-elmsyms *file-elmsymvals *FILE-PCSYMS *file-pcsymval-lists)
  (when *FILE-ELMSYMS
    (setf  *all-elmsyms *file-elmsyms))
  (when *FILE-ELMSYMVALS
    (loop
     for list in *file-elmsymvals    
     do
     (setf elmsym (my-make-symbol (car list)))
     (set elmsym list)
     )
    ;;end when
    )
  ;;NOTE: *file-elmsymvals set above 

 ;;NOTE: *FILE-PCSYMS not needed--the pcsyms are set to the pcsymval-lists below
  (when *FILE-PCSYMVAL-LISTS
    (loop
     for list in *file-pcsymval-lists
     do
     (set (car list) (second list))
     )
    ;;end when
    )
  (when *FILE-CSQ-DATA-LIST
    (setf *csq-data-list *file-csq-data-list))
  (when *FILE-ALL-PC-ELEMENT-QVARS
      (setf *ALL-PC-ELEMENT-QVARS *file-all-pc-element-qvars))
  (when *FILE-ALL-PCQVAR-LISTS
    (setf *ALL-PCQVAR-LISTS *file-all-pcqvar-lists))
  
  ;;WHERE TO START CSQ? DONE IN CSQ-CHOICE-FRAME
  ;;SSS REFINE LATER, SO AUTO STARTS WHERE USER LEFT OFF?

#|  (when determine-starting-point-p
    (cond
     ;;ADD ALT FOR AFTER HAVE ADDED VALUES
     (*file-all-pcqvar-lists
      (setf  *csq-begin-step 'find-pc-values 
             *run-begin-with-find-pcs-p NIL *run-complete-csq-p NIL))
     (*file-elmsymvals
      (setf  *run-begin-with-find-pcs-p T *run-complete-csq-p NIL ))
     (t (setf *run-complete-csq-p T)))
    ;;(break "begin")
    ;;end when
    )|#
  object-list
  ;;end let, read-saved-csq-data
  ))
;;TEST
;;  (read-saved-csq-data "CSQ-TomShortTest.lisp")
;;  (read-saved-csq-data "csq-output-temp-old.lisp")
;;  (read-saved-csq-data "TOM-CSQ-PT1.LISP")
;; works
;;  (read-saved-csq-data "Tom-AllData2017-01-copy.lisp"  :set-csq-symbols-to-data-p T )
;;
;;  (read-saved-csq-data "csq-output-test1.lisp" :set-csq-symbols-to-data-p T )
;; works= seems to.. all above symbols eval to what appears ok
;;  also CL-USER 90 > MOTHER =  ("MOTHER" "mother" ELM2-1-1-99 NIL NIL :BIPATHS (((MOTHER NIL (CAREFOROTHERS (POLE1) NIL))) ((MOTHER NIL (INTIMATE (POLE1) NIL))) ((MOTHER NIL (FLEXIBLE (POLE1) NIL))) ((MOTHER NIL (CASUAL (POLE1) NIL))) ((MOTHER NIL (EGOTISTICAL (POLE2) NIL))) ((MOTHER NIL (EXUBERANT (POLE2) NIL))) ((MOTHER NIL (NOTTHEORIST (POLE1) NIL))) ((MOTHER NIL (LOVEX (POLE1) NIL))) ((MOTHER NIL (LOVEDANCE (POLE1) NIL))) ((MOTHER NIL (HELPINGCAREER (POLE2) NIL))) ((MOTHER NIL (HIGHIMPACT (POLE2) NIL)))))
;; AND CL-USER 91 > MATERIALISTIC = ("MATERIALISTIC" "MATERIALISTIC vs NOT MATERIALISTIC" CS2-1-1-99 NIL NIL :PC ("MATERIALISTIC" "NOT MATERIALISTIC" 2 NIL) :POLE1 "MATERIALISTIC" :POLE2 "NOT MATERIALISTIC" :BESTPOLE 2 (:BIPATHS ((POLE1 NIL SALESPERSON NIL) (POLE1 NIL ANGLOS NIL) (POLE2 NIL BUDDHISTS NIL))))


;;  CL-USER 47 > *FILE-PCSYMS = (A4 B7 C0 D4)              
;; CL-USER 48 > *FILE-ELMSYMS = (MOTHER FATHER BEST-M-FRIEND BEST-F-FRIEND)
;; ALSO:
;; ;;CL-USER 1 > mother  = ("MOTHER" "mother" ELM2-1-1-99 NIL NIL :BIPATHS (((MOTHER NIL (A4 (POLE2) NIL))) ((MOTHER NIL (B7 (POLE2) NIL))) ((MOTHER NIL (C0 (POLE2) NIL)))))













;;RANK-BY-PC-VALUES
;;
;;ddd
(defun rank-by-pc-values (&key (csqdatalist *csq-data-list)
                               (sort-list-p T) (return-only-sorted-p T) (reduce-duplicates-p T))
  "U-CS.lisp, Input *csq-data-list; RETURNS (values sorted-pc-value-lists pc-value-list) where each list is (pc value) . return-only-sorted-p only works if sorted."
  (let
      ((pc-value-list)
       (pc-value-lists)
       (pc-val-only-list)
       (pc-val-only-lists)
       (sorted-pc-value-lists)
       (sorted-pc-val-only-lists)
       (pc)
       (pcbest)
       (value)
       (bestpole)
       (pole1)
       (pole2)
       )
    (loop
     for pclist in (second csqdatalist)
     do
     (setf pc (car pclist)
           value (fifth (fourth (second pclist)))
           bestpole (get-keyvalue-in-nested-list '((:bestpole T 1))  (eval pc))
           pole1 (get-keyvalue-in-nested-list '((:pole1 T 1)) (eval pc))
           pole2 (get-keyvalue-in-nested-list '((:pole2 T 1)) (eval pc))
           pc-val-only-list (list pc value)
           pc-val-only-lists (append pc-val-only-lists (list pc-val-only-list)))

     (cond
      ((= bestpole 1)
       (setf  pc-value-list (list pole1 pole2 value pc)))
      ((= bestpole 2)
       (setf  pc-value-list (list pole2 pole1 value pc))
       ))

     (setf pc-value-lists (append pc-value-lists (list  pc-value-list)))

     ;;end loop
     )
    (cond
     (sort-list-p
      (setf sorted-pc-value-lists (my-sort-lists 2 pc-value-lists :descending-p T 
                                                 :reduce-duplicates-p reduce-duplicates-p)
            sorted-pc-val-only-lists (my-sort-lists 2 pc-val-only-lists :descending-p T 
                                                    :reduce-duplicates-p reduce-duplicates-p))
      (cond
       (return-only-sorted-p
        (values sorted-pc-value-lists  sorted-pc-val-only-lists))
       (t
        (values sorted-pc-value-lists pc-value-lists pc-val-only-lists))))
     (t (values pc-value-lists pc-val-only-lists)))

    ;;end let, rank-by-pc-values
    ))
;;TEST
;; (setf *ranked-pcs-by-values  (rank-by-pc-values :reduce-duplicates-p T))
;; (rank-by-pc-values :sort-list-p nil )
;;   (setf *test-csq-data-list '(:PCSYM-ELM-LISTS ((CAREFOROTHERS (MOTHER FATHER BEST-M-FRIEND (CAREFOROTHERS CAREFOROTHERS :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12) (CAREFOROTHERS CAREFOROTHERS :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12) (CAREFOROTHERS CAREFOROTHERS :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12))) (INTIMATE (MOTHER BEST-M-FRIEND BEST-F-FRIEND (INTIMATE INTIMATE :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) ))) ..etc


;;MAKE-CSQ-RESULTS-TREE-FRAMES
;;2017
;;ddd
(defun make-csq-results-tree-frames (pathname &key  expand-all
                                              (csq-treeview-datalists *csq-treeview-data-lists) 
                                              (make-sorted-pc-values-frame-p T)
                                              (incf-init-y 70)
                                              (init-y 20) (min-treeview-pane-height 820))
  "In   Makes   treeview list frames INPUT:  If pathname=NIL, evals the data variables without reading file.  If expand-all 'ALL, expands all nodes, if 'NONE, expands none, if NIL, up to individual arg list."
;;*file-elmsymvals *file-pcsymval-lists *file-csq-data-list *file-all-pc-element-qvars *file-all-pcqvar-lists *file-pcsyms *file-elmsyms
;; *csq-treeview-data-lists = ((:DATASYM *FILE-CSQ-DATA-LIST :FRAME-ARGS (:EXPANDP 99 :TITLE "CSQ-DATA-LIST-ARGS" :WIDTH 500)) (:DATASYM *FILE-ELMSYMVALS :FRAME-ARGS (:EXPANDP 99 :TITLE "CSQ ELMSYMVALS" :WIDTH 500)) (:DATASYM *FILE-PCSYMVAL-LISTS :FRAME-ARGS (:EXPANDP 99 :TITLE "CSQ PCSYMVAL-LISTS" :WIDTH 450)) (:DATASYM *FILE-ELMSYMS :FRAME-ARGS (:EXPANDP 1 :TITLE "CSQ ELMSYMS" :WIDTH 300)))
  (let
      ((eval-file-syms-p)
       (init-y 10)       
       )
    (when pathname (setf eval-file-syms-p T)
      (read-saved-csq-data pathname :set-csq-symbols-to-data-p eval-file-syms-p
                           :eval-objects-p eval-file-syms-p))
    (loop
     for datalist in  csq-treeview-datalists
     do
     (when (and datalist  (listp datalist))
       (let*
           ((datasym (get-key-value :datasym datalist) )
            (frame-args (get-key-value :frame-args datalist))
            (expandp (get-key-value :expandp frame-args))
            (title (get-key-value :title frame-args))
            (min-width (get-key-value :width frame-args))
            (sym-datalist (eval datasym))
            (group-by-val-p (get-key-value :group-by-val-p frame-args))
            (order-by-rank-p  (get-key-value :order-by-rank-p frame-args) )
            )
         (unless min-width
           (setf min-width 500))

         (cond
          ((equal expand-all 'ALL)
           (setf expandp T))
          ((equal expand-all 'NONE)
           (setf expandp NIL)))

         ;;MAKE THE TREE
         (make-treeview-frame sym-datalist :frame-title title :expand-tree-p expandp
                              :initial-y init-y :min-treeview-pane-height min-treeview-pane-height 
                              :min-treeview-pane-width min-width
                              :group-by-val-p group-by-val-p :order-by-rank-p order-by-rank-p)     
     
         (setf init-y (+ incf-init-y init-y))
         ;;end let,when,loop
         )))
    (when make-sorted-pc-values-frame-p
      (sort-pcs-by-value  :return-list-p NIL))
    ;;end let, make-csq-results-tree-frames
    ))
;;TEST
;;  (make-csq-results-tree-frames  NIL)
;;SSSS make-csq-results-tree-frames here
;; (make-csq-results-tree-frames  "Tom-AllData2017-01-copy.lisp")
;; WORKS: Produces 7 or 8 expanded treeview frames







;;SORT-PCS-BY-VALUE&RANK
;;2018-02
;;ddd
(defun sort-pcs-by-value&rank (pcsyms &key (groupkey :csval)(sortkey :csrank)
                                    (datalist *csq-data-list)
                                  return-unsorted-list-p (make-treeview-p T)
                                  (rank-within-values-p T) splice-matched-lists-p 
                                  only-group-numbers-p (only-sort-numbers-p t) 
                                ascending-p  (descending-p T) (return-list-p T))
  "In  U-CS, PREFERRED function to sort pcs by values (and ranks within same value) and to make a treeview list of them.  Only uses datalist if no pcsyms list. RETURNS    INPUT:  "
  (let
      ((unsorted-lists)
       (sorted-lists)
       (pcsym-elm-list)
       (use-syms-p)
       )
  (cond
   ((and pcsyms (listp pcsyms) (boundp (car pcsyms)) )
    (setf use-syms-p T))
   ;;find pcsyms from datalist & see if the pcsyms are bound
   ((and (setf pcsyms (nth-value 1 (make-pcsymval-lists datalist)))
         (boundp (car pcsyms))) 
        (setf use-syms-p T))
   ;;otherwise just use the older function
   (t      
    (multiple-value-setq (sorted-lists unsorted-lists)
        (sort-pcs-by-value-from-csq-data-list :csq-data-list datalist
                                              :return-list-p return-list-p
                                              :return-unsorted-p return-unsorted-p
                                              :ascending-p ascending-p :descending-p descending-p))))

  (when use-syms-p
    (loop
     for pcsym in pcsyms
     do
     (let*
         ((pcsymvals (eval pcsym))
          (pc-rating (get-key-value groupkey pcsymvals))
          (pc-rank (get-key-value sortkey pcsymvals))
          (sortlist)
          )
       (cond
        (pc-rank
         (setf sortlist (list pcsym pc-rating pc-rank)))
        (t  (setf sortlist (list pcsym pc-rating))))

       ;;append
       (setf unsorted-lists (append unsorted-lists (list sortlist)))
       ;;end llet,loop
       ))

    (break "unsorted-lists")
    ;;GROUP/SORT THE LISTS
      (setf sorted-lists 
            (group-lists-by-nths 1 unsorted-lists :group-matched-lists-p 
                                (null splice-matched-lists-p)))

            #|(group-keylists-by-keyvalues groupkey unsorted-lists  :sortkey sortkey
                                         :splice-matched-lists-p splice-matched-lists-p 
                                         :only-group-numbers-p only-group-numbers-p
                                         :only-sort-numbers-p only-sort-numbers-p
                                         :ascending-p ascending-p :descending-p descending-p)|#
    ;;(break "sorted-lists")
    ;;end when  use-syms-p
    )

    (when make-treeview-p
      (make-treeview-frame sorted-lists :frame-title "PCSYMS SORTED BY VALUES"
                           :min-treeview-pane-width 300))
    (cond
     (return-unsorted-list-p 
      (values  sorted-lists unsorted-lists))
     ((null return-list-p)
      NIL)
     (t sorted-lists))
    ;;end let, sort-pcs-by-value&rank
    ))
;;TEST
;; (sort-pcs-by-value&rank *pcsyms)




;;SORT-PCS-BY-VALUE-FROM-CSQ-DATA-LIST
;;2017
;;ddd
(defun sort-pcs-by-value-from-csq-data-list (  &key  (csq-data-list *file-csq-data-list )
                                  return-unsorted-list-p (make-treeview-p T)
                                  (descending-p T) (return-list-p T))
  "In U-CS NON-PREFERRED way to sort pcvals and make a treeview frame, but can be made from only csq-data-list.  RETURNS (values  sorted-lists unsorted-lists) if  return-unsorted-list-p"
  (let
      ((unsorted-lists)
       (sorted-lists)
       (pcsym-elm-list (get-keyvalue-in-nested-list '((:PCSYM-ELM-LISTS 0)) csq-data-list))
       )
    (loop
     for pclist in pcsym-elm-list
     do
     (let*
         ((pcsym (car pclist))
          (pc-rating (nth 4 (fourth (second pclist))))
          (sortlist (list pcsym  pc-rating))
          )
       (setf unsorted-lists (append unsorted-lists (list sortlist)))
       ;;end llet,loop
       ))
    (setf sorted-lists (my-sort-lists 1 unsorted-lists  :descending-p descending-p))

    (when make-treeview-p
      (make-treeview-frame sorted-lists :frame-title "PCSYMS SORTED BY VALUES"
                           :min-treeview-pane-width 300))

    (cond
     (return-unsorted-list-p 
      (values  sorted-lists unsorted-lists))
     ((null return-list-p)
      NIL)
     (t sorted-lists))
    ;;end let, sort-pcs-by-value-from-csq-data-list
    ))
;;TEST
;; (sort-pcs-by-value-from-csq-data-list  :return-list-p NIL)





;;GET-SET-DELETE-APPEND-CSQ-DATA-LIST
;;2018-01-20
;;ddd
(defun get-set-delete-append-csq-data-list (listkey key value &key (datalist *csq-data-list) 
                                                     (keyloc-n 99)(val-nth 1) update-csq-data-list-p
                                   append-value-p list-first-item-in-append-p add-value-p 
                                   splice-newvalue-at-nth-p key-in-prev-keylist-p 
                                   (test (quote my-equal)) return-list-p key=list-p 
                                   put-key-after-items put-value-after-items 
                                   new-begin-items new-end-items splice-key-value-in-list-p 
                                   splice-old-new-values-p parens-after-begin-items-p (return-nested-list-p t) 
                                   (max-list-length 1000) if-not-found-append-key-value-p
                                   return-all-values-p)  
  "In U-CS.lisp, In keylist for listkey, finds or adds key, get, set, delete, appends it. If (null return-all-values-p) RETURNS (values  return-keylist new-return-nested-lists) OTHERWISE RETURNS (values return-keylist new-return-nested-lists new-keylist return-value  old-keylist last-key-found-p ) Uses get-set-append-delete-keyvalue-in-nested-list"
  ;;modify data-list
  (multiple-value-bind (return-keylist new-return-nested-lists new-keylist return-value  
                                       old-keylist last-key-found-p )
      (get-set-append-delete-keyvalue-in-nested-list value 
                                                     (list (list listkey T)(list key keyloc-n val-nth))
                                                     datalist
                                                     :add-value-p T :append-value-p nil
                                                     :key-in-prev-keylist-p T
                                                     :if-not-found-append-key-value-p NIL
                                                     :list-first-item-in-append-p  list-first-item-in-append-p
                                                     :splice-newvalue-at-nth-p  splice-newvalue-at-nth-p
                                                     :test test         :return-list-p return-list-p  
                                                     :put-key-after-items put-key-after-items
                                                     :put-value-after-items put-value-after-items
                                                     :new-begin-items new-begin-items :new-end-items new-end-items
                                                     :splice-key-value-in-list-p splice-key-value-in-list-p
                                                     :splice-old-new-values-p splice-old-new-values-p
                                                     :parens-after-begin-items-p parens-after-begin-items-p  
                                                     :return-nested-list-p return-nested-list-p
                                                     :max-list-length max-list-length
                                                     :if-not-found-append-key-value-p if-not-found-append-key-value-p)

    ;;("NICE" "nice vs nnice" CS2-1-1-99 NIL NIL :PC ("nice" "nnice" 1 NIL) :POLE1 "nice" :POLE2 "nnice" :BESTPOLE 1 :BIPATHS ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)))
    ;; *quest-- (HON HON :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12)

    ;;SET MODIFIED *CSQ-DATA-LIST
    (when update-csq-data-list-p
      (setf *csq-data-list new-return-nested-lists))

  (cond
   (return-all-values-p
    (values return-keylist new-return-nested-lists new-keylist return-value  
            old-keylist last-key-found-p ))
   (t (values  return-keylist new-return-nested-lists)))
  ;;end mvb, get-set-delete-append-csq-data-list
  ))
;;TEST
;; (setf *test-csq-data-list '(:PCSYM-ELM-LISTS ((KIND1 (MOTHER FATHER BEST-M-FRIEND)) (FEM4 (MOTHER BEST-M-FRIEND BEST-F-FRIEND)) (UNDERST (MOTHER BEST-F-FRIEND FATHER))))                           kind1 '("KIND1" "kind vs ukind" CS2-1-1-99 NIL NIL :PC ("kind" "ukind" 1 NIL) :POLE1 "kind" :POLE2 "ukind" :BESTPOLE 1 :BIPATHS ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)) :CSVAL "0.917")                FEM4 '("FEM4" "fem vs male" CS2-1-1-99 NIL NIL :PC ("fem" "male" 0 NIL) :POLE1 "fem" :POLE2 "male" :BESTPOLE 0 :BIPATHS ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL BEST-M-FRIEND NIL)) :CSVAL "0.833")               UNDERST   '("UNDERST" "underst vs nunders" CS2-1-1-99 NIL NIL :PC ("underst" "nunders" 1 NIL) :POLE1 "underst" :POLE2 "nunders" :BESTPOLE 1 :BIPATHS ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-F-FRIEND NIL) (POLE2 NIL FATHER NIL)) :CSVAL "0.917"))
;; (get-set-delete-append-csq-data-list 'underst :newkey 'newvalue :datalist *test-csq-data-list)
;; works = (UNDERST (MOTHER BEST-F-FRIEND FATHER) :NEWKEY NEWVALUE)                 (:PCSYM-ELM-LISTS ((KIND1 (MOTHER FATHER BEST-M-FRIEND)) (FEM4 (MOTHER BEST-M-FRIEND BEST-F-FRIEND)) (UNDERST (MOTHER BEST-F-FRIEND FATHER) :NEWKEY NEWVALUE)))




;;GET-SCALE-SLOT-VALUES
;;2019
;;ddd
(defun get-scale-slot-values (scale &key (return-values-p T) 
                                  (most-scale-info-p T) label-p name-string-p description-p
                                  mean-score-p num-questions-p scale-questions-p)
  "In U-cs, Finds designated CSQ SCALES standard slot-values. RETURNS (values name-string label  description num-questions  scale-questions mean-score scale-inst-sym scale-inst).  
       IF (null return-values-p) RETURNS (values scale-info-list scale-inst-sym), a key list with key for each value returned (selected by keys in arg). TIP: use :return-list-p to get only 1 or 2 values.NOTE: scale can be a symbol, string, or scale-instance"
  (let*
      ((scale-inst-sym) 
       (scale-inst) 
       (scale-info-list) 
       (label)
       (name-string)
       (description)
       (mean-score)
       (num-questions)
       (scale-questions)
       )
    ;;(break "HERE")
   (cond
     ;;IF SCALE IS A SYMBOL OR STRING
     ((or (symbolp scale) (stringp scale))
      (setf scale-inst-sym (my-make-symbol (format nil "*~A-inst" scale)))
      ;;(break "2")
                                          (setf  scale-info-list (list scale-inst-sym)
                                           scale-inst (eval scale-inst-sym)))
     ;;IF SCALE IS A SCALE INSTANCE
     (t (setf scale-inst scale
              scale-name (slot-value scale-inst 'name-string)
         scale-inst-sym (my-make-symbol (format nil "*~A-inst" scale-name)
                scale-info-list (list scale-inst-sym)))))
    ;;WHICH PARTS TO RETURN?
    (when (or name-string-p most-scale-info-p)
      (setf name-string (slot-value  (eval scale-inst) 'name-string)
            scale-info-list (append scale-info-list (list :name-string name-string))))
    (when (or label-p most-scale-info-p)
      (setf label (slot-value (eval  scale-inst) 'label)
            scale-info-list (append scale-info-list (list :label label))))
    (when (or description-p most-scale-info-p)
      (setf description (slot-value (eval  scale-inst ) 'description)
            scale-info-list (append scale-info-list (list :description description))))
    (when (and (or mean-score-p most-scale-info-p)
               (slot-exists-p  (eval scale-inst) 'mean-score))
      (setf mean-score (slot-value (eval  scale-inst ) 'mean-score)
            scale-info-list (append scale-info-list (list :mean-score mean-score))))
    (when (or num-questions-p most-scale-info-p)
      (setf num-questions (slot-value (eval  scale-inst ) 'num-questions)
            scale-info-list (append scale-info-list
                                    (list :num-questions num-questions))))
    (when (or scale-questions-p most-scale-info-p)
      (setf scale-questions (slot-value (eval  scale-inst ) 'scale-questions)
            scale-info-list (append scale-info-list (list :scale-questions scale-questions))))
    (cond
     (return-values-p
      (values name-string label  description num-questions  scale-questions
              mean-score scale-inst-sym scale-inst))
     (t 
      (values scale-info-list scale-inst-sym scale-inst)))
    ;;end let, get-scale-slot-values
    ))
;;TEST
;;;; (get-scale-slot-values  'sT1HigherSelf)
;;works = "sT1HigherSelf"   "sT1-HigherSelf-Integrity  happy balance devel discpn phil"   "Values self happiness, integrity, development, learning, discipline, self-sufficiency, independence, balance, and strong philosophy of life. This scale correlated .380 with overall happiness, .166 with low depression, .137 with low anxiety,.327 with low anger/aggression, .327 with the health scale, and .351 with overall relationship success, (10 items)"        10     (THM6LEAR THM9SHAP THM14IND THM22BOD THM23BAL THMCOMPC THMINTEG THMPHIL THMSESUF THMSEDIS)       (THM6LEAR THM9SHAP THM14IND THM22BOD THM23BAL THMCOMPC THMINTEG THMPHIL THMSESUF THMSEDIS)     ".749"  *ST1HIGHERSELF-INST     #<ST1HIGHERSELF 2CAE6557>

;; WHEN RETURN A LIST (:return-values-p = NIL)
;; (get-scale-slot-values  'sT1HigherSelf  :return-values-p NIL)
;; works =(*ST1HIGHERSELF-INST :NAME-STRING "sT1HigherSelf" :LABEL "sT1-HigherSelf-Integrity  happy balance devel discpn phil" :DESCRIPTION "Values self happiness, integrity, development, learning, discipline, self-sufficiency, independence, balance, and strong philosophy of life. This scale correlated .380 with overall happiness, .166 with low depression, .137 with low anxiety,.327 with low anger/aggression, .327 with the health scale, and .351 with overall relationship success, (10 items)" :MEAN-SCORE ".749" :NUM-QUESTIONS 10 :SCALE-QUESTIONS (THM6LEAR THM9SHAP THM14IND THM22BOD THM23BAL THMCOMPC THMINTEG THMPHIL THMSESUF THMSEDIS))     *ST1HIGHERSELF-INST    #<ST1HIGHERSELF 2CAE6557>
;; (get-scale-slot-values  'sT1HigherSelf :most-scale-info-p NIL :name-string-p T  :return-values-p NIL)
;; works =(*ST1HIGHERSELF-INST :NAME-STRING "sT1HigherSelf")    *ST1HIGHERSELF-INST   #<ST1HIGHERSELF 2CAE6557>


