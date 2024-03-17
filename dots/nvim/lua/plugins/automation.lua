local vim = vim
local g = vim.g

-----------------------------------------
-- Automation
-----------------------------------------
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
					require("fzf-lua").files()
				end,
				desc = "fzf-lua: Find files",
			},
			{
				"<M-->",
				function()
					require("telescope.builtin").git_files()
				end,
				desc = "Find git files",
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
		-- Open at last place
		"farmergreg/vim-lastplace",
	},
	{
		-- Increment dates
		"tpope/vim-speeddating",
	},
	{
		-- Semicolons
		"lfilho/cosco.vim",
		config = function()
			g.cosco_filetype_whitelist = {
				"javascript",
				"typescript",
				"css",
				"perl",
				"nginx",
			}
		end,
	},
	{
		-- Project jumping
		"ahmedkhalf/project.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("project_nvim").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
			require("telescope").load_extension("projects")
		end,
	},
	{
		-- File tree
		"nvim-tree/nvim-tree.lua",
		keys = {
			{
				"<leader>ct",
				":NvimTreeToggle<cr>",
				desc = "Open nvim tree",
			},
		},
		config = function()
			require("nvim-tree").setup({
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				update_focused_file = {
					enable = true,
					update_root = true,
				},
				sort = {
					sorter = "case_sensitive",
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = true,
				},
			})
		end,
	},
	{
		-- Better marks
		"chentoast/marks.nvim",
		lazy = false,
		keys = {
			{
				"<leader>m",
				"<cmd>MarksListAll<CR>",
				desc = "List all marks",
			},
		},
		config = function()
			require("marks").setup({})
		end,
	},
	{
		-- Peek line numbers
		"nacro90/numb.nvim",
		config = function()
			require("numb").setup()
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
		-- Auto pairs
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		-- Better search <leader>e, simpler than above
		"wincent/scalpel",
	},
	{
		-- Better folding
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		config = function()
			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local totalLines = vim.api.nvim_buf_line_count(0)
				local foldedLines = endLnum - lnum
				local suffix = ("  %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				local rAlignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
				suffix = (" "):rep(rAlignAppndx) .. suffix
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end

			-- global handler
			-- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
			-- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
			require("ufo").setup({
				fold_virt_text_handler = handler,
			})

			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
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
		-- Comment/uncomment source code files
		"numToStr/Comment.nvim",
		opts = {},
	},
	{
		-- treesitter tag closing
		"windwp/nvim-ts-autotag",
		opts = {},
	},
	{
		"echasnovski/mini.ai",
	},
	{
		"echasnovski/mini.surround",
	},
	{
		"echasnovski/mini.hipatterns",
	},
	{
		"chrisgrieser/nvim-rulebook",
		keys = {
			{
				"<leader>ri",
				function()
					require("rulebook").ignoreRule()
				end,
			},
			{
				"<leader>rl",
				function()
					require("rulebook").lookupRule()
				end,
			},
		},
	},
	{
		"bloznelis/before.nvim",
		opts = {},
		keys = {
			{
				"<c-h>",
				function()
					require("before").jump_to_last_edit()
				end,
				desc = "Jump to last edit",
			},
			{
				"<c-l>",
				function()
					require("before").jump_to_next_edit()
				end,
				desc = "Jump to next edit",
			},
		},
	},
}
