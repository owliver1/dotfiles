;; -------------------------------------------
;; Custom functions!
(defun run-file-in-eshell ()
  "Run the current file in eshell, based on its mode."
  (interactive)
  (let ((filename (buffer-file-name)))  ; Get the current file's name
    (if filename
        (cond
         ;; If the file is a Python file
         ((derived-mode-p 'python-mode)
          (progn
            (eshell)  ; Open eshell
            (eshell-return-to-prompt)  ; Ensure the prompt is ready
            (insert (concat "python3 " filename))  ; Insert the Python run command
            (eshell-send-input)))  ; Execute the command

         ;; If the file is a Prolog file
         ((derived-mode-p 'prolog-mode)
          (progn
            (eshell)  ; Open eshell
            (eshell-return-to-prompt)  ; Ensure the prompt is ready
            (insert (concat "swipl -s " filename))  ; Insert the Prolog run command
            (eshell-send-input)))  ; Execute the command

	 ((derived-mode-p 'c-mode)
          (let ((output (concat (file-name-extension filename) ".out"))) ; Output file
            (progn
              (eshell)
	      (eshell-return-to-prompt)  
              (insert (concat "gcc -o " output " " filename))
              (eshell-send-input)
              (sit-for 1)
              (eshell-return-to-prompt)
              (insert (concat "./" output))
              (eshell-send-input)))) 
	 	 
         ;; Unsupported file type
         (t (message "Unsupported file type.")))
      ;; No file associated with the buffer
      (message "No file associated with the buffer."))))



(defun reload-init-file ()
  "Reload the Emacs init file."
  (interactive)
  (load-file "~/.config/emacs/init.el")
  (message "Init file reloaded"))

(defun run-ollama()
  (interactive)
  (progn
    (eshell)
    (with-current-buffer (get-buffer "*eshell"))
    (insert "ollama run llama3.1")
    (eshell-send-input)))

(defun run-draw-sld-tree (file query)
  "Run Prolog with a given knowledge base and query, automatically sending RET after each trace call."
  (interactive
   (list (read-file-name "Select Prolog knowledge base: " "~/")
         (read-string "Enter Prolog query: ")))
  (let* ((escaped-query (replace-regexp-in-string "'" "\\'" query))
         (command (format "trace, %s, halt." escaped-query))
         (prolog-process (start-process "prolog-process" "*Trace Output*"
                                       "swipl" "-q" "-s" (expand-file-name file) "-g" command)))
    (write-region "" nil "~/.config/emacs/workflows/Prolog/sld_tree_temp.txt")
    ;; Set up the process filter to handle interaction
    (set-process-filter prolog-process
                        (lambda (proc output)
                           (write-region output nil "~/.config/emacs/workflows/Prolog/sld_tree_temp.txt" t)
                          (process-send-string proc "\n")))

    ;; Wait for the Prolog process to finish before running Python
    (set-process-sentinel prolog-process
                      (lambda (proc event)
                        (when (string= event "finished\n")
                          (run-python-script)
                          (let ((right-window (get-buffer-window "*SLD Tree*"))) ; Get the window displaying the buffer
                            (when right-window 
                              (window-resize right-window -40 t)  ; Resize the window
                              (with-current-buffer "*SLD Tree*"
                                (text-scale-set -3))))))))
  ;; Function to run the Python script
  (defun run-python-script ()
    (let* ((python-script (expand-file-name "~/.config/emacs/workflows/Prolog/sld_tree.py"))
           (python-process (start-process "python-process" "*SLD Tree*"
                                       "python" python-script)))
      ;; Set up the process filter to insert output into the buffer
      (set-process-filter python-process
                          (lambda (proc output)
                            (with-current-buffer (process-buffer proc)
                              (goto-char (point-max)); Ensure the point is at the end of the buffer
                              (insert output)))) ; Insert the output into the buffer

      ;; Clear the *SLD Tree* buffer before starting to show the new output
      (with-current-buffer (get-buffer-create "*SLD Tree*")
        (erase-buffer)) ; Clear any previous content

      ;; Create a new window on the right for the *SLD Tree* buffer
      (let ((right-window (split-window-right)))
        ;; Display the buffer in the newly created window
        (select-window right-window)
        (pop-to-buffer "*SLD Tree*")))))

;; Compiles and runs C code
(defun run-c-code ()
  "Compile and run the current C file."
  (interactive)
  (let ((file (file-name-nondirectory buffer-file-name))
        (output (concat (file-name-sans-extension (file-name-nondirectory buffer-file-name)) ".out")))
    (save-buffer)  ;; Save the file before compiling
    (compile (format "gcc -o %s %s && ./%s" output file output))))

(defun kill-no-mercy ()
  "Delete text without copying it to the kill ring."
  (interactive)
  (if (use-region-p) 
      (delete-region (region-beginning) (region-end))
    (delete-char -1)))

(defun indent-region-custom(numSpaces)
    (progn 
        ; default to start and end of current line
        (setq regionStart (line-beginning-position))
        (setq regionEnd (line-end-position))
        
        ; if there's a selection, use that instead of the current line
        (when (use-region-p)
            (setq regionStart (region-beginning))
            (setq regionEnd (region-end))
        )
        
        (save-excursion ; restore the position afterwards            
            (goto-char regionStart) ; go to the start of region
            (setq start (line-beginning-position)) ; save the start of the line
            (goto-char regionEnd) ; go to the end of region
            (setq end (line-end-position)) ; save the end of the line
            
            (indent-rigidly start end numSpaces) ; indent between start and end
            (setq deactivate-mark nil) ; restore the selected region
        )
    )
)

(defun untab-region (N)
    (interactive "p")
    (indent-region-custom -4)
)

(defun tab-region (N)
    (interactive "p")
    (if (active-minibuffer-window)
        (minibuffer-complete)    ; tab is pressed in minibuffer window -> do completion
    ; else
    (if (string= (buffer-name) "*shell*")
        (comint-dynamic-complete) ; in a shell, use tab completion
    ; else
    (if (use-region-p)    ; tab is pressed is any other buffer -> execute with space insertion
        (indent-region-custom 4) ; region was selected, call indent-region-custom
        (insert "    ") ; else insert four spaces as expected
    )))
)
