local luasnip = require("luasnip")

function _G.snippets_clear()
	local ok, m = pcall(require, "~/.config/nvim/lua/snippets/all.lua")
	if not ok then
		print(vim.inspect(m))
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
