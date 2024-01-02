-- Remap , as leader key
vim.g.mapleader = ","

vim.opt.ignorecase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

-- Treesitter folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
