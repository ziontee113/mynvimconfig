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

return {
	ls.parser.parse_snippet("ctrig", "also loaded!!"),
	ls.parser.parse_snippet("in the end", "it doesn't even matter"),
	s("selected_text", {
		f(function(_, snip)
			return snip.env.SELECT_RAW
		end, {}),
	}),
	s("insertnode", {
		i(1, "shiro"),
		i(2, "venus"),
	}),
}, {
	ls.parser.parse_snippet("autotrig", "autotriggered, if enabled"),
	ls.parser.parse_snippet("intheend", "lodash dash dash"),
}
