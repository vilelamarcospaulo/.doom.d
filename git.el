(map! :map general-override-mode-map
      :nvi "s-g s-s" #'magit-status
      :nvi "s-g s-d" #'magit-diff-buffer-file  ;;diff current
      :nvi "s-g s-a" #'magit-stage-file        ;;git add
      :nvi "s-g s-u" #'magit-unstage-file      ;;git rem
)
