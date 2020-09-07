


;;SORT-LISTS-BY-FUNCALL
;;2018-02
;;ddd
(defun sort-lists-by-funcall (function funcargs append-n uncked-lists 
                                       &key (test 'my-greaterp))           
  "In  U-lists. INPUTS a list of 1nested-lists, RETURNS  new list ordered by order of nth-list, nth item nested-list in each list."
  (let
      ((selected)
       (sorted-lists)
       (sorted-lists1)
       (other-items)
       (ret-n)
       (restlists)
       (uncked-lists2)
       (nthlist)
       )
    (cond
     ((listp uncked-lists)
      (multiple-value-setq (selected ret-n restlists uncked-lists2 nthlist)
          (get-greatest/least-list-by-funcalled-items function funcargs append-n 
                                                      uncked-lists :test test))  
        (setf sorted-lists (append sorted-lists (list selected)))
        )
     (t (setf other-items (append other-items (list uncked-lists)))))
  ;;(break "1")
    (when restlists
      (multiple-value-setq (sorted-lists1 other-items restlists)
          (sort-lists-by-funcall function funcargs append-n restlists :test test))
      (setf sorted-lists (append sorted-lists sorted-lists1)))

    (values sorted-lists other-items restlists)
    ;;end let, sort-lists-by-funcall
    ))
;;TEST
;; (sort-lists-by-funcall '#'NTH '(1) 1 '((C 3)(E 5)(A 1)(B 2)))
;; works= ((E 5) (C 3) (B 2) (A 1))   NIL   NIL





;;ORDER-1NESTED-SUBLISTS-BY-FUNCALL
;;2018-02
;;ddd
(defun order-1nested-sublists-by-funcall (function funcargs append-n
                                                    ;;function2 funcargs2 append-n2 
                                                    list-of-1nested-lists
       ;;was (nthlist nth list-of-1nested-lists
                                                      &key (test1 'my-greaterp)
                                                      (test2 'my-greaterp) (begin-n 0))
                                                      ;;ordered-list unordered-list other-items)
  "In  U-lists. INPUTS a list of 1nested-lists, RETURNS  new list ordered by order of nth-list, nth item nested-list in each list. test1 is for inner list test2 is for outer list."
  (let
      ((inner-list-selected-items)
       (sorted-selected-items-lists)
       (other-items)
       (list-n (list-length list-of-1nested-lists))
       (sorted-lists)
       (nth)
       )
    ;;1-MAKE inner-list-selected-items OF (N selected) for each list
    (loop
     for list in list-of-1nested-lists
     for n from begin-n to (+ list-n begin-n)
     do
     (afout 'out (format nil "BEGIN LOOP1 list= ~A n= ~A" list n))
     (cond
      ((listp list)
       (multiple-value-bind (selected ret-n restlists uncked-lists nthlist)
           (get-greatest/least-list-by-funcalled-items function funcargs append-n
                                                       list :test test1)
         (setf inner-list-selected-items (append inner-list-selected-items
                                                 (list (list n selected))))
         ))
      (t (setf other-items (append other-items (list list)))))
     ;;end loop
     )
    (break)
    ;;2-SORT inner-list-selected-items
    (setf sorted-selected-items-lists 
          (sort-lists-by-funcall  #'NTH '(1) 1  inner-list-selected-items :test test2))
    ;;(break)
    ;;3-Use sorted-selected-items-lists to sort uncked-lists
    (loop
     for list in sorted-selected-items-lists
     do
     (setf nth (car list)
           sorted-lists (append sorted-lists (list (nth nth list-of-1nested-lists))))
    ;;end 2nd loop
    )  
    (values  INNER-LIST-SELECTED-ITEMS  other-items)
    ;;end let, defun
    ))  
;;TEST
;;SSSSS START HERE order-1nested-sublists-by-funcall
;; (progn (setf out nil) (order-1nested-sublists-by-funcall #'NTH '(0) 1 '(((E 0.3))    ((D 0.7) (M 0.7) (P 0.7) (S 0.7))      ((C 0.1) (R 0.1))      ((B 0.2) (O 0.2)) ((A 0.4) (L 0.4) (Q 0.4)))))


;; (progn (setf out nil) (order-1nested-sublists-by-funcall #'NTH '(1) 1 '(((E 0.3))    ((D 0.7) (M 0.7) (P 0.7) (S 0.7))      ((C 0.1) (R 0.1))      ((B 0.2) (O 0.2)) ((A 0.4) (L 0.4) (Q 0.4)))))
;;result
#|
((0 (E 0.3)) (1 (S 0.7)) (2 (R 0.1)) (3 (O 0.2)) (4 (Q 0.4)))
NIL|#





;;ORDER-1NESTED-SUBLISTS-BY-NTHLIST-NTH
;;2017
;;ddd
#|(defun order-1nested-sublists-by-nthlist-nth (nthlist nth list-of-1nested-lists
                                                      &key ordered-list unordered-list other-items)
  "In  U-lists. INPUTS a list of 1nested-lists, RETURNS  new list ordered by order of nth-list, nth item nested-list in each list."
  (let*
      ((testgroup (car list-of-1nested-lists))
       (testlist (nth nthlist testgroup))
       (testitem)
       (matchitem (nth nth (nth nthlist (car (last ordered-list)))))
       )
    ;;(break "1")
    (afout 'out (format nil "testgroup= ~A~%testlist= ~A~%matchitem= ~A" testgroup testlist matchitem))

    (when list-of-1nested-lists
     (cond
      ((listp testlist)
         (setf testitem (nth nth testlist))
         (cond
          ((null ordered-list)
           (setf ordered-list (list testgroup)))
          ((>=  testitem matchitem)
           (setf ordered-list (append ordered-list (list testgroup))))
          ;;if < last item in test group put at head of ordered list
          ((= (list-length list-of-1nested-lists) 1) ;;was testgroup) 1)
           (setf ordered-list (append  (list testgroup) ordered-list))
           ;;(break "list-length 1, ordered-list, testgroup")
           )
          (t 
           ;;IF NOT GREATER THAN LAST ITEM RECURSE ON ORDERED-LIST
           (multiple-value-bind (ret-ordered-list ret-unordered-list ret-other-items )
               (order-1nested-sublists-by-nthlist-nth nthlist nth 
                                                      (list testgroup) :ordered-list (butlast ordered-list ))
                                                   ;;was   (butlast ordered-list) :ordered-list ordered-list )
      (afout 'out (format nil "ordered-list= ~A~% .unordered-list= ~A~% .other-items= ~A~% ret-ordered-list= ~A~% ret-unordered-list= ~A~% ret-other-items= ~A~% " ordered-list unordered-list other-items ret-ordered-list ret-unordered-list ret-other-items))
      ;;setf 
           (setf ordered-list (append ret-ordered-list (last ordered-list))
                unordered-list   (append unordered-list (list ret-unordered-list) 
                    other-items (append other-items (list ret-other-items))))
             ))))
      (t (setf other-items (append other-items testlist))))
     ;;(BREAK "ordered-list")
         (afout 'out (format nil "2 ordered-list= ~A" ordered-list))

     ;;IF NOT COMPLETE, RECURSE
     (unless (< (list-length list-of-1nested-lists) 1)
       (multiple-value-bind (ret-ordered-list ret-unordered-list ret-other-items )
               (order-1nested-sublists-by-nthlist-nth nthlist nth 
                                        (cdr list-of-1nested-lists)  :ordered-list ordered-list
                                        :unordered-list unordered-list 
                                        :other-items other-items)
       ;;(break "AFTER UNLESS RETURN")
       (setf ordered-list (append ordered-list ret-ordered-list)
             unordered-list  (append unordered-list ret-unordered-list)
             other-items (append other-items ret-other-items))
       ;;end mvb, unless
       ))
     ;;end when list-of-1nested-lists
     )
             (afout 'out (format nil "END ordered-list=~A~% unordered-list=~A~%  other-items=~A" ordered-list unordered-list other-items))
    (values  ordered-list unordered-list other-items)
    ;;end let, order-1nested-sublists-by-nthlist-nth
    ))|#
;;TEST
;;SSSSS START HERE order-1nested-sublists-by-nthlist-nth
;; (progn (setf out nil) (order-1nested-sublists-by-nthlist-nth 0 1 '(((E 0.3)) ((D 0.7) (M 0.7) (P 0.7) (S 0.7)) ((C 0.1) (R 0.1))  ((B 0.2) (O 0.2)) ((A 0.4) (L 0.4) (Q 0.4)))) (fout out))