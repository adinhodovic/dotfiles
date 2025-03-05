local vim = vim
local g = vim.g
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Define a function to simplify setting autocmds
local function set_autocmd(group, event, pattern, command)
	autocmd(event, {
		group = group,
		pattern = pattern,
		command = command,
	})
end

-----------------------------------------
-- Configuration management
-----------------------------------------

return {
	{
		-- Jsonnnet
		"google/vim-jsonnet",
		ft = "jsonnet",
	},
	{
		-- Helm
		"towolf/vim-helm",
		ft = "helm",
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
			set_autocmd(ansibleGroup, {
				"BufRead",
				"BufNewFile",
			}, { "*/ansible/*.yml" }, "set filetype=yaml.ansible")
		end,
	},
	{
		-- Ansible Vault
		"danihodovic/vim-ansible-vault",
		ft = "ansible",
		keys = {
			{ "<leader>ve", ":AnsibleVaultEncrypt <CR> :edit <CR>", mode = "n", desc = "Encrypt ansible vault" },
			{ "<leader>vd", ":AnsibleVaultDecrypt <CR> :edit <CR>", mode = "n", desc = "Decrypt ansible vault" },
		},
	},
	{
		-- Terraform
		"hashivim/vim-terraform",
		ft = {
			"terraform",
			"tf",
		},
		config = function()
			g.terraform_commentstring = "//%s"
			g.terraform_align = 1
			g.terraform_fmt_on_save = 1
		end,
	},
	{
		-- i3 Config
		"mboughaba/i3config.vim",
		ft = "i3config",
	},
	{
		-- Base64 Decoding/Encoding
		"taybart/b64.nvim",
		keys = {
			{
				"<leader>b64e",
				function()
					require("b64").encode()
				end,
				mode = "x",
				desc = "Base64 encrypt",
			},
			{
				"<leader>b64d",
				function()
					require("b64").decode()
				end,
				mode = "x",
				desc = "Base64 decrypt",
			},
		},
	},
}
