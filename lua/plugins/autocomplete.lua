return {
  "saghen/blink.cmp",
  version = "^1",
  event = { "InsertEnter", "CmdlineEnter" },
  opts_extend = {
    "sources.default",
    "cmdline.sources",
    "term.sources",
  },
  dependencies = {
    "rafamadriz/friendly-snippets",
    "folke/lazydev.nvim",
    "erooke/blink-cmp-latex",
    "onsails/lspkind.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    keymap = {
      preset = "none",
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
    },
    completion = {
      ghost_text = {
        enabled = true,
      },
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
      },
      menu = {
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                local icon = ctx.kind_icon
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    icon = dev_icon
                  end
                else
                  icon = require("lspkind").symbolic(ctx.kind, {
                    mode = "symbol",
                  })
                end

                return icon .. ctx.icon_gap
              end,

              -- Optionally, use the highlight groups from nvim-web-devicons
              -- You can also add the same function for `kind.highlight` if you want to
              -- keep the highlight groups in sync with the icons.
              highlight = function(ctx)
                local hl = ctx.kind_hl
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    hl = dev_hl
                  end
                end
                return hl
              end,
            }
          }
        }
      }
    },
    sources = {
      default = {
        "lsp",
        "buffer",
        "snippets",
        "path",
        "lazydev",
        "latex",
      },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        latex = {
          name = "Latex",
          module = "blink-cmp-latex",
          opts = {
            insert_command = false,
          },
        },
      },
    },
    signature = {
      enabled = true,
    },
    fuzzy = {
      implementation = "prefer_rust_with_warning",
    },
  },
}
