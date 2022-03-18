require('packer-config')

require('user.settings')
require('user.mappings')

-- NVIM-Tree --
require('nvim-tree').setup{
  autoclose = true,
  diagnostics = {
    enable = true,
  }
}
