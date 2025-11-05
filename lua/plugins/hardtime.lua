-- [nfnl] Compiled from fnl/plugins/hardtime.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local plugin_keys = _local_1_["plugin-keys"]
local function _2_()
  return vim.cmd("Hardtime toggle")
end
return plugin("m4xshen/hardtime.nvim", {dependencies = {"MunifTanjim/nui.nvim"}, opts = {enabled = false}, keys = {plugin_keys("<leader>th", _2_, {mode = "", desc = "[T]oggle [H]ardtime"})}, lazy = false})
