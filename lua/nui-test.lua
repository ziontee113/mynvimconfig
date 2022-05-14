-- local NuiText = require("nui.text")--{{{ Basic NuiText and NuiLine
--
-- vim.keymap.set("n", "<leader>zj", function()
-- 	local text = NuiText("Something Went Wrong!", "Error")
-- 	local bufnr, ns_id, linenr_start, byte_start = 0, -1, 1, 5
--
-- 	text:render(bufnr, ns_id, linenr_start, byte_start)
-- end, { noremap = true, silent = true })
--
-- vim.keymap.set("n", "<leader>zk", function()
-- 	local NuiLine = require("nui.line")
-- 	local line = NuiLine()
--
-- 	line:append("Something Went Wrong!", "Error")
--
-- 	local bufnr, ns_id, linenr_start = 0, -1, 2
--
-- 	line:render(bufnr, ns_id, linenr_start)
-- end, { noremap = true, silent = true })--}}}

--------------------------------------------------------------------------------

local NuiTree = require("nui.tree")
local NuiLine = require("nui.line")
local Split = require("nui.split")

local split = Split({
	relative = "win",
	position = "right",
	size = 70,
})

vim.keymap.set("n", "<Leader>y", function()
	split:mount()

	-- quit
	split:map("n", "q", function()
		split:unmount()
	end, { noremap = true })

	local tree = NuiTree({
		winid = split.winid,
		nodes = {
			NuiTree.Node({ text = "a" }),
			NuiTree.Node({ text = "b" }, {
				NuiTree.Node({ text = "b-1" }),
				NuiTree.Node({ text = "b-2" }, {
					NuiTree.Node({ text = "b-1-a" }),
					NuiTree.Node({ text = "b-2-b" }),
				}),
			}),
			NuiTree.Node({ text = "c" }, {
				NuiTree.Node({ text = "c-1" }),
				NuiTree.Node({ text = "c-2" }),
			}),
		},
		prepare_node = function(node)
			local line = NuiLine()

			line:append(string.rep("  ", node:get_depth() - 1))

			if node:has_children() then
				line:append(node:is_expanded() and " " or " ", "SpecialChar")
			else
				line:append("  ")
			end

			line:append(node.text)

			return line
		end,
	})

	local map_options = { noremap = true, nowait = true }

	-- print current node
	split:map("n", "<CR>", function()
		local node = tree:get_node()
		print(vim.inspect(node))
	end, map_options)

	-- collapse current node
	split:map("n", "h", function()
		local node = tree:get_node()

		if node:collapse() then
			tree:render()
		end
	end, map_options)

	-- collapse all nodes
	split:map("n", "H", function()
		local updated = false

		for _, node in pairs(tree.nodes.by_id) do
			updated = node:collapse() or updated
		end

		if updated then
			tree:render()
		end
	end, map_options)

	-- expand current node
	split:map("n", "l", function()
		local node = tree:get_node()

		if node:expand() then
			tree:render()
		end
	end, map_options)

	-- expand all nodes
	split:map("n", "L", function()
		local updated = false

		for _, node in pairs(tree.nodes.by_id) do
			updated = node:expand() or updated
		end

		if updated then
			tree:render()
		end
	end, map_options)

	-- add new node under current node
	split:map("n", "a", function()
		local node = tree:get_node()
		tree:add_node(
			NuiTree.Node({ text = "d" }, {
				NuiTree.Node({ text = "d-1" }),
			}),
			node:get_id()
		)
		tree:render()
	end, map_options)

	-- delete current node
	split:map("n", "d", function()
		local node = tree:get_node()
		tree:remove_node(node:get_id())
		tree:render()
	end, map_options)

	tree:render()
end, { noremap = true, silent = true })
