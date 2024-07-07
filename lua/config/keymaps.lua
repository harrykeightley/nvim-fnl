-- [nfnl] Compiled from fnl/config/keymaps.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local merge = _local_1_["merge"]
local _local_2_ = require("keymap")
local map = _local_2_["map"]
map({"n", "x"}, "j", "v:count == 0 ? 'gj' : 'j'", {desc = "Down", expr = true, silent = true})
map({"n", "x"}, "<Down>", "v:count == 0 ? 'gj' : 'j'", {desc = "Down", expr = true, silent = true})
map({"n", "x"}, "k", "v:count == 0 ? 'gk' : 'k'", {desc = "Up", expr = true, silent = true})
map({"n", "x"}, "<Up>", "v:count == 0 ? 'gk' : 'k'", {desc = "Up", expr = true, silent = true})
map("n", "<C-h>", "<C-w>h", {desc = "Go to Left Window", remap = true})
map("n", "<C-j>", "<C-w>j", {desc = "Go to Lower Window", remap = true})
map("n", "<C-k>", "<C-w>k", {desc = "Go to Upper Window", remap = true})
map("n", "<C-l>", "<C-w>l", {desc = "Go to Right Window", remap = true})
map("n", "<S-h>", "<cmd>bprevious<cr>", {desc = "Prev Buffer"})
map("n", "<S-l>", "<cmd>bnext<cr>", {desc = "Next Buffer"})
map({"i", "n"}, "<esc>", "<cmd>noh<cr><esc>", {desc = "Escape and Clear hlsearch"})
map("n", "<leader>dk", vim.diagnostic.goto_prev, {desc = "[D]iagnostics previous"})
map("n", "<leader>dj", vim.diagnostic.goto_next, {desc = "[D]iagnostics next"})
map("n", "<leader>dl", vim.diagnostic.open_float, {desc = "[D]iagnostics line"})
return {}
