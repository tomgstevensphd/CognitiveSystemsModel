;;************************** csq-trees.lisp *****************************
;;
;; Symbol trees representing CSQ PC results.
;; 1. Value ratings and rankings within ratings are one important dimension
;;        PC level set by same value rating. Rank inside level by rank.
;; 2. Connctions between levels by new personal connection ratings.

;; PCSYM=  ("KIND" "KIND vs UKIND" CS2-1-1-99 NIL NIL :PC ("KIND" "UKIND" 1 NIL) :POLE1 "KIND" :POLE2 "UKIND" :BESTPOLE 1 :BIPATH ((POLE1 NIL MOTHER NIL) (POLE1 NIL BEST-M-FRIEND NIL) (POLE2 NIL FATHER NIL)) :va "0.917" :RNK "2")
;;ELMSYM= ("BEST-M-FRIEND" "best-m-friend" ELM4-1-1-99 NIL "JOE" :BIPATH (((BEST-M-FRIEND NIL (FEMA (POLE2) NIL)))))
;; *csq-data-list = (:PCSYM-ELM-LISTS ((KIND (MOTHER FATHER BEST-M-FRIEND (KIND KIND :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12))) (FEMA (MOTHER BEST-M-FRIEND BEST-F-FRIEND (FEMA FEMA :SINGLE "Very important" "0.750" 9 1 12 9 SCORED-NORMAL PRIORITY12))) (NICE (MOTHER BEST-F-FRIEND FATHER (NICE NICE :SINGLE "One of the most important things in my life" "0.917" 11 1 12 11 SCORED-NORMAL PRIORITY12)))))



;;MAKE-PC-TREE
;;2017
;;ddd
#|(defun make-pc-tree (pc-list &key   )
  "In  csq-trees, INPUT: A list of pcsyms or pcsym-strs. RETURNS (values pc-tree-list ...) Where pc-tree-list= A nested list in which each level consists of a list of prioritized (or not) symbols (pcsym).  
    Note: Each symbol (pcsym) is includes (name-str poles location (cs2-1-1-99)  with keys :pole1 :pole2 :bestpole :va :RNK. The nest/tree level is determined by the csval and the sort order within the level by the csrank. 
    SUBTREES (next nest level):  If a pc has a :BIPATH subkey :sub, then the sub pcs are placed in a list to the right of the pc."
  (let
      ((x)
       )


    (cond
     (
      )
     (
      )
     (t nil))

    (loop
     for 
     do
     
     ;;end loop
     )

    (values    )
    ;;end let, make-pc-tree
    ))|#
;;TEST
;; (progn (setf *valtest1 '(happy  health (truth knowledge integrity (self-man (time-man goalset) interp (romance friends family ) career (contribute income  fun) impact )))) 
