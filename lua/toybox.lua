local M = {}

local api = vim.api
local ns = api.nvim_create_namespace("me.tsnode") --  NOTE: nvim_create_namespace

function M.nodes()
	print("toybox.nodes() executed")
	api.nvim_buf_clear_namespace(0, ns, 0, -1) --  NOTE: nvim_buf_clear_namespace

	--  NOTE: nvim_buf_add_highlight
	api.nvim_buf_add_highlight(0, ns, "GruvboxOrange", 2, 0, -1)

	--  NOTE: nvim_buf_set_extmark
	-- find about this nvim_buf_set_extmark method
end

vim.keymap.set("n", "<Leader>x", function()
	M.nodes()
end, { noremap = true })

return M
