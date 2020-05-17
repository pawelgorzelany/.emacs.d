;;; init.el --- Initialization file for Emacs. -*- lexical-binding: t -*-
;;; Commentary:
;;; This is my Emacs setup.
;;; author: @pawelgorzelany

;;; Code:

(setq lexical-binding t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(create-lockfiles nil)
 '(display-battery-mode t)
 '(doom-themes-enable-bold t)
 '(doom-themes-enable-italic t)
 '(doom-themes-neotree-file-icons t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(make-backup-files nil)
 '(neo-smart-open t)
 '(neo-window-width 60)
 '(org t)
 '(org-log-done t)
 '(package-selected-packages
   (quote
    (doom-themes neotree hide-mode-line all-the-icons-dired all-the-icons diminish forge restclient dockerfile-mode centaur-tabs doom-modeline dante yasnippet-snippets yaml-mode web-mode virtualenvwrapper use-package twittering-mode slime rainbow-delimiters php-mode nyan-mode moe-theme markdown-mode magit lua-mode json-mode intero helm-projectile go-mode find-file-in-project exec-path-from-shell elpy elm-mode edts column-enforce-mode cider)))
 '(projectile-switch-project-action (quote neotree-projectile-action))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(visible-bell t))

(put 'dired-find-alternate-file 'disabled nil)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

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

;; install everything that uses use-package for setup
(setq use-package-always-ensure t)

;; visuals: fonts, icons etc

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(ignore-errors (set-frame-font "Iosevka Term Thin 12"))

(use-package all-the-icons)
;; first time it's installed on a new machine it requires installing the fonts
;; https://github.com/domtronn/all-the-icons.el#installing-fonts

(use-package all-the-icons-dired
  :after all-the-icons
  :hook (dired-mode . all-the-icons-dired-mode))

;; (use-package moe-theme
;;   :config (load-theme 'moe-dark t))

(use-package hide-mode-line
  :hook (neotree-mode . hide-mode-line-mode))

(use-package neotree
  :diminish
  :bind ("s-\\" . neotree-toggle)
  :custom
  (neo-smart-open t)
  (neo-window-width 60)
  (projectile-switch-project-action 'neotree-projectile-action))

;; trying out some more fancy theme
(use-package doom-themes
  :custom
  (doom-themes-neotree-file-icons t)
  (doom-themes-enable-bold t)    ; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  :config
  ;; Global settings (defaults)
  (load-theme 'doom-one t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package doom-modeline
  :config (doom-modeline-mode))

(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  :custom
  (centaur-tabs-set-bar 'left)
  (centaur-tabs-set-icons t)
  (centaur-tabs-set-modified-marker t)
  (centaur-tabs-modified-marker "●")
  (centaur-tabs-cycle-scope 'tabs)
  (centaur-tabs-group-by-projectile-project)
  :bind
  ("s-[" . centaur-tabs-backward)
  ("s-]" . centaur-tabs-forward))

(use-package nyan-mode
  :init (nyan-mode t))

;; 3rd party packages

(use-package diminish)

(use-package exec-path-from-shell
  :config (exec-path-from-shell-initialize))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package column-enforce-mode
  :diminish
  :init (global-column-enforce-mode t))

(use-package flycheck
  :config (global-flycheck-mode))

(use-package helm
  :diminish
  :bind ("C-c h" . helm-mini)
  :init (helm-mode t)
  :config (setq default-directory "~/Projects/"))

(use-package projectile
  :diminish
  :after helm
  :bind-keymap ("C-c p" . projectile-command-map)
  :init (projectile-mode t)
  :config
  (setq projectile-completion-system 'helm)
  (setq projectile-indexing-method 'alien))

(use-package helm-projectile
  :after (helm projectile)
  :init (helm-projectile-on))

(use-package company
  :diminish
  :hook (prog-mode . company-mode))

(use-package elpy
  :init (elpy-enable)
  :config
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (setq elpy-modules (delq 'elpy-module-highlight-indentation elpy-modules)))

(use-package virtualenvwrapper
  :config (setq venv-location "~/.virtualenvs/"))

(use-package yasnippet-snippets)

(use-package yasnippet
  :after yasnippet-snippets
  :hook (prog-mode . yas-minor-mode)
  :init (yas-reload-all))

(use-package haskell-mode
  :hook (haskell-mode . turn-on-haskell-indent))

(use-package dante
  :after haskell-mode
  :commands 'dante-mode
  :init
  (add-hook 'haskell-mode-hook 'flycheck-mode)
  (add-hook 'haskell-mode-hook 'dante-mode)
  )

(use-package markdown-mode
  :mode (("\\.markdown$" . markdown-mode) ("\\.md$" . markdown-mode)))

(use-package yaml-mode)

(use-package json-mode)

(use-package dockerfile-mode)

(use-package elm-mode)

(use-package web-mode
  :mode (("\\.html?$" . web-mode) ("\\.php$" . web-mode))
  :config (setq web-mode-markup-indent-offset 2))

(use-package magit
  :bind ("C-c m" . #'magit-status))

(use-package forge
  :after magit)

(use-package restclient
  :mode ("\\.restclient$" . restclient-mode))

;; do some custom OS X stuff like:
;;; - enable menu
;;; - set keyboard keys to be able to enter polish characters (disabling right option as meta)
(if (memq window-system '(mac ns))
    (progn
      (menu-bar-mode t)
      (setq mac-option-key-is-meta t)
      (setq mac-right-option-modifier nil)))

;; modify window titlebar
(defun set-window-title ()
  "Set window title to either filename or buffer name."
  (if window-system
      (setq frame-title-format '(:eval (if (buffer-file-name)
                                           (abbreviate-file-name (buffer-file-name))
                                         "%b")))))

(add-hook 'window-setup-hook #'set-window-title)

;; trim trailing whitespace and delete blank lines on save
(add-hook 'before-save-hook #'delete-trailing-whitespace
          #'delete-blank-lines)

;; shorten 'yes or no' to 'y or n'
(defalias 'yes-or-no-p 'y-or-n-p)

(provide 'init)
;;; init.el ends here
