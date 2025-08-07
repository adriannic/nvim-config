return {
  "danymat/neogen",
  opts = {
    snippet_engine = "luasnip",
  },
  keys = {
    { "<Leader>a<cr>", function() require("neogen").generate { type = "any" } end,   desc = "Annotate current" },
    { "<Leader>ac",    function() require("neogen").generate { type = "class" } end, desc = "Annotate class" },
    { "<Leader>af",    function() require("neogen").generate { type = "func" } end,  desc = "Annotate function" },
    { "<Leader>at",    function() require("neogen").generate { type = "type" } end,  desc = "Annotate type" },
    { "<Leader>aF",    function() require("neogen").generate { type = "file" } end,  desc = "Annotate file" },
  },
}
