(local {: plugin : plugin-keys} (require :utils))

(local disabled-filetypes {:c true :cpp true})

(fn should-save? [filetype]
  (not (?. disabled-filetypes filetype)))

(plugin :stevearc/conform.nvim
        {:lazy false
         :keys [(plugin-keys :<leader>f
                             #(let [conform (require :conform)]
                                (conform.format {:async true
                                                 :lsp_fallback true}))
                             {:mode "" :desc "[F]ormat buffer"})]
         :opts {:notify_on_error true
                ;:format_on_save (fn [bufnr]
                ;                  {:timeout_ms 500
                ;                   :lsp_fallback (should-save? (. vim.bo bufnr :filetype))})
                :formatters {:gdformat {:prepend_args [:--use-spaces=2
                                                       :--line-length=80]}}
                :formatters_by_ft {:lua [:stylua]
                                   ;:lua [:lua-format]
                                   :rust [:rustfmt]
                                   :fennel [:fnlfmt]
                                   :python [:ruff_format]
                                   :typescript [:prettierd :prettier :eslint_d]
                                   :javascript [:prettierd :prettier :eslint_d]
                                   :json [:jq]
                                   :typescriptreact [:prettierd :eslint_d]
                                   :html [:prettierd]
                                   :gdscript [:gdformat]}}})
