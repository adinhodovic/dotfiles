local vim = vim
local set = vim.opt
local g = vim.g

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
vmap("q", "b")
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

nmap("<space>", ":")

-----------------------------------------
-- Base64
-----------------------------------------
vmap("<leader>b64e", ":<c-u>call base64#v_btoa()<cr>")
vmap("<leader>b64d", ":<c-u>call base64#v_atob()<cr>")
-----------------------------------------
-- Writing
-----------------------------------------
nmap("<F8>", ":<C-u>NextWordy<cr>")
xmap("<F8>", ":<C-u>NextWordy<cr>")
imap("<F8>", ":<C-o>NextWordy<cr>")

----------------------------------------
-- Linediff.vim
----------------------------------------
vmap('<leader>ld', ':Linediff<cr>')

----------------------------------------
-- Copilot
----------------------------------------
vim.cmd([[
imap <silent><script><expr> <C-c> copilot#Accept("\<CR>")
]])

----------------------------------------
-- Coc.nvim
----------------------------------------

local keyset = vim.keymap.set
-- Auto complete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use tab for trigger completion with characters ahead and navigate.
-- NOTE: There's always complete item selected by default, you may want to enable
-- no select by `"suggest.noselect": true` in your configuration file.
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugin before putting this into your config.
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice.
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion.
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use K to show documentation in preview window.
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

-- Highlight the symbol and its references when holding the cursor.
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})

-- Symbol renaming.
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

----------------------------------------
-- Telescope.nvim
----------------------------------------
git_files_changed = function()
    local previewers = require('telescope.previewers')
    local pickers = require('telescope.pickers')
    local sorters = require('telescope.sorters')
    local finders = require('telescope.finders')

    pickers.new {
        results_title = 'Modified on current branch',
        finder = finders.new_oneshot_job({'/home/adin/.dotfiles/scripts/git-files-changed.sh', 'list'}),
        sorter = sorters.get_fuzzy_file(),
        previewer = previewers.new_termopen_previewer {
            get_command = function(entry)
                return {'/home/adin/.dotfiles/scripts/git-files-changed.sh', 'diff', entry.value}
            end
        },
    }:find()
end

nmap('b', ":e #<cr>")
local builtin = require('telescope.builtin')
nmap('-', builtin.buffers)
nmap('=', git_files_changed)
nmap('<M-=>', builtin.find_files)
nmap('<M-->', builtin.git_files)
nmap('<leader>fg', builtin.live_grep)
nmap('<leader>fh', builtin.help_tags)
nmap('<leader>fr', ":Telescope coc references<cr>")
nmap('<leader>fd', ":Telescope coc definitions<cr>")
nmap('<leader>fds', ":Telescope coc document_symbols<cr>")

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
-- Markdown
-------------------------------------------
nmap("<leader>md", ":InstantMarkdownPreview<cr>")
nmap("<leader>ms", ":InstantMarkdownStop<cr>")

-------------------------------------------
-- GitGutter
-------------------------------------------
nmap("<leader>s", "<Plug>(GitGutterStageHunk)")
nmap("<leader>u", "<Plug>(GitGutterUndoHunk)")
nmap("ghp", "<Plug>(GitGutterPreviewHunk)")

-------------------------------------------
-- Fugitive
-------------------------------------------
nmap("<leader>gb", ":GBrowse<cr>")
nmap("<leader>gl", ":Git log<cr>")
vmap("<leader>gb", ":GBrowse<cr>")

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
