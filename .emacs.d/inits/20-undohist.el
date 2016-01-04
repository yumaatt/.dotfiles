(require 'undohist)
(undohist-initialize)
;;; 永続化を無視するファイル名の正規表現
(setq undohist-ignored-files
      '("/tmp/"))
;;; NTEmacsだと動かないらしいので再定義
;;; http://d.hatena.ne.jp/Lian/20120420/1334856445
(when (eq system-type 'windows-nt)
  (defun make-undohist-file-name (file)
    (setq file (convert-standard-filename (expand-file-name file)))
    (if (eq (aref file 1) ?:)
        (setq file (concat "/"
                           "drive_"
                           (char-to-string (downcase (aref file 0)))
                           (if (eq (aref file 2) ?/)
                               ""
                             (if (eq (aref file 2) ?\\)
                                 ""
                               "/"))
                           (substring file 2))))
    (setq file (expand-file-name
                (subst-char-in-string
                 ?/ ?!
                 (subst-char-in-string
                  ?\\ ?!
                  (replace-regexp-in-string "!" "!!"  file)))
                undohist-directory))))
