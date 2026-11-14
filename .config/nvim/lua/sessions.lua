-- One session per project folder: saved when Neovim exits, restored with
-- <leader>s, or automatically when Neovide opens a folder (`nv`).
local M = {}
local dir = vim.fn.stdpath("state") .. "/sessions/"
vim.opt.sessionoptions = { "buffers", "curdir", "folds", "tabpages", "winsize" }

local function session_file()
  return dir .. vim.fn.getcwd():gsub("/", "%%") .. ".vim"
end

local function has_files()
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[b].buflisted and vim.bo[b].buftype == "" and vim.fn.filereadable(vim.api.nvim_buf_get_name(b)) == 1 then
      return true
    end
  end
  return false
end

function M.save()
  if vim.fn.getcwd() == vim.env.HOME or not has_files() then return end
  vim.fn.mkdir(dir, "p")
  vim.cmd("mksession! " .. vim.fn.fnameescape(session_file()))
end

function M.restore(quiet)
  local file = session_file()
  if vim.fn.filereadable(file) == 0 then
    if not quiet then vim.notify("No session for " .. vim.fn.getcwd()) end
    return
  end
  -- A folder view (Oil) can't be replaced by the session, so step off it first.
  local folder_buf = vim.bo.filetype == "oil" and vim.api.nvim_get_current_buf() or nil
  if folder_buf then vim.cmd.enew() end
  vim.cmd("silent! source " .. vim.fn.fnameescape(file))
  if folder_buf and vim.api.nvim_buf_is_valid(folder_buf) and vim.fn.bufwinid(folder_buf) == -1 then
    vim.api.nvim_buf_delete(folder_buf, { force = true })
  end
end

-- Neovide opened on this folder (`nv`, or no arguments) and a session exists.
-- Oil may already have renamed a folder argument to oil:///path/.
local argv0 = vim.fn.argc() == 1
  and (vim.fn.fnamemodify((vim.fn.argv(0):gsub("^oil://", "")), ":p"):gsub("/$", "")) or nil
local auto_restore = vim.g.neovide and (vim.fn.argc() == 0 or argv0 == vim.fn.getcwd())
  and vim.fn.filereadable(session_file()) == 1

local group = vim.api.nvim_create_augroup("ProjectSessions", { clear = true })
vim.api.nvim_create_autocmd("VimLeavePre", { group = group, callback = M.save })
if auto_restore then
  -- Oil draws a folder view asynchronously; restore after it's done, or it takes the window back.
  vim.api.nvim_create_autocmd(argv0 and "User" or "VimEnter", {
    group = group,
    pattern = argv0 and "OilEnter" or "*",
    once = true,
    nested = true,
    callback = function() vim.schedule(function() M.restore(true) end) end,
  })
end

return M
