local vim = vim
local g = vim.g
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-----------------------------------------
-- Documentation/Writing
-----------------------------------------
return {
	{
		"MeanderingProgrammer/markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		ft = { "markdown", "norg", "rmd", "org" },
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
		keys = {
			{
				"<leader>gc",
				":GrammarousCheck<CR>",
				mode = { "n", "v" },
				desc = "Grammarous: Check grammar",
			},
		},
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
		init = function()
			g.mdip_imgdir = "images"
		end,
		keys = {
			{
				"<leader>mp",
				":call mdip#MarkdownClipboardImage()<CR>",
				desc = "Paste image from clipboard",
			},
		},
	},
	{
		-- Thesaurus
		"ron89/thesaurus_query.vim",
		lazy = true,
		ft = "markdown",
		init = function()
			g.tq_map_keys = 0
		end,
		keys = {
			{
				"<leader>tq",
				":ThesaurusQueryReplaceCurrentWord<CR>",
				mode = { "n", "v", "x" },
				desc = "Thesaurus: Query word",
			},
		},
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
