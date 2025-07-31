---@type LazySpec
return {
  "HiPhish/rainbow-delimiters.nvim",
  event = { "BufReadPre", "BufNewFile" },
  submodules = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
}
