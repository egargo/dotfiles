return {
	"stevearc/conform.nvim",
	lazy = false,
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		log_level = vim.log.levels.ERROR,
		notify_on_error = true,
		notify_no_formatters = true,
		format_on_save = function(bufnr)
			local disable_filetypes = {
				c = true,
				cpp = true,
				-- java = true,
			}
			return {
				timeout_ms = 500,
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		formatters_by_ft = {
			java = { "google-java-format" },
			-- lua = { "stylua" },
			rust = { "rustfmt", lsp_format = "fallback" },
			python = function(bufnr)
				if require("conform").get_formatter_info("ruff_format", bufnr).available then
					return { "ruff_format" }
				else
					return { "isort", "black" }
				end
			end,
			["_"] = { "trim_whitespace" },
		},
	},
}
