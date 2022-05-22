---@diagnostic disable: missing-parameter, unused-local, empty-block

-- Imports & aliases ///1
local api = vim.api
local ns = api.nvim_create_namespace("tree_testing_ns")

local current_desired_types = nil
local current_syntax_nodes = {}

-- Clear Namespace ///1
api.nvim_buf_clear_namespace(0, ns, 0, -1)

-- Utils (Getters) ///1
local function get_nodes_in_array() -- ///2
	local ts = vim.treesitter
	local parser = ts.get_parser(0)
	local trees = parser:parse()
	local root = trees[1]:root()

	local nodes = {}

	local function recursive_child_iter(node)
		if node:iter_children() then
			for child in node:iter_children() do
				table.insert(nodes, child)
				recursive_child_iter(child)
			end
		end
	end

	recursive_child_iter(root)

	local current_buffer = vim.api.nvim_get_current_buf()
	current_syntax_nodes[current_buffer] = nodes

	return nodes
end

local function get_desired_nodes(nodes, desired_types) -- ///2
	-- get current cursor position
	local return_nodes = {}

	-- loop through nodes
	for i = 1, #nodes do
		local node = nodes[i]
		local node_type = node:type()
		local start_row, start_col, end_row, end_col = node:range()

		-- if node_type is in desired_types, add to return_nodes
		if vim.tbl_contains(desired_types, node_type) then
			table.insert(return_nodes, node)
		end
	end

	return return_nodes
end

-- helper function [has_value] ///2
local function has_value(tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

-- Dictionary Declaration ///1
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
local left_hand_side = "fdsawervcxqtzb"
left_hand_side = vim.split(left_hand_side, "")
local right_hand_side = "jkl;oiu.,mpy/n"
right_hand_side = vim.split(right_hand_side, "")

-- Functions to Execute ///1
local function print_types(desired_types) -- ///2
	current_desired_types = desired_types

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
		elseif start_row + 1 > current_line then
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

local function go_to_next_instance(desired_types, forward) -- ///2
	-- get nodes to operate on
	local current_buffer = vim.api.nvim_get_current_buf()
	local nodes = nil
	if current_syntax_nodes[current_buffer] then
		nodes = current_syntax_nodes[current_buffer]
	else
		nodes = get_nodes_in_array()
	end

	-- get cursor position
	local current_window = api.nvim_get_current_win()
	local current_line = vim.api.nvim_win_get_cursor(current_window)[1]

	-- set up variables
	local previous_closest_node = nil
	local next_closest_node = nil
	local previous_closest_node_line = nil
	local next_closest_node_line = nil

	if nodes then
		nodes = get_desired_nodes(nodes, desired_types)

		-- find closest nodes before & after cursor
		for _, node in ipairs(nodes) do
			local start_row, start_col, end_row, end_col = node:range()

			if start_row + 1 < current_line then
				if previous_closest_node == nil then
					previous_closest_node = node
					previous_closest_node_line = start_row
				elseif previous_closest_node_line and start_row > previous_closest_node_line then
					previous_closest_node = node
				end
			elseif start_row + 1 > current_line then
				if next_closest_node == nil then
					next_closest_node = node
					next_closest_node_line = start_row
				elseif previous_closest_node_line and start_row < previous_closest_node_line then
					next_closest_node = node
				end
			end
		end
	end

	-- depends on forward or not, set cursor to closest node
	local cursor_moved = false
	if forward then
		if next_closest_node then
			local start_row, start_col, end_row, end_col = next_closest_node:range()
			vim.api.nvim_win_set_cursor(current_window, { start_row + 1, start_col })
			cursor_moved = true
		end
	else
		if previous_closest_node then
			local start_row, start_col, end_row, end_col = previous_closest_node:range()
			vim.api.nvim_win_set_cursor(current_window, { start_row + 1, start_col })
			cursor_moved = true
		end
	end

	if not cursor_moved then
		if forward then
			print("No next instance found")
		else
			print("No previous instance found")
		end
	end
end

-- Autocmds ///1
local augroup = vim.api.nvim_create_augroup("STS_augroup", { clear = true })
vim.api.nvim_create_autocmd({
	"TextChanged",
	--[[ "TextChangedI" ]]
}, {
	buffer = 0,
	group = augroup,
	callback = function()
		local current_buffer = vim.api.nvim_get_current_buf()
		current_syntax_nodes[current_buffer] = nil
	end,
})

-- Mappings ///1
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
	local current_buffer = vim.api.nvim_get_current_buf()
	go_to_next_instance(current_desired_types, true)
end, opts)
vim.keymap.set("n", "<A-p>", function()
	local current_buffer = vim.api.nvim_get_current_buf()
	go_to_next_instance(current_desired_types, false)
end, opts)

-- vim: foldmethod=marker foldmarker=///,//>

-- TODOS: ///1
-- TODO: differenciate named functions and unamed functions
-- TODO: add virt_text
-- TODO: make snippets for: [TODO comments, if_statements, for_statements]
-- TODO: make functionalities for jump up / down level / siblings
