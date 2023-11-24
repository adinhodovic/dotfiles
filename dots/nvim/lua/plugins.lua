local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

-----------------------------------------
--              General
-----------------------------------------
Plug('dkarter/bullets.vim')                     -- Bullet lists
Plug('junegunn/vim-easy-align')                 -- Align code around arbitrary characters =,:
Plug('airblade/vim-rooter')                     -- Sets root directory to project (git) directory by default
Plug('kopischke/vim-fetch')                     -- Open files at file:line:column
Plug('scrooloose/nerdcommenter')                -- Comment/uncomment source code files
Plug('tpope/vim-unimpaired')                    -- Mappings
Plug('kana/vim-textobj-user')
Plug('rhysd/vim-textobj-anyblock')
Plug('AndrewRadev/linediff.vim')                -- Linediff
Plug('junegunn/vim-slash')                      -- Better vim search
Plug('direnv/direnv.vim')                       -- direnv
Plug('brooth/far.vim')
Plug('kristijanhusak/vim-carbon-now-sh')
Plug('tpope/vim-eunuch')                        -- OS comamnds in vim
Plug('wincent/scalpel')                         -- Search and replace
Plug('AndrewRadev/splitjoin.vim')               -- Single/multi line
Plug('christianrondeau/vim-base64')             -- Base64
Plug('yegappan/mru')                            -- Most recently opened
Plug('takac/vim-hardtime')                      -- Hardtime
Plug('Lokaltog/vim-easymotion')
-----------------------------------------
--              Documentation/Writing
-----------------------------------------
Plug('instant-markdown/vim-instant-markdown', {['for'] = 'markdown'})
Plug('preservim/vim-markdown')
Plug('mzlogin/vim-markdown-toc')                -- Markdown ToC
Plug('rhysd/vim-grammarous')                    -- Words
Plug('reedes/vim-pencil')                       -- Writing tool
Plug('tpope/vim-abolish')                       -- Abbreviations
Plug('ferrine/md-img-paste.vim')                -- Image pasting
Plug('ron89/thesaurus_query.vim')
Plug('reedes/vim-wordy')
Plug('epwalsh/obsidian.nvim')                   -- Obsidian
-----------------------------------------
--              Automation
-----------------------------------------
Plug('github/copilot.vim')                      -- Copilot
Plug('farmergreg/vim-lastplace')                -- Open at lastplace
Plug('tpope/vim-speeddating')                   -- Increment dates
Plug('lfilho/cosco.vim')                        -- Semicolons
Plug('nvim-lua/plenary.nvim')                   -- Obsidian dependency
Plug('nvim-telescope/telescope.nvim')
-----------------------------------------
--              Utils
-----------------------------------------
Plug('antoinemadec/coc-fzf')                    -- Coc-Fzf
-----------------------------------------
--              Snippets
-----------------------------------------
Plug('SirVer/ultisnips')                        -- Use with coc-snippets
-----------------------------------------
--              PGSQL
-----------------------------------------
Plug('lifepillar/pgsql.vim')
-----------------------------------------
--              GUI
-----------------------------------------
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug('psliwka/vim-smoothie')                    -- Smooth scrolling
Plug('ntpeters/vim-better-whitespace')
Plug('ryanoasis/vim-devicons')                  -- Icons
Plug('vim-airline/vim-airline')                 -- Bottom bar
Plug('vim-airline/vim-airline-themes')          -- Bottom bar
Plug('Yggdroot/indentLine')                     -- Show line indentation
Plug('luochen1990/rainbow')                     -- Color parantheses
Plug('itchyny/vim-cursorword')                  -- Underlines/highlight the word under the cursor
Plug('morhetz/gruvbox')                         -- Gruvbox theme
Plug('rrethy/vim-hexokinase', {                 -- Colours in the file
  ['do'] = 'make hexokinase'
})
Plug('rrethy/vim-illuminate')                   -- Highlight similar word
Plug('machakann/vim-highlightedyank')           -- Highlight yanks
Plug('camspiers/animate.vim')                   -- Animate scroll
Plug('gelguy/wilder.nvim', {
  ['do']= ':UpdateRemotePlugins'}               -- Better wildmenu
)
-----------------------------------------
--              Shortkeys
-----------------------------------------
Plug('tpope/vim-surround')                      -- Delete add surroundings in pair
-----------------------------------------
--              GIT
-----------------------------------------
Plug('rhysd/committia.vim')                     -- Better Git commits
Plug('rhysd/git-messenger.vim')                 -- Show git messages
Plug('tpope/vim-fugitive')
Plug('rbong/vim-flog')                          -- Better git log
Plug('tpope/vim-rhubarb')                       -- Dependency for vim-fugitive
Plug('rhysd/vim-github-actions')                -- Vim filetype support for GitHub Actions
Plug('rhysd/conflict-marker.vim')               -- Diff conflicts
-----------------------------------------
--      YAML/JSON/JSONNET/TOML/HELM
-----------------------------------------
Plug('elzr/vim-json')
Plug('google/vim-jsonnet')
Plug('cespare/vim-toml')
Plug('towolf/vim-helm')                         -- Helm
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

Plug('fannheyward/telescope-coc.nvim')

vim.call('plug#end')


-- Telescope
require("telescope").setup({
  extensions = {
    coc = {
        theme = 'ivy',
        prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
    }
  },
})
require('telescope').load_extension('coc')

-- Treesitter
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

-- Obsidian
require("obsidian").setup({
  dir = "~/personal/notes",
  disable_frontmatter = false,
})

require("obsidian").setup({
  dir = "~/personal/blogs",
  disable_frontmatter = true,
})

-- Wilder.nvim
local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})
wilder.set_option('renderer', wilder.popupmenu_renderer(
  wilder.popupmenu_border_theme({
    highlighter = wilder.basic_highlighter(),
    highlights = {
      border = 'Normal', -- highlight to use for the border
    },
    border = 'rounded',
    left = {' ', wilder.popupmenu_devicons()},
    right = {' ', wilder.popupmenu_scrollbar()},
  })
))
