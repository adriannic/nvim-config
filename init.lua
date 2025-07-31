-- Startup profiling
if vim.env.PROF then
  -- example for lazy.nvim
  -- change this to the correct path for your plugin manager
  local snacks = vim.fn.stdpath "data" .. "/lazy/snacks.nvim"
  vim.opt.rtp:append(snacks)
  require("snacks.profiler").startup {
    startup = {
     event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
      -- event = "UIEnter",
      -- event = "VeryLazy",
    },
  }
end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- [ Options ]

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.number = true
vim.o.relativenumber = true

vim.o.mouse = "a"

vim.diagnostic.config {
  virtual_lines = false,
  virtual_text = false,
}

vim.o.cmdheight = 0

vim.schedule(function() vim.o.clipboard = "unnamedplus" end)

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.smartindent = true

vim.o.breakindent = true

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = "yes"

vim.o.updatetime = 300

vim.o.timeoutlen = 500

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.o.inccommand = "split"

vim.o.cursorline = true

vim.o.scrolloff = 10

vim.o.confirm = true

-- [ Keymaps ]

-- Misc
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move to lower split" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move to upper split" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move to right split" })
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<C-q>", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<Leader>pa", "<cmd>MasonUpdate<cr><cmd>Lazy update<cr>", { desc = "Update all" })
vim.keymap.set("n", "<Leader>pm", "<cmd>Mason<cr>", { desc = "Open Mason" })
vim.keymap.set("n", "<Leader>c", "<cmd>bdelete<cr>", { desc = "Close buffer" })
vim.keymap.set("n", "<Leader>/", "gcc<esc>", { desc = "Comment line", remap = true })
vim.keymap.set("v", "<Leader>/", "gcc<esc>", { desc = "Comment lines", remap = true })

-- [ autocommands ]

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("config.highlight-yank", { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- [ Plugins ]
require("lazy").setup {
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "catppuccin" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
}

vim.cmd.colorscheme "catppuccin"
