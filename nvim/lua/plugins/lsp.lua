return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("config.lsp")
    end,
    event = { "BufReadPre", "BufNewFile" },
    cmd = {
      "MasonInstall",
      "MasonUninstall",
      "MasonUpdate",
      "Mason",
      "MasonLog",
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "giuxtaposition/blink-cmp-copilot",
    },
    version = 'v0.*',
    opts_extend = { "sources.default" },
    event = {
      "InsertEnter",
    },
    config = function()
      require("config.lsp.blink")
    end,
  },
  {
    "giuxtaposition/blink-cmp-copilot",
    dependencies = {
      "zbirenbaum/copilot.lua",
    },
  },
  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons',     -- optional
    },
    event = {
      "BufRead",
      "BufNewFile",
    },
    config = function()
      require("config.lsp.lspsaga")
    end,
  },
}
