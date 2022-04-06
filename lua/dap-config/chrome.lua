local dap = require("dap")
dap.adapters.chrome = {
	type = "executable",
	command = "node",
	args = { "/home/ubur/.config/daps/vscode-chrome-debug/out/src/chromeDebug.js" },
}

dap.configurations.javascriptreact = { -- change this to javascript if needed
	{
		type = "chrome",
		request = "attach",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		port = 9222,
		webRoot = "${workspaceFolder}",
		skipFiles = { "<node_internals>/**/*.js", "${workSpaceFolder}/node_modules/**/*.js", "<eval>/**/*.js" },
	},
}

dap.configurations.typescriptreact = { -- change to typescript if needed
	{
		type = "chrome",
		request = "attach",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		port = 9222,
		webRoot = "${workspaceFolder}",
		skipFiles = { "<node_internals>/**/*.js", "${workSpaceFolder}/node_modules/**/*.js", "<eval>/**/*.js" },
	},
}
