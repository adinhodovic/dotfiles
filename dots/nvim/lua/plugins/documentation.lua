local vim = vim
local g = vim.g
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

return {
	{
		"kkoomen/vim-doge",
		build = ":call doge#install()",
		event = "BufRead",
		init = function()
			vim.g.doge_enable_mappings = true
			vim.g.doge_mapping = "<leader>dg"
		end,
		keys = {
			{
				"<leader>dgn",
				"<Plug>(doge-comment-jump-forward)",
				mode = { "n", "x" },
				desc = "Jump to next comment",
			},
			{
				"<leader>dgp",
				"<Plug>(doge-comment-jump-backward)",
				mode = { "n", "x" },
				desc = "Jump to previous comment",
			},
		},
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
}
