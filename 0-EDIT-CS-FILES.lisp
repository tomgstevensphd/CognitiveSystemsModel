;;************************** 0-EDIT-CS-FILES.lisp **************************
;;
(defparameter *CS-edit-files-open nil)


;;RUN HELP FUNCTIONS?
  (when (null (boundp '*initial-help-functions))
   ;; DISPLAY A KEY BINDINGS WINDOW
  (my-keybinds)
   ;; DISPLAY A TEMPLATE WINDOW open in buffer 0-CODE-TEMPLATES.lisp
   (my-edit-file "C:/3-TS/LISP PROJECTS TS/CogSys-Model/0-CODE-TEMPLATES.lisp")
   ;; (pathnamep "C:/3-TS/LISP PROJECTS TS/CogSys-Model/0-CODE-TEMPLATES.lisp" = NIL
   (defparameter *initial-help-functions T)
   ;;end when  *intial-help-functions
  )

;;DEFUN EDIT-CS-FILES
;;2018
;;ddd
(defun edit-cs-files (&optional re-open-cs-files-p)
  ""
  (unless (and *CS-edit-files-open (null re-open-cs-files-p))

    ;;MY-UTILITY FILES
    (my-edit-files 
     '(
  ;;these should load in .lispworks
       "U-BASIC-functions.lisp"
       "U-function-plotter.lisp"
       "U-files.lisp"
       "U-lists.lisp"
       "U-debug.lisp"
       "U-tstring.lisp"
       "U-symbol-info.lisp"
       "U-capi.lisp"
       "U-math.lisp"
       "U-clos.lisp"
       "U-LW-editor.lisp"
       "U-capi-buttons-etc.lisp"
       "U-capi-input-interfaces.lisp"
       "U-fonts.lisp"
       ;;TREEVIEW FILES??
       "U-trees.lisp"
       "CS-net-viewer.lisp"
       "U-capi.lisp"
       )
     :dir "C:/3-TS/LISP PROJECTS TS/MyUtilities")

    ;;ART-UTILITIES FILES
    (my-edit-files
     '(
       "U-data-functions.lisp"
       "ART-multipane-interface.lisp"
       "U-art-math-utilities.lisp"
       "ART-data-analysis.lisp"
       "ART-inputs.lisp"
       "U-ART.lisp"
       )
     :dir "C:\\3-TS\\LISP PROJECTS TS\\ART-Utilities")

    ;;FROM SHAQ??
    ;;"C:\\3-TS\\LISP PROJECTS TS\\SHAQ\\help-info.lisp"


    ;;/COGSYSOUTPUTS FILES
    (my-edit-files 
     '("Tom-AllData2017-01-copy"
       )
     :dir "C:/3-TS/LISP PROJECTS TS/CogSysOutputs")

    ;;COGSYS-MODEL FILES
    (my-edit-files 
     '(
       ;;utility files
       "U-CS-ART.lisp"
       "U-CS-symbol-trees.lisp"
       "U-CS-data-results-functions.lisp"

       ;; "U-CSQ.lisp"
       ;;CS (CogSys) files
       "CS-network.lisp"
       ;;model files
       "CS-PERSIM.lisp"  
       ;;CSQ-SHAQ INIT FILE(S)
       "CSQ-value-rank-frame.lisp"
       ;;Other CSQ-SHAQ joint files
       "CSQ-SHAQ-new-scales.lisp"
       ;;only SHAQ  "CSQ-SHAQ-all-scale-and-question-var-lists.lisp"
       "CSQ-SHAQ-Frames.lisp"
       "CSQ-SHAQ-Frame-quest-functions.lisp"
       ;;CSQ only files (not incl utility files)
       "CSQ-QVARS.lisp"
       "CSQ-Questions.lisp"
       "CSQ-scales.lisp"
       "CSQ-frames-intros.lisp"
       ;;MOST USED FILES -- DO LAST SO PUT IN BUFFERS
       "CSQ-config.lisp"
       "CS-config.lisp"
       "U-CS.lisp"
       "CSQ-Manage.lisp"
       )
     :dir "C:/3-TS/LISP PROJECTS TS/CogSys-Model")

    (setf  *CS-edit-files-open   T)
      ;;end unless, edit-cs-files
    ))
;;RUN
;; (EDIT-CS-FILES)



