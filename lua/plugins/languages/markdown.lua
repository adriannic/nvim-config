return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "markdown", "markdown_inline" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "marksman" })
    end,
  },
  {
    "williamboman/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "prettierd" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "marksman", "prettierd" })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        markdown = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    enabled = vim.fn.executable "yarn" == 1 or vim.fn.executable "npx" == 1,
    build = function(plugin)
      local package_manager = vim.fn.executable "yarn" and "yarn" or vim.fn.executable "npx" and "npx -y yarn" or false

      --- HACK: Use `yarn` or `npx` when possible, otherwise throw an error
      ---@see https://github.com/iamcco/markdown-preview.nvim/issues/690
      ---@see https://github.com/iamcco/markdown-preview.nvim/issues/695
      if not package_manager then error "Missing `yarn` or `npx` in the PATH" end

      local cmd = string.format(
        "!cd %s && cd app && COREPACK_ENABLE_AUTO_PIN=0 %s install --frozen-lockfile",
        plugin.dir,
        package_manager
      )

      vim.cmd(cmd)
    end,
    ft = { "markdown", "markdown.mdx" },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "markdown.mdx" },
    opts = {},
  },

}
