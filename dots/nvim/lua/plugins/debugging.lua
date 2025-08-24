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
		"miroshQa/debugmaster.nvim",
		lazy = false,
		-- osv is needed if you want to debug neovim lua code
		dependencies = { "mfussenegger/nvim-dap", "jbyuki/one-small-step-for-vimkind" },
		keys = {
			{
				"<space>d",
				function()
					require("debugmaster").mode.toggle()
				end,
				desc = "DebugMaster: Toggle Debug Mode",
			},
		},
		config = function()
			local dm = require("debugmaster")
			dm.plugins.osv_integration.enabled = true -- needed if you want to debug neovim lua code
		end,
	},
	{
		"mfussenegger/nvim-dap",
		keys = {
			{
				"<leader>db",
				function()
					require("dap").run_to_cursor()
				end,
				desc = "Dap: Run to Cursor",
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
		config = function() end,
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
	{
		"chrisgrieser/nvim-chainsaw",
		event = { "VeryLazy" },
		keys = {
			{ "g?p", ":lua require('chainsaw').emojiLog()<CR>", desc = "Chainsaw: Emoji Log" },
			{
				"g?v",
				mode = { "n", "v" },
				":lua require('chainsaw').variableLog()<CR>",
				desc = "Chainsaw: Variable Log",
			},
			{ "g?m", ":lua require('chainsaw').messageLog()<CR>", desc = "Chainsaw: Message Log" },
			{ "g?o", mode = { "n", "v" }, ":lua require('chainsaw').objectLog()<CR>", desc = "Chainsaw: Object Log" },
			{ "g?t", ":lua require('chainsaw').timeLog()<CR>", desc = "Chainsaw: Time Log" },
			{ "g?c", ":lua require('chainsaw').removeLogs()<CR>", desc = "Chainsaw: Clear" },
		},
	},
}
