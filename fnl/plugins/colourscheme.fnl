(local {: plugin : merge} (require :utils))

(fn force-load! [plugin config-callback]
  (merge plugin {:lazy false :priority 1000 :config config-callback})
  plugin)

(local colour-themes
       [(plugin :EdenEast/nightfox.nvim
                {:dependencies [:nvim-tree/nvim-web-devicons]})
        (plugin :rose-pine/neovim)
        (plugin :savq/melange-nvim)
        (plugin :catppuccin/nvim {:name :catppuccin})
        (plugin :zenbones-theme/zenbones.nvim
                {:dependencies [:rktjmp/lush.nvim]})
        (plugin :rebelot/kanagawa.nvim)
        (plugin :AlexvZyl/nordic.nvim)
        (plugin :nyoom-engineering/oxocarbon.nvim)])

(fn set-colorscheme! [name]
  (vim.cmd (.. "colorscheme " name)))

(fn set-bg! [val]
  (set vim.o.background val))

(fn build-preset [theme-index colorscheme ?background]
  (let [bg (or ?background :dark)
        theme (. colour-themes theme-index)]
    [theme
     #(do
        (set-colorscheme! colorscheme)
        (if ?background
            (set-bg! bg)))]))

(local theme-presets
       {:nightfox (build-preset 1 :nightfox)
        :terafox (build-preset 1 :terafox)
        :dayfox (build-preset 1 :dayfox)
        :dawnfox (build-preset 1 :dawnfox)
        :rose-pine (build-preset 2 :rose-pine)
        :rose-pine-dawn (build-preset 2 :rose-pine-dawn)
        :melange (build-preset 3 :melange)
        :melange-light (build-preset 3 :melange :light)
        :catppuccin (build-preset 4 :catppuccin)
        :catppuccin-latte (build-preset 4 :catppuccin-latte)
        :zenbones (build-preset 5 :zenbones)
        :zenbones-light (build-preset 5 :zenbones-light :light)
        :kanagawa-wave (build-preset 6 :kanagawa-wave)
        :kanagawa-dragon (build-preset 6 :kanagawa-dragon)
        :kanagawa-lotus (build-preset 6 :kanagawa-lotus)
        :nordic (build-preset 7 :nordic)
        :oxocarbon (build-preset 8 :oxocarbon)
        :oxocarbon-light (build-preset 8 :oxocarbon :light)})

(fn load-preset [preset]
  (let [[theme config] (. theme-presets preset)]
    (force-load! theme config)))

(load-preset :kanagawa-wave)

colour-themes
