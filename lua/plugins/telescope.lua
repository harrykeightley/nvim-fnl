-- [nfnl] Compiled from fnl/plugins/telescope.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local _local_2_ = require("keymap")
local nmap = _local_2_["nmap"]
local telescope_prefix = "<leader>s"
local function tsc(name)
  return (":lua require('telescope.builtin')." .. name .. "()<CR>")
end
local function telescope_keymap(key, fn_name, description_3f)
  return nmap((telescope_prefix .. key), tsc(fn_name), {noremap = true, desc = (description_3f or ("Telescope " .. fn_name))})
end
local function _3_()
  return (1 == vim.fn.executable("make"))
end
local function _4_()
  telescope_keymap("f", "find_files", "Search for files in the current directory")
  telescope_keymap("g", "live_grep")
  telescope_keymap("b", "buffers")
  return telescope_keymap("h", "help_tags")
end
local function _5_()
  local telescope = require("telescope")
  local themes = require("telescope.themes")
  telescope.setup({defaults = {file_ignore_patterns = {"node_modules"}, vimgrep_arguments = {"rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--iglob", "!.git", "--hidden"}}, extensions = {["ui-select"] = {themes.get_dropdown({})}}, pickers = {find_files = {find_command = {"rg", "--files", "--iglob", "!.git", "--hidden"}}}})
  telescope.load_extension("fzf")
  return telescope.load_extension("ui-select")
end
return plugin("nvim-telescope/telescope.nvim", {dependencies = {"nvim-telescope/telescope-ui-select.nvim", plugin("nvim-telescope/telescope-fzf-native.nvim", {build = "make", cond = _3_}), plugin("nvim-tree/nvim-web-devicons", {enabled = vim.g.have_nerd_font}), "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"}, init = _4_, config = _5_})
