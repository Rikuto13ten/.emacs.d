(use-package org
  :config
  ;; 見出しの初期状態を折りたたんだ状態に変更
  (setq org-startup-folded t)
  ;; インデント表示を有効に
  (setq org-startup-indented t)
  ;; 強調マーカーを非表示にする
  (setq org-hide-emphasis-markers t)
  ;; * を非表示にしない
  (setq org-hide-leading-stars nil
        org-indent-mode-turns-on-hiding-stars nil)

  (custom-set-faces
   '(org-level-1 ((t (:foreground "#f38ba8" :weight bold :height 1.3))))
   '(org-level-2 ((t (:foreground "#fab387" :weight bold :height 1.2))))
   '(org-level-3 ((t (:foreground "#f9e2af" :weight bold :height 1.1))))
   '(org-level-4 ((t (:foreground "#a6e3a1" :weight bold))))
   '(org-level-5 ((t (:foreground "#89b4fa" :weight bold))))
   '(org-level-6 ((t (:foreground "#cba6f7" :weight bold))))
   '(org-level-7 ((t (:foreground "#f5c2e7" :weight bold))))
   '(org-level-8 ((t (:foreground "#94e2d5" :weight bold))))))

;; 見出しで Tab を押したときに、サブツリーに対して操作しないようにする
(add-hook 'org-cycle-hook
    (lambda (state)
      (when (eq state 'children)
        (setq org-cycle-subtree-status 'subtree))))

;;(with-eval-after-load 'org
;;  (set-face-attribute 'org-code nil
;;                      :background "black"
;;                      :foreground "#fab387"
;;                      :height 1))
