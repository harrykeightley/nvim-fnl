(local {: plugin} (require :utils))
(local {: nmap} (require :keymap))

;; Prefix for all telescope commands
(local telescope-prefix :<leader>s)

(fn tsc [name]
  (.. ":lua require('telescope.builtin')." name "()<CR>"))

(fn telescope-keymap [key fn-name description?]
  (nmap (.. telescope-prefix key) (tsc fn-name)
        {:noremap true :desc (or description? (.. "Telescope " fn-name))}))

;; Fuck this autoformatter.
(fn setup-buffer-search []
  (let [builtin (require :telescope.builtin)
        action-state (require :telescope.actions.state)
        actions (require :telescope.actions)
        buffer-search (fn _search []
                        (builtin.buffers {:sort_mru true
                                          :ignore_current_buffer true
                                          :show_all_buffers false
                                          :attach_mappings (fn [prompt-bufnr
                                                                map]
                                                             (let [refresh (fn []
                                                                             (actions.close prompt-bufnr)
                                                                             (vim.schedule _search))
                                                                   delete-buf (fn []
                                                                                (let [selection (action-state.get_selected_entry)]
                                                                                  (vim.api.nvim_buf_delete selection.bufnr
                                                                                                           {:force true})
                                                                                  (refresh)))
                                                                   delete-bufs (fn []
                                                                                 (let [picker (action-state.get_current_picker prompt-bufnr)
                                                                                       selection (picker:get_multi_selection)]
                                                                                   (each [_ entry (ipairs selection)]
                                                                                     (vim.api.nvim_buf_delete entry.bufnr
                                                                                                              {:force true}))
                                                                                   (refresh)))]
                                                               (map :n :dd
                                                                    delete-buf)
                                                               (map :n :<C-d>
                                                                    delete-buf)
                                                               (map :i :<C-d>
                                                                    delete-buf)
                                                               true))}))]
    (nmap :<leader>sb buffer-search {:desc "Search buffers"})))

(plugin :nvim-telescope/telescope.nvim
        {:dependencies [:nvim-telescope/telescope-ui-select.nvim
                        (plugin :nvim-telescope/telescope-fzf-native.nvim
                                {:build :make
                                 :cond #(= 1 (vim.fn.executable :make))})
                        (plugin :nvim-tree/nvim-web-devicons
                                {:enabled vim.g.have_nerd_font})
                        :nvim-lua/popup.nvim
                        :nvim-lua/plenary.nvim]
         :config (fn []
                   (let [telescope (require :telescope)
                         themes (require :telescope.themes)]
                     (telescope.setup {:defaults {:file_ignore_patterns [:node_modules]
                                                  :vimgrep_arguments [:rg
                                                                      :--color=never
                                                                      :--no-heading
                                                                      :--with-filename
                                                                      :--line-number
                                                                      :--column
                                                                      :--smart-case
                                                                      :--iglob
                                                                      :!.git
                                                                      :--hidden]
                                                  :sorting_strategy :ascending
                                                  :layout_strategy :horizontal
                                                  :layout_config {:prompt_position :top
                                                                  :height 0.8}}
                                       :extensions {:ui-select {1 (themes.get_dropdown {})}}
                                       :pickers {:find_files {:find_command [:rg
                                                                             :--files
                                                                             :--iglob
                                                                             :!.git
                                                                             :--hidden]}}})
                     ;; Keybinds
                     (telescope-keymap :f :find_files
                                       "Search for files in the current directory")
                     (telescope-keymap :g :live_grep)
                     (telescope-keymap :h :help_tags)
                     (telescope-keymap :c :colorscheme)
                     (telescope-keymap :d :diagnostics)
                     (setup-buffer-search)
                     (telescope.load_extension :fzf)
                     (telescope.load_extension :ui-select)))})
