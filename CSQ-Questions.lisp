;;***************************** PC-Questions.lisp ************************
;;
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













;;SIMILAR TO 
#|
(defparameter *all-SHAQ-questions
  '(
    ( THEMES
      (THM-INSTR ("LIFE THEMES and VALUES:" "HOW IMPORTANT is this is to you?"))
      (THM1ACHQ (  "Being the best at whatever I do (example: making top grades). Achieving more than most other people.") THM-INSTR  THM1ACHQ)
      (THM3EDUCQ ("EDUCATION: Earning at least a bachelor's or higher degree--preferably a master's or doctorate and making top grades.") THM-INSTR  THM3EDUCQ)
      )))|#