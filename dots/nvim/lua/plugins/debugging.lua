local vim = vim
local g = vim.g
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-----------------------------------------
-- Debugging
-----------------------------------------
return {
	{
		-- Debugging adapter protocol
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		priority = 100,
	},
	{
		-- DAP UI
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
	},
	{
		"mfussenegger/nvim-dap",
		keys = {
			{
				"<space>b",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint",
			},
			{
				"<space>gb",
				function()
					require("dap").run_to_cursor()
				end,
				desc = "Run to Cursor",
			},
			{
				"<space>?",
				function()
					require("dapui").eval(nil, { enter = true })
				end,
				desc = "Evaluate Variable",
			},
			{
				"<F1>",
				function()
					require("dap").continue()
				end,
				desc = "Continue",
			},
			{
				"<F2>",
				function()
					require("dap").step_over()
				end,
				desc = "Step Over",
			},
			{
				"<F3>",
				function()
					require("dap").step_into()
				end,
				desc = "Step Into",
			},
			{
				"<F4>",
				function()
					require("dap").step_out()
				end,
				desc = "Step Out",
			},
			{
				"<F5>",
				function()
					require("dap").step_back()
				end,
				desc = "Step Back",
			},
			{
				"<F13>",
				function()
					require("dap").restart()
				end,
				desc = "Restart",
			},
		},
		config = function()
			require("dapui").setup()

			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},
	{
		-- DAP virtual text
		"theHamsta/nvim-dap-virtual-text",
		opts = {},
	},
	{
		-- DAP python
		"mfussenegger/nvim-dap-python",
		lazy = true,
		ft = "python",
		config = function()
			require("dap-python").setup("/usr/bin/python")
		end,
	},
	{
		-- Telescope DAP integration
		"nvim-telescope/telescope-dap.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("dap")
		end,
	},
}
