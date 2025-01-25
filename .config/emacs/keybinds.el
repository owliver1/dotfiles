;; Keybindings!
(global-set-key (kbd "C-c l") 'comment-line) ;; For commenting a line
(global-set-key (kbd "C-c o r f") 'recentf-open-files) ;; For opening recent files
(global-set-key (kbd "C-c e c") (lambda () (interactive) (find-file "~/.config/emacs/configuration.org")))
(global-set-key (kbd "C-c r") 'run-file-in-eshell)
(global-set-key (kbd "C-c e r") 'reload-init-file)
(global-set-key (kbd "C-S-c") 'kill-ring-save) ;; for copying
(global-set-key (kbd "C-S-v") 'yank)  ;; for pasting
(global-set-key (kbd "C-S-x") 'kill-region) ;; for cutting
(global-set-key (kbd "<delete>") 'kill-no-mercy) ;; make it DIE
(global-set-key (kbd "<backtab>") 'untab-region) ;; tabby!
(global-set-key (kbd "<tab>") 'tab-region) ;; untab
 

