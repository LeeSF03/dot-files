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
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    -- use a release tag to download pre-built binaries
    version = 'v0.*',
    opts_extend = { "sources.default" },
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      require("config.lsp.blink")
    end,
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
