return {
	"nvim-mini/mini.nvim",
	deps = {
		"lewis6991/gitsigns.nvim",
	},
	version = "*",
	config = function()
		require("mini.ai").setup()
		require("mini.align").setup()
		require("mini.comment").setup()
		require("mini.keymap").setup()
		require("mini.move").setup()
		require("mini.operators").setup()
		require("mini.pairs").setup()
		require("mini.splitjoin").setup()
		require("mini.surround").setup()

		require("mini.basics").setup({
			mappings = {
				windows = true,
				move_with_alt = true,
			},
		})
		require("mini.jump").setup()
		require("mini.jump2d").setup()

		require("mini.cursorword").setup()
		require("mini.hipatterns").setup({
			highlighters = {
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

				hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
			},
		})
		require("mini.icons").setup()

		local map_multistep = require("mini.keymap").map_multistep

		map_multistep("i", "<C-j>", { "pmenu_next" })
		map_multistep("i", "<Tab>", { "pmenu_next" })
		map_multistep("i", "<C-k>", { "pmenu_prev" })
		map_multistep("i", "<S-Tab>", { "pmenu_prev" })
		map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
		map_multistep("i", "<BS>", { "minipairs_bs" })
	end,
}
