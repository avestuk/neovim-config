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

  -- Mason
  use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim"
  }

  -- Nvim-surround
  use { "kylechui/nvim-surround" }

  ---- Markdown Preview
  use({ "iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end, })

  -- Comment
  use { "numToStr/Comment.nvim" }

  -- You can alias plugin names
  use {'dracula/vim', as = 'dracula'}
end)
