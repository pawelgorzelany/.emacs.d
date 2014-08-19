;;; init.el --- Initialization file for emacs.
;;; Commentary:

;;; Code:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(custom-safe-themes (quote ("e0805a9707a21efb80eb26a9487b1f16ef0bef06d851c0b0c87bf3427a2dbd93" "bb452baeed77ebb3dbd7d87df64fdc27cd9cbae868bcc25eee197df17298cfb2" default)))
 '(global-linum-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(linum-format "%4d ")
 '(make-backup-files nil)
 '(auto-save-default nil)
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(menu-bar-mode nil)
 '(tooltip-mode nil))

(put 'dired-find-alternate-file 'disabled nil)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; use a custom color theme
(load-theme 'neon)

;; initialize MELPA
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; initialize exec-path-from-shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; modify window title
(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b"))))

;; initialize auto-complete
(require 'auto-complete-config)
(ac-config-default)

;; initialize slime
(require 'slime-autoloads)
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(setq slime-contribs '(slime-fancy))

;; initialize flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; trim trailing whitespace and delete blank lines on save
(add-hook 'before-save-hook 'delete-trailing-whitespace
      'delete-blank-lines)

;; shorten 'yes or no' to 'y or n'
(defalias 'yes-or-no-p 'y-or-n-p)

;; add site-lisp folder to load-path
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;; initialize markdown-mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; initialize pymacs
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
(pymacs-load "ropemacs" "rope-")

(provide 'init)
;;; init.el ends here
