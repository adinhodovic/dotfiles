local vim = vim

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
    ft = "ansible"
  },
  {
    -- Ansible Vault
    "danihodovic/vim-ansible-vault",
    ft = "ansible"
  },
  {
    -- Terraform
    "hashivim/vim-terraform",
    ft = "terraform"
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
