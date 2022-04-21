-- Toggle Term --
require("toggleterm").setup({
	size = 12,
	open_mapping = [[<c-\>]],
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = "1",
	start_in_insert = true,
	persist_size = true,
	direction = "float",
	-- float_opts = {
	-- 	width = 100,
	-- 	height = 100,
	-- },
})

-- local status_ok, toggleterm = pcall(require, "toggleterm")
-- if not status_ok then
-- 	return
-- end

-- toggleterm.setup({
-- 	size = 20,
-- 	open_mapping = [[<c-\>]],
-- 	hide_numbers = true,
-- 	shade_filetypes = {},
-- 	shade_terminals = true,
-- 	shading_factor = 2,
-- 	start_in_insert = true,
-- 	insert_mappings = true,
-- 	persist_size = true,
-- 	direction = "float",
-- 	close_on_exit = true,
-- 	shell = vim.o.shell,
-- 	float_opts = {
-- 		border = "curved",
-- 		winblend = 0,
-- 		highlights = {
-- 			border = "Normal",
-- 			background = "Normal",
-- 		},
-- 	},
-- })

-- function _G.set_terminal_keymaps()
-- 	local opts = { noremap = true }
-- 	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
-- 	vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
-- 	vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
-- 	vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
-- 	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
-- 	vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
-- end

-- vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
local lazygit_big = Terminal:new({
	cmd = "lazygit",
	hidden = true,
	float_opts = { width = 1920, border = "none", height = 1080 },
})

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end
function _LAZYGIT_BIG_TOGGLE()
	lazygit_big:toggle()
end

local npm_start = Terminal:new({ cmd = "npm start", hidden = true })

function _NPM_START()
	npm_start:toggle()
end

local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })

function _NCDU_TOGGLE()
	ncdu:toggle()
end

local htop = Terminal:new({ cmd = "htop", hidden = true })

function _HTOP_TOGGLE()
	htop:toggle()
end

local python = Terminal:new({ cmd = "python", hidden = true })

function _PYTHON_TOGGLE()
	python:toggle()
end

----
local newTerm = Terminal:new({
	hidden = true,
	close_on_exit = false,
	count = 1,
	direction = "horizontal",
	float_opts = {
		border = "double",
	},

	-- function to run on opening the terminal
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.cmd("set winheight=15")
		vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<c-q>", "<cmd>close<CR>", { noremap = true, silent = true })
	end,
	-- function to run on closing the terminal
	on_close = function(term)
		print("Closing terminal")
	end,
})

function _NEW_TERM_TOGGLE()
	newTerm:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>lua _NEW_TERM_TOGGLE()<CR>", { noremap = true, silent = true })

----------

local verticalTerm = Terminal:new({
	hidden = true,
	close_on_exit = false,
	count = 2,
	direction = "vertical",
	float_opts = {
		border = "double",
	},

	-- function to run on opening the terminal
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.cmd("set winwidth=120")
		vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<c-q>", "<cmd>close<CR>", { noremap = true, silent = true })
	end,
	-- function to run on closing the terminal
	on_close = function(term)
		print("Closing terminal")
	end,
})

function _VERTICAL_TERM_TOGGLE()
	verticalTerm:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>T", "<cmd>lua _VERTICAL_TERM_TOGGLE()<CR>", { noremap = true, silent = true })

--------------------- TODO: New Stuff!

local test_new = Terminal:new({
	hidden = true,
	cmd = "nvim -c 'set scl=no' -c 'set scrolloff=2' -c 'set wrap' -c 'set linebreak' -c 'set clipboard=unnamed' ~/.config/nvim/wiki/Todo.wiki",
	close_on_exit = true,
	count = 4,
	direction = "float",
	float_opts = {
		-- border = "double",
		width = 50,
		height = 15,
	},

	-- function to run on opening the terminal
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Tab>", "<cmd>close<CR>", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<cmd>close<CR>", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(term.bufnr, "t", "Q", "<cmd>close<CR>", { noremap = true, silent = true })
	end,
})

function _TEST_TOGGLE()
	test_new:toggle()
end
