local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local nosilent_opts = { noremap = true, silent = false }
local term_opts = { silent = true }

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Commands Remaps
vim.cmd([[:command! Q q]])
vim.cmd([[:command! Qa qa]])
vim.cmd([[:command! QA qa]])

-- Experimental Mappings
keymap("n", "<A-i>", [[<C-i>]], opts)
keymap("n", "<A-o>", [[o<Esc>]], opts)
keymap("n", "<C-o>", [[zM<C-o>]], opts)
keymap("i", "<A-u>", [[<C-o>u]], opts)

-- Paragraph Jump
keymap("n", "}", [[:keepjumps normal! }<cr>]], opts) --> Later will be used for quickfix list
keymap("n", "{", [[:keepjumps normal! {<cr>]], opts)
keymap("n", "<C-j>", [[:keepjumps normal! }<cr>]], opts)
keymap("n", "<C-k>", [[:keepjumps normal! {<cr>]], opts)
keymap("x", "<C-j>", [[<cmd>keepjumps normal! }<cr>]], opts)
keymap("x", "<C-k>", [[<cmd>keepjumps normal! {<cr>]], opts)

-- Change-in Shortcuts
keymap("n", "ck", [[ciq]], term_opts)
keymap("n", "ckk", [[ciq]], term_opts)
keymap("n", "ckj", [[cilq]], term_opts)
keymap("n", "ckl", [[cinq]], term_opts)
keymap("n", "c,", [[cib]], term_opts)
keymap("n", "c,,", [[cib]], term_opts)
keymap("n", "c,j", [[cilb]], term_opts)
keymap("n", "c,l", [[cinb]], term_opts)
keymap("n", "cj", [[ciw]], opts)
keymap("n", "cJ", [[ciW]], opts)

-- Delete Shortcuts
keymap("n", "dl", [[cc<Esc>]], opts)

-- Fold Cycle
-- keymap("n", "<A-l>", [[za]], opts)
-- keymap("n", "<A-h>", [[zc]], opts)
-- keymap("n", "<A-j>", [[zj]], opts)
-- keymap("n", "<A-k>", [[zk]], opts)
keymap("n", "zm", [[zM]], opts)

-- Save and Esc remaps
vim.cmd([[autocmd FileType gitcommit inoremap <buffer> <C-s> <Esc>:wq<CR>]])
vim.cmd([[autocmd FileType gitcommit nnoremap <buffer> <C-s> :wq<CR>]])
keymap("n", "<C-s>", ":w<cr>", opts)
keymap("i", "<C-s>", "<Esc>:w<cr>", opts)

-- Prev / Next Buffer
-- keymap("n", "<S-l>", ":bnext<cr>", opts)
-- keymap("n", "<S-h>", ":bprevious<cr>", opts)
-- keymap("n", "<Tab>", ":bnext<cr>", opts)
-- keymap("n", "<S-Tab>", ":bprevious<cr>", opts)

-- Cursor Movement Mappings
-- keymap("n", "<C-m>", ":call cursor(0, len(getline('.'))/2)<cr>", opts)
-- keymap("n", "<C-m>", "`m", opts)
keymap("v", "<C-u>", "11k", opts)
keymap("v", "<C-d>", "11j", opts)
keymap("n", "<C-u>", "11k", opts)
keymap("n", "<C-d>", "11j", opts)
-- Alt Cursor Movement Mappings
keymap("n", "<A-j>", "3j", opts)
keymap("n", "<A-k>", "3k", opts)
keymap("n", "<A-l>", "4l", opts)
keymap("n", "<A-h>", "4h", opts)

-- Yank / Paste mapping
keymap("n", "yl", "yy", opts)
keymap("n", "yp", "yyp", opts)
keymap("x", "gy", '"*y', opts)
keymap("n", "gp", '"*p', opts)

-- Visual Mode remaps
keymap("n", "vv", "viw", opts)
keymap("n", "vV", "viW", opts)
--
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "p", '"_dP', opts)

--Moving Lines
keymap("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", opts)
keymap("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", opts)
keymap("n", "<A-Down>", ":m .+1<CR>==", opts)
keymap("n", "<A-Up>", ":m .-2<CR>==", opts)
keymap("v", "<A-Down>", "'>+1<CR>gv=gv", opts)
keymap("v", "<A-Up>", "'<-2<CR>gv=gv", opts)

-- w,e,b (Wordwise Motions) remaps
keymap("x", "W", "B", opts)
keymap("x", "E", "W", opts)
keymap("x", "B", "E", opts)
keymap("x", "w", "b", opts)
keymap("x", "e", "w", opts)
keymap("x", "b", "e", opts)
keymap("n", "W", "B", opts)
keymap("n", "E", "W", opts)
keymap("n", "B", "E", opts)
keymap("n", "w", "b", opts)
keymap("n", "e", "w", opts)
keymap("n", "b", "e", opts)

-- Insert Mode Remap
keymap("i", "<A-o>", "<Esc>o", opts) --> new line in insert mode
keymap("i", "<C-u>", "<Esc>viWgUgi", opts) --> go UPPERCASE current word
keymap("i", "<C-j>", "<Down>", opts)
keymap("i", "<C-k>", "<Up>", opts)
keymap("i", "<C-l>", "<Right>", opts)
keymap("i", "<C-h>", "<Left>", opts)

-- Leader Mappings --
keymap("n", "<leader><F12>", ":call EmmetSetup()<cr>", nosilent_opts) --save current session to Session.vim
keymap("n", "<leader>ms", ":mks! ", nosilent_opts) --save current session to Session.vim
keymap("n", "<leader>os", ":so Session.vim<cr>", nosilent_opts) --open Session.vim in working directory
keymap("n", "<leader>R", ":!lua %<cr>", nosilent_opts) --run current .lua file in
keymap("n", "<leader>rr", ":luafile %<cr>", nosilent_opts) --source current lua file for nvim
keymap("n", "<leader>r", ":luafile %<cr>", nosilent_opts) --source current lua file for nvim
keymap("n", "<leader><c-l>", ":LspInfo<cr>", opts) --open LspInfo
keymap("n", "<leader>L", ":LspInstallInfo<cr>", opts) --open LspInfo
keymap("n", "<leader>dd", ":bd<cr>", opts)
keymap("n", "<leader>dD", ":bd!<cr>", opts)
keymap("n", "<leader>d<cr>", ":bd<cr>", opts)
keymap("n", "<leader>da", ":%bd<cr>", opts) -- close all buffers
keymap("n", "<leader>dA", ":%bd|e#<cr>", opts) -- close all buffers but this one
keymap("n", "<leader>q", ":q<cr>", opts) --quit current file

-- Comment with <A-/> --> Remapped AHK for Alacrity <C-/> to <A-/>
keymap("n", "<A-/>", "gcc", term_opts)
keymap("x", "<A-/>", "gc", term_opts)
keymap("i", "<A-/>", "<Esc>gccA", term_opts)
keymap("n", "", "gcc", term_opts)
keymap("i", "", "<Esc>gccA", term_opts)
keymap("x", "", "gc", term_opts)

-- Move Cursor Between Windows
-- keymap("n", "<C-j>", "<c-w>j", opts)
-- keymap("n", "<C-k>", "<c-w>k", opts)
keymap("n", "<C-h>", "<c-w>h", opts)
keymap("n", "<C-l>", "<c-w>l", opts)
-- Resize with arrows
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
-- Terminal Hopping / Mapping
keymap("t", "<C-j>", "<C-\\><C-N><C-W>j", opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-W>k", opts)
keymap("t", "<C-h>", "<C-\\><C-N><C-W>h", opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-W>l", opts)
keymap("t", "<A-l>", "<C-l>", opts) --> clear
keymap("t", "<A-\\>", "<C-l>", opts) --> clear
-- Split Windows
-- keymap("n", "<leader>V", "<c-w>v<c-w>l<:Telescope find_files<cr>", opts)
keymap("n", "<leader>v", "<c-w>v<c-w>l", opts)
-- keymap("n", "<leader>hS", "<c-w>S<c-w>j<:Telescope find_files<cr>", opts)
keymap("n", "<leader>hs", "<c-w>s<c-w>j", opts)

------ Plugins--------
-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
-- Telescope
keymap(
	"n",
	"<C-p>",
	"<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
	opts
)
keymap("n", "<leader>k", ":Telescope keymaps<cr>", opts)
keymap("n", "<leader>he", ":Telescope help_tags<cr>", opts)
keymap("n", "<leader>hi", ":Telescope highlights<cr>", opts)
keymap("n", "<leader>f", ":Telescope find_files<cr>", opts)
keymap("n", "<c-f>", ":Telescope find_files<cr>", opts)
keymap("n", "<leader>g", ":Telescope live_grep<cr>", opts)
keymap("n", "<C-g>", ":lua require('telescope').extensions.live_grep_raw.live_grep_raw()<cr>", opts)
keymap("n", "<leader>b", ":Telescope buffers<cr>", opts)

-- TS Hoppper
keymap("x", "m", ":lua require('tsht').nodes()<CR>", opts)
-- Packer Mappings
-- keymap("n", "<leader>S", ":w\n :luafile %\n :PackerSync<cr>", opts)

-- Toggleterm
keymap("n", "<Leader>G", "<cmd>lua _LAZYGIT_TOGGLE()<cr>", nosilent_opts)
keymap("n", "<Leader><Leader>g", "<cmd>lua _LAZYGIT_BIG_TOGGLE()<cr>", nosilent_opts)
keymap("n", "<Leader><Leader>G", "<cmd>lua _LAZYGIT_BIG_TOGGLE()<cr>", nosilent_opts)
keymap("n", "<Leader>N", "<cmd>lua _NPM_START()<cr>", nosilent_opts)

-- Fugitive +++
-- keymap("n", "<Leader>G", ":G<cr>", nosilent_opts)
-- keymap("n", "<F12><F12>", ":G add .<cr> | :G commit<cr>", nosilent_opts)
-- keymap("n", "<F12>", ":G add .<cr>", nosilent_opts)
-- keymap("n", "<F12><F11>", ":G commit<cr>", nosilent_opts)
-- keymap("n", "<F12><F10>", ":G push<cr> | :redraw!", nosilent_opts)

--- Lightspeed
keymap("n", "s", "<Plug>Lightspeed_omni_s", opts)
keymap("n", "S", "<Plug>Lightspeed_omni_s", opts)
keymap("n", "gS", "<Plug>Lightspeed_omni_gs", opts)
keymap("n", "gs", "<Plug>Lightspeed_omni_gs", opts)

--- Hop
keymap("n", "<Leader>ww", ":HopWordMW<cr>", opts)
keymap("n", "<Leader>W", ":HopWordMW<cr>", opts)
keymap("n", "mw", ":HopWordMW<cr>", opts)

-- Harpoon
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> q :q<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> qq :q<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> Q :q<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> 1 :1<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> 2 :2<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> 3 :3<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> 4 :4<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> 5 :5<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> 6 :6<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> 7 :7<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> 8 :8<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> 9 :9<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> 0 :10<CR>]])

keymap("n", "<S-Tab>", ":lua require('harpoon.mark').add_file()<cr>", opts)
keymap("n", "<Leader>ha", ":lua require('harpoon.mark').add_file()<cr>", opts)
keymap("n", "<Tab>", ":lua require('harpoon.ui').toggle_quick_menu()<cr>", opts)
keymap("n", "<Leader>1", ":lua require('harpoon.ui').nav_file(1)<cr>", opts)
keymap("n", "<Leader>2", ":lua require('harpoon.ui').nav_file(2)<cr>", opts)
keymap("n", "<Leader>3", ":lua require('harpoon.ui').nav_file(3)<cr>", opts)
keymap("n", "<Leader>4", ":lua require('harpoon.ui').nav_file(4)<cr>", opts)
keymap("n", "<Leader>5", ":lua require('harpoon.ui').nav_file(5)<cr>", opts)
keymap("n", "<Leader>6", ":lua require('harpoon.ui').nav_file(6)<cr>", opts)
keymap("n", "<Leader>7", ":lua require('harpoon.ui').nav_file(7)<cr>", opts)
keymap("n", "<Leader>8", ":lua require('harpoon.ui').nav_file(8)<cr>", opts)
keymap("n", "<Leader>9", ":lua require('harpoon.ui').nav_file(9)<cr>", opts)
keymap("n", "<Leader>0", ":lua require('harpoon.ui').nav_file(10)<cr>", opts)

-- Surround shortcuts
keymap("n", "d[", ":norm ds{<cr>", opts)
