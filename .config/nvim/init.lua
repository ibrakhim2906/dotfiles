vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Look: Tokyo Night (night) + JetBrains Mono, shared with Windows Terminal, tmux, the prompt and
-- Codex. The font only applies in Neovide (a terminal uses its own).
local font = "JetBrainsMono NFM:h14"

local o = vim.opt
o.number = true
o.relativenumber = true
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
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
if not vim.uv.fs_stat(lazypath) then
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
map("n", "<leader>s", require("sessions").restore, { desc = "Restore this folder's session" })
map("n", "<leader>b", require("build"), { desc = "Build CMake project (errors to quickfix)" })
require("gdb")  -- <leader>d…: debugging with built-in Termdebug
vim.opt.ttimeoutlen = 10
vim.o.timeoutlen = 300
vim.opt.pumheight = 10
vim.opt.cursorline = true
vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
vim.opt.showmode = false  -- lualine already shows the mode
vim.o.winborder = "rounded"  -- hover, signature help and other floats match the terminal float

vim.cmd.colorscheme("tokyonight-night")

-- Neovide only: same font and colors as Windows Terminal. No effect in a terminal.
if vim.g.neovide then
  vim.o.guifont = font
  -- Window title (no title bar; this is the taskbar and Alt+Tab label): "file - project",
  -- or just the project in a folder view (Oil's raw oil:// path is noise).
  vim.o.title = true
  vim.o.titlestring = [[%{expand('%:t') != '' ? expand('%:t') . '  -  ' : ''}%{fnamemodify(getcwd(), ':t')}]]
  -- Launched from Windows, Neovide starts in a /mnt/c folder; work from the WSL home instead.
  if vim.fn.argc() == 0 and vim.fn.getcwd():find("^/mnt/") then vim.fn.chdir("~") end
  -- Neovide has no paste shortcut of its own; mirror Windows Terminal's Ctrl+Shift+V.
  map({ "n", "v" }, "<C-S-v>", '"+p', { desc = "Paste from system clipboard" })
  map({ "i", "c" }, "<C-S-v>", "<C-r>+", { desc = "Paste from system clipboard" })
  map("t", "<C-S-v>", [[<C-\><C-n>"+pi]], { desc = "Paste from system clipboard" })
  -- Ctrl+= / Ctrl+- / Ctrl+0 zoom, like most GUI apps.
  local function zoom(step)
    return function() vim.g.neovide_scale_factor = step and vim.g.neovide_scale_factor * step or 1.0 end
  end
  vim.g.neovide_scale_factor = 1.0
  map("n", "<C-=>", zoom(1.1), { desc = "Zoom in" })
  map("n", "<C-->", zoom(1 / 1.1), { desc = "Zoom out" })
  map("n", "<C-0>", zoom(nil), { desc = "Reset zoom" })

  -- Animations (lengths in seconds; 0 turns one off).
  vim.g.neovide_cursor_animation_length = 0.1
  vim.g.neovide_cursor_trail_size = 0.7
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_cursor_vfx_mode = ""  -- try "railgun", "pixiedust" or "sonicboom"
  vim.g.neovide_scroll_animation_length = 0.25
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_padding_top = 32  -- no title bar, so this is the space above the first line
  vim.g.neovide_padding_left = 8
  vim.g.neovide_padding_right = 8

  -- Floating terminal for quick commands; Windows Terminal for gdb and long sessions.
  local term = require("terminals")
  map({ "n", "t" }, "<C-/>", term.toggle, { desc = "Toggle floating terminal" })
  map("n", "<leader>T", term.open_windows_terminal, { desc = "Open Windows Terminal at project root" })
end
