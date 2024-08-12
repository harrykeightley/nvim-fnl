-- [nfnl] Compiled from fnl/plugins/colourscheme.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local merge = _local_1_["merge"]
local function force_load_21(plugin0, config_callback)
  merge(plugin0, {priority = 1000, config = config_callback, lazy = false})
  return plugin0
end
local colour_themes = {plugin("EdenEast/nightfox.nvim", {dependencies = {"nvim-tree/nvim-web-devicons"}}), plugin("rose-pine/neovim"), plugin("savq/melange-nvim"), plugin("catppuccin/nvim", {name = "catppuccin"}), plugin("zenbones-theme/zenbones.nvim", {dependencies = {"rktjmp/lush.nvim"}}), plugin("rebelot/kanagawa.nvim"), plugin("AlexvZyl/nordic.nvim"), plugin("nyoom-engineering/oxocarbon.nvim")}
local function set_colorscheme_21(name)
  return vim.cmd(("colorscheme " .. name))
end
local function set_bg_21(val)
  vim.o.background = val
  return nil
end
local function build_preset(theme_index, colorscheme, _3fbackground)
  local bg = (_3fbackground or "dark")
  local theme = colour_themes[theme_index]
  local function _2_()
    set_colorscheme_21(colorscheme)
    if _3fbackground then
      return set_bg_21(bg)
    else
      return nil
    end
  end
  return {theme, _2_}
end
local theme_presets = {nightfox = build_preset(1, "nightfox"), terafox = build_preset(1, "terafox"), dayfox = build_preset(1, "dayfox"), dawnfox = build_preset(1, "dawnfox"), ["rose-pine"] = build_preset(2, "rose-pine"), ["rose-pine-dawn"] = build_preset(2, "rose-pine-dawn"), melange = build_preset(3, "melange"), ["melange-light"] = build_preset(3, "melange", "light"), catppuccin = build_preset(4, "catppuccin"), ["catppuccin-latte"] = build_preset(4, "catppuccin-latte"), zenbones = build_preset(5, "zenbones"), ["zenbones-light"] = build_preset(5, "zenbones-light", "light"), ["kanagawa-wave"] = build_preset(6, "kanagawa-wave"), ["kanagawa-dragon"] = build_preset(6, "kanagawa-dragon"), ["kanagawa-lotus"] = build_preset(6, "kanagawa-lotus"), nordic = build_preset(7, "nordic"), oxocarbon = build_preset(8, "oxocarbon"), ["oxocarbon-light"] = build_preset(8, "oxocarbon", "light")}
local function load_preset(preset)
  local _let_4_ = theme_presets[preset]
  local theme = _let_4_[1]
  local config = _let_4_[2]
  return force_load_21(theme, config)
end
load_preset("kanagawa-wave")
return colour_themes
