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
(autoload 'ruby-mode "ruby-mode")
(autoload 'haml-mode "haml-mode")
(setq-default indent-tabs-mode nil)
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t) (setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

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

(defun whack-whitespace (arg)
      "Delete all white space from point to the next word.  With prefix ARG
    delete across newlines as well.  The only danger in this is that you
    don't have to actually be at the end of a word to make it work.  It
    skips over to the next whitespace and then whacks it all to the next
    word."
      (interactive "P")
      (let ((regexp (if arg "[ \t\n]+" "[ \t]+")))
        (re-search-forward regexp nil t)
        (replace-match "" nil nil)))

(global-set-key "\M-\C-d" 'whack-whitespace)

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
(setq auto-mode-alist 
	  (cons '("\\.rb$" .   ruby-mode) auto-mode-alist))
(setq auto-mode-alist 
	  (cons '("\\.haml$" . haml-mode) auto-mode-alist))

(setq explicit-shell-file-name "/bin/bash")
(setq explicit-bash-args '("--login" "--noediting"))

(put 'upcase-region 'disabled nil)
(global-set-key "\C-\\" 'advertised-undo)
(global-set-key "\M-o"  'occur)
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

(put 'downcase-region 'disabled nil)

 (defun writeroom ()
  "Switches to a WriteRoom-like fullscreen style"
  (interactive)	
  (when (featurep 'aquamacs)
    ;; switch to white on black
    (color-theme-initialize)
    (color-theme-clarity)
    ;; switch to Garamond 36pt
    (aquamacs-autoface-mode 0)
    (set-frame-font "-apple-garamond-medium-r-normal--36-360-72-72-m-360-iso10646-1")
    ;; switch to fullscreen mode
    (aquamacs-toggle-full-frame)))
    
(when (featurep 'aquamacs)
  (setq initial-frame-alist '((background-color . "green") (left . 50)  )))


;; Set default TAGS to $ALEX_SITE_DIR/TAGS
(let ((default-directory (getenv "ALEX_SITE_DIR")))
    (if default-directory
        (setq tags-table-list (list (expand-file-name "TAGS")))))

