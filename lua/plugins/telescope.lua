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
local function setup_buffer_search()
  local builtin = require("telescope.builtin")
  local action_state = require("telescope.actions.state")
  local actions = require("telescope.actions")
  local buffer_search
  local function _search()
    local function _3_(prompt_bufnr, map)
      local refresh
      local function _4_()
        actions.close(prompt_bufnr)
        return vim.schedule(_search)
      end
      refresh = _4_
      local delete_buf
      local function _5_()
        local selection = action_state.get_selected_entry()
        vim.api.nvim_buf_delete(selection.bufnr, {force = true})
        return refresh()
      end
      delete_buf = _5_
      local delete_bufs
      local function _6_()
        local picker = action_state.get_current_picker(prompt_bufnr)
        local selection = picker:get_multi_selection()
        for _, entry in ipairs(selection) do
          vim.api.nvim_buf_delete(entry.bufnr, {force = true})
        end
        return refresh()
      end
      delete_bufs = _6_
      map("n", "dd", delete_buf)
      map("n", "<C-d>", delete_buf)
      map("i", "<C-d>", delete_buf)
      return true
    end
    return builtin.buffers({sort_mru = true, ignore_current_buffer = true, attach_mappings = _3_, show_all_buffers = false})
  end
  buffer_search = _search
  return nmap("<leader>sb", buffer_search, {desc = "Search buffers"})
end
local function _7_()
  return (1 == vim.fn.executable("make"))
end
local function _8_()
  local telescope = require("telescope")
  local themes = require("telescope.themes")
  telescope.setup({defaults = {file_ignore_patterns = {"node_modules"}, vimgrep_arguments = {"rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--iglob", "!.git", "--hidden"}, sorting_strategy = "ascending", layout_strategy = "horizontal", layout_config = {prompt_position = "top", height = 0.8}}, extensions = {["ui-select"] = {themes.get_dropdown({})}}, pickers = {find_files = {find_command = {"rg", "--files", "--iglob", "!.git", "--hidden"}}}})
  telescope_keymap("f", "find_files", "Search for files in the current directory")
  telescope_keymap("g", "live_grep")
  telescope_keymap("h", "help_tags")
  telescope_keymap("c", "colorscheme")
  telescope_keymap("d", "diagnostics")
  setup_buffer_search()
  telescope.load_extension("fzf")
  return telescope.load_extension("ui-select")
end
return plugin("nvim-telescope/telescope.nvim", {dependencies = {"nvim-telescope/telescope-ui-select.nvim", plugin("nvim-telescope/telescope-fzf-native.nvim", {build = "make", cond = _7_}), plugin("nvim-tree/nvim-web-devicons", {enabled = vim.g.have_nerd_font}), "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"}, config = _8_})
