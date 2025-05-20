(local {: plugin : merge} (require :utils))

(fn set-colorscheme! [name]
  (vim.cmd (.. "colorscheme " name)))

(fn enable-guicolors [] (set vim.o.termguicolors true))

(fn set-bg! [val]
  (set vim.o.background val))

(local colour-themes [(plugin :EdenEast/nightfox.nvim
                              {:dependencies [:nvim-tree/nvim-web-devicons]})
                      (plugin :rose-pine/neovim)
                      (plugin :savq/melange-nvim)
                      (plugin :catppuccin/nvim {:name :catppuccin})
                      (plugin :zenbones-theme/zenbones.nvim
                              {:dependencies [:rktjmp/lush.nvim]})
                      (plugin :rebelot/kanagawa.nvim)
                      (plugin :AlexvZyl/nordic.nvim)
                      (plugin :nyoom-engineering/oxocarbon.nvim)
                      (plugin :aktersnurra/no-clown-fiesta.nvim)
                      (plugin :ramojus/mellifluous.nvim)
                      (plugin :scottmckendry/cyberdream.nvim)
                      (plugin :datsfilipe/vesper.nvim)
                      (plugin :navarasu/onedark.nvim)
                      (plugin :sainnhe/everforest)
                      (plugin :Mofiqul/vscode.nvim)
                      (plugin :sainnhe/gruvbox-material)
                      (plugin :projekt0n/github-nvim-theme)
                      (plugin :ribru17/bamboo.nvim)
                      ;;
                      ])

(local theme-options {:no-clown-fiesta {:styles {;:type {:bold true}
                                                 :lsp {:undercurl true}
                                                 :match_paren {:underline true}}}
                      :mellifluous {}
                      ;;
                      })

(fn build-preset [theme-index colorscheme ?opts]
  (let [opts (or ?opts {})
        bg (or opts.bg :dark)
        theme (. colour-themes theme-index)
        settings (. theme-options colorscheme)
        config (or opts.config #(do
                                  (enable-guicolors)
                                  (set-colorscheme! colorscheme)
                                  (when settings
                                    (let [m (require theme)]
                                      (m.setup settings)))
                                  (set-bg! bg)))]
    [theme config]))

(local theme-presets {:nightfox (build-preset 1 :nightfox)
                      :terafox (build-preset 1 :terafox)
                      :dayfox (build-preset 1 :dayfox)
                      :dawnfox (build-preset 1 :dawnfox)
                      :rose-pine (build-preset 2 :rose-pine)
                      :rose-pine-dawn (build-preset 2 :rose-pine-dawn)
                      :melange (build-preset 3 :melange)
                      :melange-light (build-preset 3 :melange {:bg :light})
                      :catppuccin (build-preset 4 :catppuccin)
                      :catppuccin-latte (build-preset 4 :catppuccin-latte)
                      :zenbones (build-preset 5 :zenbones)
                      :zenbones-light (build-preset 5 :zenbones-light
                                                    {:bg :light})
                      :kanagawa-wave (build-preset 6 :kanagawa-wave)
                      :kanagawa-dragon (build-preset 6 :kanagawa-dragon)
                      :kanagawa-lotus (build-preset 6 :kanagawa-lotus)
                      :nordic (build-preset 7 :nordic)
                      :oxocarbon (build-preset 8 :oxocarbon)
                      :oxocarbon-light (build-preset 8 :oxocarbon :light)
                      :no-clown-fiesta (build-preset 9 :no-clown-fiesta)
                      :mellifluous (build-preset 10 :mellifluous)
                      :cyberdream (build-preset 11 :cyberdream)
                      :vesper (build-preset 12 :vesper)
                      :ondedark (build-preset 13 :onedark)
                      :everforest (build-preset 14 :everforest)
                      :vscode (build-preset 15 :vscode)
                      :gruvbox (build-preset 16 :gruvbox-material)
                      :github (build-preset 17 :github)
                      :github-dark-default (build-preset 17
                                                         :github_dark_default)
                      :bamboo (build-preset 18 :bamboo)
                      ;;
                      })

(fn force-load! [plugin config-callback]
  (merge plugin {:lazy false :priority 1000 :config config-callback})
  plugin)

(fn load-preset [preset]
  (let [[theme config] (. theme-presets preset)]
    (force-load! theme config)))

(load-preset :github-dark-default)

colour-themes
