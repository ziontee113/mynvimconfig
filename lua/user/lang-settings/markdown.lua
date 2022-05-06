-- write autocmd for .md files to set wrap settings in that .md buffer

local group = vim.api.nvim_create_augroup("Markdown Wrap Settings", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	group = group,
	command = "setlocal wrap",
})
