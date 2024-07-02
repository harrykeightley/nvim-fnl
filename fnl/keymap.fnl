(local {: merge} (require :utils))

(fn map [mode lhs rhs opts?] 
  (vim.keymap.set mode lhs rhs (or opts? {})))

(local nmap (partial map :n))
(local imap (partial map :i))

(fn keymap-with-defaults [default-options]
  (fn [mode lhs rhs opts?]
    (map mode lhs rhs (merge default-options (or opts? {})))))

{: map
 : nmap
 : imap
 : keymap-with-defaults}
