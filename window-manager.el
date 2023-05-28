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
      :nvi "s-1" (lambda () (interactive) (wm-focus-window 1))
      :nvi "s-2" (lambda () (interactive) (wm-focus-window 2))
      :nvi "s-3" (lambda () (interactive) (wm-focus-window 3))
      :nvi "s-4" (lambda () (interactive) (wm-focus-window 4))
      :nvi "s-5" (lambda () (interactive) (wm-focus-window 5))
      :nvi "s-6" (lambda () (interactive) (wm-focus-window 6)))
