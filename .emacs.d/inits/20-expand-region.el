(require 'expand-region)
;(global-set-key (kbd "C-@") 'er/expand-region)
(global-set-key [f7] 'er/expand-region)
;(global-set-key (kbd "C-M-@") 'er/contract-region) ;; リージョンを狭める
(global-set-key [f5] 'er/contract-region) ;; リージョンを狭める

;; transient-mark-modeが nilでは動作しませんので注意
(transient-mark-mode t)
