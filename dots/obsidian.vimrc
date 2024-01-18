" TODO: Copy more from here
" https://github.com/chrisgrieser/.config/blob/main/obsidian/obsidian.vimrc
noremap q b
noremap go gg

vmap q b
vmap go gg

noremap W $
noremap Q 0

vmap W $
vmap Q 0
" map s /
" nmap s

nmap <space> :
nmap j gj
nmap k gk
nmap [[ :pHead
nmap ]] :nHead

vmap j gj
vmap k gk

set clipboard=unnamed

" mrj-jump-to-link:activate-jump-to-link
" mrj-jump-to-link:activate-jump-to-anywhere
" mrj-jump-to-link:activate-lightspeed-jump
" exmap jump obcommand mrj-jump-to-link:activate-jump-to-anywhere
exmap jump obcommand mrj-jump-to-link:activate-lightspeed-jump
nmap s :jump
vmap s :jump

exmap omnisearch obcommand omnisearch:show-modal
nmap \ :omnisearch

exmap switcher_open obcommand switcher:open
nmap - :switcher_open

" backlink:open

exmap editor_follow_link obcommand editor:open-link-in-new-leaf
nmap gd :editor_follow_link

exmap previous_tab obcommand workspace:previous-tab
nmap b :previous_tab


exmap app_go_back obcommand app:go-back
nmap <C-o> :app_go_back

exmap app_go_forward obcommand app:go-forward
nmap <C-i> :app_go_forward
