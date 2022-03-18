return require('packer').startup(function()

	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Telescope
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
  use 'BurntSushi/ripgrep'

  -- NVIM Tree
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'

  -- Color Scheme
  use 'gruvbox-community/gruvbox'
  use 'folke/tokyonight.nvim'


end)
