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

function M.input_test() --{{{
	-- vim.ui.input({}, function(input)
	-- 	N(input, "info", "input_test")
	-- end)

	local cur_line = api.nvim_win_get_cursor(0)
	local total_lines_num = vim.api.nvim_buf_line_count(0)
	N(cur_line)
	N(total_lines_num)
end --}}}

function M.select_test() --{{{
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
end --}}}

function M.split_test(text) --{{{
	local original_win = vim.api.nvim_get_current_win()

	vim.cmd("vsplit")
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_win_set_buf(win, buf)

	vim.api.nvim_buf_set_text(buf, 0, 0, 0, 0, text)
	vim.api.nvim_buf_set_option(buf, "filetype", "javascript")

	vim.api.nvim_win_set_width(win, 40)

	api.nvim_set_current_win(original_win)
end --}}}

vim.keymap.set("n", "<Leader>jk", function() --{{{ Keymaps
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
end, { noremap = true }) --}}}

local function helper_A(buf, contents)
	vim.schedule(function()
		vim.api.nvim_buf_set_text(buf, 0, 0, 0, 0, contents)
		vim.api.nvim_buf_set_option(buf, "filetype", "lua")
	end)
end

function M.curl_test()
	local Job = require("plenary.job")
	local domain = "https://api.stackexchange.com"
	local api_key = "&key=A2BkHz)K9Ct2Eb7rjYcedA(("
	-- local query = "/2.3/articles?order=desc&sort=activity&site=stackoverflow"
	local query =
		"/2.3/search/advanced?order=desc&sort=relevance&q=how%20to%20center%20a%20div%20in%20html&site=stackoverflow"
	local url = domain .. query .. api_key

	vim.cmd("vsplit")
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_win_set_buf(win, buf)

	-- Job
	-- 	:new({
	-- 		command = "curl",
	-- 		args = { "--compressed", url },
	-- 		on_exit = function(job)
	-- 			local result = job:result()
	--
	-- 			vim.schedule(function()
	-- 				vim.api.nvim_buf_set_text(buf, 0, 0, 0, 0, result)
	-- 				vim.api.nvim_buf_set_option(buf, "filetype", "json")
	-- 			end)
	-- 		end,
	-- 	})
	-- 	:start()

	local curl = require("plenary.curl")
	local result = curl.get(url, { accept = "application/json" })

	local decoded_JSON = vim.json.decode(result.body)

	--  NOTE: show results in a new buffer

	-- -- split new lines in string into table{{{
	-- local lines = {}
	-- for line in string.gmatch(vim.inspect(vim.json.decode(result.body)), "[^\n]+") do
	-- 	table.insert(lines, line)
	-- end
	--
	-- -- insert "local results = " at the beginning of the first line
	-- lines[1] = "local results = " .. lines[1]
	--
	-- helper_A(buf, lines)--}}}

	-- show only the titles
	local titles = { "{" }
	for _, item in ipairs(decoded_JSON.items) do
		table.insert(titles, '"' .. item.title .. '",')
	end
	table.insert(titles, "}")

	helper_A(buf, titles)
end

return M
