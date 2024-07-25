-- [nfnl] Compiled from fnl/plugins/conjure.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local function _2_()
  vim.g["conjure#mapping#doc_word"] = false
  return nil
end
return plugin("Olical/conjure", {init = _2_})
