---@diagnostic disable: missing-parameter
local api = vim.api
local ns = api.nvim_create_namespace("tree_testing_ns")

-- clear namespace
api.nvim_buf_clear_namespace(0, ns, 0, -1)

local function get_nodes_in_array()
	local ts = vim.treesitter
	local parser = ts.get_parser(0)
	local trees = parser:parse()
	local root = trees[1]:root()

	local nodes = {}

	local function recursive_child_iter(node)
		if node:iter_children() then
			for child in node:iter_children() do
				-- do something with the child (if we want tod)

				table.insert(nodes, child)
				recursive_child_iter(child)
			end
		end
	end

	recursive_child_iter(root)

	return nodes
end

-- loop through nodes and print their type
local function print_types()
	local nodes = get_nodes_in_array()
	local desired_types = { "function", "variable_declaration", "if_statement", "for_statement" }
	local desired_aliases = { "F", "v", "I", "F" }

	vim.cmd([[:messages clear]])
	for _, node in ipairs(nodes) do
		print(node:type())

		-- loop through desired_types
		for index, desired_type in ipairs(desired_types) do
			if node:type() == desired_type then
				---@diagnostic disable-next-line: unused-local
				local start_row, start_col, end_row, end_col = node:range()

				local alias = desired_aliases[index]

				api.nvim_buf_set_extmark(0, ns, start_row, start_col, {
					virt_text = { { alias, "DapUIScope" } },
					virt_text_pos = "overlay",
				})
			end
		end
	end
end

local opts = { noremap = true, silent = true }
vim.keymap.set("n", " pt", function()
	print_types()
end, opts)

vim.keymap.set("n", " me", ":messages<cr>", opts)
vim.keymap.set("n", " mc", ":messages clear<cr>", opts)
