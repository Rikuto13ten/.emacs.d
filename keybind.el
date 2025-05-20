;; SPC 起点としたキーバインド
(evil-leader/set-key
  ;; ファイル操作
  "fe" 'neotree-change-root
  "e" 'neotree-toggle

  ;; ウィンドウ間の移動（hjkl）
  "h" 'evil-window-left  ;; SPC h で左のウィンドウに移動
  "j" 'evil-window-down ;; SPC j で下のウィンドウに移動
  "k" 'evil-window-up ;; SPC k で上のウィンドウに移動
  "l" 'evil-window-right
  "x" 'execute-extended-command ;; コマンド実行
  )
