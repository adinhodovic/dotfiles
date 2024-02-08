local vim = vim
local g = vim.g
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Define a function to simplify setting autocmds
local function set_autocmd(group, event, pattern, command)
  autocmd(event, {
    group = group,
    pattern = pattern,
    command = command
  })
end

-----------------------------------------
-- Infrastructure
-----------------------------------------
return {
  {
    -- Nginx
    "chr4/nginx.vim",
    ft = "nginx"
  },
}
