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

-----------------------------------------
-- GUI
-----------------------------------------
return {
  {
    -- treesitter
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({
        -- A list of parser names, or "all"
        ensure_installed = "all",
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        -- Automatically install missing parsers when entering buffer
        auto_install = true,
        -- List of parsers to ignore installing (for "all")
        ignore_install = {},
        highlight = {
          -- `false` will disable the whole extension
          enable = true,
          -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
          -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
          -- the name of the parser)
          -- list of language that will be disabled
          disable = {},
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      })
    end
  },
  {
    -- treesitter context
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require('treesitter-context').setup({
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      })
    end
  },
  {
    -- smooth scrolling
    "psliwka/vim-smoothie",
  },
  {
    -- Better whitespace
    "ntpeters/vim-better-whitespace",
    config = function()
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
    end
  },
  {
    -- Icons
    "nvim-tree/nvim-web-devicons",
  },
  {
    -- Bottom bar
    "vim-airline/vim-airline",
    config = function()
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
    end
  },
  {
    -- Airline themes
    "vim-airline/vim-airline-themes",
  },
  {
    -- Show line indentation
    "Yggdroot/indentLine",
    config = function()
      g.indentLine_char_list = { '|', '¦', '┆', '┊' }
      g.indentLine_fileTypeExclude = { 'markdown', 'terraform' }
    end
  },
  {
    -- Color parenthesis
    "luochen1990/rainbow",
    config = function()
      g.rainbow_active = 1
    end
  },
  {
    -- Underlines/highlight the word under the cursor
    "itchyny/vim-cursorword",
  },
  {
    -- Github theme
    "projekt0n/github-nvim-theme",
    priority = 1000,
    config = function()
      require('github-theme').setup()
      vim.cmd.colorscheme("github_dark_default")
    end
  },
  {
    -- Colours in the file
    "rrethy/vim-hexokinase",
    build = "make hexokinase",
  },
  {
    -- Highlight similar words
    "rrethy/vim-illuminate",
  },
  {
    -- Better wildmenu
    "gelguy/wilder.nvim",
    dependencies = {
      "roxma/nvim-yarp",
      "roxma/vim-hug-neovim-rpc"
    },
    config = function()
      local wilder = require('wilder')
      wilder.setup({ modes = { ':', '?' } })
      wilder.set_option('renderer', wilder.popupmenu_renderer(
        wilder.popupmenu_border_theme({
          highlighter = wilder.basic_highlighter(),
          highlights = {
            border = 'Normal', -- highlight to use for the border
          },
          border = 'rounded',
          left = { ' ', wilder.popupmenu_devicons() },
          right = { ' ', wilder.popupmenu_scrollbar() },
        })
      ))
    end
  },
  {
    -- Better dropbar
    "Bekaboo/dropbar.nvim",
  },
  {
    -- Animate scroll
    "camspiers/animate.vim",
  },
  {
    -- Highlight yanks
    "machakann/vim-highlightedyank",
  },
  {
    -- Telescope fzf
    "nvim-telescope/telescope-fzf-native.nvim",
  },
  {
    -- Better bufferline
    "akinsho/bufferline.nvim",
    config = function()
      require('bufferline').setup({
        options = {
          diagnostics = "coc",
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            -- luacheck: pop
            if (count == 0) then
              return ""
            end
            local icon = '' .. ' ' .. level
            if level:match("error") then
              icon = ''
            elseif level:match("warning") then
              icon = ''
            elseif level:match("info") or level:match("hint") then
              icon = ''
            end
            -- kitty scales down the icon if there is no space on the right
            return icon .. " " .. count
          end,
          hover = {
            enabled = true,
            delay = 0,
            reveal = { "close" }
          },
        }
      })
    end
  },
  {
    -- Better statuscol
    "luukvbaal/statuscol.nvim",
    config = function()
      local builtin = require("statuscol.builtin")
      local cfg = {
        segments = { -- https://github.com/luukvbaal/statuscol.nvim#custom-segments
          { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
          {
            sign = { name = { "CocGit*" }, minwidth = 1, maxwidth = 1, auto = false },
            click = "v:lua.ScSa"
          },
          {
            sign = { name = { ".*" }, minwidth = 2, maxwidth = 2, auto = false },
            click = "v:lua.ScSa"
          },
          {
            text = {
              " ",
              builtin.lnumfunc,
              " "
            },
            condition = { true, builtin.not_empty },
            click = 'v:lua.ScLa'
          },
        },
      }
      require("statuscol").setup(cfg)
    end
  },
  {
    -- Better buffers
    "ghillb/cybu.nvim",
    config = function()
      require("cybu").setup()
    end
  },
  {
    -- Deadcolumn
    "Bekaboo/deadcolumn.nvim",
    config = function()
      require("deadcolumn").setup()
    end
  },
}
