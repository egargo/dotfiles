local config = {
    'akinsho/toggleterm.nvim',
    version = '*',
}

function config.config()
    require('toggleterm').setup {
        size = 12,
        desc = 'Open [t]erminal Open',
        open_mapping = '<C-t>',
        hide_numbers = true,
        -- direction = 'horizontal',
        direction = 'float',
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
            border = 'single',
            width = 80,
            height = 24,
        },
    }
end

return config
