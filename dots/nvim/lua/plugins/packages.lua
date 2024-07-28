return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		opts = {},
		config = function(_, opts)
			local present, mason = pcall(require, "mason")

			if not present then
				return
			end

			local options = {
				ensure_installed = {
					"ansible-lint",
					"black",
					"codespell",
					"djlint",
					"eslint",
					"htmlhint",
					"isort",
					"jsonlint",
					"jsonnetlint",
					"lemminx",
					"luacheck",
					"markdownlint",
					"mypy",
					-- Go
					"gofumpt",
					"goimports",
					"golangci-lint",
					"gopls",
					---
					"prettier",
					"pylint",
					"ruff",
					"shellcheck",
					"shfmt",
					"sqlfluff",
					"stylelint",
					"stylua",
					"tflint",
					"vale",
					"vint",
					"write-good",
					"yamlfmt",
					"yamllint",
				},
				max_concurrent_installers = 10,
				PATH = "skip",
			}

			mason.setup(options)

			vim.api.nvim_create_user_command("MasonInstallAll", function()
				vim.cmd("MasonInstall " .. table.concat(options.ensure_installed, " "))
			end, {})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"ansiblels",
					"bashls",
					"cssls",
					"dockerls",
					"docker_compose_language_service",
					"emmet_language_server",
					"gopls",
					"html",
					"htmx",
					"helm_ls",
					"ltex",
					"lua_ls",
					"jsonls",
					"tsserver",
					"jsonnet_ls",
					"jqls",
					"marksman",
					"pyright",
					"sqlls",
					"bzl",
					"taplo",
					"tailwindcss",
					"terraformls",
					"vimls",
					"yamlls",
				},
			})
		end,
	},
}
