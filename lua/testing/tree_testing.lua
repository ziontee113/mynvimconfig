---@diagnostic disable: missing-parameter
local api = vim.api

local function get_nodes_in_array()
	local ts = vim.treesitter
	local parser = ts.get_parser(0)
	local trees = parser:parse()
	local root = trees[1]:root()

	local nodes = {}

	local function recursive_child_iter(node)
		if node:iter_children() then
			for child in node:iter_children() do
				P(child:type())
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

	for _, node in ipairs(nodes) do
		print(node:type())
	end
end

local opts = { noremap = true, silent = true }
vim.keymap.set("n", " pt", function()
	print_types()
end, opts)

vim.keymap.set("n", " me", ":messages<cr>", opts)
vim.keymap.set("n", " mc", ":messages clear<cr>", opts)
