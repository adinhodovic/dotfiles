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
		-- smooth scrolling
		"psliwka/vim-smoothie",
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
		"vim-airline/vim-airline",
		config = function()
			g.airline_theme = "github_dark_default"
			g["airline#extensions#tabline#enabled"] = 0
			g["airline#extensions#coc#enabled"] = 1
			g["airline#extensions#coc#show_coc_status"] = 1
			g["airline#extensions#hunks#enabled"] = 1
			g["airline#extensions#hunks#coc_git"] = 1
			-- remove the filetype part
			g.airline_section_x = '%{get(b:,"coc_git_blame","")}'
			g.airline_section_y = ""
			-- remove separators for empty sections
			g.airline_skip_empty_sections = 1
			vim.cmd("autocmd User CocGitStatusChange AirlineRefresh")
		end,
	},
	{
		-- Airline themes
		"vim-airline/vim-airline-themes",
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
		-- Better wildmenu
		"gelguy/wilder.nvim",
		build = ":UpdateRemotePlugins",
		enabled = false,
		config = function()
			local wilder = require("wilder")
			wilder.setup({ modes = { ":", "?" } })
			wilder.set_option(
				"renderer",
				wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
					highlighter = wilder.basic_highlighter(),
					highlights = {
						border = "Normal", -- highlight to use for the border
					},
					border = "rounded",
					left = { " ", wilder.popupmenu_devicons() },
					right = { " ", wilder.popupmenu_scrollbar() },
				}))
			)
		end,
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
		config = function()
			local builtin = require("statuscol.builtin")
			local cfg = {
				segments = { -- https://github.com/luukvbaal/statuscol.nvim#custom-segments
					{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
					{
						sign = { name = { "CocGit*" }, minwidth = 1, maxwidth = 1, auto = false },
						click = "v:lua.ScSa",
					},
					{
						sign = { name = { ".*" }, minwidth = 2, maxwidth = 2, auto = false },
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
			}
			require("statuscol").setup(cfg)
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
		enabled = true,
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
}
