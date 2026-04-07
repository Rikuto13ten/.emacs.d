;; straight.el のブートストラップ
(defvar bootstrap-version) ; ブートストラップ用変数
(let ((bootstrap-file ; bootstrap ファイルのパス
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7)) ; straight.el バージョン
  (unless (file-exists-p bootstrap-file)
    ;; bootstrap ファイルが存在しなければダウンロードして実行
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage)) ; bootstrap ファイルを読み込み

;; use-package を straight.el でインストール・設定
(straight-use-package 'use-package) ; use-package を straight.el 経由でインストール

;; straight.el を use-package のデフォルトパッケージマネージャーに設定
(setq straight-use-package-by-default t) ; use-package で自動的に straight.el を使用
(setq use-package-always-ensure t) ; :ensure キーワードは straight.el で動作
