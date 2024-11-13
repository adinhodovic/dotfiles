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
		"cappyzawa/trim.nvim",
		opts = {
			ft_blocklist = {
				"html",
				"diff",
				"help",
				"dashboard",
				"qf",
				"git",
				"gitcommit",
				"unite",
				"help",
				"fugitive",
				"Trouble",
				"NeogitConsole",
				"TelescopeResults",
				"TelescopePrompt",
				"NeogitConsole",
				"fzf",
			},
			highlight = true,
		},
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
		config = function()
			require("ibl").setup({
				exclude = {
					filetypes = { "dashboard" },
				},
			})
		end,
	},
	{
		-- Github theme
		"projekt0n/github-nvim-theme",
		priority = 1000,
		config = function()
			require("github-theme").setup({
				options = {},
			})
			vim.cmd.colorscheme("github_dark_default")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavor = "moccha",
				transparent_background = true,
			})
		end,
	},
	-- Automatically highlights other instances of the word under your cursor.
	{
		"RRethy/vim-illuminate",
		lazy = false,
		opts = {
			delay = 200,
			large_file_cutoff = 2000,
			large_file_overrides = {
				providers = { "lsp", "treesitter", "regex" },
			},
		},
		config = function(_, opts)
			require("illuminate").configure(opts)

			local function map(key, dir, buffer)
				vim.keymap.set("n", key, function()
					require("illuminate")["goto_" .. dir .. "_reference"](false)
				end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
			end

			map("]]", "next")
			map("[[", "prev")

			-- also set it after loading ftplugins, since a lot overwrite [[ and ]]
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					local buffer = vim.api.nvim_get_current_buf()
					map("]]", "next", buffer)
					map("[[", "prev", buffer)
				end,
			})
		end,
		keys = {
			{ "]]", desc = "Next Reference" },
			{ "[[", desc = "Prev Reference" },
		},
	},
	{
		-- Better dropbar
		"Bekaboo/dropbar.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"telescope-fzf-native.nvim",
		},
	},
	{
		-- Highlight yanks
		"machakann/vim-highlightedyank",
	},
	{
		-- Telescope fzf
		"nvim-telescope/telescope-fzf-native.nvim",
	},
	{
		-- Better bufferline
		"akinsho/bufferline.nvim",
		config = function()
			require("bufferline").setup({
				options = {
					-- TODO(adinhodovic): High CPU
					--
					-- diagnostics = "nvim_lsp",
					-- 		diagnostics_indicator = function(count, level, diagnostics_dict, context)
					-- 			if count == 0 then
					-- 				return ""
					-- 			end
					-- 			local icon = "" .. " " .. level
					-- 			if level:match("error") then
					-- 				icon = ""
					-- 			elseif level:match("warning") then
					-- 				icon = ""
					-- 			elseif level:match("info") or level:match("hint") then
					-- 				icon = ""
					-- 			end
					-- 			return icon .. " " .. count
					-- 		end,
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
		dependencies = {
			"kevinhwang91/nvim-ufo",
			"lewis6991/gitsigns.nvim",
			"folke/trouble.nvim",
		},
		config = function()
			local signs = {
				Error = "",
				Warn = "",
				Hint = "",
				Info = "",
				Other = "",
			}
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				setopt = true,
				-- https://github.com/luukvbaal/statuscol.nvim/issues/72#issuecomment-1593828496
				bt_ignore = { "nofile", "prompt", "tempfile", "terminal" },
				ft_ignore = { "oil", "neotest-summary" },

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
		-- Better buffers
		"ghillb/cybu.nvim",
		keys = {
			{ "[b", "<Plug>(CybuPrev)", desc = "Cybu buffer previous" },
			{ "]b", "<Plug>(CybuNext)", desc = "Cybu buffer next" },
		},
		config = function()
			require("cybu").setup()
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
		event = "VeryLazy",
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
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				theme = "hyper",
				config = {
					week_header = {
						enable = true,
					},
					shortcut = {
						{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
						{
							icon = " ",
							icon_hl = "@variable",
							desc = "Files",
							group = "Label",
							action = "Telescope find_files",
							key = "f",
						},
						{
							desc = " Apps",
							group = "DiagnosticHint",
							action = "Telescope app",
							key = "a",
						},
						{
							desc = " dotfiles",
							group = "Number",
							action = "Telescope dotfiles",
							key = "d",
						},
					},
				},
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{ "winston0410/range-highlight.nvim", dependencies = { "winston0410/cmd-parser.nvim" }, config = true },
	{
		"tzachar/highlight-undo.nvim",
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
}
