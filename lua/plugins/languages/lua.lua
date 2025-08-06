return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "lua", "luap" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "lua_ls" })
    end,
  },
  {
    "williamboman/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "stylua", "selene" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "lua-language-server", "stylua", "selene" })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      local function selene_configured(path)
        return #vim.fs.find("selene.toml", { path = path, upward = true, type = "file" }) > 0
      end

      opts.linters_by_ft = {
        lua = { "selene" },
      }
      opts.linters = opts.linters or {}
      opts.linters.selene = {
        condition = function(ctx)
          return selene_configured(ctx.filename)
        end
      }
    end,
  }
}
