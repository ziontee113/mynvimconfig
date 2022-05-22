local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- change & targets.vim related
keymap("n", "ckk", "ciq", term_opts)
keymap("n", "ck ", "ciq", term_opts)
keymap("n", "ckj", "cilq", term_opts)
keymap("n", "ckh", "c2ilq", term_opts)
keymap("n", "ckg", "c3ilq", term_opts)
keymap("n", "ckl", "cinq", term_opts)
keymap("n", "ck;", "c2inq", term_opts)
keymap("n", "ck'", "c3inq", term_opts)

keymap("n", "c,,", "cib", term_opts)
keymap("n", "c, ", "cib", term_opts)
keymap("n", "c,j", "cilb", term_opts)
keymap("n", "c,h", "c2ilb", term_opts)
keymap("n", "c,g", "c3ilb", term_opts)
keymap("n", "c,l", "cinb", term_opts)
keymap("n", "c,;", "c2inb", term_opts)
keymap("n", "c,'", "c3inb", term_opts)

keymap("n", "cj", "ciw", opts)
keymap("n", "cJ", "ciW", opts)

-- O related
keymap("n", "<CR>", "o", opts) --> Ctrl + F7 for Wezterm
keymap("n", "<F32>", "O", opts) --> Ctrl + F8 for Wezterm
keymap("i", "<F32>", "<C-o>O", opts) --> Ctrl + F8 for Wezterm

-- Testing
keymap("n", "s<CR>", "5k", opts) --> Ctrl + F8 for Wezterm
