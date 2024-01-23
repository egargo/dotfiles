return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'folke/tokyonight.nvim',
    },
    opts = {
        options = {
            icons_enabled = true,
            theme = 'tokyonight',
            component_separators = '|',
            section_separators = '',
            'filename',
            path = 1,
        },
    },
}
