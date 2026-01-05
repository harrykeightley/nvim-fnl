-- [nfnl] fnl/plugins/lspconfig.fnl
local _local_1_ = require("utils")
local plugin = _local_1_.plugin
local setup_plugin = _local_1_["setup-plugin"]
local keys = _local_1_.keys
local merge = _local_1_.merge
local filter_keys = _local_1_["filter-keys"]
local _local_2_ = require("keymap")
local map = _local_2_.map
local server_settings = {lua_ls = {settings = {Lua = {completion = {callSnippet = "Replace"}}}}, gopls = {}, ruff = {}, pyright = {settings = {pyright = {disableOrganizeImports = true}}}, ts_ls = {}, tailwindcss = {}, fennel_language_server = {}, gdscript = {}, texlab = {}, astro = {}, rust_analyzer = {}}
local function bmap(buffer, keys0, func, desc)
  return map("n", keys0, func, {desc = ("LSP: " .. desc), buffer = buffer})
end
local function tsb(name)
  return require("telescope.builtin")[name]
end
local function lsp_attach(client, bufnr)
  local bmap0
  local function _3_(...)
    return bmap(bufnr, ...)
  end
  bmap0 = _3_
  bmap0("gd", tsb("lsp_definitions"), "[G]oto [D]efinition")
  bmap0("gr", tsb("lsp_references"), "[G]oto [R]eferences")
  bmap0("gI", tsb("lsp_implementations"), "[G]oto [I]mplementations")
  bmap0("gD", tsb("lsp_type_definitions"), "[G]oto Type [D]efinitions")
  bmap0("gs", tsb("lsp_document_symbols"), "[G]oto [S]ymbols")
  bmap0("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  bmap0("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
  return bmap0("K", vim.lsp.buf.hover, "Hover Documentation")
end
local function base_capabilities()
  local cmp = require("cmp_nvim_lsp")
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  return vim.tbl_deep_extend("force", capabilities, cmp.default_capabilities())
end
local function setup_lsps()
  for lsp_name, options in pairs(server_settings) do
    vim.lsp.config(lsp_name, options)
    vim.lsp.enable(lsp_name)
  end
  return nil
end
local function config()
  local lsp_zero = require("lsp-zero")
  lsp_zero.extend_lspconfig({sign_text = true, lsp_attach = lsp_attach, capabilities = base_capabilities()})
  return setup_lsps()
end
return plugin("VonHeikemen/lsp-zero.nvim", {dependencies = {plugin("neovim/nvim-lspconfig"), plugin("williamboman/mason.nvim", {config = true}), plugin("williamboman/mason-lspconfig.nvim"), plugin("WhoIsSethDaniel/mason-tool-installer.nvim"), setup_plugin("j-hui/fidget.nvim"), setup_plugin("folke/neodev.nvim")}, config = config})
