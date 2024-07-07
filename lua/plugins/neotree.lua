-- [nfnl] Compiled from fnl/plugins/neotree.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local merge = _local_1_["merge"]
local plugin_keys = _local_1_["plugin-keys"]
local function command(opts)
  local cmd = require("neo-tree.command")
  return cmd.execute(opts)
end
local function init()
  local function _2_()
    if not package.loaded["neo-tree"] then
      local stats = vim.uv.fs_stat(vim.fn.argv(0))
      local is_dir_3f = (stats and (stats.type == "directory"))
      if is_dir_3f then
        return require("neo-tree")
      else
        return nil
      end
    else
      return nil
    end
  end
  return vim.api.nvim_create_autocmd("BufEnter", {group = vim.api.nvim_create_augroup("neotree-start-directory", {clear = true}), desc = "Start Neotree with a directory", once = true, callback = _2_})
end
local window_opts
local function _5_(state)
  local node = (state.tree):get_node()
  local path = node:get_id()
  return vim.fn.setreg("+", path, "c")
end
window_opts = {mappings = {l = "open", h = "close_node", ["<space>"] = "none", Y = {_5_, desc = "Copy path to clipboard"}, P = {"toggle_preview", config = {use_float = false}}}}
local function _6_()
  return command({toggle = true, dir = vim.uv.cwd()})
end
local function _7_()
  return vim.cmd("Neotree close")
end
return plugin("nvim-neo-tree/neo-tree.nvim", {version = "*", dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim"}, cmd = "Neotree", keys = {plugin_keys("<leader>e", _6_, {desc = "Toggle explorer"})}, deactivate = _7_, init = init, opts = {sources = {"filesystem", "buffers", "git_status"}, open_files_do_not_replace_types = {"terminal", "Trouble", "trouble", "qf", "Outline"}, window = window_opts, filesystem = {follow_current_file = {enabled = true}, use_libuv_file_watcher = true, filtered_items = {visible = true, show_hidden_count = true, hide_gitignored = true, hide_by_name = {".DS_Store"}, hide_dotfiles = false}, bind_to_cwd = false}}})
