---@type LazySpec
return {
  "xiyaowong/transparent.nvim",
  config = function()
    require("transparent").setup {
      extra_groups = {
        "NormalFloat",
        "NvimTreeNormal",
      },
    }

    vim.g.transparent_enabled = true
  end,
}
