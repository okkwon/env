;;; .emacs --- Emacs initialization file -*- lexical-binding: t; -*-

;;; Commentary:

;; Welcome to Emacs (http://go/emacs).
;;
;; If you see this file, your homedir was just created on this workstation.
;; That means either you are new to Google (in that case, welcome!) or you
;; got yourself a faster machine.
;;
;; Either way, the main goal of this configuration is to help you be more
;; productive; if you have ideas, praise or complaints, direct them to
;; emacs-users@google.com (http://g/emacs-users).  We'd especially like to hear
;; from you if you can think of ways to make this configuration better for the
;; next Noogler.
;;
;; If you want to learn more about Emacs at Google, see http://go/emacs.

;;; Code:

(toggle-scroll-bar -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Use the 'google' package by default.
;; (require 'google)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)


;; theme
;; (load-theme 'dracula t)
(load-theme 'modus-vivendi t)

;; ivy
(ivy-mode 1)

(use-package all-the-icons
  :if (display-graphic-p))

(global-set-key (kbd "<f7>") #'clang-format-buffer)

;; deadgrep
;(require 'deadgrep)

(use-package deadgrep
  :ensure t
  :init)
(global-set-key (kbd "<f5>") #'deadgrep)

(use-package dap-mode
  :defer
  :custom
  (dap-auto-configure-mode t)
  (dap-auto-configure-features
   '(sessions locals breakpoints expressions tooltip))
  :config
  ;;; dap for c++
  (require 'dap-lldb)

  ;;; set the debugger executable (c++)
  (setq dap-lldb-debug-program '("/usr/bin/lldb-vscode"))

  ;;; ask user for executable to debug if not specified explicitly (c++)
  (setq dap-lldb-debugged-program-function (lambda () (read-file-name "Select file to debug."))))


(setq load-path
      (cons (expand-file-name "~/llvm-project/llvm/utils/emacs") load-path))
(require 'llvm-mode)
(require 'tablegen-mode)
(setq load-path
      (cons (expand-file-name "~/llvm-project/mlir/utils/emacs") load-path))
(require 'mlir-mode)
(require 'mlir-lsp-client)
(setq lsp-mlir-server-executable "~/llvm-project/build/bin/mlir-lsp-server")
(lsp-mlir-setup)


(setq lsp-pyls-plugins-jedi-environment  "/usr/local/google/home/okwan/.venv")

(use-package lsp-mode
  :ensure t
  :init
  :hook (c++-mode . lsp-deferred)
  :hook (c-mode . lsp-deferred)
  :hook (mlir-mode . lsp-deferred)
r  :hook (python-mode . lsp-deferred)
  :commands lsp lsp-deferred)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("s-p" . projectile-command-map)
              ("C-c p" . projectile-command-map)
              ([f6] . projectile-find-file)))

(setq projectile-project-search-path '("~/iree"))

(use-package all-the-icons
  :if (display-graphic-p))

(setq column-number-mode t)
(setq-default fill-column 80)
(setq-default indent-tabs-mode nil)
(setq-default global-display-fill-column-indicator-mode nil)

;;; .emacs ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["unspecified-bg" "red" "green" "yellow" "blue" "brightmagenta" "brightcyan" "brightwhite"])
 '(custom-safe-themes
   '("aa72e5b41780bfff2ff55d0cc6fcd4b42153386088a4025fed606c1099c2d9b8" "1bddd01e6851f5c4336f7d16c56934513d41cc3d0233863760d1798e74809b4b" "1d5e33500bc9548f800f9e248b57d1b2a9ecde79cb40c0b1398dec51ee820daf" "8d7b028e7b7843ae00498f68fad28f3c6258eda0650fe7e17bfb017d51d0e2a2" "028c226411a386abc7f7a0fba1a2ebfae5fe69e2a816f54898df41a6a3412bb5" "da186cce19b5aed3f6a2316845583dbee76aea9255ea0da857d1c058ff003546" "a9a67b318b7417adbedaab02f05fa679973e9718d9d26075c6235b1f0db703c8" "22f080367d0b7da6012d01a8cd672289b1debfb55a76ecdb08491181dcb29626" "76ed126dd3c3b653601ec8447f28d8e71a59be07d010cd96c55794c3008df4d7" "c4063322b5011829f7fdd7509979b5823e8eea2abf1fe5572ec4b7af1dd78519" "234dbb732ef054b109a9e5ee5b499632c63cc24f7c2383a849815dacc1727cb6" "04d8595e5772f1dc7a4c1737ba4589d32c695221270134e0763bd87834a42bbc" "d9e811d5a12dec79289c5bacaecd8ae393d168e9a92a659542c2a9bab6102041" default))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(lsp-python-ms dap-mode modus-vivendi-theme clang-format magit doom-themes doom-modeline deadgrep dracula-theme counsel restart-emacs use-package projectile zenburn-theme yasnippet-snippets yaml-mode which-key undo-tree tabbar session rust-mode puppet-mode pod-mode muttrc-mode mutt-alias lsp-ui initsplit ido-completing-read+ htmlize graphviz-dot-mode goto-chg gitignore-mode gitconfig-mode gitattributes-mode git-modes folding ess eproject editorconfig diminish csv-mode company-lsp color-theme-modern cmake-mode browse-kill-ring boxquote bm bar-cursor apache-mode))
 '(projectile-mode t nil (projectile))
 '(warning-suppress-types '((emacs))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Dejavu Sans Mono" :slant normal :weight normal :height 110 :width normal)))))
