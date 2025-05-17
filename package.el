;; パッケージ管理の初期化
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; パッケージの自動更新
(unless package-archive-contents
  (package-refresh-contents))

;; use-package（パッケージ管理用）
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; ===== パッケージインストール =====

;; Ivy/Counsel/Swiper（補完と検索強化）
(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) "))

(use-package counsel
  :config
  (counsel-mode 1))

(use-package swiper)

;; Which Key（キーバインドヘルプ）
(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.3)
  (setq which-key-prefix-prefix "⚡ ")
  (setq which-key-sort-order 'which-key-key-order-alpha))

;; テーマ設定
(use-package catppuccin-theme
  :config
  (setq catppuccin-flavor 'mocha) ;; 'latte, 'frappe, 'macchiato, 'mocha から選択
  (load-theme 'catppuccin t))

;; Evilモード（Vimキーバインド）
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

;; Evilの拡張
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Evilリーダーキー
(use-package evil-leader
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "SPC"))

;; neotree（ファイルツリー表示）
(use-package neotree
  :config
  (setq neo-window-width 32)
  (setq neo-smart-open t)
  (setq neo-show-hidden-files t))
