(local {: plugin : merge} (require :utils))

(fn force-load! [plugin config-callback]
  (merge plugin {:lazy false :priority 1000 :config config-callback})
  plugin)

(local colour-themes
       [(plugin :EdenEast/nightfox.nvim
                {:dependencies [:nvim-tree/nvim-web-devicons]})
        (plugin :savq/melange-nvim)
        (plugin :rose-pine/neovim)
        (plugin :catppuccin/nvim {:name :catppuccin})])

;; NOTE: Set theme index and config callback here
(let [theme-index 1
      theme (. colour-themes theme-index)
      ;config #(vim.cmd "colorscheme catppuccin-latte")]
      config #(vim.cmd "colorscheme nightfox")]
  ;config #(vim.cmd "colorscheme dayfox")]
  ;config #(vim.cmd "colorscheme dawnfox")]
  ;config #(vim.cmd "colorscheme rose-pine")]
  ;config #(vim.cmd "colorscheme rose-pine-dawn")]
  ;config #(vim.cmd "colorscheme melange")]
  (force-load! theme config)
  colour-themes)
