-- [nfnl] Compiled from snippets/typescriptreact/react.fnl by https://github.com/Olical/nfnl, do not edit.
local ls = require("luasnip")
local s = ls["snippet"]
local sn = ls["snippet_node"]
local t = ls["text_node"]
local i = ls["insert_node"]
local f = ls["function_node"]
local d = ls["dynamic_node"]
local _local_1_ = require("luasnip.extras.fmt")
local fmt = _local_1_["fmt"]
local fmta = _local_1_["fmta"]
local _local_2_ = require("luasnip.extras")
local rep = _local_2_["rep"]
return {s("fn", fmt("function $#($#) {\n  $#\n};", {i(1), i(2), i(3)}, {delimiters = "$#"})), s("afn", fmt("async function $#($#) {\n  $#\n};", {i(1), i(2), i(3)}, {delimiters = "$#"})), s("refn", fmt("type $#Props = {\n  $#\n}\n\nexport function $#({$#}: $#Props) {\n  return <div></div>\n};", {i(1), i(2), rep(1), i(3), rep(1)}, {delimiters = "$#"}))}
