(local {: plugin} (require :utils))
(local {: nmap} (require :keymap))

(plugin :alexghergh/nvim-tmux-navigation
        {:config (fn []
                   (let [nav (require :nvim-tmux-navigation)]
                     (nav.setup {:disable_when_zoomed true})
                     (nmap :<C-h> nav.NvimTmuxNavigateLeft
                           {:desc "Go to Left Window"})
                     (nmap :<C-j> nav.NvimTmuxNavigateDown
                           {:desc "Go to Lower Window"})
                     (nmap :<C-k> nav.NvimTmuxNavigateUp
                           {:desc "Go to Upper Window"})
                     (nmap :<C-l> nav.NvimTmuxNavigateRight
                           {:desc "Go to Right Window"})))})
