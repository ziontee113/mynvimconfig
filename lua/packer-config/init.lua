-- Autocommand that reloads neovim whenever you save the plugins.lua file (PackerSync on save)
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost ~/.config/nvim/lua/packer-config/init.lua source <afile> | PackerSync
  augroup end
]]
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Install your plugins here
return require('packer').startup(function()

	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

  -- Toggle Terminal
  use 'akinsho/toggleterm.nvim'

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
