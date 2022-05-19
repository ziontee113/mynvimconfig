local set = vim.opt

vim.cmd([[ set foldmethod=marker ]])

set.number = false
set.relativenumber = false
-- set.number = true
-- set.relativenumber = true
set.expandtab = true
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
vim.cmd([[set guicursor=n-v-c:block-Cursor]])

vim.cmd([[au BufEnter * :set formatoptions-=cro]])

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

set.timeoutlen = 1000
set.cursorline = true

set.showmode = false

vim.wo.signcolumn = "yes"
vim.cmd([[:colorscheme gruvbox]])
-- vim.cmd([[:colorscheme tokyonight]])
vim.cmd([[:highlight SignColumn guibg=NONE]])

-- Wez Term
vim.cmd("hi Normal guibg=NONE ctermbg=NONE") --transparent Document bg-color
vim.cmd([[set mouse=a]])

-- for Gitsigns & LSP Diagnostics
vim.o.signcolumn = "yes:2"

-- Fold
-- vim.cmd([[set fdc=1]])
-- vim.cmd([[hi FoldColumn guibg=none guifg=#008cff]])
vim.cmd([[hi FoldColumn guibg=none guifg=#262626]])
vim.cmd([[:hi Folded guibg=NONE]])

-- Text Yank Post
vim.cmd([[
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=200}
augroup END
]])

-- Markdown Previewer
vim.cmd([[let g:mkdp_auto_close = 0]])

-- -- Zen Mode auto in
-- vim.cmd([[ au VimEnter * silent! ZenMode]])

-- Runtime Path
vim.cmd([[set runtimepath+=~/.config/nvim/lua/myPlugs/syntax-tree-surfer/]])
vim.cmd([[set runtimepath+=~/.config/nvim/lua/myPlugs/supporting-acctress/]])

-- LSP Help Background
vim.cmd([[:hi NormalFloat guibg=NONE]])
vim.cmd([[:hi PMenu guibg=NONE]])
-- vim.cmd([[:hi FloatBorder guibg=NONE]])

vim.cmd(":hi MsgArea guifg=#008cff")
-- vim.cmd(":hi MsgArea guifg=skyblue")
