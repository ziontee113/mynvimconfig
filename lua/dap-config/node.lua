local dap = require("dap")

dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = { "/home/ubur/.config/daps/vscode-node-debug2/out/src/nodeDebug.js" },
}

dap.configurations.javascript = {
	{
		name = "Launch",
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		-- console = "integratedTerminal",
		skipFiles = {
			"<node_internals>/**/*.js",
			"${workspaceFolder}/node_modules/**/*.js",
			"${workspaceFolder}/lib/**/*.js",
		},
	},
	-- {
	-- 	-- For this to work you need to make sure the node process is started with the `--inspect` flag.
	-- 	name = "Attach to process",
	-- 	type = "node2",
	-- 	request = "attach",
	-- 	port = 9229,
	-- 	processId = require("dap.utils").pick_process,
	-- },
}
