return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    styles = {
      terminal = {
        border = vim.o.winborder,
      },
    },
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    dashboard = {
      preset = {
        header = table.concat({
          " █████╗ ██████╗ ██████╗ ██╗ █████╗ ███╗   ██╗███╗   ██╗██╗ ██████╗",
          "██╔══██╗██╔══██╗██╔══██╗██║██╔══██╗████╗  ██║████╗  ██║██║██╔════╝",
          "███████║██║  ██║██████╔╝██║███████║██╔██╗ ██║██╔██╗ ██║██║██║     ",
          "██╔══██║██║  ██║██╔══██╗██║██╔══██║██║╚██╗██║██║╚██╗██║██║██║     ",
          "██║  ██║██████╔╝██║  ██║██║██║  ██║██║ ╚████║██║ ╚████║██║╚██████╗",
          "╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═══╝╚═╝ ╚═════╝",
        }, "\n"),
      },
    },
    dim = { enabled = false },
    explorer = { enabled = true },
    gitbrowse = { enabled = true },
    image = { enabled = true },
    indent = {
      enabled = true,
      animate = {
        enabled = false,
      },
    },
    input = { enabled = true },
    layout = { enabled = true },
    lazygit = { enabled = vim.fn.executable "lazygit" == 1 },
    notifier = { enabled = true },
    picker = { enabled = true },
    profiler = { enabled = true },
    quickfile = { enabled = true },
    rename = { enabled = true },
    scope = { enabled = true },
    statuscolumn = { enabled = true },
    terminal = { enabled = true },
    win = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    -- Explorer
    { "<Leader>e",  function() Snacks.explorer.open() end,         desc = "Open explorer" },
    -- Find
    { "<Leader>fc", function() Snacks.picker.grep_word() end,      desc = "Find word under cursor",  mode = { "n", "x" } },
    { "<Leader>fC", function() Snacks.picker.colorschemes() end,   desc = "Find colorschemes" },
    { "<Leader>ff", function() Snacks.picker.smart() end,          desc = "Find Files" },
    { "<Leader>fh", function() Snacks.picker.help() end,           desc = "Find help" },
    { "<Leader>fm", function() Snacks.picker.man() end,            desc = "Find manuals" },
    { "<Leader>fn", function() Snacks.picker.notifications() end,  desc = "Find notifications" },
    { "<Leader>fp", function() Snacks.picker.projects() end,       desc = "Find projects" },
    { "<Leader>fP", function() Snacks.picker.pickers() end,        desc = "Find pickers" },
    { "<Leader>ft", function() Snacks.picker.todo_comments() end,  desc = "Find todos" },
    { "<Leader>fu", function() Snacks.picker.undo() end,           desc = "Find undo history" },
    { "<Leader>fw", function() Snacks.picker.grep() end,           desc = "Find word" },
    { "<Leader>fz", function() Snacks.picker.zoxide() end,         desc = "Find zoxide" },
    -- Git
    { "<Leader>gb", function() Snacks.picker.git_branches() end,   desc = "Git branches" },
    { "<Leader>gd", function() Snacks.picker.git_diff() end,       desc = "Git diff" },
    { "<Leader>gg", function() Snacks.lazygit.open() end,          desc = "Lazygit" },
    { "<Leader>gl", function() Snacks.picker.git_log() end,        desc = "Git log" },
    { "<Leader>go", function() Snacks.gitbrowse.open() end,        desc = "Git open" },
    { "<Leader>gs", function() Snacks.picker.git_status() end,     desc = "Git status" },
    -- Terminal
    { "<Leader>tf", function() Snacks.terminal.toggle("bash") end, desc = "Toggle floating terminal" },
  },
}
