local ls = require("luasnip")

return {
	ls.parser.parse_snippet("toofar", "boom"),
	ls.parser.parse_snippet("expect", "pressure"),
}, {

	ls.parser.parse_snippet("hello", "shiro"),
}
