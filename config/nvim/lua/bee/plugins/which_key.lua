return {
	"folke/which-key.nvim",
	-- event = "VimEnter", -- Sets the loading event to 'VimEnter'
	event = "VeryLazy",
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
	dependencies = {
		-- { "nvim-tree/nvim-web-devicons" },
		{ "echasnovski/mini.nvim", version = false },
	},
	opts = {
		triggers_blacklist = {
			i = { "<leader>", "<space>", " ", "", "j", "k", "l", "h" },
			v = { "j", "k" },
		},
	},
	config = function() -- This is the function that runs, AFTER loading
		require("which-key").setup()
		require("which-key").add({
			{ "<leader>c", name = "[C]ode", desc = "which_key_ignore" },
			{ "<leader>d", name = "[D]ocument", desc = "which_key_ignore" },
			{ "<leader>r", name = "[R]ename", desc = "which_key_ignore" },
			{ "<leader>s", name = "[S]earch", desc = "which_key_ignore" },
			{ "<leader>w", name = "[W]orkspace", desc = "which_key_ignore" },
			{ "<leader>t", name = "[T]oggle", desc = "which_key_ignore" },
			{ "<leader>h", name = "Git [H]unk", desc = "which_key_ignore" },
		})
		-- visual mode
		require("which-key").add({
			{ "<leader>h", desc = "Git [H]unk" },
		}, { mode = "v" })
	end,
}
