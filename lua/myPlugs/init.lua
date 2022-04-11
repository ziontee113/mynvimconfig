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

local function get_master_node()
	local node = ts_utils.get_node_at_cursor()
	if node == nil then
		error("No Treesitter parser found")
	end

	local root = ts_utils.get_root_for_node(node)

	local start_row = node:start()
	local parent = node:parent()

	while parent ~= nil and parent ~= root and parent:start() == start_row do
		-- print(node:type())
		node = parent
		parent = node:parent()
	end

	return node
end

M.select = function()
	local node = get_master_node()
	local bufnr = vim.api.nvim_get_current_buf()

	print(node:type())

	ts_utils.update_selection(bufnr, node)
end

M.move = function()
	local node = get_master_node()
	local bufnr = vim.api.nvim_get_current_buf()

	local prev_sibling = node:prev_sibling()

	ts_utils.swap_nodes(node, prev_sibling, bufnr, true)
end

vim.api.nvim_set_keymap("n", "vx", '<cmd>lua require("myPlugs").select()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "vu", '<cmd>lua require("myPlugs").move()<cr>', { noremap = true, silent = true })

return M
