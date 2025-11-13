local vim = vim
local g = vim.g

-----------------------------------------
-- Automation
-----------------------------------------
return {
	{
		-- Open at last place
		"farmergreg/vim-lastplace",
	},
	{
		-- Better marks
		"chentoast/marks.nvim",
		lazy = false,
		keys = {
			{
				"<leader>m",
				"<cmd>MarksListAll<CR>",
				desc = "Marks: List all marks",
			},
		},
		config = function()
			require("marks").setup({})
		end,
	},
	{
		-- Better folding
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		config = function()
			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
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

			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

			local ui_ft_blocklist = require("custom_settings").ui_ft_blocklist
			local disable_folding = function(args)
				require("ufo").detach()
				vim.opt_local.foldenable = false
				vim.opt_local.foldcolumn = "0"
			end
			vim.api.nvim_create_autocmd("FileType", {
				pattern = ui_ft_blocklist,
				callback = disable_folding,
			})
		end,
	},
	{
		-- Comment/uncomment source code files
		"numToStr/Comment.nvim",
		opts = {},
	},
	{
		-- treesitter tag closing
		"windwp/nvim-ts-autotag",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {},
	},
	{
		-- Auto pairs
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"chrisgrieser/nvim-rulebook",
		keys = {
			{
				"<leader>ri",
				function()
					require("rulebook").ignoreRule()
				end,
				desc = "Rulebook: Ignore rule",
			},
			{
				"<leader>rl",
				function()
					require("rulebook").lookupRule()
				end,
				desc = "Rulebook: Lookup rule",
			},
		},
	},
	{
		"chrisgrieser/nvim-spider",
		keys = {
			{
				"w",
				"<cmd>lua require('spider').motion('w')<CR>",
				mode = { "n", "o", "x" },
				desc = "Spider: Move to next word",
			},
			{
				"e",
				"<cmd>lua require('spider').motion('e')<CR>",
				mode = { "n", "o", "x" },
				desc = "Spider: Move to end of word",
			},
			-- ...
			{
				"q",
				"<cmd>lua require('spider').motion('b')<CR>",
				mode = { "n", "o", "x" },
				desc = "Spider: Move to previous word",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"folke/which-key.nvim",
		},

		keys = (function()
			local keys = {}
			local function D(desc)
				return "Textobjects: " .. desc
			end

			---------------------------------------------------------------------------
			-- helpers
			---------------------------------------------------------------------------
			local function map_select(lhs, query, desc)
				table.insert(keys, {
					lhs,
					function()
						require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
					end,
					mode = { "x", "o" },
					desc = D(desc),
				})
			end

			local function map_swap(lhs, query, direction, desc)
				table.insert(keys, {
					lhs,
					function()
						local swap = require("nvim-treesitter-textobjects.swap")
						swap["swap_" .. direction](query)
					end,
					mode = "n",
					desc = D(desc),
				})
			end

			-- dir: "next" | "previous"
			-- pos: "start" | "end"
			local function map_move(lhs, dir, pos, query, desc, group)
				group = group or "textobjects"
				local fn_name = ("goto_%s_%s"):format(dir, pos) -- e.g. goto_next_start
				table.insert(keys, {
					lhs,
					function()
						local move = require("nvim-treesitter-textobjects.move")
						move[fn_name](query, group)
					end,
					mode = { "n", "x", "o" },
					desc = D(desc),
				})
			end

			local function map_repeat_key(lhs, fn_name, desc)
				table.insert(keys, {
					lhs,
					function()
						local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
						ts_repeat_move[fn_name]()
					end,
					mode = { "n", "x", "o" },
					desc = D(desc),
				})
			end

			local function map_builtin_repeat(lhs, fn_name, desc)
				table.insert(keys, {
					lhs,
					function(...)
						local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
						return ts_repeat_move[fn_name](...)
					end,
					mode = { "n", "x", "o" },
					expr = true,
					desc = D(desc),
				})
			end

			---------------------------------------------------------------------------
			-- SELECT (your original textobjects)
			---------------------------------------------------------------------------
			map_select("a=", "@assignment.outer", "Select outer part of an assignment")
			map_select("i=", "@assignment.inner", "Select inner part of an assignment")
			map_select("l=", "@assignment.lhs", "Select left hand side of an assignment")
			map_select("r=", "@assignment.rhs", "Select right hand side of an assignment")

			map_select("a:", "@property.outer", "Select outer part of a property")
			map_select("i:", "@property.inner", "Select inner part of a property")
			map_select("l:", "@property.lhs", "Select left part of a property")
			map_select("r:", "@property.rhs", "Select right part of a property")

			map_select("aa", "@parameter.outer", "Select outer part of a parameter/argument")
			map_select("ia", "@parameter.inner", "Select inner part of a parameter/argument")

			map_select("ai", "@conditional.outer", "Select outer part of a conditional")
			map_select("ii", "@conditional.inner", "Select inner part of a conditional")

			map_select("al", "@loop.outer", "Select outer part of a loop")
			map_select("il", "@loop.inner", "Select inner part of a loop")

			map_select("af", "@call.outer", "Select outer part of a function call")
			map_select("if", "@call.inner", "Select inner part of a function call")

			map_select("am", "@function.outer", "Select outer part of a method/function definition")
			map_select("im", "@function.inner", "Select inner part of a method/function definition")

			map_select("ac", "@class.outer", "Select outer part of a class")
			map_select("ic", "@class.inner", "Select inner part of a class")

			---------------------------------------------------------------------------
			-- SWAP
			---------------------------------------------------------------------------
			map_swap("<leader>na", "@parameter.inner", "next", "Swap parameter/argument with next")
			map_swap("<leader>n:", "@property.outer", "next", "Swap property with next")
			map_swap("<leader>nm", "@function.outer", "next", "Swap function with next")

			map_swap("<leader>pa", "@parameter.inner", "previous", "Swap parameter/argument with previous")
			map_swap("<leader>p:", "@property.outer", "previous", "Swap property with previous")
			map_swap("<leader>pm", "@function.outer", "previous", "Swap function with previous")

			---------------------------------------------------------------------------
			-- MOVE (goto_*), matching your original mappings
			---------------------------------------------------------------------------
			-- next start
			map_move("]f", "next", "start", "@call.outer", "Next function call start")
			map_move("]m", "next", "start", "@function.outer", "Next method/function def start")
			map_move("]l", "next", "start", "@loop.outer", "Next loop start")
			map_move("]s", "next", "start", "@local.scope", "Next scope", "locals")
			map_move("]z", "next", "start", "@fold", "Next fold", "folds")

			-- next end
			map_move("]F", "next", "end", "@call.outer", "Next function call end")
			map_move("]M", "next", "end", "@function.outer", "Next method/function def end")
			map_move("]C", "next", "end", "@class.outer", "Next class end")
			map_move("]I", "next", "end", "@conditional.outer", "Next conditional end")
			map_move("]L", "next", "end", "@loop.outer", "Next loop end")

			-- previous start
			map_move("[f", "previous", "start", "@call.outer", "Prev function call start")
			map_move("[m", "previous", "start", "@function.outer", "Prev method/function def start")
			map_move("[C", "previous", "start", "@class.outer", "Prev class start")
			map_move("[i", "previous", "start", "@conditional.outer", "Prev conditional start")
			map_move("[l", "previous", "start", "@loop.outer", "Prev loop start")

			-- previous end
			map_move("[F", "previous", "end", "@call.outer", "Prev function call end")
			map_move("[M", "previous", "end", "@function.outer", "Prev method/function def end")
			map_move("[C", "previous", "end", "@class.outer", "Prev class end")
			map_move("[I", "previous", "end", "@conditional.outer", "Prev conditional end")
			map_move("[L", "previous", "end", "@loop.outer", "Prev loop end")

			---------------------------------------------------------------------------
			-- REPEATABLE MOVE (; , and f/F/t/T)
			---------------------------------------------------------------------------
			map_repeat_key(";", "repeat_last_move_next", "Repeat last treesitter move (next)")
			map_repeat_key(",", "repeat_last_move_previous", "Repeat last treesitter move (prev)")

			map_builtin_repeat("f", "builtin_f_expr", "Repeatable f")
			map_builtin_repeat("F", "builtin_F_expr", "Repeatable F")
			map_builtin_repeat("t", "builtin_t_expr", "Repeatable t")
			map_builtin_repeat("T", "builtin_T_expr", "Repeatable T")

			return keys
		end)(),

		config = function()
			-- main-branch style: configure through this plugin, not nvim-treesitter.configs
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
					-- add selection_modes/include_surrounding_whitespace here if you want,
					-- following the main-branch README
				},
				move = {
					set_jumps = true,
				},
				-- swap doesn't currently need config; you just call swap_next/previous
			})
		end,
	},
	{
		"kevinhwang91/nvim-hlslens",
		keys = {
			{
				"<leader>l",
				"<cmd>noh<CR>",
				desc = "Hlslens: Clear highlights",
			},
			{
				"n",
				[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
				desc = "Hlslens: Next",
			},
			{
				"N",
				[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
				desc = "Hlslens: Previous",
			},
			{
				"*",
				[[*<Cmd>lua require('hlslens').start()<CR>]],
				desc = "Hlslens: Next",
			},
			{
				"#",
				[[#<Cmd>lua require('hlslens').start()<CR>]],
				desc = "Hlslens: Previous",
			},
			{
				"g*",
				[[g*<Cmd>lua require('hlslens').start()<CR>]],
				desc = "Hlslens: Next",
			},
			{
				"g#",
				[[g#<Cmd>lua require('hlslens').start()<CR>]],
				desc = "Hlslens: Previous",
			},
		},
		opts = {
			-- GPT custom hlsens display to add pattern
			override_lens = function(render, posList, nearest, idx, relIdx)
				local sfw = vim.v.searchforward == 1
				local indicator, text, chunks
				local absRelIdx = math.abs(relIdx)
				if absRelIdx > 1 then
					indicator = ("%d%s"):format(absRelIdx, sfw ~= (relIdx > 1) and "▲" or "▼")
				elseif absRelIdx == 1 then
					indicator = sfw ~= (relIdx == 1) and "▲" or "▼"
				else
					indicator = ""
				end

				local lnum, col = unpack(posList[idx])

				-- 🔍 current search pattern (what you typed after / or ?)
				local pattern = vim.fn.getreg("/")

				if nearest then
					local cnt = #posList
					if indicator ~= "" then
						text = ("[%s %d/%d]"):format(indicator, idx, cnt)
					else
						text = ("[%d/%d]"):format(idx, cnt)
					end
					chunks = {
						{ " " },
						{ text, "HlSearchLensNear" },
						{ (" %s"):format(pattern), "HlSearchLensNear" }, -- or your own hl group
					}
				else
					text = ("[%s %d]"):format(indicator, idx)
					chunks = {
						{ " " },
						{ text, "HlSearchLens" },
						{ (" %s"):format(pattern), "HlSearchLens" }, -- or another group
					}
				end

				render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
			end,
		},
	},
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("refactoring").setup()
			require("telescope").load_extension("refactoring")
		end,
		keys = {
			{
				"<leader>rr",
				function()
					require("telescope").extensions.refactoring.refactors()
				end,
				mode = { "n", "x" },
				desc = "Refactor: Telescope",
			},
		},
	},
}
