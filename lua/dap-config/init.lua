require("dap-config.dap-ui")
require("nvim-dap-virtual-text").setup()

require("dap-config.python")
require("dap-config.chrome")
require("dap-config.node")

--
-- vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
-- vim.fn.sign_define("DapStopped", { text = "⭐️", texthl = "", linehl = "", numhl = "" })

-- Key Maps
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.cmd([[
autocmd FileType dap-float nnoremap <buffer> q :q<CR>
]])

keymap("n", "<leader>dui", '<cmd>lua require"dapui".toggle()<CR>', opts)
keymap("n", "dui", '<cmd>lua require"dapui".toggle()<CR>', opts)

-- keymap("n", "<S-u>", '<cmd>lua require"dap-config.helper".attachToRemote()<CR>', opts)
keymap("n", "<S-u>", '<cmd>lua require"dapui".toggle()<CR> | <cmd>lua require"dap".continue()<CR>', opts)
-- keymap("n", "<S-u>", '<cmd>lua require"dap".continue()<CR>', opts)
keymap("n", "<Leader>cn", '<cmd>lua require"dap".continue()<CR>', opts)
keymap("n", "<S-j>", '<cmd>lua require"dap".step_into()<CR>', opts)
keymap("n", "<S-l>", '<cmd>lua require"dap".step_over()<CR>', opts)
keymap("n", "<S-h>", '<cmd>lua require"dap".step_out()<CR>', opts)

keymap("n", "<Leader>dk", '<cmd>:lua require"dap".up()<CR>', opts)
keymap("n", "<Leader>dj", '<cmd>:lua require"dap".down()<CR>', opts)

keymap("n", "B", '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts)
keymap("n", "<leader>dB", '<cmd>lua require"dap".set_breakpoint()<CR>', opts)

keymap("n", "<leader>ds", '<cmd>lua require"dap.ui.widgets".scopes()<CR>', opts)
keymap("n", "<leader>di", '<cmd>lua require"dap.ui.widgets".hover()<CR>', opts)
keymap("v", "<leader>di", '<cmd>lua require"dap.ui.widgets".visual_hover()<CR>', opts)

keymap("n", "<leader>duh", '<cmd>lua require"dap.ui.widgets".hover()<CR>', opts)
keymap(
	"n",
	"<leader>duf",
	"<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>",
	opts
)

-- keymap("n", "<leader>dsbr", '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', opts)
keymap(
	"n",
	"<leader>dsbm",
	'<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
	opts
)

keymap("n", "<leader>dro", '<cmd>lua require"dap".repl.open()<CR>', opts)
keymap("n", "<leader>drl", '<cmd>lua require"dap".repl.run_last()<CR>', opts)

-- telescope-dap
vim.cmd([[
nnoremap <leader>DF :Telescope dap frames<CR>
nnoremap <leader>DC :Telescope dap commands<CR>
nnoremap <leader>DB :Telescope dap list_breakpoints<CR>
]])
-- keymap("n", "<leader>dcc", '<cmd>lua require"telescope".extensions.dap.commands{}<CR>', opts)
-- keymap("n", "<leader>dco", '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>', opts)
-- keymap("n", "<leader>dlb", '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>', opts)
-- keymap("n", "<leader>tdv", '<cmd>lua require"telescope".extensions.dap.variables{}<CR>', opts)
-- keymap("n", "<leader>tdf", '<cmd>lua require"telescope".extensions.dap.frames{}<CR>', opts)
