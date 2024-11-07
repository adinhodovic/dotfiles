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
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
		},
		keys = {
			{
				"<leader>gd",
				"<cmd>DiffviewOpen<cr>",
				desc = "DiffView: Open",
			},
			{
				"<leader>gdc",
				"<cmd>DiffviewClose<cr>",
				desc = "DiffView: Close",
			},
			{
				"<leader>gdlm",
				function()
					vim.cmd("DiffviewOpen " .. get_default_branch_name())
				end,
				desc = "DiffView: Open Diff Local Main",
			},
			{
				"<leader>gdrm",
				function()
					vim.cmd("DiffviewOpen HEAD..origin/" .. get_default_branch_name())
				end,
				desc = "DiffView: Open Diff Local Main",
			},
			{
				"<leader>gdr",
				"<cmd>DiffviewFileHistory<cr>",
				desc = "DiffView: Repo history",
			},
			{
				"<leader>gdf",
				"<cmd>DiffviewFileHistory --follow %<cr>",
				desc = "DiffView: File history",
			},
			{
				"<leader>gdv",
				"<Esc><Cmd>'<,'>DiffviewFileHistory --follow<CR>",
				mode = { "v" },
				desc = "DiffView: Visual History",
			},
			{
				"<leader>gdl",
				"<Cmd>.DiffviewFileHistory --follow<CR>",
				desc = "DiffView: Line History",
			},
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
		keys = {
			{
				"<leader>gl",
			},
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
