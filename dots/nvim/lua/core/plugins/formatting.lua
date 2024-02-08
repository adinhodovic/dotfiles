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
		dependencies = { "mason.nvim" },
		config = function()
			require("conform").setup({
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
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
					toml = { "taplo" },
					css = { "prettier" },
					scss = { "prettier" },
					less = { "prettier" },
					sql = { "sqlfluff" },
					yaml = { "yamlfmt" },
					html = { "djlint" },
				},
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
					prepend_args = { "--lint", "--reformat" },
				},
			},
		},
		config = function(_, opts)
			local lint = require("lint")

			-- require('lint') is just available here.
			opts.linters.htmlhint = {
				cmd = vim.fn.systemlist("which htmlhint")[1],
				stdin = false,
				args = { "--format", "unix", "--nocolor" },
				parser = require("lint.parser").from_errorformat("%f:%l:%c: %m,%-G,%-G%*\\d problems"),
			}

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
