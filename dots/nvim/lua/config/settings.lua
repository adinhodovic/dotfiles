local vim = vim
local set = vim.opt
local g = vim.g
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Define a function to simplify setting autocmds
local function set_autocmd(group, event, pattern, command)
	autocmd(event, {
		group = group,
		pattern = pattern,
		command = command,
	})
end

g.python3_host_prog = "/usr/bin/python"

g.hardtime_default_on = 0

vim.opt.laststatus = 3

g.hardtime_maxcount = 2
g.hardtime_allow_different_key = 1

set.completeopt = "preview,menu"

-- All file plugins recommend this setting
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.netrw_browser_viewer = "o"

set.mouse = "a"

set.updatetime = 300

-- Set to auto read when a file is changed from the outside
vim.opt.autoread = true

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- don't give |ins-completion-menu| messages.
set.shortmess = "c"

-- always show signcolumns
set.signcolumn = "yes"

-- Abbreviations
vim.cmd("cnoreabbrev W! w!")
vim.cmd("cnoreabbrev Q! q!")
vim.cmd("cnoreabbrev Qall! qall!")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev Wa wa")
vim.cmd("cnoreabbrev wQ wq")
vim.cmd("cnoreabbrev WQ wq")
vim.cmd("cnoreabbrev W w")
vim.cmd("cnoreabbrev Q q")

-------------------------------------------
-- Folding
-------------------------------------------
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-----------------------------------------
-- GUI
-----------------------------------------
set.termguicolors = true
set.cursorline = true
vim.api.nvim_set_hl(0, "CursorLine", { underline = false })

vim.opt.showmode = false

set.title = true

set.number = true
vim.opt.number = true
vim.opt.relativenumber = true

-- Bullets.vim
vim.g.bullets_enabled_file_types = {
	"markdown",
	"text",
	"gitcommit",
	"scratch",
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
-- Replaced by LSP LTEX
set.spell = false
-- set.spelllang = { "en_us" }
-- set.spellfile = vim.fn.expand("$HOME/dotfiles/misc/spell/en.utf-8.add")

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
set.expandtab = true

-- Be smart when using tabs
set.smarttab = true

-- 1 tab == 2 spaces
set.shiftwidth = 2
set.tabstop = 2

set.autoindent = true
set.smartindent = true
-- wrapping
set.wrap = true

-- Count words with dashes as one word
set.iskeyword:append({ "-" })

-- pasting from outside
set.clipboard = "unnamedplus"
-------------------------------------------
--                   Text width
-------------------------------------------
set.linebreak = true
set.textwidth = 150
set.colorcolumn = "150"

local textwidth = augroup("textwidth", {})
autocmd("FileType", {
	pattern = { "gitcommit", "html", "htmldjango", "text", "direnv", "markdown", "libsonnet", "jsonnet" },
	command = "setlocal textwidth=0 | setlocal colorcolumn=0",
	group = textwidth,
})

-------------------------------------------
--                 VIM user interface
-------------------------------------------

-- Set 7 lines to the cursor - when moving vertically using j/k
set.scrolloff = 7

-- Turn on the wildmenu
set.wildmenu = true

-- Ignore compiled files
set.wildignore = { "*.o", "*~", "*.pyc" }

-- Always show current position
set.ruler = true

-- A buffer becomes hidden when it is abandoned
set.hidden = true

-- Configure backspace so it acts as it should act
set.backspace = { "eol", "start", "indent" }
set.whichwrap = "<,>,h,l,[,]"

-- Ignore case when searching
set.ignorecase = true

-- When searching try to be smart about cases
set.smartcase = true

-- Better display for messages
set.cmdheight = 2

-- Highlight search results
set.hlsearch = true

-- Makes search act like search in modern browsers
set.incsearch = true

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

-------------------------------------------
-- Filetypes
-------------------------------------------
vim.filetype.add({
	pattern = {
		-- .env.template
		["%.env%.[%w_.-]+"] = "sh",
	},
})

-- Auto-detect Tiltfile as a Bazel/Starlark file
vim.filetype.add({
	filename = {
		["Tiltfile"] = "bzl",
	},
	extension = {
		["bzl"] = "bzl",
	},
})

-------------------------------------------
-- LSP
-------------------------------------------
vim.lsp.set_log_level("off")

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
})
