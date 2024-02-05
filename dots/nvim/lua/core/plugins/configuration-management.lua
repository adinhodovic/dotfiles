local vim = vim

-----------------------------------------
-- Configuration management
-----------------------------------------

return {
  {
    -- Json
    "elzr/vim-json",
  },
  {
    -- Jsonnnet
    "google/vim-jsonnet",
  },
  {
    -- Toml
    "cespare/vim-toml",
  },
  {
    -- Helm
    "towolf/vim-helm",
  },
  {
    -- Starlark
    "cappyzawa/starlark.vim",
  },
  {
    -- Ansible Vault
    "danihodovic/vim-ansible-vault",
  },
  {
    -- Terraform
    "hashivim/vim-terraform",
  },
  {
    -- i3 Config
    "mboughaba/i3config.vim",
  },
  {
    -- Ansible
    "pearofducks/ansible-vim",
    build = "cd ./UltiSnips; ./generate.py"
  }
}
