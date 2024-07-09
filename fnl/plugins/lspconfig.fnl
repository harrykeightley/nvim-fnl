(local {: plugin : setup-plugin : keys : merge} (require :utils))
(local {: map } (require :keymap))

; Setup and configure options for lsp clients 
;
; See more here
; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.m
(local server-settings 
			 {
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
					:pyright {
						:settings {
							:pyright {
								:disableOrganizeImports true ;using ruff
							}
							:python {
								:analysis {
									:ignore ["*"] ; Using Ruff
									:typeCheckingMode :off ; -- Using Ruff
									:reportUndefinedVariable "none"
								}
							}
						}
					}
          :tsserver {}
          :tailwindcss {}
          :fennel_language_server {}
        })

(local group-names 
			 {:attach :hjk-attach
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
															(vim.api.nvim_clear_autocmds {:group (. group-names :highlight)
																														:buffer other-event.buf}))})))))

(fn setup-capabilities []
	(let [capabilities (vim.lsp.protocol.make_client_capabilities)
        cmp (require :cmp_nvim_lsp)
        capabilities (vim.tbl_deep_extend :force capabilities (cmp.default_capabilities))
				;; Require mason to be setup
        mason (require :mason)
        _ (mason.setup)
        servers server-settings
				;; You can add other tools here that you want Mason to install
				;; for you, so that they are available from within Neovim.
        ensure_installed (keys (or servers {}))
        tool-installer (require :mason-tool-installer)
        mason-lspconfig (require :mason-lspconfig)]

    (tool-installer.setup {: ensure_installed})
    (mason-lspconfig.setup 
      {:handlers [(fn [server-name]
                    (let [server (or (?. servers server-name) {})
                          server-capabilities (vim.tbl_deep_extend 
                                                :force 
                                                {} 
                                                capabilities 
                                                (or server.capabilities {}))
                          lspconfig (require :lspconfig)
                          lspserver (. lspconfig server-name)]
											(set server.capabilities server-capabilities)
                      (lspserver.setup server)))]}))
	)

(fn config []
  (autocmd :LspAttach 
					 {:group (augroup (. group-names :attach))
						:callback on-attach})
  (setup-capabilities))


(plugin :neovim/nvim-lspconfig
  {:dependencies 
    [(plugin :williamboman/mason.nvim {:config true})
     :williamboman/mason-lspconfig.nvim
     :WhoIsSethDaniel/mason-tool-installer.nvim
     (setup-plugin :j-hui/fidget.nvim)
     (setup-plugin :folke/neodev.nvim)]
   : config })
