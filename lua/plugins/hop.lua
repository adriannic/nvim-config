---@type LazySpec
return {
  "phaazon/hop.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  keys = {
    {
      "<leader>j",
      desc = "Jump",
      mode = { "n", "v" },
    },
    {
      "<leader>jw",
      function() require("hop").hint_words() end,
      mode = { "n" },
      desc = "Jump to word",
    },
    {
      "<leader>jl",
      function() require("hop").hint_lines() end,
      mode = { "n" },
      desc = "Jump to line",
    },
    {
      "<leader>jw",
      function() require("hop").hint_words { extend_visual = true } end,
      mode = { "v" },
      desc = "Jump to word",
    },
    {
      "<leader>jl",
      function() require("hop").hint_lines { extend_visual = true } end,
      mode = { "v" },
      desc = "Jump to line",
    },
  },
}
