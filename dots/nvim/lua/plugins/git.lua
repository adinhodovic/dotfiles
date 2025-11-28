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
				function()
					require("gitsigns").stage_buffer()
				end,
				desc = "Gitsigns: Stage buffer",
			},
			{
				"<leader>hu",
				function()
					require("gitsigns").undo_stage_hunk()
				end,
				desc = "Gitsigns: Undo stage hunk",
			},
			{
				"<leader>hR",
				function()
					require("gitsigns").reset_buffer()
				end,
				desc = "Gitsigns: Reset buffer",
			},
			{
				"<leader>hp",
				function()
					require("gitsigns").preview_hunk()
				end,
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
				"<leader>hd",
				function()
					require("gitsigns").diffthis()
				end,
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
				"<leader>gstw",
				function()
					require("gitsigns").toggle_word_diff()
				end,
				desc = "Gitsigns: Toggle word diff",
			},
			{
				"<leader>gstl",
				function()
					require("gitsigns").toggle_linehl()
				end,
				desc = "Gitsigns: Toggle line highlight",
			},
			{
				"<leader>gstd",
				function()
					require("gitsigns").toggle_deleted()
				end,
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
		"esmuellert/vscode-diff.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {},
		cmd = {
			"CodeDiff",
		},
		keys = {
			{
				"<leader>gd",
				"<cmd>CodeDiff<cr>",
				desc = "VSCode Diff: Open",
			},
		},
	},
	{
		"aaronhallaert/advanced-git-search.nvim",
		dependencies = {
			"ibhagwan/fzf-lua",
			"sindrets/diffview.nvim",
		},
		keys = {
			{
				"<leader>gas",
				"<cmd>AdvancedGitSearch<cr>",
				mode = { "n", "v" },
				desc = "Advanced-git-search: Open",
			},
		},
		config = function()
			require("advanced_git_search.fzf").setup({
				git_flags = { "-c", "delta.side-by-side=false" },
				git_diff_flags = {},
				git_log_flags = {},
				show_builtin_git_pickers = true,
				diff_plugin = "diffview",
				entry_default_author_or_date = "author",
			})
		end,
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed, not both.
			"ibhagwan/fzf-lua", -- optional
		},
		keys = {
			{
				"<leader>ng",
				"<cmd>Neogit<cr>",
				desc = "Neogit: Open",
			},
		},
		opts = {},
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
