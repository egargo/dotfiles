local config = {
    'ThePrimeagen/harpoon',
}

function config.config()
    require('telescope').load_extension 'harpoon'
    require('harpoon').setup {
        menu = {
            width = vim.api.nvim_win_get_width(0) - 4,
        },
    }

    vim.keymap.set('n', '<A-a>', require('harpoon.mark').add_file, { desc = 'Harpoon mark files to revisit later on' })
    vim.keymap.set('n', '<A-m>', require('harpoon.ui').toggle_quick_menu, { desc = 'Harpoon toggle quick menu' })
    vim.keymap.set('n', '<A-n>', require('harpoon.ui').nav_next, { desc = 'Harpoon navigate to next mark' })
    vim.keymap.set('n', '<A-p>', require('harpoon.ui').nav_prev, { desc = 'Harpoon navigate to previous mark' })
end

return config
