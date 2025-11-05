-- [nfnl] Compiled from fnl/plugins/gitsigns.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local plugin_keys = _local_1_["plugin-keys"]
local function _2_()
  return vim.cmd("Gitsigns toggle_current_line_blame")
end
return plugin("lewis6991/gitsigns.nvim", {opts = {}, keys = {plugin_keys("<leader>tgb", _2_, {mode = "", desc = "[T]oggle [G]itsigns [B]lame"})}})
