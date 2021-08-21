(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

(defun my-kill-emacs ()
  "save some buffers, then exit unconditionally"
  (interactive)
  (save-some-buffers nil t)
  (kill-emacs))
(global-set-key (kbd "C-x C-c") 'my-kill-emacs)

(set-frame-font "Cascadia Code 12" nil t)
(load-theme 'atom-one-dark t)

(define-minor-mode cmd-mode
  "normal mode"
  nil
  "NORMAL"
  '(
    ("j" . next-line)
    ("k" . previous-line)
    ("l" . forward-char)
    ("h" . backward-char)
  )
  )

;Changes cursor type to bar
(setq-default cursor-type 'bar)
