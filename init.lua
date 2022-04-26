-- A: Essentials:
require("user.packer-config")
require("user.settings")
require("user.mappings")
-- require("user.mappings-hop")
-- B: LSP Related:
require("user.null-ls-config")
require("user.cmp-config")
require("user.lsp")
require("dap-config")
-- C: Treesitter
require("user.treesitter")
-- D: Telescope
require("user.telescope-config")
require("user.telescope-custom-pickers")
-- E: UI Elements
require("user.nvim-tree")
require("user.gitsigns")
require("user.toggle-term")
require("user.wilder-config")
-- F: Status Line
-- require("user.lualine-config")
require("user.evil-lualine")
-- require("user.bufferline-config")
-- G: Editing
require("user.autopairs")
require("user.todo-comments-config")
require("user.pretty-fold-config")
-- H: LuaSnip
require("user.luasnip-config")
-- J: Advanced Plugins
require("user.vim-submode-config")
-- Cursor Flasher
require("user.beacon-config")
require("user.symbols-outline-config")
--Custom Plugins
require("myPlugs.global")

-- S:imple Configs
require("Comment").setup()
require("colorizer").setup(--[[ { scss = { mode = "foreground" } } ]]
)
require("neoclip").setup({
	keys = {
		telescope = {
			i = {
				paste = "<CR>",
				paste_behind = "<BS>",
				select = "<C-s>",
			},
		},
	},
})

require("twilight").setup({
	dimming = {
		alpha = 0.25, -- amount of dimming
		-- we try to get the foreground from the highlight groups or fallback color
		color = { "Normal", "#ffffff" },
		inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
	},
	context = 0, -- amount of lines we will try to show around the current line
	treesitter = true, -- use treesitter when available for the filetype
	-- treesitter is used to automatically expand the visible text,
	-- but you can further control the types of nodes that should always be fully expanded
	expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
		"function",
		"method",
		"table",
		"if_statement",
	},
	exclude = {}, -- exclude these filetypes
})
