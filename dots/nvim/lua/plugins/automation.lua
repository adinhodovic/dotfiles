local vim = vim
local g = vim.g

local function default(val, default_val)
	if val == nil then
		return default_val
	else
		return val
	end
end

local default_options = { noremap = true, silent = true }
local default_options_expression = { noremap = true, silent = true, expr = true, replace_keycodes = false }

local function map(mode, shortcut, command, options)
	options = default(options, default_options)
	vim.keymap.set(mode, shortcut, command, options)
end

local function nmap(shortcut, command, options)
	map("n", shortcut, command, options)
end

local function imap(shortcut, command, options)
	map("i", shortcut, command, options)
end

local function vmap(shortcut, command, options)
	map("v", shortcut, command, options)
end

local function xmap(shortcut, command, options)
	map("x", shortcut, command, options)
end

local function omap(shortcut, command, options)
	map("o", shortcut, command, options)
end

local function cmap(shortcut, command, options)
	map("c", shortcut, command, options)
end

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
		-- Fzf vim integration
		"junegunn/fzf.vim",
		dependencies = {
			"junegunn/fzf",
		},
		config = function()
			g.fzf_action = {
				["ctrl-t"] = "tab split",
				["ctrl-x"] = "vsplit",
				["ctrl-z"] = "split",
			}
			g.fzf_layout = { up = "~40%" }
			g.fzf_files_options = '--ansi --preview "bat --style=plain {}" --preview-window right:100'
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

			local git_files_changed = function()
				local previewers = require("telescope.previewers")
				local pickers = require("telescope.pickers")
				local sorters = require("telescope.sorters")
				local finders = require("telescope.finders")

				pickers
					.new({
						results_title = "Modified on current branch",
						finder = finders.new_oneshot_job({
							"/home/adin/.dotfiles/scripts/git-files-changed.sh",
							"list",
						}),
						sorter = sorters.get_fuzzy_file(),
						previewer = previewers.new_termopen_previewer({
							get_command = function(entry)
								return { "/home/adin/.dotfiles/scripts/git-files-changed.sh", "diff", entry.value }
							end,
						}),
					})
					:find()
			end

			nmap("b", ":e #<cr>")
			local builtin = require("telescope.builtin")
			nmap("-", builtin.buffers)
			nmap("=", git_files_changed)
			nmap("<M-=>", builtin.find_files)
			nmap("<M-->", builtin.git_files)
			nmap("<leader>fg", builtin.live_grep)
			nmap("<leader>fh", builtin.help_tags)
			nmap("<leader>fc", builtin.commands)
			nmap("<leader>fds", builtin.lsp_document_symbols)

			-- Action spell
			vim.keymap.set({ "n", "v" }, "<leader>as", ":lua require('telescope.builtin').spell_suggest({})<CR>")
		end,
	},
	-- Code actions
	{
		"aznhe21/actions-preview.nvim",
		keys = {
			{
				"<leader>ca",
				mode = { "v", "n" },
				function()
					require("actions-preview").code_actions()
				end,
				desc = "Toggle Code Actions",
			},
		},
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
				desc = "Search on current file",
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
		opts = {}, -- this is equalent to setup({}) function
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
		config = function()
			require("nvim-treesitter.configs").setup({
				autotag = {
					enable = true,
				},
			})
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = false,
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = {
						accept = "<c-c>",
						accept_word = false,
						accept_line = false,
						next = false,
						prev = false,
					},
				},
			})
		end,
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
}
