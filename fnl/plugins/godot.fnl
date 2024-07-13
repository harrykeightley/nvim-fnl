;; Starts a pipe at ~/.cache/nvim/server.pipe for godot to send commands through to.
(local pipe-path (.. (vim.fn.stdpath :cache) :/server.pipe))

(when (not (vim.loop.fs_stat pipe-path))
  (vim.fn.serverstart pipe-path))

{}
