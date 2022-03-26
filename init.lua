-- A: Essentials:
require("user.packer-config")
require("user.settings")
require("user.mappings")
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
require("user.nvim-tree")
require("user.gitsigns")
require("user.toggle-term")
-- F: Status Line
-- require("user.lualine-config")
require("user.evil-lualine")
-- G: Editing
require("user.autopairs")
require("user.todo-comments-config")
-- H: Snippets
require("user.luasnip-config")
-- J: Advanced Plugins
require("user.vim-submode-config")
require("user.fold-cycle-config")

-- S:imple Configs
require("Comment").setup()
require("hop").setup({
	keys = "etovxqpdygfblzhckisuran",
})

-- HACK:
vim.cmd([[nnoremap <c-i> <c-i>]])
