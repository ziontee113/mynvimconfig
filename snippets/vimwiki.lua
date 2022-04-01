-- Imports
local ls = require("luasnip")
local s = ls.s
local i = ls.i
local t = ls.t

local ps = ls.parser.parse_snippet

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
	ps("vimwiki", "hello from vimwiki format"),
}

return snippets, {
	ls.parser.parse_snippet("autovimwiki", "autotriggered"),
}
