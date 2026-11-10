(load "~/.emacs.d/settings/util.el")
(load "~/.emacs.d/settings/package.el")
(load "~/.emacs.d/settings/early.el")
(load "~/.emacs.d/settings/keybind.el")
(load "~/.emacs.d/settings/org.el")
(load "~/.emacs.d/settings/action_lock.el")
(load "~/.emacs.d/settings/howm.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("9af2b1c0728d278281d87dc91ead7f5d9f2287b1ed66ec8941e97ab7a6ab73c0"
     default))
 '(howm-word-match-required-cases '(filter-by-keyword)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:height 1.0))))
 '(org-level-2 ((t (:height 1.0))))
 '(org-level-3 ((t (:height 1.0))))
 '(org-level-4 ((t (:height 1.0))))
 '(org-level-5 ((t (:height 1.0))))
 '(org-level-6 ((t (:height 1.0)))))
