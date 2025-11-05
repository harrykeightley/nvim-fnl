(local {: plugin : plugin-keys} (require :utils))

(plugin :lewis6991/gitsigns.nvim
        {:opts {}
         :keys [(plugin-keys :<leader>tgb
                             #(vim.cmd "Gitsigns toggle_current_line_blame")
                             {:mode "" :desc "[T]oggle [G]itsigns [B]lame"})]})
