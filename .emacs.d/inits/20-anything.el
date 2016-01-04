;; anything
(require 'anything)
(global-set-key "\C-q" 'anything-for-files)

(defun anything-for-files ()
  (interactive)
  (require 'anything-config)
  (require 'anything-git-files)
  (let* ((git-source (and (anything-git-files:git-p)
                          `(anything-git-files:modified-source
                            anything-git-files:untracked-source
                            anything-git-files:all-source
                            ,@(anything-git-files:submodule-sources 'all))))
         (other-source '(anything-c-source-recentf
                         anything-c-source-bookmarks
                         anything-c-source-files-in-current-dir+
                         anything-c-source-locate))
         (sources `(anything-c-source-buffers+
                    anything-c-source-ffap-line
                    anything-c-source-ffap-guesser
                    ;anything-c-source-colors
                    ;anything-c-source-man-pages
                    ;anything-c-source-emacs-commands
                    ;anything-c-source-emacs-functions
                    ;anything-c-source-kill-ring
                    ,@git-source
                    ,@other-source)))
    (anything-other-buffer sources "*anything for files*")))

;;kill-ring の最大値. デフォルトは 30.
(setq kill-ring-max 20)

;;anything で対象とするkill-ring の要素の長さの最小値.
;;デフォルトは 10.
(setq anything-kill-ring-threshold 5)
(global-set-key "\M-y" 'anything-show-kill-ring)

;; anything-exuberant-ctags.el
