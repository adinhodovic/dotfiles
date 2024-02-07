local vim = vim
local g = vim.g
-----------------------------------------
-- Backend
-----------------------------------------
return {
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
			local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					require("go.format").goimport()
				end,
				group = format_sync_grp,
			})
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
	{
		-- Go
		"fatih/vim-go",
		enabled = false,
		config = function()
			-- disable all linters as that is taken care of by vim
			g.go_diagnostics_enabled = 0
			g.go_metalinter_enabled = 0
			g.go_list_type = ""

			-- don't jump to errors after metalinter is invoked
			g.go_jump_to_error = 0

			-- automatically highlight variable your cursor is on
			g.go_auto_sameids = 0
			g.go_def_mapping_enabled = 0
			g.go_gopls_enabled = 0
			g.go_code_completion_enabled = 0
			g.go_fmt_autosave = 0
			g.go_echo_go_info = 0
			g.go_metalinter_autosave = 0
		end,
	},
	{
		-- Delve debugging
		"sebdah/vim-delve",
		ft = "go",
	},
	{
		-- Ruby
		"vim-ruby/vim-ruby",
		ft = "ruby",
	},
}
