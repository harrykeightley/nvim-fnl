(local {: plugin : merge : plugin-keys} (require :utils))


(fn command [opts]
  (let [cmd (require :neo-tree.command)]
    (cmd.execute opts)))

(local window-opts
 {:mappings {:l :open
             :h :close_node
             :<space> :none
             :Y {1 (fn [state]
                       (let [node (state.tree:get_node)
                             path (node:get_id)]
                         (vim.fn.setreg :+ path :c)))
                   :desc "Copy path to clipboard"}
             :P {1 :toggle_preview
                   :config {:use_float false}}}})

(plugin "nvim-neo-tree/neo-tree.nvim"
  {:version "*"
   :dependencies [:nvim-lua/plenary.nvim 
                  :nvim-tree/nvim-web-devicons 
                  :MunifTanjim/nui.nvim]
   :cmd :Neotree
   :keys [(plugin-keys :<leader>e 
                       #(command {:toggle true :dir (vim.uv.cwd)}) 
                       {:desc "Toggle explorer"})]

   :deactivate #(vim.cmd "Neotree close") 

   :opts {:sources [:filesystem :buffers :git_status]
          :open_files_do_not_replace_types [:terminal :Trouble :trouble :qf :Outline]
          :window window-opts
    
    
   }})
