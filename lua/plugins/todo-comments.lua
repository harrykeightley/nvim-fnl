-- [nfnl] Compiled from fnl/plugins/todo-comments.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local plugin = _local_1_["plugin"]
return plugin("folke/todo-comments.nvim", {event = "VimEnter", dependencies = {"nvim-lua/plenary.nvim"}, opts = {signs = false}})
