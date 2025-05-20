-- [nfnl] Compiled from snippets/typescript/chaos.fnl by https://github.com/Olical/nfnl, do not edit.
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
return {s("sys", fmt("export const $#: System = async (world) => {\n  const intention = new Intention();\n  return intention;\n};", {i(1)}, {delimiters = "$#"})), s("plug", fmt("import {\n  Intention,\n  ReservedKeys,\n  System,\n  World,\n} from '@persephia/chaos-engine';\nimport { Keys } from '@/game/keys';\n\nexport const $# = (world: World): World => {\n  return world;\n};", {i(1)}, {delimiters = "$#"}))}
