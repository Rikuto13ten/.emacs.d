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

(unless (package-installed-p 'vc-use-package)
  (package-vc-install "https://github.com/slotThe/vc-use-package"))
(require 'vc-use-package)


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

;;;; テーマ設定
(use-package catppuccin-theme
  :config
  (setq catppuccin-flavor 'mocha) ;; 'latte, 'frappe, 'macchiato, 'mocha から選択
  (load-theme 'catppuccin t))

;;;; org-appear
;; マーカ編集中に強調マーカを表示する
(use-package org-appear
  :after org
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
(add-hook 'org-mode-hook 'org-appear-mode)

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
(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :config
  (setq company-minimum-prefix-length 1)  ; 1文字から補完開始
  (setq company-idle-delay 0.3)           ; 補完表示遅延
  (setq company-backends '(company-capf)) ; eglotではcapfを使用

  ;; キーバインド
  (define-key company-active-map (kbd "TAB") 'company-complete-selection)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))


;;;; rainbow-delimiters
(use-package rainbow-delimiters)
(require 'cl-lib)
(require 'color)
(rainbow-delimiters-mode 1)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
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
;;; eglot
(use-package eglot
  :ensure t
  :hook
  (elm-mode . eglot-ensure)
  (kotlin-mode . eglot-ensure)
  :config
  (add-to-list
   'eglot-server-programs `((kotlin-mode) . (,(concat user-emacs-directory "") ""))))
;;; elm-mode
;; Elm Mode
(use-package elm-mode
  :ensure t
  :mode "\\.elm\\'"
  :config
  ;; 自動フォーマット
  (setq elm-format-on-save t)
  ;; キーバインド
  (define-key elm-mode-map (kbd "C-c C-l") 'elm-repl-load)
  (define-key elm-mode-map (kbd "C-c C-r") 'elm-repl)
  (define-key elm-mode-map (kbd "C-c C-f") 'elm-format-buffer)
  )
;;;; nerd-icons
(use-package nerd-icons
  :ensure t)

;;;; dirvish
;;; 基本設定
(use-package dirvish
  :ensure t
  :after nerd-icons
  :init (dirvish-override-dired-mode)
  :config
  (setq dired-listing-switches "-l --almost-all --human-readable --group-directories-first --no-group")

  ;; dirvish属性の設定（左寄せ）
  (setq dirvish-attributes
        '(vc-state nerd-icons subtree-state))

  ;; モードライン設定
  (setq dirvish-mode-line-format
        '(:left (sort symlink) :right (omit yank index))))

;;; side bar mode
(setq dirvish-side-follow-mode t)

;;; C-f を押したらディレクトリを開く
(with-eval-after-load 'dirvish
  (define-key dirvish-mode-map (kbd "<tab>") 'dirvish-subtree-toggle))
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

;;;; org-roam
;;; config
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/blog/org-blog/"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

;;; org-roam-capture
(with-eval-after-load 'org-roam-capture
  (setq org-roam-capture-templates '(("f" "Fleeting(一時メモ)" plain "%?"
                                      :target (file+head "fleeting/%<%Y%m%d%H%M%S>-${slug}.org" "#+TITLE: ${title}\n")
                                      :unnarrowed t)

                                     ("p" "Permanent(記事)" plain "%?"
                                      :target (file+head
                                               "permanent/%<%Y%m%d%H%M%S>-${slug}.org"
                                               "#+TITLE: ${title}\n#+AUTHOR:\n#+DATE:\n#+HUGO_BASE_DIR: ../../\n#+HUGO_DRAFT: false\n#+HUGO_TAGS:\n#+STARTUP: nohideblocks\n")
                                      :unnarrowed t)

                                     ("d" "Diary(日記)" plain "%?"
                                      :target (file+head "diary/%<%Y%m%d%H%M%S>-${slug}.org" "#+TITLE: ${title}\n")
                                      :unnarrowed t)

                                     ("z" "Zenn" plain "%?"
                                      :target (file+head "zenn/%<%Y%m%d%H%M%S>.org" "#+TITLE: ${title}\n")
                                      :unnarrowed t)

                                     ("m" "Private" plain "%?"
                                      :target (file+head "private/%<%Y%m%d%H%M%S>.org" "#+TITLE: ${title}\n")
                                      :unnarrowed t)

                                     ;; TODO専用テンプレート
                                     ("t" "TODO" plain "* TODO ${title}%?\n  :PROPERTIES:\n  :CREATED: %U\n  :END:\n"
                                      :target (file+head "private/todo.org"
                                                         "#+title: TODO List\n
                                                          #+filetags: :todo:\n\n")
                                      :unnarrowed t))))

;;;; one.el
(use-package one)

;;;; ox-hugo
(use-package ox-hugo
  :ensure t
  :pin melpa
  :after ox
  :config
  (setq org-hugo-preserve-filling t)
  (setq org-export-preserve-breaks t))

;;;; php-mode
(use-package php-mode
  :ensure t)

;;;; eat
(use-package eat
  :ensure t
  :config
  ;; シェル統合の有効化
  (add-hook 'eshell-load-hook #'eat-eshell-mode)
  ;; 視覚的コマンドの処理もeatで行う
  (add-hook 'eshell-load-hook #'eat-eshell-visual-command-mode))


;;;; yasnnipet
(use-package yasnippet
  :ensure t
  :custom-face
  (yas-field-highlight-face ((t (:inherit nil))))
  :bind (:map yas-minor-mode-map
              ;; バインドが使いづらいので解除
              ("C-c & C-n" . nil)
              ("C-c & C-s" . nil)
              ("C-c & C-v" . nil)
              ;; よく使うコマンドをバインド
              ("C-x y n" . yas-new-snippet)
              ("C-x y i" . yas-insert-snippet)
              ("C-x y v" . yas-visit-snippet-file)
              ("C-x y l" . yas-describe-tables)
              ("C-x y r" . yas-reload-all))
  :init
  (yas-global-mode)
  :config
  (setq yas-prompt-functions '(yas-ido-prompt)))

;;;; org-modern
(use-package org-modern
  :after org
  :custom
  (org-modern-block-fringe 1)
  (org-modern-star '("◉" "○" "◈" "◇" "✱" "✲" "✳" "✴"))
  :config
  (global-org-modern-mode))

;;; 装飾を一時的に無効化
(defun my/toggle-org-modern ()
  "Toggle org-modern on/off"
  (interactive)
  (if org-modern-mode
      (org-modern-mode -1)
    (org-modern-mode 1)))

;; キーバインド設定例
(define-key org-mode-map (kbd "C-c m") 'my/toggle-org-modern)



;;;; perfect margin
(use-package perfect-margin
  :config
  (setq perfect-margin-ignore-filters nil)
  (perfect-margin-mode +1))

;;;; super padding
(use-package spacious-padding
  :config
  (setq spacious-padding-widths
        '( :internal-border-width 15
           :header-line-width 4
           :mode-line-width 6
           :tab-width 4
           :right-divider-width 30
           :scroll-bar-width 8))

  ;; Read the doc string of `spacious-padding-subtle-mode-line' as it
  ;; is very flexible and provides several examples.
  (setq spacious-padding-subtle-mode-line
        `( :mode-line-active 'default
           :mode-line-inactive vertical-border))

  (spacious-padding-mode +1))
