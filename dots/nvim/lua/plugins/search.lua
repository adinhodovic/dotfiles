return {
	{
		-- Fzf
		"junegunn/fzf",
		dir = "~/.fzf",
		build = "./install --all",
	},
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("fzf-lua").setup({
				"telescope",
				winopts = { preview = { default = "bat" } },
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
		},
		lazy = false,
		keys = {
			{
				"<leader>cd",
				function()
					require("telescope").extensions.projects.projects()
				end,
				desc = "Find project",
			},
			{
				"b",
				":e #<cr>",
				desc = "Last buffer",
			},
			{
				"<M-=>",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Telescope: Find files",
			},
			{
				"<M-->",
				function()
					require("telescope.builtin").git_files()
				end,
				desc = "Telescope: Find git files",
			},
			{
				"-",
				function()
					require("telescope.builtin").buffers({
						show_all_buffers = true,
						sort_lastused = true,
						ignore_current_buffer = true,
					})
				end,
				desc = "Find buffers",
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
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Telescope Grep",
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
		},
		priority = 1000,
		config = function()
			require("telescope").setup({
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
					},
				},
			})
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"polirritmico/telescope-lazy-plugins.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		keys = {
			{
				"<leader>tlp",
				function()
					require("telescope").extensions.lazy_plugins.lazy_plugins()
				end,
				desc = "Telescope: Lazy Plugins",
			},
		},
		config = function()
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
		-- Better search
		"cshuaimin/ssr.nvim",
		opts = {},
		keys = {
			{
				"<leader>sr",
				mode = { "n", "x" },
				function()
					require("ssr").open()
				end,
				desc = "Search and replace",
			},
		},
	},
	{
		-- Search and replace
		"nvim-pack/nvim-spectre",
		keys = {
			{ "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', desc = "Toggle Spectre" },
			{
				"<leader>sw",
				'<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
				desc = "Search current word",
			},
			{
				"<leader>sw",
				mode = { "v" },
				'<esc><cmd>lua require("spectre").open_visual()<CR>',
				desc = "Search current word",
			},
			{
				"<leader>sp",
				'<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
				desc = "Search in current file",
			},
		},
		config = function()
			require("spectre").setup()
		end,
	},
	{
		-- Better search <leader>e, simpler than above
		"wincent/scalpel",
	},
}
