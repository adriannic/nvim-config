return {
	{
		"mason-org/mason-lspconfig.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
				"neocmake",
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
				"cmakelang",
			})
		end,
	},
	{
		"Civitasv/cmake-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
    lazy = true,
		opts = {},
	},
}
