local vim = vim
local g = vim.g
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-----------------------------------------
-- Documentation/Writing
-----------------------------------------
return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		ft = { "markdown", "norg", "rmd", "org", "Avante" },
		opts = {
			heading = {
				-- Turn on / off heading icon & background rendering
				enabled = false,
			},
			bullet = {
				-- Turn on / off list bullet rendering
				enabled = false,
			},
			code = {
				style = "language",
			},

			latex = { enabled = false },
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
		keys = {
			{
				"<leader>md",
				":MarkdownPreviewToggle<cr>",
				desc = "Start instant markdown preview",
			},
		},
	},
	{
		-- Obsidian
		"epwalsh/obsidian.nvim",
		lazy = true,
		enabled = false,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			vim.opt.conceallevel = 1
			require("obsidian").setup({
				ui = {
					-- use markdown.nvim instead for these
					checkboxes = {},
					bullets = {},
					external_link_icon = {},
				},
				workspaces = {
					{
						name = "notes",
						path = "~/personal/notes",
						disable_frontmatter = false,
					},
					{
						name = "blogs",
						path = "~/personal/blogs",
						disable_frontmatter = true,
					},
				},
				disable_frontmatter = true,
			})
		end,
	},
}
