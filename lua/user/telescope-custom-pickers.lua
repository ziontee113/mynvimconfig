local M = {}
local telescope = require("telescope")
local builtin = require("telescope.builtin")

function M.grep_string()
	builtin.grep_string({
		shorten_path = true,
		search = vim.fn.input("Rg> "),
	})
end

function M.vimrc_find_files()
	local opts = {}
	opts.search_dirs = {
		"~/.config/nvim/",
	}
	opts.prompt_title = "$MYVIMRC find_files"
	opts.shorten_path = true
	builtin.live_grep(opts)
end

function M.vimrc_live_grep()
	local opts = {}
	opts.search_dirs = {
		"~/.config/nvim/",
	}
	opts.prompt_title = "$MYVIMRC live_grep"
	opts.shorten_path = true
	builtin.live_grep(opts)
end

return M
