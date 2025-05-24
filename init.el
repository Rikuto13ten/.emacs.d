;;; init.el --- Emacs設定ファイルのメインエントリーポイント

;; カスタム変数用ファイルの設定
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; セッション保存
(require 'desktop)                          ;; desktopパッケージを読み込み
(desktop-save-mode 1)                       ;; セッション保存を有効化
(setq desktop-restore-eager 5)              ;; 起動時に復元するバッファの数（残りは遅延ロード）
(setq desktop-save t)                       ;; 毎回保存する（ask-if-new, ask, if-exists, always, t）
(setq desktop-load-locked-desktop t)        ;; ロックされていても読み込む
(setq desktop-path '("~/.emacs.d/desktop")) ;; セッション保存先
(setq desktop-auto-save-timeout 30)         ;; 自動保存（秒）

;; 保存ディレクトリの作成
(unless (file-exists-p "~/.emacs.d/desktop")
  (make-directory "~/.emacs.d/desktop" t))

;; custom-fileの読み込み（もしcustom-fileが設定されている場合）
(when (and (boundp 'custom-file) custom-file (file-exists-p custom-file))
  (load custom-file))

;; その他の基本設定
(setq make-backup-files nil) ;; バックアップファイルを作らない
(setq auto-save-default nil) ;; 自動保存ファイルを作らない

(mac-auto-ascii-mode 1)

;; パッケージ設定のロード
(load (expand-file-name "package.el" user-emacs-directory))

;; キーバインド設定のロード
(load (expand-file-name "keybind.el" user-emacs-directory))

;; UI 関連
(load (expand-file-name "ui.el" user-emacs-directory))

;; org mode 関連
(load (expand-file-name "org-mode.el" user-emacs-directory))

;; Coding 関係のまとめる
(load (expand-file-name "coding.el" user-emacs-directory))

(add-hook 'emacs-lisp-mode-hook 'outline-minor-mode)

;;; 括弧を色つける
(require 'cl-lib)
(require 'color)

(rainbow-delimiters-mode 1)
(setq rainbow-delimiters-outermost-only-face-count 1)

(set-face-foreground 'rainbow-delimiters-depth-1-face "#fed4ff")
(set-face-foreground 'rainbow-delimiters-depth-2-face "#ff5e5e")
(set-face-foreground 'rainbow-delimiters-depth-3-face "#ffaa77")
(set-face-foreground 'rainbow-delimiters-depth-4-face "#dddd77")
(set-face-foreground 'rainbow-delimiters-depth-5-face "#80ee80")
(set-face-foreground 'rainbow-delimiters-depth-6-face "#66bbff")
(set-face-foreground 'rainbow-delimiters-depth-7-face "#da6bda")
(set-face-foreground 'rainbow-delimiters-depth-8-face "#afafaf")
(set-face-foreground 'rainbow-delimiters-depth-9-face "#f0f0f0")

;; 使いたいモードはお好みで
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'c-mode-hook 'rainbow-delimiters-mode)

