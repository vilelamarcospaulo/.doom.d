(map! "s-r" #'xref-find-references-and-replace)
(map! "s-b" #'xref-find-references)
(map! "s-u" #'xref-find-definitions)
(map! "s-=" #'+fold/toggle)

(map! :map general-override-mode-map
      :nvi "s-[" #'xref-go-back
      :nvi "s-]" #'xref-go-forward)
