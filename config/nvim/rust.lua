local config = {
    {
        'rust-lang/rust.vim',
        ft = 'rust',
        init = function()
            vim.g.rustfmt_autosave = 1
        end,
    },

    {
        'simrat39/rust-tools.nvim',
        opts = {},
    },

    {
        'saecki/crates.nvim',
        tag = 'v0.4.0',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup()
        end,
    },
}

function config.config()
    local rt = require 'rust-tools'

    rt.setup {
        server = {
            on_attach = function(_, bufnr)
                -- Hover actions
                vim.keymap.set('n', '<C-space>', rt.hover_actions.hover_actions, { buffer = bufnr })
                -- Code action groups
                vim.keymap.set('n', '<Leader>a', rt.code_action_group.code_action_group, { buffer = bufnr })
            end,
        },
    }

    require('rust-tools').inlay_hints.set()
end

return config
