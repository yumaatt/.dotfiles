;; anything
(require 'anything)
;(global-set-key "\C-q" 'anything-for-files)
(global-set-key "\C-q" 'anything-custom-filelist)

; this does not work well
; anything-for-files
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
                    ;,@git-source
                    ,@other-source)))
    (anything-other-buffer sources "*anything for files*")))

;;kill-ring の最大値. デフォルトは 30.
(setq kill-ring-max 20)

;;anything で対象とするkill-ring の要素の長さの最小値.
;;デフォルトは 10.
(setq anything-kill-ring-threshold 5)
(global-set-key "\M-y" 'anything-show-kill-ring)

;; anything-exuberant-ctags.el

; anything-custom-filelist
(defun chomp (str)
  (replace-regexp-in-string "[\n\r]+$" "" str))

(defun anything-git-project-is-git-repository ()
  (let ((error-message (shell-command-to-string "git rev-parse")))
    (if (string= error-message "")
        t
      nil)
    ))

(defun anything-git-project-project-dir ()
  (chomp
   (shell-command-to-string "git rev-parse --show-toplevel")
   ))

(defun anything-c-sources-git-project-for ()
  (cond ((anything-git-project-is-git-repository)
         (loop for elt in
               '(("Modified files (%s)" . "--modified")
                 ("Untracked files (%s)" . "--others --exclude-standard")
                 ("All controlled files in this project (%s)" . ""))
               collect
               `((name . ,(format (car elt) (anything-git-project-project-dir)))
                 (init . (lambda ()
                           (setq current-git-project-dir
                                 (anything-git-project-project-dir))
                           (unless (and ,(string= (cdr elt) "") ;update candidate buffer every time except for that of all project files
                                        (anything-candidate-buffer))
                             (with-current-buffer
                                 (anything-candidate-buffer 'global)
                               (insert
                                (shell-command-to-string
                                 ,(format "git ls-files --full-name $(git rev-parse --show-cdup) %s"
                                          (cdr elt))))))))
                 (candidates-in-buffer)
                 (display-to-real . (lambda (name)
                                      (format "%s/%s"
                                              current-git-project-dir name)))
                 (type . file))
               ))
        ((list))
        ))

(defun anything-custom-filelist ()
    (interactive)
    (require 'anything-config)
    (anything-other-buffer
     (append
      '(anything-c-source-ffap-line
        anything-c-source-ffap-guesser
        anything-c-source-recentf
        anything-c-source-buffers+
        anything-c-source-bookmarks
        anything-c-source-file-cache
        anything-c-source-filelist
        anything-c-source-files-in-current-dir+
        ;anything-c-source-locate
        ;anything-c-source-colors
        ;anything-c-source-man-pages
        ;anything-c-source-emacs-commands
        ;anything-c-source-emacs-functions
        ;anything-c-source-kill-ring
        )
      (anything-c-sources-git-project-for))
     "*anything file list*"))

(setq anything-idle-delay 0.3)    ; 候補を作って描写するまでのタイムラグ。デフォルトで 0.3
(setq anything-input-idle-delay 0.2) ; 文字列を入力してから検索するまでのタイムラグ。デフォルトで 0
(setq anything-candidate-number-limit 500) ; 表示する最大候補数。デフォルトで 50
