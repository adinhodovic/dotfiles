return {
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{
				"<M-=>",
				function()
					require("fzf-lua").files()
				end,
				desc = "Fzf-lua: Find files",
			},
			{
				"<M-+>",
				function()
					require("fzf-lua").files({ cwd = require("fzf-lua").path.git_root() })
				end,
				desc = "Fzf-lua: Find files (Git Root)",
			},
			{
				"<M-->",
				function()
					require("fzf-lua").git_files()
				end,
				desc = "Fzf-lua: Git files",
			},
			{
				"-",
				function()
					require("fzf-lua").buffers({
						sort_lastused = true,
						ignore_current_buffer = true,
					})
				end,
				desc = "Fzf-lua: Find buffers",
			},
			{
				"<leader>fg",
				function()
					require("fzf-lua").live_grep()
				end,
				desc = "Fzf-lua: Live Grep",
			},
			{
				"gd",
				function()
					require("fzf-lua").lsp_definitions()
				end,
				desc = "Fzf-lua: Go to Definition",
			},
			{
				"gr",
				function()
					require("fzf-lua").lsp_references()
				end,
				desc = "Fzf-lua: LSP References",
			},
			{
				"gy",
				function()
					require("fzf-lua").lsp_typedefs()
				end,
				desc = "Goto T[y]pe Definition",
			},
			{
				"gI",
				function()
					require("fzf-lua").lsp_implementations()
				end,
				desc = "Goto Implementation",
			},
		},
		config = function()
			require("fzf-lua").setup({
				"telescope",
				winopts = { preview = { default = "bat" } },
				defaults = { formatter = "path.filename_first" },
				fzf_opts = {
					-- ["--layout"] = "reverse",
				},
				keymap = {
					fzf = {
						["tab"] = "up",
						["shift-tab"] = "down",
					},
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		priority = 10000,
	},
	{
		-- Telescope
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			{
				"polirritmico/telescope-lazy-plugins.nvim",
				opts = {
					lazy_config = vim.fn.stdpath("config") .. "/lua/config/lazy.lua", -- path to the file containing the lazy opts and setup() call.
				},
				keys = {
					{
						"<leader>flp",
						function()
							require("telescope").extensions.lazy_plugins.lazy_plugins()
						end,
						desc = "Telescope: Lazy Plugins",
					},
				},
			},
		},
		lazy = false,
		keys = {
			{
				"b",
				":e #<cr>",
				desc = "Last buffer",
			},
			{
				"<leader>fc",
				function()
					require("telescope.builtin").commands()
				end,
				desc = "Telescope Commands",
			},
			{
				"<leader>fds",
				function()
					require("telescope.builtin").lsp_document_symbols()
				end,
				desc = "Telescope Document Symbols",
			},
			{
				"<leader>fh",
				function()
					require("telescope.builtin").help_tags()
				end,
				desc = "Telescope Help tags",
			},
			{
				"<leader>as",
				mode = { "n", "v" },
				function()
					require("telescope.builtin").spell_suggest({})
				end,
				desc = "Telescope Spell Suggest",
			},
			{
				"<leader>cd",
				function()
					require("telescope").extensions.projects.projects()
				end,
				desc = "Telescope: Find project",
			},
		},
		priority = 1000,
		config = function()
			require("telescope").setup({
				defaults = {
					prompt_prefix = "󰼛 ",
					selection_caret = "󱞩 ",
					sorting_strategy = "ascending",

					layout_config = {
						horizontal = {
							prompt_position = "bottom",
						},
					},
				},
				mappings = {
					-- TODO(adinhodovic): Fix these mappings
					n = {
						["Tab"] = require("telescope.actions").move_selection_next,
						["S-Tab"] = require("telescope.actions").move_selection_previous,
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
					},
				},
			})
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("lazy_plugins")
		end,
	},
	{
		"piersolenski/telescope-import.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = {
			{
				"<leader>fi",
				function()
					require("telescope").extensions.import.import()
				end,
				desc = "Telescope: Import library",
			},
		},
		config = function()
			require("telescope").load_extension("import")
		end,
	},
	{
		"axkirillov/easypick.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{
				"=",
				":Easypick git_changed_files<cr>",
				desc = "Find changed git files",
			},
		},
		config = function()
			local easypick = require("easypick")

			local base_branch = vim.fn.system("basename $(git symbolic-ref --short refs/remotes/origin/HEAD)")

			easypick.setup({
				pickers = {
					-- diff current branch with base_branch and show files that changed with respective diffs in preview
					{
						name = "git_changed_files",
						command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
						previewer = easypick.previewers.branch_diff({ base_branch = base_branch }),
					},

					-- list files that have conflicts with diffs in preview
					{
						name = "git_conflicts",
						command = "git diff --name-only --diff-filter=U --relative",
						previewer = easypick.previewers.file_diff(),
					},
				},
			})
		end,
	},
	{
		"Myzel394/jsonfly.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{
				"<leader>tj",
				"<cmd>Telescope jsonfly<cr>",
				desc = "JsonFly: Open json(fly)",
				ft = { "json" },
				mode = "n",
			},
		},
		config = function()
			require("telescope").load_extension("jsonfly")
		end,
	},
	{
		-- Better search
		"folke/flash.nvim",
		lazy = false,
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
		config = function()
			require("flash").setup({
				modes = {
					search = {
						-- TODO: adinhodovic renable this maybe later?
						enabled = false,
					},
					char = {
						jump_labels = true,
					},
				},
			})
		end,
	},
	{
		"MagicDuck/grug-far.nvim",
		opts = {
			transient = true,
			engines = {
				ripgrep = {
					path = "/usr/bin/rg",
				},
			},
		},
		keys = {
			{
				"<leader>S",
				function()
					require("grug-far").open()
				end,
				desc = "Grug: Open",
			},
			{
				"<leader>sw",
				function()
					require("grug-far").open({
						prefills = {
							search = vim.fn.expand("<cword>"),
						},
					})
				end,
				desc = "Grug: Replace word under cursor",
			},
			{
				"<leader>sf",
				function()
					require("grug-far").open({
						prefills = {
							flags = vim.fn.expand("%"),
						},
					})
				end,
				desc = "Grug: Replace word in current file",
			},
			{
				"<leader>sv",
				function()
					require("grug-far").with_visual_selection({
						prefills = {
							flags = vim.fn.expand("%"),
						},
					})
				end,
				mode = { "v" },
				desc = "Grug: Replace word in current file visually selected",
			},
		},
	},
}
