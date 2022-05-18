require("hop").setup({}) -- testing out Hop.nvim with vim.schedule

--------------------> Vim.schedule demonstration
--------------------
--------------------
--------------------
--------------------
--------------------

-- SECTION: yank a line with HopLineStart
vim.keymap.set("n", "yl", function()
	vim.cmd([[:HopLineStart]]) --> jump to line
	--> It's more ocmplicated when it comes to multiple windows, we'll save it for later
	vim.schedule(function()
		vim.cmd([[normal! yy]]) --> yank the line
		vim.cmd([[normal! ]]) --> jump back
	end)
end, { noremap = true, silent = true })

-- SECTION: Hyper Yank
vim.keymap.set("n", "yb", function()
	vim.cmd([[:HopLineStart]])
	vim.schedule(function()
		require("tsht").nodes()
		vim.schedule(function()
			vim.cmd([[normal! V]]) --> go to visual selection mode -> optional
			vim.cmd([[normal! y]]) --> yank
			vim.cmd([[normal! ]]) --> jump back
		end)
	end)
end, { noremap = true, silent = true })

-- SECTION: Using nvim-treehopper to yank
vim.keymap.set("n", "ym", function()
	require("tsht").nodes()
	vim.schedule(function()
		vim.cmd([[normal! y]]) --> yank
	end)
end, { noremap = true, silent = true })

--SECTION: Hop Paste to the line below target

vim.keymap.set("n", "vp", function()
	vim.cmd([[:HopLineStart]])
	vim.schedule(function()
		vim.cmd([[normal! o]]) --> make new line below target
		vim.cmd([[normal! p]]) --> paste
	end)
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>vp", function()
	vim.cmd([[:HopLineStart]])
	vim.schedule(function()
		vim.cmd([[normal! o]]) --> make new line below target
		vim.cmd([[normal! o]]) --> make another new line below target
		vim.cmd([[normal! p]]) --> paste
	end)
end, { noremap = true, silent = true })

vim.keymap.set("n", "vP", function()
	vim.cmd([[:HopLineStart]])
	vim.schedule(function()
		vim.cmd([[normal! P]]) --> paste
	end)
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>vP", function()
	vim.cmd([[:HopLineStart]])
	vim.schedule(function()
		vim.cmd([[normal! O]]) --> make another new line below target
		vim.cmd([[normal! P]]) --> paste
	end)
end, { noremap = true, silent = true })

--  NOTE: Hop to create new lines

vim.keymap.set("n", "vo", function()
	vim.cmd([[:HopLineStart]])
	vim.schedule(function()
		vim.cmd([[normal! o]])
		vim.cmd([[startinsert]])
	end)
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>vo", function()
	vim.cmd([[:HopLineStart]])
	vim.schedule(function()
		vim.cmd([[normal! o]])
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
vim.keymap.set("n", "<Leader>vO", function()
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

vim.keymap.set("n", "your_keymap", function()
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
