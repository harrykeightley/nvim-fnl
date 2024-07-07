(local {: plugin : merge : plugin-keys} (require :utils))


(fn command [opts]
  (let [cmd (require :neo-tree.command)]
    (cmd.execute opts)))

(fn init []
  (vim.api.nvim_create_autocmd "BufEnter"
    {:group (vim.api.nvim_create_augroup "neotree-start-directory" {:clear true})
     :desc "Start Neotree with a directory"
     :once true
     :callback (fn []
                 (when (not (. package.loaded "neo-tree"))
                    (let [stats (vim.uv.fs_stat (vim.fn.argv 0))
                          is-dir? (and stats (= stats.type :directory))]
                      (when is-dir? 
                        (require :neo-tree)))))

     })
  )

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

   : init

   :opts {:sources [:filesystem :buffers :git_status]
          :open_files_do_not_replace_types [:terminal :Trouble :trouble :qf :Outline]
          :window window-opts
          :filesystem {:bind_to_cwd false
                       :follow_current_file {:enabled true}
                       :use_libuv_file_watcher true
                       :filtered_items {
                          :visible true
                          :show_hidden_count true
                          :hide_dotfiles false
                          :hide_gitignored true
                          :hide_by_name [".DS_Store"]}
                       }
    
    
   }})
