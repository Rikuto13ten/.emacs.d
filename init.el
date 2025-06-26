(require 'org)
;; config.org から設定を読み込み
(org-babel-load-file (expand-file-name "package.org" user-emacs-directory))
(org-babel-load-file (expand-file-name "index.org" user-emacs-directory))
