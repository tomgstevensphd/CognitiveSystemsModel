;;************************* test-functions10.lisp ****************************


;; (draw-equations-curves  '((arcline  `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1 3 .8  2) (2 2  1.0  prev-y) 10 ("cyc1" "cyc2")  "Eq1" 1)  (arcline2  `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1 3 .8  2) (2 2  (add-expdelta 1.5 0 1.0)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1))   :multiple-graphs-p T  :y-multiplier 10 :x-multiplier 10  :x-string "  This is X String  " :y-string " y string vertically" :return-output-p NIL)

;;(draw-equations-curves  '((arcline1  `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (0.5 1.0  1.5  2.0) (0.5 0.5  (add-expdelta 2.0 0 1.5)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1))   :multiple-graphs-p T  :y-multiplier 10 :x-multiplier 10  :x-string "  This is X String  " :y-string " y string vertically")

;;mult-expdelta
#|
 (draw-equations-curves
  '(
       (arcline1  `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  0.1  2.0) (1.0 1.0 0.1   prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1) 
    (arcline2  `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  0.05  2.0) (1.0 1.0  0.05  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
  ;;  (arcline3 `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  1.1  2.0) (1.0 1.0  (mult-expdelta 1.5 0 1.1)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
  ;;  (arcline4  `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  1.1  2.0) (1.0 1.0  (mult-expdelta 1.5 0 1.1)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    (arcline5 `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  1.1  2.0) (1.0 1.0  (add-expdelta 1.5 0 1.1)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    (arcline5  `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  1.01  2.0) (1.0 1.0  (add-expdelta 1.01 0 1.1)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    (arcline6  `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  1.01  2.0) (1.0 1.0  (add-expdelta 1.01 0.1 1.001)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    (arcline7  `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  0.02  2.0) (1.0 1.0  (add-expdelta 1.0 0.01 1.01)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    (arcline8 `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  0.001  2.0) (1.0 1.0 (add-expdelta 1.0 0.001 1.000)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1) 
  ) :multiple-graphs-p T  :y-multiplier 10.0 :x-multiplier 10.0  :x-string "  This is X String  " :y-string " y string vertically")|#

#|
;; VARY EXP (If base is < 1.0, then SMALLER the EXP, the LARGER the RESULT)
 (draw-equations-curves
  '(
    (arcline8 `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  0.0001  2.0) (1.0 1.0 (add-expdelta 0.9 0.001 0.0)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1) 
    (arcline8 `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  0.0001  2.0) (1.0 1.0 (add-expdelta 0.8 0.001 0.0)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    (arcline8 `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  0.0001  2.0) (1.0 1.0 (add-expdelta 0.7 0.001 0.0)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    (arcline8 `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  0.0001  2.0) (1.0 1.0 (add-expdelta 0.6 0.001 0.0)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    (arcline8 `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  0.0001  2.0) (1.0 1.0 (add-expdelta 0.5 0.001 0.0)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    ) :multiple-graphs-p T  :y-multiplier 10.0 :x-multiplier 10.0  :x-string "  This is X String  " :y-string " y string vertically")|#

#|
;; VARYING INITIAL DY/DX (SLOPE)  HAD LITTLE EFFECT

;;USING HIGH exp and CHANGING C produces good change in curves--tho these all NOT very rounded.
 (draw-equations-curves
  '(
    (arcline8 `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  0.0001  2.0) (1.0 1.0 (add-expdelta 0.9 0.001 0.0)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1) 
    (arcline8 `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  0.0001  2.0) (1.0 1.0 (add-expdelta 0.9 0.001 0.01)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    (arcline8 `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  0.0001  2.0) (1.0 1.0 (add-expdelta 0.9 0.001 0.02)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    (arcline8 `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  0.0001 2.0) (1.0 1.0 (add-expdelta 0.9 0.001 0.03)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    (arcline8 `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  0.0001  2.0) (1.0 1.0 (add-expdelta 0.9 0.001 0.1)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    ) :multiple-graphs-p T  :y-multiplier 10.0 :x-multiplier 10.0  :x-string "  This is X String  " :y-string " y string vertically")|#

#|
;;TRY MULT-EXPDELTA
;; ADDING C (.001 < C <  .3)  MAKES A BIG DIFFERENCE IN STEEPNESS, MUST KEEP EXP SMALL (< 1.1?)
 (draw-equations-curves
  '(
    (arcline8 `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  .01  2.0) (1.0 1.0 (mult-expdelta 1.01 0.001 1.01)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1) 
    (arcline8 `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  .05  2.0) (1.0 1.0 (mult-expdelta 1.05 0.01 1.01)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    (arcline8 `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  .1  2.0) (1.0 1.0 (mult-expdelta 1.05 0.1 1.01)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    (arcline8 `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  .1 2.0) (1.0 1.0 (mult-expdelta 1.05 0.2 1.01)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    (arcline8 `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  .1  2.0) (1.0 1.0 (mult-expdelta 1.05 0.3 1.01)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    ) :multiple-graphs-p T  :y-multiplier 10.0 :x-multiplier 10.0  :x-string "  This is X String  " :y-string " y string vertically")|#
;; FOR MULT-EXPDELTA
;;INITIAL-DELTA MOSTLY AFFECTS RAPIDITY OF STEEPNESS CLIMB
;; KEEP INITIAL VALUES (1.0 < INITIAL-DELTA < 1.3) 
#|
(draw-equations-curves
  '(
    (arcline1  `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  .1  2.0) (1.0 1.0 (mult-expdelta 1.05 0.1 1.01)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    (arcline2  `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  .1  2.0) (1.0 1.0 (mult-expdelta 1.05 0.1 1.05)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    (arcline3 `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  .1   2.0) (1.0 1.0 (mult-expdelta 1.05 0.1 1.1)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    (arcline4 `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  .1  2.0) (1.0 1.0 (mult-expdelta 1.05 0.1 1.2)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    (arcline5  `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  .1  2.0) (1.0 1.0 (mult-expdelta 1.05 0.1 1.3)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    ) :multiple-graphs-p T  :y-multiplier 10.0 :x-multiplier 10.0  :x-string "  This is X String  " :y-string " y string vertically")
|#

;; WHEN MULT-EXPDELTA
;;IF MODIFY INITIAL DY/DX (SLOPE), KEEP INITIAL-DELTA SMALL (< 1.05 ?)
;; GOOD FOR CHANGING CURVATURE 
#|
(draw-equations-curves
  '(
    (arcline1  `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  .1  2.0) (1.0 1.0 (mult-expdelta 1.05 0.1 1.01)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    (arcline2  `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  .05  2.0) (1.0 1.0 (mult-expdelta 1.05 0.1 1.01)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    (arcline3 `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  .1   2.0) (1.0 1.0 (mult-expdelta 1.05 0. 1.01)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    (arcline4 `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  .15  2.0) (1.0 1.0 (mult-expdelta 1.05 0.1 1.01)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    (arcline5  `(+ (* ,dy/dx (- ,x2  ,x1)) ,y1) (x1 x2 dy/dx y1) (1.0 2.0  .2  2.0) (1.0 1.0 (mult-expdelta 1.05 0.1 1.01)  prev-y) 10 ("cyc1" "cyc2")  "Eq2" 1)
    ) :multiple-graphs-p T  :y-multiplier 10.0 :x-multiplier 10.0  :x-string "  This is X String  " :y-string " y string vertically")
|#