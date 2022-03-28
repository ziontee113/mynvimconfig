local ls = require("luasnip")
local s = ls.s
local f = ls.f

return {
	ls.parser.parse_snippet("ctrig", "also loaded!!"),
	ls.parser.parse_snippet("in the end", "it doesn't even matter"),
	s("selected_text", {
		f(function(_, snip)
			return snip.env.SELECT_RAW
		end, {}),
	}),
}, {
	ls.parser.parse_snippet("autotrig", "autotriggered, if enabled"),
	ls.parser.parse_snippet("intheend", "lodash dash dash"),
}
