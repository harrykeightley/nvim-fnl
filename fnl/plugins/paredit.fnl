(local {: plugin} (require :utils))

(plugin :julienvincent/nvim-paredit
        {:lazy true
         :ft [:clojure :fennel]
         :config (fn []
                   (let [paredit (require :nvim-paredit)]
                     (paredit.setup)))})
