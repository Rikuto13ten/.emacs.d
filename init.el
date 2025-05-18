;;; init.el --- Emacs設定ファイルのメインエントリーポイント

;; カスタム変数用ファイルの設定
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)

 ;; セッション保存
(desktop-save-mode 1)                       ;; セッション保存を有効化
(setq desktop-restore-eager 5)              ;; 起動時に復元するバッファの数（残りは遅延ロード）
(setq desktop-save t)                       ;; 毎回保存する（ask-if-new, ask, if-exists, always, t）
(setq desktop-load-locked-desktop t)        ;; ロックされていても読み込む
(setq desktop-path '("~/.emacs.d/desktop")) ;; セッション保存先
(setq desktop-auto-save-timeout 30)         ;; 自動保存（秒）
;; 保存ディレクトリの作成
(unless (file-exists-p "~/.emacs.d/desktop")
  (make-directory "~/.emacs.d/desktop" t)) (load custom-file))

;; その他の基本設定
(setq make-backup-files nil)       ;; バックアップファイルを作らない
(setq auto-save-default nil)       ;; 自動保存ファイルを作らない

;; パッケージ設定のロード
(load (expand-file-name "package.el" user-emacs-directory))

;; キーバインド設定のロード
(load (expand-file-name "keybind.el" user-emacs-directory))

;; UI 関連
(load (expand-file-name "ui.el" user-emacs-directory))

;; org mode 関連
(load (expand-file-name "org-mode.el" user-emacs-directory))
