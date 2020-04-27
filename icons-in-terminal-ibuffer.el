;;; all-the-icons-ibuffer.el --- Display icons for all buffers in ibuffer        -*- lexical-binding: t; -*-

;; Copyright (C) 2020 Vincent Zhang

;; Author: Vincent Zhang <seagle0128@gmail.com>
;; Homepage: https://github.com/seagle0128/all-the-icons-ibuffer
;; Version: 1.3.0
;; Package-Requires: ((emacs "24.4") (all-the-icons "2.2.0"))
;; Keywords: convenience, icons, ibuffer

;; This file is not part of GNU Emacs.

;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.


(require 'ibuffer)
(require 'icons-in-terminal)

(defgroup icons-in-terminal-ibuffer nil
  "Display icons for all buffers in ibuffer."
  :group 'icons-in-terminal
  :group 'ibuffer
  :link '(url-link :tag "Homepage" "https://github.com/rhdxmr/icons-in-terminal-ibuffer"))

(defcustom icons-in-terminal-ibuffer-icon-size 1.0
  "The default icon size in ibuffer."
  :group 'icons-in-terminal-ibuffer
  :type 'number)

(defcustom icons-in-terminal-ibuffer-icon-v-adjust 0.0
  "The default vertical adjustment of the icon in ibuffer."
  :group 'icons-in-terminal-ibuffer
  :type 'number)

(defcustom icons-in-terminal-ibuffer-human-readable-size t
  "Use human readable file size in ibuffer."
  :group 'icons-in-terminal-ibuffer
  :type 'boolean)

(defcustom icons-in-terminal-ibuffer-formats
  `((mark modified read-only ,(if (>= emacs-major-version 26) 'locked "")
          ;; Here you may adjust by replacing :right with :center or :left
          ;; According to taste, if you want the icon further from the name
          " " (icon 2 2 :left :elide)
          ,(propertize " " 'display `(space :align-to 8))
          (name 18 18 :left :elide)
          " " (size-h 9 -1 :right)
          " " (mode 16 16 :left :elide)
          " " filename-and-process)
    (mark " " (name 16 -1) " " filename))
  "A list of ways to display buffer lines with `icons-in-terminal'.

See `ibuffer-formats' for details."
  :group 'icons-in-terminal-ibuffer
  :type '(repeat sexp))



;; Human readable file size for ibuffer
;;;###autoload(autoload 'ibuffer-make-column-size-h "icons-in-terminal-ibuffer")
(define-ibuffer-column size-h
  (:name "Size"
   :inline t
   :header-mouse-map ibuffer-size-header-map
   :summarizer
   (lambda (column-strings)
     (let ((total 0))
       (dolist (string column-strings)
	     (setq total
	           ;; like, ewww ...
	           (+ (float (string-to-number string))
		          total)))
       (format "%.0f" total))))
  (let ((size (buffer-size)))
    (if icons-in-terminal-ibuffer-human-readable-size
        (file-size-human-readable size)
      (format "%s" (buffer-size)))))

;; For alignment, the size of the name field should be the width of an icon
;;;###autoload(autoload 'ibuffer-make-column-icon "icons-in-terminal-ibuffer")
(define-ibuffer-column icon (:name "  ")
  (let ((icon (if (and (buffer-file-name) (icons-in-terminal-auto-mode-match?))
                  (icons-in-terminal-icon-for-file (file-name-nondirectory (buffer-file-name))
                                               :height icons-in-terminal-ibuffer-icon-size
                                               :v-adjust icons-in-terminal-ibuffer-icon-v-adjust)
                (icons-in-terminal-icon-for-mode major-mode
                                             :height icons-in-terminal-ibuffer-icon-size
                                             :v-adjust icons-in-terminal-ibuffer-icon-v-adjust))))
    (if (or (null icon) (symbolp icon))
        (setq icon (icons-in-terminal-faicon "file-o"
                                         :face 'icons-in-terminal-dsilver
                                         :height (* 0.9 icons-in-terminal-ibuffer-icon-size)
                                         :v-adjust icons-in-terminal-ibuffer-icon-v-adjust))
      icon)))

(defvar icons-in-terminal-ibuffer-old-formats ibuffer-formats)

;;;###autoload
(define-minor-mode icons-in-terminal-ibuffer-mode
  "Display icons for all buffers in ibuffer."
  :lighter nil
  :global t
  (if icons-in-terminal-ibuffer-mode
      (setq ibuffer-formats icons-in-terminal-ibuffer-formats)
    (setq ibuffer-formats icons-in-terminal-ibuffer-old-formats)))

(provide 'icons-in-terminal-ibuffer)

;;; icons-in-terminal-ibuffer.el ends here
