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

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Syntax Tree Surfer V2 Mappings
-- jump with virtual_text
local stf = require("syntax-tree-surfer")
vim.keymap.set("n", "gv", function() -- only jump to variable_declarations
	stf.targeted_jump({ "variable_declaration" })
end, opts)
vim.keymap.set("n", "gfu", function() -- only jump to functions
	stf.targeted_jump({ "function" })
end, opts)
vim.keymap.set("n", "gif", function() -- only jump to if_statements
	stf.targeted_jump({ "if_statement" })
end, opts)
vim.keymap.set("n", "gfo", function() -- only jump to for_statements
	stf.targeted_jump({ "for_statement" })
end, opts)
vim.keymap.set("n", "gj", function() -- jump to all that you specify
	stf.targeted_jump({
		"function",
		"if_statement",
		"else_clause",
		"else_statement",
		"elseif_statement",
		"for_statement",
		"while_statement",
		"switch_statement",
	})
end, opts)

-------------------------------
-- filtered_jump --
-- "default" means that you jump to the default_desired_types or your lastest jump types
vim.keymap.set("n", "<A-n>", function()
	stf.filtered_jump("default", true) --> true means jump forward
end, opts)
vim.keymap.set("n", "<A-p>", function()
	stf.filtered_jump("default", false) --> false means jump backwards
end, opts)

-- non-default jump --> custom desired_types
vim.keymap.set("n", "your_keymap", function()
	stf.filtered_jump({
		"if_statement",
		"else_clause",
		"else_statement",
	}, true) --> true means jump forward
end, opts)
vim.keymap.set("n", "your_keymap", function()
	stf.filtered_jump({
		"if_statement",
		"else_clause",
		"else_statement",
	}, false) --> false means jump backwards
end, opts)

-------------------------------
-- jump with limited targets --
-- jump to sibling nodes only
vim.keymap.set("n", "-", function()
	stf.filtered_jump({
		"if_statement",
		"else_clause",
		"else_statement",
	}, false, { destination = "siblings" })
end, opts)
vim.keymap.set("n", "=", function()
	stf.filtered_jump({ "if_statement", "else_clause", "else_statement" }, true, { destination = "siblings" })
end, opts)

-- jump to parent or child nodes only
vim.keymap.set("n", "_", function()
	stf.filtered_jump({
		"if_statement",
		"else_clause",
		"else_statement",
	}, false, { destination = "parent" })
end, opts)
vim.keymap.set("n", "+", function()
	stf.filtered_jump({
		"if_statement",
		"else_clause",
		"else_statement",
	}, true, { destination = "children" })
end, opts)

-- Setup Function example:

require("syntax-tree-surfer").setup({
	disable_no_instance_found_report = false,
	default_desired_types = {
		"function",
		"if_statement",
		"else_clause",
		"else_statement",
		"elseif_statement",
		"for_statement",
		"while_statement",
		"switch_statement",
	},
})
