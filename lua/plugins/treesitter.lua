-- [nfnl] Compiled from fnl/plugins/treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local ensure_installed = {"bash", "fish", "vim", "vimdoc", "clojure", "commonlisp", "dockerfile", "fennel", "html", "java", "javascript", "typescript", "tsx", "astro", "json", "lua", "markdown", "yaml", "python"}
local function _2_()
  local treesitter = require("nvim-treesitter.configs")
  return treesitter.setup({highlight = {enable = true}, indent = {enable = true}, ensure_installed = ensure_installed})
end
return plugin("nvim-treesitter/nvim-treesitter", {build = ":TSUpdate", config = _2_})
