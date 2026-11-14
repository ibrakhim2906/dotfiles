-- A floating shell for quick commands, plus a jump to Windows Terminal for
-- longer sessions (gdb, servers). The float keeps its shell alive when hidden.
local M = {}
local buf, win

local function is_open()
  return win ~= nil and vim.api.nvim_win_is_valid(win)
end

local function open()
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.7)
  if not (buf and vim.api.nvim_buf_is_valid(buf)) then buf = vim.api.nvim_create_buf(false, true) end
  win = vim.api.nvim_open_win(buf, true, {
    relative = "editor", style = "minimal", border = "rounded",
    width = width, height = height,
    row = math.floor((vim.o.lines - height) / 2) - 1,
    col = math.floor((vim.o.columns - width) / 2),
    title = " terminal ", title_pos = "center",
  })
  if vim.bo[buf].buftype ~= "terminal" then
    vim.fn.jobstart(vim.o.shell, {
      term = true,
      -- Typing `exit` closes the float; the next toggle starts a fresh shell.
      on_exit = function()
        vim.schedule(function()
          if is_open() then vim.api.nvim_win_close(win, true) end
          if buf and vim.api.nvim_buf_is_valid(buf) then vim.api.nvim_buf_delete(buf, { force = true }) end
          buf, win = nil, nil
        end)
      end,
    })
    vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { buffer = buf, desc = "Terminal normal mode" })
  end
  vim.cmd.startinsert()
end

function M.toggle()
  if not is_open() then
    open()
  elseif vim.api.nvim_get_current_win() ~= win then
    vim.api.nvim_set_current_win(win)
    vim.cmd.startinsert()
  else
    vim.api.nvim_win_hide(win)
    win = nil
  end
end

-- New Windows Terminal tab (in the last-used window) at the project root.
function M.open_windows_terminal()
  local dir = vim.fs.root(0, { ".git", "CMakeLists.txt", "pyproject.toml" })
    or (vim.bo.buftype == "" and vim.fn.expand("%:p:h") ~= "" and vim.fn.expand("%:p:h"))
    or vim.fn.getcwd()
  vim.fn.jobstart({ "wt.exe", "-w", "0", "new-tab", "wsl.exe", "-d", "Ubuntu-24.04", "--cd", dir }, { detach = true })
end

return M
