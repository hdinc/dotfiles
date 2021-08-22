(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)
(setq auto-save-list-file-prefix nil)
(setq backup-inhibited t)

(add-to-list 'default-frame-alist '(font . "Cascadia Code-12"))

(use-package atom-one-dark-theme
  :ensure t
  :config (load-theme 'atom-one-dark t))

(use-package undo-tree
  :ensure t
  :config (global-undo-tree-mode))

(use-package evil
  :ensure t
  :config (evil-mode 1)
  :custom
  (evil-undo-system 'undo-tree))

(use-package lsp-mode
  :ensure t
  :config
  (add-hook 'c++-mode-hook 'lsp)
  (add-hook 'python-mode-hook 'lsp)
  (setq lsp-clients-clangd-args '("-j=4" "-background-index" "-log=error")))

(use-package company
  :ensure t
  :config (global-company-mode))
