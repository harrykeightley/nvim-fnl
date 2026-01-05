(local {: plugin : plugin-keys} (require :utils))

(plugin :lewis6991/gitsigns.nvim {:opts {:signs_staged_enable true
                                         :signcolumn true
                                         :current_line_blame true}
                                  :keys [(plugin-keys :<leader>tgb
                                                      #(vim.cmd "Gitsigns toggle_current_line_blame")
                                                      {:mode ""
                                                       :desc "[T]oggle [G]itsigns [B]lame"})
                                         (plugin-keys :<leader>sC
                                                      #(vim.cmd "Gitsigns setqflist")
                                                      {:mode ""
                                                       :desc "[S]earch Git [C]hanges"})]
                                  :lazy false})
