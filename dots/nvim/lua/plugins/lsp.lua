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
		-- TODO: remove this when empty lines work
		-- https://github.com/zbirenbaum/copilot-cmp/issues/5
		-- https://github.com/hrsh7th/nvim-cmp/issues/1272
		"github/copilot.vim",
		config = function()
			g.copilot_no_tab_map = true
			g.copilot_assume_mapped = true
			vim.cmd([[
	       imap <silent><script><expr> <C-c> copilot#Accept("\<CR>")
	     ]])
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
	{
		"zbirenbaum/copilot.lua",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = false,
				},
				suggestion = {
					-- TODO: enable this when empty lines work
					-- https://github.com/zbirenbaum/copilot-cmp/issues/5
					-- https://github.com/hrsh7th/nvim-cmp/issues/1272
					enabled = false,
					auto_trigger = true,
					keymap = {
						accept = "<c-c>",
						accept_word = false,
						accept_line = false,
						next = false,
						prev = false,
					},
				},
				filetypes = {
					yaml = true,
					markdown = true,
					help = true,
				},
			})
		end,
	},
}
