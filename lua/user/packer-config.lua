-- Autocommand that reloads neovim whenever you save the plugins.lua file (PackerSync on save)
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost ~/.config/nvim/lua/user/packer-config.lua source <afile> | PackerSync
  augroup end
]])
-- Use a protected call so we don't error out on first use
local status_ok, _ = pcall(require, "packer")
if not status_ok then
	return
end

-- Install your plugins here
return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Toggle Terminal
	use("akinsho/toggleterm.nvim")
	use("nvim-lualine/lualine.nvim")
	use("metakirby5/codi.vim")

	-- Telescope
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope.nvim")
	use("BurntSushi/ripgrep")

	-- NVIM Tree
	use("kyazdani42/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")

	-- Color Scheme
	use("gruvbox-community/gruvbox")
	use("folke/tokyonight.nvim")
	use("folke/todo-comments.nvim")

	-- Tree Sitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("p00f/nvim-ts-rainbow")
	use("nvim-treesitter/playground")

	-- LSP
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	use("hrsh7th/cmp-nvim-lsp")

	-- Null-ls
	use("jose-elias-alvarez/null-ls.nvim")

	-- NVIM CMP Autocomplete
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lua")

	-- LuaSnip
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")

	-- Text Formatting / Comments / Targets / Brackets
	use("wellle/targets.vim")
	use("numToStr/Comment.nvim")
	use("windwp/nvim-autopairs")
	use("tpope/vim-surround")

	-- Test Jumping / Hopping
	use("phaazon/hop.nvim")
	use("mfussenegger/nvim-treehopper")

	-- Git Signs
	use("lewis6991/gitsigns.nvim")
end)
