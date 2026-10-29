-- Bytes Beneath's midnight background with VS Code Dark+ token colors.
local c = {
  bg = "#00001C", surface = "#0F0F2A", cursorline = "#0A0A26",
  detail = "#191933", border = "#303049", selection = "#264F78",
  fg = "#D4D4D4", muted = "#85859C", gutter = "#62627A",
  blue = "#569CD6", purple = "#C586C0", teal = "#4EC9B0",
  variable = "#9CDCFE", constant = "#4FC1FF", func = "#DCDCAA",
  string = "#CE9178", number = "#B5CEA8", comment = "#6A9955",
  escape = "#D7BA7D", regexp = "#D16969",
  error = "#F44747", warning = "#D7BA7D", info = "#75BEFF", hint = "#4EC9B0",
  added_bg = "#142A2B", changed_bg = "#102646", removed_bg = "#321529",
  search_bg = "#5A4529", match_bg = "#1A3552",
}

local function mode(accent)
  return {
    a = { fg = c.bg, bg = accent, gui = "bold" },
    b = { fg = c.fg, bg = c.detail },
    c = { fg = c.fg, bg = c.surface },
  }
end

return {
  colors = c,
  lualine = {
    normal = mode(c.blue), insert = mode(c.teal), visual = mode(c.purple),
    replace = mode(c.error), command = mode(c.escape), terminal = mode(c.teal),
    inactive = {
      a = { fg = c.muted, bg = c.surface },
      b = { fg = c.muted, bg = c.surface },
      c = { fg = c.muted, bg = c.surface },
    },
  },
}
