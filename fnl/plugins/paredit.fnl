(local {: plugin} (require :utils))

[(plugin :julienvincent/nvim-paredit
  {:lazy true
  :ft [:clojure :fennel]
  :config (fn []
            (let [paredit (require :nvim-paredit)]
              (paredit.setup)))})

 (plugin :julienvincent/nvim-paredit-fennel
  {:dependencies [:julienvincent/nvim-paredit]
  :lazy true
  :ft [:fennel]
  :config (fn []
            (let [paredit-fnl (require :nvim-paredit-fennel)]
              (paredit-fnl.setup)))})]

