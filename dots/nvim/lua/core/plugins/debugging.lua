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
      "nvim-telescope/telescope.nvim"
    },
    priority = 100,
  },
  {
    -- DAP UI
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap"
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
    end
  },
  {
    -- DAP virtual text
    "theHamsta/nvim-dap-virtual-text",
  },
  {
    -- DAP python
    "mfussenegger/nvim-dap-python",
    lazy = true,
    ft = "python",
    config = function()
      require('dap-python').setup('/usr/bin/python')
    end
  },
  {
    -- DAP GO
    "leoluz/nvim-dap-go",
    lazy = true,
    ft = "go",
    config = function()
      require('dap-go').setup()
    end
  },
  {
    -- Telescope DAP integration
    "nvim-telescope/telescope-dap.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      require('telescope').load_extension('dap')
    end
  },
}
