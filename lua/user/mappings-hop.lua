local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local nosilent_opts = { noremap = true, silent = false }
local term_opts = { silent = true }

-- Hop Related
keymap("n", "<A-q>", "q", opts) -- Macro q remap
keymap("x", "<A-q>", "q", opts)
keymap("n", "?", "/", nosilent_opts)

-- Hop
keymap("x", ",", "<cmd>HopWord<cr>", opts)
keymap("n", ",", "<cmd>HopWord<cr>", opts)
keymap("n", ";", "<cmd>HopLineStart<cr>", opts)
keymap("x", ";", "<cmd>HopLineStart<cr>", opts)
keymap("n", "<leader>l", "<cmd>HopLineStart<cr>", opts)
keymap("n", "<leader>W", "<cmd>HopWordMW<cr>", opts)

keymap("x", "f", "<cmd>HopChar1<cr>", opts)
keymap("n", "f", "<cmd>HopChar1<cr>", opts)
keymap("x", "f", "<cmd>HopChar1<cr>", opts)
keymap("n", "f", "<cmd>HopChar1<cr>", opts)
keymap("x", "s", "<cmd>HopChar1<cr>", opts)
keymap("n", "s", "<cmd>HopChar1<cr>", opts)

keymap("n", "/", "<cmd>HopChar1<cr>", opts)
keymap("x", "/", "<cmd>HopChar1<cr>", opts)
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
keymap("n", "f'", "<cmd>lua require'hop'.hint_patterns({}, [[\"\\|']])<cr>", opts)
keymap("n", "f-", "<cmd>lua require'hop'.hint_patterns({}, [[-\\|+]])<cr>", opts)
keymap("n", "f;", "<cmd>lua require'hop'.hint_patterns({}, [[;\\|:]])<cr>", opts)

keymap("n", "s/", "<cmd>lua require'hop'.hint_patterns({}, [[/\\|?]])<cr>", opts)
keymap("n", "f/", "<cmd>lua require'hop'.hint_patterns({}, [[/\\|?]])<cr>", opts)
keymap("n", "//", "<cmd>lua require'hop'.hint_patterns({}, [[/\\|?]])<cr>", opts)

-- keymap("n", "f[", "<cmd>lua require'hop'.hint_patterns({}, [[\\[\\|(]])<cr>", opts)
-- keymap("n", "f]", "<cmd>lua require'hop'.hint_patterns({}, [[\\]\\|)]])<cr>", opts)
keymap("n", "s[", "<cmd>lua require'hop'.hint_patterns({}, [[(]])<cr>", opts)
keymap("n", "s]", "<cmd>lua require'hop'.hint_patterns({}, [[)]])<cr>", opts)
keymap("n", "q[", "<cmd>lua require'hop'.hint_patterns({}, [[{]])<cr>", opts)
keymap("n", "q]", "<cmd>lua require'hop'.hint_patterns({}, [[}]])<cr>", opts)
