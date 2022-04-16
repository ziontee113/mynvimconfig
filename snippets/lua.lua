-- Imports
local ls = require("luasnip")
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local function lp(package_name) -- Load Package Function
	package.loaded[package_name] = nil
	return require(package_name)
end

local snippets = {
	s(
		{ trig = "s", hidden = false },
		fmt([[ s({{ trig = "{}", hidden = true }}, {})]], { i(1, "trigger"), i(2, 't"contents"') })
	),
	ls.parser.parse_snippet("lua", "also loaded!!"),
}

local vim_cmd_multiline_snippet = s("CMD", {
	t({ "vim.cmd[[", "  " }),
	i(1, ""),
	t({ "", "]]" }),
})
local vim_cmd_singleline_snippet = s("CMd", fmt("vim.cmd[[{}]]", { i(1, "") }))

local github_import_packer = s({ trig = "https://github%.com/([%w-_]+)/([%w-_]+)!", regTrig = true, hidden = true }, {
	t([[use "]]),
	f(function(_, snip)
		return snip.captures[1]
	end),
	t("/"),
	f(function(_, snip)
		return snip.captures[2]
	end),
	t({ [["]], "" }),
	i(1, ""),
})

return snippets,
	{
		ls.parser.parse_snippet("autolua", "autotriggered, if enabled"),
		ls.parser.parse_snippet("get_down", "breakdown"),
		vim_cmd_multiline_snippet,
		vim_cmd_singleline_snippet,
		github_import_packer,
	}
