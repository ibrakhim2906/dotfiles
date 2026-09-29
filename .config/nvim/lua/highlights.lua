-- Approximation of CLion's default Dark (Darcula, New UI) palette.
local c = {
  bg        = "#1E1F22",
  bg_alt    = "#2B2D30",  -- gutter / statusline
  cursorline= "#26282E",
  fg        = "#BCBEC4",
  comment   = "#7A7E85",
  doc       = "#5F826B",
  keyword   = "#CF8E6D",
  string    = "#6AAB73",
  number    = "#2AACB8",
  func      = "#56A8F5",
  const     = "#C77DBB",
  macro     = "#908B25",
  gutter_fg = "#4B5059",
  gutter_cur= "#A1A3AB",
}

local function apply()
  local hl = function(g, o) vim.api.nvim_set_hl(0, g, o) end

  -- editor chrome
  hl("Normal",        { fg = c.fg, bg = c.bg })
  hl("NormalFloat",   { fg = c.fg, bg = c.bg_alt })
  hl("CursorLine",    { bg = c.cursorline })
  hl("CursorLineNr",  { fg = c.gutter_cur })
  hl("LineNr",        { fg = c.gutter_fg })
  hl("SignColumn",    { bg = c.bg })
  hl("Visual",        { bg = "#214283" })
  hl("Search",        { fg = c.bg, bg = "#32593D" })
  hl("Pmenu",         { fg = c.fg, bg = c.bg_alt })
  hl("PmenuSel",      { bg = "#2E436E" })
  hl("WinSeparator",  { fg = "#393B40" })

  -- syntax
  hl("@comment",               { fg = c.comment, italic = true })
  hl("@comment.documentation", { fg = c.doc, italic = true })
  hl("@string",                { fg = c.string })
  hl("@character",             { fg = c.string })
  hl("@string.escape",         { fg = c.keyword, bold = true })
  hl("@number",                { fg = c.number })
  hl("@number.float",          { fg = c.number })
  hl("@boolean",               { fg = c.keyword })
  hl("@constant",              { fg = c.const })
  hl("@constant.builtin",      { fg = c.keyword })
  hl("@constant.macro",        { fg = c.macro })
  hl("@keyword",               { fg = c.keyword })
  hl("@keyword.conditional",   { fg = c.keyword })
  hl("@keyword.repeat",        { fg = c.keyword })
  hl("@keyword.return",        { fg = c.keyword })
  hl("@keyword.operator",      { fg = c.keyword })
  hl("@keyword.directive",     { fg = c.macro })
  hl("@keyword.import",        { fg = c.macro })
  hl("@function",              { fg = c.func })
  hl("@function.call",         { fg = c.func })
  hl("@function.method",       { fg = c.func })
  hl("@function.method.call",  { fg = c.func })
  hl("@function.builtin",      { fg = c.func })
  hl("@type",                  { fg = c.fg })
  hl("@type.builtin",          { fg = c.keyword })
  hl("@variable",              { fg = c.fg })
  hl("@variable.member",       { fg = c.const })
  hl("@variable.parameter",    { fg = c.fg })
  hl("@property",              { fg = c.const })
  hl("@operator",              { fg = c.fg })
  hl("@punctuation.bracket",   { fg = c.fg })
  hl("@punctuation.delimiter", { fg = c.fg })
end

apply()
vim.api.nvim_create_autocmd("ColorScheme", { callback = apply })
