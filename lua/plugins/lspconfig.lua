-- [nfnl] Compiled from fnl/plugins/lspconfig.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local setup_plugin = _local_1_["setup-plugin"]
local keys = _local_1_["keys"]
local merge = _local_1_["merge"]
local filter_keys = _local_1_["filter-keys"]
local _local_2_ = require("keymap")
local map = _local_2_["map"]
local server_settings = {lua_ls = {settings = {Lua = {completion = {callSnippet = "Replace"}}}}, ruff = {}, pyright = {settings = {pyright = {disableOrganizeImports = true}}}, tsserver = {}, tailwindcss = {}, fennel_language_server = {}, gdscript = {}}
local mason_ensure_installed = {"lua_ls", "tailwindcss", "fennel_language_server", "tsserver"}
local function bmap(buffer, keys0, func, desc)
  return map("n", keys0, func, {desc = ("LSP: " .. desc), buffer = buffer})
end
local function tsb(name)
  return (require("telescope.builtin"))[name]
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
local function setup_mason_lsps()
  local mason = require("mason")
  local _ = mason.setup()
  local servers = server_settings
  local tool_installer = require("mason-tool-installer")
  local mason_lspconfig = require("mason-lspconfig")
  tool_installer.setup({ensure_installed = mason_ensure_installed})
  local function _4_(server_name)
    local server = (servers[server_name] or {})
    local server_capabilities = vim.tbl_deep_extend("force", {}, base_capabilities(), (server.capabilities or {}))
    local lspconfig = require("lspconfig")
    local lspserver = lspconfig[server_name]
    server["capabilities"] = server_capabilities
    return lspserver.setup(server)
  end
  return mason_lspconfig.setup({handlers = {_4_}})
end
local function setup_server(lsp_name, options)
  local lspconfig = require("lspconfig")
  local server = lspconfig[lsp_name]
  return server.setup(options)
end
local function config()
  local lsp_zero = require("lsp-zero")
  lsp_zero.extend_lspconfig({sign_text = true, lsp_attach = lsp_attach, capabilities = base_capabilities()})
  return setup_mason_lsps()
end
return plugin("VonHeikemen/lsp-zero.nvim", {dependencies = {plugin("neovim/nvim-lspconfig"), plugin("williamboman/mason.nvim", {config = true}), plugin("williamboman/mason-lspconfig.nvim"), plugin("WhoIsSethDaniel/mason-tool-installer.nvim"), setup_plugin("j-hui/fidget.nvim"), setup_plugin("folke/neodev.nvim")}, config = config})
