-- [nfnl] Compiled from fnl/plugins/lint.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local linters = {python = {"ruff"}, typescriptreact = {"eslint_d"}, javascriptreact = {"eslint_d"}, typescript = {"eslint_d"}, javascript = {"eslint_d"}}
local function config()
  local lint = require("lint")
  local lint_group = vim.api.nvim_create_augroup("lint", {clear = true})
  do end (lint)["linters_by_ft"] = linters
  local function _2_()
    local lint0 = require("lint")
    return lint0.try_lint()
  end
  return vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost", "InsertLeave"}, {group = lint_group, callback = _2_})
end
return plugin("mfussenegger/nvim-lint", {event = {"BufReadPre", "BufNewFile"}, config = config})
