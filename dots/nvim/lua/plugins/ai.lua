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
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
			{ "ibhagwan/fzf-lua" },
		},
		opts = {
			-- See Configuration section for rest
		},
		keys = {
			{
				"<leader>cct",
				function()
					require("CopilotChat").toggle()
				end,
				desc = "CopilotChat: Toggle",
			},
			{
				"<leader>ccr",
				function()
					require("CopilotChat").reset()
				end,
				desc = "CopilotChat: Reset",
			},
			{
				"<leader>cch",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.help_actions())
				end,
				desc = "CopilotChat: Help actions",
			},
			{
				"<leader>ccp",
				mode = { "n", "v", "x" },
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
				end,
				desc = "CopilotChat: Prompt actions",
			},
		},
	},
}
