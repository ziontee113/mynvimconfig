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
	-- use("akinsho/bufferline.nvim")

	-- Telescope
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope-live-grep-raw.nvim")
	use("nvim-telescope/telescope.nvim")
	use("BurntSushi/ripgrep")

	-- Vim UI
	use("stevearc/dressing.nvim")

	-- NVIM Tree
	use("kyazdani42/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")

	-- Color Scheme
	use("gruvbox-community/gruvbox")
	use("folke/tokyonight.nvim")
	use("folke/todo-comments.nvim")

	-- Tree Sitter
	-- use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", commit = "21ac88b9551072f49ba994f461f78794af43a5aa" })
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")
	use("p00f/nvim-ts-rainbow")
	use("nvim-treesitter/playground")

	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("mfussenegger/nvim-treehopper")

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
	-- use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lua")

	-- use("ray-x/cmp-treesitter")

	-- Auto Import
	use("jose-elias-alvarez/nvim-lsp-ts-utils")
	-- use("ludovicchabant/vim-gutentags")
	-- use("kristijanhusak/vim-js-file-import")

	-- LuaSnip
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	-- use("rafamadriz/friendly-snippets")

	-- Text Formatting / Comments / Targets / Brackets
	use("wellle/targets.vim")
	use("numToStr/Comment.nvim")
	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("mg979/vim-visual-multi")

	-- Test Jumping / Hopping
	use("phaazon/hop.nvim")
	use("ggandor/lightspeed.nvim")

	-- Git Signs / UI
	use("lewis6991/gitsigns.nvim")
	use("norcalli/nvim-colorizer.lua")

	-- Submodes
	use("kana/vim-submode")

	-- Folds
	use("anuvyklack/pretty-fold.nvim")

	-- Github Copilot

	use("github/copilot.vim")

	-- use({
	-- 	"zbirenbaum/copilot.lua",
	-- 	event = { "VimEnter" },
	-- 	config = function()
	-- 		vim.defer_fn(function()
	-- 			require("copilot").setup()
	-- 		end, 100)
	-- 	end,
	-- })

	-- use({
	-- 	"zbirenbaum/copilot-cmp",
	-- 	after = { "copilot.lua", "nvim-cmp" },
	-- })

	-- DAP
	use("mfussenegger/nvim-dap")
	use("mfussenegger/nvim-dap-python")
	use("theHamsta/nvim-dap-virtual-text")
	use("rcarriga/nvim-dap-ui")
	use("nvim-telescope/telescope-dap.nvim")

	-- Harpoon
	use("ThePrimeagen/harpoon")

	-- Code Runner
	-- use("metakirby5/codi.vim")
	-- use({ "michaelb/sniprun", run = "bash ./install.sh" })
	use("thinca/vim-quickrun")

	-- Cursor Flasher
	use({ "rainbowhxch/beacon.nvim" })

	-- Workspace Symbols
	use("simrat39/symbols-outline.nvim")

	-- Wilder Cmdline
	use("gelguy/wilder.nvim")

	-- PreVim
	-- use("previm/previm")

	use("mracos/mermaid.vim")
	use("aklt/plantuml-syntax")
	-- use("tyru/open-browser.vim")
	-- use("weirongxu/plantuml-previewer.vim")

	-- Markdown preview
	use({ "iamcco/markdown-preview.nvim" })

	-- Zen Mode
	use({
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({})
		end,
	})
end)
