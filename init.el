;;; init.el --- Initialization file for Emacs.
;;; Commentary:
;;; This is my Emacs setup.
;;; author: @gonzomember

;;; Code:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
  ;'(global-linum-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 ;'(linum-format "%4d ")
 '(make-backup-files nil)
 '(auto-save-default nil)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(menu-bar-mode nil)
 '(tooltip-mode nil)
 ;'(ido-mode t)
 ;'(ido-enable-flex-matching t)
 ;'(ido-everywhere t)
 '(org t)
 '(org-log-done t))

(put 'dired-find-alternate-file 'disabled nil)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; initialize MELPA
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; setup `use-package` package, install if not previously installed
(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))

(require 'use-package)

;; now setup all 3rd party packages and install them as necessary
(use-package monokai-theme
  :ensure t
  :init (progn
          (load-theme 'monokai t)))

(use-package flycheck
  :ensure t
  :init (progn
          (add-hook 'after-init-hook #'global-flycheck-mode)))

(use-package auto-complete
  :ensure t
  :init (progn
          (ac-config-default)))

(use-package helm
  :ensure t
  :init (progn
          (setq default-directory "~/Projects/")
          (helm-mode t)
          (bind-key "C-c h" 'helm-mini)))

(use-package slime
  :ensure t
  :commands slime
  :init (progn
            ;this works well for OS X and brew but on linux usually requires a symlink
            (setq inferior-lisp-program (executable-find "sbcl"))
            (setq slime-contribs '(slime-scratch slime-editing-commands))
            (setq slime-contribs '(slime-fancy))))

(use-package haskell-mode
  :ensure t
  :init (progn
          (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)))

(use-package markdown-mode
  :ensure t
  :mode (("\\.markdown\\'" . markdown-mode) ("\\.md\\'" . markdown-mode)))

(use-package coffee-mode
  :ensure t
  :init (progn
          (setq coffee-tab-width 2)))

(use-package literate-coffee-mode
  :ensure t)

(use-package web-mode
  :ensure t
  :mode ("\\.html?\\'" . web-mode))

(use-package magit
  :ensure t
  :bind ("C-c m" . magit-status))

(use-package jedi
  :ensure t
  :init (progn
          (add-hook 'python-mode-hook 'jedi:setup)
          (setq jedi:complete-on-dot t)))

(use-package nyan-mode
  :ensure t
  :init (progn
          (nyan-mode t)))

;; do some custom OS X stuff like:
;;; - initialize exec-path-from-shell
;;; - enable menu
(if (memq window-system '(mac ns))
    (progn
      (exec-path-from-shell-initialize)
      (menu-bar-mode t)))

;; modify window titlebar
(defun set-window-title ()
  "Set window title to either filename or buffer name."
  (if window-system
      (progn
        (setq frame-title-format '(:eval (if (buffer-file-name)
                                             (abbreviate-file-name (buffer-file-name))
                                           "%b"))))))

(add-hook 'window-setup-hook 'set-window-title)

;; trim trailing whitespace and delete blank lines on save
(add-hook 'before-save-hook 'delete-trailing-whitespace
          'delete-blank-lines)

;; shorten 'yes or no' to 'y or n'
(defalias 'yes-or-no-p 'y-or-n-p)

;; add site-lisp folder to load-path for all packages that are not on melpa
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;; initialize pymacs, if it's installed
(if (package-installed-p 'pymacs)
    (progn
     (autoload 'pymacs-apply "pymacs")
     (autoload 'pymacs-call "pymacs")
     (autoload 'pymacs-eval "pymacs" nil t)
     (autoload 'pymacs-exec "pymacs" nil t)
     (autoload 'pymacs-load "pymacs" nil t)
     (autoload 'pymacs-autoload "pymacs")
     ;;(eval-after-load "pymacs"
     ;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))

     ;; initialize ropemacs
     ;;(require 'pymacs)
     (pymacs-load "ropemacs" "rope-")))

(provide 'init)
;;; init.el ends here
