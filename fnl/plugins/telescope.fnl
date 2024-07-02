(local {: plugin} (require :utils))
(local {: nmap} (require :keymap))

;; Prefix for all telescope commands
(local telescope-prefix "<leader>s")

(fn tsc [name]
  (.. ":lua require('telescope.builtin')." name "()<CR>"))

(fn telescope-keymap [key fn-name description?]
  (nmap (.. telescope-prefix key) 
        (tsc fn-name) 
        {:noremap true
         :desc (or description? (.. "Telescope " fn-name))}))

(plugin :nvim-telescope/telescope.nvim
  {
  :dependencies [:nvim-telescope/telescope-ui-select.nvim
                 :nvim-lua/popup.nvim
                 :nvim-lua/plenary.nvim]
  :init (fn []
          (telescope-keymap :f :find_files "Search for files in the current directory")
          (telescope-keymap :g :live_grep)
          (telescope-keymap :b :buffers)
          (telescope-keymap :h :help_tags))
  :config (fn []
            (let [telescope (require :telescope)
                  themes (require :telescope.themes)]
              (telescope.setup {:defaults {:file_ignore_patterns ["node_modules"]
                                           :vimgrep_arguments ["rg"
                                                               "--color=never"
                                                               "--no-heading"
                                                               "--with-filename"
                                                               "--line-number"
                                                               "--column"
                                                               "--smart-case"
                                                               "--iglob"
                                                               "!.git"
                                                               "--hidden"]}
                                :extensions {:ui-select {1 (themes.get_dropdown {})}}
                                :pickers {:find_files {:find_command ["rg"
                                                                      "--files"
                                                                      "--iglob"
                                                                      "!.git"
                                                                      "--hidden"]}}})
              (telescope.load_extension "ui-select")))})
