(local {: plugin : merge} (require :utils))

(fn set-colorscheme! [name]
  (vim.cmd (.. "colorscheme " name)))

(fn enable-guicolors [] (set vim.o.termguicolors true))

(fn set-bg! [val]
  (set vim.o.background val))

(local theme-plugins {:nightfox (plugin :EdenEast/nightfox.nvim
                                        {:dependencies [:nvim-tree/nvim-web-devicons]})
                      :rose-pine (plugin :rose-pine/neovim)
                      :melange (plugin :savq/melange-nvim)
                      :cat (plugin :catppuccin/nvim {:name :catppuccin})
                      :zenbones (plugin :zenbones-theme/zenbones.nvim
                                        {:dependencies [:rktjmp/lush.nvim]})
                      :kanagawa (plugin :rebelot/kanagawa.nvim)
                      :nordic (plugin :AlexvZyl/nordic.nvim)
                      :oxocarbon (plugin :nyoom-engineering/oxocarbon.nvim)
                      :no-clown (plugin :aktersnurra/no-clown-fiesta.nvim)
                      :mellifluous (plugin :ramojus/mellifluous.nvim)
                      :cyberdream (plugin :scottmckendry/cyberdream.nvim)
                      :vesper (plugin :datsfilipe/vesper.nvim)
                      :onedark (plugin :navarasu/onedark.nvim)
                      :everforest (plugin :sainnhe/everforest)
                      :vscode (plugin :Mofiqul/vscode.nvim)
                      :gruvbox (plugin :sainnhe/gruvbox-material)
                      :github (plugin :projekt0n/github-nvim-theme)
                      :bamboo (plugin :ribru17/bamboo.nvim)
                      ;; Little note here to not wrap last line
                      })

(local theme-options {:no-clown-fiesta {:styles {;:type {:bold true}
                                                 :lsp {:undercurl true}
                                                 :match_paren {:underline true}}}
                      :mellifluous {}
                      ;;
                      })

(fn build-preset [theme-index-name colorscheme ?opts]
  (let [opts (or ?opts {})
        bg (or opts.bg :dark)
        theme (. theme-plugins theme-index-name)
        settings (. theme-options colorscheme)
        config (or opts.config #(do
                                  (enable-guicolors)
                                  (set-colorscheme! colorscheme)
                                  (when settings
                                    (let [m (require theme)]
                                      (m.setup settings)))
                                  (set-bg! bg)))]
    [theme config]))

(local theme-presets {:nightfox (build-preset :nightfox :nightfox)
                      :terafox (build-preset :nightfox :terafox)
                      :dayfox (build-preset :nightfox :dayfox)
                      :dawnfox (build-preset :nightfox :dawnfox)
                      :rose-pine (build-preset :rose-pine :rose-pine)
                      :rose-pine-dawn (build-preset :rose-pine :rose-pine-dawn)
                      :melange (build-preset :melange :melange)
                      :melange-light (build-preset :melange :melange
                                                   {:bg :light})
                      :catppuccin (build-preset :cat :catppuccin)
                      :catppuccin-latte (build-preset :cat :catppuccin-latte)
                      :zenbones (build-preset :zenbones :zenbones)
                      :zenbones-light (build-preset :zenbones :zenbones-light
                                                    {:bg :light})
                      :kanagawa-wave (build-preset :kanagawa :kanagawa-wave)
                      :kanagawa-dragon (build-preset :kanagawa :kanagawa-dragon)
                      :kanagawa-lotus (build-preset :kanagawa :kanagawa-lotus)
                      :nordic (build-preset :nordic :nordic)
                      :oxocarbon (build-preset :oxocarbon :oxocarbon)
                      :oxocarbon-light (build-preset :oxocarbon :oxocarbon
                                                     :light)
                      :no-clown-fiesta (build-preset :no-clown :no-clown-fiesta)
                      :mellifluous (build-preset :mellifluous :mellifluous)
                      :cyberdream (build-preset :cyberdream :cyberdream)
                      :vesper (build-preset :vesper :vesper)
                      :ondedark (build-preset :onedark :onedark)
                      :everforest (build-preset :everforest :everforest)
                      :vscode (build-preset :vscode :vscode)
                      :gruvbox (build-preset :gruvbox :gruvbox-material)
                      :github (build-preset :github :github)
                      :github-dark-default (build-preset :github
                                                         :github_dark_default)
                      :bamboo (build-preset :bamboo :bamboo)
                      ;;
                      })

(fn force-load! [plugin config-callback]
  (merge plugin {:lazy false :priority 1000 :config config-callback})
  plugin)

(fn load-preset [preset]
  (let [[theme config] (. theme-presets preset)]
    (force-load! theme config)))

(load-preset :github-dark-default)

(local theme-plugin-values (icollect [_ v (pairs theme-plugins)] v))

theme-plugin-values
