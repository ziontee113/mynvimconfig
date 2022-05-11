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
	-- M.curl_test()
	M.input_test()
end, { noremap = true }) --}}}

local function print_to_right_split(buf, contents) --{{{
	vim.schedule(function()
		vim.api.nvim_buf_set_text(buf, 0, 0, 0, 0, contents)
		vim.api.nvim_buf_set_option(buf, "filetype", "lua")
	end)
end --}}}

local function SE_API_to_JSON(question) --{{{
	local domain = "https://api.stackexchange.com"
	local api_key = "&key=A2BkHz)K9Ct2Eb7rjYcedA(("
	-- local query = "/2.3/articles?order=desc&sort=activity&site=stackoverflow"

	question = "&q=" .. string.gsub(question, "%s", "%%20")

	local with_body = "&filter=withbody"
	local tags = "&tagged=javascript"

	local query = "/2.3/search/advanced?order=desc&sort=relevance"
		.. question
		.. tags
		.. "&site=stackoverflow"
		.. with_body
	local url = domain .. query .. api_key
	N(url) -- for debugging

	local curl = require("plenary.curl")
	local result = curl.get(url, { accept = "application/json" })
	local decoded_JSON = vim.json.decode(result.body)

	return decoded_JSON
end --}}}

local function unescape(str) --{{{
	str = string.gsub(str, "&lt;", "<")
	str = string.gsub(str, "&gt;", ">")
	str = string.gsub(str, "&le;", "<=")
	str = string.gsub(str, "&ge;", ">=")
	str = string.gsub(str, "&#x3d;", "=")
	str = string.gsub(str, "&amp;", "&")
	str = string.gsub(str, "&quot;", '"')
	str = string.gsub(str, "&apos;", "'")
	str = string.gsub(str, "&#39;", "'")
	str = string.gsub(str, "&#x27;", "'")
	str = string.gsub(str, "&#x60;", "`")
	str = string.gsub(str, "&#x7b;", "{")
	str = string.gsub(str, "&#x7d;", "}")
	str = string.gsub(str, "&#x7e;", "~")
	str = string.gsub(str, "&#x5c;", "\\")
	str = string.gsub(str, "&#x2f;", "/")

	return str
end --}}}

function M.curl_test(decoded_JSON)
	vim.cmd("vsplit")
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_win_set_buf(win, buf)

	-- split new lines in string into table{{{
	local lines = {}
	for line in string.gmatch(I(decoded_JSON), "[^\n]+") do
		table.insert(lines, line)
	end

	-- insert "local results = " at the beginning of the first line
	lines[1] = "local results = " .. lines[1]

	-- print titles
	table.insert(lines, "")
	table.insert(lines, "local titles = {")
	for _, item in ipairs(decoded_JSON.items) do
		local title = item.title
		title = unescape(title)

		table.insert(lines, "\t[=[ " .. title .. " ]=],")
	end
	table.insert(lines, "}")

	print_to_right_split(buf, lines) --}}}
end

function M.input_test()
	vim.ui.input({}, function(input)
		if input then
			local decoded_JSON = SE_API_to_JSON(input)
			M.curl_test(decoded_JSON)
		end
	end)
end

return M
