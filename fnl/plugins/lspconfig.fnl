(local {: plugin : setup-plugin : keys : notify} (require :utils))
(local {: map } (require :keymap))

(fn bmap [buffer keys func desc]
  (map :n keys func {:desc (.. "LSP: " desc)
                     : buffer}))

(fn tsb [name]
  (. (require :telescope.builtin) name))

(fn on-attach [event]
  ;; LSP BINDINGS
  (let [bmap (partial bmap event.buf)]
    (bmap :gd (tsb :lsp_definitions) "[G]oto [D]efinition")
    (bmap :gr (tsb :lsp_references) "[G]oto [R]eferences")
    (bmap :gI (tsb :lsp_implementations) "[G]oto [I]mplementations")
    (bmap :gD (tsb :lsp_type_definitions) "[G]oto Type [D]efinitions")
    (bmap :gs (tsb :lsp_document_symbols) "[G]oto [S]ymbols")
    (bmap :<leader>rn vim.lsp.buf.rename "[R]e[n]ame")
    (bmap :<leader>ca vim.lsp.buf.code_action "[C]ode [A]ction")
    (bmap :K vim.lsp.buf.hover "Hover Documentation"))

  (let [client (vim.lsp.get_client_by_id event.data.client_id)
        can-highlight? (and client (?. client :server_capabilities :documentHighlightProvider))]

    ; The following two autocommands are used to highlight references of the
    ; word under your cursor when your cursor rests there for a little while.
    ;    See `:help CursorHold` for information about when this is executed
    ;
    ; When you move your cursor, the highlights will be cleared (the second autocommand).
    (when can-highlight?
      (let [highlight-augroup (vim.api.nvim_create_augroup :lsp-highlight {:clear false})
            create-autocmd (fn [events group callback buffer?]
                             (vim.api.nvim_create_autocmd events 
                                                          {: group 
                                                           : callback 
                                                           :buffer buffer?}))]
        (create-autocmd [:CursorHold :CursorHoldI] 
                        highlight-augroup 
                        vim.lsp.buf.document_highlight
                        event.buf)
        (create-autocmd [:CursorMoved :CursorMovedI] 
                        highlight-augroup 
                        vim.lsp.buf.clear_references
                        event.buf)
        (create-autocmd :LspDetach
                        (vim.api.nvim_create_augroup :lsp-detatch {:clear true}) 
                        (fn [e] 
                          (vim.lsp.buf.clear_references)
                          (vim.api.nvim_clear_autocmds {:group :lsp-highlight
                                                        :buffer e.buf}))
                        event.buf)
        )
    )))

(fn config []
  (vim.api.nvim_create_autocmd :LspAttach 
    {:group (vim.api.nvim_create_augroup :lsp-attach {:clear true})
     :callback on-attach})
  (let [capabilities (vim.lsp.protocol.make_client_capabilities)
        cmp (require :cmp_nvim_lsp)
        capabilities (vim.tbl_deep_extend :force capabilities (cmp.default_capabilities))
        servers {
          :lua_ls {
            :settings {
              :Lua {
                :completion {
                  :callSnippet :Replace
                }
              }
            }
          }
          :ruff {}
          }
        mason (require :mason)
        _ (mason.setup)
        ensure_installed (keys (or servers {}))
        tool-installer (require :mason-tool-installer)
        mason-lspconfig (require :mason-lspconfig)]

    (tool-installer.setup {: ensure_installed})
    (mason-lspconfig.setup 
      {:handlers [(fn [server-name]
                    (let [server (or (. servers server-name) {})
                          server-capabilities (vim.tbl_deep_extend 
                                                :force 
                                                {} 
                                                capabilities 
                                                (or server.capabilities {}))
                          lspconfig (require :lspconfig)
                          lspserver (. lspconfig server-name)]
                      (lspserver.setup server)))]}))
  )


(plugin :neovim/nvim-lspconfig
  {:dependencies 
    [(plugin :williamboman/mason.nvim {:config true})
     :williamboman/mason-lspconfig.nvim
     :WhoIsSethDaniel/mason-tool-installer.nvim
     (setup-plugin :j-hui/fidget.nvim)
     (setup-plugin :folke/neodev.nvim)]
   : config })
