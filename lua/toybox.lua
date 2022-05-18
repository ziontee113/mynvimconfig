local M = {}

local api = vim.api
local ns = api.nvim_create_namespace("me.tsnode") --  NOTE: nvim_create_namespace

local memo = setmetatable({ --{{{
	put = function(cache, params, result)
		local node = cache
		for i = 1, #params do
			local param = vim.inspect(params[i])
			node.children = node.children or {}
			node.children[param] = node.children[param] or {}
			node = node.children[param]
		end
		node.result = result
	end,
	get = function(cache, params)
		local node = cache
		for i = 1, #params do
			local param = vim.inspect(params[i])
			node = node.children and node.children[param]
			if not node then
				return nil
			end
		end
		return node.result
	end,
}, {
	__call = function(memo, func)
		local cache = {}

		return function(...)
			local params = { ... }
			local result = memo.get(cache, params)
			if not result then
				result = { func(...) }
				memo.put(cache, params, result)
				print("not cached")
			else
				print("cached")
			end
			return unpack(result)
		end
	end,
}) --}}}

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

	str = string.gsub(str, "\r", "")

	return str
end --}}}

function M.nodes() --{{{
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
vim.keymap.set("n", "<Leader>kj", function()
	-- M.curl_test()
	M.input_test()
end, { noremap = true }) --}}}

local function print_to_right_split(buf, contents, filetype) --{{{
	vim.schedule(function()
		vim.api.nvim_buf_set_text(buf, 0, 0, 0, 0, contents)
		vim.api.nvim_buf_set_option(buf, "filetype", filetype or "lua")
		-- vim.cmd([[:%s/\r//g]]) --> Get rid of the ^M character --> use Lua gsub \r instead
	end)
end --}}}

local curl_url = memo(function(url)
	local curl = require("plenary.curl")
	local result = curl.get(url, { accept = "application/json" })
	local decoded_JSON = vim.json.decode(result.body)

	return decoded_JSON
end)

local function SE_API_to_JSON(question) --{{{
	local domain = "https://api.stackexchange.com"
	local api_key = "&key=A2BkHz)K9Ct2Eb7rjYcedA(("
	-- local query = "/2.3/articles?order=desc&sort=activity&site=stackoverflow"

	question = "&q=" .. string.gsub(question, "%s", "%%20")

	-- local filter = "&filter=withbody"
	-- local filter = -- body & body_markdown
	-- 	"&filter=!95kkh65WFZ)RhgpIx)CICUjWUcI0zc7mF5moTK(msTJOtjUZmFore2f2z5RGtW8a5o1fOtSuXjBXbXbnQWAoExQo_fU89xxwPxblD"
	-- local filter = -- only body_markdown
	-- 	"&filter=!_o.tLhueaZj*bf0)b_-oNkK83AcRWjEMcHWgbAQNAxd_gFmsixoZlee5zHS_6YAB(H4iNmu.oOitAsLm8-Fxbini6PK3xFzAH2WMUZUH9r"
	local filter = -- only body_markdown
		"&filter=!QWRdKli8sNK1EmcTY3G30.1B)jVv46wKiw_p5wdsc()rzc.dNJudv"
	local tags = "&tagged=javascript"

	local query = "/2.3/search/advanced?order=desc&sort=relevance"
		.. question
		.. tags
		.. "&site=stackoverflow"
		.. filter
	local url = domain .. query .. api_key
	-- N(url) -- for debugging

	local decoded_JSON = curl_url(url)

	return decoded_JSON
end --}}}

function M.curl_test(decoded_JSON)
	vim.cmd("vsplit")
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_win_set_buf(win, buf)

	-- -- split new lines in string into table{{{
	-- local lines = {}
	-- for line in string.gmatch(I(decoded_JSON), "[^\n]+") do
	-- 	table.insert(lines, line)
	-- end
	-- lines[1] = "local results = " .. lines[1] -- insert "local results = " at the beginning of the first line
	--
	-- -- print titles
	-- table.insert(lines, "")
	-- table.insert(lines, "local titles = {")
	-- for _, item in ipairs(decoded_JSON.items) do
	-- 	local title = item.title
	-- 	title = unescape(title)
	--
	-- 	table.insert(lines, "\t[=[ " .. title .. " ]=],")
	-- end
	-- table.insert(lines, "}")
	--
	-- print_to_right_split(buf, lines) --}}}

	-- Paint The Town{{{
	local target_data = decoded_JSON.items[1].answers[1].body_markdown

	local lines = {}
	for line in string.gmatch(target_data, "[^\n]+") do
		line = unescape(line)

		if line ~= "" then
			if not line:match("^%s") then
				line = "// " .. line
			else
				-- delete 4 spaces at the beginning of the line
				line = line:gsub("^%s%s%s%s", "")
			end
		end

		table.insert(lines, line)
	end

	-- print the title
	table.insert(lines, "const title = '" .. decoded_JSON.items[1].title .. "';")

	print_to_right_split(buf, lines, "javascript") --}}}

	vim.api.nvim_win_set_option(win, "wrap", true) --> well it works here
	-- vim.cmd([[:setlocal wrap]]) --> well it works here
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

-- Current Target:
--> Left Split to display the questions & The Question
--> Right Split to display the answers & The Answer
-- Also rewrite the code to make it cleaner
