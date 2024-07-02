-- [nfnl] Compiled from fnl/plugins/which-key.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local function config()
  local wk = require("which-key")
  local keys = {c = "[C]ode", d = "[D]iagnostics", r = "[R]ename", s = "[S]earch", t = "[T]oggle", h = "Git [H]unk"}
  wk.setup()
  local function _2_()
    local tbl_14_auto = {}
    for key, name in pairs(keys) do
      local k_15_auto, v_16_auto = {("<leader>" .. key)}, {name = name, [_] = "which-key-ignore"}
      if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
        tbl_14_auto[k_15_auto] = v_16_auto
      else
      end
    end
    return tbl_14_auto
  end
  wk.register(_2_())
  return wk.register({[{"<leader>h"}] = {"Git [H]unk"}}, {mode = "v"})
end
return plugin("folke/which-key.nvim", {event = "VimEnter", config = config})
