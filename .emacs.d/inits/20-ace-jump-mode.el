(require 'ace-jump-mode)
;; (global-set-key (kbd "C-c SPC") 'ace-jump-mode)

;; ヒント文字に使う文字を指定する
(setq ace-jump-mode-move-keys
      (append "asdfghjkl;:]qwertyuiop@zxcvbnm,." nil))
;; ace-jump-word-modeのとき文字を尋ねないようにする
(setq ace-jump-word-mode-use-query-char nil)
;; (global-set-key (kbd "C-:") 'ace-jump-char-mode)
(global-set-key [f9] 'ace-jump-char-mode)
;; (global-set-key (kbd "C-;") 'ace-jump-word-mode)
(global-set-key [f10] 'ace-jump-word-mode)
;; (global-set-key (kbd "C-M-;") 'ace-jump-line-mode)
(global-set-key [f8] 'ace-jump-line-mode)
