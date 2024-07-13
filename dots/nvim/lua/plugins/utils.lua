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

			local lazygit = Terminal:new({
				cmd = "lazygit",
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

			function _lazygit_toggle() ---@diagnostic disable-line: lowercase-global
				lazygit:toggle()
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

			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
				vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
			end

			-- if you only want these mappings for toggle term use term://*toggleterm#* instead
			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
		end,
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
		"ellisonleao/carbon-now.nvim",
		opts = {},
		keys = {
			{
				"<F6>",
				":CarbonNow<CR>",
				mode = { "x" },
				desc = "CarbowNow: Open Carbon.sh with selected text",
			},
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
}
