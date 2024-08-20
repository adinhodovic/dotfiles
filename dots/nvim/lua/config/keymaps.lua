local vim = vim
local set = vim.opt
local g = vim.g

local function default(val, default_val)
	if val == nil then
		return default_val
	else
		return val
	end
end

local default_options = { noremap = true, silent = true }
local default_options_expression = { noremap = true, silent = true, expr = true, replace_keycodes = false }

local function map(mode, shortcut, command, options)
	options = default(options, default_options)
	vim.keymap.set(mode, shortcut, command, options)
end

local function nmap(shortcut, command, options)
	map("n", shortcut, command, options)
end

local function imap(shortcut, command, options)
	map("i", shortcut, command, options)
end

local function vmap(shortcut, command, options)
	map("v", shortcut, command, options)
end

local function xmap(shortcut, command, options)
	map("x", shortcut, command, options)
end

local function omap(shortcut, command, options)
	map("o", shortcut, command, options)
end

local function cmap(shortcut, command, options)
	map("c", shortcut, command, options)
end

-------------------------------------------
-- Moving around, tabs, windows and buffers
-------------------------------------------

-- Treat long lines as break lines (useful when moving around in them)
nmap("j", "gj")
nmap("k", "gk")

-- Disable highlight when <leader><cr> is pressed
nmap("<leader><cr>", ":noh<cr>")

vim.cmd([[
  " Don't close window, when deleting a buffer
  command! Bclose call BufcloseCloseIt()
  function! BufcloseCloseIt()
    let l:currentBufNum = bufnr('%')
    let l:alternateBufNum = bufnr('#')

    if buflisted(l:alternateBufNum)
      buffer #
    else
      bnext
    endif

    if bufnr('%') == l:currentBufNum
      new
    endif

    if buflisted(l:currentBufNum)
      execute('bdelete! '.l:currentBufNum)
    endif
  endfunction
]])

-- Close the current buffer
nmap("<leader>bd", ":Bclose<cr>")
-- Close all the buffers
nmap("<leader>ba", ":1,1000 bd!<cr>")

nmap("q", "b")
vmap("q", "b")
-- Movement begin/end of line
nmap("Q", "^")
vmap("Q", "^")
nmap("W", "g_")

-- Window movements
imap("<C-h>", "<esc>:wincmd h<cr>")
imap("<C-l>", "<esc>:wincmd l<cr>")
imap("<C-j>", "<esc>:wincmd j<cr>")
imap("<C-k>", "<esc>:wincmd k<cr>")

nmap("<C-h>", "<esc>:wincmd h<cr>")
nmap("<C-l>", "<esc>:wincmd l<cr>")
nmap("<C-j>", "<esc>:wincmd j<cr>")
nmap("<C-k>", "<esc>:wincmd k<cr>")

-- Execute macro over a visual selection
xmap("<leader>q", ":'<,'>:normal @q<CR>")

nmap("<space>", ":", { noremap = true, silent = false })
vmap("<space>", ":", { noremap = true, silent = false })
xmap("<space>", ":", { noremap = true, silent = false })
nmap(":", "<nop>")
vmap(":", "<nop>")
xmap(":", "<nop>")

-- Visual mode pressing * or # searches for the current selection
-- Super useful! From an idea by Michael Naumann
vim.cmd([[
function! CmdLine(str)
  exe 'menu Foo.Bar :' . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction

function! VisualSelection(direction) range
  let l:saved_reg = @"
  execute 'normal! vgvy'

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, '\n$', '', '')

  if a:direction ==# 'b'
    execute 'normal ?' . l:pattern . '^M'
  elseif a:direction ==# 'gv'
    call CmdLine('vimgrep' . '/'. l:pattern . '/' . ' **/*.')
  elseif a:direction ==# 'replace'
    call CmdLine('%s' . '/'. l:pattern . '/')
  elseif a:direction ==# 'f'
    execute 'normal /' . l:pattern . '^M'
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction
]])

vmap("*", ":call VisualSelection('f')<CR>")
vmap("#", ":call VisualSelection('b')<CR>")

-----------------------------------------
-- Writing
-----------------------------------------
nmap("<F8>", ":<C-u>NextWordy<cr>")
xmap("<F8>", ":<C-u>NextWordy<cr>")
imap("<F8>", ":<C-o>NextWordy<cr>")

-------------------------------------------
--  Spell checking
-------------------------------------------
-- Pressing ,se will toggle and untoggle spell checking
nmap("<leader>sss", ":setlocal spell!<cr>")
