;;; init.el --- Initialization file for Emacs.
;;; Commentary:
;;; This is my Emacs setup.
;;; author: @pawelgorzelany

;;; Code:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(org t)
 '(org-log-done t)
 '(package-selected-packages
   (quote
    (projectile helm company flycheck yasnippet-snippets intero yaml-mode web-mode virtualenvwrapper use-package twittering-mode tide slime rainbow-delimiters nyan-mode moe-theme markdown-mode magit literate-coffee-mode json-mode jedi helm-projectile haskell-mode exec-path-from-shell elpy elm-mode column-enforce-mode cider)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(visible-bell t))

(put 'dired-find-alternate-file 'disabled nil)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; initialize MELPA
;; by default install all packages from melpa but add also melpa-stable for pinned packages
;; like for example cider and slime
(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(package-initialize)

;; setup `use-package` package, install if not previously installed
(unless (package-installed-p 'use-package)
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))

(eval-when-compile
  (require 'use-package))

;; now setup all 3rd party packages and install them as necessary

(use-package moe-theme
  :ensure t
  :config (load-theme 'moe-dark t))

(use-package column-enforce-mode
  :ensure t
  :init (global-column-enforce-mode t))

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package flycheck
  :ensure t
  :hook (after-init . global-flycheck-mode))

(use-package company
  :ensure t
  :hook (after-init . global-company-mode))

(use-package elpy
  :ensure t
  :init (elpy-enable)
  :config (setq elpy-modules '(elpy-module-company
                               elpy-module-eldoc
                               elpy-module-pyvenv
                               elpy-module-yasnippet
                               elpy-module-sane-defaults)))

(use-package yasnippet-snippets
  :ensure t)

(use-package yasnippet
  :after yasnippet-snippets
  :ensure t
  :hook (prog-mode . yas-minor-mode)
  :init (yas-reload-all))

(use-package helm
  :ensure t
  :bind ("C-c h" . helm-mini)
  :init (helm-mode t)
  :config (setq default-directory "~/Projects/"))

(use-package projectile
  :ensure t
  :after helm
  :bind-keymap ("C-c p" . projectile-command-map)
  :init (projectile-mode t)
  :config (setq projectile-completion-system 'helm))

(use-package helm-projectile
  :ensure t
  :after (helm projectile)
  :init (helm-projectile-on))

(use-package slime
  :pin melpa-stable
  :ensure t
  :commands slime
  :init
  (setq inferior-lisp-program (executable-find "sbcl"))
  (setq slime-contribs '(slime-fancy)))

(use-package cider
  :pin melpa-stable
  :ensure t)

(use-package haskell-mode
  :ensure t
  :hook (haskell-mode . turn-on-haskell-indent))

(use-package intero
  :ensure t
  :hook (haskell-mode . intero-mode))

(use-package markdown-mode
  :ensure t
  :mode (("\\.markdown\\'" . markdown-mode) ("\\.md\\'" . markdown-mode)))

(use-package yaml-mode
  :ensure t)

(use-package json-mode
  :ensure t)

(use-package elm-mode
  :ensure t)

(use-package web-mode
  :ensure t
  :mode (("\\.html?\\'" . web-mode) ("\\.php\\'" . web-mode))
  :config (setq web-mode-markup-indent-offset 2))

(use-package magit
  :ensure t
  :bind ("C-c m" . magit-status))

(use-package virtualenvwrapper
  :ensure t
  :config (setq venv-location "~/.virtualenvs/"))

(use-package twittering-mode
  :ensure t
  :config
  (setq twittering-use-master-password t)
  (setq twittering-icon-mode t)
  (setq twittering-use-icon-storage t))

(use-package nyan-mode
  :ensure t
  :init (nyan-mode t))

;; do some custom OS X stuff like:
;;; - initialize exec-path-from-shell
;;; - enable menu
;;; - set keyboard keys to be able to enter polish characters (disabling right option as meta)
(if (memq window-system '(mac ns))
    (progn
      (use-package exec-path-from-shell
        :ensure t
        :config (exec-path-from-shell-initialize))
      (menu-bar-mode t)
      (setq mac-option-key-is-meta t)
      (setq mac-right-option-modifier nil)))

;; modify window titlebar
(defun set-window-title ()
  "Set window title to either filename or buffer name."
  (if window-system
      (progn
        (setq frame-title-format '(:eval (if (buffer-file-name)
                                             (abbreviate-file-name (buffer-file-name))
                                           "%b"))))))

(add-hook 'window-setup-hook #'set-window-title)

;; trim trailing whitespace and delete blank lines on save
(add-hook 'before-save-hook #'delete-trailing-whitespace
          #'delete-blank-lines)

;; shorten 'yes or no' to 'y or n'
(defalias 'yes-or-no-p 'y-or-n-p)

;; add site-lisp folder to load-path for all packages that are not on melpa
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

(provide 'init)
;;; init.el ends here
