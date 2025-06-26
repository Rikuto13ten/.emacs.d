(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

(setq use-package-always-ensure t)

(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) "))

(use-package counsel
  :config
  (counsel-mode 1))

(use-package swiper)

(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.3)
  (setq which-key-prefix-prefix "⚡ ")
  (setq which-key-sort-order 'which-key-key-order-alpha))

(use-package spacemacs-theme)

(load-theme 'spacemacs-light t)

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

(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :config
  (setq company-minimum-prefix-length 1)  ; 1文字から補完開始
  (setq company-idle-delay 0.3)           ; 補完表示遅延
  (setq company-backends '(company-capf)) ; eglotではcapfを使用

  (define-key company-active-map (kbd "TAB") 'company-complete-selection)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))

(use-package rainbow-delimiters)
(require 'cl-lib)
(require 'color)
(rainbow-delimiters-mode 1)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(setq rainbow-delimiters-outermost-only-face-count 1)

(use-package nerd-icons
  :ensure t)

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
  ;; q で magit buffer を閉じる
  (bind-key "q" #'mu-magit-kill-buffers magit-status-mode-map))

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

(use-package ox-hugo
  :ensure t
  :pin melpa
  :after ox
  :config
  (setq org-hugo-preserve-filling t)
  (setq org-export-preserve-breaks t))

(use-package eat
  :ensure t
  :config
  ;; シェル統合の有効化
  (add-hook 'eshell-load-hook #'eat-eshell-mode)
  ;; 視覚的コマンドの処理もeatで行う
  (add-hook 'eshell-load-hook #'eat-eshell-visual-command-mode))

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

(use-package spacious-padding
  :config
  (setq spacious-padding-widths
        '( :internal-border-width 15
           :header-line-width 4
           :mode-line-width 6
           :tab-width 4
           :right-divider-width 30
           :scroll-bar-width 8))
  (setq spacious-padding-subtle-mode-line
        `( :mode-line-active 'default
           :mode-line-inactive vertical-border))

  (spacious-padding-mode +1))

(use-package writeroom-mode)
(setq writeroom-width 120)
(add-hook 'org-mode-hook 'writeroom-mode)
(add-hook 'org-mode-hook 'visual-fill-column-mode)
(add-hook 'org-mode-hook 'visual-line-mode)

(use-package json-mode)
