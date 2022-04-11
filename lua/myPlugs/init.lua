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

	-- print(node:type())

	ts_utils.update_selection(bufnr, node)
end

M.move = function(mode, up)
	local node = get_master_node()
	local bufnr = vim.api.nvim_get_current_buf()

	local target = node:next_named_sibling()
	if up == true then
		target = node:prev_named_sibling()
	end

	ts_utils.swap_nodes(node, target, bufnr, true)

	if mode == "v" then
		ts_utils.update_selection(bufnr, target)
		ts_utils.update_selection(bufnr, target)
	end
end

M.peek = function(up, mode)
	local node = get_master_node()
	local bufnr = vim.api.nvim_get_current_buf()

	local target = node:next_named_sibling()
	if up == true then
		target = node:prev_named_sibling()
	end

	if target ~= nil then
		P({ node:type(), target:type() })

		ts_utils.update_selection(bufnr, target)
		if mode == "v" then
			ts_utils.update_selection(bufnr, target)
		end
	end
end

vim.api.nvim_set_keymap("n", "vx", '<cmd>lua require("myPlugs").select()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "vu", '<cmd>lua require("myPlugs").move("n", true)<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"n",
	"vd",
	'<cmd>lua require("myPlugs").move("n", false)<cr>',
	{ noremap = true, silent = true }
)

-- Alt Cursor Movement Mappings - Visual Mode
vim.api.nvim_set_keymap(
	"x",
	"<A-k>",
	'<cmd>lua require("myPlugs").move("v", true)<cr>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"x",
	"<A-j>",
	'<cmd>lua require("myPlugs").move("v", false)<cr>',
	{ noremap = true, silent = true }
)

-- Peek
vim.api.nvim_set_keymap("n", "vh", '<cmd>lua require("myPlugs").peek(true)<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "vl", '<cmd>lua require("myPlugs").peek(false)<cr>', { noremap = true, silent = true })
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
