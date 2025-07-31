local get_project_name = function() return vim.fn.getcwd():match "^.+/(.+)$" end

---@type LazySpec
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "yavorski/lualine-macro-recording.nvim", "nvim-tree/nvim-web-devicons" },
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    options = {
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "macro_recording" },
      lualine_x = { "lsp_status", "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          "buffers",
          show_filename_only = false,
          symbols = {
            alternate_file = "",
          },
        },
      },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    winbar = {
      lualine_a = { get_project_name },
      lualine_b = { "branch" },
      lualine_c = { "aerial" },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  },
  keys = {
    { "H", "<cmd>bprevious<cr>", "Previous buffer" },
    { "L", "<cmd>bnext<cr>", "Next buffer" },
  },
}
