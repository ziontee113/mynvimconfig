-- Autocommand PackerSync on this file save
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
	use("akinsho/bufferline.nvim")
	use("metakirby5/codi.vim")

	-- Telescope
	use("nvim-lua/plenary.nvim")
	use("stevearc/dressing.nvim")
	use("nvim-telescope/telescope-live-grep-raw.nvim")
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
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")
	use("p00f/nvim-ts-rainbow")
	use("nvim-treesitter/playground")

	use("nvim-treesitter/nvim-treesitter-textobjects")

	-- LSP
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	use("hrsh7th/cmp-nvim-lsp")

	use("mattn/emmet-vim")

	use("j-hui/fidget.nvim")

	-- Null-ls
	use("jose-elias-alvarez/null-ls.nvim")

	-- NVIM CMP Autocomplete
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lua")

	-- Auto Import
	use("jose-elias-alvarez/nvim-lsp-ts-utils")
	-- use("ludovicchabant/vim-gutentags")
	-- use("kristijanhusak/vim-js-file-import")

	-- LuaSnip
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	-- Text Formatting / Comments / Targets / Brackets
	use("wellle/targets.vim")
	use("numToStr/Comment.nvim")
	use("tpope/vim-surround")
	use("mg979/vim-visual-multi")

	-- Test Jumping / Hopping
	use("phaazon/hop.nvim")
	use("mfussenegger/nvim-treehopper")
	use("ggandor/lightspeed.nvim")

	-- Git Signs / UI
	use("lewis6991/gitsigns.nvim")
	use("norcalli/nvim-colorizer.lua")

	-- Vim Fugitive
	use("tpope/vim-fugitive")

	-- Submodes
	use("kana/vim-submode")

	-- Folds
	use("anuvyklack/pretty-fold.nvim")

	-- Github Copilot
	use("github/copilot.vim")
	-- use({
	-- 	"zbirenbaum/copilot.lua",
	-- 	event = "InsertEnter",
	-- 	config = function()
	-- 		vim.schedule(function()
	-- 			require("copilot")
	-- 		end)
	-- 	end,
	-- })
	-- use({
	-- 	"zbirenbaum/copilot-cmp",
	-- 	after = { "copilot.lua", "nvim-cmp" },
	-- })

	-- Wiki
	use("vimwiki/vimwiki")

	-- DAP
	use("mfussenegger/nvim-dap")

	use("mfussenegger/nvim-dap-python")

	use("theHamsta/nvim-dap-virtual-text")
	use("rcarriga/nvim-dap-ui")
	use("nvim-telescope/telescope-dap.nvim")

	-- Harpoon
	use("ThePrimeagen/harpoon")
end)
