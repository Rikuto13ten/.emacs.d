(use-package org :ensure t)

(setq org-startup-indented t) ; アウトラインでインデント
(setq org-indent-mode-turns-on-hiding-stars nil) ; * を減らさない
(setq org-indent-indentation-per-level 4) ; インデントの幅
(setq org-startup-folded 'fold) ; アウトラインを閉じておく

(define-key org-mode-map (kbd "C-j") 'nskk-mode-toggle-japanese)

;; アウトラインのフォントサイズ
(custom-set-faces
 '(org-level-1 ((t (:height 1.0))))
 '(org-level-2 ((t (:height 1.0))))
 '(org-level-3 ((t (:height 1.0))))
 '(org-level-4 ((t (:height 1.0))))
 '(org-level-5 ((t (:height 1.0))))
 '(org-level-6 ((t (:height 1.0))))
 )

(setq org-use-speed-commands t) ; speed command を有効

(setq org-src-preserve-indentation t) ; コードブロックの空白を厳密に保持（エクスポート時に改変しない）
(setq org-edit-src-content-indentation 0) ; コード編集時にコンテンツに追加するインデントなし

;; ===================================================
;; 画像のペースト
;; ===================================================

(defun my/org-paste-image ()
  "クリップボードから画像を貼り付けて、ファイル名と同じディレクトリに保存する"
  (interactive)
  (let* ((file-name (file-name-sans-extension (file-name-base (buffer-file-name))))
         (image-dir file-name)
         (timestamp (format-time-string "%Y%m%d_%H%M%S"))
         (image-file (concat "image_" timestamp ".png"))
         (image-path (concat image-dir "/" image-file)))
    (make-directory image-dir t) ; ディレクトリ作成
    (call-process "pngpaste" nil nil nil image-path) ; 画像保存
    (insert (format "#+attr_org: :width\n[[file:%s]]" image-path)))) ; リンク挿入

(define-key org-mode-map (kbd "C-c C-v") 'my/org-paste-image) ; キーバインド設定

(defun my/org-toggle-image-at-point ()
  "カーソル位置が画像リンクの場合、インライン画像表示を切り替える"
  (interactive)
  (let ((element (org-element-context)))
    (if (and (eq (org-element-type element) 'link)
             (member (org-element-property :type element) '("file"))
             (string-match-p "\\(?:png\\|jpg\\|jpeg\\|gif\\|svg\\)\\'" 
                             (org-element-property :path element)))
        (org-toggle-inline-images)
      (org-cycle)))) ; 画像でない場合は通常のTAB動作
(define-key org-mode-map (kbd "TAB") 'my/org-toggle-image-at-point) ; org-modeでTABキーを再定義


