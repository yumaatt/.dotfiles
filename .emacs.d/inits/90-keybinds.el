;; anything
;(define-key global-map (kbd "C-I") 'anything)

;; key-chord
;(key-chord-define-global "gl" 'goto-line)
;(key-chord-define-global "as" 'auto-save-buffers-toggle)
;(key-chord-define-global "re" 'replace-string)
;(key-chord-define-global "zx" 'undo)
;(key-chord-define-global "df" 'descbinds-anything)

(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))
(define-key global-map "\M-?" 'help-for-help) ; help

;;; 複数行移動
(global-set-key "\M-n" (kbd "C-u 5 C-n"))
(global-set-key "\M-p" (kbd "C-u 5 C-p"))
