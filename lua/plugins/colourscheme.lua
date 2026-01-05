-- [nfnl] fnl/plugins/colourscheme.fnl
local _local_1_ = require("utils")
local plugin = _local_1_.plugin
local merge = _local_1_.merge
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
local theme_plugins = {nightfox = plugin("EdenEast/nightfox.nvim", {dependencies = {"nvim-tree/nvim-web-devicons"}}), ["rose-pine"] = plugin("rose-pine/neovim"), melange = plugin("savq/melange-nvim"), cat = plugin("catppuccin/nvim", {name = "catppuccin"}), zenbones = plugin("zenbones-theme/zenbones.nvim", {dependencies = {"rktjmp/lush.nvim"}}), kanagawa = plugin("rebelot/kanagawa.nvim"), nordic = plugin("AlexvZyl/nordic.nvim"), oxocarbon = plugin("nyoom-engineering/oxocarbon.nvim"), ["no-clown"] = plugin("aktersnurra/no-clown-fiesta.nvim"), mellifluous = plugin("ramojus/mellifluous.nvim"), cyberdream = plugin("scottmckendry/cyberdream.nvim"), vesper = plugin("datsfilipe/vesper.nvim"), onedark = plugin("navarasu/onedark.nvim"), everforest = plugin("sainnhe/everforest"), vscode = plugin("Mofiqul/vscode.nvim"), gruvbox = plugin("sainnhe/gruvbox-material"), github = plugin("projekt0n/github-nvim-theme"), bamboo = plugin("ribru17/bamboo.nvim")}
local theme_options = {["no-clown-fiesta"] = {styles = {lsp = {undercurl = true}, match_paren = {underline = true}}}, mellifluous = {}}
local function build_preset(theme_index_name, colorscheme, _3fopts)
  local opts = (_3fopts or {})
  local bg = (opts.bg or "dark")
  local theme = theme_plugins[theme_index_name]
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
local theme_presets = {nightfox = build_preset("nightfox", "nightfox"), terafox = build_preset("nightfox", "terafox"), dayfox = build_preset("nightfox", "dayfox"), dawnfox = build_preset("nightfox", "dawnfox"), ["rose-pine"] = build_preset("rose-pine", "rose-pine"), ["rose-pine-dawn"] = build_preset("rose-pine", "rose-pine-dawn"), melange = build_preset("melange", "melange"), ["melange-light"] = build_preset("melange", "melange", {bg = "light"}), catppuccin = build_preset("cat", "catppuccin"), ["catppuccin-latte"] = build_preset("cat", "catppuccin-latte"), zenbones = build_preset("zenbones", "zenbones"), ["zenbones-light"] = build_preset("zenbones", "zenbones-light", {bg = "light"}), ["kanagawa-wave"] = build_preset("kanagawa", "kanagawa-wave"), ["kanagawa-dragon"] = build_preset("kanagawa", "kanagawa-dragon"), ["kanagawa-lotus"] = build_preset("kanagawa", "kanagawa-lotus"), nordic = build_preset("nordic", "nordic"), oxocarbon = build_preset("oxocarbon", "oxocarbon"), ["oxocarbon-light"] = build_preset("oxocarbon", "oxocarbon", "light"), ["no-clown-fiesta"] = build_preset("no-clown", "no-clown-fiesta"), mellifluous = build_preset("mellifluous", "mellifluous"), cyberdream = build_preset("cyberdream", "cyberdream"), vesper = build_preset("vesper", "vesper"), ondedark = build_preset("onedark", "onedark"), everforest = build_preset("everforest", "everforest"), vscode = build_preset("vscode", "vscode"), gruvbox = build_preset("gruvbox", "gruvbox-material"), github = build_preset("github", "github"), ["github-dark-default"] = build_preset("github", "github_dark_default"), bamboo = build_preset("bamboo", "bamboo")}
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
local theme_plugin_values
do
  local tbl_26_ = {}
  local i_27_ = 0
  for _, v in pairs(theme_plugins) do
    local val_28_ = v
    if (nil ~= val_28_) then
      i_27_ = (i_27_ + 1)
      tbl_26_[i_27_] = val_28_
    else
    end
  end
  theme_plugin_values = tbl_26_
end
return theme_plugin_values
