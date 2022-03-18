local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local nosilent_opts = { noremap = true, silent = false }
local term_opts = { silent = true }

vim.g.mapleader = " "

-- Save and Esc remaps
keymap("n", "<C-s>", ":w<cr>", opts)
--keymap("i", "jj", "<Esc>", opts)
--keymap("i", "kk", "<Esc>", opts)
keymap("i", "<C-s>", "<Esc>:w<cr>", opts)

keymap("n", "<C-m>", ":call cursor(0, len(getline('.'))/2)<cr>", opts)

-- New Lines in Normal Mode
keymap("n", "<A-o>", "o<Esc>", opts)
keymap("n", "<A-O>", "O<Esc>", opts)

-- Yank / Paste mapping
keymap("n", "yp", "yyp", opts)
keymap("n", "gy", '"*y', opts)
keymap("n", "gp", '"*p', opts)

-- Visual Mode remaps
keymap("n", "vv", "viw", opts)

-- w,e,b (Words) remaps
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

-- Comment Remaps
keymap("n", "<C-_>", "gcc", term_opts)
keymap("i", "<C-_>", "<Esc>gcc", term_opts)
keymap("v", "<C-_>", "gc", term_opts)

-- Insert Mode Remap
keymap("i", "<C-u>", "<Esc>viWgUWa", opts) --> go UPPERCASE current word
keymap("i", "<C-l>", "<right>", opts)
keymap("i", "<C-h>", "<left>", opts)

-- Move Cursor Between Windows
keymap("n", "<C-j>", "<c-w>j", opts)
keymap("n", "<C-k>", "<c-w>k", opts)
keymap("n", "<C-h>", "<c-w>h", opts)
keymap("n", "<C-l>", "<c-w>l", opts)
-- Split Windows w/ Leader Key
keymap("n", "<leader>V", "<c-w>v<c-w>l<:Telescope find_files<cr>", opts)
keymap("n", "<leader>v", "<c-w>v<c-w>l", opts)
keymap("n", "<leader>S", "<c-w>S<c-w>j<:Telescope find_files<cr>", opts)
keymap("n", "<leader>s", "<c-w>s<c-w>j", opts)

------ Plugins & Leader --------

-- Leader Remaps
keymap("n", "<leader>ms", ":mks! ", nosilent_opts)
keymap("n", "<leader>os", ":so Session.vim<cr>", nosilent_opts)
keymap("n", "<leader>R", ":!lua %<cr>", nosilent_opts) --source current lua file
keymap("n", "<leader>rr", ":luafile %<cr>", nosilent_opts) --source current lua file
keymap("n", "<leader>r", ":luafile %<cr>", nosilent_opts) --source current lua file
keymap("n", "<leader>l", ":LspInfo<cr>", opts) --open LspInfo
keymap("n", "<leader>q", ":q<cr>", opts) --quit current file
-- NvimTreeToggle & Telescope
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
keymap("n", "<leader>f", ":Telescope find_files<cr>", opts)
keymap("n", "<c-p>", ":Telescope find_files<cr>", opts)
keymap("n", "<c-g>", ":Telescope live_grep<cr>", opts)
keymap("n", "<c-f>", ":Telescope find_files<cr>", opts)
keymap("n", "<leader>g", ":Telescope live_grep<cr>", opts)
keymap("n", "<leader>b", ":Telescope buffers<cr>", opts)
keymap("n", "<leader>S", ":luafile %\n :PackerSync<cr>", opts)
