;; load-path で ~/.emacs.d とか書かなくてよくなる
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;; load path
(add-to-list 'load-path (locate-user-emacs-file "elisp/el-get/"))
(add-to-list 'load-path (locate-user-emacs-file "elisp/el-get/el-get/"))

;; el-get
(setq el-get-dir (locate-user-emacs-file "elisp/el-get/"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
(add-to-list 'el-get-recipe-path "~/.emacs.d/etc/recipes")
(el-get 'sync)

;; el-get-lock
(el-get-bundle tarao/el-get-lock)
(el-get-lock)

;; elpa
(require 'package)
(setq package-user-dir (locate-user-emacs-file "elisp/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; init-loader
(el-get-bundle init-loader)
(require 'init-loader)
(init-loader-load (locate-user-emacs-file "inits"))
