return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-neotest/neotest-python",
		"mrcjkb/rustaceanvim",
		"alfaix/neotest-gtest",
	},
	ft = {
		"c",
		"cpp",
		"python",
		"rust",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python"),
				require("rustaceanvim.neotest"),
				require("neotest-gtest").setup({}),
			},
		})
	end,
	keys = {
		{ "<Leader>tt", function() require("neotest").summary.toggle() end, desc = "Toggle test window" }
	}
}
