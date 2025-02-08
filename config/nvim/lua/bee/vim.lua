-- vim.g.*
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.g.editorconfig = true

-- vim.opt.*
-- vim.opt.splitright = true
-- vim.opt.tabstop = 4
-- vim.opt.shiftwidth = 4
-- vim.opt.softtabstop = 4
-- vim.opt.expandtab = true
-- vim.opt.smartindent = true
-- vim.opt.relativenumber = false
-- vim.opt.cursorline = true
-- vim.opt.ruler = true
-- vim.opt.autoindent = true
-- vim.opt.number = true
-- vim.opt.mouse = "a"
-- vim.opt.showmode = false
-- vim.opt.clipboard = "unnamedplus"
-- vim.opt.breakindent = true
-- vim.opt.undofile = true
-- vim.opt.ignorecase = true
-- vim.opt.smartcase = true
-- vim.opt.signcolumn = "yes"
-- vim.opt.updatetime = 250
-- vim.opt.timeoutlen = 300
-- vim.opt.splitright = true
-- vim.opt.splitbelow = true
-- vim.opt.list = true

vim.g.virtcolumn_char = "▕" -- char to display the line
vim.g.virtcolumn_priority = 10 -- priority of extmark

vim.opt.colorcolumn = "80"
vim.opt.autoindent = false
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.softtabstop = 4
vim.opt.copyindent = false
vim.opt.preserveindent = false
vim.opt.splitright = true
vim.opt.ttyfast = true
vim.opt.wrap = true
vim.opt.autoread = true
vim.opt.encoding = "utf-8"
vim.opt.fileformat = "unix"

vim.opt.spell = true

vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.ruler = true
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = true
vim.opt.showmatch = true
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = {
	tab = "» ",
	trail = "·",
	nbsp = "␣",
	-- eol = "↴"
}
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.list = true

-- vim.wo.*
vim.wo.number = true

-- vim.keymap.*
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!!"<CR>')
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- vim.api.*
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
