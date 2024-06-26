return {
	{
		"stevearc/oil.nvim",
		cmd = "Oil",
		keys = {
			{
				"<leader>fo",
				":Oil --float <cr>",
				desc = "Oil: Open file explorer",
			},
		},
		opts = {
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
	{
		-- Project jumping
		-- Autocd to root of project
		"ahmedkhalf/project.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("project_nvim").setup({})
			require("telescope").load_extension("projects")
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
}
