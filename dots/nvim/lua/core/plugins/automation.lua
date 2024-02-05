local vim = vim
local g = vim.g
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-----------------------------------------
-- Automation
-----------------------------------------
return {
	{
		-- Fzf
		"junegunn/fzf",
		dir = "~/.fzf",
		build = "./install --all",
	},
	{
		-- Fzf vim integration
		"junegunn/fzf.vim",
		dependencies = {
			"junegunn/fzf",
		},
		config = function()
			g.fzf_action = {
				["ctrl-t"] = "tab split",
				["ctrl-x"] = "vsplit",
				["ctrl-z"] = "split",
			}
			g.fzf_layout = { up = "~40%" }
			g.fzf_files_options = '--ansi --preview "bat --style=plain {}" --preview-window right:100'
		end,
	},
	{
		-- Copilot
		"github/copilot.vim",
		config = function()
			-- Disable copilot tabs that interfere with Coc
			g.copilot_no_tab_map = true
			g.copilot_assume_mapped = true
		end,
	},
	{
		-- Telescope
		"nvim-telescope/telescope.nvim",
		priority = 1000,
		config = function()
			require("telescope").setup({
				extensions = {
					coc = {
						theme = "ivy",
						prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
					},
				},
			})
		end,
	},
  -- Telescope code actions
  {
  "aznhe21/actions-preview.nvim",
	keys = {
			{
				"<leader>a",
				mode = {"v", "n"},
				function()
          require("actions-preview").code_actions()
				end,
				desc = "Toggle Code Actions",
			},
    },
},
	{
		-- Telescope CoC
		"fannheyward/telescope-coc.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"neoclide/coc.nvim",
		},
		config = function()
			require("telescope").load_extension("coc")
		end,
	},
	{
		-- Open at last place
		"farmergreg/vim-lastplace",
	},
	{
		-- Increment dates
		"tpope/vim-speeddating",
	},
	{
		-- Semicolons
		"lfilho/cosco.vim",
		config = function()
			g.cosco_filetype_whitelist = {
				"javascript",
				"typescript",
				"css",
				"perl",
				"nginx",
			}
		end,
	},
	{
		-- Project jumping
		"ahmedkhalf/project.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("project_nvim").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
			require("telescope").load_extension("projects")
		end,
	},
	{
		-- File tree
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup({
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				update_focused_file = {
					enable = true,
					update_root = true,
				},
				sort = {
					sorter = "case_sensitive",
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = true,
				},
			})
		end,
	},
	{
		-- Markbar
		"Yilin-Yang/vim-markbar",
		config = function() end,
	},
	{
		-- Peek line numbers
		"nacro90/numb.nvim",
		config = function()
			require("numb").setup()
		end,
	},
	{
		-- Search and replace
		"nvim-pack/nvim-spectre",
		config = function()
			require("spectre").setup()
		end,
	},
	{
		-- Auto pairs
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	{
		-- Better search <leader>e, simpler than above
		"wincent/scalpel",
	},
	{
		-- Better folding
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		keys = {
			{
				"zR",
				mode = { "n" },
				function()
					require("ufo").openAllFolds()
				end,
				desc = "Ufo open all",
			},
			{
				"zM",
				mode = { "n" },
				function()
					require("ufo").closeAllFolds()
				end,
				desc = "Ufo close all",
			},
		},
		config = function()
			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local totalLines = vim.api.nvim_buf_line_count(0)
				local totalLines = vim.api.nvim_buf_line_count(0)
				local foldedLines = endLnum - lnum
				local suffix = ("  %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				local rAlignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
				suffix = (" "):rep(rAlignAppndx) .. suffix
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end

			-- global handler
			-- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
			-- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
			require("ufo").setup({
				fold_virt_text_handler = handler,
			})
		end,
	},
	{
		-- Better search
		"folke/flash.nvim",
		event = "VeryLazy",
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
		},
		config = function()
			require("flash").setup()
		end,
	},
	{
		-- Delete add surroundings in pair
		"tpope/vim-surround",
	},
	{
		-- Comment/uncomment source code files
		"scrooloose/nerdcommenter",
		config = function()
			-- Add a space before any comment
			g.NERDSpaceDelims = 1
		end,
	},
	{
		-- Ultisnips, use with coc-snippets
		"SirVer/ultisnips",
		config = function()
			-- Collides with coc-snippets
			g.UltiSnipsListSnippets = "<nop>"
			g.UltiSnipsExpandTrigger = "<nop>"
			-- Load my own snippets
			g.UltiSnipsSnippetDirectories = { "~/personal/UltiSnips" }
		end,
	},
	{
		-- Conform formatting
		"stevearc/conform.nvim",
		dependencies = { "mason.nvim" },
		cmd = "ConformInfo",
		config = function()
			require("conform").setup({
				format_on_save = {
					-- These options will be passed to conform.format()
					timeout_ms = 500,
					lsp_fallback = true,
				},
				formatters_by_ft = {
					sh = { "shfmt" },
					lua = { "stylua" },
					python = { "isort", "black" },
					jsonnet = { "tk" },
					vim = { "vint" },
					text = { "writegood" },
					markdown = { "markdownlint" },
					ansible = { "ansible-lint" },
					yaml = { "ansiblelint", "yamllint" },
					javascript = { { "prettierd", "prettier" } },
					typescript = { { "prettierd", "prettier" } },
					typescriptreact = { { "prettierd", "prettier" } },
					javascriptreact = { "eslint", { "prettierd", "prettier" } },
					css = { "stylelint" },
					scss = { "stylelint" },
					less = { "stylelint" },
					html = { "htmlhint", "jsbeautify" },
					htmldjango = { "htmlhint", "djlint" },
					json = { "jsonlint" },
				},
			})
			-- require("conform").formatters.tk = {
			-- prepend_args = { "fmt" },
			-- }
		end,
	},
	{
		-- nvim-lint linting
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = {
				markdown = { "vale" },
				ansible = { "ansible-lint" },
				yaml = { "yamllint" },
				json = { "jsonlint" },
				javascript = { "eslint", "prettier" },
				typescript = { "eslint", "prettier" },
				typescriptreact = { "eslint", "prettier" },
				javascriptreact = { "eslint", "prettier" },
				css = { "stylelint" },
				scss = { "stylelint" },
				less = { "stylelint" },
				html = { "htmlhint" },
				htmldjango = { "htmlhint" },
				sh = { "shellcheck" },
				lua = { "luacheck" },
				python = { "mypy", "pylint" },
				vim = { "vint" },
				sql = { "sqlint" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
          require("lint").try_lint("cspell")
				end,
			})
		end,
	},
}
