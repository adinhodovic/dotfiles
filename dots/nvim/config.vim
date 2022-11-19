
"-----------------------------------------
" Base64
"-----------------------------------------
vnoremap <silent> <leader>b64d :<c-u>call base64#v_atob()<cr>
vnoremap <silent> <leader>b64e :<c-u>call base64#v_btoa()<cr>
"-----------------------------------------
" Autocompelete
"-----------------------------------------
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
" remap for complete to use tab and <cr>
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
"-----------------------------------------
" History
"-----------------------------------------
" Sets how many lines of history VIM has to remember
set history=1000
"-----------------------------------------
" Spelling
"-----------------------------------------
set nospell
set spellfile=~/.dotfiles/spell/en.utf-8.add
set title
set number
"-----------------------------------------
" Moving around, tabs, windows and buffers
"-----------------------------------------
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

nmap m %
vmap m %
set cmdwinheight=1

noremap q b
" Movement begin/end of line
noremap Q ^
noremap W g_
noremap $ <nop>
noremap ^ <nop>
nnoremap : <nop>

" Disable keys to get more used to hjkl
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Window movements
inoremap <silent> <C-h> <esc>:wincmd h<cr>
inoremap <silent> <C-l> <esc>:wincmd l<cr>
inoremap <silent> <C-j> <esc>:wincmd j<cr>
inoremap <silent> <C-k> <esc>:wincmd k<cr>

nnoremap <silent> <C-h> :wincmd h<cr>
nnoremap <silent> <C-l> :wincmd l<cr>
nnoremap <silent> <C-j> :wincmd j<cr>
nnoremap <silent> <C-k> :wincmd k<cr>

noremap <leader>q q
" Execute macro over a visual selection
xnoremap <leader>q :'<,'>:normal @q<CR>

execute 'nnoremap <space> :' . &cedit . 'a'
execute 'xnoremap <space> :' . &cedit . 'a'
execute 'nnoremap / /' . &cedit . 'a'
execute 'xnoremap / /' . &cedit . 'a'
execute 'nnoremap ? ?' . &cedit . 'a'
execute 'xnoremap ? ?' . &cedit . 'a'
"-----------------------------------------
"           Files, backups and undo
"-----------------------------------------
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowritebackup
set noswapfile
"-----------------------------------------
"           Text, tab and indent related
"-----------------------------------------
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2


set autoindent "Auto indent
set smartindent "Smart indent
set wrap "Wrap lines

set iskeyword+=- " Count words with dashes as one word
"-----------------------------------------
"                   Text width
"-----------------------------------------
set linebreak
set textwidth=90
set colorcolumn=

augroup textwidth
  autocmd FileType dockerfile,sh,gitcommit,html,htmldjango,python,yaml,text,jsonnet,direnv,terraform setlocal textwidth=0
  autocmd FileType dockerfile,sh,gitcommit,html,htmldjango,python,yaml,text,jsonnet,direnv,terraform setlocal colorcolumn=0
augroup END
"-----------------------------------------
"                 VIM user interface
"-----------------------------------------
" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hidden

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set timeoutlen=500
"-----------------------------------------
"               Writing
"-----------------------------------------
noremap <silent> <F8> :<C-u>NextWordy<cr>
xnoremap <silent> <F8> :<C-u>NextWordy<cr>
inoremap <silent> <F8> <C-o>:NextWordy<cr>
"-----------------------------------------
"               GUI
"-----------------------------------------
set termguicolors
syntax enable

set background=dark
silent! colorscheme gruvbox

hi clear SpellBad
hi SpellBad ctermfg=DarkRed term=undercurl

set cursorline
hi CursorLine ctermbg=236 guibg=#242321
"-----------------------------------------
"               Indentation
"-----------------------------------------
" `nocindent smartindent` will allow us to omit semicolons and jump to the next line without auto indentation
filetype on
filetype indent on
filetype plugin indent on
syntax on
" for Javascript/Typescript
augroup indentation
  autocmd FileType typescript,javascript,terraform,jinja2  setlocal  shiftwidth=2 tabstop=2 expandtab nocindent smartindent
  autocmd FileType coffee                 setlocal  shiftwidth=2 tabstop=2 expandtab
  autocmd FileType css,scss,stylus        setlocal  shiftwidth=2 tabstop=2 expandtab
  autocmd FileType vim                    setlocal  shiftwidth=2 tabstop=2 expandtab
  autocmd FileType tex                    setlocal  shiftwidth=2 tabstop=2 expandtab
  autocmd FileType yaml,docker-compose    setlocal  shiftwidth=2 tabstop=2 expandtab
  autocmd FileType json                   setlocal  shiftwidth=2 tabstop=2 expandtab
  autocmd FileType json syntax match Comment +\/\/.\+$+
  autocmd FileType snippets               setlocal  shiftwidth=2 tabstop=2 expandtab
  autocmd FileType jade                   setlocal  shiftwidth=2 tabstop=2 expandtab
  autocmd FileType html,htmldjango        setlocal  shiftwidth=2 tabstop=2 expandtab
  autocmd FileType python                 setlocal  shiftwidth=4 tabstop=4 expandtab
  autocmd FileType go                     setlocal  shiftwidth=4 tabstop=4 noexpandtab
  autocmd FileType erlang                 setlocal  shiftwidth=4 tabstop=4 noexpandtab
  autocmd FileType make                   setlocal  shiftwidth=4 tabstop=4 noexpandtab
  autocmd FileType sh,bash,zsh,readline,nginx,conf setlocal  shiftwidth=2 tabstop=2 expandtab nocindent smartindent
  autocmd FileType php                    setlocal  shiftwidth=4 tabstop=4 expandtab
  autocmd FileType markdown               setlocal  shiftwidth=4 tabstop=4 expandtab
  autocmd FileType ruby                   setlocal  shiftwidth=2 tabstop=2 expandtab
  autocmd FileType lua                    setlocal  shiftwidth=2 tabstop=2 expandtab
  autocmd FileType sshconfig              setlocal  shiftwidth=4 tabstop=4 expandtab
augroup END

"pasting from outside
set clipboard=unnamedplus
"-----------------------------------------
"               Spell checking
"-----------------------------------------
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg                           " Add word to spellcheck
map <leader>s? z=
"-----------------------------------------
"               Misc
"-----------------------------------------
" Reload vimrc on write
augroup myvimrc
    au!
    au BufWritePost vimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
"         Plugin specific settings
"
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"----------------------------------------
" Cosco.vim
"-----------------------------------------
let g:cosco_filetype_whitelist = ['javascript', 'typescript', 'css', 'perl', 'nginx']
"-----------------------------------------
" Whitespace
"-----------------------------------------
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
let g:better_whitespace_verbosity=1
let g:current_line_whitespace_disabled_soft=1
let g:better_whitespace_filetypes_blacklist=['zsh', 'html', 'vim', 'diff', 'gitcommit', 'unite', 'qf', 'help']
let g:better_whitespace_ctermcolor='red'
augroup whitespace
  autocmd BufWritePre * StripWhitespace
augroup END
"-----------------------------------------
" Lastplace
"-----------------------------------------
let g:lastplace_ignore = 'gitcommit,gitrebase,svn,hgcommit'
"-----------------------------------------
" Airline
"-----------------------------------------
let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#coc#enabled = 1
" remove the filetype part
let g:airline_section_x='%{coc#status()}'
let g:airline_section_y=''
" remove separators for empty sections
let g:airline_skip_empty_sections = 1
"-----------------------------------------
" Easymotion
"-----------------------------------------
let g:EasyMotion_keys = 'hgjfkdls;a'
let g:EasyMotion_grouping = 1
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_shade = 1
let g:EasyMotion_use_upper = 1
map f <Plug>(easymotion-bd-fl)
map t <Plug>(easymotion-bd-tl)
map s <Plug>(easymotion-sn)
"-----------------------------------------
" IndentLine
"-----------------------------------------
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_fileTypeExclude = ['markdown', 'terraform']
"-----------------------------------------
" fzf.vim
"-----------------------------------------
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'vsplit',
  \ 'ctrl-z': 'split' }

let g:fzf_layout = {'up': '~40%'}
let g:fzf_files_options = '--ansi --preview "bat --style=plain {}" --preview-window right:100'
nnoremap b :e #<cr>
nnoremap - :Buffers<cr>
nnoremap = :call FzfGitChangedFilesFromMaster()<cr>
nnoremap <M-=> :Files<cr>
nnoremap <M--> :GitFiles<cr>

function! FzfGitChangedFilesFromMaster()
  let root = split(system('git rev-parse --show-toplevel'), '\n')[0]
  if v:shell_error
    echom 'Not in git repo'
    return
  endif

  let default_remote_branch = split(system("git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'"), '\n')[0]
  let cmd_diff_files = printf('git --no-pager diff origin/%s --name-only', default_remote_branch)
  let diff_files = split(system(cmd_diff_files), '\n')

  let untracked_files = split(system('git ls-files --others --exclude-standard'), '\n')
  let files = diff_files + untracked_files

  let wrapped = fzf#wrap({
  \ 'source':  files,
  \ 'dir':     root,
  \ 'options': '--ansi --multi --bind=alt-a:select-all --nth 2..,.. --tiebreak=index --prompt "GitFiles?> " --preview ''sh -c "(git diff origin/master --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500"''',
  \ 'up':      '50%',
  \})
  call fzf#run(wrapped)
endfunction

"-----------------------------------------
" Coc
"-----------------------------------------
let g:coc_global_extensions = [
    \ 'coc-pairs',
    \ 'coc-json',
    \ 'coc-yaml',
    \ 'coc-vimlsp',
    \ 'coc-emoji',
    \ 'coc-yank',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-pyright',
    \ 'coc-ultisnips',
    \ 'coc-tsserver',
    \ 'coc-git',
\]
"\ 'coc-tabnine' disable due to high cpu,

set updatetime=300
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . ' ' . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
augroup coc
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup end

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
"-----------------------------------------
" coc-fzf
"-----------------------------------------
nnoremap <silent> <space><space> :<C-u>CocFzfList<CR>
nnoremap <silent> <space>c :<C-u>CocFzfList commands<CR>
nnoremap <silent> <space>e :<C-u>CocFzfList extensions<CR>
nnoremap <silent> <space>l :<C-u>CocFzfList location<CR>
nnoremap <silent> <space>o :<C-u>CocFzfList outline<CR>
nnoremap <silent> <space>s :<C-u>CocFzfList symbols<CR>
nnoremap <silent> <space>p :<C-u>CocFzfListResume<CR>
"-----------------------------------------
" Delete/Paste text without copying
"-----------------------------------------
nnoremap <leader>d "_d
xnoremap <leader>d "_d
nnoremap <leader>dd "_dd
xnoremap <leader>dd "_dd
xnoremap <leader>p "_dP

let g:mdip_imgdir = 'images'
nnoremap <buffer><silent> <leader>mp :call mdip#MarkdownClipboardImage()<CR>
"-----------------------------------------
" Ansible-vim
"-----------------------------------------
let g:ansible_extra_keywords_highlight = 1
augroup ansible
  au BufRead,BufNewFile */ansible/*.yml set filetype=yaml.ansible
augroup END
"-----------------------------------------
" Ansible-vault
"-----------------------------------------
function EncryptVault()
  :AnsibleVaultEncrypt
  edit
endfunction

nnoremap <Leader>ve :call EncryptVault() <CR>
nnoremap <Leader>vd :AnsibleVaultDecrypt <CR> :edit <CR>
"-----------------------------------------
" NERDCommenter
"-----------------------------------------
vnoremap <leader>c :call NERDComment(0, "toggle")<CR>
" Add a space before any comment
let g:NERDSpaceDelims = 1
"-----------------------------------------
" CarbonNowSh
"-----------------------------------------
vnoremap <F6> :CarbonNowSh<CR>
"-----------------------------------------
" GitMessenger
"-----------------------------------------
nnoremap <leader>gm :GitMessenger <CR>
let g:git_messenger_include_diff = 'current'
" ----------------------------------------
" Visual mode related
" ----------------------------------------
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSS & HTML
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:user_emmet_install_global = 0
augroup emmet
  autocmd FileType html,css,jsx,tsx EmmetInstall
augroup END
"-----------------------------------------
" GitGutter
"-----------------------------------------
let g:gitgutter_max_signs=9999
hi SignColumn guibg=black ctermbg=black
nmap <Leader>s <Plug>(GitGutterStageHunk)
nmap <Leader>u <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)
"-----------------------------------------
" Fugitive
"-----------------------------------------
command! Gdom Gdiff origin/master
map <leader>gb :GBrowse<cr>
map <leader>gl :0Glog<cr>
map <leader>ge :Gedit<cr>
"-----------------------------------------
" Committia
"-----------------------------------------
let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    " Additional settings
    setlocal spell

    " Scroll the diff window from insert mode
    " Map <C-n> and <C-p>
    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
endfunction
"-----------------------------------------
" Rainbow Parantheses
"-----------------------------------------
let g:rainbow_active = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" Returns true if paste mode is enabled
function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  en
  return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
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
"-----------------------------------------
" Neomake
"-----------------------------------------
let g:neomake_list_height = 8
let g:neomake_open_list = 2

let g:neomake_eslint_exe = systemlist('git rev-parse --show-toplevel')[0].'/node_modules/.bin/eslint'
let g:neomake_stylelint_exe = systemlist('which stylelint')[0]

let g:neomake_text_enabled_makers = ['writegood']

let g:neomake_sh_enabled_makers = ['shellcheck']

let g:neomake_vim_enabled_makers = ['vint']

let g:neomake_markdown_enabled_makers = ['markdownlint']
let g:neomake_markdown_markdownlint_args = ['-c', '~/.markdownlint.yaml']

let g:neomake_ansible_enabled_makers = ['ansiblelint', 'yamllint']

let g:neomake_yamllint_enabled_makers = ['yamllint']

let g:neomake_typescriptreact_enabled_makers = ['eslint']
let g:neomake_typescriptreact_eslint_args = ['--fix', '--format=json']

let g:neomake_javascriptreact_enabled_makers = ['eslint']
let g:neomake_javascriptreact_eslint_args = ['--fix', '--format=json']

let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_javascript_eslint_args = ['--fix', '--format=json']

let g:neomake_typescript_enabled_makers = ['eslint']
let g:neomake_typescript_eslint_args = ['--fix', '--format=json']

let g:neomake_json_enabled_makers = ['jsonlint']
let g:neomake_json_jsonlint_args = ['-i']

let g:neomake_jsonnet_tk_maker = {
    \ 'name': 'tk',
    \ 'exe': 'tk',
    \ 'errorformat': '%m',
    \ 'args': ['lint']
    \ }
let g:neomake_jsonnet_enabled_makers = ['tk']

let g:neomake_python_isort_maker = {
    \ 'name': 'isort',
    \ }
let g:neomake_python_black_maker = {
    \ 'name': 'black',
    \ }
let g:neomake_pylint_exe = systemlist('which pylint')[0]
let g:neomake_mypy_exe = systemlist('which mypy')[0]

let g:neomake_python_enabled_makers = ['pylint', 'isort', 'black', 'mypy', 'flake8']

let g:neomake_css_enabled_makers = ['stylelint']
let g:neomake_css_stylelint_args = ['--fix']

let g:neomake_scss_enabled_makers = ['stylelint']
let g:neomake_scss_stylelint_args = ['--fix']

let g:neomake_less_enabled_makers = ['stylelint']
let g:neomake_less_stylelint_args = ['--fix']

let g:neomake_html_jsbeautify_maker = {
    \ 'name': 'jsbeautify',
    \ 'exe': 'js-beautify',
    \ 'args': ['-r', '--type html'],
    \ }

let g:neomake_htmldjango_jsbeautify_maker = {
    \ 'name': 'jsbeautify',
    \ 'exe': 'js-beautify',
    \ 'args': ['-r', '--type html'],
    \ }

let g:neomake_htmldjango_htmlhint_maker = {
    \ 'args': ['--format', 'unix', '--nocolor'],
    \ 'errorformat': '%f:%l:%c: %m,%-G,%-G%*\d problems',
    \ }

let g:neomake_htmldjango_enabled_makers = ['htmlhint', 'jsbeautify']
let g:neomake_html_enabled_makers = ['htmlhint', 'jsbeautify']

call neomake#configure#automake('w')

augroup my_neomake_hooks
  au!
  autocmd User NeomakeJobFinished :edit
augroup END
"-----------------------------------------
" wsdjeg/flygrep
"-----------------------------------------
nnoremap <Space>s :FlyGrep<cr>
"-----------------------------------------
" SirVer/ultisnips
"-----------------------------------------
" Collides with coc-snippets
let g:UltiSnipsExpandTrigger = '<nop>'
" Load my own snippets
let g:UltiSnipsSnippetDirectories=['~/personal/UltiSnips']
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"               Terraform
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
augroup terraform
  autocmd BufEnter *.hcl :setlocal filetype=terraform
augroup END
"-----------------------------------------
" hashivim/vim-terraform
"-----------------------------------------
let g:terraform_commentstring='//%s'
let g:terraform_align=1
let g:terraform_fmt_on_save=1
"-----------------------------------------
" spelunker-vim
"-----------------------------------------
augroup spelunker
  autocmd!
  " Setting for g:spelunker_check_type = 1:
  autocmd BufWinEnter,BufWritePost *.vim,*.js,*.jsx,*.json,*.md call spelunker#check()

  " Setting for g:spelunker_check_type = 2:
  autocmd CursorHold *.vim,*.js,*.jsx,*.json,*.md call spelunker#check_displayed_words()
augroup END
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"               Documentation
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"-----------------------------------------
" Markdown
"-----------------------------------------
" Disable autostart of md composer
let g:instant_markdown_browser = 'firefox --new-window'
let g:instant_markdown_autostart = 0

" Disable markdown code block conceals
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" The other style keeps unfolding
let g:vim_markdown_folding_style_pythonic = 1

nnoremap <leader>md :InstantMarkdownPreview<cr>
nnoremap <leader>ms :InstantMarkdownStop<cr>
"-----------------------------------------
"               Vim-pencil
"-----------------------------------------
let g:pencil#wrapModeDefault = 'soft'
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
augroup END
"-----------------------------------------
" conflict-marker
"-----------------------------------------
let g:conflict_marker_highlight_group = 'DiffText'
"-----------------------------------------
" vim-go
"-----------------------------------------
nnoremap <leader>gr :GoRun<CR>

let g:go_metalinter_autosave = 1

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_auto_sameids = 1
"-----------------------------------------
" MRU
"-----------------------------------------
nnoremap <leader>mr :MRU<CR>
"-----------------------------------------
" Abbreviations
"-----------------------------------------
function! LoadAbbreviations()
   source ~/.dotfiles/dots/vim/abbreviations.vim
endfunction

augroup abbreviations
  autocmd VimEnter * call LoadAbbreviations()
augroup end
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = "all",
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  auto_install = true,
  -- List of parsers to ignore installing (for "all")
  ignore_install = { },
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF
