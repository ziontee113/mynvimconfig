local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local nosilent_opts = { noremap = true, silent = false }
local term_opts = { silent = true }

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Save and Esc remaps
keymap("n", "<C-s>", ":w<cr>", opts)
keymap("i", "<C-s>", "<Esc>:w<cr>", opts)
--keymap("i", "jk", "<Esc>", opts)
--keymap("i", "jj", "<Esc>", opts)
--keymap("i", "kk", "<Esc>", opts)

-- Prev / Next Buffer
keymap("n", "<Tab>", ":bnext<cr>", opts)
keymap("n", "<S-Tab>", ":bprevious<cr>", opts)
keymap("n", "<S-h>", ":bnext<cr>", opts)
keymap("n", "<S-l>", ":bprevious<cr>", opts)

-- Cursor Movement Mappings
keymap("n", "<C-m>", ":call cursor(0, len(getline('.'))/2)<cr>", opts)
--keymap("n", "<A-J>", "2<C-e>jj", opts) --> these motions brings motion sickness
--keymap("n", "<A-K>", "2<C-y>kk", opts)
--keymap("n", "<A-J>", "2jzz", opts)
--keymap("n", "<A-K>", "2kzz", opts)
keymap("n", "<A-j>", "3j", opts)
keymap("n", "<A-k>", "3k", opts)

-- New Lines in Normal Mode
keymap("n", "<A-o>", "o<Esc>", opts)
keymap("n", "<A-O>", "O<Esc>", opts)

-- Yank / Paste mapping
keymap("n", "yp", "yyp", opts)
keymap("n", "gy", '"*y', opts)
keymap("n", "gp", '"*p', opts)

-- Visual Mode remaps
keymap("n", "vv", "viw", opts)
keymap("n", "vV", "viW", opts)
--
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "p", "'_dP", opts)

--Moving Lines
keymap("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", opts)
keymap("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", opts)
keymap("n", "<A-Down>", ":m .+1<CR>==", opts)
keymap("n", "<A-Up>", ":m .-2<CR>==", opts)
keymap("v", "<A-Down>", "'>+1<CR>gv=gv", opts)
keymap("v", "<A-Up>", "'<-2<CR>gv=gv", opts)

-- w,e,b (Wordwise Motions) remaps
keymap("v", "W", "B", opts)
keymap("v", "E", "W", opts)
keymap("v", "B", "E", opts)
keymap("v", "w", "b", opts)
keymap("v", "e", "w", opts)
keymap("v", "b", "e", opts)
keymap("n", "W", "B", opts)
keymap("n", "E", "W", opts)
keymap("n", "B", "E", opts)
keymap("n", "w", "b", opts)
keymap("n", "e", "w", opts)
keymap("n", "b", "e", opts)

-- Insert Mode Remap
keymap("i", "<C-u>", "<Esc>viWgUgi", opts) --> go UPPERCASE current word
keymap("i", "<C-l>", "<right>", opts)
keymap("i", "<C-h>", "<left>", opts)

-- Leader Mappings --
keymap("n", "<leader>ms", ":mks! ", nosilent_opts) --save current session to Session.vim
keymap("n", "<leader>os", ":so Session.vim<cr>", nosilent_opts) --open Session.vim in working directory
keymap("n", "<leader>R", ":!lua %<cr>", nosilent_opts) --run current .lua file in
keymap("n", "<leader>rr", ":luafile %<cr>", nosilent_opts) --source current lua file for nvim
keymap("n", "<leader>r", ":luafile %<cr>", nosilent_opts) --source current lua file for nvim
keymap("n", "<leader>l", ":LspInfo<cr>", opts) --open LspInfo
keymap("n", "<leader>L", ":LspInstallInfo<cr>", opts) --open LspInfo
keymap("n", "<leader>d", ":bd<cr>", opts) --quit current file
keymap("n", "<leader>q", ":q<cr>", opts) --quit current file

-- Move Cursor Between Windows
keymap("n", "<C-j>", "<c-w>j", opts)
keymap("n", "<C-k>", "<c-w>k", opts)
keymap("n", "<C-h>", "<c-w>h", opts)
keymap("n", "<C-l>", "<c-w>l", opts)
-- Terminal Hopping / Mapping
keymap("t", "<C-j>", "<C-\\><C-N><C-W>j", opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-W>k", opts)
keymap("t", "<C-h>", "<C-\\><C-N><C-W>h", opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-W>l", opts)
keymap("t", "<A-l>", "<C-l>", opts) --> clear
-- Split Windows
keymap("n", "<leader>V", "<c-w>v<c-w>l<:Telescope find_files<cr>", opts)
keymap("n", "<leader>v", "<c-w>v<c-w>l", opts)
keymap("n", "<leader>S", "<c-w>S<c-w>j<:Telescope find_files<cr>", opts)
keymap("n", "<leader>s", "<c-w>s<c-w>j", opts)

------ Plugins--------
-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
-- Telescope
keymap(
	"n",
	"<leader>F",
	"<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
	opts
)
keymap("n", "<leader>f", ":Telescope find_files<cr>", opts)
keymap("n", "<c-p>", ":Telescope find_files<cr>", opts)
keymap("n", "<c-g>", ":Telescope live_grep<cr>", opts)
keymap("n", "<c-f>", ":Telescope find_files<cr>", opts)
keymap("n", "<leader>g", ":Telescope live_grep<cr>", opts)
keymap("n", "<leader>b", ":Telescope buffers<cr>", opts)
-- Packer Mappings
keymap("n", "<leader>S", ":w\n :luafile %\n :PackerSync<cr>", opts)
