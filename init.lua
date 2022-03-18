require('user.packer')
require('user.settings')
require('user.mappings')
require('user.cmp')
require('user.lsp')
require('user.telescope')

-- NVIM-Tree --
require('nvim-tree').setup{
  autoclose = true,
  diagnostics = {
    enable = true,
  }
}

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
