local luasnip = require("luasnip")

function _G.snippets_clear()
	for m, _ in pairs(luasnip.snippets) do
		package.loaded["snippets." .. m] = nil
	end
	luasnip.snippets = setmetatable({}, {
		__index = function(t, k)
			local ok, m = pcall(require, "snippets." .. k)
			if not ok and not string.match(m, "^module.*not found:") then
				error(m)
			end
			t[k] = ok and m or {}

			-- optionally load snippets from vscode- or snipmate-library:
			--
			-- require("luasnip.loaders.from_vscode").load({include={k}})
			-- require("luasnip.loaders.from_snipmate").load({include={k}})
			return t[k]
		end,
	})
end

_G.snippets_clear()

vim.cmd([[
augroup snippets_clear
au!
au BufWritePost ~/.config/nvim/lua/snippets/*.lua lua _G.snippets_clear()
" au BufWritePost ~/.config/nvim/lua/snippets/*.lua echo "Hello from " @%
augroup END
]])
