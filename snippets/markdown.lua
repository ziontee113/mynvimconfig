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

-- Helper Functions --

local function toCamelCase(str)
	if #str == 0 or str == nil or type(str) == "table" then
		return ""
	end

	local words = {}
	local index = 1
	for word in str:gmatch("%w+") do
		if index == 1 then
			table.insert(words, word:lower())
		else
			table.insert(words, word:sub(1, 1):upper() .. word:sub(2):lower())
		end
		index = index + 1
	end

	return table.concat(words, "")
end
local function same_toLowerCase(index)
	return f(function(arg)
		return toCamelCase(arg[1][1])
	end, { index })
end

-- Snippets go here --

local plantUML_actor_snippet = s(
	"actor_plantUML",
	fmt(
		[[ 
{} "{}" as {}
]],
		{
			c(1, { t("actor"), t("usecase") }),
			i(2, ""),
			same_toLowerCase(2),
		}
	)
)
local startuml_snippet = s(
	"startuml",
	fmt(
		[[ 
@startuml
{}
{}
@enduml
]],
		{
			c(1, { t("left to right direction"), t("") }),
			i(2, ""),
		}
	)
)

local plantUML_direction = s(
	{ trig = "dir", regTrig = true, hidden = true },
	fmt(
		[[ 
{}
]],
		{ c(1, { t("left to right direction"), t("") }) }
	)
)

-- Snippets end here --

local snippets = {
	plantUML_actor_snippet,
	startuml_snippet,
	plantUML_direction,
}
local autosnippets = {}

-- Autocmd for keymap triggered snippets --
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local group = augroup("Markdown Snippets", { clear = true })
autocmd("BufEnter", {
	pattern = "*.md",
	group = group,
	callback = function()
		map({ "i" }, "jj", function() --> j act(or)
			ls.snip_expand(plantUML_actor_snippet)
		end, opts)
		map({ "i" }, "jks", function()
			ls.snip_expand(startuml_snippet)
		end, opts)
		-- map({ "i" }, "jff", function()
		-- 	ls.snip_expand(function_snippet)
		-- end, opts)
	end,
})

return snippets, autosnippets
