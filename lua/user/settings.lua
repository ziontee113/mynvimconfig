local set = vim.opt

set.number = true
set.relativenumber = true
set.cursorline = false

set.expandtab = true
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2

vim.wo.signcolumn = "yes"
vim.cmd[[:colorscheme gruvbox]]
vim.cmd[[:highlight SignColumn guibg=NONE]]

set.hlsearch = false
set.ignorecase = true
set.smartcase = true

set.wrap = false
set.scrolloff = 8

set.fileencoding = "utf-8"
set.termguicolors = true

set.swapfile = false
set.backup = false
set.hidden = true
set.undofile = true

set.splitright = true
set.splitbelow = true
