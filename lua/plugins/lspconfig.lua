---@type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", lazy = false, opts = {} },
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", event = "LSPAttach", tag = "v1.6.1" },
    },
    config = function()
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("config.lsp-lens", { clear = true }),
        callback = function(event) vim.lsp.codelens.refresh { bufnr = 0 } end,
      })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("config.lsp-attach", { clear = true }),
        callback = function(event)
          --- Keymaps
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP " .. desc })
          end

          map("<Leader>lD", function() Snacks.picker.diagnostics() end, "Find diagnostics")
          map("<Leader>lS", require("aerial").toggle, "Show Symbols")
          map("<Leader>la", vim.lsp.buf.code_action, "Apply quickfix", { "n", "x" })
          map("<Leader>la", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
          map("<Leader>ld", function() vim.diagnostic.open_float() end, "Show hover diagnostics")
          map("<Leader>lf", function() require("conform").format { async = true } end, "Format buffer")
          map("<Leader>ll", vim.lsp.codelens.run, "Codelens run")
          map("<Leader>lr", vim.lsp.buf.rename, "Rename")
          map("<Leader>ls", function() Snacks.picker.lsp_symbols() end, "Find Symbols")
          map("gD", function() Snacks.picker.lsp_declarations() end, "Goto declaration")
          map("gI", function() Snacks.picker.lsp_implementations() end, "Goto implementation")
          map("gd", function() Snacks.picker.lsp_definitions() end, "Goto definition")
          map("gr", function() Snacks.picker.lsp_references() end, "Goto references")
          map("gt", function() Snacks.picker.lsp_type_definitions() end, "Goto type definition")
          map(
            "K",
            function() vim.lsp.buf.hover { border = "rounded", max_height = 25, max_width = 120 } end,
            "Show documentation"
          )

          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has "nvim-0.11" == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if
            client
            and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
          then
            local highlight_augroup = vim.api.nvim_create_augroup("config.lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("config.lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = "config.lsp-highlight", buffer = event2.buf }
              end,
            })
          end

          vim.lsp.inlay_hint.enable(true)
        end,
      })

      vim.diagnostic.config {
        severity_sort = true,
        float = {
          border = "rounded",
          source = "if_many",
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = "󰋼 ",
            [vim.diagnostic.severity.HINT] = "󰌵 ",
          },
        },
      }

      local language_servers = {
        lua_ls = {
          settings = {
            Lua = {
              hint = {
                enable = true,
                arrayIndex = "Disable",
              },
            },
          },
        },
        ["rust-analyzer"] = {
          diagnostics = {
            enable = true,
            experimental = {
              enable = true,
            },
          },
          files = {
            excludeDirs = { ".direnv", ".git", "target" },
          },
          check = {
            command = "clippy",
            extraArgs = { "--no-deps" },
          },
        },
        taplo = {},
        bashls = {
          filetypes = { "sh", "bash", "zsh" },
        },
        neocmakelsp = {},
        clangd = {},
        dockerls = {},
        docker_compose_language_service = {},
        jsonls = { settings = { json = { validate = { enable = true } } } },
        html = { init_options = { provideFormatter = false } },
        cssls = { init_options = { provideFormatter = false } },
        hyprls = {},
        marksman = {},
        basedpyright = {},
        yamlls = {},
      }

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

      local debuggers = {
        codelldb = {},
        cpptools = {},
        ["bash-debug-adapter"] = {},
        debugpy = {},
      }

      local linters = {
        selene = {},
        bacon = {},
        shellcheck = {},
        hadolint = {},
      }

      local formatters = {
        stylua = {},
        shfmt = {},
        prettierd = {},
        black = {},
        isort = {},
      }

      local remove = function(a, b)
        for _, elem in pairs(b) do
          for i, v in ipairs(a) do
            if v == elem then table.remove(a, i) end
          end
        end
      end

      local ensure_installed = vim.tbl_keys(language_servers or {})
      vim.list_extend(ensure_installed, vim.tbl_keys(debuggers or {}))
      vim.list_extend(ensure_installed, vim.tbl_keys(linters or {}))
      vim.list_extend(ensure_installed, vim.tbl_keys(formatters or {}))

      remove(ensure_installed, {
        "rust-analyzer",
      })

      require("mason-lspconfig").setup {
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = language_servers[server_name] or {}
            require("lspconfig")[server_name].setup(server)
          end,
        },
      }

      require("mason-tool-installer").setup {
        ensure_installed = ensure_installed,
        auto_update = true,
      }
    end,
    opts = {
      inlay_hints = {
        enabled = true,
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    opts = {
      ensure_installed = {},
      automatic_installation = false,
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      ensure_installed = {},
      automatic_installation = false,
    },
  },
}
