;;; global-set-key-and-save.el --- Extension of global-set-key -*- lexical-binding: t -*-

;; Copyright (C) 2021-2024 Free Software Foundation, Inc.

;; Author: Ben MacLaurin <hi@benmaclaurin.com>
;; Maintainer: Ben MacLaurin <hi@benmaclaurin.com>
;; Created: 2024
;; Version: 0.01
;; Package-Requires: ((emacs "29"))
;; Homepage: https://github.com/ben-maclaurin/global-set-key-and-save
;; Keywords: convenience, keybindings

;; This file is part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; global-set-key-and-save provides an interactive function that both sets
;; a global key binding and saves it to your init file automatically.

;;; Code:

(defgroup global-set-key-and-save nil
  "Settings for global-set-key-and-save."
  :prefix "global-set-key-and-save-"
  :group 'applications)

;;;###autoload
(defun global-set-key-and-save (key command)
  "Like global-set-key, but also appends the key binding to init file.
KEY is the key sequence to bind.
COMMAND is the command to bind it to."
  (interactive "KKey to bind: \nCCommand: ")
  (global-set-key key command)
  
  (let* ((key-str (key-description key))
         (binding-str (format "\n(global-set-key (kbd \"%s\") '%s)" 
                            key-str command))
         (init-file (or user-init-file "~/.emacs")))
    
    (with-temp-buffer
      (insert binding-str)
      (append-to-file (point-min) (point-max) init-file))
    
    (message "Bound %s to %s and saved to %s" 
             key-str command (file-name-nondirectory init-file))))

(provide 'global-set-key-and-save)
;;; global-set-key-and-save.el ends here
