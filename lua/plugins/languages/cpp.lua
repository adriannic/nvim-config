return {
	{
		"mason-org/mason-lspconfig.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
				"clangd",
			})
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
				"cpptools",
				"codelldb",
			})
		end,
	},
	{
		"p00f/clangd_extensions.nvim",
		lazy = true,
	},
}
