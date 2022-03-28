local ls = require("luasnip")

return {
	ls.parser.parse_snippet("ctrig", "also loaded!!"),
	ls.parser.parse_snippet("in the end", "it doesn't even matter"),
}, {
	ls.parser.parse_snippet("autotrig", "autotriggered, if enabled"),
	ls.parser.parse_snippet("intheend", "lodash dash dash"),
}
