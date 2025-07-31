---@type LazySpec
return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },
  keys = {
    { "<F5>", function() require("dap").continue() end, desc = "Debug: Start/Continue" },
    { "<F1>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
    { "<F2>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
    { "<F3>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
    { "<Leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle breakpoint" },
    {
      "<Leader>dB",
      function() require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ") end,
      desc = "Debug: Set breakpoint",
    },
    { "<F7>", function() require("dapui").toggle() end, desc = "Debug: Toggle debug UI" },
  },
  config = function()
    local dap = require "dap"
    local dapui = require "dapui"

    dapui.setup {}

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close
  end,
}
