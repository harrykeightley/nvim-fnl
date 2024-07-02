-- [nfnl] Compiled from fnl/keymap.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local merge = _local_1_["merge"]
local function map(mode, lhs, rhs, opts_3f)
  return vim.keymap.set(mode, lhs, rhs, (opts_3f or {}))
end
local nmap
local function _2_(...)
  return map("n", ...)
end
nmap = _2_
local imap
local function _3_(...)
  return map("i", ...)
end
imap = _3_
local function keymap_with_defaults(default_options)
  local function _4_(mode, lhs, rhs, opts_3f)
    return map(mode, lhs, rhs, merge(default_options, (opts_3f or {})))
  end
  return _4_
end
return {map = map, nmap = nmap, imap = imap, ["keymap-with-defaults"] = keymap_with_defaults}
