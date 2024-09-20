local vim = vim

-- :lua print(vim.inspect(get_all_buffer_filetypes()))
-- util for debugging
function get_all_buffer_filetypes()
	local buffer_filetypes = {}
	-- Iterate over all buffers
	for buf = 1, vim.fn.bufnr("$") do
		-- Check if the buffer exists
		if vim.api.nvim_buf_is_loaded(buf) then
			-- Get the filetype of the buffer
			local filetype = vim.api.nvim_buf_get_option(buf, "filetype")
			-- Add the filetype to the list if it's not empty
			if filetype ~= "" then
				table.insert(buffer_filetypes, filetype)
			end
		end
	end
	return buffer_filetypes
end

function get_default_branch_name()
	local res = vim.system({ "git", "rev-parse", "--verify", "main" }, { capture_output = true }):wait()
	return res.code == 0 and "main" or "master"
end

-- Define a Lua function for the custom Sol command
function RunSol()
	-- Run the external command `sol` on the selected text
	vim.cmd("'<,'>!sol -p -c -b -r -a -s -jqobj -jqarr -jqop comma")
end

-- Bind the command to visual mode (x mode)
vim.api.nvim_set_keymap("x", "<leader>sol", ":lua RunSol()<CR>", { noremap = true, silent = true })
