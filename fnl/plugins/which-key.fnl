(local {: plugin } (require :utils))

(fn config []
  (let [wk (require :which-key)
        ;; Existing key-chains
        keys {
        :c "[C]ode"
        :d "[D]iagnostics"
        :r "[R]ename"
        :s "[S]earch"
        :t "[T]oggle"
        :h "Git [H]unk"
        }]
    (wk.setup)
    (wk.register (collect [key name (pairs keys)]
                   (values [(.. :<leader> key)] 
                           {: name 
                            _ :which-key-ignore})))
    ;; Visual mode
    (wk.register {[:<leader>h] ["Git [H]unk"]} {:mode :v})))

(plugin :folke/which-key.nvim
        {:event :VimEnter
        : config })
