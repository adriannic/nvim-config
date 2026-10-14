return {
	{
		"mason-org/mason-lspconfig.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "panache" })
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "cbfmt" })
		end,
	},
	{
		"OXY2DEV/markview.nvim",
		ft = { "markdown" },
		dependencies = {
			"saghen/blink.cmp",
			"nvim-mini/mini.nvim",
		},
		opts = {
			preview = {
				icon_provider = "mini",
			},
		},
	},
}
