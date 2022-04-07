-- A: Essentials:
require("user.packer-config")
require("user.settings")
require("user.mappings")
-- B: LSP Related:
require("user.null-ls-config")
require("user.cmp-config")
require("user.lsp")
require("dap-config")
-- require("david")
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
-- require("user.bufferline-config")
-- G: Editing
require("user.autopairs")
require("user.todo-comments-config")
require("user.pretty-fold-config")
-- H: Snippets
require("user.luasnip-config")
-- J: Advanced Plugins
require("user.vim-submode-config")
--NOTE:taking:
require("user.vimwiki")

-- S:imple Configs
require("Comment").setup()
require("hop").setup({
	-- keys = "etovxqpdygfblzhckisuran",
})
require("colorizer").setup()
require("fidget").setup({ window = { blend = 0 } })
