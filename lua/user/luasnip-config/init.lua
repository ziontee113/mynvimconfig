local ls = require("luasnip")
ls.config.set_config({
	history = true, --keep around last snippet local to jump back
	updateevents = "TextChanged,TextChangedI", --update changes as you type
	enable_autosnippets = true,
})

function _G.snippets_clear()
	for m, _ in pairs(ls.snippets) do --> clear all snippets
		package.loaded["snippets." .. m] = nil
	end

	-- local ok, m = pcall(require, "snippets.all")
	-- if not ok then
	-- 	print(m)
	-- else
	-- 	-- TODO
	-- end

	ls.snippets = setmetatable({}, {
		__index = function(t, k)
			local ok, m = pcall(require, "snippets." .. k)
			if not ok and not string.match(m, "^module.*not found:") then
				error(m)
			end
			t[k] = ok and m or {}

			return t[k]
		end,
	})
end

_G.snippets_clear()

vim.cmd([[
augroup snippets_clear
au!
au BufWritePost ~/.config/nvim/lua/snippets/*.lua lua _G.snippets_clear()
augroup END
]])

function _G.edit_ft()
	-- returns table like {"lua", "all"}
	local fts = require("luasnip.util.util").get_snippet_filetypes()
	vim.ui.select(fts, {
		prompt = "Select which filetype to edit:",
	}, function(item, idx)
		-- selection aborted -> idx == nil
		if idx then
			vim.cmd("edit ~/.config/nvim/lua/snippets/" .. item .. ".lua")
		end
	end)
end

vim.cmd([[command! LuaSnipEdit :lua _G.edit_ft()]])
