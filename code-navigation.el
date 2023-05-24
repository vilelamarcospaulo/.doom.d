(map! "s-b" #'xref-find-definitions)
(map! "s-=" #'+fold/toggle)

(map! :map general-override-mode-map
      :n "s-[" #'xref-go-back
      :n "s-]" #'xref-go-forward)
