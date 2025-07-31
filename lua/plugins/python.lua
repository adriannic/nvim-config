---@type LazySpec
return {
  "linux-cultist/venv-selector.nvim",
  ft = "python",
  branch = "regexp",
  enabled = vim.fn.executable "fd" == 1 or vim.fn.executable "fdfind" == 1 or vim.fn.executable "fd-find" == 1,
  ---@type venv-selector.Config
  opts = {},
  keys = {
    { "<Leader>lv", "<cmd>VenvSelect<cr>", desc = "LSP select VirtualEnv" },
  },
}
