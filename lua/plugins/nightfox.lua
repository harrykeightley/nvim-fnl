-- [nfnl] Compiled from fnl/plugins/nightfox.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local function _2_()
  return vim.cmd("colorscheme nightfox")
end
return plugin("EdenEast/nightfox.nvim", {dependencies = {"nvim-tree/nvim-web-devicons"}, priority = 1000, config = _2_})
