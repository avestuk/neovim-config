-- Enable folding for files that have the VSCode Region tags set
vim.keymap.set("n", "<leader>yf", "<cmd>set foldmarker=#region,#endregion<cr><cmd>set foldmethod=marker<cr>")
