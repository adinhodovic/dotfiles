local vim = vim

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
}
