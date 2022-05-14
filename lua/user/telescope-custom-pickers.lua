local M = {}
local telescope = require("telescope")
local builtin = require("telescope.builtin")

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
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	local function enter(prompt_bufnr)
		local selected = action_state.get_selected_entry()
		local cmd = "cd " .. selected[1]
		vim.cmd(cmd)
		actions.close(prompt_bufnr)
	end

	local opts = {
		finder = finders.new_table({
			"~/.config/nvim/",
			"/mnt/d/notes",
		}),

		layout_stratey = "vertical",
		layout_config = {
			height = 12,
			width = 0.25,
			prompt_position = "top",
		},
		prompt_title = "Directory Picker",
		sorting_strategy = "ascending",

		--

		attach_mappings = function(prompt_bufnr, map)
			map("i", "<CR>", enter)
			return true
		end,

		on_complete = { --> start in Normal Mode
			function()
				vim.cmd("stopinsert")
			end,
		},
	}

	---@diagnostic disable-next-line: missing-parameter
	local dirs = pickers.new(opts)
	dirs:find()
end

vim.keymap.set("n", "<Leader>l", function()
	M.directory_picker()
end, { noremap = true, silent = true })

return M
