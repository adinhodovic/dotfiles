local vim = vim
local g = vim.g
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-----------------------------------------
-- Documentation/Writing
-----------------------------------------
return {
	{
		-- Instant markdown reader
		"instant-markdown/vim-instant-markdown",
		lazy = true,
		ft = "markdown",
		config = function()
			-- Disable autostart of md composer
			g.instant_markdown_browser = "chromium --new-window"
			g.instant_markdown_autostart = 0
		end,
	},
	{
		-- Markdown
		"preservim/vim-markdown",
		lazy = true,
		ft = "markdown",
		config = function()
			-- Disable markdown code block conceals
			g.vim_markdown_conceal = 0
			g.vim_markdown_conceal_code_blocks = 0

			-- Disable folding, we have search
			g.vim_markdown_folding_disabled = 1
		end,
	},
	{
		-- Markdown ToC
		"mzlogin/vim-markdown-toc",
		lazy = true,
		ft = "markdown",
	},
	{
		-- Words
		"rhysd/vim-grammarous",
		lazy = true,
		ft = "markdown",
	},
	{
		-- Writing tooling
		"reedes/vim-pencil",
		lazy = true,
		ft = "markdown",
		init = function()
			g["pencil#wrapModeDefault"] = "soft"
			g["pencil#conceallevel"] = 2

			local pencilGroup = augroup("pencil", {})
			autocmd("FileType", {
				pattern = { "markdown", "mkd" },
				command = "call pencil#init()",
				group = pencilGroup,
			})
		end,
	},
	{
		-- Markdown image pasting
		"ferrine/md-img-paste.vim",
		lazy = true,
		ft = "markdown",
	},
	{
		-- Thesaurus
		"ron89/thesaurus_query.vim",
		lazy = true,
		ft = "markdown",
	},
	{
		-- Words
		"reedes/vim-wordy",
		lazy = true,
		ft = "markdown",
	},
	{
		-- Obsidian
		"epwalsh/obsidian.nvim",
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			vim.opt.conceallevel = 1
			require("obsidian").setup({
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
