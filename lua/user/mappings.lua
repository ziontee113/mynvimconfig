local function base_map(lhs)
	return function(mode)
		return function(rhs)
			vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = true })
		end
	end
end

function _G.nnoremap(lhs)
	return base_map(lhs)("")
end
function _G.inoremap(lhs)
	return base_map(lhs)("i")
end

--------------------------------------------------------------------------------

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local nosilent_opts = { noremap = true, silent = false }
local term_opts = { silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Commands Remaps
vim.cmd([[:command! Q q]])
vim.cmd([[:command! Qa qa]])
vim.cmd([[:command! QA qa]])

-- Experimental Mappings
keymap("n", "co", "o<Esc>c0", opts)
keymap("n", "<Leader>o", "2o<Esc>i", opts)
keymap("n", "<Leader>O", "O<Esc>O", opts)
keymap("n", "<Leader><Leader>o", "o<Esc>O", opts)
keymap("n", "<Leader><Leader>O", "O<Esc>o", opts)
keymap("n", "<F31>", "<C-i>", opts) --> Ctrl + F7 for Wezterm
keymap("n", "<A-,>", "owe will use this keymap for the great purpose<Esc>", opts) --> Ctrl + F7 for Wezterm

keymap("n", "<Leader><Leader>\\", ":Twilight<cr>", opts) --> Twilight
keymap("n", "<Leader>-", ":set number! | set relativenumber! | set signcolumn:no | set cursorline!<cr>", opts) --> Twilight
keymap("n", "<Leader><Leader>-", ":set signcolumn:yes:2<cr>", opts) --> Twilight

-- Experimental Mappings
keymap("n", "<A-i>", [[<C-i>]], opts)
keymap("n", "<A-o>", [[o<Esc>]], opts)
-- keymap("n", "<C-o>", [[zM<C-o>]], opts)
keymap("i", "<A-u>", [[<C-o>u]], opts)
-- keymap("n", "<S-y>", "J", opts)
-- keymap(
-- 	"n",
-- 	"'",
-- 	[[<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>]],
-- 	opts
-- )
vim.cmd([[autocmd FileType TelescopePrompt inoremap <silent> <buffer> kk <Esc>]])

-- Javascript Mappings
vim.cmd([[autocmd FileType javascript inoremap <silent> <buffer> SS >]])
vim.cmd([[autocmd FileType javascript inoremap <silent> <buffer> SA >=]])
vim.cmd([[autocmd FileType javascript inoremap <silent> <buffer> AA <]])
vim.cmd([[autocmd FileType javascript inoremap <silent> <buffer> AS <=]])
vim.cmd([[autocmd FileType javascript inoremap <silent> <buffer> EE ===]])
vim.cmd([[autocmd FileType javascript inoremap <silent> <buffer> ER !==]])

-- Markdown / PlantUML Mappings
vim.cmd([[autocmd FileType plantuml nnoremap <silent> <buffer> ' I'<Esc>]])
vim.cmd([[autocmd FileType markdown nnoremap <silent> <buffer> ' I'<Esc>]])

vim.cmd([[autocmd FileType plantuml nnoremap <silent> <buffer> <F12> :set filetype=markdown<CR>]])
vim.cmd([[autocmd FileType plantuml nnoremap <silent> <buffer> <F11> :set filetype=plantuml<CR>]])
vim.cmd([[autocmd FileType plantuml nnoremap <silent> <buffer> <F10> :set filetype=mermaid<CR>]])
vim.cmd([[autocmd FileType markdown nnoremap <silent> <buffer> <F12> :set filetype=markdown<CR>]])
vim.cmd([[autocmd FileType markdown nnoremap <silent> <buffer> <F11> :set filetype=plantuml<CR>]])
vim.cmd([[autocmd FileType markdown nnoremap <silent> <buffer> <F10> :set filetype=mermaid<CR>]])
vim.cmd([[autocmd FileType mermaid nnoremap <silent> <buffer> <F12> :set filetype=markdown<CR>]])
vim.cmd([[autocmd FileType mermaid nnoremap <silent> <buffer> <F11> :set filetype=plantuml<CR>]])
vim.cmd([[autocmd FileType mermaid nnoremap <silent> <buffer> <F10> :set filetype=mermaid<CR>]])

-- Paragraph Jump
keymap("n", "}", [[:keepjumps normal! }<cr>]], opts) --> Later will be used for quickfix list
keymap("n", "{", [[:keepjumps normal! {<cr>]], opts)

keymap("n", "<C-j>", [[:keepjumps normal! j}k<cr>]], opts)
keymap("n", "<C-k>", [[:keepjumps normal! k{j<cr>]], opts)
-- keymap("n", "<A-j>", [[:keepjumps normal! }<cr>]], opts)
-- keymap("n", "<A-k>", [[:keepjumps normal! {<cr>]], opts)
keymap("n", "<A-j>", [[10j]], opts)
keymap("n", "<A-k>", [[10k]], opts)
-- keymap("x", "<C-j>", [[<cmd>keepjumps normal! }<cr>]], opts)
-- keymap("x", "<C-k>", [[<cmd>keepjumps normal! {<cr>]], opts)
keymap("x", "<C-j>", [[<cmd>keepjumps normal! j}k<cr>]], opts)
keymap("x", "<C-k>", [[<cmd>keepjumps normal! k{j<cr>]], opts)

--------------------------------------------------------------------------------

-- Change-in Shortcuts --> We need more of this for lightning speed editting

-- keymap("n", "ck", [[ciq]], term_opts)
keymap("n", "ckk", [[ciq]], term_opts)
keymap("n", "ckj", [[cilq]], term_opts)
keymap("n", "ckh", [[c2ilq]], term_opts)
keymap("n", "ckg", [[c3ilq]], term_opts)
keymap("n", "ckl", [[cinq]], term_opts)
keymap("n", "ck;", [[c2inq]], term_opts)
keymap("n", "ck'", [[c3inq]], term_opts)

-- keymap("n", "c,", [[cib]], term_opts)
keymap("n", "c,,", [[cib]], term_opts)
keymap("n", "c,j", [[cilb]], term_opts)
keymap("n", "c,h", [[c2ilb]], term_opts)
keymap("n", "c,g", [[c3ilb]], term_opts)
keymap("n", "c,l", [[cinb]], term_opts)
keymap("n", "c,;", [[c2inb]], term_opts)
keymap("n", "c,'", [[c3inb]], term_opts)

keymap("n", "cj", [[ciw]], opts)
keymap("n", "cJ", [[ciW]], opts)

--------------------------------------------------------------------------------

-- Delete Shortcuts
keymap("n", "dl", [[cc<Esc>]], opts)

-- Fold Cycle
-- keymap("n", "<A-l>", [[za]], opts)
-- keymap("n", "<A-h>", [[zc]], opts)
-- keymap("n", "<A-j>", [[zj]], opts)
-- keymap("n", "<A-k>", [[zk]], opts)
keymap("n", "zm", [[zM]], opts)
keymap("n", "zp", [[vipzf]], opts)

-- Save and Esc remaps
vim.cmd([[autocmd FileType gitcommit inoremap <buffer> <C-s> <Esc>:wq<CR>]])
vim.cmd([[autocmd FileType gitcommit nnoremap <buffer> <C-s> :wq<CR>]])
keymap("n", "<C-s>", ":w<cr>", opts)
keymap("i", "<C-s>", "<Esc>:w<cr>", opts)

-- Prev / Next Buffer
keymap("n", "<S-l>", ":bnext<cr>", opts)
keymap("n", "<S-h>", ":bprevious<cr>", opts)
-- keymap("n", "<Tab>", ":bnext<cr>", opts)
-- keymap("n", "<S-Tab>", ":bprevious<cr>", opts)

-- Cursor Movement Mappings
-- keymap("n", "<C-m>", ":call cursor(0, len(getline('.'))/2)<cr>", opts)
-- keymap("n", "<C-m>", "`m", opts)
keymap("v", "<C-u>", "11k", opts)
keymap("v", "<C-d>", "11j", opts)
keymap("n", "<C-u>", "11k", opts)
keymap("n", "<C-d>", "11j", opts)

-- Alt Cursor Movement Mappings - Normal Mode
-- keymap("n", "<A-j>", "3j", opts)
-- keymap("n", "<A-k>", "3k", opts)
-- keymap("n", "<A-l>", "4l", opts)
-- keymap("n", "<A-h>", "4h", opts)

-- Quickfix List movement
keymap("n", "<A-h>", ":cprev<cr>", opts)
keymap("n", "<A-l>", ":cnext<cr>", opts)
keymap("n", "<C-q>", ":call ToggleQuickFix()<cr>", opts)
keymap("n", "<S-q>", ":call ToggleLocationList()<cr>", opts)
vim.cmd([[
function! ToggleQuickFix()
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
  else
    cclose
  endif
endfunction

function! ToggleLocationList()
  if empty(filter(getwininfo(), 'v:val.loclist'))
    lopen
  else
    lclose
  endif
endfunction
]])

-- Yank / Paste mapping keymap("n", "yad", ":% y<cr>", opts)
keymap("n", "yl", "yy", opts)
keymap("n", "yp", "yyp", opts)
keymap("n", "gy", '"*yy', opts)
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
keymap("n", "w", "b", opts)
keymap("n", "b", "w", opts)
keymap("n", "W", "B", opts)
keymap("n", "B", "W", opts)
keymap("x", "w", "b", opts)
keymap("x", "b", "w", opts)
keymap("x", "W", "B", opts)
keymap("x", "B", "W", opts)

-- Insert Mode Remap
keymap("i", "<C-u>", "<Esc>viWgUgi", opts) --> go UPPERCASE current word
-- keymap("i", "<C-j>", "<Down>", opts)
-- keymap("i", "<C-k>", "<Up>", opts)
keymap("i", "<C-l>", "<Right>", opts)
keymap("i", "<C-h>", "<Left>", opts)
keymap("i", "<C-f>", "<C-Right>", opts)
keymap("i", "<C-d>", "<C-Left>", opts)

-- Leader Mappings --
keymap("n", "<leader><F12>", ":call EmmetSetup()<cr>", nosilent_opts) --save current session to Session.vim
keymap("n", "<leader>ms", ":mks! ", nosilent_opts) --save current session to Session.vim
keymap("n", "<leader><Leader>s", ":so Session.vim<cr>", nosilent_opts) --open Session.vim in working directory
-- keymap("n", "<leader>R", ":!lua %<cr>", opts) --run current .lua file in
vim.cmd([[autocmd FileType lua nnoremap <silent> <buffer> <leader>R :!lua %<cr>]])
vim.cmd([[autocmd FileType lua nnoremap <silent> <buffer> <leader>rr :luafile %<cr>]])
vim.cmd([[autocmd FileType javascript nnoremap <silent> <buffer> <leader>R :!node %<cr>]])
vim.cmd([[autocmd FileType javascript nnoremap <silent> <buffer> <leader>rr :!node %<cr>]])
-- keymap("n", "<leader>rr", ":luafile %<cr>", nosilent_opts) --source current lua file for nvim
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
keymap("n", "gO", "gcO", term_opts)
keymap("n", "gA", "gcA", term_opts)
-- More comment remaps
keymap("x", "z/", "gc", term_opts)
keymap("x", "<Leader>/", "gc", term_opts)

-- Move Cursor Between Windows
-- keymap("n", "<C-j>", "<c-w>j", opts)
-- keymap("n", "<C-k>", "<c-w>k", opts)
keymap("n", "<C-h>", "<c-w>h", opts)
keymap("n", "<C-l>", "<c-w>l", opts)
-- Resize with arrows
-- keymap("n", "<C-Down>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +5<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -5<CR>", opts)
-- Terminal Hopping / Mapping
-- keymap("t", "<C-j>", "<C-\\><C-N><C-W>j", opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-W>k", opts)
-- keymap("t", "<C-h>", "<C-\\><C-N><C-W>h", opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-W>l", opts)
-- keymap("t", "<A-l>", "<C-l>", opts) --> clear
-- keymap("t", "<A-\\>", "<C-l>", opts) --> clear
-- Split Windows
-- keymap("n", "<leader>V", "<c-w>v<c-w>l<:Telescope find_files<cr>", opts)
keymap("n", "<leader>v", "<c-w>v<c-w>l", opts)
-- keymap("n", "<leader>hS", "<c-w>S<c-w>j<:Telescope find_files<cr>", opts)
keymap("n", "<leader>hs", "<c-w>s<c-w>j", opts)

------ Plugins--------
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
keymap("n", "<c-f>", ":Telescope find_files<cr>", opts)
keymap("n", "<leader>g", ":Telescope live_grep<cr>", opts)
keymap("n", "<C-g>", ":lua require('telescope').extensions.live_grep_raw.live_grep_raw()<cr>", opts)
keymap("n", "<leader>b", ":Telescope buffers<cr>", opts)
keymap("n", "<leader>f", ":Telescope find_files<cr>", opts)
-- keymap("n", "<leader>zf", ":Telescope current_buffer_fuzzy_find<cr>", opts)
-- keymap("n", "<leader>wo", ":Telescope grep_string<cr>", opts)

keymap("n", "<leader><C-p>", ":lua require('user.telescope-custom-pickers').vimrc_find_files()<cr>", opts)
keymap("n", "<leader><leader>g", ":lua require('user.telescope-custom-pickers').vimrc_live_grep()<cr>", opts)

-- TS Hoppper
keymap("x", "m", ":lua require('tsht').nodes()<CR>", opts)
-- Packer Mappings
-- keymap("n", "<leader>S", ":w\n :luafile %\n :PackerSync<cr>", opts)

-- Toggleterm
keymap("n", "<Leader>G", "<cmd>lua _LAZYGIT_TOGGLE()<cr>", nosilent_opts)
keymap("n", "<Leader><C-g>", "<cmd>lua _LAZYGIT_BIG_TOGGLE()<cr>", nosilent_opts)
keymap("n", "<Leader>N", "<cmd>lua _NPM_START()<cr>", nosilent_opts)
keymap("n", "<Leader>X", "<cmd>lua _TEST_TOGGLE()<cr>", nosilent_opts)
keymap("n", "<S-Tab>", "<cmd>lua _TEST_TOGGLE()<cr>", opts)

--- Lightspeed
keymap("x", "s", "<Plug>Lightspeed_omni_s", opts)
keymap("n", "s", "<Plug>Lightspeed_omni_s", opts)
keymap("n", "S", "<Plug>Lightspeed_omni_s", opts)
keymap("n", "gS", "<Plug>Lightspeed_omni_gs", opts)
keymap("n", "gs", "<Plug>Lightspeed_omni_gs", opts)
-- keymap("n", "<leader>s", "<Plug>Lightspeed_omni_gs", opts)

--- Hop
-- keymap("n", "<Leader>ww", ":HopWordMW<cr>", opts)
-- keymap("n", "<Leader>W", ":HopWordMW<cr>", opts)
-- keymap("n", "mw", ":HopWordMW<cr>", opts)
-- vim.cmd([[autocmd FileType markdown nnoremap <silent> <buffer> q <cmd>HopLineStart<CR>]])

-- Harpoon
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> <Tab> :q<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> q :q<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> Q :q<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> 1 <CMD>lua require('harpoon.ui').nav_file(11)<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> 2 <CMD>lua require('harpoon.ui').nav_file(12)<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> 3 <CMD>lua require('harpoon.ui').nav_file(13)<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> 4 <CMD>lua require('harpoon.ui').nav_file(14)<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> 5 <CMD>lua require('harpoon.ui').nav_file(15)<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> 6 <CMD>lua require('harpoon.ui').nav_file(16)<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> 7 <CMD>lua require('harpoon.ui').nav_file(17)<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> 8 <CMD>lua require('harpoon.ui').nav_file(18)<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> 9 <CMD>lua require('harpoon.ui').nav_file(19)<CR>]])
vim.cmd([[autocmd FileType harpoon nnoremap <silent> <buffer> 0 <CMD>lua require('harpoon.ui').nav_file(20)<CR>]])

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

-- SnipRun
keymap("n", "<leader>ru", "<cmd>QuickRun<cr>", opts)
keymap("n", "R", "<cmd>QuickRun<cr>", opts)
vim.cmd([[autocmd FileType quickrun :vertical resize 60]])
vim.cmd([[autocmd FileType quickrun nnoremap <silent> <buffer> 6 :vertical resize 30<CR>]])
vim.cmd([[autocmd FileType quickrun nnoremap <silent> <buffer> 5 :vertical resize 40<CR>]])
vim.cmd([[autocmd FileType quickrun nnoremap <silent> <buffer> 4 :vertical resize 60<CR>]])
vim.cmd([[autocmd FileType quickrun nnoremap <silent> <buffer> 3 :vertical resize 80<CR>]])
vim.cmd([[autocmd FileType quickrun nnoremap <silent> <buffer> 2 :vertical resize 100<CR>]])
vim.cmd([[autocmd FileType quickrun nnoremap <silent> <buffer> 1 :vertical resize 120<CR>]])

-- Syntax Tree Surfer
keymap("n", "vd", '<cmd>lua require("syntax-tree-surfer").move("n", false)<cr>', opts)
keymap("n", "vu", '<cmd>lua require("syntax-tree-surfer").move("n", true)<cr>', opts)

keymap("n", "vx", '<cmd>lua require("syntax-tree-surfer").select()<cr>', opts)
keymap("n", "vn", '<cmd>lua require("syntax-tree-surfer").select_current_node()<cr>', opts)

keymap("x", "J", '<cmd>lua require("syntax-tree-surfer").surf("next", "visual")<cr>', opts)
keymap("x", "K", '<cmd>lua require("syntax-tree-surfer").surf("prev", "visual")<cr>', opts)
keymap("x", "H", '<cmd>lua require("syntax-tree-surfer").surf("parent", "visual")<cr>', opts)
keymap("x", "L", '<cmd>lua require("syntax-tree-surfer").surf("child", "visual")<cr>', opts)

keymap("x", "<A-j>", '<cmd>lua require("syntax-tree-surfer").surf("next", "visual", true)<cr>', opts)
keymap("x", "<A-k>", '<cmd>lua require("syntax-tree-surfer").surf("prev", "visual", true)<cr>', opts)

-- Symbols Outline
keymap("n", "<Leader>s", "<cmd>SymbolsOutline<cr>", opts)
vim.cmd([[autocmd FileType Outline nnoremap <silent> <buffer> H :norm! H<CR>]])
vim.cmd([[autocmd FileType Outline nnoremap <silent> <buffer> L :norm! L<CR>]])

-- Markdown Preview
vim.cmd([[autocmd FileType markdown nnoremap <silent> <buffer> <Leader>rr :MarkdownPreviewToggle<CR>]])
vim.cmd([[autocmd FileType markdown nnoremap <silent> <buffer> <Leader>pr :MarkdownPreviewToggle<CR>]])
vim.cmd([[autocmd FileType plantuml nnoremap <silent> <buffer> <Leader>rr :PlantumlOpen<CR>]])
vim.cmd([[autocmd FileType plantuml nnoremap <silent> <buffer> <Leader>pr :PlantumlOpen<CR>]])

-- Supporting Acctress
keymap("n", "<Leader>S", "<cmd>lua require('supporting-acctress').open_window()<cr>", opts)

-- Zen Mode
keymap("n", "<Leader>Z", "<cmd>lua require('zen-mode').toggle()<cr>", opts)
-- Neoclip
keymap("n", "<Leader>re", "<cmd>Telescope neoclip default<cr>", opts)
keymap("i", "<C-r>", "<cmd>Telescope neoclip default<cr>", opts)
