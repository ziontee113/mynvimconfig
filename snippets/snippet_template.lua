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

-- Snippets go here --

-- Snippets end here --

local snippets = {}
local autosnippets = {}

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
		-- map({ "i" }, "jj", function()
		-- 	ls.snip_expand(local_var_snippet)
		-- end, opts)
		-- map({ "i" }, "<C-d>", function()
		-- 	ls.snip_expand(snippets[3])
		-- end, opts)
		-- map({ "i" }, "jff", function()
		-- 	ls.snip_expand(function_snippet)
		-- end, opts)
	end,
})

return snippets, autosnippets
