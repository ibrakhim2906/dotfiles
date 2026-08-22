vim.g.mapleader = " "
vim.g.maplocalleader = " "

local o = vim.opt
o.number = true
o.relativenumber = true
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true
o.ignorecase = true
o.smartcase = true
o.termguicolors = true
o.signcolumn = "yes"
o.updatetime = 300
o.splitright = true
o.splitbelow = true
o.scrolloff = 8
o.clipboard = "unnamedplus"
o.undofile = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

-- Neovim 0.11+ already provides: grn (rename), gra (code action),
-- grr (references), gri (implementation), grt (type definition),
-- K (hover), [d / ]d (diagnostic navigation) — no config needed.
-- Only keeping what those defaults don't cover:
local map = vim.keymap.set
map("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open file explorer (Oil)" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Grep in project" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "List open buffers" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.opt.ttimeoutlen = 10
vim.o.timeoutlen = 300
