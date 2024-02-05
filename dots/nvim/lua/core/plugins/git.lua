local vim = vim
local g = vim.g
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-----------------------------------------
-- Git
-----------------------------------------
return {
  {
    -- Better Git commits
    "rhysd/committia.vim",
  },
  {
    -- Show git messages
    "rhysd/git-messenger",
  },
  {
    -- Nvim Git integration
    "tpope/vim-fugitive",
    dependencies = {
      "tpope/vim-rhubarb"
    },
  },
  {
    -- Better git log
    "rbong/vim-flog",
  },
  {
    -- File type support for GitHub Actions
    "rhysd/vim-github-actions",
  },
  {
    -- Diff conflicts
    "rhysd/conflict-marker.vim",
  },
}
