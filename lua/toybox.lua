local M = {}

local api = vim.api --{{{
local ns = api.nvim_create_namespace("me.tsnode") --  NOTE: nvim_create_namespace

function M.nodes()
	api.nvim_buf_clear_namespace(0, ns, 0, -1) --  NOTE: nvim_buf_clear_namespace

	-- local win_info = vim.fn.getwininfo(api.nvim_get_current_win())[1]
	-- for i = win_info.topline, win_info.botline do
	-- 	api.nvim_buf_add_highlight(0, ns, "TSNodeUnmatched", i - 1, 0, -1)
	-- end

	--  NOTE: nvim_buf_add_highlight
	-- api.nvim_buf_add_highlight(0, ns, "GruvboxOrange", 2, 0, -1)

	--  NOTE: nvim_buf_set_extmark

	--  NOTE: vim.treesitter
	--  NOTE: require("vim.treesitter.query").get_query
	--  NOTE: require("vim.treesitter").get_parser
end --}}}

function M.input_test()
	vim.ui.input({}, function(input)
		N(input, "info", "input_test")
	end)
end

function M.select_test()
	vim.ui.select({ --> Choices
		"tabs",
		"spaces",
	}, {
		prompt = "Select tabs or spaces:",
		format_item = function(item)
			return "I'd like to choose " .. item
		end,
	}, function(choice)
		N(choice, nil, "select_test")
	end)
end

vim.keymap.set("n", "<Leader>x", function()
	M.input_test()
end, { noremap = true })
vim.keymap.set("n", "<Leader>z", function()
	M.select_test()
end, { noremap = true })

return M
