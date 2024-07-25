-- [nfnl] Compiled from fnl/plugins/tmux.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local _local_2_ = require("keymap")
local nmap = _local_2_["nmap"]
local function _3_()
  local nav = require("nvim-tmux-navigation")
  nav.setup({disable_when_zoomed = true})
  nmap("<C-h>", nav.NvimTmuxNavigateLeft, {desc = "Go to Left Window"})
  nmap("<C-j>", nav.NvimTmuxNavigateDown, {desc = "Go to Lower Window"})
  nmap("<C-k>", nav.NvimTmuxNavigateUp, {desc = "Go to Upper Window"})
  return nmap("<C-l>", nav.NvimTmuxNavigateRight, {desc = "Go to Right Window"})
end
return plugin("alexghergh/nvim-tmux-navigation", {config = _3_})
