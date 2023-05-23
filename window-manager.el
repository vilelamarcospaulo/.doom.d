(defun wm-focus-window (n)
  (if-let (goto-window (nth (- n 1)
                            (window-list (selected-frame)        ;; fn's from emacs api, https://www.gnu.org/software/emacs/manual/html_node/elisp/Windows.html
                                         nil
                                         (frame-first-window))))
      (select-window goto-window)))

(map! "s-]" #'next-window)
(map! "s-[" #'previous-window)

(map! "s-|" #'split-window-vertically)
(map! "s-\\" #'split-window-horizontally)

(map! :map general-override-mode-map
      :n "s-1" (lambda () (interactive) (wm-focus-window 1))
      :n "s-2" (lambda () (interactive) (wm-focus-window 2))
      :n "s-3" (lambda () (interactive) (wm-focus-window 3))
      :n "s-4" (lambda () (interactive) (wm-focus-window 4))
      :n "s-5" (lambda () (interactive) (wm-focus-window 5))
      :n "s-6" (lambda () (interactive) (wm-focus-window 6)))
