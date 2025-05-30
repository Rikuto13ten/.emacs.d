;;;;; Header rule
;; `;;;;;` -> category
;; `;;;;` -> ひとつの機能
;; `;;;` -> 機能のメソッドなど

;;;;; 起動オプション
;;; カスタム変数用ファイルの設定
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;;; セッション保存
(require 'desktop)                          ;; desktopパッケージを読み込み
(desktop-save-mode 1)                       ;; セッション保存を有効化
(setq desktop-restore-eager 5)              ;; 起動時に復元するバッファの数（残りは遅延ロード）
(setq desktop-save t)                       ;; 毎回保存する（ask-if-new, ask, if-exists, always, t）
(setq desktop-load-locked-desktop t)        ;; ロックされていても読み込む
(setq desktop-path '("~/.emacs.d/desktop")) ;; セッション保存先
(setq desktop-auto-save-timeout 30)         ;; 自動保存（秒）

;;; 保存ディレクトリの作成
(unless (file-exists-p "~/.emacs.d/desktop")
  (make-directory "~/.emacs.d/desktop" t))

;;; custom-fileの読み込み（もしcustom-fileが設定されている場合）
(when (and (boundp 'custom-file) custom-file (file-exists-p custom-file))
  (load custom-file))

;;; backup file & auto save file settings
(setq make-backup-files nil) ;; バックアップファイルを作らない
(setq auto-save-default nil) ;; 自動保存ファイルを作らない

;;; Emacs Server
;; Emacs Server設定
(require 'server)

;; サーバーが既に起動していない場合のみ起動
(unless (server-running-p)
  (server-start))

;; サーバーソケットのディレクトリを指定（オプション）
(setq server-socket-dir "~/.emacs.d/server")

;; クライアント終了時の動作設定
(setq server-kill-new-buffers t)  ; 新しいバッファは自動削除
(setq server-temp-file-regexp "^/tmp/\\|/draft$")  ; 一時ファイルの設定
;;;;; 基本的な設定
;;;; Font 関係
(when (display-graphic-p)
  (cond
   ;; 第一優先のフォントが利用可能かチェック
   ((find-font (font-spec :name "Iosevka Custom Rikuto Code"))
    (set-face-attribute 'default nil
                        :family "Iosevka Custom Rikuto Code"
                        :height 160))
   ;; フォールバック1
   (t
    (set-face-attribute 'default nil
                        :family "Menlo"
                        :height 120))))

;;;; whitespace-modeの設定
(require 'whitespace)
(setq whitespace-style '(face       ;; 見た目
                         trailing   ;; 行末の空白
                         tabs       ;; タブ
                         spaces     ;; スペース
                         empty      ;; 先頭/末尾ノ空行
                         space-mark ;; 空白マークヲ表示
                         tab-mark)) ;; タブマークヲ表示

;; 色設定（控エメナ色、背景色ナシ）
(set-face-attribute 'whitespace-trailing nil
                    :background nil
                    :foreground "#40404a"  ;; 行末ノ空白（薄イグレー）
                    :underline t)          ;; 下線デ強調

(set-face-attribute 'whitespace-tab nil
                    :background nil
                    :foreground "#40404a")  ;; タブ（薄イグレー）

(set-face-attribute 'whitespace-space nil
                    :background nil
                    :foreground "#40404a")  ;; スペース（薄イグレー）

(set-face-attribute 'whitespace-empty nil
                    :background nil
                    :foreground "#40404a")  ;; 空行（薄イグレー）

;; グローバルニ有効化
(global-whitespace-mode 1)

;; Tab to Space に変換
(setq-default indent-tabs-mode nil)

;;;; 行番号を表示
(global-display-line-numbers-mode)

;;;; ascii mode
(mac-auto-ascii-mode 1)
;;;; 対応する括弧を自動挿入
(electric-pair-mode 1)
;;;;; Package.el
;; パッケージ設定のロード
(load (expand-file-name "package.el" user-emacs-directory))

;;;;; outline 関連
;;;;; org pmode 関連
;;; 見出し設定
(use-package org
  :config
  ;; 見出しの初期状態を折りたたんだ状態に変更
  (setq org-startup-folded t)
  ;; インデント表示を有効に
  (setq org-startup-indented t)
  ;; 強調マーカーを非表示にする
  (setq org-hide-emphasis-markers t)
  ;; * を非表示にしない
  (setq org-hide-leading-stars nil)
  (setq org-indent-mode-turns-on-hiding-stars nil)

  (custom-set-faces
   '(org-level-1 ((t (:foreground "#f38ba8" :weight bold :height 1.3))))
   '(org-level-2 ((t (:foreground "#fab387" :weight bold :height 1.2))))
   '(org-level-3 ((t (:foreground "#f9e2af" :weight bold :height 1.1))))
   '(org-level-4 ((t (:foreground "#a6e3a1" :weight bold))))
   '(org-level-5 ((t (:foreground "#89b4fa" :weight bold))))
   '(org-level-6 ((t (:foreground "#cba6f7" :weight bold))))
   '(org-level-7 ((t (:foreground "#f5c2e7" :weight bold))))
   '(org-level-8 ((t (:foreground "#94e2d5" :weight bold))))))

;;;;; extention
;;;; 見出しを変える
(font-lock-add-keywords 'emacs-lisp-mode
                        '(("^;;;\\([;]*\\) \\(.*\\)$"
                           (2 '(:inherit org-level-4 :height 1.1) t))
                          ("^;;;;\\([;]*\\) \\(.*\\)$"
                           (2 '(:inherit org-level-3 :height 1.2) t))
                          ("^;;;;;\\([;]*\\) \\(.*\\)$"
                           (2 '(:inherit org-level-2 :height 1.3) t))
                          ("^;;;;;;\\([;]*\\) \\(.*\\)$"
                           (2 '(:inherit org-level-1 :height 1.4) t))))

;;;; outliEne-minor-modeでTABキーを使って開閉する設定
;;; 個々の見出しの開閉を切り替える関数
(defun my-outline-toggle ()
  "Toggle outline body visibility at point."
  (interactive)
  ;; 現在行が、ヘッダー行の場合処理を続ける
  ;; それ以外は処理をしない
  (when (outline-on-heading-p)
    ;; 行末に隠れたテキストがある場合
    (if (outline-invisible-p (line-end-position))
        ;; t: 本文を表示し、小見出しも表示する。
        (progn (outline-show-entry)
               (outline-show-children))
      ;; nil: 本文と、小見出しの全てを非表示にする
      (outline-hide-subtree))))

;;; すべての見出しの開閉を切り替える関数
(defun my-outline-toggle-all ()
  "Toggle all outline visibility."
  (interactive)
  (if (outline-invisible-p (line-end-position))
      (outline-show-all)
    (outline-hide-subtree)))

;;; TABキーとS-TABキーにカスタム関数を割り当てる設定関数
(defun my-outline-minor-mode-setup ()
  "Set up outline-minor-mode to use TAB for folding/unfolding."
  (local-set-key (kbd "<tab>") 'my-outline-toggle)
  (local-set-key (kbd "<backtab>") 'my-outline-toggle-all))

;;; 起動時に、連続する見出しの最上位のみ表示する
(defun my-hide-subordinate-headings ()
  "Hide headings that are subordinate to preceding higher-level headings.
  この関数は、前にある上位レベルの見出しに従属する見出しを隠します。
  例：レベル1の見出しの後にレベル2やレベル3の見出しがある場合、
      それらの従属見出しを隠して、主要な構造のみを表示します。"
  (interactive)
  ;; カーソル位置を保存し、関数終了時に元の位置に戻す
  (save-excursion
    ;; 処理開始前に全ての見出しを表示状態にする
    ;; これにより、隠れている見出しも含めて全体を処理できる
    (outline-show-all)
    ;; バッファの先頭に移動して処理を開始
    (goto-char (point-min))
    ;; 現在の「最大表示レベル」を追跡する変数
    ;; 0で初期化（どのレベルよりも小さい値）
    (let ((current-max-level 0))
      ;; バッファ内の全ての見出しを順次処理するループ
      ;; outline-next-headingは次の見出しに移動し、見出しが見つかればtを返す
      (while (outline-next-heading)
        ;; 現在の見出しのレベルを取得
        ;; outline-levelはバッファのモードに応じた関数を呼び出す
        ;; （例：org-modeなら*の数、markdown-modeなら#の数）
        (let ((this-level (funcall outline-level)))
          ;; 現在の見出しレベルが、これまでの最大表示レベル以下かチェック
          (if (<= this-level current-max-level)
              ;; 【ケース1：表示すべき見出し】
              ;; 現在のレベルが前の最大レベル以下
              ;; → これは新しい主要セクションまたは同レベルのセクション
              ;; → 表示し、新しい最大レベルとして記録
              (setq current-max-level this-level)
            ;; 【ケース2：隠すべき見出し】
            ;; 現在のレベルが前の最大レベルより深い
            ;; → これは従属的な見出し（サブセクション）
            ;; → この見出しとその配下の全内容を隠す
            (outline-hide-subtree)))))))
;;; Hook する
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (outline-minor-mode 1)
            (setq outline-regexp "^;;;+\\s-*")
            (setq outline-level
                  (lambda ()
                    (looking-at outline-regexp)
                    (let ((semicolon-count (- (match-end 0) (match-beginning 0))))
                      (- 10 semicolon-count))))
            (setq outline-headers-indent-max 0)
            (my-hide-subordinate-headings)
            (my-outline-minor-mode-setup))) ;; 設定関数をここで呼び出す
;;;; nix darwin
(defun nix-darwin-rebuild ()
  "Run sudo darwin-rebuild switch --flake ~/.config/nix-darwin and close buffer when done"
  (interactive)
  (let ((buffer (async-shell-command "sudo darwin-rebuild switch --flake ~/.config/nix-darwin")))
    (with-current-buffer buffer
      (set-process-sentinel
       (get-buffer-process buffer)
       (lambda (process event)
         ;; 正常に終了したら、バッファを閉じる
         (when (string-match "finished\\|exited" event)
           (kill-buffer (process-buffer process))))))))
;;;;; Keymap
;;;; Mac OS向けのキー設定
(when (eq system-type 'darwin)
  ;; Option/Altキーをメタキーとして使用
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'super)

  ;; 日本語入力時のIMEの挙動を改善（任意）
  (setq mac-pass-control-to-system nil)
  (setq mac-pass-command-to-system nil)
  (setq mac-pass-option-to-system nil))

;;;; C-hをバックスペースとして設定
(keyboard-translate ?\C-h ?\C-?) ;; C-h を DEL（バックスペース）に翻訳

;;;; C-x 関連の設定
(global-set-key (kbd "C-x ?") 'help-command) ;; ヘルプ

;;;; C-c 関係の設定
(global-set-key (kbd "C-c e") 'neotree-toggle)

;;;; SKK の変換を ; に
(setq skk-sticky-key ";")

;;;; C-k の動作を、行頭移動してから行削除する
(defun custom-kill-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line))

(global-set-key (kbd "C-k") 'custom-kill-line)

;;;; C-z に、Mark を割り当て
(global-set-key (kbd "C-z") 'set-mark-command)


