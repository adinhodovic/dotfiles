local vim = vim
local g = vim.g
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-----------------------------------------
-- Frontend
-----------------------------------------
return {
  {
    -- Tag matching
    "AndrewRadev/tagalong.vim",
    ft = "html"
  },
  {
    -- Provides support for expanding abbreviations similar to emmet.
    "mattn/emmet-vim",
    dependencies = {
      "mfussenegger/nvim-dap"
    },
  },
  {
    -- CSS syntax
    "hail2u/vim-css3-syntax",
    lazy = true,
    ft = {
      "css",
      "scss",
      "less",
    },
  },
  {
    -- Tailwind class sorting
    "laytan/tailwind-sorter.nvim",
    build = "cd formatter && npm i && npm run build",
    lazy = true,
    ft = {
      "css",
      "scss",
      "less",
    },
    config = function()
      require('tailwind-sorter').setup({
        on_save_enabled = true, -- If `true`, automatically enables on save sorting.
      })
    end
  },
}
