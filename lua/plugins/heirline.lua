return {
	"rebelot/heirline.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	event = { "BufReadPre", "BufNewFile", "InsertEnter", "UiEnter" },
	config = function(opts)
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")
		local colors = require("catppuccin.palettes").get_palette()

		local align = {
			provider = "%=",
			hl = {
				bg = colors.crust,
			},
		}

		local separator_end = function(reverse)
			return {
				provider = (reverse and "") or "",
				hl = {
					fg = colors.base,
					bg = colors.crust,
				},
			}
		end

		local mode = {
			init = function(self)
				self.mode = vim.fn.mode(0)
			end,
			static = {
				mode_names = {
					n = "NORMAL",
					v = "VISUAL",
					V = "VISUAL",
					["\22"] = "VISUAL",
					c = "COMMAND",
					s = "SELECT",
					S = "SELECT",
					["\19"] = "SELECT",
					i = "INSERT",
					R = "REPLACE",
					r = "...",
					["!"] = "SHELL",
					t = "TERM",
				},
				mode_colors = {
					n = colors.blue,
					i = colors.green,
					v = colors.sky,
					V = colors.teal,
					["\22"] = colors.sapphire,
					c = colors.peach,
					s = colors.mauve,
					S = colors.mauve,
					["\19"] = colors.mauve,
					R = colors.flamingo,
					r = colors.flamingo,
					["!"] = colors.red,
					t = colors.yellow,
				},
			},
			provider = function(self)
				return " %(" .. self.mode_names[self.mode] .. "%) "
			end,
			hl = function(self)
				local mode = self.mode:sub(1, 1)
				return { fg = colors.base, bg = self.mode_colors[mode], bold = true }
			end,
			update = {
				"ModeChanged",
				"CmdlineLeave",
				pattern = "*:*",
				callback = vim.schedule_wrap(function()
					vim.cmd("redrawstatus")
				end),
			},
		}

		local git = {
			condition = conditions.is_git_repo,
			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict
				self.has_changes = self.status_dict.added or self.status_dict.removed or self.status_dict.changed
			end,
			hl = {
				fg = colors.blue,
				bg = colors.base,
			},
			{
				provider = function(self)
					return " " .. self.status_dict.head
				end,
				hl = {
					bold = true,
					bg = colors.base,
				},
			},
			{
				provider = function(self)
					local count = self.status_dict.added or 0
					return count > 0 and (" " .. count)
				end,
				hl = {
					fg = colors.green,
					bg = colors.base,
				},
			},
			{
				provider = function(self)
					local count = self.status_dict.removed or 0
					return count > 0 and (" " .. count)
				end,
				hl = {
					fg = colors.red,
					bg = colors.base,
				},
			},
			{
				provider = function(self)
					local count = self.status_dict.changed or 0
					return count > 0 and (" " .. count)
				end,
				hl = {
					fg = colors.peach,
					bg = colors.base,
				},
			},
			{
				provider = " ",
				hl = {
					bg = colors.base,
				},
			},
		}

		local diagnostics = {
			condition = conditions.has_diagnostics,
			static = {
				error_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.ERROR],
				warn_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.WARN],
				info_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.INFO],
				hint_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.HINT],
			},
			init = function(self)
				self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
				self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
				self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
				self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
			end,
			update = {
				"DiagnosticChanged",
				"BufEnter",
			},
			{
				provider = function(self)
					return self.errors > 0 and (self.error_icon .. "" .. self.errors .. " ")
				end,
				hl = {
					fg = colors.red,
					bg = colors.base,
				},
			},
			{
				provider = function(self)
					return self.warnings > 0 and (self.warn_icon .. "" .. self.warnings .. " ")
				end,
				hl = {
					fg = colors.peach,
					bg = colors.base,
				},
			},
			{
				provider = function(self)
					return self.info > 0 and (self.info_icon .. "" .. self.info .. " ")
				end,
				hl = {
					fg = colors.yellow,
					bg = colors.base,
				},
			},
			{
				provider = function(self)
					return self.hints > 0 and (self.hint_icon .. "" .. self.hints .. " ")
				end,
				hl = {
					fg = colors.teal,
					bg = colors.base,
				},
			},
		}

		local macro = {
			condition = function()
				return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0
			end,
			provider = function()
				return " " .. vim.fn.reg_recording() .. " "
			end,
			hl = {
				fg = colors.mauve,
				bg = colors.base,
				bold = true,
			},
			update = {
				"RecordingEnter",
				"RecordingLeave",
			},
		}

		local lsp = {
			condition = conditions.lsp_attached,
			update = {
				"LspAttach",
				"LspDetach",
			},
			provider = function()
				local names = {}
				for i, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
					table.insert(names, " " .. server.name)
				end
				return " " .. table.concat(names, " ") .. " "
			end,
			hl = {
				fg = colors.text,
				bg = colors.base,
			},
		}

		local fileinfo = {
			provider = function()
				local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
				return " " .. vim.bo.filetype .. " " .. enc .. " " .. vim.bo.fileformat .. " "
			end,
			hl = {
				fg = colors.blue,
				bg = colors.base,
			},
		}

		local ruler = {
			provider = " %l:%c %P ",
			hl = {
				fg = colors.base,
				bg = colors.blue,
				bold = true,
			},
		}

		local status_line = {
			mode,
			{
				provider = " ",
				hl = {
					bg = colors.base,
				},
			},
			git,
			diagnostics,
			macro,
			separator_end(false),
			align,
			separator_end(true),
			lsp,
			fileinfo,
			ruler,
		}

		local file_icon = {
			init = function(self)
				local filename = self.filename
				local extension = vim.fn.fnamemodify(filename, ":e")
				self.icon, self.icon_color =
					require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
			end,
			provider = function(self)
				return self.icon and (" " .. self.icon .. " ")
			end,
			hl = function(self)
				return { fg = self.icon_color }
			end,
		}

		local file_name = {
			provider = function(self)
				local filename = self.filename
				filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
				return filename
			end,
			hl = function(self)
				return {
					bold = self.is_active or self.is_visible,
				}
			end,
		}

		local file_flags = {
			condition = function(self)
				return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
			end,
			provider = " ",
			hl = {
				fg = colors.yellow,
			},
			{
				condition = function(self)
					return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
						or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
				end,
				provider = function(self)
					if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
						return " "
					else
						return " "
					end
				end,
				hl = {
					fg = colors.text,
				},
			},
		}

		local filename_block = {
			init = function(self)
				self.filename = vim.api.nvim_buf_get_name(self.bufnr)
			end,
			hl = function(self)
				if self.is_active then
					return "TabLineSel"
				else
					return "TabLine"
				end
			end,
			on_click = {
				callback = function(_, minwid, _, button)
					if button == "m" then
						vim.schedule(function()
							vim.api.nvim_buf_delete(minwid, { force = false })
						end)
					else
						vim.api.nvim_win_set_buf(0, minwid)
					end
				end,
				minwid = function(self)
					return self.bufnr
				end,
				name = "heirline_tabline_buffer_callback",
			},
			file_icon,
			file_flags,
			file_name,
			{
				provider = " ",
			},
		}

		local buffer_line = utils.make_buflist(
			filename_block,
			{ provider = "", hl = { fg = "gray" } },
			{ provider = "", hl = { fg = "gray" } }
		)

		require("heirline").setup({
			colors = colors,
			statusline = status_line,
			tabline = buffer_line,
		})

		vim.o.showtabline = 2
		vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
	end,
	keys = {
		{ "H", "<cmd>bprevious<cr>", "Previous buffer" },
		{ "L", "<cmd>bnext<cr>", "Next buffer" },
	},
}
