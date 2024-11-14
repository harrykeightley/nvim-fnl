(local {: plugin : notify } (require :utils))

(fn which-binding [keys ?opts]
  (plugin keys ?opts))

(fn config [...]
  (let [wk (require :which-key)]
    (wk.setup)
    (wk.add [
       (which-binding :<leader>c {:group "[C]ode+"})
       (which-binding :<leader>d {:group "[D]iagnostics+"})
       (which-binding :<leader>r {:group "[R]ename+"})
       (which-binding :<leader>s {:group "[S]earch+"})
       (which-binding :<leader>t {:group "[T]oggle+"})])))

(plugin :folke/which-key.nvim
        {:event :VimEnter
        : config })
