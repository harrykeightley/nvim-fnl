local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyrepo = "https://github.com/folke/lazy.nvim.git"

if not vim.loop.fs_stat(lazypath) then
	print("nvim is bootstrapping.")
	local fn = vim.fn

	fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		lazyrepo,
		lazypath,
	})
end

vim.opt.runtimepath:prepend(lazypath)
vim.loader.enable()

-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Start Lazy
require("lazy").setup("plugins")
