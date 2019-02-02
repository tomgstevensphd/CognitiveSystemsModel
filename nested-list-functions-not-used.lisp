;; ********************* nested-list-functions-not-used.lisp ************************
;;

;;



;; FOLLOWING FUNCTION MAY BE REPLACED BY NEW SET-KEY-VALUE-IN-NESTED LISTS
;;  SSS START HERE DEBUGGING set-keyvalue-deepfirst
;; FIX SO WILL APPEND THE VALUE-LIST NOT ADD TO VALUE
;;   AND ALSO WILL SET OR APPEND SET-NTH AFTER KEY
;;
;;ddd
(defun set-keyvalue-deepfirst (new-value  key-spec-lists  nested-lists 
                                                 &key append-keyvalue-p  (set-nth 1)
                                                 (max-list-length 1000)  
                                                 ;;cur-level-list
                                                 last-key-found-p   
                                                 new-keylist old-keylist return-value) 
  "In U-lists.lisp, GOOD FOR STUDYING RECURSION (unquote afouts). Works ONLY on nested-lists which are in the value slot after a lower key has been matched.  Doesn't search branches that don't have a matched key.  Key can be any place within a list.  If a list has no matches, will search next level. SETS key-value. USE SET-KEY-VALUE (newer) or APPEND-KEY-VALUE for many cases. USE THIS FOR MULTI-LEVEL KEYS.  RETURNS (values new-keylist return-nested-lists  return-value    old-keylist) that matches key-spec. The spec-lists is a list of 2 item spec lists. (key keyloc-n). If key = nil, T, or 0, sets the item following key to the new-value. Extra items are extra non-list items on all level lists that might contain important info. Can process infinite? levels of key lists. Can match with equal or string-equal automatically. The spec-lists are arranged FROM OUTER-MOST LIST to inner-most list. FINAL-KEY-INSIDE-KEYLIST-P means that the last key is inside a list--so items in outer list won't cause a false match. APPEND-ITEM is appended to the end of the list containing the final key.If APPEND-KEYVALUE-P, appends the new-value to the value following the key [If old value not a list, makes a list with both values.]     NOTE: final keylists should contain a value--even if nil in the set-nth (starts with 1) position so it can be replaced UNLESS the new-value is a new keylist and subst-new-keylist-p = t. If value is in place, replaces it with new-value. Note:last-key-found-p  new-keylist old-keylist return-value are used in recursion returns. IF ALL KEYS NOT FOUND, RETURNS NILS for all values except return-nested-lists."
  (let*
      ((return-nested-lists)
       (match-item)
       (spec-list (car key-spec-lists))
       (KEY (first spec-list))
       (keyloc-n (second spec-list))
       (new-spec-lists)
       (new-nested-list1)
       (new-nested-lists)
       (add-new-value-p)
       (cur-level-list)
       )

    (cond
     (nested-lists
      (cond
       ;;IF KEYLOC-N = NUMBER, USE efficient function to get, set, or append.
       ((numberp keyloc-n)
        (multiple-value-setq (new-keylist new-nested-lists 
                                          return-value   old-keylist last-key-found-p )
            (set-key-value-in-orderly-nested-list new-value  key-spec-lists  nested-lists 
                                          :append-keyvalue-p append-keyvalue-p
                                           :max-list-length max-list-length
                                          :last-key-found-p   last-key-found-p
                                          :new-keylist new-keylist
                                          :old-keylist old-keylist
                                          :return-value return-value))
        (setf return-nested-lists (append return-nested-lists (list new-nested-lists)))
        ;;end (numberp keyloc-n)
        )       
       
       ;;KEYLOC = NIL OR T (SEARCH ALL ITEMS IN LIST)  
       (t 
        (loop
         for item in nested-lists
         for item-n from 0 to max-list-length
         do
         (afout 'out (format nil "item=  ~A spec-list= ~A key= ~A" item spec-list key))
         (cond
          ;;ADD-NEW-VALUE-P [SET VALUE FOLLOWING LAST KEY]
          (add-new-value-p  
           (setf add-new-value-p nil)

            (multiple-value-setq (new-keylist return-value)
                (get-set-or-append-keyvalue key old-value new-value :keyloc-n keyloc-n
                                            :append-value-p append-keyvalue-p
                                            :put-key-after-items put-key-after-items
                                            :splice-key-value-in-list splice-key-value-in-list))

           (setf return-nested-lists (append return-nested-lists 
                                                  new-keylist (nthcdr item-n nested-lists)))
           (return)
       
           ;;(BREAK "after add new value")
           ;;end add-new-value-p
           )

          ;;IF LISTP ITEM AND NULL LAST-KEY-FOUND-P, 
          ;;               SEARCH  LIST FOR KEYS
          ((and (listp item) (null last-key-found-p))
           (setf cur-level-list item)
           (multiple-value-setq (new-keylist new-nested-lists 
                                             return-value   old-keylist last-key-found-p )
               ;;use original key-spec-lists bec has NOT found key in any list
               (set-key-value-in-nested-lists new-value  key-spec-lists  item
                                              :append-keyvalue-p append-keyvalue-p
                                              :max-list-length max-list-length
                                              :new-keylist new-keylist  
                                              :old-keylist old-keylist :return-value return-value
                                              ))
           (setf return-nested-lists (append return-nested-lists (list new-nested-lists)))
           ;;end listp item
           )
          ;;ITEM NOT A LIST (note that :no-key must have a keyloc-n)
          (t 
           (cond
            ((my-equal item key)
             (setf new-spec-lists (cdr key-spec-lists)
                   new-nested-list1  (nthcdr (+ item-n 1) nested-lists))
             ;;(break "1b EQUAL")
             (afout 'out (format nil "ITEM=KEY= ~a~%cur-level-list= ~A~%new-nested-list1= ~A" item cur-level-list new-nested-list1)) 
             (cond
              ;;must recurse if not last spec-list (above) and is more nested list left
              (new-spec-lists
               (multiple-value-setq (new-keylist new-nested-lists 
                                                 return-value    old-keylist  last-key-found-p )
                   (set-key-value-in-nested-lists new-value new-spec-lists 
                                                  new-nested-list1
                                                  :append-keyvalue-p append-keyvalue-p
                                                  :max-list-length max-list-length
                                                  :new-keylist new-keylist 
                                                  :old-keylist old-keylist :return-value return-value
                                                  ))
               (afout 'out (format nil "new-nested-lists AFTER RECURSE= ~a" new-nested-lists)) 
                
               (setf return-nested-lists (append return-nested-lists  new-nested-lists))
               (when last-key-found-p (return))
               ;;end new-spec-lists
               )

              ;;NOT USED?? ITEM = KEY, FINAL KEY [no more key-spec-lists]
              ( t 
                (setf  last-key-found-p T
                       add-new-value-p T)
                (afout 'out (format nil "last-key-found-p= ~A" last-key-found-p))               
                ;;return-nested-lists (append return-nested-lists (list key)))  
                (BREAK "AFTER SET last-key-found-p t")
                ))
             ;;end item = key
             )
            ;;NOT ITEM = KEY
            (t (setf return-nested-lists (append return-nested-lists (list item)))))
           ;;end item not listp, cond
           ))
         ;;end loop, t, cond,  nested-lists clause
         ))))
       ;;NULL NESTED-LISTS (end recursions)
       (t  
        ;;end null nested-lists, cond
        ))
      (afout 'out (format nil "return-nested-lists= ~A" return-nested-lists))
      (values new-keylist return-nested-lists return-value    
              old-keylist last-key-found-p )
      ;;end let, set-key-value-in-nested-lists
      ))
;;TEST
;; append
;;(progn (setf out nil)(set-keyvalue-deepfirst  'NEW-VALUE '((:key2 0)(:key1 3)) '("classX1end" 0.22 (:KEY0 0.25) :KEY1 (33)  (:KEY2 (0.55)) :KEY3 (44) (:KEY4 0.95)) :append-keyvalue-p t))
;;works=(:KEY2 (0.55) NEW-VALUE)   ("classX1end" 0.22 (:KEY0 0.25) :KEY1 (33) (:KEY2 (0.55) NEW-VALUE) :KEY3 (44) (:KEY4 0.95))   ((0.55) NEW-VALUE)   (:KEY2 (0.55))    T

;;no append/replace old-value
;;   (set-keyvalue-deepfirst  'NEW-VALUE '((:key2 0)) '("classX1end" 0.22 (:KEY0 0.25) :KEY1 (33)  (:KEY2 (0.55)) :KEY3 (44) (:KEY4 0.95)))
;;works=  (:KEY2 NEW-VALUE)    ("classX1end" 0.22 (:KEY0 0.25) :KEY1 (33) (:KEY2 NEW-VALUE) :KEY3 (44) (:KEY4 0.95))    (NEW-VALUE)    (:KEY2 (0.55))   T
;;set not append
;;  (progn (setf out nil) (set-keyvalue-deepfirst 'NEW-VALUE  '((:PC-VALUES 0)(A3 0))  '(:PCSYM-ELM-LISTS ((A3 (MOTHER FATHER BEST-M-FRIEND)) (B3 (MOTHER FATHER BEST-F-FRIEND)) (C5 (MOTHER BEST-M-FRIEND BEST-F-FRIEND)) (D1 (FATHER BEST-M-FRIEND BEST-F-FRIEND))) :PC-VALUES ((A3 "a vs not a" :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12)(A4 "this is A4") x) a b (list y) 33)))
;;finally works= (A3 NEW-VALUE)    (:PCSYM-ELM-LISTS ((A3 (MOTHER FATHER BEST-M-FRIEND)) (B3 (MOTHER FATHER BEST-F-FRIEND)) (C5 (MOTHER BEST-M-FRIEND BEST-F-FRIEND)) (D1 (FATHER BEST-M-FRIEND BEST-F-FRIEND))) ((A3 NEW-VALUE "a vs not a" :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12) (A4 "this is A4") X) A B (LIST Y) 33)   (NEW-VALUE)    (A3 "a vs not a")      T      T
;;append
;;  (progn (setf out nil) (set-keyvalue-deepfirst 'NEW-VALUE  '((:PC-VALUES 0)(A3 0))  '(:PCSYM-ELM-LISTS ((A3 (MOTHER FATHER BEST-M-FRIEND)) (B3 (MOTHER FATHER BEST-F-FRIEND)) (C5 (MOTHER BEST-M-FRIEND BEST-F-FRIEND)) (D1 (FATHER BEST-M-FRIEND BEST-F-FRIEND))) :PC-VALUES ((A3 "a vs not a" :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12)(A4 "this is A4") x) a b (list y) 33) :append-keyvalue-p T))
;; works =  
;; (A3 "a vs not a" NEW-VALUE)     (:PCSYM-ELM-LISTS ((A3 (MOTHER FATHER BEST-M-FRIEND)) (B3 (MOTHER FATHER BEST-F-FRIEND)) (C5 (MOTHER BEST-M-FRIEND BEST-F-FRIEND)) (D1 (FATHER BEST-M-FRIEND BEST-F-FRIEND))) ((A3 "a vs not a" NEW-VALUE :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12) (A4 "this is A4") X) A B (LIST Y) 33)      ("a vs not a" NEW-VALUE)     (A3 "a vs not a")    T     T



;;SSS START HERE MAKING IT APPEND INSIDE FIRST LEVEL OR
;;  USE ANOTHER FUNCTION (APPEND-KEY-VALUE OR SET-KEY-VALUE)
;; (setf mother '("MOTHER" "mother" CS1-1-1-1 (datalist this :key1 "that") NIL :info "this is info" :key3 (a b c)))
;; (set-keyvalue-deepfirst  "new-value"  `((:key1  0 T)) mother :append-keyvalue-p T :final-key-inside-keylist-p T) =
;;doesn't work right, results =  (:KEY1 "new-value")  ("MOTHER" "mother" CS1-1-1-1 (DATALIST THIS :KEY1 "that") NIL :INFO "this is info" :KEY3 (A B C) (:KEY1 "new-value"))


;;  (set-keyvalue-deepfirst 77 '((:key1 0)) '("classX1end" 0.22 (:NO-KEY 0.55) (:NO-KEY 0.55) (:NO-KEY 0.55)))

;;test append-item -- only replaces items after the key??
;; (progn (setf out nil) (set-keyvalue-deepfirst  77 '((:key2 0)) '("classX1end" 0.22 (:KEY0 0.25) :KEY1 (33)  (:KEY2 (0.55)) :KEY3 (44) (:KEY4 0.95)) :append-item t))
;; (set-keyvalue-deepfirst  77 '((:key4 0)) '("classX1end" 0.22 (:KEY0 0.25) :KEY1 (33)  (:KEY2 0.55) :KEY3 (44) (:KEY4 0.95)) :append-item t)
;;(:KEY4 77)   ("classX1end" 0.22 (:KEY0 0.25) :KEY1 (33) (:KEY2 0.55) :KEY3 (44) (:KEY4 77))   77   (:KEY4 0)  (:KEY4 0.95)

;;note key-spec-list wrong below, so appends list with key1; MUST BE A NESTED LIST
;; (set-keyvalue-deepfirst  77 '((:key1 0)) '("classX1end" 0.22 (:KEY0 0.25) :KEY1 (33)  (:KEY2 0.55) :KEY3 (44) (:KEY4 0.95)))
;; result= ("classX1end" 0.22 (:KEY0 0.25) :KEY1 (33) (:KEY2 0.55) :KEY3 (44) (:KEY4 0.95) (:KEY1 77))

;;first key NOT in main list
;;  (progn (setf out nil) (set-keyvalue-deepfirst 'this-value '((a 0)(b 0)(c 0)) '( (s 1 2 (t 3 4 (u 5 6 7 )))(a (n1 2) (b (mm 33 ) (c 1 2 3  (l i s t )) (nn 22)) ( extra ))))  )
;;works, returns 1- (C (THIS-VALUE) 2 3 (L I S T))  2-  ((S 1 2 (T 3 4 (U 5 6 7))) (A (N1 2) (B (MM 33) ((C (THIS-VALUE) 2 3 (L I S T))) (NN 22)) (EXTRA)))  3-  THIS-VALUE  4-  (C 0)    5- (C 1 2 3 (L I S T))
;; first key IN MAIN list
;; (progn (setf out nil) (set-keyvalue-deepfirst 'this-value '((a T)(b 0)(c 0)) '( s 1 2 (t 3 4 (u 5 6 7 )) a ((n1 2) (b (mm 33 ) (c 1 2 3  (l i s t ))) (nn 22)) ( extra )))  )  ;;SSS = doesn't work
;;
;;  (progn (setf out nil)  (set-keyvalue-deepfirst 'this-value  '(("iAcademicMotivation.java" 1)( "acmESOCSTudy" 0)) '((PC-INSTANCES  "iAcademicMotivation.java"      ("[]questionInstancesArray1)")      ("acmNDROPcourses" "30" "acmNDROPcoursesQ" "int" "FrAnswerPanel.LikeMe7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight")      ("acmESOCSTudy" "3" "acmESOCSTudyQ" "int" "FrAnswerPanel.LikeMe7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight"))))) ;;(fout out)) ;; :return-list-p  t))
;;WORKS, returns 1-("acmESOCSTudy" (THIS-VALUE) "acmESOCSTudyQ" "int" "FrAnswerPanel.LikeMe7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight")   2-((PC-INSTANCES "iAcademicMotivation.java" ("[]questionInstancesArray1)") ("acmNDROPcourses" "30" "acmNDROPcoursesQ" "int" "FrAnswerPanel.LikeMe7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight") (("acmESOCSTudy" (THIS-VALUE) "acmESOCSTudyQ" "int" "FrAnswerPanel.LikeMe7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight"))))   3- THIS-VALUE  4- ("acmESOCSTudy" 0)   5-("acmESOCSTudy" "3" "acmESOCSTudyQ" "int" "FrAnswerPanel.LikeMe7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight")
;;
;;  (set-keyvalue-deepfirst 'this '((5 0))  '((1 0 (1 2 A)) (5 1 (1 6 (QUOTE (A B))))))
;; returns (THIS 1 (1 6 (QUOTE (A B))))  ((THIS 1 (1 6 (QUOTE (A B))))) (THIS)  (5 0) NIL

;; (progn (setf out nil) (set-keyvalue-deepfirst 'that-value '((this 0))  '((a b)(c (1 2))(this (3 4 5))(x y))))
;;  (set-keyvalue-deepfirst '((x 0))  '((a b)(c (1 2))(this (3 4 5))(x y)) )
;; (set-keyvalue-deepfirst  '((5 0)) '((1 0 (1 2 A)) (5 1 (1 6 (QUOTE (A B))))) :return-list-p t)
;;  use (replace-list  new-value2   (+ set-nth 1)) instead
;;(replace   '(5 1 (1 6 (QUOTE (A B)))) '(this) :start1 1)
;; (progn (setf out nil) (set-keyvalue-deepfirst  '((5 0)(1 0)) '((1 0 (1 2 A)) (5 1 (1 6 (QUOTE (A B))))) :return-list-p t))(fout out))
;; (set-keyvalue-deepfirst  '((5 0)(1 0))  '((1 0 (1 2 A)) (5 1 (1 6 (QUOTE (A B))))) :return-nth 2) 
;; (nth 0 '((1 0 (1 2 A)) (5 1 (1 6 (QUOTE (A B)))))) (1 0 (1 2 A))
;; (progn (setf out nil)  ( set-keyvalue-deepfirst '(( "iWorldviewFears.java" 1)("wovNoLove" 0)) *all-shaq-pc-instances  :return-list-p t))  
;; (progn (setf out nil)  (set-keyvalue-deepfirst "wovNoLove" *all-shaq-pc-instances :find-outer-key "iWorldviewFears.java" :find-nth-first 1)) ;;  :return-list-p t))
;;
;; (progn (setf out nil) (multiple-value-setq (*testfn1 *testfn2 *testfn3 *testfn4) (set-keyvalue-deepfirst "wovNoLove" *all-shaq-pc-instances  :find-outer-key  t   :return-list-p t) )(fout out)))
 
;;  (progn (setf out nil)  (set-keyvalue-deepfirst    "acmESOCSTudy" '(PC-INSTANCES  "iAcademicMotivation.java"      ("[]questionInstancesArray1)")      ("acmNDROPcourses" "30" "acmNDROPcoursesQ" "int" "FrAnswerPanel.LikeMe7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight")      ("acmESOCSTudy" "3" "acmESOCSTudyQ" "int" "FrAnswerPanel.LikeMe7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight")) :return-list-p  t))
;;works, returns ("acmESOCSTudy" "3" "acmESOCSTudyQ" "int" "FrAnswerPanel.LikeMe7" "questionInstancesArray" "frameTitle" "frameDimWidth" "frameDimHeight")  "acmESOCSTudy"  NIL  (PC-INSTANCES "iAcademicMotivation.java")

;;  (set-keyvalue-deepfirst 'this  '((a b)(c (1 2))(this (3 4 5))(x y)))
;; works, returns= (3 4 5)  THIS NIL NIL
;;  (set-keyvalue-deepfirst 'x '((a b)(c (1 2))(this (3 4 5))(x y)))
;; works, returns Y X NIL NIL
;;   (set-keyvalue-deepfirst 5  '((1 0 (1 2 A)) (5 1 (1 6 (QUOTE (A B)))))) = 1 5 NIL NIL
;; (set-keyvalue-deepfirst 5  '((1 0 (1 2 A)) (5 1 (1 6 (QUOTE (A B))))) :return-list-p t)
;; works, returns (5 1 (1 6 (QUOTE (A B))))  5 NIL NIL
;; (set-keyvalue-deepfirst 5  '((1 0 (1 2 A)) (5 1 (1 6 (QUOTE (A B))))) :return-nth 2) 
;;works, returns (1 6 (QUOTE (A B)))  5 NIL NIL
;;(replace  '(0 1 2 3 4 5 6 7 8 9) '(a b c) :start1 5 :end1 7 :start2 1 :end2 3) = (0 1 2 3 4 B C 7 8 9)
;; (replace  '(0 1 2 3 4 5 (x y z) 7 8 9) '(a b (l m)) :start1 5 :end1 7 :start2 1 :end2 3) = (0 1 2 3 4 B (L M) 7 8 9)
;; (replace  '(0 1 2 3 4 5 (x y z) 7 8 9) '(a b (l m)) :start1 6 :end1 9 :start2 1 :end2 3) = (0 1 2 3 4 5 B (L M) 8 9)
;; (set-class-symval "classXX" .22 :key1)
;; ;;    (set-keyvalue-deepfirst 55  '((key1 T))  nil) = (KEY1 55) ((KEY1 55)) NIL NIL NIL
;;  (set-keyvalue-deepfirst 55 nil  nil) = (:NO-KEY 55) ((:NO-KEY 55)) NIL NIL NIL
;;  (set-keyvalue-deepfirst 55  '((key2 0)) '(1 2 (key1 22)(key2 33)(key3 0))) 
;; works= (KEY2 55)  (1 2 (KEY1 22) (KEY2 55) (KEY3 0))   55  (KEY2 0)  (KEY2 33)




















;;OLD-NON-WORKING

;SET-KEY-VALUE-IN-NESTED-LISTS
;;  (partially replaced by set-key-value and append-key-value) 
;;   This function can more specifically search deep nested lists 
;;  ESPECIALLY GOOD FOR MULTI-LEVEL KEYS
;;
;;ddd
#|(defun set-key-value-in-nested-lists2 (new-value  key-spec-lists  nested-lists 
                                                &key append-item  append-keyvalue-p
                                                final-key-inside-keylist-p 
                                                subst-new-keylist-p no-return-extra-p) 
  "In U-lists.lisp, SETS key-value. USE SET-KEY-VALUE (newer) or APPEND-KEY-VALUE for many cases. USE THIS FOR MULTI-LEVEL KEYS.  RETURNS (values new-keylist return-nested-lists  return-value  final-spec-list old-keylist) that matches key-spec. The spec-lists is a list of 2 item spec lists. (key set-nth)  If  key = T, searches entire list of lists for key  If set-nth = T, searches entire sublist for the key. SET-NTH MUST BE T on ALL BUT LAST LEVEL? Extra items are extra non-list items on all level lists that might contain important info. Can process infinite? levels of key lists. Can match with equal or string-equal automatically. The spec-lists are arranged FROM OUTER-MOST LIST to inner-most list. FINAL-KEY-INSIDE-KEYLIST-P means that the last key is inside a list--so items in outer list won't cause a false match. APPEND-ITEM is appended to the end of the list containing the final key.If APPEND-KEYVALUE-P, appends the new-value to the value following the key [If old value not a list, makes a list with both values.]     NOTE: final keylists should contain a value--even if nil in the set-nth position so it can be replaced UNLESS the new-value is a new keylist and subst-new-keylist-p = t. If value is in place, replaces it with new-value. "
  (let*
      ((new-keylist)
       (new-nested-lists)
       (return-key)
       (return-value)
       (return-nested-lists)
       (old-keylist)
       (match-item)
       (spec-list (car key-spec-lists))
       (KEY (first spec-list))
       (SET-NTH (second spec-list))
       (new-spec-lists (cdr key-spec-lists))
       (final-spec-list)
       (nested-list-length (list-length nested-lists))
       (new-nested-lists)
       (match-item-lo)
       (new-value-lo  )
       (length-item-lo)
       (item-loval)
       (last-item-key-p)
       )
    (unless  set-nth (setf set-nth 0))
    (cond
     (nested-lists
      (cond
       ;;SPEC IS TO SEARCH EVERY ITEM AT THIS LEVEL
       ((or (equal key t) (equal set-nth t))
        ;;(afout 'out (format nil "NEW CALL TO T  key= ~A~% (car of list= ~A~%" key (car nested-lists)))   
        (loop
         for item  in nested-lists
         for item-n from 0 to 2000
         ;;with new-value2 
         ;;with new-nested-lists 
         do
         ;;(afout 'out (format nil "T OUTER-LOOP key= ~A~%  item= ~A~%" key item))
         ;;test to see what the spec-list indicates
         (cond
          ;;In case key is in first level of a nested list
          ((and item (listp item))

           ;;note: this may call other recursive calls
           (multiple-value-setq (new-keylist  new-nested-lists return-value 
                                              final-spec-list old-keylist)
               (set-key-value-in-nested-lists new-value new-spec-lists item
                                              :append-item append-item 
                                              :final-key-inside-keylist-p final-key-inside-keylist-p 
                                              :subst-new-keylist-p subst-new-keylist-p
                                              :no-return-extra-p no-return-extra-p
                                              ))
           ;;works?
           (setf return-nested-lists (append return-nested-lists (list  new-nested-lists)))
           ;;end item listp
           )
          ((and item (not (listp item)))
           (cond
            ((my-equal item key)
             (cond
              (new-spec-lists
               (when (equal set-nth T)
                 (setf set-nth item-n))
               (setf new-nested-lists  (nthcdr (+ set-nth 1) nested-lists))
               (break "set-nth")
               ;;note: this may call other recursive calls
               (multiple-value-setq (new-keylist  new-nested-lists return-value 
                                                  final-spec-list old-keylist)
                   (set-key-value-in-nested-lists new-value new-spec-lists 
                                                  new-nested-lists
                                                  :append-item append-item 
                                                  :final-key-inside-keylist-p final-key-inside-keylist-p 
                                                  :subst-new-keylist-p subst-new-keylist-p
                                                  :no-return-extra-p no-return-extra-p
                                                  ))
               ;;works?
               (setf return-nested-lists (append return-nested-lists (list  new-nested-lists)))
               )    
              (t  NIL ;;was (setf new-nested-lists (append new-nested-lists (list key))
                  ))
             ;;end when my-equal item key
             )
            (t nil))
           ;;end item not list
           )
          ;;may be non-list items such as other keys providing info re: found outer lis.
          (t (setf return-nested-lists (append return-nested-lists (list  item))))) 
         ;;end loop, clause item equal.t  or set-nth = t
         ))
       ;;AT LOWEST LIST, SEARCH FOR KEY-VALUE
       ((and (null new-spec-lists) key)
        (loop
         for item-lo in nested-lists
         for n from 0 to nested-list-length
         with match-item-lo 
         with new-value-lo  
         with length-item-lo 
         do
         ;;(afout 'out (format  nil "1 LOWEST LEVEL TEST key= ~A  match-item-lo= ~A~% set-nth= ~A~%nested-lists= ~A~% IN find-key-value-in-lists " key match-item-lo set-nth nested-lists))
         (cond
          ;;SEARCH INSIDE A NESTED LIST -- NOT IN OUTER LIST FOR KEY
          ((and (listp item-lo) (null final-key-inside-keylist-p))
           (setf  length-item-lo (list-length item-lo))       
           (unless (>= set-nth  length-item-lo))
           (setf match-item-lo (nth set-nth item-lo))
           (cond
            ((my-equal key match-item-lo)
             ;;was (or (equal key match-item-lo) (if (stringp match-item-lo) (string-equal key match-item-lo)))

             ;;(afout 'out (format  nil "2 LOWEST LEVEL TEST key= ~A  match-item-lo= ~A~% set-nth= ~A~%nested-lists= ~A~% item-lo= ~A~%IN find-key-value-in-lists " key match-item-lo set-nth nested-lists item-lo))

             ;;use RETURN-VALUE because will be NIL IF NO MATCH (and return NIL)
             ;;  also set old-keylist to item-lo
             (setf return-value new-value
                   old-keylist item-lo)
             ;;PUT NEW-VALUE IN PROPER PLACE AND/OR ADD APPEND-ITEM-LO
             ;;do I replace an item-lo or just add it.
             (cond
              ;;if subst-new-keylist-p subst new-value (a list) for old keylist.
              ((and subst-new-keylist-p (listp new-value))
               (setf new-keylist new-value))
              ;;if  set-nth, replace that item-lo with new-value
              (set-nth
               ;;problem with replace modifying item-lo permenantly and therefore old-keylist
               ;;modified 2016-04 to add append-keyvalue-p option
               (cond
                (append-keyvalue-p
                 (setf item-loval (second item-lo))
                 (cond
                  ((listp item-loval)
                   (setf new-value-lo (append item-loval (list new-value))))
                  (t (setf new-value-lo (list item-loval new-value)))))
                (t (setf  new-value-lo new-value)))

               ;;2015-05 was (list new-value)= extra parens
               (setf new-keylist (replace-list item-lo (+ set-nth 1) new-value-lo)))
              (t nil))  ;;was (setf new-keylist nil)))
             ;;if append-item (= a value) append to the new-keylist
             (if append-item
                 (setf final-spec-list (append final-spec-list (list append-item)))) 
             ;;set final return items
             (setf final-spec-list (list key set-nth)
                   return-nested-lists (replace-list nested-lists n new-keylist)) 
             ;;2015 was (list new-keylist))) => extra parens around list
             ;;  (return)
             )
            (t nil))
           ;;end listp item-lo
           )
          ;;if not list, search current list for item-lo, just check to see if item-lo = key
          ;;problem if an item-lo matches key but real key is inside a later list
          ;;SEARCHES OUTER LIST FOR KEY MATCH--NOT AN INNER LIST
          (final-key-inside-keylist-p
           (cond
            ((my-equal key item-lo)
             ;;was (or (equal key item-lo) (if (stringp item-lo) (string-equal key item-lo)))
             ;;PUT NEW-VALUE IN PROPER PLACE AND/OR ADD APPEND-ITEM-LO
             ;;do I replace an item-lo or just add it.
             (cond
              ;;if subst-new-keylist-p subst new-value (a list) for old keylist.
              ((and subst-new-keylist-p (listp new-value))
               (setf new-keylist new-value))
              ;;if  set-nth, replace that item-lo with new-value
              (set-nth
               (setf  new-value-lo (list new-value)
                      ;;xxx causes a problem perm changing item-lo value??
                      new-keylist (replace-list item-lo    (+ set-nth 1) new-value-lo)))
              #|                    (replace item-lo new-value-lo :start1
                                         (+ set-nth 1) :end1 (+ set-nth 2))))|#
              (t (setf new-keylist nil)))

             ;;if append-item (= a value) append to the new-keylist
             (if append-item
                 (setf new-keylist (append new-keylist (list append-item))))
             ;;added works
             (setf return-nested-lists (append return-nested-lists (list  new-keylist)))
             (return))
            (t  nil)))    ;; (setf new-nested-list (append new-nested-list (list item-lo))))))
          (t nil) ;; (setf new-nested-list (append new-nested-list (list item-lo))))
          ;;end cond, lo loop, equal null new-spec-lists
          )))
       ;;SPEC IS TO SEARCH THIS LEVEL (not last level) BY KEY at SET-NTH
       ((and  new-spec-lists  key)
        ;;(afout 'out (format nil "OUTER-LOOP SEARCH new-spec-lists= ~A~%" new-spec-lists))         
        ;;check each list at this level
        (loop
         for item in nested-lists
         with list-length  
         with match-item 
         with new-nested-lists 
         do
         ;;for each sublist, check set-nth
         ;;(afout 'out (format nil "KEY OUTER-LOOP key= ~A~% item= ~A~%new-spec-lists= ~A~%" key item new-spec-lists))
         (cond
          ((listp item)
           (setf  list-length (list-length item))     
           (unless (>= set-nth  list-length))
           (setf match-item (nth set-nth item))
          ;; (setf *out (append *out  (format  nil "OUTER LOOP TESTING key= ~A  match-item= ~A~%  IN find-key-value-in-lists" key match-item)))
           (cond
            ((my-equal key match-item)
             ;;was (or (equal key match-item) (if (stringp match-item) (string-equal key match-item)))
             ;;;yyy
             (multiple-value-setq (new-keylist  new-nested-lists return-value 
                                                final-spec-list old-keylist)
                 (set-key-value-in-nested-lists new-value new-spec-lists item
                                                :append-item append-item 
                                                :final-key-inside-keylist-p 
                                                final-key-inside-keylist-p 
                                                :subst-new-keylist-p subst-new-keylist-p
                                                :no-return-extra-p no-return-extra-p))
             ;;works
             (setf return-nested-lists (append return-nested-lists (list new-nested-lists)))
   ;;sss start here
             ;;(setf *out (append *out  (format nil "ON RECURSE RETURN return-value= ~A~% return-key=~A~%" return-value return-key)))
             ;;was   (return)
             )
            (t (setf return-nested-lists (append return-nested-lists (list item)))))
           ;;end listp item
           )
          (t 
           (setf return-nested-lists (append return-nested-lists (list (list item))))))
         ;;end loop, equal new-spec-lists
         ))
       ;;IF TOP LEVEL NONE-OF-ABOVE
       (t (setf return-nested-lists (append return-nested-lists (list (list :no-key new-value))))))
      ;;end nested-lists clause
      )

      ;;NULL NESTED-LISTS
     (t (cond
         (key-spec-lists
          (if (listp key-spec-lists)
              (setf new-keylist (list (caar  key-spec-lists) new-value)
                    return-nested-lists (list new-keylist))
            (setf new-keylist (list  key-spec-lists  new-value)
                  nested-lists (list new-keylist))))
         (t (setf new-keylist (list :no-key new-value)
              return-nested-lists (list new-keylist))))
        ;;end outer t, cond
        ))

;;2015-05 added bec wouldn't add keylist to a simple list with no key already in list
   (when  (and (null return-value) (null new-keylist) key new-value )
        (setf new-keylist  (list key new-value)
              return-nested-lists (append nested-lists (list new-keylist))))
             ;; return-nested-lists nil)
    ;;end set-key-value-in-nested-lists

    (values new-keylist return-nested-lists  return-value  final-spec-list old-keylist) 
    ))|#

#|(defun set-key-value-in-nested-lists (new-value  key-spec-lists  nested-lists 
                                                 &key append-keyvalue-p  
                                                 (max-list-length 1000)
                                                 key-found-p
                                                 ) 
  "In U-lists.lisp, SETS key-value. USE SET-KEY-VALUE (newer) or APPEND-KEY-VALUE for many cases. USE THIS FOR MULTI-LEVEL KEYS.  RETURNS (values new-keylist return-nested-lists  return-value    old-keylist) that matches key-spec. The spec-lists is a list of 2 item spec lists. (key set-nth). If key = nil, T, or 0, sets the item following key to the new-value. Extra items are extra non-list items on all level lists that might contain important info. Can process infinite? levels of key lists. Can match with equal or string-equal automatically. The spec-lists are arranged FROM OUTER-MOST LIST to inner-most list. FINAL-KEY-INSIDE-KEYLIST-P means that the last key is inside a list--so items in outer list won't cause a false match. APPEND-ITEM is appended to the end of the list containing the final key.If APPEND-KEYVALUE-P, appends the new-value to the value following the key [If old value not a list, makes a list with both values.]     NOTE: final keylists should contain a value--even if nil in the set-nth position so it can be replaced UNLESS the new-value is a new keylist and subst-new-keylist-p = t. If value is in place, replaces it with new-value. "
  (let*
      ((new-keylist)
       ;;(return-key)
       (return-value)
       (return-nested-lists)
       (old-keylist)
       (match-item)
       (spec-list (car key-spec-lists))
       (KEY (first spec-list))
       (SET-NTH (second spec-list))
   ;;PREVENT  = NIL
       (new-spec-lists (cdr key-spec-lists))
       ;;(nested-list-length (list-length nested-lists))
       (new-nested-lists)
       (new-nested-list)
       ;;(match-item-lo)
       ;;(new-value-lo  )
      ;; (length-item-lo)
       (new-nested-lists)
       ;;(item-loval)
       (add-new-value-p)
       )
    (unless  set-nth (setf set-nth 0))
    (cond
     (nested-lists
      (loop
       for item in nested-lists
       for item-n from 0 to max-list-length
       do
       (afout 'out (format nil "item=  ~A" item))
       (cond
        ((listp item)
         (cond
          (add-new-value-p  ;;[only for next item after last key]
            (setf add-new-value-p nil)
            (cond
             (append-keyvalue-p
              (setf return-nested-lists (append return-nested-lists 
                                                (list item new-value))))
             ;;replace old value
             (t (setf return-nested-lists (append return-nested-lists 
                                                  (list new-value)))))
            (BREAK "after add new value")
            ;;end add-new-value-p
            )
          (t
           (multiple-value-setq (new-keylist new-nested-lists 
                                             return-value   old-keylist key-found-p)
               ;;use original key-spec-lists bec has NOT found key in any list
               (set-key-value-in-nested-lists new-value key-spec-lists  item
                                              :append-keyvalue-p append-keyvalue-p
                                              :max-list-length max-list-length))
           (setf return-nested-lists (append return-nested-lists (list new-nested-lists)))))
         ;;end listp item
         )
        ;;NOT A LIST 
        (t (cond
            ((my-equal item key)  
             ;;(break "1b EQUAL")
             (cond
              (new-spec-lists
               (setf return-nested-lists (append return-nested-lists (list item)))
               new-nested-list (nthcdr (+ item-n 1) nested-lists)

               (cond
                ;;must recurse if not last spec-list and is more nested list left
                (new-nested-lists
                 (multiple-value-setq (new-keylist new-nested-lists 
                                                   return-value    old-keylist key-found-p)
                     (set-key-value-in-nested-lists new-value new-spec-lists 
                                                    new-nested-list
                                                    :append-keyvalue-p append-keyvalue-p
                                                    :max-list-length max-list-length))

                 ;;??? what is new-keylist? is it needed??
                 (setf return-nested-lists 
                       (append return-nested-lists (list new-nested-lists))))

                ;;if NOT new-spec-lists and new-nested-list, but item = key
                (t 
                 (setf return-nested-lists (append return-nested-lists (list key))
                       key-found-p T
                       add-new-value-p T)
                 (break "2 nonlistp")
                 ;;end t, cond
                 ))
               ;;end new-spec-lists
               )

              ;;ITEM = KEY, FINAL KEY
              ( t 
                (setf  key-found-p T
                      add-new-value-p T
                      return-nested-lists (append return-nested-lists 
                                                  (list key)))))
             ;;end item = key
             )
            ;;ADD-NEW-VALUE-P  SET VALUE FOR ITEM FOLLOWING LAST KEY
            (add-new-value-p  ;;[only for next item after last key]
              (setf add-new-value-p nil)
             (cond
                (append-keyvalue-p
                 (setf new-keylist (list key item new-value)
                       old-keylist (list key item)
                       return-value (list item new-value)
                       return-nested-lists (append return-nested-lists 
                                                   (list item new-value))))
                 ;;replace old value
                 (t (setf  new-keylist (list key new-value)
                           old-keylist (list key item)
                           return-value (list  new-value)
                           return-nested-lists (append return-nested-lists 
                                                       (list new-value)))))
             (BREAK "after add new value")
             ;;end add-new-value-p
             )
            ;;not item = key
            (t (setf return-nested-lists (append return-nested-lists (list item)))))
           ;;end item not listp, cond
           ))
       ;;end loop, nested-lists clause
       ))
     ;;NULL NESTED-LISTS (end recursions)
     (t  
      ;;key not ever found??
      (unless key-found-p
        (setf return-nested-lists (append return-nested-lists (list "TEST" key new-value))))
      ;;end null nested-lists
      ))
    (afout 'out (format nil "return-nested-lists= ~A" return-nested-lists))
    (values new-keylist return-nested-lists return-value    
            old-keylist key-found-p)
    ;;end let, set-key-value-in-nested-lists
    ))|#



;GET-KEY-SINGLEVALUE-IN-NESTED-LISTS
;;  (partially replaced by set-key-value and append-key-value) 
;;   This function can search deep nested lists 
;;ddd
(defun get-singlekey-value-in-nested-lists (key  nested-lists 
                                                 &key (max-list-length 1000)
                                                  new-keylist old-keylist return-value key-found-p)
  "In U-lists, searchs nested list for key value. RETURNS (values return-value keylist)"

  (multiple-value-bind (keylist return-nested-lists 
                                             return-value) 
               (set-singlekey-value-in-nested-lists :get  key  nested-lists
                                              :max-list-length max-list-length)
  (values return-value keylist)
  ;;end mvb, get-singlekey-value-in-nested-lists
  ))
;;TEST
;;  (get-singlekey-value-in-nested-lists   ':key2 '("classX1end" 0.22 (:KEY0 0.25) :KEY1 (33)  (:KEY2 (0.55)) :KEY3 (44) (:KEY4 0.95)))
;; works= (0.55)   (:KEY2 (0.55))   



;SET-KEY-SINGLEVALUE-IN-NESTED-LISTS
;;  (partially replaced by set-key-value and append-key-value) 
;;   This function can search deep nested lists 
;;
;;ddd
(defun set-singlekey-value-in-nested-listsOLD (new-value  key  nested-lists 
                                                 &key append-keyvalue-p  (set-nth 1)
                                                 (max-list-length 1000)
                                                  new-keylist old-keylist return-value key-found-p) 
  "In U-lists.lisp, SETS key-value. USE SET-KEY-VALUE (newer) or APPEND-KEY-VALUE for many cases. USE THIS FOR MULTI-LEVEL KEYS.  RETURNS (values new-keylist return-nested-lists  return-value  old-keylist) that matches key. .If APPEND-KEYVALUE-P, appends the new-value to the value following the key [If old value not a list, makes a list with both values.]  If set-nth, sets nth item after key to value (starts with 1).  [iIf  KEY NOT FOUND, RETURNS NILS for all values except return-nested-lists. [Note: this version does exhaustive search of tree including branches and items past the found key.  Not efficient if know lower level keys.]. "
  (let*
      ((return-nested-lists)
       (new-nested-lists)
       (new-nested-list)
       (new-nested-lists)
       (add-new-value-p)
       )
    (cond
     (nested-lists
      (loop
       for item in nested-lists
       for item-n from 0 to max-list-length
       do
       (afout 'out (format nil "item=  ~A key-found-p= ~A" item key-found-p))
       (cond
       ;;ADD-NEW-VALUE-P  SET VALUE FOR ITEM FOLLOWING LAST KEY  [only for next item after last key]
       (add-new-value-p  
        (setf add-new-value-p nil)
        #|(cond
         ;;If new-value = :get, function serves as a get instead of set
         ((equal new-value :get)
          (setf  new-keylist (list key item)
                   old-keylist (list key item)
                   return-value   item
                   return-nested-lists (append return-nested-lists 
                                                (list key new-value))))
         ;;append old-value with new-value
         (append-keyvalue-p
          (setf new-keylist (list key item new-value)
                old-keylist (list key item)
                return-value (list item new-value)
                return-nested-lists (append return-nested-lists 
                                             (list key item new-value))))
         ;;replace old value
         (t (setf  new-keylist (list key new-value)
                   old-keylist (list key item)
                   return-value (list  new-value)
                   return-nested-lists (append return-nested-lists 
                                                (list key new-value)))))|#

        (setf  return-nested-lists (append return-nested-lists 
                                           (list new-keylist)))
        (BREAK "after add new value")
        ;;end add-new-value-p
        )
        ((listp item)
           (multiple-value-setq (new-keylist new-nested-lists 
                                             return-value   old-keylist key-found-p)
               (set-singlekey-value-in-nested-lists new-value  key  item
                                              :append-keyvalue-p append-keyvalue-p
                                              :max-list-length max-list-length
                                              :key-found-p key-found-p
                                              :new-keylist new-keylist 
                                              :old-keylist old-keylist :return-value return-value
                                              ))
           (setf return-nested-lists (append return-nested-lists (list  new-nested-lists)))
         ;;end listp item
         )
        ;;NOT A LIST 
        (t (cond
            ((my-equal item key)  
             (setf key-found-p T
                   add-new-value-p T)
             ;;(break "1b EQUAL")
             (afout 'out (format nil "ITEM=KEY= ~a" ITEM))
             ;;end item = key
             )
            ;;not item = key
            (t (setf return-nested-lists (append return-nested-lists (list  item)))))
           ;;end item not listp, cond
           ))
       ;;end loop, nested-lists clause
       ))
     ;;NULL NESTED-LISTS (end recursions)
     (t  NIL
      ;;end null nested-lists
      ))
    (afout 'out (format nil "return-nested-lists= ~A~%key-found-p= ~A" return-nested-lists key-found-p))
    (values new-keylist return-nested-lists return-value    
            old-keylist key-found-p)
    ;;end let, set-singlekey-value-in-nested-lists
    ))
;;TEST
;; append
;;(progn (setf out nil)(set-singlekey-value-in-nested-lists  'NEW-VALUE ':key2 '("classX1end" 0.22 (:KEY0 0.25) :KEY1 (33)  (:KEY2 (0.55)) :KEY3 (44) (:KEY4 0.95)) :append-keyvalue-p t))
;;works=(:KEY2 (0.55) NEW-VALUE)     ("classX1end" 0.22 (:KEY0 0.25) :KEY1 (33) (:KEY2 (0.55) NEW-VALUE) :KEY3 (44) (:KEY4 0.95))     ((0.55) NEW-VALUE)    (:KEY2 (0.55))   T
;;no append/replace old-value
;;   (set-singlekey-value-in-nested-lists  'NEW-VALUE ':key2 '("classX1end" 0.22 (:KEY0 0.25) :KEY1 (33)  (:KEY2 (0.55)) :KEY3 (44) (:KEY4 0.95)))
;;works=  (:KEY2 NEW-VALUE)    ("classX1end" 0.22 (:KEY0 0.25) :KEY1 (33) (:KEY2 NEW-VALUE) :KEY3 (44) (:KEY4 0.95))    (NEW-VALUE)    (:KEY2 (0.55))   T

;; set not append
;;(progn (setf out nil) (set-singlekey-value-in-nested-lists 'NEW-VALUE  'A3  '(:PCSYM-ELM-LISTS ((A3 (MOTHER FATHER BEST-M-FRIEND)) (B3 (MOTHER FATHER BEST-F-FRIEND)) (C5 (MOTHER BEST-M-FRIEND BEST-F-FRIEND)) (D1 (FATHER BEST-M-FRIEND BEST-F-FRIEND))) :PC-VALUES ((A3 "a vs not a" :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12)(A4 "this is A4") x y) (list z))))
;;NOTE:-SETS BOTH A3 =  (A3 NEW-VALUE)    (:PCSYM-ELM-LISTS ((A3 NEW-VALUE) (B3 (MOTHER FATHER BEST-F-FRIEND)) (C5 (MOTHER BEST-M-FRIEND BEST-F-FRIEND)) (D1 (FATHER BEST-M-FRIEND BEST-F-FRIEND))) :PC-VALUES ((A3 NEW-VALUE :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12) (A4 "this is A4") X Y) (LIST Z))    (NEW-VALUE)    (A3 "a vs not a")    T
;;
;;with 2 keys in nested list, sets BOTH VALUES.
;;WORKS= (A3 NEW-VALUE)    (:PCSYM-ELM-LISTS ((A3 NEW-VALUE) (B3 (MOTHER FATHER BEST-F-FRIEND)) (C5 (MOTHER BEST-M-FRIEND BEST-F-FRIEND)) (D1 (FATHER BEST-M-FRIEND BEST-F-FRIEND))) :PC-VALUES ((A3 NEW-VALUE :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12)))    (NEW-VALUE)     (A3 "a vs not a")    T






