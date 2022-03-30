local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("user.lsp.lsp-installer")
require("user.lsp.handlers").setup()

vim.cmd([[function! EmmetSetup()
  " :lua require("lspconfig").emmet_ls.setup({ filetypes = { "html", "css", "scss", "javascript", "typescript", "typescriptreact", "javascriptreact" } })
  :lua require("lspconfig").emmet_ls.setup({ filetypes = { "html", "css", "scss", } })
endfunction]])
