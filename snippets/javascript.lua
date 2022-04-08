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
	),
	s(
		{ trig = "ifre", regTrig = false, hidden = true },
		fmt(
			[[
if ({} === {}) return {};
    ]],
			{
				i(1, "LHS"),
				i(2, "RHS"),
				i(3, "true"),
			}
		)
	),
	s(
		{ trig = "f[un]?", regTrig = true, hidden = true },
		fmt(
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
	),
}

return snippets
