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

vim.cmd([[
execute 'nnoremap <space> :' . &cedit . 'a'
execute 'xnoremap <space> :' . &cedit . 'a'
execute 'nnoremap / /' . &cedit . 'a'
execute 'xnoremap / /' . &cedit . 'a'
execute 'nnoremap ? ?' . &cedit . 'a'
execute 'xnoremap ? ?' . &cedit . 'a'
]])

-- Linediff.vim
vmap('<leader>ld', ':Linediff<cr>')

-- Telescope.nvim
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

-- Grammarous
nmap("<leader>gc", ":GrammarousCheck<CR>")

-- Thesaurus_query.vim
vim.g.tq_map_keys = 0
nmap("<leader>tq", ":ThesaurusQueryReplaceCurrentWord<CR>")

