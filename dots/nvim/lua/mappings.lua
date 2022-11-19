local vim = vim
local set = vim.opt

function map(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end

function xmap(shortcut, command)
  map('x', shortcut, command)
end

-------------------------------------------
-- Moving around, tabs, windows and buffers
-------------------------------------------

-- Treat long lines as break lines (useful when moving around in them)
nmap("j", "gj")
nmap("k", "gk")

-- Disable highlight when <leader><cr> is pressed
nmap("<leader><cr>", ":noh<cr>")

-- Close the current buffer
nmap("<leader>bd", ":Bclose<cr>")
-- Close all the buffers
nmap("<leader>ba", ":1,1000 bd!<cr>")

nmap("m", "%")
vmap("m", "%")
-- set cmdwinheight=1

nmap("q", "b")
-- Movement begin/end of line
nmap("Q", "^")
nmap("W", "g_")
nmap("$", "<nop>")
nmap("^", "<nop>")
nmap(":", "<nop>")

-- Window movements
imap("<C-h>", "<esc>:wincmd h<cr>")
imap("<C-l>", "<esc>:wincmd l<cr>")
imap("<C-j>", "<esc>:wincmd j<cr>")
imap("<C-k>", "<esc>:wincmd k<cr>")

nmap("<C-h>", "<esc>:wincmd h<cr>")
nmap("<C-l>", "<esc>:wincmd l<cr>")
nmap("<C-j>", "<esc>:wincmd j<cr>")
nmap("<C-k>", "<esc>:wincmd k<cr>")

nmap("<leader>q", "q")
-- Execute macro over a visual selection
xmap("<leader>q", ":'<,'>:normal @q<CR>")

vim.cmd([[
execute 'nnoremap <space> :' . &cedit . 'a'
execute 'xnoremap <space> :' . &cedit . 'a'
execute 'nnoremap / /' . &cedit . 'a'
execute 'xnoremap / /' . &cedit . 'a'
execute 'nnoremap ? ?' . &cedit . 'a'
execute 'xnoremap ? ?' . &cedit . 'a'
]])
-- Linediff.vim
nmap('n', '<Leader>ld', ':Linediff<cr>')
