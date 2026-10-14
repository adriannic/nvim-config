return {
	{
		"mason-org/mason-lspconfig.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "taplo" })
		end,
	},
}
