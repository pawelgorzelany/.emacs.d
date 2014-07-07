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
 '(cua-mode t nil (cua-base))
 '(custom-safe-themes (quote ("bb452baeed77ebb3dbd7d87df64fdc27cd9cbae868bcc25eee197df17298cfb2" default)))
 '(global-linum-mode t)
 '(inhibit-startup-screen t)
 '(linum-format "%4d ")
 '(make-backup-files nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(indent-tabs-mode nil)
 '(initial-scratch-message nil)
 '(make-backup-files nil))

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

(provide 'init)
;;; init.el ends here
