;;;; package の設定
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

;;;; ===== パッケージインストール =====
;;;; ivy
(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) "))
;;;; counsel
;; ivy というコマンド補完機能を
;; 用いて、絞りこみ検索をする
(use-package counsel
  :config
  (counsel-mode 1))
;;;; swiper
;; Isearch の強化版
(use-package swiper)

;;;; Which Key（キーバインドヘルプ）
(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.3)
  (setq which-key-prefix-prefix "⚡ ")
  (setq which-key-sort-order 'which-key-key-order-alpha))

;;;; nテーマ設定
(use-package catppuccin-theme
  :config
  (setq catppuccin-flavor 'mocha) ;; 'latte, 'frappe, 'macchiato, 'mocha から選択
  (load-theme 'catppuccin t))

;;;; neotree（ファイルツリー表示）
(use-package neotree
  :config
  (setq neo-window-width 32)
  (setq neo-smart-open t)
  (setq neo-show-hidden-files t))

;;;; org-appear
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

;;;; DDSKK設定
;; やったぜ 完成したぜ。
(use-package ddskk
  :ensure t
  :config
  (setq default-input-method "japanese-skk")
  (global-set-key (kbd "C-x C-j") 'skk-mode))

;;;; flycheck
;; リアルタイムにソースの
;; エラーやワーニングを表示するマイナーモード
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
(use-package flycheck-inline)
;; flycheck で、インラインにエラーメッセージを追加
(with-eval-after-load 'flycheck
  (add-hook 'flycheck-mode-hook #'flycheck-inline-mode))

;;;; company
;; コードの補完をするパッケージ
(use-package company)
(add-hook 'after-init-hook 'global-company-mode)

;;;; rainbow-delimiters
(use-package rainbow-delimiters)
(require 'cl-lib)
(require 'color)
(rainbow-delimiters-mode 1)
(setq rainbow-delimiters-outermost-only-face-count 1)
;; 色をつける
(set-face-foreground 'rainbow-delimiters-depth-1-face "#fed4ff")
(set-face-foreground 'rainbow-delimiters-depth-2-face "#ff5e5e")
(set-face-foreground 'rainbow-delimiters-depth-3-face "#ffaa77")
(set-face-foreground 'rainbow-delimiters-depth-4-face "#dddd77")
(set-face-foreground 'rainbow-delimiters-depth-5-face "#80ee80")
(set-face-foreground 'rainbow-delimiters-depth-6-face "#66bbff")
(set-face-foreground 'rainbow-delimiters-depth-7-face "#da6bda")
(set-face-foreground 'rainbow-delimiters-depth-8-face "#afafaf")
(set-face-foreground 'rainbow-delimiters-depth-9-face "#f0f0f0")

;;;; lsp
;;; Eglot
(use-package eglot
  :ensure t
  :hook
  (html-mode . eglot-ensure)
  (css-mode . eglot-ensure)
  (js-mode .eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '(astro-mode . ("astro-ls" "--stdio"
                               :initializationOptions
                               (:typescript (:tsdk "./node_modules/typescript/lib")))))
  :init
  ;; astro-mode の eglot を自動起動
  (add-hook 'astro-mode-hook 'eglot-ensure))

;;; nix
;; lsp-nix
(use-package lsp-nix
  :ensure lsp-mode
  :after (lsp-mode)
  :demand t
  :custom
  (lsp-nix-nil-formatter ["nixfmt"]))

;; nix-mode
(use-package nix-mode
  :hook (nix-mode . lsp-deferred)
  :ensure t)
;;; ts
(use-package typescript-ts-mode
  :mode (("\\\\.tsx\\\\'" . tsx-ts-mode)
         ("\\\\.ts\\\\'" . tsx-ts-mode))
  :config
  (setq typescript-ts-mode-indent-offset 2))

;;; html
(add-to-list 'auto-mode-alist '("\\\\.html\\\\" . html-mode))

;;; js
(add-to-list 'auto-mode-alist '("\\\\.js\\\\" . js-mode))

;;; css
(add-to-list 'auto-mode-alist '("\\\\.css\\\\" . css-mode))

;;; astro
;; WEB モード
(use-package web-mode
  :ensure t)

;; ASTRO
(define-derived-mode astro-mode web-mode "astro")
(setq auto-mode-alist
      (append '((".*\\.astro\\'" . astro-mode))
              auto-mode-alist))
;;;; nerd-icons
(use-package nerd-icons
  :ensure t)

;;;; dirvish
(use-package dirvish
  :ensure t
  :after nerd-icons
  :init (dirvish-override-dired-mode)
  :config
  ;; フォルダを先に表示 + 左寄せ
  (setq dired-listing-switches "-l --all --human-readable --group-directories-first --no-group")

  ;; dirvish属性の設定（左寄せ）
  (setq dirvish-attributes
        '(nerd-icons subtree-state))

  ;; モードライン設定
  (setq dirvish-mode-line-format
        '(:left (sort symlink) :right (omit yank index))))

;;; side bar mode
(setq dirvish-side-follow-mode t)

;;; tab を押したらディレクトリを開く
(with-eval-after-load 'dirvish
  (define-key dirvish-mode-map (kbd "TAB") 'dirvish-subtree-toggle))
;;;; magit
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch-popup))
  :config
  (defun mu-magit-kill-buffers ()
    "magit buffer 内で、 `q` を押したら閉じる''"
    (interactive)
    (let ((buffers (magit-mode-get-buffers)))
      (magit-restore-window-configuration)
      (mapc #'kill-buffer buffers)))
  (bind-key "q" #'mu-magit-kill-buffers magit-status-mode-map))

;;;; moody
;; モードラインの要素をタブやリボンとして表示
(use-package moody
  :config
  (moody-replace-mode-line-front-space)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode))



