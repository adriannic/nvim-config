return {
  "catppuccin/nvim",
  event = "VimEnter",
  name = "catppuccin",
  priority = 1000,
  opts = function(_, _)
    vim.cmd([[colorscheme catppuccin-nvim]])
  end,
}
