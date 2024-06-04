local vim = vim

return {
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
			"f3fora/cmp-spell",
			"saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
			"luckasRanarison/tailwind-tools.nvim",
			"chrisgrieser/cmp_yanky",
			"zbirenbaum/copilot-cmp",
			"onsails/lspkind.nvim",
			"lukas-reineke/cmp-rg",
			"barreiroleo/ltex_extra.nvim",
			"windwp/nvim-autopairs",
		},
		config = function()
			require("cmp_git").setup()

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			local cmp_lsp = { name = "nvim_lsp", group_index = 1 }
			local cmp_copilot = { name = "copilot", max_item_count = 5, group_index = 1 }
			local cmp_luasnip = { name = "luasnip", max_item_count = 10, group_index = 1 }
			local cmp_yanky = { name = "cmp_yanky", max_item_count = 10, group_index = 1 }
			local cmp_spell = {
				name = "spell",
				option = {
					enable_in_context = function()
						return require("cmp.config.context").in_treesitter_capture("spell")
					end,
				},
				group_index = 1,
			}
			local cmp_path = { name = "path", max_item_count = 20, group_index = 1 }
			local cmp_emoji = { name = "emoji", max_item_count = 5, group_index = 1 }
			local cmp_calc = { name = "calc", max_item_count = 5, group_index = 1 }
			local cmp_git = { name = "git", max_item_count = 10, group_index = 1 }
			local cmp_conventional_commits = {
				name = "conventionalcommits",
				max_item_count = 20,
				group_index = 1,
			}
			local cmp_ripgrep = { name = "rg", max_item_count = 10, keyword_length = 5, group_index = 1 }
			local cmp_buffer = { name = "buffer", max_item_count = 10, group_index = 2 }

			local default_cmp_sources = {
				cmp_lsp,
				cmp_copilot,
				cmp_luasnip,
				cmp_yanky,
				cmp_git,
				cmp_spell,
				cmp_path,
				cmp_emoji,
				cmp_calc,
				cmp_ripgrep,
				cmp_buffer,
			}

			local luasnip = require("luasnip")
			local utils = require("tailwind-tools.utils")

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

							-- Custom icon for 'spell' source
							if entry.source.name == "spell" then
								vim_item.kind = "󰓆"
								return vim_item
							end

							-- Tailwind colors
							local doc = entry.completion_item.documentation
							if vim_item.kind == "Color" and type(doc) == "string" then
								local _, _, r, g, b = doc:find("rgba?%((%d+), (%d+), (%d+)")
								if r then
									vim_item.kind_hl_group = utils.set_hl_from(r, g, b, "foreground")
								end
							end

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
				sources = cmp.config.sources(default_cmp_sources),
			})

			-- Set configuration for specific filetype.
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources(
					vim.tbl_deep_extend("keep", { cmp_conventional_commits }, default_cmp_sources)
				),
			})

			-- Set configuration for specific filetype.
			cmp.setup.filetype("markdown", {
				sources = cmp.config.sources({
					vim.tbl_deep_extend("keep", { cmp_conventional_commits }, default_cmp_sources),
				}),
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
					{ cmp_buffer },
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
					cmp_path,
					{ name = "cmdline", group_index = 2 },
				}),
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = {
			"zbirenbaum/copilot.lua",
		},
		config = function()
			local copilot_cmp = require("copilot_cmp")
			copilot_cmp.setup({})
		end,
	},
}
