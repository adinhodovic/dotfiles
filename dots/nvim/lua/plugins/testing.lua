local vim = vim

return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-go",
		},
		config = function()
			-- get neotest namespace (api call creates or returns namespace)
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)

			require("neotest").setup({
				adapters = {
					require("neotest-python"),
					require("neotest-go"),
				},
				output = {
					enter = true,
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
				"<leader>trs",
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
					require("neotest").output.open({ enter = true })
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
