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
			})
		end,
	},
	{
		-- Colorizer in code
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				user_default_options = {
					tailwind = true,
					sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
				},
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
		-- Better renamer
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup({
				input_buffer_type = "dressing",
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
		"stevearc/aerial.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("aerial").setup({
				layout = {
					default_direction = "prefer_left",
				},
				-- optionally use on_attach to set keymaps when aerial has attached to a buffer
				on_attach = function(bufnr)
					-- Jump forwards/backwards with '{' and '}'
					vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
					vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
				end,
				vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>"),
			})
		end,
	},
	{
		-- Better whitespace
		"ntpeters/vim-better-whitespace",
		config = function()
			g.better_whitespace_enabled = 1
			g.strip_whitespace_on_save = 1
			g.strip_whitespace_confirm = 0
			g.better_whitespace_verbosity = 1
			g.current_line_whitespace_disabled_soft = 1
			g.better_whitespace_filetypes_blacklist =
				{ "zsh", "html", "vim", "diff", "gitcommit", "unite", "qf", "help" }
			g.better_whitespace_ctermcolor = "red"

			local whitespaceGroup = augroup("whitespace", {})
			set_autocmd(whitespaceGroup, { "BufWritePre" }, { "*" }, "StripWhitespace")
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
			local git_blame = require("gitblame")
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
							git_blame.get_current_blame_text,
							cond = git_blame.is_blame_text_available,
						},
					},
					lualine_y = { "aerial", "filename", "progress", "location" },
					lualine_z = { "searchcount", "selectioncount" },
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = { "aerial" },
			})
		end,
	},
	{
		-- Show line indentation
		"Yggdroot/indentLine",
		config = function()
			g.indentLine_char_list = { "|", "¦", "┆", "┊" }
			g.indentLine_fileTypeExclude = { "markdown", "terraform" }
		end,
	},
	{
		-- Color parenthesis
		"luochen1990/rainbow",
		config = function()
			g.rainbow_active = 1
		end,
	},
	{
		-- Underlines/highlight the word under the cursor
		"itchyny/vim-cursorword",
	},
	{
		-- Github theme
		"projekt0n/github-nvim-theme",
		priority = 1000,
		config = function()
			require("github-theme").setup()
			vim.cmd.colorscheme("github_dark_default")
		end,
	},
	{
		-- Colours in the file
		"rrethy/vim-hexokinase",
		build = "make hexokinase",
	},
	{
		-- Highlight similar words
		"rrethy/vim-illuminate",
	},
	{
		-- Better dropbar
		"Bekaboo/dropbar.nvim",
	},
	{
		-- Animate scroll
		"camspiers/animate.vim",
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
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level, diagnostics_dict, context)
						-- luacheck: pop
						if count == 0 then
							return ""
						end
						local icon = "" .. " " .. level
						if level:match("error") then
							icon = ""
						elseif level:match("warning") then
							icon = ""
						elseif level:match("info") or level:match("hint") then
							icon = ""
						end
						-- kitty scales down the icon if there is no space on the right
						return icon .. " " .. count
					end,
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
				bt_ignore = { "nofile", "prompt" },

				segments = { -- https://github.com/luukvbaal/statuscol.nvim#custom-segments
					{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
					{
						sign = { namespace = { "gitsigns" }, minwidth = 1, maxwidth = 1, auto = false },
						click = "v:lua.ScSa",
					},
					{
						sign = { namespace = { ".*" }, minwidth = 2, maxwidth = 2, auto = false },
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
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		-- Better buffers
		"ghillb/cybu.nvim",
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
		-- Better notifications
		"folke/noice.nvim",
		enabled = false,
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				cmdline = {
					view = "cmdline",
					enable = true,
				},

				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = true, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
	},
	{
		"lewis6991/satellite.nvim",
		config = function()
			require("satellite").setup()
		end,
	},
	{
		"echasnovski/mini.animate",
		event = "VeryLazy",
		enabled = true,
		config = function()
			local animate = require("mini.animate")
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
		end,
	},
}
