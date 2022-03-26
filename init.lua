require("user.packer-config")
require("user.settings")
require("user.null-ls-config")
require("user.cmp")
require("user.lsp")
require("user.treesitter")
require("user.telescope")
require("user.telescope-pickers")
require("user.autopairs")
require("user.gitsigns")
-- require("user.lualine-config")
require("user.evil-lualine")
require("user.nvim-tree")
require("user.toggle-term")
require("user.todo-comments-config")
require("user.mappings")
require("user.luasnip-config")
require("user.vim-submode-config")
require("user.fold-cycle-config")

-- Comment.nvim --
require("Comment").setup()

-- Hop
require("hop").setup({
	keys = "etovxqpdygfblzhckisuran",
})
