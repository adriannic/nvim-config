---@type LazySpec
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("lint").linters_by_ft = {
      dockerfile = { "hadolint" },
      lua = { "selene" },
      sh = { "shellcheck" },
      zsh = { "shellcheck" },
    }
  end,
}
