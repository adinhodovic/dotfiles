local vim = vim

vim.api.nvim_create_augroup("htmlDjango", {})
vim.api.nvim_create_autocmd("BufWritePost", {
    group = "htmlDjango",
    command = "call CocAction('format')",
    desc = "Format on save manually due to slow DjLint performance and timeouts"
})
