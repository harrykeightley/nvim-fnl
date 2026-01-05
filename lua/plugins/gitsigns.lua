-- [nfnl] Compiled from fnl/plugins/gitsigns.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local plugin_keys = _local_1_["plugin-keys"]
local function _2_()
  return vim.cmd("Gitsigns toggle_current_line_blame")
end
local function _3_()
  return vim.cmd("Gitsigns setqflist")
end
return plugin("lewis6991/gitsigns.nvim", {opts = {signs_staged_enable = true, signcolumn = true, current_line_blame = true}, keys = {plugin_keys("<leader>tgb", _2_, {mode = "", desc = "[T]oggle [G]itsigns [B]lame"}), plugin_keys("<leader>sC", _3_, {mode = "", desc = "[S]earch Git [C]hanges"})}, lazy = false})
