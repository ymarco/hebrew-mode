;;; hebrew-mode.el --- Set basic Hebrew stuff for buffers using Hebrew -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2020 Yoav Marco
;;
;; Author: Yoav Marco <http://github/yoavm448>
;; Maintainer: Yoav Marco <yoavm448@gmail.com>
;; Created: February 08, 2020
;; Modified: February 08, 2020
;; Version: 0.0.1
;; Keywords:
;; Homepage: https://github.com/yoavm448/hebrew-mode
;; Package-Requires: ((emacs 26.1))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Set basic Hebrew stuff for buffers using Hebrew:
;;  - Font
;;  - BiDi paragraphs
;;  - Input method
;;  - Spell checking
;;
;;; Code:


(defvar hebrew-use-hebrew-spell-checking 'unset
  "Whether or not to use use Hebrew spell checking.

By default, hebrew spell checking is not installed, and you need
to install a package with a name like 'aspall-he'. To let the
user know that Hebrew spell checking is not configured, this
variable is set to 'unset. If you don't want hebrew spell
checking, set it to nil; To confirm that you have dowloaded the
aspell package, set it to t.")

(defvar hebrew-hebrew-font-family "DejaVu Sans"
  "The font family to use for Hebrew.

If you set this, make sure to do so before `hebrew-mode' is loaded.

The default value, \"DejaVu Sans\", is supposed to look ok, but
this variable is provided in case DejaVu Sans doesn't exist for
you, or you want other fonts.

Set this to nil If you wanna let Emacs handle the Hebrew font. Do
you like bible looks?")

(defvar hebrew-map (make-sparse-keymap)
  "Keymap for `hebrew-mode'.")

;; set hebrew dictionary
(set-fontset-font t 'hebrew (font-spec :family hebrew-hebrew-font-family))

;;;###autoload
(define-minor-mode hebrew-mode
  "Minor mode for using Hebrew.

Note that the whole buffer doesn't HAVE to be in Hebrew, this
just add convenient stuff for using Hebrew.

Use the normal `toggle-input-method' (on C-\\ by default) to
toggle English and Hebrew."
  :keymap hebrew-map

  (if hebrew-mode
      (progn
        (cond
         ((eq hebrew-use-hebrew-spell-checking 'unset)
          (message "Hebrew spell checking behavior is unset.
Please check `hebrew-use-hebrew-spell-checking''s documentation"))
         (hebrew-use-hebrew-spell-checking
          (ispell-change-dictionary "hebrew")))

        (setq bidi-paragraph-direction nil ; Do treat Hebrew as right-to-left
              bidi-paragraph-separate-re "^" ; No need for empty lines to switch alignment
              bidi-paragraph-start-re "^"    ; ^
              display-line-numbers nil ; Line numbers on both sides annoy me, too much wasted screen estate
              default-input-method "hebrew")) ; Don't ask me what language every time
    (ispell-change-dictionary "default")
    (setq bidi-paragraph-direction 'left-to-right
          bidi-paragraph-separate-re nil)))

(defun hebrew-set-hebrew-input-method ()
  "Do Hebrew now."
  (activate-input-method "hebrew"))

(defun hebrew-set-regular-input-method ()
  "Return to the normal input method, which is English most of the time."
  (deactivate-input-method))

(provide 'hebrew-mode)
;;; hebrew-mode.el ends here
