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
		-- treesitter
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all"
				ensure_installed = "all",
				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,
				-- Automatically install missing parsers when entering buffer
				auto_install = true,
				-- List of parsers to ignore installing (for "all")
				ignore_install = {},
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},
	{
		"hiphish/rainbow-delimiters.nvim",
		lazy = true,
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
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({
				input = {
					override = function(conf)
						conf.col = -1
						conf.row = 0
						return conf
					end,
				},
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
	},
	{
		-- Bottom bar
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"projekt0n/github-nvim-theme",
			"f-person/git-blame.nvim",
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
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff" },
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
					lualine_z = { lint_progress, "searchcount", "selectioncount" },
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
				options = {},
			})
			vim.cmd.colorscheme("github_dark_default")
			local visual_bg = vim.api.nvim_get_hl(0, { name = "Visual" }).bg
			vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = visual_bg, bold = true })
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
		-- Better bufferline
		"akinsho/bufferline.nvim",
		config = function()
			require("bufferline").setup({
				options = {
					hover = {
						enabled = true,
						delay = 0,
						reveal = { "close" },
					},
				},
			})
		end,
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
		-- TODO: maybe replace with neoscroll?
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
		"tzachar/highlight-undo.nvim",
		enabled = true,
		opts = {},
	},
	{
		"j-hui/fidget.nvim",
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
		"mawkler/modicator.nvim",
		opts = {},
	},
	{
		"Sam-programs/cmdline-hl.nvim",
		event = "VimEnter",
		opts = {
			type_signs = {
				[":"] = { " ", "Title" },
				["/"] = { " ", "Title" },
				["?"] = { " ", "Title" },
			},
			ghost_text = false,
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
		-- Smear cursor, shows cursor movement
		"sphamba/smear-cursor.nvim",
		enabled = true,
		opts = {
			distance_stop_animating = 0.5,
		},
	},
}
