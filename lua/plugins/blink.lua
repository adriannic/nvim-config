return {
  "saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "rafamadriz/friendly-snippets",
    "folke/lazydev.nvim"
  },
  version = "1.*",
  opts = {
    appearance = { nerd_font_variant = "mono" },
    completion = {
      ghost_text = { enabled = true },
      accept = { auto_brackets = { enabled = true } },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
      },
    },
    keymap = {
      preset = "none",
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
    },
    signature = { enabled = true },
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        lsp = {
          name = 'LSP',
          module = 'blink.cmp.sources.lsp',
          transform_items = function(_, items)
            return vim.tbl_filter(function(item)
              return item.kind ~= require('blink.cmp.types').CompletionItemKind.Keyword
            end, items)
          end,
        },
      }
    },
    fuzzy = {
      sorts = {
        "exact",
        "score",
        "sort_text",
      },
      implementation = "prefer_rust_with_warning"
    },
    cmdline = {
      keymap = { preset = "inherit" },
      completion = {
        ghost_text = { enabled = true },
        menu = { auto_show = true }
      },
    },
  },
  opts_extend = { "sources.default" }
}
