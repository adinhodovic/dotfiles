return {
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		dependencies = { "folke/snacks.nvim", lazy = true },
		keys = {
			{
				"<leader>ff",
				mode = { "n", "v" },
				"<cmd>Yazi<cr>",
				desc = "Yazi: Open yazi at the current file",
			},
			{
				-- Open in the current working directory
				"<leader>fw",
				"<cmd>Yazi cwd<cr>",
				desc = "Yazi: Open the file manager in nvim's working directory",
			},
		},
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = true,
			floating_window_scaling_factor = 1,
			keymaps = {
				show_help = "~",
			},
		},
		init = function()
			-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
			-- vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
	},
	{
		-- File tree
		"nvim-tree/nvim-tree.lua",
		keys = {
			{
				"<leader>ft",
				":NvimTreeToggle<cr>",
				desc = "Nvim Tree: Open NvimTree",
			},
		},
		config = function()
			require("nvim-tree").setup({
				hijack_netrw = false,
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				update_focused_file = {
					enable = true,
					update_root = true,
				},
				view = {
					width = {
						min = 30,
						max = 50,
					},
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
		"stevearc/oil.nvim",
		cmd = "Oil",
		-- Yazi preferred
		keys = {
			{
				"<leader>fo",
				":Oil --float <cr>",
				desc = "Oil: Open file explorer",
			},
		},
		opts = {
			default_file_explorer = false,
			columns = {
				"icon",
				"size",
				"mtime",
			},
			win_options = {
				signcolumn = "yes:2",
			},
			view_options = {
				-- Show files and directories that start with "."
				show_hidden = true,
			},

			float = {
				max_width = 100,
				max_height = 0,
			},
		},
		-- Optional dependencies
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"SirZenith/oil-vcs-status",
		dependencies = {
			"stevearc/oil.nvim",
		},
		config = function()
			local status_const = require("oil-vcs-status.constant.status")

			local StatusType = status_const.StatusType

			require("oil-vcs-status").setup({
				status_symbol = {
					[StatusType.Added] = "",
					[StatusType.Copied] = "󰆏",
					[StatusType.Deleted] = "",
					[StatusType.Ignored] = "",
					[StatusType.Modified] = "",
					[StatusType.Renamed] = "",
					[StatusType.TypeChanged] = "󰉺",
					[StatusType.Unmodified] = " ",
					[StatusType.Unmerged] = "",
					[StatusType.Untracked] = "",
					[StatusType.External] = "",

					[StatusType.UpstreamAdded] = "󰈞",
					[StatusType.UpstreamCopied] = "󰈢",
					[StatusType.UpstreamDeleted] = "",
					[StatusType.UpstreamIgnored] = " ",
					[StatusType.UpstreamModified] = "󰏫",
					[StatusType.UpstreamRenamed] = "",
					[StatusType.UpstreamTypeChanged] = "󱧶",
					[StatusType.UpstreamUnmodified] = " ",
					[StatusType.UpstreamUnmerged] = "",
					[StatusType.UpstreamUntracked] = " ",
					[StatusType.UpstreamExternal] = "",
				},
			})
		end,
	},
}
