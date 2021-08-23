(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(setq-default
 make-backup-files nil
 auto-save-default nil
 create-lockfiles nil
 auto-save-list-file-prefix nil
 backup-inhibited t
 cursor-in-non-selected-windows nil
 fill-column 80
 inhibit-startup-screen t
 initial-scratch-message ""
 tab-width 4
 c-basic-offset 4
 indent-tabs-mode nil
 indent-line-function 'insert-tab
)

(add-to-list 'default-frame-alist '(font . "Cascadia Code-12"))

(use-package atom-one-dark-theme
  :ensure t
  :config (load-theme 'atom-one-dark t))

(use-package undo-tree
  :ensure t
  :config (global-undo-tree-mode))

(use-package general
  :ensure t
  :config (general-evil-setup))

(use-package evil
  :ensure t
  :init (setq evil-want-keybinding nil)
  :custom (evil-undo-system 'undo-tree)
  :config
  (evil-mode 1)
  (general-nmap
    "M-w" 'tab-bar-switch-to-prev-tab
    "M-e" 'tab-bar-switch-to-next-tab
    "M-s" 'previous-buffer
    "M-d" 'next-buffer
    "C-h" 'windmove-left
    "C-l" 'windmove-right
    "C-k" 'windmove-up
    "C-j" 'windmove-down
    ", z" 'fzf
    )
  (setq-default
   evil-shift-width 4
   )
  )

(use-package evil-collection
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-commentary
  :ensure t)

(use-package lsp-mode
  :ensure t
  :config
;  (add-hook 'c++-mode-hook 'lsp)
;  (add-hook 'python-mode-hook 'lsp)
  (setq lsp-clients-clangd-args '("-j=4" "-background-index" "-log=error")))

(use-package company
  :ensure t
  :config (global-company-mode))

(use-package fzf
  :ensure t)
