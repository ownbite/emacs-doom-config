;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-
(server-start)

;;;;;;;;;;;;;;;;;;;;;;
;; CUSTOM FUNCTIONS ;;
;;;;;;;;;;;;;;;;;;;;;;
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
      :desc "Run pytest repeat"    :n  "t"   #'python-pytest-repeat
      :desc "Run pytest config"    :n  "y"   #'python-pytest-popup)))


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
