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
		-- Hardtime
		"takac/vim-hardtime",
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
			{
				"<leader>xx",
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
						"/home/adin/dotfiles/snippets/yaml",
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
		"stevearc/oil.nvim",
		cmd = "Oil",
		opts = {
			columns = {
				"icon",
				"size",
				"mtime",
			},
			win_options = {
				signcolumn = "yes:2",
			},
		},
		-- Optional dependencies
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"SirZenith/oil-vcs-status",
		dependencies = {
			"stevearc/oil.nvim",
		},
		config = function()
			local status_const = require("oil-vcs-status.constant.status")

			local StatusType = status_const.StatusType

			require("oil-vcs-status").setup({
				status_symbol = {
					[StatusType.Added] = "",
					[StatusType.Copied] = "󰆏",
					[StatusType.Deleted] = "",
					[StatusType.Ignored] = "",
					[StatusType.Modified] = "",
					[StatusType.Renamed] = "",
					[StatusType.TypeChanged] = "󰉺",
					[StatusType.Unmodified] = " ",
					[StatusType.Unmerged] = "",
					[StatusType.Untracked] = "",
					[StatusType.External] = "",

					[StatusType.UpstreamAdded] = "󰈞",
					[StatusType.UpstreamCopied] = "󰈢",
					[StatusType.UpstreamDeleted] = "",
					[StatusType.UpstreamIgnored] = " ",
					[StatusType.UpstreamModified] = "󰏫",
					[StatusType.UpstreamRenamed] = "",
					[StatusType.UpstreamTypeChanged] = "󱧶",
					[StatusType.UpstreamUnmodified] = " ",
					[StatusType.UpstreamUnmerged] = "",
					[StatusType.UpstreamUntracked] = " ",
					[StatusType.UpstreamExternal] = "",
				},
			})
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
	{
		"backdround/global-note.nvim",
		config = function()
			require("global-note").setup({})
		end,
		keys = {
			{
				"<leader>gn",
				"<cmd>GlobalNote<cr>",
				desc = "Toggle global note",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"folke/which-key.nvim",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
							["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
							["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
							["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

							["a:"] = { query = "@property.outer", desc = "Select outer part of an object property" },
							["i:"] = { query = "@property.inner", desc = "Select inner part of an object property" },
							["l:"] = { query = "@property.lhs", desc = "Select left part of an object property" },
							["r:"] = { query = "@property.rhs", desc = "Select right part of an object property" },

							["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
							["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

							["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
							["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

							["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
							["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

							["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
							["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

							["am"] = {
								query = "@function.outer",
								desc = "Select outer part of a method/function definition",
							},
							["im"] = {
								query = "@function.inner",
								desc = "Select inner part of a method/function definition",
							},

							["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
							["<leader>n:"] = "@property.outer", -- swap object property with next
							["<leader>nm"] = "@function.outer", -- swap function with next
						},
						swap_previous = {
							["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
							["<leader>p:"] = "@property.outer", -- swap object property with prev
							["<leader>pm"] = "@function.outer", -- swap function with previous
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]f"] = { query = "@call.outer", desc = "Next function call start" },
							["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
							["]l"] = { query = "@loop.outer", desc = "Next loop start" },

							["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
							["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
						},
						goto_next_end = {
							["]F"] = { query = "@call.outer", desc = "Next function call end" },
							["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
							["]C"] = { query = "@class.outer", desc = "Next class end" },
							["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
							["]L"] = { query = "@loop.outer", desc = "Next loop end" },
						},
						goto_previous_start = {
							["[f"] = { query = "@call.outer", desc = "Prev function call start" },
							["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
							["[c"] = { query = "@class.outer", desc = "Prev class start" },
							["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
							["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
						},
						goto_previous_end = {
							["[F"] = { query = "@call.outer", desc = "Prev function call end" },
							["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
							["[C"] = { query = "@class.outer", desc = "Prev class end" },
							["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
							["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
						},
					},
				},
			})

			local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

			-- vim way: ; goes to the direction you were moving.
			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
		end,
	},
}
