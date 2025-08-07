vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move to lower split" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move to upper split" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move to right split" })
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<C-q>", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<Leader>pa", "<cmd>MasonUpdate<cr><cmd>Lazy update<cr>", { desc = "Update all" })
vim.keymap.set("n", "<Leader>pm", "<cmd>Mason<cr>", { desc = "Open Mason" })
vim.keymap.set("n", "<Leader>c", "<cmd>bdelete<cr>", { desc = "Close buffer" })
vim.keymap.set("n", "<Leader>/", "gcc<esc>", { desc = "Comment line", remap = true })
vim.keymap.set("v", "<Leader>/", "gcc<esc>", { desc = "Comment lines", remap = true })
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { noremap = true })
