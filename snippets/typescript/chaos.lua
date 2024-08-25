-- [nfnl] Compiled from snippets/typescript/chaos.fnl by https://github.com/Olical/nfnl, do not edit.
local ls = require("luasnip")
local _local_1_ = ls
local s = _local_1_["snippet"]
local sn = _local_1_["snippet_node"]
local t = _local_1_["text_node"]
local i = _local_1_["insert_node"]
local f = _local_1_["function_node"]
local d = _local_1_["dynamic_node"]
local _local_2_ = require("luasnip.extras.fmt")
local fmt = _local_2_["fmt"]
local fmta = _local_2_["fmta"]
local _local_3_ = require("luasnip.extras")
local rep = _local_3_["rep"]
return {s("sys", fmt("export const $#: System = async (world) => {\n  const intention = new Intention();\n  return intention;\n};", {i(1)}, {delimiters = "$#"})), s("plug", fmt("import {\n  Intention,\n  ReservedKeys,\n  System,\n  World,\n} from '@persephia/chaos-engine';\nimport { Keys } from '@/game/keys';\n\nexport const $# = (world: World): World => {\n  return world;\n};", {i(1)}, {delimiters = "$#"}))}
