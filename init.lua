require('user.packer')
require('user.settings')
require('user.cmp')
require('user.lsp')
require('user.treesitter')
require('user.telescope')
require('user.autopairs')
require('user.gitsigns')
require('user.nvim-tree')
require('user.mappings')

-- Toggle Term --
require("toggleterm").setup({
	size = 12,
	open_mapping = [[<c-\>]],
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = "1",
	start_in_insert = true,
	persist_size = true,
	direction = "horizontal",
})


-- Comment.nvim --
require('Comment').setup()
