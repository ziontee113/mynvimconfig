local M = {}
local telescope = require("telescope")
local builtin = require("telescope.builtin")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

function M.grep_string()
	builtin.grep_string({
		shorten_path = true,
		search = vim.fn.input("Rg> "),
	})
end

local dropdown_theme = require("telescope.themes").get_dropdown({
	winblend = 10,
	width = 0.5,
	prompt = " ",
	results_height = 15,
	previewer = false,
})
local ivy_theme = require("telescope.themes").get_ivy({
	winblend = 10,
	results_title = false,
	layout_config = {
		preview_width = 0.6,
	},
})

function M.vimrc_find_files()
	local opts = vim.deepcopy(ivy_theme)
	opts.search_dirs = { "~/.config/nvim/" }
	opts.prompt_title = "$MYVIMRC find_files"
	opts.shorten_path = true
	builtin.find_files(opts)
end

function M.vimrc_live_grep()
	local opts = vim.deepcopy(ivy_theme)
	opts.search_dirs = {
		"~/.config/nvim/",
	}
	opts.prompt_title = "$MYVIMRC live_grep"
	opts.shorten_path = true
	builtin.live_grep(opts)
end

function M.directory_picker()
	local function enter(prompt_bufnr)
		local selected = action_state.get_selected_entry()
		local cmd = "cd " .. selected[1]
		vim.cmd(cmd)
		actions.close(prompt_bufnr)
	end

	local opts = {
		finder = finders.new_table({
			"~/.config/nvim/",
			"~/.config/nvim/lua/myPlugs/syntax-tree-surfer/",
			"/mnt/d/notes",
			"/mnt/e/YouTube Projects/",
			"~/.local/share/nvim/site/pack/packer/start/",
			"/mnt/c/Users/VD/Documents/Rainmeter/Skins/TriSound/",
		}),

		sorter = sorters.get_generic_fuzzy_sorter({}),

		layout_stratey = "vertical",
		layout_config = {
			height = 12,
			width = 0.25,
			prompt_position = "top",
		},
		prompt_title = "Directory Picker",
		sorting_strategy = "ascending",

		attach_mappings = function(prompt_bufnr, map)
			map("i", "<CR>", enter)
			map("n", "<CR>", enter)
			return true
		end,
	}

	---@diagnostic disable-next-line: missing-parameter
	local dirs = pickers.new(opts)
	dirs:find()
end

vim.keymap.set("n", "<Leader>l", function()
	M.directory_picker()
end, { noremap = true, silent = true })

return M
