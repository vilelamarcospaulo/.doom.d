(defun wm-focus-window (n)
  (if-let (goto-window (nth (- n 1)
                            (window-list (selected-frame)        ;; fn's from emacs api, https://www.gnu.org/software/emacs/manual/html_node/elisp/Windows.html
                                         nil
                                         (frame-first-window))))
      (select-window goto-window)))

(defun hsplit-last-buffer ()
  (interactive)
  (split-window-horizontally)
  (other-window 1 nil)
  (switch-to-next-buffer))

(defun vsplit-last-buffer ()
  (interactive)
  (split-window-vertically)
  (other-window 1 nil)
  (switch-to-next-buffer))

(map! "s-|" #'vsplit-last-buffer)
(map! "s-\\" #'hsplit-last-buffer)

(map! :map general-override-mode-map
      :n "s-1" (lambda () (interactive) (wm-focus-window 1))
      :n "s-2" (lambda () (interactive) (wm-focus-window 2))
      :n "s-3" (lambda () (interactive) (wm-focus-window 3))
      :n "s-4" (lambda () (interactive) (wm-focus-window 4))
      :n "s-5" (lambda () (interactive) (wm-focus-window 5))
      :n "s-6" (lambda () (interactive) (wm-focus-window 6)))
