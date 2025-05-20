(local {: plugin} (require :utils))

(plugin :NeogitOrg/neogit {:dependencies [:nvim-lua/plenary.nvim
                                          :sindrets/diffview.nvim
                                          :nvim-telescope/telescope.nvim]
                           :config true})
