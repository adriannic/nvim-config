return {
	{
		"mason-org/mason-lspconfig.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
				"fish_lsp",
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		optional = true,
		opts = function(_, opts)
			local nls = require("null-ls")
			if not opts.sources then
				opts.sources = {}
			end
			opts.sources = vim.list_extend(opts.sources, {
				nls.builtins.formatting.fish_indent,
				nls.builtins.diagnostics.fish,
			})
		end,
	},
}
