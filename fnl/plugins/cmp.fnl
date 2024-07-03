(local {: plugin} (require :utils))

(fn config []
  (let [cmp (require :cmp)
        luasnip (require :luasnip)]
    (luasnip.config.setup)
    (cmp.setup 
      {:snippet {:expand (fn [args] (luasnip.lsp_expand args.body))}
       :completion {:completeopt "menu,menuone,noinsert"}
       :mapping (cmp.mapping.preset.insert 
                  {:<C-n> (cmp.mapping.select_next_item)}
                   :<C-p> (cmp.mapping.select_prev_item)
                   :<C-b> (cmp.mapping.scroll_docs -4)
                   :<C-f> (cmp.mapping.scroll_docs 4)
                   :<C-y> (cmp.mapping.confirm {:select true})
                   :<C-Space> (cmp.mapping.complete)
                  )


       :sources [{:name :nvim_lsp}
                 {:name :luasnip}
                 {:name :path}]})))

(plugin :hrsh7th/nvim-cmp
        {:event :InsertEnter
         :dependencies [(plugin :L3MON4D3/LuaSnip
                                {:build (let [is-windows? (= (vim.fn.has :win32) 1)
                                                has-make? (= (vim.fn.executable :make) 1)]
                                            (if (or is-windows? (not has-make?))
                                                "make install_jsregexp"))})
                        :saadparwaiz1/cmp_luasnip 
                        :hrsh7th/cmp-nvim-lsp
                        :hrsh7th/cmp-path]
         : config})
