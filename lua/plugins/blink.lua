---@type LazySpec
return {
  "saghen/blink.cmp",
  version = "^1",
  event = { "InsertEnter", "CmdlineEnter" },
  -- build = "cargo build --release",
  opts_extend = {
    "sources.default",
    "cmdline.sources",
    "term.sources",
  },
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
    },
    "rafamadriz/friendly-snippets",
    "folke/lazydev.nvim",
    "erooke/blink-cmp-latex",
    "Kaiser-Yang/blink-cmp-git",
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "super-tab",
      ["<C-e>"] = false,
      ["<C-n>"] = false,
      ["<C-p>"] = false,
      ["<S-k>"] = { "select_prev", "fallback" },
      ["<S-j>"] = { "select_next", "fallback" },
    },
    completion = {
      list = {},
    },
    sources = {
      default = {
        "lsp",
        "buffer",
        "snippets",
        "path",
        "lazydev",
        "latex",
        "git",
      },
      completion = {
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          },
        },
        menu = {
          auto_show = function(ctx) return ctx.mode ~= "cmdline" end,
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          draw = {
            treesitter = { "lsp" },
          },
        },
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
          window = {
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          },
        },
      },
      signature = {
        window = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
        },
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
        git = {
          name = "Git",
          module = "blink-cmp-git",
          opts = {},
        },
      },
    },
    fuzzy = {
      implementation = "prefer_rust_with_warning",
    },
  },
}
