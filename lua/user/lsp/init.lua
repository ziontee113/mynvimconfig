require("nvim-lsp-installer").setup({})
require("user.lsp.handlers").setup()
local lspconfig = require("lspconfig")

--- New Start

local servers = { "sumneko_lua", "jsonls", "tsserver", "html", "cssls" }
for _, lsp in pairs(servers) do
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	if lsp == "sumneko_lua" then
		local sumneko_opts = require("user.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)

		local luadev = require("lua-dev").setup({})
		opts = vim.tbl_deep_extend("force", luadev, opts)
	end

	lspconfig[lsp].setup(opts)
end
