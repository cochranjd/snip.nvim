local M = {}

local function create_and_open_file()
	-- Get the directory where the file will be created
	local directory = vim.fn.expand("~/snippets/")

	-- Get user input for the file name
	local topic = vim.fn.input("Enter the topic: ")
	if topic == "" then
		print("No file name entered.")
		return
	end

	-- Combine directory and file name to get the full path
	local file_name = string.gsub(topic, " ", "-")
	file_name = string.lower(file_name)
	local file_path = directory .. file_name .. ".md"

	-- Create the file
	local file = io.open(file_path, "w")
	if file then
		file:write("# " .. topic .. "\n\n\n")
		file:close()
	else
		print("Error creating file: " .. file_path)
		return
	end

	-- Open the file in a buffer
	vim.cmd("edit " .. file_path)

	-- Set the cursor to the last line of the file
	local buf = vim.api.nvim_get_current_buf()
	local line_count = vim.api.nvim_buf_line_count(buf)
	vim.api.nvim_win_set_cursor(0, { line_count, 0 })
end

function M.create_snippet()
	create_and_open_file()
end

return M
