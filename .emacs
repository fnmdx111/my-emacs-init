;; packages installed
;; - paredit
;; - cider
;; - ocpindent
;; - merlin
;; - smart compile
;; - tuareg
;; - org
;; - solarized-theme


(global-set-key (kbd "C-c C-.") (lambda ()
                                  (interactive)
                                  (find-file "~/.emacs")))

;; ================
;; setting up MELPA
;; ================
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

;; ========================
;; restoring option to meta
;; ========================
(set-keyboard-coding-system nil)

;; ==================
;; setting up ParEdit
;; ==================
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook #'eldoc-mode)
(add-hook 'lisp-interaction-mode-hook #'eldoc-mode)
(add-hook 'ielm-mode-hook #'eldoc-mode)

(require 'eldoc) ; if not already loaded
(eldoc-add-command 'paredit-backward-delete 'paredit-close-round)

(add-hook 'cider-mode-hook #'enable-paredit-mode)
(add-hook 'cider-mode-hook #'eldoc-mode)
(add-hook 'clojure-mode-hook (lambda () (cider-mode)))
(add-hook 'clojurescript-mode-hook (lambda () (cider-mode)))

;; ============
;; user details
;; ============
(setq user-full-name "Zihang Chen")
(setq user-full-mail-address "zc2324@columbia.edu")
(setq inhibit-splash-screen t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(set-default 'truncate-lines t)

(setq x-select-enable-clipboard t)
(delete-selection-mode t)

(setq tab-width 4
      indent-tabs-mode nil)

(global-set-key (kbd "C-c C-c") 'eval-buffer)
(add-hook 'c-mode
          (lambda ()
            (global-set-key) (kbd "C-c C-c") #'smart-compile))

(setq visible-bell t)
(show-paren-mode t)

(when window-system
  (progn (menu-bar-mode 1)
	 (load-theme 'solarized-dark t)))

(global-linum-mode t)

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; ======================
;; ocaml related settings
;; ======================
(require 'smart-compile)
(add-to-list 'smart-compile-alist
             '(tuareg-mode . "ocamlopt -o %n %f"))

(setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))

(require 'ocp-indent)
(require 'merlin)

(add-hook 'tuareg-mode
          (lambda ()
            (global-set-key) (kbd "C-c C-c") #'smart-compile))

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; =================
;; setting up AucTeX
;; =================
(setenv "PATH"
        (concat "/usr/texbin" ":"
                (getenv "PATH")))
(setq-default TeX-engine 'xetex)
(setq-default TeX-PDF-mode t)


;; ===================
;; setting up org-mode
;; ===================
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c b") 'org-iswitchb)

(add-hook 'org-mode-hook
          (lambda ()
            (writegood-mode)))
(add-hook 'latex-mode-hook
          (lambda ()
            (writegood-mode)))

;; =================
;; org-mode settings
;; =================
(setq org-log-done t
      org-todo-keywords '((sequence "TODO" "INPROG" "DONE"))
      org-todo-keyword-faces '(("INPROG" . (:foreground "blue"
                                            :weight bold))))


;; ===========================
;; auto-complete configuration
;; ===========================
(require 'auto-complete-config)
(ac-config-default)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
