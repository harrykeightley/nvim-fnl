-- [nfnl] Compiled from fnl/plugins/which-key.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local notify = _local_1_["notify"]
local function config(...)
  local wk = require("which-key")
  wk.setup()
  wk.register({c = {name = "[C]ode+"}, d = {name = "[D]iagnostics+"}, r = {name = "[R]ename+"}, s = {name = "[S]earch+"}, t = {name = "[T]oggle+"}, h = {name = "Git [H]unk+"}}, {prefix = "<leader>"})
  return wk.register({["<leader>h"] = {"Git [H]unk"}}, {mode = "v"})
end
return plugin("folke/which-key.nvim", {event = "VimEnter", config = config})
