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
autocmd BufWritePre *.go lua go_org_imports()
autocmd BufWritePre *.go lua vim.lsp.buf.format()
autocmd BufWritePre *.tfvars lua vim.lsp.buf.format()
autocmd BufWritePre *.tf lua vim.lsp.buf.format()
autocmd BufWritePre *.rs lua vim.lsp.buf.format()
lua vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
lua vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
lua vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
lua vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
lua vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])

