return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    { "<leader>cf", function() require("conform").format({ lsp_fallback = true }) end, desc = "Format buffer" },
  },
  opts = {
    formatters_by_ft = {
      cpp = { "clang_format" },
      c = { "clang_format" },
      python = { "ruff_format" },
    },
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
  },
}
