(local {: plugin : plugin-keys} (require :utils))

(plugin :m4xshen/hardtime.nvim
              {:lazy false
               :dependencies [:MunifTanjim/nui.nvim]
               :opts {:enabled false}
               :keys [(plugin-keys :<leader>th #(vim.cmd "Hardtime toggle")
                                   {:mode "" :desc "[T]oggle [H]ardtime"})]})
