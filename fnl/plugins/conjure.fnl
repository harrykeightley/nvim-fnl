(local {: plugin} (require :utils))

(plugin :Olical/conjure {:init #(set vim.g.conjure#mapping#doc_word false)})
