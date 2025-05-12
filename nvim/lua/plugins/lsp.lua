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
    event = { "BufReadPost", "BufNewFile" },
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
    dependencies = { 'rafamadriz/friendly-snippets' },
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
      "saghen/blink.cmp",
    },
    event = {
      "InsertEnter",
    },
  },
  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons',     -- optional
    },
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      require("config.lsp.lspsaga")
    end,
  },
}
