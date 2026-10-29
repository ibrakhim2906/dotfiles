-- Dark+ syntax on the Bytes Beneath background. No colorscheme plugin needed.
local c = require("bytes_dark").colors

local function apply()
  local function set(groups, attrs)
    if type(groups) == "string" then groups = { groups } end
    for _, group in ipairs(groups) do vim.api.nvim_set_hl(0, group, attrs) end
  end
  local function link(group, target) set(group, { link = target }) end

  vim.g.colors_name = "bytes-dark"

  -- Editor and floating windows.
  set({ "Normal", "NormalNC" }, { fg = c.fg, bg = c.bg })
  set("NormalFloat", { fg = c.fg, bg = c.surface })
  set("FloatBorder", { fg = c.border, bg = c.surface })
  set({ "FloatTitle", "FloatFooter" }, { fg = c.variable, bg = c.surface, bold = true })
  set({ "Cursor", "lCursor", "TermCursor" }, { fg = c.bg, bg = c.fg })
  set("CursorIM", { fg = c.bg, bg = c.teal })
  set({ "CursorLine", "CursorColumn" }, { bg = c.cursorline })
  set("ColorColumn", { bg = c.detail })
  set({ "SignColumn", "FoldColumn" }, { fg = c.gutter, bg = c.bg })
  set({ "LineNr", "LineNrAbove", "LineNrBelow" }, { fg = c.gutter })
  set("CursorLineNr", { fg = c.fg, bold = true })
  set({ "CursorLineSign", "CursorLineFold" }, { bg = c.cursorline })
  set({ "WinSeparator", "VertSplit" }, { fg = c.border, bg = c.bg })
  set("EndOfBuffer", { fg = c.bg })
  set({ "NonText", "Whitespace", "SpecialKey" }, { fg = c.border })
  set("Folded", { fg = c.muted, bg = c.surface })
  set({ "Visual", "VisualNOS" }, { bg = c.selection })
  set("Search", { fg = c.fg, bg = c.search_bg })
  set({ "IncSearch", "CurSearch" }, { fg = c.bg, bg = c.escape, bold = true })
  set("Substitute", { fg = c.bg, bg = c.string, bold = true })
  set("MatchParen", { fg = c.fg, bg = c.match_bg, bold = true })
  set("StatusLine", { fg = c.fg, bg = c.surface })
  set("StatusLineNC", { fg = c.muted, bg = c.surface })
  set("WinBar", { fg = c.fg, bg = c.bg })
  set("WinBarNC", { fg = c.muted, bg = c.bg })
  set({ "TabLine", "TabLineFill" }, { fg = c.muted, bg = c.surface })
  set("TabLineSel", { fg = c.variable, bg = c.bg, bold = true })
  set("Title", { fg = c.blue, bold = true })
  set({ "Directory", "Question", "MoreMsg" }, { fg = c.teal })
  set("ModeMsg", { fg = c.variable, bold = true })
  set("MsgArea", { fg = c.fg, bg = c.bg })
  set("MsgSeparator", { fg = c.border, bg = c.surface })
  set("ErrorMsg", { fg = c.error })
  set("WarningMsg", { fg = c.warning })
  set("QuickFixLine", { bg = c.selection })
  set("Conceal", { fg = c.muted })

  -- Completion menus, including nvim-cmp.
  set("Pmenu", { fg = c.fg, bg = c.surface })
  set("PmenuSel", { fg = c.fg, bg = c.selection })
  set({ "PmenuKind", "PmenuExtra" }, { fg = c.muted, bg = c.surface })
  set({ "PmenuKindSel", "PmenuExtraSel" }, { fg = c.variable, bg = c.selection })
  set("PmenuSbar", { bg = c.detail })
  set("PmenuThumb", { bg = c.gutter })
  set({ "PmenuMatch", "CmpItemAbbrMatch", "CmpItemAbbrMatchFuzzy" }, { fg = c.constant, bold = true })
  set("PmenuMatchSel", { fg = c.constant, bg = c.selection, bold = true })
  set("CmpItemAbbr", { fg = c.fg })
  set("CmpItemAbbrDeprecated", { fg = c.muted, strikethrough = true })
  set("CmpItemMenu", { fg = c.muted })
  set({ "CmpItemKind", "CmpItemKindText", "CmpItemKindVariable", "CmpItemKindField", "CmpItemKindProperty" }, { fg = c.variable })
  set({ "CmpItemKindFunction", "CmpItemKindMethod", "CmpItemKindConstructor" }, { fg = c.func })
  set({ "CmpItemKindClass", "CmpItemKindInterface", "CmpItemKindStruct", "CmpItemKindTypeParameter", "CmpItemKindModule" }, { fg = c.teal })
  set({ "CmpItemKindKeyword", "CmpItemKindOperator", "CmpItemKindSnippet" }, { fg = c.blue })
  set({ "CmpItemKindConstant", "CmpItemKindEnum", "CmpItemKindEnumMember" }, { fg = c.constant })
  set({ "CmpItemKindValue", "CmpItemKindColor", "CmpItemKindUnit" }, { fg = c.number })
  set({ "CmpItemKindFile", "CmpItemKindFolder", "CmpItemKindReference", "CmpItemKindEvent" }, { fg = c.string })
  set("ComplMatchIns", { fg = c.muted })

  -- Vim syntax remains useful for languages without a Tree-sitter parser.
  set("Comment", { fg = c.comment })
  set("Constant", { fg = c.constant })
  set({ "String", "Character" }, { fg = c.string })
  set({ "Number", "Float" }, { fg = c.number })
  set("Boolean", { fg = c.blue })
  set("Identifier", { fg = c.variable })
  set("Function", { fg = c.func })
  set({ "Statement", "Conditional", "Repeat", "Exception" }, { fg = c.purple })
  set("Label", { fg = c.fg })
  set("Operator", { fg = c.fg })
  set({ "Keyword", "StorageClass", "Typedef" }, { fg = c.blue })
  set({ "PreProc", "Include", "Define", "Macro", "PreCondit" }, { fg = c.blue })
  set({ "Type", "Structure" }, { fg = c.teal })
  set({ "Special", "SpecialChar" }, { fg = c.escape })
  set("Tag", { fg = c.blue })
  set("Delimiter", { fg = c.fg })
  set("SpecialComment", { fg = c.comment })
  set("Debug", { fg = c.purple })
  set("Underlined", { fg = c.variable, underline = true })
  set("Ignore", { fg = c.muted })
  set("Error", { fg = c.error })
  set("Todo", { fg = c.escape, bold = true })

  -- Tree-sitter captures. Derived captures inherit these base definitions.
  local captures = {
    ["@comment"] = "Comment", ["@comment.documentation"] = "Comment",
    ["@comment.todo"] = "Todo", ["@comment.note"] = "DiagnosticInfo",
    ["@comment.warning"] = "DiagnosticWarn", ["@comment.error"] = "DiagnosticError",
    ["@string"] = "String", ["@string.documentation"] = "String",
    ["@string.escape"] = "SpecialChar", ["@string.special"] = "SpecialChar",
    ["@character"] = "Character", ["@character.special"] = "SpecialChar",
    ["@number"] = "Number", ["@number.float"] = "Float", ["@boolean"] = "Boolean",
    ["@constant"] = "Constant", ["@constant.builtin"] = "Boolean", ["@constant.macro"] = "Constant",
    ["@variable"] = "Identifier", ["@variable.parameter"] = "Identifier",
    ["@variable.member"] = "Identifier", ["@variable.builtin"] = "Keyword", ["@property"] = "Identifier",
    ["@function"] = "Function", ["@function.call"] = "Function", ["@function.builtin"] = "Function",
    ["@function.method"] = "Function", ["@function.method.call"] = "Function", ["@function.macro"] = "Function",
    ["@constructor"] = "Type", ["@type"] = "Type", ["@type.builtin"] = "Keyword", ["@type.definition"] = "Type",
    ["@module"] = "Type", ["@module.builtin"] = "Type", ["@attribute"] = "Type", ["@attribute.builtin"] = "Type",
    ["@keyword"] = "Keyword", ["@keyword.function"] = "Keyword", ["@keyword.type"] = "Keyword",
    ["@keyword.modifier"] = "Keyword", ["@keyword.operator"] = "Keyword",
    ["@keyword.conditional"] = "Conditional", ["@keyword.conditional.ternary"] = "Conditional",
    ["@keyword.repeat"] = "Repeat", ["@keyword.return"] = "Statement", ["@keyword.exception"] = "Exception",
    ["@keyword.import"] = "Statement", ["@keyword.coroutine"] = "Statement",
    ["@keyword.directive"] = "PreProc", ["@keyword.directive.define"] = "Define",
    ["@label"] = "Label", ["@operator"] = "Operator",
    ["@punctuation.delimiter"] = "Delimiter", ["@punctuation.bracket"] = "Delimiter",
    ["@punctuation.special"] = "Keyword",
    ["@tag"] = "Tag", ["@tag.builtin"] = "Tag", ["@tag.attribute"] = "Identifier",
    ["@markup.heading"] = "Title", ["@markup.raw"] = "String",
    ["@markup.link"] = "Underlined", ["@markup.link.url"] = "Underlined",
    ["@markup.link.label"] = "Identifier", ["@markup.list"] = "Keyword",
    ["@markup.quote"] = "Comment", ["@markup.math"] = "Special",
    ["@diff.plus"] = "Added", ["@diff.minus"] = "Removed", ["@diff.delta"] = "Changed",
    -- Compatibility with older parser queries.
    ["@text"] = "Normal", ["@text.literal"] = "@markup.raw", ["@text.uri"] = "@markup.link.url",
    ["@text.title"] = "@markup.heading", ["@text.strong"] = "@markup.strong", ["@text.emphasis"] = "@markup.italic",
    ["@text.underline"] = "@markup.underline", ["@text.strike"] = "@markup.strikethrough",
    ["@namespace"] = "@module", ["@parameter"] = "@variable.parameter", ["@field"] = "@variable.member",
    ["@method"] = "@function.method", ["@method.call"] = "@function.method.call",
    ["@conditional"] = "@keyword.conditional", ["@repeat"] = "@keyword.repeat",
    ["@exception"] = "@keyword.exception", ["@include"] = "@keyword.import",
    ["@preproc"] = "@keyword.directive", ["@define"] = "@keyword.directive.define",
    ["@float"] = "@number.float", ["@symbol"] = "Constant", ["@string.regex"] = "@string.regexp",
  }
  for group, target in pairs(captures) do link(group, target) end
  set("@string.regexp", { fg = c.regexp })
  set("@tag.delimiter", { fg = c.muted })
  set("@markup.strong", { fg = c.blue, bold = true })
  set("@markup.italic", { fg = c.purple, italic = true })
  set("@markup.strikethrough", { strikethrough = true })
  set("@markup.underline", { underline = true })
  set({ "@markup.list.checked", "@markup.list.unchecked" }, { fg = c.teal })

  -- LSP tokens use the same palette; modifiers do not recolor an entire token.
  local semantic = {
    namespace = "@module", type = "@type", class = "@type", enum = "@type",
    interface = "@type", struct = "@type", typeParameter = "@type",
    parameter = "@variable.parameter", variable = "@variable", property = "@variable.member",
    enumMember = "@constant", event = "@variable.member", function_ = "@function",
    method = "@function.method", macro = "@constant.macro", keyword = "@keyword",
    modifier = "@keyword.modifier", comment = "@comment", string = "@string",
    number = "@number", regexp = "@string.regexp", operator = "@operator",
    decorator = "@attribute", boolean = "@boolean", label = "@label",
    selfKeyword = "@variable.builtin", selfParameter = "@variable.builtin",
    builtinType = "@type.builtin", lifetime = "@label",
  }
  for token, target in pairs(semantic) do
    if token == "function_" then token = "function" end
    link("@lsp.type." .. token, target)
  end
  for _, modifier in ipairs({ "declaration", "definition", "readonly", "static", "abstract", "async", "modification", "documentation", "defaultLibrary" }) do
    set("@lsp.mod." .. modifier, {})
  end
  set("@lsp.mod.deprecated", { strikethrough = true })
  for _, token in ipairs({ "variable", "property" }) do
    link("@lsp.typemod." .. token .. ".readonly", "@constant")
    link("@lsp.typemod." .. token .. ".defaultLibrary", "@variable")
  end
  link("@lsp.typemod.type.defaultLibrary", "@type.builtin")
  link("@lsp.typemod.function.defaultLibrary", "@function.builtin")

  -- Diagnostics keep floats and virtual text consistent with their surfaces.
  for _, item in ipairs({ { "Error", c.error }, { "Warn", c.warning }, { "Info", c.info }, { "Hint", c.hint }, { "Ok", c.teal } }) do
    local severity, color = item[1], item[2]
    set({ "Diagnostic" .. severity, "DiagnosticSign" .. severity }, { fg = color })
    set({ "DiagnosticVirtualText" .. severity, "DiagnosticVirtualLines" .. severity }, { fg = color })
    set("DiagnosticFloating" .. severity, { fg = color, bg = c.surface })
    set("DiagnosticUnderline" .. severity, { sp = color, undercurl = true })
  end
  set("DiagnosticUnnecessary", { fg = c.muted })
  set("DiagnosticDeprecated", { strikethrough = true })
  set("LspReferenceText", { bg = c.match_bg })
  link("LspReferenceRead", "LspReferenceText")
  link("LspReferenceWrite", "LspReferenceText")
  link("LspReferenceTarget", "LspReferenceText")
  set({ "LspInlayHint", "LspCodeLens", "LspCodeLensSeparator" }, { fg = c.muted })
  set("LspSignatureActiveParameter", { fg = c.variable, bold = true, underline = true })
  for group, color in pairs({ SpellBad = c.error, SpellCap = c.warning, SpellLocal = c.info, SpellRare = c.hint }) do
    set(group, { sp = color, undercurl = true })
  end

  -- Diff and Git signs.
  set("DiffAdd", { bg = c.added_bg })
  set("DiffChange", { bg = c.changed_bg })
  set("DiffDelete", { fg = c.regexp, bg = c.removed_bg })
  set("DiffText", { bg = c.selection, bold = true })
  set({ "Added", "GitSignsAdd", "GitSignsAddNr" }, { fg = c.number })
  set({ "Changed", "GitSignsChange", "GitSignsChangeNr" }, { fg = c.blue })
  set({ "Removed", "GitSignsDelete", "GitSignsDeleteNr", "GitSignsTopdelete" }, { fg = c.regexp })
  set("GitSignsChangedelete", { fg = c.purple })
  set("GitSignsUntracked", { fg = c.teal })
  set("GitSignsCurrentLineBlame", { fg = c.muted })
  link("GitSignsAddLn", "DiffAdd")
  link("GitSignsChangeLn", "DiffChange")
  link("GitSignsDeleteLn", "DiffDelete")

  -- Telescope and Oil share the same restrained window chrome.
  link("TelescopeNormal", "NormalFloat")
  link("TelescopeBorder", "FloatBorder")
  set("TelescopeTitle", { fg = c.variable, bg = c.surface, bold = true })
  set("TelescopeSelection", { bg = c.selection })
  set("TelescopeSelectionCaret", { fg = c.teal, bg = c.selection })
  set("TelescopeMatching", { fg = c.constant, bold = true })
  set("TelescopePromptPrefix", { fg = c.blue, bg = c.surface })
  set("TelescopeMultiSelection", { fg = c.teal })
  set("TelescopePreviewLine", { bg = c.selection })
  link("OilDir", "Directory")
  link("OilDirIcon", "Directory")
  set("OilFile", { fg = c.fg })
  set({ "OilLink", "OilLinkTarget" }, { fg = c.variable })
  set({ "OilLinkTargetDir", "OilSocket" }, { fg = c.teal })
  set({ "OilOrphanLink", "OilOrphanLinkTarget" }, { fg = c.error })
  set("OilHidden", { fg = c.muted })
  set({ "OilCreate", "OilCopy" }, { fg = c.number })
  set("OilMove", { fg = c.blue })
  set("OilDelete", { fg = c.error })
  set({ "OilChange", "OilRestore", "OilPurge" }, { fg = c.warning })
  set({ "OilTrashSourcePath", "OilMtime", "OilSize" }, { fg = c.muted })
  set({ "OilPermissionRead", "OilPermissionWrite", "OilPermissionExecute" }, { fg = c.escape })

  -- Embedded terminals use the same 16 ANSI colors as the outer terminal.
  local ansi = {
    c.surface, c.error, c.comment, c.func, c.blue, c.purple, c.teal, c.fg,
    "#6D6D7D", "#F14C4C", c.number, c.escape, c.variable, "#D7A8D1", c.constant, "#FFFFFF",
  }
  for index, color in ipairs(ansi) do vim.g["terminal_color_" .. (index - 1)] = color end
end

vim.opt.background = "dark"
apply()
-- clear=true makes re-sourcing safe; applying highlights does not emit ColorScheme.
local group = vim.api.nvim_create_augroup("BytesDarkHighlights", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", { group = group, callback = apply })

return { apply = apply }
