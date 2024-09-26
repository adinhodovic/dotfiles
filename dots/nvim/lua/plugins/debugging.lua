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
				desc = "Dap: Toggle Breakpoint",
			},
			{
				"<leader>db",
				function()
					require("dap").run_to_cursor()
				end,
				desc = "Dap: Run to Cursor",
			},
			{
				"<leader>dr",
				function()
					require("dapui").float_element("repl")
				end,
				desc = "Dap: Repl",
			},
			{
				"<space>?",
				function()
					require("dapui").eval(nil, { enter = true })
				end,
				desc = "Dap: Evaluate Variable",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Dap: Continue",
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "Dap: Step Over",
			},
			{
				"<leader>dO",
				function()
					require("dap").step_out()
				end,
				desc = "Dap: Step Out",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Dap: Step Into",
			},
			{
				"<leader>ds",
				function()
					require("dap").step_back()
				end,
				desc = "Dap: Step Back",
			},
			{
				"<F8>",
				function()
					require("dap").terminate()
				end,
				desc = "Dap: Terminate",
			},
			{
				"<F9>",
				function()
					require("dap").restart()
				end,
				desc = "Dap: Restart",
			},
		},
		config = function()
			require("dapui").setup({
				mappings = {
					edit = "null",
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					repl = "r",
					toggle = "t",
				},
			})

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
		"leoluz/nvim-dap-go",
		opts = {},
		ft = "go",
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
