---@type LazySpec
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    {
      "nvim-tree/nvim-web-devicons",
      opts = {},
    },
  },
  ---@module "which-key"
  ---@type wk.Opts
  opts = {
    preset = "helix",
    show_help = false,
    delay = 0,
    spec = {
      { "<Leader>a", group = "Annotate" },
      { "<Leader>c", group = " CodeSnap", mode = { "v" } },
      { "<Leader>d", group = "Debug" },
      { "<Leader>f", group = "Find", mode = { "n", "v" } },
      { "<Leader>g", group = "Git" },
      { "<Leader>j", group = "Jump" },
      { "<Leader>l", group = "LSP", mode = { "n", "v" } },
      { "<Leader>p", group = "Packages" },
    },
    icons = {
      group = "",
    },
  },
}
