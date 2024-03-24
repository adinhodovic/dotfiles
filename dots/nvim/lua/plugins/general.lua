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
		-- Align code around arbitrary characters =,:
		"junegunn/vim-easy-align",
	},
	{
		-- Open files at file:line:column
		"kopischke/vim-fetch",
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
		-- Direnv integration
		"direnv/direnv.vim",
	},
	{
		"ellisonleao/carbon-now.nvim",
		opts = {},
		keys = {
			{
				"<F6>",
				":CarbonNow<CR>",
				mode = { "x" },
				desc = "Open Carbon.sh with selected text",
			},
		},
	},
	{
		"ckolkey/ts-node-action",
		keys = {
			{
				"<leader>cc",
				function()
					require("ts-node-action").node_action()
				end,
				desc = "Trigger Node Action",
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
		"mrjones2014/legendary.nvim",
		dependencies = {
			"folke/which-key.nvim",
		},
		keys = {
			{
				"<leader>lg",
				mode = { "n" },
				"<cmd>Legendary<cr>",
				desc = "Open Legendary",
			},
		},
		priority = 10000,
		lazy = false,
		opts = {
			extensions = {
				lazy_nvim = { auto_register = true },
				which_key = { auto_register = true },
			},
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = { spelling = true },
			defaults = {
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["gs"] = { name = "+surround" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["<leader><tab>"] = { name = "+tabs" },
				["<leader>b"] = { name = "+buffer" },
				["<leader>c"] = { name = "+code" },
				["<leader>f"] = { name = "+file/find" },
				["<leader>g"] = { name = "+git" },
				["<leader>gh"] = { name = "+hunks" },
				["<leader>q"] = { name = "+quit/session" },
				["<leader>s"] = { name = "+search" },
				["<leader>u"] = { name = "+ui" },
				["<leader>w"] = { name = "+windows" },
				["<leader>x"] = { name = "+diagnostics/quickfix" },
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register(opts.defaults)
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
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
