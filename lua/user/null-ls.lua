local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	sources = {
		formatting.prettierd,
		-- formatting.eslint_d,
		formatting.stylua,
		formatting.clang_format,

		-- diagnostics.eslint_d,
	},
	on_attach = function(client) --> Format on Save
		if client.resolved_capabilities.document_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		end
	end,
})
