;;************************* CSQ-value-rank.lisp *****************************
;;
;; COMPARES PC VALUES TO GET A RANK ORDER
;;
;;
;; INPUT: PC-value-lists (valuename digvalue init-gr-n (rank-val-list)
;;             with minimum initial values (0 to 1.0) or nil (if no initial values)
;; OUTPUT: RANK-ORDER  1 (best) TO RANK-N= num of values OR specified  rank-n.
;; COMPARES N-per-trial values to obtain rankings.
;; ALGORITHM:  
;; STEP 1: DIVIDE INTO INITIAL GROUPS
;;  1-DIVIDE-RANK INTO N-init-groups all values, ranked 1 to N-init-groups
;;  2-DIVIDE EACH GROUP INTO N-groups with n-per-group, and divide 
;;   whole group into ranked subgroups.
;;  3- REPEAT UNTIL GET ABSOLUTE RANKINGS    

;; NO--ABOVE BETTER??
;;  STEP 2: DIVIDE WITHIN INITIAL GROUPS
;;  1-Divide N by N-per-trial groups (could be just one group to rank all within group)
;;  2-First Round (all values): Rank in each group 1 to N-per-trial
;;  3-Second Round (No1 values): 
;;     3.1-Divide all 1s into groups of N-per-trial groups & rank as above
;;     3.2-Repeat with all new 1's until all done.
;;  4-Third Round (No:


;;RANK-VALUES-LIST
;;
;;ddd
(defun rank-values-list (value-dig-list &key (num-groups 5))
  "In CSQ-value-rank.lisp"
  (let*
      ((ranked-vals)
       )
    

    ;;end let, rank-values-list
    ))



;;RANK-VALUES
;;
;;ddd
(defun rank-values (value-list &key (num-groups 5))
  "In CSQ-value-rank.lisp"
  (let*
      ((ranked-vals)
       )
    

    ;;end let, rank-values-list
    ))