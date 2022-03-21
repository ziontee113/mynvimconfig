require("user.packer-config")
require("user.settings")
require("user.cmp")
require("user.lsp")
require("user.treesitter")
require("user.telescope")
require("user.autopairs")
require("user.gitsigns")
require("user.null-ls-config")
require("user.lualine-config")
require("user.nvim-tree")
require("user.toggle-term")
require("user.mappings")
require("user.luasnip-config")

-- Comment.nvim --
require("Comment").setup()

-- Sneak
vim.cmd([[let g:sneak#label = 1]])

-- Hop
require("hop").setup({
	keys = "etovxqpdygfblzhckisuran",
})
