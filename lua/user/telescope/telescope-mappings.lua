-- Telescope

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap(
	"n",
	"<C-p>",
	"<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
	opts
)
keymap("n", " b", "<cmd>lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown())<cr>", opts)
keymap("n", "<leader>k", ":Telescope keymaps<cr>", opts)
keymap("n", "<leader>ke", ":Telescope keymaps<cr>", opts)
keymap("n", "<leader>he", ":Telescope help_tags<cr>", opts)
keymap("n", "<leader>hi", ":Telescope highlights<cr>", opts)
keymap("n", "<c-f>", ":Telescope find_files<cr>", opts)
keymap("n", "<leader>g", ":Telescope live_grep<cr>", opts)
keymap("n", "<C-g>", ":lua require('telescope').extensions.live_grep_raw.live_grep_raw()<cr>", opts)
keymap("n", "<leader>ff", ":Telescope find_files<cr>", opts)
keymap("n", "<leader>fz", ":Telescope current_buffer_fuzzy_find<cr>", opts)

keymap("n", "<leader><C-p>", ":lua require('user.telescope.telescope-custom-pickers').vimrc_find_files()<cr>", opts)
keymap("n", "<leader><leader>g", ":lua require('user.telescope.telescope-custom-pickers').vimrc_live_grep()<cr>", opts)
