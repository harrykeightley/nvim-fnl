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
      t_2_ = (t_2_)[filetype]
    else
    end
    _3_ = t_2_
  end
  return not _3_
end
local function _5_()
  local conform = require("conform")
  return conform.format({async = true, lsp_fallback = true, mode = "", desc = "[F]ormat buffer"})
end
local function _6_(bufnr)
  return {timeout_ms = 500, lsp_fallback = should_save_3f(vim.bo[bufnr].filetype)}
end
return plugin("stevearc/conform.nvim", {keys = {plugin_keys("<leader>f", _5_)}, opts = {format_on_save = _6_, formatters_by_ft = {lua = {"stylua"}}, notify_on_error = false}, lazy = false})
