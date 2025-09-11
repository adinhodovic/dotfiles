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
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim", -- optional
			"neovim/nvim-lspconfig", -- optional
		},
		config = function()
			require("tailwind-tools").setup({
				options = {
					server = {
						-- override = false,
						root_dir = require("lspconfig").util.root_pattern(
							"tailwind.config.js",
							"tailwind.config.ts",
							"tailwind.input.css",
							"postcss.config.js",
							"postcss.config.ts",
							"package.json",
							"node_modules",
							"dj_tailwind_output"
						),
					},
				},
			})
			local tailwindGroup = augroup("tailwind", {})
			-- This messes up django if statements
			-- set_autocmd(tailwindGroup, { "BufWritePre" }, { "*.html" }, "TailwindSort")
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
