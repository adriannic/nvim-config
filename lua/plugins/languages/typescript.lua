return {
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = function(_, opts)
			if opts.ensure_installed ~= "all" then
				opts.ensure_installed =
					vim.list_extend(opts.ensure_installed or {}, { "javascript", "typescript", "tsx", "jsdoc" })
			end
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "vtsls" })
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "js" })
			if not opts.handlers then
				opts.handlers = {}
			end
			opts.handlers.python = function() end
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "vtsls", "js-debug-adapter" })
		end,
	},
	{
		"dmmulroy/tsc.nvim",
		cmd = "TSC",
		opts = {},
	},
}
