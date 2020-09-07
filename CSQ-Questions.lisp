;;***************************** PC-Questions.lisp ************************
;;
;;==> FOR SHAQ QUESTIONS, SEE CSQ-SHAQ-Questions.lisp
#|
(length (third *all-PC-element-qvars)) = 25
(length (second *all-PC-element-qvars)) = 32
 (length (second *All-PCE-elementQs)) = 27
 (length (third *all-PC-element-qvars)) = 8
 (length (third *All-PCE-elementQs)) = 9|#

;;*ALL-PCE-ELEMENTQS
;;
;;ddd
(defparameter *All-PCE-elementQs
  '(
    (PCE-PEOPLE
     (PCE-PEOPLE-INSTR ("People Important To You"  *Instr-Name-element))
     (MOTHERQ ("Your Mother [or person most like a mother to you]") PCE-PEOPLE-INSTR *input-box-instrs)
     (FATHERQ ("Your Father [or person most like a father to you]") PCE-PEOPLE-INSTR *input-box-instrs)
     (BEST-M-FRIENDQ ("A best male friend") PCE-PEOPLE-INSTR *input-box-instrs)
     (BEST-F-FRIENDQ ("A best female friend") PCE-PEOPLE-INSTR *input-box-instrs)
     (M-DISLIKEQ ("A male you very strongly dislike") PCE-PEOPLE-INSTR *input-box-instrs)
     (F-DISLIKEQ ("A female you very strongly dislike") PCE-PEOPLE-INSTR *input-box-instrs)
     (M-ADMIREQ ("A male who you most admire (not parent)") PCE-PEOPLE-INSTR *input-box-instrs)
     (F-ADMIREQ ("A female who you most admire (not parent)") PCE-PEOPLE-INSTR *input-box-instrs)
     (PER-MOSTFUNQ ("A person you have most fun with") PCE-PEOPLE-INSTR *input-box-instrs)
     (PER-ROMANCEQ ("Person you feel most romantically attracted to.") PCE-PEOPLE-INSTR *input-box-instrs)
     (ROLE-MODELQ ("A person who has been a major role-model for you.") PCE-PEOPLE-INSTR *input-box-instrs)
     (CHILD-FRIENDQ ("A best childhood friend") PCE-PEOPLE-INSTR *input-box-instrs)
     (CHILD-DISLIKEQ ("A person you most disliked as a child") PCE-PEOPLE-INSTR *input-box-instrs)
     (WORK-FRIENDQ ("A work-related close friend") PCE-PEOPLE-INSTR *input-box-instrs)
     (WORK-PER-DISLIKEQ ("A work-related person you strongly dislike") PCE-PEOPLE-INSTR *input-box-instrs)
     (FAV-BOSSQ ("A favorite boss, person with authority over you") PCE-PEOPLE-INSTR *input-box-instrs)
     (WORST-BOSSQ ("Worst boss or person with authority over you") PCE-PEOPLE-INSTR *input-box-instrs)
     (FAV-M-STARQ ("A favorite male movie star") PCE-PEOPLE-INSTR *input-box-instrs)
     (FAV-F-STARQ ("A favorite female movie star") PCE-PEOPLE-INSTR *input-box-instrs)
     (FAV-POLITICOQ ("A favorite political figure") PCE-PEOPLE-INSTR *input-box-instrs)
     (FAV-TEACHERQ ("A favorite teacher") PCE-PEOPLE-INSTR *input-box-instrs)
     (FAV-SPIRITUALQ ("A favorite spiritual or inspirational person") PCE-PEOPLE-INSTR *input-box-instrs)
     (DIS-TEACHERQ ("A teacher you disliked the most") PCE-PEOPLE-INSTR *input-box-instrs)
     )
    (PCE-GROUPS
     (PCE-GROUPS-INSTR  ( "Significant Groups"  *Instr-Name-element))
     (TEACHERQ ("Teachers") PCE-GROUPS-INSTR *input-box-instrs)
     (POLICEMANQ ("Policepersons") PCE-GROUPS-INSTR *input-box-instrs)
     (SALESPERSONQ ("Salespersons") PCE-GROUPS-INSTR *input-box-instrs) 
     (DOCTORQ ("Doctors") PCE-GROUPS-INSTR *input-box-instrs)
     (LAWYERQ ("Lawyers") PCE-GROUPS-INSTR *input-box-instrs)
     (BUSINESS-OWNERQ ("Business owner") PCE-GROUPS-INSTR *input-box-instrs)
     (MANAGERQ ("Manager") PCE-GROUPS-INSTR *input-box-instrs)
     (SCIENTISTQ ("Scientist") PCE-GROUPS-INSTR *input-box-instrs)
     (FARMERQ ("Farmer") PCE-GROUPS-INSTR *input-box-instrs)
     (DRUG-DEALERQ ("Drug dealer") PCE-GROUPS-INSTR *input-box-instrs)
     (POLITICIANQ ("Politician") PCE-GROUPS-INSTR *input-box-instrs)
     (DANCERQ ("Dancer") PCE-GROUPS-INSTR *input-box-instrs)
     (ARTISTQ ("Artist") PCE-GROUPS-INSTR *input-box-instrs)
     ( COMEDIANQ ("Comedian") PCE-GROUPS-INSTR *input-box-instrs)
     ( ENGINEERQ ("Engineer") PCE-GROUPS-INSTR *input-box-instrs)
     ( HOUSE-CLEANERQ ("Housecleaner") PCE-GROUPS-INSTR *input-box-instrs)
     (MOVIE-STARQ ("Movie star") PCE-GROUPS-INSTR *input-box-instrs)
     (ROCK-STARQ ("Rock star") PCE-GROUPS-INSTR *input-box-instrs)
     ( CHURCH-MINISTERQ ("Church minister") PCE-GROUPS-INSTR *input-box-instrs)
     ( CATHOLICSQ ("Catholics") PCE-GROUPS-INSTR *input-box-instrs)
     (PROTESTANTSQ ("Protestants") PCE-GROUPS-INSTR *input-box-instrs)
     (JEWSQ ("Jewish people") PCE-GROUPS-INSTR *input-box-instrs)
     (MUSLIMSQ ("Muslims") PCE-GROUPS-INSTR *input-box-instrs)
     (BUDDHISTSQ ("Buddhists") PCE-GROUPS-INSTR *input-box-instrs)
     (ATHEISTSQ ("Atheists") PCE-GROUPS-INSTR *input-box-instrs)
     (ANGLOSQ ("Anglos") PCE-GROUPS-INSTR *input-box-instrs)
     (HISPANICSQ ("Hispanics") PCE-GROUPS-INSTR *input-box-instrs)
     (BLACKSQ ("Blacks") PCE-GROUPS-INSTR *input-box-instrs)
     (ASIANSQ ("Asians") PCE-GROUPS-INSTR *input-box-instrs)
     )
    (PCE-SELF
     (PCE-SELF-INSTR  ( "Important Self-Related"  *Instr-Name-element))
     (MOST-IMPORTANT-VALUEQ ("Your most important goal or value") PCE-SELF-INSTR *input-box-instrs)
     (MOST-IMPORTANT-ABILITYQ ("Your most important ability") PCE-SELF-INSTR *input-box-instrs)
     (MOST-IMPORTANT-BELIEFQ ("Your most important belief") PCE-SELF-INSTR *input-box-instrs)
     (YOUR-PERSONALITYQ ("The best word or phrase to describe you") PCE-SELF-INSTR *input-box-instrs)
     (YOUR-BEST-CHARACTERISTICQ ("Your best characteristic") PCE-SELF-INSTR *input-box-instrs)
     (YOUR-POSSESSIONSQ ("Overall word or phrase to describe your possessions") PCE-SELF-INSTR *input-box-instrs)
     (YOUR-WORST-CHARACTERISTICQ ("Your worst characteristic") PCE-SELF-INSTR *input-box-instrs)
     )
    )
  "PC element questions used in CSQ"
  )


;;FOR PC-SYMS THAT ARE CREATED PROGRAMATICALLY

(defparameter *All-PCSYM-Qs
  '(
    (ALL-PCSYMS
     (PCSYM-INSTR (*Instr-rate-value  ))
     (PCSYM-VALQ  ("]") PCSYM-INSTR Priority12Instructions)
     ))
  "NOTE: THIS IS A WORK IN PROGRESS--USE LATER?"
  )

;;SIMILAR TO  FR-ANSWER-PANEL  ============================
;;NOTE: Add these to original fr-anwer-panel.lisp if want to use SHAQ & CSQ

(defparameter pc-element 
  '("Type NAME (not listed before) BELOW:" 23 pc-elementAnswer
    pc-elementAnswer "single" "text"))

(defparameter pc-elementAnswer
  '("NAME of specific person/entitiy:"))

(defparameter  Compare3
    '("1-Important way 2 alike & different from third:"  23  compare3answers
    compare3answers  "single" "text"))

(defparameter  *compare3answers
  '( ))

(defparameter *compare-pc-element-title "COMPARING ELEMENTS")
(defparameter *compare-pc-element-instr  (format nil "~A~%~A" "   INSTRUCTIONS:   Write an IMPORTANT way ANY 2 of the following 3 items are ALIKE and DIFFERENT from the third. " "                                     [One word preferably, but phrase OK.]"))
(defparameter *compare-pc-element-alike-text  "1. Important way 2 items are ALIKE (and different from 3rd item):")
(defparameter *compare-pc-element-dif-text "2. Way third item is DIFFERENT (opposite of 1):")
(defparameter *compare-pc-element-input-pane1-title "1a. Way 2 items ALIKE: " )
(defparameter *compare-pc-element-input-pane2-title "2a. Way 3rd is DIFFERENT: ")  
(defparameter *compare-pc-element-text-pane3-text  "3. Which of the above 2 ways  is BETTER (you value most)?") ;;(way ALIKE or way DIFFERENT)
(defparameter *bestpole-button-items  '("Way 2 alike better" "Way 3rd different better" "About equally good"))
(defparameter  *element-button-items   '("Item 1" "Item 2" "Item 3"))

;;INSTRUCTIONS
(defparameter *Instr-Name-element "Write the (first + last name initial) NAME of a person that fits the description well. DO NOT use the same person twice!")
(defparameter *Instr-rate-value "Check the statement that best describes how important this value or characteristic is to you (or how you feel about it).
          [Example: How important that a you, another person, object, event, etc. BE THIS WAY.]")
(defparameter *Rate-elm-title " VALUE TO YOU")
(defparameter *Instr-rate-elm-value "Check the statement that best describes how you FEEL about this person, element, or aspect of your life.")

(defparameter *Rate-pc-title " IMPORTANCE TO YOU")
(defparameter *input-box-instrs  '("Type answer in BOX below:") "For instructions inside the text-input-pane")



#|example
 (defparameter  Agree7   
    '(Agree7Instructions  7  Agree7AnswerArray 
                          Values7to1Array  "single" "int"))|#

(defparameter  Priority12
    '(Priority12Instructions  12  Priority12AnswerArray
    Values12to1Array  :single-selection  "int"))

(defparameter  Priority12Instructions   
    "Importance to you:")
  ;;10 responses for following:
(defparameter  Priority12AnswerArray    '(
                                            "The most important (positive) thing in my life" 
                                            "One of the most important things in my life" 
                                            "Extremely important"  "Very important" 
                                            "Moderately important"  "Mildly important" 
                                            "Not important, unsure, or neutral" 
                                            "Negative to me"  "Very negative to me"  
                                            "Extremely negative to me" 
                                            "One of the most negative things/fears in my life" 
                                            "The most negative thing/fear in my life"))

(defparameter Values12to1Array    '(12 11 10  9  8  7  6  5  4  3  2  1))



(defparameter  Priority11
    '(Priority11Instructions  11  Priority11AnswerArray
    Values11to1Array  :single-selection "int"))

(defparameter  Priority11Instructions   
    "Importance to you:")
  ;;10 responses for following:
(defparameter  Priority11AnswerArray    '(                                          
                                            "One of the most positive elements in my life" 
                                            "Extremely positive element"  "Very positive element" 
                                            "Moderately positive element"  "Mildly positive element" 
                                            "UNSURE, or NEUTRAL element" 
                                            "Mildly negative element" "Moderately positive element" 
                                            "Very negative element"  "Extremely negative element" 
                                            "One of the most negative elements in my life" ))

(defparameter Values11to1Array    '(11 10  9  8  7  6  5  4  3  2  1))

;;******** CURRENT *ALL-CSQ-QUESTIONS **********

;; SINGLE-SELECTION QUESTION EG. 
;; (THMMENCHQ     ("MENTAL CHALLENGE: Be mentally challenged with difficult and/or creative mental tasks.")     THM-INSTR     THM32MENTALCHALQ)
;;MULTI-SELECTION (MULTI-ITEM) QUESTION EG.
;; Questions found in original QVAR list
;; (UTYPE    (TKNOWMORQ NO-QUEST-STRING-FOUND)   (TEXPERIEQ NO-QUEST-STRING-FOUND)  .  .  .   (WANTSPQQ NO-QUEST-STRING-FOUND)   (WANTSPQQ NO-QUEST-STRING-FOUND))

;;CURRENT *ALL-CSQ-QUESTIONS
;; 2019-12-4
;;
;;CL-USER 33 > (pprint *all-csq-questions)
;;xxx FOR PC QUESTIONS ----------------------------------------------------
#|((PCE-PEOPLE 
    ;;NOTE: GENERAL INSTRS IN FIRST LIST IN CATEGORY
  (PCE-PEOPLE-INSTR ("People Important To You" *INSTR-NAME-ELEMENT))
   ;;THEN THE LIST OF PCs
  (MOTHERQ    ("Your Mother [or person most like a mother to you]")
   PCE-PEOPLE-INSTR
   *INPUT-BOX-INSTRS)
  (FATHERQ
   ("Your Father [or person most like a father to you]")
   PCE-PEOPLE-INSTR
   *INPUT-BOX-INSTRS)
  (BEST-M-FRIENDQ
   ("A best male friend")
   PCE-PEOPLE-INSTR
   *INPUT-BOX-INSTRS)
  (BEST-F-FRIENDQ
   ("A best female friend")
   PCE-PEOPLE-INSTR
   *INPUT-BOX-INSTRS)
  (M-DISLIKEQ
   ("A male you very strongly dislike")
   PCE-PEOPLE-INSTR
   *INPUT-BOX-INSTRS)
  (F-DISLIKEQ
   ("A female you very strongly dislike")
   PCE-PEOPLE-INSTR
   *INPUT-BOX-INSTRS)
  (M-ADMIREQ
   ("A male who you most admire (not parent)")
   PCE-PEOPLE-INSTR
   *INPUT-BOX-INSTRS)
  (F-ADMIREQ
   ("A female who you most admire (not parent)")
   PCE-PEOPLE-INSTR
   *INPUT-BOX-INSTRS)
  (PER-MOSTFUNQ
   ("A person you have most fun with")
   PCE-PEOPLE-INSTR
   *INPUT-BOX-INSTRS)
  (PER-ROMANCEQ
   ("Person you feel most romantically attracted to.")
   PCE-PEOPLE-INSTR
   *INPUT-BOX-INSTRS)
  (ROLE-MODELQ
   ("A person who has been a major role-model for you.")
   PCE-PEOPLE-INSTR
   *INPUT-BOX-INSTRS)
  (CHILD-FRIENDQ
   ("A best childhood friend")
   PCE-PEOPLE-INSTR
   *INPUT-BOX-INSTRS)
  (CHILD-DISLIKEQ
   ("A person you most disliked as a child")
   PCE-PEOPLE-INSTR
   *INPUT-BOX-INSTRS)
  (WORK-FRIENDQ
   ("A work-related close friend")
   PCE-PEOPLE-INSTR
   *INPUT-BOX-INSTRS)
  (WORK-PER-DISLIKEQ
   ("A work-related person you strongly dislike")
   PCE-PEOPLE-INSTR
   *INPUT-BOX-INSTRS)
  (FAV-BOSSQ
   ("A favorite boss, person with authority over you")
   PCE-PEOPLE-INSTR
   *INPUT-BOX-INSTRS)
  (WORST-BOSSQ
   ("Worst boss or person with authority over you")
   PCE-PEOPLE-INSTR
   *INPUT-BOX-INSTRS)
  (FAV-M-STARQ
   ("A favorite male movie star")
   PCE-PEOPLE-INSTR
   *INPUT-BOX-INSTRS)
  (FAV-F-STARQ
   ("A favorite female movie star")
   PCE-PEOPLE-INSTR
   *INPUT-BOX-INSTRS)
  (FAV-POLITICOQ
   ("A favorite political figure")
   PCE-PEOPLE-INSTR
   *INPUT-BOX-INSTRS)
  (FAV-TEACHERQ ("A favorite teacher") PCE-PEOPLE-INSTR *INPUT-BOX-INSTRS)
  (FAV-SPIRITUALQ
   ("A favorite spiritual or inspirational person")
   PCE-PEOPLE-INSTR
   *INPUT-BOX-INSTRS)
  (DIS-TEACHERQ
   ("A teacher you disliked the most")
   PCE-PEOPLE-INSTR
   *INPUT-BOX-INSTRS))
 (PCE-GROUPS
  (PCE-GROUPS-INSTR ("Significant Groups" *INSTR-NAME-ELEMENT))
  (TEACHERQ ("Teachers") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (POLICEMANQ ("Policepersons") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (SALESPERSONQ ("Salespersons") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (DOCTORQ ("Doctors") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (LAWYERQ ("Lawyers") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (BUSINESS-OWNERQ ("Business owner") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (MANAGERQ ("Manager") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (SCIENTISTQ ("Scientist") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (FARMERQ ("Farmer") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (DRUG-DEALERQ ("Drug dealer") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (POLITICIANQ ("Politician") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (DANCERQ ("Dancer") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (ARTISTQ ("Artist") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (COMEDIANQ ("Comedian") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (ENGINEERQ ("Engineer") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (HOUSE-CLEANERQ ("Housecleaner") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (MOVIE-STARQ ("Movie star") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (ROCK-STARQ ("Rock star") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (CHURCH-MINISTERQ
   ("Church minister")
   PCE-GROUPS-INSTR
   *INPUT-BOX-INSTRS)
  (CATHOLICSQ ("Catholics") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (PROTESTANTSQ ("Protestants") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (JEWSQ ("Jewish people") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (MUSLIMSQ ("Muslims") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (BUDDHISTSQ ("Buddhists") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (ATHEISTSQ ("Atheists") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (ANGLOSQ ("Anglos") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (HISPANICSQ ("Hispanics") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (BLACKSQ ("Blacks") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS)
  (ASIANSQ ("Asians") PCE-GROUPS-INSTR *INPUT-BOX-INSTRS))
 (PCE-SELF
  (PCE-SELF-INSTR ("Important Self-Related" *INSTR-NAME-ELEMENT))
  (MOST-IMPORTANT-VALUEQ
   ("Your most important goal or value")
   PCE-SELF-INSTR
   *INPUT-BOX-INSTRS)
  (MOST-IMPORTANT-ABILITYQ
   ("Your most important ability")
   PCE-SELF-INSTR
   *INPUT-BOX-INSTRS)
  (MOST-IMPORTANT-BELIEFQ
   ("Your most important belief")
   PCE-SELF-INSTR
   *INPUT-BOX-INSTRS)
  (YOUR-PERSONALITYQ
   ("The best word or phrase to describe you")
   PCE-SELF-INSTR
   *INPUT-BOX-INSTRS)
  (YOUR-BEST-CHARACTERISTICQ
   ("Your best characteristic")
   PCE-SELF-INSTR
   *INPUT-BOX-INSTRS)
  (YOUR-POSSESSIONSQ
   ("Overall word or phrase to describe your possessions")
   PCE-SELF-INSTR
   *INPUT-BOX-INSTRS)
  (YOUR-WORST-CHARACTERISTICQ
   ("Your worst characteristic")
   PCE-SELF-INSTR
   *INPUT-BOX-INSTRS))

;;xxx FOR CSYM LINK QUESTIONS
  (CS-DECLARATIVE
      ;;(instr-symbol (frame-title  frame-instrs) 
      (CS-DECLARATIVE-INSTR ("LINKS TO OTHER NODES" (format nil "~%        Type answer in box at bottom:     ") ))  ;;*CS-PC-current) 
      ;;was (format nil  "Associations with the word, class, concept, or instance=> ~A."  *cs-explore-phrase)
      (ISAQ  ((format nil "What kind(s) or type(s) is ~A?" *cs-explore-phrase)) CS-DECLARATIVE-INSTR *multi-input-box-instrs)
      (PARTQ  ( (format nil "List the most important members or parts of  ~A?" *cs-explore-phrase)) CS-DECLARATIVE-INSTR *multi-input-box-instrs)
      (WHYQ  ((format nil "  ~A: Why is it important or why does it exist?" *cs-explore-phrase)) CS-DECLARATIVE-INSTR *multi-input-box-instrs)
      (CAUSEQ  ((format nil "What is/are the main cause(s) of  ~A?" *cs-explore-phrase)) CS-DECLARATIVE-INSTR *multi-input-box-instrs)
      (EVIDQ  ( (format nil "What is the evidence for  ~A?" *cs-explore-phrase)) CS-DECLARATIVE-INSTR *multi-input-box-instrs)
      (HOWQ  ( (format nil "What are important steps or ways to  ~A?" *cs-explore-phrase)) CS-DECLARATIVE-INSTR *multi-input-box-instrs)
      (EXQ  ( (format nil "What is the best example of  ~A?" *cs-explore-phrase)) CS-DECLARATIVE-INSTR *input-box-instrs)
      (FEATQ  ( (format nil "What are the main features or characteristics of  ~A?" *cs-explore-phrase)) CS-DECLARATIVE-INSTR *multi-input-box-instrs)
      #|(STERETQ  ((format nil "What are other (features/chars.) of  ~A?" *cs-explore-phrase)) CS-DECLARATIVE-INSTR *multi-input-box-instrs)|#
      (REGNQ  ((format nil "Is ~A almost always or exclusively associated with something? If not, write 'none'--otherwise describe?  " *cs-explore-phrase)) CS-DECLARATIVE-INSTR *multi-input-box-instrs)
      ;;(PROT0Q  ( (format nil "What example best demonstrates the essence of/most features of  ~A?" *cs-explore-phrase)) CS-DECLARATIVE-INSTR *input-box-instrs)
      ;;end CS-DECLARATIVE
      )
     (CS-SEMANTIC
      (CS-SEMANTIC-INSTR ("LINKS TO OTHER NODES" (format nil "~%        Type answer in box at bottom:     ") ))  
      (NAMEQ  ( (format nil "What is the best NAME for  ~A?" *cs-explore-phrase))  CS-SEMANTIC-INSTR *input-box-instrs)
      (DEFQ  ((format nil "What is the best definition of ~A?" *cs-explore-phrase)) CS-SEMANTIC-INSTR *input-box-instrs)
      (DESCQ  ( (format nil "What is the best description of  ~A?" *cs-explore-phrase)) CS-SEMANTIC-INSTR *input-box-instrs)
      (OPPQ  ( (format nil "What is the opposite of  ~A?" *cs-explore-phrase)) CS-SEMANTIC-INSTR *input-box-instrs)
      (SYNQ  ( (format nil "What word(s) has/have a meaning most similar to  ~A?" *cs-explore-phrase)) CS-SEMANTIC-INSTR *multi-input-box-instrs)
      ;;end CS-SEMANTIC
      )
     (CS-EPISODIC
      ;;(instr-symbol (frame-title  frame-instrs) 
      (CS-EPISODIC-INSTR ("LINKS TO OTHER NODES" (format nil "~%        Type answer in box at bottom:     ") ))  ;;*CS-PC-current) 
      ;;was (format nil  "Associations with the word, class, concept, or instance=> ~A."  *cs-explore-phrase)
      (EVNTQ  ((format nil "What main event(s) do you associate with ~A?" *cs-explore-phrase)) CS-EPISODIC-INSTR *multi-input-box-instrs)
      ;;end CS-EPISODIC
      )
     (CS-WORLDVIEW
      (CS-WORLDVIEW-INSTR ("LINKS TO OTHER NODES" (format nil "~%        Type answer in box at bottom:     ") )) 
      (VALLNKQ ( (format nil "What value(s) do you most strongly associate with  ~A?" *cs-explore-phrase)) CS-WORLDVIEW-INSTR *multi-input-box-instrs)
      (SELFQ ( (format nil "How does ~A affect you personally?" *cs-explore-phrase)) CS-WORLDVIEW-INSTR *multi-input-box-instrs)
      (OBJQ  ( (format nil "What OBJECT(s) do you most associate with ~A?" *cs-explore-phrase)) CS-WORLDVIEW-INSTR *multi-input-box-instrs)
      ;;(POSEXPQ ( (format nil "What POSITIVE outcomes do you expect will follow from ~A?" *cs-explore-phrase)) CS-WORLDVIEW-INSTR *multi-input-box-instrs)
      ;;(NEGEXPQ ( (format nil "What NEGATIVE outcomes do you expect will follow from ~A?" *cs-explore-phrase)) CS-WORLDVIEW-INSTR *multi-input-box-instrs)
      ;;end CS-WORLDVIEW
      )
     (CS-PROCEDURAL
      (CS-PROCEDURAL-INSTR ("LINKS TO OTHER NODES" (format nil "~%        Type answer in box at bottom:     ") )) 
      (SUPGLQ  ( (format nil "Is ~A a part of meeting bigger goals? ~% List one HIGHER GOAL in each popup window (or leave blank if none): " *cs-explore-phrase)) CS-PROCEDURAL-INSTR *multi-input-box-instrs)
      (SUBGLQ  ( (format nil "What SUB-GOAL(S) do you have from:  ~A?~% List sub-goal in each popup (or leave blank if none)." *cs-explore-phrase)) CS-PROCEDURAL-INSTR *multi-input-box-instrs)
      (SCRPTQ ((format nil "What SCRIPTS or THEMES for behavior (eg. 'ordering in a restaurant') do you associate with  ~A? ~% List one in each popup window (or leave blank if none)." *cs-explore-phrase) )CS-PROCEDURAL-INSTR *multi-input-box-instrs)
      (SITQ  ( (format nil "What situations or stimuli usually or frequently PRECEDE  ~A? ~% List one in each popup window (or leave blank if none)." *cs-explore-phrase)) CS-PROCEDURAL-INSTR *multi-input-box-instrs)
      (ALT-RQ  ( (format nil "What are some (of the main) alternatives to  ~A? ~% List one in each popup window (or leave blank if none)." *cs-explore-phrase)) CS-PROCEDURAL-INSTR *multi-input-box-instrs)
      (ACT  ( (format nil "What habits, actions, or skills do you strongly associate with  ~A? ~% List one in each popup window (or leave blank if none)." *cs-explore-phrase)) CS-PROCEDURAL-INSTR *multi-input-box-instrs)
      (REINFQ ((format nil "What rewards or positive outcomes do you associate with  ~A?" *cs-explore-phrase)) CS-PROCEDURAL-INSTR *multi-input-box-instrs)
      (PUNISHQ ((format nil "What negative outcomes do you associate with  ~A?" *cs-explore-phrase)) CS-PROCEDURAL-INSTR *multi-input-box-instrs)
      ;;end CS-PROCEDURAL
      )
     (CS-MODALITY
      (CS-MODALITY-INSTR ("LINKS TO OTHER NODES" (format nil "~%        Type answer in box at bottom:     ") ))  ;;*CS-PC-current) 
      (IMGQ   ((format nil "What visual image(s) come to mind when you think of/do you associate with  ~A?" *cs-explore-phrase)) CS-MODALITY-INSTR *multi-input-box-instrs)
      (SNDQ  ( (format nil "What sounds come to mind when you think of/do you associate with  ~A?" *cs-explore-phrase)) CS-MODALITY-INSTR *multi-input-box-instrs)
      (SENSQ  ((format nil "What smells, tastes, or other sensations come to mind when you think of /do you associate with  ~A?" *cs-explore-phrase)) CS-MODALITY-INSTR *multi-input-box-instrs)
      ;;(SMELLQ  ((format nil "What smells come to mind when you think of /do you associate with  ~A?" *cs-explore-phrase)) CS-MODALITY-INSTR *multi-input-box-instrs)
      ;;(TASTEQ  ((format nil "What tastes come to mind when you think of /do you associate with  ~A?" *cs-explore-phrase)) CS-MODALITY-INSTR *multi-input-box-instrs)
      ;;(TACTILEQ  ((format nil "What tactile sensations come to mind when you think of /do you associate with  ~A?" *cs-explore-phrase)) CS-MODALITY-INSTR *multi-input-box-instrs)
      ;;end CS-MODALITY
      )   
     (CS-EMOTION
      (CS-EMOTION-INSTR ("LINKS TO OTHER NODES" (format nil "~%        Type answer in box at bottom:     ") ))  ;;*CS-PC-current) 
      (EMOTQ  ((format nil "What emotion(s) (HAPPY, CARING, ANXIETY, ANGER, SAD, NONE-OF-ABOVE) do you MOST associate with ~A?" *cs-explore-phrase)) CS-EMOTION-INSTR *multi-input-box-instrs)
      #|   (HAPPYQ  ((format nil "What emotions do you associate with ?  Anxiety, sad, anger, happiness, love, etc ask each separately  ~A?" *cs-explore-phrase)) CS-DECLARATIVE-INSTR *multi-input-box-instrs)|#
      ;; ADD?? With FUQ  ((format nil "Why, What events/situations/ etc come to mind  ~A?" *cs-explore-phrase))
      ;;end CS-EMOTION
      )
 (CS-SEMANTIC
  (CS-SEMANTIC
   ("LINKS TO OTHER NODES"
    (FORMAT NIL "~%        Type answer in box at bottom:     ")))
  (NAMEQ
   ((FORMAT NIL "What is the best NAME for  ~A?" *CS-EXPLORE-PHRASE))
   CS-SEMANTIC-INSTR
   *INPUT-BOX-INSTRS)
  (DEFQ
   ((FORMAT NIL "What is the best definition of ~A?" *CS-EXPLORE-PHRASE))
   CS-SEMANTIC-INSTR
   *INPUT-BOX-INSTRS)
  (DESCQ
   ((FORMAT NIL
            "What is the best description of  ~A?"
            *CS-EXPLORE-PHRASE))
   CS-SEMANTIC-INSTR
   *INPUT-BOX-INSTRS)
  (OPPQ
   ((FORMAT NIL "What is the opposite of  ~A?" *CS-EXPLORE-PHRASE))
   CS-SEMANTIC-INSTR
   *INPUT-BOX-INSTRS)
  (SYNQ
   ((FORMAT NIL
            "What word(s) has/have a meaning most similar to  ~A?"
            *CS-EXPLORE-PHRASE))
   CS-SEMANTIC-INSTR
   *MULTI-INPUT-BOX-INSTRS))
 (CS-EPISODIC
  (CS-EPISODIC
   ("LINKS TO OTHER NODES"
    (FORMAT NIL "~%        Type answer in box at bottom:     ")))
  (EVNTQ
   ((FORMAT NIL
            "What main event(s) do you associate with ~A?"
            *CS-EXPLORE-PHRASE))
   CS-DECLARATIVE-INSTR
   *MULTI-INPUT-BOX-INSTRS))
 (CS-WORLDVIEW
  (CS-WORLDVIEW
   ("LINKS TO OTHER NODES"
    (FORMAT NIL "~%        Type answer in box at bottom:     ")))
  (VALLNKQ
   ((FORMAT NIL
            "What value(s) do you most strongly associate with  ~A?"
            *CS-EXPLORE-PHRASE))
   CS-WORLDVIEW-INSTR
   *MULTI-INPUT-BOX-INSTRS)
  (SELFQ
   ((FORMAT NIL "How does ~A affect you personally?" *CS-EXPLORE-PHRASE))
   CS-WORLDVIEW-INSTR
   *MULTI-INPUT-BOX-INSTRS)
  (OBJQ
   ((FORMAT NIL
            "What OBJECT(s) do you most associate with ~A?"
            *CS-EXPLORE-PHRASE))
   CS-WORLDVIEW-INSTR
   *MULTI-INPUT-BOX-INSTRS))
 (CS-PROCEDURAL
  (CS-PROCEDURAL
   ("LINKS TO OTHER NODES"
    (FORMAT NIL "~%        Type answer in box at bottom:     ")))
  (SUPGLQ
   ((FORMAT NIL
            "Is ~A a part of meeting bigger goals? ~% List one HIGHER GOAL in each popup window (or leave blank if none): "
            *CS-EXPLORE-PHRASE))
   CS-PROCEDURAL-INSTR
   *MULTI-INPUT-BOX-INSTRS)
  (SUBGLQ
   ((FORMAT NIL
            "What SUB-GOAL(S) do you have from:  ~A?~% List sub-goal in each popup (or leave blank if none)."
            *CS-EXPLORE-PHRASE))
   CS-PROCEDURAL-INSTR
   *MULTI-INPUT-BOX-INSTRS)
  (SCRPTQ
   ((FORMAT NIL
            "What SCRIPTS or THEMES for behavior (eg. 'ordering in a restaurant') do you associate with  ~A? ~% List one in each popup window (or leave blank if none)."
            *CS-EXPLORE-PHRASE))
   CS-PROCEDURAL-INSTR
   *MULTI-INPUT-BOX-INSTRS)
  (SITQ
   ((FORMAT NIL
            "What situations or stimuli usually or frequently PRECEDE  ~A? ~% List one in each popup window (or leave blank if none)."
            *CS-EXPLORE-PHRASE))
   CS-PROCEDURAL-INSTR
   *MULTI-INPUT-BOX-INSTRS)
  (ALT-RQ
   ((FORMAT NIL
            "What are some (of the main) alternatives to  ~A? ~% List one in each popup window (or leave blank if none)."
            *CS-EXPLORE-PHRASE))
   CS-PROCEDURAL-INSTR
   *MULTI-INPUT-BOX-INSTRS)
  (ACT
   ((FORMAT NIL
            "What habits, actions, or skills do you strongly associate with  ~A? ~% List one in each popup window (or leave blank if none)."
            *CS-EXPLORE-PHRASE))
   CS-PROCEDURAL-INSTR
   *MULTI-INPUT-BOX-INSTRS)
  (REINFQ
   ((FORMAT NIL
            "What rewards or positive outcomes do you associate with  ~A?"
            *CS-EXPLORE-PHRASE))
   CS-PROCEDURAL-INSTR
   *MULTI-INPUT-BOX-INSTRS)
  (PUNISHQ
   ((FORMAT NIL
            "What negative outcomes do you associate with  ~A?"
            *CS-EXPLORE-PHRASE))
   CS-PROCEDURAL-INSTR
   *MULTI-INPUT-BOX-INSTRS))
 (CS-MODALITY
  (CS-MODALITY
   ("LINKS TO OTHER NODES"
    (FORMAT NIL "~%        Type answer in box at bottom:     ")))
  (IMGQ
   ((FORMAT NIL
            "What visual image(s) come to mind when you think of/do you associate with  ~A?"
            *CS-EXPLORE-PHRASE))
   CS-MODALITY-INSTR
   *MULTI-INPUT-BOX-INSTRS)
  (SNDQ
   ((FORMAT NIL
            "What sounds come to mind when you think of/do you associate with  ~A?"
            *CS-EXPLORE-PHRASE))
   CS-MODALITY-INSTR
   *MULTI-INPUT-BOX-INSTRS)
  (SENSQ
   ((FORMAT NIL
            "What smells, tastes, or other sensations come to mind when you think of /do you associate with  ~A?"
            *CS-EXPLORE-PHRASE))
   CS-MODALITY-INSTR
   *MULTI-INPUT-BOX-INSTRS))
 (CS-EMOTION
  (CS-EMOTION-INSTR
   ("LINKS TO OTHER NODES"
    (FORMAT NIL "~%        Type answer in box at bottom:     ")))
  (EMOTQ
   ((FORMAT NIL
            "What emotion(s) (HAPPY, CARING, ANXIETY, ANGER, SAD, NONE-OF-ABOVE) do you MOST associate with ~A?"
            *CS-EXPLORE-PHRASE))
   CS-EMOTION-INSTR
   *MULTI-INPUT-BOX-INSTRS))

;;xxx FOR SHAQ QUESTIONS -----------------------------------------
 (ID
  (CASENUMQ NO-QUEST-STRING-FOUND)
  (CASETYPEQ NO-QUEST-STRING-FOUND)
  (SOURCEFILEQ NO-QUEST-STRING-FOUND)
  (FILEDATEQ NO-QUEST-STRING-FOUND)
  (INSTRQ NO-QUEST-STRING-FOUND)
  (RESRQ NO-QUEST-STRING-FOUND)
  (NAMEQ NO-QUEST-STRING-FOUND)
  (IDNUMQ NO-QUEST-STRING-FOUND)
  (SEXQ NO-QUEST-STRING-FOUND)
  (AGEQ NO-QUEST-STRING-FOUND)
  (EMAILQ NO-QUEST-STRING-FOUND)
  (ZIPCODEQ NO-QUEST-STRING-FOUND)
  (NATIONQ NO-QUEST-STRING-FOUND)
  (HRSWORKQ NO-QUEST-STRING-FOUND))
 (UTYPE
  (TKNOWMORQ NO-QUEST-STRING-FOUND)
  (TEXPERIEQ NO-QUEST-STRING-FOUND)
  (TWANTTHOQ NO-QUEST-STRING-FOUND)
  (TWANTSPEQ NO-QUEST-STRING-FOUND)
  (TWORKNGAQ NO-QUEST-STRING-FOUND)
  (TU100STUQ NO-QUEST-STRING-FOUND)
  (TCSULBSTQ NO-QUEST-STRING-FOUND)
  (TOTHERSTQ NO-QUEST-STRING-FOUND)
  (TCOLSTUQ NO-QUEST-STRING-FOUND)
  (TINSTRUCQ NO-QUEST-STRING-FOUND)
  (TCOLFACAQ NO-QUEST-STRING-FOUND)
  (TWANTHELQ NO-QUEST-STRING-FOUND)
  (WANTSPQQ NO-QUEST-STRING-FOUND)
  (WANTSPQQ NO-QUEST-STRING-FOUND))
 (UGOALS
  (GSUCHAPQ NO-QUEST-STRING-FOUND)
  (GACADSUCQ NO-QUEST-STRING-FOUND)
  (GEMOCOPQ NO-QUEST-STRING-FOUND)
  (GSLFESTQ NO-QUEST-STRING-FOUND)
  (GPROCRSTQ NO-QUEST-STRING-FOUND)
  (GTIMEMANQ NO-QUEST-STRING-FOUND)
  (GRELATQ NO-QUEST-STRING-FOUND)
  (GMEETPEOQ NO-QUEST-STRING-FOUND)
  (GLONELYFQ NO-QUEST-STRING-FOUND)
  (GEXVALUSQ NO-QUEST-STRING-FOUND)
  (GDEPRESQ NO-QUEST-STRING-FOUND)
  (GANXFEARQ NO-QUEST-STRING-FOUND)
  (GAGGRANGQ NO-QUEST-STRING-FOUND)
  (GCOMPLTAQ NO-QUEST-STRING-FOUND)
  (GCARPLANQ NO-QUEST-STRING-FOUND)
  (GNOTTAKEQ NO-QUEST-STRING-FOUND)
  (GCARONLYQ NO-QUEST-STRING-FOUND)
  (SPERSBIOQ NO-QUEST-STRING-FOUND)
  (SVEMAAPTQ NO-QUEST-STRING-FOUND)
  (SVEMAAPTQ NO-QUEST-STRING-FOUND))
 (BIO3EDUC
  (BIO3EDUC-INSTR ("Education Level"))
  (BIO3EDUCQ ("Your Highest Education Completed:") BIO3EDUC-INSTR)
  (BIOHSGPAQ ("Your high school grade average?") BIO3EDUC-INSTR)
  (BIOCOLLEQ ("Your overall college grade average?") BIO3EDUC-INSTR))
 (BIO4JOB
  (BIO4JOBQ NO-QUEST-STRING-FOUND)
  (STUDENTQ NO-QUEST-STRING-FOUND)
  (MANAGERQ NO-QUEST-STRING-FOUND)
  (PROPEOPQ NO-QUEST-STRING-FOUND)
  (PROTECHQ NO-QUEST-STRING-FOUND)
  (CONSULTAQ NO-QUEST-STRING-FOUND)
  (EDUCATORQ NO-QUEST-STRING-FOUND)
  (SALESQ NO-QUEST-STRING-FOUND)
  (TECHNICIQ NO-QUEST-STRING-FOUND)
  (CLERICALQ NO-QUEST-STRING-FOUND)
  (SERVICEQ NO-QUEST-STRING-FOUND)
  (OWNBUS10Q NO-QUEST-STRING-FOUND)
  (OTHRSFEMQ NO-QUEST-STRING-FOUND))
 (BI07LANG (LANGQ NO-QUEST-STRING-FOUND))
 (BIO1ETHN (ETHNICQ NO-QUEST-STRING-FOUND))
 (BIORELAF (BIORELAFQ NO-QUEST-STRING-FOUND))
 (NO-SCALE
  (NO-SCALE-INSTR ("Other Questions" "Please be as accurate as you can."))
  (BIO5INCOQ
   ("Your Highest personal income for one year.")
   NO-SCALE-INSTR
   BIO5INCOQ))
 (STUCOLLE
  (STUCOLLE-INSTR ("Check the best answer:"))
  (STUCOLLEQ ("What school do you attend?") STUCOLLE-INSTR))
 (STUMAJOR (STUMAJORQ))
 (STU-DATA
  (STU-DATA-INSTR ("Education-Related Questions"))
  (STPAREDQ
   ("What was the highest level of education reached by EITHER of your PARENTS?")
   STU-DATA-INSTR
   STUPARENTSEDUCQ)
  (STUCOLLEQ
   ("What school do you attend?")
   STU-DATA-INSTR
   STUCOLLEGEATTENDINGQ)
  (STUCLASSQ
   ("What is your current class level?")
   STU-DATA-INSTR
   STUCLASSLEVELQ)
  (STUDEGREQ
   ("What is your ultimate educational objective?")
   STU-DATA-INSTR
   STUDEGREEOBJECTIVEQ)
  (STUSEMESQ
   ("How many units are you currently enrolled in?")
   STU-DATA-INSTR
   STUSEMESTERUNITSQ)
  (STMAJGPAQ
   ("What is your grade average in your major field of study?")
   STU-DATA-INSTR
   STUMAJORGPAQ)
  (STACADSTQ
   ("What is your current academic status?")
   STU-DATA-INSTR
   STUACADEMICSTATUSQ))
 (STGPATRE
  (STGPATREQ
   ("What best describes your GRADE AVERAGE TREND or changes?")
   STU-DATA-INSTR
   STUGPATRENDQ))
 (STUAPT
  (STUAPT-INSTR ("Your Aptitude Test Scores:"))
  (STUVERBAQ
   ("In which percentile range were your VERBAL APTITUDE (SAT, ACT) scores?")
   STUAPT-INSTR
   STUVERBALAPTQ)
  (STUMATHAQ
   ("In which percentile range were your MATH APTITUDE (SAT, ACT)scores?")
   STUAPT-INSTR
   STUMATHAPTQ))
 (STUFEEL
  (STUFEEL-INSTR
   ("Education-Related Questions"
    "Describe your educational experience."))
  (STULOOKFQ
   ("I really look forward to coming to campus.")
   STUFEEL-INSTR
   STULOOKFORWARDQ)
  (STULIKEIQ
   ("I like my instructors very much and feel that I can talk freely with at least one of them.")
   STUFEEL-INSTR
   STULIKEINSTRQ)
  (STUCOMFOQ
   ("I feel extremely comfortable with the faculty and students in my major.")
   STUFEEL-INSTR
   STUCOMFORTABLEQ)
  (STUFRIENQ
   ("I have current school-related friends that I enjoy being with.")
   STUFEEL-INSTR
   STUFRIENDSQ)
  (STUEXTMOQ
   ("Meeting expectations of my parents or others is the most important reason I am in school.")
   STUFEEL-INSTR
   STUEXTMOTIVQ)
  (STULOOKFQ ("I really look forward to coming to campus.") STUFEEL-INSTR)
  (STUCAREEQ
   ("I am in school primariy to get the job/career I want.")
   STUFEEL-INSTR
   STUCAREERMOTIVQ)
  (STUMONEYNEWQ
   ("Making more money is the main reason I'm in school.")
   STUFEEL-INSTR
   STUCAREERMOTIVQ)
  (STUCONFUQ
   ("I don't know why I am in school or what I want from an education.")
   STUFEEL-INSTR
   STUCONFUSEDQ)
  (STUFINDEQ
   ("Which statement describes your financial support best?")
   STUFEEL-INSTR
   STUFINDEPENDQ)
  (STUEACTRQ
   ("I am enjoying life and having fun while in school.")
   STUFEEL-INSTR
   STUEACTREGFUNQ)
  (STHAPCOLQ
   ("Overall how happy are you with your college experience?")
   STUFEEL-INSTR
   STUHAPPYCOLLEGEQ)
  (STHAPGPAQ
   ("Overall, I am happy with my grades and what I am learning.")
   STUFEEL-INSTR
   STUHAPPYGRADESQ)
  (STUENJOYQ
   ("I really enjoy all my learning classes and homework.")
   STUFEEL-INSTR
   STUENJOYLEARNQ))
 (STU-ACMOTIV
  (ACM-INSTR
   ("Learning-Academic Questions:"
    "Honest answers give you the most accurate results."))
  (ACMSTUDYQ
   ("On average, how many hours do you study outside class for each hour in class?")
   ACM-INSTR
   ACMSTUDYQ)
  (ACMNDROPQ
   ("I almost never drop a course or take an incomplete(or wouldn't if you've not taken any.)")
   ACM-INSTR
   ACMNDROPCOURSESQ)
  (ACMATTENQ
   ("I almost never miss a class, and my activities rarely interfere with my schoolwork.")
   ACM-INSTR
   ACMATTENDCLASSQ)
  (ACMEFAMLQ
   ("Others where I live RARELY expect me to help them, do chores, or socialize with them if it interferes with my studies.")
   ACM-INSTR
   ACMEFAMLDEMANDSQ)
  (ACMESOCSQ
   ("My family and friends very strongly encourage my studying and doing well in school.")
   ACM-INSTR
   ACMESOCSTUDYQ)
  (ACMCONCEQ
   ("When I start working on a task or problem, reading an assignment, or writing, my concentration is so great and I get so involved that almost nothing can distract me.")
   ACM-INSTR
   ACMCONCENTRATEQ)
  (ACMTIMEQ
   ("My schedule gives me so little time to study that it seriously affects my grades.")
   ACM-INSTR
   ACMTIMEQ)
  (ACMTIMEORIGQ
   ("My schedule gives me so little time to study that it seriously affects my grades.")
   ACM-INSTR
   ACMTIMEQ)
  (ACMSELFSQ
   ("I am able to manage my college life extremely well myself--with little or no help or support from others.")
   ACM-INSTR
   ACMSELFSUFFICIENTQ)
  (ACMCOMPLQ
   ("Confidence that you will complete your college degree.")
   ACM-INSTR
   ACMCOMPLETECOL1Q)
  (ACMQUITCQ
   ("There is almost no possibility that I will drop out of college during the next year.")
   ACM-INSTR
   ACMQUITCOLQ)
  (ACMFINANQ
   ("Confidence that you have adequate financial means to complete college. ")
   ACM-INSTR
   ACMFINANCIALQ)
  (ACMDEGREQ
   ("I have been so highly motivated to get the college degree I seek for so long that almost nothing could stop me now.")
   ACM-INSTR
   ACMDEGREMOTIVATIO))
 (STU-LRN
  (LRNESTUDQ
   ("I have a good place where I can study as much as I want with minimal distractions.")
   ACM-INSTR
   LRNESTUDYPLACEQ)
  (LRNTXOVEQ
   ("Whenever I read a chapter in a text, I always do the following:
 1-Get an OVERVIEW OF THE CHAPTER FIRST
 2-Actively try to get the main point of each paragraph or section.
 3-Summarize what I have learned when I finish a major section or chapter.")
   ACM-INSTR
   LRNTXOVERVIEWQ)
  (LRNTXUNDQ
   ("Whenever I don't understand something I am reading,  I almost never just continue reading. Instead I look up parts I don't know, visualize it, or think about it until I understand it.")
   ACM-INSTR
   LRNTXUNDERSTANDQ)
  (LRNTSREVQ
   ("In studying for a big exam, I always review ALL of the assigned material AT LEAST 3 TIMES within 2 days of the exam.")
   ACM-INSTR
   LRNTSREVIEWQ)
  (LRNMAPQ
   ("I almost always create some type of visual overview (or \"map\") of my text chapters.")
   ACM-INSTR
   LRNMAPQ)
  (LRNTEXTNQ
   ("In math or science courses, I focus my energy on understanding the basic principles--not just getting answers to problems.")
   ACM-INSTR
   LRNTEXTNOTPROBSQ)
  (LRNINTERQ
   ("If I find a text boring, I almost always find ways of making it interesting.")
   ACM-INSTR
   LRNINTERESTQ)
  (LRNROTEQ
   ("Every time I go over material I try to view it a new way instead of using rote memory methods.")
   ACM-INSTR
   LRNROTEQ)
  (LRNASSOCQ
   ("I try to associate new material with as many things in my own experiences as I can.")
   ACM-INSTR
   LRNASSOCQ)
  (LRNSTRUGQ
   ("When I am reading and come to a part that is very difficult to understand, I almost never just go on. Instead I almost always struggle with it until I understand it well.")
   ACM-INSTR
   LRNSLTNSTRUGGLEQ)
  (LRNTHEORQ
   ("I enjoy learning about theories and enjoy building my own theories about what I am learning in class.")
   ACM-INSTR
   LRNTHEORYQ)
  (LRNALONEQ
   ("I am satisfied with the result of my studying in relation to the time I spend at it.")
   ACM-INSTR
   LRNSEFICICIENCYQ)
  (LRNMATHQ
   ("I enjoy math and don't seem to have any great difficulty in doing problems correctly.")
   ACM-INSTR
   LRNMATHQ)
  (LRNWRPAPQ
   ("I make \"A\"s on almost all of the term papers I write and almost all of the essay tests that I take.")
   ACM-INSTR
   LRNWRITESKILLSQ)
  (LRNTXOUTQ
   ("When I read my textbooks, I almost always underline, make notes, outline, or summarize as I am reading.")
   ACM-INSTR
   LRNTEXTOUTLINEQ)
  (LRNNOTESQ
   ("I am satisfied with the way I take notes in class and with their usefulness to me as I study for my tests.")
   ACM-INSTR
   LRNNOTESQ)
  (LRNWRSKLQ
   ("I am satisfied with all my writing skills such as spelling, grammar, and punctuation.")
   ACM-INSTR
   LRNWRITESKILLSQ)
  (LRNSEEQ
   ("I don't seem to have any visual problems when I read.")
   ACM-INSTR
   LRNSEEQ)
  (LRNVOCABQ
   ("As I read my textbooks and outside reading for my classes, I don't seem to have any problems with the vocabulary or in understanding the writer's thought patterns.")
   ACM-INSTR
   LRNVOCABQ)
  (LRNSREADQ
   ("I think that I read slower than most of my classmates.")
   ACM-INSTR
   LRNSREADQ)
  (LRNMEMORQ
   ("I don't seem to have any difficulty in remembering new terms, formulas, or facts.")
   ACM-INSTR
   LRNMEMORQ)
  (LRNTENSEQ
   ("I rarely feel tense during my examinations.")
   ACM-INSTR
   LRNTENSEQ)
  (LRNSEFICQ
   ("I am satisfied with the result of my studying in relation to the time I spend at it.")
   ACM-INSTR
   LRNSEFICICIENCYQ)
  (LRNWRORGQ
   ("When I write, I don't have any great difficulty in organizing what I want to say.")
   ACM-INSTR
   LRNWRORGANIZATIO)
  (LRNUNASNQ
   ("Do you have a great deal of difficulty understanding assignments and beginning them?")
   ACM-INSTR
   LRNUNASNMENTSQ)
  (LRNCOLMTQ
   ("Were you ever made to feel that you were not college material?")
   ACM-INSTR
   LRNCOLMTERALQ)
  (LRNKNOWTQ
   ("Do you feel that you know the material, but are unable to do well on a test?")
   ACM-INSTR
   LRNKNOWTESTBADQ)
  (LRNPROOFQ
   ("Would you feel very unsure about turning in a paper that has been proofread by someone else?")
   ACM-INSTR
   LRNPROOFPAPERQ)
  (LRNRREADQ
   ("Do you usually have to read textbooks 2-3 times or more to make sense of them?")
   ACM-INSTR
   LRNRREADTEXTSQ)
  (LRNEFFICQ
   ("I am satisfied with the result of my studying in relation to the time I spend at it.")
   ACM-INSTR
   LRNSEFICICIENCYQ)
  (LRNTESTTQ
   ("Could you do better on tests if you were allowed a lot more time?")
   ACM-INSTR
   LRNTESTTMORETIMEQ)
  (LRNTIMASQ
   ("Do you spend too much time on one assignment which causes you to not complete other assignments?")
   ACM-INSTR
   LRNTIMASSIGNSQ)
  (LRNTIREDQ
   ("Does reading for one hour make you very tired?")
   ACM-INSTR
   LRNTIREDREADQ)
  (LRNTANXIQ
   ("Do you feel more anxiety about tests than most of your classmates?")
   ACM-INSTR
   LRNTANXIETYQ)
  (LRNSMARTQ
   ("Do you feel that you're a lot smarter than your grades indicate?")
   ACM-INSTR
   LRNSMARTERTHANGRADESQ)
  (LRNAREADQ
   ("Do you avoid reading so much that it is a big problem?")
   ACM-INSTR
   LRNAREADQ)
  (LRNRSLOWQ
   ("Do you generally read much slower than other people?")
   ACM-INSTR
   LRNRSLOWREADQ))
 (THEMES
  (THM-INSTR
   ("LIFE THEMES and VALUES:" "HOW IMPORTANT is this is to you?"))
  (THM1ACHQ
   ("Being the best at whatever I do (example: making top grades). Achieving more than most other people.")
   THM-INSTR
   THM1ACHQ)
  (THM3EDUCQ
   ("EDUCATION: Earning at least a bachelor's or higher degree--preferably a master's or doctorate and making top grades.")
   THM-INSTR
   THM3EDUCQ)
  (THM4MONEQ
   ("INCOME: Making a lot of money, preferably becoming a millionaire, or multimillionaire.")
   THM-INSTR
   THM4MONEYQ)
  (THM25POSQ
   ("POSSESSIONS: Having top quality (expensive) possessions--home, car, electronics, jewelry, etc.")
   THM-INSTR
   THM25POSSESSQ)
  (THM26SUCQ
   ("SUCCESS: Being extremely successful in my career--rising to the top in it.")
   THM-INSTR
   THM26SUCCESSQ)
  (THMIMPACQ
   ("IMPACT: Having a major impact on changing the world to make it a better place.")
   THM-INSTR
   THM27CHANGEWORLDQ)
  (THM28CREQ
   ("CREATION: Creating something that I feel is a major contribution (e.g. invention, bridge, book, house, work of art, etc.).")
   THM-INSTR
   THM28CREATEQ)
  (THM30CEOQ
   ("POWER: Being president, CEO, owner, etc. of an important organization OR having a great amount of influence or control over others.")
   THM-INSTR
   THM30CEOQ)
  (THM33GOAQ
   ("COMPLETION and ACHIEVEMENT: Accomplish all my important goals.")
   THM-INSTR
   THM33GOALSQ)
  (THM8ROMAQ
   ("LOVE-ROMANCE: Having a wonderful, romantic marriage/relationship.")
   THM-INSTR
   THM8ROMANCEQ)
  (THM12PLEQ
   ("PLEASING: Pleasing others, avoiding conflict, keeping relationships pleasant.")
   THM-INSTR
   THM12PLEASEQ)
  (THMRESPEQ
   ("RESPECT: Being highly respected by others, and being seen as an important, successful, and/or good person by others.")
   THM-INSTR
   THM15RESPECTQ)
  (THM20INTQ
   ("INTIMACY: Having a few extremely close and long-term relationships.")
   THM-INSTR
   THM20INTIMACYQ)
  (THMLIKEDQ
   ("WELL-LIKED: Being well liked by everyone. Having many friends and networking with many others.")
   THM-INSTR
   THM21NETWORKQ)
  (THMCAREGQ
   ("CARE-GIVING: Be a good parent, or take care of others in need.")
   THM-INSTR
   THM31CAREGIVERQ)
  (THMSUPPOQ
   ("EMOTIONAL SUPPORT: Having people in my life to support me if I'm upset or having a problem.")
   THM-INSTR
   THMVSUPRTQ)
  (THMATTENQ
   ("ATTENTION: Being the center of attention, entertaining others, or performing in front of groups.")
   THM-INSTR
   THMATTENTIO)
  (THMFAMILQ
   ("FAMILY: Family members and family matters, events, traditions, etc.")
   THM-INSTR
   THMFAMILYQ)
  (THMRECOGQ
   ("RECOGNITION: Having respect, recognition, status, position, and/or other signs of success.")
   THM-INSTR
   THMRECOGNITIO)
  (THMPHURTQ
   ("PERSONAL HEALING: Overcoming past family or personal problems that have hurt me in the past.")
   THM-INSTR
   THM16HURTQ)
  (THMOBGODQ
   ("OBEDIENCE: Obeying God and living according to His commands and rules.")
   THM-INSTR
   THM17GODRULESQ)
  (THMPARLVQ
   ("PARENTAL LOVE and RESPECT: Being respected and loved by my parent(s) or other authorities.")
   THM-INSTR
   THM18PARENTRESPECTQ)
  (THMSPROTQ
   ("SELF-PROTECTION: Protecting myself from others and the harm they have done to me or may do to me.")
   THM-INSTR
   THM24PROTECTQ)
  (THMPUNCTQ
   ("PUNCTUALITY: Being on time, timeliness.")
   THM-INSTR
   THMPUNCTUALITYQ)
  (THMOBLIGQ
   ("DUTY and OBLIGATION, obeying the rules and expectations of one's family or group--even if it goes against one's own happiness.")
   THM-INSTR
   THMOBLIGATIO)
  (THM5ADVEQ
   ("ADVENTURE: Having a life of adventure and excitement with many new experiences.")
   THM-INSTR
   THM5ADVENTQ)
  (THM6LEARQ
   ("LEARNING: Learning, self-development, and growing to be the best I can be.")
   THM-INSTR
   THM6LEARNQ)
  (THM9SHAPQ
   ("SELF-HAPPINESS: Living the happiest life I can.")
   THM-INSTR
   THM9HAPPYQ)
  (THM10OTHQ
   ("GIVING: Contributing to others' health/happiness and making the world a better place.")
   THM-INSTR
   THM10OTHHAPQ)
  (THMRELGDQ
   ("SPIRITUAL INTIMACY: Having a very close relationship with God.")
   THM-INSTR
   THM13RELGODQ)
  (THM14INDQ
   ("INDEPENDENCE: Being independent, and living according to my own values and dreams.")
   THM-INSTR
   THM14INDEPQ)
  (THM22BODQ
   ("HEALTH: Having an exceptionally healthy body and living to be 100--by exceptional nutrition, exercise, no use of drugs or smoking, etc.")
   THM-INSTR
   THM22BODYQ)
  (THM23BALQ
   ("BALANCE: Having balance in my life--even at the cost of not achieving as much in my career or any other area.")
   THM-INSTR
   THM23BALANCEQ)
  (THMORDERQ
   ("ORDERLINESS: Having good organization or logical order, being systematic, etc.")
   THM-INSTR
   THMORDERLYQ)
  (THMMENCHQ
   ("MENTAL CHALLENGE: Be mentally challenged with difficult and/or creative mental tasks.")
   THM-INSTR
   THM32MENTALCHALQ)
  (THM34EXPQ
   ("EXPLORATION: Exploring the unknown, seeking the answers to mysteries.")
   THM-INSTR
   THM34EXPLOREQ)
  (THMCOMPCQ
   ("COMPETENCE: Being the best I can be and achieving the most competence I can at whatever I do.")
   THM-INSTR
   THM35COMPETENCEQ)
  (THMINTEGQ
   ("INTEGRITY: Having integrity; pursuing my own values, beliefs, and goals above what others think; being honest with myself and others; etc.")
   THM-INSTR
   THM36INTEGRITYQ)
  (THMPHILQ
   ("PERSONAL PHILOSOPHY: Developing a positive, well thought out personal belief system and living according to those beliefs.")
   THM-INSTR
   THMPHILQ)
  (THMCLEANQ
   ("PLEASING: Pleasing others, avoiding conflict, keeping relationships pleasant.")
   THM-INSTR
   THM12PLEASEQ)
  (THMWHOLEQ
   ("WHOLENESS (unity, integration, organization, simplicity, etc.).")
   THM-INSTR
   THMWHOLENESSQ)
  (THMPERFEQ
   ("PERFECTION and idealism for self, others, nature.")
   THMPERFECTIO)
  (THMJUSTIQ
   ("JUSTICE (fairness, getting what one has earned or deserved).")
   THM-INSTR
   THMJUSTICEQ)
  (THMSIMPLQ ("SIMPLICITY.") THM-INSTR THMSIMPLICITYQ)
  (THMBEAUTQ ("BEAUTY of all types in all things.") THM-INSTR THMBEAUTYQ)
  (THMGOODNQ
   ("GOODNESS and functionality (versus dysfunctional, evil, or harmful).")
   THM-INSTR
   THMGOODNESSQ)
  (THMUNIQUQ
   ("UNIQUENESS and DIVERSITY (idiosyncrasy, individuality, variety, novelty).")
   THM-INSTR
   THMUNIQUEQ)
  (THMCREATQ
   ("CREATIVENESS: Producing new, original ideas, art, objects, actions, etc.")
   THM-INSTR
   THMCREATIVEQ)
  (THMEFORTQ
   ("EFFORTLESSNESS (ease, grace, beautifully functioning).")
   THM-INSTR
   THMEFORTLESSQ)
  (THMPLAYFQ
   ("FUN and PLAYFULNESS (fun, joy, amusement, humor).")
   THM-INSTR
   THMPLAYFULQ)
  (THMSESUFQ
   ("SELF-SUFFICIENCY (autonomy, independence, environment-transcending, taking care of oneself, separateness, living by own laws).")
   THM-INSTR
   THMSELFSUFFICIENTQ)
  (THMSEDISQ
   ("SELF-DISCIPLINE, self-control, control over one's own thoughts, emotions, and actions to be consistent with one's highest values and goals.")
   THM-INSTR
   THMSELFDISCIPLINEQ)
  (THMSPIRIQ
   ("GOD and/or SPIRITUALITY: A rich spiritual life that is the center of my life.")
   THM-INSTR
   THMSPIRITGODQ)
  (THMRELIGQ
   ("RELIGION and the church or religious group to which I belong.")
   THM-INSTR
   THMRELIGIO)
  (THMUNCONQ
   ("UNCONDITIONAL LOVE: Unconditionally loving myself and everyone in the world.")
   THM-INSTR
   THMUNCONDITLOVEQ))
 (TBV
  (TBV-INSTR
   ("Important Beliefs Questions:"
    "To what degree do you believe the following."))
  (TBVOTHFIQ
   ("I should always put other people's needs before my own.")
   TBV-INSTR
   TBVOTHERSFIRSTQ)
  (TBVLIKEDQ
   ("I should be loved or liked by everyone I meet.")
   TBV-INSTR
   TBVLIKEDBYALLQ)
  (TBVWEAKQ
   ("I am weak and dependent on strong people for my happiness.")
   TBV-INSTR
   TBVWEAKQ)
  (TBVBESTQ ("I must be the best at everything I do.") TBV-INSTR TBVBESTQ)
  (TBVENTITQ
   ("I am entitled to a good life, and people I care for should try to help meet my needs.")
   TBV-INSTR
   TBVENTITLEDQ)
  (TBVRULESQ
   ("We must run our lives by rules, and people who break those rules must be severely punished or we will have chaos.")
   TBV-INSTR
   TBVRULESPUNISHQ)
  (TBVWINNEQ
   ("There are winners and losers. If you are not strong and take advantage of others before they take advantage of you and you will be a loser.")
   TBV-INSTR
   TBVWINNERSQ)
  (TBVBALANQ
   ("I try to properly balance present with future happiness and balance my own with others' happiness-- a key to inner harmony.")
   TBV-INSTR
   TBVBALANCEFUTUREQ)
  (TBVHAPCAQ
   ("For every decision I make--especially big ones--I attempt to estimate which alternative will lead to the greatest happiness and choose that alternative.")
   TBV-INSTR
   TBVHAPCALCQ)
  (TBVGRATIQ
   ("I am grateful for the gift of life. I was given the gift of life and the opportunity to create a happy life for myself. I did not earn or deserve life or this opportunity--so I will not complain about not having what others do or not getting what I want or need.")
   TBV-INSTR
   TBVGRATITUDEQ)
  (THVSELFAQ
   ("There are one or more aspects (or parts) of myself that I have a hard time accepting or do not like.")
   TBV-INSTR
   THVSELFACCEPTQ)
  (THVSELFAORIGQ
   ("There are one or more aspects (or parts) of myself that I have a hard time accepting or do not like.")
   TBV-INSTR
   THVSELFACCEPTQ)
  (THVUNCONQ
   ("I value all people unconditionally just because they are human. Attributes such as background, ethnicity, social group, income, accomplishments, and even their personality or morality aren't relevant to their basic value as humans.")
   TBV-INSTR
   THVUNCONDCAREQ)
  (THVSELFWQ
   ("I could love myself and value my own happiness unconditionally no matter what mistakes or bad things I may do.")
   TBV-INSTR
   THVSELFWORTHQ))
 (IE
  (IE-INSTR
   ("Important Beliefs Questions:"
    "To what degree do you believe the following:"))
  (IECSELFSQ
   ("I am extremely good at taking care of myself and any problems I might run into.")
   IE-INSTR
   IECSELFSUFFICIENTQ)
  (IECICONTQ
   ("Relative to outside forces like destiny, other people, luck, fate, God, government, organizations, and anything else, I am the one who has by far the greatest amount of control over my own life and happiness.")
   IE-INSTR
   IECILOFCIVSEQ)
  (IECGENETQ
   ("Genetics and my biology are primarily responsible for my personality and my emotional reactions.")
   IE-INSTR
   IECGENETICQ)
  (IECPEOPLQ
   ("People in my life are primarily responsible for my personality and my emotional reactions.")
   IE-INSTR
   IECPEOPLEQ)
  (IECDEPENQ
   ("I am very dependent upon someone (parent, spouse, etc.) to support or take care of me (emotionally, financially, socially, etc.).")
   IE-INSTR
   IECDEPENDENTQ)
  (IECCOFEEQ
   ("I worry more about caring for someone else's needs or feelings than my own (e.g. family member(s), lover, friend(s), etc.).")
   IE-INSTR
   IECCODEPENDENTQ)
  (IECCOPRBQ
   ("I worry a great deal about taking care of someone with a serious problem (e.g. illness, an addiction, a psychological disorder, etc.")
   IE-INSTR
   IECCODEPPROBLEMQ))
 (WORLDVIEW
  (WOV-INSTR
   ("Important Beliefs Questions:"
    "To what degree do you believe the following."))
  (WOV-INSTR2
   ("Important Beliefs Questions:"
    "Percent of the time that you do the following."))
  (WOVPROGRQ
   ("The world will gradually improve in most important respects (materially, socially, environmentally, spiritually, etc.).")
   WOV-INSTR
   WOVPROGRESSQ)
  (WOVGOODFQ
   ("The world is controlled by forces beneficial to humans (and me).")
   WOV-INSTR
   WOVGOODFORCESQ)
  (WOVMYLIFQ ("My life will generally improve.") WOV-INSTR WOVMYLIFEQ)
  (WOVNFAIRQ
   ("Life has been extremely unfair to me.")
   WOV-INSTR
   WOVLIFENOTFAIRQ)
  (WOVENTITQ
   ("I am entitled to the basic necessities of life such as good health care, good income, people caring for me, etc.")
   WOV-INSTR
   WOVENTITLEDQ)
  (WOVINJURQ
   ("Someone has injured me so much that it has ruined my life.")
   WOV-INSTR
   WOVINJUREDQ)
  (WOVABUNDQ ("I have all I need to be happy.") WOV-INSTR WOVABUNDANCEQ)
  (WOVGRATEQ
   ("I am extremely grateful for having so much.")
   WOV-INSTR
   WOVGRATEFULQ)
  (WOVPOSTHQ
   ("Percent of the time you have positive thoughts VERSUS negative thoughts.")
   WOV-INSTR2
   WOVPOSTHOUGHTSPERCENTQ)
  (WOV-INSTR3
   ("Your Worst Fears" "How much fear or anxiety do you have about. . ."))
  (WOVHAPPYQ
   ("Fear of not getting a job or career you will be happy with.")
   WOV-INSTR3
   WOVHAPPYCAREERQ)
  (WOVPOORQ
   ("Fear of not having enough income or money.")
   WOV-INSTR3
   WOVPOORQ)
  (WOVILLQ ("Fear of having a serious illness.") WOV-INSTR3 WOVILLQ)
  (WOVDEATHQ ("Fear of death.") WOV-INSTR3 WOVDEATHQ)
  (WOVALONEQ ("Fear of being alone.") WOV-INSTR3 WOVALONEQ)
  (WOVNOLOVQ
   ("Fear of not ever having a good marriage and/or family life.")
   WOV-INSTR3
   WOVNOLOVEQ)
  (WOVLIKEDQ
   ("Fear of not having close enough friends.")
   WOV-INSTR3
   WOVLIKEDQ)
  (WOVPERSOQ
   ("Fear of not becoming the kind of person you want to be.")
   WOV-INSTR3
   WOVPERSO)
  (WOVPROBLQ
   ("Fear of never overcoming some personal, psychological, or other type of problem.")
   WOV-INSTR3
   WOVPROBLEMQ)
  (WOVDISCOQ
   ("Fear that something about you will be discovered, punished, or made public.")
   WOV-INSTR3
   WOVDISCOVEREDQ)
  (WOVSUCCEQ
   ("Fear of not obtaining the academic or career success you want.")
   WOV-INSTR3
   WOVSUCCESSQ)
  (WOVOVERCQ
   ("Degree of belief that even if your worst fear(s) happened, you could learn how to be happy.")
   WOV-INSTR3
   WOVOVERCOMEFEARQ))
 (SELF-CONF
  (SELF-CONF-INSTR
   ("Self-Confidence Questions"
    "CONFIDENCE in your abililities, skills, knowledge, and motivation in this area."))
  (SLFLEARNQ ("Learning and study skills") SELF-CONF-INSTR SLFLEARNSKILLQ)
  (SLFCRITTQ
   ("Critical thinking and logic--ability to examine statements critically and think logically")
   SELF-CONF-INSTR
   SLFCRITTHINKQ)
  (SLFRESEAQ ("Research and methodology") SELF-CONF-INSTR SLFRESEARCHQ)
  (SLFANALYQ
   ("Analytical thinking--ability to conceptually break wholes into component parts")
   SELF-CONF-INSTR
   SLFANALYSISQ)
  (SLFSYNTHQ
   ("Synthesis--ability to put confusing pieces together into meaningful wholes")
   SELF-CONF-INSTR
   SLFSYNTHESISQ)
  (SLFCREATQ
   ("Critical thinking and logic--ability to examine statements critically and think logically")
   SELF-CONF-INSTR
   SLFCRITTHINKQ)
  (SLFCOMPUQ ("Computer-related skills") SELF-CONF-INSTR SLFCOMPUTERQ)
  (SLFBIOSCQ ("Biological Science") SELF-CONF-INSTR SLFBIOSCIQ)
  (SLFNATSCQ
   ("Natural Science (physics, chemistry, etc.)")
   SELF-CONF-INSTR
   SLFNATSCIQ)
  (SLFLIBARQ
   ("Liberal Arts (literature, history, English, languages, etc.)")
   SELF-CONF-INSTR
   SLFLIBARTSQ)
  (SLFSOCSCQ
   ("Behavioral and Social Sciences (psychology, sociology, political science, etc.)")
   SELF-CONF-INSTR
   SLFSOCSCIQ)
  (SLFPHILRQ
   ("Philosophy and/or Religion
")
   SELF-CONF-INSTR
   SLFPHILRELQ)
  (SLFPERFAQ
   ("Performing Arts (music, dance, theatre arts, etc.)")
   SELF-CONF-INSTR
   SLFPERFARTQ)
  (SLFFINEAQ
   ("Fine Arts (art, design, etc.)")
   SELF-CONF-INSTR
   SLFFINEARTQ)
  (SLFBUSANQ ("Business or Management") SELF-CONF-INSTR SLFBUSANDMANAGEQ)
  (SLFHEAL2Q ("Health or Medicine") SELF-CONF-INSTR SLFHEALTHMEDQ)
  (SLFENGINQ ("Engineering or Technical") SELF-CONF-INSTR SLFENGINQ)
  (SLFEDUCHQ
   ("Education, Counseling, or Helping-Related")
   SELF-CONF-INSTR
   SLFEDUCHELPQ)
  (SLFIQQ ("Overall intelligence (IQ)") SELF-CONF-INSTR SLFIQQ)
  (SLFDECMAQ
   ("Life and career decision-making and planning")
   SELF-CONF-INSTR
   SLFDECMAKINGQ)
  (SLFTIMEMQ ("Time management") SELF-CONF-INSTR SLFTIMEMANAGEMENTQ)
  (SLFCOPEQ
   ("Emotional coping skills--ability to prevent and overcome negative emotions effectively")
   SELF-CONF-INSTR
   SLFCOPEQ)
  (SLFSELF4Q
   ("Self-motivation--ability to motivate yourself to do unpleasant tasks even under adverse conditions")
   SELF-CONF-INSTR
   SLFSELFMOTIVQ)
  (SLFSELFMQ
   ("Self-disclosure--ability and practice of sharing openly innermost feelings and intimate information with close friends and family")
   SELF-CONF-INSTR
   SLFSELFDISCLOSEQ)
  (SLFACHANQ
   ("Task or achievement motivation and work habits--highly focused and productive work habits.")
   SELF-CONF-INSTR
   SLFACHANDWORKQ)
  (SLFMANA6Q
   ("Managing finances and money")
   SELF-CONF-INSTR
   SLFMANAGEMONEYQ)
  (SLFHEAL3Q ("Health or Medicine") SELF-CONF-INSTR SLFHEALTHMEDQ)
  (SLFMEETPQ
   ("Meeting people and talking to strangers")
   SELF-CONF-INSTR
   SLFMEETPEOPLEQ)
  (SLFLISTEQ
   ("Empathetic listening skills--ability and practice of understanding inner meaning of what others say")
   SELF-CONF-INSTR
   SLFLISTENINGQ)
  (SLFSELF5Q
   ("Self-disclosure--ability and practice of sharing openly innermost feelings and intimate information with close friends and family")
   SELF-CONF-INSTR
   SLFSELFDISCLOSEQ)
  (SLFCONFLQ
   ("Conflict resolution skills--ability to calmly and effectively resolve interpersonal conflict situations")
   SELF-CONF-INSTR
   SLFCONFLICTRESOLQ)
  (SLFPERSUQ
   ("Persuasion skills--ability to influence others")
   SELF-CONF-INSTR
   SLFPERSUASIONQ)
  (SLFMANA7Q
   ("Management and leadership skills")
   SELF-CONF-INSTR
   SLFMANAGESKILLQ)
  (SLFHELPSQ
   ("Helping and teaching skills")
   SELF-CONF-INSTR
   SLFHELPSKILLQ)
  (SLFSPEAKQ ("Public speaking skills") SELF-CONF-INSTR SLFSPEAKSKILLQ)
  (SLFJOBSEQ
   ("Job search and interviewing skills")
   SELF-CONF-INSTR
   SLFJOBSEARCHQ)
  (SLFADAPTQ
   ("Very adaptable, flexible, and resourceful--ability to rapidly adapt to and be successful in almost any situation.")
   SELF-CONF-INSTR
   SLFADAPTQ)
  (SLFHAPPYQ
   ("\"Happiness IQ\"--knowledge and ability of how to make yourself happy in any possible situation and overall.")
   SELF-CONF-INSTR
   SLFHAPPYIQQ)
  (SLFOPTIMQ ("Time management") SELF-CONF-INSTR SLFTIMEMANAGEMENTQ)
  (SLFFRIENQ
   ("Very caring, friendly, and outgoing person overall.")
   SELF-CONF-INSTR
   SLFFRIENDLYQ)
  (SLFINDEPQ
   ("Very strong, independent, self-disciplined person overall.")
   SELF-CONF-INSTR
   SLFINDEPENDENTQ))
 (SM
  (SM-INSTR
   ("Self-Management Questions:"
    "Honest answers give you the most accurate results."))
  (SMTBUSYQ
   ("I rarely get upset about being too rushed, having too many things to do, or not having any time to relax.")
   SM-INSTR
   SMTBUSYQ)
(SMTFUTURQ
   ("I spend a lot of time thinking about the future, making plans, and working toward completing distant goals.")
   SM-INSTR
   SMTFUTUREPLA)
  (SMTEXERCQ
   ("Frequency that you get vigorous exercise for a minimum of 20 minutes:")
   SM-INSTR
   SMTEXERCIZEQ)
  (SMTEATHQ
   ("I eat a very healthy diet, (vitamins, minerals, balanced meals, fiber, low fat, etc.) do not drink excessively, smoke, or take drugs.")
   SM-INSTR
   SMTEATHQ)
  (SMTSLEEPQ
   ("Number of hours I average sleeping per night:")
   SM-INSTR
   SMTSLEEPQ)
  (SMTSDEVEQ
   ("I have been successful in consciously planning and greatly improving a number of important aspects of myself such as my interpersonal relations, coping with my emotions, self-discipline, smoking, overeating, or study habits.")
   SM-INSTR
   SMTSDEVELOPMENTQ)
  (SMTNPROCQ
   ("If I am facing a task or assignment that is very boring, very confusing, or very frustrating, I will almost always start it without any procrastination and continue to work diligently until it is completed at a high level of quality.")
   SM-INSTR
   SMTNPROCRASTINATEQ)
  (SMTPTODOQ
   ("I make a PRIORITIZED TASK LIST which covers to-do's from my school, work, social, recreation, and other areas of my life at least once per week.")
   SM-INSTR
   SMTPTODOQ)
  (SMTGOALSQ
   ("At least twice a year I spend several hours making a list of GOALS and SPECIFIC OBJECTIVES for myself for each area of my life and use these goals/objectives regularly during the year planning my weekly activities at least twice per year.")
   SM-INSTR
   SMTGOALSQ)
  (SMTSCHDQ
   ("I make a WEEKLY SCHEDULE of how I want to spend my time during the week--scheduling times for classes, study, friends, work, recreation, and other important activities. I use this schedule weekly.")
   SM-INSTR
   SMTSCHDQ)
  (SMT2DTODQ
   ("I make a COMPREHENSIVE SCHEDULE of ALL ASSIGNMENTS and PROJECTS and their DUE DATES for the ENTIRE semester, quarter, year, etc., and regularly use that schedule to see what I need to do next.")
   SM-INSTR
   SMT2DTODOQ)
  (SMTACMPLQ
   ("I am extremely busy with many things to do, but feel that I am accomplishing a great deal in most of my life areas, enjoy my life a great deal, and rarely feel under too much pressure from too many things to do.")
   SM-INSTR
   SMTACMPLQ)
  (SMTGHELPQ
   ("I work on self-improvement regularly by reading, counseling, taking non-required classes, or other activities to consciously improve myself.")
   SM-INSTR
   SMTGHELPQ)
  (SMTBALANQ
   ("I would say that I lead a very balanced lifestyle. I have time and energy for my school, my work, friends and family, the opposite sex, relaxation, physical activity, my spiritual life, and recreation.  In addition, almost all of these life areas are providing me with a great deal of satisfaction.")
   SM-INSTR
   SMTBALANCEQ)
  (SMTHABCHQ
   ("If I get good advice from reading or another person, I almost always make a conscious effort to follow that advice and even change life-long habits.")
   SM-INSTR
   SMTHABCHGQ))
 (COPE
  (COPE-INSTR
   ("Emotional Coping Questions"
    "When upset, percent of the time you ___________"))
  (COPE-INSTR2 ("Emotional Coping Questions"))
  (COPNEGTHQ
   ("Worry, think negative thoughts, think of problems without thinking of good solutions")
   COPE-INSTR
   COPNEGTHINKINGQ)
  (COPCOPEAQ ("Eat.") COPE-INSTR COPCOPEATQ)
  (COPPSOLVQ
   ("Face the problem directly, think about what caused the feelings, think of possible solutions, and take action to solve the underlying problem.")
   COPE-INSTR
   COPPSOLVEQ)
  (COPEMOTAQ
   ("Outwardly express anger by losing your temper, crying, damaging something, or getting even.")
   COPE-INSTR
   COPEMOTAGGRESSQ)
  (COPAVOPSQ
   ("Avoid thinking about problems by sleeping, keeping busy, or putting it off.")
   COPE-INSTR
   COPAVOIDQ)
  (COPBLAMEQ
   ("Think about whose fault it is, blame yourself, or blame others.")
   COPE-INSTR
   COPBLAMEQ)
  (COPWDRWQ
   ("Withdraw from others, feel hurt, hold your emotions in, feel sorry for yourself.")
   COPE-INSTR
   COPWDRWQ)
  (COPFUNQ
   ("Do something involving or fun to get rid of the feelings (listen to music, read, socialize, shop, walk, etc.")
   COPE-INSTR
   COPFUNQ)
  (COPTALKSQ
   ("Talk to someone else about the problem/feelings (friend, family member, counselor, etc.)")
   COPE-INSTR
   COPTALKSOMEONEQ)
  (COPPEPTAQ
   ("Think about positive thoughts and goals and/or give yourself a pep talk.")
   COPE-INSTR
   COPPEPTALKQ)
  (COPSMOKEQ
   ("Smoke a cigarette or tobacco product.")
   COPE-INSTR
   COPSMOKEQ)
  (COPDRUGQ
   ("Drink an alcoholic beverage, take street drugs, or use prescribed medication.")
   COPE-INSTR
   COPDRUGQ)
  (COPPEQ
   ("Think about positive thoughts and goals and/or give yourself a pep talk.")
   COPE-INSTR
   COPPEPTALKQ)
  (COPNEGPHQ
   ("Think of the problem from a very critical or punitive point of view. (Examples: \"I must not make mistakes.\" or \"God may send me to Hell\")")
   COPE-INSTR
   COPNEGPHILQ)
  (COPSELFBQ
   ("Get angry at yourself, think negative thoughts about yourself, or call yourself names.")
   COPE-INSTR
   COPSELFBLAMEQ)
  (COPPOSPHQ
   ("Think of the problem from a constructive (philosophical or religious?) point of view that makes you feel better.")
   COPE-INSTR
   COPPOSPHILQ)
  (COPEXPECQ
   ("Examine your underlying expectations of yourself (or others) and reset them to more realistic levels.")
   COPE-INSTR
   COPEXPECTATIONSQ)
  (COPHAPPYQ
   ("Tell yourself that you can be happy no matter what happens.")
   COPE-INSTR
   COPHAPPYQ)
  (COPAVOATQ
   ("How often have you missed work, school, or other important activities because you were so upset (anxious, depressed, etc.) that you couldn't cope.")
   COPE-INSTR2
   COPAVOIDFREQQ)
  (COPSELFEQ
   ("How much do you enjoy exploring and analyzing your feelings, thoughts, beliefs, and memories.")
   COPE-INSTR2
   COPSELFEXPLOREQ))
 (ASSERTCR
  (CR-INSTR
   ("Relationship Questions"
    "Apply this question to your closest relationship: marriage or close romantic relationship, OR apply the question to an imagined future relationship, OR to another valued relationship."))
  (CR1ISSUEQ
   ("When my partner and I have a discussion or argument, we almost always stay on one issue at a time.")
   CR-INSTR
   CRSRQ19ISSUEQ)
  (CRRESOLVQ
   ("My partner and I rarely argue about the same issue more than once.")
   CR-INSTR
   CRSRQ26FINISHQ)
  (CRNTHREAQ
   ("I almost never make threats about what I will do if my partner takes a certain action.")
   CR-INSTR
   CRSRQ29THREATSQ)
  (CRUNDERLQ
   ("We usually discuss what is really bothering us (the underlying issues) instead of the surface issues.")
   CR-INSTR
   CRSRQ30REALQ)
  (CRTKLONGQ
   ("One partner usually talks a long time before the other partner has a chance.")
   CR-INSTR
   CRSRQ32ONETALKQ)
  (CRNNEGLBQ
   ("I rarely use negative labels or call others (such as 'dumb,' 'dependent,' 'weak,' 'selfish,' 'inconsiderate') even when we are angry with each other.")
   CR-INSTR
   CRSRQ33RARENEGQ)
  (CRTEWEAKQ
   ("I do not really feel very comfortable telling my partner about my weaknesses or something I have done wrong.")
   CR-INSTR
   CRSRQ34NOWEAKQ)
  (CRWINWINQ
   ("When making an important decision, we almost always discuss it until we find a solution with which we are both happy.")
   CR-INSTR
   CRSRQ35WINWINQ)
  (CRLONGTKQ
   ("Sometimes when we are trying to resolve a difficult problem, we almost always keep going until we reach a solution (even if we have to discuss it for hours or the next day).")
   CR-INSTR
   CRSRQ36LONGTALKQ)
  (CREXAGGRQ
   ("I frequently use words like \"always,\" \"never,\" or other exaggerations.")
   CR-INSTR
   CRSRQ37EXAGGERATEQ)
  (CRMANIPUQ
   ("I frequently feel as if my partner is manipulating me or that I am manipulating my partner.")
   CR-INSTR
   CRSRQ38PARTMANIPQ)
  (CRSUMMARQ
   ("When discussing important issues my partner and I usually repeat back a summary of what the other has said to make sure we understand it.")
   CR-INSTR
   CRSRQ39LISTENQ)
  (CRCPRAISQ
   ("Even during a disagreement, my partner and I frequently laugh and praise each other.")
   CR-INSTR
   CRSRQ40PRAISEQ)
  (CRBOASSRQ
   ("My partner and I are both very assertive(positive, firm, and diplomatic).")
   CR-INSTR
   CRSRQ43BOTHASSERTQ)
  (CROPHONEQ
   ("Our communication is extremely open, nondefensive, and honest.")
   CR-INSTR
   CRSRQ45OPENQ)
  (CRREPRAIQ
   ("Overall, my partner gives me a lot more criticism than praise.")
   CR-INSTR
   CRSRQ47PARTCRITQ)
  (CRTEACHQ
   ("If one of us tries to teach the other something, we usually end up having some hard feelings.")
   CR-INSTR
   CRSRQ56TEACHQ)
  (CRIFAVORQ
   ("If my partner asks me to do me a favor, I almost always do it cheerfully.")
   CR-INSTR
   CRSRQ57FAVORQ)
  (CRIFOLUPQ
   ("I almost always do what I tell my partner I will do.")
   CR-INSTR
   CRSRQ59FOLLOWUPQ)
  (CRANGANGQ
   ("If my partner gets angry at me, I usually get angry or defensive back.")
   CR-INSTR
   CRSRQ60ANGERBACKQ)
  (CRIPRAISQ
   ("Overall, I criticize my partner quite a bit more than I praise him/her.")
   CR-INSTR
   CRSRQ67CRITICALQ)
  (CRANGRESQ
   ("If I lose my temper at my partner, he/she will almost always tell me about it in a firm, diplomatic way without losing his/her temper. I do the same when she/he loses her/his temper.")
   CR-INSTR
   CRSRQ68ANGERRESQ)
  (CRTLKMORQ
   ("In our conversations, one partner usually talks quite a bit more than the other.")
   CR-INSTR
   CRSRQ31EQTALKQ)
  (CREQWINQ
   ("My partner and I \"win\" long disagreements/arguments about equally often.")
   CR-INSTR
   CRSRQ58EQWINQ))
 (INTIMACY
  (INT-INSTR
   ("Relationship Questions"
    "Apply this question to your closest relationship: marriage or close romantic relationship, OR apply the question to an imagined future relationship, OR to another valued relationship."))
  (INSTSHLPQ
   ("If I am under more stress than usual, my partner will usually do extra things for me.")
   INT-INSTR
   INTSRQ6EXTRAQ)
  (INTCOMITQ
   ("A long term commitment (would) cause(s) me to feel trapped.")
   INT-INSTR
   INTSRQ7COMMITQ)
  (INTUNDRLQ
   ("We usually discuss what is really bothering us (the underlying issues) instead of the surface issues.")
   INT-INSTR
   INTSRQ30REALQ)
  (INTTELALQ
   ("I have told my partner almost everything about myself.")
   INT-INSTR
   INTSRQ8TELLALLQ)
  (INTSMGOAQ
   ("My partner and I strongly agree on most long term goals.")
   INT-INSTR
   INTSRQ18LIKEGOALSQ)
  (INTEQDECQ
   ("Overall, my partner and I are equal in how much influence we have in decisions.")
   INT-INSTR
   INTSRQ20EQDISCUSSQ)
  (INTIOPENQ
   ("When I discuss an important issue with my partner, I go ahead and tell my partner almost exactly what I am thinking and feeling--even though it might upset him/her. My partner does the same.")
   INT-INSTR
   INTSRQ21OPENISSUEQ)
  (INTWEOPNQ
   ("Our communication is extremely open, nondefensive, and honest.")
   INT-INSTR
   INTSRQ45NONDEFQ)
  (INTDAILYQ
   ("Almost every day my partner and I each share our FEELINGS about events happening that day.")
   INT-INSTR
   INTSRQ46OPENFEELQ)
  (INTRESPTQ
   ("I respect my partner more than almost anyone else I know.")
   INT-INSTR
   INTSRQ50RESPECTQ)
  (INTALLOPQ
   ("My partner and I talk very openly and freely about specifically what we like and dislike about even the most sensitive areas of our relationship (e.g. what we really think of each other, sexual relations, finances, secrets.")
   INT-INSTR
   INTSRQ53OPENSEXTKQ)
  (INTWKTOGQ
   ("My partner and I do NOT enjoy working at the same task together.")
   INT-INSTR
   INTSRQ55MUTTASKQ)
  (INTKNPFEQ
   ("I frequently do not know what my partner really wants or feels.")
   INT-INSTR
   INTSRQ61KNOWFEELQ)
  (INTLSQPRQ
   ("I frequently tell others about their positive characteristics and about how much I like, love, or respect my partner.")
   INT-INSTR
   INTLSQPRASE44Q)
  (INTLOVEQ
   ("I love (care for) my partner very much.")
   INT-INSTR
   INTLOVEQ))
 (INDEP-INT
  (INR-INSTR
   ("Relationship Questions"
    "Apply this question to your closest relationship: marriage or close romantic relationship, OR apply the question to an imagined future relationship, OR to another valued relationship."))
  (INRBEALNQ
   ("It is NOT ok for one partner to go away for a weekend by themselves to think and be alone.")
   INR-INSTR
   INRSRQ2BEALONEQ)
  (INALCNSTQ
   ("One should always consult with their partner before making even small decisions.")
   INR-INSTR
   INRSRQ3CONSULTQ)
  (INRFRIENQ
   ("My partner has close friends of his/her same sex with whom he/she has frequent social contact outside work.")
   INR-INSTR
   INRSRQ9OWNFRIENDSQ)
  (INDIFDECQ
   ("If my partner makes a decision concerning his/her own personal matters, and I do not agree with it, I almost always am supportive and encouraging to my partner.")
   INR-INSTR
   INRSRQ10ENCDIFDECQ)
  (INRLUNCHQ
   ("It is ok for one partner to go out to lunch alone with an attractive friend of the opposite sex.")
   INR-INSTR
   INRSRQ11LUNCHQ)
  (INRINHAPQ
   ("The (marriage) relationship is more important than the happiness of one partner.")
   INR-INSTR
   INRSRQ15INDHAPQ)
  (INNEVARGQ
   ("Partners should never argue or disagree if they are to have a truly happy relationship.")
   INR-INSTR
   INRSRQ16NEVARGUEQ)
  (INRIGROWQ
   ("I would end my relationship if staying in it meant that I could not grow as a person.")
   INR-INSTR
   INRSRQ17ENDQ)
  (INRSAYWEQ
   ("When I refer to myself, I frequently say 'we' (meaning my partner and I).")
   INR-INSTR
   INRSRQ24SAYWEQ)
  (INCOMTWOQ
   ("One of us frequently worries about whether the other is really committed to this relationship.")
   INR-INSTR
   INRSRQ25COMMITWORRYQ)
  (INDIFGOAQ
   ("It is OK for my partner and I to have some goals which are not the same.")
   INR-INSTR
   INRSRQ28DIFGOALOKQ)
  (INFINDANQ
   ("If I did not have my partner, I would think I could find another partner with whom I could be very happy.")
   INR-INSTR
   INRSRQ41FINDANOTHERQ)
  (INENALONQ
   ("I find that I can't really enjoy myself very much if I go someplace without my partner.")
   INR-INSTR
   INRSRQ44ENJOYALONEQ)
  (INOKALONQ
   ("I don't know how I could be happy if I didn't have my partner.")
   INR-INSTR
   INRSRQ48HAPALONEQ)
  (INRHATEAQ
   ("I hate to be alone for even a short time.")
   INR-INSTR
   INRSRQ49FEARALONEQ)
  (INRFREEHQ
   ("I feel free to do whatever I want at home whether or not my partner is there.")
   INR-INSTR
   INRSRQ51FREEATHOMEQ)
  (INSEPINTQ
   ("I am glad that my partner has some recreational activities and interests apart from me.")
   INR-INSTR
   INRSRQ63PARTINTERESTSQ)
  (INRMONEYQ
   ("My partner and I each have our own funds from which to buy personal things without consulting the other.")
   INR-INSTR
   INRSRQ64OWNFUNDSQ))
 (ROM
  (ROM-INSTR
   ("Relationship Questions"
    "Apply this question to your closest relationship: marriage or close romantic relationship, OR apply the question to an imagined future relationship, OR to another valued relationship."))
  (ROMSURPRQ
   ("I do something different to surprise my partner such as buy flowers, leave a love note, or buy a present for no special event at least once a week.")
   ROM-INSTR
   ROMSRQ1SURPRISEQ)
  (ROMFANTAQ
   ("I frequently fantasize about my partner.")
   ROM-INSTR
   ROMSRQ4FANTASIZEQ)
  (ROMCELEBQ
   ("My partner and I celebrate special days together almost once a month.")
   ROM-INSTR
   ROMSRQ5CELEBRQ)
  (ROMPLACEQ
   ("My partner and I go out to romantic places just to be alone together at least once a week.")
   ROM-INSTR
   ROMSRQ12ROMPLACESQ)
  (ROMATTRAQ
   ("I am extremely attracted to my partner sexually.")
   ROM-INSTR
   ROMSRQ13ATTRACTQ)
  (ROMPLAYFQ
   ("My partner and I both enjoy playful interactions with each other several times per week.")
   ROM-INSTR
   ROMSRQ14PLAYQ)
  (ROMCHARMQ
   ("My partner is extremely charming and romantic.")
   ROM-INSTR
   ROMSRQ42CHARMQ))
 (LIBROLE
  (LRO-INSTR
   ("Relationship Questions"
    "Apply this question to your closest relationship: marriage or close romantic relationship, OR apply the question to an imagined future relationship, OR to another valued relationship."))
  (LROMTASKQ
   ("There are certain tasks that are MORE the man's responsibility, such as providing economic support, taking care of the car, etc.")
   LRO-INSTR
   LROSRQ22MTASKSQ)
  (LROFTASKQ
   ("There are certain tasks that are MORE the woman's responsibility, such as cleaning house, fixing meals, etc.")
   LRO-INSTR
   LROSRQ23FTASKSQ)
  (LRMFINALQ
   ("The man should make the final decision.")
   LRO-INSTR
   LROSRQ27FINALDECQ)
  (LROEMBARQ
   ("I would feel embarrassed if my partner did something considered more characteristic of the opposite sex in front of other people (such as a woman working on the car or a man crying).")
   LRO-INSTR
   LROSRQ52EMBARQ)
  (LROMSTROQ
   ("I want a relationship in which the man is stronger and more decisive than the woman.")
   LRO-INSTR
   LROSRQ54MSTRONGERQ)
  (LROEQINCQ
   ("The man and woman should be equally responsible for providing an income for the couple or family.")
   LRO-INSTR
   LROSRQ65EQINCOMEQ)
  (LRCARCONQ
   ("If the man and woman have a career conflict in which one has to quit his/her job, the woman should be the one to quit.")
   LRO-INSTR
   LROSRQ66FQUITJOBQ))
 (HAP
  (HAP-INSTR
   ("Overall Happiness Questions" "Degree that you are happy with ... "))
  (HAPAREAQ
   ("Happiness with living in this area, with the home in which I live, and feeling at home here.")
   HAP-INSTR
   HAPAREAQ)
  (HAPCLFRNQ
   ("Happiness with the number and closeness of my friendships, and I see them as often enough.")
   HAP-INSTR
   HAPCLFR)
  (HAPCARNWQ ("Happiness with my career now.") HAP-INSTR HAPCAREERQ)
  (HAPCARFUQ
   ("Happiness with expectations for future career success and happiness.")
   HAP-INSTR
   HAPCAREEREXPECTQ)
  (HAPFRIENQ ("Happiness with friendships.") HAP-INSTR HAPFRIENDSQ)
  (HAPWKRELQ
   ("Happiness with relationships at work, school, or job-like setting.")
   HAP-INSTR
   HAPWORKRELSQ)
  (HAPPEQ
   ("Happiness with my physical activity area of my life.")
   HAP-INSTR
   HAPPEQ)
  (HAPRECREQ ("Happiness with my recreation.") HAP-INSTR HAPRECREATIO)
  (HAPSEXREQ
   ("Happiness with the sexual/romantic relationship area of my life.")
   HAP-INSTR
   HAPSEXRELQ)
  (HAPFAMILQ
   ("Happiness with my family relationships.")
   HAP-INSTR
   HAPFAMILYQ)
  (HAPSELFDQ
   ("Happiness with the kind of person I am and with my personal growth/development.")
   HAP-INSTR
   HAPSELFDEVELQ)
  (HAPSPIRIQ
   ("Happiness with having a meaningful life and with my spiritual or religious life.")
   HAP-INSTR
   HAPSPIRITUALQ)
  (HAPYEARQ
   ("Overall happiness during the past year.")
   HAP-INSTR
   HAPYEARQ)
  (HAP3YEARQ
   ("Overall happiness during the past year.")
   HAP-INSTR
   HAPYEARQ)
  (HAPLIFEQ
   ("Overall happiness during my entire life up to 3 years ago.")
   HAP-INSTR
   HAPLIFEQ)
  (HAPEXPECQ
   ("Overall happiness expected in the future.")
   HAP-INSTR
   HAPEXPECTQ))
 (RHEALTH
  (RHL-INSTR
   ("Health Questions"
    "What best describes your health and your habits?"))
  (RHLFREQIQ
   ("How often did you get sick the past 3 years?")
   RHL-INSTR
   RHLFREQILLNESSQ)
  (RHLALCOHQ
   ("How many drinks of alcohol do you average?")
   RHL-INSTR
   RHLALCOHOLQ)
  (RHLSMOKEQ
   ("How often do you use cigarettes or other tobacco products?")
   RHL-INSTR
   RHLSMOKEQ)
  (RHLDRUGSQ
   ("How many often do you take illegal drugs on average?")
   RHL-INSTR
   RHLDRUGSQ)
  (RHLPHYSIQ
   ("How would you describe your physical conditioning?")
   RHL-INSTR
   RHLPHYSICALCONDITIO)
  (RHLWEIGHQ
   ("How would you describe your weight?")
   RHL-INSTR
   RHLWEIGHTQ))
 (RPEOPLE
  (RPE-INSTR
   ("Relationship Questions" "Honest answers give better results."))
  (RPEHAPFRQ
   ("Almost all of my good friends are very successful and happy in almost every area of their lives including school and interpersonal relationships.")
   RPE-INSTR
   RPEHAPFRIENDSQ)
  (RPEHMARRQ
   ("I have (or have had) a very happy marital -- or marital-like relationship with someone for an extended period of time.")
   RPE-INSTR
   RPEHMARRQ)
  (RPENETWQ
   ("I have developed an extensive, close network of friends and career-related persons with whom I share support and information.")
   RPE-INSTR
   RPENETWQ)
  (RPECLFRNQ
   ("In my life I have had a number of extremely close friends with whom I could discuss my innermost secrets, weaknesses, and problems.")
   RPE-INSTR
   RPECLFR)
  (RPENUMFRQ
   ("Approximate number of friends in general with whom you interact socially -- outside of work or school settings--at least once a month.")
   RPE-INSTR
   RPENUMFRIENDSQ)
  (RPENUMCLQ
   ("Approximate number of EXTREMELY CLOSE friendships with which you are VERY SATISFIED.")
   RPE-INSTR
   RPENUMCLOSEFRIENDSQ)
  (RPECOMMIQ
   ("Degree of commitment to an intimate(romantic) relationship (lasting at least 3 months)")
   RPE-INSTR
   RPECOMMITQ))
 (RDEP
  (RDEP-INSTR
   ("Unhappiness and Depression Questions"
    "Honesty is important for valid results."))
  (RDEP-INSTR2
   ("Unhappiness and Depression Questions"
    "Honesty is important for valid results."))
  (RDEPFEELQ
   ("I often feel sad, apathetic, listless, or depressed.")
   RDEP-INSTR
   RDEPFEELINGQ)
  (RDEPTHOUQ
   ("I often feel worthless, very guilty, or think very negative thoughts about my future, the world, death, or myself.")
   RDEP-INSTR
   RDEPTHOUGHTQ)
  (RDEPDYSSQ
   ("If you have felt depressed and had 2 or more of the following symptoms regularly, how long have you had them?
  * feel sad, unhappy, or depressed most of the day for most days
  * feel low energy, tiredness most of the time
  * have poor concentration and trouble making decisions
  * feel hopeless or doomed
  * have feelings of low self-esteem
  * have poor appetite or overeat
  * sleep too little or too much most of the time.")
   RDEP-INSTR
   RDEPDYSSYMPTOMSQ)
  (RDEPMAJSQ
   ("How many times for 2 or more weeks at a time, have you had 5 (or more) of the following symptoms:
 * feel very depressed
 * have markedly less interest or pleasure in almost all daily activities
 * diminished ability to concentrate or think
 * feel worthless and/or very guilty
 * not be able to sleep or sleep much more than usual
 * have very low energy
 * significant weight loss or gain (without effort)
 * move much more slowly (motor retardation) or quickly (agitation) than usual
 * have recurring thoughts of death or suicidal thoughts")
   RDEP-INSTR
   RDEPMAJSYMPTOMSQ)
  (RDEPMEDSQ
   ("Length of time that you have been prescribed medication for depression.")
   RDEP-INSTR2
   RDEPMEDSQ)
  (RDEPTHERQ
   ("Amount of counseling or psychotherapy for depression.")
   RDEP-INSTR2
   RDEPTHERAPYQ))
 (RANX
  (RANX-INSTR
   ("Anxiety Related Questions"
    "Degree/accuracy this statement describes you."))
  (RANX-INSTR2 ("Anxiety Related Questions" "Give your best estimate."))
  (RANXPERFQ
   ("Do you feel excessively nervous or anxious when speaking or performing in front of others.")
   RANX-INSTR
   RANXPERFORMQ)
  (RANXALLTQ
   ("Do you worry or feel nervous or anxious almost all of the time?")
   RANX-INSTR
   RANXALLTIMEQ)
  (RANXPSTDQ
   ("Do you suffer from post-traumatic stress symptoms?

[Were you ever exposed to some life-threatening, abusive, or shocking traumatic event(s) where you felt extremely frightened and helpless AND still have frequent episodes of flashbacks, numbness, detachment, distress, avoidance of similar situations, or other symptoms that significantly interfere in your life?]")
   RANX-INSTR
   RANXPSTDQ)
  (RANXSOCIQ
   ("Do you feel very nervous or anxious almost any time you are with other people?")
   RANX-INSTR
   RANXSOCIALQ)
  (RANXOCDQ
   ("How many times have you had a lasting problem with obsessions or compulsions?

[Obsessions definition: recurring, uncontrollable thoughts or images that you cannot get out of your mind, and cause distress.
Compulsions definition: repeating outward or mental acts (e.g. washing, ordering, checking, praying, counting, repeating words) because one feels compelled to.
Both obsessions and compulsions are usually not realistically connected to any immediate outside problem or are excessive.]")
   RANX-INSTR
   RANXOCDQ)
  (RANXPHOBQ
   ("How many genuine phobias do you think you have?

[Phobia definition: repeated intense, excessive, and unreasonable fear or anxiety elicited by a specific object, animal, or situation. Or, do you have a fear of almost all social contact?]")
   RANX-INSTR
   RANXPHOBIAQ)
  (RANXPANIQ
   ("About how many genuine panic attacks have you had during the past 5 years?

[Panic attack definition: four or more of the following symptoms together for 10 minutes or more:
   pounding heart; trembling; trouble breathing; chest pain; feeling dizzy;    feeling detached or numb; plus fears of dying, going crazy, or losing control]")
   RANX-INSTR
   RANXPANICQ)
  (RANXMEDSQ
   ("Length of time that you have been prescribed medication for anxiety, obsessions/compulsions, phobias, or panic disorder.")
   RANX-INSTR
   RANXMEDSQ)
  (RANXTHERQ
   ("Amount of counseling or psychotherapy for excessive stress, anxiety, obsessions/compulsions, phobias, or panic disorder.")
   RANX-INSTR
   RANXTHERAPYQ))
 (RANG
  (RANG-INSTR
   ("Anger Related Questions"
    "Degree/accuracy this statement describes you. Honesty is very important for helpful results."))
  (RANG-INSTR2
   ("Anger Related Questions"
    "Give your best estimate.  Honesty is very important for helpful results."))
  (RANGFEELQ
   ("How often do you get angry and lose your temper?")
   RANG-INSTR2
   RANGFEELINGQ)
  (RANGYELLQ
   ("How often do you yell at someone or call someone hurtful names?")
   RANG-INSTR2
   RANGYELLQ)
  (RANGDOMIQ
   ("How often do you get someone to do what you want by criticizing them, out-talking them, getting angry, or threatening them.")
   RANG-INSTR2
   RANGDOMINATEQ)
  (RANGTHOUQ
   ("How often do you think about getting even with someone who has hurt you?")
   RANG-INSTR2
   RANGTHOUGHTSQ)
  (RANGDESTQ
   ("How often do you damage objects or property, hurt animals or people purposely, or break the law?")
   RANG-INSTR2
   RANGDESTROYQ))
 (REMOT)
 (TB2
  (TB2-INSTR
   ("Important Beliefs Questions"
    "To what degree do you believe the following."))
  (TB2RELATQ
   ("There is no 'absolute' right and wrong or good or bad--it depends upon factors like your point of view, the situation, or one's cultural background.")
   TB2-INSTR
   TBV2RELGOODQ)
  (TB2PUNISQ
   ("We must run our lives by rules, and people who break those rules must be severely punished or we will have chaos.")
   TB2-INSTR
   TBVRULESPUNISHQ)
  (TBV2NOTRQ
   ("If a person has a bad environement and/or genetics, they aren't really responsible for what they do.")
   TB2-INSTR
   TBV2NOTRESPONSIBLEQ)
  (TB2GROUMQ
   ("One group in my life (such as my family, nation, culture, or religion) is so important that I would be almost nothing without them. Life wouldn't be worth living.")
   TB2-INSTR
   TBV2GROUPMEANINGQ)
  (TB2SELFMQ
   ("Life has no meaning in itself, any meaning must be supplied by the individual.")
   TB2-INSTR
   TBV2SELFMEANINGQ)
  (TB2GDWRKQ
   ("People can only be completely forgiven and guilt-free if they are good enough (do enough of the right things).")
   TB2-INSTR
   TBV2GOODWORKSQ)
  (TB2GDATTQ
   ("Goodness (or being forgiven) depends much more on attitude than good deeds.")
   TB2-INSTR
   TBV2GOODATTITUDEQ)
  (TB2ALLGDQ
   ("There is a lot of good in all people no matter what they believe or have done.")
   TB2-INSTR
   TBV2ALLGOODQ)
  (TB2REASOQ
   ("If society would base everything upon reason and science, we would have nothing to worry about.")
   TB2-INSTR
   TBV2REASO)
  (TBV2ASTRQ
   ("I believe in phenomena like communicating with spirits of the deceased, seeing into the future, and astrology.")
   TB2-INSTR
   TBV2ASTROLOGYQ)
  (TB2IDHUMQ
   ("I identify with all humanity more than any single group.")
   TB2-INSTR
   TBV2IDHUMANITYQ)
  (TB2LIFADQ
   ("I believe in some form of life after death.")
   TB2-INSTR
   TBV2LIFEAFDEATHQ)
  (TB2MOVEMQ
   ("Being part of a progressive movement is more important to me than my family or any other group.")
   TB2-INSTR
   TBV2MOVEMENTQ)
  (TBV2COREQ
   ("Despite some doubts, I have a set of strong core beliefs [about God, Nature, Humanity, Right and Wrong, Myself etc.] that I use daily to guide me in all aspects of life.")
   TB2-INSTR
   TBV2COREBELIEFSQ))
 (CARGEN
  (CAR-INSTR
   ("Career or College Major Interests Questions"
    "Degree/Accuracy this describes you."))
  (CAR1CARGQ
   ("I feel extremely satisfied about my career decision.  I have a clear career goal and plan for reaching that goal. My plan has a very high probability for success.")
   CAR-INSTR
   CAR1CARGOALQ)
  (CAR1CARPQ
   ("I have spent a great deal of time going through the process of reaching a career decision doing things such as reading about careers, interviewing others, taking interest tests, thinking about what I want, and getting related work experience.")
   CAR-INSTR
   CAR1CARPRIORITYQ)
  (CAR1INATQ
   ("I really enjoy natural science classes like chemistry, physics, or geology and am considering a career involving some aspect of natural science.")
   CAR-INSTR
   CAR1INATSCIQ)
  (CARIBIOHQ
   ("I really enjoy subjects like biology and am considering a career which might involve a lot of knowledge of biological science. I am considering a major or minor in BIOLOGY, MICROBIOLOGY, or another biological science.")
   CAR-INSTR
   CARIBIOHEALTHSCIQ)
  (CARISOCSQ
   ("I really enjoy learning about myself or other people. I enjoy classes like psychology, sociology, anthropology, economics, or geography. I am considering a career where understanding people, groups, economics, OR cultures may be important.")
   CAR-INSTR
   CARISOCSCIQ)
  (CARIHELPQ
   ("I really enjoy helping people and am considering a career in a 'helping profession' such as counseling, teaching, or social work.")
   CAR-INSTR
   CARIHELPQ)
  (CARIMATHQ
   ("I love math, am very good at it, and am considering a career in which math might play an important part.")
   CAR-INSTR
   CARIMATHQ)
  (CARIMEDQ
   ("I am considering a career in a medical or health-related field. Or I might like a career related to physical education, physical therapy, pharmacy, audiology, speech therapy or some other field which requires a lot of knowledge about biology or the human body.")
   CAR-INSTR
   CARIMEDQ)
  (CARIWRITQ
   ("I love to write and am considering a career in which writing would be very important. OR I have an interest in journalism or radio, TV, or film production.")
   CAR-INSTR
   CARIWRITEQ)
  (CARIFNARQ
   ("I have a serious interest in an art-related field such as art, design, music, dance, photography, or theatre arts.")
   CAR-INSTR
   CARIFNARTQ)
  (CARIETHNQ
   ("I am extremely interested in studying about an ethnic group, about women, or about ancient or current cultures.")
   CAR-INSTR
   CARIETHNICQ)
  (CARILEARQ
   ("I love learning through reading, taking classes, or any other way I can. I might eventually want to get a masters degree or doctorate.")
   CAR-INSTR
   CARILEAR)
  (CARIEXPEQ
   ("I would love to specialize and be an expert at something.  I tend to get passionate interests about one interest area at a time for months or  years. I am considering a career where I might become an expert at something that requires intense study or an advanced degree.")
   CAR-INSTR
   CARIEXPERTQ)
  (CARIGENEQ
   ("I enjoy a large variety of activities. I would like a career where I have a little knowledge about many things. I might rather have a more general degree like a general business, social science, or liberal arts degree that can give me a wide variety of career options.")
   CAR-INSTR
   CARIGENERALQ)
  (CARINOINQ
   ("I have never been very interested in school, any particular subject in school, or any particular career that I know of. I feel very confused about what major or career I want.")
   CAR-INSTR
   CARINOINTERESTQ)
  (CARILITQ
   ("I enjoy reading and literature of many types. I am considering a field like history or literature.")
   CAR-INSTR
   CARILITQ)
  (CARIRECPQ
   ("I really enjoy sports, recreational activiites, and helping others enjoy  them. I am considering a career in a physical education, sports, or recreation-related field.")
   CAR-INSTR
   CARIRECPEQ)
  (CARIPOLIQ
   ("I enjoy learning about law, politics, or government and am considering a career where these subjects may be important.")
   CAR-INSTR
   CARIPOLITICSQ)
  (CARIMIL6Q
   ("Law enforcement, the legal profession, probation, or the military are careers I have an interest in.")
   CAR-INSTR
   CARIMILTARYLAWENFORCEQ)
  (CARIMANUQ
   ("I really enjoy working with machines, electronics, computers, aircraft, medical equipment, construction, or other activities where I can work with my hands and see something I made or repaired. I am less interested in designing these or working behind a desk. I might prefer a technical career which requires only a one- or two-year technical degree at a community college or a technical school.")
   CAR-INSTR
   CARIMANUALACTSQ)
  (CARILANGQ
   ("I really enjoy other countries and learning foreign languages. I am considering majoring or minoring in a foreign language.")
   CAR-INSTR
   CARILANGUAGEQ)
  (CARIPHILQ
   ("I really enjoy philosophy and/or the study of religion. I may want PHILOSOPHY or RELIGION as a major or a minor for my career and/or personal benefit.")
   CAR-INSTR
   CARIPHILANDRELQ)
  (CARIBUSIQ
   ("I expect to work in a business setting or am considering a major or minor in a business-related career.")
   CAR-INSTR
   CARIBUSINESSQ)
  (CARIENGIQ
   ("I am interested in science and/or technical things, math, computers, medical equipment, machines, airplanes, electronics, buildings or public works projects. I might like to build or design things or work with computers. I am considering a career in engineering, engineering technology, computers, architecture, or a related field.")
   CAR-INSTR
   CARIENGINEERQ)
  (CARIFAMCQ
   ("I have a very high interest in one or more of the following--child development, consumer affairs, fashion merchandising, textiles and clothing, nutrition, food industries, gerontology, or teaching home economics or family and consumer affairs. I might be interested in one of these areas as a major or minor in a FAMILY AND CONSUMER SCIENCES area.")
   CAR-INSTR
   CARIFAMCONSCIQ)
  (CARIWOMAQ
   ("I might be interested in majoring or minoring in Women's Studies or studies of a special ethnic group such as Asian or Asian-American Studies, Mexican-American Studies, Black Studies, or Native American Studies.")
   CAR-INSTR
   CARIWOMANETHNICQ)
  (CARICOM8Q
   ("I enjoy working on a computer, learning about software and hardware, and think that I might enjoy a job in a computer-related field where I spend a lot of time designing software or hardware, or working with computers, computer networks, the Internet, or managing others who work with computers.")
   CAR-INSTR
   CARICOMPUTERQ)
  (CARINTE0Q
   ("I might like to have a major that combined two or three other major areas of my choosing. I might like to inquire about designing such a major that fits my particular interests. [Most universities offer such majors under titles like 'Special Major', 'Interdisciplinary Studies', or 'Liberal Arts.']")
   CAR-INSTR
   CARINTERDISCSTQ))
 (CARBUS
  (CARIBMARQ
   ("I enjoy selling or planning how to market things and am considering a career in sales, marketing, market research, or some other form of merchandising. I am considering MARKETING as a major or minor.")
   CAR-INSTR
   CARIBMARKETINGQ)
  (CARIBMANQ
   ("I think I would like being an executive or manager in charge of other people and responsible for a work-group or business. I am considering a career in management or MANAGEMENT as a major or minor.")
   CAR-INSTR
   CARIBMANAGEMENTQ)
  (CARIBINFQ
   ("I enjoy working with computers, and think I would like a career related to business applications of computers. I am considering BUSINESS INFORMATION SYSTEMS as a major or minor department.")
   CAR-INSTR
   CARIBINFORMSYSTEMSQ)
  (CARIBFINQ
   ("I enjoy dealing with money, finance, economics, real estate, and/or business law issues. I am considering a career in a field related to one of these interests. I am considering a major or minor in the FINANCE department.")
   CAR-INSTR
   CARIBFINANCEQ)
  (CARIBHRDQ
   ("I would like teaching and helping people in a business setting and am considering work in personnel, training, or human resource development. I am considering a major or minor in HUMAN RESOURCES MANAGEMENT.")
   CAR-INSTR
   CARIBHRDQ)
  (CARIBACCQ
   ("I would like to work with numbers and do precise, detailed work. I might enjoy working with auditing or tax-related issues.  I am considering a career, major, or minor in ACCOUNTING or a related field.")
   CAR-INSTR
   CARIBACCTOUNTINGQ)
  (CARISPBUQ
   ("I would greatly value developing my speech, communication, or public relations skills to high level and am considering a career where those skills may be very important. I am considering a major or minor in the SPEECH COMMUNICATION department.")
   CAR-INSTR
   CARISPBUSQ))
 (CARENGR
  (CARIEENGQ
   ("I enjoy complex math and might enjoy designing complex electronic systems such as computers.  I am considering a career in electrical or electronic engineering or its option in biomedical engineering.")
   CAR-INSTR
   CARIEENGQ)
  (CARIMEQ
   ("I enjoy design and am interested in the workings of complex mechanical  things. I am considering a career in mechanical engineering or in one of its options of industrial-management engineering, materials engineering, or ocean engineering.")
   CAR-INSTR
   CARIMEQ)
  (CARICHE2Q
   ("I enjoy chemistry and also designing things. I am considering a career in chemical engineering.")
   CAR-INSTR
   CARICHEMENGQ)
  (CARICIVEQ
   ("I think I would enjoy designing things like civil works projects, buildings, or other large projects. I am considering civil engineering as a career.")
   CAR-INSTR
   CARICIVENGQ)
  (CARIAEROQ
   ("I am very interested in aerospace-related engineering and am considering a career as an aerospace engineer.")
   CAR-INSTR
   CARIAEROENGQ)
  (CARIEITEQ
   ("I am interested in an engineering-related field, but am not as interested in complex math or designing systems as I am in technical aspects of one or more of the following--construction management, electronics, manufacturing, or quality assurance. I might be interested in an ENGINEERING TECHNOLOGY major.")
   CAR-INSTR
   CARIEITECHQ)
  (CARICOM9Q
   ("I love math, programming, and computer software design, but am less interested in the electronic circuits and hardware of computers.  I am considering (engineering) computer science as a major.")
   CAR-INSTR
   CARICOMPSCIENGRQ)
  (CARIBCOMQ
   ("I really enjoy working with computers. But I would prefer a business environment more than an engineering, science, or mathematical environment. I might consider getting a major in business with an emphasis in computers or INFORMATION SYSTEMS.")
   CAR-INSTR
   CARIBCOMPUTERQ))
 (CARFINE
  (CARIMUSIQ
   ("I love music and am considering a music-related career or a major or minor in MUSIC.")
   CAR-INSTR
   CARIMUSICQ)
  (CARIARTQ
   ("I love art and am considering an art-related or design-related career or am considering a major in ART.")
   CAR-INSTR
   CARIARTQ)
  (CARIDRAMQ
   ("I love to act and be in plays and am considering professional acting as a career or considering a major or minor in THEATER ARTS.")
   CAR-INSTR
   CARIDRAMAQ)
  (CARIDANCQ
   ("I love to dance and am considering a career in which dance might play an important part or a major or minor in DANCE.")
   CAR-INSTR
   CARIDANCQ)
  (CARIPHOTQ
   ("I have an interest in becoming a photojournalist and would consider a major or minor in PHOTOGRAPHY or PHOTOJOURNALISM.")
   CAR-INSTR
   CARIPHOTJOURNALISMQ)
  (CARINDDEQ
   ("I love to draw and design functional things. I would consider a major in DESIGN or INDUSTRIAL DESIGN.")
   CAR-INSTR
   CARINDDESIG)
  (CARINTE1Q
   ("I love to decorate and would like to design interiors for homes or businesses. I would consider a major in INTERIOR DESIGN.")
   CAR-INSTR
   CARINTERIORDESIG))
 (CARHELP
  (CARITEACQ
   ("I enjoy teaching groups of people and am considering a career where teaching might be an important part of my job.")
   CAR-INSTR
   CARITEACHQ)
  (CARICOUNQ
   ("I enjoy helping people one-on-one and am considering a career in a counseling-related field such as becoming a psychologist or psychiatrist, a school counselor or psychologist, or a social worker.  I know that these all require graduate degrees, and some require psychology as a major. I am considering a major in PSYCHOLOGY (which will also give me the most flexibility in choosing what type of counseling I want to pursue later.)")
   CAR-INSTR
   CARICOUNSELINGQ)
  (CARIEDUCQ
   ("I would strongly like to work in an educational setting such as a public school or university.")
   CAR-INSTR
   CARIEDUCSETTINGQ)
  (CARIHADUQ
   ("I would especially enjoy a career helping ADULTS.")
   CAR-INSTR
   CARIHADULTQ)
  (CARIHCHIQ
   ("I would especially enjoy a career helping CHILDREN or TEENAGERS.")
   CAR-INSTR
   CARIHCHILDQ)
  (CARITVOCQ
   ("I would enjoy teaching vocational or shop courses. I am considering vocational education as a major.")
   CAR-INSTR
   CARITVOCATIONALQ)
  (CARICOM4Q
   ("I would be interested in a career helping people with their speech or helping persons with hearing impairments. I might want a major leading to a career in audiology or speech therapy such as COMMUNICATIVE DISORDERS.")
   CAR-INSTR
   CARICOMDISORDERSQ)
  (CARSOCWOQ
   ("I know that I want to be a social worker and work with public agencies helping people with various types of disabilities or who are in need of help. I know that most jobs are with the government and think I would enjoy working as part of a larger organization dedicated to helping people even though there may be a lot of paperwork, etc. I am considering a major in psychology, sociology, social work, or a related field.")
   CAR-INSTR
   CARSOCWORKQ)
  (CARK12TEQ
   ("I think that I might like to teach in public or private schools in a grade level between Kindergarten and College (K-12). I am interested in a major that leads to a teaching credential.

[In California getting a teaching credential usually means getting a special degree in Liberal Studies for elementary teaching or obtaining one of a select number of majors for teaching high school. Go to your local College or School of Education for more information.]")
   CAR-INSTR
   CARK12TEACHQ)
  (CARMINISQ
   ("I am considering a career in church work or as a minister, priest, rabbi, or other religious leader. Or, I am interested in learning more about or teaching about religion. I am considering a degree in RELIGION, RELIGIOUS STUDIES, or PHILOSOPHY. Or, I am considering a different kind of major such as psychology or sociology that could help me be more effective helping people.")
   CAR-INSTR
   CARMINISTERQ))
 (CARLANG
  (CARIFRENQ
   ("I am very interested in learning or teaching French or considering FRENCH as a major.")
   CAR-INSTR
   CARIFRENCHQ)
  (CARIITALQ
   ("I am very interested in learning or teaching Italian or am considering ITALIAN as a major.")
   CAR-INSTR
   CARIITALIA)
  (CARIGERMQ
   ("I am very interested in learning or teaching German or am considering GERMAN as a major.")
   CAR-INSTR
   CARIGERMA)
  (CARIRUSSQ
   ("I am very interested in learning or teaching Russian or am considering RUSSIAN as a major.")
   CAR-INSTR
   CARIRUSSIA)
  (CARIJAPNQ
   ("I am very interested in learning or teaching Japanese or am considering JAPANESE as a major.")
   CAR-INSTR
   CARIJAPNESEQ)
  (CARICHINQ
   ("I am very interested in learning or teaching Chinese or am considering CHINESE as a major.")
   CAR-INSTR
   CARICHI)
  (CARICLASQ
   ("I am very interested in ancient Greece or Rome and in learning those languages.  I am considering a major in CLASSICS.")
   CAR-INSTR
   CARICLASCSQ)
  (CARISPANQ
   ("I am very interested in learning or teaching Spanish or am considering SPANISH  as a major.")
   CAR-INSTR
   CARISPANISHQ)
  (CARIPORQ
   ("I am very interested in learning or teaching Portuguese or am considering PORTUGUESE as a major.")
   CAR-INSTR
   CARIPORTUGUESEQ))
 (CARMED
  (CARIMDQ
   ("I am considering becoming a physician and have high ability in science. I may want to consider a major in a biological or chemical science with a minor in the other.")
   CAR-INSTR
   CARIMDQ)
  (CARINURSQ
   ("I am considering nursing or a related career or a major in NURSING.

[Obtaining an RN (Registered Nurse) certificate usually only requires a 2-year degree, However, you may prefer a 4-year bachelor's degree in nursing to advance your knowledge or career.]")
   CAR-INSTR
   CARINURSEQ)
  (CARIPTHEQ
   ("I like helping one-on-one and working with the body. I am considering becoming a physical therapist and would consider a major in a pre-physical therapy major such as Kinesiology.")
   CAR-INSTR
   CARIPTHERAPYQ)
  (CARIHEALQ
   ("I am extremely interested in health science, health education, and/or health administration. I am considering a career in one of these fields or a degree in HEALTH SCIENCE or HEALTH CARE ADMINISTRATION.")
   CAR-INSTR
   CARIHEALTHQ)
  (CARIKINEQ
   ("I am interested in studying the human body, its overall movement and function, physical therapy, athletic training, or physical education.  I might be interested in a major in Kinesiology or in a major leading to physical therapy.")
   CAR-INSTR
   CARIKINESOLOGYQ)
  (CARICOM5Q
   ("I would be interested in a career helping people with their speech or helping persons with hearing impairments. I might want a major leading to a career in audiology or speech therapy such as COMMUNICATIVE DISORDERS.")
   CAR-INSTR
   CARICOMDISORDERSQ)
  (CARMEDTEQ
   ("I might prefer to work in a specialized medically-related field working directly with patients such as a technician working with medical imaging, X-rays, dental assistance, nursing, or some other similar field that only requires one to two years at a technical school or community college.")
   CAR-INSTR
   CARMEDTECHQ))
 (CARLAW
  (CARILAWQ
   ("I am considering becoming a lawyer in criminal law (defense, prosecution, etc.). I think that I might prefer to get an undergraduate degree or minor in CRIMINAL JUSTICE.")
   CAR-INSTR
   CARILAWQ)
  (CARICRIMQ
   ("I am considering working in a law enforcement field, within probation, or withi
 another aspect of the legal system. I might be interested in a CRIMINAL JUSTICE major or minor.")
   CAR-INSTR
   CARICRIMQ)
  (CARIMIL7Q
   ("I am considering joining one of the military services or am considering a career in the military. I might be interested in a MILITARY SCIENCE or related major or minor, or I might want to major i
 some other field and join the military later.")
   CAR-INSTR
   CARIMILT2Q))
 (CARNATSCI
  (CARICHE3Q
   ("I enjoy chemistry and am considering a career requiring a lot of knowledge of chemistry (such as chemistry or medicine) or am considering CHEMISTRY, BIOCHEMISTRY, or a related field as a major or minor.")
   CAR-INSTR
   CARICHEMQ)
  (CARIPHYSQ
   ("I enjoy physics and am considering a career requiring a lot of knowledge of physics or PHYSICS as a major or minor.")
   CAR-INSTR
   CARIPHYSICSQ)
  (CARIGEOLQ
   ("I enjoy geology or study of the environment and am considering or GEOLOGY as a major or minor.")
   CAR-INSTR
   CARIGEOLOGYQ)
  (CARIASTRQ
   ("I enjoy astronomy and math am considering a career requiring a lot of knowledge of astronomy or ASTRONOMY as a major or minor.")
   CAR-INSTR
   CARIASTRONOMYQ)
  (CARIENVIQ
   ("I enjoy studying the environment, pollution, and/or ways to make the environment cleaner and safer. I might be interested in a major or minor in earth science or environmental studies.")
   CAR-INSTR
   CARIENVIRSCIQ))
 (CARBESCI
  (CARIPSYCQ
   ("I am extremely interested in learning about myself and understanding people in depth. I am considering a career where working with people or am considering a major or minor in PSYCHOLOGY.")
   CAR-INSTR
   CARIPSYCHQ)
  (CARISOCOQ
   ("I am extremely interested in learning about groups and society. I am considering a career where knowledge of groups and society would be very important, or a SOCIOLOGY major or minor.")
   CAR-INSTR
   CARISOCOLOGYQ)
  (CARIHISTQ
   ("I am extremely interested in history, or am considering a major or minor in HISTORY.")
   CAR-INSTR
   CARIHISTQ)
  (CARIPOLSQ
   ("I am extremely interested in law, politics, and/or studying political systems. I might like to work in public administration, in government or politics, or become an attorney. I am considering a major or minor in POLITICAL SCIENCE or an advanced degree in public administration.")
   CAR-INSTR
   CARIPOLSCQ)
  (CARIECONQ
   ("I am extremely interested in studying the economic behavior of people and/or the  economy as a whole. I am considering a major or minor in ECONOMICS.")
   CAR-INSTR
   CARIECO)
  (CARGEOGRQ
   ("I enjoy studying physical and cultural aspects of various countries or geographic regions. In addition I may enjoy studying topics like climates, mapping, urban life, etc. I might like to major or minor in GEOGRAPHY.")
   CAR-INSTR
   CARGEOGRAPHYQ)
  (CARIAMERQ
   ("I am extremely interested in studying the United States and might like to major or minor in American Studies.")
   CAR-INSTR
   CARIAMERSTQ)
  (CARIANTRQ
   ("Studying humans and various cultures (including ancient ones) in our many social, cultural, and biological aspects is fascinating to me.  I might enjoy majoring or minoring in ANTHROPOLOGY.")
   CAR-INSTR
   CARIANTROQ)
  (CARIANTHQ
   ("I am very interested in studying cultures in general and cultures as a whole for both the past and present from a variety of viewpoints. I am considering ANTHROPOLOGY as a major or minor.")
   CAR-INSTR
   CARIANTHROPOLOGYQ)
  (CARISPEEQ
   ("I am extremely interested in learning about groups and society. I am considering a career where knowledge of groups and society would be very important, or a SOCIOLOGY major or minor.")
   CAR-INSTR
   CARISOCOLOGYQ)
  (CARLINGQ
   ("I like social science, research and theory, and find the study of speech and language fascinating. I might like a major or minor in LINGUISTICS.")
   CAR-INSTR
   CARLINGQ))
 (CARETHNIC
  (CARIAISTQ
   ("I have a very high interest in American Indian culture and studies and might consider it as a major or minor.")
   CAR-INSTR
   CARIAISTUDIESQ)
  (CARIBSTUQ
   ("I have a very high interest in American Indian culture and studies and might consider it as a major or minor.")
   CAR-INSTR
   CARIAISTUDIESQ)
  (CARIMEXAQ
   ("I have a very high interest in Mexican-American culture and studies.")
   CAR-INSTR
   CARIMEXAMERSTUDIESQ)
  (CARIASAMQ
   ("I have a very high interest in Asian-American culture and studies.")
   CAR-INSTR
   CARIASAMQ)
  (CARIAMSTQ
   ("I have a very high interest in studying the American culture as a whole from a variety of viewpoints and disciplines. I might consider AMERICAN STUDIES as a major or minor.")
   CAR-INSTR
   CARIAMSTQ)
  (CARIWSTUQ
   ("I am very interested in studying women--their history, experience, and sex-roles--from a variety of viewpoints. I might be interested in WOMEN'S STUDIES as a major or minor.")
   CAR-INSTR
   CARIWSTUDIESQ))
 (CARWRITE
  (CARIENGLQ
   ("I highly enjoy writing, English literature, and/or possibly teaching English, and am considering ENGLISH or as a major or minor.")
   CAR-INSTR
   CARIENGLITQ)
  (CARIJOURQ
   ("I am considering working for a newspaper or other news media as a journalist or photojournalist; OR I might want to teach journalism; OR  I might want to work in public relations. I am considering JOURNALISM as a major or minor.")
   CAR-INSTR
   CARIJOURNALISMQ))
 (USER-FEEDBACK
  (USERRATE-INSTR
   ("Your Overall Rating of SHAQ" "Degree/Accuracy this describes you."))
  (USERRATEQ
   ("How interesting and beneficial overall would you rate your experience taking SHAQ?

   ADDITIONAL COMMENTS:  
   ==> WE WELCOME YOUR COMMENTS VIA EMAIL:
    If you have suggestions for correcting errors or  improving SHAQ in any way,
    Email to Dr. Tom Stevens at:  tstevens@csulb.edu")
   USERRATE-INSTR
   USERRATEQ)))|#















