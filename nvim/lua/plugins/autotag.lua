return {
  'windwp/nvim-ts-autotag',
  opts = {
    opts = {
      -- Defaults
      enable_close = true,         -- Auto close tags
      enable_rename = true,        -- Auto rename pairs of tags
      enable_close_on_slash = true -- Auto close on trailing </
    },
  },
  ft = { "typescript", "javascript", "typescriptreact", "javascriptreact", "html" },
}
