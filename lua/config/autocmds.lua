vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("config.highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  desc = "Return to the last position in a file",
  group = vim.api.nvim_create_augroup("config.recover-file-pos", { clear = true }),
  pattern = "*",
  command = 'silent! normal! g`"zv',
})
