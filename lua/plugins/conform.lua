-- [nfnl] Compiled from fnl/plugins/conform.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local plugin_keys = _local_1_["plugin-keys"]
local disabled_filetypes = {c = true, cpp = true}
local function should_save_3f(filetype)
  local _3_
  do
    local t_2_ = disabled_filetypes
    if (nil ~= t_2_) then
      t_2_ = t_2_[filetype]
    else
    end
    _3_ = t_2_
  end
  return not _3_
end
local function _5_()
  local conform = require("conform")
  return conform.format({async = true, lsp_fallback = true})
end
return plugin("stevearc/conform.nvim", {keys = {plugin_keys("<leader>f", _5_, {mode = "", desc = "[F]ormat buffer"})}, opts = {notify_on_error = true, formatters = {gdformat = {prepend_args = {"--use-spaces=2", "--line-length=80"}}}, formatters_by_ft = {lua = {"stylua"}, rust = {"rustfmt"}, fennel = {"fnlfmt"}, python = {"ruff_format"}, typescript = {"prettierd", "prettier", "eslint_d"}, javascript = {"prettierd", "prettier", "eslint_d"}, json = {"jq"}, typescriptreact = {"prettierd", "eslint_d"}, html = {"prettierd"}, gdscript = {"gdformat"}}}, lazy = false})
