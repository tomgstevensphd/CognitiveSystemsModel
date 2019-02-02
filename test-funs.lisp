;; ******************* temp4/test-funs.lisp


;;h = ymax
(defun testfun (x y h  nx  delta)
  (let*
      ((dx 1.0)
       (dy)
       (points-list (list (list :N 1 (list x y))))
       )
    (loop
     for n from 1 to 100
     do
    (cond
     ((< (* n delta) h)
      (return))
     (t (setf delta (* 0.8 delta))))
    ;;end loop
    )

    (loop
     for n from 1 to nx
     do
     (cond
      ((= n nx)
       (setf dy (- h y)
             y  h
             x (+ x dx)
             points-list (append points-list (list (list :N n (list x y)))))
       )
      (t
       (setf dy (* delta (- h y))
             y (+ y dy)
             x (+ x dx)
             points-list (append points-list (list (list :N n (list x y)))))))
    ;;end loop
    )
    (setf *temp-points points-list)
    (pprint *temp-points)
    points-list
    ;;end let, defun 
    ))
;;TEST
;;  (testfun 0  0 2.0 10 0.4)
;; result= ((:N 1 (0 0)) (:N 1 (1.0 0.8)) (:N 2 (2.0 1.28)) (:N 3 (3.0 1.568)) (:N 4 (4.0 1.7408)) (:N 5 (5.0 1.84448)) (:N 6 (6.0 1.906688)) (:N 7 (7.0 1.9440128)) (:N 8 (8.0 1.9664077)) (:N 9 (9.0 1.9798446)) (:N 10 (10.0 2.0)))     
;;  (testfun 0  0 2.0 10 0.3)     
;; result= ((:N 1 (0 0)) (:N 1 (1.0 0.6)) (:N 2 (2.0 1.02)) (:N 3 (3.0 1.314)) (:N 4 (4.0 1.5198001)) (:N 5 (5.0 1.6638601)) (:N 6 (6.0 1.7647021)) (:N 7 (7.0 1.8352915)) (:N 8 (8.0 1.8847041)) (:N 9 (9.0 1.9192929)) (:N 10 (10.0 2.0)))