require("neoscroll").setup({
	-- Set any options as needed
})

local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "96" } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "96" } }
t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "96" } }
t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "96" } }
t["zt"] = { "zt", { "96" } }
t["zz"] = { "zz", { "96" } }
t["zb"] = { "zb", { "96" } }

t["G"] = { "scroll", { "9999", "true", "120" } }
t["gg"] = { "scroll", { "-9999", "true", "120" } }

require("neoscroll.config").set_mappings(t)
