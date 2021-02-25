;; Font tools
;;
(defun my/zoom-in ()
  "Increase font size by 10 points"
  (interactive)
  (set-face-attribute 'default nil
                      :height
                      (+ (face-attribute 'default :height)
                         10)))

(defun my/zoom-out ()
  "Decrease font size by 10 points"
  (interactive)
  (set-face-attribute 'default nil
                      :height
                      (- (face-attribute 'default :height)
                         10)))

;; change font size, interactively
(global-set-key (kbd "C->") 'my/zoom-in)
(global-set-key (kbd "C-<") 'my/zoom-out)

;; Clean white spaces
;;
(defun clean-buffer ()
  "Remove white space at the end of lines and extra new lines at the end."
  (interactive "*")
  (save-excursion
    (goto-char (point-max))
    (delete-horizontal-space)
    (while (re-search-backward "[ \t]\n" (point-min) t)
      (delete-horizontal-space))
    (goto-char (point-max))
    (if (re-search-backward "[^\n]" (point-min) t)
        (progn
          (forward-char 1)
          (replace-regexp "\n*" "\n")))))

(global-set-key "\C-xw"         'clean-buffer)
(global-set-key "\M-k"          'copy-line)

;; Spell checking
;;
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(global-set-key "\C-xp"    'ispell-buffer)

;; org mode settings
;;
(setq org-startup-truncated nil)
(with-eval-after-load 'org
  (setq org-startup-indented t) ; Enable `org-indent-mode' by default
  (add-hook 'org-mode-hook #'visual-line-mode))