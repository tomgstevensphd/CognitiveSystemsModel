;;*********************** CS-explore-questions.lisp ******************************
;;
;;NOTES:

;;CURRENT *ALL-CSQ-QUESTIONS = see file: CSQ-Questions.lisp
;;FORMAT
;; SINGLE-SELECTION QUESTION EG. 
;; ( THEMES
;;   INSTRS, first list after THEMES
;;       (THM-INSTR ("LIFE THEMES and VALUES:" "HOW IMPORTANT is this is to you?"))
;; (THMMENCHQ     ("MENTAL CHALLENGE: Be mentally challenged with difficult and/or creative mental tasks.")     THM-INSTR     THM32MENTALCHALQ)
;;
;;MULTI-SELECTION (MULTI-ITEM) QUESTION EG.
;; Questions found in original QVAR list
;; (UTYPE    (TKNOWMORQ NO-QUEST-STRING-FOUND)   (TEXPERIEQ NO-QUEST-STRING-FOUND)  .  .  .   (WANTSPQQ NO-QUEST-STRING-FOUND)   (WANTSPQQ NO-QUEST-STRING-FOUND))





#|
(defparameter *TEST-PC-element-qvars
  '((PCE-PEOPLE
     ("mother""mother"  "single-text" ("mother" "1" "motherQ" "pc-element" "Pc-Element"))
     ("father""father"  "single-text" ("father" "2" "fatherQ" "pc-element" "Pc-Element"))
     ("best-m-friend""best-m-friend"  "single-text" ("best-m-friend" "3" "best-m-friendQ" "pc-element" "pc-Element" getname-p))
     ("best-f-friend""best-f-friend"  "single-text" ("best-f-friend" "4" "best-f-friendQ" "pc-element" "pc-Element" getname-p))
     ("m-dislike""m-dislike"  "single-text" ("m-dislike" "5" "m-dislikeQ" "pc-element" "pc-Element" getname-p))
     :single-text
;;delete parens after test
)))
|#

(defparameter *cs-explore-phrase nil  "Phrase describing CS or PC being explored by CS-Explore--used in question text.")

;;  REFINE THESE CATEGORIES/QUESTIONS, THEN CHANGE QVARS TOO
(defparameter  *All-CS-exploreQs                           ;;like *All-PCE-elementQs
  '( (CS-DECLARATIVE
      ;;(instr-symbol (frame-title  frame-instrs) 
      (CS-DECLARATIVE-INSTR ("LINKS TO OTHER NODES" (format nil "~%        Type answer in box to right below:     ") ))  ;;*CS-PC-current) 
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
      (VALNKQ ( (format nil "What value(s) do you most strongly associate with  ~A?" *cs-explore-phrase)) CS-WORLDVIEW-INSTR *multi-input-box-instrs)
      (SELFQ ( (format nil "How does ~A affect you personally?" *cs-explore-phrase)) CS-WORLDVIEW-INSTR *multi-input-box-instrs)
      (OBJQ  ( (format nil "What OBJECT(s) do you most associate with ~A?" *cs-explore-phrase)) CS-WORLDVIEW-INSTR *multi-input-box-instrs)
      ;;(POSEXPQ ( (format nil "What POSITIVE outcomes do you expect will follow from ~A?" *cs-explore-phrase)) CS-WORLDVIEW-INSTR *multi-input-box-instrs)
      ;;(NEGEXPQ ( (format nil "What NEGATIVE outcomes do you expect will follow from ~A?" *cs-explore-phrase)) CS-WORLDVIEW-INSTR *multi-input-box-instrs)
      ;;end CS-WORLDVIEW
      )
     (CS-PROCEDURAL
      (CS-PROCEDURAL-INSTR ("LINKS TO OTHER NODES" (format nil "~%        Type answer in box at bottom:     ") )) 
      (SUPGQ  ( (format nil "Is ~A a part of meeting bigger goals? ~% List one HIGHER GOAL in each popup window (or leave blank if none): " *cs-explore-phrase)) CS-PROCEDURAL-INSTR *multi-input-box-instrs)
      (SUBGQ  ( (format nil "What SUB-GOAL(S) do you have from:  ~A?~% List sub-goal in each popup (or leave blank if none)." *cs-explore-phrase)) CS-PROCEDURAL-INSTR *multi-input-box-instrs)
      (SCRPTQ ((format nil "What SCRIPTS or THEMES for behavior (eg. 'ordering in a restaurant') do you associate with  ~A? ~% List one in each popup window (or leave blank if none)." *cs-explore-phrase) )CS-PROCEDURAL-INSTR *multi-input-box-instrs)
      (SITQ  ( (format nil "What situations or stimuli usually or frequently PRECEDE  ~A? ~% List one in each popup window (or leave blank if none)." *cs-explore-phrase)) CS-PROCEDURAL-INSTR *multi-input-box-instrs)
      (ALTRQ  ( (format nil "What are some (of the main) alternatives to  ~A? ~% List one in each popup window (or leave blank if none)." *cs-explore-phrase)) CS-PROCEDURAL-INSTR *multi-input-box-instrs)
      (ACTQ ( (format nil "What habits, actions, or skills do you strongly associate with  ~A? ~% List one in each popup window (or leave blank if none)." *cs-explore-phrase)) CS-PROCEDURAL-INSTR *multi-input-box-instrs)
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
      ;;(TACTLQ  ((format nil "What tactile sensations come to mind when you think of /do you associate with  ~A?" *cs-explore-phrase)) CS-MODALITY-INSTR *multi-input-box-instrs)
      ;;end CS-MODALITY
      )   
     (CS-EMOTION
      (CS-EMOTION-INSTR ("LINKS TO OTHER NODES" (format nil "~%        Type answer in box at bottom:     ") ))  ;;*CS-PC-current) 
      (EMOTQ  ((format nil "What emotion(s) (HAPPY, CARING, ANXIETY, ANGER, SAD, NONE-OF-ABOVE) do you MOST associate with ~A?" *cs-explore-phrase)) CS-EMOTION-INSTR *multi-input-box-instrs)
      #|   (HAPPYQ  ((format nil "What emotions do you associate with ?  Anxiety, sad, anger, happiness, love, etc ask each separately  ~A?" *cs-explore-phrase)) CS-DECLARATIVE-INSTR *multi-input-box-instrs)|#
      ;; ADD?? With FUQ  ((format nil "Why, What events/situations/ etc come to mind  ~A?" *cs-explore-phrase))
      ;;end CS-EMOTION
      )
     ;;END-ALL
     ) "QUESTIONS for making CS-explore questions to explore a CS links in depth")

;;*ALL-CS-EXPLOREQS-OLD
#|(defparameter  *All-CS-exploreQs-OLD                            ;;like *All-PCE-elementQs
  '(
#|    (PCE-PEOPLE
     (PCE-PEOPLE-INSTR ("People Important To You"  *Instr-Name-element))|#
  (CS-LINKTYPE
   ;;(instr-symbol (frame-title  frame-instrs) 
   (CS-LINKTYPE-INSTR ("LINKS TO OTHER NODES" (format nil "~%        Type answer in box at bottom:     ") ))  ;;*CS-PC-current) 
   ;;was (format nil  "Associations with the word, class, concept, or instance=> ~A."  *cs-explore-phrase)
   (ISAQ  ((format nil "What kind(s) or type(s) is ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
   (PARTQ  ( (format nil "List the most important members or parts of  ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
   (WHYQ  ((format nil "  ~A: Why is it important or why does it exist?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
   (CAUSEQ  ((format nil "What caused  ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
   (EVIDENCEQ  ( (format nil "What is the evidence for  ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
   (HOWQ  ( (format nil "What are important steps or ways to  ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
   (EXQ  ( (format nil "Give a good example or instance of  ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
   (EVENTQ  ((format nil "What main event(s) preceded ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
   (FEATUREQ  ( (format nil "What are the main features or characteristics of  ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
   (STEREOTYPEQ  ((format nil "What are other (features/chars.) of  ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
   (REGNANTQ  ((format nil " ~A almost always or exclusively associated with WHAT?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
   (PROTOTYPEQ  ( (format nil "What example best demonstrates the essence of/most features of  ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
   (ALT-RQ  ( (format nil "What are some (of the main) alternatives to  ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
;;MODALITY LINKS--------
;;VERBAL
   (NAMEQ  ( (format nil "What is the (best) name for  ~A?" *cs-explore-phrase))  CS-LINKTYPE-INSTR *input-box-instrs)
   (DEFINEQ  ((format nil "What is the best definition of ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *input-box-instrs)
   (DESCRIBEQ  ( (format nil "What is the best description of  ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *input-box-instrs)
   (OPPOSITEQ  ( (format nil "What is the opposite of  ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *input-box-instrs)
   (SYNONYMQ  ( (format nil "What words have a meaning similar to  ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
   (IMAGEQ   ((format nil "What visual image(s) come to mind when you think of/do you associate with  ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
   (SOUNDQ  ( (format nil "What sounds come to mind when you think of/do you associate with  ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
   (SMELLQ  ((format nil "What smells come to mind when you think of /do you associate with  ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
   (TASTEQ  ((format nil "What tastes come to mind when you think of /do you associate with  ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
   (EMOTIONQ  ((format nil "What emotion(s) (HAPPY, CARING, ANXIETY, ANGER, SAD) do you MOST associate with ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
#|   (HAPPYQ  ((format nil "What emotions do you associate with ?  Anxiety, sad, anger, happiness, love, etc ask each separately  ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *input-box-instrs)|#
;; ADD?? With FUQ  ((format nil "Why, What events/situations/ etc come to mind  ~A?" *cs-explore-phrase))
TACTILEQ  ((format nil "What tactile sensations come to mind when you think of /do you associate with  ~A?" *cs-explore-phrase))
(SITUATIONS-SDQ  ( (format nil "What situations or stimuli usually or frequently PRECEDE  ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
    (MOTOR S-R LINKSQ  ( (format nil "What habits, actions, or skills do you strongly associate with  ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
;;VALUES, GOALS, REINFS
   (VALUEQ ( (format nil "What values do you strongly associate with  ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
  (SUPGOALQ  ( (format nil "Is ~A a part of meeting a larger goal? If not, leave blank. Otherwise list the HIGHER GOAL(S) below: " *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
  (SUBGOALQ  ( (format nil "What SUB-GOAL(S) do you have from:  ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
  (REINFQ ((format nil "What rewards or positive outcomes do you associate with  ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
  (PUNISHQ ((format nil "What negative outcomes do you associate with  ~A?" *cs-explore-phrase)) CS-LINKTYPE-INSTR *multi-input-box-instrs)
  (SCRIPTQ ((format nil "What SCRIPTS for behavior (eg. 'ordering in a restaurant') do you associate with  ~A?" *cs-explore-phrase) )CS-LINKTYPE-INSTR *multi-input-box-instrs)
  )))|#

;;FOR CS-EXPLORE
(defparameter *input-box-instrs  '("Type answer in BOX below:") "For instructions inside the text-input-pane")
(defparameter *multi-input-box-instrs  '("Type only ONE answer in BOX below. 
     * Type any additional answers in other popup windows.  
     * If NO ANSWER or UNCERTAIN, leave blank. 
     * When finished with all answers, click on LAST button.") "For instructions inside the text-input-pane")


;;***************************** PC-Questions.lisp ************************
;;
#|
(length (third *all-PC-element-qvars)) = 25
(length (second *all-PC-element-qvars)) = 32
 (length (second *All-PCE-elementQs)) = 27
 (length (third *all-PC-element-qvars)) = 8
 (length (third *All-PCE-elementQs)) = 9
|#


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
#|(defparameter *Instr-Name-element "Write the (first + last name initial) NAME of a person that fits the description well. DO NOT use the same person twice!")
(defparameter *Instr-rate-value "Check the statement that best describes how important this value or characteristic is to you (or how you feel about it).
          [Example: How important that a you, another person, object, event, etc. BE THIS WAY.]")
(defparameter *Rate-elm-title " VALUE TO YOU")
(defparameter *Instr-rate-elm-value "Check the statement that best describes how you FEEL about this person, element, or aspect of your life.")
(defparameter *Rate-pc-title " IMPORTANCE TO YOU")|#

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
















