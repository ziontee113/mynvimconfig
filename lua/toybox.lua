local M = {}

local api = vim.api
local ns = api.nvim_create_namespace("me.tsnode") --  NOTE: nvim_create_namespace

function M.nodes()
	print("copium")
	-- api.nvim_buf_clear_namespace(0, ns, 0, -1) --  NOTE: nvim_buf_clear_namespace

	--  NOTE: nvim_buf_add_highlight
	-- api.nvim_buf_add_highlight(0, ns, "TSNodeUnmatched", 0 - 1, 0, -1)
end

return M
