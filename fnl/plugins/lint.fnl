(local {: plugin : plugin-keys} (require :utils))

(local linters {:python [:ruff]
                :go [:golangcilint]
                :typescriptreact [:eslint_d]
                :javascriptreact [:eslint_d]
                :typescript [:eslint_d]
                :javascript [:eslint_d]
                ;:gdscript [:gdlint]}
                })

(fn view-linters []
  (let [lint (require :lint)
        linters (lint.get_running)]
    (if (= (length linters) 0)
        (print "No linters running.")
        (print (.. "Linters: " (table.concat linters ", "))))))

(fn config []
  (let [lint (require :lint)
        lint-group (vim.api.nvim_create_augroup :lint {:clear true})]
    ;(tset eslint :args  ;      [:--no-warn-ignored ;       :--format ;       :json ;       :--stdin ;       :--stdin-filename ;       (fn [] (vim.api.nvim_buf_get_name 0)) ;  ])
    ;; Setup linters
    (set lint.linters_by_ft linters)
    ;; Setup autocommand
    (vim.api.nvim_create_autocmd [:BufEnter :BufWritePost :InsertLeave]
                                 {:group lint-group :callback #(lint.try_lint)})
    ))

(plugin :mfussenegger/nvim-lint
        {:event [:BufReadPre :BufNewFile]
         : config
         :keys [(plugin-keys :<leader>vl view-linters
                             {:mode :n :desc "[V]iew [L]inters"})]})
