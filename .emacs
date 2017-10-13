(add-to-list 'default-frame-alist '(tty-color-mode  . -1))     ; b&w terminal mode
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(require 'package)
(add-to-list 'package-archives
                          '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

; (toggle-truncate-lines)


(setq-default vc-make-backup-files   t)
(setq-default backup-directory-alist `(("." . "/Users/dansmith/.saves")))

(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

; "~/elisp/themes"

(setq load-path (append load-path (list "~/elisp" ) ))
(setq inhibit-startup-message t)
(setq default-tab-width 2)
(setq column-number-mode t)
(menu-bar-mode)

;(load-theme 'inkpot t)
(set-face-foreground 'minibuffer-prompt "white")

;; (require 'color-theme)
;; (eval-after-load "color-theme"
;;    '(progn
;;       (color-theme-initialize)
;; ;      (color-theme-clarity)
;; ;      (color-theme-ld-dark)
;;       (color-theme-dark-laptop)
;; ;      (color-theme-hober)
;; ;      (color-theme-midnight)
;;       (set-face-foreground 'minibuffer-prompt "white")
;; ))




(put 'narrow-to-region 'disabled nil)
(autoload 'tt-mode "tt-mode")
; (autoload 'color-theme-solarized-light "color-theme-solarized-light")
; (autoload 'color-theme-solarized-dark "color-theme-solarized-dark")

(setq-default indent-tabs-mode nil)
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t) (setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

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

(global-set-key "\M-\C-d" 'whack-whitespace)
(global-set-key "\C-xg" 'goto-line)

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
(global-set-key "\C-xc" 'compare-windows)
(setq-default compare-ignore-whitespace t)

(global-font-lock-mode t)

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
 '(custom-safe-themes
   (quote
    ("1bd383f15ee7345c270b82c5e41554754b2a56e14c2ddaa2127c3590d0303b95" "03ea866815fe82c4736611acafef3c90519d15cd3d465d8f146ebfa3a293b663" "8659c305d48242dc8558a015fcd475584b53be2ec5fdb469ed12d46bac16c11a" "0777cfc5345e1018a8a20506e791fb49f22b3999270456952a6675b0e05fc9e1" "588a126bb2602528f1b61ca533e86baa6c2985225cccfa6caf63efa54d95a544" "d7ad8092aa1b790f780e2e216610a5fd76960ea586b2ded178d3290030754e89" "52974e923c79ee2e5de05b5f60950f20b25ed0a1929df7f402f59dd6db7d511f" "52c3d86abcc95f3a7a3566c15834b09caee2bb3093cf9d53d9eab61f925326c6" "58c7e88517136072f383afef93fe1eeb9c12de37398c4f95c27f363a2cc41fcd" "7dad2be7d806486305d7d3afe6b53a0c882cf651e183ed1ffe6dfb0745dc80f6" default)))
 '(package-selected-packages (quote (rebecca-theme darcula-theme atom-one-dark-theme))))

(put 'downcase-region 'disabled nil)

(defun commit-notes() 
  (interactive)
  (cond ((getenv "p") (find-file (concat (getenv "p") "/commit-notes")))
        (t                      (message "No project set"))))


;; Set default TAGS to $ALEX_SITE_DIR/TAGS
(let ((default-directory (getenv "ALEX_SITE_DIR")))
    (if default-directory
        (setq tags-table-list (list (expand-file-name "TAGS")))))


(put 'scroll-left 'disabled nil)



(defun recenter-top-bottom (&optional arg)
  "Move current line to window center, top, and bottom, successively.
With a prefix argument, this is the same as `recenter':
 With numeric prefix ARG, move current line to window-line ARG.
 With plain `C-u', move current line to window center.

Otherwise move current line to window center on first call, and to
top, middle, or bottom on successive calls.

The starting position of the window determines the cycling order:
 If initially in the top or middle third: top -> middle -> bottom.
 If initially in the bottom third: bottom -> middle -> top.

Top and bottom destinations are actually `scroll-conservatively' lines
from true window top and bottom."
  (interactive "P")
  (if arg                               ; Always respect ARG.
      (recenter arg)
    (case last-command
      (recenter-tb-top                  ; Top -> middle -> bottom
       (setq this-command  'recenter-tb-middle)
       (recenter))
      (recenter-tb-middle
       (setq this-command  'recenter-tb-bottom)
       (recenter (1- (- scroll-conservatively))))
      (recenter-tb-bottom
       (setq this-command  'recenter-tb-top)
       (Recenter scroll-conservatively))
      (recenter-tb-bottom-1             ; Bottom -> middle -> top
       (setq this-command  'recenter-tb-middle-1)
       (recenter))
      (recenter-tb-middle-1
       (setq this-command  'recenter-tb-top-1)
       (recenter scroll-conservatively))
      (recenter-tb-top-1
       (setq this-command  'recenter-tb-bottom-1)
       (recenter (1- (- scroll-conservatively))))
      (otherwise                        ; First time - save mode and recenter.
       (let ((top      (1+ (count-lines 1 (window-start))))
             (current  (1+ (count-lines 1 (point))))
             (total    (window-height)))
         (setq this-command  (if (< (- current top) (/ total 3))
                                 'recenter-tb-middle
                               'recenter-tb-middle-1)))
       (recenter)))))

 (substitute-key-definition       'recenter 'recenter-top-bottom global-map)



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'set-goal-column 'disabled nil)
