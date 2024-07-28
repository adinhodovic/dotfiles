local vim = vim
local g = vim.g
-----------------------------------------
-- Backend
-----------------------------------------
return {
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
	{
		-- Delve debugging
		"sebdah/vim-delve",
		ft = "go",
	},
	{
		-- Ruby
		"vim-ruby/vim-ruby",
		ft = "ruby",
	},
}
