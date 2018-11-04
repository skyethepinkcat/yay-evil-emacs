(add-hook 'prog-mode-hook 'company-mode)
(setq company-global-modes '(not eshell-mode))
(setq company-idle-delay t)
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

(global-set-key (kbd "C-;") 'avy-goto-word-1)
(setq avy-keys '(?a ?b ?c ?y ?e ?w ?g ?h ?i ?j ?x ?m ?n ?o ?p ?q ?r ?s ?t ?u ?v ?f ?k ?d ?l))

(global-set-key (kbd "C-c d") 'diff)
(global-set-key (kbd "C-c e") 'ediff)
(global-set-key (kbd "C-c D") 'diff-buffer-with-file)
(global-set-key (kbd "C-c E") 'ediff-current-file)
(eval-after-load 'diff-mode
  '(progn
     (set-face-foreground 'diff-added "#355531")
     (set-face-background 'diff-added "#dcffdd")
     (set-face-foreground 'diff-removed "#553333")
     (set-face-background 'diff-removed "#ffdddc")))

(put 'dired-find-alternate-file 'disabled nil)
(add-hook 'dired-mode-hook (lambda () (define-key dired-mode-map (kbd "RET")
                                        'dired-find-alternate-file)))

(global-set-key (kbd "C-x D") 'ido-dired) ;; The actual dired-mode
(global-set-key (kbd "C-x d") 'dired-sidebar-toggle-sidebar)

(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-q") 'nil)
(global-set-key (kbd "M-s") 'nil)
(global-set-key (kbd "M-r") 'nil)
(global-set-key (kbd "C-x F") 'replace-string)
(global-set-key (kbd "s-c") 'kill-ring-save)

(require 'emmet-mode)
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(add-hook 'js-mode-hook 'emmet-mode)
(add-hook 'js-jsx-mode-hook 'emmet-mode)

;;  (global-set-key (kbd "<M-return>") 'eshell)
  (require 'esh-autosuggest)  ;; Fish-like autosuggestion
  (add-hook 'eshell-mode-hook #'esh-autosuggest-mode)
  (eshell-git-prompt-use-theme 'powerline)

  ;; The 'clear' command
  (defun eshell/clear ()
    "Clear the eshell buffer to the top."
    (interactive)
    (let ((inhibit-read-only t))
      (erase-buffer)))
  (global-set-key (kbd "C-8") 'eshell-previous-input)
  (global-set-key (kbd "C-9") 'eshell-next-input)

  ;; To let eshell use brew-installed commands
  (setenv "PATH" (concat "/usr/local/bin/" ":" (getenv "PATH")))
  (setq exec-path (append '("/usr/local/bin/") exec-path))
  ;; Eshell aliases
  (defalias 'ff 'find-file)

(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)

(add-hook 'after-init-hook 'global-flycheck-mode)

;; Spell checker software Aspell (to replace ispell)
(setq ispell-program-name "/usr/local/bin/aspell")

(require 'hungry-delete)
(global-hungry-delete-mode)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(require 'ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
(require 'flx-ido)
(flx-ido-mode 1)
(setq ido-enable-flex-matching t)

(setq-default tab-width 2)
(defvaralias 'c-basic-offset 'tab-width)
;; (defvaralias 'cperl-indent-level 'tab-width)
(setq-default indent-tabs-mode nil) ;; Always use spaces
(setq js-indent-level 2)
(setq c-default-style '((java-mode . "java") (other . "gnu")))
(defun newline-and-push-brace () "`newline-and-indent', but bracket aware."
       (interactive)
       (insert "\n")
       (when (looking-at "}")
         (insert "\n")
         (indent-according-to-mode)
         (forward-line -1))
       (indent-according-to-mode)

       (when (looking-at ")")
         (insert "\n")
         (indent-according-to-mode)
         (forward-line -1))
       (indent-according-to-mode)

       (when (looking-at "]")
         (insert "\n")
         (indent-according-to-mode)
         (forward-line -1))
       (indent-according-to-mode))
(global-set-key (kbd "RET") 'newline-and-push-brace)
(require 'auto-indent-mode)

;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js-jsx-mode))
;; (add-hook 'js2-mode-hook #'js2-imenu-extras-mode)
(require 'prettier-js)
(setq prettier-js-args '("--bracket-spacing" "true"
                         "--jsx-bracket-same-line" "true"))

;; In order for 'pdflatex' to work. Also had to export PATH from .zshrc
(setenv "PATH" (concat "/usr/texbin:/Library/TeX/texbin:" (getenv "PATH")))
(setq exec-path (append '("/usr/texbin" "/Library/TeX/texbin") exec-path))

;; Colourful Org LaTeX Code Blocks
(require 'ox-latex)
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)
(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
(setq org-latex-minted-options '(("linenos=true")))

(require 'nlinum-relative)
;; (add-hook 'prog-mode-hook 'nlinum-relative-mode)
(setq nlinum-relative-redisplay-delay 0)
(setq nlinum-relative-current-symbol "")  ;; empty to display current number
(setq nlinum-relative-offset 0)

(global-set-key (kbd "C-x g") 'magit-status)

(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(drag-stuff-global-mode 1)
(drag-stuff-define-keys)  ;; Use Meta-up/down/left/right

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(define-key mc/keymap (kbd "<return>") nil)

(add-to-list 'load-path "/.emacs.d/elpa/neotree/")
(require 'neotree)
(global-set-key (kbd "C-x j") 'neotree-toggle)

(setq neo-theme 'icons)

(require 'ox-md)
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(global-set-key (kbd "C-c a") 'org-agenda)  ;; Use C-c a to active agenda
(setq org-todo-keywords
      '((sequence "TODO" "DOING" "DONE")))
(setq org-todo-keyword-faces
      '(
        ("TODO" . (:background "#FFCDCD" :foreground "#801111" :box t))
        ("DOING" . (:background "#FDF381" :foreground "#4D3100" :box t))
        ("DONE" . (:background "#E0FDD5" :foreground "#1A4D00" :box t))))
(global-set-key (kbd "C-c w") 'writeroom-mode) ;; Toggle writeroom

(elpy-enable)
(setq elpy-rpc-python-command "/usr/local/bin/python3")
(setq python-shell-interpreter "/usr/local/bin/python3")
(add-hook 'elpy-mode-hook (lambda () (highlight-indentation-mode -1)))
(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))  ;; company-jedi
(add-hook 'python-mode-hook 'my/python-mode-hook)

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'rainbow-mode)

(set-register ?e '(file . "~/.emacs.d/init.el"))
(set-register ?o '(file . "~/.emacs.d/config.org"))
(set-register ?c '(file . "~/.emacs.d/custom.el"))
(set-register ?r '(file . "~/.emacs.d/themes/tronlegacy-theme.el"))
(set-register ?t '(file . "~/todo.org"))

(fset 'join-lines
      (lambda (&optional arg) "Join lines the Vim style"
        (interactive "p") (kmacro-exec-ring-item '(" " 0 "%d") arg)))
(global-set-key (kbd "C-x C-k J") 'join-lines)

(fset 'make-word-italics
   (lambda (&optional arg) "Keyboard macro."
     (interactive "p") (kmacro-exec-ring-item '([47 escape 102 47] 0 "%d") arg)))
(global-set-key (kbd "C-x C-k I") 'make-word-italics)

(smartparens-global-mode 1)
(setq show-paren-delay 0)
(show-paren-mode 1)

(require 'smex)
(global-set-key (kbd "M-x") 'smex)

(require 'smooth-scrolling)
(smooth-scrolling-mode 1)
(setq scroll-margin 2
      smooth-scroll-margin 2
      scroll-conservatively 0
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01)
(setq-default scroll-up-aggressively 0.01
              scroll-down-aggressively 0.01)

(server-start)

(setq inhibit-splash-screen t)
(sml-modeline-mode t)
(display-battery-mode 1)
(column-number-mode t)
(minions-mode 1)
;; (beacon-mode t)

(add-hook 'prog-mode-hook 'highlight-numbers-mode)
(add-hook 'prog-mode-hook 'hl-line-mode)
(add-hook 'prog-mode-hook 'highlight-operators-mode)
(add-hook 'prog-mode-hook 'hes-mode)
(add-hook 'prog-mode-hook 'whitespace-cleanup-mode)

(setq user-full-name "Ian Y.E. Pan")
(global-set-key (kbd "C-x 5 F") 'toggle-frame-fullscreen)
;; (add-to-list 'default-frame-alist '(ns-appearance . dark))

(setq ring-bell-function 'ignore)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode 0)

(setq initial-major-mode 'org-mode)
(with-current-buffer
    (get-buffer-create "*scratch*") (org-mode)
    (make-local-variable 'kill-buffer-query-functions)
    (add-hook 'kill-buffer-query-functions 'kill-scratch-buffer))
(defun kill-scratch-buffer ()
  (set-buffer (get-buffer-create "*scratch*"))
  (remove-hook 'kill-buffer-query-functions 'kill-scratch-buffer)
  (kill-buffer (current-buffer))
  (set-buffer (get-buffer-create "*scratch*")) (org-mode)
  (make-local-variable 'kill-buffer-query-functions)
  (add-hook 'kill-buffer-query-functions 'kill-scratch-buffer) nil)

(add-hook 'prog-mode-hook 'column-enforce-mode)
(setq column-enforce-column 79)

(global-font-lock-mode t)

(fset 'yes-or-no-p 'y-or-n-p)

(setq make-backup-files nil)

(global-visual-line-mode t)
(setq-default indicate-empty-lines t)

(defun toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
                    ((numberp (cdr alpha)) (cdr alpha))
                    ((numberp (cadr alpha)) (cadr alpha))) 100)
         '(75 . 75) '(100 . 100)))))
(global-set-key (kbd "C-c t") 'toggle-transparency)

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))
(global-set-key (kbd "C-x 4 5") 'toggle-window-split)

(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)
(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

(require 'vimrc-mode)
(add-to-list 'auto-mode-alist '("\\.vim\\(rc\\)?\\'" . vimrc-mode))

(require 'which-key)
(which-key-mode t)

(yas-global-mode 1)
