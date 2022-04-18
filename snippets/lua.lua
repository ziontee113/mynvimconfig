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

local vim_cmd_multiline = s("CMD", {
	t({ "vim.cmd[[", "  " }),
	i(1, ""),
	t({ "", "]]" }),
})
local vim_cmd_singleline_snippet = s("CMd", fmt("vim.cmd[[{}]]", { i(1, "") }))
local github_import_packer = s({
	trig = "https://github%.com/([%w-%._]+)/([%w-%._]+)!",
	regTrig = true,
	hidden = true,
}, {
	t([[use "]]),
	f(function(_, snip)
		return snip.captures[1]
	end),
	t("/"),
	f(function(_, snip)
		return snip.captures[2]
	end),
	t({ [["]], "" }),
	i(1, ""),
})

-- Snippets to create new Snippets --

local luasnip_regexSnippet = s(
	"regexSnippet",
	fmt(
		[=[
local {} = s({{ trig = "{}", regTrig = true, hidden = true }}, fmt([[ 
  {}
]], {{
  {}
}}))
      ]=],
		{
			i(1, ""),
			i(2, ""),
			i(3, ""),
			i(4, ""),
		}
	)
)
local luaSnippet = s(
	"luaSnippet",
	fmt(
		[=[
local {} = s("{}", fmt([[ 
  {}
]], {{
  {}
  }}))
    ]=],
		{
			i(1, ""),
			i(2, ""),
			i(3, ""),
			i(4, ""),
		}
	)
)
local parseSnippet = s(
	"parseSnippet",
	fmt(
		[[ 
local {} = ls.parser.parse_snippet("{}", "{}")
]],
		{
			i(1, ""),
			i(2, ""),
			i(3, ""),
		}
	)
)

local keymapForLuaSnippet = s(
	"keymapForLuaSnippet",
	fmt(
		[[ 
map({{ "{}" }}, "{}", function()
  ls.snip_expand({})
end, opts)
]],
		{
			i(1, "i"),
			i(2, "jk"),
			i(3, "someSnippet"),
		}
	)
)

-- Lua Snippets --

local function_snippet = s(
	"function",
	fmt(
		[[ 
function {}({})
  {}
end
]],
		{
			i(1, ""),
			i(2, ""),
			i(3, ""),
		}
	)
)
local local_var_snippet = s(
	"local",
	fmt(
		[[ 
local {} = {}
  ]],
		{ i(1, ""), i(2, "") }
	)
)

local snippets = {
	ls.parser.parse_snippet("lua", "also loaded!!"),
	parseSnippet,
	luaSnippet,
	luasnip_regexSnippet,
	keymapForLuaSnippet,
}
local autosnippets = {
	ls.parser.parse_snippet("autolua", "autotriggered, if enabled"),
	ls.parser.parse_snippet("get_down", "breakdown"),
	vim_cmd_multiline,
	vim_cmd_singleline_snippet,
	github_import_packer,
}

-- Autocmd for keymap triggered snippets --
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local group = augroup("Lua Snippets", { clear = true })
autocmd("BufEnter", {
	pattern = "*.lua",
	group = group,
	callback = function()
		map({ "i" }, "jj", function()
			ls.snip_expand(local_var_snippet)
		end, opts)
		map({ "i" }, "<C-d>", function()
			ls.snip_expand(snippets[3])
		end, opts)
		map({ "i" }, "jff", function()
			ls.snip_expand(function_snippet)
		end, opts)
	end,
})

return snippets, autosnippets
