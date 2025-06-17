local vim = vim

return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"fang2hou/blink-copilot",
			"mikavilpas/blink-ripgrep.nvim",
			"disrupted/blink-cmp-conventional-commits",
			"folke/lazydev.nvim",
			"Kaiser-Yang/blink-cmp-git",
			"ribru17/blink-cmp-spell",
			"onsails/lspkind.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				"xzbdmw/colorful-menu.nvim",
				opts = {},
			},
		},
		version = "1.*",

		config = function()
			local has_words_before = function()
				local col = vim.api.nvim_win_get_cursor(0)[2]
				if col == 0 then
					return false
				end
				local line = vim.api.nvim_get_current_line()
				return line:sub(col, col):match("%s") == nil
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "BlinkCmpMenuOpen",
				callback = function()
					require("copilot.suggestion").dismiss()
					vim.b.copilot_suggestion_hidden = true
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "BlinkCmpMenuClose",
				callback = function()
					vim.b.copilot_suggestion_hidden = false
				end,
			})

			require("blink.cmp").setup({
				keymap = {
					preset = "enter",
					["<c-g>"] = {
						function()
							require("blink-cmp").show({ providers = { "ripgrep" } })
						end,
					},
					-- If completion hasn't been triggered yet, insert the first suggestion; if it has, cycle to the next suggestion.
					["<Tab>"] = {
						function(cmp)
							if has_words_before() then
								return cmp.insert_next()
							end
						end,
						"fallback",
					},
					-- Navigate to the previous suggestion or cancel completion if currently on the first one.
					["<S-Tab>"] = { "insert_prev" },
				},
				cmdline = {
					completion = {},
				},
				completion = {
					accept = {
						auto_brackets = {
							enabled = true,
						},
					},
					menu = {
						draw = {
							columns = {
								{
									"label",
									gap = 1,
								},
								{ "kind_icon", "kind", gap = 1 },
							},
							components = {
								label = {
									text = function(ctx)
										return require("colorful-menu").blink_components_text(ctx)
									end,
									highlight = function(ctx)
										return require("colorful-menu").blink_components_highlight(ctx)
									end,
								},
								kind_icon = {
									text = function(ctx)
										local icon = ctx.kind_icon
										if vim.tbl_contains({ "Path" }, ctx.source_name) then
											local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
											if dev_icon then
												icon = dev_icon
											end
										else
											icon = require("lspkind").symbolic(ctx.kind, {
												mode = "symbol",
											})
										end

										return icon .. ctx.icon_gap
									end,

									-- Optionally, use the highlight groups from nvim-web-devicons
									-- You can also add the same function for `kind.highlight` if you want to
									-- keep the highlight groups in sync with the icons.
									highlight = function(ctx)
										local hl = ctx.kind_hl
										if vim.tbl_contains({ "Path" }, ctx.source_name) then
											local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
											if dev_icon then
												hl = dev_hl
											end
										end
										return hl
									end,
								},
							},
						},
						border = "single",
					},
					documentation = {
						auto_show = true,
						auto_show_delay_ms = 500,
						window = { border = "single" },
					},
				},
				signature = {
					enabled = true,
					window = { border = "single" },
				},

				-- Default list of enabled providers defined so that you can extend it
				-- elsewhere in your config, without redefining it, due to `opts_extend`
				sources = {
					default = {
						"conventional_commits",
						"lsp",
						"copilot",
						"lazydev",
						"snippets",
						"ripgrep",
						"path",
						"git",
						"spell",
						"buffer",
					},
					providers = {
						copilot = {
							name = "copilot",
							module = "blink-copilot",
							score_offset = 100,
							async = true,
						},
						lsp = {
							name = "lsp",
							score_offset = 90,
						},
						lazydev = {
							name = "LazyDev",
							module = "lazydev.integrations.blink",
							score_offset = 110,
							enabled = function()
								return vim.bo.filetype == "lua"
							end,
						},
						snippets = {
							name = "Snippets",
							score_offset = 70,
						},
						ripgrep = {
							module = "blink-ripgrep",
							name = "Ripgrep",
							score_offset = 60,
							max_items = 5,
							transform_items = function(_, items)
								for _, item in ipairs(items) do
									-- append a description to easily distinguish rg results
									item.labelDetails = {
										description = "(rg)",
									}
								end
								return items
							end,
						},
						path = {
							name = "Path",
							score_offset = 110,
						},
						conventional_commits = {
							name = "Conventional Commits",
							module = "blink-cmp-conventional-commits",
							score_offset = 110,
							enabled = function()
								return vim.bo.filetype == "gitcommit"
							end,
						},
						git = {
							module = "blink-cmp-git",
							name = "Git",
							score_offset = 105,
							enabled = function()
								return vim.tbl_contains({ "octo", "gitcommit", "markdown" }, vim.bo.filetype)
							end,
						},
						spell = {
							name = "Spell",
							module = "blink-cmp-spell",
							opts = {
								-- EXAMPLE: Only enable source in `@spell` captures, and disable it
								-- in `@nospell` captures.
								enable_in_context = function()
									local curpos = vim.api.nvim_win_get_cursor(0)
									local captures = vim.treesitter.get_captures_at_pos(0, curpos[1] - 1, curpos[2] - 1)
									local in_spell_capture = false
									for _, cap in ipairs(captures) do
										if cap.capture == "spell" then
											in_spell_capture = true
										elseif cap.capture == "nospell" then
											return false
										end
									end
									return in_spell_capture
								end,
							},
						},
					},
				},
			})
		end,
	},
}
