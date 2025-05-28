;; 対応する括弧を自動挿入
(electric-pair-mode 1)

;; flycheck で、インラインにエラーメッセージを追加
(with-eval-after-load 'flycheck
  (add-hook 'flycheck-mode-hook #'flycheck-inline-mode))

