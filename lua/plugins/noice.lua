return {
  "folke/noice.nvim",
	event = "CmdlineEnter",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
  opts = {
		lsp = {
			signature = {
				enabled = false,
			},
			hover = {
				enabled = false,
			}
		}
	},
}
