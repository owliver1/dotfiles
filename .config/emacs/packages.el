;; -------------------------------------------
;; MELPA Package Management
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; -------------------------------------------
;; Org!
(defun owlmacs/org-mode-setup ()
  (org-indent-mode t)               ;; Enable org-indent-mode
  (variable-pitch-mode 1)            ;; Enable variable pitch font
  (auto-fill-mode 0)                 ;; Disable auto-fill mode
  (visual-line-mode 1)               ;; Enable visual-line-mode
  (setq evil-auto-indent nil)        ;; Disable auto-indent in evil-mode

  ;; Disable line numbers in indented regions (for better visual alignment)
  (setq display-line-numbers nil))    ;; Disable line numbers inside Org mode 

(use-package org
  :ensure t
  :hook (org-mode . owlmacs/org-mode-setup)
  :config
  (setq org-ellipsis " "
        org-hide-emphasis-markers t))

(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
;; -------------------------------------------
;; Evil (Vim Emulation)
(require 'evil)
(evil-mode 1)  ;; Enable Evil mode (mwahaha)

;; -------------------------------------------
;; I like themes!
(use-package doom-themes
  :ensure t
  :config
  ;; Global theme settings
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  ;; Load a theme
  (load-theme 'doom-laserwave t)
  ;; Optional alternative theme (commented out)
  ;; (load-theme 'doom-outrun-electric t)
  ;; Enable visual bell on errors
  (doom-themes-visual-bell-config)
  ;; Correct org-mode fontification
  (doom-themes-org-config))
;; -------------------------------------------
;; LSP configuration!
(use-package lsp-mode
  :ensure t
  :hook ((python-mode . lsp)
         (c-mode . lsp)
         (c++-mode . lsp)
	 (java-mode .lsp)) 
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

;;--------------------------------------------
;; Java Stuff!
;; using jdtls - yay jdtls
(use-package java-mode
  :ensure t)
;; Java formatting using `lsp-java`
(setq lsp-java-format-on-save t)

;; Jump to definition
(setq lsp-enable-symbol-highlighting t)

;; ECLIPSE
(use-package 'eclim
  :ensure t)
(setq eclimd-autostart t)
(defun my-java-mode-hook ()
    (eclim-mode t))
(add-hook 'java-mode-hook 'my-java-mode-hook)

;; -------------------------------------------
;; Snip snip snip
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

;; -------------------------------------------
;; Git Interface!
(use-package magit
  :ensure t)

;; -------------------------------------------
(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode))

;; -------------------------------------------
;; Treemacs!
(use-package treemacs
  :ensure t
  :config
  (global-set-key (kbd "C-c t") 'treemacs)
  (treemacs-git-mode 'extended))

;; -------------------------------------------
;; Dashboard setup!
(defun my/dashboard-banner ()
  "Set a dashboard banner including information on package initialization
time and garbage collections."
  (setq dashboard-banner-logo-title
        (format "Emacs ready in %.2f seconds with %d garbage collections."
                (float-time (time-subtract after-init-time before-init-time)) gcs-done)))

(use-package dashboard
  :ensure t
  :init
  ;; Refresh dashboard after init for all sessions
  (add-hook 'after-init-hook 'dashboard-refresh-buffer)
  (add-hook 'dashboard-mode-hook 'my/dashboard-banner)
  :config
  ;; Configure dashboard appearance
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-center-content t)
  (setq dashboard-vertically-center-content t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)

  ;; Dashboard footer with random messages
  (setq dashboard-footer-messages
        '("i showed you my source code pls respond"
          "bitches hate vi but love evil mode"
          "i love this operating system!"
          "yes i use emacs please leave me alone"
          "Welcome to Emacs! You cannot leave now!"
          "Yes VS-Code is better. No, I won't switch!"
          "Tip of the day: You can use vim to edit emacs init.el over SSH!"
          "i'm going insane please help me"))

  ;; Ensure dashboard items are set!
  (setq dashboard-items '()) 
  ;; Explicitly open dashboard on startup, even when running emacsclient
  (add-hook 'emacs-startup-hook (lambda ()
                                  (unless (get-buffer "*dashboard*")
                                    (dashboard-refresh-buffer))))

  ;; Setup dashboard at startup
  (dashboard-setup-startup-hook))

