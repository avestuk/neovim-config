-- Enable folding for files that have the VSCode Region tags set
vim.keymap.set("n", "<leader>yf", "<cmd>set foldmarker=#region,#endregion<cr><cmd>set foldmethod=marker<cr>")

-- Quickfix navigating
-- TODO Doesn't work on mac for some reason
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")
