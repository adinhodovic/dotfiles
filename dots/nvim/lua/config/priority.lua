local vim = vim
-- Disable underline on cursorline
-- Nvim plugins overwrite this
vim.g.maplocalleader = ","

-------------------------------------------
-- Shared Lazy Settings
-------------------------------------------
local S = {}

S.ui_ft_blocklist = {
	"html",
	"diff",
	"cmp_menu",
	"snacks_dashboard",
	"qf",
	"git",
	"gitcommit",
	"unite",
	"oil",
	"help",
	"Trouble",
	"NeogitConsole",
	"NeogitStatus",
	"neotest-summary",
	"TelescopeResults",
	"TelescopePrompt",
	"fzf",
	"taskedit",
	"packer",
	"terminal",
	"log",
	"markdown",
	"lspinfo",
	"mason.nvim",
	"toggleterm",
	"text",
	"grug-far",
}

package.loaded["custom_settings"] = S
