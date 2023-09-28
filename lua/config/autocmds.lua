-- Autoformat files
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.tf", "*.tfvars", "*.lua", "*.go" },
	callback = function()
		vim.lsp.buf.format()
	end,
})
