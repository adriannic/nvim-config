return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"<Leader>pa",
				"<cmd>MasonUpdate<cr><cmd>Lazy update<cr>",
				desc = "Update all",
			},
			{
				"<Leader>pm",
				"<cmd>Mason<cr>",
				desc = "Open Mason",
			},
		},
		dependencies = {
			{
				"mason-org/mason-lspconfig.nvim",
				opts = {},
				dependencies = {
					"mason-org/mason.nvim",
					"neovim/nvim-lspconfig",
				},
			},
			{
				"jay-babu/mason-null-ls.nvim",
				dependencies = {
					"mason-org/mason.nvim",
					{
						"nvimtools/none-ls.nvim",
						dependencies = {
							"nvim-lua/plenary.nvim",
						},
					},
				},
				opts = {},
			},
			"mfussenegger/nvim-dap",
			{
				"jay-babu/mason-nvim-dap.nvim",
				dependencies = {
					"mason-org/mason.nvim",
				},
			},
		},
		opts = {
			ensure_installed = {
				"lua_ls",
			},
		},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "LspAttach",
		opts = {
			diagnostics = {
				virtual_text = false,
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
				group = vim.api.nvim_create_augroup("config.lsp-lens", { clear = true }),
				callback = function(_)
					vim.lsp.codelens.enable(true, { bufnr = 0 })
				end,
			})
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					---@param keys string keybinding
					---@param func function keybinding callback
					---@param desc string description
					---@param mode? string|table modes it is available in
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP " .. desc })
					end

					map("<Leader>lD", function()
						Snacks.picker.diagnostics()
					end, "find diagnostics")
					map("<Leader>la", vim.lsp.buf.code_action, "code Action", { "n", "x" })
					map("<Leader>ld", function()
						vim.diagnostic.open_float()
					end, "show hover diagnostics")
					map("<Leader>lf", vim.lsp.buf.format, "format buffer", { "n", "x" })
					map("<Leader>ll", vim.lsp.codelens.run, "codelens run")
					map("<Leader>lr", vim.lsp.buf.rename, "rename")
					map("<Leader>ls", function()
						Snacks.picker.lsp_symbols()
					end, "find Symbols")
					map("gD", function()
						Snacks.picker.lsp_declarations()
					end, "goto declaration")
					map("gI", function()
						Snacks.picker.lsp_implementations()
					end, "goto implementation")
					map("gd", function()
						Snacks.picker.lsp_definitions()
					end, "goto definition")
					map("gr", function()
						Snacks.picker.lsp_references()
					end, "goto references")
					map("gt", function()
						Snacks.picker.lsp_type_definitions()
					end, "goto type definition")

					local client = vim.lsp.get_client_by_id(event.data.client_id)

					if
						client
						and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
					then
						local highlight_augroup = vim.api.nvim_create_augroup("config.lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("config.lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "config.lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					vim.lsp.inlay_hint.enable(true)
				end,
			})
		end,
	},
	dependencies = {
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = { {
					path = "${3rd}/luv/library",
					words = { "vim%.uv" },
				} },
			},
		},
	},
}
