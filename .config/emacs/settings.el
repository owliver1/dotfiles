;; -------------------------------------------
;; General Settings & Customization
(setq inhibit-startup-message t
      tab-width 4
      display-line-numbers-width 2
      display-line-numbers 'relative
      indent-tabs-mode nil
      history-length 25
      custom-file (locate-user-emacs-file "custom-vars.el")
      use-dialog-box nil)
(setq initial-buffer-choice (lambda ()
                              (get-buffer-create "*dashboard*")
			      (dashboard-refresh-buffer)))

;; -------------------------------------------
;; Maximizing Minimalism
(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)

;; -------------------------------------------
;; User Interface Tweaks
(global-display-line-numbers-mode 1)    ;; Line numbers globally
(recentf-mode 1)                        ;; Remember recent files
(savehist-mode 1)                       ;; Remember minibuffer history
(save-place-mode 1)                     ;; Remember last visited place
(global-auto-revert-mode 1)             ;; Revert buffers automatically when file changes
(electric-pair-mode 1)                  ;; Automatically insert closing brackets or parentheses

(add-to-list 'auto-mode-alist '("\\.pl\\'" . prolog-mode)) ;; Enable Prolog mode!

;; -------------------------------------------
;; Font Configuration
(set-face-attribute 'default nil
                    :family "Fira Code Nerd Font"  ;; Font family (fira cuz im a nerd)
                    :height 160)                  ;; Font size in 1/10 pt
