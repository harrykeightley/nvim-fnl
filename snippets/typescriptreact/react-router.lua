-- [nfnl] Compiled from snippets/typescriptreact/react-router.fnl by https://github.com/Olical/nfnl, do not edit.
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
return {s("rrl", fmt("export async function loader({ $# }: Route.LoaderArgs) {\n  $#\n};", {i(1), i(2)}, {delimiters = "$#"})), s("rra", fmt("export async function action({ $# }: Route.ActionArgs) {\n  $#\n};", {i(1), i(2)}, {delimiters = "$#"})), s("rrp", fmt("export default function Page() {\n  return <>$#</>\n};", {i(1)}, {delimiters = "$#"}))}
