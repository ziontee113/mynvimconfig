-- A: Essentials:
require("user.packer-config")
-- B: LSP Related:
require("user.null-ls-config")
require("user.cmp")
require("user.lsp")
-- C: Treesitter
require("user.treesitter")
-- D: Telescope
require("user.telescope")
require("user.telescope-pickers")
-- E: UI Elements
require("user.gitsigns")
-- require("user.lualine-config")
require("user.evil-lualine")
require("user.nvim-tree")
require("user.toggle-term")
require("user.autopairs")
require("user.todo-comments-config")
require("user.mappings")
require("user.settings")
require("user.luasnip-config")
require("user.vim-submode-config")
require("user.fold-cycle-config")

-- SECTION: Simple Configs
require("Comment").setup()
require("hop").setup({
	keys = "etovxqpdygfblzhckisuran",
})
