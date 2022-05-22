---@diagnostic disable: missing-parameter, empty-block

-- Imports & aliases ///1
local M = {
	opts = {
		disable_no_instance_found_report = false,
	},
}

local ts_utils = require("nvim-treesitter.ts_utils")

local api = vim.api
local ns = api.nvim_create_namespace("tree_testing_ns")

local current_desired_types = {
	"function",
	"if_statement",
	"else_clause",
	"else_statement",
	"elseif_statement",
	"for_statement",
	"while_statement",
	"switch_statement",
} -- default desired types
local current_syntax_nodes = {} -- hash table of nodes for each buffer, gets cleared when TextChanged event is triggered

-- Clear Namespace ///1
api.nvim_buf_clear_namespace(0, ns, 0, -1)

-- Utils (Getters) ///1
local function recursive_child_iter(node, table_to_insert, desired_types) -- ///2
	if node:iter_children() then
		for child in node:iter_children() do
			if desired_types then
				if vim.tbl_contains(desired_types, child:type()) then
					table.insert(table_to_insert, child)
				end
			else
				table.insert(table_to_insert, child)
			end

			recursive_child_iter(child, table_to_insert, desired_types)
		end
	end
end
local function filter_children_recursively(node, desired_types)
	local children = {}

	recursive_child_iter(node, children, desired_types)

	return children
end

local function get_nodes_in_array() -- ///2
	local ts = vim.treesitter
	local parser = ts.get_parser(0)
	local trees = parser:parse()
	local root = trees[1]:root()

	local current_buffer = vim.api.nvim_get_current_buf()
	local nodes = {}

	if current_syntax_nodes[current_buffer] then
		nodes = current_syntax_nodes[current_buffer]
	else
		recursive_child_iter(root, nodes)
		current_syntax_nodes[current_buffer] = nodes
	end

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

local function filter_sibling_nodes(node, desired_types) -- ///2
	local current_node_id = node:id()
	local parent = node:parent()
	local return_nodes = {}

	for child in parent:iter_children() do
		if child:id() ~= current_node_id then
			local node_type = child:type()

			if vim.tbl_contains(desired_types, node_type) then
				table.insert(return_nodes, child)
			end
		end
	end

	return return_nodes
end

local function filter_nearest_parent(node, desired_types) -- ///2
	if node:parent() then
		local parent = node:parent()
		local parent_type = parent:type()

		if vim.tbl_contains(desired_types, parent_type) then
			return parent
		else
			return filter_nearest_parent(parent, desired_types)
		end
	else
		return nil
	end
end

local function get_parent_nodes(node, desired_types) -- ///2
	local parents = {}

	while node:parent() do
		node = node:parent()
		local node_type = node:type()

		if vim.tbl_contains(desired_types, node_type) then
			table.insert(parents, node)
		end
	end

	return parents
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

local function set_extmark_then_delete_it(start_row, start_col, contents, color_group, timeout) -- ///2
	if start_col <= 0 then
		start_col = 1
	end

	local extmark_id = api.nvim_buf_set_extmark(0, ns, start_row, start_col - 1, {
		virt_text = { { contents, color_group } },
		virt_text_pos = "overlay",
	})

	local timer = vim.loop.new_timer()
	timer:start(
		timeout,
		timeout,
		vim.schedule_wrap(function()
			api.nvim_buf_del_extmark(0, ns, extmark_id)
		end)
	)

	return extmark_id
end
-- Possible Keymaps for jumping ///1
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

local function go_to_next_instance(desired_types, forward, opts) -- ///2
	-- get nodes to operate on
	local nodes = get_nodes_in_array()

	-- get cursor position
	local current_window = api.nvim_get_current_win()
	local current_line = vim.api.nvim_win_get_cursor(current_window)[1]

	-- set up variables
	local previous_closest_node = nil
	local next_closest_node = nil
	local previous_closest_node_line = nil
	local next_closest_node_line = nil

	local previous_closest_node_index = nil
	local next_closest_node_index = nil

	if nodes then
		-- filter the nodes based on the opts
		if opts then
			local current_node = ts_utils.get_node_at_cursor(current_window)

			if opts.destination == "parent" then
				nodes = get_parent_nodes(current_node, desired_types)
				previous_closest_node = nodes[1]
				previous_closest_node_index = 1
			end

			if opts.destination == "children" then
				nodes = filter_children_recursively(current_node, desired_types)
			end

			if opts.destination == "siblings" then
				nodes = filter_sibling_nodes(current_node, desired_types)

				if #nodes == 0 then
					nodes = {}
					-- if the current node type is in desired_types, then don't filter
					if not vim.tbl_contains(desired_types, current_node:type()) then
						previous_closest_node = filter_nearest_parent(current_node, desired_types)
						previous_closest_node_index = 1
					end
				end
			end
		else
			nodes = get_desired_nodes(nodes, desired_types)
		end

		-- find closest nodes before & after cursor
		for index, node in ipairs(nodes) do
			local start_row, start_col, end_row, end_col = node:range()

			if start_row + 1 < current_line then
				if previous_closest_node == nil then
					previous_closest_node = node
					previous_closest_node_line = start_row
					previous_closest_node_index = index
				elseif previous_closest_node_line and start_row > previous_closest_node_line then
					previous_closest_node = node
					previous_closest_node_index = index
				end
			elseif start_row + 1 > current_line then
				if next_closest_node == nil then
					next_closest_node = node
					next_closest_node_line = start_row
					next_closest_node_index = index
				elseif next_closest_node_line and start_row < next_closest_node_line then
					next_closest_node = node
					next_closest_node_index = index
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

	-- if there is no next instance, print message
	if not cursor_moved then
		if not M.opts.disable_no_instance_found_report then
			if forward then
				print("No next instance found")
			else
				print("No previous instance found")
			end
		end
	else -- if cursor moved
		if not opts then
			if forward then
				while next_closest_node_index + 1 <= #nodes do
					local start_row, start_col, end_row, end_col = nodes[next_closest_node_index + 1]:range()
					next_closest_node_index = next_closest_node_index + 1
					set_extmark_then_delete_it(start_row, start_col, "", "DapUIScope", 800)
				end
			else
				while previous_closest_node_index - 1 >= 1 do
					local start_row, start_col, end_row, end_col = nodes[previous_closest_node_index - 1]:range()
					previous_closest_node_index = previous_closest_node_index - 1
					set_extmark_then_delete_it(start_row, start_col, "", "DapUIScope", 800)
				end
			end
		end
	end
end

-- Setup Function ///1
M.setup = function(opts)
	if opts.default_desired_types then
		current_desired_types = opts.default_desired_types
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

-- jump with virt_text
vim.keymap.set("n", "gj", function()
	print_types({ "function", "if_statement", "for_statement", "switch_statement", "while_statement" })
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

-- jump with desired_types
vim.keymap.set("n", "-", function()
	go_to_next_instance({ "if_statement", "else_clause", "else_statement" }, false, { destination = "siblings" })
end, opts)
vim.keymap.set("n", "=", function()
	go_to_next_instance({ "if_statement", "else_clause", "else_statement" }, true, { destination = "siblings" })
end, opts)
vim.keymap.set("n", "_", function()
	go_to_next_instance({ "if_statement", "else_clause", "else_statement" }, false, { destination = "parent" })
end, opts)
vim.keymap.set("n", "+", function()
	go_to_next_instance({ "if_statement", "else_clause", "else_statement" }, true, { destination = "children" })
end, opts)

vim.keymap.set("n", "<A-n>", function()
	go_to_next_instance(current_desired_types, true)
	vim.schedule(function()
		vim.cmd("norm! zO")
		-- vim.cmd("norm! zz")
	end)
end, opts)
vim.keymap.set("n", "<A-p>", function()
	go_to_next_instance(current_desired_types, false)
	vim.schedule(function()
		vim.cmd("norm! zO")
		-- vim.cmd("norm! zz")
	end)
end, opts)

-- show & clear messages
vim.keymap.set("n", " me", ":messages<cr>", opts)
vim.keymap.set("n", " mc", ":messages clear<cr>", opts)

-- TODOS: ///1
-- TODO: differenciate named functions and unamed functions
-- TODO:: make the .setup() function
-- TODO: make functionalities for jump up / down level / siblings
--> TODO: jump sublings & up is fine, the problem is jump down, we need to get the tree from the current node and then jump

-- vim: foldmethod=marker foldmarker=///,//>
