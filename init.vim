set runtimepath^=~/.config/nvim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

"Load Packer
lua require('plugins')

"Setup Plugins
lua require('avestuk')

" Better teminal colours
set termguicolors 
"Set dark background
set background=dark

" Set noshowmode
set noshowmode

" Dracula color scheme
let g:dracula_colorterm = 0
colorscheme dracula

" Autoformat files
autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()

autocmd BufWritePre *.go lua go_org_imports()
