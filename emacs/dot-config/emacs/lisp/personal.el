(defun beginning-of-line-or-indentation ()
  "move to beginning of line, or indentation"
  (interactive)
  (if (bolp)
      (back-to-indentation)
    (beginning-of-line)))

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
