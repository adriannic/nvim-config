return {
  "xiyaowong/transparent.nvim",
  opts = function(_, opts)
    opts.extra_groups = {
      "NormalFloat",
      "NvimTreeNormal",
    }

    vim.g.transparent_enabled = true
  end,
}
