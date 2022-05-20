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

-- helper function has_value
local function has_value(tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

-- loop through nodes and print their type
local dictionary = {
	["function"] = {
		color_group = "DapUIScope",
		alias = "F",
	},
	["variable_declaration"] = {
		color_group = "DapUIScope",
		alias = "v",
	},
	["if_statement"] = {
		color_group = "DapUIScope",
		alias = "I",
	},
	["for_statement"] = {
		color_group = "DapUIScope",
		alias = "F",
	},
}
local function print_types(desired_types)
	local nodes = get_nodes_in_array()

	vim.cmd([[:messages clear]])
	for _, node in ipairs(nodes) do
		local node_type = node:type()
		print(node_type)

		-- check if the node type is in the desired_types
		if has_value(desired_types, node_type) then
			local color_group = dictionary[node_type].color_group
			local alias = dictionary[node_type].alias
			---@diagnostic disable-next-line: unused-local
			local start_row, start_col, end_row, end_col = node:range()

			api.nvim_buf_set_extmark(0, ns, start_row, start_col, {
				virt_text = { { alias, color_group } },
				virt_text_pos = "overlay",
			})
		end
	end
end

local opts = { noremap = true, silent = true }
vim.keymap.set("n", " pt", function()
	print_types({ "variable_declaration" })
end, opts)

vim.keymap.set("n", " me", ":messages<cr>", opts)
vim.keymap.set("n", " mc", ":messages clear<cr>", opts)
