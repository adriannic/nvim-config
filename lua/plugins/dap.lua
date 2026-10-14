return {
	"mfussenegger/nvim-dap",
	event = "LspAttach",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"jay-babu/mason-nvim-dap.nvim",
			"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local dap = require("dap")
		local widgets = require("dap.ui.widgets")
		local dapui = require("dapui")

		dapui.setup()

		require("nvim-dap-virtual-text").setup()

		vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "Continue" })
		vim.keymap.set("n", "<F9>", function() dap.step_back() end, { desc = "Step back" })
		vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "Step over" })
		vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "Step into" })
		vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "Step out" })
		vim.keymap.set("n", "<Leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle breakpoint" })
		vim.keymap.set("n", "<Leader>dR", function() dap.repl.toggle() end, { desc = "Toggle REPL" })
		vim.keymap.set("n", "<Leader>dr", function() dap.repl.run_to_cursor() end, { desc = "Run to cursor" })
		vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
			widgets.hover()
		end, { desc = "Hover" })
		vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
			widgets.preview()
		end, { desc = "Preview" })
		vim.keymap.set("n", "<Leader>df", function()
			widgets.centered_float(widgets.frames)
		end, { desc = "Frames" })
		vim.keymap.set("n", "<Leader>ds", function()
			widgets.centered_float(widgets.scopes)
		end, { desc = "Scopes" })

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
	end,
}

-- return {
-- 	"theHamsta/nvim-dap-virtual-text",
-- 	dependencies = {
-- 		{
-- 			"mfussenegger/nvim-dap",
-- 			opts = {
-- 				adapters = {
-- 					codelldb = {
-- 						type = "executable",
-- 						command = "codelldb",
-- 					},
-- 				},
-- 			},
-- 			keys = {
-- 				{ "<Leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle breakpoint" },
-- 				{ "<Leader>dc", "<cmd>DapContinue<cr>", desc = "Continue execution" },
-- 				{ "<Leader>dn", "<cmd>DapStepOver<cr>", desc = "Step over" },
-- 				{
-- 					"<Leader>dR",
-- 					function()
-- 						require("dap").repl.toggle()
-- 					end,
-- 					desc = "Toggle REPL",
-- 				},
-- 				{ "<Leader>dr", "<cmd>DapNew<cr>", desc = "Run program in debugger" },
-- 				{ "<Leader>ds", "<cmd>DapStepInto<cr>", desc = "Step into" },
-- 			},
-- 		},
-- 		"nvim-treesitter/nvim-treesitter",
-- 	},
-- 	event = "LspAttach",
-- 	opts = {
-- 		commented = true,
-- 	},
-- }
