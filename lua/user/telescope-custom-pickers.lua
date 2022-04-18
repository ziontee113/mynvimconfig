local M = {}
local telescope = require("telescope")
local builtin = require("telescope.builtin")

function M.grep_string()
	builtin.grep_string({
		shorten_path = true,
		search = vim.fn.input("Rg> "),
	})
end

return M
