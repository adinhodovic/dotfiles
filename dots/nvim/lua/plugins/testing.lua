local vim = vim

return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-python"),
				},
			})
		end,
		keys = {
			{
				"<leader>tr",
				function()
					require("neotest").run.run()
				end,
				desc = "Neotest: Run tests (default nearest test)",
			},
			{
				"<leader>tf",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Neotest: Run all tests in file",
			},
			{
				"<leader>td",
				function()
					require("neotest").run.run({ strategy = "dap" })
				end,
				desc = "Neotest: Debug test (with dap)",
			},
			{
				"<leader>ts",
				function()
					require("neotest").run.stop()
				end,
				desc = "Neotest: Stop test run",
			},
			{
				"<leader>ta",
				function()
					require("neotest").run.attach()
				end,
				desc = "Neotest: Attach to test run",
			},
			{
				"<leader>twr",
				function()
					require("neotest").watch.toggle()
				end,
				desc = "Neotest: Toggle test watcher",
			},
			{
				"<leader>twf",
				function()
					require("neotest").watch.toggle(vim.fn.expand("%"))
				end,
				desc = "Neotest: Toggle test watcher for file",
			},
			{
				"<leader>to",
				function()
					require("neotest").output_panel.toggle()
				end,
			},
			{
				"<leader>tos",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Neotest: Toggle test summary",
			},
		},
	},
}
