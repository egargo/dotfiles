local config = {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    show_end_of_line = true,
    show_current_context = true,
    show_current_context_start = true,
    opts = {},
}

function config.config()
    require('ibl').setup {
        indent = {
            char = '┊',
        },
    }
end

return config
