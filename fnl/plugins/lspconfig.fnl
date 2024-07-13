(local {: plugin : setup-plugin : keys : merge : filter-keys} (require :utils))
(local {: map } (require :keymap))

; Setup and configure options for lsp clients 
;
; See more here
; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.m
(local server-settings {:lua_ls {:settings {:Lua {:completion {:callSnippet :Replace}}}}
                        :ruff {}
                        :tsserver {}
                        :tailwindcss {}
                        :fennel_language_server {}
                        :gdscript {}})



(local mason-managed-lsps [:lua_ls :ruff :tsserver :tailwindcss :fennel_language_server])

;; Group names used in vim augroups
(local group-names {:attach :hjk-attach
                    :detach :hjk-detach
                    :highlight :hjk-highlight})

(fn bmap [buffer keys func desc]
  (map :n keys func {:desc (.. "LSP: " desc)
                     : buffer}))

(fn tsb [name]
  (. (require :telescope.builtin) name))

(fn augroup [name ?opts]
  (vim.api.nvim_create_augroup name (merge {:clear false} (or ?opts {}))))

(fn autocmd [events ?opts]
  (vim.api.nvim_create_autocmd events (or ?opts {})))

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
      (let [highlight-augroup (augroup (. group-names :highlight))]
        (autocmd [:CursorHold :CursorHoldI]
                 {:buffer event.buf
                  :group highlight-augroup
                  :callback vim.lsp.buf.document_highlight})
        (autocmd [:CursorMoved :CursorMovedI]
                 {:buffer event.buf
                  :group highlight-augroup
                  :callback vim.lsp.buf.clear_references})
        (autocmd :LspDetach
                 {:group (augroup (. group-names :detach))
                  :callback (fn [other-event]
                              (vim.lsp.buf.clear_references)
                              (vim.api.nvim_clear_autocmds {:group (. group-names
                                                                      :highlight)
                                                            :buffer other-event.buf}))})))))

(fn setup-server [lsp-name options]
  (let [lspconfig (require :lspconfig)
        server (. lspconfig lsp-name)]
    (server.setup options)))


(fn base-capabilities []
  (let [cmp (require :cmp_nvim_lsp)
        capabilities (vim.lsp.protocol.make_client_capabilities)]
    (vim.tbl_deep_extend :force capabilities (cmp.default_capabilities))))

(fn setup-mason-lsps []
	(let [ ;; Require mason to be setup
        mason (require :mason)
        _ (mason.setup)
        servers server-settings
        ;; You can add other tools here that you want Mason to install
        ;; for you, so that they are available from within Neovim.
        ensure_installed mason-managed-lsps
        tool-installer (require :mason-tool-installer)
        mason-lspconfig (require :mason-lspconfig)]

    (tool-installer.setup {: ensure_installed})
    (mason-lspconfig.setup 
      {:handlers [(fn [server-name]
                    (let [server (or (?. servers server-name) {})
                          server-capabilities (vim.tbl_deep_extend 
                                                :force 
                                                {} 
                                                (base-capabilities) 
                                                (or server.capabilities {}))
                          lspconfig (require :lspconfig)
                          lspserver (. lspconfig server-name)]
                      (set server.capabilities server-capabilities)
                      (lspserver.setup server)))]})))

(fn setup-nonmason-lsps []
  (let [servers (filter-keys server-settings mason-managed-lsps)
        capabilities (base-capabilities)]
    (each [name options (pairs servers)]
      (let [server-capabilities (vim.tbl_deep_extend :force {}
                                                     capabilities
                                                     (or options.capabilities
                                                         {}))]
        (setup-server name (merge options {:capabilities server-capabilities}))))))

(fn config []
  (autocmd :LspAttach {:group (augroup (. group-names :attach))
                       :callback on-attach})
  (setup-mason-lsps)
  (setup-nonmason-lsps))


(plugin :neovim/nvim-lspconfig
  {:dependencies 
    [(plugin :williamboman/mason.nvim {:config true})
     :williamboman/mason-lspconfig.nvim
     :WhoIsSethDaniel/mason-tool-installer.nvim
     (setup-plugin :j-hui/fidget.nvim)
     (setup-plugin :folke/neodev.nvim)]
   : config })
