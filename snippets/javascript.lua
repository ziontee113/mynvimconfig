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

local snippets = {
	s({ trig = "testjs", hidden = false }, t("testing hidden snippet in javascript")),
	s(
		{ trig = "for(%w)", regTrig = true, hidden = true },
		fmt(
			[[
for (let {} = 0; {} < {}{}; {}++) {{
  {}
}}

{}
    ]],
			{
				i(1, "i"),
				rep(1),
				i(2, "arr"),
				c(3, { t(""), t(".length") }),
				rep(1),
				i(4, "// TODO:"),
				i(5),
			}
		)
	),
	s(
		{ trig = "ire", regTrig = false, hidden = true },
		fmt(
			[[
if ({} === {}) return {};
    ]],
			{
				i(1, "lhs"),
				i(2, "rhs"),
				i(3, "true"),
			}
		)
	),
}

return snippets
