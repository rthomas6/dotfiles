;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ray Thomas"
      user-mail-address "mhsbari@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Treat underscore as word character
(modify-syntax-entry ?_ "w")
(add-hook! (vhdl-mode sh-mode tcl-mode) :append (modify-syntax-entry ?_ "w"))
;(add-hook! 'sh-mode (modify-syntax-entry ?_ "w"))
;(add-hook! 'tcl-mode (modify-syntax-entry ?_ "w"))

(add-hook! org-mode (setq fill-column 80))

;VHDL 2008 for syntax checking
(add-hook! vhdl-mode :append (setq flycheck-ghdl-language-standard "08"))

;; Custom keybindings
(map! :nivr "C-j" 'evil-window-down
      :nivr "C-k" 'evil-window-up
      :nivr "C-h" 'evil-window-left
      :nivr "C-l" 'evil-window-right
      :n "L" 'centaur-tabs-forward
      :n "H" 'centaur-tabs-backward)

(map! :prefix ("," . "Ray's leader key")
      :n "h" 'help-for-help
      :n "b" 'switch-to-buffer
      :n "n" 'neotree-toggle
      :n "t" 'org-todo-list
      :n "j" 'org-journal-new-entry
      :n "c" 'org-capture
      :n "p" (cmd! (find-file "~/org/projects.org")))

;; Org config
(after! org
  (setq
   ;Add a D level priority and make C the default
   org-lowest-priority 68
   org-default-priority 67
   org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)"))
   org-stuck-projects '("project+LEVEL=2/-DONE" ("TODO" "WAITING") nil "")
   org-capture-inbox-file "~/org/inbox.org"
   org-capture-projects-file "~/org/projects.org"
   org-agenda-todo-ignore-scheduled 'future)
  ;Org capture templates
  (add-to-list 'org-capture-templates
               '("i" "Add note to inbox" entry
                (file "~/org/inbox.org")
                ""
                :prepend t :kill-buffer t))
  (add-to-list 'org-capture-templates
               '("g" "Add item to grocery list" checkitem
                (file+olp "~/org/projects.org" "Lists" "Groceries")
                ""
                :prepend t :kill-buffer t)))

;;Make fullscreen
(add-to-list 'default-frame-alist '(fullscreen . maximized))
