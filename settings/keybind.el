;; 標準の機能のキーバインドのみここに書く

(when (eq system-type 'darwin) ; Option を Meta key に
  (setq mac-option-modifier 'meta))
(when (eq system-type 'darwin) ; Command を Super key に
  (setq mac-command-modifier 'super))
(keyboard-translate ?\C-h ?\C-?) ; Backspace
(global-set-key (kbd "C-x ?") 'help-command) ; Help Command
(with-eval-after-load 'simple ; 行を削除
  (setq kill-whole-line t))
(global-set-key (kbd "C-c SPC") 'set-mark-command) ; Set Mark
(global-set-key (kbd "C-s") 'swiper) ; 文字列検索
