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
				desc = "Shows the history of commits under the cursor in popup window.",
			},
		},
		config = function()
			g.git_messenger_include_diff = "current"
		end,
	},
	{
		-- Nvim Git integration
		"tpope/vim-fugitive",
		keys = {
			{
				"<leader>gb",
				":GBrowse<cr>",
				mode = { "n", "x" },
				desc = "Open the current file on GitHub",
			},
			{
				"<leader>gl",
				":Git log<cr>",
				desc = "Open the git log",
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
		config = function()
			require("gitsigns").setup({
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					map("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					-- Actions
					map("n", "<leader>hs", gs.stage_hunk)
					map("n", "<leader>hr", gs.reset_hunk)
					map("v", "<leader>hs", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)
					map("v", "<leader>hr", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)
					map("n", "<leader>hS", gs.stage_buffer)
					map("n", "<leader>hu", gs.undo_stage_hunk)
					map("n", "<leader>hR", gs.reset_buffer)
					map("n", "<leader>hp", gs.preview_hunk)
					map("n", "<leader>hb", function()
						gs.blame_line({ full = true })
					end)
					map("n", "<leader>tb", gs.toggle_current_line_blame)
					map("n", "<leader>hd", gs.diffthis)
					map("n", "<leader>hD", function()
						gs.diffthis("~")
					end)
					map("n", "<leader>td", gs.toggle_deleted)

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
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
		"aaronhallaert/ts-advanced-git-search.nvim",
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
				"<leader>gsa",
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
			"nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
		},
		config = true,
	},
	{
		"isak102/telescope-git-file-history.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope.nvim",
				"tpope/vim-fugitive",
			},
		},
		keys = {
			{
				"<leader>gfh",
				function()
					require("telescope").extensions.git_file_history.git_file_history()
				end,
				desc = "Telescope: Git File History",
			},
		},
		config = function()
			require("telescope").load_extension("git_file_history")
		end,
	},
}
