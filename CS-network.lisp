;;*************************** CS-network.lisp ****************************
;;




;;RUNCS
;;
;;ddd
(defun runcs ()
  "In CS-network.lisp"
  (let
      ((X)
       )
    (make-cogcs-network) 

    ;;end let, runcs
    ))



;;MAKE-COGCS-NETWORK
;;
;;ddd
(defun make-CS-network (&key csyms-arglists  (init-CS-network-p T))
  "In CS-network.lisp. FINISH??"
  (let
      ((x)
       )

    ;;INITIATE THE ART-NETWORK STRUCTURE
    (when init-bv-network-p 
      (CS-ART-init *n-bot-bvs  *n-out-bvs))

    ;;DEFINE CSYMS
    (make-csyms csyms-arglists)

    ;;end let,make-CS-network
    ))




;;MAKE-CSYMS
;;
;;ddd
(defun make-csyms (csyms-arglists &key (csym-root *default-bvart-rootstr)
                                      (init-bvdims *init-bvart-dims))
  "In CS-network.lisp One csym-arglist item = '(csym bvphrase bvart-loc bvdata  bvdef   :info info :paths paths :default-bvart-rootstr default-bvart-rootstr
    :cur-bvart-dims cur-bvart-dims :separator separator :node-separator node-separator). If a key in above is missing, then make-csym uses it's default value.  Unless bvart-loc, then it uses csym-root, init-bvdims to assign the csym to a bvartsym."
  (let
      ((csyms)
       (csymvals)
       (csym)
       (dim1)
       (rest-dims (cdr *cur-bvart-dims))
       )
    
     (loop
      for csym-arglist in csyms-arglists
      do
      ;;FIND BVARTsym DIMS
      (setf  dim1 (+ (car *cur-bvart-dims) 1)             
             *cur-bvart-dims (append (list dim1) rest-dims))

      ;;MAKE NEW CSYM
      (multiple-value-setq (csymvals csym)
           (apply #'make-csym  csym-arglist))
      (setf csyms (append csyms (list csym)))

      ;;end loop
      )
     csyms
    ;;end mvb,let, make-csyms
    ))
;;TEST
;; (csym bvphrase bvart-loc bvdata  bvdef   :info info :paths paths :default-bvart-rootstr default-bvart-rootstr :cur-bvart-dims cur-bvart-dims :separator separator :node-separator node-separator)
#|
  (make-csyms 
   '((happy "happiness for all" nil (99) "Max happiness for self and others")
     (truth  "truth" nil  (90) "Max truth unless too harmful")
     (knowledge "knowledge" nil (90) "Max knowledge--especially important for top values")
     (self-development "self-development" nil (90) "Max self-development--esp meet top values")
     (integrity "integrity" nil (90) "Max integrity")
     (internal-control "internal control" nil (80) "Internal control by top values---close to integrity")
     (health "health" nil (90) "Physical health for all")
     ))
     |#


#| ORIGINAL PRE 2018-08 VERSION--works
(defun make-csym (csym csphrase csartloc csdata  csdef 
                         &key info BIPATH pole1 pole2 bestpole
                          topath to from wto wfrom SUBITEM ;;to left added 2018
                         (default-csart-rootstr *default-csart-rootstr)
                         (cur-csart-dims *cur-csart-dims)
                         (separator *art-index-separator)
                         (node-separator *art-node-separator)
                         pclist  restkeys  (if-exists-do-nothing-p T))
  "In U-CS-network, csym (sym or string).  creates new csym set to a csymvals = (csname  csphrase  csdata csartloc csdef keywords ). KEYWORDS are :info, :pc,  and :path set to lists. also sets the value (4th of symvals) of csartloc sym (created if not exist) to csym. RETURNS (values csymvals csym). Note1: Does NOT auto advance *cur-CSart-dims. Note2: Can set or get CSdata with setsymval or getsymval functions. pclist = (pole1 pole2 value) causes csphrase to be sritten as pole1 vs pole2 and a list with both poles written after keyword :pc. RESTKEYS allows a list of keylists eg. ((key1 value1)(key2 value2) etc). Should be a standard key such as :to :from :wto :wfrom"
  (let
      ((csname)
       (csymvals)
       )
    (cond
     ((symbolp csym)
      (setf csname (format nil "~a" csym)))
     ((stringp csym)
      (setf csname csym)
      (setf csym (my-make-cs-symbol csname)))
     (t nil))

    (cond
     ;;IF EXISTS ALREAD
     ((and if-exists-do-nothing-p  (boundp csym)
           (listp csym)(> (list-length csym) 2))
      (setf csymvals (eval csym))
      ;;(break "exists")
      )
     ;;IF NOT EXIST
     (T
    ;;SET/CREATE THE CSARTLOC VALUE TO CSYM
    (cond
     ((and (boundp csartloc) csartloc  (listp (eval csartloc)))
      (setsymval csartloc nil csym))
     (csartloc
      (setf csartloc
              (make-dim-symbol csartloc nil))
        (setsymval csartloc nil csym))
     (t (setf csartloc
              (make-dim-symbol  default-csart-rootstr cur-csart-dims))
        (setsymval csartloc nil csym)))     

    ;;MAKE THE NEW CSYMVALS
    (setf  csymvals  (list csname  csphrase csartloc csdata  csdef))
    ;;(break)
    (when pclist
      (setf csymvals (append csymvals (list :pc  pclist))))
    (when info
      (setf csymvals (append csymvals (list :info info))))
    (when BIPATH
      (setf csymvals (append csymvals (list :BIPATH BIPATH))))
     ;;added  topath to from wto wfrom SUBITEM
    (when topath
      (setf csymvals (append csymvals (list :topath topath))))
    (when BIPATH
      (setf csymvals (append csymvals (list :BIPATH BIPATH))))
    (when BIPATH
      (setf csymvals (append csymvals (list :BIPATH BIPATH))))
    (when BIPATH
      (setf csymvals (append csymvals (list :BIPATH BIPATH))))
    (when BIPATH
      (setf csymvals (append csymvals (list :BIPATH BIPATH))))
    (when BIPATH
      (setf csymvals (append csymvals (list :BIPATH BIPATH))))

    (when pole1
      (setf csymvals (append csymvals (list :pole1 pole1))))
    (when pole2
      (setf csymvals (append csymvals (list :pole2 pole2))))
    (when bestpole
      (setf csymvals (append csymvals (list :bestpole bestpole))))

    ;;FOR RESTKEYS -- CAN ADD ANY KEYS
    (when restkeys
      (loop
       for keylist in restkeys
       do
       (setf csymvals (append csymvals (list (car keylist)(second keylist))))
       ))

    ;;SET THE NEW CSYM TO CSYMVALS
    (set csym csymvals)     
    ;;end T, cond
    ))

    (values csymvals csym)
    ;;end let, make-CSYM
    ))
  |#

