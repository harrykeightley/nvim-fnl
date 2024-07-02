
(local {: plugin } (require :utils))

(plugin :EdenEast/nightfox.nvim 
        {:dependencies [:nvim-tree/nvim-web-devicons]
         :priority 1000
         :config #(vim.cmd "colorscheme nightfox")}) 
