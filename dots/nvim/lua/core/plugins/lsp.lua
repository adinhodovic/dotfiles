local vim = vim
local g = vim.g
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local function set_autocmd(group, event, pattern, command)
  autocmd(event, {
    group = group,
    pattern = pattern,
    command = command
  })
end

-----------------------------------------
-- LSP
-----------------------------------------
return {
  {
    -- coc
    "neoclide/coc.nvim",
    build = "npm ci",
    lazy = false,
    priority = 1000,
    config = function ()
      g.coc_global_extensions = {
        'coc-pairs',
        'coc-json',
        'coc-yaml',
        'coc-vimlsp',
        'coc-emoji',
        'coc-yank',
        'coc-html',
        'coc-htmldjango',
        'coc-css',
        'coc-html-css-support',
        'coc-emmet',
        'coc-pyright',
        'coc-snippets',
        'coc-tsserver',
        '@yaegassy/coc-tailwindcss3',
        'coc-spell-checker',
        'coc-markdownlint',
        'coc-git',
        'coc-lists',
        'coc-prettier',
        'coc-go',
        'coc-lua',
        '@yaegassy/coc-ansible',
        '@yaegassy/coc-marksman',
        'coc-sql',
      }

      local cocGroup = augroup("coc", {})
      -- Highlight symbol under cursor on CursorHold
      set_autocmd(
        cocGroup,
        {
          "CursorHold"
        },
        { "html" },
        "silent call CocActionAsync('highlight')"
      )

      -- coc-tailwindcss3
      local coctailwindGroup = augroup("coctailwind", {})
      set_autocmd(
        coctailwindGroup,
        {
          "FileType"
        },
        { "html" },
        "let b:coc_root_patterns = ['.git', '.env', 'tailwind.config.js', 'tailwind.config.cjs']"
      )
    end
  },
}
