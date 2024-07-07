(local {: plugin } (require :utils))

(local ensure_installed
  [:bash 
  :fish
  :vim
  :vimdoc
  :clojure 
  :commonlisp 
  :dockerfile 
  :fennel 
  :html 
  :java 
  :javascript 
  :typescript 
  :tsx
  :astro 
  :json 
  :lua 
  :markdown 
  :yaml
  :python])

(plugin :nvim-treesitter/nvim-treesitter
  {:build ":TSUpdate"
   :config (fn []
            (let [treesitter (require :nvim-treesitter.configs)]
              (treesitter.setup {:highlight {:enable true}
                                 :indent {:enable true}
                                 : ensure_installed})))})
