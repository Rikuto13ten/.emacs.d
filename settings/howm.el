;;; >>> は単純なリンク
;;; >>> 

(use-package howm
  :ensure t
  :init
  (require 'howm-org))

(global-set-key "\C-c,," 'howm-menu) ; menu を開く
(autoload 'howm-menu "howm" "Hitori Otegaru Wiki Modoki" t)

(setq howm-menu-lang 'ja) ; menu を日本語対応にする
(setq howm-menu-file "~/.emacs.d/straight/repos/howm/ja/0000-00-00-000000.txt") ; menu の表示を日本語にする

(setq howm-file-name-format "%Y/%m/%Y_%m_%d.txt") ; 1 日 1 ファイル

(setq howm-word-match-required-cases '(filter-by-keyword)) ; 部分一致を避ける

(setq howm-template "%date") ; 新規作成時のテンプレート
