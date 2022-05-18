-- A: Essentials:
require("user.packer-config")
require("user.settings")
require("user.mappings")
-- require("user.mappings-hop")
-- B: LSP Related:
require("user.null-ls-config")
require("user.cmp-config")
require("user.lsp")
require("dap-config")
-- C: Treesitter
require("user.treesitter")
-- D: Telescope
require("user.telescope-config")
require("user.telescope-custom-pickers")
-- E: UI Elements
-- require("user.nvim-tree")
require("user.neotree-config")
require("user.nvim-tree")
require("user.gitsigns")
require("user.toggle-term")
require("user.wilder-config")
-- F: Status Line
-- require("user.lualine-config")
require("user.evil-lualine")
-- require("user.bufferline-config")
-- G: Editing
require("user.autopairs")
require("user.todo-comments-config")
require("user.pretty-fold-config")
-- H: LuaSnip
require("user.luasnip-config")
-- J: Advanced Plugins
require("user.vim-submode-config")
-- Cursor Flasher
require("user.beacon-config")
require("user.symbols-outline-config")
require("user.notify-config")
--Custom Plugins
require("myPlugs.global")

-- S:imple Configs
require("Comment").setup()
require("colorizer").setup()
require("neoclip").setup({
	keys = {
		telescope = {
			i = {
				paste = "<CR>",
				paste_behind = "<BS>",
				select = "<C-s>",
			},
		},
	},
})
require("user.twilight-config")
require("user.neoscroll-config")

------------------  NOTE: Language Specific Settings ----------------------------
require("user.lang-settings.markdown")

------------------  NOTE: Testing out Stufs ----------------------------
require("toybox")
require("nui-test")
require("vim_schedule_demo")

require("hop-mappings")

-- Cursorline color
vim.cmd([[highlight Cursorline guibg=#212121]])
