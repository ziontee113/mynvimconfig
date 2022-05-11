require("neoscroll").setup({
	-- Set any options as needed
})

local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
t["<C-y>"] = { "scroll", { "-4", "true", "45" } }
t["<C-e>"] = { "scroll", { "4", "true", "45" } }

t["<C-u>"] = { "scroll", { "-11", "true", "69" } }
t["<C-d>"] = { "scroll", { "11", "true", "69" } }
t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "96", [['circular']] } }
t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "96", [['circular']] } }
t["zt"] = { "zt", { "96" } }
t["zz"] = { "zz", { "96" } }
t["zb"] = { "zb", { "96" } }

-- t["G"] = { "scroll", { "9999", "true", "96" } }
-- t["gg"] = { "scroll", { "-9999", "true", "96" } }
local e = "96"
t["gg"] = { "scroll", { "1 - vim.api.nvim_win_get_cursor(0)[1]", "true", "1", "5", e } }
t["G"] = { "scroll", { "vim.api.nvim_buf_line_count(0) - vim.api.nvim_win_get_cursor(0)[1]", "true", "1", "5", e } }

require("neoscroll.config").set_mappings(t)
