return {
    "tpope/vim-sleuth",
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            "sindrets/diffview.nvim", -- optional
        },
        config = true,
    },

    {
        -- See `:help gitsigns` to understand what the configuration keys do
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
            on_attach = function(bufnr)
                vim.keymap.set(
                    "n",
                    "[c",
                    require("gitsigns").prev_hunk,
                    { buffer = bufnr, desc = "Go to Previous Hunk" }
                )
                vim.keymap.set("n", "]c", require("gitsigns").next_hunk, { buffer = bufnr, desc = "Go to Next Hunk" })
                vim.keymap.set(
                    "n",
                    "<leader>ph",
                    require("gitsigns").preview_hunk,
                    { buffer = bufnr, desc = "[P]review [H]unk" }
                )
            end,
        },
    },
}
