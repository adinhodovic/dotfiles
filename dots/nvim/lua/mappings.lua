local vim = vim
local set = vim.opt
local g = vim.g

function default(val, default_val)
	if val == nil then
		return default_val
	else
		return val
	end
end

default_options = { noremap = true, silent = true }
default_options_expression = { noremap = true, silent = true, expr = true, replace_keycodes = false }

function map(mode, shortcut, command, options)
	options = default(options, default_options)
	vim.keymap.set(mode, shortcut, command, options)
end

function nmap(shortcut, command, options)
	map("n", shortcut, command, options)
end

function imap(shortcut, command, options)
	map("i", shortcut, command, options)
end

function vmap(shortcut, command, options)
	map("v", shortcut, command, options)
end

function xmap(shortcut, command, options)
	map("x", shortcut, command, options)
end

function omap(shortcut, command, options)
	map("o", shortcut, command, options)
end

function cmap(shortcut, command, options)
	map("c", shortcut, command, options)
end

-------------------------------------------
-- Moving around, tabs, windows and buffers
-------------------------------------------

-- Treat long lines as break lines (useful when moving around in them)
nmap("j", "gj")
nmap("k", "gk")

-- Disable highlight when <leader><cr> is pressed
nmap("<leader><cr>", ":noh<cr>")

-- Close the current buffer
nmap("<leader>bd", ":Bclose<cr>")
-- Close all the buffers
nmap("<leader>ba", ":1,1000 bd!<cr>")

nmap("q", "b")
vmap("q", "b")
-- Movement begin/end of line
nmap("Q", "^")
nmap("W", "g_")
nmap("$", "<nop>")
nmap("^", "<nop>")
nmap(":", "<nop>")

-- Window movements
imap("<C-h>", "<esc>:wincmd h<cr>")
imap("<C-l>", "<esc>:wincmd l<cr>")
imap("<C-j>", "<esc>:wincmd j<cr>")
imap("<C-k>", "<esc>:wincmd k<cr>")

nmap("<C-h>", "<esc>:wincmd h<cr>")
nmap("<C-l>", "<esc>:wincmd l<cr>")
nmap("<C-j>", "<esc>:wincmd j<cr>")
nmap("<C-k>", "<esc>:wincmd k<cr>")

nmap("<leader>q", "q")
-- Execute macro over a visual selection
xmap("<leader>q", ":'<,'>:normal @q<CR>")

nmap("<space>", ":")

-----------------------------------------
-- Base64
-----------------------------------------
vmap("<leader>b64e", ":<c-u>call base64#v_btoa()<cr>")
vmap("<leader>b64d", ":<c-u>call base64#v_atob()<cr>")

-----------------------------------------
-- Writing
-----------------------------------------
nmap("<F8>", ":<C-u>NextWordy<cr>")
xmap("<F8>", ":<C-u>NextWordy<cr>")
imap("<F8>", ":<C-o>NextWordy<cr>")

----------------------------------------
-- Linediff.vim
----------------------------------------
vmap("<leader>ld", ":Linediff<cr>")

-- -------------------------------------------
-- -- coc-git
-- -------------------------------------------
-- -- navigate chunks of current buffer
-- nmap("[g", "<Plug>(coc-git-prevchunk)")
-- nmap("]g", "<Plug>(coc-git-nextchunk)")
-- -- navigate conflicts of current buffer
-- nmap("[c", "<Plug>(coc-git-prevconflict)")
-- nmap("]c", "<Plug>(coc-git-nextconflict)")
-- -- show chunk diff at current position
-- nmap("<leader>gs", "<Plug>(coc-git-chunkinfo)")

----------------------------------------
-- Telescope.nvim
----------------------------------------
git_files_changed = function()
	local previewers = require("telescope.previewers")
	local pickers = require("telescope.pickers")
	local sorters = require("telescope.sorters")
	local finders = require("telescope.finders")

	pickers
		.new({
			results_title = "Modified on current branch",
			finder = finders.new_oneshot_job({ "/home/adin/.dotfiles/scripts/git-files-changed.sh", "list" }),
			sorter = sorters.get_fuzzy_file(),
			previewer = previewers.new_termopen_previewer({
				get_command = function(entry)
					return { "/home/adin/.dotfiles/scripts/git-files-changed.sh", "diff", entry.value }
				end,
			}),
		})
		:find()
end

nmap("b", ":e #<cr>")
local builtin = require("telescope.builtin")
nmap("-", builtin.buffers)
nmap("=", git_files_changed)
nmap("<M-=>", builtin.find_files)
nmap("<M-->", builtin.git_files)
nmap("<leader>fg", builtin.live_grep)
nmap("<leader>fh", builtin.help_tags)
nmap("<leader>fr", ":Telescope coc references<cr>")
nmap("<leader>fd", ":Telescope coc definitions<cr>")
nmap("<leader>fds", ":Telescope coc document_symbols<cr>")

----------------------------------------
-- Grammarous
----------------------------------------
nmap("<leader>gc", ":GrammarousCheck<CR>")
vmap("<leader>gc", ":GrammarousCheck<CR>")

----------------------------------------
-- Thesaurus_query.vim
----------------------------------------
vim.g.tq_map_keys = 0
nmap("<leader>tq", ":ThesaurusQueryReplaceCurrentWord<CR>")
vmap("<leader>tq", ":ThesaurusQueryReplaceCurrentWord<CR>")

-------------------------------------------
-- Markdown
-------------------------------------------
nmap("<leader>md", ":InstantMarkdownPreview<cr>")
nmap("<leader>ms", ":InstantMarkdownStop<cr>")

-------------------------------------------
-- Fugitive
-------------------------------------------
nmap("<leader>gb", ":GBrowse<cr>")
nmap("<leader>gl", ":Git log<cr>")
vmap("<leader>gb", ":GBrowse<cr>")

-------------------------------------------
-- Committia
-------------------------------------------
vim.cmd([[
  let g:committia_hooks = {}
  function! g:committia_hooks.edit_open(info)
      " Scroll the diff window from insert mode
      " Map <C-n> and <C-p>
      imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
      imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
  endfunction
]])

-------------------------------------------
-- Projects/Tree
-------------------------------------------
nmap("<leader>cd", ":Telescope projects<cr>")
nmap("<leader>ct", ":NvimTreeToggle<cr>")

-------------------------------------------
-- Delete/Paste text without copying
-------------------------------------------
nmap("<leader>d", '"_d')
xmap("<leader>d", '"_d')
nmap("<leader>dd", '"_dd')
xmap("<leader>dd", '"_dd')
xmap("<leader>p", '"_dP')

-------------------------------------------
-- MarkdownClipboardImage
-------------------------------------------
g.mdip_imgdir = "images"
nmap("<leader>mp", ":call mdip#MarkdownClipboardImage()<CR>")

-------------------------------------------
-- MRU
-------------------------------------------
nmap("<leader>mr", ":MRU<CR>")

-------------------------------------------
--  Spell checking
-------------------------------------------
-- Pressing ,se will toggle and untoggle spell checking
nmap("<leader>se", ":setlocal spell!<cr>")

-------------------------------------------
-- CarbonNowSh
-------------------------------------------
xmap("<F6>", ":CarbonNowSh<CR>")

-------------------------------------------
-- GitMessenger
-------------------------------------------
nmap("<leader>gm", ":GitMessenger <CR>")
g.git_messenger_include_diff = "current"

-------------------------------------------
-- Dap
-------------------------------------------
nmap("<F5>", function()
	require("dap").continue()
end)
nmap("<F10>", function()
	require("dap").step_over()
end)
nmap("<F11>", function()
	require("dap").step_into()
end)
nmap("<F12>", function()
	require("dap").step_out()
end)
nmap("<Leader>b", function()
	require("dap").toggle_breakpoint()
end)
nmap("<Leader>dr", function()
	require("dap").repl.open()
end)
nmap("<Leader>dl", function()
	require("dap").run_last()
end)
vmap("<Leader>b", function()
	require("dapui").eval()
end)
vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
	require("dap.ui.widgets").hover()
end)
vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
	require("dap.ui.widgets").preview()
end)
vim.keymap.set("n", "<Leader>df", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.frames)
end)
vim.keymap.set("n", "<Leader>ds", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end)
-------------------------------------------
-- Spectre
-------------------------------------------
nmap("<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
	desc = "Toggle Spectre",
})
nmap("<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
	desc = "Search current word",
})
vmap("<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
	desc = "Search current word",
})
nmap("<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
	desc = "Search on current file",
})
-------------------------------------------
-- Cybu
-------------------------------------------
nmap("[b", "<Plug>(CybuPrev)")
nmap("]b", "<Plug>(CybuNext)")
nmap("<s-tab>", "<plug>(CybuLastusedPrev)")
nmap("<tab>", "<plug>(CybuLastusedNext)")
