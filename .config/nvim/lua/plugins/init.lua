return {
  { "folke/tokyonight.nvim",
    lazy = false, priority = 1000,
    config = function()
      require("tokyonight").setup({ style = "night" })
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },
  { "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "cpp", "c", "python", "lua", "cmake", "bash", "json" },
        highlight = { enable = true },
        indent = { enable = true, disable = { "cpp", "c" } },
      })
    end,
  },
  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
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
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "lewis6991/gitsigns.nvim", config = true },
  { "stevearc/oil.nvim", config = true },
  { "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = { theme = "tokyonight", section_separators = "", component_separators = "", globalstatus = true },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },
  { "christoomey/vim-tmux-navigator" },
}
