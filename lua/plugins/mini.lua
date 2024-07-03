-- [nfnl] Compiled from fnl/plugins/mini.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
local function config()
  local ai = require("mini.ai")
  local surround = require("mini.surround")
  local statusline = require("mini.statusline")
  ai.setup({n_lines = 500})
  surround.setup()
  statusline.setup({use_icons = vim.g.have_nerd_font})
  local function _2_()
    return "%2l:%-2v"
  end
  statusline.section_location = _2_
  return nil
end
return plugin("echasnovski/mini.nvim", {config = config})
