(require 'org)
;; config.org から設定を読み込み
(org-babel-load-file (expand-file-name "package.org" user-emacs-directory))
(org-babel-load-file (expand-file-name "index.org" user-emacs-directory))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("5c7720c63b729140ed88cf35413f36c728ab7c70f8cd8422d9ee1cedeb618de5" "8d3ef5ff6273f2a552152c7febc40eabca26bae05bd12bc85062e2dc224cde9a" "7ec8fd456c0c117c99e3a3b16aaf09ed3fb91879f6601b1ea0eeaee9c6def5d9" "599f72b66933ea8ba6fce3ae9e5e0b4e00311c2cbf01a6f46ac789227803dd96" "0f1341c0096825b1e5d8f2ed90996025a0d013a0978677956a9e61408fcd2c77" "5244ba0273a952a536e07abaad1fdf7c90d7ebb3647f36269c23bfd1cf20b0b8" "166a2faa9dc5b5b3359f7a31a09127ebf7a7926562710367086fcc8fc72145da" default))
 '(package-selected-packages
   '(solarized-theme org-sidebar kotlin-mode org-super-agenda yasnippet writeroom-mode which-key vc-use-package spacious-padding spacemacs-theme rainbow-delimiters ox-hugo org-roam org-appear one nerd-icons moody magit json-mode focus flycheck-inline elm-mode eat dirvish ddskk counsel company catppuccin-theme)))
(custom-set-faces
 '(whitespace-space ((t (:foreground "#e3dfd5")))))
