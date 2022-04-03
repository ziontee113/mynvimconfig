require("telescope").load_extension("dap")
require("dbg.python")
require("dbg.chrome")

-- nvim-dap-virtual-text
require("nvim-dap-virtual-text").setup()

-- nvim-dap-ui
require("dapui").setup()

-- Key Maps

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("n", "<leader>dui", '<cmd>lua require"dapui".toggle()<CR>', opts)

keymap("n", "<leader>dct", '<cmd>lua require"dap".continue()<CR>', opts)
keymap("n", "<leader>dsv", '<cmd>lua require"dap".step_over()<CR>', opts)
keymap("n", "<leader>dsi", '<cmd>lua require"dap".step_into()<CR>', opts)
keymap("n", "<leader>dso", '<cmd>lua require"dap".step_out()<CR>', opts)
keymap("n", "<leader>dtb", '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts)

keymap("n", "<leader>dsc", '<cmd>lua require"dap.ui.variables".scopes()<CR>', opts)
keymap("n", "<leader>dhh", '<cmd>lua require"dap.ui.variables".hover()<CR>', opts)
keymap("v", "<leader>dhv", '<cmd>lua require"dap.ui.variables".visual_hover()<CR>', opts)

keymap("n", "<leader>duh", '<cmd>lua require"dap.ui.widgets".hover()<CR>', opts)
keymap(
	"n",
	"<leader>duf",
	"<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>",
	opts
)

keymap("n", "<leader>dsbr", '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', opts)
keymap(
	"n",
	"<leader>dsbm",
	'<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
	opts
)

keymap("n", "<leader>dro", '<cmd>lua require"dap".repl.open()<CR>', opts)
keymap("n", "<leader>drl", '<cmd>lua require"dap".repl.run_last()<CR>', opts)

-- telescope-dap
keymap("n", "<leader>dcc", '<cmd>lua require"telescope".extensions.dap.commands{}<CR>', opts)
keymap("n", "<leader>dco", '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>', opts)
keymap("n", "<leader>dlb", '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>', opts)
keymap("n", "<leader>tdv", '<cmd>lua require"telescope".extensions.dap.variables{}<CR>', opts)
keymap("n", "<leader>tdf", '<cmd>lua require"telescope".extensions.dap.frames{}<CR>', opts)
