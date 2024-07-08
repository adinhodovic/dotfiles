local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

-- Remap , as leader key
-- Must be before lazy
vim.g.mapleader = ","
-- vim.keymap.set("n", "<leader>ml", "<cmd>Lazy<cr>")

require("lazy").setup("plugins", {
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = true,
		notify = false, -- get a notification when changes are found
	},
	dev = {
		path = "~/oss",
	},
	-- Can cause git issues
	concurrency = 5,
})
