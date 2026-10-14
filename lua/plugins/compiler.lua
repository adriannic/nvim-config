return {
	"Zeioth/compiler.nvim",
	cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo", "CompilerStop" },
	dependencies = {
		{
			"stevearc/overseer.nvim",
			cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo", "CompilerStop" },
			opts = {
				task_list = {
					direction = "bottom",
					min_height = 25,
					max_height = 25,
					default_detail = 1,
				},
			},
		},
		"nvim-telescope/telescope.nvim",
	},
	opts = {},
	keys = {
		{ "<Leader>bc", ":CompilerStop<cr>", desc = "Clear all tasks" },
		{ "<Leader>bo", ":CompilerOpen<cr>", desc = "Open compiler" },
		{ "<Leader>br", ":CompilerRedo<cr>", desc = "Redo the last selected option" },
		{ "<Leader>bt", ":CompilerToggleResults<cr>", desc = "Toggle compiler results" },
	},
}
