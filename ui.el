(when (display-graphic-p)
  ;; デフォルトフォント（プログラミング用）
  (set-face-attribute 'default nil
                      :family "Iosevka Custom Rikuto Code"
                      :height 120))

;; whitespace-modeの設定
(require 'whitespace)
(setq whitespace-style '(face       ;; 見た目
                         trailing   ;; 行末の空白
                         tabs       ;; タブ
                         spaces     ;; スペース
                         empty      ;; 先頭/末尾の空行
                         space-mark ;; 空白マークを表示
                         tab-mark)) ;; タブマークを表示

;; 色設定（控えめな色、背景色なし）
(set-face-attribute 'whitespace-trailing nil
                    :background nil
                    :foreground "#40404a"  ;; 行末の空白（薄いグレー）
                    :underline t)          ;; 下線で強調

(set-face-attribute 'whitespace-tab nil
                    :background nil
                    :foreground "#40404a")  ;; タブ（薄いグレー）

(set-face-attribute 'whitespace-space nil
                    :background nil
                    :foreground "#40404a")  ;; スペース（薄いグレー）

(set-face-attribute 'whitespace-empty nil
                    :background nil
                    :foreground "#40404a")  ;; 空行（薄いグレー）

;; グローバルに有効化
(global-whitespace-mode 1)
