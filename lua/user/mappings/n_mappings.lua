---@diagnostic disable: unused-local

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

keymap("n", "<A-j>", "n", opts)
keymap("n", "<A-k>", "N", opts)
