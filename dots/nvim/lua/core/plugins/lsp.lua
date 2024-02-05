local vim = vim
local g = vim.g
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local function set_autocmd(group, event, pattern, command)
	autocmd(event, {
		group = group,
		pattern = pattern,
		command = command,
	})
end

-----------------------------------------
-- LSP
-----------------------------------------
return {
	{
		-- coc
		"neoclide/coc.nvim",
		build = "npm ci",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			g.coc_global_extensions = {
				"coc-json",
				"coc-yaml",
				"coc-vimlsp",
				"coc-emoji",
				"coc-yank",
				"coc-html",
				"coc-htmldjango",
				"coc-css",
				"coc-html-css-support",
				"coc-emmet",
				"coc-tsserver",
				"@yaegassy/coc-tailwindcss3",
				"coc-spell-checker",
				"coc-markdownlint",
				"coc-git",
				"coc-lists",
				"coc-prettier",
				"coc-go",
				"@yaegassy/coc-marksman",
				"coc-sql",
			}

			local cocGroup = augroup("coc", {})
			-- Highlight symbol under cursor on CursorHold
			set_autocmd(cocGroup, {
				"CursorHold",
			}, { "html" }, "silent call CocActionAsync('highlight')")

			-- coc-tailwindcss3
			local coctailwindGroup = augroup("coctailwind", {})
			set_autocmd(coctailwindGroup, {
				"FileType",
			}, { "html" }, "let b:coc_root_patterns = ['.git', '.env', 'tailwind.config.js', 'tailwind.config.cjs']")
		end,
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		opts = {},
		config = function(_, opts)
			local present, mason = pcall(require, "mason")

			if not present then
				return
			end

			local options = {
				ensure_installed = {
					"black",
					"isort",
					"vint",
					"luacheck",
					"shellcheck",
					"stylua",
					"write-good",
				},
				max_concurrent_installers = 10,
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
					"gopls",
					"html",
					"htmx",
					"helm_ls",
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
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lspconfig").ansiblels.setup({})
			require("lspconfig").bashls.setup({})
			require("lspconfig").cssls.setup({})
			require("lspconfig").dockerls.setup({})
			require("lspconfig").docker_compose_language_service.setup({})
			require("lspconfig").gopls.setup({})
			require("lspconfig").html.setup({})
			require("lspconfig").htmx.setup({})
			require("lspconfig").helm_ls.setup({})
			require("lspconfig").jsonls.setup({})
			require("lspconfig").tsserver.setup({})
			require("lspconfig").jsonnet_ls.setup({})
			require("lspconfig").jqls.setup({})
			require("lspconfig").marksman.setup({})
			require("lspconfig").pyright.setup({})
			require("lspconfig").sqlls.setup({})
			require("lspconfig").bzl.setup({})
			require("lspconfig").taplo.setup({})
			require("lspconfig").tailwindcss.setup({})
			require("lspconfig").terraformls.setup({})
			require("lspconfig").vimls.setup({})
			require("lspconfig").yamlls.setup({})
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "nvim-telescope/telescope.nvim" },
		opts = {
			auto_open = true, -- automatically open the list when you have diagnostics
			auto_close = true, -- automatically close the list when you have no diagnostics
		},
		keys = {
			{
				"<leader>xx",
				mode = "n",
				function()
					require("trouble").toggle()
				end,
				desc = "Toggle trouble",
			},
			{
				"<leader>xw",
				mode = "n",
				function()
					require("trouble").toggle("workspace_diagnostics")
				end,
				desc = "Toggle trouble workspace diagnostics",
			},
			{
				"<leader>xd",
				mode = "n",
				function()
					require("trouble").toggle("document_diagnostics")
				end,
				desc = "Toggle trouble document diagnostics",
			},
			{
				"<leader>xq",
				mode = "n",
				function()
					require("trouble").toggle("quickfix")
				end,
				desc = "Toggle trouble quickfix",
			},
			{
				"<leader>gR",
				mode = "n",
				function()
					require("trouble").toggle("lsp_references")
				end,
				desc = "Toggle trouble lsp references",
			},
		},
		config = function()
			-- What does this do
			local trouble = require("trouble.providers.telescope")

			local telescope = require("telescope")

			telescope.setup({
				defaults = {
					mappings = {
						i = { ["<c-t>"] = trouble.open_with_trouble },
						n = { ["<c-t>"] = trouble.open_with_trouble },
					},
				},
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"SirVer/ultisnips",
			"quangnguyen30192/cmp-nvim-ultisnips",
		},
		config = function()
			local cmp = require("cmp")
			local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						-- elseif cmp_ultisnips_mappings.expand_or_jumpable() then
							-- cmp_ultisnips_mappings.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						-- elseif cmp_ultisnips_mappings.jumpable(-1) then
							-- cmp_ultisnips_mappings.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "ultisnips" },
				}, {
					{ name = "buffer" },
				}),
			})

			-- Set configuration for specific filetype.
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "git" },
				}, {
					{ name = "buffer" },
				}),
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

			-- Set up lspconfig.
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			require("lspconfig")["ansiblels"].setup({
				capabilities = capabilities,
			})
			require("lspconfig")["bashls"].setup({
				capabilities = capabilities,
			})
			require("lspconfig")["cssls"].setup({
				capabilities = capabilities,
			})
			require("lspconfig")["dockerls"].setup({
				capabilities = capabilities,
			})
			require("lspconfig")["docker_compose_language_service"].setup({
				capabilities = capabilities,
			})
			require("lspconfig")["gopls"].setup({
				capabilities = capabilities,
			})
			require("lspconfig")["html"].setup({
				capabilities = capabilities,
			})
			require("lspconfig")["htmx"].setup({
				capabilities = capabilities,
			})
			require("lspconfig")["helm_ls"].setup({
				capabilities = capabilities,
			})
			require("lspconfig")["jsonls"].setup({
				capabilities = capabilities,
			})
			require("lspconfig")["tsserver"].setup({
				capabilities = capabilities,
			})
			require("lspconfig")["jsonnet_ls"].setup({
				capabilities = capabilities,
			})
			require("lspconfig")["jqls"].setup({
				capabilities = capabilities,
			})
			require("lspconfig")["marksman"].setup({
				capabilities = capabilities,
			})
			require("lspconfig")["pyright"].setup({
				capabilities = capabilities,
			})
			require("lspconfig")["sqlls"].setup({
				capabilities = capabilities,
			})
			require("lspconfig")["bzl"].setup({
				capabilities = capabilities,
			})
			require("lspconfig")["taplo"].setup({
				capabilities = capabilities,
			})
			require("lspconfig")["tailwindcss"].setup({
				capabilities = capabilities,
			})
			require("lspconfig")["terraformls"].setup({
				capabilities = capabilities,
			})
			require("lspconfig")["vimls"].setup({
				capabilities = capabilities,
			})
			require("lspconfig")["yamlls"].setup({
				capabilities = capabilities,
			})
		end,
	},
}
