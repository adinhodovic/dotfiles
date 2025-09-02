local vim = vim
-----------------------------------------
-- General
-----------------------------------------
return {
	{
		-- Bullet lists
		"dkarter/bullets.vim",
	},
	{
		-- Linediff
		"AndrewRadev/linediff.vim",
		keys = {
			{
				"<leader>ld",
				":Linediff<cr>",
				mode = "v",
				desc = "Check Linediffs",
			},
		},
		config = function()
			-- Try to not break statuscol
			vim.g.linediff_modify_statusline = 0
		end,
	},
	{
		"ckolkey/ts-node-action",
		keys = {
			{
				"<leader>cc",
				function()
					require("ts-node-action").node_action()
				end,
				desc = "Node Action: Toggle Node Action",
			},
		},
		dependencies = { "nvim-treesitter" },
		opts = {},
	},
	{
		"gbprod/yanky.nvim",
		dependencies = { "kkharji/sqlite.lua" },
		opts = {
			highlight = {
				on_put = true,
				on_yank = true,
				timer = 300,
			},
			ring = {
				storage = "sqlite",
				history_length = 500,
			},
		},
		keys = {
			{
				"<leader>p",
				function()
					require("telescope").extensions.yank_history.yank_history({})
				end,
				desc = "Open Yank History",
			},
			{ "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
			{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
			{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
			{ "<leader>p", '"0p', mode = { "x" }, desc = "Put yanked text and do not copy" },
			{ "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after selection" },
			{ "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before selection" },
			{ "[y", "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
			{ "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
			{ "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
			{ "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
			{ "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
			{ "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
			{ ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
			{ "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
			{ ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
			{ "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
			-- TODO: enable? Slows down git_changed files <=>
			-- { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
			-- { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			triggers = {
				{ "<auto>", mode = "nixsotc" },
				{ "<leader>", mode = { "n", "v" } },
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			highlight = {
				-- vimgrep regex, supporting the pattern TODO(name):
				pattern = [[.*<((KEYWORDS)%(\(.{-1,}\))?):]],
			},
			search = {
				-- ripgrep regex, supporting the pattern TODO(name):
				pattern = [[\b(KEYWORDS)(\(\w*\))*:]],
			},
		},
		-- Will show todo highlighting
		lazy = false,
		keys = {
			{
				"<leader>tds",
				"<cmd>TodoTelescope<cr>",
				desc = "Open todo comments in telescope",
			},
			{
				"<leader>tdt",
				"<cmd>TodoTrouble<cr>",
				desc = "Open todo comments in trouble",
			},
		},
	},
}
