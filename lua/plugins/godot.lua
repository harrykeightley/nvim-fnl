-- [nfnl] Compiled from fnl/plugins/godot.fnl by https://github.com/Olical/nfnl, do not edit.
local pipe_path = (vim.fn.stdpath("cache") .. "/server.pipe")
if not vim.loop.fs_stat(pipe_path) then
  vim.fn.serverstart(pipe_path)
else
end
return {}
