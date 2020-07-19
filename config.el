;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(server-start)

;; Make it possible to quickly swap over to iterm
(defun open-iterm ()
  (interactive)

  (shell-command
   (format "open -a /Applications/iTerm.app \"%s\""
       (if (buffer-file-name)
           (file-name-directory (buffer-file-name))
         (expand-file-name default-directory)))))

(defun open-terminal-in-new-window ()
  (interactive)
  (split-window-below)
  (evil-window-down 1)
  (multi-term))

(defun pipenv-activate-and-reload ()
  (interactive)
  (pipenv-deactivate)
  (pipenv-activate))

(setq flycheck-check-syntax-automatically '(mode-enabled save))

;; Custom keybindings
(map!
 :n "M-m" 'evil-mc-make-and-goto-next-match

 (:leader
    ;; :desc "jedi code completion"   :n  "m"   #'jedi:complete
    :desc "M-x"                    :nv ":"   #'execute-extended-command

    :desc "Delete the window"      :n  "q"   #'delete-window

    ;; :desc "Horizonal Split"        :n  "s"   #'split-window-below
    ;; :desc "Vertical Split"         :n  "v"   #'split-window-right


    (:desc "toggle" :prefix "t"
      :desc "Toggle terminal"      :n  "t"   #'open-terminal-in-new-window)

    ;; (:desc "git" :prefix "g"
    ;;   :desc "Magit status"         :n  "g"   #'magit-status)

    (:desc "code" :prefix "c"
      :desc "Toggle comments"      :n  "c"   #'comment-line
      :desc "Run pytest repeat"    :n  "t"   #'python-pytest-repeat
      :desc "Run pytest config"    :n  "y"   #'python-pytest-popup
      :desc "Activate pipenv"      :n  "a"   #'pipenv-activate-and-reload)))

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
