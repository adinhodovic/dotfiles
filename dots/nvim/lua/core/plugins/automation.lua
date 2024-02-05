local vim = vim
local g = vim.g
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-----------------------------------------
-- Automation
-----------------------------------------
return {
  {
    -- Open at last place
    "farmergreg/vim-lastplace"
  },
  {
    -- Increment dates
    "tpope/vim-speeddating",
  },
  {
    -- Semicolons
    "lfilho/cosco.vim",
  },
  {
    -- Telescope
    "nvim-telescope/telescope.nvim",
    priority = 1000,
    config = function()
      require("telescope").setup({
        extensions = {
          coc = {
            theme = 'ivy',
            prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
          }
        },
      })
    end
  },
  {
    -- Telescope CoC
    "fannheyward/telescope-coc.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "neoclide/coc.nvim"
    },
    config = function()
      require('telescope').load_extension('coc')
    end
  },
  {
    -- Project jumping
    "ahmedkhalf/project.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      require("project_nvim").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
      require('telescope').load_extension('projects')
    end
  },
  {
    -- File tree
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true
        },
        sort = {
          sorter = "case_sensitive",
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      })
    end
  },
  {
    -- Markbar
    "Yilin-Yang/vim-markbar",
    config = function()
    end
  },
  {
    -- Peek line numbers
    "nacro90/numb.nvim",
    config = function()
      require('numb').setup()
    end
  },
  {
    -- Search and replace
    "nvim-pack/nvim-spectre",
    config = function()
      require('spectre').setup()
    end
  },
  {
    -- Better folding
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async"
    },
    config = function()
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local totalLines = vim.api.nvim_buf_line_count(0)
        local totalLines = vim.api.nvim_buf_line_count(0)
        local foldedLines = endLnum - lnum
        local suffix = ("  %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        local rAlignAppndx =
            math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
        suffix = (" "):rep(rAlignAppndx) .. suffix
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end

      -- global handler
      -- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
      -- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
      require('ufo').setup({
        fold_virt_text_handler = handler
      })
    end
  },
  {
    -- Better search
    "folke/flash.nvim",
    config = function()
      require("flash").setup()
    end
  },
  {
    -- Better notifications
    "folke/noice.nvim",
    config = function()
      -- require('noice').setup()
    end
  },
}
