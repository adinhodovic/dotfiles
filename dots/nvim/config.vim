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
    \ '@yaegassy/coc-ansible',
    \ '@yaegassy/coc-marksman',
    \ 'coc-sql'
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

" Use for trigger snippet expand.
imap <leader>se <Plug>(coc-snippets-expand)

" Use for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)
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
" Abbreviations
"-----------------------------------------
function! LoadAbbreviations()
   source ~/.dotfiles/dots/nvim/abbreviations.vim
endfunction

augroup abbreviations
  autocmd VimEnter * call LoadAbbreviations()
augroup end
