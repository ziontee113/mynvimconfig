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
		{ trig = "s~", hidden = true },
		fmt([[ s({{ trig = "{}", hidden = true }}, {})]], { i(1, "trigger"), i(2, 't"contents"') })
	),
	s({ trig = "trigger!", hidden = true }, t("contents")),
}

return snippets
