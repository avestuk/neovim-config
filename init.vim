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

" Telescope Mappings
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>gf <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>lg <cmd>lua require('telescope.builtin').live_grep()<cr>

" Autoformat files
autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()

autocmd BufWritePre *.go lua go_org_imports()
