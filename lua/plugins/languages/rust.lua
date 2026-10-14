return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "codelldb"
      })
    end,
  },
	{
		"Saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		opts = {
			completion = {
				crates = { enabled = true },
			},
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},
		},
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^9",
		lazy = false,
	},
}
