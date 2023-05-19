(global-set-key (kbd "M-o") 'ace-window)

(map! "s-[" #'previous-window-any-frame)
(map! "s-]" #'next-window-any-frame)

(map! "s-\\" #'split-window-right)
(map! "s-|" #'split-window-below)
