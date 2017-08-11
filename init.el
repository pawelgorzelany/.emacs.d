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
;; like for example cider
(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(package-initialize)

;; here is a list of all pinned packages that should be downloaded from melpa-stable
(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)

;; setup `use-package` package, install if not previously installed
(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))

(require 'use-package)

;; now setup all 3rd party packages and install them as necessary

;; themes - uncomment which ever suits the mood

;; (use-package monokai-theme
;;   :ensure t
;;   :config (progn
;;             (load-theme 'monokai t)))

(use-package moe-theme
  :ensure t
  :config (progn
            (load-theme 'moe-dark t)))

;; themes selection ends here.

(use-package rainbow-delimiters
  :ensure t
  :init (progn
          ;; set hooks for specific modes
          ;; for all programming modes
          (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)))
          ;; or for python only
          ;; (add-hook 'python-mode-hook 'rainbow-delimiters-mode)
          ;; or if shit gets fancy set rainbowish flavor all over the place
          ;; (global-rainbow-delimiters-mode)))

(use-package flycheck
  :ensure t
  :init (progn
          (add-hook 'after-init-hook #'global-flycheck-mode)))

(use-package company
  :ensure t
  :init (progn
          (add-hook 'after-init-hook 'global-company-mode)))

;; (use-package auto-complete
;;   :ensure t
;;   :init (progn
;;           (ac-config-default)))

(use-package elpy
  :ensure t
  :init (progn
          (elpy-enable)
          (setq elpy-rpc-backend "jedi")
          (setq elpy-modules
                '(elpy-module-company elpy-module-eldoc elpy-module-pyvenv elpy-module-yasnippet elpy-module-sane-defaults))))

(use-package yasnippet
  :ensure t
  :init (progn
          ;; make yasnippet globally available
          (yas-global-mode t)
          ;; but disable it in shell mode
          (add-hook 'shell-mode-hook #'(lambda ()
                                         (yas-minor-mode nil)))))

(use-package helm
  :ensure t
  :init (progn
          (setq default-directory "~/Projects/")
          (helm-mode t)
          (bind-key "C-c h" 'helm-mini)))

(use-package projectile
  :ensure t
  :init (progn
          (use-package helm-projectile
            :ensure t)
          (projectile-mode)
          (setq projectile-completion-system 'helm)
          (helm-projectile-on)))

(use-package slime
  :ensure t
  :commands slime
  :init (progn
            ;this works well for OS X and brew but on linux usually requires a symlink
            (setq inferior-lisp-program (executable-find "sbcl"))
            (setq slime-contribs '(slime-scratch slime-editing-commands))
            (setq slime-contribs '(slime-fancy))))

(use-package cider
  :ensure t)

(use-package haskell-mode
  :ensure t
  :init (progn
          (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)))

(use-package markdown-mode
  :ensure t
  :mode (("\\.markdown\\'" . markdown-mode) ("\\.md\\'" . markdown-mode)))

(use-package yaml-mode
  :ensure t)

(use-package json-mode
  :ensure t)

(use-package elm-mode
  :ensure t)

(defun setup-tide-mode ()
  "Setup tide for TypeScript hacking."
  (interactive)
  (tide-setup)
  (flycheck-mode t)
  (setq flycheck-check-syntax-automatically '(idle-change mode-enabled))
  (eldoc-mode t))
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  ;; (company-mode +1))

(use-package tide
  :ensure t
  :mode (("\\.tsx\\'" . web-mode) ("\\.jsx\\'" . web-mode))
  :init (progn
          (add-hook 'web-mode-hook
                    (lambda ()
                      (when (or
                             (string-equal "tsx" (file-name-extension buffer-file-name))
                             (string-equal "jsx" (file-name-extension buffer-file-name)))
                        (setup-tide-mode))))
          ;; aligns annotation to the right hand side
          ;; (setq company-tooltip-align-annotations t)

          ;; formats the buffer before saving
          (add-hook 'before-save-hook 'tide-format-before-save)
          (add-hook 'typescript-mode-hook #'setup-tide-mode)

          ;; format options
          (setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))
          (setq tide-tsserver-executable "node_modules/typescript/bin/tsserver")))


(use-package web-mode
  :ensure t
  :mode (("\\.html?\\'" . web-mode) ("\\.php\\'" . web-mode))
  :init (progn
          (setq web-mode-markup-indent-offset 2)))

(use-package magit
  :ensure t
  :bind ("C-c m" . magit-status))

;; (use-package jedi
;;   :ensure t
;;   :init (progn
;;           (add-hook 'python-mode-hook 'jedi:setup)
;;           (setq jedi:complete-on-dot t)))

(use-package virtualenvwrapper
  :ensure t
  :init (progn
          (setq venv-location "~/.virtualenvs/")))

(use-package twittering-mode
  :ensure t
  :init (progn
          (setq twittering-use-master-password t)
          (setq twittering-icon-mode t)
          (setq twittering-use-icon-storage t)))

(use-package nyan-mode
  :ensure t
  :init (progn
          (nyan-mode t)))

;; do some custom OS X stuff like:
;;; - initialize exec-path-from-shell
;;; - enable menu
;;; - set keyboard keys to be able to enter polish characters (disabling right option as meta)
(if (memq window-system '(mac ns))
    (progn
      (use-package exec-path-from-shell
        :ensure t
        :init (progn
                (exec-path-from-shell-initialize)))
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

(add-hook 'window-setup-hook 'set-window-title)

;; trim trailing whitespace and delete blank lines on save
(add-hook 'before-save-hook 'delete-trailing-whitespace
          'delete-blank-lines)

;; shorten 'yes or no' to 'y or n'
(defalias 'yes-or-no-p 'y-or-n-p)

;; add site-lisp folder to load-path for all packages that are not on melpa
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

(provide 'init)
;;; init.el ends here
