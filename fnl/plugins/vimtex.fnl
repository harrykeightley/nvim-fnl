(local {: plugin} (require :utils))

(fn set-open-with-finder []
  (set vim.g.vimtex_view_general_viewer :open)
  (set vim.g.vimtex_view_general_options "-a Preview @pdf"))

(fn open-with-skim []
  (set vim.g.vimtex_view_method :skim))

(plugin :lervag/vimtex {:lazy false :init open-with-skim})
