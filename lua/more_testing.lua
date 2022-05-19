local api = vim.api
local ns = api.nvim_create_namespace("testing_namespace")

-- clear namespace
api.nvim_buf_clear_namespace(0, ns, 0, -1)

local function test_extmark()
	api.nvim_buf_set_extmark(0, ns, 1, 0, {
		virt_text = { { "aespa", "DapUIScope" } },
		virt_text_pos = "overlay",
	})

	-- testing vim.fn.getchar
	vim.cmd("redraw")

	local ok, keynum = pcall(vim.fn.getchar)

	if ok then
		if keynum == 27 then --> Esc
			api.nvim_buf_clear_namespace(0, ns, 0, -1)
		else
			local key = string.char(keynum)
			N(key)
		end
	end
end

vim.keymap.set("n", " ns", function()
	test_extmark()
end, { noremap = true, silent = true })
