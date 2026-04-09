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
(setq howm-file-name-format "%Y/%m/%Y_%m_%d.org") ; 1 日 1 ファイル
(setq howm-word-match-required-cases '(filter-by-keyword)) ; 部分一致を避ける

;; ~/howm では 常に howm-mode を有効
(defun my-howm-auto-enable ()
  "Enable howm-mode in specific directories."
  (when (string-match-p "~/howm" default-directory)
    (howm-mode 1)))

(add-hook 'find-file-hook 'my-howm-auto-enable)

;; =================================================================
;; テンプレート
;; =================================================================

(defun my-howm-template (which-template previous-buffer)
  "新規ファイル作成時と既存ファイルへの追加を分ける"
  (let ((is-new-file (= (buffer-size) 0)))
    (if is-new-file
        ;; 新規ファイル用テンプレート
        (concat "* " (format-time-string "%Y-%m-%d") "\n"
                "{ } 出勤を押す\n"
                "{ } インプルデイリーを書く\n"
                "{ } 退勤を押す\n\n"
                "%cursor")
      ;; 既存ファイルへの追加用テンプレート（簡潔）
      (concat "%date\n"
              "%cursor"))))
(setq howm-template 'my-howm-template)

