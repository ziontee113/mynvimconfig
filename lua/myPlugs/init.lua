local ts_utils = require("nvim-treesitter.ts_utils")

local M = {}

M.select_current_node = function()
	local node = ts_utils.get_node_at_cursor()
	local bufnr = vim.api.nvim_get_current_buf()

	if node ~= nil then
		ts_utils.update_selection(bufnr, node)
	end
end

local function find_range_from_2nodes(nodeA, nodeB)
	local start_row_A, start_col_A, end_row_A, end_col_A = nodeA:range()
	local start_row_B, start_col_B, end_row_B, end_col_B = nodeB:range()

	local true_range = {}

	if start_row_A == start_row_B then
		if start_col_A < start_col_B then
			table.insert(true_range, start_row_A)
			table.insert(true_range, start_col_A)
		else
			table.insert(true_range, start_row_B)
			table.insert(true_range, start_col_B)
		end
	end

	if start_row_A < start_row_B then
		table.insert(true_range, start_row_A)
		table.insert(true_range, start_col_A)
	elseif start_row_A > start_row_B then
		table.insert(true_range, start_row_B)
		table.insert(true_range, start_col_B)
	end

	if end_row_A == end_row_B then
		if end_col_A > end_col_B then
			table.insert(true_range, end_row_A)
			table.insert(true_range, end_col_A)
		else
			table.insert(true_range, end_row_B)
			table.insert(true_range, end_col_B)
		end
	end
	if end_row_A > end_row_B then
		table.insert(true_range, end_row_A)
		table.insert(true_range, end_col_A)
	elseif end_row_A < end_row_B then
		table.insert(true_range, end_row_B)
		table.insert(true_range, end_col_B)
	end

	return true_range
end

M.select_sibling_node = function(direction, mode)
	local node = ts_utils.get_node_at_cursor() -- declare node and bufnr
	local bufnr = vim.api.nvim_get_current_buf()

	if node == nil then -- prevent errors
		return
	end

	if mode == "visual" then
		local nodeA = node
		vim.cmd("normal! o")
		local nodeB = ts_utils.get_node_at_cursor()
		vim.cmd("normal! o")

		if nodeA:id() ~= nodeB:id() then --> get the true node
			local true_range = find_range_from_2nodes(nodeA, nodeB)
			local parent = nodeA:parent()
			local start_row_P, start_col_P, end_row_P, end_col_P = parent:range()

			while
				start_row_P ~= true_range[1]
				or start_col_P ~= true_range[2]
				or end_row_P ~= true_range[3]
				or end_col_P ~= true_range[4]
			do
				parent = parent:parent()
				start_row_P, start_col_P, end_row_P, end_col_P = parent:range()
			end

			node = parent
		end
	end

	local parent = node:parent() --> if parent only has 1 child, move up the tree
	while parent:named_child_count() == 1 do
		node = parent
		parent = node:parent()
	end

	local target --> setting the target, depending on the direction
	if direction == "parent" then
		target = node:parent()
	elseif direction == "child" and node ~= nil then
		while node ~= nil do
			if node:named_child_count() >= 2 then
				target = node:named_child(0)
				break
			end
			node = node:named_child(0)
		end
	else
		target = node:next_named_sibling() -- naively look for next or prev sibling based on direction
		if direction == "prev" then
			target = node:prev_named_sibling()
		end

		while target ~= nil and target:type() == "comment" do -- skip over the comments because how comments are treated in Treesitter
			if direction == "prev" then
				target = target:prev_named_sibling()
			else
				target = target:next_named_sibling()
			end
		end
	end

	if target ~= nil then
		ts_utils.update_selection(bufnr, target) --> make the selection
		if mode == "visual" then
			ts_utils.update_selection(bufnr, target)
		end
	end
end

local function get_master_node(block_check, custom_node)
	local node = ts_utils.get_node_at_cursor()
	if node == nil then
		error("No Treesitter parser found")
	end

	if custom_node ~= nil then
		node = custom_node
	end

	local root = ts_utils.get_root_for_node(node)

	local start_row = node:start()
	local parent = node:parent()

	while parent ~= nil and parent ~= root and parent:start() == start_row do
		if block_check and parent:type() == "block" then
			break
		end

		node = parent
		parent = node:parent()
		-- print(node:type())
	end

	return node
end

M.select = function()
	local node = get_master_node()
	local bufnr = vim.api.nvim_get_current_buf()

	-- print(node:type())

	ts_utils.update_selection(bufnr, node)
end

M.move = function(mode, up)
	local node = get_master_node(true)
	local bufnr = vim.api.nvim_get_current_buf()

	local target
	if up == true then
		target = node:prev_named_sibling()
	else
		target = node:next_named_sibling()
	end

	if target == nil then
		return
	end

	while target:type() == "comment" do
		if up == true then
			target = target:prev_named_sibling()
		else
			target = target:next_named_sibling()
		end
	end

	if target ~= nil then
		ts_utils.swap_nodes(node, target, bufnr, true)

		if mode == "v" then
			target = ts_utils.get_node_at_cursor()
			ts_utils.update_selection(bufnr, target)
			ts_utils.update_selection(bufnr, target)
		end
	end
end

M.peek = function(up, mode)
	local node = get_master_node(true)
	local bufnr = vim.api.nvim_get_current_buf()

	local target
	if up == true then
		target = node:prev_named_sibling()
	else
		target = node:next_named_sibling()
	end

	if target == nil then
		return
	end

	while target:type() == "comment" do
		if up == true then
			target = target:prev_named_sibling()
		else
			target = target:next_named_sibling()
		end
	end

	if target ~= nil then
		ts_utils.update_selection(bufnr, target)
		if mode == "v" then
			ts_utils.update_selection(bufnr, target)
		end
	end
end

-- Experimental Mappings
vim.api.nvim_set_keymap(
	"n",
	"vn",
	'<cmd>lua require("myPlugs").select_current_node("n")<cr>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"vk",
	'<cmd>lua require("myPlugs").select_sibling_node("next")<cr>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"vj",
	'<cmd>lua require("myPlugs").select_sibling_node("prev")<cr>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap( -- visual mode
	"x",
	"J",
	'<cmd>lua require("myPlugs").select_sibling_node("next", "visual")<cr>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"x",
	"K",
	'<cmd>lua require("myPlugs").select_sibling_node("prev", "visual")<cr>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap( -- visual mode
	"x",
	"H",
	'<cmd>lua require("myPlugs").select_sibling_node("parent", "visual")<cr>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"x",
	"L",
	'<cmd>lua require("myPlugs").select_sibling_node("child", "visual")<cr>',
	{ noremap = true, silent = true }
)

-- Move with C-k and C-j
vim.api.nvim_set_keymap(
	"x",
	"<A-j>",
	'<cmd>lua require("myPlugs").move("v", false)<cr>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"x",
	"<A-k>",
	'<cmd>lua require("myPlugs").move("v", true)<cr>',
	{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap("n", "vx", '<cmd>lua require("myPlugs").select()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "vu", '<cmd>lua require("myPlugs").move("n", true)<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"n",
	"vd",
	'<cmd>lua require("myPlugs").move("n", false)<cr>',
	{ noremap = true, silent = true }
)

-- Peek
-- vim.api.nvim_set_keymap("n", "vh", '<cmd>lua require("myPlugs").peek(true)<cr>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "vl", '<cmd>lua require("myPlugs").peek(false)<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"x",
	"<A-h>",
	'<cmd>lua require("myPlugs").peek(true, "v")<cr>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"x",
	"<A-l>",
	'<cmd>lua require("myPlugs").peek(false, "v")<cr>',
	{ noremap = true, silent = true }
)

return M
