-- [nfnl] Compiled from fnl/plugins/neotree.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local merge = _local_1_["merge"]
local plugin_keys = _local_1_["plugin-keys"]
local function command(opts)
  local cmd = require("neo-tree.command")
  return cmd.execute(opts)
end
local window_opts
local function _2_(state)
  local node = (state.tree):get_node()
  local path = node:get_id()
  return vim.fn.setreg("+", path, "c")
end
window_opts = {mappings = {l = "open", h = "close_node", ["<space>"] = "none", Y = {_2_, desc = "Copy path to clipboard"}, P = {"toggle_preview", config = {use_float = false}}}}
local function _3_()
  return command({toggle = true, dir = vim.uv.cwd()})
end
local function _4_()
  return vim.cmd("Neotree close")
end
return plugin("nvim-neo-tree/neo-tree.nvim", {version = "*", dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim"}, cmd = "Neotree", keys = {plugin_keys("<leader>e", _3_, {desc = "Toggle explorer"})}, deactivate = _4_, opts = {sources = {"filesystem", "buffers", "git_status"}, open_files_do_not_replace_types = {"terminal", "Trouble", "trouble", "qf", "Outline"}, window = window_opts}})
