(local {: plugin : setup-plugin : keys : merge : filter-keys} (require :utils))
(local {: map} (require :keymap))

; Setup and configure options for lsp clients 
;
; See more here
; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
(local server-settings {:lua_ls {:settings {:Lua {:completion {:callSnippet :Replace}}}}
                        :ruff {}
                        :pyright {:settings {:pyright {:disableOrganizeImports true}}}
                        :tsserver {}
                        :tailwindcss {}
                        :fennel_language_server {}
                        :gdscript {}})

;; You can add other tools here that you want Mason to install
;; for you, so that they are available from within Neovim.
(local mason-ensure-installed [:lua_ls
                               :tailwindcss
                               :fennel_language_server
                               :tsserver])

(fn bmap [buffer keys func desc]
  (map :n keys func {:desc (.. "LSP: " desc) : buffer}))

(fn tsb [name]
  (. (require :telescope.builtin) name))

(fn lsp-attach [client bufnr]
  "Called when the LSP first attaches to the client"
  (let [bmap (partial bmap bufnr)]
    (bmap :gd (tsb :lsp_definitions) "[G]oto [D]efinition")
    (bmap :gr (tsb :lsp_references) "[G]oto [R]eferences")
    (bmap :gI (tsb :lsp_implementations) "[G]oto [I]mplementations")
    (bmap :gD (tsb :lsp_type_definitions) "[G]oto Type [D]efinitions")
    (bmap :gs (tsb :lsp_document_symbols) "[G]oto [S]ymbols")
    (bmap :<leader>rn vim.lsp.buf.rename "[R]e[n]ame")
    (bmap :<leader>ca vim.lsp.buf.code_action "[C]ode [A]ction")
    (bmap :K vim.lsp.buf.hover "Hover Documentation")))

(fn base-capabilities []
  (let [cmp (require :cmp_nvim_lsp)
        capabilities (vim.lsp.protocol.make_client_capabilities)]
    (vim.tbl_deep_extend :force capabilities (cmp.default_capabilities))))

(fn setup-mason-lsps []
  (let [;; Require mason to be setup
        mason (require :mason)
        _ (mason.setup)
        servers server-settings
        tool-installer (require :mason-tool-installer)
        mason-lspconfig (require :mason-lspconfig)]
    (tool-installer.setup {:ensure_installed mason-ensure-installed})
    (mason-lspconfig.setup {:handlers [(fn [server-name]
                                         (let [server (or (. servers
                                                             server-name)
                                                          {})
                                               server-capabilities (vim.tbl_deep_extend :force
                                                                                        {}
                                                                                        (base-capabilities)
                                                                                        (or server.capabilities
                                                                                            {}))
                                               lspconfig (require :lspconfig)
                                               lspserver (. lspconfig
                                                            server-name)]
                                           (tset server :capabilities
                                                 server-capabilities)
                                           (lspserver.setup server)))]})))

(fn setup-server [lsp-name options]
  (let [lspconfig (require :lspconfig)
        server (. lspconfig lsp-name)]
    (server.setup options)))

(fn config []
  (let [lsp-zero (require :lsp-zero)]
    (lsp-zero.extend_lspconfig {:sign_text true
                                :lsp_attach lsp-attach
                                :capabilities (base-capabilities)})
    (setup-mason-lsps)))

(plugin :VonHeikemen/lsp-zero.nvim
        {:dependencies [(plugin :neovim/nvim-lspconfig)
                        (plugin :williamboman/mason.nvim {:config true})
                        (plugin :williamboman/mason-lspconfig.nvim)
                        (plugin :WhoIsSethDaniel/mason-tool-installer.nvim)
                        (setup-plugin :j-hui/fidget.nvim)
                        (setup-plugin :folke/neodev.nvim)]
         : config})
