(require 'typescript-ts-mode)

(add-to-list 'auto-mode-alist '("\\.tsx?\\'" . tsx-ts-mode))

;; customize preferences for typescript-language-server:

(require 'cl-seq)
(require 'eglot)

(/v 'eglot-server-programs
  (cl-substitute-if
    (cons
      '(js-mode js-ts-mode
         tsx-ts-mode typescript-ts-mode typescript-mode)
      '("typescript-language-server" "--stdio" :initializationOptions
         (:preferences
           (
             ;; https://github.com/microsoft/TypeScript/blob/main/src/server/protocol.ts#L3410-L3539
             :disableSuggestions                                    :json-false     ;; boolean
             :quotePreference                                       "double"        ;; "auto" | "double" | "single"
             :includeCompletionsForModuleExports                    t               ;; boolean
             :includeCompletionsForImportStatements                 t               ;; boolean
             :includeCompletionsWithSnippetText                     t               ;; boolean
             :includeCompletionsWithInsertText                      t               ;; boolean
             :includeAutomaticOptionalChainCompletions              t               ;; boolean
             :includeCompletionsWithClassMemberSnippets             t               ;; boolean
             :includeCompletionsWithObjectLiteralMethodSnippets     t               ;; boolean
             :useLabelDetailsInCompletionEntries                    t               ;; boolean
             :allowIncompleteCompletions                            t               ;; boolean
             :importModuleSpecifierPreference                       "shortest"      ;; "shortest" | "project-relative" | "relative" | "non-relative"
             :importModuleSpecifierEnding                           "minimal"       ;; "auto" | "minimal" | "index" | "js"
             :allowTextChangesInNewFiles                            t               ;; boolean
             ;; :lazyConfiguredProjectsFromExternalProject                          ;; boolean
             :providePrefixAndSuffixTextForRename                   t               ;; boolean
             :provideRefactorNotApplicableReason                    :json-false     ;; boolean
             :allowRenameOfImportPath                               t               ;; boolean
             ;; :includePackageJsonAutoImports                                      ;; "auto" | "on" | "off"
             :jsxAttributeCompletionStyle                           "auto"          ;; "auto" | "braces" | "none"
             :displayPartsForJSDoc                                  t               ;; boolean
             :generateReturnInDocTemplate                           t               ;; boolean
             :includeInlayParameterNameHints                        "all"           ;; "none" | "literals" | "all"
             :includeInlayParameterNameHintsWhenArgumentMatchesName t               ;; boolean
             :includeInlayFunctionParameterTypeHints                t               ;; boolean,
             :includeInlayVariableTypeHints                         t               ;; boolean
             :includeInlayVariableTypeHintsWhenTypeMatchesName      t               ;; boolean
             :includeInlayPropertyDeclarationTypeHints              t               ;; boolean
             :includeInlayFunctionLikeReturnTypeHints               t               ;; boolean
             :includeInlayEnumMemberValueHints                      t               ;; boolean
             ;; :autoImportFileExcludePatterns                                      ;; string[]
             ;; :organizeImportsIgnoreCase                                          ;; "auto" | boolean
             ;; :organizeImportsCollation                                           ;; "ordinal" | "unicode"
             ;; :organizeImportsCollationLocale                                     ;; string
             ;; :organizeImportsNumericCollation                                    ;; boolean
             ;; :organizeImportsAccentCollation                                     ;; boolean
             ;; :organizeImportsCaseFirst                                           ;; "upper" | "lower" | false
             :disableLineTextInReferences                           :json-false)))) ;; boolean
    (lambda (server-program)
      (and
        (listp (car server-program))
        (member 'tsx-ts-mode (car server-program))))
    eglot-server-programs))

;; on save, organize imports:

(defun /typescript-ts-base-mode-hook-function ()
  (add-hook 'before-save-hook
    #'/eglot-organize-imports nil t))

(add-hook 'typescript-ts-base-mode-hook
  #'/typescript-ts-base-mode-hook-function)

(defun /eglot-organize-imports ()
  (interactive)
  (if (derived-mode-p major-mode #'typescript-ts-base-mode)
    (seq-do
      (lambda (kind) (interactive)
        (ignore-errors
          (eglot-code-actions (buffer-end 0) (buffer-end 1) kind t)))
      ;; https://github.com/typescript-language-server/typescript-language-server#code-actions-on-save
      (list
        "source.addMissingImports.ts"
        "source.fixAll.ts"
        ;; "source.removeUnused.ts"
        "source.addMissingImports.ts"
        "source.removeUnusedImports.ts"
        ;; "source.sortImports.ts"
        ;; "source.organizeImports.ts"
        ))
    (funcall-interactively #'eglot-code-action-organize-imports)))
