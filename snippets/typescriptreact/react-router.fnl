(local ls (require :luasnip))
(local {:snippet s
        :snippet_node sn
        :text_node t
        :insert_node i
        :function_node f
        :dynamic_node d} ls)

(local {: fmt : fmta} (require :luasnip.extras.fmt))
(local {: rep} (require :luasnip.extras))

[(s :rrl (fmt "export async function loader({ $# }: Route.LoaderArgs) {\n  $#\n};"
              [(i 1) (i 2)] {:delimiters "$#"}))
 (s :rra (fmt "export async function action({ $# }: Route.ActionArgs) {\n  $#\n};"
              [(i 1) (i 2)] {:delimiters "$#"}))
 (s :rrp (fmt "export default function Page() {\n  return <>$#</>\n};" [(i 1)]
              {:delimiters "$#"}))]
