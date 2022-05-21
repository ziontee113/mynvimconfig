---@diagnostic disable: missing-parameter, unused-local

-- Imports & aliases
local api = vim.api
local ns = api.nvim_create_namespace("tree_testing_ns")

-- clear namespace
api.nvim_buf_clear_namespace(0, ns, 0, -1)

-- utils
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

-- helper function
local function has_value(tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

-- dictionary declaration
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

-- possible keymaps
local left_hand_side = "fdswervcxqt"
left_hand_side = vim.split(left_hand_side, "")
local right_hand_side = "jkloiupy"
right_hand_side = vim.split(right_hand_side, "")

-- function to execute
local function print_types(desired_types)
	local nodes = get_nodes_in_array()

	local current_window = api.nvim_get_current_win()
	local current_line = vim.api.nvim_win_get_cursor(current_window)[1]

	local nodes_before_cursor = {}
	local nodes_after_cursor = {}

	local hash_table = {}

	for _, node in ipairs(nodes) do
		local start_row, start_col, end_row, end_col = node:range()

		if start_row + 1 < current_line then
			table.insert(nodes_before_cursor, node)
		elseif start_row > current_line then
			table.insert(nodes_after_cursor, node)
		end
	end

	local color_group = "DapUIScope"

	-- loop backwards through nodes_before_cursor
	local count = 1
	for i = #nodes_before_cursor, 1, -1 do
		local node = nodes_before_cursor[i]
		local node_type = node:type()
		local start_row, start_col, end_row, end_col = node:range()

		if not left_hand_side[count] then
			break
		end

		if has_value(desired_types, node_type) then
			api.nvim_buf_set_extmark(0, ns, start_row, start_col - 1, {
				virt_text = { { left_hand_side[count], color_group } },
				virt_text_pos = "overlay",
			})

			api.nvim_buf_set_extmark(0, ns, start_row, -1, {
				virt_text = { { " " .. left_hand_side[count] .. " <-- " .. node_type, color_group } },
				virt_text_pos = "overlay",
			})

			hash_table[left_hand_side[count]] = {}
			hash_table[left_hand_side[count]].start_row = start_row
			hash_table[left_hand_side[count]].start_col = start_col

			count = count + 1
		end
	end

	count = 1
	for i = 1, #nodes_after_cursor do
		local node = nodes_after_cursor[i]
		local node_type = node:type()
		local start_row, start_col, end_row, end_col = node:range()

		if not right_hand_side[count] then
			break
		end

		if has_value(desired_types, node_type) then
			api.nvim_buf_set_extmark(0, ns, start_row, start_col - 1, {
				virt_text = { { right_hand_side[count], color_group } },
				virt_text_pos = "overlay",
			})

			api.nvim_buf_set_extmark(0, ns, start_row, -1, {
				virt_text = { { " " .. right_hand_side[count] .. " <-- " .. node_type, color_group } },
				virt_text_pos = "overlay",
			})

			hash_table[right_hand_side[count]] = {}
			hash_table[right_hand_side[count]].start_row = start_row
			hash_table[right_hand_side[count]].start_col = start_col

			count = count + 1
		end
	end

	vim.cmd([[redraw]])

	local ok, keynum = pcall(vim.fn.getchar)
	if ok then
		local key = string.char(keynum)
		if hash_table[key] then
			local start_row = hash_table[key].start_row + 1
			local start_col = hash_table[key].start_col

			vim.api.nvim_win_set_cursor(current_window, { start_row, start_col })
		end
	end

	api.nvim_buf_clear_namespace(0, ns, 0, -1)
end

-- mappings
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "gj", function()
	print_types({ "function", "if_statement", "for_statement" })
end, opts)
vim.keymap.set("n", "gv", function()
	print_types({ "variable_declaration" })
end, opts)
vim.keymap.set("n", "gfu", function()
	print_types({ "function" })
end, opts)
vim.keymap.set("n", "gif", function()
	print_types({ "if_statement" })
end, opts)
vim.keymap.set("n", "gfo", function()
	print_types({ "for_statement" })
end, opts)

vim.keymap.set("n", " me", ":messages<cr>", opts)
vim.keymap.set("n", " mc", ":messages clear<cr>", opts)
vim.keymap.set("n", "<A-n>", function()
	print("+")
end, opts)
vim.keymap.set("n", "<A-p>", function()
	print("-")
end, opts)
