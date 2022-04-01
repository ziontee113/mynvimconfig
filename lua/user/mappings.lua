local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local nosilent_opts = { noremap = true, silent = false }
local term_opts = { silent = true }

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Experimental Mappings
keymap("n", "<A-i>", [[<C-i>]], opts)
keymap("n", "<A-o>", [[<C-o>]], opts)
-- keymap("n", "o", [[o<Esc>cc]], opts)
-- keymap("n", "O", [[O<Esc>cc]], opts)

-- Change-in Shortcuts
keymap("n", "ck", [[ciq]], term_opts)
keymap("n", "ckk", [[ciq]], term_opts)
keymap("n", "ckj", [[cilq]], term_opts)
keymap("n", "ckl", [[cinq]], term_opts)
keymap("n", "c,", [[cib]], term_opts)
keymap("n", "cj", [[ciw]], opts)
keymap("n", "cJ", [[ciW]], opts)

-- Delete Shortcuts
keymap("n", "dl", [[dd]], opts)

-- Fold Cycle
keymap("n", "<A-l>", [[za]], opts)
keymap("n", "<A-h>", [[zc]], opts)
keymap("n", "<A-j>", [[zj]], opts)
keymap("n", "<A-k>", [[zk]], opts)
keymap("n", "zm", [[zM]], opts)

-- Save and Esc remaps
keymap("n", "<C-s>", ":w<cr>", opts)
keymap("i", "<C-s>", "<Esc>:w<cr>", opts)

-- Prev / Next Buffer
keymap("n", "<S-l>", ":bnext<cr>", opts)
keymap("n", "<S-h>", ":bprevious<cr>", opts)
keymap("n", "<Tab>", ":bnext<cr>", opts)
keymap("n", "<S-Tab>", ":bprevious<cr>", opts)

-- Cursor Movement Mappings
-- keymap("n", "<C-m>", ":call cursor(0, len(getline('.'))/2)<cr>", opts)
-- keymap("n", "<C-m>", "`m", opts)
keymap("v", "<C-u>", "11k", opts)
keymap("v", "<C-d>", "11j", opts)
keymap("n", "<C-u>", "11k", opts)
keymap("n", "<C-d>", "11j", opts)

-- Yank / Paste mapping
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
keymap("n", "<leader>d", ":bd<cr>", opts) --quit current file
keymap("n", "<leader>q", ":q<cr>", opts) --quit current file

-- Comment with <A-/> --> Remapped AHK for Alacrity <C-/> to <A-/>
keymap("n", "<A-/>", "gcc", term_opts)
keymap("x", "<A-/>", "gc", term_opts)
keymap("i", "<A-/>", "<Esc>gccA", term_opts)
keymap("n", "", "gcc", term_opts)
keymap("i", "", "<Esc>gccA", term_opts)
keymap("x", "", "gc", term_opts)

-- Move Cursor Between Windows
keymap("n", "<C-j>", "<c-w>j", opts)
keymap("n", "<C-k>", "<c-w>k", opts)
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
	"<C-p>",
	"<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
	opts
)
keymap("n", "<leader>k", ":Telescope keymaps<cr>", opts)
keymap("n", "<leader>h", ":Telescope help_tags<cr>", opts)
keymap("n", "<leader>f", ":Telescope find_files<cr>", opts)
keymap("n", "<c-f>", ":Telescope find_files<cr>", opts)
keymap("n", "<leader>g", ":Telescope live_grep<cr>", opts)
keymap("n", "<C-g>", ":lua require('telescope').extensions.live_grep_raw.live_grep_raw()<cr>", opts)
keymap("n", "<leader>b", ":Telescope buffers<cr>", opts)
-- Hop
keymap("x", ",", "<cmd>HopWord<cr>", opts)
keymap("n", ",", "<cmd>HopWord<cr>", opts)
keymap("n", ";", "<cmd>HopLineStart<cr>", opts)
keymap("x", ";", "<cmd>HopLineStart<cr>", opts)
keymap("n", "<leader>l", "<cmd>HopLineStart<cr>", opts)
keymap("n", "<leader>W", "<cmd>HopWordMW<cr>", opts)
keymap("n", "f", "<cmd>HopChar1<cr>", opts)
keymap("n", "F", "<cmd>HopChar1MW<cr>", opts)
keymap("o", "t", "<cmd>HopChar1CurrentLineAC<cr>", opts)
keymap("o", "T", "<cmd>HopChar1CurrentLineBC<cr>", opts)
keymap(
	"o",
	"f",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
	opts
)
keymap(
	"o",
	"F",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = false })<cr>",
	opts
)
-- keymap("n", "<leader>H", "<cmd>lua require'hop'.hint_patterns({}, vim.fn['getreg']('/'))<cr>", opts) --> will come to use later
keymap("n", "<leader>H", "<cmd>lua require'hop'.hint_patterns({}, [[\\d\\+]])<cr>", opts)
-- TS Hoppper
keymap("v", "m", ":lua require('tsht').nodes()<CR>", opts)
-- Packer Mappings
keymap("n", "<leader>S", ":w\n :luafile %\n :PackerSync<cr>", opts)

-- Fugitive
keymap("n", "<Leader>G", ":G<cr>", opts)
