;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; Set the meta key to COMMAND on mac keyboard
(setq mac-option-modifier nil
      x-select-enable-clipboard t)

;; Set line number to relative
(setq display-line-numbers-type 'relative)

;; Use pipenv package
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
