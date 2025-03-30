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
-- Frontend
-----------------------------------------
return {
	{
		"pmizio/typescript-tools.nvim",
		ft = {
			"typescript",
			"typescriptreact",
		},
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	{
		"luckasRanarison/tailwind-tools.nvim",
		config = function()
			require("tailwind-tools").setup({})
			local tailwindGroup = augroup("tailwind", {})
			set_autocmd(tailwindGroup, { "BufWritePre" }, { "*.html" }, "TailwindSort")
		end,
		ft = {
			"htmldjango",
			"html",
			"jsx",
			"tsx",
			"css",
			"scss",
			"less",
		},
	},
	{
		"MaximilianLloyd/tw-values.nvim",
		keys = {
			{
				"<leader>sv",
				"<cmd>TWValues<cr>",
				desc = "Show tailwind CSS values",
			},
		},
		opts = {},
	},
}
