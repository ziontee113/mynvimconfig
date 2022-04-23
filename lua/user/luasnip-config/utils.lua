local ls = require("luasnip") --{{{
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep --}}}

local M = {}

local group = vim.api.nvim_create_augroup("Lua Snippets", { clear = true })

M.cs = function(trigger, nodes, keymap) --> cs stands for create snippet
	local snippet = s(trigger, nodes)
	local target_table = snippets

	if keymap ~= nil then
		local pattern = "*.lua"
		if type(keymap) == "table" then
			pattern = keymap[1]
			keymap = keymap[2]
		else
			if keymap == "auto" then
				target_table = autosnippets
			end
		end
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = pattern,
			group = group,
			callback = function()
				vim.keymap.set({ "i" }, keymap, function()
					ls.snip_expand(snippet)
				end, { noremap = true, silent = true, buffer = true })
			end,
		})
	end

	table.insert(target_table, snippet)
end

-- the cs function has 3 responsibilities:
-- 1. create a snippet
-- 2. add the snippet to the appropriate table
-- 3. add a keymap for that snippet, also define appropriate autocmd
return M
