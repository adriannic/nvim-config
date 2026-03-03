return {
  {
    "stevearc/oil.nvim",
    event = "VimEnter",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      columns = {
        "icon",
        "size",
      }
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- lazy = false,
    keys = {
      { "<Leader>e", ":Oil --float<cr>", desc = "Open explorer" },
    },
  },
  {
    "malewicz1337/oil-git.nvim",
    dependencies = { "stevearc/oil.nvim" },
    lazy = true,
  },
  {
    "JezerM/oil-lsp-diagnostics.nvim",
    dependencies = { "stevearc/oil.nvim" },
    lazy = true,
    opts = {},
  },
}
