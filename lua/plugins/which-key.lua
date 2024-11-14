-- [nfnl] Compiled from fnl/plugins/which-key.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local notify = _local_1_["notify"]
local function which_binding(keys, _3fopts)
  return plugin(keys, _3fopts)
end
local function config(...)
  local wk = require("which-key")
  wk.setup()
  return wk.add({which_binding("<leader>c", {group = "[C]ode+"}), which_binding("<leader>d", {group = "[D]iagnostics+"}), which_binding("<leader>r", {group = "[R]ename+"}), which_binding("<leader>s", {group = "[S]earch+"}), which_binding("<leader>t", {group = "[T]oggle+"})})
end
return plugin("folke/which-key.nvim", {event = "VimEnter", config = config})
