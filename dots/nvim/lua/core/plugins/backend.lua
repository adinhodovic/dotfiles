local vim = vim
local g = vim.g
-----------------------------------------
-- Backend
-----------------------------------------
return {
	{
		-- Go
		"fatih/vim-go",
		ft = "go",
		config = function()
			-- disable all linters as that is taken care of by coc.nvim
			g.go_diagnostics_enabled = 0
			g.go_metalinter_enabled = 0

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
