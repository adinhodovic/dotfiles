local vim = vim
local g = vim.g
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-----------------------------------------
-- Git
-----------------------------------------
return {
	{
		-- Better Git commits
		"rhysd/committia.vim",
		ft = { "gitcommit" },
		config = function()
			vim.cmd([[
        let g:committia_hooks = {}
        function! g:committia_hooks.edit_open(info)
          " Scroll the diff window from insert mode
          " Map <C-n> and <C-p>
          imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
          imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
        endfunction
      ]])
		end,
	},
	{
		-- Show git messages
		"rhysd/git-messenger.vim",
		keys = {
			{
				"<leader>gm",
				"<Plug>(GitMessenger)",
				desc = "GitMessenger: Shows the history of commits under the cursor in popup window.",
			},
		},
		config = function()
			g.git_messenger_include_diff = "current"
		end,
	},
	{
		-- Nvim Git integration
		"tpope/vim-fugitive",
		cmd = { "Git" },
		keys = {
			{
				"<leader>gb",
				":GBrowse<cr>",
				mode = { "n", "x" },
				desc = "Fugitive: Open the current file on GitHub",
			},
			{
				"<leader>gl",
				":Git log<cr>",
				desc = "Fugitive: Open the git log",
			},
		},
		dependencies = {
			"tpope/vim-rhubarb",
		},
		config = function()
			vim.api.nvim_create_user_command("Browse", function(opts)
				vim.fn.system({ "xdg-open", opts.fargs[1] })
			end, { nargs = 1 })
		end,
	},
	{
		-- Flog is a fast, beautiful, and powerful git branch viewer for Vim.
		"rbong/vim-flog",
		lazy = true,
		cmd = { "Flog", "Flogsplit", "Floggit" },
		dependencies = {
			"tpope/vim-fugitive",
		},
	},
	{
		-- File type support for GitHub Actions
		"rhysd/vim-github-actions",
	},
	{
		"lewis6991/gitsigns.nvim",
		keys = {
			{
				"]c",
				function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						require("gitsigns").nav_hunk("next")
					end
				end,
				desc = "Gitsigns: Next hunk",
			},
			{
				"[c",
				function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						require("gitsigns").nav_hunk("prev")
					end
				end,
				desc = "Gitsigns: Previous hunk",
			},
			{
				"<leader>hs",
				function()
					require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end,
				mode = "v",
				desc = "Gitsigns: Stage hunk",
			},
			{
				"<leader>hr",
				function()
					require("gitsigns").reset_hunk(vim.fn.line("."))
				end,
				mode = "v",
				desc = "Gitsigns: Reset hunk",
			},
			{
				"<leader>hS",
				"<cmd>lua require('gitsigns').stage_buffer()<cr>",
				desc = "Gitsigns: Stage buffer",
			},
			{
				"<leader>hu",
				"<cmd>lua require('gitsigns').undo_stage_hunk()<cr>",
				desc = "Gitsigns: Undo stage hunk",
			},
			{
				"<leader>hR",
				"<cmd>lua require('gitsigns').reset_buffer()<cr>",
				desc = "Gitsigns: Reset buffer",
			},
			{
				"<leader>hp",
				"<cmd>lua require('gitsigns').preview_hunk()<cr>",
				desc = "Gitsigns: Preview hunk",
			},
			{
				"<leader>hb",
				function()
					require("gitsigns").blame_line({ full = true })
				end,
				desc = "Gitsigns: Blame line",
			},
			{
				"<leader>tb",
				"<cmd>lua require('gitsigns').toggle_current_line_blame()<cr>",
				desc = "Gitsigns: Toggle current line blame",
			},
			{
				"<leader>hd",
				"<cmd>lua require('gitsigns').diffthis()<cr>",
				desc = "Gitsigns: Diff this",
			},
			{
				"<leader>hD",
				function()
					require("gitsigns").diffthis("~")
				end,
				desc = "Gitsigns: Diff this",
			},
			{
				"<leader>td",
				"<cmd>lua require('gitsigns').toggle_deleted()<cr>",
				desc = "Gitsigns: Toggle deleted",
			},
			{
				"ih",
				":<C-U>Gitsigns select_hunk<CR>",
				mode = { "o", "x" },
				desc = "Gitsigns: Select hunk",
			},
		},
		opts = {},
	},
	{
		"akinsho/git-conflict.nvim",
		config = true,
	},
	{
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
		},
		opts = {},
	},
	{
		"aaronhallaert/advanced-git-search.nvim",
		config = function()
			require("telescope").load_extension("advanced_git_search")
		end,
		dependencies = {
			"nvim-telescope/telescope.nvim",
			-- to show diff splits and open commits in browser
			"tpope/vim-fugitive",
		},
		keys = {
			{
				"<leader>gas",
				"<cmd>Telescope advanced_git_search show_custom_functions<cr>",
				desc = "Advanced Git Search",
			},
		},
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed, not both.
			"ibhagwan/fzf-lua", -- optional
		},
		config = true,
	},
	{
		"FabijanZulj/blame.nvim",
		opts = {},
		keys = {
			{
				"<leader>gbl",
				"<cmd>BlameToggle<cr>",
				desc = "Git blame: Toggle",
			},
		},
	},
}
