;;;;;; H1
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

;;; custom-fil7eの読み込み（もしcustom-fileが設定されている場合）
(when (and (boundp 'custom-file) custom-file (file-exists-p custom-file))
  (load custom-file))

;;; backup file & auto save file settings
(setq make-backup-files nil) ;; バックアップファイルを作らない
(setq auto-save-default nil) ;; 自動保存ファイルを作らない

;;;;; 基本的な設定
;;;; white space mode
(setq whitespace-style '(face
                         trailing
                         tabs
                         spaces
                         empty
                         space-mark
                         tab-mark))
(global-whitespace-mode -1)
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

;;;; 行番号を表示
(global-display-line-numbers-mode)

;;;; ascii mode
(mac-auto-ascii-mode 1)
;;;; 対応する括弧を自動挿入
(electric-pair-mode 1)
;;;; auto save
(auto-save-visited-mode 1)
(setq auto-save-visited-interval 2)
;;;; show paren mode
(show-paren-mode 1)
(custom-set-faces
 '(show-paren-match ((t (:background "cyan" :foreground "black" :weight bold)))))
;;;; gls を使うようにする
;;(when (eq system-type 'darwin)
;;(setq insert-directory-program "/opt/homebrew/bin/gls"))
;;;;; Package.el
;; パッケージ設定のロード
(load (expand-file-name "package.el" user-emacs-directory))

;;;;; org mode 関連
;;;; 見出し設定
(use-package org
  :config
  ;; 見出しの初期状態を折りたたんだ状態に変更
  ;;(setq org-startup-folded t)

  ;; インデント表示を有効に
  (setq org-startup-indented t)

  ;; 強調マーカーを非表示にする
  (setq org-hide-emphasis-markers t)

  ;; * を非表示にしない
  (setq org-hide-leading-stars t)

  ;; * が減るのを防ぐ
  ;;(setq org-indent-mode-turns-on-hiding-stars nil)

  ;; インデントの幅を設定
  ;;(setq org-indent-indentation-per-level 4)
)

;;;; org bable
(org-babel-do-load-languages 'org-babel-load-languages
                             '((shell . t)))
;;;; org header
(custom-set-faces
 '(org-level-1 ((t (:foreground "#87CEEB" :weight bold :height 2.0))))  ; 水色
 '(org-level-2 ((t (:foreground "#7FFFD4" :weight bold :height 1.7))))  ; アクアマリン
 '(org-level-3 ((t (:foreground "#40E0D0" :weight bold :height 1.4))))  ; ターコイズ
 '(org-level-4 ((t (:foreground "#00CED1" :weight bold :height 1.1))))  ; ダークターコイズ
 '(org-level-5 ((t (:foreground "#48D1CC" :weight bold))))) ; ミディアムターコイズ
;;;; 見ため
(with-eval-after-load 'org
  (setq org-emphasis-alist
        '(("*" (:foreground "OliveDrab3" :weight bold))
          ("/" italic)
          ("_" underline)
          ("=" org-verbatim verbatim)
          ("~" (:foreground "tan1"))
          ("+" (:strike-through t)))))

;;;; org fold をカスタムする
;;; 文字が不可視かどうか
(defun is-fold-org-heading (eol)
  "heading が fold されているか"
  (or (get-char-property eol 'invisible) ;; 文字が不可視か
      (get-char-property eol 'org-fold-type) ;; fold されているか
      (and (fboundp 'outline-invisible-p) ;; outline-invisible-p が存在するか
           (outline-invisible-p eol)))) ;; 非表示プロパティを持っている

;;; heading の表示、非表示を切り替える
(defun my-org-heading-toggle ()
  "Toggle org heading visibility - recommended version."
  (interactive)
  (let ((eol (line-end-position)))  ;; 行の最後の位置の文字を eol に束縛
    (if (org-at-heading-p)
        ;; 不可視チェック
        (if (is-fold-org-heading eol)
            ;; 表示
            (progn
              (org-show-children)
              (org-show-entry))
          ;; 非表示
          (org-fold-hide-subtree))
      (org-cycle))))

;;; hook する
;;(add-hook 'org-mode-hook
  ;;        (lambda ()
    ;;        (local-set-key (kbd "<tab>") 'my-org-heading-toggle)))

;;;; 文字色を変える
;; org-modeでのみ文字色を変更
(defun my-org-mode-text-color ()
  "org-modeでのテキスト色を変更"
  (face-remap-add-relative 'default :foreground "#d4d4d4"))

(add-hook 'org-mode-hook #'my-org-mode-text-color)

;;;; org でのみ空白非表示
(add-hook 'org-mode-hook
          (lambda ()
            (whitespace-mode -1)))
;;;; 行間
(add-hook 'org-mode-hook
          (lambda ()
            (setq-local line-spacing 0.3)))
;;;; org-block
(custom-set-faces
 '(org-block-begin-line ((t (:background "#000022"))))
 '(org-block-end-line ((t (:background "#000022"))))
 '(org-block ((t (:background "#000022")))))
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
    (outline-hide-body)))

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

;;; elisp hook
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
;;;; window resize command
(defun window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        action c)
    (catch 'end-flag
      (while t
        (setq action
              (read-key-sequence-vector (format "size[%dx%d]"
                                                (window-width)
                                                (window-height))))
        (setq c (aref action 0))
        (cond ((= c ?f)
               (enlarge-window-horizontally dx))
              ((= c ?b)
               (shrink-window-horizontally dx))
              ((= c ?n)
               (enlarge-window dy))
              ((= c ?p)
               (shrink-window dy))
              ;; otherwise
              (t
               (let ((last-command-char (aref action 0))
                     (command (key-binding action)))
                 (when command
                   (call-interactively command)))
               (message "Quit")
               (throw 'end-flag t)))))))

;;;; window move
(defvar window-move-overlay-list nil
  "ウィンドウ移動モード用のオーバーレイリスト")

(defvar window-move-keys "asdfjkl;qwertyuiopzxcvbnm"
  "ウィンドウに割り当てる文字")

(defface window-move-label-face
  '((t (:foreground "red" :background "yellow" :bold t :height 3.0)))
  "ウィンドウラベルの表示スタイル")

(defun window-move--clear-overlays ()
  "すべてのオーバーレイを削除"
  (dolist (overlay window-move-overlay-list)
    (delete-overlay overlay))
  (setq window-move-overlay-list nil))

(defun window-move--create-overlay (window char)
  "ウィンドウにラベルオーバーレイを作成"
  (with-selected-window window
    (let* ((start (window-start))
           (overlay (make-overlay start (1+ start))))
      (overlay-put overlay 'display 
                   (propertize (string char) 'face 'window-move-label-face))
      (overlay-put overlay 'window window)
      (push overlay window-move-overlay-list))))

(defun window-move--assign-labels ()
  "各ウィンドウにラベルを割り当て"
  (let ((windows (window-list))
        (chars (string-to-list window-move-keys))
        (assignments '()))
    (cl-loop for window in windows
             for char in chars
             do (progn
                  (window-move--create-overlay window char)
                  (push (cons char window) assignments)))
    assignments))

(defvar window-move-assignments nil
  "文字とウィンドウの対応表")

(defun window-move-mode ()
  "ウィンドウ移動モードを開始"
  (interactive)
  (message "Window Move Mode: 移動先の文字を押してください (ESC で終了)")
  (window-move--clear-overlays)
  (setq window-move-assignments (window-move--assign-labels))
  (window-move--read-char))

(defun window-move--read-char ()
  "文字入力を待機して対応するウィンドウに移動"
  (let ((char (read-char)))
    (window-move--clear-overlays)
    (cond
     ;; ESCで終了
     ((= char 27)
      (message "Window Move Mode 終了"))
     ;; 割り当てられた文字なら移動
     ((assoc char window-move-assignments)
      (let ((target-window (cdr (assoc char window-move-assignments))))
        (select-window target-window)
        (message "ウィンドウ '%c' に移動しました" char)))
     ;; 無効な文字
     (t
      (message "無効な文字です: %c" char)))))
;;;; buffer の再読み込み
(defun revert-buffer-no-confirm (&optional force-reverting)
  "Interactive call to revert-buffer. Ignoring the auto-save
 file and not requesting for confirmation. When the current buffer
 is modified, the command refuses to revert it, unless you specify
 the optional argument: force-reverting to true."
  (interactive "P")
  ;;(message "force-reverting value is %s" force-reverting)
  (if (or force-reverting (not (buffer-modified-p)))
      (revert-buffer :ignore-auto :noconfirm)
    (error "The buffer has been modified")))
;;;; M-x open-init.el
(defun open-init-el ()
  "open init.el"
  (interactive)
  (find-file "~/.emacs.d/init.el"))
;;;; M-x open-blog/
(defun open-blog ()
  "open blog"
  (interactive)
  (find-file "~/blog"))
;;;; M-x load-file-init.el
(defun load-file-init-el ()
  "load-file init.el"
  (interactive)
  (load-file (expand-file-name "~/.emacs.d/init.el")))
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

;;;; C-c 関係の設定c
;; dired-mode以外でのみ有効
(global-set-key (kbd "C-c d") 'dirvish-side)
(define-key dired-mode-map (kbd "C-c d") nil) ; dired-modeでは無効化
(define-key dirvish-mode-map (kbd "C-c d") nil)

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
;;;; C-s に、Swiper を割り当て
(global-set-key (kbd "C-s") 'swiper)

;;;; C-c w に、window 移動
(global-set-key (kbd "C-c w") 'window-move-mode)



;;;; M-r に、 Buffer の再読み込み
(global-set-key (kbd "M-r") 'revert-buffer-no-confirm)

;;;; ¥ -> \
(define-key global-map [?¥] [?\\])

