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

local if_fmt_arg = {
	i(1, ""),
	c(2, { i(1, "LHS"), i(1, "10") }),
	c(3, { i(1, "==="), i(1, "<"), i(1, ">"), i(1, "<="), i(1, ">="), i(1, "!==") }),
	i(4, "RHS"),
	i(5, "//TODO:"),
}
local if_fmt_1 = fmt(
	[[
{}if ({} {} {}) {};
    ]],
	vim.deepcopy(if_fmt_arg)
)
local if_fmt_2 = fmt(
	[[
{}if ({} {} {}) {{
  {};
}}
    ]],
	vim.deepcopy(if_fmt_arg)
)

local if_snippet = s(
	{ trig = "IF", regTrig = false, hidden = true },
	c(1, {
		if_fmt_1,
		if_fmt_2,
	})
)

local function_fmt = fmt(
	[[
function {}({}) {{
  {}
}}
    ]],
	{
		i(1, "myFunc"),
		c(2, { i(1, "arg"), i(1, "") }),
		i(3, "//TODO:"),
	}
)

local function_snippet = s({ trig = "f[un]?", regTrig = true, hidden = true }, function_fmt)
local function_snippet_func = s({ trig = "func" }, vim.deepcopy(function_fmt))

local for_loop_snippet = s(
	{ trig = "for(%w)", regTrig = true, hidden = true },
	fmt(
		[[
for (let {} = 0; {} < {}; {}++) {{
  {}
}}

{}
    ]],
		{
			i(1, "i"),
			rep(1),
			c(2, { i(1, "num"), sn(1, { i(1, "arr"), t(".length") }) }),
			rep(1),
			i(3, "// TODO:"),
			i(4),
		}
	)
)

local snippets = {
	for_loop_snippet,
	function_snippet,
	function_snippet_func,
}

return snippets, { if_snippet }
