return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      {
        "mason-org/mason.nvim",
        opts = {},
      },
      {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
      },
      {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
          "mason-org/mason.nvim",
          "nvimtools/none-ls.nvim",
        },
        opts = {},
      },
      {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        opts = {
          auto_install = true,
          highlight = {
            enable = true,
          },
          indent = {
            enable = true,
          },
        },
      },
      {
        "j-hui/fidget.nvim",
        event = "LSPAttach",
        opts = {},
      }
    },
    opts = function(_, opts)
      opts.auto_update = true
      opts.start_delay = 0

      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("config.lsp-lens", { clear = true }),
        callback = function(_) vim.lsp.codelens.refresh { bufnr = 0 } end,
      })
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          ---@param keys string keybinding
          ---@param func function keybinding callback
          ---@param desc string description
          ---@param mode? string|table modes it is available in
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP " .. desc })
          end

          map("<Leader>lD", function() Snacks.picker.diagnostics() end, "find diagnostics")
          map("<Leader>lS", require("aerial").toggle, "show Symbols")
          map("<Leader>la", vim.lsp.buf.code_action, "apply quickfix", { "n", "x" })
          map("<Leader>la", vim.lsp.buf.code_action, "code Action", { "n", "x" })
          map("<Leader>ld", function() vim.diagnostic.open_float() end, "show hover diagnostics")
          map("<Leader>lf", vim.lsp.buf.format, "format buffer")
          map("<Leader>ll", vim.lsp.codelens.run, "codelens run")
          map("<Leader>lr", vim.lsp.buf.rename, "rename")
          map("<Leader>ls", function() Snacks.picker.lsp_symbols() end, "find Symbols")
          map("gD", function() Snacks.picker.lsp_declarations() end, "goto declaration")
          map("gI", function() Snacks.picker.lsp_implementations() end, "goto implementation")
          map("gd", function() Snacks.picker.lsp_definitions() end, "goto definition")
          map("gr", function() Snacks.picker.lsp_references() end, "goto references")
          map("gt", function() Snacks.picker.lsp_type_definitions() end, "goto type definition")

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
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
        end
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "mfussenegger/nvim-dap",
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
    config = function() end
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    opts = {
      diagnostics = {
        virtual_text = false,
      }
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      { "<F5>",       function() require("dap").continue() end,          desc = "Debug: Start/Continue" },
      { "<F1>",       function() require("dap").step_into() end,         desc = "Debug: Step Into" },
      { "<F2>",       function() require("dap").step_over() end,         desc = "Debug: Step Over" },
      { "<F3>",       function() require("dap").step_out() end,          desc = "Debug: Step Out" },
      { "<Leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle breakpoint" },
      {
        "<Leader>dB",
        function() require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ") end,
        desc = "Debug: Set breakpoint",
      },
      { "<F7>", function() require("dapui").toggle() end, desc = "Debug: Toggle debug UI" },
    },
    opts = function(_, _)
      local dap = require "dap"
      local dapui = require "dapui"

      dapui.setup {}

      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      commented = true,
      enabled = true,
      enabled_commands = true,
    },
  }
}
