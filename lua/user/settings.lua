local set = vim.opt

-- Fold
vim.cmd([[set foldmethod=manual]])
vim.cmd([[
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
]])

set.number = true
set.relativenumber = true
set.cursorline = false
set.expandtab = true
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
vim.cmd([[set guicursor=n-v-c:block-Cursor]])

vim.cmd([[au BufEnter * :set formatoptions-=cro]])

-- vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_italic_functions = true
-- vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
-- vim.cmd([[:colorscheme tokyonight]])

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

-- set.timeoutlen = 500
set.timeoutlen = 1000
set.cursorline = true

set.showmode = false
-- vim.cmd([[:set cmdheight=2]])

vim.wo.signcolumn = "yes"
vim.cmd([[:colorscheme gruvbox]])
vim.cmd([[:highlight SignColumn guibg=NONE]])

-- Wez Term
vim.cmd("hi Normal guibg=NONE ctermbg=NONE") --transparent Document bg-color
vim.cmd([[set mouse=a]])

-- for Gitsigns & LSP Diagnostics
vim.o.signcolumn = "yes:2"

-- Fold
vim.cmd([[set fdc=1]])
vim.cmd([[hi FoldColumn guibg=none guifg=#008cff]])
vim.cmd([[:hi Folded guibg=NONE]])

-- -- Codi Text Color
-- vim.cmd([[hi CodiVirtualText guifg=skyblue]])
-- vim.cmd([[
-- let g:codi#width=80
-- ]])

-- Text Yank Post
vim.cmd([[
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=200}
augroup END
]])

-- Markdown Previewer
vim.cmd([[let g:mkdp_auto_close = 0]])

-- Runtime Path
vim.cmd([[set runtimepath+=~/.config/nvim/lua/myPlugs/syntax-tree-surfer/]])
