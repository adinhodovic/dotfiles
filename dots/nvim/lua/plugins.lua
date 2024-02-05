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
--              Go
-----------------------------------------
Plug('fatih/vim-go')
Plug('sebdah/vim-delve')
-----------------------------------------
--              Ruby
-----------------------------------------
Plug('vim-ruby/vim-ruby')
-----------------------------------------
--              NGINX
-----------------------------------------
Plug('chr4/nginx.vim')
-----------------------------------------
--              Neomake
-----------------------------------------
Plug('neomake/neomake')


vim.call('plug#end')
