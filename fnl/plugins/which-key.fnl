(local {: plugin : notify } (require :utils))

(fn config [...]
  (let [wk (require :which-key)]
    (wk.setup)
    (wk.register 
      {
        :c {:name "[C]ode+"}
        :d {:name "[D]iagnostics+"}
        :r {:name "[R]ename+"}
        :s {:name "[S]earch+"}
        :t {:name "[T]oggle+"}
        :h {:name  "Git [H]unk+"}
      }
      {:prefix :<leader>})
    ; Visual mode
    (wk.register {:<leader>h ["Git [H]unk"]} {:mode :v})
  ))

(plugin :folke/which-key.nvim
        {:event :VimEnter
        : config })
