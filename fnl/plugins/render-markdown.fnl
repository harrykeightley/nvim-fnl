(local {: plugin : plugin-keys} (require :utils))

(plugin :MeanderingProgrammer/render-markdown.nvim
        {:dependencies [:nvim-treesitter/nvim-treesitter :nvim-mini/mini.nvim]
         :opts {}
         ;:keys [(plugin-keys :<leader>tgb
         ;                    #(vim.cmd "Gitsigns toggle_current_line_blame")
         ;                    {:mode "" :desc "[T]oggle [G]itsigns [B]lame"})
         ;       (plugin-keys :<leader>sC #(vim.cmd "Gitsigns setqflist")
         ;                    {:mode "" :desc "[S]earch Git [C]hanges"})]
         })
