vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")
vim.keymap.set("n", "<C-q>", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<Leader>/", "gcc<esc>", { desc = "Comment line", remap = true })
vim.keymap.set("v", "<Leader>/", "gcc<esc>", { desc = "Comment lines", remap = true })
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { noremap = true })
