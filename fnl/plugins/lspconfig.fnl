(local {: plugin : setup-plugin : keys : merge : filter-keys} (require :utils))
(local {: map} (require :keymap))

; Setup and configure options for lsp clients 
;
; See more here
; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
(local server-settings {:lua_ls {:settings {:Lua {:completion {:callSnippet :Replace}}}}
                        :ruff {}
                        :pyright {:settings {:pyright {:disableOrganizeImports true}}}
                        :ts_ls {}
                        :tailwindcss {}
                        :fennel_language_server {}
                        :gdscript {}
                        :texlab {}
                        :astro {}
                        :rust_analyzer {}})

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

(fn setup-server [lsp-name options]
  (let [lspconfig (require :lspconfig)
        server (. lspconfig lsp-name)]
    (server.setup options)))

(fn setup-lsps []
  (each [lsp-name options (pairs server-settings)]
    (setup-server lsp-name options)))

(fn config []
  (let [lsp-zero (require :lsp-zero)]
    (lsp-zero.extend_lspconfig {:sign_text true
                                :lsp_attach lsp-attach
                                :capabilities (base-capabilities)})
    (setup-lsps)))

(plugin :VonHeikemen/lsp-zero.nvim
        {:dependencies [(plugin :neovim/nvim-lspconfig)
                        (plugin :williamboman/mason.nvim {:config true})
                        (plugin :williamboman/mason-lspconfig.nvim)
                        (plugin :WhoIsSethDaniel/mason-tool-installer.nvim)
                        (setup-plugin :j-hui/fidget.nvim)
                        (setup-plugin :folke/neodev.nvim)]
         : config})
