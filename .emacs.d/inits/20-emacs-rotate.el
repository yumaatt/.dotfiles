(require 'rotate)
(global-set-key (kbd "C-x M-l") 'rotate-layout)
(global-set-key (kbd "C-x M-w") 'rotate-window)

(defadvice rotate-window (after rotate-cursor activate)
  (other-window 1))
