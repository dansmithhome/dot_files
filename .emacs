;; (add-to-list 'default-frame-alist '(tty-color-mode  . -1))     ; b&w terminal mode

(if (boundp 'custom-theme-load-path)
    (add-to-list 'custom-theme-load-path "~/.emacs.d/themes") 
  nil)

(require 'package)
(add-to-list 'package-archives
                          '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

; (toggle-truncate-lines)


(setq-default vc-make-backup-files   t)
(setq-default backup-directory-alist `(("." . "~/.emacs-saves")))

(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

(setq load-path (append load-path (list "~/elisp" ) ))
(setq inhibit-startup-message t)
(setq default-tab-width 2)
(setq column-number-mode t)
(menu-bar-mode)




(set-face-foreground 'minibuffer-prompt "white")

(require 'color-theme)
 (eval-after-load "color-theme"
    '(progn
      (color-theme-initialize)
       (color-theme-dark-laptop)
   ;      (color-theme-clarity)
;; ;      (color-theme-ld-dark)
;; ;      (color-theme-hober)
;; ;      (color-theme-midnight)
))


(autoload 'tt-mode "tt-mode")
;; (autoload 'color-theme-solarized-light "color-theme-solarized-light")
;; (autoload 'color-theme-solarized-dark "color-theme-solarized-dark")

(setq-default indent-tabs-mode nil)
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

(autoload 'apache-mode "apache-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))

(defun no-dos-please-were-unixish ()
  (let ((coding-str (symbol-name buffer-file-coding-system)))
    (when (string-match "-dos$" coding-str)
      (setq coding-str
            (concat (substring coding-str 0 (match-beginning 0)) "-unix"))
      (message "CODING: %s" coding-str)
      (set-buffer-file-coding-system (intern coding-str)) )))

(add-hook 'find-file-hooks 'no-dos-please-were-unixish)



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


(defalias 'perl-mode 'cperl-mode)


;; (setq explicit-shell-file-name "/bin/bash")
;; (setq explicit-bash-args '("--login" "--noediting"))

(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("\\.pl$" . perl-mode))
(add-to-list 'auto-mode-alist '("\\.cgi$" . perl-mode))
(add-to-list 'auto-mode-alist '("\\.tt$" . tt-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.rb$" .   ruby-mode))
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))

(global-set-key "\C-\\" 'advertised-undo)
(global-set-key "\M-o"  'occur)
(global-set-key "\C-x*" 'comment-region)
(global-set-key "\C-xc" 'compare-windows)
(global-set-key "\M-\C-d" 'whack-whitespace)
(global-set-key "\C-xg" 'goto-line)



(setq-default compare-ignore-whitespace t)
(setq split-width-threshold nil)   ;; prevent windows from splitting horizontally

(global-font-lock-mode t)

(add-hook 'cperl-mode-hook 'n-cperl-mode-hook t)
(defun n-cperl-mode-hook ()
  (setq cperl-indent-level 4)
  (setq cperl-continued-statement-offset 0)
  (setq cperl-extra-newline-before-brace t)
  (set-face-background 'cperl-array-face "wheat")
  (set-face-background 'cperl-hash-face "wheat")
  )

;; Set default TAGS to $ALEX_SITE_DIR/TAGS
(let ((default-directory (getenv "ALEX_SITE_DIR")))
    (if default-directory
        (setq tags-table-list (list (expand-file-name "TAGS")))))


(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
