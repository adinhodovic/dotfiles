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
