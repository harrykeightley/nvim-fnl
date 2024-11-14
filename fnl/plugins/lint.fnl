(local {: plugin} (require :utils))

(local linters {:python [:ruff]
                :typescriptreact [:eslint_d]
                :javascriptreact [:eslint_d]
                :typescript [:eslint_d]
                :javascript [:eslint_d]})

(fn config []
  (let [lint (require :lint)
        lint-group (vim.api.nvim_create_augroup :lint {:clear true})
        eslint lint.linters.eslint_d]

    (tset eslint :args 
          [:--no-warn-ignored
           :--format
           :json
           :--stdin
           :--stdin-filename
           (fn [] (vim.api.nvim_buf_get_name 0))
      ])
    ;; Setup linters
    (tset lint :linters_by_ft linters)

    ;; Setup autocommand
    (vim.api.nvim_create_autocmd [:BufEnter :BufWritePost :InsertLeave]
                                 {:group lint-group
                                  :callback (fn []
                                              (let [lint (require :lint)]
                                                (lint.try_lint)))})))

(plugin :mfussenegger/nvim-lint {:event [:BufReadPre :BufNewFile] : config})
