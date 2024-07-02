-- [nfnl] Compiled from fnl/plugins/lspconfig.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local setup_plugin = _local_1_["setup-plugin"]
local keys = _local_1_["keys"]
local _local_2_ = require("keymap")
local map = _local_2_["map"]
local function bmap(buffer, keys0, func, desc)
  return map("n", keys0, func, {desc = ("LSP: " .. desc), buffer = buffer})
end
local function tsb(name)
  return (require("telescope.builtin"))[name]
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
  do
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
      local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", {clear = false})
      local create_autocmd
      local function _9_(events, group, callback, buffer_3f)
        return vim.api.nvim_create_autocmd(events, {group = group, callback = callback, buffer = buffer_3f})
      end
      create_autocmd = _9_
      create_autocmd({"CursorHold", "CursorHoldI"}, highlight_augroup, vim.lsp.buf.document_highlight, event.buf)
      create_autocmd({"CursorMoved", "CursorMovedI"}, highlight_augroup, vim.lsp.buf.clear_references, event.buf)
      local function _10_(e)
        vim.lsp.buf.clear_references()
        return vim.api.nvim_clear_autocmds({group = "lsp-highlight", buffer = e.buf})
      end
      create_autocmd("LspDetach", vim.api.nvim_create_augroup("lsp-detatch", {clear = true}), _10_, event.buf)
    else
    end
  end
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local cmp = require("cmp_nvim_lsp")
  local capabilities0 = vim.tbl_deep_extend("force", capabilities, cmp.default_capabilities())
  local servers = {lua_ls = {settings = {Lua = {completion = {callSnippet = "Replace"}}}}}
  local mason = require("mason")
  local _ = mason.setup()
  local ensure_installed = keys((servers or {}))
  local tool_installer = require("mason-tool-installer")
  local mason_lspconfig = require("mason-lspconfig")
  tool_installer.setup({ensure_installed = ensure_installed})
  local function _12_(server_name)
    local server = (servers[server_name] or {})
    local server_capabilities = vim.tbl_deep_extend("force", {}, capabilities0, (server.capabilities or {}))
    local lspconfig = require("lspconfig")
    local lspserver = lspconfig[server_name]
    return lspserver.setup(server)
  end
  return mason_lspconfig.setup({handlers = {_12_}})
end
local function config()
  return vim.api.nvim_create_autocmd("LspAttach", {group = vim.api.nvim_create_augroup("lsp-attach", {clear = true}), callback = on_attach})
end
return plugin("neovim/nvim-lspconfig", {dependencies = {plugin("williamboman/mason.nvim", {config = true}), "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim", setup_plugin("j-hui/fidget.nvim"), setup_plugin("folke/neodev.nvim")}, config = config})
