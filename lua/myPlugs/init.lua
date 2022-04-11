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

	local start_row = node:start()
	local parent = node:parent()

	while parent ~= nil and parent:start() == start_row do
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

vim.api.nvim_set_keymap("n", "vx", '<cmd>lua require("myPlugs").select()<cr>', { noremap = true, silent = true })

return M
