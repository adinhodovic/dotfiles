local vim = vim
local set = vim.opt
local g = vim.g
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Define a function to simplify setting autocmds
local function set_autocmd(group, event, pattern, command)
	autocmd(event, {
		group = group,
		pattern = pattern,
		command = command,
	})
end

local ui_ft_blocklist = require("custom_settings").ui_ft_blocklist
-----------------------------------------
-- GUI
-----------------------------------------
return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		opts = {},
	},
	{
		"MeanderingProgrammer/treesitter-modules.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			auto_install = true,
			fold = {
				enable = true,
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = true,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					node_decremental = "<BS>",
				},
			},
		},
	},
	{
		"hiphish/rainbow-delimiters.nvim",
		config = function()
			require("rainbow-delimiters.setup").setup({})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		-- Colorizer in code
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup({
				-- Set to virtual text if needed
				render = "background",
				enable_named_colors = true,
				enable_tailwind = true,
			})
		end,
	},
	{
		-- treesitter context
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
			})
		end,
	},
	{
		-- Icons
		"nvim-tree/nvim-web-devicons",
		opts = {},
	},
	{
		-- Bottom bar
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"projekt0n/github-nvim-theme",
			"f-person/git-blame.nvim",
			"stevearc/overseer.nvim",
		},
		config = function()
			-- We only use the statusline for the git blame
			g.gitblame_display_virtual_text = 0
			g.gitblame_date_format = "%x %H:%M"

			local lint_progress = function()
				local linters = require("lint").get_running()
				if #linters == 0 then
					return "󰦕"
				end
				return "󱉶 " .. table.concat(linters, ", ")
			end

			local dmode_enabled = false
			vim.api.nvim_create_autocmd("User", {
				pattern = "DebugModeChanged",
				callback = function(args)
					dmode_enabled = args.data.enabled
				end,
			})

			local function worktree_and_branch()
				-- must be inside a git repo
				if vim.fn.systemlist("git rev-parse --is-inside-work-tree")[1] ~= "true" then
					return ""
				end

				-- branch (or detached)
				local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1] or ""
				if branch == "HEAD" then
					branch = "@" .. (vim.fn.systemlist("git rev-parse --short HEAD")[1] or "")
				end

				-- detect worktree name
				local common = vim.fn.systemlist("git rev-parse --git-common-dir")[1] or ""
				local wt = common:match("/worktrees/([^/]+)$")

				if wt then
					return string.format("󰙅 %s  %s", wt, branch)
				else
					return " " .. branch
				end
			end

			require("lualine").setup({
				options = {
					icons_enabled = true,
					always_divide_middle = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = {
						{
							"mode",
							fmt = function(str)
								return dmode_enabled and "DEBUG" or str
							end,
							color = function(tb)
								return dmode_enabled and "dCursor" or tb
							end,
						},
					},
					lualine_b = { worktree_and_branch, "diff" },
					lualine_c = { "diagnostics" },
					lualine_x = {
						{
							function()
								local blame_text = require("gitblame").get_current_blame_text()
								if blame_text:len() > 180 then
									blame_text = blame_text:sub(1, 180) .. "..."
								end
								local blame_text_escaped = blame_text:gsub("%%", "%%%%")
								return blame_text_escaped
							end,
							cond = require("gitblame").is_blame_text_available,
						},
					},
					lualine_y = { "filename", "progress", "location" },
					lualine_z = {
						lint_progress,
						{
							"overseer",
							label = "",
							colored = false,
						},
						"searchcount",
						"selectioncount",
					},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = { "aerial" },
			})
		end,
	},
	{
		"briangwaltney/paren-hint.nvim",
		lazy = false,
		opts = {},
	},
	{
		-- Show line indentation
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			exclude = {
				filetypes = ui_ft_blocklist,
			},
		},
	},
	{
		-- Github theme
		"projekt0n/github-nvim-theme",
		priority = 100000,
		config = function()
			require("github-theme").setup({
				options = {
					transparent = true,
				},
			})
			vim.cmd.colorscheme("github_dark_default")

			-- Helper to fetch colors from your current theme
			local function get(name)
				return vim.api.nvim_get_hl(0, { name = name })
			end

			local normal = get("Normal")
			local visual = get("Visual")
			local tabline = get("TabLine")
			local selected = get("TabLineSel")

			vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = visual.bg, bold = true })

			-- These should be really fixed upstream, the tabline is a ugly without these defaults
			vim.api.nvim_set_hl(0, "MiniTablineCurrent", {
				fg = "#58a6ff", -- GitHub blue
				bg = "NONE", -- transparent background
				bold = true,
			})
			vim.api.nvim_set_hl(0, "MiniTablineModifiedCurrent", {
				fg = "#58a6ff", -- GitHub blue
				bg = "NONE", -- transparent background
				bold = true,
			})
			vim.api.nvim_set_hl(0, "MiniTablineModifiedVisible", {
				fg = "#58a6ff", -- GitHub blue
				bg = "NONE", -- transparent background
				bold = false,
			})

			vim.api.nvim_set_hl(0, "MiniTablineVisible", {
				fg = "#58a6ff", -- GitHub blue
				bg = "NONE", -- transparent background
				bold = false,
			})
		end,
	},
	{
		-- Better dropbar
		"Bekaboo/dropbar.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		lazy = false,
		keys = {
			{
				"[;",
				function()
					require("dropbar.api").goto_context_start()
				end,
				desc = "Dropbar: Go to start of current context",
			},
			{
				"];",
				function()
					require("dropbar.api").select_next_context()
				end,
				desc = "Dropbar: Select next context",
			},
		},
		opts = true,
	},
	{
		-- Highlight yanks
		"machakann/vim-highlightedyank",
	},
	{
		-- Better statuscol
		"luukvbaal/statuscol.nvim",
		lazy = false,
		priority = 100,
		dependencies = {
			"kevinhwang91/nvim-ufo",
			"lewis6991/gitsigns.nvim",
			"folke/trouble.nvim",
		},
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				setopt = true,
				-- https://github.com/luukvbaal/statuscol.nvim/issues/72#issuecomment-1593828496
				bt_ignore = { "nofile", "prompt", "tempfile", "terminal" },
				ft_ignore = ui_ft_blocklist,

				segments = { -- https://github.com/luukvbaal/statuscol.nvim#custom-segments
					{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
					{
						sign = { namespace = { "gitsigns" }, minwidth = 1, maxwidth = 1, auto = false },
						click = "v:lua.ScSa",
					},
					{
						sign = { name = { ".*" }, namespace = { ".*" }, minwidth = 2, maxwidth = 2, auto = false },
						click = "v:lua.ScSa",
					},
					{
						text = {
							" ",
							builtin.lnumfunc,
							" ",
						},
						condition = { true, builtin.not_empty },
						click = "v:lua.ScLa",
					},
				},
			})
		end,
	},
	{
		-- Deadcolumn
		"Bekaboo/deadcolumn.nvim",
		config = function()
			require("deadcolumn").setup()
		end,
	},
	{
		"lewis6991/satellite.nvim",
		config = function()
			require("satellite").setup({
				handlers = {
					gitsigns = {
						enable = true,
					},
				},
			})
		end,
	},
	{
		"echasnovski/mini.animate",
		config = function()
			local animate = require("mini.animate")
			-- Disable on large files
			if vim.api.nvim_buf_line_count(0) < 1000 then
				require("mini.animate").setup({
					cursor = {
						-- Lags, disabled
						enabled = false,
						timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
					},
					scroll = {
						timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
					},
				})
			end
		end,
	},
	{
		"lewis6991/hover.nvim",
		config = function()
			require("hover").setup({
				init = function()
					-- Require providers
					require("hover.providers.lsp")
					require("hover.providers.gh")
					require("hover.providers.gh_user")
					require("hover.providers.man")
					require("hover.providers.dictionary")
				end,
				preview_opts = {
					border = "single",
				},
				preview_window = false,
				title = true,
				mouse_providers = {
					"LSP",
				},
				mouse_delay = 1000,
			})

			-- Setup keymaps, replaces cmp's mappings
			vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
			vim.keymap.set("n", "<C-p>", function()
				require("hover").hover_switch("previous")
			end, { desc = "hover.nvim (previous source)" })
			vim.keymap.set("n", "<C-n>", function()
				require("hover").hover_switch("next")
			end, { desc = "hover.nvim (next source)" })
		end,
	},
	{
		"j-hui/fidget.nvim",
		enabled = false,
		config = function()
			require("fidget").setup({
				-- Nvim UI notifications
				notification = {
					override_vim_notify = false,
				},
				progress = {
					-- ignore = { "ltex" },
				},
			})
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		enabled = true,
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
			cmdline = {
				view = "cmdline",
			},
			notify = {
				enabled = true,
			},
			messages = {
				enabled = true,
				view_search = false,
			},
			routes = {
				-- Just a bunch of junk displaying modified lines etc
				{
					filter = { event = "msg_show", kind = "", find = "lines --" },
					opts = { skip = true },
				},
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"zbirenbaum/neodim",
		event = "LspAttach",
		opts = {
			alpha = 0.5,
		},
	},
	{
		"mcauley-penney/visual-whitespace.nvim",
		opts = {},
	},
	{
		"echasnovski/mini.trailspace",
		event = "VeryLazy",
		config = function()
			local f = function(args)
				vim.b[args.buf].minitrailspace_disable = true
			end
			local ui_ft_blocklist = require("custom_settings").ui_ft_blocklist
			vim.api.nvim_create_autocmd("FileType", { pattern = ui_ft_blocklist, callback = f })
			require("mini.trailspace").setup()
		end,
	},
	{
		"echasnovski/mini.cursorword",
		version = false,
		opts = {},
	},
	{
		"nvim-zh/colorful-winsep.nvim",
		config = true,
		event = { "WinLeave" },
	},
	{
		-- Smear cursor, shows cursor movement
		"sphamba/smear-cursor.nvim",
		enabled = true,
		opts = {
			distance_stop_animating = 0.5,
		},
	},
	{
		"iofq/dart.nvim",
		enabled = true,
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function(_, opts)
			require("dart").setup({
				buflist = { "z", "x", "c", "v", "b", "n", "m" },
				mappings = {
					mark = "", -- disable
					jump = "-", -- Open Dart.pick
					pick = "<c-t>p", -- Open Dart.pick
					next = "<S-l>", -- Cycle right through the tabline
					prev = "<S-h>", -- Cycle left through the tabline
				},
				tabline = {
					format_item = function(item)
						local icon = require("nvim-web-devicons").get_icon(item.content) or ""
						local click = string.format("%%%s@SwitchBuffer@", item.bufnr)
						return string.format(
							"%%#%s#%s %s%%#%s#%s %s %%X",
							item.hl_label,
							click,
							item.label,
							item.hl,
							icon,
							item.content
						)
					end,
				},
			})
		end,
	},
	{
		"echasnovski/mini.tabline",
		opts = {},
	},
	{
		"rachartier/tiny-glimmer.nvim",
		event = "VeryLazy",
		priority = 10, -- Low priority to catch other plugins' keybindings
		opts = {
			overwrite = {
				yank = {
					enabled = true,
				},
				search = {
					enabled = true,
				},
				paste = {
					enabled = true,
				},
				undo = {
					enabled = true,
				},
				redo = {
					enabled = true,
				},
			},
			presets = {
				-- Pulsar-style cursor highlighting on specific events
				pulsar = {
					enabled = true,
				},
			},
		},
		config = function(_, opts)
			require("tiny-glimmer").setup(opts)
		end,
	},
}
