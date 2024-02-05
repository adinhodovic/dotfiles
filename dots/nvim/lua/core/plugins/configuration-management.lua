local vim = vim
local g = vim.global
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
-- Configuration management
-----------------------------------------

return {
  {
    -- Json
    "elzr/vim-json",
    ft = "json"
  },
  {
    -- Jsonnnet
    "google/vim-jsonnet",
    ft = "jsonnet"
  },
  {
    -- Toml
    "cespare/vim-toml",
    ft = "toml"
  },
  {
    -- Helm
    "towolf/vim-helm",
    ft = "helm"
  },
  {
    -- Starlark
    "cappyzawa/starlark.vim",
    ft = {
      "starlark",
      "tiltfile"
    }
  },
  {
    -- Ansible
    "pearofducks/ansible-vim",
    build = "cd ./UltiSnips; ./generate.py",
    ft = "ansible",
    config = function()
      -- require('noice').setup()
      g.ansible_extra_keywords_highlight = 1
      local ansibleGroup = augroup("ansible", {})
      set_autocmd(
        ansibleGroup,
        {
          "BufRead",
          "BufNewFile"
        },
        { "*/ansible/*.yml" },
        "set filetype=yaml.ansible"
      )
    end
  },
  {
    -- Ansible Vault
    "danihodovic/vim-ansible-vault",
    ft = "ansible"
  },
  {
    -- Terraform
    "hashivim/vim-terraform",
    ft = {
      "terraform",
      "tf"
    },
    config = function()
      g.terraform_commentstring = '//%s'
      g.terraform_align = 1
      g.terraform_fmt_on_save = 1
    end
  },
  {
    -- i3 Config
    "mboughaba/i3config.vim",
    ft = "i3config"
  },
  {
    -- Base64 Decoding/Encoding
    "christianrondeau/vim-base64",
  },
  {
    -- Most recently opened
    "yegappan/mru",
  },
}
