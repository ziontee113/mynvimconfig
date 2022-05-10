-- write autocmd for .md files to set wrap settings in that .md buffer

local group = vim.api.nvim_create_augroup("Markdown Wrap Settings", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	group = group,
	command = "setlocal wrap",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "plantuml" },
	group = group,
	command = "setlocal nowrap",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	group = group,
	callback = function()
		vim.keymap.set("n", "<F6>", ":Glow<cr>", { noremap = true, buffer = true, slient = true })
	end,
})
