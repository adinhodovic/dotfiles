local vim = vim
local g = vim.g

return {
	{
		-- TODO: remove this when empty lines work
		-- https://github.com/zbirenbaum/copilot-cmp/issues/5
		-- https://github.com/hrsh7th/nvim-cmp/issues/1272
		"github/copilot.vim",
		enabled = true,
		config = function()
			g.copilot_no_tab_map = true
			g.copilot_assume_mapped = true
			vim.cmd([[
	       imap <silent><script><expr> <C-c> copilot#Accept("\<CR>")
	     ]])
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = false,
				},
				suggestion = {
					-- TODO: enable this when empty lines work
					-- https://github.com/zbirenbaum/copilot-cmp/issues/5
					-- https://github.com/hrsh7th/nvim-cmp/issues/1272
					enabled = false,
					auto_trigger = true,
					keymap = {
						accept = "<c-c>",
						accept_word = false,
						accept_line = false,
						next = false,
						prev = false,
					},
				},
				filetypes = {
					yaml = true,
					markdown = true,
					help = true,
				},
			})
		end,
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		opts = {
			provider = "copilot",
			auto_suggestions_provider = "claude",
			behaviour = {
				auto_suggestions = false,
			},
		},
		build = "make",
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			"MeanderingProgrammer/render-markdown.nvim",
			"HakonHarnes/img-clip.nvim",
		},
	},
}
