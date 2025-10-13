;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-
(server-start)

(setq doom-theme 'doom-dracula)
;;(setq user-emacs-directory "~/.emacs.d/")
(setq display-line-numbers-type 'relative)

(require 'ox-reveal)


;;;;;;;;;;;;;;;;;;;;;;
;; CUSTOM FUNCTIONS ;;
;;;;;;;;;;;;;;;;;;;;;;
(setq lsp-pyls-server-command "pyright-langserver")
(setq lsp-python-ms-executable "pyright-langserver")

(defun open-iterm ()
  (interactive)

  (shell-command
   (format "open -a /Applications/iTerm.app \"%s\""
       (if (buffer-file-name)
         (expand-file-name default-directory)))))

(defun open-terminal-in-new-window ()
  (interactive)
  (split-window-below)
  (evil-window-down 1)
  (multi-term))

(defun ruff-format-current-file ()
  "Run Ruff fix+format on this file, then reload."
  (interactive)
  (when (eq major-mode 'python-mode) ; Check if it's a Python file
        (shell-command (format "ruff check --fix %s" (buffer-file-name)))
        (ruff-format-buffer)
        (revert-buffer :ignore-auto :noconfirm))
  (when (eq major-mode 'html-mode) ; Check if it's an HTML file
    (shell-command (format "djhtml -i %s" (buffer-file-name)))
    (revert-buffer :ignore-auto :noconfirm)))

(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom keybindings ;;
;;;;;;;;;;;;;;;;;;;;;;;;
(map!
 :n "M-m" 'evil-mc-make-and-goto-next-match

 (:leader
    :desc "M-x"                    :nv ":"   #'execute-extended-command

    :desc "Delete the window"      :n  "q"   #'delete-window

    (:desc "toggle" :prefix "t"
      :desc "Toggle terminal"      :n  "t"   #'open-terminal-in-new-window)

    (:desc "code" :prefix "c"
      :desc "Toggle comments"      :n  "c"   #'comment-line
      :desc "Goto definition of fn":n  "g"   #'evil-goto-definition
      :desc "Run pytest repeat"    :n  "t"   #'python-pytest-repeat
      :desc "Run isort, black and djhtml"    :n  "s"   #'ruff-format-buffer
      :desc "Run pytest config"    :n  "y"   #'python-pytest-popup)

    (:desc "file" :prefix "f"
      :desc "open link"            :n  "o"   #'browse-url)

    (:desc "workspace" :prefix "TAB"
        :desc "Toggle last workspace" :n  "TAB"  #'+workspace/other)))

;;;;;;;;;;;;;;
;; SETTINGS ;;
;;;;;;;;;;;;;;

;; Autocompletion
(setq company-idle-delay 0.2
      company-minimum-prefix-length 3)

;; Set the meta key to COMMAND on mac keyboard
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)

;; Do not guess auto root
(setq lsp-auto-guess-root nil)

(setq flycheck-check-syntax-automatically '(mode-enabled save))

(use-package tramp
  :ensure nil
  :custom
  (tramp-default-method "ssh"))

(setenv "PATH"
  (concat
   "/Users/linuswallin/.pyenv/shims" ":"
   "/Users/linuswallin/.local/bin" ":"
   "/usr/local/bin" ":"
   (getenv "PATH")
  )
)

;; Javascript development blarg
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)


