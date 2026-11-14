return {
  { "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local langs = { "cpp", "c", "python", "lua", "cmake", "bash", "json", "yaml", "toml", "markdown", "markdown_inline" }
      require("nvim-treesitter").setup()
      require("nvim-treesitter").install(langs)
      -- highlight = { enable = true } is gone; Neovim starts it per buffer now
      vim.api.nvim_create_autocmd("FileType", {
        pattern = langs,
        callback = function() pcall(vim.treesitter.start) end,
      })
    end,
  },
  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim", "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      -- Tell servers what nvim-cmp can show (snippets, argument placeholders, ...).
      vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "basedpyright" },
      })
    end,
  },
  { "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        completion = { keyword_length = 2 },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = {
          { name = "nvim_lsp", max_item_count = 20 },
          { name = "buffer", max_item_count = 5 },
          { name = "path" },
        },
      })
    end,
  },
  { "echasnovski/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      -- Oil uses mini.icons directly; this lets Telescope and others find it too.
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  { "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { defaults = { borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" } } },
  },
  { "lewis6991/gitsigns.nvim", config = true },
  { "stevearc/oil.nvim", config = true },
  { "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = { theme = vim.g.theme == "tokyo" and "tokyonight" or require("bytes_dark").lualine, section_separators = "", component_separators = "", globalstatus = true },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            -- project folder (the window has no title bar), then the file
            { function()
                local cwd = vim.fn.getcwd()
                return vim.fn.nr2char(0xF07B) .. " " .. (cwd == vim.env.HOME and "~" or vim.fn.fnamemodify(cwd, ":t"))
              end,
              color = "Directory", padding = { left = 1, right = 2 } },
            { "filename", padding = { left = 0, right = 1 } },
          },
          lualine_x = { "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },
  { "folke/tokyonight.nvim",
    lazy = true,  -- loads on `colorscheme`
    opts = {
      on_colors = function(c)
        c.comment = "#737DA8"  -- stock #565F89 is only ~2.7:1 on the background; this is ~4.3:1
      end,
    },
  },
  { "christoomey/vim-tmux-navigator" },
}
