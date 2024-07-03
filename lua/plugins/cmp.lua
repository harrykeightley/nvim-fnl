-- [nfnl] Compiled from fnl/plugins/cmp.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local function config()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  luasnip.config.setup()
  local function _2_(args)
    return luasnip.lsp_expand(args.body)
  end
  return cmp.setup({snippet = {expand = _2_}, completion = {completeopt = "menu,menuone,noinsert"}, mapping = cmp.mapping.preset.insert({["<C-n>"] = cmp.mapping.select_next_item()}, "<C-p>", cmp.mapping.select_prev_item(), "<C-b>", cmp.mapping.scroll_docs(-4), "<C-f>", cmp.mapping.scroll_docs(4), "<C-y>", cmp.mapping.confirm({select = true}), "<C-Space>", cmp.mapping.complete()), sources = {{name = "nvim_lsp"}, {name = "luasnip"}, {name = "path"}}})
end
local _3_
do
  local is_windows_3f = (vim.fn.has("win32") == 1)
  local has_make_3f = (vim.fn.executable("make") == 1)
  if (is_windows_3f or not has_make_3f) then
    _3_ = "make install_jsregexp"
  else
    _3_ = nil
  end
end
return plugin("hrsh7th/nvim-cmp", {event = "InsertEnter", dependencies = {plugin("L3MON4D3/LuaSnip", {build = _3_}), "saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path"}, config = config})
