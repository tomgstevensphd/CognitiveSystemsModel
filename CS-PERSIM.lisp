;;************************************ BV-PERSIM.lisp ***************************
;;
;;Author:  Tom G. Stevens PhD
;;Date: 2014
;;ALL MAJOR CLASSES WITHIN THE SHAQ PERSIM MODEL
;; SHAQ = Success and Happiness Attributes Questionnaire
;; CARES = Computer Assisted Assessment and Referral System
;;
(in-package "CL-USER")
;;
;;put in all key files
;;  (my-config-editor-after-start)
#|
;;TEMPLATES
;;
;;SLOTS
   (
    :initarg :
    :accessor 
    :documentation "
    )

;; class QUESTION SLOTS (includes superordinate slots)
;;id info
NAME ;;scalevar
NAME-STRING ;;scalevar-str
LABEL  ;;spss label
DESCRIPTION  ;;long descr
PREVIOUS-NAMES  ;;previous java names list
OBJECT-DOCS
;;hierarchy info
PARENTS
CHILDREN 
CLASS-INSTANCE  ;;class inst auto-created
CLASS-INSTANCES
ASSESSMENT-TYPE
COMPOSITE-SCALE-P
;;data fields
DATA-NAME  ;;omit bec same as name
DATA-LABEL   ;;omit
DATA-DESCRIPTION   ;;omit
;;scale info
IS-SCALE-P  ;;T
SCALE-CLASSES  ;;omit
SCALE-GROUP-NAME  
SCALE-GROUP-DESCRIPTION ;;nil
SCALE-INSTANCE  ;;omit bec same as class inst
SCALE-INSTANCES ;;omit bec same as class inst
SUBSCALES ;;a list
SCALE-QUESTIONS  ;;a list of qvars
NUM-QUESTIONS ; integer
FIRING-ORDER-LIST  'quest-order  ;;means use scale-questions, unless dif
INCL-IN-RESULTS  T ;;or nil
spss-match ;;t
quest-selection-type  ;;single-selection
reverse-scored-p  ;;nil
scoring-formula  ;; +
raw-score
relative-score

;;help info
HELP-INFO
HELP-LINKS
HELP-RESOURCES

;;question info?? OMIT THESE for now
QUESTION 
QUESTION-INSTANCE
;;edit info re this class
UPDATED-DATE

|#

(defclass top-class ()
  ((name
    :initarg :name
    :accessor name
    :initform "Initial top-class name"
    :documentation "Class name symbol")
   (name-string
    :initarg :name-string
    :accessor name-string
    :type  :String
    :initform "name-string"
    :documentation "Class name-string")
   (label
      :initarg :label
    :accessor label
    :initform "label"
    :documentation "Brief description: eg SPSS")
   (title
      :initarg :title
    :accessor title
    :initform "title"
    :documentation "Formal good grammer name for display.")
   (description
      :initarg :description
    :accessor description
    :initform "Initial description"
    :documentation "description")
   (object-docs
     :initarg :object-docs
    :accessor object-docs
    :initform "Put class doc here."
    :documentation "Specific class or instance object-docs")
   (class-instance
    :initarg  :classInstance
    :accessor classInstance
    :initform '*persim-inst
    :documentation "Default class instance SYMBOL--usually *classname"
    )
   (parents
     :initarg :parents
    :accessor parents
    :type :list
     :initform nil
    :documentation "Parent/superclass classes")
   (children
     :initarg :children
    :accessor children
    :type :list
     :initform nil
    :documentation "Children/subclass classes")
   (class-instances
    :initarg :class-instances
    :type :list
    :initform nil
    :accessor class-instances
    :documentation "class-instances-must use this slot for all subclass instances or can't use my accessor methods/functions")
   (top-class-var1
    :initarg :top-class-var1
    :accessor top-class-var1
    :allocation :class
    :initform nil
    :documentation "Misc var to be used only by top-class.")
   ))

;;MAKE CLASS INSTANCE
;;moved bec of deliver errors (defparameter  *top-class-inst (make-instance 'top-class))


;;PERSIM CLASS
;;ddd
;;
(defclass PERSIM (top-class)
  ((updated-date
    :initarg :updated-date
    :accessor updated-date
    :type :string
    :documentation "Date (string) of last update/modifcation (only use after initial rollout?)."
    )
   (previous-names
    :initarg :previous-names
    :accessor previous-names
    :documentation "Class previous-name (list of strings)."
    )
   (data-name-string
    :initarg :data-name-string
    :accessor data-name-string
    :type  :String
    :initform "data-name-string"
    :documentation "SPSS or other data name--if different from name-string.")   
   (data-label
    :initarg :data-label
    :accessor data-label
    :documentation "Class data-label."
    )
   (data-description
    :initarg :data-description
    :accessor data-description
    :documentation "Class data-description")
   
    ;;end slots
   )
  ;; class options
  (:default-initargs )
 ( :documentation  "In \".lisp, Top PERSIM class.")
  ;;end class
  )
;;MAKE CLASS INSTANCE
;;moved bec of deliver errors (defparameter  *persim-inst  (make-instance 'persim))

;;*PERSIM-INST  (PERSIM INSTANCE--LATER PUT IN FUNCTION??)
;;ddd
;;
#| error key word documentation in list ??

(defparameter  *persim-inst  (make-instance 'persim 
                                           :name "PERSIM"
                                           :read-name "PERSIM"
                                           :description  "PERSIM - the Top Class of the PERSIM Model"
                                  ))|#

;;PERSIM-SYSTEM
;;
;;ddd
(defclass per-system (persim)
  (
    (system
    :initarg :system
    :accessor system
    :documentation "system"
    )
    (system-list
    :initarg :system-list
    :accessor system-list
    :documentation "system-list"
    )  
    ))
;;MAKE CLASS INSTANCE
;;moved bec of deliver errors
#|(defparameter  *per-system-inst  
  (make-instance 'per-system
     ::system-list '(BIO  VALUES-THEMES BELIEFS SKILLS-CONFIDENCE
       INTERPERSONAL ACAD-LEARNING  CAREER-INTEREST  OUTCOME)))|#


;;ASSESSMENT
;;ddd
(defclass assessment (persim)
  (
    (assessment-type
    :initarg :assessment-type
    :accessor assessment-type
    :initform "questionnaire"
    :documentation "Assessment-type--eg. questionnaire, scale, etc."
    ) 
    (scale-group-name
    :initarg :scale-group-name
    :accessor scale-group-name
    :documentation "Scale-group-name, eg Interpersonal Scales, can be string or eval sym to string"
    ) 
    (scale-group-description
    :initarg :scale-group-description
    :accessor scale-group-description
    :documentation "Scale-group-description--describes meaning, content etc of scale group category"
    ) 
    (scale-classes
    :initarg :scale-classes
    :accessor scale-classes
    :type :list
    :documentation "Subordinate (non-subscale) assessment/scale classes list"
    ) 
    (scale-instances
    :initarg :scale-instances
    :accessor scale-instances
    :type :list
    :documentation "Subordinate (non-subscale) assessment/scale instances list"
    ) 
  #|   /**
   * Question frame and multi-question related variables
   */|#
   ;;was public static int totalQuestions = 18;
   (num-questions  ;was total-questions or totalQuestions
    :initarg :num-questions
    :accessor num-questions
    :documentation "Number of questions"
    )
   #|was  //public  PCategory currentQuestInstance;
 ;;was public static PCategory[] questionInstancesArray = new PCategory[totalQuestions];|#
   (scale-questions
    :initarg :scale-questions
    :accessor scale-questions
    :type :list
    :documentation "List of question names (in order of numbers/firing?)"
    )
   #|  /**
   * set the frame firing order to [0] if it is to be replaced by
   * the defaultFiringOrder method--see below.
   */|#
   ;;was  public static int[] firingOrderArray = MyMethods.makeAscendingArray(1,totalQuestions);
   (firing-order-list
    :initarg :firing-order-list
    :accessor firing-order-list
    :documentation "Default firing-order-list--though normally would just be ordered by question position in scale-questions list."
    )
    (incl-in-results-p
    :initarg :incl-in-results-p
    :accessor incl-in-results-p
    :initform T
    :type :boolean
    :documentation "Is this scale/etc included in the user's results printout? Default is T."
    ) 
    (spss-match
    :initarg :spss-match
    :accessor spss-match
    :initform T
    :type :boolean
    :documentation "Does this variable match an spss var in 2009 analysis?"
    )
    (quest-selection-type
    :initarg :quest-selection-type
    :accessor quest-selection-type
    :initform :single-selection
    :documentation "Is the question :single-selection or :multiple-selection type?"
    )
    (reverse-scored-p
    :initarg :reverse-scored-p
    :accessor reverse-scored-p
    :initform NIL
    :type :boolean
    :documentation "Is the scale or question reverse scored?"
    )
    (scoring-formula
    :initarg :scoring-formula
    :accessor scoring-formula
    :initform '+
    :documentation "The formula for scoring, either +, - or a list."
    )
    (raw-score
   :initarg :raw-score
    :accessor raw-score
    :documentation "The raw-score"
    ) 
    (relative-score
   :initarg :relative-score
    :accessor relative-score
    :documentation "The relative-score is raw-score / num scale points for a question. The scale relative-score is the mean of question rel scores. "
    )
    (mean-score
     :initarg :mean-score
    :accessor mean-score
    :documentation "The  mean-score"
    )
    (variance
     :initarg :variance
    :accessor variance
    :documentation "The  variance"
    )
    (standard-deviation
    :initarg :standard-deviation
    :accessor standard-deviation
    :documentation "The standard-deviation"
    )
    (sample-N
    :initarg :sample-N
    :accessor sample-N
    :documentation "N of sample for mean-score,etc."
    )
    (range
    :initarg :range
    :accessor range
    :documentation "The range"
    )
    (max-possible-value
    :initarg :max-possible-value
    :accessor max-possible-value
    :documentation "Maximum score value possible for the scale"
    )
    (min-possible-value
    :initarg :min-possible-value
    :accessor min-possible-value
    :documentation "Minimum score value possible for the scale"
    )
    (question-data-lists
    :initarg :question-data-lists
    :accessor question-data-lists
    :documentation "Question-data-lists= For SHAQ, list of lists (list q-num qvar  relative-score score max-score reverse-score-p)"
    )
 #|
    (
    :initarg :
    :accessor 
    :documentation ""
    ) 
    (
    :initarg :
    :accessor 
    :documentation ""
    ) |#
  (frame
    :initarg :frame
    :accessor frame
    :documentation "frame interface for class"
    )
   (frame-title
    :initarg :frame-title
    :accessor frame-title
    :documentation "Default frameTitle for the frame to present the questions (one at a time)"
    )
   ;; was public static int frameDimWidth = 805;
   (frame-dim-width
    :initarg :frame-dim-width
    :accessor frame-dim-width
    :initform 805
    :documentation "Default frame-dim-width"
    )
   ;;was public static int frameDimHeight = 460;
   (frame-dim-height
    :initarg :frame-dim-height
    :accessor frame-dim-height
    :initform 460
    :documentation "Default frame-dim-height"
    )
   (frame-created-p
    :initarg :frame-created-p
    :accessor frame-created-p
    :type :boolean
    :documentation "isFramesCreated - BOOLEAN"
    )
   (help-priority
    :initarg :help-priority
    :accessor help-priority
    :documentation "Priority area for self-help."
    )
   (help-info
    :initarg :help-info
    :accessor help-info
    :documentation "Related self-help information."
    )
   (help-links
    :initarg :help-links
    :accessor help-links
    :documentation "List of  Internet help links"
    )
   (help-resources
    :initarg :help-resources
    :accessor help-resources
    :documentation  "List of  helpful resources (eg. books, organizations, etc."
    )
   ;;end slots
   )
  (:default-initargs )
  (:documentation "Collection of scales, etc. Eg. Interpersonal scales")
  ;;end class
  )
   
;;MAKE CLASS INSTANCE
;;moved bec of deliver errors

                                       
;;SCALE CLASS
;;
;;ddd
(defclass scale (assessment)
  ((scale-name
    :initarg :scale-name
    :accessor scale-name
    :type :string
    :documentation "Scale name string"
    )
   ( is-scale-p
     :initarg  :is-scale-p
     :accessor is-scale-p
     :initform T
     :type :boolean
     :documentation "Does this class represent one scale? --  BOOLEAN."
     )
   (scale-instance
    :initarg :scale-instance
    :accessor scale-instance
    :documentation "Instance for one scale or subscale. *scalename is default."
    )
   (subscales
    :initarg :subscales
    :accessor subscales
    :documentation "List of scale subordinate or composite subscales ."
    )
   (composite-scale-p
    :initarg :composite-scale-p
    :accessor composite-scale-p
    :type :boolean
    :documentation "Is this scale composed of questions from other scales?"
    )
 
   ;;end slots
   )
  ;; class options
  (:default-initargs )
  (:documentation  "For Questionnaire Scales and Subscales.")
  ;;end class
  )
;;*SCALE-INST  (for access to class defaults, etc)
;; scale-inst MUST come before subclasses
;;ddd

#|
(q-inst q-num q-text-inst q-data-type q-ans-panel q-inst-array 
                                     q-frame-title q-fr-width q-fr-height)
|#


;; SUBSCALE
;;
;;ddd
(defclass subscale (scale)
  ()
  (:documentation  "For Questionnaire Subscales that are a subset of a scale.")
  )
;;MAKE CLASS INSTANCE
(defparameter *subscale-inst (make-instance 'subscale
                                           :name "*subscale-inst"
                                           :name-string "*subscale-inst"
                                           :scale-instance '*subscale-inst))

;;COMPOSITE-SCALE
;;
;;ddd
(defclass composite-scale (scale)
  ()
  (:documentation  "For Questionnaire scales composed of items in other scales.")
  )
;;MAKE CLASS INSTANCE
(defparameter *composite-scale-inst (make-instance 'composite-scale
                                           :name "*composite-scale-inst"
                                           :name-string "*composite-scale-inst"
                                           :scale-instance '*composite-scale-inst))

;;MULTI-ANSWER-SCALE
;;
;;ddd
(defclass  multi-answer-scale (assessment)
    ((answer-items
      :initarg :answer-items
      :accessor answer-items
      :type :list
      :documentation "List of answer item qvars, each is a frame answer in list of alternatives."
      )
     (scale-name
      :initarg :scale-name
      :accessor scale-name
      :type :list
      :documentation "Scale name"
      )
     )
       (:documentation  "A scale that consists of multiple subscales which are normally selected, with boolean values, and given separate data variables in analyses. Eg. A Ethnicity (asian..etc)  scale allowing multiple or single choice from a number of answers, where each answer is a data-variable = subscale. Normally the name is the same as a CATEGORY name in an overall list of all question variables (eg *SHAQ-question-variable-lists). NOT usually scored as part of a larger list. NOTE: quest-selection-type is :single-selection by default, so MUST CHANGE TO :MULTIPLE-SELECTION."
     ))
;;MAKE CLASS INSTANCE



;;TEXT-ANSWER-QUESTION
;;
;;ddd
(defclass text-answer-question (assessment)
  ((user-answer-text
      :initarg :user-answer-text
      :accessor user-answer-text
      :type :string
      :documentation "User answer text"
      )
   (user-answer-data
      :initarg :user-answer-data
      :accessor user-answer-data
      :documentation "user-answer-data"
      )
   )
 )
;;MAKE CLASS INSTANCE

;;NO: MAKE THIS A TYPE OF SCALE--EASIER FOR PROCESSING??    
;;NO-SCALE
;;
;;ddd  
#|(defclass no-scale (assessment)
  ((scale-name
    :initarg :scale-name
    :accessor scale-name
    :type :string
    :documentation "Scale name string"
    )
   ( is-scale-p
     :initarg  :is-scale-p
     :accessor is-scale-p
     :initform NIL
     :type :boolean
     :documentation "Does this class represent one scale? --  BOOLEAN."
     )
   (scale-instance
    :initarg :scale-instance
    :accessor scale-instance
    :documentation "Instance for one scale or subscale. *scalename is default."
    )
   (subscales
    :initarg :subscales
    :accessor subscales
    :documentation "List of scale subordinate or composite subscales ."
    )
   ;;end slots
   )
  ;; class options
  (:default-initargs )
  (:documentation  "For Questionnaire Scales and Subscales.")
  ;;end class
  )
(defparameter *no-scale-inst (make-instance 'no-scale
                                           :name "*no-scale-inst"
                                           :name-string "*no-scale-inst"
                                           :scale-instance '*no-scale-inst))

  |#





;;xxx ============= ADDED FOR PERSONAL CONTRUCTS ========



;;PC-SYSTEM
;;
;;ddd
(defclass PC-SYSTEM (scale)
  ((PCSys-name
    :initarg :PCSys-name
    :accessor PCSys-name
    :type :string
    :documentation "PC name string. "
    )
   ( is-PCSys-p
     :initarg  :is-PCSys-p
     :accessor is-PCSys-p
     :initform T
     :type :boolean
     :documentation "Does this class represent one PC? --  BOOLEAN."
     )
   (PCSys-instance
    :initarg :PCSys-instance
    :accessor PCSys-instance
    :documentation "Instance for one PC or subPC. *PCname is default."
    )
   (PC-SSs
    :initarg :PC-SSs
    :accessor PC-SSs
    :type :list
    :documentation "List of PC subordinate or composite PC-SSs ."
    )
   (composite-PCSys-p
    :initarg :composite-PCSys-p
    :accessor composite-PCSys-p
    :type :boolean
    :documentation "Is this PC composed of questions from other PCs?"
    )
   (SysPCs
    :initarg :SysPCs
    :accessor SysPCs
    :type :list
    :documentation "PCs that are in this system/subsystem with no intervening PC subsystems."
    )
   (SysPC-N
    :initarg :SysPC-N
    :accessor SysPC-N
    :type :integer
    :documentation "Number of direct PCs in this system/subsystem"
    )
   (PCSys-value
    :initarg :PCSys-value
    :accessor PCSys-value
    :type :number 
    :documentation "The personal value on scale of 0 to 100"
    )
   (PCSys-description
      :initarg :PCSys-description
    :accessor PCSys-description
    :type :string
    :documentation  "PC description"
    )
   (CogBVsym
      :initarg :CogBVsym
    :accessor CogBVsym
    :type :symbol
    :documentation "The CogBVsym corresponding/linked to this PCsys"
    )
   (CogBVartsym
      :initarg :CogBVartsym
    :accessor CogBVartsym
    :type :symbol
    :documentation "The CogBVartsym corresponding/linked to this PCsys"
    )
   ;;end slots
   )
  ;; class options
  (:default-initargs )
  (:documentation  "PC= George Kelly's Personal Construct for CogTest Questionnaire PCs and SubPCs Systems.")
  ;;end class
  )





;;PC-SUBSYSTEM
;;
;;ddd
(defclass PC-SUBSYSTEM (PC-SYSTEM)
  ((PC-SS-name
    :initarg :PC-SS-name
    :accessor PC-SS-name
    :type :string
    :documentation "PC name string. "
    )
   ( is-PC-SS-p
     :initarg  :is-PC-SS-p
     :accessor is-PC-SS-p
     :initform T
     :type :boolean
     :documentation "Does this class represent one PC? --  BOOLEAN."
     )
   (PC-SS-instance
    :initarg :PC-SS-instance
    :accessor PC-SS-instance
    :documentation "Instance for one PC or subPC. *PCname is default."
    )
   (composite-PC-SS-p
    :initarg :composite-PC-SS-p
    :accessor composite-PC-SS-p
    :type :boolean
    :documentation "Is this PC composed of questions from other PCs?"
    )
   ;;end slots
   )
  ;; class options
  (:default-initargs )
  (:documentation  "PC= George Kelly's Personal Construct for CogTest Questionnaire PCs and SubPCs.")
  ;;end class
  )


;;PC
;;
;;ddd
(defclass PC (assessment)
  ((PC-name
    :initarg :PC-name
    :accessor PC-name
    :type :string
    :documentation "PC name string. "
    )
   ( is-PC-p
     :initarg  :is-PC-p
     :accessor is-PC-p
     :initform T
     :type :boolean
     :documentation "Does this class represent one PC? --  BOOLEAN."
     )
   (PC-instance
    :initarg :PC-instance
    :accessor PC-instance
    :documentation "Instance for one PC or subPC. *PCname is default."
    )
   (subPCs
    :initarg :subPCs
    :accessor subPCs
    :documentation "List of PC subordinate or composite subPCs ."
    )
   (composite-PC-p
    :initarg :composite-PC-p
    :accessor composite-PC-p
    :type :boolean
    :documentation "Is this PC composed of questions from other PCs?"
    )
   (element-combo-nums
    :initarg :element-combo-nums
    :accessor element-combo-nums
    :documentation "A list of lists of 3 element numbers in the particular PC-scale."
    )
   (pc-pole1
    :initarg :pc-pole1
    :accessor pc-pole1
    :type :string
    :documentation "First pole written."
    )
   (pc-pole2
    :initarg :pc-pole2
    :accessor pc-pole2
    :type :string
    :documentation "Second pole--opposite of pole1"
    )
   (pole1-valence
    :initarg :pole1-valence
    :accessor pole1-valence
    :type :string
    :documentation "String + or - OR pos or neg"
    )
   (pc-value
    :initarg :pc-value
    :accessor pc-value
    :type :number 
    :documentation "The personal value on scale of 0 to 100"
    )
   (pc-description
      :initarg :pc-description
    :accessor pc-description
    :type :string
    :documentation  "PC description"
    )
   (CogBVsym
      :initarg :CogBVsym
    :accessor CogBVsym
    :type :symbol
    :documentation "The CogBVsym corresponding/linked to this PC"
    )
   (CogBVartsym
      :initarg :CogBVartsym
    :accessor CogBVartsym
    :type :symbol
    :documentation "The CogBVartsym corresponding/linked to this PC"
    )
   ;;end slots
   )
  ;; class options
  (:default-initargs )
  (:documentation  "PC= George Kelly's Personal Construct for CogTest Questionnaire PCs and SubPCs.")
  ;;end class
  )


;;================== END ADDED FOR CSQ ==============




;XXX -------------------------------- MAKE CLASS INSTANCES FUNCTION -----------


;;MAKE-PERSIM-CLASS-INSTANCES
;;
;;ddd
(defun make-persim-class-instances ()
  "In Cl-PERSIM, needed to put into a [run], etc function that is called AFTER deliver compiles files"
  (defparameter  *top-class-inst (make-instance 'top-class))
  (defparameter  *persim-inst  (make-instance 'persim))
  (defparameter  *per-system-inst  
    (make-instance 'per-system
                   ::system-list '(BIO  VALUES-THEMES BELIEFS SKILLS-CONFIDENCE
                                        INTERPERSONAL ACAD-LEARNING  CAREER-INTEREST  OUTCOME)))
  (defparameter  *assessment-inst (make-instance 'assessment
                                                 :name "*assessment-inst"
                                                 :name-string "*assessment-inst"))
  (defparameter  *scale-inst (make-instance 'scale 
                                            :name "*scale-inst"
                                            :name-string "*scale-inst"
                                            :scale-instance '*scale-inst
                                            ))
  (defparameter *composite-scale-inst (make-instance 'composite-scale
                                                     :name "*composite-scale-inst"
                                                     :name-string "*composite-scale-inst"
                                                     :scale-instance '*composite-scale-inst))
  (defparameter *multi-answer-scale-inst  (make-instance 'multi-answer-scale
                                                         :name "*multi-answer-scale-inst"
                                                         :name-string "*multi-answer-scale-inst"
                                                         ))
  (defparameter *text-answer-question-inst  (make-instance 'text-answer-question
                                                           :name "*text-answer-question-inst"
                                                           :name-string "*text-answer-question-inst"
                                                           )) 

  ;;end make-persim-class-instances
  )




;;-----------------------------------  END OF CLASS INSTANCES --------------------

;;USED PLISTS INSTEAD OF CLOS FOR QUESTIONS, 
;;         HELP-INFO, DATA-LISTS,ETC.
#|
(defclass question (scale)
  ((question


    :initarg :question
    :accessor question
    :documentation "Question content (string) or symbol eval to string."
    )
   (question-instance
    :initarg :question-instance
    :accessor question-instance
    :documentation "question-instance symbol."
    )


|#
;;xxx  -------------------------------------------- HELP-TEST SECTION ------------------------------------



;;   (slot-value persim-inst 'class-description) =>  "This is class description"
;;doesn't work (class-description persim-inst)
;;  (slot-value persim-inst 'scale-list)  => '(s1 s2 s3)
;;  (setf   (slot-value persim-inst 'subscale-list)  "test of setf slot-value")
;;  (slot-value persim-inst 'subscale-list) =>  "test of setf slot-value"



;;xxx
;;------------------------------------- NEVER USED -----------------------------------



#|  public static FrameQuestionJRadioButtons[] questionFramesArray =
      new FrameQuestionJRadioButtons[totalQuestions];
  public static FrAnswerPanel likeMe7 = FrAnswerPanel.LikeUs7;
   (frame-answer-panel
    :initarg :frame-answer-panel
    :accessor frame-answer-panel
    :documentation "Frame-answer-panel instance?"
    )
  ;;public static boolean isFramesCreated = false;
   (frames-created-p
    :initarg :frames-created-p
    :accessor frames-created-p
    :type :boolean
    :documentation "frames-created-p - BOOLEAN-was isFramesCreated"
    )
  ;;was public static MakeFrQuJRadioButtons
   (MakeFrQuJRadioButtonsInstance
    :initarg :MakeFrQuJRadioButtonsInstance
    :accessor MakeFrQuJRadioButtonsInstance
    :documentation "MakeFrQuJRadioButtonsInstance"
    )
#|    bsIndependentRelMakeFrQuJRadioButtonsInstance =
      new MakeFrQuJRadioButtons(className, totalQuestions,
          firingOrderArray, questionInstancesArray,
          questionFramesArray);|#

   ;;end slots
   )
  ;;default-initargs
  (:documentation "Class for question instances"
   )
  ;;end class
  )
|#
;;*QUESTION-INST  (for access to class defaults, etc)
;;
;;ddd
#| error key word documentation in list ??
(defparameter  *question-inst (make-instance 'question 
                                           :name "*question-inst"
                                           :read-name "*question-inst"
                                           :question-instance '*question-inst
                                  ))
|#
