local M = {}
local telescope = require("telescope")
local builtin = require("telescope.builtin")

function M.grep_string()
	builtin.grep_string({
		shorten_path = true,
		search = vim.fn.input("Rg> "),
	})
end

local dropdown_theme = require("telescope.themes").get_dropdown({
	winblend = 10,
	width = 0.5,
	prompt = " ",
	results_height = 15,
	previewer = false,
})
local ivy_theme = require("telescope.themes").get_ivy({
	winblend = 10,
	results_title = false,
	layout_config = {
		preview_width = 0.6,
	},
})

function M.vimrc_find_files()
	local opts = vim.deepcopy(ivy_theme)
	opts.search_dirs = { "~/.config/nvim/" }
	opts.prompt_title = "$MYVIMRC find_files"
	opts.shorten_path = true
	builtin.find_files(opts)
end

function M.vimrc_live_grep()
	local opts = vim.deepcopy(ivy_theme)
	opts.search_dirs = {
		"~/.config/nvim/",
	}
	opts.prompt_title = "$MYVIMRC live_grep"
	opts.shorten_path = true
	builtin.live_grep(opts)
end

return M
