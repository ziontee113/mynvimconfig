local luasnip = require("luasnip")

function _G.snippets_clear()
	for m, _ in pairs(luasnip.snippets) do --> clear all snippets
		package.loaded["snippets." .. m] = nil
	end

	local ok, m = pcall(require, "snippets.all")
	if not ok then
		print(m)
	end
end

_G.snippets_clear()

vim.cmd([[
augroup snippets_clear
au!
au BufWritePost ~/.config/nvim/lua/snippets/*.lua lua _G.snippets_clear()
" au BufWritePost ~/.config/nvim/lua/snippets/*.lua echo "Hello from " @%
augroup END
]])
