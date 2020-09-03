(setq
 inhibit-startup-screen t
 create-lockfiles nil
 make-backup-files nil
 column-number-mode t
 scroll-error-top-bottom t
 show-paren-delay 0.5
 use-package-always-ensure t
 sentence-end-double-space nil)

;; Package manager
;; Straight
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
;; Use Straight by default
(setq straight-use-package-by-default t)

;; Bootstrap `use-package`
(straight-use-package 'use-package)

;;packages
(use-package evil
  :config
  (evil-mode t))

(use-package monokai-theme)
(use-package neotree)
(use-package helm
  :config
  (helm-mode t))

(use-package magit)

(use-package org-journal
  :config
  (setq org-journal-file-type 'daily)
  (setq org-journal-dir "~/journal"))
(use-package projectile)
(use-package helm-projectile)
(use-package helm-ag)
(use-package evil-numbers)
(use-package dumb-jump)
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)

;;Visual customization
(load-theme 'monokai t)
;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
;;(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;;Show line numbers
(global-display-line-numbers-mode)

;;Tab bar
(global-tab-line-mode)

;;Make fullscreen
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Org mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)
(setq org-default-notes-file (concat org-directory "/inbox.org"))
(setq org-log-done t)
;;Add next keyword
(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)")))
;;Use all files in org directory for building agenda view
(setq org-agenda-files `(,org-directory))
;;Allow refiling at the top level of a file
(setq org-refile-use-outline-path 'file)
;;Copy-pasted code that lets me refile to any other file used in agenda view
(setq org-refile-targets '((nil :maxlevel . 9)
                                (org-agenda-files :maxlevel . 9)))
(setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
(setq org-refile-use-outline-path t)                  ; Show full paths for refiling
;;Indent outline stages more
(setq org-startup-indented 1)
(setq org-indent-indentation-per-level 4)

;;Wrap
(add-hook 'org-mode-hook '(lambda () (setq fill-column 80)))
;;(add-hook 'org-mode-hook 'auto-fill-mode)

;;Show images
(setq org-startup-with-inline-images 1)
(setq org-image-actual-width nil)

;;Helm
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;;Projectile
(projectile-mode t)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;evil mode keybindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar my-leader-map (make-sparse-keymap)
  "Keymap for \"leader key\" shortcuts.")

;; binding "," to the keymap
(define-key evil-normal-state-map "," my-leader-map)

;;(define-key my-leader-map "n" 'neotree-toggle)
(define-key my-leader-map "n" 'helm-find-files)
(define-key my-leader-map "b" 'helm-mini)
(define-key my-leader-map "p" 'projectile-command-map)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
(define-key my-leader-map "h" 'help-for-help-internal)

(define-key evil-normal-state-map "H" 'previous-buffer)
(define-key evil-normal-state-map "L" 'next-buffer)
(define-key global-map (kbd "M-b") 'helm-mini)
(define-key my-leader-map "j" 'org-journal-new-entry)

(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-z") 'evil-numbers/dec-at-pt)

(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
(evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
(evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)

;;Make words include underscores in VHDL
(add-hook 'vhdl-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))

;;Other custom keybindings
(global-set-key (kbd "C-x g") 'magit-status)

;;Default file
(find-file "~/org/projects.org")

;;custom
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f3ab34b145c3b2a0f3a570ddff8fabb92dafc7679ac19444c31058ac305275e1" default))
 '(org-capture-templates
   '(("g" "Add item to grocery list" checkitem
      (file+olp "~/org/projects.org" "Lists" "Groceries")
      "")
     ("i" "Add note to inbox" entry
      (file "~/org/inbox.org")
      "")))
 '(org-hide-leading-stars t)
 '(org-stuck-projects '("project+LEVEL=2/-DONE" ("TODO" "WAITING") nil ""))
 '(package-selected-packages '(evil use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
