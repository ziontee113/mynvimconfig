local ls = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

local types = require("luasnip.util.types")
ls.config.set_config({
	history = true, --keep around last snippet local to jump back
	updateevents = "TextChanged,TextChangedI", --update changes as you type
	enable_autosnippets = true,
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "●", "GruvboxOrange" } },
			},
		},
		-- [types.insertNode] = {
		-- 	active = {
		-- 		virt_text = { { "●", "GruvboxBlue" } },
		-- 	},
		-- },
	},
})

-- Key Mapping --

vim.keymap.set({ "i", "s" }, "<c-u>", '<cmd>lua require("luasnip.extras.select_choice")()<cr>')
vim.keymap.set({ "i", "s" }, "<c-k>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

vim.keymap.set("i", "<c-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)
vim.keymap.set("i", "<c-h>", function()
	if ls.choice_active() then
		ls.change_choice(-1)
	end
end)

vim.keymap.set("i", "<c-u>", require("luasnip.extras.select_choice"))

-- Auto Reload --

function _G.snippets_clear()
	for m, _ in pairs(ls.snippets) do --> clear all snippets
		package.loaded["snippets." .. m] = nil
	end

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

	-- for Auto Triggered
	for m, _ in pairs(ls.autosnippets) do --> clear all snippets
		package.loaded["autosnippets." .. m] = nil
	end

	ls.autosnippets = setmetatable({}, {
		__index = function(t, k)
			local ok, m = pcall(require, "autosnippets." .. k)
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
au BufWritePost ~/.config/nvim/lua/autosnippets/*.lua lua _G.snippets_clear()
" au BufWritePost ~/.config/nvim/lua/snippets/*.lua echo "Hello from " @%
augroup END
]])
