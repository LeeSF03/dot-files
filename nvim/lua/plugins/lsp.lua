return {
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = 'rafamadriz/friendly-snippets',

    -- use a release tag to download pre-built binaries
    version = 'v0.*',
    opts = {
      keymap = {
          ['<C-s>'] = { 'show', 'show_documentation', 'hide_documentation' },
          ['<C-e>'] = { 'hide' },
          ['<C-y>'] = { 'select_and_accept' },

          ['<C-k>'] = { 'select_prev', 'fallback' },
          ['<C-j>'] = { 'select_next', 'fallback' },

          ['<C-h>'] = { 'scroll_documentation_up', 'fallback' },
          ['<C-l>'] = { 'scroll_documentation_down', 'fallback' },
      },
      documentation = {
        auto_show = true,
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      completion = {
        menu = {
          border = 'rounded',
        },
      },
      -- experimental signature help support
      signature = { enabled = true }
    },
    opts_extend = { "sources.default" }
  },
  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons',     -- optional
    }
  },
}
