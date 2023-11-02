local vim = vim
local set = vim.opt
local g = vim.g
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

g.python3_host_prog = '/usr/bin/python'

g.hardtime_default_on = 0

g.hardtime_maxcount = 2
g.hardtime_allow_different_key = 1


set.completeopt=preview,menu

set.mouse=a

set.updatetime = 300

-- Set to auto read when a file is changed from the outside
vim.opt.autoread = true

vim.g.mapleader = ','

-- don't give |ins-completion-menu| messages.
set.shortmess = "c"

-- always show signcolumns
set.signcolumn = 'yes'

-----------------------------------------
-- GUI
-----------------------------------------
set.termguicolors = true

set.background = "dark"
vim.cmd("silent! colorscheme gruvbox")

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
-- set.wildoptions = "pum"

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

-------------------------------------------
-- Go
-------------------------------------------
g.go_def_mapping_enabled = 0
g.go_auto_sameids = 0
g.go_gopls_enabled = 0
g.go_code_completion_enabled = 0
g.go_fmt_autosave = 0
g.go_diagnostics_enabled = 0
g.go_echo_go_info = 0
g.go_metalinter_enabled = 0
g.go_metalinter_autosave = 0
-- g.go_debug_windows = {
  -- vars = 'rightbelow 60vnew',
  -- stack = 'rightbelow 10new'
-- }
-- nnoremap <leader>gr :GoRun<CR>

-------------------------------------------
-- Neomake
-------------------------------------------
g.neomake_list_height = 8
g.neomake_open_list = 2

g.neomake_eslint_exe = vim.fn.systemlist('which eslint')[0]
g.neomake_stylelint_exe = vim.fn.systemlist('which stylelint')[0]

g.neomake_text_enabled_makers = {'writegood'}

g.neomake_sh_enabled_makers = {'shellcheck'}

g.neomake_vim_enabled_makers = {'vint'}

g.neomake_markdown_enabled_makers = {'markdownlint'}
g.neomake_markdown_markdownlint_args = {'-c', '~/.markdownlint.yaml'}

g.neomake_ansible_enabled_makers = {'ansiblelint', 'yamllint'}

g.neomake_yamllint_enabled_makers = {'yamllint'}

g.neomake_typescriptreact_enabled_makers = {'eslint'}
g.neomake_typescriptreact_eslint_args = {'--fix', '--format=json'}

g.neomake_javascriptreact_enabled_makers = {'eslint'}
g.neomake_javascriptreact_eslint_args = {'--fix', '--format=json'}

g.neomake_javascript_enabled_makers = {'eslint'}
g.neomake_javascript_eslint_args = {'--fix', '--format=json'}

g.neomake_typescript_enabled_makers = {'eslint'}
g.neomake_typescript_eslint_args = {'--fix', '--format=json'}

g.neomake_json_enabled_makers = {'jsonlint'}
g.neomake_json_jsonlint_args = {'-i'}

g.neomake_jsonnet_tk_maker = {
  name = 'tk',
  exe = 'tk',
  errorformat ='%m',
  args = {'lint'}
}
g.neomake_jsonnet_enabled_makers = {'tk'}

g.neomake_python_isort_maker = {
  name = 'isort'
}
g.neomake_python_black_maker = {
 name = 'black'
}
g.neomake_pylint_exe = vim.fn.systemlist('which pylint')[0]
g.neomake_mypy_exe = vim.fn.systemlist('which mypy')[0]

g.neomake_python_enabled_makers = {'pylint', 'isort', 'black', 'mypy'}

g.neomake_css_enabled_makers = {'stylelint'}
g.neomake_css_stylelint_args = {'--fix'}

g.neomake_scss_enabled_makers = {'stylelint'}
g.neomake_scss_stylelint_args = {'--fix'}

g.neomake_less_enabled_makers = {'stylelint'}
g.neomake_less_stylelint_args = {'--fix'}

g.neomake_html_jsbeautify_maker = {
  name = 'djLint',
  exe = 'djlint',
  args = {'--profile=html', '--reformat'}
}

-- g.neomake_htmldjango_jsbeautify_maker = {
  -- name = 'djLint',
  -- exe = 'djlint',
  -- args = {'--profile=django', '--reformat'}
-- }

g.neomake_htmldjango_htmlhint_maker = {
  args = {'--nocolor'},
  -- errorformat = '%f:%l:%c: %m,%-G,%-G%*\d problems'
}

-- g.neomake_go_enabled_makers = {}
g.neomake_htmldjango_enabled_makers = {'htmlhint'}
g.neomake_html_enabled_makers = {'htmlhint', 'jsbeautify'}

vim.cmd([[
  call neomake#configure#automake('w')

  augroup my_neomake_hooks
    au!
    autocmd User NeomakeJobFinished silent! :edit
  augroup END
]])

-- Disable copilot tabs that interfere with Coc
g.copilot_no_tab_map = true
g.copilot_assume_mapped = true

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Terraform
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
autocmd("BufEnter", {
  pattern = {"*.hcl"},
  command = "setlocal filetype=terraform",
  group = terraform
})

------------------------------------------
-- hashivim/vim-terraform
------------------------------------------
g.terraform_commentstring='//%s'
g.terraform_align=1
g.terraform_fmt_on_save=1

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Documentation
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-------------------------------------------
-- Markdown
-------------------------------------------
-- Disable autostart of md composer
g.instant_markdown_browser = 'chromium --new-window'
g.instant_markdown_autostart = 0

-- Disable markdown code block conceals
g.vim_markdown_conceal = 0
g.vim_markdown_conceal_code_blocks = 0

-- Disable folding, we have search
g.vim_markdown_folding_disabled = 1

-------------------------------------------
-- GitGutter
-------------------------------------------
g.gitgutter_max_signs=9999
vim.cmd("hi SignColumn guibg=black ctermbg=black")
