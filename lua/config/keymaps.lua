-- [nfnl] Compiled from fnl/config/keymaps.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local merge = _local_1_["merge"]
local _local_2_ = require("keymap")
local map = _local_2_["map"]
local _local_3_ = require("config.diagnostics")
local jump_by_severity = _local_3_["jump-by-severity"]
map({"n", "x"}, "j", "v:count == 0 ? 'gj' : 'j'", {desc = "Down", expr = true, silent = true})
map({"n", "x"}, "<Down>", "v:count == 0 ? 'gj' : 'j'", {desc = "Down", expr = true, silent = true})
map({"n", "x"}, "k", "v:count == 0 ? 'gk' : 'k'", {desc = "Up", expr = true, silent = true})
map({"n", "x"}, "<Up>", "v:count == 0 ? 'gk' : 'k'", {desc = "Up", expr = true, silent = true})
map("n", "<S-h>", "<cmd>bprevious<cr>", {desc = "Prev Buffer"})
map("n", "<S-l>", "<cmd>bnext<cr>", {desc = "Next Buffer"})
map({"i", "n"}, "<esc>", "<cmd>noh<cr><esc>", {desc = "Escape and Clear hlsearch"})
local function _4_()
  return jump_by_severity(-1)
end
map("n", "<leader>dk", _4_, {desc = "[D]iagnostics previous"})
local function _5_()
  return jump_by_severity(1)
end
map("n", "<leader>dj", _5_, {desc = "[D]iagnostics next"})
map("n", "<leader>dl", vim.diagnostic.open_float, {desc = "[D]iagnostics line"})
local _local_6_ = require("nfnl.module")
local autoload = _local_6_["autoload"]
local core = autoload("nfnl.core")
local function vim_opt(option, value)
  return core.assoc(vim.o, option, value)
end
local function _7_()
  return vim_opt("expandtab", not vim.o.expandtab)
end
map("n", "<leader>tt", _7_, {desc = "[T]oggle [T]abs as spaces"})
return {}
