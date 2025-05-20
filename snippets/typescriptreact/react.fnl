(local ls (require :luasnip))
(local {:snippet s
        :snippet_node sn
        :text_node t
        :insert_node i
        :function_node f
        :dynamic_node d} ls)

(local {: fmt : fmta} (require :luasnip.extras.fmt))
(local {: rep} (require :luasnip.extras))

[(s :fn (fmt "function $#($#) {\n  $#\n};" [(i 1) (i 2) (i 3)]
             {:delimiters "$#"}))
 (s :afn (fmt "async function $#($#) {\n  $#\n};" [(i 1) (i 2) (i 3)]
              {:delimiters "$#"}))
 (s :refn (fmt "type $#Props = {
  $#
}

export function $#({$#}: $#Props) {
  return <div></div>
};" [(i 1) (i 2) (rep 1) (i 3) (rep 1)] {:delimiters "$#"}))]
