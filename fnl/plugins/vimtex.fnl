(local {: plugin} (require :utils))

(plugin :lervag/vimtex {:lazy false
                        :init (fn []
                                (set vim.g.vimtex_view_general_viewer :open)
                                (set vim.g.vimtex_view_general_options
                                     "-a Preview @pdf"))})
