local luasnip = require("luasnip")

function _G.snippets_clear()
	local ok, m = pcall(require, "snippets.all")
	if not ok and not string.match(m, "^module.*not found:") then
		error(m)
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
