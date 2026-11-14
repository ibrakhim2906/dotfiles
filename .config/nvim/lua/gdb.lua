-- Debug C/C++ with Neovim's built-in Termdebug: gdb runs in a split, breakpoints
-- and the current line show in your code. No plugin needed.
-- <leader>dd starts gdb on a program; the other <leader>d keys work once it runs.
vim.g.termdebug_config = { wide = 1 }
vim.api.nvim_set_hl(0, "debugPC", { link = "Visual" })
vim.api.nvim_set_hl(0, "debugBreakpoint", { link = "DiagnosticError" })

local last_program

local function start()
  vim.cmd.packadd("termdebug")
  last_program = vim.fn.input("Program: ", last_program or (vim.fn.getcwd() .. "/"), "file")
  if last_program ~= "" then vim.cmd("Termdebug " .. vim.fn.fnameescape(last_program)) end
end

-- Termdebug's commands only exist while it runs.
local function gdb(cmd)
  return function()
    if vim.fn.exists(":" .. cmd) == 2 then vim.cmd(cmd) else vim.notify("Start gdb first: <leader>dd") end
  end
end

local map = vim.keymap.set
map("n", "<leader>dd", start, { desc = "Debug: start gdb on a program" })
map("n", "<leader>db", gdb("Break"), { desc = "Debug: breakpoint on this line" })
map("n", "<leader>dB", gdb("Clear"), { desc = "Debug: remove breakpoint" })
map("n", "<leader>dr", gdb("Run"), { desc = "Debug: run program" })
map("n", "<leader>dc", gdb("Continue"), { desc = "Debug: continue" })
map("n", "<leader>dn", gdb("Over"), { desc = "Debug: next line" })
map("n", "<leader>di", gdb("Step"), { desc = "Debug: step into" })
map("n", "<leader>do", gdb("Finish"), { desc = "Debug: step out" })
map("n", "<leader>dh", gdb("Evaluate"), { desc = "Debug: value under cursor" })
