-- [nfnl] Compiled from fnl/plugins/oklch-color-picker.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local plugin_keys = _local_1_["plugin-keys"]
local function _2_()
  return require("oklch-color-picker").pick_under_cursor()
end
return plugin("eero-lehtinen/oklch-color-picker.nvim", {event = "VeryLazy", version = "*", keys = {plugin_keys("<leader>vc", _2_, {mode = "n", desc = "[V]iew [C]olorpicker"})}, opts = {}})
