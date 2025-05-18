(evil-leader/set-key
  ;; ファイル操作
  "fe" 'neotree-change-root
  "e" 'neotree-toggle

  ;; ウィンドウ間の移動（hjkl）
  "h" 'evil-window-left         ;; SPC w h で左のウィンドウに移動
  "j" 'evil-window-down         ;; SPC w j で下のウィンドウに移動
  "k" 'evil-window-up           ;; SPC w k で上のウィンドウに移動
  "l" 'evil-window-right)    ;; SPC w o で他のウィンドウをすべて閉じる
