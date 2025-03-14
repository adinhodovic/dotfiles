return {
	{
		"L3MON4D3/LuaSnip",
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("luasnip.loaders.from_snipmate").lazy_load({
				paths = { "/home/adin/dotfiles/snippets" },
			})
		end,
	},
	{
		"chrisgrieser/nvim-scissors",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		}, -- optional
		opts = {
			snippetDir = "/home/adin/dotfiles/snippets",
			editSnippetPopup = {
				keymaps = {
					cancel = "<esc>",
				},
			},
		},
		keys = {
			{
				mode = { "n", "x" },
				"<leader>sa",
				function()
					require("scissors").addNewSnippet()
				end,
				desc = "Scissors: Add snippet",
			},
			{
				"<leader>se",
				function()
					require("scissors").editSnippet()
				end,
				desc = "Scissors: Edit snippet",
			},
		},
	},
	{
		"benfowler/telescope-luasnip.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "L3MON4D3/LuaSnip" },
		config = function()
			require("telescope").load_extension("luasnip")
		end,
		keys = {
			{
				"<leader>ts",
				function()
					require("telescope").extensions.luasnip.luasnip({})
				end,
				desc = "Snippets: Search snippets in telescope",
			},
		},
	},
}
