-- ESSENTIALS:
require("user.packer-config")
require("user.settings")
require("user.mappings")
-- require("user.mappings-hop")
-- LSP_RELATED:
require("user.null-ls-config")
require("user.cmp-config")
require("user.lsp")
require("dap-config")
-- TREESITTER:
require("user.treesitter")
-- TELESCOPE:
require("user.telescope.telescope-config")
require("user.telescope.telescope-custom-pickers")
require("user.telescope.telescope-mappings")
-- UI_ELEMENTS:
-- require("user.nvim-tree")
require("user.neotree-config")
require("user.nvim-tree")
require("user.gitsigns")
require("user.toggle-term")
require("user.wilder-config")
-- STATUS_LINE:
-- require("user.lualine-config")
require("user.evil-lualine")
-- require("user.bufferline-config")
-- EDITING:
require("user.autopairs")
--require("user.todo-comments-config")
require("user.pretty-fold-config")
-- LUASNIP:
require("user.luasnip-config")
-- ADVANCED_PLUGINS:
require("user.vim-submode-config")
-- CURSOR_FLASHER:
-- require("user.beacon-config")
require("user.symbols-outline-config")
require("user.notify-config")
--Custom Plugins
require("myPlugs.global")

-- SIMPLE_CONFIGS:
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
-- require("user.neoscroll-config")

------------------  NOTE: Language Specific Settings ----------------------------
require("user.lang-settings.markdown")

------------------  NOTE: Testing out Stufs ----------------------------
require("toybox")
require("nui-test")
require("vim_schedule_demo")

require("hop-mappings")
require("more_testing")

require("user.c_mappings")
require("user.syntax-tree-surfer-config")

-- Cursorline color
-- vim.cmd([[highlight Cursorline guibg=#212121]])
-- Folded Color
-- vim.cmd([[highlight Folded guifg=#5e97ec]])
