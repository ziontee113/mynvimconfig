require("hop").setup({}) -- testing out Hop.nvim with vim.schedule

--------------------> Vim.schedule demonstration
--------------------
--------------------
--------------------
--------------------
--------------------

--  NOTE: Hop to create blank lines

vim.keymap.set("n", "vo", function()
	vim.cmd([[:HopLineStart]])
	vim.schedule(function()
		vim.cmd([[normal! o]])
		vim.cmd([[startinsert]])
	end)
end, { noremap = true, silent = true })

vim.keymap.set("n", "vO", function()
	vim.cmd([[:HopLineStart]])
	vim.schedule(function()
		vim.cmd([[normal! O]])
		vim.cmd([[normal! O]])
		vim.cmd([[startinsert]])
	end)
end, { noremap = true, silent = true })

--  NOTE: Hop with Macros

vim.keymap.set("n", "vY", function()
	vim.cmd([[:HopLineStart]])
	vim.schedule(function()
		vim.cmd([[:normal @f]])
	end)
end, { noremap = true, silent = true })

--  NOTE: Hop can even trigger LuaSnip Snippets (complicated)

vim.keymap.set("n", "vP", function()
	vim.cmd([[:HopLineStart]]) --> Best thing ever in the history of mankind
	vim.schedule(function()
		vim.cmd([[:normal ojja ]]) --> POGG
		vim.cmd("startinsert")
	end)
end, { noremap = true, silent = true })

--  NOTE: TSHT (Treesitter hint textobject) --> mfussenegger/nvim-treehopper

vim.keymap.set("n", "vy", function()
	require("tsht").nodes()
	vim.schedule(function()
		vim.cmd([[normal! c]])
		vim.cmd([[startinsert]])
	end)
end, { noremap = true, silent = true })
