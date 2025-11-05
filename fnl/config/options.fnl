(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(fn vim-opt [option value]
  (core.assoc vim.o option value))

(local options {; Add hybrid relative numbers
                :number true
                :relativenumber true
                :mouse :a
                :showmode false
                ; Sync clipboard between OS and Neovim.
                ; Remove this option if you want your OS clipboard to remain independent.
                ; See `:help 'clipboard'`
                :clipboard :unnamedplus
                :breakindent true
                ; Decrease update time
                :updatetime 250
                ; Decrease mapped sequence wait time
                ; Displays which-key popup sooner
                :timeoutlen 300
                :cursorline true
                :scrolloff 10
                ; Case-insensitive searching UNLESS \C or one or more capital letters in the search term
                :ignorecase true
                :smartcase true
                :hlsearch true
                :inccommand :split
                ; Keep sign colum on by default
                :signcolumn :yes
                ; :guicursor {}
                ;; Folds
                :conceallevel 0
                :foldenable false
                ;; Backups
                :hidden true
                :swapfile false
                :backup false
                :undofile true
                :termguicolors true
                ;; Splits
                :splitright true
                :splitbelow true
                :wrap false
                :pumblend 10
                ;; Popups
                ; Popup blend
                :pumheight 10
                ; Max number of entries
                :confirm true
                ;; Tab behaviour
                :tabstop 2
                :shiftwidth 2
                :softtabstop 2
                :expandtab true
                :list true
                :listchars "tab:» ,trail:·,nbsp:␣"})

(each [key value (pairs options)]
  (vim-opt key value))

{}
