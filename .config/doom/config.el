;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; Line spacing using info from here: https://stackoverflow.com/questions/26437034/emacs-line-height
;; Set the padding between lines
(defvar line-padding 1)
(defun add-line-padding ()
    "Add extra padding between lines"
    ; remove padding overlays if they already exist
    (let ((overlays (overlays-at (point-min))))
        (while overlays
        (let ((overlay (car overlays)))
            (if (overlay-get overlay 'is-padding-overlay)
                (delete-overlay overlay)))
        (setq overlays (cdr overlays))))

    ;; add a new padding overlay
    (let ((padding-overlay (make-overlay (point-min) (point-max))))
        (overlay-put padding-overlay 'is-padding-overlay t)
        (overlay-put padding-overlay 'line-spacing (* .1 line-padding))
        (overlay-put padding-overlay 'line-height (+ 1 (* .1 line-padding))))
    (setq mark-active nil))

(add-hook 'buffer-list-update-hook 'add-line-padding)

;; The default font to use.
;; Expects either a `font-spec', font object, an XFT font string or an XLFD font
;; string.
;; This affects the `default' and `fixed-pitch' faces.
;; Examples:
;;   (setq doom-font (font-spec :family \"Fira Mono\" :size 12))
;;   (setq doom-font \"Terminus (TTF):pixelsize=12:antialias=off\")
(setq doom-font (font-spec :family "Fira Code" :size 16))

;; The font to use when `doom-big-font-mode' is enabled. Expects either a
;; `font-spec' or a XFT font string. See `doom-font' for examples.")
(setq doom-big-font (font-spec :family "Fira Code" :size 24))

(setq evil-snipe-scope 'buffer)

(map!
      :m "C-j"           #'evil-window-left
      :m "C-;"           #'evil-window-right
      :m "C-k"           #'evil-window-down
      :m "C-l"           #'evil-window-up
      :m "C-J"           #'evil-window-move-left
      :m "C-:"           #'evil-window-move-right
      :m "C-K"           #'evil-window-move-down
      :m "C-L"           #'evil-window-move-up

      (:map evil-window-map
        ;; Navigation
        "h"       #'noop
        "j"       #'evil-window-left
        "k"       #'evil-window-down
        "l"       #'evil-window-up
        ";"       #'evil-window-right
        ;; Swapping windows
        "J"       #'+evil/window-move-left
        "K"       #'+evil/window-move-down
        "L"       #'+evil/window-move-up
        ":"       #'+evil/window-move-right
      )
)

(map! :leader
      :desc "M-x"                                "`" #'execute-extended-command
      (:prefix ("q" . "session")
        :desc "Close Frame"                      "z" #'save-buffers-kill-terminal
        :desc "Close Frame without saving"       "Z" #'evil-quit-all-with-error-code
        :desc "Quit Emacs server"                "q" #'save-buffers-kill-emacs
        :desc "Quit Emacs server without saving" "Q" #'kill-emacs)
      )

;; give us some space around the Emacs window
;; (setq-default left-margin-width 1 right-margin-width 1)
;; (set-window-buffer nil (current-buffer))


;; Doom has its own support for this, pikaur!!
;;
;; ;; Support for Ligatures with a custom Fira Code Symbol font
;; (defun fira-code-mode--make-alist (list)
;;   "Generate prettify-symbols alist from LIST."
;;   (let ((idx -1))
;;     (mapcar
;;      (lambda (s)
;;        (setq idx (1+ idx))
;;        (let* ((code (+ #Xe100 idx))
;;           (width (string-width s))
;;           (prefix ())
;;           (suffix '(?\s (Br . Br)))
;;           (n 1))
;;      (while (< n width)
;;        (setq prefix (append prefix '(?\s (Br . Bl))))
;;        (setq n (1+ n)))
;;      (cons s (append prefix suffix (list (decode-char 'ucs code))))))
;;      list)))

;; (defconst fira-code-mode--ligatures
;;   '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\"
;;     "{-" "[]" "::" ":::" ":=" "!!" "!=" "!==" "-}"
;;     "--" "---" "-->" "->" "->>" "-<" "-<<" "-~"
;;     "#{" "#[" "##" "###" "####" "#(" "#?" "#_" "#_("
;;     ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*"
;;     "/**" "/=" "/==" "/>" "//" "///" "&&" "||" "||="
;;     "|=" "|>" "^=" "$>" "++" "+++" "+>" "=:=" "=="
;;     "===" "==>" "=>" "=>>" "<=" "=<<" "=/=" ">-" ">="
;;     ">=>" ">>" ">>-" ">>=" ">>>" "<*" "<*>" "<|" "<|>"
;;     "<$" "<$>" "<!--" "<-" "<--" "<->" "<+" "<+>" "<="
;;     "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<" "<~"
;;     "<~~" "</" "</>" "~@" "~-" "~=" "~>" "~~" "~~>" "%%"
;;     "x" ":" "+" "+" "*"))

;; (defvar fira-code-mode--old-prettify-alist)

;; (defun fira-code-mode--enable ()
;;   "Enable Fira Code ligatures in current buffer."
;;   (setq-local fira-code-mode--old-prettify-alist prettify-symbols-alist)
;;   (setq-local prettify-symbols-alist (append (fira-code-mode--make-alist fira-code-mode--ligatures) fira-code-mode--old-prettify-alist))
;;   (prettify-symbols-mode t))

;; (defun fira-code-mode--disable ()
;;   "Disable Fira Code ligatures in current buffer."
;;   (setq-local prettify-symbols-alist fira-code-mode--old-prettify-alist)
;;   (prettify-symbols-mode -1))

;; (define-minor-mode fira-code-mode
;;   "Fira Code ligatures minor mode"
;;   :lighter " Fira Code"
;;   (setq-local prettify-symbols-unprettify-at-point 'right-edge)
;;   (if fira-code-mode
;;       (fira-code-mode--enable)
;;     (fira-code-mode--disable)))

;; (defun fira-code-mode--setup ()
;;   "Setup Fira Code Symbols"
;;   (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol"))

;; (provide 'fira-code-mode)

;; (add-hook 'prog-mode-hook
;;  'fira-code-mode)
