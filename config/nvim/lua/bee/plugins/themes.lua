return {
	{
		-- "folke/tokyonight.nvim",
		-- "catppuccin/nvim",
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		init = function()
			-- vim.cmd.colorscheme("tokyonight-night")
			-- vim.cmd.colorscheme("catppuccin-macchiato")
			vim.cmd.colorscheme("gruvbox")
			vim.cmd.hi("Comment gui=none")
		end,
	},
}
