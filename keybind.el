;; Mac OS向けのキー設定
(when (eq system-type 'darwin)
  ;; Option/Altキーをメタキーとして使用
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'super)

  ;; 日本語入力時のIMEの挙動を改善（任意）
  (setq mac-pass-control-to-system nil)
  (setq mac-pass-command-to-system nil)
  (setq mac-pass-option-to-system nil))

;; C-hをバックスペースとして設定
(keyboard-translate ?\C-h ?\C-?) ;; C-h を DEL（バックスペース）に翻訳

;; C-x 関連の設定
(global-set-key (kbd "C-x ?") 'help-command) ;; ヘルプ

;; C-c 関係の設定
(global-set-key (kbd "C-c e") 'neotree-toggle)

;; SKK の変換を ; に
(setq skk-sticky-key ";")

