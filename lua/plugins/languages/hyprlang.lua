-- hyprlang filetype
vim.filetype.add {
  filetypes = {
    extension = {
      hl = "hyprlang",
    },
    pattern = {
      [".*/hypr/.*.conf"] = "hyprlang",
      ["hypr.*.conf"] = "hyprlang",
    },
  },
}

return {
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "hyprls" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "hyprls" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "hyprlang" })
      end
    end,
  },
}
