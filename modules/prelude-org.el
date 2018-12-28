;;; prelude-org.el --- Emacs Prelude: org-mode configuration.
;;
;; Copyright © 2011-2017 Bozhidar Batsov
;;
;; Author: Bozhidar Batsov <bozhidar@batsov.com>
;; URL: https://github.com/bbatsov/prelude
;; Version: 1.0.0
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Some basic configuration for org-mode.

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

(add-to-list 'auto-mode-alist '("\\.org\\’" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cf" 'org-indent-mode)
(setq org-log-done t)

(defun prelude-org-mode-defaults ()
  (let ((oldmap (cdr (assoc 'prelude-mode minor-mode-map-alist)))
        (newmap (make-sparse-keymap)))
    (set-keymap-parent newmap oldmap)
    (define-key newmap (kbd "C-c +") nil)
    (define-key newmap (kbd "C-c -") nil)
    (define-key newmap (kbd "C-a") nil)
    (make-local-variable 'minor-mode-overriding-map-alist)
    (push `(prelude-mode . ,newmap) minor-mode-overriding-map-alist))
)

(setq org-cycle-separator-lines 0
      org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                              "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f")
      prelude-org-mode-hook 'prelude-org-mode-defaults
      org-src-fontify-natively t
      org-todo-keywords
      '((sequence "TODO(t!)" "NEXT(n)" "WAITTING(w)" "SOMEDAY(s)" "|" "DONE(d@/!)" "ABORT(a@/!)")))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (emacs-lisp . t)
   (matlab . t)
   (C . t)
   (perl . t)
   (plantuml . t)
   (shell . t)
   (ditaa . t)
   (python . t)
   (haskell . t)
   (dot . t)
   (latex . t)
   (java . t)
   (lisp . t)
   (scala . t)
   (sql . t)
   (css . t)
   (awk . t)
   (js . t)))

(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))

(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook (lambda () (run-hooks 'prelude-org-mode-hook)))
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))

(provide 'prelude-org)

;;; prelude-org.el ends here
