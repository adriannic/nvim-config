return {
  "chrisgrieser/nvim-origami",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  init = function()
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
  end,
}
