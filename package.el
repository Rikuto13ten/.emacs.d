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
;; Ivy、Emacs の汎用補完メカニズム。
;; Counsel は、一般的な Emacs コマンドの Ivy 拡張バージョンのコレクション。
;; Swiper は、Isearch の Ivy 強化代替品。
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

;; neotree（ファイルツリー表示）
(use-package neotree
  :config
  (setq neo-window-width 32)
  (setq neo-smart-open t)
  (setq neo-show-hidden-files t))

;; マーカ編集中に強調マーカを表示する
(use-package org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t ; 強調マーカー (*bold* など)
        org-appear-autosubmarkers t ; 下付き/上付きマーカー
        org-appear-autolinks t ; リンクマーカー
        org-appear-autoentities t ; エンティティ
        org-appear-autokeywords t ; キーワード
        ;; 重要: 見出しの * を表示するための設定
        org-appear-inside-latex t
        org-appear-trigger 'always) ; 常に表示（Evilモード対応）
)

;; DDSKK設定
;; やったぜ 完成したぜ。
(use-package ddskk
  :ensure t
  :config
  (setq default-input-method "japanese-skk")
  (global-set-key (kbd "C-x C-j") 'skk-mode))

;; リアルタイムにソースの
;; エラーやワーニングを表示するマイナーモード
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
(use-package flycheck-inline)

;; コードの補完をするパッケージ
(use-package company)
(add-hook 'after-init-hook 'global-company-mode)

(use-package rainbow-delimiters)

;; buffer tabs
(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t))

(use-package lsp-mode
    :hook (XXX-mode . lsp-deferred)
    :commands (lsp lsp-deferred))

(use-package lsp-nix
  :ensure lsp-mode
  :after (lsp-mode)
  :demand t
  :custom
  (lsp-nix-nil-formatter ["nixfmt"]))

(use-package nix-mode
  :hook (nix-mode . lsp-deferred)
  :ensure t)

(use-package nerd-icons
  :ensure t)

(use-package dirvish
  :ensure t
  :after nerd-icons
  :init (dirvish-override-dired-mode)
  :config
  ;; フォルダを先に表示 + 左寄せ
  (setq dired-listing-switches "-l --all --human-readable --group-directories-first --no-group")

  ;; dirvish属性の設定（左寄せ）
  (setq dirvish-attributes
        '(nerd-icons file-time file-size collapse subtree-state vc-state git-msg))

  ;; モードライン設定
  (setq dirvish-mode-line-format
        '(:left (sort symlink) :right (omit yank index))))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch-popup))
  :config
  (defun mu-magit-kill-buffers ()
    "Restore window configuration and kill all Magit buffers."
    (interactive)
    (let ((buffers (magit-mode-get-buffers)))
      (magit-restore-window-configuration)
      (mapc #'kill-buffer buffers)))
  (bind-key "q" #'mu-magit-kill-buffers magit-status-mode-map))
