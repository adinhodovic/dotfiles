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
		-- Sets root directory to project (git) directory by default
		"airblade/vim-rooter",
	},
	{
		-- Open files at file:line:column
		"kopischke/vim-fetch",
	},
	{
		-- Mappings
		"tpope/vim-unimpaired",
	},
	{
		-- Linediff
		"AndrewRadev/linediff.vim",
	},
	{
		-- Direnv integration
		"direnv/direnv.vim",
	},
	{
		-- CarbonNow Integration
		"kristijanhusak/vim-carbon-now-sh",
	},
	{
		-- OS commands in vim
		"tpope/vim-eunuch",
	},
	{
		-- Split/join multi lines
		"AndrewRadev/splitjoin.vim",
	},
	{
		-- Hardtime
		"takac/vim-hardtime",
	},
	{
		"gbprod/yanky.nvim",
		dependencies = { "kkharji/sqlite.lua" },
		opts = {
			highlight = {
				timer = 250,
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
			{ "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
			{ "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
			{
				"<leader>x",
				-- TODO(adinhodovic): Improve this to mimic coc behaviour
				"y<cmd>lua require('luasnip.loaders').edit_snippet_files()<cr>1<cr>2<cr><esc>Go<cr><esc>0<esc>isnippet key \"Desc\"<esc>p",
				mode = "v",
				desc = "Convert to snippet",
			},
		},
	},
	{
		"L3MON4D3/LuaSnip",
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		config = function()
			require("luasnip.loaders.from_snipmate").lazy_load({
				paths = { "/home/adin/.dotfiles/snippets" },
			})
		end,
	},
	{
		"benfowler/telescope-luasnip.nvim",
		keys = {
			{
				"<leader>ts",
				function()
					require("telescope").extensions.luasnip.luasnip({})
				end,
				desc = "Search snippets in telescope",
			},
		},
		requires = { "nvim-telescope/telescope.nvim", "L3MON4D3/LuaSnip" },
		config = function()
			require("telescope").load_extension("luasnip")
		end,
	},
	{
		"smjonas/snippet-converter.nvim",
		cmd = "ConvertSnippets",
		config = function()
			local template = {
				-- name = "t1", (optionally give your template a name to refer to it in the `ConvertSnippets` command)
				sources = {
					ultisnips = {
						"/home/adin/personal/Ultisnips/yaml",
					},
				},
				output = {
					-- Specify the output formats and paths
					snipmate = {
						"/home/adin/.dotfiles/snippets/yaml",
					},
				},
				sort_snippets = function(first, second)
					return first.trigger < second.trigger
				end,
			}

			require("snippet_converter").setup({
				templates = { template },
				-- To change the default settings (see configuration section in the documentation)
				-- settings = {},
			})
		end,
	},
}
