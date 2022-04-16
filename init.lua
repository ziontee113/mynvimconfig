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
-- require("david")
-- C: Treesitter
require("user.treesitter")
-- D: Telescope
require("user.telescope")
require("user.telescope-pickers")
-- E: UI Elements
require("user.nvim-tree")
require("user.gitsigns")
require("user.toggle-term")
-- F: Status Line
-- require("user.lualine-config")
require("user.evil-lualine")
-- require("user.bufferline-config")
-- G: Editing
require("user.autopairs")
-- require("user.todo-comments-config")
require("user.pretty-fold-config")
-- H: Snippets
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
require("hop").setup({
	-- keys = "etovxqpdygfblzhckisuran",
})
require("colorizer").setup({ scss = { mode = "foreground" } })
require("fidget").setup({ window = { blend = 0 } })

--
local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })

wilder.set_option("pipeline", {
	wilder.branch(
		wilder.cmdline_pipeline({
			fuzzy = 1,
			set_pcre2_pattern = 1,
		}),
		wilder.python_search_pipeline({
			pattern = "fuzzy",
		})
	),
})

local highlighters = {
	wilder.pcre2_highlighter(),
	wilder.basic_highlighter(),
}

wilder.set_option(
	"renderer",
	wilder.renderer_mux({
		[":"] = wilder.popupmenu_renderer({
			highlighter = highlighters,
		}),
		["/"] = wilder.wildmenu_renderer({
			highlighter = highlighters,
		}),
	})
)
