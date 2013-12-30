(setq load-path (append load-path (list "~/elisp")))
(setq inhibit-startup-message t)
(setq default-tab-width 4)
(setq column-number-mode t)
(menu-bar-mode)
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(font-lock-builtin-face ((((class color) (min-colors 8)) (:foreground "blue"))))
 '(font-lock-comment-delimiter-face ((default (:inherit font-lock-comment-face)) (((class color) (min-colors 8) (background light)) nil)))
 '(font-lock-comment-face ((((class color) (min-colors 8) (background light)) (:foreground "black"))))
 '(font-lock-constant-face ((((class color) (min-colors 8)) nil)))
 '(font-lock-function-name-face ((((class color) (min-colors 8)) (:foreground "blue"))))
 '(font-lock-keyword-face ((((class color) (min-colors 8)) (:foreground "black"))))
 '(font-lock-preprocessor-face ((t nil)))
 '(font-lock-string-face ((((class color) (min-colors 8)) (:foreground "green"))))
 '(font-lock-type-face ((((class color) (min-colors 8)) nil)))
 '(font-lock-variable-name-face ((((class color) (min-colors 8)) nil)))
 '(font-lock-warning-face ((((class color) (min-colors 8)) (:foreground "black"))))
 '(link ((((class color) (background light)) (:foreground "cyan" :underline t))))
 '(minibuffer-prompt ((t nil))))

(put 'narrow-to-region 'disabled nil)
(autoload 'tt-mode "tt-mode")
(setq-default indent-tabs-mode nil)

(autoload 'apache-mode "apache-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))




(defun sort-words (reverse beg end)
  "Sort words in region alphabetically, in REVERSE if negative.
    Prefixed with negative \\[universal-argument], sorts in reverse.
    The variable `sort-fold-case' determines whether alphabetic case
    affects the sort order.
    See `sort-regexp-fields'."
      (interactive "*P\nr")
      (sort-regexp-fields reverse "\\w+" "\\&" beg end))



(defalias 'perl-mode 'cperl-mode)

(setq split-width-threshold nil)   ;; prevent windows from splitting horizontally

(setq auto-mode-alist 
	  (cons '("\\.pl$" . perl-mode) auto-mode-alist))
(setq auto-mode-alist 
	  (cons '("\\.cgi$" . perl-mode) auto-mode-alist))
(setq auto-mode-alist 
	  (cons '("\\.tt$" . tt-mode) auto-mode-alist))
(setq auto-mode-alist 
	  (cons '("\\.html$" . html-mode) auto-mode-alist))
(setq explicit-shell-file-name "/bin/bash")
(setq explicit-bash-args '("--login" "--noediting"))

(put 'upcase-region 'disabled nil)
(global-set-key "\C-\\" 'advertised-undo)
(global-set-key "\C-x*" 'comment-region)
(global-set-key "\C-xw" 'compare-windows)
(setq-default compare-ignore-whitespace t)

(global-font-lock-mode nil)

(add-hook 'cperl-mode-hook 'n-cperl-mode-hook t)
(defun n-cperl-mode-hook ()
  (setq cperl-indent-level 4)
  (setq cperl-continued-statement-offset 0)
  (setq cperl-extra-newline-before-brace t)
  (set-face-background 'cperl-array-face "wheat")
  (set-face-background 'cperl-hash-face "wheat")
  )

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )



;; Set default TAGS to $ALEX_SITE_DIR/TAGS
(let ((default-directory (getenv "ALEX_SITE_DIR")))
    (if default-directory
        (setq tags-table-list (list (expand-file-name "TAGS")))))

