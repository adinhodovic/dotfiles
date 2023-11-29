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
    \ 'coc-htmldjango',
    \ 'coc-css',
    \ 'coc-html-css-support',
    \ 'coc-emmet',
    \ 'coc-pyright',
    \ 'coc-snippets',
    \ 'coc-tsserver',
    \ '@yaegassy/coc-tailwindcss3',
    \ 'coc-spell-checker',
    \ 'coc-markdownlint',
    \ 'coc-git',
    \ 'coc-lists',
    \ 'coc-prettier',
    \ 'coc-go',
    \ 'coc-lua',
    \ '@yaegassy/coc-ansible'
\]
"\ 'coc-tabnine' disable due to high cpu,

nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

augroup coctailwind
  au FileType html let b:coc_root_patterns = ['.git', '.env', 'tailwind.config.js', 'tailwind.config.cjs']
augroup END

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Use <C-l> for trigger snippet expand.
imap <leader>se <Plug>(coc-snippets-expand)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)
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
" SirVer/ultisnips
"-----------------------------------------
" Collides with coc-snippets
let g:UltiSnipsListSnippets = '<nop>'
let g:UltiSnipsExpandTrigger = '<nop>'
" Load my own snippets
let g:UltiSnipsSnippetDirectories=['~/personal/UltiSnips']
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
" MRU
"-----------------------------------------
nnoremap <leader>mr :MRU<CR>
"-----------------------------------------
" Abbreviations
"-----------------------------------------
function! LoadAbbreviations()
   source ~/.dotfiles/dots/nvim/abbreviations.vim
endfunction

augroup abbreviations
  autocmd VimEnter * call LoadAbbreviations()
augroup end
