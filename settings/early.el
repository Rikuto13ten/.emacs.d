;; ===================================================================
;; セッション管理（Desktop Save Mode）
;; ===================================================================

(require 'desktop) ; desktopパッケージを読み込み

;; セッション保存ディレクトリの作成
(let ((desktop-dir "~/.emacs.d/desktop"))
  (unless (file-exists-p desktop-dir)
    (make-directory desktop-dir t)) ; 保存ディレクトリがなければ作成
  (setq desktop-path (list desktop-dir))) ; セッション保存先を指定

(desktop-save-mode 1) ; セッション保存を有効化
(setq desktop-restore-eager 5) ; 起動時に復元するバッファの数（残りは遅延ロード）
(setq desktop-load-locked-desktop t) ; クラッシュ時のロックファイルが存在しても読み込む
(setq desktop-auto-save-timeout 30) ; 自動保存間隔（秒単位）

(defun load-file-init-el () ; init.el を読み込み
    "load-file init.el"
    (interactive)
    (load-file (expand-file-name "~/.emacs.d/init.el")))

;; ===================================================================
;; ファイル管理
;; ===================================================================

(setq make-backup-files nil) ; バックアップファイルを作成しない
(setq auto-save-default nil) ; 自動保存ファイルを作成しない
(auto-save-visited-mode 1) ; アクティブなバッファを自動保存する
(setq auto-save-visited-interval 2) ; 自動保存の間隔（秒単位）

;; ===================================================================
;; 文字コード設定
;; ===================================================================

(set-default-coding-systems 'utf-8) ; デフォルト文字コードを UTF-8 に設定
(set-terminal-coding-system 'utf-8) ; 端末の文字コードを UTF-8 に設定
(set-keyboard-coding-system 'utf-8) ; キーボード入力の文字コードを UTF-8 に設定
(set-buffer-file-coding-system 'utf-8) ; バッファのファイル文字コードを UTF-8 に設定
(setq-default buffer-file-coding-system 'utf-8) ; デフォルトバッファファイル文字コードを UTF-8 に設定

;; ===================================================================
;; macOS 固有の設定
;; ===================================================================

(mac-auto-ascii-mode 1) ; ASCII 文字への自動切り替え（IM 対応）

;; ===================================================================
;; UI 設定（フォント・テーマ）
;; ===================================================================
(use-package spacemacs-theme :ensure t)

(use-package telephone-line)
(telephone-line-mode 1)

(load-theme 'spacemacs-dark t) ; spacemacs-dark テーマを読み込み
(set-face-attribute 'default nil :family "PlemolJP" :height 150) ; デフォルトフォントを PlemolJP 15pt に設定
(set-fontset-font nil '(#x000000 . #x10FFFF) (font-spec :family "PlemolJP")) ; Unicode 全範囲を PlemolJP でカバー

;; ===================================================================
;; UI 要素の表示設定
;; ===================================================================

(menu-bar-mode 1) ; メニューバーを表示
(tool-bar-mode -1) ; ツールバーを非表示
(global-display-line-numbers-mode 1) ; 行番号を表示

;; ===================================================================
;; 空白
;; ===================================================================

(setq whitespace-style '(face ; 表示する空白を設定
                         spaces
                         trailing
                         tabs
                         empty
                         space-mark
                         tab-mark))
(global-whitespace-mode 0) ; 空白モードを無効にする
(setq-default indent-tabs-mode nil) ;; インデントを空白にする

;; ===================================================================
;; エディター設定
;; ===================================================================

(electric-pair-mode 1) ; 括弧を自動挿入

(use-package rainbow-delimiters)
(require 'cl-lib)
(require 'color)
(rainbow-delimiters-mode 1)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(setq rainbow-delimiters-outermost-only-face-count 1)

;; ===================================================================
;; 補完
;; ===================================================================

(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) "))

(use-package counsel
  :config
  (counsel-mode 1))

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

(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.3)
  (setq which-key-prefix-prefix "⚡ ")
  (setq which-key-sort-order 'which-key-key-order-alpha))

;; ===================================================================
;; 検索
;; ===================================================================

(use-package swiper)

