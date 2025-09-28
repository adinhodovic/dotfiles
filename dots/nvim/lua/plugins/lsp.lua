local vim = vim
local g = vim.g

-----------------------------------------
-- LSP
-----------------------------------------
return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"b0o/schemastore.nvim",
			"hrsh7th/nvim-cmp",
			"saghen/blink.cmp",
			"kevinhwang91/nvim-ufo",
			"barreiroleo/ltex_extra.nvim",
			{
				"WilliamHsieh/overlook.nvim",
				opts = {},
			},
			{
				-- Navbuddy provides breadcrumb like UI
				"SmiteshP/nvim-navbuddy",
				dependencies = {
					"SmiteshP/nvim-navic",
					"MunifTanjim/nui.nvim",
				},
				opts = {
					lsp = {
						auto_attach = true,
					},
				},
				keys = {
					{
						"<leader>nb",
						function()
							require("nvim-navbuddy").open()
						end,
						desc = "Navbuddy: Toggle",
					},
				},
			},
		},
		keys = {
			{ "<leader>li", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
			{ "gD", vim.lsp.buf.declaration, desc = "Go to Declaration" },
			-- Some are replaced by hover.nvim
			{ "gK", vim.lsp.buf.signature_help, desc = "Signature Help" },
			{ "gY", vim.lsp.buf.type_definition, desc = "Go to Type Definition" },
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
				desc = "LSP: Source Action",
			},
			{
				"<leader>cr",
				function()
					local inc_rename = require("inc_rename")
					return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
				end,
				expr = true,
				desc = "IncRename: Rename",
			},
			{
				"gpd",
				function()
					require("overlook.api").peek_definition()
				end,
				desc = "Overlook: Peek Definition",
			},
			{
				"<leader>gpu",
				function()
					require("overlook.api").restore_popup()
				end,
				desc = "Overlook: Restore Peek Window",
			},
			{
				"<leader>gpc",
				function()
					require("overlook.api").close_all()
				end,
				desc = "Overlook: Close All Peek Windows",
			},
		},
		config = function()
			vim.lsp.enable("ansiblels")

			vim.lsp.enable("bashls")

			vim.lsp.enable("cssls")

			vim.lsp.enable("dockerls")

			vim.lsp.enable("docker_compose_language_service")

			vim.lsp.enable("emmet_language_server")

			vim.lsp.enable("gopls")

			vim.lsp.config("helm_ls", {
				settings = {
					["helm-ls"] = {
						yamlls = {
							path = "yaml-language-server",
						},
					},
				},
			})
			vim.lsp.enable("helm_ls")

			vim.lsp.config("html", {
				filetypes = { "html", "htmldjango" },
			})
			vim.lsp.enable("html")

			-- vim.lsp.config("htmx", {
			-- 	filetypes = { "html", "htmldjango" },
			-- })
			-- vim.lsp.enable("htmx")

			vim.lsp.config("jsonls", {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})
			vim.lsp.enable("jsonls")

			vim.lsp.config("jsonnet_ls", {
				cmd = { "jsonnet-language-server", "-t" },
			})
			vim.lsp.enable("jsonnet_ls")

			vim.lsp.config("jqls", {})
			vim.lsp.enable("jqls")

			vim.lsp.enable("lua_ls")

			vim.lsp.config("ltex_plus", {
				on_attach = function(_, _)
					-- rest of your on_attach process.
					require("ltex_extra").setup({
						path = "~/dotfiles/misc/spell",
					})
				end,
				settings = {
					ltex = {
						language = "en-US",
						checkFrequency = "save",
					},
				},
			})
			vim.lsp.enable("ltex_plus")

			vim.lsp.enable("marksman")

			vim.lsp.enable("ts_ls")

			vim.lsp.config("pyright", {
				settings = {
					python = {
						analysis = {
							diagnosticMode = "openFilesOnly", -- 'workspace' diagnostics is better but consumes more resources
							typeCheckingMode = "off", -- Using mypy
						},
					},
				},
			})
			vim.lsp.enable("pyright")

			vim.lsp.enable("sqlls")

			vim.lsp.enable("bzl")

			vim.lsp.enable("taplo")

			-- Managed by tailwind-tools
			-- lspconfig.tailwindcss.setup({
			-- 	capabilities = capabilities,
			-- })

			vim.lsp.enable("terraformls")

			vim.lsp.enable("vale_ls")

			vim.lsp.enable("vimls")

			vim.lsp.config("yamlls", {
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
			vim.lsp.enable("yamlls")

			vim.lsp.enable("lemminx")
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
			local open_with_trouble = require("trouble.sources.telescope").open

			local telescope = require("telescope")
			vim.lsp.handlers["textDocument/publishDiagnostics"] =
				vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true })

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
	{
		"rachartier/tiny-code-action.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
		event = "LspAttach",
		opts = {
			backend = "difftastic",
			picker = "fzf-lua",
		},
		keys = {
			{
				"<leader>ca",
				mode = { "v", "n" },
				function()
					require("tiny-code-action").code_action()
				end,
				desc = "Acitons Preview: Toggle Code Actions",
			},
		},
	},
	-- Better inline diagnostic for breaking lines
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		config = function()
			require("tiny-inline-diagnostic").setup()
			vim.diagnostic.config({ virtual_text = false })
		end,
	},
	{
		-- Better LSP renamer
		"smjonas/inc-rename.nvim",
		dependencies = {
			"folke/snacks.nvim",
		},
		config = function()
			require("inc_rename").setup({
				input_buffer_type = "snacks",
			})
		end,
	},
}
