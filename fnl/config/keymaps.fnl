(local {: merge} (require :utils))
(local {: map} (require :keymap))
(local {: jump-by-severity} (require :config.diagnostics))

;; Copy from lazyvim 

;; Better UP/Down
(map [:n :x] :j "v:count == 0 ? 'gj' : 'j'"
     {:desc :Down :expr true :silent true})
(map [:n :x] :<Down> "v:count == 0 ? 'gj' : 'j'"
     {:desc :Down :expr true :silent true})
(map [:n :x] :k "v:count == 0 ? 'gk' : 'k'" {:desc :Up :expr true :silent true})
(map [:n :x] :<Up> "v:count == 0 ? 'gk' : 'k'"
     {:desc :Up :expr true :silent true})

;; Move to window using the <ctrl> hjkl keys
;(map :n :<C-h> :<C-w>h {:desc "Go to Left Window" :remap true})
;(map :n :<C-j> :<C-w>j {:desc "Go to Lower Window" :remap true})
;(map :n :<C-k> :<C-w>k {:desc "Go to Upper Window" :remap true})
;(map :n :<C-l> :<C-w>l {:desc "Go to Right Window" :remap true})

;; Move between buffers
(map :n :<S-h> :<cmd>bprevious<cr> {:desc "Prev Buffer"})
(map :n :<S-l> :<cmd>bnext<cr> {:desc "Next Buffer"})

;; Clear search with <esc>
(map [:i :n] :<esc> :<cmd>noh<cr><esc> {:desc "Escape and Clear hlsearch"})

;; Diagnostics
(map :n :<leader>dk #(jump-by-severity -1) {:desc "[D]iagnostics previous"})
(map :n :<leader>dj #(jump-by-severity 1) {:desc "[D]iagnostics next"})
(map :n :<leader>dl vim.diagnostic.open_float {:desc "[D]iagnostics line"})

(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(fn vim-opt [option value]
  (core.assoc vim.o option value))

;; Toggle tabs as spaces
(map :n :<leader>tt #(vim-opt :expandtab (not vim.o.expandtab))
     {:desc "[T]oggle [T]abs as spaces"})

{}
