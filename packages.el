;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)
(package! pipenv-with-projectile :disable t)
(package! pipenv :disable t)
(package! evil-collection)

;; Multi term for zsh support
(package! multi-term)

;; Better user experience with git
(package! magit)

;; For formatting
;; (package! py-autopep8)
(package! blacken)
(package! ruff-format)
(package! python-black)
(package! python-pytest)


(package! terraform-mode)

(package! ox-reveal)
(package! web-mode)
