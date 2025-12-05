vim.g.mapleader = " "
vim.g.localleader = " "

vim.g.have_nerd_font = nixCats("have_nerd_font")

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.opt.signcolumn = "yes"
vim.opt.showmode = false

vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 20

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.breakindent = true
