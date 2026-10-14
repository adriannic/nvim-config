return {
	{
		"mason-org/mason-lspconfig.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
				"ruff",
			})
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "debugpy" })
			if not opts.handlers then
				opts.handlers = {}
			end
			opts.handlers.python = function() end
		end,
	},
	{
		"linux-cultist/venv-selector.nvim",
		branch = "regexp",
		enabled = vim.fn.executable("fd") == 1 or vim.fn.executable("fdfind") == 1 or vim.fn.executable("fd-find") == 1,
		ft = "python",
		keys = {
			{ "<Leader>lv", "<Cmd>VenvSelect<CR>", desc = "LSP select virtualenv" },
		},
		opts = {},
		cmd = "VenvSelect",
	},
	{
		"mfussenegger/nvim-dap",
		event = { "BufReadPre", "BufNewFile" },
		optional = true,
		specs = {
			{
				"mfussenegger/nvim-dap-python",
				dependencies = "mfussenegger/nvim-dap",
				ft = "python",
				opts = function(_, opts)
					local path = vim.fn.exepath("debugpy-adapter")
					if path == "" then
						path = vim.fn.exepath("python")
					end
					require("dap-python").setup(path, opts)
				end,
			},
		},
	},
}
