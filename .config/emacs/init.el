; Set up emacs configuration directory!
(setq user-emacs-directory (expand-file-name "~/.config/emacs/"))

;; Packages!
(load-file (expand-file-name "packages.el" user-emacs-directory)) ;; Load packages from packages.el

;; Settings!
(load-file (expand-file-name "settings.el" user-emacs-directory)) ;; Load settings from settings.el

;; Keybinds!
(load-file (expand-file-name "keybinds.el" user-emacs-directory)) ;; Load keybinds from keybinds.el

;; Functions!
(load-file (expand-file-name "functions.el" user-emacs-directory)) ;; Load functions from functions.el
