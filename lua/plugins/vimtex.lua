-- [nfnl] Compiled from fnl/plugins/vimtex.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local function _2_()
  vim.g.vimtex_view_general_viewer = "open"
  vim.g.vimtex_view_general_options = "-a Preview @pdf"
  return nil
end
return plugin("lervag/vimtex", {init = _2_, lazy = false})
