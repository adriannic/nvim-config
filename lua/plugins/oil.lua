return {
  {
    "stevearc/oil.nvim",
    event = "VimEnter",
    opts = {
      columns = {
        "icon",
        "size",
      }
    },
    dependencies = { "nvim-mini/mini.nvim" },
    keys = {
      { "<Leader>e", ":Oil --float<cr>", desc = "Open explorer" },
    },
  },
  {
    "malewicz1337/oil-git.nvim",
    event = "VimEnter",
    dependencies = { "stevearc/oil.nvim" },
  },
  {
    "JezerM/oil-lsp-diagnostics.nvim",
    event = "VimEnter",
    dependencies = { "stevearc/oil.nvim" },
    opts = {},
  },
}
