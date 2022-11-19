local vim = vim
local set = vim.opt
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

vim.g.hardtime_default_on = 0

vim.g.hardtime_maxcount = 2
vim.g.hardtime_allow_different_key = 1

vim.opt.completeopt=preview,menu

vim.opt.mouse=a

-- Set to auto read when a file is changed from the outside
vim.opt.autoread = true

vim.g.mapleader = ','

-- don't give |ins-completion-menu| messages.
set.shortmess = "c"

-- always show signcolumns
set.signcolumn = 'yes'

-- Bullets.vim
vim.g.bullets_enabled_file_types = {
     'markdown',
     'text',
     'gitcommit',
     'scratch'
}

set.cmdwinheight = 1

-------------------------------------------
-- History
-------------------------------------------
-- Sets how many lines of history VIM has to remember
set.history = 1000

-------------------------------------------
-- Spelling
-------------------------------------------
set.spell = false
set.spellfile = "~/.dotfiles/spell/en.utf-8.add"
set.title = true
set.number = true

-------------------------------------------
--           Files, backups and undo
-------------------------------------------
-- Turn backup off, since most stuff is in SVN, git etc. anyway...
set.backup = false
set.writebackup = false
set.swapfile = false

-------------------------------------------
--           Text, tab and indent related
-------------------------------------------
-- Use spaces instead of tabs
set.expandtab =  true

-- Be smart when using tabs
set.smarttab = true

-- 1 tab == 2 spaces
set.shiftwidth = 2
set.tabstop = 2


set.autoindent = true
set.smartindent = true
set.wrap = true

-- Count words with dashes as one word
set.iskeyword:append({"-"})
-------------------------------------------
--                   Text width
-------------------------------------------
set.linebreak = true
set.textwidth = 90
set.colorcolumn = ""

local textwidth = augroup("textwidth", {})
autocmd("FileType", {
  pattern = {"dockerfile","sh","gitcommit","html","htmldjango","python","yaml","text","jsonnet","direnv","terraform"},
  command = "setlocal textwidth=0 | setlocal colorcolumn=0",
  group = textwidth
})

-------------------------------------------
--                 VIM user interface
-------------------------------------------

-- Set 7 lines to the cursor - when moving vertically using j/k
set.scrolloff = 7

-- Turn on the WiLd menu
set.wildmenu = true

-- Ignore compiled files
set.wildignore = {"*.o", "*~", "*.pyc"}

-- Always show current position
set.ruler = true

-- A buffer becomes hidden when it is abandoned
set.hidden = true

-- Configure backspace so it acts as it should act
set.backspace = {"eol", "start", "indent"}
set.whichwrap = "<,>,h,l,[,]"

-- Ignore case when searching
set.ignorecase =  true

-- When searching try to be smart about cases
set.smartcase = true

-- Better display for messages
set.cmdheight = 2

-- Highlight search results
set.hlsearch = true

-- Makes search act like search in modern browsers
set.incsearch = true

-- Don't redraw while executing macros (good performance config)
set.lazyredraw = true

-- For regular expressions turn magic on
set.magic = true

-- Show matching brackets when text indicator is over them
set.showmatch = true
--  How many tenths of a second to blink when matching brackets
set.matchtime = 2

-- No annoying sound on errors
set.errorbells = false
set.visualbell = false
set.timeoutlen = 500
