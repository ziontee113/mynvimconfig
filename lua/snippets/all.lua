local ls = require("luasnip")
local s = ls.s

local fmt = require("luasnip.extras.fmt").fmt

local snippets = {
	all = {
		s("test", fmt("test snippet")),
	},
}

print("coming from snippets/all.lua")
