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
					"black",
					"isort",
					"htmlhint",
					"golangci-lint",
					"ruff",
					"djlint",
					"vint",
					"luacheck",
					"jsonlint",
					"jsonnetlint",
					"shellcheck",
					"yamllint",
					"yamlfmt",
					"shfmt",
					"codespell",
					"sqlfluff",
					"ansible-lint",
					"stylelint",
					"mypy",
					"tflint",
					"stylua",
					"pylint",
					"prettier",
					"write-good",
					"eslint",
					"vale",
					"markdownlint",
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
			-- Some are replaced by hover.nvim
			-- { "K", vim.lsp.buf.hover, desc = "Hover" },
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
			-- lspconfig.htmx.setup({})
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
			auto_open = false, -- automatically open the list when you have diagnostics
			auto_close = false, -- automatically close the list when you have no diagnostics
		},
		config = function(_, opts)
			require("trouble").setup(opts)
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
			vim.keymap.set("n", "<leader>xx", function()
				require("trouble").toggle()
			end)
			vim.keymap.set("n", "<leader>xw", function()
				require("trouble").toggle("workspace_diagnostics")
			end)
			vim.keymap.set("n", "<leader>xd", function()
				require("trouble").toggle("document_diagnostics")
			end)
			vim.keymap.set("n", "<leader>xq", function()
				require("trouble").toggle("quickfix")
			end)
			vim.keymap.set("n", "<leader>xl", function()
				require("trouble").toggle("loclist")
			end)
			vim.keymap.set("n", "gR", function()
				require("trouble").toggle("lsp_references")
			end)
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
		"zbirenbaum/copilot-cmp",
		dependencies = {
			"zbirenbaum/copilot.lua",
		},
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		config = function()
			require("lsp_signature").setup({
				bind = true, -- This is mandatory, otherwise border config won't get registered.
				handler_opts = {
					border = "rounded",
				},
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"ray-x/lsp_signature.nvim",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-calc",
			"petertriho/cmp-git",
			"davidsierradz/cmp-conventionalcommits",
			"SirVer/ultisnips",
			"f3fora/cmp-spell",
			"saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
			"roobert/tailwindcss-colorizer-cmp.nvim",
			"chrisgrieser/cmp_yanky",
			"zbirenbaum/copilot-cmp",
			"onsails/lspkind.nvim",
			"lukas-reineke/cmp-rg",
		},
		config = function()
			local cmp = require("cmp")

			require("cmp_git").setup()

			local cmp_copilot = { name = "copilot", group_index = 2, max_item_count = 5 }
			local cmp_lsp = { name = "nvim_lsp", max_item_count = 10 }
			local cmp_luasnip = { name = "luasnip", max_item_count = 10 }
			local cmp_yanky = { name = "cmp_yanky", max_item_count = 5 }
			local cmp_spell = {
				name = "spell",
				option = {
					enable_in_context = function()
						return require("cmp.config.context").in_treesitter_capture("spell")
					end,
				},
			}
			local cmp_path = { name = "path" }
			local cmp_ultisnips = { name = "ultisnips", max_item_count = 5 }
			local cmp_emoji = { name = "emoji", max_item_count = 5 }
			local cmp_calc = { name = "calc", max_item_count = 5 }
			local cmp_git = { name = "git", max_item_count = 10 }
			local cmp_conventional_commits = { name = "conventionalcommits", max_item_count = 20 }
			local cmp_ripgrep = { name = "rg", max_item_count = 5, keyword_length = 5 }

			local default_cmp_sources = {
				cmp_copilot,
				cmp_lsp,
				cmp_luasnip,
				cmp_yanky,
				cmp_git,
				cmp_spell,
				cmp_path,
				cmp_ultisnips,
				cmp_emoji,
				cmp_calc,
				cmp_ripgrep,
			}

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

			local luasnip = require("luasnip")

			cmp.setup({
				formatting = {
					format = require("lspkind").cmp_format({
						mode = "symbol_text",
						symbol_map = { Copilot = "" },
						maxwidth = 50,
						ellipsis_char = "...",
						before = function(entry, vim_item)
							-- Custom icon for 'calc' source
							if entry.source.name == "calc" then
								vim_item.kind = ""
								return vim_item
							end

							-- Custom icon for 'git' source
							if entry.source.name == "git" then
								vim_item.kind = ""
								return vim_item
							end

							-- Custom icon for 'search' source
							if entry.source.name == "rg" then
								vim_item.kind = ""
								return vim_item
							end

							-- Tailwind colors
							vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
							return vim_item
						end,
					}),
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
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
						cmp_conventional_commits,
					}),
					{
						{ name = "buffer" },
					}
				),
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				-- Use default nvim history scrolling
				mapping = cmp.mapping.preset.cmdline({
					-- Use default nvim history scrolling
					["<C-n>"] = {
						c = false,
					},
					["<C-p>"] = {
						c = false,
					},
				}),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline({
					-- Use default nvim history scrolling
					["<C-n>"] = {
						c = false,
					},
					["<C-p>"] = {
						c = false,
					},
				}),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

			-- Hide copilot when suggestion open
			cmp.event:on("menu_opened", function()
				vim.b.copilot_suggestion_hidden = true
			end)

			cmp.event:on("menu_closed", function()
				vim.b.copilot_suggestion_hidden = false
			end)

			-- Set up lspconfig.
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			-- nvim-ufo requirement
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

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
			-- require("lspconfig")["htmx"].setup({
			-- 	capabilities = capabilities,
			-- })
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
