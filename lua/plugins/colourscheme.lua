-- [nfnl] Compiled from fnl/plugins/colourscheme.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local merge = _local_1_["merge"]
local function force_load_21(plugin0, config_callback)
  merge(plugin0, {priority = 1000, config = config_callback, lazy = false})
  return plugin0
end
local colour_themes = {plugin("EdenEast/nightfox.nvim", {dependencies = {"nvim-tree/nvim-web-devicons"}}), plugin("savq/melange-nvim"), plugin("rose-pine/neovim"), plugin("catppuccin/nvim", {name = "catppuccin"})}
local theme_index = 1
local theme = colour_themes[theme_index]
local config
local function _2_()
  return vim.cmd("colorscheme nightfox")
end
config = _2_
force_load_21(theme, config)
return colour_themes
