require('plugins')
-- require('configs')
-- require('keybindings')

local vim = vim
local set = vim.opt
local map = vim.keymap.set

vim.g.hardtime_default_on = 0

vim.g.hardtime_maxcount = 2
vim.g.hardtime_allow_different_key = 1

vim.opt.completeopt=preview,menu

vim.opt.mouse=a

-- Set to auto read when a file is changed from the outside
vim.opt.autoread = true

vim.g.mapleader = ','
-- if hidden is not set, TextEdit might fail.
set.hidden = true

-- Better display for messages
set.cmdheight = 2

-- don't give |ins-completion-menu| messages.
set.shortmess = c

-- always show signcolumns
set.signcolumn = 'yes'

-- Bullets.vim
vim.g.bullets_enabled_file_types = {
     'markdown',
     'text',
     'gitcommit',
     'scratch'
}

-- Linediff.vim
map('n', '<Leader>ld', ':Linediff<cr>')

vim.cmd('source ~/.config/nvim/config.vim')
