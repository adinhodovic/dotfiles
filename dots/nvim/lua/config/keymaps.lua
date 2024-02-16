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
nmap(":", "<nop>")

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

----------------------------------------
-- Grammarous
----------------------------------------
nmap("<leader>gc", ":GrammarousCheck<CR>")
vmap("<leader>gc", ":GrammarousCheck<CR>")

----------------------------------------
-- Thesaurus_query.vim
----------------------------------------
vim.g.tq_map_keys = 0
nmap("<leader>tq", ":ThesaurusQueryReplaceCurrentWord<CR>")
vmap("<leader>tq", ":ThesaurusQueryReplaceCurrentWord<CR>")
-------------------------------------------
-- Fugitive
-------------------------------------------

-------------------------------------------
-- Committia
-------------------------------------------
vim.cmd([[
  let g:committia_hooks = {}
  function! g:committia_hooks.edit_open(info)
      " Scroll the diff window from insert mode
      " Map <C-n> and <C-p>
      imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
      imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
  endfunction
]])

-------------------------------------------
-- Projects/Tree
-------------------------------------------
nmap("<leader>cd", ":Telescope projects<cr>")

-------------------------------------------
-- Delete/Paste text without copying
-------------------------------------------
nmap("<leader>d", '"_d')
xmap("<leader>d", '"_d')
nmap("<leader>dd", '"_dd')
xmap("<leader>dd", '"_dd')
xmap("<leader>p", '"_dP')

-------------------------------------------
-- MarkdownClipboardImage
-------------------------------------------
g.mdip_imgdir = "images"
nmap("<leader>mp", ":call mdip#MarkdownClipboardImage()<CR>")

-------------------------------------------
--  Spell checking
-------------------------------------------
-- Pressing ,se will toggle and untoggle spell checking
nmap("<leader>se", ":setlocal spell!<cr>")

-------------------------------------------
-- Dap
-------------------------------------------
nmap("<F5>", function()
	require("dap").continue()
end)
nmap("<F10>", function()
	require("dap").step_over()
end)
nmap("<F11>", function()
	require("dap").step_into()
end)
nmap("<F12>", function()
	require("dap").step_out()
end)
nmap("<Leader>br", function()
	require("dap").toggle_breakpoint()
end)
nmap("<Leader>dr", function()
	require("dap").repl.open()
end)
nmap("<Leader>dl", function()
	require("dap").run_last()
end)
vmap("<Leader>b", function()
	require("dapui").eval()
end)
vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
	require("dap.ui.widgets").hover()
end)
vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
	require("dap.ui.widgets").preview()
end)
vim.keymap.set("n", "<Leader>df", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.frames)
end)
vim.keymap.set("n", "<Leader>ds", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end)
