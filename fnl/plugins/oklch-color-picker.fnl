(local {: plugin : plugin-keys} (require :utils))

(plugin :eero-lehtinen/oklch-color-picker.nvim
        {:event :VeryLazy
         :version "*"
         :keys ;; One handed keymap recommended, you will be using the mouse
         [(plugin-keys :<leader>vc
                             (fn []
                               ((. (require :oklch-color-picker) :pick_under_cursor)))
                             {:mode :n :desc "[V]iew [C]olorpicker"})]
         ;; @type oklch.Opts
         :opts {}})
