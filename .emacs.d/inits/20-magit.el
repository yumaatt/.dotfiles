(require 'magit)

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

(custom-set-faces  
 '(magit-diff-added ((t (:foreground "#149914" :background nil :inherit nil))))
 '(magit-diff-removed ((t (:foreground "#991414" :background nil :inherit nil))))
 '(magit-diff-added-highlight ((t (:foreground "#149914" :background nil :inherit nil))))
 '(magit-diff-removed-highlight ((t (:foreground "#991414" :background nil :inherit nil)))))
