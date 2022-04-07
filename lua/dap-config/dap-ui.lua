require("dapui").setup({
	icons = { expanded = "▾", collapsed = "▸" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	sidebar = {
		-- You can change the order of elements in the sidebar
		elements = {
			-- Provide as ID strings or tables with "id" and "size" keys
			-- { id = "watches", size = 0.33 },
			{ id = "stacks", size = 0.33 },
			{
				id = "scopes",
				size = 0.33, -- Can be float or integer > 1
			},
			{ id = "repl", size = 0.33 },
			-- { id = "breakpoints", size = 0.1 },
		},
		size = 60,
		position = "right", -- Can be "left", "right", "top", "bottom"
	},
	tray = {
		-- elements = { "repl" },
		elements = {},
		size = 0,
		position = "bottom", -- Can be "left", "right", "top", "bottom"
	},
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
})

vim.cmd([[autocmd FileType dapui_watches nnoremap <silent> <buffer> <C-j> <C-w>j]])
vim.cmd([[autocmd FileType dapui_watches nnoremap <silent> <buffer> <C-k> <C-w>k]])
vim.cmd([[autocmd FileType dapui_scopes nnoremap <silent> <buffer> <C-j> <C-w>j]])
vim.cmd([[autocmd FileType dapui_scopes nnoremap <silent> <buffer> <C-k> <C-w>k]])
vim.cmd([[autocmd FileType dapui_stacks nnoremap <silent> <buffer> <C-j> <C-w>j]])
vim.cmd([[autocmd FileType dapui_stacks nnoremap <silent> <buffer> <C-k> <C-w>k]])
vim.cmd([[autocmd FileType dap-repl nnoremap <silent> <buffer> <C-j> <C-w>j]])
vim.cmd([[autocmd FileType dap-repl nnoremap <silent> <buffer> <C-k> <C-w>k]])
