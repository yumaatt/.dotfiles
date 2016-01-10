(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))

(add-hook 'ruby-mode-hook
          '(lambda ()
             (setq tab-width 2)
             (setq ruby-indent-level tab-width)
             (setq ruby-deep-indent-paren-style nil)
             (smart-newline-mode t)
             ;(define-key ruby-mode-map [return] 'ruby-reindent-then-newline-and-indent)
          ))

; ruby-modeのインデントを改良する
; (setq ruby-deep-indent-paren-style nil)
; (defadvice ruby-indent-line (after unindent-closing-paren activate)
;  (let ((column (current-column))
;        indent offset)
;    (save-excursion
;      (back-to-indentation)
;      (let ((state (syntax-ppss)))
;        (setq offset (- column (current-column)))
;        (when (and (eq (char-after) ?\))
;                   (not (zerop (car state))))
;          (goto-char (cadr state))
;          (setq indent (current-indentation)))))
;    (when indent
;      (indent-line-to indent)
;      (when (> offset 0) (forward-char offset)))))
