local vim = vim
local g = vim.g
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-----------------------------------------
-- Automation
-----------------------------------------
return {
  {
    -- Fzf
    "junegunn/fzf",
    dir = "~/.fzf",
    build = "./install --all"
  },
  {
    -- Fzf vim integration
    "junegunn/fzf.vim",
    dependencies = {
      "junegunn/fzf"
    },
    config = function()
      g.fzf_action = {
        ['ctrl-t'] = 'tab split',
        ['ctrl-x'] = 'vsplit',
        ['ctrl-z'] = 'split',
      }
      g.fzf_layout = { up = '~40%' }
      g.fzf_files_options = '--ansi --preview "bat --style=plain {}" --preview-window right:100'
    end
  },
  {
    -- Copilot
    "github/copilot.vim",
    config = function()
      -- Disable copilot tabs that interfere with Coc
      g.copilot_no_tab_map = true
      g.copilot_assume_mapped = true
    end
  },
  {
    -- Telescope
    "nvim-telescope/telescope.nvim",
    priority = 1000,
    config = function()
      require("telescope").setup({
        extensions = {
          coc = {
            theme = 'ivy',
            prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
          }
        },
      })
    end
  },
  {
    -- Telescope CoC
    "fannheyward/telescope-coc.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "neoclide/coc.nvim"
    },
    config = function()
      require('telescope').load_extension('coc')
    end
  },
  {
    -- Open at last place
    "farmergreg/vim-lastplace"
  },
  {
    -- Increment dates
    "tpope/vim-speeddating",
  },
  {
    -- Semicolons
    "lfilho/cosco.vim",
    config = function()
      g.cosco_filetype_whitelist = {
        'javascript',
        'typescript', 'css', 'perl', 'nginx' }
    end
  },
  {
    -- Project jumping
    "ahmedkhalf/project.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      require("project_nvim").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
      require('telescope').load_extension('projects')
    end
  },
  {
    -- File tree
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true
        },
        sort = {
          sorter = "case_sensitive",
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      })
    end
  },
  {
    -- Markbar
    "Yilin-Yang/vim-markbar",
    config = function()
    end
  },
  {
    -- Peek line numbers
    "nacro90/numb.nvim",
    config = function()
      require('numb').setup()
    end
  },
  {
    -- Search and replace
    "nvim-pack/nvim-spectre",
    config = function()
      require('spectre').setup()
    end
  },
  {
    -- Better search <leader>e, simpler than above
    "wincent/scalpel",
  },
  {
    -- Better folding
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async"
    },
    config = function()
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local totalLines = vim.api.nvim_buf_line_count(0)
        local totalLines = vim.api.nvim_buf_line_count(0)
        local foldedLines = endLnum - lnum
        local suffix = ("  %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        local rAlignAppndx =
            math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
        suffix = (" "):rep(rAlignAppndx) .. suffix
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end

      -- global handler
      -- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
      -- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
      require('ufo').setup({
        fold_virt_text_handler = handler
      })
    end
  },
  {
    -- Better search
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
    config = function()
      require("flash").setup()
    end
  },
  {
    -- Better notifications
    "folke/noice.nvim",
    config = function()
      -- require('noice').setup()
    end
  },
  {
    -- Delete add surroundings in pair
    "tpope/vim-surround",
  },
  {
    -- Comment/uncomment source code files
    "scrooloose/nerdcommenter",
    config = function()
      -- Add a space before any comment
      g.NERDSpaceDelims = 1
    end
  },
  {
    -- Ultisnips, use with coc-snippets
    "SirVer/ultisnips",
    config = function()
      -- Collides with coc-snippets
      g.UltiSnipsListSnippets = '<nop>'
      g.UltiSnipsExpandTrigger = '<nop>'
      -- Load my own snippets
      g.UltiSnipsSnippetDirectories = { '~/personal/UltiSnips' }
    end
  },
  {
    -- Ultisnips, use with coc-snippets
    "neomake/neomake",
    config = function()
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
    end
  },
}
