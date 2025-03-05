local vim = vim
local g = vim.g
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Define a function to simplify setting autocmds
local function set_autocmd(group, event, pattern, command)
	autocmd(event, {
		group = group,
		pattern = pattern,
		command = command,
	})
end

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

-----------------------------------------
-- Utils
-----------------------------------------
return {
	{
		"akinsho/toggleterm.nvim",
		keys = {
			{
				"<leader>tt",
				"<cmd>lua _default_term_toggle()<cr>",
				mode = { "n", "t" },
				desc = "Toggleterm: Toggle terminal",
			},
			{
				"<leader>ttg",
				"<cmd>lua _lazygit_toggle()<cr>",
				mode = { "n", "t" },
				desc = "Toggleterm: Toggle lazygit",
			},
			{
				"<leader>gl",
				"<cmd>lua _lazygit_log_toggle()<cr>",
				mode = { "n", "t" },
				desc = "Toggleterm: Toggle lazygit log",
			},
			{
				"<leader>glf",
				"<cmd>lua _lazygit_log_file_toggle()<cr>",
				mode = { "n", "t" },
				desc = "Toggleterm: Toggle lazygit log current file",
			},
			{
				"<leader>tts",
				"<cmd>lua _serpl_toggle()<cr>",
				mode = { "n", "t" },
				desc = "Toggleterm: Toggle Serpl",
			},
		},
		opts = {},
		config = function()
			require("toggleterm").setup({
				shade_terminals = false,
				size = 20,
				float_opts = {
					border = "double",
				},
			})

			local Terminal = require("toggleterm.terminal").Terminal
			local default_term = Terminal:new({
				direction = "horizontal",
			})

			function _default_term_toggle() ---@diagnostic disable-line: lowercase-global
				default_term:toggle()
			end

			local function lazygit(command)
				-- Create a new terminal instance with the given command
				return Terminal:new({
					cmd = command,
					dir = "git_dir", -- Replace with actual Git directory or leave it to open in the current directory
					direction = "float",
					-- function to run on opening the terminal
					on_open = function(term)
						vim.cmd("startinsert!")
						vim.api.nvim_buf_set_keymap(
							term.bufnr,
							"n",
							"q",
							"<cmd>close<CR>",
							{ noremap = true, silent = true }
						)
					end,
					-- function to run on closing the terminal
					on_close = function(term)
						vim.cmd("startinsert!")
					end,
				})
			end

			-- Create terminal instances for lazygit and lazygit log
			local lazygit_terminal = lazygit("lazygit")
			local lazygit_log_terminal = lazygit("lazygit log")
			local file = vim.trim(vim.api.nvim_buf_get_name(0))
			local lazygit_log_file_terminal = lazygit("lazygit log -f " .. file)

			-- Functions to toggle each terminal instance
			function _lazygit_toggle() ---@diagnostic disable-line: lowercase-global
				lazygit_terminal:toggle()
			end

			function _lazygit_log_toggle() ---@diagnostic disable-line: lowercase-global
				lazygit_log_terminal:toggle()
			end

			function _lazygit_log_file_toggle() ---@diagnostic disable-line: lowercase-global
				lazygit_log_file_terminal:toggle()
			end

			local serpl = Terminal:new({
				cmd = "serpl",
				dir = "git_dir",
				direction = "float",
				-- function to run on opening the terminal
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(
						term.bufnr,
						"n",
						"q",
						"<cmd>close<CR>",
						{ noremap = true, silent = true }
					)
				end,
				-- function to run on closing the terminal
				on_close = function(term)
					vim.cmd("startinsert!")
				end,
			})

			function _serpl_toggle() ---@diagnostic disable-line: lowercase-global
				serpl:toggle()
			end
		end,
	},
	{
		"chrishrb/gx.nvim",
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		-- TODO: Long links don't work
		cmd = { "Browse" },
		init = function()
			vim.g.netrw_nogx = 1 -- disable netrw gx
		end,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
	},
	{
		"monaqa/dial.nvim",
		lazy = false,
		keys = {
			{
				"<C-a>",
				function()
					require("dial.map").manipulate("increment", "normal")
				end,
				desc = "dial: Increment number under cursor",
			},
			{
				"<C-x>",
				function()
					require("dial.map").manipulate("decrement", "normal")
				end,
				desc = "dial: Decrement number under cursor",
			},
			{
				"g<C-a>",
				function()
					require("dial.map").manipulate("increment", "gnormal")
				end,
				desc = "dial: Increment number under cursor",
			},
			{
				"g<C-x>",
				function()
					require("dial.map").manipulate("decrement", "gnormal")
				end,
				desc = "dial: Decrement number under cursor",
			},
			{
				"v<C-a>",
				function()
					require("dial.map").manipulate("increment", "visual")
				end,
				mode = { "v" },
				desc = "dial: Increment number under cursor",
			},
			{
				"v<C-x>",
				function()
					require("dial.map").manipulate("decrement", "visual")
				end,
				mode = { "v" },
				desc = "dial: Decrement number under cursor",
			},
			{
				"g<C-a>",
				function()
					require("dial.map").manipulate("increment", "gvisual")
				end,
				mode = { "v" },
				desc = "dial: Increment number under cursor",
			},
			{
				"g<C-x>",
				function()
					require("dial.map").manipulate("decrement", "gvisual")
				end,
				mode = { "v" },
				desc = "dial: Decrement number under cursor",
			},
		},
	},
	{
		"mistricky/codesnap.nvim",
		build = "make",
		cmd = { "CodeSnap", "CodeSnapSave" },
		keys = {
			{
				"<leader>cs",
				"<cmd>CodeSnap<cr>",
				mode = { "x" },
				desc = "codesnap: Screenshot code",
			},
		},
		opts = {
			mac_window_bar = true,
			has_breadcrumbs = true,
			save_path = "~/pictures/codesnap/",
			bg_color = "#535c68",
			watermark = "",
		},
	},
	{
		-- Direnv integration
		"direnv/direnv.vim",
		enabled = true,
	},
	{
		"gbprod/cutlass.nvim",
		opts = {
			cut_key = "x",
		},
	},
	{
		"sQVe/sort.nvim",
		opts = {},
		keys = {
			{
				"<leader>so",
				"<cmd>Sort<cr>",
				desc = "Sort: Sort lines",
			},
			{
				"<leader>so",
				"<esc><cmd>Sort<cr>",
				mode = { "v" },
			},
		},
	},
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			enabled = false,
		},
	},
	{
		-- Better vim help
		"OXY2DEV/helpview.nvim",
		lazy = false, -- Recommended

		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{
				"<leader>hv",
				"<cmd>Helpview toggleAll<cr>",
				desc = "Helpview: Toggle helpview",
			},
		},
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			notifier = {
				enabled = true,
				timeout = 3000,
			},
			quickfile = { enabled = true },
			styles = {
				notification = {
					wo = { wrap = true }, -- Wrap notifications
				},
			},
			words = { enabled = true },
		},
		config = function(_, opts)
			require("snacks").setup(opts)
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					local buffer = vim.api.nvim_get_current_buf()
					nmap("]]", function()
						require("snacks.words").jump(vim.v.count1)
					end, { desc = "Snacks: Next Reference", buffer = buffer })
					nmap("[[", function()
						require("snacks.words").jump(-vim.v.count1)
					end, { desc = "Snacks: Prev Reference", buffer = buffer })
				end,
			})
		end,
		keys = {
			{
				"<leader>un",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Snacks: Dismiss All Notifications",
			},
			{
				"<leader>bd",
				function()
					Snacks.bufdelete()
				end,
				desc = "Snacks: Delete Buffer",
			},
			{
				"<leader>gb",
				mode = { "n", "v" },
				function()
					Snacks.gitbrowse()
				end,
				desc = "Snacks: Git Browse",
			},
			{
				"<leader>cR",
				function()
					Snacks.rename()
				end,
				desc = "Snacks: Rename File",
			},
			{
				"]]",
				function()
					Snacks.words.jump(vim.v.count1)
				end,
				desc = "Snacks: Next Reference",
			},
			{
				"[[",
				function()
					Snacks.words.jump(-vim.v.count1)
				end,
				desc = "Snacks: Prev Reference",
			},
		},
	},
	-- {
	-- 	"philosofonusus/ecolog.nvim",
	-- 	dependencies = {
	-- 		"hrsh7th/nvim-cmp", -- Optional, for autocompletion support
	-- 	},
	-- 	keys = {
	-- 		{ "<leader>eg", "<cmd>EcologGoto<cr>", desc = "Ecolog: Go to env file" },
	-- 		{ "<leader>ep", "<cmd>EcologPeek<cr>", desc = "Ecolog: Peek variable" },
	-- 		{ "<leader>es", "<cmd>EcologSelect<cr>", desc = "Ecolog: Switch env file" },
	-- 	},
	-- 	lazy = false,
	-- 	opts = {
	-- 		-- Enables shelter mode for sensitive values
	-- 		shelter = {
	-- 			configuration = {
	-- 				partial_mode = false, -- Disables partial mode see shelter configuration below
	-- 			},
	-- 			modules = {
	-- 				cmp = true, -- Mask values in completion
	-- 			},
	-- 		},
	-- 		path = vim.fn.getcwd(), -- Path to search for .env files
	-- 	},
	-- },
	--
	{
		-- support for image pasting
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>pi",
				"<cmd>PasteImage<cr>",
				desc = "Img-clip: Paste image from clipboard",
			},
		},
		opts = {
			-- recommended settings
			default = {
				dir_path = "images",
				embed_image_as_base64 = false,
				prompt_for_file_name = false,
				drag_and_drop = {
					insert_mode = true,
				},
				-- required for Windows users
				use_absolute_path = true,
			},
		},
	},
	{
		"danymat/neogen",
		keys = {
			{
				"<leader>nf",
				"<cmd>lua require('neogen').generate()<cr>",
				desc = "Neogen: Generate code snippets",
			},
		},
		opts = {
			snippet_engine = "luasnip",
		},
	},
}
