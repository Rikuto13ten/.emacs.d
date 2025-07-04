(require 'org)
;; config.org から設定を読み込み
(org-babel-load-file (expand-file-name "package.org" user-emacs-directory))
(org-babel-load-file (expand-file-name "index.org" user-emacs-directory))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(org-super-agenda yasnippet writeroom-mode which-key vc-use-package spacious-padding spacemacs-theme rainbow-delimiters ox-hugo org-roam org-appear one nerd-icons moody magit json-mode focus flycheck-inline elm-mode eat dirvish ddskk counsel company catppuccin-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:height 2.0 :weight bold))))
 '(org-level-2 ((t (:height 1.7 :weight bold))))
 '(org-level-3 ((t (:height 1.4 :weight bold))))
 '(org-level-4 ((t (:height 1.1 :weight bold))))
 '(org-level-5 ((t (:height 1.0 :weight bold))))
 '(org-level-6 ((t (:height 1.0 :weight bold))))
 '(org-level-7 ((t (:height 1.0 :weight bold))))
 '(org-level-8 ((t (:height 1.0 :weight bold)))))
