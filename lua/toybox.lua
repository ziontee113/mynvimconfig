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
		N(choice)
	end)
end

function M.split_test()
	local original_win = vim.api.nvim_get_current_win()

	vim.cmd("vsplit")
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_win_set_buf(win, buf)

	vim.api.nvim_buf_set_text(buf, 0, 0, 0, 0, { "let x = 100", "const y = 999" })
	vim.api.nvim_buf_set_option(buf, "filetype", "javascript")

	vim.api.nvim_win_set_width(win, 40)

	api.nvim_set_current_win(original_win)
end

vim.keymap.set("n", "<Leader>jk", function()
	M.split_test()
end, { noremap = true })
vim.keymap.set("n", "<Leader>x", function()
	M.input_test()
end, { noremap = true })
vim.keymap.set("n", "<Leader>z", function()
	M.select_test()
end, { noremap = true })
vim.keymap.set("n", "<Leader>kj", function()
	M.curl_test()
end, { noremap = true })

local Job = require("plenary.job")
function M.curl_test()
	local url = "https://api.stackexchange.com/2.3/questions?order=desc&sort=activity&site=stackoverflow"

	Job
		:new({
			command = "curl",
			args = { url, " | gunzip" },
			on_exit = function(j, return_val)
				N(return_val)
				N(j:result())
			end,
		})
		:start()
end

return M
