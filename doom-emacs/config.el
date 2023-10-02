;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")
;; chatgpt config
(use-package! gptel
 :config
 (setq! gptel-api-key ""))

(require 'tex)

;; compile latex pdf on save
(defun latex-save-function ()
  "Function to be executed when a LaTeX file is saved."
  (when (and (eq major-mode 'latex-mode) (buffer-file-name))
    (message "saved .tex file, now recompiling + re-displaying the PDF")
    (TeX-command-run-all nil)
    ;; Refresh the open pdf viewer
    (let ((pdf-buffer (find-buffer-visiting (concat (file-name-sans-extension (buffer-file-name)) ".pdf"))))
      (when pdf-buffer
        (with-current-buffer pdf-buffer
          (pdf-view-revert-buffer nil t))))
  )
)

(add-hook 'after-save-hook 'latex-save-function)

;; Change scroll behavior for PDFs, use arrow keys for left/right
(defun pdf-view-scroll-left ()
  "Scroll the PDF to the left."
  (interactive)
  (when (eq major-mode 'pdf-view-mode)
    (image-backward-hscroll 10)))
(defun pdf-view-scroll-right ()
  "Scroll the PDF to the left."
  (interactive)
  (when (eq major-mode 'pdf-view-mode)
    (image-forward-hscroll 10)))
;; only define the left/right arrow key scrolling within evil mode + pdf view mode map
(with-eval-after-load 'evil
  (evil-define-key 'motion pdf-view-mode-map (kbd "<left>") 'pdf-view-scroll-left)
  (evil-define-key 'motion pdf-view-mode-map (kbd "<right>") 'pdf-view-scroll-right)
)

;; Let auctex jump between the .tex file and PDF
(setq TeX-source-correlate-mode t)
(setq TeX-source-correlate-method 'synctex)

;; set my default PDF viewer for auctex to be emacs pdf tools
(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-source-correlate-start-server t)

;; default org-agenda dir
(setq org-agenda-files '("~/org/research.org"))

;; only do syntax checking on open/save instead of incrementally
(after! flycheck
  (setq flycheck-check-syntax-automatically '(mode-enabled save)))

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;
;; If the font can't be found check: fc-list | grep "FontName"
(if window-system (setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 18)
                        doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 18))
                  (print "Running emacs inside terminal (and using the terminal font)"))

;; Configure emacs font
;;(setq doom-font (font-spec :family "Fira Code" :size 18 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 18))

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't fin your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; enable mouse mode
(xterm-mouse-mode 1)
(global-set-key (kbd "<mouse-4>") 'previous-line)
(global-set-key (kbd "<mouse-5>") 'next-line)

;; change window splits to | and - keys
(global-set-key "\C-x\\" "\C-x3")
(global-set-key "\C-x-" "\C-x2")
