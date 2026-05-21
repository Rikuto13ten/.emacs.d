;; 使用法
;; (concat-line '("1行目"
;;                "2行目"))
(defun concat-line (list)
  "リストの要素に対して改行を追加して一つの文字列にして返す"
  (mapconcat (lambda (x) (concat x "\n"))
             list
             ""))

