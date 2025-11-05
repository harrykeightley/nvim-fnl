-- [nfnl] Compiled from fnl/plugins/vimtex.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local function set_open_with_finder()
  vim.g.vimtex_view_general_viewer = "open"
  vim.g.vimtex_view_general_options = "-a Preview @pdf"
  return nil
end
local function open_with_skim()
  vim.g.vimtex_view_method = "skim"
  return nil
end
return plugin("lervag/vimtex", {init = open_with_skim, lazy = false})
