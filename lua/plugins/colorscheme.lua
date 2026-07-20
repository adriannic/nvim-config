return {
	"catppuccin/nvim",
	event = "VimEnter",
	name = "catppuccin",
	priority = 1000,
	config = function(_, _)
		require("catppuccin").setup({
			float = {
				transparent = true,
				solid = false
			},
			no_italic = true,
		})

		vim.cmd([[colorscheme catppuccin-nvim]])
	end,
}
