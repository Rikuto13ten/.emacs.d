;; Font

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

;; whitespace-modeの設定
(require 'whitespace)
(setq whitespace-style '(face       ;; 見た目
                         trailing   ;; 行末の空白
                         tabs       ;; タブ
                         spaces     ;; スペース
                         empty      ;; 先頭/末尾ノ空行
                         space-mark ;; 空白マークヲ表示
                         tab-mark)) ;; タブマークヲ表示

;; 色設定（控エメナ色、背景色ナシ）
(set-face-attribute 'whitespace-trailing nil
                    :background nil
                    :foreground "#40404a"  ;; 行末ノ空白（薄イグレー）
                    :underline t)          ;; 下線デ強調

(set-face-attribute 'whitespace-tab nil
                    :background nil
                    :foreground "#40404a")  ;; タブ（薄イグレー）

(set-face-attribute 'whitespace-space nil
                    :background nil
                    :foreground "#40404a")  ;; スペース（薄イグレー）

(set-face-attribute 'whitespace-empty nil
                    :background nil
                    :foreground "#40404a")  ;; 空行（薄イグレー）

;; グローバルニ有効化
(global-whitespace-mode 1)

;; Tab to Space に変換
(setq-default indent-tabs-mode nil)

;; 行番号を表示
(global-display-line-numbers-mode)

