-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Telescope
  use { 
    'nvim-telescope/telescope.nvim', 
    branch = '0.1.x',
    requires = { 
        {'nvim-lua/plenary.nvim'},
        {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        }
    }

  -- Fugitive
  use { 'tpope/vim-fugitive' }

  -- Lightline
  use { 'itchyny/lightline.vim' }

  -- LSPConfig
  use { 'neovim/nvim-lspconfig' }

  -- Rust Specific bits
  use { 'simrat39/rust-tools.nvim' }
    
  -- Debugging
  use { 'https://github.com/mfussenegger/nvim-dap' }
  use { 'https://github.com/rcarriga/nvim-dap-ui' }
  use { 'https://github.com/leoluz/nvim-dap-go' }
  use { 'theHamsta/nvim-dap-virtual-text' }

  -- Autocompletion bits
  use {
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'onsails/lspkind-nvim',
      }
  }

  -- Null-LS
  use({
    "jose-elias-alvarez/null-ls.nvim",
      requires = { "nvim-lua/plenary.nvim" },
  })

  -- Autopairs
  use { "windwp/nvim-autopairs" }

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Nvim-surround
  use { "kylechui/nvim-surround" }

  ---- Markdown Preview
  --use ({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
  use({ "iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end, })

  -- Comment
  use { "numToStr/Comment.nvim" }

  ---- Simple plugins can be specified as strings
  --use '9mm/vim-closer'

  ---- Lazy loading:
  ---- Load on specific commands
  --use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  ---- Load on an autocommand event
  --use {'andymass/vim-matchup', event = 'VimEnter'}

  ---- Plugins can have dependencies on other plugins
  --use {
  --  'haorenW1025/completion-nvim',
  --  opt = true,
  --  requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
  --}

  ---- Plugins can also depend on rocks from luarocks.org:
  --use {
  --  'my/supercoolplugin',
  --  rocks = {'lpeg', {'lua-cjson', version = '2.1.0'}}
  --}

  ---- You can specify rocks in isolation
  --use_rocks 'penlight'
  --use_rocks {'lua-resty-http', 'lpeg'}

  ---- Local plugins can be included
  --use '~/projects/personal/hover.nvim'


  ---- Post-install/update hook with call of vimscript function with argument
  --use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

  ---- Use specific branch, dependency and run lua file after load
  --use {
  --  'glepnir/galaxyline.nvim', branch = 'main', config = function() require'statusline' end,
  --  requires = {'kyazdani42/nvim-web-devicons'}
  --}

  ---- Use dependency and run lua function after load
  --use {
  --  'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
  --  config = function() require('gitsigns').setup() end
  --}

  ---- You can specify multiple plugins in a single call
  --use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}

  -- You can alias plugin names
  use {'dracula/vim', as = 'dracula'}
end)
