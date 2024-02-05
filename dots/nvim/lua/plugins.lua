local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

-----------------------------------------
--              General
-----------------------------------------
Plug('dkarter/bullets.vim')      -- Bullet lists
Plug('junegunn/vim-easy-align')  -- Align code around arbitrary characters =,:
Plug('airblade/vim-rooter')      -- Sets root directory to project (git) directory by default
Plug('kopischke/vim-fetch')      -- Open files at file:line:column
Plug('scrooloose/nerdcommenter') -- Comment/uncomment source code files
Plug('tpope/vim-unimpaired')     -- Mappings
Plug('kana/vim-textobj-user')
Plug('rhysd/vim-textobj-anyblock')
Plug('AndrewRadev/linediff.vim') -- Linediff
Plug('junegunn/vim-slash')       -- Better vim search
Plug('direnv/direnv.vim')        -- direnv
Plug('brooth/far.vim')
Plug('kristijanhusak/vim-carbon-now-sh')
Plug('tpope/vim-eunuch')            -- OS comamnds in vim
Plug('wincent/scalpel')             -- Search and replace
Plug('AndrewRadev/splitjoin.vim')   -- Single/multi line
Plug('christianrondeau/vim-base64') -- Base64
Plug('yegappan/mru')                -- Most recently opened
Plug('takac/vim-hardtime')          -- Hardtime
-----------------------------------------
--              Utils
-----------------------------------------
Plug('antoinemadec/coc-fzf') -- Coc-Fzf
-----------------------------------------
--              Snippets
-----------------------------------------
Plug('SirVer/ultisnips') -- Use with coc-snippets
-----------------------------------------
--              PGSQL
-----------------------------------------
Plug('lifepillar/pgsql.vim')
-----------------------------------------
--              Shortkeys
-----------------------------------------
Plug('tpope/vim-surround') -- Delete add surroundings in pair
-----------------------------------------
--              GIT
-----------------------------------------
Plug('rhysd/committia.vim')       -- Better Git commits
Plug('rhysd/git-messenger.vim')   -- Show git messages
Plug('tpope/vim-fugitive')
Plug('rbong/vim-flog')            -- Better git log
Plug('tpope/vim-rhubarb')         -- Dependency for vim-fugitive
Plug('rhysd/vim-github-actions')  -- Vim filetype support for GitHub Actions
Plug('rhysd/conflict-marker.vim') -- Diff conflicts
-----------------------------------------
--      YAML/JSON/JSONNET/TOML/HELM
-----------------------------------------
Plug('elzr/vim-json')
Plug('google/vim-jsonnet')
Plug('cespare/vim-toml')
Plug('towolf/vim-helm')        -- Helm
Plug('cappyzawa/starlark.vim') -- Starlark
-----------------------------------------
--              FZF
-----------------------------------------
Plug('junegunn/fzf', {
  ['dir'] = '~/.fzf',
  ['do'] = './install --all'
})
Plug('junegunn/fzf.vim')
-----------------------------------------
--              I3
-----------------------------------------
Plug('mboughaba/i3config.vim')
-----------------------------------------
--              Coc
-----------------------------------------
-----------------------------------------
--              Python
-----------------------------------------
Plug('tweekmonster/django-plus.vim')
-----------------------------------------
--              Go
-----------------------------------------
Plug('fatih/vim-go')
Plug('sebdah/vim-delve')
-----------------------------------------
--              JS/TS/JSX/TSX
-----------------------------------------
Plug('pangloss/vim-javascript')
Plug 'HerringtonDarkholme/yats.vim'
Plug('jelera/vim-javascript-syntax')
Plug('maxmellon/vim-jsx-pretty')
-----------------------------------------
--              Ruby
-----------------------------------------
Plug('vim-ruby/vim-ruby')
-----------------------------------------
--              NGINX
-----------------------------------------
Plug('chr4/nginx.vim')
-----------------------------------------
--              HTML/CSS
-----------------------------------------
-- Look into html interactions
Plug('AndrewRadev/tagalong.vim') -- Tag matching
Plug('mattn/emmet-vim')
Plug('rstacruz/sparkup', {       -- CTRL + E for hacking HTMl
  ['rtp'] = 'vim/'
})
Plug('hail2u/vim-css3-syntax')
Plug('laytan/tailwind-sorter.nvim', { ['do'] = 'cd formatter && npm i && npm run build' })
-----------------------------------------
--              Neomake
-----------------------------------------
Plug('neomake/neomake')
-----------------------------------------
--              Ansible
-----------------------------------------
Plug('pearofducks/ansible-vim', {
  ['do'] = 'cd ./UltiSnips; ./generate.py'
})
Plug('danihodovic/vim-ansible-vault')
-----------------------------------------
--              Terraform
-----------------------------------------
Plug('hashivim/vim-terraform')


vim.call('plug#end')

require('tailwind-sorter').setup({
  on_save_enabled = true, -- If `true`, automatically enables on save sorting.
})


-- Noice
