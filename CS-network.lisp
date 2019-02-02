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
      (cs-init *n-bot-bvs  *n-out-bvs))

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


;;MAKE-CSYM
;;modified 2018-08
;;
;;ddd
(defun make-csym (csym csphrase csart-loc csdata  csdef 
                         &key info bipaths pole1 pole2 bestpole
                          topath from wto wfrom  ;;to left added 2018
                         (default-csart-rootstr *default-csart-rootstr)
                         (cur-csart-dims *cur-csart-dims)
                         (separator *art-index-separator)
                         (node-separator *art-node-separator)
                         pclist  restkeys  (if-exists-do-nothing-p T)
                         (track-all-csyms  '*ALL-CSYMS))
  "In U-CS-network, csym (sym or string).  creates new csym set to a csymvals = (csname  csphrase  csdata csart-loc csdef keywords ). KEYWORDS are :info, :pc,  and :path set to lists. also sets the value (4th of symvals) of csart-loc sym (created if not exist) to csym. RETURNS (values csymvals csym). Note1: Does NOT auto advance *cur-CSart-dims. Note2: Can set or get CSdata with setsymval or getsymval functions. pclist = (pole1 pole2 value) causes csphrase to be sritten as pole1 vs pole2 and a list with both poles written after keyword :pc. RESTKEYS allows a list of keylists eg. ((key1 value1)(key2 value2) etc). Should be a standard key such as :to :from :wto :wfrom NOTE:  :SUBITEM standard key is useful to put INSIDE a value-list for any other key (eg. :BIPATHS '(\"MOTHER\" NIL :SUBITEM \"Jane Doe\")). When track-all-csyms, appends new csyms to *ALL-CSYMS"
  (let
      ((csname)
       (csymvals)
       ;;added
     (rest-keys '( :pole1 :pole2 :bestpole :bipaths :topath  :from :wto :wfrom :info))
      (rest-keyvalues (list pole1 pole2 bestpole bipaths topath from wto wfrom info))
      (csdbsym-str)
      (old-keylist)
      (new-keylist)
      (new-value)
      ;;end added
       )
    (cond
     ((symbolp csym)
      (setf csname (format nil "~a" csym)))
     ((stringp csym)
      (setf csname csym)
      (setf csym (my-make-symbol csname)))
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
    ;;SET/CREATE THE CSART-LOC VALUE TO CSYM
    (cond
     ((and (boundp csart-loc) csart-loc  (listp (eval csart-loc)))
      (setsymval csart-loc nil csym))
     (csart-loc
      (setf csart-loc
              (make-dim-symbol csart-loc nil))
        (setsymval csart-loc nil csym))
     (t (setf csart-loc
              (make-dim-symbol  default-csart-rootstr cur-csart-dims))
        (setsymval csart-loc nil csym)))     

    ;;MAKE THE NEW CSYMVALS
    (setf  csymvals  (list csname  csphrase csart-loc csdata  csdef))
    ;;(break)
    (when pclist
      (setf csymvals (append csymvals (list :pc  pclist))))

    ;;MODIFY KEYLIST
    (when csymvals
     (loop
      for key in rest-keys
      for value in rest-keyvalues
      do
      (let*
          ((keylist)
           )
        (cond
         (value   
          (setf new-keylist 
                (get-set-append-delete-keyvalue key value :old-keylist  old-keylist
                                                :append-value-p T :keyloc-n 9 :val-nth 1))
          (set csym new-keylist)
          ;;end cond
          ))
        ;;end let,loop,when, t cond
        )))

    ;;replaced with loop
#|    (when info
      (setf csymvals (append csymvals (list :info info))))
    (when bipaths
      (setf csymvals (append csymvals (list :bipaths bipaths))))
     ;;added  topath to from wto wfrom SUBITEM
    (when topath
      (setf csymvals (append csymvals (list :topath topath))))
    (when bipaths
      (setf csymvals (append csymvals (list :bipaths bipaths))))
    (when bipaths
      (setf csymvals (append csymvals (list :bipaths bipaths))))
    (when bipaths
      (setf csymvals (append csymvals (list :bipaths bipaths))))
    (when bipaths
      (setf csymvals (append csymvals (list :bipaths bipaths))))
    (when bipaths
      (setf csymvals (append csymvals (list :bipaths bipaths))))

    (when pole1
      (setf csymvals (append csymvals (list :pole1 pole1))))
    (when pole2
      (setf csymvals (append csymvals (list :pole2 pole2))))
    (when bestpole
      (setf csymvals (append csymvals (list :bestpole bestpole))))
|#
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
    (when track-all-csyms
      (setf *ALL-CSYMS (append *ALL-CSYMS (list csym))))
    (values csymvals csym)
    ;;end let, make-CSYM
    ))
;;TEST
;; (make-csym 'cststsym "cs test sym" 'cs2-1-1-1  '(5 "data") "test definition" :pole1 "pole1" :pole2 "pole2" :bestpole 1  :info "more info")
;; (make-csym 'verysilly  "cs test sym" 'cs3-1-1-1  '(5 "data") "test definition" :info "more info")
;;works=  CSTSTSYM  ("CSTSTSYM" "cs test sym" CS2-1-1-1 (5 "data") "test definition" :INFO "more info")
;;also CL-USER 148 > CS2-1-1-1  =   (CS2-1-1-1 NIL NIL CSTSTSYM NIL)

;;  (make-csym 'new-csym "newsymname" nil  nil  nil  :info "more info")
;;  VVV

;;MODIFIED FOR PC AFTER THESE TESTS
;;  (make-csym 'cststsym "cs test sym" 'cs2-1-1-1  '(5 "data") "test definition" :info "more info")
;; works= ("cststsym" "cs test sym"  cs2-1-1-1 (5 "data") "test definition" :info "more info")    cststsym
;; then: CL-USER 29 > CS2-1-1-1 =  ("CS" (2 1 1 1) NIL CSTSTSYM NIL)
;;
;;(make-csym 'cststsym "cs test sym" 'cs2-11-1-1  '(4 "data") "test definition" :info "more info")
;;works= ("cststsym" "cs test sym" cs2-11-1-1 (4 "data") "test definition" :info "more info")   cststsym
;;also CL-USER 33 > CS2-11-1-1  = ("CS" (2 11 1 1) NIL CSTSTSYM NIL)
;;  
;;depends on
;; (make-art-symdims-list 'CStst1-1-1-1)   = ("CSTST" (1 1 1 1))  "CSTST"  (1 1 1 1) "1-1-1-1"

#| ORIGINAL PRE 2018-08 VERSION--works
(defun make-csym (csym csphrase csart-loc csdata  csdef 
                         &key info bipaths pole1 pole2 bestpole
                          topath to from wto wfrom SUBITEM ;;to left added 2018
                         (default-csart-rootstr *default-csart-rootstr)
                         (cur-csart-dims *cur-csart-dims)
                         (separator *art-index-separator)
                         (node-separator *art-node-separator)
                         pclist  restkeys  (if-exists-do-nothing-p T))
  "In U-CS-network, csym (sym or string).  creates new csym set to a csymvals = (csname  csphrase  csdata csart-loc csdef keywords ). KEYWORDS are :info, :pc,  and :path set to lists. also sets the value (4th of symvals) of csart-loc sym (created if not exist) to csym. RETURNS (values csymvals csym). Note1: Does NOT auto advance *cur-CSart-dims. Note2: Can set or get CSdata with setsymval or getsymval functions. pclist = (pole1 pole2 value) causes csphrase to be sritten as pole1 vs pole2 and a list with both poles written after keyword :pc. RESTKEYS allows a list of keylists eg. ((key1 value1)(key2 value2) etc). Should be a standard key such as :to :from :wto :wfrom"
  (let
      ((csname)
       (csymvals)
       )
    (cond
     ((symbolp csym)
      (setf csname (format nil "~a" csym)))
     ((stringp csym)
      (setf csname csym)
      (setf csym (my-make-symbol csname)))
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
    ;;SET/CREATE THE CSART-LOC VALUE TO CSYM
    (cond
     ((and (boundp csart-loc) csart-loc  (listp (eval csart-loc)))
      (setsymval csart-loc nil csym))
     (csart-loc
      (setf csart-loc
              (make-dim-symbol csart-loc nil))
        (setsymval csart-loc nil csym))
     (t (setf csart-loc
              (make-dim-symbol  default-csart-rootstr cur-csart-dims))
        (setsymval csart-loc nil csym)))     

    ;;MAKE THE NEW CSYMVALS
    (setf  csymvals  (list csname  csphrase csart-loc csdata  csdef))
    ;;(break)
    (when pclist
      (setf csymvals (append csymvals (list :pc  pclist))))
    (when info
      (setf csymvals (append csymvals (list :info info))))
    (when bipaths
      (setf csymvals (append csymvals (list :bipaths bipaths))))
     ;;added  topath to from wto wfrom SUBITEM
    (when topath
      (setf csymvals (append csymvals (list :topath topath))))
    (when bipaths
      (setf csymvals (append csymvals (list :bipaths bipaths))))
    (when bipaths
      (setf csymvals (append csymvals (list :bipaths bipaths))))
    (when bipaths
      (setf csymvals (append csymvals (list :bipaths bipaths))))
    (when bipaths
      (setf csymvals (append csymvals (list :bipaths bipaths))))
    (when bipaths
      (setf csymvals (append csymvals (list :bipaths bipaths))))

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

