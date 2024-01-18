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
    command = command
  })
end

g.python3_host_prog = '/usr/bin/python'

g.hardtime_default_on = 0

g.hardtime_maxcount = 2
g.hardtime_allow_different_key = 1

set.completeopt = 'preview,menu'

g.netrw_browser_viewer = 'o'

set.mouse = 'a'

set.updatetime = 300

-- Set to auto read when a file is changed from the outside
vim.opt.autoread = true

vim.g.mapleader = ','

-- don't give |ins-completion-menu| messages.
set.shortmess = "c"

-- always show signcolumns
set.signcolumn = 'yes'

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
-- Indentation
-------------------------------------------

-- Enable file type detection
vim.o.filetype = 'on'

-- Enable syntax highlighting
vim.o.syntax = 'on'

-- Create the augroup and set autocmds for various filetypes
local indentation = augroup("indentation", {})
set_autocmd(indentation, "FileType", { "typescript", "javascript", "terraform", "jinja2" },
  "setlocal shiftwidth=2 tabstop=2 expandtab nocindent smartindent")
set_autocmd(indentation, "FileType", { "coffee" }, "setlocal shiftwidth=2 tabstop=2 expandtab")
set_autocmd(indentation, "FileType", { "css", "scss", "stylus" }, "setlocal shiftwidth=2 tabstop=2 expandtab")
set_autocmd(indentation, "FileType", { "vim" }, "setlocal shiftwidth=2 tabstop=2 expandtab")
set_autocmd(indentation, "FileType", { "tex" }, "setlocal shiftwidth=2 tabstop=2 expandtab")
set_autocmd(indentation, "FileType", { "yaml", "docker-compose" }, "setlocal shiftwidth=2 tabstop=2 expandtab")
set_autocmd(indentation, "FileType", { "json" }, "setlocal shiftwidth=2 tabstop=2 expandtab")
set_autocmd(indentation, "FileType", { "json" },
  'setlocal shiftwidth=2 tabstop=2 expandtab | syntax match Comment "^//(.+)$"')
set_autocmd(indentation, "FileType", { "snippets" }, "setlocal shiftwidth=2 tabstop=2 expandtab")
set_autocmd(indentation, "FileType", { "jade" }, "setlocal shiftwidth=2 tabstop=2 expandtab")
set_autocmd(indentation, "FileType", { "html", "htmldjango" }, "setlocal shiftwidth=2 tabstop=2 expandtab")
set_autocmd(indentation, "FileType", { "python" }, "setlocal shiftwidth=4 tabstop=4 expandtab")
set_autocmd(indentation, "FileType", { "go" }, "setlocal shiftwidth=4 tabstop=4 noexpandtab")
set_autocmd(indentation, "FileType", { "erlang" }, "setlocal shiftwidth=4 tabstop=4 noexpandtab")
set_autocmd(indentation, "FileType", { "make" }, "setlocal shiftwidth=4 tabstop=4 noexpandtab")
set_autocmd(indentation, "FileType", { "sh", "bash", "zsh", "readline", "nginx", "conf" },
  "setlocal shiftwidth=2 tabstop=2 expandtab nocindent smartindent")
set_autocmd(indentation, "FileType", { "php" }, "setlocal shiftwidth=4 tabstop=4 expandtab")
set_autocmd(indentation, "FileType", { "markdown" }, "setlocal shiftwidth=4 tabstop=4 expandtab")
set_autocmd(indentation, "FileType", { "ruby" }, "setlocal shiftwidth=2 tabstop=2 expandtab")
set_autocmd(indentation, "FileType", { "lua" }, "setlocal shiftwidth=2 tabstop=2 expandtab")
set_autocmd(indentation, "FileType", { "sshconfig" }, "setlocal shiftwidth=4 tabstop=4 expandtab")

-- pasting from outside
set.clipboard = "unnamedplus"

-------------------------------------------
-- Folding
-------------------------------------------
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-----------------------------------------
-- GUI
-----------------------------------------
set.termguicolors = true

set.background = "dark"
-- g.gruvbox_contrast_dark = "hard"
-- vim.cmd.colorscheme("gruvbox")
vim.cmd.colorscheme("github_dark_default")

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
set.spell = true
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
set.expandtab = true

-- Be smart when using tabs
set.smarttab = true

-- 1 tab == 2 spaces
set.shiftwidth = 2
set.tabstop = 2


set.autoindent = true
set.smartindent = true
set.wrap = true

-- Count words with dashes as one word
set.iskeyword:append({ "-" })
-------------------------------------------
--                   Text width
-------------------------------------------
set.linebreak = true
set.textwidth = 90
set.colorcolumn = ""

local textwidth = augroup("textwidth", {})
autocmd("FileType", {
  pattern = { "dockerfile", "sh", "gitcommit", "html", "htmldjango", "python", "yaml", "text", "jsonnet", "direnv", "terraform" },
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
-- disable all linters as that is taken care of by coc.nvim
g.go_diagnostics_enabled = 0
g.go_metalinter_enabled = 0

-- don't jump to errors after metalinter is invoked
g.go_jump_to_error = 0

-- automatically highlight variable your cursor is on
g.go_auto_sameids = 0
g.go_def_mapping_enabled = 0
g.go_gopls_enabled = 0
g.go_code_completion_enabled = 0
g.go_fmt_autosave = 0
g.go_echo_go_info = 0
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

g.neomake_text_enabled_makers = { 'writegood' }

g.neomake_sh_enabled_makers = { 'shellcheck' }

g.neomake_vim_enabled_makers = { 'vint' }

g.neomake_markdown_enabled_makers = { 'markdownlint' }
g.neomake_markdown_markdownlint_args = { '-c', '~/.markdownlint.yaml' }

g.neomake_ansible_enabled_makers = { 'ansiblelint', 'yamllint' }

g.neomake_yamllint_enabled_makers = { 'yamllint' }

g.neomake_typescriptreact_enabled_makers = { 'eslint' }
g.neomake_typescriptreact_eslint_args = { '--fix', '--format=json' }

g.neomake_javascriptreact_enabled_makers = { 'eslint' }
g.neomake_javascriptreact_eslint_args = { '--fix', '--format=json' }

g.neomake_javascript_enabled_makers = { 'eslint' }
g.neomake_javascript_eslint_args = { '--fix', '--format=json' }

g.neomake_typescript_enabled_makers = { 'eslint' }
g.neomake_typescript_eslint_args = { '--fix', '--format=json' }

g.neomake_json_enabled_makers = { 'jsonlint' }
g.neomake_json_jsonlint_args = { '-i' }

g.neomake_jsonnet_tk_maker = {
  name = 'tk',
  exe = 'tk',
  errorformat = '%m',
  args = { 'lint' }
}
g.neomake_jsonnet_enabled_makers = { 'tk' }

g.neomake_python_isort_maker = {
  name = 'isort'
}
g.neomake_python_black_maker = {
  name = 'black'
}
g.neomake_pylint_exe = vim.fn.systemlist('which pylint')[0]
g.neomake_mypy_exe = vim.fn.systemlist('which mypy')[0]

g.neomake_python_enabled_makers = { 'pylint', 'isort', 'black', 'mypy' }

g.neomake_css_enabled_makers = { 'stylelint' }
g.neomake_css_stylelint_args = { '--fix' }

g.neomake_scss_enabled_makers = { 'stylelint' }
g.neomake_scss_stylelint_args = { '--fix' }

g.neomake_less_enabled_makers = { 'stylelint' }
g.neomake_less_stylelint_args = { '--fix' }

g.neomake_html_jsbeautify_maker = {
  name = 'djLint',
  exe = 'djlint',
  args = { '--profile=html', '--reformat' }
}

-- g.neomake_htmldjango_jsbeautify_maker = {
-- name = 'djLint',
-- exe = 'djlint',
-- args = {'--profile=django', '--reformat'}
-- }

g.neomake_htmldjango_htmlhint_maker = {
  args = { '--nocolor' },
  -- errorformat = '%f:%l:%c: %m,%-G,%-G%*\d problems'
}

-- g.neomake_go_enabled_makers = {}
g.neomake_htmldjango_enabled_makers = { 'htmlhint' }
g.neomake_html_enabled_makers = { 'htmlhint', 'jsbeautify' }

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
  pattern = { "*.hcl" },
  command = "setlocal filetype=terraform",
  group = terraform
})

------------------------------------------
-- hashivim/vim-terraform
------------------------------------------
g.terraform_commentstring = '//%s'
g.terraform_align = 1
g.terraform_fmt_on_save = 1

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
-- Airline
-------------------------------------------
g.airline_theme = 'github_dark_default'
g["airline#extensions#tabline#enabled"] = 0
g["airline#extensions#coc#enabled"] = 1
g["airline#extensions#coc#show_coc_status"] = 1
g["airline#extensions#hunks#enabled"] = 1
g["airline#extensions#hunks#coc_git"] = 1
-- remove the filetype part
g.airline_section_x = '%{get(b:,"coc_git_blame","")}'
g.airline_section_y = ''
-- remove separators for empty sections
g.airline_skip_empty_sections = 1
vim.cmd("autocmd User CocGitStatusChange AirlineRefresh")

-------------------------------------------
-- SirVer/ultisnips
-------------------------------------------
-- Collides with coc-snippets
g.UltiSnipsListSnippets = '<nop>'
g.UltiSnipsExpandTrigger = '<nop>'
-- Load my own snippets
g.UltiSnipsSnippetDirectories = { '~/personal/UltiSnips' }
-------------------------------------------
-- conflict-marker
-------------------------------------------
g.conflict_marker_highlight_group = 'DiffText'

-------------------------------------------
-- CSS & HTML
-------------------------------------------
g.user_emmet_install_global = 0
local emmetGroup = augroup("emmet", {})
autocmd("FileType", {
  pattern = { "html", "css", "jsx", "tsx", "htmldjango" },
  command = "EmmetInstall",
  group = emmetGroup
})

-------------------------------------------
-- Rainbow Parantheses
-------------------------------------------
g.rainbow_active = 1

-------------------------------------------
-- Vim-pencil
-------------------------------------------
g["pencil#wrapModeDefault"] = 'soft'

local pencilGroup = augroup("pencil", {})
autocmd("FileType", {
  pattern = { "markdown", "mkd" },
  command = "call pencil#init()",
  group = pencilGroup
})

-------------------------------------------
-- Cosco.vim
-------------------------------------------
g.cosco_filetype_whitelist = { 'javascript', 'typescript', 'css', 'perl', 'nginx' }

-------------------------------------------
-- Whitespace
-------------------------------------------
g.better_whitespace_enabled = 1
g.strip_whitespace_on_save = 1
g.strip_whitespace_confirm = 0
g.better_whitespace_verbosity = 1
g.current_line_whitespace_disabled_soft = 1
g.better_whitespace_filetypes_blacklist = { 'zsh', 'html', 'vim', 'diff', 'gitcommit', 'unite', 'qf', 'help' }
g.better_whitespace_ctermcolor = 'red'

local whitespaceGroup = augroup("whitespace", {})
set_autocmd(
  whitespaceGroup,
  { "BufWritePre" },
  { "*" },
  "StripWhitespace"
)

-------------------------------------------
-- Ansible-vim
-------------------------------------------
g.ansible_extra_keywords_highlight = 1
local ansibleGroup = augroup("ansible", {})
set_autocmd(
  ansibleGroup,
  {
    "BufRead",
    "BufNewFile"
  },
  { "*/ansible/*.yml" },
  "set filetype=yaml.ansible"
)

-------------------------------------------
-- Coc
-------------------------------------------
g.coc_global_extensions = {
  'coc-pairs',
  'coc-json',
  'coc-yaml',
  'coc-vimlsp',
  'coc-emoji',
  'coc-yank',
  'coc-html',
  'coc-htmldjango',
  'coc-css',
  'coc-html-css-support',
  'coc-emmet',
  'coc-pyright',
  'coc-snippets',
  'coc-tsserver',
  '@yaegassy/coc-tailwindcss3',
  'coc-spell-checker',
  'coc-markdownlint',
  'coc-git',
  'coc-lists',
  'coc-prettier',
  'coc-go',
  'coc-lua',
  '@yaegassy/coc-ansible',
  '@yaegassy/coc-marksman',
  'coc-sql',
}

local cocGroup = augroup("coc", {})
-- Highlight symbol under cursor on CursorHold
set_autocmd(
  cocGroup,
  {
    "CursorHold"
  },
  { "html" },
  "silent call CocActionAsync('highlight')"
)

-- coc-tailwindcss3
local coctailwindGroup = augroup("coctailwind", {})
set_autocmd(
  coctailwindGroup,
  {
    "FileType"
  },
  { "html" },
  "let b:coc_root_patterns = ['.git', '.env', 'tailwind.config.js', 'tailwind.config.cjs']"
)

-------------------------------------------
-- fzf.vim
-------------------------------------------
g.fzf_action = {
  ['ctrl-t'] = 'tab split',
  ['ctrl-x'] = 'vsplit',
  ['ctrl-z'] = 'split',
}
g.fzf_layout = { up = '~40%' }
g.fzf_files_options = '--ansi --preview "bat --style=plain {}" --preview-window right:100'

-------------------------------------------
-- Easymotion
-------------------------------------------
g.EasyMotion_keys = 'hgjfkdls;a'
g.EasyMotion_grouping = 1
g.EasyMotion_do_mapping = 0
g.EasyMotion_smartcase = 1
g.EasyMotion_do_shade = 1
g.EasyMotion_use_upper = 1

-------------------------------------------
-- IndentLine
-------------------------------------------
g.indentLine_char_list = { '|', '¦', '┆', '┊' }
g.indentLine_fileTypeExclude = { 'markdown', 'terraform' }

-------------------------------------------
-- NERDCommenter
-------------------------------------------
-- Add a space before any comment
g.NERDSpaceDelims = 1
