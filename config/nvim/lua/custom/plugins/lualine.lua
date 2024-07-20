return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      options = {
        icons_enabled = true,
        -- theme = 'gruvbox',
        theme = 'tokyonight',
        component_separators = '|',
        section_separators = '',
        'filename',
        path = 1,
      },
    },
  },
}
