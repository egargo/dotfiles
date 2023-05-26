return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'rust-lang/rust.vim'
    use { 'neoclide/coc.nvim', branch = 'release' }
    use 'lewis6991/gitsigns.nvim'
    use 'tpope/vim-commentary'
    use { 'nvim-treesitter/nvim-treesitter', tag = 'v0.9.0' }
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'nvim-tree/nvim-tree.lua'
    use 'nordtheme/vim'
    use {
  'glepnir/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      -- config
    }
  end,
  requires = {'nvim-tree/nvim-web-devicons'}
}
end)
