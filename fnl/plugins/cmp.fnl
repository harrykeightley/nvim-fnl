(local {: plugin} (require :utils))
(local {: nmap : map} (require :keymap))

(local cmp-sources [{:name :nvim_lsp}
                    {:name :luasnip}
                    {:name :conjure}
                    {:name :buffer :name :buffer}])

(local dependencies [:hrsh7th/cmp-nvim-lsp
                     :hrsh7th/cmp-path
                     :PaterJason/cmp-conjure
                     ;; luasnip
                     :L3MON4D3/LuaSnip
                     :saadparwaiz1/cmp_luasnip])

(local snippets-paths ["~/.config/nvim/snippets"])

(fn make-snippet-keymaps [luasnip loader]
  (nmap :<leader>cs (fn [] (loader.load {:paths snippets-paths}))
        {:desc "Reload snippets"})
  ;; Use tab and shift tab to go back and forward in snippet components.
  ;(map [:i :s] :<Tab> ;     (fn [] (if (luasnip.expand_or_jumpable) (luasnip.jump 1) "\t")) ;     {:silent true})
  ;(map [:i :s] :<S-Tab> ;     (fn [] (if (luasnip.jumpable) (luasnip.jump -1) :<S-Tab>)) {:silent true})
  ;(map [:i :s] :<C-E> (fn [] ;                      (when (luasnip.choice_active) ;                        (luasnip.change_choice 1)) ;                      {:silent true}))
  )

(fn config []
  (let [cmp (require :cmp)
        luasnip (require :luasnip)
        snippet-loader (require :luasnip.loaders.from_lua)]
    (luasnip.config.setup)
    (snippet-loader.lazy_load {:paths snippets-paths})
    ;; Setup reload snippet keybind
    (make-snippet-keymaps luasnip snippet-loader)
    (cmp.setup {:snippet {:expand (fn [args] (luasnip.lsp_expand args.body))}
                :completion {:completeopt "menu,menuone,noinsert"}
                :mapping (cmp.mapping.preset.insert {:<C-n> (cmp.mapping.select_next_item)
                                                     :<C-p> (cmp.mapping.select_prev_item)
                                                     :<C-b> (cmp.mapping.scroll_docs (- 4))
                                                     :<C-f> (cmp.mapping.scroll_docs 4)
                                                     :<C-Space> (cmp.mapping.complete)
                                                     :<C-e> (cmp.mapping.abort)
                                                     ;:<C-y> (cmp.mapping.confirm {:select true})
                                                     :<CR> (cmp.mapping.confirm {:select true})})
                :sources cmp-sources})))

(plugin :hrsh7th/nvim-cmp {:event :InsertEnter : dependencies : config})
