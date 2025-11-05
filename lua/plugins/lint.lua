-- [nfnl] Compiled from fnl/plugins/lint.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local plugin_keys = _local_1_["plugin-keys"]
local linters = {python = {"ruff"}, go = {"golangcilint"}, typescriptreact = {"eslint_d"}, javascriptreact = {"eslint_d"}, typescript = {"eslint_d"}, javascript = {"eslint_d"}}
local function view_linters()
  local lint = require("lint")
  local linters0 = lint.get_running()
  if (#linters0 == 0) then
    return print("No linters running.")
  else
    return print(("Linters: " .. table.concat(linters0, ", ")))
  end
end
local function config()
  local lint = require("lint")
  local lint_group = vim.api.nvim_create_augroup("lint", {clear = true})
  lint.linters_by_ft = linters
  local function _3_()
    return lint.try_lint()
  end
  return vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost", "InsertLeave"}, {group = lint_group, callback = _3_})
end
return plugin("mfussenegger/nvim-lint", {event = {"BufReadPre", "BufNewFile"}, config = config, keys = {plugin_keys("<leader>vl", view_linters, {mode = "n", desc = "[V]iew [L]inters"})}})
