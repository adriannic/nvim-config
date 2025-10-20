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

local map = function(keys, func, desc, mode)
  mode = mode or "n"
  vim.keymap.set(mode, keys, func, { desc = "LSP " .. desc })
end

map("<Leader>lD", function() Snacks.picker.diagnostics() end, "find diagnostics")
map("<Leader>lS", function() require("aerial").toggle() end, "show Symbols")
map("<Leader>la", vim.lsp.buf.code_action, "apply quickfix", { "n", "x" })
map("<Leader>la", vim.lsp.buf.code_action, "code Action", { "n", "x" })
map("<Leader>ld", function() vim.diagnostic.open_float() end, "show hover diagnostics")
map("<Leader>lf", vim.lsp.buf.format, "format buffer")
map("<Leader>ll", vim.lsp.codelens.run, "codelens run")
map("<Leader>lr", vim.lsp.buf.rename, "rename")
map("<Leader>ls", function() Snacks.picker.lsp_symbols() end, "find Symbols")
map("gD", function() Snacks.picker.lsp_declarations() end, "goto declaration")
map("gI", function() Snacks.picker.lsp_implementations() end, "goto implementation")
map("gd", function() Snacks.picker.lsp_definitions() end, "goto definition")
map("gr", function() Snacks.picker.lsp_references() end, "goto references")
map("gt", function() Snacks.picker.lsp_type_definitions() end, "goto type definition")

