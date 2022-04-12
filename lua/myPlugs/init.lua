local ts_utils = require("nvim-treesitter.ts_utils")

local M = {}

local copilot_suggested = function()
	local node = ts_utils.get_node_at_cursor()

	if node ~= nil then
		local parent = node:parent()
		if parent ~= nil then
			local parent_type = parent:type()
			if parent_type == "function" or parent_type == "method" then
				return "lua"
			end
		end
	end
end

M.select_current_node = function()
	local node = ts_utils.get_node_at_cursor()
	local bufnr = vim.api.nvim_get_current_buf()

	if node ~= nil then
		ts_utils.update_selection(bufnr, node)
	end
end

M.select_sibling_node = function(direction, mode)
	local node = ts_utils.get_node_at_cursor()
	local bufnr = vim.api.nvim_get_current_buf()

	local target = node:next_named_sibling()
	if direction == "prev" then
		target = node:prev_named_sibling()
	end

	if target ~= nil then
		ts_utils.update_selection(bufnr, target)
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
	"vj",
	'<cmd>lua require("myPlugs").select_sibling_node("next")<cr>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"vk",
	'<cmd>lua require("myPlugs").select_sibling_node("prev")<cr>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap( -- visual mode
	"x",
	"j",
	'<cmd>lua require("myPlugs").select_sibling_node("next", "visual")<cr>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"x",
	"k",
	'<cmd>lua require("myPlugs").select_sibling_node("prev", "visual")<cr>',
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
