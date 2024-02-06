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
				"coc-emoji",
				"coc-yank",
				"@yaegassy/coc-tailwindcss3",
				"coc-emmet",
				"coc-tsserver",
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
					"stylelint",
					"tflint",
					"stylua",
					"prettier",
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
					"emmet_language_server",
					"eslint",
					"gopls",
					"html",
					"htmx",
					"helm_ls",
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
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/neodev.nvim",
			"b0o/schemastore.nvim",
		},
		keys = {
			{ "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
			{
				"gd",
				function()
					require("telescope.builtin").lsp_definitions({ reuse_win = true })
				end,
				desc = "Goto Definition",
			},
			{ "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
			{ "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
			{
				"gI",
				function()
					require("telescope.builtin").lsp_implementations({ reuse_win = true })
				end,
				desc = "Goto Implementation",
			},
			{
				"gy",
				function()
					require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
				end,
				desc = "Goto T[y]pe Definition",
			},
			{ "K", vim.lsp.buf.hover, desc = "Hover" },
			{ "gK", vim.lsp.buf.signature_help, desc = "Signature Help" },
			{ "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" },
			-- Code actions managed by preview in ui.lua
			{
				"<leader>cA",
				function()
					vim.lsp.buf.code_action({
						context = {
							only = {
								"source",
							},
							diagnostics = {},
						},
					})
				end,
				desc = "Source Action",
			},
			{
				"<leader>cr",
				function()
					local inc_rename = require("inc_rename")
					return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
				end,
				expr = true,
				desc = "Rename",
			},
		},
		config = function()
			require("neodev").setup({})

			local lspconfig = require("lspconfig")
			lspconfig.ansiblels.setup({})
			lspconfig.bashls.setup({})
			lspconfig.cssls.setup({})
			lspconfig.dockerls.setup({})
			lspconfig.docker_compose_language_service.setup({})
			lspconfig.emmet_language_server.setup({})
			lspconfig.gopls.setup({})
			lspconfig.html.setup({
				filetypes = { "html", "htmldjango" },
			})
			lspconfig.htmx.setup({})
			lspconfig.helm_ls.setup({})
			lspconfig.jsonls.setup({
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})
			lspconfig.tsserver.setup({})
			lspconfig.jsonnet_ls.setup({})
			lspconfig.jqls.setup({})
			lspconfig.marksman.setup({})
			lspconfig.lua_ls.setup({})
			lspconfig.pyright.setup({})
			lspconfig.sqlls.setup({})
			lspconfig.bzl.setup({})
			lspconfig.taplo.setup({})
			lspconfig.tailwindcss.setup({})
			lspconfig.terraformls.setup({})
			lspconfig.vimls.setup({})
			lspconfig.yamlls.setup({
				schemaStore = {
					-- You must disable built-in schemaStore support if you want to use
					-- this plugin and its advanced options like `ignore`.
					enable = false,
					-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
					url = "",
				},
				schemas = require("schemastore").yaml.schemas(),
			})
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
		"roobert/tailwindcss-colorizer-cmp.nvim",
		-- optionally, override the default options:
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		opts = {},
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = {
			"zbirenbaum/copilot.lua",
		},
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-emoji",
			"SirVer/ultisnips",
			"f3fora/cmp-spell",
			"quangnguyen30192/cmp-nvim-ultisnips",
			"roobert/tailwindcss-colorizer-cmp.nvim",
			"chrisgrieser/cmp_yanky",
			"zbirenbaum/copilot-cmp",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

			local cmp_copilot = { name = "copilot", group_index = 2, max_item_count = 5 }
			local cmp_lsp = { name = "nvim_lsp", max_item_count = 10 }
			local cmp_lsp_signature_help = { name = "nvim_lsp_signature_help", max_item_count = 5 }
			local cmp_yanky = { name = "cmp_yanky", max_item_count = 5 }
			local cmp_spell = {
				name = "spell",
				option = {
					keep_all_entries = false,
					enable_in_context = function()
						return require("cmp.config.context").in_treesitter_capture("spell")
					end,
				},
			}
			local cmp_path = { name = "path", max_item_count = 5 }
			local cmp_ultisnips = { name = "ultisnips", max_item_count = 5 }
			local cmp_emoji = { name = "emoji", max_item_count = 5 }

			local default_cmp_sources = {
				cmp_copilot,
				cmp_lsp,
				cmp_lsp_signature_help,
				cmp_yanky,
				cmp_spell,
				cmp_path,
				cmp_ultisnips,
				cmp_emoji,
			}

			local lspkind = require("lspkind")

			-- Lua function that merges dicts
			local function merge_dicts(...)
				local result = {}
				for _, dict in ipairs({ ... }) do
					for k, v in pairs(dict) do
						result[k] = v
					end
				end
				return result
			end
			cmp.setup({
				formatting = {
					format = require("lspkind").cmp_format({
						mode = "symbol_text",
						symbol_map = { Copilot = "" },
						maxwidth = 50,
						ellipsis_char = "...",
						before = function(entry, vim_item)
							vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
							return vim_item
						end,
					}),
				},
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
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
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
				sources = cmp.config.sources(default_cmp_sources, {
					{ name = "buffer" },
				}),
			})

			-- Set configuration for specific filetype.
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources(
					merge_dicts(default_cmp_sources, {
						{ name = "git" },
					}),
					{
						{ name = "buffer" },
					}
				),
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
			capabilities.textDocument.completion.completionItem.snippetSupport = true

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
			require("lspconfig")["lua_ls"].setup({
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
				settings = {
					yaml = {
						schemas = {
							["kubernetes"] = "*.{yml,yaml}",
							["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
							["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
							["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
							["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
							["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
							["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
							["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
							["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
							["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
							["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
							["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
						},
					},
				},
			})
		end,
	},
}
