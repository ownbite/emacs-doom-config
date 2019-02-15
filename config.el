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


;; Custom keybindings
(map!
 (:leader
    :desc "M-x"                    :nv ":"   #'execute-extended-command

    :desc "Delete the window"      :n  "q"   #'delete-window

    :desc "Horizonal Split"        :n  "s"   #'split-window-below
    :desc "Vertical Split"         :n  "v"   #'split-window-right


    (:desc "toggle" :prefix "t"
      :desc "Toggle terminal"      :n  "t"   #'open-terminal-in-new-window)

    (:desc "code" :prefix "c"
      :desc "Toggle comments"      :n  "c"   #'comment-line)))

;; Set the meta key to COMMAND on mac keyboard
(setq mac-option-modifier nil
      x-select-enable-clipboard t)

;; Set line number to relative
(setq display-line-numbers-type 'relative)

;; Use pipenv package and connect it to python-mode
(def-package! pipenv
  :hook (python-mode . pipenv-mode)
  :init
  (setq
   pipenv-projectile-after-switch-function
   #'pipenv-projectile-after-switch-extended))

;; When swapping project then actiate pipenv reload doom for changes to take effect
;; the open neotree
(add-hook! 'projectile-after-switch-project-hook
  (run-at-time "1 sec" nil #'pipenv-activate)
  (run-at-time "2 sec" nil #'doom/reload)
  (neotree-projectile-action))

;; Configure neotree
(setq neo-smart-open 1)
