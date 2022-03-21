local ls = require("luasnip")
local s = ls.s
local i = ls.i
local t = ls.t

local c = ls.choice_node
local f = ls.function_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local function lp(package_name) -- lp -> stands for Load Package
	package.loaded[package_name] = nil
	return require(package_name)
end --> TODO: turn this function into a snippet (for easier autocomplete)

local same = function(index)
	return f(function(arg)
		return arg[1]
	end, { index })
end

local snippets = {
	s("req", fmt("require {} = require('{}')", { i(1, "default"), rep(1) })),
	s("oddeye", { t("some text") }),
	s("mamba", { t("some text") }),
	s("black", { t("black "), i(1, "mamba") }),
	s("test", { t(lp("snippets.all.savage")) }),
	s("t", { t("-- " .. lp("snippets.all.super").name) }),
	s("k", fmt("-- this is a {1} and it's not a {}", { i(1, "string"), i(2, "number") })),
	s("c", fmt("hey this is cool: {}", { c(1, { t("option →"), t("◙") }) })),
	s("j", fmt("hel{{{}}}lo", { i(0) })),
	s(
		"f",
		f(function()
			return "-- Current Time is: " .. os.date("%D - %H:%M")
		end)
	),
	s("st", fmt([[-- example: {}, function: {}]], { i(1), same(1) })),
}
-- Current Time is: 03/21/22 - 08:41
-- example: hellovenus, function: hellovenus
-- 10
-- my name is super
return snippets
