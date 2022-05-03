require("neoscroll").setup({
	-- Set any options as needed
})

local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
t["<C-u>"] = { "scroll", { "-11", "true", "69" } }
t["<C-d>"] = { "scroll", { "11", "true", "69" } }
t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "96", [['circular']] } }
t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "96", [['circular']] } }
t["zt"] = { "zt", { "96" } }
t["zz"] = { "zz", { "96" } }
t["zb"] = { "zb", { "96" } }

t["G"] = { "scroll", { "9999", "true", "96" } }
t["gg"] = { "scroll", { "-9999", "true", "96" } }

require("neoscroll.config").set_mappings(t)
