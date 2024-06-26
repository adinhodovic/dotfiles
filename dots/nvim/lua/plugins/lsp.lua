local vim = vim
local g = vim.g

-----------------------------------------
-- LSP
-----------------------------------------
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/neodev.nvim",
			"b0o/schemastore.nvim",
			"hrsh7th/nvim-cmp",
			"kevinhwang91/nvim-ufo",
			{
				"rmagatti/goto-preview",
				opts = {},
			},
		},
		keys = {
			{ "<leader>li", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
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
			{
				"gpd",
				function()
					require("goto-preview").goto_preview_definition()
				end,
				desc = "Goto Preview Definition",
			},
			{
				"gpy",
				function()
					require("goto-preview").goto_preview_type_definition()
				end,
				desc = "Goto Preview Type Definition",
			},
			{
				"<leader>gp",
				function()
					require("goto-preview").close_all_win()
				end,
				desc = "Goto Preview Definition",
			},
		},
		config = function()
			require("neodev").setup({})

			-- Set up lspconfig.
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			-- nvim-ufo requirement
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			local lspconfig = require("lspconfig")
			lspconfig.ansiblels.setup({
				capabilities = capabilities,
			})
			lspconfig.bashls.setup({
				capabilities = capabilities,
			})
			lspconfig.cssls.setup({
				capabilities = capabilities,
			})
			lspconfig.dockerls.setup({
				capabilities = capabilities,
			})
			lspconfig.docker_compose_language_service.setup({
				capabilities = capabilities,
			})
			lspconfig.emmet_language_server.setup({
				capabilities = capabilities,
			})
			lspconfig.gopls.setup({
				capabilities = capabilities,
			})
			lspconfig.helm_ls.setup({
				settings = {
					["helm-ls"] = {
						yamlls = {
							path = "yaml-language-server",
						},
					},
				},
			})
			lspconfig.html.setup({
				capabilities = capabilities,
				filetypes = { "html", "htmldjango" },
			})
			lspconfig.htmx.setup({
				capabilities = capabilities,
			})
			lspconfig.jsonls.setup({
				capabilities = capabilities,
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})
			lspconfig.jsonnet_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.jqls.setup({
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.ltex.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					-- rest of your on_attach process.
					require("ltex_extra").setup({
						path = "~/dotfiles/misc/spell",
					})
				end,
			})
			lspconfig.marksman.setup({
				capabilities = capabilities,
			})

			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							-- 'workspace' diagnostics is better but consumes more resources
							diagnosticMode = "openFilesOnly",
							typeCheckingMode = "off", -- Using mypy
						},
					},
				},
			})
			lspconfig.sqlls.setup({
				capabilities = capabilities,
			})
			lspconfig.bzl.setup({
				capabilities = capabilities,
			})
			lspconfig.taplo.setup({
				capabilities = capabilities,
			})
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
			})
			lspconfig.terraformls.setup({
				capabilities = capabilities,
			})
			lspconfig.vimls.setup({
				capabilities = capabilities,
			})
			lspconfig.yamlls.setup({
				capabilities = capabilities,
				yaml = {
					schemaStore = {
						-- You must disable built-in schemaStore support if you want to use
						-- this plugin and its advanced options like `ignore`.
						enable = false,
						-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
						url = "",
					},
					schemas = require("schemastore").yaml.schemas(),
				},
			})
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "nvim-telescope/telescope.nvim" },
		opts = {
			auto_open = false, -- automatically open the list when you have diagnostics
			auto_close = false, -- automatically close the list when you have no diagnostics
			focus = true,
			modes = {
				lsp = {
					focus = false,
					win = { position = "left", size = 60 },
				},
				symbols = {
					focus = false,
					win = { position = "left", size = 60 },
				},
			},
		},
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Trouble: Diagnostics",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Trouble: DBuffer Diagnostics",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle<cr>",
				desc = "Trouble: DSymbols",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle<cr>",
				desc = "Trouble: DLSP Definitions / references",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Trouble: DLocation List",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Trouble: Quickfix List",
			},
		},
		config = function(_, opts)
			require("trouble").setup(opts)
			-- What does this do
			local actions = require("telescope.actions")
			local open_with_trouble = require("trouble.sources.telescope").open

			-- Use this to add more results without clearing the trouble list
			local add_to_trouble = require("trouble.sources.telescope").add

			local telescope = require("telescope")

			telescope.setup({
				defaults = {
					mappings = {
						i = { ["<c-t>"] = open_with_trouble },
						n = { ["<c-t>"] = open_with_trouble },
					},
				},
			})
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
	-- Code actions
	{
		"aznhe21/actions-preview.nvim",
		keys = {
			{
				"<leader>ca",
				mode = { "v", "n" },
				function()
					require("actions-preview").code_actions()
				end,
				desc = "Toggle Code Actions",
			},
		},
	},
}
