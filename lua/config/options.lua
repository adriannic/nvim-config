vim.o.relativenumber = true
vim.o.number = true

vim.o.mouse = "a"
vim.o.cmdheight = 0

vim.o.signcolumn = "yes"

vim.o.cursorline = true

vim.schedule(function() vim.o.clipboard = "unnamedplus" end)

vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.inccommand = "split"

vim.o.wrap = true
vim.o.breakindent = true

vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

vim.o.updatetime = 300
vim.o.timeoutlen = 500

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.undofile = true
vim.o.swapfile = false

vim.o.scrolloff = 10

vim.o.confirm = true

vim.o.winborder = "rounded"

vim.diagnostic.config {
  severity_sort = true,
  float = {
    border = "rounded",
    source = "if_many",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = "󰋼 ",
      [vim.diagnostic.severity.HINT] = "󰌵 ",
    },
  },
}
