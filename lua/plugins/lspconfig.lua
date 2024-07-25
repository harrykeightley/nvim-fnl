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
local mason_managed_lsps = {"lua_ls", "tsserver", "tailwindcss", "fennel_language_server"}
local group_names = {attach = "hjk-attach", detach = "hjk-detach", highlight = "hjk-highlight"}
local function bmap(buffer, keys0, func, desc)
  return map("n", keys0, func, {desc = ("LSP: " .. desc), buffer = buffer})
end
local function tsb(name)
  return (require("telescope.builtin"))[name]
end
local function augroup(name, _3fopts)
  return vim.api.nvim_create_augroup(name, merge({clear = false}, (_3fopts or {})))
end
local function autocmd(events, _3fopts)
  return vim.api.nvim_create_autocmd(events, (_3fopts or {}))
end
local function on_attach(event)
  do
    local bmap0
    do
      local _3_ = event.buf
      local function _4_(...)
        return bmap(_3_, ...)
      end
      bmap0 = _4_
    end
    bmap0("gd", tsb("lsp_definitions"), "[G]oto [D]efinition")
    bmap0("gr", tsb("lsp_references"), "[G]oto [R]eferences")
    bmap0("gI", tsb("lsp_implementations"), "[G]oto [I]mplementations")
    bmap0("gD", tsb("lsp_type_definitions"), "[G]oto Type [D]efinitions")
    bmap0("gs", tsb("lsp_document_symbols"), "[G]oto [S]ymbols")
    bmap0("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    bmap0("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    bmap0("K", vim.lsp.buf.hover, "Hover Documentation")
  end
  local client = vim.lsp.get_client_by_id(event.data.client_id)
  local can_highlight_3f
  local function _5_()
    local t_6_ = client
    if (nil ~= t_6_) then
      t_6_ = (t_6_).server_capabilities
    else
    end
    if (nil ~= t_6_) then
      t_6_ = (t_6_).documentHighlightProvider
    else
    end
    return t_6_
  end
  can_highlight_3f = (client and _5_())
  if can_highlight_3f then
    local highlight_augroup = augroup(group_names.highlight)
    autocmd({"CursorHold", "CursorHoldI"}, {buffer = event.buf, group = highlight_augroup, callback = vim.lsp.buf.document_highlight})
    autocmd({"CursorMoved", "CursorMovedI"}, {buffer = event.buf, group = highlight_augroup, callback = vim.lsp.buf.clear_references})
    local function _9_(other_event)
      vim.lsp.buf.clear_references()
      return vim.api.nvim_clear_autocmds({group = group_names.highlight, buffer = other_event.buf})
    end
    return autocmd("LspDetach", {group = augroup(group_names.detach), callback = _9_})
  else
    return nil
  end
end
local function setup_server(lsp_name, options)
  local lspconfig = require("lspconfig")
  local server = lspconfig[lsp_name]
  return server.setup(options)
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
  local ensure_installed = mason_managed_lsps
  local tool_installer = require("mason-tool-installer")
  local mason_lspconfig = require("mason-lspconfig")
  tool_installer.setup({ensure_installed = ensure_installed})
  local function _11_(server_name)
    local server
    local function _12_()
      local t_13_ = servers
      if (nil ~= t_13_) then
        t_13_ = (t_13_)[server_name]
      else
      end
      return t_13_
    end
    server = (_12_() or {})
    local server_capabilities = vim.tbl_deep_extend("force", {}, base_capabilities(), (server.capabilities or {}))
    local lspconfig = require("lspconfig")
    local lspserver = lspconfig[server_name]
    server.capabilities = server_capabilities
    return lspserver.setup(server)
  end
  return mason_lspconfig.setup({handlers = {_11_}})
end
local function setup_nonmason_lsps()
  local servers = filter_keys(server_settings, mason_managed_lsps)
  local capabilities = base_capabilities()
  for name, options in pairs(servers) do
    local server_capabilities = vim.tbl_deep_extend("force", {}, capabilities, (options.capabilities or {}))
    setup_server(name, merge(options, {capabilities = server_capabilities}))
  end
  return nil
end
local function config()
  autocmd("LspAttach", {group = augroup(group_names.attach), callback = on_attach})
  setup_mason_lsps()
  return setup_nonmason_lsps()
end
return plugin("neovim/nvim-lspconfig", {dependencies = {plugin("williamboman/mason.nvim", {config = true}), "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim", setup_plugin("j-hui/fidget.nvim"), setup_plugin("folke/neodev.nvim")}, config = config})
