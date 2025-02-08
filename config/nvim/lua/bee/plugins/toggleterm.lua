return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 12,
			desc = "Open [t]erminal Open",
			open_mapping = "<C-t>",
			hide_numbers = true,
			direction = "float", -- "float" | "horizontal" | "vertical"
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "single",
				width = 132,
				height = 32,
			},
		})
	end,
}
