local vim = vim
local g = vim.g

-----------------------------------------
-- Automation
-----------------------------------------
return {
	{
		-- Conform formatting
		"stevearc/conform.nvim",
		enabled = true,
		config = function()
			require("conform").setup({
				format_on_save = function(bufnr)
					-- Disable with a global or buffer-local variable
					if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
						return
					end
					return { timeout_ms = 500, lsp_fallback = true }
				end,
				formatters = {
					tk = {
						command = vim.fn.systemlist("which tk")[1],
						args = { "fmt", "-" },
					},
					prettier = {
						prepend_args = { "--write" },
					},
					sqlfluff = {
						args = { "format", "--dialect=postgres", "-" },
					},
				},

				formatters_by_ft = {
					sh = { "shfmt" },
					lua = { "stylua" },
					python = { "isort", "black" },
					jsonnet = { "tk" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					typescriptreact = { "prettier" },
					javascriptreact = { "prettier" },
					graphql = { "prettier" },
					toml = { "taplo" },
					css = { "prettier" },
					scss = { "prettier" },
					less = { "prettier" },
					sql = { "sqlfluff" },
					yaml = { "prettier" },
					html = { "djlint" },
					htmldjango = { "djlint" },
				},
			})

			vim.api.nvim_create_user_command("FormatDisable", function(args)
				if args.bang then
					-- FormatDisable! will disable formatting just for this buffer
					vim.b.disable_autoformat = true
				else
					vim.g.disable_autoformat = true
				end
			end, {
				desc = "Disable autoformat-on-save",
				bang = true,
			})
			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.b.disable_autoformat = false
				vim.g.disable_autoformat = false
			end, {
				desc = "Re-enable autoformat-on-save",
			})
		end,
	},
	{
		-- nvim-lint linting
		"mfussenegger/nvim-lint",
		opts = {
			linters_by_ft = {
				["*"] = { "codespell" },
				markdown = { "markdownlint" },
				text = { "vale" },
				ansible = { "ansible-lint" },
				yaml = { "yamllint" },
				json = { "jsonlint" },
				jsonnet = { "tk" },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				css = { "stylelint" },
				scss = { "stylelint" },
				less = { "stylelint" },
				sql = { "sqlfluff" },
				html = { "htmlhint" },
				htmldjango = { "htmlhint", "djlint" },
				sh = { "shellcheck" },
				lua = { "luacheck" },
				python = { "mypy", "pylint" },
				vim = { "vint" },
			},

			linters = {
				eslint_d = {
					args = {
						"--no-warn-ignored", -- <-- this is the key argument
						"--format",
						"json",
						"--stdin",
						"--stdin-filename",
						function()
							return vim.api.nvim_buf_get_name(0)
						end,
					},
				},
				ansiblelint = {
					prepend_args = { "--write" },
				},
				jsonlint = {
					prepend_args = { "--fix" },
				},
				vint = {
					prepend_args = { "--enable-neovim" },
				},
				djlint = {
					prepend_args = { "--lint" },
				},
			},
		},
		config = function(_, opts)
			local lint = require("lint")

			opts.linters.tk = {
				cmd = vim.fn.systemlist("which tk")[1],
				args = { "lint" },
				stdin = false,
				ignore_exitcode = true,
				parser = require("lint.parser").from_errorformat("%f:%l:%e-%c %m"),
			}

			lint.linters_by_ft = opts.linters_by_ft
			for name, linter in pairs(opts.linters) do
				if type(linter) == "table" and type(lint.linters[name]) == "table" then
					lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
				else
					lint.linters[name] = linter
				end
			end
			vim.api.nvim_create_autocmd({
				"BufWritePost",
			}, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
