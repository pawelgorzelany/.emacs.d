;; based on color-theme-phil-neon.el

(deftheme neon
 "neon-theme")

(custom-theme-set-faces
 'neon

 '(default ((t (:background "#000000" :foreground "#f8f8f2"))))
 '(mouse ((t (:foreground "black"))))
 '(cursor ((t (:foreground "green"))))
 '(border ((t (:foreground "white"))))

 '(bold ((t (:bold t :foreground "#ffffff"))))
 '(bold-italic ((t (:italic t :bold t))))
 '(calendar-today-face ((t (:underline t))))
 '(diary-face ((t (:foreground "red"))))

 ;; Mode line faces
 '(mode-line ((t (:background "#444444" :foreground "#857b6f"))))
 '(mode-line-inactive ((t (:background "#444444" :foreground "#857b6f"))))

 ;; Font lock faces
 '(font-lock-builtin-face ((t (:bold t :foreground "#66d9ef"))))
 '(font-lock-comment-face ((t (:foreground "#8e8e8e"))))
 '(font-lock-constant-face ((t (:foreground "#f8f8f2"))))
 '(font-lock-function-name-face ((t (:foreground "#a4e402"))))
 '(font-lock-keyword-face ((t (:foreground "#f92672"))))
 '(font-lock-string-face ((t (:foreground "#e6dc6d"))))
 '(font-lock-type-face ((t (:foreground "#66d9ef"))))
 '(font-lock-variable-name-face ((t (:foreground "#fd971f"))))
 '(font-lock-warning-face ((t (:bold t :foreground "gold"))))
 '(highlight ((t (:background "darkslategrey" :foreground "wheat"))))
 '(holiday-face ((t (:background "pink"))))
 '(info-menu-5 ((t (:underline t))))
 '(info-node ((t (:italic t :bold t))))
 '(info-xref ((t (:bold t))))
 '(italic ((t (:italic t :background "gray"))))
 '(message-cited-text-face ((t (:foreground "red"))))
 '(message-header-cc-face ((t (:bold t :foreground "green4"))))
 '(message-header-name-face ((t (:foreground "DarkGreen"))))
 '(message-header-newsgroups-face ((t (:italic t :bold t :foreground "yellow"))))
 '(message-header-other-face ((t (:foreground "#b00000"))))
 '(message-header-subject-face ((t (:foreground "green3"))))
 '(message-header-to-face ((t (:bold t :foreground "green2"))))
 '(message-header-xheader-face ((t (:foreground "blue"))))
 '(message-mml-face ((t (:foreground "ForestGreen"))))
 '(message-separator-face ((t (:foreground "blue3"))))
 '(region ((t (:background "grey"))))
 '(secondary-selection ((t (:background "darkslateblue"))))
 '(show-paren-match-face ((t (:background "turquoise"))))
 '(show-paren-mismatch-face ((t (:background "purple" :foreground "white"))))
 '(underline ((t (:underline t)))))

;; auto load
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'neon)

;; neon theme ends here
