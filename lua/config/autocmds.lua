vim.api.nvim_create_autocmd("BufWinEnter", {
  desc = "Return to the last position in a file",
  group = vim.api.nvim_create_augroup("config.recover-file-pos", { clear = true }),
  pattern = "*",
  command = 'silent! normal! g`"zv',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function()
    vim.treesitter.start()
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
