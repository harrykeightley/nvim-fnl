-- [nfnl] Compiled from fnl/plugins/colourscheme.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local merge = _local_1_["merge"]
local function set_colorscheme_21(name)
  return vim.cmd(("colorscheme " .. name))
end
local function enable_guicolors()
  vim.o.termguicolors = true
  return nil
end
local function set_bg_21(val)
  vim.o.background = val
  return nil
end
local colour_themes = {plugin("EdenEast/nightfox.nvim", {dependencies = {"nvim-tree/nvim-web-devicons"}}), plugin("rose-pine/neovim"), plugin("savq/melange-nvim"), plugin("catppuccin/nvim", {name = "catppuccin"}), plugin("zenbones-theme/zenbones.nvim", {dependencies = {"rktjmp/lush.nvim"}}), plugin("rebelot/kanagawa.nvim"), plugin("AlexvZyl/nordic.nvim"), plugin("nyoom-engineering/oxocarbon.nvim"), plugin("aktersnurra/no-clown-fiesta.nvim"), plugin("ramojus/mellifluous.nvim"), plugin("scottmckendry/cyberdream.nvim"), plugin("datsfilipe/vesper.nvim"), plugin("navarasu/onedark.nvim"), plugin("sainnhe/everforest"), plugin("Mofiqul/vscode.nvim"), plugin("sainnhe/gruvbox-material"), plugin("projekt0n/github-nvim-theme"), plugin("ribru17/bamboo.nvim")}
local theme_options = {["no-clown-fiesta"] = {styles = {lsp = {undercurl = true}, match_paren = {underline = true}}}, mellifluous = {}}
local function build_preset(theme_index, colorscheme, _3fopts)
  local opts = (_3fopts or {})
  local bg = (opts.bg or "dark")
  local theme = colour_themes[theme_index]
  local settings = theme_options[colorscheme]
  local config
  local or_2_ = opts.config
  if not or_2_ then
    local function _3_()
      enable_guicolors()
      set_colorscheme_21(colorscheme)
      if settings then
        local m = require(theme)
        m.setup(settings)
      else
      end
      return set_bg_21(bg)
    end
    or_2_ = _3_
  end
  config = or_2_
  return {theme, config}
end
local theme_presets = {nightfox = build_preset(1, "nightfox"), terafox = build_preset(1, "terafox"), dayfox = build_preset(1, "dayfox"), dawnfox = build_preset(1, "dawnfox"), ["rose-pine"] = build_preset(2, "rose-pine"), ["rose-pine-dawn"] = build_preset(2, "rose-pine-dawn"), melange = build_preset(3, "melange"), ["melange-light"] = build_preset(3, "melange", {bg = "light"}), catppuccin = build_preset(4, "catppuccin"), ["catppuccin-latte"] = build_preset(4, "catppuccin-latte"), zenbones = build_preset(5, "zenbones"), ["zenbones-light"] = build_preset(5, "zenbones-light", {bg = "light"}), ["kanagawa-wave"] = build_preset(6, "kanagawa-wave"), ["kanagawa-dragon"] = build_preset(6, "kanagawa-dragon"), ["kanagawa-lotus"] = build_preset(6, "kanagawa-lotus"), nordic = build_preset(7, "nordic"), oxocarbon = build_preset(8, "oxocarbon"), ["oxocarbon-light"] = build_preset(8, "oxocarbon", "light"), ["no-clown-fiesta"] = build_preset(9, "no-clown-fiesta"), mellifluous = build_preset(10, "mellifluous"), cyberdream = build_preset(11, "cyberdream"), vesper = build_preset(12, "vesper"), ondedark = build_preset(13, "onedark"), everforest = build_preset(14, "everforest"), vscode = build_preset(15, "vscode"), gruvbox = build_preset(16, "gruvbox-material"), github = build_preset(17, "github"), ["github-dark-default"] = build_preset(17, "github_dark_default"), bamboo = build_preset(18, "bamboo")}
local function force_load_21(plugin0, config_callback)
  merge(plugin0, {priority = 1000, config = config_callback, lazy = false})
  return plugin0
end
local function load_preset(preset)
  local _let_5_ = theme_presets[preset]
  local theme = _let_5_[1]
  local config = _let_5_[2]
  return force_load_21(theme, config)
end
load_preset("github-dark-default")
return colour_themes
