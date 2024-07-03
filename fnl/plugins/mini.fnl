(local {: plugin} (require :utils))

(fn config []
  (let [ai (require :mini.ai)
        surround (require :mini.surround)
        statusline (require :mini.statusline)]
    (ai.setup {:n_lines 500})
    (surround.setup)
    (statusline.setup {:use_icons vim.g.have_nerd_font})
    (set statusline.section_location (fn [] "%2l:%-2v")))
  )

(plugin :echasnovski/mini.nvim
  {: config})
