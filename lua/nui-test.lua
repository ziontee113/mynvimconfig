local NuiText = require("nui.text")

vim.keymap.set("n", "<leader>zj", function()
	local text = NuiText("Something Went Wrong!", "Error")
	local bufnr, ns_id, linenr_start, byte_start = 0, -1, 1, 5

	text:render(bufnr, ns_id, linenr_start, byte_start)
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>zk", function()
	local NuiLine = require("nui.line")
	local line = NuiLine()

	line:append("Something Went Wrong!", "Error")

	local bufnr, ns_id, linenr_start = 0, -1, 2

	line:render(bufnr, ns_id, linenr_start)
end, { noremap = true, silent = true })
