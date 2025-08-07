return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = function(_, _)
    vim.cmd [[colorscheme catppuccin]]
  end
}
