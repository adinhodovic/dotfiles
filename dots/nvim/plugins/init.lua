local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

-----------------------------------------
--              General
-----------------------------------------
Plug('dkarter/bullets.vim')                    -- Bullet lists
Plug('junegunn/vim-easy-align')                -- Align code around arbitrary characters =,:
Plug('airblade/vim-rooter')                    -- Sets root directory to project (git) directory by default
Plug('kopischke/vim-fetch')                    -- Open files at file:line:column
Plug('scrooloose/nerdcommenter')               -- Comment/uncomment source code files
Plug('tpope/vim-unimpaired')                   -- Mappings
Plug('kana/vim-textobj-user')
Plug('rhysd/vim-textobj-anyblock')
Plug('AndrewRadev/linediff.vim')               -- Linediff
Plug('junegunn/vim-slash')                     -- Better vim search
Plug('direnv/direnv.vim')                      -- direnv
Plug('brooth/far.vim')
Plug('kristijanhusak/vim-carbon-now-sh')
Plug('tpope/vim-eunuch')                       -- OS comamnds in vim
Plug('wincent/scalpel')                        -- Search and replace
Plug('AndrewRadev/splitjoin.vim')              -- Single/multi line
Plug('christianrondeau/vim-base64')            -- Base64
Plug('yegappan/mru')                           -- Most recently opened
Plug('takac/vim-hardtime')                     -- Hardtime
Plug('Lokaltog/vim-easymotion')
-----------------------------------------
--              Documentation/Writing
-----------------------------------------
Plug('instant-markdown/vim-instant-markdown', {['for'] = 'markdown'})
Plug('plasticboy/vim-markdown')
Plug('mzlogin/vim-markdown-toc')               -- Markdown ToC
Plug('kamykn/spelunker.vim')                   -- Words
Plug('kamykn/popup-menu.nvim')                 -- Popup for spelunker
Plug('reedes/vim-pencil')                      -- Writing tool
Plug('reedes/vim-wordy')
Plug('tpope/vim-abolish')                      -- Abbreviations
Plug('ferrine/md-img-paste.vim')               -- Image pasting
-----------------------------------------
--              Automation
-----------------------------------------
Plug('github/copilot.vim')                     -- Copilot
Plug('farmergreg/vim-lastplace')               -- Open at lastplace
Plug('tpope/vim-speeddating')                  -- Increment dates
Plug('lfilho/cosco.vim')                       -- Semicolons
-----------------------------------------
--              Utils
-----------------------------------------
Plug('wsdjeg/FlyGrep.vim')                     -- Use grep in Vim
Plug('antoinemadec/coc-fzf')                   -- Coc-Fzf
-----------------------------------------
--              Snippets
-----------------------------------------
Plug('SirVer/ultisnips')
-----------------------------------------
--              PGSQL
-----------------------------------------
Plug('lifepillar/pgsql.vim')
-----------------------------------------
--              GUI
-----------------------------------------
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug('psliwka/vim-smoothie')                   -- Smooth scrolling
Plug('ntpeters/vim-better-whitespace')
Plug('ryanoasis/vim-devicons')                 -- Icons
Plug('vim-airline/vim-airline')                -- Bottom bar
Plug('vim-airline/vim-airline-themes')         -- Bottom bar
Plug('Yggdroot/indentLine')                    -- Show line indentation
Plug('luochen1990/rainbow')                    -- Color parantheses
Plug('itchyny/vim-cursorword')                 -- Underlines the word under the cursor
Plug('morhetz/gruvbox')                        -- Gruvbox theme
Plug('rrethy/vim-hexokinase', {                -- Colours in the file
  ['do'] = 'make hexokinase'
})
Plug('rrethy/vim-illuminate')                  -- Highlight similar word
Plug('machakann/vim-highlightedyank')          -- Highlight yanks
Plug('camspiers/animate.vim')
-----------------------------------------
--              Shortkeys
-----------------------------------------
Plug('tpope/vim-surround')                     -- Delete add surroundings in pair
-----------------------------------------
--              GIT
-----------------------------------------
Plug('rhysd/committia.vim')                    -- Better Git commits
Plug('rhysd/git-messenger.vim')                -- Show git messages
Plug('airblade/vim-gitgutter')                 -- Show changed git lines
Plug('tpope/vim-fugitive')
Plug('rbong/vim-flog')                         -- Better git log
Plug('tpope/vim-rhubarb')                      -- Dependency for vim-fugitive
Plug('rhysd/vim-github-actions')               -- Vim filetype support for GitHub Actions
Plug('rhysd/conflict-marker.vim')              -- Diff conflicts
-----------------------------------------
--      YAML/JSON/JSONNET/TOML
-----------------------------------------
Plug 'elzr/vim-json'
Plug 'google/vim-jsonnet'
Plug('cespare/vim-toml')
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
Plug('neoclide/coc.nvim', {['branch'] = 'release'})
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
Plug('AndrewRadev/tagalong.vim')              -- Tag matching
Plug('mattn/emmet-vim')
Plug('rstacruz/sparkup', {                    -- CTRL + E for hacking HTMl
  ['rtp'] = 'vim/'
})
Plug('hail2u/vim-css3-syntax')
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
