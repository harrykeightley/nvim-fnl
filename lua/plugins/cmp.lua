-- [nfnl] Compiled from fnl/plugins/cmp.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local _local_2_ = require("keymap")
local nmap = _local_2_["nmap"]
local map = _local_2_["map"]
local cmp_sources = {{name = "nvim_lsp"}, {name = "luasnip"}, {name = "conjure"}, {name = "buffer"}}
local dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path", "PaterJason/cmp-conjure", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip"}
local snippets_paths = {"~/.config/nvim/snippets"}
local function make_snippet_keymaps(luasnip, loader)
  local function _3_()
    return loader.load({paths = snippets_paths})
  end
  return nmap("<leader>cs", _3_, {desc = "Reload snippets"})
end
local function config()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local snippet_loader = require("luasnip.loaders.from_lua")
  luasnip.config.setup()
  snippet_loader.lazy_load({paths = snippets_paths})
  make_snippet_keymaps(luasnip, snippet_loader)
  local function _4_(args)
    return luasnip.lsp_expand(args.body)
  end
  return cmp.setup({snippet = {expand = _4_}, completion = {completeopt = "menu,menuone,noinsert"}, mapping = cmp.mapping.preset.insert({["<C-n>"] = cmp.mapping.select_next_item(), ["<C-p>"] = cmp.mapping.select_prev_item(), ["<C-b>"] = cmp.mapping.scroll_docs(( - 4)), ["<C-f>"] = cmp.mapping.scroll_docs(4), ["<C-Space>"] = cmp.mapping.complete(), ["<C-e>"] = cmp.mapping.abort(), ["<CR>"] = cmp.mapping.confirm({select = true})}), sources = cmp_sources})
end
return plugin("hrsh7th/nvim-cmp", {event = "InsertEnter", dependencies = dependencies, config = config})
