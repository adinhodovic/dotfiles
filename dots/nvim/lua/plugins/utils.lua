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
}
