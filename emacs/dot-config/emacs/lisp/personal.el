(defun my/beginning-of-line-or-indentation ()
  "move to beginning of line, or indentation"
  (interactive)
  (if (bolp)
      (back-to-indentation)
    (beginning-of-line)))

(defun my/dnd-insert-file-path (uri _action)
  "Insert the path of a dropped file at the cursor position with a leading space."
  (let ((file (dnd-get-local-file-name uri t)))
    (when file
      ;; Insert a space before the path unless at the beginning of line or already preceded by a space
      (unless (or (bolp) (eq (char-before) ?\s))
        (insert " "))
      (insert (shell-quote-argument file))
      'copy)))

;; eshell

(defun eshell/g (&rest args)
    "Call magit without args, or git with args."
    (if args
        (eshell-command-result (concat "git " (string-join (mapcar #'shell-quote-argument args) " ")))
      (magit-status)))

(defun eshell/x ()
  "Leave or kill the Eshell buffer, depending on `eshell-kill-on-exit'."
  (throw 'eshell-terminal t))

(provide 'personal)
