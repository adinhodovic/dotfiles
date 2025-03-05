local vim = vim
local g = vim.g
-----------------------------------------
-- Backend
-----------------------------------------
return {
	{
		-- Has DAP Golang aswell
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup({
				dap_debug_keymap = false,
			})
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
		keys = {
			{
				"<leader>god",
				":GoDebug<CR>",
				desc = "Go DAP: Start",
			},
			{
				"<leader>gos",
				":GoDbgStop<CR>",
				desc = "Go DAP: Stop",
			},
		},
	},
	{
		-- Ruby
		"vim-ruby/vim-ruby",
		ft = "ruby",
	},
}
