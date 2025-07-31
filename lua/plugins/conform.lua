---@type LazySpec
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  ---@module 'conform'
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      ["yaml.docker-compose"] = { "prettierd", "prettier", stop_after_first = false },
      css = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      less = { "prettierd", "prettier", stop_after_first = true },
      lua = { "stylua" },
      markdown = { "prettierd", "prettier", stop_after_first = true },
      postcss = { "prettierd", "prettier", stop_after_first = true },
      python = { "isort", "black" },
      scss = { "prettierd", "prettier", stop_after_first = true },
      sh = { "shfmt", "shellcheck" },
      yaml = { "prettierd", "prettier", stop_after_first = true },
      zsh = { "shfmt", "shellcheck" },
    },
    format_on_save = false,
  },
}
