require("telescope").load_extension("dap")
require("dbg.python")

-- Key Maps
-- vim.cmd([[
-- " Create a submode to handle debugging
--
-- " The submode is entered whith <Leader>j and exited with <Leader>
-- call submode#enter_with('DebugMode', 'n', '', '<Leader>j', ':echo "debug mode"<CR>')
-- call submode#leave_with('DebugMode', 'n', '', '<Leader>')
--
-- "
-- call submode#map('DebugMode', 'n', '', 'h', '<cmd>lua require"dap".step_out()<CR>')
-- call submode#map('DebugMode', 'n', '', 'j', '<cmd>lua require"dap".step_over()<CR>')
-- call submode#map('DebugMode', 'n', '', 'k', '<cmd>lua require"dap".step_into()<CR>')
-- call submode#map('DebugMode', 'n', '', 'l', '<cmd>lua require"dap".continue()<CR>')
-- " call submode#map('DebugMode', 'n', '', 'o', '<cmd>lua print("Hello World")<CR>')
--
-- call submode#map('DebugMode', 'n', '', 'b', '<cmd>lua require"dap".toggle_breakpoint()<CR>')
--
-- call submode#map("DebugMode", "n", '', 's', '<cmd>lua require"dap.ui.variables".scopes()<CR>')
-- call submode#map("DebugMode", "n", '', 'H', '<cmd>lua require"dap.ui.variables".hover()<CR>')
-- call submode#map("DebugMode", "n", '', 'vh', '<cmd>lua require"dap.ui.variables".visual_hover()<CR>')
--
-- call submode#map("DebugMode", "n", '', 'ro', '<cmd>lua require"dap".repl.open()<CR>')
-- call submode#map("DebugMode", "n", '', 'rl', '<cmd>lua require"dap".repl.run_last()<CR>')
--
-- "
--
-- call submode#map("DebugMode", "n", '', 'wh', '<cmd>lua require"dap.ui.widgets".hover()<CR>')
-- call submode#map("DebugMode", "n", '', 'wf', '<cmd>lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>')
--
-- call submode#map("DebugMode", "n", '', 'sb', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
-- call submode#map("DebugMode", "n", '', 'sm', '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
--
-- " telescope-dap
--
-- call submode#map("DebugMode", "n", '', 'dc', '<cmd>lua require"telescope".extensions.dap.commands{}<CR>')
-- call submode#map("DebugMode", "n", '', 'cf', '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>')
-- call submode#map("DebugMode", "n", '', 'lb', '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>')
-- call submode#map("DebugMode", "n", '', 'dv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>')
-- call submode#map("DebugMode", "n", '', 'df', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>')
--
-- "
--
-- let g:submode_keep_leaving_key = 0
-- let g:submode_timeout = 0
-- ]])

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

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
keymap("n", "<leader>dv", '<cmd>lua require"telescope".extensions.dap.variables{}<CR>', opts)
keymap("n", "<leader>df", '<cmd>lua require"telescope".extensions.dap.frames{}<CR>', opts)
