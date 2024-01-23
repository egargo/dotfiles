--[[ local config = {
    'stevearc/conform.nvim',
    opts = {},
}

function config.config()
    require('conform').setup {
        formatters_by_ft = {
            bash = { 'shfmt' },
            sh = { 'shfmt' },
            lua = { 'stylua' },
            python = { 'isort', 'black' },
            javascript = { 'prettier' },
            go = { 'gofmt', 'goimports' },
            toml = { 'taplo' },
            markdown = { 'markdownlint' },
            css = { 'stylelint' },
            ['*'] = { 'codespell' },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
    }
end

return config ]]

return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',
            {
                'j-hui/fidget.nvim',
                branch = 'legacy',
            },
            'folke/neodev.nvim',
        },
    },

    opts = {
        diagnostics = {
            underline = true,
            update_in_insert = false,
            virtual_text = {
                spacing = 4,
                source = 'if_many',
                prefix = '●',
            },
        },
        severity_sort = true,
        inlay_hints = { enabled = true },
        capabilities = {},
        format = {},
        servers = {
            bashls = {},
            cssls = {},
            eslint = {},
            docker_compose_language_service = {},
            dockerls = {},
            hls = {},
            html = {},
            jsonls = {},
            marksman = {},
            ocamllsp = {},
            perlnavigator = {},
            pyright = {},
            rust_analyzer = {},
            taplo = {},
            tsserver = {},
            yamlls = {},
            lua_ls = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        },
        setup = {},

        config = function()
            require('neodev').setup()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        end
    },
}
