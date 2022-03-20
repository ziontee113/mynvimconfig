local ls = require("luasnip")
local s = ls.s
local i = ls.i

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets = {
	s("req", fmt("local {} = require('{}')", { i(1, "default"), rep(1) })),
}

return snippets
