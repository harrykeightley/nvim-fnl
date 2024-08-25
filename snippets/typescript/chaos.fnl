(local ls (require :luasnip))
(local {:snippet s
        :snippet_node sn
        :text_node t
        :insert_node i
        :function_node f
        :dynamic_node d} ls)

(local {: fmt : fmta} (require :luasnip.extras.fmt))
(local {: rep} (require :luasnip.extras))

[(s :sys (fmt "export const $#: System = async (world) => {
  const intention = new Intention();
  return intention;
};" [(i 1)] {:delimiters "$#"}))
 (s :plug (fmt "import {
  Intention,
  ReservedKeys,
  System,
  World,
} from '@persephia/chaos-engine';
import { Keys } from '@/game/keys';

export const $# = (world: World): World => {
  return world;
};" [(i 1)] {:delimiters "$#"}))]
