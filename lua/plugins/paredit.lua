-- [nfnl] Compiled from fnl/plugins/paredit.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local function _2_()
  local paredit = require("nvim-paredit")
  return paredit.setup()
end
local function _3_()
  local paredit_fnl = require("nvim-paredit-fennel")
  return paredit_fnl.setup()
end
return {plugin("julienvincent/nvim-paredit", {lazy = true, ft = {"clojure", "fennel"}, config = _2_}), plugin("julienvincent/nvim-paredit-fennel", {dependencies = {"julienvincent/nvim-paredit"}, lazy = true, ft = {"fennel"}, config = _3_})}
