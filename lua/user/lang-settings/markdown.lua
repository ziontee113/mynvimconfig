-- write autocmd for .md files to set wrap settings in that .md buffer

local group = vim.api.nvim_create_augroup("Markdown Wrap Settings", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.md",
	group = group,
	callback = function()
		vim.wo.wrap = true
	end,
})
vim.api.nvim_create_autocmd("BufLeave", {
	pattern = "*",
	group = group,
	callback = function()
		vim.wo.wrap = false
	end,
})
