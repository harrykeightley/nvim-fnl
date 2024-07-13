-- [nfnl] Compiled from fnl/config/options.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local function vim_opt(option, value)
  return core.assoc(vim.o, option, value)
end
local options = {number = true, mouse = "a", clipboard = "unnamedplus", breakindent = true, updatetime = 250, timeoutlen = 300, cursorline = true, scrolloff = 10, ignorecase = true, smartcase = true, hlsearch = true, inccommand = "split", signcolumn = "yes", conceallevel = 0, hidden = true, undofile = true, termguicolors = true, splitright = true, splitbelow = true, pumblend = 10, pumheight = 10, confirm = true, tabstop = 2, shiftwidth = 2, softtabstop = 2, expandtab = true, list = true, listchars = "tab:\194\187 ,trail:\194\183,nbsp:\226\144\163", backup = false, showmode = false, wrap = false, swapfile = false, foldenable = false}
for key, value in pairs(options) do
  vim_opt(key, value)
end
return {}
